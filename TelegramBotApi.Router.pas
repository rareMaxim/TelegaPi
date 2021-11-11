unit TelegramBotApi.Router;

interface

uses
  System.Rtti,
  System.Generics.Collections,
  System.SysUtils,
  TelegramBotApi.Types;

type
  // Управление текущим состоянием пользователя
  TtgRouteUserStateManagerAbstract = class abstract
  private
    FOnGetUserStateCallback: TFunc<Int64, string>;
    FOnSetUserStateCallback: TProc<Int64, string>;
    FDefaultName: string;
  protected
    function DoGetUserState(const AUserID: Int64): string; virtual;
    procedure DoSetUserState(const AIndex: Int64; const Value: string); virtual;
  public
    constructor Create; virtual;
    // имя "нулевого" маршрута
    property DefaultName: string read FDefaultName write FDefaultName;
    // Класс запрашивает из сторонего хранилища состояние пользователя по ИД пользователя
    property OnGetUserStateCallback: TFunc<Int64, string> read FOnGetUserStateCallback write FOnGetUserStateCallback;
    // класс сообщает что для пользователя установлено новое состояние
    property OnSetUserStateCallback: TProc<Int64, string> read FOnSetUserStateCallback write FOnSetUserStateCallback;
    // Чтение/Запись состояний
    property UserState[const AIndex: Int64]: string read DoGetUserState write DoSetUserState;
  end;

  // Хранение состояний в ОЗУ. Для начала неплохой вариант.
  // Не забывать сохранять/загружать актуальные состояния в постоянную память (на диск)
  // Потом написать класс для хранения состояний в БД что бы не переживать за аварийное завершение бота
  TtgRouteUserStateManagerRAM = class(TtgRouteUserStateManagerAbstract)
  private
    FRouteUserStates: TDictionary<Int64, string>;
  protected
    function DoGetUserState(const AUserID: Int64): string; override;
    procedure DoSetUserState(const AIndex: Int64; const Value: string); override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  // Точка маршрута
  TtgRoute = record
  private
    FName: string;
    FOnStartCallback: TProc<Int64>;
    FOnMessageCallback: TProc<TtgMessage>;
    FTagString: string;
    FTagInteger: Integer;
    FTagValue: TValue;
    FOnStopCallback: TProc<Int64>;
    // protected
    procedure RouteStart(const AUserID: Int64);
    procedure RouteStop(const AUserID: Int64);
    procedure SendMessage(AMessage: TtgMessage);
  public
    class function Create(const AName: string): TtgRoute; static;
    class function Empty: TtgRoute; static;
    function IsEmpty: Boolean;
    property TagString: string read FTagString write FTagString;
    property TagInteger: Integer read FTagInteger write FTagInteger;
    // Имя точки.
    // Возможно, по имени точки будет происходить переход на нужныый маршрут
    property Name: string read FName write FName;
    // Отправляем побуждение к действию
    property OnStartCallback: TProc<Int64> read FOnStartCallback write FOnStartCallback;
    // Обрабатывапем ответ от пользователя
    property OnMessageCallback: TProc<TtgMessage> read FOnMessageCallback write FOnMessageCallback;
    // вызывается при перемещении на следующую точку маршрута. Возможно, лишний колбек.
    property OnStopCallback: TProc<Int64> read FOnStopCallback write FOnStopCallback;
  end;

  // Управление маршрутами
  TtgRouter = class
  private
    FRouteUserState: TtgRouteUserStateManagerAbstract;
    FRoutes: TDictionary<string, TtgRoute>;
    FOnRouteNotFound: TProc<Int64, string>;
    FCurrentRoute: TtgRoute;
    fOnRouteMove: TProc<Int64, TtgRoute, TtgRoute>;
  protected
    procedure DoNotifyRouteNotFound(const AId: Int64; const ARouteName: string);
    procedure DoCheckRouteIsExist(const AId: Int64; const ARouteName: string);
    procedure DoOnRouteMove(const AUserID: Int64; const AFrom, ATo: TtgRoute);
  public
    constructor Create(ARouteUserState: TtgRouteUserStateManagerAbstract);
    destructor Destroy; override;
    procedure MoveTo(const AUserID: Int64; const ARoute: TtgRoute);
    // регистрируем точку
    procedure RegisterRoute(ARoute: TtgRoute);
    // регистрируем точки
    procedure RegisterRoutes(ARoutes: TArray<TtgRoute>);
    // Уведомляем маршрутизатор о новом сообщении
    procedure SendMessage(AMessage: TtgMessage);
    // property Routes: TDictionary<string, TtgRoute> read FRoutes write FRoutes;
    // Доступ к состояниям пользователей
    property RouteUserState: TtgRouteUserStateManagerAbstract read FRouteUserState write FRouteUserState;
    // Колбек перехода на несуществующий маршрут
    property OnRouteNotFound: TProc<Int64, string> read FOnRouteNotFound write FOnRouteNotFound;
    // при перемещении точки  UserID, From, To
    property OnRouteMove: TProc<Int64, TtgRoute, TtgRoute> read fOnRouteMove write fOnRouteMove;
  end;

implementation

{ TtgRouteUserStateManagerAbstract }

constructor TtgRouteUserStateManagerAbstract.Create;
begin
  FDefaultName := '/start';
end;

