unit SendingContactMessageTests;

interface

uses
  TestsFixture,
  TelegramBotApi.Client,
  Test.Data,
  DUnitX.TestFramework,
  DUnitX.Attributes;

type

  [TestFixture]
  TSendingContactMessageTests = class(TTestsFixture)
  private
    FLastID: string;
  public
    [Test]
    procedure Should_Send_Contact;
  end;

implementation

uses
  TelegramBotApi.Types.Request,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Enums;

{ TSendingContactMessageTests }

procedure TSendingContactMessageTests.Should_Send_Contact;
var
  LSendContactArgument: TtgSendContactArgument;
  LResult: ItgResponse<TtgMessage>;

begin
  LSendContactArgument := TtgSendContactArgument.Default;
  LSendContactArgument.ChatId := TTestData.Current.SupergroupChat.ID;
  LSendContactArgument.PhoneNumber := '+38 063 126 48 33';
  LSendContactArgument.FirstName := 'Max';
  LSendContactArgument.LastName := 'Rare';
  LResult := Bot.SendContact(LSendContactArgument);

  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  Assert.AreEqual(LSendContactArgument.PhoneNumber, LResult.Result.Contact.PhoneNumber);
  Assert.AreEqual(LSendContactArgument.FirstName, LResult.Result.Contact.FirstName);
  Assert.AreEqual(LSendContactArgument.LastName, LResult.Result.Contact.LastName);
end;

end.
