program Router;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  TelegramBotApi.Client,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Enums,
  TelegramBotApi.Types.Request,
  TelegramBotApi.Polling.Console,
  TelegramBotApi.Router,
  System.SysUtils,
  System.Rtti,
  Winapi.Windows,
  TelegramBotApi.Types.Keyboards;

type
  TDemoPooling = class
  const
    BOT_TOKEN = '1225990942:AAEfSINTq5fMdAOiswxNScZ8wQUDD_5KDYQ';
  private
    fBot: TTelegramBotApi;
    fPooling: TtgPollingConsole;
    FRouteManager: TtgRouteManager;
    FUserStates: TtgRouteUserStateManagerRAM;
  protected
    procedure UpdateConsoleTitle(ABot: TTelegramBotApi);
    procedure SendTextMessage(const UserLink: TtgUserLink; const MsgText: string);
    procedure DoReadMessage(AMsg: TtgMessage);
    procedure SendFile(AMsg: TtgMessage);
    procedure SendReplyKeyboard(AMsg: TtgMessage);
    procedure SetupRoutes;
  public
    procedure Main;
    constructor Create;
    destructor Destroy; override;

  end;

  { TEchoCore }

constructor TDemoPooling.Create;
begin
  fBot := TTelegramBotApi.Create(BOT_TOKEN);
  fPooling := TtgPollingConsole.Create;
  fPooling.Bot := fBot;
  FUserStates := TtgRouteUserStateManagerRAM.Create;
  FRouteManager := TtgRouteManager.Create;
  FRouteManager.RouteUserState := FUserStates;
  SetupRoutes;
end;

destructor TDemoPooling.Destroy;
begin
  FRouteManager.Free;
  FUserStates.Free;
  fBot.Free;
  fPooling.Free;

  inherited;
end;

procedure TDemoPooling.DoReadMessage(AMsg: TtgMessage);
var
  lMsgType: string;
  lAction: string;
begin
  lMsgType := TRttiEnumerationType.GetName<TtgMessageType>(AMsg.&Type);
  Writeln('Receive message type: ' + lMsgType);
  FRouteManager.SendMessage(AMsg);
  if AMsg.&Type = TtgMessageType.Text then
  begin
    lAction := AMsg.Text.Split([' '])[0];
    if lAction = '/photo' then
    begin
      SendFile(AMsg);
    end
    else if lAction = '/keyboard' then
    begin

    end
    else
      SendTextMessage(AMsg.Chat.ID, AMsg.Text);
  end
  else
    SendTextMessage(AMsg.Chat.ID, lMsgType + ': ' + AMsg.Text);
end;

procedure TDemoPooling.Main;
begin
  UpdateConsoleTitle(fBot);
  fPooling.OnMessage := procedure(AMsg: TtgMessage)
    begin
      DoReadMessage(AMsg);
    end;
  fPooling.Start;
end;

procedure TDemoPooling.SendFile(AMsg: TtgMessage);
var
  lChatActionArg: TtgSendChatActionArgument;
  lSendPhotoArg: TtgSendPhotoArgument;
begin
  lChatActionArg := TtgSendChatActionArgument.Create(AMsg.Chat.ID, TtgChatAction.Typing);
  try
    fBot.SendChatAction(lChatActionArg);
  finally
    lChatActionArg.Free;
  end;

  lSendPhotoArg := TtgSendPhotoArgument.Create;
  try
    lSendPhotoArg.Photo := 'https://telegram.org/img/t_logo.png?1';
    lSendPhotoArg.Caption := 'Nice Picture';
    lSendPhotoArg.ChatId := AMsg.Chat.ID;
    fBot.SendPhoto(lSendPhotoArg);
  finally
    lSendPhotoArg.Free;
  end;
end;

procedure TDemoPooling.SendReplyKeyboard(AMsg: TtgMessage);
var
  lKB: TtgReplyKeyboardMarkup;
  lBtn: TtgKeyboardButton;
  lMsg: TtgMessageArgument;
begin
  lMsg := TtgMessageArgument.Create;
  lKB := TtgReplyKeyboardMarkup.Create;
  lBtn := TtgKeyboardButton.Create;
  try
    lBtn.Text := 'Sample button';
    lKB.Keyboard := [[lBtn, lBtn], [lBtn, lBtn, lBtn]];
    lMsg.ChatId := AMsg.Chat.ID;
    lMsg.Text := 'Choose';
    lMsg.ReplyMarkup := lKB;
    fBot.SendMessage(lMsg);
  finally
    lMsg.Free;
    // lKB.Free;     <-- Autofree in TelegaPi core
  end;
end;

procedure TDemoPooling.SendTextMessage(const UserLink: TtgUserLink; const MsgText: string);
var
  lMsg: TtgMessageArgument;
begin
  lMsg := TtgMessageArgument.Create;
  try
    lMsg.ChatId := UserLink;
    lMsg.Text := MsgText;
    fBot.SendMessage(lMsg);
  finally
    lMsg.Free;
  end;
end;

procedure TDemoPooling.SetupRoutes;
var
  lStart: TtgRoute;
  lKB: TtgRoute;
begin
  lStart := TtgRoute.Create('/start');
  lStart.OnMessageCallback := procedure(AMsg: TtgMessage)
    begin
      SendTextMessage(AMsg.Chat.ID, AMsg.Text);
    end;
  lKB := TtgRoute.Create('/keyboard');
  lKB.OnMessageCallback := procedure(AMsg: TtgMessage)
    begin
      SendReplyKeyboard(AMsg);
    end;
  //
  FRouteManager.RegisterRoutes([lStart, lKB]);
end;

procedure TDemoPooling.UpdateConsoleTitle(ABot: TTelegramBotApi);
var
  lUser: TtgUser;
begin
  lUser := ABot.GetMe.Result;
  try
    SetConsoleTitle(pwideChar(lUser.Username));
  finally
    // lUser.Free; <-- Autofree in TelegaPi core
  end;
end;

procedure Main;
var
  lCore: TDemoPooling;
begin
  lCore := TDemoPooling.Create;
  try
    lCore.Main;
  finally
    lCore.Free;
  end;
end;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    Main;
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
