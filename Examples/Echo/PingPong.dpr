program PingPong;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  FastMM5,
  System.SysUtils,
  WinAPI.Windows,
  TelegramBotApi.Client,
  TelegramBotApi.Polling.Console,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Request,
  Test.Config in '..\..\Tests\Integ\Framework\Test.Config.pas';

type
  TControllerTest = class
  private
    FBot: TTelegramBotApi;
    FMe: TtgUser;
    FPoller: TtgPollingConsole;
    FConfig: TConfigFile;
  protected
    procedure SendMsg(ATo: TtgUserLink; const AMsg: string);
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
      SendMsg(AMsg.From.ID, AMsg.Text);
    end;
  FPoller.Start;
  Writeln('Start listening for @' + FMe.Username);
end;

destructor TControllerTest.Destroy;
begin
  FPoller.Stop;
  FPoller.Free;
  FBot.Free;
  FConfig.Free;
  inherited;
end;

procedure TControllerTest.SendMsg(ATo: TtgUserLink; const AMsg: string);
var
  LMsgArg: TtgMessageArgument;
begin
  LMsgArg := TtgMessageArgument.Default;
  LMsgArg.ChatId := ATo;
  LMsgArg.Text := AMsg;
  FBot.SendMessage(LMsgArg);
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
