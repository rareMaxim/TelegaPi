program Pooling;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  TelegramBotApi.Client,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Enums,
  TelegramBotApi.Types.Request,
  TelegramBotApi.Polling.Console,
  System.SysUtils,
  System.Rtti,
  Winapi.Windows,
  TelegramBotApi.Types.Keyboards,
  Demo.BotBase in '..\Demo.BotBase.pas', TelegramBotApi.Types.AvailableMethods;

type
  TDemoPooling = class(TDemoBotBase)
  protected
    procedure UpdateConsoleTitle(ABot: TTelegramBotApi);
    procedure SendTextMessage(const UserLink: TtgUserLink; const MsgText: string);
    procedure DoReadMessage(AMsg: TtgMessage);
    procedure SendFile(AMsg: TtgMessage);
    procedure SendReplyKeyboard(AMsg: TtgMessage);
  public
    procedure Main;
  end;

procedure TDemoPooling.DoReadMessage(AMsg: TtgMessage);
var
  lMsgType: string;
  lAction: string;
begin
  lMsgType := TRttiEnumerationType.GetName<TtgMessageType>(AMsg.&Type);
  Writeln('Receive message type: ' + lMsgType);
  if AMsg.&Type = TtgMessageType.Text then
  begin
    lAction := AMsg.Text.Split([' '])[0];
    if lAction = '/photo' then
    begin
      SendFile(AMsg);
    end
    else if lAction = '/keyboard' then
    begin
      SendReplyKeyboard(AMsg);
    end
    else
      SendTextMessage(AMsg.Chat.ID, AMsg.Text);
  end
  else
    SendTextMessage(AMsg.Chat.ID, lMsgType + ': ' + AMsg.Text);
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
