unit Test.Config;

interface

uses
  TelegramBotApi.Types;

type
  TConfigFile = class
  private
    FBotToken: string;
    FSupergroupChatID: Int64;
    FChannelChatId: string;
  public
    property BotToken: string read FBotToken write FBotToken;
    property SupergroupChatID: Int64 read FSupergroupChatID write FSupergroupChatID;
    property ChannelChatId: string read FChannelChatId write FChannelChatId;
    class function Load(const AFileName: string): TConfigFile;
    procedure Save(const AFileName: string);
  end;

implementation

uses
  System.IOUtils,
  System.JSON.Serializers,
  System.SysUtils,
  System.JSON.Types;

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
