unit TelegramBotApi.Tools.Router;

interface

uses
  System.Rtti,
  System.Generics.Collections,
  System.SysUtils,
  System.Json,
  TelegramBotApi.Types,
  TelegramBotApi.Client,
  TelegramBotApi.Tools.UserDataStorage.Json,
  TelegramBotApi.Tools.UserDataStorage.Abstract;

type
  // Точка маршрута
  TtgRoute = record
  private
    FName: string;
    FAutorunTriggers: TArray<string>;
    FOnStartCallback: TProc<Int64, TtgMessage>;
    FOnMessageCallback: TProc<TtgMessage>;
    FTagString: string;
    FTagInteger: Integer;
    FTagValue: TValue;
    FOnStopCallback: TProc<Int64>;
    FBot: TTelegramBotApi;
    FMessage: TtgMessage;
    FOnCallbackQuery: TProc<TtgCallbackQuery>;
    // protected
    procedure RouteStart(const AUserID: Int64; AMessage: TtgMessage);
    procedure RouteStop(const AUserID: Int64);
    procedure SendMessage(AMessage: TtgMessage);
    procedure SendCallbackQuery(AQuery: TtgCallbackQuery);
  public
    class function Create(const AName: string; AAutorunTriggers: TArray<string> = []): TtgRoute; static;
    class function Empty: TtgRoute; static;
    property Message: TtgMessage read FMessage write FMessage;
    function IsEmpty: Boolean;
    property TagString: string read FTagString write FTagString;
    property TagInteger: Integer read FTagInteger write FTagInteger;
    property TagValue: TValue read FTagValue write FTagValue;
    // Имя точки.
    // Возможно, по имени точки будет происходить переход на нужныый маршрут
    property Name: string read FName write FName;
    property AutorunTriggers: TArray<string> read FAutorunTriggers write FAutorunTriggers;
    // Отправляем побуждение к действию
    property OnStartCallback: TProc<Int64, TtgMessage> read FOnStartCallback write FOnStartCallback;
    // Обрабатывапем ответ от пользователя
    property OnMessageCallback: TProc<TtgMessage> read FOnMessageCallback write FOnMessageCallback;
    property OnCallbackQuery: TProc<TtgCallbackQuery> read FOnCallbackQuery write FOnCallbackQuery;
    // вызывается при перемещении на следующую точку маршрута. Возможно, лишний колбек.
    property OnStopCallback: TProc<Int64> read FOnStopCallback write FOnStopCallback;
    property Bot: TTelegramBotApi read FBot write FBot;
  end;

  // Управление маршрутами
  TtgRouter = class
  private const
    ROUTE_NAME = 'route_name';
  private
    FRouteUserState: TtgUserDataStorageAbstract;
    FRoutes: TDictionary<string, TtgRoute>;
    FTriggerToRouteMap: TDictionary<string, string>;
    FOnRouteNotFound: TProc<Int64, string>;
    FCurrentRoute: TtgRoute;
    fOnRouteMove: TProc<Int64, TtgRoute, TtgRoute>;
    FBot: TTelegramBotApi;
  protected
    procedure DoNotifyRouteNotFound(const AId: Int64; const ARouteName: string);
    procedure DoCheckRouteIsExist(const AId: Int64; const ARouteName: string);
    procedure DoOnRouteMove(const AUserID: Int64; const AFrom, ATo: TtgRoute);
    function DoCheckTrigger(const AUserID: Int64; AMsg: TtgMessage; var ARouteName: string): Boolean;
  public
    constructor Create(ARouteUserState: TtgUserDataStorageAbstract; ABot: TTelegramBotApi);
    destructor Destroy; override;
    procedure MoveTo(const AUserID: Int64; const ARoute: TtgRoute; AMessage: TtgMessage); overload;
    procedure MoveTo(const AUserID: Int64; const ARouteName: string; AMessage: TtgMessage); overload;
    // регистрируем точку
    procedure RegisterRoute(ARoute: TtgRoute);
    // регистрируем точки
    procedure RegisterRoutes(ARoutes: TArray<TtgRoute>);
    // Уведомляем маршрутизатор о новом сообщении
    procedure SendMessage(AMessage: TtgMessage);
    procedure SendCallbackQuery(AQuery: TtgCallbackQuery);

    // property Routes: TDictionary<string, TtgRoute> read FRoutes write FRoutes;
    // Доступ к состояниям пользователей
    property RouteUserState: TtgUserDataStorageAbstract read FRouteUserState write FRouteUserState;
    // Колбек перехода на несуществующий маршрут
    property OnRouteNotFound: TProc<Int64, string> read FOnRouteNotFound write FOnRouteNotFound;
    // при перемещении точки  UserID, From, To
    property OnRouteMove: TProc<Int64, TtgRoute, TtgRoute> read fOnRouteMove write fOnRouteMove;
    property Bot: TTelegramBotApi read FBot;
  end;

implementation

uses
  System.IOUtils;

{ TtgRoute }

class function TtgRoute.Create(const AName: string; AAutorunTriggers: TArray<string> = []): TtgRoute;
begin
  Result.Name := AName;
  Result.AutorunTriggers := AAutorunTriggers;
end;

class function TtgRoute.Empty: TtgRoute;
begin
  Result := TtgRoute.Create(string.Empty);
