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
  public
    [Test]
    procedure Should_Send_Contact;
    [Test]
    procedure Should_Send_Contact_With_VCard;
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
  LSendContactArgument.PhoneNumber := '380631264833';
  LSendContactArgument.FirstName := 'Max';
  LSendContactArgument.LastName := 'Rare';
  LResult := Bot.SendContact(LSendContactArgument);
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  Assert.AreEqual(LSendContactArgument.PhoneNumber, LResult.Result.Contact.PhoneNumber);
  Assert.AreEqual(LSendContactArgument.FirstName, LResult.Result.Contact.FirstName);
  Assert.AreEqual(LSendContactArgument.LastName, LResult.Result.Contact.LastName);
end;

procedure TSendingContactMessageTests.Should_Send_Contact_With_VCard;
var
  LSendContactArgument: TtgSendContactArgument;
  LResult: ItgResponse<TtgMessage>;
begin
  LSendContactArgument := TtgSendContactArgument.Default;
  LSendContactArgument.ChatId := TTestData.Current.SupergroupChat.ID;
  LSendContactArgument.PhoneNumber := '380631264833';
  LSendContactArgument.FirstName := 'Max';
  LSendContactArgument.LastName := 'Rare';
  LSendContactArgument.VCard :=
    'BEGIN:VCARD' + #10 + // +
    'VERSION:2.1' + #10 + // +
    'N:Gump;Forrest;;Mr.' + #10 + // +
    'FN:Forrest Gump' + #10 + // +
    'ORG:Bubba Gump Shrimp Co.' + #10 + // +
    'TITLE:Shrimp Man' + #10 + // +
    'PHOTO;JPEG:https://upload.wikimedia.org/wikipedia/commons/9/95/TomHanksForrestGump94.jpg' + #10 + // +
    'TEL;WORK;VOICE:(111) 555-1212' + #10 + // +
    'TEL;HOME;VOICE:(404) 555-1212' + #10 + // +
    'ADR;HOME:;;42 Plantation St.;Baytown;LA;30314;United States of America' + #10 + // +
    'LABEL;HOME;ENCODING=QUOTED-PRINTABLE;CHARSET=UTF-8:42 Plantation St.=0D=0A=' + #10 + // +
    'Baytown, LA 30314=0D=0AUnited States of America' + #10 + // +
    'EMAIL:forrestgump@example.org' + #10 + // +
    'REV:20080424T195243Z' + #10 + // +
    'END:VCARD';

  LResult := Bot.SendContact(LSendContactArgument);
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  Assert.AreEqual(LSendContactArgument.PhoneNumber, LResult.Result.Contact.PhoneNumber);
  Assert.AreEqual(LSendContactArgument.FirstName, LResult.Result.Contact.FirstName);
  Assert.AreEqual(LSendContactArgument.LastName, LResult.Result.Contact.LastName);
  Assert.AreEqual(LSendContactArgument.VCard, LResult.Result.Contact.VCard);
end;

end.
