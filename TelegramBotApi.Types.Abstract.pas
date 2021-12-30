unit TelegramBotApi.Types.Abstract;

interface

uses
  CloudAPI.Attributes,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Keyboards,
  TelegramBotApi.Types.Enums;

type
  TtgMessageAbstract = class
  private
    [caName('chat_id')]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    FDisableNotification: Boolean;
    [caName('reply_markup')]
    FReplyMarkup: TtgKeyboardAbstractProto;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;

    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification: Boolean read FDisableNotification write FDisableNotification;
    /// <summary>
    /// A JSON-serialized object for an keyboard
    /// </summary>
    property ReplyMarkup: TtgKeyboardAbstractProto read FReplyMarkup write FReplyMarkup;
  end;

  TtgSendMessageBase = class(TtgMessageAbstract)
  private
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    FReplyToMessageId: Int64;
    [caName('allow_sending_without_reply')]
    [caDefaultValueBoolean(False)]
    FAllowSendingWithoutReply: Boolean;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification;
    /// <summary>If the message is a reply, ID of the original message</summary>
    property ReplyToMessageId: Int64 read FReplyToMessageId write FReplyToMessageId;
    /// <summary>
    /// Pass True, if the message should be sent even if the specified replied-to
    /// message is not found
    /// </summary>
    property AllowSendingWithoutReply: Boolean read FAllowSendingWithoutReply write FAllowSendingWithoutReply;
    constructor Create; override;
    destructor Destroy; override;
  end;

  TtgSendMessageBaseWithParseMode = class(TtgSendMessageBase)
  private
    [caName('parse_mode')]
    [caDefaultValueString('')]
    FParseMode: TtgParseMode;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in your bot's message.   </summary>
    property ParseMode: TtgParseMode read FParseMode write FParseMode;
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

  TtgSendMediaAbstractArgument = class(TtgSendMessageBaseWithParseMode)
  private
    [caName('caption')]
    [caDefaultValueStringAttribute('')]
    FCaption: string;
    [caName('caption_entities')]
    [caDefaultValueString('[]')]
    FCaptionEntities: TArray<TtgMessageEntity>;
  public
    constructor Create; override;
    destructor Destroy; override;
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>Caption, 0-1024 characters after entities parsing</summary>
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
  end;

implementation

{ TtgSendMessageBaseWithParseMode }

constructor TtgSendMessageBaseWithParseMode.Create;
begin
  inherited Create;
  FParseMode := TtgParseMode.Default;
end;

destructor TtgSendMessageBaseWithParseMode.Destroy;
begin

  inherited Destroy;
end;

{ TtgSendMessageBase }

constructor TtgSendMessageBase.Create;
begin
  inherited Create;
  FReplyToMessageId := 0;
  FAllowSendingWithoutReply := False;
end;

destructor TtgSendMessageBase.Destroy;
begin

  inherited;
end;

{ TtgMessageAbstract }

constructor TtgMessageAbstract.Create;
begin

end;

destructor TtgMessageAbstract.Destroy;
begin

  inherited;
end;

{ TtgSendMediaAbstractArgument }

constructor TtgSendMediaAbstractArgument.Create;
begin
  inherited Create;
  FCaption := '';
  FCaptionEntities := nil;
end;

destructor TtgSendMediaAbstractArgument.Destroy;
begin

  inherited Destroy;
end;

end.
