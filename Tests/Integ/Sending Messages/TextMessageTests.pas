unit TextMessageTests;

interface

uses
  TestsFixture,
  TelegramBotApi.Client,
  Test.Data,
  DUnitX.TestFramework,
  DUnitX.Attributes;

type

  [TestFixture]
  TTextMessageTests = class(TTestsFixture)
  public
    // [Test]
    procedure Should_Get_Me;
    [Test]
    procedure Should_Send_Text_Message;
    // [Test]
    procedure Should_Send_Text_Message_To_Channel;
    [Test]
    procedure Should_Forward_Message;
    // [Test]
    procedure Should_Parse_MarkDown_Entities;
    // [Test]
    procedure Should_Parse_HTML_Entities;
    // [Test]
    procedure Should_Parse_Message_Entities_Into_Values;
    // [Test]
    procedure Should_Parse_MarkdownV2_Entities;
  end;

implementation

uses
  System.DateUtils,
  System.Generics.Collections,
  System.SysUtils,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Enums,
  TelegramBotApi.Types.Helpers,
  TelegramBotApi.Types.Request;

procedure TTextMessageTests.Should_Forward_Message;
var
  LMessageArgument: TtgMessageArgument;
  LMessageForwardArgument: TtgForwardMessageArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
  LMessageFrw: TtgMessage;
