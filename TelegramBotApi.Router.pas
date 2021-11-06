unit TelegramBotApi.Router;

interface

uses
  System.Generics.Collections,
  System.SysUtils;

type
  // TtgRouteUserState = TPair<Int64, string>;

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
    property DefaultName: string read FDefaultName write FDefaultName;
    property OnGetUserStateCallback: TFunc<Int64, string> read FOnGetUserStateCallback write FOnGetUserStateCallback;
    property OnSetUserStateCallback: TProc<Int64, string> read FOnSetUserStateCallback write FOnSetUserStateCallback;
    property UserState[const AIndex: Int64]: string read DoGetUserState write DoSetUserState;
  end;

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

  TtgRoute = class
  private
    FName: string;
  public
    constructor Create(const AName: string);
    property Name: string read FName write FName;

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

constructor TtgRoute.Create(const AName: string);
begin
  inherited Create;
  FName := AName;
end;

end.
