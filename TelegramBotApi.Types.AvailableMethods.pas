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
    constructor Create; override;
    destructor Destroy; override;
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

implementation

{ TtgSendMessageArgument }

constructor TtgSendMessageArgument.Create;
begin
  inherited Create();
  FText := '';
  FEntities := nil;
  FDisableWebPagePreview := False;
end;

destructor TtgSendMessageArgument.Destroy;
begin

  inherited;
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
end;

destructor TtgSendPhotoArgument.Destroy;
begin

  inherited Destroy;
end;

end.
