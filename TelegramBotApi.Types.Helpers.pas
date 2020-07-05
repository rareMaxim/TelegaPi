unit TelegramBotApi.Types.Helpers;

interface

uses
  TelegramBotApi.Types.Enums;

type
  TAllowedUpdatesHelper = record helper for TAllowedUpdates
  public
    function ToString: string;
  end;

  TtgMessageEntityTypeHelper = record helper for TtgMessageEntityType
  public
    function ToString: string;
    class function FromString(const AValue: string): TtgMessageEntityType; static;
  end;

implementation

uses
  System.Generics.Collections,
  System.SysUtils;

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

end.
