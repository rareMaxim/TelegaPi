program Experiments;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  TelegramBotApi.Client,
  TelegramBotApi.Types.Request,
  Test.Data,
  System.SysUtils;

procedure ExceptionHandler;
var
  LBot: TTelegramBotApi;
  LSendMsg: TtgMessageArgument;
begin
  LBot := TTelegramBotApi.Create(TTestData.Current.Config.BotToken);
  try
    LSendMsg := TtgMessageArgument.Default;
    LBot.SendMessage(LSendMsg);
  finally
    LBot.Free;
  end;
end;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    ExceptionHandler;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
  Readln;

end.
