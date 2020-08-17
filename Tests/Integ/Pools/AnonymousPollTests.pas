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
  TelegramBotApi.Types.Request,
  TelegramBotApi.Types, TelegramBotApi.Types.Enums;

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

end;

end.
