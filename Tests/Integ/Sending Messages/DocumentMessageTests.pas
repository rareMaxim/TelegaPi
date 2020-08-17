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
    [Test]
    procedure Should_Send_Document_With_Farsi_Name;
    [Test]
    procedure Should_Send_Document_With_Thumb;
  end;

implementation

uses
  Test.Assert,
  TelegramBotApi.Types.Request,
  TelegramBotApi.Types,
  Test.Constants,
  TelegramBotApi.Types.Enums;

{ TSendingDocumentMessageTests }

procedure TSendingDocumentMessageTests.Should_Send_Document_With_Farsi_Name;
var
  LSendDocumentArgument: TtgSendDocumentArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LSendDocumentArgument := TtgSendDocumentArgument.Default;
  LSendDocumentArgument.ChatId := TTestData.Current.SupergroupChat.ID;
  LSendDocumentArgument.Document := TtgConst.PathToFile.Documents.Hamlet;
  LSendDocumentArgument.Caption := 'تراژدی هملت' + #10 + 'شاهزاده دانمارک';
  LResult := Bot.SendDocument(LSendDocumentArgument);
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  LMessage := LResult.Result;
  Assert.AreEqual(TtgMessageType.Document, LMessage.&Type);
  Assert.AreEqual(LSendDocumentArgument.Document.FilePath, LMessage.Document.Filename);
  Assert.AreEqual('application/pdf', LResult.Result.Document.MimeType);
  TgAssert.InRange(LMessage.Document.FileSize, 253000, 257000);
  Assert.IsNotEmpty(LMessage.Document.FileId);
  Assert.IsNotEmpty(LMessage.Document.FileUniqueId);
  Assert.AreEqual(LSendDocumentArgument.Caption, LMessage.Caption);

end;

procedure TSendingDocumentMessageTests.Should_Send_Document_With_Thumb;
var
  LSendDocumentArgument: TtgSendDocumentArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LSendDocumentArgument := TtgSendDocumentArgument.Default;
  LSendDocumentArgument.ChatId := TTestData.Current.SupergroupChat.ID;
  LSendDocumentArgument.Document := TtgConst.PathToFile.Documents.Hamlet;
  LSendDocumentArgument.Thumb := TtgConst.PathToFile.Thumbnail.TheAbilityToBreak;
  LResult := Bot.SendDocument(LSendDocumentArgument);
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  LMessage := LResult.Result;

  Assert.IsNotNull(LMessage.Document.Thumb);
  Assert.IsNotEmpty(LMessage.Document.Thumb.FileId);
  Assert.IsNotEmpty(LMessage.Document.Thumb.FileUniqueId);
  Assert.AreEqual(Int64(90), LMessage.Document.Thumb.Width);
  Assert.AreEqual(Int64(90), LMessage.Document.Thumb.Height);
  TgAssert.InRange(LMessage.Document.Thumb.FileSize, 11000, 12000);

  Assert.AreEqual(TtgMessageType.Document, LMessage.&Type);
  Assert.AreEqual(LSendDocumentArgument.Document.FilePath, LMessage.Document.Filename);
  Assert.AreEqual('application/pdf', LResult.Result.Document.MimeType);
  TgAssert.InRange(LMessage.Document.FileSize, 253000, 257000);
  Assert.IsNotEmpty(LMessage.Document.FileId);
  Assert.IsNotEmpty(LMessage.Document.FileUniqueId);
  Assert.IsEmpty(LMessage.Caption);
end;

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
  Assert.AreEqual(LSendDocumentArgument.Document.FilePath, LMessage.Document.Filename);
  Assert.AreEqual('application/pdf', LResult.Result.Document.MimeType);
  TgAssert.InRange(LMessage.Document.FileSize, 253000, 257000);
  Assert.IsNotEmpty(LMessage.Document.FileId);
  Assert.IsNotEmpty(LMessage.Document.FileUniqueId);
  Assert.AreEqual(LSendDocumentArgument.Caption, LMessage.Caption);
end;

end.
