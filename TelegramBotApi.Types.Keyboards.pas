unit TelegramBotApi.Types.Keyboards;

interface

uses
  System.JSON.Serializers;

type
{$REGION 'Standard keyboards'}
  /// <summary>
  /// This object represents type of a poll, which is allowed to be created and sent
  /// when the corresponding button is pressed.
  /// </summary>
  TtgKeyboardButtonPollType = class
  private
    [JsonName('type')]
    FType: string;
  public
    /// <summary>
    /// Optional. If quiz is passed, the user will be allowed to create only polls in
    /// the quiz mode. If regular is passed, only regular polls will be allowed.
    /// Otherwise, the user will be allowed to create a poll of any type.
    /// </summary>
    { TODO -oOwner -cGeneral : change to enum }
    property &Type: string read FType write FType;
  end;

  /// <summary> This object represents one button of the reply keyboard. For simple
  /// text buttons String can be used instead of this object to specify text of the
  /// button. Optional fields request_contact, request_location, and request_poll are
  /// mutually exclusive
  /// </summary>
  /// <remarks>
  /// Note: request_contact and request_location options will only work in Telegram
  /// versions released after 9 April, 2016. Older clients will display unsupported
  /// message.
  /// Note: request_poll option will only work in Telegram versions released after 23
  /// January, 2020. Older clients will display unsupported message.
  /// </remarks>
  TtgKeyboardButton = class
  private
    [JsonName('text')]
    FText: string;
    [JsonName('request_contact')]
    FRequestContact: Boolean;
    [JsonName('request_location')]
    FRequestLocation: Boolean;
    [JsonName('request_poll')]
    FRequestPoll: TtgKeyboardButtonPollType;
  public
    /// <summary>
    /// Text of the button. If none of the optional fields are used, it will be sent as
    /// a message when the button is pressed
    /// </summary>
    property Text: string read FText write FText;
    /// <summary>
    /// Optional. If True, the user's phone number will be sent as a contact when the
    /// button is pressed. Available in private chats only
    /// </summary>
    property RequestContact: Boolean read FRequestContact write FRequestContact;
    /// <summary>
    /// Optional. If True, the user's current location will be sent when the button is
    /// pressed. Available in private chats only
    /// </summary>
    property RequestLocation: Boolean read FRequestLocation write FRequestLocation;
    /// <summary>
    /// Optional. If specified, the user will be asked to create a poll and send it to
    /// the bot when the button is pressed. Available in private chats only
    /// </summary>
    property RequestPoll: TtgKeyboardButtonPollType read FRequestPoll write FRequestPoll;
  end;

  /// <summary>
  /// This object represents a custom keyboard with reply options (see Introduction
  /// to bots for details and examples).
  /// </summary>
  TtgReplyKeyboardMarkup = class
  private
    [JsonName('keyboard')]
    FKeyboard: TArray<TArray<TtgKeyboardButton>>;
    [JsonName('resize_keyboard')]
    FResizeKeyboard: Boolean;
    [JsonName('one_time_keyboard')]
    FOneTimeKeyboard: Boolean;
    [JsonName('selective')]
    FSelective: Boolean;
  public
    /// <summary>
    /// Array of button rows, each represented by an Array of KeyboardButton objects
    /// </summary>
    property Keyboard: TArray < TArray < TtgKeyboardButton >> read FKeyboard write FKeyboard;
    /// <summary>
    /// Optional. Requests clients to resize the keyboard vertically for optimal fit (e.
    /// g., make the keyboard smaller if there are just two rows of buttons). Defaults
    /// to false, in which case the custom keyboard is always of the same height as the
    /// app's standard keyboard.
    /// </summary>
    property ResizeKeyboard: Boolean read FResizeKeyboard write FResizeKeyboard;
    /// <summary>
    /// Optional. Requests clients to hide the keyboard as soon as it's been used. The
    /// keyboard will still be available, but clients will automatically display the
    /// usual letter-keyboard in the chat – the user can press a special button in the
    /// input field to see the custom keyboard again. Defaults to false.
    /// </summary>
    property OneTimeKeyboard: Boolean read FOneTimeKeyboard write FOneTimeKeyboard;
    /// <summary>
    /// Optional. Use this parameter if you want to show the keyboard to specific users
    /// only. Targets: 1) users that are @mentioned in the text of the Message object;
    /// 2) if the bot's message is a reply (has reply_to_message_id), sender of the
    /// original message.
    ///
    /// Example: A user requests to change the bot's language, bot replies to the
    /// request with a keyboard to select the new language. Other users in the group
    /// don't see the keyboard.
    /// </summary>
    property Selective: Boolean read FSelective write FSelective;
  end;

  /// <summary>
  /// Upon receiving a message with this object, Telegram clients will remove the
  /// current custom keyboard and display the default letter-keyboard. By default,
  /// custom keyboards are displayed until a new keyboard is sent by a bot. An
  /// exception is made for one-time keyboards that are hidden immediately after the
  /// user presses a button (see ReplyKeyboardMarkup).
  /// </summary>
  TtgReplyKeyboardRemove = class
  private
    [JsonName('remove_keyboard')]
    FRemoveKeyboard: Boolean;
    [JsonName('selective')]
    FSelective: Boolean;
  public
    /// <summary>
    /// Requests clients to remove the custom keyboard (user will not be able to summon
    /// this keyboard; if you want to hide the keyboard from sight but keep it
    /// accessible, use one_time_keyboard in ReplyKeyboardMarkup)
    /// </summary>
    property RemoveKeyboard: Boolean read FRemoveKeyboard write FRemoveKeyboard;
    /// <summary>
    /// Optional. Use this parameter if you want to remove the keyboard for specific
    /// users only. Targets: 1) users that are @mentioned in the text of the Message
    /// object; 2) if the bot's message is a reply (has reply_to_message_id), sender of
    /// the original message.
    ///
    /// Example: A user votes in a poll, bot returns confirmation message in reply to
    /// the vote and removes the keyboard for that user, while still showing the
    /// keyboard with poll options to users who haven't voted yet.
    /// </summary>
    property Selective: Boolean read FSelective write FSelective;
  end;
{$ENDREGION}
{$REGION 'Inline keyboards'}

  /// <summary>
  /// This object represents a parameter of the inline keyboard button used to
  /// automatically authorize a user. Serves as a great replacement for the Telegram
  /// Login Widget when the user is coming from Telegram. All the user needs to do is
  /// tap/click a button and confirm that they want to log in:
  ///
  /// TITLE
  /// Telegram apps support these buttons as of version 5.7.
  ///
  /// Sample bot: @discussbot
  /// </summary>
  TtgLoginUrl = class
  private
    [JsonName('url')]
    FUrl: string;
    [JsonName('forward_text')]
    FForwardText: string;
    [JsonName('bot_username')]
    FBotUsername: string;
    [JsonName('request_write_access')]
    FRequestWriteAccess: Boolean;
  public
    /// <summary>
    /// An HTTP URL to be opened with user authorization data added to the query string
    /// when the button is pressed. If the user refuses to provide authorization data,
    /// the original URL without information about the user will be opened. The data
    /// added is the same as described in Receiving authorization data.
    ///
    /// NOTE: You must always check the hash of the received data to verify the
    /// authentication and the integrity of the data as described in Checking
    /// authorization.
    /// </summary>
    property Url: string read FUrl write FUrl;
    /// <summary>
    /// Optional. New text of the button in forwarded messages.
    /// </summary>
    property ForwardText: string read FForwardText write FForwardText;
    /// <summary>
    /// Optional. Username of a bot, which will be used for user authorization. See
    /// Setting up a bot for more details. If not specified, the current bot's username
    /// will be assumed. The url's domain must be the same as the domain linked with
    /// the bot. See Linking your domain to the bot for more details.
    /// </summary>
    property BotUsername: string read FBotUsername write FBotUsername;
    /// <summary>
    /// Optional. Pass True to request the permission for your bot to send messages to
    /// the user.
    /// </summary>
    property RequestWriteAccess: Boolean read FRequestWriteAccess write FRequestWriteAccess;
  end;

  { TODO -oOwner -cGeneral : Создать объект }
  TtgCallbackGame = string;

  /// <summary>
  /// This object represents one button of an inline keyboard. You must use exactly
  /// one of the optional fields.
  /// </summary>
  TtgInlineKeyboardButton = class
  private
    [JsonName('text')]
    FText: string;
    [JsonName('url')]
    FUrl: string;
    [JsonName('login_url')]
    FLoginUrl: TtgLoginUrl;
    [JsonName('callback_data')]
    FCallbackData: string;
    [JsonName('switch_inline_query')]
    FSwitchInlineQuery: string;
    [JsonName('switch_inline_query_current_chat')]
    FSwitchInlineQueryCurrentChat: string;
    [JsonName('callback_game')]
    FCallbackGame: TtgCallbackGame;
    [JsonName('pay')]
    FPay: Boolean;
  public
    /// <summary>
    /// Label text on the button
    /// </summary>
    property Text: string read FText write FText;
    /// <summary>
    /// Optional. HTTP or tg:// url to be opened when button is pressed
    /// </summary>
    property Url: string read FUrl write FUrl;
    /// <summary>
    /// Optional. An HTTP URL used to automatically authorize the user. Can be used as
    /// a replacement for the Telegram Login Widget.
    /// </summary>
    property LoginUrl: TtgLoginUrl read FLoginUrl write FLoginUrl;
    /// <summary>
    /// Optional. Data to be sent in a callback query to the bot when button is pressed,
    /// 1-64 bytes
    /// </summary>
    property CallbackData: string read FCallbackData write FCallbackData;
    /// <summary>
    /// Optional. If set, pressing the button will prompt the user to select one of
    /// their chats, open that chat and insert the bot's username and the specified
    /// inline query in the input field. Can be empty, in which case just the bot's
    /// username will be inserted.
    ///
    /// Note: This offers an easy way for users to start using your bot in inline mode
    /// when they are currently in a private chat with it. Especially useful when
    /// combined with switch_pm… actions – in this case the user will be automatically
    /// returned to the chat they switched from, skipping the chat selection screen.
    /// </summary>
    property SwitchInlineQuery: string read FSwitchInlineQuery write FSwitchInlineQuery;
    /// <summary>
    /// Optional. If set, pressing the button will insert the bot's username and the
    /// specified inline query in the current chat's input field. Can be empty, in
    /// which case only the bot's username will be inserted.
    ///
    /// This offers a quick way for the user to open your bot in inline mode in the
    /// same chat – good for selecting something from multiple options.
    /// </summary>
    property SwitchInlineQueryCurrentChat: string read FSwitchInlineQueryCurrentChat
      write FSwitchInlineQueryCurrentChat;
    /// <summary>
    /// Optional. Description of the game that will be launched when the user presses
    /// the button.
    ///
    /// NOTE: This type of button must always be the first button in the first row.
    /// </summary>
    property CallbackGame: TtgCallbackGame read FCallbackGame write FCallbackGame;
    /// <summary>
    /// Optional. Specify True, to send a Pay button.
    ///
    /// NOTE: This type of button must always be the first button in the first row.
    /// </summary>
    property Pay: Boolean read FPay write FPay;
  end;

  /// <summary>
  /// This object represents an inline keyboard that appears right next to the
  /// message it belongs to.
  /// </summary>
  TtgInlineKeyboardMarkup = class
  private
    [JsonName('inline_keyboard')]
    FInlineKeyboard: TArray<TArray<TtgInlineKeyboardButton>>;
  public
    /// <summary>
    /// Array of button rows, each represented by an Array of InlineKeyboardButton
    /// objects
    /// </summary>
    property InlineKeyboard: TArray < TArray < TtgInlineKeyboardButton >> read FInlineKeyboard write FInlineKeyboard;
  end;
{$ENDREGION}

implementation

end.
