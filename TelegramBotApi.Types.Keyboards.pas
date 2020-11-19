unit TelegramBotApi.Types.Keyboards;

interface

uses
  System.JSON.Serializers;

type
  TtgKeyboardButton = class
  private
    [JsonName('can_join_groups')]
    FText: string;
    [JsonName('request_contact')]
    FRequestContact: Boolean;
    [JsonName('request_location')]
    FRequestLocation: Boolean;
  public
    property Text: string read FText write FText;
    property RequestContact: Boolean read FRequestContact write FRequestContact;
    property RequestLocation: Boolean read FRequestLocation write FRequestLocation;
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
