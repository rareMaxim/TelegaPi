unit AudioMessageTests;

interface

uses
  TestsFixture,
  TelegramBotApi.Client,
  Test.Data,
  DUnitX.TestFramework,
  DUnitX.Attributes;

type

  [TestFixture]
  TAudioMessageTests = class(TTestsFixture)
  public
    [Test]
    procedure Should_Send_Audio;
    [Test]
    procedure Should_Send_Audio_With_Thumb;
    [Test]
    procedure Should_Send_Voice;
  end;

implementation

uses
  TelegramBotApi.Types.Request,
  TelegramBotApi.Types,
  Test.Constants, TelegramBotApi.Types.Enums;

{ TAudioMessageTests }

procedure TAudioMessageTests.Should_Send_Audio;
var
  LAudioArgument: TtgSendAudioArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LAudioArgument := TtgSendAudioArgument.Default;
  LAudioArgument.ChatId := TTestData.Current.SupergroupChat.ID;
  LAudioArgument.Audio := TtgConst.PathToFile.Audio.CantinaRagMp3;
  LAudioArgument.Title := 'Cantina Rag';
  LAudioArgument.Performer := 'Jackson F. Smith';
  LAudioArgument.Caption := 'Audio File in .mp3 format';
  LAudioArgument.Duration := 201;

  LResult := Bot.SendAudio(LAudioArgument);
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  LMessage := LResult.Result;

  Assert.AreEqual(TtgMessageType.Audio, LMessage.&Type);
  Assert.AreEqual(LAudioArgument.Caption, LMessage.Caption);
  Assert.AreEqual(LAudioArgument.Performer, LMessage.Audio.Performer);
  Assert.AreEqual(LAudioArgument.Title, LMessage.Audio.Title);
  Assert.AreEqual(LAudioArgument.Duration, LMessage.Audio.Duration);
  Assert.AreEqual('audio/mpeg', LMessage.Audio.MimeType);
  Assert.IsNotEmpty(LMessage.Audio.FileId);
  Assert.IsNotEmpty(LMessage.Audio.FileUniqueId);
  Assert.IsTrue(LMessage.Audio.FileSize > 200);
end;

procedure TAudioMessageTests.Should_Send_Audio_With_Thumb;
var
  LAudioArgument: TtgSendAudioArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LAudioArgument := TtgSendAudioArgument.Default;
  LAudioArgument.ChatId := TTestData.Current.SupergroupChat.ID;
  LAudioArgument.Audio := TtgConst.PathToFile.Audio.AStateOfDespairMp3;
  LAudioArgument.Thumb := TtgConst.PathToFile.Thumbnail.TheAbilityToBreak;

  LResult := Bot.SendAudio(LAudioArgument);
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  LMessage := LResult.Result;

  Assert.IsNotNull(LMessage.Audio.Thumb);
  Assert.IsNotEmpty(LMessage.Audio.Thumb.FileId);
  Assert.IsNotEmpty(LMessage.Audio.Thumb.FileUniqueId);
  Assert.AreEqual(Int64(90), LMessage.Audio.Thumb.Width);
  Assert.AreEqual(Int64(90), LMessage.Audio.Thumb.Height);
  Assert.IsTrue(LMessage.Audio.Thumb.FileSize > 10000);
end;

procedure TAudioMessageTests.Should_Send_Voice;
var
  LAudioArgument: TtgSendVoiceArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LAudioArgument := TtgSendVoiceArgument.Default;
  LAudioArgument.ChatId := TTestData.Current.SupergroupChat.ID;
  LAudioArgument.Voice := TtgConst.PathToFile.Audio.TestOgg;
  LAudioArgument.Caption := 'Test Voice in .ogg format';
  LAudioArgument.Duration := 24;

  LResult := Bot.SendVoice(LAudioArgument);
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  LMessage := LResult.Result;

  Assert.AreEqual(TtgMessageType.Voice, LMessage.&Type);
  Assert.AreEqual(LAudioArgument.Caption, LMessage.Caption);
  Assert.AreEqual(LAudioArgument.Duration, LMessage.Voice.Duration);
  Assert.AreEqual('audio/ogg', LMessage.Audio.MimeType);
  Assert.IsNotEmpty(LMessage.Audio.FileId);
  Assert.IsNotEmpty(LMessage.Audio.FileUniqueId);
  Assert.IsTrue(LMessage.Audio.FileSize > 200);
end;

end.