end;

function TtgRoute.IsEmpty: Boolean;
begin
  Result := FName.IsEmpty;
end;

procedure TtgRoute.RouteStart(const AUserID: Int64; AMessage: TtgMessage);
begin
  if Assigned(OnStartCallback) then
    OnStartCallback(AUserID, AMessage);
end;

procedure TtgRoute.RouteStop(const AUserID: Int64);
begin
  if Assigned(OnStopCallback) then
    OnStopCallback(AUserID);
end;

procedure TtgRoute.SendCallbackQuery(AQuery: TtgCallbackQuery);
begin
  if Assigned(OnCallbackQuery) then
    OnCallbackQuery(AQuery);
end;

procedure TtgRoute.SendMessage(AMessage: TtgMessage);
begin
  if Assigned(OnMessageCallback) then
    OnMessageCallback(AMessage);
end;

{ TtgRouteManager }

constructor TtgRouter.Create(ARouteUserState: TtgUserDataStorageAbstract; ABot: TTelegramBotApi);
begin
  FRoutes := TDictionary<string, TtgRoute>.Create;
  FTriggerToRouteMap := TDictionary<string, string>.Create;
  FRouteUserState := ARouteUserState;
  FCurrentRoute := TtgRoute.Empty;
end;

destructor TtgRouter.Destroy;
begin
  FRoutes.Free;
  FTriggerToRouteMap.Free;
  inherited;
end;

procedure TtgRouter.DoCheckRouteIsExist(const AId: Int64; const ARouteName: string);
begin
  if not FRoutes.ContainsKey(ARouteName) then
    DoNotifyRouteNotFound(AId, ARouteName);
end;

function TtgRouter.DoCheckTrigger(const AUserID: Int64; AMsg: TtgMessage; var ARouteName: string): Boolean;
var
  lRoute: TtgRoute;
begin
  Result := FRoutes.TryGetValue(AMsg.Text, lRoute);
  if Result then
  begin
    ARouteName := lRoute.Name;
    Exit;
  end;
  Result := FTriggerToRouteMap.TryGetValue(AMsg.Text, ARouteName);
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

procedure TtgRouter.MoveTo(const AUserID: Int64; const ARouteName: string; AMessage: TtgMessage);
var
  lRoute: TtgRoute;
begin
  if FRoutes.TryGetValue(ARouteName, lRoute) then
    MoveTo(AUserID, lRoute, AMessage)
  else
    raise EArgumentNilException.CreateFmt('Route [%s] not found', [ARouteName]);
end;

procedure TtgRouter.MoveTo(const AUserID: Int64; const ARoute: TtgRoute; AMessage: TtgMessage);
var
  LCurrentRoute: TtgRoute;
begin
  if FRouteUserState[AUserID, ROUTE_NAME] <> ARoute.Name then
  begin
    if FRoutes.TryGetValue(FRouteUserState[AUserID, ROUTE_NAME], LCurrentRoute) then
      LCurrentRoute.RouteStop(AUserID);
  end;
  FRouteUserState[AUserID, ROUTE_NAME] := ARoute.Name;
  ARoute.RouteStart(AUserID, AMessage);
  DoOnRouteMove(AUserID, LCurrentRoute, ARoute);
end;

procedure TtgRouter.RegisterRoute(ARoute: TtgRoute);
var
  LTrigger: string;
begin
  if ARoute.Bot = nil then
    ARoute.Bot := FBot;
  FRoutes.AddOrSetValue(ARoute.Name, ARoute);
  for LTrigger in ARoute.AutorunTriggers do
    FTriggerToRouteMap.AddOrSetValue(LTrigger, ARoute.Name);
end;

procedure TtgRouter.RegisterRoutes(ARoutes: TArray<TtgRoute>);
var
  I: Integer;
begin
  for I := Low(ARoutes) to High(ARoutes) do
    RegisterRoute(ARoutes[I]);
end;

procedure TtgRouter.SendCallbackQuery(AQuery: TtgCallbackQuery);
var
  lRoute: TtgRoute;
  lCurrentUserID: Int64;
  LCurrentState: string;
begin
  lCurrentUserID := AQuery.From.ID;
  LCurrentState := FRouteUserState[lCurrentUserID, ROUTE_NAME];
  DoCheckRouteIsExist(lCurrentUserID, LCurrentState);
  if FRoutes.TryGetValue(LCurrentState, lRoute) then
  begin
    lRoute.SendCallbackQuery(AQuery)
  end;
end;

procedure TtgRouter.SendMessage(AMessage: TtgMessage);
var
  lRoute: TtgRoute;
  lRouteName: string;
  lCurrentUserID: Int64;
  LCurrentState: string;
begin
  lCurrentUserID := AMessage.From.ID;
  if DoCheckTrigger(lCurrentUserID, AMessage, lRouteName) then
  begin
    MoveTo(lCurrentUserID, lRouteName, AMessage);
    Exit;
  end;
  LCurrentState := FRouteUserState[lCurrentUserID, ROUTE_NAME];
  DoCheckRouteIsExist(lCurrentUserID, LCurrentState);
  if FRoutes.TryGetValue(LCurrentState, lRoute) then
  begin
    lRoute.SendMessage(AMessage)
  end;
end;

end.
