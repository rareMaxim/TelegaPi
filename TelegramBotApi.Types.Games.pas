unit TelegramBotApi.Types.Games;

interface

uses
  CloudApi.Attributes,
  CloudApi.Types,
  System.JSON.Serializers,
  TelegramBotApi.Types.Abstract;

type

  /// <summary>
  /// Use this method to send a game. On success, the sent Message is returned.
  /// </summary>
  [caName('sendGame')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.GetOrPost)]
  TtgSendGameArgument = class(TtgSendMessageBase)
  private
    [caName('game_short_name')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FGameShortName: string;
    [caName('protect_content')]
    FProtectContent: Boolean;
  public
    property ChatId;
    /// <summary>
    /// Short name of the game, serves as the unique identifier for the game. Set up
    /// your games via Botfather.
    /// </summary>
    property GameShortName: string read FGameShortName write FGameShortName;
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
  end;

implementation

end.
