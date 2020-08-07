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
    [Test]
    procedure Should_Send_Photo_Album_Using_Url;
  end;

implementation

uses
  TelegramBotApi.Types.Request,
  TelegramBotApi.Types, Test.Constants, CloudAPI.Types,
  TelegramBotApi.Types.Enums;

{ TAlbumMessageTests }

procedure TAlbumMessageTests.Should_Send_Photo_Album_Using_Url;
var
  LMediaGroup: TtgSendMediaGroupArgument;
  LResult: ItgResponse<TArray<TtgMessage>>;
  i: integer;
begin
  LMediaGroup := TtgSendMediaGroupArgument.Default;
  LMediaGroup.ChatId := TTestData.Current.SupergroupChat.ID;
  LMediaGroup.Media := [ //
    TtgInputMediaPhoto.Create('https://cdn.pixabay.com/photo/2017/06/20/19/22/fuchs-2424369_640.jpg'), //
    TtgInputMediaPhoto.Create('https://cdn.pixabay.com/photo/2017/04/11/21/34/giraffe-2222908_640.jpg')];
  LResult := Bot.SendMediaGroup(LMediaGroup);
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  for i := Low(LResult.Result) to High(LResult.Result) do
  begin
    Assert.AreEqual(TtgMessageType.Photo, LResult.Result[i].&Type);
    Assert.AreEqual(LMediaGroup.Media[i].Caption, LResult.Result[i].Caption);
  end;
end;

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
