unit TestsFixture;

interface

uses
  DUnitX.TestFramework,
  Test.Data,
  TelegramBotApi.Client,
  TelegramBotApi.Types;

type

  [TestFixture]
  TTestsFixture = class
  private
    FBot: TTelegramBotApi;

  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    property Bot: TTelegramBotApi read FBot write FBot;
  end;

implementation

uses
  System.SysUtils;

{ TTestsFixture }

procedure TTestsFixture.Setup;
begin
  FBot := TTelegramBotApi.Create(TTestData.Current.Config.BotToken);
  FBot.CloudApi.RequestLimitManager.Add(500, 'GlobalTelegram 0.5sec', True);
  FBot.CloudApi.RequestLimitManager.OnLimit := procedure(ANeedPause: Int64)
    begin
      Sleep(ANeedPause);
    end;
  FBot.CloudApi.ExceptionManager.AlertException := True;
end;

procedure TTestsFixture.TearDown;
begin
  FBot.Free;
  FBot := nil;
end;

initialization

ReportMemoryLeaksOnShutdown := True;

end.
