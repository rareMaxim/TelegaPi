program TelegramBotApiTests;

{$IFNDEF TESTINSIGHT}
{$APPTYPE CONSOLE}
{$ENDIF}
{$STRONGLINKTYPES ON}

uses
  System.SysUtils,
  {$IFDEF TESTINSIGHT}
  TestInsight.DUnitX,
  {$ELSE}
  DUnitX.Loggers.Console,
  {$ENDIF }
  DUnitX.TestFramework,
  TelegramBotApi.Client in '..\TelegramBotApi.Client.pas',
  TelegramBotApi.CloudAPI.Authenticator in '..\TelegramBotApi.CloudAPI.Authenticator.pas',
  TestsFixture in 'Integ\Framework\TestsFixture.pas',
  Test.Config in 'Integ\Framework\Test.Config.pas',
  Test.Data in 'Integ\Framework\Test.Data.pas',
  Test.Constants in 'Test.Constants.pas',
  Test.Assert in 'Integ\Framework\Test.Assert.pas',
  AlbumMessageTests in 'Integ\Sending Messages\AlbumMessageTests.pas',
  AnimationMessageTests in 'Integ\Sending Messages\AnimationMessageTests.pas',
  AudioMessageTests in 'Integ\Sending Messages\AudioMessageTests.pas',
  DocumentMessageTests in 'Integ\Sending Messages\DocumentMessageTests.pas',
  SendingContactMessageTests in 'Integ\Sending Messages\SendingContactMessageTests.pas',
  SendingPhotoMessageTests in 'Integ\Sending Messages\SendingPhotoMessageTests.pas',
  SendingVenueMessageTests in 'Integ\Sending Messages\SendingVenueMessageTests.pas',
  TextMessageTests in 'Integ\Sending Messages\TextMessageTests.pas',
  VideoMessageTests in 'Integ\Sending Messages\VideoMessageTests.pas';

//
{$IFNDEF TESTINSIGHT}

var
  runner: ITestRunner;
  results: IRunResults;
  logger: ITestLogger;
  nunitLogger: ITestLogger;
{$ENDIF}

begin
{$IFDEF TESTINSIGHT}
  TestInsight.DUnitX.RunRegisteredTests;
{$ELSE}
  try
    // Check command line options, will exit if invalid
    TDUnitX.CheckCommandLine;
    // Create the test runner
    runner := TDUnitX.CreateRunner;
    // Tell the runner to use RTTI to find Fixtures
    runner.UseRTTI := True;
    // When true, Assertions must be made during tests;
    runner.FailsOnNoAsserts := False;

    // tell the runner how we will log things
    // Log to the console window if desired
    if TDUnitX.Options.ConsoleMode <> TDunitXConsoleMode.Off then
    begin
      logger := TDUnitXConsoleLogger.Create(TDUnitX.Options.ConsoleMode = TDunitXConsoleMode.Quiet);
      runner.AddLogger(logger);
    end;

    // Run tests
    results := runner.Execute;
    if not results.AllPassed then
      System.ExitCode := EXIT_ERRORS;

{$IFNDEF CI}
    // We don't want this happening when running under CI.
    if TDUnitX.Options.ExitBehavior = TDUnitXExitBehavior.Pause then
    begin
      System.WriteLn;
      System.WriteLn('Telegram lib version: ' + TTelegramBotApi.LIB_VERSION);
      System.WriteLn('Done.. press <Enter> key to quit.');
      System.Readln;
    end;
{$ENDIF}
  except
    on E: Exception do
      System.WriteLn(E.ClassName, ': ', E.Message);
  end;
{$ENDIF}

end.
