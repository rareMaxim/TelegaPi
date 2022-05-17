unit TelegramBotApi.Types.WebApps;

interface

uses
  System.JSON.Serializers;

type
  // Contains information about a Web App.
  TtgWebAppInfo = class
  private
    [JsonName('text')]
    FUrl: string;
  public
    // An HTTPS URL of a Web App to be opened with additional data
    // as specified in Initializing Web Apps
    property Url: string read FUrl write FUrl;
  end;

  TtgMenuButtonAbstract = class
  private
    [JsonName('type')]
    FType: string;
  public
    constructor Create; virtual; abstract;
    property &Type: string read FType write FType;
  end;

  // Represents a menu button, which opens the bot's list of commands.
  TtgMenuButtonCommands = class(TtgMenuButtonAbstract)
  public
    constructor Create; override;
  end;

  // Represents a menu button, which launches a Web App.
  TtgMenuButtonWebApp = class(TtgMenuButtonAbstract)
  private
    [JsonName('text')]
    FText: string;
    [JsonName('web_app')]
    FWebApp: TtgWebAppInfo;
  public
    constructor Create; override;
    destructor Destroy; override;
    // Text on the button
    property Text: string read FText write FText;
    // Description of the Web App that will be launched when the user presses the button.
    // The Web App will be able to send an arbitrary message on behalf of the user using the method answerWebAppQuery.
    property WebApp: TtgWebAppInfo read FWebApp write FWebApp;
  end;

  // Describes that no specific value for the menu button was set.
  TtgMenuButtonDefault = class(TtgMenuButtonAbstract)
  public
    constructor Create; override;
  end;

  TtgMenuButton = class(TtgMenuButtonWebApp);

  TtgSentWebAppMessage = class
  private
    FInlineMessageId: Int64;
  public
    property InlineMessageId: Int64 read FInlineMessageId write FInlineMessageId;
  end;

implementation

{ TtgMenuButtonCommands }

constructor TtgMenuButtonCommands.Create;
begin
  FType := 'commands';
end;

{ TtgMenuButtonWebApp }

constructor TtgMenuButtonWebApp.Create;
begin
  FType := 'web_app';
  FWebApp := TtgWebAppInfo.Create;
end;

destructor TtgMenuButtonWebApp.Destroy;
begin
  FWebApp.Free;
  inherited;
end;

{ TtgMenuButtonDefault }

constructor TtgMenuButtonDefault.Create;
begin
  FType := 'default';
end;

end.
