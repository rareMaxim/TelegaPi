unit VideoMessageTests;

interface

uses
  TestsFixture,
  TelegramBotApi.Client,
  Test.Data,
  DUnitX.TestFramework,
  DUnitX.Attributes;

type

  [TestFixture]
  TSendingVideoMessageTests = class(TTestsFixture)
  public
    [Test]
    procedure Should_Send_Video;
  end;

implementation

uses
  CloudAPI.Types,
  System.DateUtils,
  System.SysUtils,
  Test.Constants,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Enums,
  TelegramBotApi.Types.Request;

{ TSendingVideoMessageTests }

procedure TSendingVideoMessageTests.Should_Send_Video;
var
  LVideoArgument: TtgSendVideoArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LVideoArgument := TtgSendVideoArgument.Default;
  LVideoArgument.ChatId := TTestData.Current.SupergroupChat.ID;
  LVideoArgument.Video := TcaFileToSend.FromFile(TtgConst.PathToFile.Videos.MoonLanding);
  LVideoArgument.Duration := 104;
  LVideoArgument.Width := 320;
  LVideoArgument.Height := 240;
  LVideoArgument.Caption := 'Moon Landing';
  LResult := Bot.SendVideo(LVideoArgument);

  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  LMessage := LResult.Result;
  Assert.AreEqual(TtgMessageType.Video, LMessage.&Type);
  Assert.AreEqual(LVideoArgument.Caption, LMessage.Caption);
  Assert.IsNotEmpty(LMessage.Video.FileId);
  Assert.IsNotEmpty(LMessage.Video.FileUniqueId);
  Assert.AreEqual(LVideoArgument.Duration, LMessage.Video.Duration);
  Assert.AreEqual(LVideoArgument.Width, LMessage.Video.Width);
  Assert.AreEqual(LVideoArgument.Height, LMessage.Video.Height);
  Assert.AreEqual('video/mp4', LMessage.Video.MimeType);
  Assert.IsNotEmpty(LMessage.Video.Thumb.FileId);
  Assert.IsNotEmpty(LMessage.Video.Thumb.FileUniqueId);
  Assert.IsTrue(LMessage.Video.Thumb.FileSize > 200);
  Assert.AreEqual(LVideoArgument.Width, LMessage.Video.Thumb.Width);
  Assert.AreEqual(LVideoArgument.Height, LMessage.Video.Thumb.Height);
  Assert.IsTrue((LMessage.Video.Thumb.FileSize >= 600) and (LMessage.Video.Thumb.FileSize <= 900));
end;

end.
