unit TelegramBotApi.Types.UpdatingMessages;
// The following methods allow you to change an existing message in the message history instead of sending a new
// one with a result of an action. This is most useful for messages with inline keyboards using callback queries, but can//
// also help reduce clutter in conversations with regular chat bots.

// Please note, that it is currently only possible to edit messages without reply_markup or with inline keyboards.
interface

uses
  CloudAPI.Attributes,
  CloudAPI.Types,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Abstract;

type

  [caName('editMessageText')]
  [caParameterType(TcaParameterType.GetOrPost)]
  [caMethod(TcaMethod.POST)]
  /// <summary>Use this method to send text messages.
  /// On success, the sent Message is returned.
  /// </summary>
  TtgEditMessageTextArgument = class(TtgSendMessageBaseWithParseMode)
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
    [caName('message_id')]
    [caIsRequaired]
    FMessageID: Int64;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>
    /// Required if inline_message_id is not specified. Identifier of the message to
    /// edit
    /// </summary>
    property MessageID: Int64 read FMessageID write FMessageID;
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
  end;

  [caName('editMessageText')]
  [caParameterType(TcaParameterType.GetOrPost)]
  [caMethod(TcaMethod.POST)]
  /// <summary>Use this method to send text messages.
  /// On success, the sent Message is returned.
  /// </summary>
  TtgEditMessageTextInlineArgument = class(TtgSendMessageBaseWithParseMode)
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
    [caName('inline_message_id')]
    [caIsRequaired]
    FInlineMessageId: Int64;
  public
    /// <summary>
    /// Required if chat_id and message_id are not specified. Identifier of the inline
    /// message
    /// </summary>
    property InlineMessageId: Int64 read FInlineMessageId write FInlineMessageId;
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
  end;

  [caName('deleteMessage')]
  [caParameterType(TcaParameterType.GetOrPost)]
  [caMethod(TcaMethod.POST)]
  /// <summary>
  /// Use this method to delete a message, including service messages, with the
  /// following limitations:
  /// - A message can only be deleted if it was sent less than 48 hours ago.
  /// - A dice message in a private chat can only be deleted if it was sent more than
  /// 24 hours ago.
  /// - Bots can delete outgoing messages in private chats, groups, and supergroups.
  /// - Bots can delete incoming messages in private chats.
  /// - Bots granted can_post_messages permissions can delete outgoing messages in
  /// channels.
  /// - If the bot is an administrator of a group, it can delete any message there.
  /// - If the bot has can_delete_messages permission in a supergroup or a channel,
  /// it can delete any message there.
  /// Returns True on success.
  /// </summary>
  TtgDeleteMessageArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caName('message_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FMessageID: Int64;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    /// <summary>Identifier of the message to delete</summary>
    property MessageID: Int64 read FMessageID write FMessageID;
    constructor Create;
  end;

implementation

{ TtgEditMessageTextInlineArgument }

constructor TtgEditMessageTextInlineArgument.Create;
begin
  inherited;
  FInlineMessageId := 0;
end;

{ TtgDeleteMessageArgument }

constructor TtgDeleteMessageArgument.Create;
begin
  inherited;
  FChatId := 0;
  FMessageID := 0;
end;

end.
