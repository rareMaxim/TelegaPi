unit SendingPhotoMessageTests;

interface

uses
  TestsFixture,
  TelegramBotApi.Client,
  Test.Data,
  DUnitX.TestFramework,
  DUnitX.Attributes;

type

  [TestFixture]
  TSendingPhotoMessageTests = class(TTestsFixture)
  private
    FLastID: string;
  public
    [Test]
    procedure Should_Send_Photo_File;
    [Test]
    procedure Should_Send_Photo_FileId;
    [Test]
    procedure Should_Parse_Message_Caption_Entities_Into_Values;
    [Test]
    procedure Should_Send_Photo_With_Markdown_Encoded_Caption;
  end;

implementation

uses
  Test.Constants,
  TelegramBotApi.Types.Request, TelegramBotApi.Types,
  TelegramBotApi.Types.Enums, System.Generics.Collections, System.SysUtils;

{ TSendingPhotoMessageTests }

procedure TSendingPhotoMessageTests.Should_Parse_Message_Caption_Entities_Into_Values;
type
  TEntityValueMap = TPair<TtgMessageEntityType, string>;
const
  url = 'https://telegram.org/';
var
  LEntityValueMappings: TDictionary<string, TtgMessageEntityType>;
  LSendPhotoArgument: TtgSendPhotoArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
  I: Integer;
begin
  LEntityValueMappings := TDictionary<string, TtgMessageEntityType>.Create;
  LSendPhotoArgument := TtgSendPhotoArgument.Create;
  try
    LEntityValueMappings.Add('+38 063 126 48 33', TtgMessageEntityType.PhoneNumber);
    LEntityValueMappings.Add('$UAH', TtgMessageEntityType.Cashtag);
    LEntityValueMappings.Add('#TelegramBots', TtgMessageEntityType.Hashtag);
    LEntityValueMappings.Add('@BotFather', TtgMessageEntityType.Mention);
    LEntityValueMappings.Add('https://github.com/ms301/TelegramBotApi', TtgMessageEntityType.url);
    LEntityValueMappings.Add('security@telegram.org', TtgMessageEntityType.Email);
    LEntityValueMappings.Add('/test', TtgMessageEntityType.BotCommand);
    LEntityValueMappings.Add(Format('/test@%s', [TTestData.Current.BotUser.Username]), TtgMessageEntityType.BotCommand);

    LSendPhotoArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LSendPhotoArgument.Photo := TtgConst.PathToFile.Photos.Logo;
    LSendPhotoArgument.Caption := string.Join(#13#10, LEntityValueMappings.Keys.ToArray);
    LResult := Bot.SendPhoto(LSendPhotoArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    for I := 0 to LMessage.CaptionEntities.Count - 1 do
    begin
      Assert.IsTrue(LEntityValueMappings.ContainsValue(LMessage.CaptionEntities[I].&Type),
        'LEntityValueMappings.ContainsKey');
    end;
  finally
    LEntityValueMappings.Free;
    LSendPhotoArgument.Free;
  end;

end;

procedure TSendingPhotoMessageTests.Should_Send_Photo_File;
var
  LSendPhotoArgument: TtgSendPhotoArgument;
  LResult: ItgResponse<TtgMessage>;
  LPhoto: TtgPhotosize;
begin
  LSendPhotoArgument := TtgSendPhotoArgument.Create;
  try
    LSendPhotoArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LSendPhotoArgument.Caption := '👆 This is a ' + #13#10 + 'Telegram Bot';
    LSendPhotoArgument.Photo := TtgConst.PathToFile.Photos.Bot;
    LResult := Bot.SendPhoto(LSendPhotoArgument);
  finally
    LSendPhotoArgument.Free;
  end;

  FLastID := LResult.Result.Photo.First.FileId;
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  Assert.AreEqual(TtgMessageType.Photo, LResult.Result.&Type);
  for LPhoto in LResult.Result.Photo do
  begin
    Assert.IsNotEmpty(LPhoto.FileId);
    Assert.IsNotEmpty(LPhoto.FileUniqueId);
    Assert.IsFalse(LPhoto.Width = 0);
    Assert.IsFalse(LPhoto.Height = 0);
  end;
end;

procedure TSendingPhotoMessageTests.Should_Send_Photo_FileId;
var
  LSendPhotoArgument: TtgSendPhotoArgument;
  LResult: ItgResponse<TtgMessage>;
begin
  LSendPhotoArgument := TtgSendPhotoArgument.Create;
  try
    LSendPhotoArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LSendPhotoArgument.Photo := FLastID;
    LResult := Bot.SendPhoto(LSendPhotoArgument);
  finally
    LSendPhotoArgument.Free;
  end;
  Assert.AreEqual(True, LResult.Ok, LResult.Description);
  Assert.AreEqual(TtgMessageType.Photo, LResult.Result.&Type);
end;

procedure TSendingPhotoMessageTests.Should_Send_Photo_With_Markdown_Encoded_Caption;
type
  TEntityValueMap = TPair<TtgMessageEntityType, string>;
const
  url = 'https://telegram.org/';
var
  LEntityValueMappings: TDictionary<TtgMessageEntityType, string>;
  LSendPhotoArgument: TtgSendPhotoArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
  I: Integer;
begin
  LEntityValueMappings := TDictionary<TtgMessageEntityType, string>.Create;
  LSendPhotoArgument := TtgSendPhotoArgument.Create;
  try
    LEntityValueMappings.Add(TtgMessageEntityType.Bold, '*bold*');
    LEntityValueMappings.Add(TtgMessageEntityType.Italic, '_italic_');
    LEntityValueMappings.Add(TtgMessageEntityType.TextLink, Format('[inline url to Telegram.org](%s)', [url]));
    LSendPhotoArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LSendPhotoArgument.Photo := TtgConst.PathToFile.Photos.Logo;
    LSendPhotoArgument.Caption := string.Join(#13#10, LEntityValueMappings.Values.ToArray);
    LSendPhotoArgument.ParseMode := TtgParseMode.Markdown;
    LResult := Bot.SendPhoto(LSendPhotoArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    for I := 0 to LMessage.CaptionEntities.Count - 1 do
    begin
      Assert.IsTrue(LEntityValueMappings.ContainsKey(LMessage.CaptionEntities[I].&Type),
        'LEntityValueMappings.ContainsKey');
    end;
  finally
    LEntityValueMappings.Free;
    LSendPhotoArgument.Free;
  end;
end;

end.
