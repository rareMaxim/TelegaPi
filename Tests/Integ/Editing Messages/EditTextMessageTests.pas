unit EditTextMessageTests;

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
    procedure Should_Get_Me;
    // [Test]
    procedure Should_Edit_Text_Message;
    [Test]
    procedure Should_Edit_Text_Message_With_Kb;
  end;

implementation

uses
  System.DateUtils,
  System.Generics.Collections,
  System.SysUtils,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Enums,
  TelegramBotApi.Types.Helpers,
  TelegramBotApi.Types.Request,
  TelegramBotApi.Types.Keyboards;

procedure TTextMessageTests.Should_Edit_Text_Message_With_Kb;
var
  LMessageArgument: TtgSendMessageArgument;
  LEditMsg: TtgEditMessageTextArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
  lEditedResult: ItgResponse<TtgMessage>;
begin
  LMessageArgument := TtgSendMessageArgument.Create;
  LEditMsg := TtgEditMessageTextArgument.Create;
  try
    // блок отправки сообщения
    LMessageArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LMessageArgument.Text := 'Hello world!';
    LMessageArgument.ParseMode := TtgParseMode.Default;
    LResult := Bot.SendMessage(LMessageArgument);
    LMessage := LResult.Result;
    Assert.AreEqual(LMessageArgument.Text, LMessage.Text);
    // блок отправки измененного сообщения
    LEditMsg.ChatId := LResult.Result.Chat.ID;
    LEditMsg.MessageID := LResult.Result.MessageID;
    LEditMsg.Text := 'EditedMessage!';
    lEditedResult := Bot.EditMessageText(LEditMsg);
    System.Writeln(Bot.CloudApi.ResponsePrinter.AsJson);
    // общие проверки
    Assert.AreEqual(TtgMessageType.Text, LMessage.&Type);
    Assert.AreEqual(TTestData.Current.SupergroupChat.ID, LMessage.Chat.ID);
    Assert.IsTrue(DateInRange(LMessage.Date, IncSecond(Now, -10), IncSecond(Now, 2)));
    Assert.AreEqual(TTestData.Current.BotUser.ID, LMessage.From.ID);
    Assert.AreEqual(TTestData.Current.BotUser.Username, LMessage.From.Username);
  finally
    LMessageArgument.Free;
    LEditMsg.Free;
  end;
end;

procedure TTextMessageTests.Should_Get_Me;
var
  LResult: ItgResponse<TtgUser>;
begin
  LResult := Bot.GetMe;
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
end;

procedure TTextMessageTests.Should_Edit_Text_Message;
var
  LMessageArgument: TtgSendMessageArgument;
  LEditMsg: TtgEditMessageTextArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
  lEditedResult: ItgResponse<TtgMessage>;
begin
  LMessageArgument := TtgSendMessageArgument.Create;
  LEditMsg := TtgEditMessageTextArgument.Create;
  try
    // блок отправки сообщения
    LMessageArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LMessageArgument.Text := 'Hello world!';
    LMessageArgument.ParseMode := TtgParseMode.Default;
    LResult := Bot.SendMessage(LMessageArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LMessageArgument.Text, LMessage.Text);
    // блок отправки измененного сообщения
    LEditMsg.ChatId := LMessageArgument.ChatId;
    LEditMsg.MessageID := LResult.Result.MessageID;
    LEditMsg.Text := 'EditedMessage!';
    lEditedResult := Bot.EditMessageText(LEditMsg);
    // System.Writeln(Bot.CloudApi.ResponsePrinter.AsJson);
    // общие проверки
    Assert.AreEqual(TtgMessageType.Text, LMessage.&Type);
    Assert.AreEqual(TTestData.Current.SupergroupChat.ID, LMessage.Chat.ID);
    Assert.IsTrue(DateInRange(LMessage.Date, IncSecond(Now, -10), IncSecond(Now, 2)));
    Assert.AreEqual(TTestData.Current.BotUser.ID, LMessage.From.ID);
    Assert.AreEqual(TTestData.Current.BotUser.Username, LMessage.From.Username);
  finally
    LMessageArgument.Free;
    LEditMsg.Free;
  end;
end;

end.
