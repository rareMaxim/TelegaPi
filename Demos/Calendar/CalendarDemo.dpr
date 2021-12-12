program CalendarDemo;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  TelegramBotApi.Client,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Request,
  TelegramBotApi.Polling.Console,
  System.SysUtils,
  Winapi.Windows,
  TelegramBotApi.Ext.Calendar in '..\..\TelegramBotApi.Ext.Calendar.pas';

type
  TEchoCore = class
  const
    BOT_TOKEN = '1225990942:AAEfSINTq5fMdAOiswxNScZ8wQUDD_5KDYQ';
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
  fPooling.OnUpdates := procedure(AUpdates: TArray<TtgUpdate>)
    begin
 //     Writeln(fBot.CloudApi.ResponsePrinter.AsJson);
    end;
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
  lCalendar: TtgCalendarControl;
begin
  lMsg := TtgMessageArgument.Create;
  lCalendar := TtgCalendarControl.Create;
  try
    lMsg.ChatId := UserLink;
    lMsg.Text := 'Календарь';
    lMsg.ReplyMarkup := lCalendar.Keyboard;
    fBot.SendMessage(lMsg);
    Writeln(fBot.CloudApi.ResponsePrinter.AsJson);
  finally
    lMsg.Free;
    lCalendar.Free;
    // lKB.Free;     <-- Autofree in TelegaPi core
  end;
end;

procedure TEchoCore.UpdateConsoleTitle(ABot: TTelegramBotApi);
var
  lUser: TtgUser;
begin
  lUser := ABot.GetMe.Result;
  try
    if lUser = nil then
      raise Exception.Create('Check bot token');
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
    Readln;
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
