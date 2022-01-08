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
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
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

  /// <summary> Use this method to send point on the map. On success, the sent
  /// Message is returned.
  /// </summary>
  [caName('sendLocation')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSendLocationArgument = record
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
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
    class function Default: TtgSendLocationArgument; static;
  end;

  /// <summary>
  /// Use this method to send information about a venue. On success, the sent Message is returned.
  /// </summary>
  [caName('sendVenue')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSendVenueArgument = record
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
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
    class function Default: TtgSendVenueArgument; static;
  end;

  /// <summary>
  /// Use this method to send phone contacts. On success, the sent Message is returned.
  /// </summary>
  [caName('sendContact')]
  [caParameterType(TcaParameterType.GetOrPost)]
  TtgSendContactArgument = record
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
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
    class function Default: TtgSendContactArgument; static;
  end;

  [caName('sendPoll')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSendPollArgument = record
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
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
    class function Default: TtgSendPollArgument; static;
  end;

  /// <summary>
  /// Use this method to send an animated emoji that will display a random value. On
  /// success, the sent Message is returned.
  /// </summary>
  [caName('sendDice')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSendDiceArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caName('emoji')]
    [caDefaultValueString('🎲')]
    FEmoji: string;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    FDisableNotification: Boolean;
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    FReplyToMessageId: Int64;
    [caName('protect_content')]
    FProtectContent: Boolean;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    /// <summary> Emoji on which the dice throw animation is based. Currently, must be
    /// one of “🎲”, “🎯”, “🏀”, “⚽”, “🎳”, or “🎰”. Dice can have values 1-6 for “🎲”,
    /// “🎯” and “🎳”, values 1-5 for “🏀” and “⚽”, and values 1-64 for “🎰”. Defaults
    /// to “🎲”
    /// </summary>
    property Emoji: string read FEmoji write FEmoji;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.
    /// </summary>
    property DisableNotification: Boolean read FDisableNotification write FDisableNotification;
    /// <summary>If the message is a reply, ID of the original message</summary>
    property ReplyToMessageId: Int64 read FReplyToMessageId write FReplyToMessageId;
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
    constructor Create;
  end;

  [caName('SendMediaGroup')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSendMediaGroupArgument = class(TtgSendMessageBase)
  private
    [caName('media')]
    [caIsRequaired]
    [caDefaultValueString('')]
    [caParameterType(TcaParameterType.GetOrPost)]
    FMedia: TArray<TtgInputMedia>;
    [caName('protect_content')]
    FProtectContent: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    property ChatId;
    /// <summary>
    /// Audio file to send. Pass a file_id as String to send an animation that exists on
    /// the Telegram servers (recommended), pass an HTTP URL as a String for Telegram
    /// to get a file from the Internet, or upload a new one using
    /// multipart/form-data. More info on Sending Files »
    /// </summary>
    property Media: TArray<TtgInputMedia> read FMedia write FMedia;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification;
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
    /// <summary>If the message is a reply, ID of the original message</summary>
    property ReplyToMessageId;
  end;

  [caName('copyMessage')]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>Use this method to send text messages.
  /// On success, the sent Message is returned.
  /// </summary>
  TtgCopyMessageArgument = class(TtgSendMessageBaseWithParseMode)
  private
    [caName('from_chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FFromChatId: TtgUserLink;
    [caName('message_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FMessageID: Int64;
    [caName('caption')]
    [caDefaultValueStringAttribute('')]
    FCaption: string;
    [caName('caption_entities')]
    [caDefaultValueString('[]')]
    FCaptionEntities: TArray<TtgMessageEntity>;
    [caName('protect_content')]
    FProtectContent: Boolean;
  public
    constructor Create; override;
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property FromChatId: TtgUserLink read FFromChatId write FFromChatId;
    /// <summary>Message identifier in the chat specified in from_chat_id</summary>
    property MessageID: Int64 read FMessageID write FMessageID;
    /// <summary>New caption for media, 0-1024 characters after entities parsing. If
    /// not specified, the original caption is kept
    /// </summary>
    property Caption: string read FCaption write FCaption;
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in your bot's message.   </summary>
    property ParseMode;
    /// <summary> List of special entities that appear in the new caption, which can be
    /// specified instead of parse_mode
    /// </summary>
    property CaptionEntities: TArray<TtgMessageEntity> read FCaptionEntities write FCaptionEntities;
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
  FProtectContent := False;
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
{ TtgSendLocationArgument }

class function TtgSendLocationArgument.Default: TtgSendLocationArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
  Result.Latitude := 0.0;
  Result.Longitude := 0.0;
  Result.LivePeriod := 0;
  Result.DisableNotification := False;
  Result.ReplyToMessageId := 0;
  Result.ProtectContent := False;
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
  Result.ProtectContent := False;
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
  Result.ProtectContent := False;
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
  Result.ProtectContent := False;
end;

{ TtgSendDiceArgument }

constructor TtgSendDiceArgument.Create;
begin
  FChatId := TtgUserLink.Empty;
  FEmoji := '🎲';
  FDisableNotification := False;
  FReplyToMessageId := 0;
  FProtectContent := False;
end;

{ TtgSendMediaGroupArgument }

constructor TtgSendMediaGroupArgument.Create;
begin
  FMedia := [];
  FProtectContent := False;
end;

destructor TtgSendMediaGroupArgument.Destroy;
var
  I: Integer;
begin
  for I := Low(FMedia) to High(FMedia) do
  begin
    FMedia[I].Free;
  end;
  FMedia := nil;
  inherited;
end;

{ TtgCopyMessageArgument }

constructor TtgCopyMessageArgument.Create;
begin
  inherited Create();
  FFromChatId := TtgUserLink.Empty;
  FMessageID := 0;
  FCaption := '';
  FCaptionEntities := nil;
end;

end.
