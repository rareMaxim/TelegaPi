unit TelegramBotApi.Types.Request;

interface

uses
  CloudAPI.Attributes,
  CloudAPI.Types,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Enums;

type
  TtgEmptyArgument = class(TInterfacedObject);

  [caName('getMe')]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>
  /// A simple method for testing your bot's auth token.
  /// Requires no parameters.
  /// Returns basic information about the bot in form of a User object.
  /// </summary>
  TtgGetMeArgunentNew = class(TtgEmptyArgument);

  TtgMessageAbstract = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    fChatId: TtgUserLink;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    fDisableNotification: Boolean;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read fChatId write fChatId;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification: Boolean read fDisableNotification write fDisableNotification;
  end;

  TtgSendMessageBase = class(TtgMessageAbstract)
  private
    [caName('parse_mode')]
    [caDefaultValueString('')]
    fParseMode: TtgParseMode;
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    fReplyToMessageId: Int64;
    [caName('allow_sending_without_reply')]
    [caDefaultValueBoolean(False)]
    fAllowSendingWithoutReply: Boolean;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in your bot's message.   </summary>
    property ParseMode: TtgParseMode read fParseMode write fParseMode;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification;
    /// <summary>If the message is a reply, ID of the original message</summary>
    property ReplyToMessageId: Int64 read fReplyToMessageId write fReplyToMessageId;
    /// <summary>
    /// Pass True, if the message should be sent even if the specified replied-to
    /// message is not found
    /// </summary>
    property AllowSendingWithoutReply: Boolean read fAllowSendingWithoutReply write fAllowSendingWithoutReply;
    constructor Create; override;
    destructor Destroy; override;
  end;

  [caName('sendMessage')]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>Use this method to send text messages.
  /// On success, the sent Message is returned.
  /// </summary>
  TtgMessageArgument = class(TtgSendMessageBase)
  private
    [caName('text')]
    [caIsRequaired]
    [caDefaultValueString('')]
    fText: string;
    [caName('entities')]
    [caDefaultValueString('[]')]
    fEntities: TArray<TtgMessageEntity>;
    [caDefaultValueBoolean(False)]
    [caName('disable_web_page_preview')]
    fDisableWebPagePreview: Boolean;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>Text of the message to be sent, 1-4096 characters after entities
    /// parsing</summary>
    property Text: string read fText write fText;
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in your bot's message.   </summary>
    property ParseMode;
    /// <summary>
    /// List of special entities that appear in message text, which can be specified
    /// instead of parse_mode
    /// </summary>
    property Entities: TArray<TtgMessageEntity> read fEntities write fEntities;
    /// <summary>Disables link previews for links in this message</summary>
    property DisableWebPagePreview: Boolean read fDisableWebPagePreview write fDisableWebPagePreview;
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
    constructor Create; override;
    destructor Destroy; override;
  end;

  [caName('forwardMessage')]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>Use this method to forward messages of any kind. On success, the sent
  /// Message is returned.</summary>
  TtgForwardMessageArgument = class(TtgMessageAbstract)
  private
    [caName('from_chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    fFromChatId: TtgUserLink;
    [caName('message_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    fMessageId: Int64;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>Unique identifier for the chat where the original message was sent (or
    /// channel username in the format @channelusername)</summary>
    property FromChatId: TtgUserLink read fFromChatId write fFromChatId;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification;
    /// <summary>Message identifier in the chat specified in from_chat_id</summary>
    property MessageId: Int64 read fMessageId write fMessageId;
    constructor Create; override;
    destructor Destroy; override;
  end;

  [caName('copyMessage')]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>Use this method to send text messages.
  /// On success, the sent Message is returned.
  /// </summary>
  TtgCopyMessageArgument = class(TtgSendMessageBase)
  private
    [caName('from_chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    fFromChatId: TtgUserLink;
    [caName('message_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    fMessageId: Int64;
    [caName('caption')]
    [caDefaultValueStringAttribute('')]
    fCaption: string;
    [caName('caption_entities')]
    [caDefaultValueString('[]')]
    fCaptionEntities: TArray<TtgMessageEntity>;
  public
    constructor Create; override;
    destructor Destroy; override;
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property FromChatId: TtgUserLink read fFromChatId write fFromChatId;
    /// <summary>Message identifier in the chat specified in from_chat_id</summary>
    property MessageId: Int64 read fMessageId write fMessageId;
    /// <summary>New caption for media, 0-1024 characters after entities parsing. If
    /// not specified, the original caption is kept
    /// </summary>
    property Caption: string read fCaption write fCaption;
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in your bot's message.   </summary>
    property ParseMode;
    /// <summary> List of special entities that appear in the new caption, which can be
    /// specified instead of parse_mode
    /// </summary>
    property CaptionEntities: TArray<TtgMessageEntity> read fCaptionEntities write fCaptionEntities;
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

  TtgSendMediaAbstractArgument = class(TtgSendMessageBase)
  private
    [caName('caption')]
    [caDefaultValueStringAttribute('')]
    fCaption: string;
    [caName('caption_entities')]
    [caDefaultValueString('[]')]
    fCaptionEntities: TArray<TtgMessageEntity>;
  public
    constructor Create; override;
    destructor Destroy; override;
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>Caption, 0-1024 characters after entities parsing</summary>
    property Caption: string read fCaption write fCaption;
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in your bot's message.   </summary>
    property ParseMode;
    /// <summary> List of special entities that appear in the new caption, which can be
    /// specified instead of parse_mode
    /// </summary>
    property CaptionEntities: TArray<TtgMessageEntity> read fCaptionEntities write fCaptionEntities;
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
    procedure SetReplyToMessageId(const Value: Int64);
  public
    constructor Create; override;
    destructor Destroy; override;
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
  TtgSendAudioArgument = class(TtgSendMediaAbstractArgument)
  private
    [caName('audio')]
    [caIsRequaired]
    [caDefaultValueStringAttribute('')]
    fAudio: TcaFileToSend;
    [caName('duration')]
    [caDefaultValueInt64Attribute(0)]
    fDuration: Int64;
    [caName('performer')]
    [caDefaultValueString('')]
    fPerformer: string;
    [caName('title')]
    [caDefaultValueString('')]
    fTitle: string;
    [caName('thumb')]
    [caDefaultValueStringAttribute('')]
    fThumb: TcaFileToSend;
  public
    constructor Create; override;
    destructor Destroy; override;
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
    property Duration: Int64 read fDuration write fDuration;
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
  end;

  /// <summary>
  /// Use this method to send general files. On success, the sent Message is returned.
  /// Bots can currently send files of any type of up to 50 MB in size, this limit
  /// may be changed in the future.
  /// </summary>
  [caName('sendDocument')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSendDocumentArgument = class(TtgSendMediaAbstractArgument)
  private
    [caName('document')]
    [caIsRequaired]
    [caDefaultValueString('')]
    fDocument: TcaFileToSend;
    [caName('thumb')]
    [caDefaultValueString('')]
    fThumb: TcaFileToSend;
    [caName('disable_content_type_detection')]
    [caDefaultValueBoolean(False)]
    FDisableContentTypeDetection: Boolean;
  public
    constructor Create; override;
    destructor Destroy; override;
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
    property Thumb: TcaFileToSend read fThumb write fThumb;
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

  /// <summary>
  /// Use this method to send phone contacts. On success, the sent Message is returned.
  /// </summary>
  [caName('sendContact')]
  [caParameterType(TcaParameterType.GetOrPost)]
  TtgSendContactArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    [caName('phone_number')]
    [caIsRequaired]
    [caDefaultValueString('')]
    /// <summary>Contact's phone number</summary>
    PhoneNumber: string;
    [caName('first_name')]
    [caIsRequaired]
    [caDefaultValueString('')]
    /// <summary>Contact's first name</summary>
    FirstName: string;
    [caName('last_name')]
    [caDefaultValueString('')]
    /// <summary>Contact's last name</summary>
    LastName: string;
    [caName('vcard')]
    [caDefaultValueString('')]
    /// <summary>Additional data about the contact in the form of a vCard, 0-2048 bytes</summary>
    VCard: string;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    DisableNotification: Boolean;
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    /// <summary>If the message is a reply, ID of the original message</summary>
    ReplyToMessageId: Int64;
    class function Default: TtgSendContactArgument; static;
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

  /// <summary>
  /// </summary>
  [caName('sendVenue')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSendVenueArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    [caName('latitude')]
    [caIsRequaired]
    [caDefaultValueSingle(0)]
    /// <summary>
    /// Latitude of the venue
    /// </summary>
    Latitude: Single;
    [caName('longitude')]
    [caIsRequaired]
    [caDefaultValueSingle(0)]
    /// <summary>
    /// Longitude of the venue
    /// </summary>
    Longitude: Single;

    [caName('title')]
    [caIsRequaired]
    [caDefaultValueString('')]
    /// <summary>
    /// Name of the venue
    /// </summary>
    Title: string;

    [caName('address')]
    [caIsRequaired]
    [caDefaultValueString('')]
    /// <summary>
    /// Address of the venue
    /// </summary>
    Address: string;

    [caName('foursquare_id')]
    [caDefaultValueString('')]
    /// <summary>
    /// Foursquare identifier of the venue
    /// </summary>
    FoursquareId: string;

    [caName('foursquare_type')]
    [caDefaultValueString('')]
    /// <summary>
    /// Foursquare type of the venue, if known.
    /// (For example, “arts_entertainment/default”, “arts_entertainment/aquarium”
    /// or “food/icecream”.)
    /// </summary>
    FoursquareType: string;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    DisableNotification: Boolean;
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    /// <summary>If the message is a reply, ID of the original message</summary>
    ReplyToMessageId: Int64;
    class function Default: TtgSendVenueArgument; static;
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
    [caParameterType(TcaParameterType.GetOrPost)]
    /// <summary>
    /// Audio file to send. Pass a file_id as String to send an animation that exists on
    /// the Telegram servers (recommended), pass an HTTP URL as a String for Telegram
    /// to get a file from the Internet, or upload a new one using
    /// multipart/form-data. More info on Sending Files »
    /// </summary>
    Media: TArray<TtgInputMedia>;
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

  /// <summary> Use this method to send point on the map. On success, the sent
  /// Message is returned.
  /// </summary>
  [caName('sendLocation')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSendLocationArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    [caName('latitude')]
    [caIsRequaired]
    [caDefaultValueSingle(0.0)]
    /// <summary> Latitude of the location</summary>
    Latitude: Single;
    [caName('longitude')]
    [caIsRequaired]
    [caDefaultValueSingle(0.0)]
    /// <summary> Longitude of the location</summary>
    Longitude: Single;
    /// <summary>Period in seconds for which the location will be updated (see Live
    /// Locations, should be between 60 and 86400.</summary>
    [caName('live_period')]
    [caDefaultValueInt64(0)]
    LivePeriod: Int64;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    DisableNotification: Boolean;
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    /// <summary>If the message is a reply, ID of the original message</summary>
    ReplyToMessageId: Int64;
    class function Default: TtgSendLocationArgument; static;
  end;

  [caName('editMessageLiveLocation')]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>Use this method to edit live location messages. A location can be
  /// edited until its live_period expires or editing is explicitly disabled by a
  /// call to stopMessageLiveLocation. On success, if the edited message was sent by
  /// the bot, the edited Message is returned, otherwise True is returned.</summary>
  TtgEditMessageLiveLocationHaveInlineMessageIDArgument = record
  public
    [caName('inline_message_id')]
    [caIsRequaired]
    [caDefaultValueString('')]
    /// <summary>If the message is a reply, ID of the original message</summary>
    InlineMessageID: Int64;
    [caName('latitude')]
    [caIsRequaired]
    [caDefaultValueSingle(0.0)]
    /// <summary> Latitude of the location</summary>
    Latitude: Single;
    [caName('longitude')]
    [caIsRequaired]
    [caDefaultValueSingle(0.0)]
    /// <summary> Longitude of the location</summary>
    Longitude: Single;
    class function Default: TtgEditMessageLiveLocationHaveInlineMessageIDArgument; static;
  end;

  [caName('editMessageLiveLocation')]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>Use this method to edit live location messages. A location can be
  /// edited until its live_period expires or editing is explicitly disabled by a
  /// call to stopMessageLiveLocation. On success, if the edited message was sent by
  /// the bot, the edited Message is returned, otherwise True is returned.</summary>
  TtgEditMessageLiveLocationArgument = record
  public
    /// <summary>Required if inline_message_id is not specified. Unique identifier for
    /// the target chat or username of the target channel (in the format
    /// @channelusername)</summary>
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    ChatId: TtgUserLink;
    /// <summary>Required if inline_message_id is not specified. Identifier of the
    /// message to edit</summary>
    [caName('message_id')]
    [caDefaultValueInt64(0)]
    MessageId: Int64;
    [caName('latitude')]
    [caIsRequaired]
    [caDefaultValueSingle(0.0)]
    /// <summary> Latitude of the location</summary>
    Latitude: Single;
    [caName('longitude')]
    [caIsRequaired]
    [caDefaultValueSingle(0.0)]
    /// <summary> Longitude of the location</summary>
    Longitude: Single;
    class function Default: TtgEditMessageLiveLocationArgument; static;
  end;

  /// <summary>Use this method to stop updating a live location message before
  /// live_period expires. On success, if the message was sent by the bot, the sent
  /// Message is returned, otherwise True is returned.</summary>
  [caName('stopMessageLiveLocation')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgStopMessageLiveLocationHaveInlineMessageIDArgument = record
  public
    [caName('inline_message_id')]
    [caIsRequaired]
    [caDefaultValueString('')]
    /// <summary>If the message is a reply, ID of the original message</summary>
    InlineMessageID: Int64;
    class function Default: TtgStopMessageLiveLocationHaveInlineMessageIDArgument; static;
  end;

  /// <summary>Use this method to stop updating a live location message before
  /// live_period expires. On success, if the message was sent by the bot, the sent
  /// Message is returned, otherwise True is returned.</summary>
  [caName('stopMessageLiveLocation')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgStopMessageLiveLocationArgument = record
  public
    /// <summary>Required if inline_message_id is not specified. Unique identifier for
    /// the target chat or username of the target channel (in the format
    /// @channelusername)</summary>
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    ChatId: TtgUserLink;
    /// <summary>Required if inline_message_id is not specified. Identifier of the
    /// message to edit</summary>
    [caName('message_id')]
    [caDefaultValueInt64(0)]
    MessageId: Int64;
    class function Default: TtgStopMessageLiveLocationArgument; static;
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

  /// <summary>Use this method to specify a url and receive incoming updates via an
  /// outgoing webhook. Whenever there is an update for the bot, we will send an
  /// HTTPS POST request to the specified url, containing a JSON-serialized Update.
  /// In case of an unsuccessful request, we will give up after a reasonable amount
  /// of attempts. Returns True on success.
  /// </summary>
  /// <remarks>
  /// If you'd like to make sure that the Webhook request comes from Telegram, we
  /// recommend using a secret path in the URL, e.g. https://www.example.com/<token>.
  /// Since nobody else knows your bot's token, you can be pretty sure it's us.
  /// </remarks>
  [caName('setWebhook')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSetWebhookArgument = record
  public
    /// <summary>HTTPS url to send updates to. Use an empty string to remove webhook
    /// integration</summary>
    [caIsRequaired]
    [caName('url')]
    [caDefaultValueString('')]
    Url: string;
    /// <summary>Upload your public key certificate so that the root certificate in use
    /// can be checked. See our self-signed guide for details.</summary>
    [caName('certificate')]
    [caDefaultValueString('')]
    Certificate: TcaFileToSend;
    /// <summary> Maximum allowed number of simultaneous HTTPS connections to the
    /// webhook for update delivery, 1-100. Defaults to 40. Use lower values to limit
    /// the load on your bot's server, and higher values to increase your bot's
    /// throughput.</summary>
    [caName('max_connections')]
    [caDefaultValueInt64(40)]
    MaxConnections: Int64;
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
    class function Default: TtgSetWebhookArgument; static;
  end;

  /// <summary> Use this method to remove webhook integration if you decide to switch
  /// back to getUpdates. Returns True on success. Requires no parameters.
  /// </summary>
  [caName('deleteWebhook')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgDeleteWebhookArgument = record
  public
    class function Default: TtgDeleteWebhookArgument; static;
  end;

  /// <summary> Use this method to get current webhook status. Requires no parameters.
  /// On success, returns a WebhookInfo object. If the bot is using getUpdates, will
  /// return an object with the url field empty.</summary>
  [caName('getWebhookInfo')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgGetWebhookInfoArgument = record
  public
    class function Default: TtgGetWebhookInfoArgument; static;
  end;

  [caName('exportChatInviteLink')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.GetOrPost)]
  TtgExportChatInviteLinkArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    class function Default: TtgExportChatInviteLinkArgument; static;
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

  [caName('sendPoll')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSendPollArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    [caName('question')]
    [caIsRequaired]
    [caDefaultValueString('')]
    /// <summary>
    /// Poll question, 1-255 characters
    /// </summary>
    Question: string;
    [caName('options')]
    [caIsRequaired]
    [caDefaultValueString('[]')]
    /// <summary>
    /// A JSON-serialized list of answer options, 2-10 strings 1-100 characters each
    /// </summary>
    Options: TArray<string>;
    [caName('is_anonymous')]
    [caDefaultValueBoolean(True)]
    /// <summary>
    /// True, if the poll needs to be anonymous, defaults to True
    /// </summary>
    IsAnonymous: Boolean;
    [caName('type')]
    [caDefaultValueString('regular')]
    /// <summary>
    /// Poll type, “quiz” or “regular”, defaults to “regular”
    /// </summary>
    &Type: string;
    [caName('allows_multiple_answers')]
    [caDefaultValueBoolean(False)]
    /// <summary>
    /// True, if the poll allows multiple answers, ignored for polls in quiz mode, defaults to False
    /// </summary>
    AllowsMultipleAnswers: Boolean;
    [caName('correct_option_id')]
    [caDefaultValueInt64(0)]
    /// <summary>
    /// True, if the poll allows multiple answers, ignored for polls in quiz mode, defaults to False
    /// </summary>
    CorrectOptionId: Integer;
    [caName('explanation')]
    [caDefaultValueString('')]
    /// <summary>
    /// Text that is shown when a user chooses an incorrect answer
    /// or taps on the lamp icon in a quiz-style poll, 0-200 characters with at most 2 line feeds after entities parsing
    /// </summary>
    Explanation: string;
    [caName('explanation_parse_mode')]
    [caDefaultValueString('')]
    /// <summary>Mode for parsing entities in the explanation. See formatting options for more details.</summary>
    ExplanationParseMode: TtgParseMode;
    [caName('open_period')]
    [caDefaultValueInt64(0)]
    /// <summary>
    /// Amount of time in seconds the poll will be active after creation, 5-600. Can't
    /// be used together with close_date.
    /// </summary>
    OpenPeriod: Integer;
    [caName('close_date')]
    [caDefaultValueInt64(0)]
    /// <summary>
    /// Point in time (Unix timestamp) when the poll will be automatically closed.
    /// Must be at least 5 and no more than 600 seconds in the future. Can't be used together with open_period.
    /// </summary>
    CloseDate: Integer;
    [caDefaultValueBoolean(False)]
    [caName('is_closed')]
    /// <summary>
    /// Pass True, if the poll needs to be immediately closed. This can be useful for poll preview.
    /// </summary>
    IsClosed: Boolean;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.
    /// </summary>
    DisableNotification: Boolean;
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    /// <summary>If the message is a reply, ID of the original message</summary>
    ReplyToMessageId: Int64;
    class function Default: TtgSendPollArgument; static;
  end;

  /// <summary>
  /// Use this method to send an animated emoji that will display a random value. On
  /// success, the sent Message is returned.
  /// </summary>
  [caName('sendDice')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSendDiceArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    [caName('emoji')]
    [caDefaultValueString('🎲')]
    /// <summary>
    /// Emoji on which the dice throw animation is based. Currently, must be
    /// one of “🎲”, “🎯”, or “🏀”. Dice can have values 1-6 for “🎲” and “🎯”, and
    /// values 1-5 for “🏀”. Defaults to “🎲”
    /// </summary>
    Emoji: string;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.
    /// </summary>
    DisableNotification: Boolean;
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    /// <summary>If the message is a reply, ID of the original message</summary>
    ReplyToMessageId: Int64;
    class function Default: TtgSendDiceArgument; static;
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
  TtgSendChatActionArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    /// <summary> ype of action to broadcast. Choose one, depending on what the user is
    /// about to receive: typing for text messages, upload_photo for photos,
    /// record_video or upload_video for videos, record_audio or upload_audio for audio
    /// files, upload_document for general files, find_location for location data,
    /// record_video_note or upload_video_note for video notes.</summary>
    [caName('action')]
    [caDefaultValueString('')]
    [caIsRequaired]
    Action: TtgChatAction;
    class function Default: TtgSendChatActionArgument; static;
  end;

implementation

{ TtgForwardMessageArgument }

constructor TtgForwardMessageArgument.Create;
begin
  inherited Create;
  fChatId := TtgUserLink.Empty;
  fFromChatId := TtgUserLink.Empty;
  fDisableNotification := False;
  fMessageId := 0;
end;

destructor TtgForwardMessageArgument.Destroy;
begin

  inherited;
end;

{ TtgSendPhotoArgument }

constructor TtgSendPhotoArgument.Create;
begin
  inherited Create();
  fPhoto := TcaFileToSend.Empty;
end;

destructor TtgSendPhotoArgument.Destroy;
begin

  inherited Destroy;
end;

procedure TtgSendPhotoArgument.SetReplyToMessageId(const Value: Int64);
begin
  fReplyToMessageId := Value;
end;

{ TtgSendDocumentArgument }

constructor TtgSendDocumentArgument.Create;
begin
  inherited Create();
  fDocument := TcaFileToSend.Empty;
  fThumb := TcaFileToSend.Empty;
  FDisableContentTypeDetection := False;
end;

destructor TtgSendDocumentArgument.Destroy;
begin

  inherited;
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

{ TtgSendVenueArgument }

class function TtgSendVenueArgument.Default: TtgSendVenueArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
  Result.Latitude := 0;
  Result.Longitude := 0;
  Result.Title := '';
  Result.Address := '';
  Result.FoursquareId := '';
  Result.FoursquareType := '';
  Result.DisableNotification := False;
  Result.ReplyToMessageId := 0;
end;

{ TtgSendContactArgument }

class function TtgSendContactArgument.Default: TtgSendContactArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
  Result.PhoneNumber := '';
  Result.FirstName := '';
  Result.LastName := '';
  Result.VCard := '';
  Result.DisableNotification := False;
  Result.ReplyToMessageId := 0;
end;

{ TtgSendPollArgument }

class function TtgSendPollArgument.Default: TtgSendPollArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
  Result.Question := '';
  Result.Options := [];
  Result.IsAnonymous := True;
  Result.&Type := 'regular';
  Result.AllowsMultipleAnswers := False;
  Result.CorrectOptionId := 0;
  Result.Explanation := '';
  Result.ExplanationParseMode := TtgParseMode.Default;
  Result.OpenPeriod := 0;
  Result.CloseDate := 0;
  Result.IsClosed := False;
  Result.DisableNotification := False;
  Result.ReplyToMessageId := 0;
end;

{ TtgSetWebhookArgument }

class function TtgSetWebhookArgument.Default: TtgSetWebhookArgument;
begin
  Result.Url := '';
  Result.Certificate := TcaFileToSend.Empty;
  Result.MaxConnections := 40;
  Result.AllowedUpdates := UPDATES_ALLOWED_ALL;
end;

{ TtgDeleteWebhookArgument }

class function TtgDeleteWebhookArgument.Default: TtgDeleteWebhookArgument;
begin

end;

{ TtgGetWebhookInfoArgument }

class function TtgGetWebhookInfoArgument.Default: TtgGetWebhookInfoArgument;
begin

end;

{ TtgSendLocationArgument }

class function TtgSendLocationArgument.Default: TtgSendLocationArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
  Result.Latitude := 0.0;
  Result.Longitude := 0.0;
  Result.LivePeriod := 0;
  Result.DisableNotification := False;
  Result.ReplyToMessageId := 0;
end;

{ TtgEditMessageLiveLocationHaveInlineMessageIDArgument }

class function TtgEditMessageLiveLocationHaveInlineMessageIDArgument.Default
  : TtgEditMessageLiveLocationHaveInlineMessageIDArgument;
begin
  Result.InlineMessageID := 0;
  Result.Latitude := 0.0;
  Result.Longitude := 0.0;
end;

{ TtgEditMessageLiveLocationArgument }

class function TtgEditMessageLiveLocationArgument.Default: TtgEditMessageLiveLocationArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
  Result.MessageId := 0;
  Result.Latitude := 0.0;
  Result.Longitude := 0.0;
end;

{ TtgStopMessageLiveLocationArgument }

class function TtgStopMessageLiveLocationArgument.Default: TtgStopMessageLiveLocationArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
  Result.MessageId := 0;
end;

{ TtgStopMessageLiveLocationHaveInlineMessageIDArgument }

class function TtgStopMessageLiveLocationHaveInlineMessageIDArgument.Default
  : TtgStopMessageLiveLocationHaveInlineMessageIDArgument;
begin
  Result.InlineMessageID := 0;
end;

{ TtgSendDiceArgument }

class function TtgSendDiceArgument.Default: TtgSendDiceArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
  Result.Emoji := '🎲';
  Result.DisableNotification := False;
  Result.ReplyToMessageId := 0;
end;

{ TtgSendChatActionArgument }

class function TtgSendChatActionArgument.Default: TtgSendChatActionArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
  Result.Action := TtgChatAction.Typing;
end;

{ TtgExportChatInviteLinkArgument }

class function TtgExportChatInviteLinkArgument.Default: TtgExportChatInviteLinkArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
end;

{ TtgMessageArgument }

constructor TtgMessageArgument.Create;
begin
  inherited Create();
  fText := '';
  fEntities := nil;
  fDisableWebPagePreview := False;
end;

destructor TtgMessageArgument.Destroy;
begin

  inherited;
end;

{ TtgSendMessageBase }

constructor TtgSendMessageBase.Create;
begin
  inherited Create;
  fParseMode := TtgParseMode.Default;
  fReplyToMessageId := 0;
  fAllowSendingWithoutReply := False;
end;

destructor TtgSendMessageBase.Destroy;
begin

  inherited Destroy;
end;

{ TtgCopyMessageArgument }

constructor TtgCopyMessageArgument.Create;
begin
  inherited Create();
  fFromChatId := TtgUserLink.Empty;
  fMessageId := 0;
  fCaption := '';
  fCaptionEntities := nil;
end;

destructor TtgCopyMessageArgument.Destroy;
begin

  inherited Destroy;
end;

{ TtgMessageAbstract }

constructor TtgMessageAbstract.Create;
begin
  inherited Create();
  fChatId := TtgUserLink.Empty;
  fDisableNotification := False;
end;

destructor TtgMessageAbstract.Destroy;
begin

  inherited Destroy;
end;

{ TtgSendMediaAbstractArgument }

constructor TtgSendMediaAbstractArgument.Create;
begin
  inherited Create;
  fCaption := '';
  fCaptionEntities := nil;
end;

destructor TtgSendMediaAbstractArgument.Destroy;
begin

  inherited Destroy;
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
end;

destructor TtgSendAudioArgument.Destroy;
begin

  inherited Destroy;
end;

end.
