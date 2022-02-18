unit Test.Integ.Config;

interface

uses
  TelegramBotApi.Types;

type
  TConfigFile = class
  private const
    FILE_CONFIG_NAME = 'config.json';
  private
    class var FCurrent: TConfigFile;
  private
    FBotToken: string;
    FSupergroupChat: TtgChat;
  public
    constructor Create;
    destructor Destroy; override;
    class constructor Create;
    class destructor Destroy;
    class function Current: TConfigFile;
    property BotToken: string read FBotToken write FBotToken;
    property SupergroupChat: TtgChat read FSupergroupChat write FSupergroupChat;
    class function Load(const AFileName: string): TConfigFile;
    procedure Save(const AFileName: string);
  end;

implementation

uses
  System.IOUtils,
  System.JSON.Serializers,
  System.SysUtils, System.JSON.Types;

class constructor TConfigFile.Create;
begin
  FCurrent := TConfigFile.Load(FILE_CONFIG_NAME);
end;

constructor TConfigFile.Create;
begin
  FSupergroupChat := TtgChat.Create;
end;

class function TConfigFile.Current: TConfigFile;
begin
  Result := FCurrent;
end;

destructor TConfigFile.Destroy;
begin
  FSupergroupChat.Free;
  inherited Destroy;
end;

class destructor TConfigFile.Destroy;
begin
  TConfigFile.FCurrent.Save(TConfigFile.FILE_CONFIG_NAME);
  TConfigFile.FCurrent.Free;
end;

class function TConfigFile.Load(const AFileName: string): TConfigFile;
var
  LJson: string;
  LSerializer: TJsonSerializer;
begin
  if not FileExists(AFileName) then
    Result := TConfigFile.Create;
  LSerializer := TJsonSerializer.Create;
  LJson := TFile.ReadAllText(AFileName, TEncoding.UTF8);
  try
    Result := LSerializer.Deserialize<TConfigFile>(LJson);
  finally
    LSerializer.Free;
  end;
end;

procedure TConfigFile.Save(const AFileName: string);
var
  LSerializer: TJsonSerializer;
  LJson: string;
begin
  LSerializer := TJsonSerializer.Create;
  try
    LSerializer.Formatting := TJsonFormatting.Indented;
    LJson := LSerializer.Serialize<TConfigFile>(Self);
    TFile.WriteAllText(AFileName, LJson, TEncoding.UTF8);
  finally
    LSerializer.Free;
  end;
end;

end.
