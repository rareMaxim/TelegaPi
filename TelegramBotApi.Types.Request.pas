unit TelegramBotApi.Types.Request;

interface

uses
  CloudAPI.Attributes,
  CloudAPI.Types,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Enums;

type

  /// <summary>
  /// A simple method for testing your bot's auth token.
  /// Requires no parameters.
  /// Returns basic information about the bot in form of a User object.
  /// </summary>
  [caName('getMe')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgGetMeArgument = record
  public
    class function Default: TtgGetMeArgument; static;
  end;

  [caName('sendMessage')]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>Use this method to send text messages.
  /// On success, the sent Message is returned.
  /// </summary>
  TtgMessageArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    [caName('text')]
    [caIsRequaired]
    [caDefaultValueString('')]
    /// <summary>Text of the message to be sent, 1-4096 characters after entities
    /// parsing</summary>
    Text: string;
    [caName('parse_mode')]
    [caDefaultValueString('')]
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in your bot's message.   </summary>
    ParseMode: TtgParseMode;

    [caDefaultValueBoolean(False)]
    [caName('disable_web_page_preview')]
    /// <summary>Disables link previews for links in this message</summary>
    DisableWebPagePreview: Boolean;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    DisableNotification: Boolean;
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    /// <summary>If the message is a reply, ID of the original message</summary>
    ReplyToMessageId: Int64;
    class function Default: TtgMessageArgument; static;
  end;

  [caName('forwardMessage')]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>Use this method to forward messages of any kind. On success, the sent
  /// Message is returned.</summary>
  TtgForwardMessageArgument = record
  public

    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    [caName('from_chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the chat where the original message was sent (or
    /// channel username in the format @channelusername)</summary>
    FromChatId: TtgUserLink;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    DisableNotification: Boolean;
    /// <summary>Message identifier in the chat specified in from_chat_id</summary>
    [caName('message_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    MessageId: Int64;
    class function Default: TtgForwardMessageArgument; static;
  end;

  [caName('sendPhoto')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>Use this method to send photos. On success, the sent Message is
  /// returned.</summary>
  TtgSendPhotoArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>
    /// Unique identifier for the target chat or username of the target channel (in
    /// the format @channelusername)
    /// </summary>
    ChatId: TtgUserLink;
    [caName('photo')]
    [caIsRequaired]
    [caDefaultValueStringAttribute('')]
    /// <summary>Photo to send. Pass a file_id as String to send a photo that exists on
    /// the Telegram servers (recommended), pass an HTTP URL as a String for Telegram
    /// to get a photo from the Internet, or upload a new photo using
    /// multipart/form-data. More info on Sending Files »</summary>
    Photo: TcaFileToSend;
    [caName('caption')]
    [caDefaultValueStringAttribute('')]
    /// <summary>Photo caption (may also be used when resending photos by file_id),
    /// 0-1024 characters after entities parsing</summary>
    Caption: string;
    [caName('parse_mode')]
    [caDefaultValueString('')]
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in the media caption.</summary>
    ParseMode: TtgParseMode;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    DisableNotification: Boolean;
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    /// <summary>If the message is a reply, ID of the original message</summary>
    ReplyToMessageId: Int64;
    class function Default: TtgSendPhotoArgument; static;
  end;

  [caName('sendAudio')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>Use this method to send audio files, if you want Telegram clients to
  /// display them in the music player. Your audio must be in the .MP3 or .M4A format.
  /// On success, the sent Message is returned. Bots can currently send audio files
  /// of up to 50 MB in size, this limit may be changed in the future.
  ///
  /// For sending voice messages, use the sendVoice method instead.</summary>
  TtgSendAudioArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    [caName('audio')]
    [caIsRequaired]
    [caDefaultValueStringAttribute('')]
    /// <summary>Audio file to send. Pass a file_id as String to send an audio file
    /// that exists on the Telegram servers (recommended), pass an HTTP URL as a String
    /// for Telegram to get an audio file from the Internet, or upload a new one using
    /// multipart/form-data. More info on Sending Files »</summary>
    Audio: TcaFileToSend;
    [caName('caption')]
    [caDefaultValueStringAttribute('')]
    /// <summary>Audio caption, 0-1024 characters after entities parsing</summary>
    Caption: string;
    [caName('parse_mode')]
    [caDefaultValueString('')]
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in the media caption.</summary>
    ParseMode: TtgParseMode;
    [caName('duration')]
    [caDefaultValueInt64Attribute(0)]
    /// <summary>Duration of the audio in seconds</summary>
    Duration: Int64;
    [caName('performer')]
    [caDefaultValueString('')]
    /// <summary>Performer</summary>
    Performer: string;
    [caName('title')]
    [caDefaultValueString('')]
    /// <summary>Track name</summary>
    Title: string;
    [caName('thumb')]
    [caDefaultValueStringAttribute('')]
    /// <summary>Thumbnail of the file sent; can be ignored if thumbnail generation for
    /// the file is supported server-side. The thumbnail should be in JPEG format and
    /// less than 200 kB in size. A thumbnail‘s width and height should not exceed 320.
    /// Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t
    /// be reused and can be only uploaded as a new file, so you can pass “attach:
    /// file_attach_name” if the thumbnail was uploaded using multipart/form-data
    /// under file_attach_name. More info on Sending Files »</summary>
    Thumb: TcaFileToSend;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    DisableNotification: Boolean;
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    /// <summary>If the message is a reply, ID of the original message</summary>
    ReplyToMessageId: Int64;
    class function Default: TtgSendAudioArgument; static;
  end;

  /// <summary>
  /// Use this method to send general files. On success, the sent Message is returned.
  /// Bots can currently send files of any type of up to 50 MB in size, this limit
  /// may be changed in the future.
  /// </summary>
  [caName('sendDocument')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSendDocumentArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    [caName('document')]
    [caIsRequaired]
    [caDefaultValueStringAttribute('')]
    /// <summary>Audio file to send. Pass a file_id as String to send an audio file
    /// that exists on the Telegram servers (recommended), pass an HTTP URL as a String
    /// for Telegram to get an audio file from the Internet, or upload a new one using
    /// multipart/form-data. More info on Sending Files »</summary>
    Document: TcaFileToSend;
    [caName('thumb')]
    [caDefaultValueStringAttribute('')]
    /// <summary>Thumbnail of the file sent; can be ignored if thumbnail generation for
    /// the file is supported server-side. The thumbnail should be in JPEG format and
    /// less than 200 kB in size. A thumbnail‘s width and height should not exceed 320.
    /// Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t
    /// be reused and can be only uploaded as a new file, so you can pass “attach:
    /// file_attach_name” if the thumbnail was uploaded using multipart/form-data
    /// under file_attach_name. More info on Sending Files »</summary>
    Thumb: TcaFileToSend;
    [caName('caption')]
    [caDefaultValueStringAttribute('')]
    /// <summary>
    /// Document caption (may also be used when resending documents by file_id), 0-1024
    /// characters after entities parsing
    /// </summary>
    Caption: string;
    [caName('parse_mode')]
    [caDefaultValueString('')]
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in the media caption.</summary>
    ParseMode: TtgParseMode;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    DisableNotification: Boolean;
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    /// <summary>If the message is a reply, ID of the original message</summary>
    ReplyToMessageId: Int64;
    class function Default: TtgSendDocumentArgument; static;
  end;

  /// <summary>
  /// Use this method to send video files, Telegram clients support mp4 videos (other
  /// formats may be sent as Document). On success, the sent Message is returned.
  /// Bots can currently send video files of up to 50 MB in size, this limit may be
  /// changed in the future.
  /// </summary>
  [caName('sendVideo')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.GetOrPost)]
  TtgSendVideoArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    [caName('video')]
    [caIsRequaired]
    [caDefaultValueString('')]
    /// <summary>Audio file to send. Pass a file_id as String to send an audio file
    /// that exists on the Telegram servers (recommended), pass an HTTP URL as a String
    /// for Telegram to get an audio file from the Internet, or upload a new one using
    /// multipart/form-data. More info on Sending Files »</summary>
    Video: TcaFileToSend;
    [caName('duration')]
    [caDefaultValueInt64(0)]
    /// <summary>Duration of sent video in seconds</summary>
    Duration: Int64;
    [caName('width')]
    [caDefaultValueInt64(0)]
    /// <summary>Video width</summary>
    Width: Int64;
    [caName('height')]
    [caDefaultValueInt64(0)]
    /// <summary>Video height</summary>
    Height: Int64;
    [caName('thumb')]
    [caDefaultValueString('')]
    /// <summary>Thumbnail of the file sent; can be ignored if thumbnail generation for
    /// the file is supported server-side. The thumbnail should be in JPEG format and
    /// less than 200 kB in size. A thumbnail‘s width and height should not exceed 320.
    /// Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t
    /// be reused and can be only uploaded as a new file, so you can pass “attach:
    /// file_attach_name” if the thumbnail was uploaded using multipart/form-data
    /// under file_attach_name. More info on Sending Files »</summary>
    Thumb: TcaFileToSend;
    [caName('caption')]
    [caDefaultValueString('')]
    /// <summary> Video caption (may also be used when resending videos by file_id),
    /// 0-1024 characters after entities parsing</summary>
    Caption: string;
    [caName('parse_mode')]
    [caDefaultValueString('')]
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in the media caption.</summary>
    ParseMode: TtgParseMode;
    [caName('supports_streaming')]
    [caDefaultValueBoolean(False)]
    /// <summary>Pass True, if the uploaded video is suitable for streaming</summary>
    SupportsStreaming: Boolean;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    DisableNotification: Boolean;
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    /// <summary>If the message is a reply, ID of the original message</summary>
    ReplyToMessageId: Int64;
    class function Default: TtgSendVideoArgument; static;
  end;

  [caName('sendAnimation')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>
  /// Use this method to send video files, Telegram clients support mp4 videos (other
  /// formats may be sent as Document). On success, the sent Message is returned.
  /// Bots can currently send video files of up to 50 MB in size, this limit may be
  /// changed in the future.
  /// </summary>
  TtgSendAnimationArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    [caName('animation')]
    [caIsRequaired]
    [caDefaultValueString('')]
    /// <summary>
    /// Animation to send. Pass a file_id as String to send an animation that exists on
    /// the Telegram servers (recommended), pass an HTTP URL as a String for Telegram
    /// to get an animation from the Internet, or upload a new animation using
    /// multipart/form-data. More info on Sending Files »
    /// </summary>
    Animation: TcaFileToSend;
    [caName('duration')]
    [caDefaultValueInt64(0)]
    /// <summary>Duration of sent animation in seconds</summary>
    Duration: Int64;
    [caName('width')]
    [caDefaultValueInt64(0)]
    /// <summary>Animation width</summary>
    Width: Int64;
    [caName('height')]
    [caDefaultValueInt64(0)]
    /// <summary>Animation height</summary>
    Height: Int64;
    [caName('thumb')]
    [caDefaultValueString('')]
    /// <summary>Thumbnail of the file sent; can be ignored if thumbnail generation for
    /// the file is supported server-side. The thumbnail should be in JPEG format and
    /// less than 200 kB in size. A thumbnail‘s width and height should not exceed 320.
    /// Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t
    /// be reused and can be only uploaded as a new file, so you can pass “attach:
    /// file_attach_name” if the thumbnail was uploaded using multipart/form-data
    /// under file_attach_name. More info on Sending Files »</summary>
    Thumb: TcaFileToSend;
    [caName('caption')]
    [caDefaultValueString('')]
    /// <summary> Animation caption (may also be used when resending videos by file_id),
    /// 0-1024 characters after entities parsing</summary>
    Caption: string;
    [caName('parse_mode')]
    [caDefaultValueString('')]
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in the media caption.</summary>
    ParseMode: TtgParseMode;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    DisableNotification: Boolean;
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    /// <summary>If the message is a reply, ID of the original message</summary>
    ReplyToMessageId: Int64;
    class function Default: TtgSendAnimationArgument; static;
  end;

  /// <summary> Use this method to send audio files, if you want Telegram clients to
  /// display the file as a playable voice message. For this to work, your audio must
  /// be in an .OGG file encoded with OPUS (other formats may be sent as Audio or
  /// Document). On success, the sent Message is returned. Bots can currently send
  /// voice messages of up to 50 MB in size, this limit may be changed in the future.
  /// </summary>
  [caName('sendVoice')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSendVoiceArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    [caName('voice')]
    [caIsRequaired]
    [caDefaultValueString('')]
    /// <summary>
    /// Audio file to send. Pass a file_id as String to send an animation that exists on
    /// the Telegram servers (recommended), pass an HTTP URL as a String for Telegram
    /// to get a file from the Internet, or upload a new one using
    /// multipart/form-data. More info on Sending Files »
    /// </summary>
    Voice: TcaFileToSend;
    /// <summary> Voice message caption, 0-1024 characters after entities
    /// parsing</summary>
    [caName('caption')]
    [caDefaultValueString('')]
    Caption: string;

    [caName('parse_mode')]
    [caDefaultValueString('')]
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in the media caption.</summary>
    ParseMode: TtgParseMode;
    /// <summary>Duration of the voice message in seconds</summary>
    [caName('duration')]
    [caDefaultValueInt64(0)]
    Duration: Int64;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    DisableNotification: Boolean;
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    /// <summary>If the message is a reply, ID of the original message</summary>
    ReplyToMessageId: Int64;
    class function Default: TtgSendVoiceArgument; static;
  end;

  /// <summary> Use this method to send audio files, if you want Telegram clients to
  /// display the file as a playable voice message. For this to work, your audio must
  /// be in an .OGG file encoded with OPUS (other formats may be sent as Audio or
  /// Document). On success, the sent Message is returned. Bots can currently send
  /// voice messages of up to 50 MB in size, this limit may be changed in the future.
  /// </summary>
  [caName('sendVideoNote')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSendVideoNoteArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    [caName('video_note')]
    [caIsRequaired]
    [caDefaultValueString('')]
    /// <summary>
    /// Audio file to send. Pass a file_id as String to send an animation that exists on
    /// the Telegram servers (recommended), pass an HTTP URL as a String for Telegram
    /// to get a file from the Internet, or upload a new one using
    /// multipart/form-data. More info on Sending Files »
    /// </summary>
    VideoNote: TcaFileToSend;
    /// <summary>Duration of the voice message in seconds</summary>
    [caName('duration')]
    [caDefaultValueInt64(0)]
    Duration: Int64;
    [caName('length')]
    [caDefaultValueInt64(0)]
    Length: Int64;
    [caName('thumb')]
    [caDefaultValueString('')]
    /// <summary>Thumbnail of the file sent; can be ignored if thumbnail generation for
    /// the file is supported server-side. The thumbnail should be in JPEG format and
    /// less than 200 kB in size. A thumbnail‘s width and height should not exceed 320.
    /// Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t
    /// be reused and can be only uploaded as a new file, so you can pass “attach:
    /// file_attach_name” if the thumbnail was uploaded using multipart/form-data
    /// under file_attach_name. More info on Sending Files »</summary>
    Thumb: TcaFileToSend;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    DisableNotification: Boolean;
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    /// <summary>If the message is a reply, ID of the original message</summary>
    ReplyToMessageId: Int64;
    class function Default: TtgSendVideoNoteArgument; static;
  end;

  [caName('SendMediaGroup')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSendMediaGroupArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    [caName('media')]
    [caIsRequaired]
    [caDefaultValueString('')]
    /// <summary>
    /// Audio file to send. Pass a file_id as String to send an animation that exists on
    /// the Telegram servers (recommended), pass an HTTP URL as a String for Telegram
    /// to get a file from the Internet, or upload a new one using
    /// multipart/form-data. More info on Sending Files »
    /// </summary>
    media: TArray<TcaFileToSend>;

    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    DisableNotification: Boolean;
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    /// <summary>If the message is a reply, ID of the original message</summary>
    ReplyToMessageId: Int64;
    class function Default: TtgSendMediaGroupArgument; static;
  end;

  [caName('getUpdates')]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>
  /// Use this method to send video files, Telegram clients support mp4 videos (other
  /// formats may be sent as Document). On success, the sent Message is returned.
  /// Bots can currently send video files of up to 50 MB in size, this limit may be
  /// changed in the future.
  /// </summary>
  TtgGetUpdatesArgument = record
  public
    [caName('offset')]
    [caDefaultValueInt64(0)]
    /// <summary>Identifier of the first update to be returned. Must be greater by one
    /// than the highest among the identifiers of previously received updates. By
    /// default, updates starting with the earliest unconfirmed update are returned. An
    /// update is considered confirmed as soon as getUpdates is called with an offset
    /// higher than its update_id. The negative offset can be specified to retrieve
    /// updates starting from -offset update from the end of the updates queue. All
    /// previous updates will forgotten.</summary>
    Offset: Int64;
    /// <summary>
    /// Limits the number of updates to be retrieved. Values between 1—100 are accepted.
    /// Defaults to 100.</summary>
    [caName('limit')]
    [caDefaultValueInt64(100)]
    Limit: Int64;
    [caName('timeout')]
    [caDefaultValueInt64(0)]
    /// <summary>
    /// Timeout in seconds for long polling. Defaults to 0, i.e. usual short polling.
    /// Should be positive, short polling should be used for testing purposes only.
    /// </summary>
    Timeout: Int64;
    [caName('allowed_updates')]
    [caDefaultValueString('')]
    /// <summary>A JSON-serialized list of the update types you want your bot to
    /// receive. For example, specify [“message”, “edited_channel_post”,
    /// “callback_query”] to only receive updates of these types. See Update for a
    /// complete list of available update types. Specify an empty list to receive all
    /// updates regardless of type (default). If not specified, the previous setting
    /// will be used.
    ///
    /// Please note that this parameter doesn't affect updates created before the call
    /// to the getUpdates, so unwanted updates may be received for a short period of
    /// time.</summary>
    AllowedUpdates: TAllowedUpdates;
    class function Default: TtgGetUpdatesArgument; static;
  end;

  [caName('getChat')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.GetOrPost)]
  TtgGetChatArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    class function Default: TtgGetChatArgument; static;
  end;

implementation

class function TtgMessageArgument.Default: TtgMessageArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
  Result.Text := '';
  Result.ParseMode := TtgParseMode.Default;
  Result.DisableWebPagePreview := False;
  Result.DisableNotification := False;
  Result.ReplyToMessageId := 0;
  Result.ChatId := 0;
end;

{ TtgForwardMessageArgument }

class function TtgForwardMessageArgument.Default: TtgForwardMessageArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
  Result.FromChatId := TtgUserLink.Empty;
  Result.DisableNotification := False;
  Result.MessageId := 0;
end;

{ TtgSendPhotoArgument }

class function TtgSendPhotoArgument.Default: TtgSendPhotoArgument;
begin
  Result.ChatId := 0;
  Result.Photo := TcaFileToSend.Empty;
  Result.Caption := '';
  Result.ParseMode := TtgParseMode.Default;
  Result.DisableNotification := False;
  Result.ReplyToMessageId := 0;
end;

{ TtgGetMeArgument }

class function TtgGetMeArgument.Default: TtgGetMeArgument;
begin

end;

{ TtgSendAudioArgument }

class function TtgSendAudioArgument.Default: TtgSendAudioArgument;
begin
  Result.ChatId := 0;
  Result.Audio := TcaFileToSend.Empty;
  Result.Caption := '';
  Result.ParseMode := TtgParseMode.Default;
  Result.Duration := 0;
  Result.Performer := '';
  Result.Title := '';
  Result.Thumb := TcaFileToSend.Empty;
  Result.DisableNotification := False;
  Result.ReplyToMessageId := 0;
end;

{ TtgSendDocumentArgument }

class function TtgSendDocumentArgument.Default: TtgSendDocumentArgument;
begin
  Result.ChatId := 0;
  Result.Document := TcaFileToSend.Empty;
  Result.Caption := '';
  Result.ParseMode := TtgParseMode.Default;
  Result.Thumb := TcaFileToSend.Empty;
  Result.DisableNotification := False;
  Result.ReplyToMessageId := 0;
end;

{ TtgSendVideoArgument }

class function TtgSendVideoArgument.Default: TtgSendVideoArgument;
begin
  Result.ChatId := 0;
  Result.Video := TcaFileToSend.Empty;
  Result.Duration := 0;
  Result.Width := 0;
  Result.Height := 0;
  Result.Thumb := TcaFileToSend.Empty;
  Result.Caption := '';
  Result.ParseMode := TtgParseMode.Default;
  Result.SupportsStreaming := False;
  Result.DisableNotification := False;
  Result.ReplyToMessageId := 0;
end;

{ TtgSendAnimationArgument }

class function TtgSendAnimationArgument.Default: TtgSendAnimationArgument;
begin
  Result.ChatId := 0;
  Result.Animation := TcaFileToSend.Empty;
  Result.Duration := 0;
  Result.Width := 0;
  Result.Height := 0;
  Result.Thumb := TcaFileToSend.Empty;
  Result.Caption := '';
  Result.ParseMode := TtgParseMode.Default;
  Result.DisableNotification := False;
  Result.ReplyToMessageId := 0;
end;

{ TtgGetUpdatesArgument }

class function TtgGetUpdatesArgument.Default: TtgGetUpdatesArgument;
begin
  Result.Offset := 0;
  Result.Limit := 100;
  Result.Timeout := 0;
  Result.AllowedUpdates := UPDATES_ALLOWED_ALL;
end;

{ TtgSendVoiceArgument }

class function TtgSendVoiceArgument.Default: TtgSendVoiceArgument;
begin
  Result.ChatId := 0;
  Result.Voice := TcaFileToSend.Empty;
  Result.Duration := 0;
  Result.Caption := '';
  Result.ParseMode := TtgParseMode.Default;
  Result.DisableNotification := False;
  Result.ReplyToMessageId := 0;
end;

{ TtgSendVideoNoteArgument }

class function TtgSendVideoNoteArgument.Default: TtgSendVideoNoteArgument;
begin
  Result.ChatId := 0;
  Result.VideoNote := TcaFileToSend.Empty;
  Result.Duration := 0;
  Result.Length := 0;
  Result.Thumb := TcaFileToSend.Empty;
  Result.DisableNotification := False;
  Result.ReplyToMessageId := 0;
end;

{ TtgSendMediaGroupArgument }

class function TtgSendMediaGroupArgument.Default: TtgSendMediaGroupArgument;
begin

end;

{ TtgGetChatArgument }

class function TtgGetChatArgument.Default: TtgGetChatArgument;
begin
  Result.ChatId := 0;
end;

end.
