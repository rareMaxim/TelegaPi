unit TelegramBotApi.Tools.UserDataStorage.Json;

interface

uses
  TelegramBotApi.Tools.UserDataStorage.Ram,
  System.Json.Serializers,
  System.Generics.Collections;

type
  TtgUserDataStorage = class(TelegramBotApi.Tools.UserDataStorage.Ram.TtgUserDataStorage)
  private
    FSerializer: TJsonSerializer;
    FFileName: string;
  protected
    procedure LoadFromFile(const AFileName: string);
    procedure SaveToFile(const AFileName: string);
  public
    destructor Destroy; override;
    constructor Create(const AFileName: string); reintroduce;
  end;

implementation

uses
  System.IOUtils,
  System.Json.Types,
  System.SysUtils;

{ TtgUserDataStorageJson }

constructor TtgUserDataStorage.Create(const AFileName: string);
begin
  inherited Create;
  FSerializer := TJsonSerializer.Create;
  FSerializer.Formatting := TJsonFormatting.Indented;
  LoadFromFile(AFileName);
end;

destructor TtgUserDataStorage.Destroy;
begin
  SaveToFile(FFileName);
  FSerializer.Free;
  inherited Destroy;
end;

procedure TtgUserDataStorage.LoadFromFile(const AFileName: string);
var
  lFileSource: string;
begin
  FFileName := AFileName;
  lFileSource := TFile.ReadAllText(AFileName);
  FSerializer.Populate<TtgUserDataStorage.TData>(lFileSource, FData);
end;

procedure TtgUserDataStorage.SaveToFile(const AFileName: string);
var
  lFileSource: string;
begin
  lFileSource := FSerializer.Serialize<TtgUserDataStorage.TData>(FData);
  TFile.WriteAllText(AFileName, lFileSource, TEncoding.UTF8);
end;

end.
