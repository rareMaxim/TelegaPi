unit Test.Data;

interface

uses
  TelegramBotApi.Client,
  TelegramBotApi.Types,
  Test.Config;

type
  TTestData = class
  private const
    CONFIG_FILE_NAME = 'config.json';
  private
    class var FCurrent: TTestData;
  private
    FConfig: TConfigFile;
    FSupergroupChat: TtgChat;
    FBotUser: TtgUser;
  protected
    procedure InitBotUser;
    procedure InitSupergroupChat;
  public
    constructor Create;
    destructor Destroy; override;
    class constructor Create;
    class destructor Destroy;
    class function Current: TTestData;
    procedure AfterConstruction; override;
  published
    property Config: TConfigFile read FConfig write FConfig;
    property BotUser: TtgUser read FBotUser write FBotUser;
    property SupergroupChat: TtgChat read FSupergroupChat write FSupergroupChat;
  end;

implementation

uses
  TelegramBotApi.Types.Request,
  System.SysUtils;

{ TTestData }

constructor TTestData.Create;
begin
  inherited Create;
  FConfig := TConfigFile.Load(CONFIG_FILE_NAME);
  InitBotUser;
  InitSupergroupChat;
end;

destructor TTestData.Destroy;
begin
  FreeAndNil(FSupergroupChat);
  FreeAndNil(FBotUser);
  //

  FConfig.Save(CONFIG_FILE_NAME);
  FreeAndNil(FConfig);
  inherited Destroy;
end;

procedure TTestData.AfterConstruction;
begin
  inherited;

end;

class constructor TTestData.Create;
begin
  FCurrent := TTestData.Create;
end;

class function TTestData.Current: TTestData;
begin
  if FCurrent = nil then
    raise Exception.Create('Error Message');
  Result := FCurrent;
end;

class destructor TTestData.Destroy;
begin
  FreeAndNil(FCurrent);
end;

procedure TTestData.InitBotUser;
var
  LResp: ItgResponse<TtgUser>;
  FBot: TTelegramBotApi;
begin
  FBot := TTelegramBotApi.Create(FConfig.BotToken);
  try
    LResp := FBot.GetMe;
    FBotUser := LResp.Result;
    LResp.Result := default (TtgUser);
    LResp := nil;
  finally
    FreeAndNil(FBot);
  end;
end;

procedure TTestData.InitSupergroupChat;
var
  LGetChatArgument: TtgGetChatArgument;
  LResp: ItgResponse<TtgChat>;
  FBot: TTelegramBotApi;
begin
  FBot := TTelegramBotApi.Create(FConfig.BotToken);
  try
    LGetChatArgument := TtgGetChatArgument.Default;
    LGetChatArgument.ChatId := FConfig.SupergroupChatID;
    LResp := FBot.getChat(LGetChatArgument);
    FSupergroupChat := LResp.Result;
    LResp.Result := default (TtgChat);
    LResp := nil;
  finally
    FreeAndNil(FBot);
  end;

end;

end.
