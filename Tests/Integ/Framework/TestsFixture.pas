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
  protected
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    property Bot: TTelegramBotApi read FBot write FBot;
  end;

implementation

{ TTestsFixture }

procedure TTestsFixture.Setup;
begin
  FBot := TTelegramBotApi.Create(TTestData.Current.Config.BotToken);
end;

procedure TTestsFixture.TearDown;
begin
  FBot.Free;
  FBot := nil;
end;

initialization

ReportMemoryLeaksOnShutdown := True;

end.
