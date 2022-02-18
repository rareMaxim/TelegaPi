unit Main;

interface

uses
  TelegramBotApi.Client,
  DUnitX.TestFramework;

type

  [TestFixture]
  TTelegramBotApiTest = class
  strict private
    FTelegram: TTelegramBotApi;
    FSendToID: Int64;
    FHtml, FMarkdown, FMarkdownV2: string;
  protected
    procedure ReadIni;
  public
    [Setup]
    procedure Setup;
    [TearDown]
    procedure TearDown;
    // Sample Methods
    // Simple single Test
    [Test]
    procedure getMe;
    [Test]
    procedure SendMessage;
    [Test]
    procedure SendMessageFormattedMarkdown;
    [Test]
    procedure SendMessageFormattedMarkdownV2;
    [Test]
    procedure SendMessageFormattedMarkdownHtml;
    [Test]
    procedure ForwardMessage;
    [Test]
    procedure SendPhotoUrl;
    [Test]
    procedure SendPhotoFile;
    [Test]
    procedure SendAudioUrl;
    [Test]
    procedure SendDocument;
    [Test]
    procedure SendVideo;
    [Test]
    procedure SendAnimation;
    [Test]
    procedure GetUpdates;
  end;

implementation

uses
  CloudAPI.Types,
  System.IniFiles,
  System.IOUtils,
  System.SysUtils,
  TelegramBotApi.Types.Request,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Intf,
  TelegramBotApi.Types.Enums,
  TelegramBotApiTests.Tools, System.Generics.Collections;

procedure TTelegramBotApiTest.ReadIni;
var
  LIni: TMemIniFile;
begin
  if not FileExists('config.ini') then
    raise EFileNotFoundException.Create('config.ini not found');

  LIni := TMemIniFile.Create('config.ini');
  try
    FTelegram.BotToken := LIni.ReadString('Telegram', 'BotToken', '');
    FHtml := LIni.ReadString('SendMessage', 'html', '');
    FMarkdown := LIni.ReadString('SendMessage', 'Markdown', '');
    FMarkdownV2 := LIni.ReadString('SendMessage', 'MarkdownV2', '');
    FSendToID := LIni.ReadString('Telegram', 'SendToID', '').ToInt64;
  finally
    LIni.Free;
  end;
end;

procedure TTelegramBotApiTest.SendAnimation;
var
  LMsg: TtgSendAnimationArgument;
  LResult: ItgResponse<TtgMessage>;
begin
  LMsg := TtgSendAnimationArgument.Default;
  LMsg.ChatId := FSendToID;
  LMsg.Animation := TcaFileToSend.FromURL('http://techslides.com/demos/sample-videos/small.mp4');
  LMsg.Caption := 'SendAnimation';
  LResult := FTelegram.SendAnimation(LMsg);
  Assert.IsTrue(LResult.Ok, LResult.Description);
  Assert.IsTrue(LResult.Result.MessageID <> 0, LResult.Description);
end;

procedure TTelegramBotApiTest.SendAudioUrl;
var
  LMsg: TtgSendAudioArgument;
  LResult: ItgResponse<TtgMessage>;
begin
  LMsg := TtgSendAudioArgument.Default;
  LMsg.ChatId := FSendToID;
  LMsg.Audio := TcaFileToSend.FromURL('https://github.com/TelegramBots/book/raw/master/src/docs/audio-guitar.mp3');
  LMsg.Caption := 'Telegram bot api v.' + FTelegram.Version;
  LResult := FTelegram.SendAudio(LMsg);
  Assert.IsTrue(LResult.Ok, LResult.Description);
  Assert.IsTrue(LResult.Result.MessageID <> 0, LResult.Description);
end;

procedure TTelegramBotApiTest.SendDocument;
var
  LMsg: TtgSendDocumentArgument;
  LResult: ItgResponse<TtgMessage>;
begin
  LMsg := TtgSendDocumentArgument.Default;
  LMsg.ChatId := FSendToID;
  LMsg.Document := TcaFileToSend.FromFile('pJNqeRflXYU.bmp');
  LMsg.Caption := 'SendDocument';
  LResult := FTelegram.SendDocument(LMsg);
  Assert.IsTrue(LResult.Ok, LResult.Description);
  Assert.IsTrue(LResult.Result.MessageID <> 0, LResult.Description);
end;

procedure TTelegramBotApiTest.SendMessage;
var
  LMsg: TtgMessageArgument;
  LResult: ItgResponse<TtgMessage>;
begin
  LMsg := TtgMessageArgument.Default;
  LMsg.ChatId := FSendToID;
  LMsg.Text := 'Telegram bot api v.' + FTelegram.Version;
  LResult := FTelegram.SendMessage(LMsg);
  Assert.IsTrue(LResult.Ok, LResult.Description);
  Assert.IsTrue(LResult.Result.MessageID <> 0, LResult.Description);
end;

procedure TTelegramBotApiTest.SendMessageFormattedMarkdown;
var
  LMsg: TtgMessageArgument;
  LResult: ItgResponse<TtgMessage>;
begin
  LMsg := TtgMessageArgument.Default;
  LMsg.ChatId := FSendToID;
  LMsg.ParseMode := TtgParseMode.Markdown;
  LMsg.Text := TFile.ReadAllText(FMarkdown);
  LResult := FTelegram.SendMessage(LMsg);
  Assert.IsTrue(LResult.Ok, LResult.Description);
  Assert.IsTrue(LResult.Result.MessageID <> 0, LResult.Description);
end;

