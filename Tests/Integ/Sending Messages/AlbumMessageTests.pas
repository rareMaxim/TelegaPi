unit AlbumMessageTests;

interface

uses
  TestsFixture,
  TelegramBotApi.Client,
  Test.Data,
  DUnitX.TestFramework,
  DUnitX.Attributes;

type

  [TestFixture]
  TAlbumMessageTests = class(TTestsFixture)
  public
    [Test]
    procedure Should_Upload_2_Photos_Album;
  end;

implementation

uses
  TelegramBotApi.Types.Request,
  TelegramBotApi.Types, Test.Constants, CloudAPI.Types,
  TelegramBotApi.Types.Enums;

{ TAlbumMessageTests }

procedure TAlbumMessageTests.Should_Upload_2_Photos_Album;
var
  LMediaGroup: TtgSendMediaGroupArgument;
  LResult: ItgResponse<TArray<TtgMessage>>;
  LMsg: TtgMessage;
begin
  LMediaGroup := TtgSendMediaGroupArgument.Default;
  LMediaGroup.ChatId := TTestData.Current.SupergroupChat.ID;
  LMediaGroup.Media := [ //
    TInputMediaPhoto.Create(TcaFileToSend.FromFile(TtgConst.PathToFile.Photos.Bot)),
    TInputMediaPhoto.Create(TcaFileToSend.FromFile(TtgConst.PathToFile.Photos.Bot)) //
    ];

  LResult := Bot.SendMediaGroup(LMediaGroup);
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  for LMsg in LResult.Result do
  begin
    Assert.AreEqual(TtgMessageType.Photo, LMsg.&Type);
  end;

end;

end.
