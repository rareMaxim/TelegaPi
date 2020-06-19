﻿unit Sending_Messages;

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
  end;

implementation

uses
  System.DateUtils,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Enums,
  TelegramBotApi.Types.Request,
  System.SysUtils;

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
  Assert.AreEqual('Hello world!', LMessage.Text);
  Assert.AreEqual(TtgMessageType.Text, LMessage.&type);
  Assert.AreEqual(TTestData.Current.SupergroupChat.ID, LMessage.Chat.ID);
  Assert.IsTrue(DateInRange(LMessage.Date, IncSecond(Now, -10), IncSecond(Now, 2)));
  Assert.AreEqual(TTestData.Current.BotUser.ID, LMessage.From.ID);
  Assert.AreEqual(TTestData.Current.BotUser.Username, LMessage.From.Username);
end;

end.