begin
  LMessageArgument := TtgMessageArgument.Create;
  LMessageForwardArgument := TtgForwardMessageArgument.Create;
  try
    LMessageArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LMessageArgument.Text := '➡️ Message to be forwared ⬅️';
    LResult := Bot.SendMessage(LMessageArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    LMessageForwardArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LMessageForwardArgument.FromChatId := TTestData.Current.SupergroupChat.ID;
    LMessageForwardArgument.MessageId := LMessage.MessageId;
    LResult := Bot.ForwardMessage(LMessageForwardArgument);
    LMessageFrw := LResult.Result;
    Assert.AreEqual(TTestData.Current.BotUser.ID, LMessageFrw.From.ID);
    Assert.AreEqual(TTestData.Current.BotUser.Username, LMessageFrw.From.Username);
    Assert.IsNotNull(LMessageFrw.ForwardFromChat);
    Assert.AreEqual(LMessageFrw.ForwardFromMessageId, Default (Int64));
    Assert.IsEmpty(LMessageFrw.ForwardSignature);
    Assert.IsNotEmpty(LMessageFrw.ForwardDate);
    Assert.IsTrue(DateInRange(LMessageFrw.Date, IncSecond(Now, -10), IncSecond(Now, 2)));
  finally
    LMessageForwardArgument.Free;
    LMessageArgument.Free;
  end;

end;

procedure TTextMessageTests.Should_Get_Me;
var
  LResult: ItgResponse<TtgUser>;
begin
  LResult := Bot.GetMe;
  Assert.AreEqual(True, LResult.Ok, LResult.Description);

end;

procedure TTextMessageTests.Should_Parse_HTML_Entities;
type
  TEntityValueMap = TPair<TtgMessageEntityType, string>;
const
  url = 'https://telegram.org/';
var
  LEntityValueMappings: TDictionary<string, TtgMessageEntityType>;
  LMessageArgument: TtgMessageArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
  I: Integer;
begin
  LEntityValueMappings := TDictionary<string, TtgMessageEntityType>.Create;
  try
    LEntityValueMappings.Add('<b>bold</b>', TtgMessageEntityType.Bold);
    LEntityValueMappings.Add('<strong>strong</strong>', TtgMessageEntityType.Bold);
    LEntityValueMappings.Add('<i>italic</i>', TtgMessageEntityType.Italic);
    LEntityValueMappings.Add('<em>em</em>', TtgMessageEntityType.Italic);
    LEntityValueMappings.Add(Format('<a href="%s">inline url to Telegram.org</a>', [url]),
      TtgMessageEntityType.TextLink);
    LEntityValueMappings.Add(Format('<a href="tg://user?id=%d">%s</a>', [TTestData.Current.BotUser.ID,
      TTestData.Current.BotUser.FirstName]), TtgMessageEntityType.TextMention);
    LEntityValueMappings.Add('inline "`fixed-width code`"', TtgMessageEntityType.Code);
    LEntityValueMappings.Add('```pre-formatted fixed-width code block```', TtgMessageEntityType.Pre);
    LEntityValueMappings.Add('<s>strikethrough</s>', TtgMessageEntityType.Strikethrough);
    LEntityValueMappings.Add('<u>underline</u>', TtgMessageEntityType.Underline);

    LMessageArgument := TtgMessageArgument.Create;
    try
      LMessageArgument.ChatId := TTestData.Current.SupergroupChat.ID;
      LMessageArgument.Text := string.Join(#13#10, LEntityValueMappings.Keys.ToArray);
      LMessageArgument.ParseMode := TtgParseMode.HTML;
      LMessageArgument.DisableWebPagePreview := True;

      LResult := Bot.SendMessage(LMessageArgument);

    finally
      LMessageArgument.Free;
    end;
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;

    for I := 0 to LMessage.Entities.Count - 1 do
    begin
      Assert.IsTrue(LEntityValueMappings.ContainsValue(LMessage.Entities[I].&Type),
        LMessage.Entities[I].&Type.ToString);
    end;
  finally
    LEntityValueMappings.Free;
  end;

end;

procedure TTextMessageTests.Should_Parse_MarkdownV2_Entities;
type
  TEntityValueMap = TPair<TtgMessageEntityType, string>;
const
  url = 'https://telegram.org/';
var
  LEntityValueMappings: TDictionary<TtgMessageEntityType, string>;
  LMessageArgument: TtgMessageArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
  I: Integer;
begin
  LEntityValueMappings := TDictionary<TtgMessageEntityType, string>.Create;
  try
    LEntityValueMappings.Add(TtgMessageEntityType.Bold, '*bold*');
    LEntityValueMappings.Add(TtgMessageEntityType.Italic, '_italic_');
    LEntityValueMappings.Add(TtgMessageEntityType.TextLink, Format('[inline url to Telegram.org](%s)', [url]));
    LEntityValueMappings.Add(TtgMessageEntityType.TextMention, Format('[%s](tg://user?id=%d)',
      [TTestData.Current.BotUser.FirstName, TTestData.Current.BotUser.ID]));
    LEntityValueMappings.Add(TtgMessageEntityType.Code, 'inline "`fixed-width code`"');
    LEntityValueMappings.Add(TtgMessageEntityType.Pre, '```pre-formatted fixed-width code block```');

    LEntityValueMappings.Add(TtgMessageEntityType.Strikethrough, '~strikethrough~');
    LEntityValueMappings.Add(TtgMessageEntityType.Underline, '__underline__');

    LMessageArgument := TtgMessageArgument.Create;
    try
      LMessageArgument.ChatId := TTestData.Current.SupergroupChat.ID;
      LMessageArgument.Text := string.Join(#13#10, LEntityValueMappings.Values.ToArray);
      LMessageArgument.ParseMode := TtgParseMode.Markdown;
      LMessageArgument.DisableWebPagePreview := True;

      LResult := Bot.SendMessage(LMessageArgument);
      Assert.AreEqual(True, LResult.Ok, LResult.Description);
      LMessage := LResult.Result;

      for I := 0 to LMessage.Entities.Count - 1 do
      begin
        Assert.IsTrue(LEntityValueMappings.ContainsKey(LMessage.Entities[I].&Type), 'LEntityValueMappings.ContainsKey');
      end;
    finally
      LMessageArgument.Free;
    end;

  finally
    LEntityValueMappings.Free;
  end;

end;

procedure TTextMessageTests.Should_Parse_MarkDown_Entities;
type
  TEntityValueMap = TPair<TtgMessageEntityType, string>;
const
  url = 'https://telegram.org/';
var
  LEntityValueMappings: TDictionary<TtgMessageEntityType, string>;
  LMessageArgument: TtgMessageArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
  I: Integer;
begin
  LEntityValueMappings := TDictionary<TtgMessageEntityType, string>.Create;
  try
    LEntityValueMappings.Add(TtgMessageEntityType.Bold, '*bold*');
    LEntityValueMappings.Add(TtgMessageEntityType.Italic, '_italic_');
    LEntityValueMappings.Add(TtgMessageEntityType.TextLink, Format('[inline url to Telegram.org](%s)', [url]));
    LEntityValueMappings.Add(TtgMessageEntityType.TextMention, Format('[%s](tg://user?id=%d)',
      [TTestData.Current.BotUser.FirstName, TTestData.Current.BotUser.ID]));
    LEntityValueMappings.Add(TtgMessageEntityType.Code, 'inline "`fixed-width code`"');
    LEntityValueMappings.Add(TtgMessageEntityType.Pre, '```pre-formatted fixed-width code block```');

    LMessageArgument := TtgMessageArgument.Create;
    try
      LMessageArgument.ChatId := TTestData.Current.SupergroupChat.ID;
      LMessageArgument.Text := string.Join(#13#10, LEntityValueMappings.Values.ToArray);
      LMessageArgument.ParseMode := TtgParseMode.Markdown;
      LMessageArgument.DisableWebPagePreview := True;

      LResult := Bot.SendMessage(LMessageArgument);
    finally
      LMessageArgument.Free;
    end;

    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;

    for I := 0 to LMessage.Entities.Count - 1 do
    begin
      Assert.IsTrue(LEntityValueMappings.ContainsKey(LMessage.Entities[I].&Type), 'LEntityValueMappings.ContainsKey');
    end;
  finally
    LEntityValueMappings.Free;
  end;

end;

procedure TTextMessageTests.Should_Parse_Message_Entities_Into_Values;
type
  TEntityValueMap = TPair<TtgMessageEntityType, string>;
const
  url = 'https://telegram.org/';
var
  LEntityValueMappings: TDictionary<string, TtgMessageEntityType>;
  LMessageArgument: TtgMessageArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
  I: Integer;
begin
  LEntityValueMappings := TDictionary<string, TtgMessageEntityType>.Create;
  try
    LEntityValueMappings.Add('+38 063 126 48 33', TtgMessageEntityType.PhoneNumber);
    LEntityValueMappings.Add('$UAH', TtgMessageEntityType.Cashtag);
    LEntityValueMappings.Add('#TelegramBots', TtgMessageEntityType.Hashtag);
    LEntityValueMappings.Add('@BotFather', TtgMessageEntityType.Mention);
    LEntityValueMappings.Add('https://github.com/ms301/TelegramBotApi', TtgMessageEntityType.url);
    LEntityValueMappings.Add('security@telegram.org', TtgMessageEntityType.Email);
    LEntityValueMappings.Add('/test', TtgMessageEntityType.BotCommand);
    LEntityValueMappings.Add(Format('/test@%s', [TTestData.Current.BotUser.Username]), TtgMessageEntityType.BotCommand);

    LMessageArgument := TtgMessageArgument.Create;
    try
      LMessageArgument.ChatId := TTestData.Current.SupergroupChat.ID;
      LMessageArgument.Text := string.Join(#13#10, LEntityValueMappings.Keys.ToArray);

      LResult := Bot.SendMessage(LMessageArgument);
    finally
      LMessageArgument.Free;
    end;

    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;

    for I := 0 to LMessage.Entities.Count - 1 do
    begin
      Assert.IsTrue(LEntityValueMappings.ContainsValue(LMessage.Entities[I].&Type), 'LEntityValueMappings.ContainsKey');
    end;
  finally
    LEntityValueMappings.Free;
  end;
end;

procedure TTextMessageTests.Should_Send_Text_Message;
var
  LMessageArgument: TtgMessageArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LMessageArgument := TtgMessageArgument.Create;
  try
    LMessageArgument.ChatId := TTestData.Current.SupergroupChat.ID;
    LMessageArgument.Text := 'Hello world!';
    LMessageArgument.ParseMode := TtgParseMode.Default;
    LResult := Bot.SendMessage(LMessageArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LMessageArgument.Text, LMessage.Text);
  finally
    LMessageArgument.Free;
  end;

  Assert.AreEqual(TtgMessageType.Text, LMessage.&Type);
  Assert.AreEqual(TTestData.Current.SupergroupChat.ID, LMessage.Chat.ID);
  Assert.IsTrue(DateInRange(LMessage.Date, IncSecond(Now, -10), IncSecond(Now, 2)));
  Assert.AreEqual(TTestData.Current.BotUser.ID, LMessage.From.ID);
  Assert.AreEqual(TTestData.Current.BotUser.Username, LMessage.From.Username);
end;

procedure TTextMessageTests.Should_Send_Text_Message_To_Channel;
const
  C_MSG = 'Hello members of channel %s';
var
  LMessageArgument: TtgMessageArgument;
  LResult: ItgResponse<TtgMessage>;
  LMessage: TtgMessage;
begin
  LMessageArgument := TtgMessageArgument.Create;
  try
    LMessageArgument.ChatId := TTestData.Current.ChannelChat.Username;
    LMessageArgument.Text := Format(C_MSG, [LMessageArgument.ChatId.ToString]);
    LResult := Bot.SendMessage(LMessageArgument);
    Assert.AreEqual(True, LResult.Ok, LResult.Description);
    LMessage := LResult.Result;
    Assert.AreEqual(LMessageArgument.Text, LMessage.Text);
  finally
    LMessageArgument.Free;
  end;
  Assert.AreEqual(TtgMessageType.Text, LMessage.&Type);
  Assert.AreEqual(TTestData.Current.ChannelChat.ID, LMessage.Chat.ID);
  Assert.AreEqual(TTestData.Current.ChannelChat.Username, LMessage.Chat.Username);
end;

end.
