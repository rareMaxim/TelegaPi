unit TelegramBotApi.Types.Helpers;

interface

uses
  TelegramBotApi.Types.Enums;

type
  TAllowedUpdatesHelper = record helper for TAllowedUpdates
  public
    function ToString: string;
  end;

  TtgChatActionHelper = record helper for TtgChatAction
  public
    function ToString: string;
  end;

  TtgMessageEntityTypeHelper = record helper for TtgMessageEntityType
  public
    function ToString: string;
    class function FromString(const AValue: string): TtgMessageEntityType; static;
  end;

  TtgParseModeHelper = record helper for TtgParseMode
  private const
    TG_PARSE_MODES: array of string = ['', 'Markdown', 'MarkdownV2', 'HTML'];
  public
    function ToString: string;
    class function FromString(const AValue: string): TtgParseMode; static;
  end;

implementation

uses
  System.Generics.Collections,
  System.SysUtils,
  System.Rtti;

{ TAllowedUpdatesHelper }

function TAllowedUpdatesHelper.ToString: string;
var
  LAllowed: TList<string>;
begin
  LAllowed := TList<string>.Create;
  try
    if TAllowedUpdate.Message in Self then
      LAllowed.Add('"message"');
    if TAllowedUpdate.Edited_message in Self then
      LAllowed.Add('"edited_message"');
    if TAllowedUpdate.Channel_post in Self then
      LAllowed.Add('"channel_post"');
    if TAllowedUpdate.Edited_channel_post in Self then
      LAllowed.Add('"edited_channel_post"');
    if TAllowedUpdate.Inline_query in Self then
      LAllowed.Add('"inline_query"');
    if TAllowedUpdate.Chosen_inline_result in Self then
      LAllowed.Add('"chosen_inline_result"');
    if TAllowedUpdate.Callback_query in Self then
      LAllowed.Add('"callback_query"');
    Result := '[' + Result.Join(',', LAllowed.ToArray) + ']';
  finally
    LAllowed.Free;
  end;

end;

{ TtgMessageEntityTypeHelper }

class function TtgMessageEntityTypeHelper.FromString(const AValue: string): TtgMessageEntityType;
var
  LStore: TDictionary<string, TtgMessageEntityType>;
begin
  LStore := TDictionary<string, TtgMessageEntityType>.Create;
  try
    LStore.Add('mention', TtgMessageEntityType.Mention);
    LStore.Add('hashtag', TtgMessageEntityType.Hashtag);
    LStore.Add('bot_command', TtgMessageEntityType.BotCommand);
    LStore.Add('url', TtgMessageEntityType.Url);
    LStore.Add('email', TtgMessageEntityType.Email);
    LStore.Add('bold', TtgMessageEntityType.Bold);
    LStore.Add('italic', TtgMessageEntityType.Italic);
    LStore.Add('code', TtgMessageEntityType.Code);
    LStore.Add('pre', TtgMessageEntityType.Pre);
    LStore.Add('text_link', TtgMessageEntityType.TextLink);
    LStore.Add('text_mention', TtgMessageEntityType.TextMention);
    LStore.Add('phone_number', TtgMessageEntityType.PhoneNumber);
    LStore.Add('cashtag', TtgMessageEntityType.Cashtag);
    LStore.Add('underline', TtgMessageEntityType.Underline);
    LStore.Add('strikethrough', TtgMessageEntityType.Strikethrough);
    Result := LStore[AValue];
  finally
    LStore.Free;
  end;
end;

function TtgMessageEntityTypeHelper.ToString: string;
var
  LStore: TDictionary<TtgMessageEntityType, string>;
begin
  LStore := TDictionary<TtgMessageEntityType, string>.Create;
  try
    LStore.Add(TtgMessageEntityType.Mention, 'mention');
    LStore.Add(TtgMessageEntityType.Hashtag, 'hashtag');
    LStore.Add(TtgMessageEntityType.BotCommand, 'bot_command');
    LStore.Add(TtgMessageEntityType.Url, 'url');
    LStore.Add(TtgMessageEntityType.Email, 'email');
    LStore.Add(TtgMessageEntityType.Bold, 'bold');
    LStore.Add(TtgMessageEntityType.Italic, 'italic');
    LStore.Add(TtgMessageEntityType.Code, 'code');
    LStore.Add(TtgMessageEntityType.Pre, 'pre');
    LStore.Add(TtgMessageEntityType.TextLink, 'text_link');
    LStore.Add(TtgMessageEntityType.TextMention, 'text_mention');
    LStore.Add(TtgMessageEntityType.PhoneNumber, 'phone_number');
    LStore.Add(TtgMessageEntityType.Cashtag, 'cashtag');
    LStore.Add(TtgMessageEntityType.Underline, 'underline');
    LStore.Add(TtgMessageEntityType.Strikethrough, 'strikethrough');
    Result := LStore[Self];
  finally
    LStore.Free;
  end;

end;

{ TtgParseModeHelper }

class function TtgParseModeHelper.FromString(const AValue: string): TtgParseMode;
var
  I: Integer;
begin
  Result := TtgParseMode.Default;
  for I := Low(TG_PARSE_MODES) to High(TG_PARSE_MODES) do
    if SameText(TG_PARSE_MODES[I], AValue) then
      Exit(TtgParseMode(I));
end;

function TtgParseModeHelper.ToString: string;
begin
  Result := TG_PARSE_MODES[Ord(Self)];
end;

{ TtgChatActionHelper }

function TtgChatActionHelper.ToString: string;
begin
  case Self of
    TtgChatAction.Typing:
      Result := 'typing';
    TtgChatAction.UploadPhoto:
      Result := 'upload_photo';
    TtgChatAction.RecordVideo:
      Result := 'record_video';
    TtgChatAction.UploadVideo:
      Result := 'upload_video';
    TtgChatAction.RecordVoice:
      Result := 'record_voice';
    TtgChatAction.UploadVoice:
      Result := 'upload_voice';
    TtgChatAction.UploadDocument:
      Result := 'upload_document';
    TtgChatAction.FindLocation:
      Result := 'find_location';
    TtgChatAction.RecordVideoNote:
      Result := 'record_video_note';
    TtgChatAction.UploadVideoNote:
      Result := 'upload_video_note';
    TtgChatAction.ChooseSticker:
      Result := 'choose_sticker';
  else
    raise Exception.Create('Unknown function TtgChatActionHelper.ToString: string;');
  end
end;

end.