procedure TTelegramBotApiTest.SendMessageFormattedMarkdownHtml;
var
  LMsg: TtgMessageArgument;
  LResult: ItgResponse<TtgMessage>;
begin
  LMsg := TtgMessageArgument.Default;
  LMsg.ChatId := FSendToID;
  LMsg.ParseMode := TtgParseMode.HTML;
  LMsg.Text := TFile.ReadAllText(FHtml);
  LResult := FTelegram.SendMessage(LMsg);
  Assert.IsTrue(LResult.Ok, LResult.Description);
  Assert.IsTrue(LResult.Result.MessageID <> 0, LResult.Description);
end;

procedure TTelegramBotApiTest.SendMessageFormattedMarkdownV2;
var
  LMsg: TtgMessageArgument;
  LResult: ItgResponse<TtgMessage>;
begin
  LMsg := TtgMessageArgument.Default;
  LMsg.ChatId := FSendToID;
  LMsg.ParseMode := TtgParseMode.MarkdownV2;
  LMsg.Text := TFile.ReadAllText(FMarkdownV2);
  LResult := FTelegram.SendMessage(LMsg);
  Assert.IsTrue(LResult.Ok, LResult.Description);
  Assert.IsTrue(LResult.Result.MessageID <> 0, LResult.Description);
end;

procedure TTelegramBotApiTest.SendPhotoFile;
var
  LMsg: TtgSendPhotoArgument;
  LResult: ItgResponse<TtgMessage>;
begin
  LMsg := TtgSendPhotoArgument.Default;
  LMsg.ChatId := FSendToID;
  LMsg.Photo := TcaFileToSend.FromFile('pJNqeRflXYU.bmp');
  LMsg.Caption := 'Telegram bot api v.' + FTelegram.Version;
  LResult := FTelegram.SendPhoto(LMsg);
  Assert.IsTrue(LResult.Ok, LResult.Description);
  Assert.IsTrue(LResult.Result.MessageID <> 0, LResult.Description);
end;

procedure TTelegramBotApiTest.SendPhotoUrl;
var
  LMsg: TtgSendPhotoArgument;
  LResult: ItgResponse<TtgMessage>;
begin
  LMsg := TtgSendPhotoArgument.Default;
  LMsg.ChatId := FSendToID;
  LMsg.Photo := TcaFileToSend.FromURL
    ('https://www.google.com/images/branding/googlelogo/1x/googlelogo_color_272x92dp.png');
  LMsg.Caption := 'Telegram bot api v.' + FTelegram.Version;
  LResult := FTelegram.SendPhoto(LMsg);
  Assert.IsTrue(LResult.Ok, LResult.Description);
  Assert.IsTrue(LResult.Result.MessageID <> 0, LResult.Description);
end;

procedure TTelegramBotApiTest.SendVideo;
var
  LMsg: TtgSendVideoArgument;
  LResult: ItgResponse<TtgMessage>;
begin
  LMsg := TtgSendVideoArgument.Default;
  LMsg.ChatId := FSendToID;
  LMsg.Video := TcaFileToSend.FromURL('http://techslides.com/demos/sample-videos/small.mp4');
  LMsg.Caption := 'SendVideo';
  LResult := FTelegram.SendVideo(LMsg);
  Assert.IsTrue(LResult.Ok, LResult.Description);
  Assert.IsTrue(LResult.Result.MessageID <> 0, LResult.Description);
end;

procedure TTelegramBotApiTest.Setup;
begin
  ReportMemoryLeaksOnShutdown := true;
  FTelegram := TTelegramBotApi.Create;
  ReadIni;
end;

procedure TTelegramBotApiTest.TearDown;
begin
  FTelegram.Free;
end;

procedure TTelegramBotApiTest.ForwardMessage;
var
  LMsg: TtgMessageArgument;
  FMsgFrw: TtgForwardMessageArgument;
  LResult: ItgResponse<TtgMessage>;
begin
  LMsg := TtgMessageArgument.Default;
  LMsg.ChatId := FSendToID;
  LMsg.Text := 'Forward message';
  LResult := FTelegram.SendMessage(LMsg);
  FMsgFrw := TtgForwardMessageArgument.Default;
  FMsgFrw.ChatId := LResult.Result.Chat.ID;
  FMsgFrw.FromChatId := LResult.Result.Chat.ID;
  FMsgFrw.MessageID := LResult.Result.MessageID;
  LResult := FTelegram.ForwardMessage(FMsgFrw);
  Assert.IsTrue(LResult.Ok, LResult.Description);
  Assert.IsTrue(LResult.Result.MessageID <> 0, LResult.Description);
end;

procedure TTelegramBotApiTest.getMe;
var
  LResult: ItgResponse<TtgUser>;
  LID: Int64;
begin
  LResult := FTelegram.getMe;
  Assert.IsTrue(LResult.Ok, LResult.Description);
  LID := LResult.Result.ID;
  Assert.IsTrue(LID <> 0);
end;

procedure TTelegramBotApiTest.GetUpdates;
var
  LResult: ItgResponse<TArray<TtgUpdate>>;
  I: Integer;
begin
  LResult := FTelegram.GetUpdates(TtgGetUpdatesArgument.Default);
  try
    Assert.IsTrue(LResult.Ok, LResult.Description);
  finally
    for I := Low(LResult.Result) to High(LResult.Result) do
      LResult.Result[I].Free;
  end;
end;

initialization

TTelegramTools.GenerateEmptyConfigFile;
TDUnitX.RegisterTestFixture(TTelegramBotApiTest);

end.
