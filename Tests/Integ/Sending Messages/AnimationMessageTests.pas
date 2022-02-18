unit AnimationMessageTests;

interface

uses
  TestsFixture,
  TelegramBotApi.Client,
  Test.Data,
  DUnitX.TestFramework,
  DUnitX.Attributes;

type

  [TestFixture]
  TAnimationMessageTests = class(TTestsFixture)
  public
    [Test]
    procedure Should_Send_Animation;
    [Test]
    procedure Should_Send_Animation_With_Thumb;
  end;

implementation

uses
  TelegramBotApi.Types.Request, TelegramBotApi.Types, Test.Constants,
  TelegramBotApi.Types.Enums;

{ TAnimationMessageTests }

procedure TAnimationMessageTests.Should_Send_Animation;
var
  LAnimationArgument: TtgSendAnimationArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LAnimationArgument := TtgSendAnimationArgument.Create;
  try
    LAnimationArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LAnimationArgument.Animation := TtgConst.PathToFile.Animation.Earth;
    LAnimationArgument.Duration := 4;
    LAnimationArgument.Width := 400;
    LAnimationArgument.Height := 400;
    LAnimationArgument.Caption := '<b>Rotating</b> <i>Earth</i>';
    LAnimationArgument.ParseMode := TtgParseMode.HTML;
    LResult := Bot.SendAnimation(LAnimationArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;

    Assert.AreEqual(TtgMessageType.Document, LMessage.&Type);
    Assert.IsNotNull(LMessage.Document);
    Assert.IsNotNull(LMessage.Animation);

    Assert.AreEqual('Rotating Earth', LMessage.Caption);
    Assert.AreEqual(2, LMessage.CaptionEntities.Count);
    // Assert.AreEqual(2, LMessage.CaptionEntityValues.Count);

    Assert.AreEqual(LAnimationArgument.Duration, LMessage.Animation.Duration);
    Assert.AreEqual(LAnimationArgument.Width, LMessage.Animation.Width);
    Assert.AreEqual(LAnimationArgument.Height, LMessage.Animation.Height);
    Assert.AreEqual('video/mp4', LMessage.Animation.MimeType);
    Assert.IsNotEmpty(LMessage.Animation.FileId);
    Assert.IsNotEmpty(LMessage.Animation.FileUniqueId);
    Assert.IsNotEmpty(LMessage.Animation.Filename);
    Assert.IsTrue(LMessage.Animation.FileSize > 80000);
  finally
    LAnimationArgument.free;
  end;
end;

procedure TAnimationMessageTests.Should_Send_Animation_With_Thumb;
var
  LAnimationArgument: TtgSendAnimationArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LAnimationArgument := TtgSendAnimationArgument.Create;
  try
    LAnimationArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LAnimationArgument.Animation := TtgConst.PathToFile.Animation.Earth;
    LAnimationArgument.Thumb := TtgConst.PathToFile.Thumbnail.TheAbilityToBreak;

    LResult := Bot.SendAnimation(LAnimationArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;

    Assert.IsNotNull(LMessage.Animation);
    Assert.IsNotNull(LMessage.Animation.Thumb);

    Assert.IsNotEmpty(LMessage.Animation.Thumb.FileId);
    Assert.IsNotEmpty(LMessage.Animation.Thumb.FileUniqueId);
    Assert.IsNotEmpty(LMessage.Animation.Filename);
    Assert.IsTrue(LMessage.Animation.Thumb.FileSize > 10000);
  finally
    LAnimationArgument.free;
  end;
end;

end.
