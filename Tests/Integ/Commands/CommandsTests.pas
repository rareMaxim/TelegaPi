unit CommandsTests;

interface

uses
  TestsFixture,
  TelegramBotApi.Client,
  Test.Data,
  DUnitX.TestFramework,
  DUnitX.Attributes;

type

  [TestFixture]
  TMyCommandsTests = class(TTestsFixture)
  public
    [Test]
    procedure Should_SetMyCommands;
    [Test]
    procedure Should_GetMyCommands;
  end;

implementation

uses
  TelegramBotApi.Types,
  TelegramBotApi.Types.Request;

{ TMyCommandsTests }

procedure TMyCommandsTests.Should_GetMyCommands;
var
  LGetMyCommands: TtgGetMyCommandsArgument;
  LResult: ItgResponse<TArray<TtgBotCommand>>;
begin
  LGetMyCommands := TtgGetMyCommandsArgument.Create;
  try
    LResult := Bot.GetMyCommands(LGetMyCommands);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
  finally
    LGetMyCommands.Free;
  end;

end;

procedure TMyCommandsTests.Should_SetMyCommands;
var
  LSetMyCommands: TtgSetMyCommandsArgument;
  LResult: ItgResponse<Boolean>;
begin
  LSetMyCommands := TtgSetMyCommandsArgument.Create;
  try
    LSetMyCommands.Commands := [TtgBotCommand.Create('new', 'новій')];
    LResult := Bot.SetMyCommands(LSetMyCommands);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
  finally
    LSetMyCommands.Free;
  end;

end;

end.
