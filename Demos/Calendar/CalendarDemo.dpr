program CalendarDemo;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  TelegaPi,
  TelegramBotApi.Types,
  CloudAPI.Exceptions,
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
  Bot.CloudAPI.ExceptionManager.OnAlert := procedure(E: ECloudApiException)
    begin
      Writeln(E.ToString);
    end;
  UpdateConsoleTitle(Bot);

  Pooling.OnMessage := procedure(AMsg: TtgMessage)
    begin
      Writeln(AMsg.Text);
      SendTextMessage(AMsg.Chat.ID, AMsg.Text);
    end;
  Pooling.Start;
end;

procedure TEchoCore.SendTextMessage(const UserLink: TtgUserLink; const MsgText: string);
var
  lMsg: TtgSendMessageArgument;
  lCalendar: TtgCalendarControl;
begin
  lMsg := TtgSendMessageArgument.Create;
  lCalendar := TtgCalendarControl.Create;
  try
//    lCalendar.Day := 1;
//    lCalendar.Month := 1;
//    lCalendar.Year := 2022;
    lMsg.ChatId := UserLink;
    lMsg.Text := 'Календарь';
    lMsg.ReplyMarkup := lCalendar.Keyboard;
    Bot.SendMessage(lMsg);
    Writeln(Bot.CloudAPI.ResponsePrinter.AsJson);
  finally
    lMsg.Free;
    lCalendar.Free;
    // lKB.Free;     <-- Autofree in TelegaPi core
  end;
end;

procedure TEchoCore.UpdateConsoleTitle(ABot: TTelegramBotApi);
var
  lUser: ItgResponse<TtgUser>;
begin
  lUser := ABot.GetMe;
  try
    if lUser = nil then
    begin
     raise Exception.Create('Check bot token')
    end
    else
      SetConsoleTitle(pwideChar(lUser.Result.Username));
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
