program Example.Echo;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  FastMM5,
  System.SysUtils,
  WinAPI.Windows,
  TelegramBotApi.Client,
  TelegramBotApi.Polling.Console,
  Test.Config in '..\..\Tests\Integ\Framework\Test.Config.pas',
  TelegramBotApi.Types;

type
  TControllerTest = class
  private
    FBot: TTelegramBotApi;
    FMe: TtgUser;
    FPoller: TtgPollingConsole;
    FConfig: TConfigFile;
  protected
  public
    constructor Create;
    destructor Destroy; override;

  end;

  { TControllerTest }

constructor TControllerTest.Create;
begin
  FConfig := TConfigFile.Load('config.json');
  FBot := TTelegramBotApi.Create(FConfig.BotToken);
  FPoller := TtgPollingConsole.Create;
  FPoller.Bot := FBot;
  FMe := FBot.GetMe.Result;
  SetConsoleTitle(PWideChar(FMe.Username));
  FPoller.OnMessage := procedure(AMsg: TtgMessage)
    begin
      Writeln(AMsg.Text);
    end;
  FPoller.Start;
  Writeln('Start listening for @' + FMe.Username);
end;

destructor TControllerTest.Destroy;
begin
  // FMe.Free;
  FPoller.Free;
  FBot.Free;
  FConfig.Free;
  inherited;
end;

procedure Run;
var
  LProgram: TControllerTest;
begin
  LProgram := TControllerTest.Create;
  try
    Readln;
  finally
    LProgram.Free;
  end;
end;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    ReportMemoryLeaksOnShutdown := True;
    Run;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
