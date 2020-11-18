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

  TtgReplyKeyboardMarkup = class
  private
    [JsonName('keyboard')]
    FKeyboard: TArray<TArray<TtgKeyboardButton>>;
    [JsonName('resize_keyboard')]
    FResizeKeyboard: Boolean;
  public
    property Keyboard: TArray < TArray < TtgKeyboardButton >> read FKeyboard write FKeyboard;
    property ResizeKeyboard: Boolean read FResizeKeyboard write FResizeKeyboard;
  end;

  TtgInlineKeyboardMarkup = class
    { TODO -oOwner -cGeneral : Заполнить }
  end;

implementation

end.
