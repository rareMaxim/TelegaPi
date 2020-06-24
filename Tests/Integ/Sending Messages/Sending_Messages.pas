unit Sending_Messages;

interface

uses
  TestsFixture,
  TelegramBotApi.Client,
  Test.Data,
  DUnitX.TestFramework,
  DUnitX.Attributes;

type

  [TestFixture]
  TTextMessageTests = class(TTestsFixture)
  public
    [Test]
    procedure Should_Send_Text_Message;
    [Test]
    procedure Should_Send_Text_Message_To_Channel;
    [Test]
    procedure Should_Forward_Message;
  end;

implementation

uses
  System.DateUtils,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Enums,
  TelegramBotApi.Types.Request,
  System.SysUtils;

procedure TTextMessageTests.Should_Forward_Message;
var
  LMessageArgument: TtgMessageArgument;
  LMessageForwardArgument: TtgForwardMessageArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
  LMessageFrw: TtgMessage;
begin
  LMessageArgument := TtgMessageArgument.Default;
  LMessageArgument.ChatId := TTestData.Current.SupergroupChat.ID;
  LMessageArgument.Text := '➡️ Message to be forwared ⬅️';
  LResult := Bot.SendMessage(LMessageArgument);
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  LMessage := LResult.Result;
  LMessageForwardArgument.ChatId := TTestData.Current.SupergroupChat.ID;
  LMessageForwardArgument.FromChatId := TTestData.Current.SupergroupChat.ID;
  LMessageForwardArgument.MessageId := LMessage.MessageId;
  LResult := Bot.ForwardMessage(LMessageForwardArgument);
  LMessageFrw := LResult.Result;
  Assert.AreEqual(TTestData.Current.BotUser.ID, LMessageFrw.From.ID);
  Assert.AreEqual(TTestData.Current.BotUser.Username, LMessageFrw.From.Username);
  Assert.IsNull(LMessageFrw.ForwardFromChat);
  Assert.AreEqual(LMessageFrw.ForwardFromMessageId, Default (Int64));
  Assert.IsEmpty(LMessageFrw.ForwardSignature);
  Assert.IsNotEmpty(LMessageFrw.ForwardDate);
  Assert.IsTrue(DateInRange(LMessageFrw.Date, IncSecond(Now, -10), IncSecond(Now, 2)));
end;

procedure TTextMessageTests.Should_Send_Text_Message;
var
  LMessageArgument: TtgMessageArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LMessageArgument := TtgMessageArgument.Default;
  LMessageArgument.ChatId := TTestData.Current.SupergroupChat.ID;
  LMessageArgument.Text := 'Hello world!';
  LResult := Bot.SendMessage(LMessageArgument);
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  LMessage := LResult.Result;
  Assert.AreEqual(LMessageArgument.Text, LMessage.Text);
  Assert.AreEqual(TtgMessageType.Text, LMessage.&type);
  Assert.AreEqual(TTestData.Current.SupergroupChat.ID, LMessage.Chat.ID);
  Assert.IsTrue(DateInRange(LMessage.Date, IncSecond(Now, -10), IncSecond(Now, 2)));
  Assert.AreEqual(TTestData.Current.BotUser.ID, LMessage.From.ID);
  Assert.AreEqual(TTestData.Current.BotUser.Username, LMessage.From.Username);
end;

procedure TTextMessageTests.Should_Send_Text_Message_To_Channel;
const
  C_MSG = 'Hello members of channel %s';
var
  LMessageArgument: TtgMessageArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LMessageArgument := TtgMessageArgument.Default;
  LMessageArgument.ChatId := TTestData.Current.ChannelChat.Username;
  LMessageArgument.Text := Format(C_MSG, [LMessageArgument.ChatId.ToString]);
  LResult := Bot.SendMessage(LMessageArgument);
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  LMessage := LResult.Result;
  Assert.AreEqual(LMessageArgument.Text, LMessage.Text);
  Assert.AreEqual(TtgMessageType.Text, LMessage.&type);
  Assert.AreEqual(TTestData.Current.ChannelChat.ID, LMessage.Chat.ID);
  Assert.AreEqual(TTestData.Current.ChannelChat.Username, LMessage.Chat.Username);
end;

end.
