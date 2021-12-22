program EchoDemo;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  TelegramBotApi.Client,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Request,
  TelegramBotApi.Polling.Console,
  System.SysUtils,
  Winapi.Windows,
  Demo.BotBase in '..\Demo.BotBase.pas';

type
  TEchoCore = class(TDemoBotBase)
  protected
    procedure UpdateConsoleTitle(ABot: TTelegramBotApi);
    procedure SendTextMessage(const UserLink: TtgUserLink; const MsgText: string);
  public
    procedure Main;
  end;

procedure TEchoCore.Main;
begin
  UpdateConsoleTitle(Bot);
  Pooling.OnMessage := procedure(AMsg: TtgMessage)
    begin
      Writeln(AMsg.Text);
      SendTextMessage(AMsg.Chat.ID, AMsg.Text);
    end;
  Pooling.Start;
  WhaitEnter;
end;

procedure TEchoCore.SendTextMessage(const UserLink: TtgUserLink; const MsgText: string);
var
  lMsg: TtgMessageArgument;
begin
  lMsg := TtgMessageArgument.Create;
  try
    lMsg.ChatId := UserLink;
    lMsg.Text := MsgText;
    Bot.SendMessage(lMsg);
  finally
    lMsg.Free;
  end;
end;

procedure TEchoCore.UpdateConsoleTitle(ABot: TTelegramBotApi);
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
  lCore: TEchoCore;
begin
  lCore := TEchoCore.Create;
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
