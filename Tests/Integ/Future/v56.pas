unit v56;

interface

uses
  DUnitX.TestFramework,
  TestsFixture;

type

  [TestFixture]
  TtgFutureTest_v56 = class(TTestsFixture)
  public
    [Test]
    procedure protect_content_sendMessage;
    [Test]
    procedure protect_content_sendPhoto;
    [Test]
    procedure protect_content_sendVideo;
    [Test]
    procedure protect_content_sendAnimation;
    [Test]
    procedure protect_content_sendAudio;
    [Test]
    procedure protect_content_sendDocument;
    [Test]
    procedure protect_content_sendSticker;
    [Test]
    procedure protect_content_sendVideoNote;
    [Test]
    procedure protect_content_sendVoice;
    [Test]
    procedure protect_content_sendLocation;
    [Test]
    procedure protect_content_sendVenue;
    [Test]
    procedure protect_content_sendContact;
    [Test]
    procedure protect_content_sendPoll;
    [Test]
    procedure protect_content_sendDice;
    [Test]
    procedure protect_content_sendInvoice;
    [Test]
    procedure protect_content_sendGame;
    [Test]
    procedure protect_content_sendMediaGroup;
    [Test]
    procedure protect_content_copyMessage;
  end;

implementation

uses
  TelegaPi,
  TelegramBotApi.Types,
  Test.Data,
  System.SysUtils;

{ TtgFutureTest_v56 }

procedure TtgFutureTest_v56.protect_content_copyMessage;
var
  LOrigArg: TtgSendMessageArgument;
  lCopyArg: TtgCopyMessageArgument;
  LOrigMsg: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
  lCopyResult: ItgResponse<TtgMessageId>;
begin
  LOrigArg := TtgSendMessageArgument.Create;
  lCopyArg := TtgCopyMessageArgument.Create;
  try
    // блок отправки сообщения
    LOrigArg.ChatId := TTestData.Current.SupergroupChat.ID;
    LOrigArg.Text := 'Original message';
    LOrigMsg := Bot.SendMessage(LOrigArg);
    Assert.AreEqual(True, LOrigMsg.Ok, LOrigMsg.Description);
    LMessage := LOrigMsg.Result;
    Assert.AreEqual(LOrigArg.Text, LMessage.Text);
    // блок отправки измененного сообщения
    lCopyArg.ChatId := LOrigArg.ChatId;
    lCopyArg.FromChatId := LOrigMsg.Result.Chat.ID;
    lCopyArg.MessageID := LOrigMsg.Result.MessageID;
    lCopyArg.ProtectContent := True;
    lCopyResult := Bot.CopyMessage(lCopyArg);
    Assert.AreEqual(True, lCopyResult.Ok, lCopyResult.Description);

  finally
    LOrigArg.Free;
    lCopyArg.Free;
  end;

end;

procedure TtgFutureTest_v56.protect_content_sendAnimation;
var
  LAnimeArgument: TtgSendAnimationArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LAnimeArgument := TtgSendAnimationArgument.Create;
  try
    // блок отправки сообщения
    LAnimeArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LAnimeArgument.Caption := 'Protected sendAnimation';
    LAnimeArgument.Animation := 'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4';
    LAnimeArgument.ProtectContent := True;
    LResult := Bot.SendAnimation(LAnimeArgument);
    System.Writeln(Bot.CloudApi.ResponsePrinter.AsJson);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LAnimeArgument.ProtectContent, LMessage.HasProtectedContent);
  finally
    LAnimeArgument.Free;
  end;
end;

procedure TtgFutureTest_v56.protect_content_sendAudio;
var
  LAudioArgument: TtgSendAudioArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LAudioArgument := TtgSendAudioArgument.Create;
  try
    // блок отправки сообщения
    LAudioArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LAudioArgument.Caption := 'Protected sendAudio';
    LAudioArgument.Audio := 'https://www.learningcontainer.com/wp-content/uploads/2020/02/Kalimba.mp3';
    LAudioArgument.ProtectContent := True;
    LResult := Bot.SendAudio(LAudioArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LAudioArgument.ProtectContent, LMessage.HasProtectedContent);
  finally
    LAudioArgument.Free;
  end;
end;

procedure TtgFutureTest_v56.protect_content_sendContact;
var
  LContactArgument: TtgSendContactArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LContactArgument := TtgSendContactArgument.Default;
  try
    // блок отправки сообщения
    LContactArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LContactArgument.PhoneNumber := '+380688888888';
    LContactArgument.FirstName := 'Max';
    LContactArgument.LastName := 'Rare';
    LContactArgument.ProtectContent := True;
    LResult := Bot.SendContact(LContactArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LContactArgument.ProtectContent, LMessage.HasProtectedContent);
  finally
    // LContactArgument.Free;
  end;
