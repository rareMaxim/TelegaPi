unit TestsFixture;

interface

uses
  DUnitX.TestFramework,
  Test.Integ.Config,
  TelegramBotApi.Client,
  TelegramBotApi.Types;

type

  [TestFixture]
  TTestsFixture = class
  private
    FBot: TTelegramBotApi;
    FBotUser: TtgUser;
  protected
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;

    property Bot: TTelegramBotApi read FBot write FBot;
    property BotUser: TtgUser read FBotUser write FBotUser;
  end;

implementation

{ TTestsFixture }

procedure TTestsFixture.Setup;
var
  LResp: ItgResponse<TtgUser>;
begin
  FBot := TTelegramBotApi.Create(TConfigFile.Current.BotToken);
  LResp := FBot.GetMe;
  FBotUser := LResp.Result;
  LResp.Result := default (TtgUser);
  LResp := nil;
end;

procedure TTestsFixture.TearDown;
begin
  FBotUser.Free;
  FBotUser := nil;
  FBot.Free;
  FBot := nil;
end;

initialization

ReportMemoryLeaksOnShutdown := True;

end.
