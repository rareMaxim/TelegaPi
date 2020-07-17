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

end.
