unit TelegramBotApi.Types.Request;

interface

uses
  CloudAPI.Attributes,
  CloudAPI.Types,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Abstract,
  TelegramBotApi.Types.Enums,
  TelegramBotApi.Types.Keyboards;

type
  TtgEmptyArgument = class(TInterfacedObject);

  [caName('getMe')]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>
  /// A simple method for testing your bot's auth token.
  /// Requires no parameters.
  /// Returns basic information about the bot in form of a User object.
  /// </summary>
  TtgGetMeArgunent = class(TtgEmptyArgument);
  /// <summary>
  /// Use this method to log out from the cloud Bot API server before launching the
  /// bot locally. You must log out the bot before running it locally, otherwise
  /// there is no guarantee that the bot will receive updates. After a successful
  /// call, you can immediately log in on a local server, but will not be able to log
  /// in back to the cloud Bot API server for 10 minutes. Returns True on success.
  /// Requires no parameters.
  /// </summary>
  [caName('logOut')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgLogOutArgunent = class(TtgEmptyArgument);
  /// <summary>Use this method to close the bot instance before moving it from one
  /// local server to another. You need to delete the webhook before calling this
  /// method to ensure that the bot isn't launched again after server restart. The
  /// method will return error 429 in the first 10 minutes after the bot is launched.
  /// Returns True on success. Requires no parameters.</summary>
  [caName('close')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgCloseArgunent = class(TtgEmptyArgument);

  [caName('forwardMessage')]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>Use this method to forward messages of any kind. On success, the sent
  /// Message is returned.</summary>
  TtgForwardMessageArgument = class(TtgMessageAbstract)
  private
    [caName('from_chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FFromChatId: TtgUserLink;
    [caName('message_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FMessageID: Int64;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>Unique identifier for the chat where the original message was sent (or
    /// channel username in the format @channelusername)</summary>
    property FromChatId: TtgUserLink read FFromChatId write FFromChatId;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification;
    /// <summary>Message identifier in the chat specified in from_chat_id</summary>
    property MessageID: Int64 read FMessageID write FMessageID;
    constructor Create; override;
    destructor Destroy; override;
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
    InlineMessageId: Int64;
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
    MessageID: Int64;
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
    InlineMessageId: Int64;
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
    MessageID: Int64;
    class function Default: TtgStopMessageLiveLocationArgument; static;
  end;

  [caName('getUpdates')]
  [caParameterType(TcaParameterType.GetOrPost)]
  [caMethod(TcaMethod.POST)]
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
    /// <summary>
    /// The fixed IP address which will be used to send webhook requests instead of the
    /// IP address resolved through DNS
    /// </summary>
    [caName('ip_address')]
    [caDefaultValueString('')]
    IpAddress: string;
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
    /// <summary>
    /// Pass True to drop all pending updates
    /// </summary>
    [caName('drop_pending_updates')]
    [caDefaultValueBoolean(False)]
    DropPendingUpdates: Boolean;
    class function Default: TtgSetWebhookArgument; static;
  end;

  /// <summary>Use this method to remove webhook integration if you decide to switch
  /// back to getUpdates. Returns True on success.
  /// <summary>
  [caName('deleteWebhook')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgDeleteWebhookArgument = record
  public
    /// <summary>
    /// Pass True to drop all pending updates
    /// </summary>
    [caName('drop_pending_updates')]
    [caDefaultValueBoolean(False)]
    DropPendingUpdates: Boolean;
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

  /// <summary>
  /// Use this method to get basic info about a file and prepare it for downloading.
  /// For the moment, bots can download files of up to 20MB in size. On success, a
  /// File object is returned. The file can then be downloaded via the link https:
  /// //api.telegram.org/file/bot<token>/<file_path>, where <file_path> is taken from
  /// the response. It is guaranteed that the link will be valid for at least 1 hour.
  /// When the link expires, a new one can be requested by calling getFile again.
  /// </summary>
  [caName('getFile')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.GetOrPost)]
  TtgGetFileArgument = class
  private
    [caName('file_id')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FFileId: string;
  public
    constructor Create(const AFileID: string);
    /// <summary>File identifier to get info about</summary>
    property FileId: string read FFileId write FFileId;
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
    constructor Create;
  end;

  /// <summary> Use this method to unban a previously kicked user in a supergroup or
  /// channel. The user will not return to the group or channel automatically, but
  /// will be able to join via link, etc. The bot must be an administrator for this
  /// to work. By default, this method guarantees that after the call the user is not
  /// a member of the chat, but will be able to join it. So if the user is a member
  /// of the chat they will also be removed from the chat. If you don't want this,
  /// use the parameter only_if_banned. Returns True on success.</summary>
  [caName('unbanChatMember')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgUnbanChatMemberArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caName('user_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FUserID: Int64;
    [caName('only_if_banned')]
    [caDefaultValueBoolean(False)]
    FOnlyIfBanned: Boolean;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    /// <summary> Unique identifier of the target user.</summary>
    property UserId: Int64 read FUserID write FUserID;
    /// <summary>
    /// Do nothing if the user is not banned
    /// </summary>
    property OnlyIfBanned: Boolean read FOnlyIfBanned write FOnlyIfBanned;
    constructor Create(AChatId: TtgUserLink; const AUserId: Int64; const AOnlyIfBanned: Boolean = True);
  end;

  /// <summary>Use this method to remove a message from the list of pinned messages
  /// in a chat. If the chat is not a private chat, the bot must be an administrator
  /// in the chat for this to work and must have the 'can_pin_messages' admin right
  /// in a supergroup or 'can_edit_messages' admin right in a channel. Returns True
  /// on success.
  /// </summary>
  [caName('unpinChatMessage')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgUnpinChatMessageArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caName('message_id')]
    [caDefaultValueInt64(0)]
    FMessageID: Int64;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    /// <summary>Identifier of a message to unpin. If not specified, the most recent
    /// pinned message (by sending date) will be unpinned.</summary>
    property MessageID: Int64 read FMessageID write FMessageID;
    constructor Create(AChatId: TtgUserLink; const AMessageId: Int64 = 0);
  end;

  /// <summary>Use this method to remove a message from the list of pinned messages
  /// in a chat. If the chat is not a private chat, the bot must be an administrator
  /// in the chat for this to work and must have the 'can_pin_messages' admin right
  /// in a supergroup or 'can_edit_messages' admin right in a channel. Returns True
  /// on success.
  /// </summary>
  [caName('unpinAllChatMessages')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgUnpinAllChatMessagesArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    constructor Create(AChatId: TtgUserLink);
  end;

  /// <summary>
  /// Use this method to create an additional invite link for a chat. The bot must be
  /// an administrator in the chat for this to work and must have the appropriate
  /// admin rights. The link can be revoked using the method revokeChatInviteLink.
  /// Returns the new invite link as ChatInviteLink object.
  /// </summary>
  [caName('createChatInviteLink')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgCreateChatInviteLinkArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caName('expire_date')]
    FExpireDate: TDateTime;
    [caName('member_limit')]
    FMemberLimit: Integer;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    /// <summary>
    /// Point in time (Unix timestamp) when the link will expire
    /// </summary>
    property ExpireDate: TDateTime read FExpireDate write FExpireDate;
    /// <summary>
    /// Maximum number of users that can be members of the chat simultaneously after
    /// joining the chat via this invite link; 1-99999
    /// </summary>
    property MemberLimit: Integer read FMemberLimit write FMemberLimit;
  end;

  /// <summary>
  /// Use this method to edit a non-primary invite link created by the bot. The bot
  /// must be an administrator in the chat for this to work and must have the
  /// appropriate admin rights. Returns the edited invite link as a ChatInviteLink
  /// object.
  /// </summary>
  [caName('editChatInviteLink')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgEditChatInviteLinkArgument = class(TtgCreateChatInviteLinkArgument)
  private
    [caName('invite_link')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FInviteLink: string;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>
    /// The invite link to edit
    /// </summary>
    property InviteLink: string read FInviteLink write FInviteLink;
    /// <summary>
    /// Point in time (Unix timestamp) when the link will expire
    /// </summary>
    property ExpireDate;
    /// <summary>
    /// Maximum number of users that can be members of the chat simultaneously after
    /// joining the chat via this invite link; 1-99999
    /// </summary>
    property MemberLimit;
  end;

  /// <summary> Use this method to revoke an invite link created by the bot. If the
  /// primary link is revoked, a new link is automatically generated. The bot must be
  /// an administrator in the chat for this to work and must have the appropriate
  /// admin rights. Returns the revoked invite link as ChatInviteLink object.
  /// </summary>
  [caName('revokeChatInviteLink')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgRevokeChatInviteLinkArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caName('invite_link')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FInviteLink: string;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    /// <summary>
    /// The invite link to revoke
    /// </summary>
    property InviteLink: string read FInviteLink write FInviteLink;
  end;

  /// <summary> Use this method to promote or demote a user in a supergroup or a
  /// channel. The bot must be an administrator in the chat for this to work and must
  /// have the appropriate admin rights. Pass False for all boolean parameters to
  /// demote a user. Returns True on success.
  /// </summary>
  TtgPromoteChatMemberArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caName('user_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FUserID: Int64;
    [caName('is_anonymous')]
    [caDefaultValueBoolean(False)]
    FIsAnonymous: Boolean;
    [caName('can_manage_chat')]
    [caDefaultValueBoolean(False)]
    FCanManageChat: Boolean;
    [caName('can_post_messages')]
    [caDefaultValueBoolean(False)]
    FCanPostMessages: Boolean;
    [caName('can_edit_messages')]
    [caDefaultValueBoolean(False)]
    FCanEditMessages: Boolean;
    [caName('can_delete_messages')]
    [caDefaultValueBoolean(False)]
    FCanDeleteMessages: Boolean;
    [caName('can_manage_voice_chats')]
    [caDefaultValueBoolean(False)]
    FCanManageVoiceChats: Boolean;
    [caName('can_restrict_members')]
    [caDefaultValueBoolean(False)]
    FCanRestrictMembers: Boolean;
    [caName('can_promote_members')]
    [caDefaultValueBoolean(False)]
    FCanPromoteMembers: Boolean;
    [caName('can_change_info')]
    [caDefaultValueBoolean(False)]
    FCanChangeInfo: Boolean;
    [caName('can_invite_users')]
    [caDefaultValueBoolean(False)]
    FCanInviteUsers: Boolean;
    [caName('can_pin_messages')]
    [caDefaultValueBoolean(False)]
    FCanPinMessages: Boolean;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    /// <summary>
    /// Unique identifier of the target user
    /// </summary>
    property UserId: Int64 read FUserID write FUserID;
    /// <summary> Pass True, if the administrator's presence in the chat is
    /// hidden</summary>
    property IsAnonymous: Boolean read FIsAnonymous write FIsAnonymous;
    /// <summary> Pass True, if the administrator can access the chat event log, chat
    /// statistics, message statistics in channels, see channel members, see anonymous
    /// administrators in supergroups and ignore slow mode. Implied by any other
    /// administrator privilege
    /// </summary>
    property CanManageChat: Boolean read FCanManageChat write FCanManageChat;
    /// <summary> Pass True, if the administrator can create channel posts, channels
    /// only </summary>
    property CanPostMessages: Boolean read FCanPostMessages write FCanPostMessages;
    /// <summary> Pass True, if the administrator can edit messages of other users and
    /// can pin messages, channels only</summary>
    property CanEditMessages: Boolean read FCanEditMessages write FCanEditMessages;
    /// <summary>Pass True, if the administrator can delete messages of other
    /// users</summary>
    property CanDeleteMessages: Boolean read FCanDeleteMessages write FCanDeleteMessages;
    /// <summary>Pass True, if the administrator can manage voice chats</summary>
    property CanManageVoiceChats: Boolean read FCanManageVoiceChats write FCanManageVoiceChats;
    /// <summary> Pass True, if the administrator can restrict, ban or unban chat
    /// members</summary>
    property CanRestrictMembers: Boolean read FCanRestrictMembers write FCanRestrictMembers;
    /// <summary>Pass True, if the administrator can add new administrators with a
    /// subset of their own privileges or demote administrators that he has promoted,
    /// directly or indirectly (promoted by administrators that were appointed by him)
    /// </summary>
    property CanPromoteMembers: Boolean read FCanPromoteMembers write FCanPromoteMembers;
    /// <summary> Pass True, if the administrator can change chat title, photo and
    /// other settings</summary>
    property CanChangeInfo: Boolean read FCanChangeInfo write FCanChangeInfo;
    /// <summary> Pass True, if the administrator can invite new users to the
    /// chat</summary>
    property CanInviteUsers: Boolean read FCanInviteUsers write FCanInviteUsers;
    /// <summary> Pass True, if the administrator can pin messages, supergroups
    /// only</summary>
    property CanPinMessages: Boolean read FCanPinMessages write FCanPinMessages;
  end;

  /// <summary> Use this method to kick a user from a group, a supergroup or a
  /// channel. In the case of supergroups and channels, the user will not be able to
  /// return to the chat on their own using invite links, etc., unless unbanned first.
  /// The bot must be an administrator in the chat for this to work and must have the
  /// appropriate admin rights. Returns True on success.</summary>
  [caName('banChatMember')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgBanChatMember = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caName('user_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FUserID: Int64;
    [caName('until_date')]
    [caDefaultValueSingle(0)]
    FUntilDate: TDateTime;
    [caName('revoke_messages')]
    [caDefaultValueBoolean(False)]
    FRevokeMessages: Boolean;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    /// <summary> Unique identifier of the target user.</summary>
    property UserId: Int64 read FUserID write FUserID;
    /// <summary>
    /// Date when the user will be unbanned, unix time. If user is banned for more than
    /// 366 days or less than 30 seconds from the current time they are considered to
    /// be banned forever. Applied for supergroups and channels only.
    /// </summary>
    property UntilDate: TDateTime read FUntilDate write FUntilDate;
    /// <summary>
    /// Pass True to delete all messages from the chat for the user that is being
    /// removed. If False, the user will be able to see messages in the group that were
    /// sent before the user was removed. Always True for supergroups and channels.
    /// </summary>
    property RevokeMessages: Boolean read FRevokeMessages write FRevokeMessages;
    constructor Create;
  end;

  /// <summary>
  /// Use this method to send invoices. On success, the sent Message is returned.
  /// </summary>
  TtgSendInvoiceArgument = class(TtgSendMessageBase)
  private
    [caName('title')]
    [caIsRequaired]
    [caDefaultValueString('')]
    fTitle: string;
    [caName('description')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FDescription: string;
    [caName('payload')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FPayload: string;
    [caName('provider_token')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FProviderToken: string;
    [caName('currency')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FCurrency: string;
    [caName('prices')]
    [caIsRequaired]
    [caDefaultValueString('[]')]
    FPrices: TArray<TtgLabeledPrice>;
    [caName('max_tip_amount')]
    [caDefaultValueInt(0)]
    FMaxTipAmount: Integer;
    [caName('suggested_tip_amounts')]
    [caDefaultValueString('[]')]
    FSuggestedTipAmounts: TArray<Integer>;
    [caName('start_parameter')]
    [caDefaultValueString('')]
    FStartParameter: string;
    [caName('provider_data')]
    [caDefaultValueString('')]
    FProviderData: string;
    [caName('photo_url')]
    [caDefaultValueString('')]
    FPhotoUrl: string;
    [caName('photo_size')]
    [caDefaultValueInt(0)]
    FPhotoSize: Integer;
    [caName('photo_width')]
    [caDefaultValueInt(0)]
    FPhotoWidth: Integer;
    [caName('photo_height')]
    [caDefaultValueInt(0)]
    FPhotoHeight: Integer;
    [caName('need_name')]
    [caDefaultValueBoolean(False)]
    FNeedName: Boolean;
    [caName('need_phone_number')]
    [caDefaultValueBoolean(False)]
    FNeedPhoneNumber: Boolean;
    [caName('need_email')]
    [caDefaultValueBoolean(False)]
    FNeedEmail: Boolean;
    [caName('need_shipping_address')]
    [caDefaultValueBoolean(False)]
    FNeedShippingAddress: Boolean;
    [caName('send_phone_number_to_provider')]
    [caDefaultValueBoolean(False)]
    FSendPhoneNumberToProvider: Boolean;
    [caName('send_email_to_provider')]
    [caDefaultValueBoolean(False)]
    FSendEmailToProvider: Boolean;
    [caName('is_flexible')]
    [caDefaultValueBoolean(False)]
    FIsFlexible: Boolean;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>
    /// Product name, 1-32 characters
    /// </summary>
    property Title: string read fTitle write fTitle;
    /// <summary>
    /// Product description, 1-255 characters
    /// </summary>
    property Description: string read FDescription write FDescription;
    /// <summary>
    /// Bot-defined invoice payload, 1-128 bytes. This will not be displayed to the
    /// user, use for your internal processes.
    /// </summary>
    property Payload: string read FPayload write FPayload;
    /// <summary>
    /// Payments provider token, obtained via Botfather
    /// </summary>
    property ProviderToken: string read FProviderToken write FProviderToken;
    /// <summary>
    /// Three-letter ISO 4217 currency code, see more on currencies
    /// </summary>
    property Currency: string read FCurrency write FCurrency;
    /// <summary>
    /// Price breakdown, a JSON-serialized list of components (e.g. product price, tax,
    /// discount, delivery cost, delivery tax, bonus, etc.)
    /// </summary>
    property Prices: TArray<TtgLabeledPrice> read FPrices write FPrices;
    /// <summary>
    /// The maximum accepted amount for tips in the smallest units of the currency (
    /// integer, not float/double). For example, for a maximum tip of US$ 1.45 pass
    /// max_tip_amount = 145. See the exp parameter in currencies.json, it shows the
    /// number of digits past the decimal point for each currency (2 for the majority
    /// of currencies). Defaults to 0
    /// </summary>
    property MaxTipAmount: Integer read FMaxTipAmount write FMaxTipAmount;
    /// <summary>
    /// A JSON-serialized array of suggested amounts of tips in the smallest units of
    /// the currency (integer, not float/double). At most 4 suggested tip amounts can
    /// be specified. The suggested tip amounts must be positive, passed in a strictly
    /// increased order and must not exceed max_tip_amount.
    /// </summary>
    property SuggestedTipAmounts: TArray<Integer> read FSuggestedTipAmounts write FSuggestedTipAmounts;
    /// <summary>
    /// Unique deep-linking parameter. If left empty, forwarded copies of the sent
    /// message will have a Pay button, allowing multiple users to pay directly from
    /// the forwarded message, using the same invoice. If non-empty, forwarded copies
    /// of the sent message will have a URL button with a deep link to the bot (instead
    /// of a Pay button), with the value used as the start parameter
    /// </summary>
    property StartParameter: string read FStartParameter write FStartParameter;
    /// <summary>
    /// A JSON-serialized data about the invoice, which will be shared with the payment
    /// provider. A detailed description of required fields should be provided by the
    /// payment provider.
    /// </summary>
    property ProviderData: string read FProviderData write FProviderData;
    /// <summary>
    /// URL of the product photo for the invoice. Can be a photo of the goods or a
    /// marketing image for a service. People like it better when they see what they
    /// are paying for.
    /// </summary>
    property PhotoUrl: string read FPhotoUrl write FPhotoUrl;
    /// <summary>
    /// Photo size
    /// </summary>
    property PhotoSize: Integer read FPhotoSize write FPhotoSize;
    /// <summary>
    /// Photo width
    /// </summary>
    property PhotoWidth: Integer read FPhotoWidth write FPhotoWidth;
    /// <summary>
    /// Photo height
    /// </summary>
    property PhotoHeight: Integer read FPhotoHeight write FPhotoHeight;
    /// <summary>
    /// Pass True, if you require the user's full name to complete the order
    /// </summary>
    property NeedName: Boolean read FNeedName write FNeedName;
    /// <summary>
    /// Pass True, if you require the user's phone number to complete the order
    /// </summary>
    property NeedPhoneNumber: Boolean read FNeedPhoneNumber write FNeedPhoneNumber;
    /// <summary>
    /// Pass True, if you require the user's email address to complete the order
    /// </summary>
    property NeedEmail: Boolean read FNeedEmail write FNeedEmail;
    /// <summary>
    /// Pass True, if you require the user's shipping address to complete the order
    /// </summary>
    property NeedShippingAddress: Boolean read FNeedShippingAddress write FNeedShippingAddress;
    /// <summary>
    /// Pass True, if user's phone number should be sent to provider
    /// </summary>
    property SendPhoneNumberToProvider: Boolean read FSendPhoneNumberToProvider write FSendPhoneNumberToProvider;
    /// <summary>
    /// Pass True, if user's email address should be sent to provider
    /// </summary>
    property SendEmailToProvider: Boolean read FSendEmailToProvider write FSendEmailToProvider;

    /// <summary>
    /// Pass True, if the final price depends on the shipping method
    /// </summary>
    property IsFlexible: Boolean read FIsFlexible write FIsFlexible;

    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification;
    /// <summary>
    /// If the message is a reply, ID of the original message
    /// </summary>
    property ReplyToMessageId;
    /// <summary>
    /// Pass True, if the message should be sent even if the specified replied-to
    /// message is not found
    /// </summary>
    property AllowSendingWithoutReply;
    /// <summary>
    /// A JSON-serialized object for an keyboard
    /// </summary>
    property ReplyMarkup;
  end;

  /// <summary> Use this method to get the current list of the bot's commands for the
  /// given scope and user language. Returns Array of BotCommand on success. If
  /// commands aren't set, an empty list is returned.</summary>
  [caName('getMyCommands')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgGetMyCommandsArgument = class
  private
    [caName('scope')]
    [caDefaultValueString('{}')]
    FScope: TtgBotCommandScope;
    [caName('language_code')]
    [caDefaultValueString('')]
    FLanguageCode: string;
  public
    /// <summary>A JSON-serialized object, describing scope of users. Defaults to
    /// BotCommandScopeDefault.</summary>
    property Scope: TtgBotCommandScope read FScope write FScope;
    /// <summary>
    /// A two-letter ISO 639-1 language code or an empty string
    /// </summary>
    property LanguageCode: string read FLanguageCode write FLanguageCode;
  end;

  /// <summary> Use this method to change the list of the bot's commands. See https:
  /// //core.telegram.org/bots#commands for more details about bot commands. Returns
  /// True on success.</summary>
  [caName('setMyCommands')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSetMyCommandsArgument = class
  private
    [caName('commands')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FCommands: TArray<TtgBotCommand>;
    [caName('scope')]
    [caDefaultValueString('{}')]
    FScope: TtgBotCommandScope;
    [caName('language_code')]
    [caDefaultValueString('')]
    FLanguageCode: string;
  public
    destructor Destroy; override;
    /// <summary>
    /// A JSON-serialized list of bot commands to be set as the list of the bot's
    /// commands. At most 100 commands can be specified.
    /// </summary>
    property Commands: TArray<TtgBotCommand> read FCommands write FCommands;
    /// <summary>A JSON-serialized object, describing scope of users. Defaults to
    /// BotCommandScopeDefault.</summary>
    property Scope: TtgBotCommandScope read FScope write FScope;
    /// <summary>
    /// A two-letter ISO 639-1 language code or an empty string
    /// </summary>
    property LanguageCode: string read FLanguageCode write FLanguageCode;
  end;

  /// <summary> Use this method to get the number of members in a chat. Returns Int
  /// on success.</summary>
  [caName('getChatMemberCount')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgGetChatMemberCountArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
  end;

  /// <summary>
  /// Use this method to send answers to callback queries sent from inline keyboards.
  /// The answer will be displayed to the user as a notification at the top of the
  /// chat screen or as an alert. On success, True is returned.
  /// </summary>
  [caName('answerCallbackQuery')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgAnswerCallbackQueryArgument = record
  private
    [caName('callback_query_id')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FCallbackQueryId: string;
    [caDefaultValueString('')]
    [caName('text')]
    FText: string;
    [caName('show_alert')]
    [caDefaultValueBoolean(False)]
    FShowAlert: Boolean;
    [caName('url')]
    [caDefaultValueString('')]
    FUrl: string;
    [caName('cache_time')]
    [caDefaultValueInt(0)]
    FCacheTime: Integer;
  public
    /// <summary>
    /// Unique identifier for the query to be answered
    /// </summary>
    property CallbackQueryId: string read FCallbackQueryId write FCallbackQueryId;
    /// <summary>
    /// Text of the notification. If not specified, nothing will be shown to the user,
    /// 0-200 characters
    /// </summary>
    property Text: string read FText write FText;
    /// <summary>
    /// If True, an alert will be shown by the client instead of a notification at the
    /// top of the chat screen. Defaults to false.
    /// </summary>
    property ShowAlert: Boolean read FShowAlert write FShowAlert;
    /// <summary>
    /// URL that will be opened by the user's client. If you have created a Game and
    /// accepted the conditions via @Botfather, specify the URL that opens your game —
    /// note that this will only work if the query comes from a callback_game button.
    ///
    /// Otherwise, you may use links like t.me/your_bot?start=XXXX that open your bot with a parameter.
    /// </summary>
    property Url: string read FUrl write FUrl;
    /// <summary>
    /// The maximum amount of time in seconds that the result of the callback query may
    /// be cached client-side. Telegram apps will support caching starting in version 3.
    /// 14. Defaults to 0.
    /// </summary>
    property CacheTime: Integer read FCacheTime write FCacheTime;
  end;

implementation

uses System.SysUtils;

{ TtgForwardMessageArgument }

constructor TtgForwardMessageArgument.Create;
begin
  inherited Create;
  ChatId := TtgUserLink.Empty;
  FromChatId := TtgUserLink.Empty;
  DisableNotification := False;
  FMessageID := 0;
end;

destructor TtgForwardMessageArgument.Destroy;
begin

  inherited;
end;

{ TtgGetUpdatesArgument }

class function TtgGetUpdatesArgument.Default: TtgGetUpdatesArgument;
begin
  Result.Offset := 0;
  Result.Limit := 100;
  Result.Timeout := 0;
  Result.AllowedUpdates := UPDATES_ALLOWED_ALL;
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
  Result.IpAddress := '';
  Result.MaxConnections := 40;
  Result.AllowedUpdates := UPDATES_ALLOWED_ALL;
  Result.DropPendingUpdates := False;
end;

{ TtgDeleteWebhookArgument }

class function TtgDeleteWebhookArgument.Default: TtgDeleteWebhookArgument;
begin
  Result.DropPendingUpdates := False;
end;

{ TtgGetWebhookInfoArgument }

class function TtgGetWebhookInfoArgument.Default: TtgGetWebhookInfoArgument;
begin

end;

{ TtgEditMessageLiveLocationHaveInlineMessageIDArgument }

class function TtgEditMessageLiveLocationHaveInlineMessageIDArgument.Default
  : TtgEditMessageLiveLocationHaveInlineMessageIDArgument;
begin
  Result.InlineMessageId := 0;
  Result.Latitude := 0.0;
  Result.Longitude := 0.0;
end;

{ TtgEditMessageLiveLocationArgument }

class function TtgEditMessageLiveLocationArgument.Default: TtgEditMessageLiveLocationArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
  Result.MessageID := 0;
  Result.Latitude := 0.0;
  Result.Longitude := 0.0;
end;

{ TtgStopMessageLiveLocationArgument }

class function TtgStopMessageLiveLocationArgument.Default: TtgStopMessageLiveLocationArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
  Result.MessageID := 0;
end;

{ TtgStopMessageLiveLocationHaveInlineMessageIDArgument }

class function TtgStopMessageLiveLocationHaveInlineMessageIDArgument.Default
  : TtgStopMessageLiveLocationHaveInlineMessageIDArgument;
begin
  Result.InlineMessageId := 0;
end;

{ TtgSendDiceArgument }

constructor TtgSendDiceArgument.Create;
begin
  FChatId := TtgUserLink.Empty;
  FEmoji := '🎲';
  FDisableNotification := False;
  FReplyToMessageId := 0;
end;

{ TtgExportChatInviteLinkArgument }

class function TtgExportChatInviteLinkArgument.Default: TtgExportChatInviteLinkArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
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

{ TtgUnbanChatMemberArgument }

constructor TtgUnbanChatMemberArgument.Create(AChatId: TtgUserLink; const AUserId: Int64;
  const AOnlyIfBanned: Boolean = True);
begin
  FChatId := AChatId;
  FUserID := AUserId;
  FOnlyIfBanned := AOnlyIfBanned;
end;

{ TtgGetFileArgument }

constructor TtgGetFileArgument.Create(const AFileID: string);
begin
  FFileId := AFileID;
end;

constructor TtgUnpinChatMessageArgument.Create(AChatId: TtgUserLink; const AMessageId: Int64 = 0);
begin
  inherited Create();
  FChatId := AChatId;
  FMessageID := AMessageId;
end;

constructor TtgUnpinAllChatMessagesArgument.Create(AChatId: TtgUserLink);
begin
  inherited Create();
  FChatId := AChatId;
end;

{ TtgKickChatMemberArgument }

constructor TtgBanChatMember.Create;
begin
  FChatId := TtgUserLink.Empty;
  FUserID := 0;
  FUntilDate := 0;
  FRevokeMessages := False;
end;

destructor TtgSetMyCommandsArgument.Destroy;
begin
  if Assigned(FScope) then
    FreeAndNil(FScope);
  inherited;
end;

end.
