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
  LFiles: TArray<TcaFileToSend>;
  i: integer;
begin
  LFiles := [ //
    TcaFileToSend.FromFile(TtgConst.PathToFile.Photos.Logo), //
    TcaFileToSend.FromFile(TtgConst.PathToFile.Photos.Bot)];
  LMediaGroup := TtgSendMediaGroupArgument.Default;
  LMediaGroup.ChatId := TTestData.Current.SupergroupChat.ID;
  LMediaGroup.Media := [ //
    TtgInputMediaPhoto.Create(LFiles[0], 'Logo'), //
    TtgInputMediaPhoto.Create(LFiles[1], 'Bot')];
  LResult := Bot.SendMediaGroup(LMediaGroup);
  Assert.AreEqual(True, LResult.Ok, LResult.Description);

  for i := Low(LResult.Result) to High(LResult.Result) do
  begin
    Assert.AreEqual(TtgMessageType.Photo, LResult.Result[i].&Type);
    Assert.AreEqual(LMediaGroup.Media[i].Caption, LResult.Result[i].Caption);
  end;
end;

end.
