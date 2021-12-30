unit TelegramBotApi.Types.AvailableMethods;

interface

uses
  CloudAPI.Attributes,
  CloudAPI.Types,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Core;

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

end.
