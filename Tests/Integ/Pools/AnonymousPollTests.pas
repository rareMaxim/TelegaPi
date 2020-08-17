unit AnonymousPollTests;

interface

uses
  TestsFixture,
  TelegramBotApi.Client,
  Test.Data,
  DUnitX.TestFramework,
  DUnitX.Attributes;

type

  [TestFixture]
  TAnonymousPollTests = class(TTestsFixture)
  public
    [Test]
    procedure Should_Send_Poll;
  end;

implementation

uses
  TelegramBotApi.Types,
  TelegramBotApi.Types.Enums,
  TelegramBotApi.Types.Request,
  Test.Assert;

{ TAnonymousPollTests }

procedure TAnonymousPollTests.Should_Send_Poll;
var
  LPool: TtgSendPollArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
  i: integer;
begin
  LPool := TtgSendPollArgument.Default;
  LPool.ChatId := TTestData.Current.SupergroupChat.ID;
  LPool.Question := 'Who shot first?';
  LPool.Options := ['Han Solo', 'Greedo', 'I don''t care'];
  LResult := Bot.SendPool(LPool);
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  LMessage := LResult.Result;

  Assert.AreEqual(TtgMessageType.Poll, LMessage.&Type);
  Assert.IsNotEmpty(LMessage.Poll.ID);
  Assert.IsFalse(LMessage.Poll.IsClosed);
  Assert.IsTrue(LMessage.Poll.IsAnonymous);
  Assert.AreEqual('regular', LMessage.Poll.&Type);
  Assert.IsFalse(LMessage.Poll.AllowsMultipleAnswers);
  TgAssert.IsDefault(LMessage.Poll.CorrectOptionId);
  TgAssert.IsDefault(LMessage.Poll.OpenPeriod);
  TgAssert.IsDefault(LMessage.Poll.CloseDate);
  Assert.AreEqual(LPool.Question, LMessage.Poll.Question);
  Assert.AreEqual(3, Length(LMessage.Poll.Options));
  for i := Low(LPool.Options) to High(LPool.Options) do
    Assert.AreEqual(LPool.Options[i], LMessage.Poll.Options[i].Text);
end;

end.