end;

procedure TtgFutureTest_v56.protect_content_sendDice;
var
  LDiceArgument: TtgSendDiceArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LDiceArgument := TtgSendDiceArgument.Create;
  try
    // блок отправки сообщения
    LDiceArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LDiceArgument.Emoji := '🎰';
    LDiceArgument.ProtectContent := True;
    LResult := Bot.SendDice(LDiceArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LDiceArgument.ProtectContent, LMessage.HasProtectedContent);
  finally
    LDiceArgument.Free;
  end;
end;

procedure TtgFutureTest_v56.protect_content_sendDocument;
var
  LDocArgument: TtgSendDocumentArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LDocArgument := TtgSendDocumentArgument.Create;
  try
    // блок отправки сообщения
    LDocArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LDocArgument.Caption := 'Protected sendDocument';
    LDocArgument.Document := 'https://www.learningcontainer.com/wp-content/uploads/2019/09/sample-pdf-file.pdf';
    LDocArgument.ProtectContent := True;
    LResult := Bot.SendDocument(LDocArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LDocArgument.ProtectContent, LMessage.HasProtectedContent);
  finally
    LDocArgument.Free;
  end;
end;

procedure TtgFutureTest_v56.protect_content_sendGame;
var
  LGameArgument: TtgSendGameArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LGameArgument := TtgSendGameArgument.Create;
  try
    // блок отправки сообщения
    LGameArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LGameArgument.GameShortName := 'Protected sendDocument';
    LGameArgument.ProtectContent := True;
    LResult := Bot.SendGame(LGameArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LGameArgument.ProtectContent, LMessage.HasProtectedContent);
  finally
    LGameArgument.Free;
  end;
end;

procedure TtgFutureTest_v56.protect_content_sendInvoice;
var
  LInvoiceArgument: TtgSendInvoiceArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LInvoiceArgument := TtgSendInvoiceArgument.Create;
  try
    // блок отправки сообщения
    LInvoiceArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LInvoiceArgument.Title := 'TelegaPi';
    LInvoiceArgument.Description := 'buy me coffee';
    LInvoiceArgument.Payload := TGUID.NewGuid.ToString;
    LInvoiceArgument.ProviderToken := '410694247:TEST:51494eb1-29d8-4c3e-8259-7ef26d0eaeb4';
    LInvoiceArgument.Currency := 'UAH';
    LInvoiceArgument.Prices := [TtgLabeledPrice.Create('Coffee', 2000)];
    LInvoiceArgument.ProtectContent := True;
    LResult := Bot.SendInvoice(LInvoiceArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LInvoiceArgument.ProtectContent, LMessage.HasProtectedContent);
  finally
    LInvoiceArgument.Free;
  end;
end;

procedure TtgFutureTest_v56.protect_content_sendLocation;
var
  LLocationArgument: TtgSendLocationArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LLocationArgument := TtgSendLocationArgument.Default;
  try
    // блок отправки сообщения
    LLocationArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LLocationArgument.Latitude := 1;
    LLocationArgument.Longitude := 2;
    LLocationArgument.ProtectContent := True;
    LResult := Bot.SendLocation(LLocationArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LLocationArgument.ProtectContent, LMessage.HasProtectedContent);
  finally
    //
  end;
end;

procedure TtgFutureTest_v56.protect_content_sendMediaGroup;
var
  LMediaGroup: TtgSendMediaGroupArgument;
  LResult: ItgResponse<TArray<TtgMessage>>;
  lMessages: TArray<TtgMessage>;
  i: integer;
begin
  LMediaGroup := TtgSendMediaGroupArgument.Create;
  try
    LMediaGroup.ChatId := TTestData.Current.SupergroupChat.ID;
    LMediaGroup.Media := [ //
      TtgInputMediaPhoto.Create('https://cdn.pixabay.com/photo/2017/06/20/19/22/fuchs-2424369_640.jpg'), //
      TtgInputMediaPhoto.Create('https://cdn.pixabay.com/photo/2017/04/11/21/34/giraffe-2222908_640.jpg')];
    LResult := Bot.SendMediaGroup(LMediaGroup);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    lMessages := LResult.Result;
    for i := Low(lMessages) to High(lMessages) do
    begin
      Assert.AreEqual(LMediaGroup.ProtectContent, LResult.Result[i].HasProtectedContent);
    end;
  finally
    for i := Low(lMessages) to High(lMessages) do
    begin
      lMessages[i].Free;
    end;
    LMediaGroup.Free;
  end;
end;

