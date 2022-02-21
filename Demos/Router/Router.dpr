program Router;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  TelegaPi,

  System.SysUtils,
  System.Rtti,
  Winapi.Windows,
  Demo.BotBase in '..\Demo.BotBase.pas',
  TelegramBotApi.Types.AvailableMethods,
  TelegramBotApi.Tools.UserDataStorage.Ram;

type
  TDemoPooling = class(TDemoBotBase)
  private
    FRouteManager: TtgRouter;
    FUserStates: TtgUserDataStorage;
  protected
    procedure UpdateConsoleTitle(ABot: TTelegramBotApi);
    procedure SendTextMessage(const UserLink: TtgUserLink; const MsgText: string);
    procedure DoReadMessage(AMsg: TtgMessage);
    procedure SendFile(AMsg: TtgMessage);
    procedure SendReplyKeyboard(AMsg: TtgMessage);
    procedure SetupRoutes;
  public
    procedure Main;
    destructor Destroy; override;
    constructor Create; override;
  end;

constructor TDemoPooling.Create;
begin
  inherited Create;
  FUserStates := TtgUserDataStorage.Create;
  FRouteManager := TtgRouter.Create(FUserStates, Bot);
  SetupRoutes;
end;

destructor TDemoPooling.Destroy;
begin
  FRouteManager.Free;
  FUserStates.Free;
  inherited;
end;

procedure TDemoPooling.DoReadMessage(AMsg: TtgMessage);
var
  lMsgType: string;
begin
  lMsgType := TRttiEnumerationType.GetName<TtgMessageType>(AMsg.&Type);
  FRouteManager.SendMessage(AMsg);
end;

procedure TDemoPooling.Main;
begin
  UpdateConsoleTitle(Bot);
  Pooling.OnMessage := procedure(AMsg: TtgMessage)
    begin
      DoReadMessage(AMsg);
    end;
  Pooling.Start;
  WhaitEnter;
end;

procedure TDemoPooling.SendFile(AMsg: TtgMessage);
var
  lChatActionArg: TtgSendChatActionArgument;
  lSendPhotoArg: TtgSendPhotoArgument;
begin
  lChatActionArg := TtgSendChatActionArgument.Create(AMsg.Chat.ID, TtgChatAction.Typing);
  try
    Bot.SendChatAction(lChatActionArg);
  finally
    lChatActionArg.Free;
  end;

  lSendPhotoArg := TtgSendPhotoArgument.Create;
  try
    lSendPhotoArg.Photo := 'https://telegram.org/img/t_logo.png?1';
    lSendPhotoArg.Caption := 'Nice Picture';
    lSendPhotoArg.ChatId := AMsg.Chat.ID;
    Bot.SendPhoto(lSendPhotoArg);
  finally
    lSendPhotoArg.Free;
  end;
end;

procedure TDemoPooling.SendReplyKeyboard(AMsg: TtgMessage);
var
  lKB: TtgReplyKeyboardMarkup;
  lBtn: TtgKeyboardButton;
  lMsg: TtgSendMessageArgument;
begin
  lMsg := TtgSendMessageArgument.Create;
  lKB := TtgReplyKeyboardMarkup.Create;
  lBtn := TtgKeyboardButton.Create;
  try
    lBtn.Text := 'Sample button';
    lKB.Keyboard := [[lBtn, lBtn], [lBtn, lBtn, lBtn]];
    lMsg.ChatId := AMsg.Chat.ID;
    lMsg.Text := 'Choose';
    lMsg.ReplyMarkup := lKB;
    Bot.SendMessage(lMsg);
  finally
    lMsg.Free;
    // lKB.Free;     <-- Autofree in TelegaPi core
  end;
end;

procedure TDemoPooling.SendTextMessage(const UserLink: TtgUserLink; const MsgText: string);
var
  lMsg: TtgSendMessageArgument;
begin
  lMsg := TtgSendMessageArgument.Create;
  try
    lMsg.ChatId := UserLink;
    lMsg.Text := MsgText;
    Bot.SendMessage(lMsg);
  finally
    lMsg.Free;
  end;
end;

procedure TDemoPooling.SetupRoutes;
var
  lStart: TtgRoute;
  lAge: TtgRoute;
  lName: TtgRoute;
begin
  lStart := TtgRoute.Create('/start');
  lStart.OnStartCallback := procedure(AUserID: Int64; AMsg: TtgMessage)
    begin
      Writeln(TimeToStr(NOW) + ':"' + lStart.Name + '" start');
      if AMsg.Text = lStart.Name then
        FRouteManager.MoveTo(AMsg.Chat.ID, lAge, AMsg);
    end;
  lStart.OnMessageCallback := procedure(AMsg: TtgMessage)
    begin
      Writeln(TimeToStr(NOW) + ':"' + lStart.Name + '" Message');
    end;
  lStart.OnStopCallback := procedure(AUserID: Int64)
    begin
      Writeln(TimeToStr(NOW) + ':"' + lStart.Name + '" stop');
    end;
  lAge := TtgRoute.Create('/age');
  lAge.OnStartCallback := procedure(AUserID: Int64; AMsg: TtgMessage)
    const
      C_MSG = 'Сколько тебе лет?';
    begin
      Writeln(TimeToStr(NOW) + ':"' + lAge.Name + '" start');
      SendTextMessage(AUserID, C_MSG);
    end;
  lAge.OnMessageCallback := procedure(AMsg: TtgMessage)
    var
      lAge_Value: Integer;
    const
      C_MSG = 'Не верю. Давай еще раз';
    begin
      Writeln(TimeToStr(NOW) + ':"' + lAge.Name + '" Message');
      if Integer.TryParse(AMsg.Text, lAge_Value) then
      begin
        FRouteManager.MoveTo(AMsg.Chat.ID, lName, AMsg);
      end
      else
      begin
        SendTextMessage(AMsg.Chat.ID, C_MSG);
      end;
    end;
  lAge.OnStopCallback := procedure(AUserID: Int64)
    begin
      Writeln(TimeToStr(NOW) + ':"' + lAge.Name + '" stop');
    end;
  lName := TtgRoute.Create('/name');
  lName.OnStartCallback := procedure(AUserID: Int64; AMsg: TtgMessage)
    begin
      Writeln(TimeToStr(NOW) + ':"' + lName.Name + '" start');
      SendTextMessage(AMsg.Chat.ID, 'Как тебя зовут?');
    end;
  lName.OnMessageCallback := procedure(AMsg: TtgMessage)
    const
      C_MSG = 'Приветики, ';
    begin
      SendTextMessage(AMsg.Chat.ID, C_MSG+ AMsg.Text);
    end;
  lName.OnStopCallback := procedure(AUserID: Int64)
    begin
      Writeln(TimeToStr(NOW) + ':"' + lName.Name + '" stop');
    end;
  //
  FRouteManager.RegisterRoutes([lStart, lAge, lName]);
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
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
