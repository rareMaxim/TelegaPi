unit DocumentMessageTests;

interface

uses
  TestsFixture,
  TelegramBotApi.Client,
  Test.Data,
  DUnitX.TestFramework,
  DUnitX.Attributes;

type

  [TestFixture]
  TSendingDocumentMessageTests = class(TTestsFixture)
  public
    [Test]
    procedure Should_Send_Pdf_Document;
  end;

implementation

uses
  Test.Assert,
  TelegramBotApi.Types.Request,
  TelegramBotApi.Types,
  Test.Constants,
  TelegramBotApi.Types.Enums;

{ TSendingDocumentMessageTests }

procedure TSendingDocumentMessageTests.Should_Send_Pdf_Document;
var
  LSendDocumentArgument: TtgSendDocumentArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LSendDocumentArgument := TtgSendDocumentArgument.Default;
  LSendDocumentArgument.ChatId := TTestData.Current.SupergroupChat.ID;
  LSendDocumentArgument.Document := TtgConst.PathToFile.Documents.Hamlet;
  LSendDocumentArgument.Caption := 'The Tragedy of Hamlet,' + #10 + 'Prince of Denmark';
  LResult := Bot.SendDocument(LSendDocumentArgument);
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  LMessage := LResult.Result;
  Assert.AreEqual(TtgMessageType.Document, LMessage.&Type);
  Assert.AreEqual(LSendDocumentArgument.Document.Name, LMessage.Document.Filename);
  Assert.AreEqual('application/pdf', LResult.Result.Document.MimeType);
  TgAssert.InRange(LMessage.Document.FileSize, 253000, 257000);
  Assert.IsNotEmpty(LMessage.Document.FileId);
  Assert.IsNotEmpty(LMessage.Document.FileUniqueId);
  Assert.AreEqual(LSendDocumentArgument.Caption, LMessage.Caption);
end;

end.
