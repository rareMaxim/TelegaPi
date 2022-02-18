unit DeleteTextMessageTests;

interface

uses
  TestsFixture,
  TelegaPi,
  Test.Data,
  DUnitX.TestFramework,
  DUnitX.Attributes;

type

  [TestFixture]
  TDeleteTextMessageTests = class(TTestsFixture)
  public
    [Test]
    procedure Should_Get_Me;
    [Test]
    procedure Should_Delete_Text_Message;
  end;

implementation

uses
  System.DateUtils,
  TelegramBotApi.Types, System.SysUtils;

{ TDeleteTextMessageTests }

procedure TDeleteTextMessageTests.Should_Delete_Text_Message;
var
  LMessageArgument: TtgSendMessageArgument;
  LDeleteMsg: TtgDeleteMessageArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
  lEditedResult: ItgResponse<Boolean>;
begin
  LMessageArgument := TtgSendMessageArgument.Create;
  LDeleteMsg := TtgDeleteMessageArgument.Create;
  try
    // блок отправки сообщения
    LMessageArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LMessageArgument.Text := 'Hello world!';
    LMessageArgument.ParseMode := TtgParseMode.Default;
    LResult := Bot.SendMessage(LMessageArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LMessageArgument.Text, LMessage.Text);
    // блок удаления сообщения
    LDeleteMsg.ChatId := LMessageArgument.ChatId;
    LDeleteMsg.MessageID := LResult.Result.MessageID;
    lEditedResult := Bot.DeleteMessage(LDeleteMsg);
    Assert.AreEqual(True, lEditedResult.Result);
    // System.Writeln(Bot.CloudApi.ResponsePrinter.AsJson);
    // общие проверки
    Assert.AreEqual(TtgMessageType.Text, LMessage.&Type);
    Assert.AreEqual(TTestData.Current.SupergroupChat.ID, LMessage.Chat.ID);
    Assert.IsTrue(DateInRange(LMessage.Date, IncSecond(Now, -10), IncSecond(Now, 2)));
    Assert.AreEqual(TTestData.Current.BotUser.ID, LMessage.From.ID);
    Assert.AreEqual(TTestData.Current.BotUser.Username, LMessage.From.Username);
  finally
    LMessageArgument.Free;
    LDeleteMsg.Free;
  end;
end;

procedure TDeleteTextMessageTests.Should_Get_Me;
var
  LResult: ItgResponse<TtgUser>;
begin
  LResult := Bot.GetMe;
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
end;

end.