function TtgRouteUserStateManagerAbstract.DoGetUserState(const AUserID: Int64): string;
begin
  if Assigned(FOnGetUserStateCallback) then
    Result := FOnGetUserStateCallback(AUserID);
  // if Result.IsEmpty then
  // Result := FDefaultName;
end;

procedure TtgRouteUserStateManagerAbstract.DoSetUserState(const AIndex: Int64; const Value: string);
begin
  if Assigned(OnSetUserStateCallback) then
    OnSetUserStateCallback(AIndex, Value);
end;

{ TtgRouteUserStateManagerRAM }

constructor TtgRouteUserStateManagerRAM.Create;
begin
  inherited Create();
  FRouteUserStates := TDictionary<Int64, string>.Create;
end;

destructor TtgRouteUserStateManagerRAM.Destroy;
begin
  FRouteUserStates.Free;
  inherited Destroy;
end;

function TtgRouteUserStateManagerRAM.DoGetUserState(const AUserID: Int64): string;
begin
  // inherited DoGetUserState(AUserID);
  if not FRouteUserStates.TryGetValue(AUserID, Result) then
    Result := FDefaultName;

end;

procedure TtgRouteUserStateManagerRAM.DoSetUserState(const AIndex: Int64; const Value: string);
begin
  inherited DoSetUserState(AIndex, Value);
  FRouteUserStates.AddOrSetValue(AIndex, Value);
end;

{ TtgRoute }

class function TtgRoute.Create(const AName: string): TtgRoute;
begin
  Result.Name := AName;
end;

class function TtgRoute.Empty: TtgRoute;
begin
  Result := TtgRoute.Create(string.Empty);
end;

function TtgRoute.IsEmpty: Boolean;
begin
  Result := FName.IsEmpty;
end;

procedure TtgRoute.RouteStart(const AUserID: Int64);
begin
  if Assigned(OnStartCallback) then
    OnStartCallback(AUserID);
end;

procedure TtgRoute.RouteStop(const AUserID: Int64);
begin
  if Assigned(OnStopCallback) then
    OnStopCallback(AUserID);
end;

procedure TtgRoute.SendMessage(AMessage: TtgMessage);
begin
  if Assigned(OnMessageCallback) then
    OnMessageCallback(AMessage);
end;

{ TtgRouteManager }

constructor TtgRouter.Create(ARouteUserState: TtgRouteUserStateManagerAbstract);
begin
  FRoutes := TDictionary<string, TtgRoute>.Create;
  FRouteUserState := ARouteUserState;
  FCurrentRoute := TtgRoute.Empty;
end;

destructor TtgRouter.Destroy;
begin
  FRoutes.Free;
  inherited;
end;

procedure TtgRouter.DoCheckRouteIsExist(const AId: Int64; const ARouteName: string);
begin
  if not FRoutes.ContainsKey(ARouteName) then
    DoNotifyRouteNotFound(AId, ARouteName);
end;

procedure TtgRouter.DoNotifyRouteNotFound(const AId: Int64; const ARouteName: string);
begin
  if Assigned(FOnRouteNotFound) then
    FOnRouteNotFound(AId, ARouteName)
  else
    raise Exception.CreateFmt('Route "%s" for UserID "%d" not found', [ARouteName, AId]);
end;

procedure TtgRouter.DoOnRouteMove(const AUserID: Int64; const AFrom, ATo: TtgRoute);
begin
  if Assigned(OnRouteMove) then
    OnRouteMove(AUserID, AFrom, ATo);
end;

procedure TtgRouter.MoveTo(const AUserID: Int64; const ARoute: TtgRoute);
var
  LCurrentRoute: TtgRoute;
begin
  if FRouteUserState.UserState[AUserID] <> ARoute.Name then
  begin
    if FRoutes.TryGetValue(FRouteUserState.UserState[AUserID], LCurrentRoute) then
      LCurrentRoute.RouteStop(AUserID);
  end;
  FRouteUserState.UserState[AUserID] := ARoute.Name;
  ARoute.RouteStart(AUserID);
  DoOnRouteMove(AUserID, LCurrentRoute, ARoute);
end;

procedure TtgRouter.RegisterRoute(ARoute: TtgRoute);
begin
  FRoutes.AddOrSetValue(ARoute.Name, ARoute);
end;

procedure TtgRouter.RegisterRoutes(ARoutes: TArray<TtgRoute>);
var
  I: Integer;
begin
  for I := Low(ARoutes) to High(ARoutes) do
    RegisterRoute(ARoutes[I]);
end;

procedure TtgRouter.SendMessage(AMessage: TtgMessage);
var
  LRoute: TtgRoute;
  lCurrentUserID: Int64;
  LCurrentState: string;
begin
  lCurrentUserID := AMessage.From.ID;
  LCurrentState := FRouteUserState.UserState[lCurrentUserID];
  DoCheckRouteIsExist(lCurrentUserID, LCurrentState);
  if FRoutes.TryGetValue(LCurrentState, LRoute) then
  begin
    // if LRoute.Name <> FCurrentRoute.Name then
    // begin
    // FCurrentRoute := LRoute;
    // FCurrentRoute.RouteStart(AMessage)
    // end
    // else if LRoute.Name = FCurrentRoute.Name then
    LRoute.SendMessage(AMessage)
    // else
    // raise Exception.Create('TtgRouteManager.SendMessage');
  end;

end;

end.
