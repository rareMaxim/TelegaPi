unit TelegramBotApi.Types.Keyboards;

interface

uses
  System.JSON.Serializers;

type

  /// <summary>
  /// This object represents type of a poll, which is allowed to be created and sent
  /// when the corresponding button is pressed.
  /// </summary>
  TtgKeyboardButtonPollType = class
  private
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
    [JsonName('can_join_groups')]
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

  TtgInlineKeyboardMarkup = class
    { TODO -oOwner -cGeneral : Заполнить }
  end;

implementation

end.
