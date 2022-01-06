unit TelegramBotApi.Types.AvailableMethods;

interface

uses
  CloudAPI.Attributes,
  CloudAPI.Types,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Abstract,
  TelegramBotApi.Types.Enums;

type

  [caName('sendMessage')]
  [caParameterType(TcaParameterType.GetOrPost)]
  [caMethod(TcaMethod.POST)]
  /// <summary>Use this method to send text messages.
  /// On success, the sent Message is returned.
  /// </summary>
  TtgSendMessageArgument = class(TtgSendMessageBaseWithParseMode)
  private
    [caName('text')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FText: string;
    [caName('entities')]
    [caDefaultValueString('[]')]
    FEntities: TArray<TtgMessageEntity>;
    [caDefaultValueBoolean(False)]
    [caName('disable_web_page_preview')]
    FDisableWebPagePreview: Boolean;
    [caDefaultValueBoolean(False)]
    [caName('protect_content')]
    FProtectContent: Boolean;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>Text of the message to be sent, 1-4096 characters after entities
    /// parsing</summary>
    property Text: string read FText write FText;
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in your bot's message.   </summary>
    property ParseMode;
    /// <summary>
    /// List of special entities that appear in message text, which can be specified
    /// instead of parse_mode
    /// </summary>
    property Entities: TArray<TtgMessageEntity> read FEntities write FEntities;
    /// <summary>Disables link previews for links in this message</summary>
    property DisableWebPagePreview: Boolean read FDisableWebPagePreview write FDisableWebPagePreview;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification;
    /// <summary>If the message is a reply, ID of the original message</summary>
    property ReplyToMessageId;
    /// <summary>
    /// Pass True, if the message should be sent even if the specified replied-to
    /// message is not found
    /// </summary>
    property AllowSendingWithoutReply;
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
    constructor Create; override;
  end;

  [caName('sendChatAction')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary> Use this method when you need to tell the user that something is
  /// happening on the bot's side. The status is set for 5 seconds or less (when a
  /// message arrives from your bot, Telegram clients clear its typing status).
  /// Returns True on success.</summary>
  /// <remarks>
  /// We only recommend using this method when a response from the bot will take a
  /// noticeable amount of time to arrive.
  /// </remarks>
  TtgSendChatActionArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caName('action')]
    [caDefaultValueString('')]
    [caIsRequaired]
    fAction: TtgChatAction;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    /// <summary> Type of action to broadcast. Choose one, depending on what the user is
    /// about to receive: typing for text messages, upload_photo for photos,
    /// record_video or upload_video for videos, record_audio or upload_audio for audio
    /// files, upload_document for general files, find_location for location data,
    /// record_video_note or upload_video_note for video notes.</summary>
    property Action: TtgChatAction read fAction write fAction;
    constructor Create(AChatId: TtgUserLink; AAction: TtgChatAction = TtgChatAction.Typing);
  end;

  [caName('sendPhoto')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.GetOrPost)]
  /// <summary>Use this method to send photos. On success, the sent Message is
  /// returned.</summary>
  TtgSendPhotoArgument = class(TtgSendMediaAbstractArgument)
  private
    [caName('photo')]
    [caIsRequaired]
    [caDefaultValueStringAttribute('')]
    fPhoto: TcaFileToSend;
    [caDefaultValueBoolean(False)]
    [caName('protect_content')]
    FProtectContent: Boolean;
  public
    constructor Create; override;
    /// <summary>
    /// Unique identifier for the target chat or username of the target channel (in
    /// the format @channelusername)
    /// </summary>
    property ChatId;
    /// <summary>Photo to send. Pass a file_id as String to send a photo that exists on
    /// the Telegram servers (recommended), pass an HTTP URL as a String for Telegram
    /// to get a photo from the Internet, or upload a new photo using
    /// multipart/form-data. More info on Sending Files »</summary>
    property Photo: TcaFileToSend read fPhoto write fPhoto;
    /// <summary>Photo caption (may also be used when resending photos by file_id),
    /// 0-1024 characters after entities parsing</summary>
    property Caption;
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in the media caption.</summary>
    property ParseMode;
    /// <summary> List of special entities that appear in the new caption, which can be
    /// specified instead of parse_mode
    /// </summary>
    property CaptionEntities;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification;
    /// <summary>If the message is a reply, ID of the original message</summary>
    property ReplyToMessageId;
    /// <summary>
    /// Pass True, if the message should be sent even if the specified replied-to
    /// message is not found
    /// </summary>
    property AllowSendingWithoutReply;
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
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
  TtgSendVideoArgument = class(TtgSendVideoOrAnimationArgument)
  private
    [caName('video')]
    [caIsRequaired]
    [caDefaultValueString('')]
    fVideo: TcaFileToSend;
  public
    constructor Create; override;
    /// <summary>Audio file to send. Pass a file_id as String to send an audio file
    /// that exists on the Telegram servers (recommended), pass an HTTP URL as a String
    /// for Telegram to get an audio file from the Internet, or upload a new one using
    /// multipart/form-data. More info on Sending Files »</summary>
    property Video: TcaFileToSend read fVideo write fVideo;
  end;

  [caName('sendAnimation')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.GetOrPost)]
  /// <summary>
  /// Use this method to send video files, Telegram clients support mp4 videos (other
  /// formats may be sent as Document). On success, the sent Message is returned.
  /// Bots can currently send video files of up to 50 MB in size, this limit may be
  /// changed in the future.
  /// </summary>
  TtgSendAnimationArgument = class(TtgSendVideoOrAnimationArgument)
  private
    [caName('animation')]
    [caIsRequaired]
    [caDefaultValueString('')]
    fAnimation: TcaFileToSend;
  public
    constructor Create; override;
    /// <summary>
    /// Animation to send. Pass a file_id as String to send an animation that exists on
    /// the Telegram servers (recommended), pass an HTTP URL as a String for Telegram
    /// to get an animation from the Internet, or upload a new animation using
    /// multipart/form-data. More info on Sending Files »
    /// </summary>
    property Animation: TcaFileToSend read fAnimation write fAnimation;
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
  TtgSendVoiceArgument = class(TtgSendMediaAbstractArgument)
  private
    [caName('voice')]
    [caIsRequaired]
    [caDefaultValueStringAttribute('')]
    fVoice: TcaFileToSend;
    [caName('duration')]
    [caDefaultValueInt64Attribute(0)]
    fDuration: Int64;
  public
    constructor Create; override;
    /// <summary>
    /// Unique identifier for the target chat or username of the target channel (in
    /// the format @channelusername)
    /// </summary>
    property ChatId;
    /// <summary>Audio file to send. Pass a file_id as String to send an audio file
    /// that exists on the Telegram servers (recommended), pass an HTTP URL as a String
    /// for Telegram to get an audio file from the Internet, or upload a new one using
    /// multipart/form-data. More info on Sending Files »</summary>
    property Voice: TcaFileToSend read fVoice write fVoice;
    /// <summary>Audio caption,
    /// 0-1024 characters after entities parsing</summary>
    property Caption;
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in the media caption.</summary>
    property ParseMode;
    /// <summary> List of special entities that appear in the new caption, which can be
    /// specified instead of parse_mode
    /// </summary>
    property CaptionEntities;
    /// <summary>Duration of the audio in seconds</summary>
    property Duration: Int64 read fDuration write fDuration;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification;
    /// <summary>If the message is a reply, ID of the original message</summary>
    property ReplyToMessageId;
    /// <summary>
    /// Pass True, if the message should be sent even if the specified replied-to
    /// message is not found
    /// </summary>
    property AllowSendingWithoutReply;
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
  TtgSendAudioArgument = class(TtgSendVoiceArgument)
  private
    [caName('thumb')]
    [caDefaultValueStringAttribute('')]
    fThumb: TcaFileToSend;
    [caName('audio')]
    [caIsRequaired]
    [caDefaultValueStringAttribute('')]
    fAudio: TcaFileToSend;
    [caName('performer')]
    [caDefaultValueString('')]
    fPerformer: string;
    [caName('title')]
    [caDefaultValueString('')]
    fTitle: string;
    [caName('protect_content')]
    FProtectContent: Boolean;
  public
    constructor Create; override;
    /// <summary>
    /// Unique identifier for the target chat or username of the target channel (in
    /// the format @channelusername)
    /// </summary>
    property ChatId;
    /// <summary>Audio file to send. Pass a file_id as String to send an audio file
    /// that exists on the Telegram servers (recommended), pass an HTTP URL as a String
    /// for Telegram to get an audio file from the Internet, or upload a new one using
    /// multipart/form-data. More info on Sending Files »</summary>
    property Audio: TcaFileToSend read fAudio write fAudio;
    /// <summary>Audio caption,
    /// 0-1024 characters after entities parsing</summary>
    property Caption;
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in the media caption.</summary>
    property ParseMode;
    /// <summary> List of special entities that appear in the new caption, which can be
    /// specified instead of parse_mode
    /// </summary>
    property CaptionEntities;
    /// <summary>Duration of the audio in seconds</summary>
    property Duration;
    /// <summary>Performer</summary>
    property Performer: string read fPerformer write fPerformer;
    /// <summary>Track name</summary>
    property Title: string read fTitle write fTitle;
    /// <summary>Thumbnail of the file sent; can be ignored if thumbnail generation for
    /// the file is supported server-side. The thumbnail should be in JPEG format and
    /// less than 200 kB in size. A thumbnail‘s width and height should not exceed 320.
    /// Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t
    /// be reused and can be only uploaded as a new file, so you can pass “attach:
    /// file_attach_name” if the thumbnail was uploaded using multipart/form-data
    /// under file_attach_name. More info on Sending Files »</summary>
    property Thumb: TcaFileToSend read fThumb write fThumb;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification;
    /// <summary>If the message is a reply, ID of the original message</summary>
    property ReplyToMessageId;
    /// <summary>
    /// Pass True, if the message should be sent even if the specified replied-to
    /// message is not found
    /// </summary>
    property AllowSendingWithoutReply;
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
  end;

  /// <summary>
  /// Use this method to send general files. On success, the sent Message is returned.
  /// Bots can currently send files of any type of up to 50 MB in size, this limit
  /// may be changed in the future.
  /// </summary>
  [caName('sendDocument')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSendDocumentArgument = class(TtgSendMediaWithThumbAbstractArgument)
  private
    [caName('document')]
    [caIsRequaired]
    [caDefaultValueString('')]
    fDocument: TcaFileToSend;
    [caName('disable_content_type_detection')]
    [caDefaultValueBoolean(False)]
    FDisableContentTypeDetection: Boolean;
    [caName('protect_content')]
    FProtectContent: Boolean;
  public
    constructor Create; override;
    /// <summary>
    /// Unique identifier for the target chat or username of the target channel (in
    /// the format @channelusername)
    /// </summary>
    property ChatId;
    /// <summary>File to send. Pass a file_id as String to send a file that exists on
    /// the Telegram servers (recommended), pass an HTTP URL as a String for Telegram
    /// to get a file from the Internet, or upload a new one using multipart/form-data..
    /// More info on Sending Files »</summary>
    property Document: TcaFileToSend read fDocument write fDocument;
    /// <summary>Thumbnail of the file sent; can be ignored if thumbnail generation for
    /// the file is supported server-side. The thumbnail should be in JPEG format and
    /// less than 200 kB in size. A thumbnail‘s width and height should not exceed 320.
    /// Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t
    /// be reused and can be only uploaded as a new file, so you can pass “attach:
    /// file_attach_name” if the thumbnail was uploaded using multipart/form-data
    /// under file_attach_name. More info on Sending Files »</summary>
    property Thumb;
    /// <summary>Document caption (may also be used when resending documents by file_id)
    /// , 0-1024 characters after entities parsing</summary>
    property Caption;
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in the media caption.</summary>
    property ParseMode;
    /// <summary> List of special entities that appear in the new caption, which can be
    /// specified instead of parse_mode
    /// </summary>
    property CaptionEntities;
    /// <summary>
    /// Disables automatic server-side content type detection for files uploaded using
    /// multipart/form-data
    /// </summary>
    property DisableContentTypeDetection: Boolean read FDisableContentTypeDetection write FDisableContentTypeDetection;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification;
    /// <summary>If the message is a reply, ID of the original message</summary>
    property ReplyToMessageId;
    /// <summary>
    /// Pass True, if the message should be sent even if the specified replied-to
    /// message is not found
    /// </summary>
    property AllowSendingWithoutReply;
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
  end;

  /// <summary>
  /// Use this method to send static .WEBP or animated .TGS stickers. On success, the sent Message is returned.
  /// </summary>
  [caName('sendSticker')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSendStickerArgument = class(TtgSendMessageBase)
  private
    [caName('sticker')]
    [caIsRequaired]
    [caDefaultValueString('')]
    fSticker: TcaFileToSend;
    [caName('disable_content_type_detection')]
    [caDefaultValueBoolean(False)]
    FDisableContentTypeDetection: Boolean;
    [caName('protect_content')]
    FProtectContent: Boolean;
  public
    constructor Create; override;
    /// <summary>
    /// Unique identifier for the target chat or username of the target channel (in
    /// the format @channelusername)
    /// </summary>
    property ChatId;
    /// <summary>Sticker to send. Pass a file_id as String to send a file that exists on
    /// the Telegram servers (recommended), pass an HTTP URL as a String for Telegram
    /// to get a file from the Internet, or upload a new one using multipart/form-data..
    /// More info on Sending Files »</summary>
    property Sticker: TcaFileToSend read fSticker write fSticker;
    /// <summary>
    /// Disables automatic server-side content type detection for files uploaded using
    /// multipart/form-data
    /// </summary>
    property DisableContentTypeDetection: Boolean read FDisableContentTypeDetection write FDisableContentTypeDetection;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification;
    /// <summary>If the message is a reply, ID of the original message</summary>
    property ReplyToMessageId;
    /// <summary>
    /// Pass True, if the message should be sent even if the specified replied-to
    /// message is not found
    /// </summary>
    property AllowSendingWithoutReply;
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
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
  private
    [caName('protect_content')]
    FProtectContent: Boolean;
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
  public
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
    class function Default: TtgSendVideoNoteArgument; static;
  end;

implementation

{ TtgSendMessageArgument }

constructor TtgSendMessageArgument.Create;
begin
  inherited Create();
  FText := '';
  FEntities := nil;
  FDisableWebPagePreview := False;
  FProtectContent := False;
end;

{ TtgSendChatActionArgument }

constructor TtgSendChatActionArgument.Create(AChatId: TtgUserLink; AAction: TtgChatAction = TtgChatAction.Typing);
begin
  FChatId := AChatId;
  fAction := AAction;
end;

{ TtgSendPhotoArgument }

constructor TtgSendPhotoArgument.Create;
begin
  inherited Create();
  fPhoto := TcaFileToSend.Empty;
  FProtectContent := False;
  ProtectContent := False;
end;

{ TtgSendVideoArgument }

constructor TtgSendVideoArgument.Create;
begin
  inherited Create();
  Video := TcaFileToSend.Empty;
  ProtectContent := False;
end;

{ TtgSendAnimationArgument }

constructor TtgSendAnimationArgument.Create;
begin
  inherited Create();
  fAnimation := TcaFileToSend.Empty;
  ProtectContent := False;
end;

{ TtgSendVoiceArgument }

constructor TtgSendVoiceArgument.Create;
begin
  inherited Create();
  fVoice := TcaFileToSend.Empty;
  fDuration := 0;
end;

{ TtgSendAudioArgument }

constructor TtgSendAudioArgument.Create;
begin
  inherited Create();
  fAudio := TcaFileToSend.Empty;
  fDuration := 0;
  fPerformer := '';
  fTitle := '';
  fThumb := TcaFileToSend.Empty;
  FProtectContent := False;
end;

{ TtgSendDocumentArgument }

constructor TtgSendDocumentArgument.Create;
begin
  inherited Create();
  fDocument := TcaFileToSend.Empty;
  Thumb := TcaFileToSend.Empty;
  FDisableContentTypeDetection := False;
  FProtectContent := False;
end;

{ TtgSendStickerArgument }

constructor TtgSendStickerArgument.Create;
begin
  inherited Create();
  fSticker := TcaFileToSend.Empty;
  FDisableContentTypeDetection := False;
  FProtectContent := False;
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
  Result.ProtectContent := False;
end;

end.
