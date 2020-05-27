unit TelegramBotApi.CloudAPI.Authenticator;

interface

uses
  CloudAPI.IAuthenticator,
  CloudAPI.Request;

type
  TTelegramAuthenticator = class(TInterfacedObject, IAuthenticator)
  private
    FBotToken: string;
    function GetBotToken: string;
    procedure SetBotToken(const Value: string);
  public
    constructor Create(const ABotToken: string);
    procedure Authenticate(ARequest: IcaRequest);
    property BotToken: string read GetBotToken write SetBotToken;
  end;

implementation

constructor TTelegramAuthenticator.Create(const ABotToken: string);
begin
  inherited Create;
  FBotToken := ABotToken;
end;

procedure TTelegramAuthenticator.Authenticate(ARequest: IcaRequest);
begin
  ARequest.AddUrlSegment('token', FBotToken);
end;

function TTelegramAuthenticator.GetBotToken: string;
begin
  Result := FBotToken;
end;

procedure TTelegramAuthenticator.SetBotToken(const Value: string);
begin
  FBotToken := Value;
end;

end.
