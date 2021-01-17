program EchoDemo;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  TelegramBotApi.Client,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Request,
  TelegramBotApi.Polling.Console,
  System.SysUtils,
  Winapi.Windows;

type
  TEchoCore = class
  const
    BOT_TOKEN = '';
  private
    fBot: TTelegramBotApi;
    fPooling: TtgPollingConsole;
  protected
    procedure UpdateConsoleTitle(ABot: TTelegramBotApi);
    procedure SendTextMessage(const UserLink: TtgUserLink; const MsgText: string);
  public
    procedure Main;
    constructor Create;
    destructor Destroy; override;

  end;

  { TEchoCore }

constructor TEchoCore.Create;
begin
  fBot := TTelegramBotApi.Create(BOT_TOKEN);
  fPooling := TtgPollingConsole.Create;
  fPooling.Bot := fBot;
end;

destructor TEchoCore.Destroy;
begin
  fBot.Free;
  fPooling.Free;
  inherited;
end;

procedure TEchoCore.Main;
begin
  UpdateConsoleTitle(fBot);
  fPooling.OnMessage := procedure(AMsg: TtgMessage)
    begin
      Writeln(AMsg.Text);
      SendTextMessage(AMsg.Chat.ID, AMsg.Text);
    end;
  fPooling.Start;
end;

procedure TEchoCore.SendTextMessage(const UserLink: TtgUserLink; const MsgText: string);
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
    Readln;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
