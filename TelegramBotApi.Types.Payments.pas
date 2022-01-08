unit TelegramBotApi.Types.Payments;

interface

uses
  CloudApi.Attributes,
  CloudApi.Types,
  System.JSON.Serializers,
  TelegramBotApi.Types.Abstract;

type
  /// <summary>
  /// This object represents a portion of the price for goods or services.
  /// </summary>
  TtgLabeledPrice = record
  private
    [JsonName('label')]
    FLabel: string;
    [JsonName('amount')]
    FAmount: Integer;
  public
    /// <summary>
    /// Portion label
    /// </summary>
    property &Label: string read FLabel write FLabel;
    /// <summary>
    /// Price of the product in the smallest units of the currency (integer, not
    /// float/double). For example, for a price of US$ 1.45 pass amount = 145. See the
    /// exp parameter in currencies.json, it shows the number of digits past the
    /// decimal point for each currency (2 for the majority of currencies).
    /// </summary>
    property Amount: Integer read FAmount write FAmount;
    class function Create(const ALabel: string; const AAmount: Integer): TtgLabeledPrice; static;
  end;

  /// <summary>
  /// Use this method to send invoices. On success, the sent Message is returned.
  /// </summary>
  [caName('sendInvoice')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.GetOrPost)]
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
    [caName('protect_content')]
    FProtectContent: Boolean;
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
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
  end;

implementation

class function TtgLabeledPrice.Create(const ALabel: string; const AAmount: Integer): TtgLabeledPrice;
begin
  Result.&Label := ALabel;
  Result.Amount := AAmount;
end;

end.