procedure TtgFutureTest_v56.protect_content_sendMessage;
var
  LMessageArgument: TtgSendMessageArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LMessageArgument := TtgSendMessageArgument.Create;
  try
    // блок отправки сообщения
    LMessageArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LMessageArgument.Text := 'Protected sendMessage';
    LMessageArgument.ProtectContent := True;
    LResult := Bot.SendMessage(LMessageArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LMessageArgument.Text, LMessage.Text);
    Assert.AreEqual(LMessageArgument.ProtectContent, LMessage.HasProtectedContent);
  finally
    LMessageArgument.Free;
  end;
end;

procedure TtgFutureTest_v56.protect_content_sendPhoto;
var
  LphotoArgument: TtgSendPhotoArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LphotoArgument := TtgSendPhotoArgument.Create;
  try
    // блок отправки сообщения
    LphotoArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LphotoArgument.Caption := 'Protected sendPhoto';
    LphotoArgument.Photo := 'https://avatars.githubusercontent.com/u/4525776?v=4';
    LphotoArgument.ProtectContent := True;
    LResult := Bot.SendPhoto(LphotoArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LphotoArgument.ProtectContent, LMessage.HasProtectedContent);
  finally
    LphotoArgument.Free;
  end;
end;

procedure TtgFutureTest_v56.protect_content_sendPoll;
var
  LPoolArgument: TtgSendPollArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LPoolArgument := TtgSendPollArgument.Default;
  try
    // блок отправки сообщения
    LPoolArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LPoolArgument.Question := 'protect_content_sendPoll';
    LPoolArgument.Options := ['a', 'b', 'c', 'd'];
    LPoolArgument.ProtectContent := True;
    LResult := Bot.SendPool(LPoolArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LPoolArgument.ProtectContent, LMessage.HasProtectedContent);
  finally
    // LPoolArgument.Free;
  end;
end;

procedure TtgFutureTest_v56.protect_content_sendSticker;
var
  LStickerArgument: TtgSendStickerArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LStickerArgument := TtgSendStickerArgument.Create;
  try
    // блок отправки сообщения
    LStickerArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LStickerArgument.Sticker := 'https://www.gstatic.com/webp/gallery/1.webp';
    LStickerArgument.ProtectContent := True;
    LResult := Bot.SendSticker(LStickerArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LStickerArgument.ProtectContent, LMessage.HasProtectedContent);
  finally
    LStickerArgument.Free;
  end;
end;

procedure TtgFutureTest_v56.protect_content_sendVenue;
var
  LVenueArgument: TtgSendVenueArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LVenueArgument := TtgSendVenueArgument.Default;
  try
    // блок отправки сообщения
    LVenueArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LVenueArgument.Latitude := 1;
    LVenueArgument.Longitude := 2;
    LVenueArgument.Title := 'Should_protect_content_sendVenue';
    LVenueArgument.Address := 'Melitopol';
    LVenueArgument.ProtectContent := True;
    LResult := Bot.SendVenue(LVenueArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LVenueArgument.ProtectContent, LMessage.HasProtectedContent);
  finally
    //
  end;
end;

procedure TtgFutureTest_v56.protect_content_sendVideo;
var
  LVideoArgument: TtgSendVideoArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LVideoArgument := TtgSendVideoArgument.Create;
  try
    // блок отправки сообщения
    LVideoArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LVideoArgument.Caption := 'Protected sendVideo';
    LVideoArgument.Video := 'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4';
    LVideoArgument.ProtectContent := True;
    LResult := Bot.SendVideo(LVideoArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LVideoArgument.ProtectContent, LMessage.HasProtectedContent);
  finally
    LVideoArgument.Free;
  end;
end;

procedure TtgFutureTest_v56.protect_content_sendVideoNote;
var
  LVideoArgument: TtgSendVideoNoteArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LVideoArgument := TtgSendVideoNoteArgument.Default;
  try
    // блок отправки сообщения
    LVideoArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LVideoArgument.VideoNote := 'https://www.learningcontainer.com/wp-content/uploads/2020/05/sample-mp4-file.mp4';
    LVideoArgument.ProtectContent := True;
    LResult := Bot.SendVideoNote(LVideoArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LVideoArgument.ProtectContent, LMessage.HasProtectedContent);
  finally

  end;
end;

procedure TtgFutureTest_v56.protect_content_sendVoice;
var
  LVoiceArgument: TtgSendVoiceArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LVoiceArgument := TtgSendVoiceArgument.Create;
  try
    // блок отправки сообщения
    LVoiceArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LVoiceArgument.Caption := 'Protected sendVoice';
    LVoiceArgument.Voice := 'https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.ogg';
    LVoiceArgument.ProtectContent := True;
    LResult := Bot.SendVoice(LVoiceArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LVoiceArgument.ProtectContent, LMessage.HasProtectedContent);
  finally
    LVoiceArgument.Free;
  end;
end;

initialization

TDUnitX.RegisterTestFixture(TtgFutureTest_v56);

end.
