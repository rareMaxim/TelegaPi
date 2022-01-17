unit TelegramBotApi.Tools.UserDataStorage;

interface

uses
  System.Generics.Collections;

type
  TtgUserDataStorageAbstract = class abstract
  protected
    function GetData(const AID: Int64; const AKey: string): string; virtual; abstract;
    procedure SetData(const AID: Int64; const AKey, Value: string); virtual; abstract;
  public
    property Data[const AID: Int64; const AKey: string]: string read GetData write SetData; default;
  end;

  TtgUserDataStorageRAM = class(TtgUserDataStorageAbstract)
  private
    FData: TDictionary<Int64, TDictionary<string, string>>;
  protected
    function GetData(const AID: Int64; const AKey: string): string; override;
    procedure SetData(const AID: Int64; const AKey: string; const Value: string); override;
  public
    constructor Create;
    destructor Destroy; override;
  end;

implementation

{ TtgUserDataStorageRAM }

constructor TtgUserDataStorageRAM.Create;
begin
  FData := TObjectDictionary < Int64, TDictionary < string, string >>.Create;
end;

destructor TtgUserDataStorageRAM.Destroy;
begin
  FData.Free;
  inherited;
end;

function TtgUserDataStorageRAM.GetData(const AID: Int64; const AKey: string): string;
var
  LData: TDictionary<string, string>;
begin
  Result := '';
  if not FData.TryGetValue(AID, LData) then
  begin
    LData := TDictionary<string, string>.Create;
    FData.Add(AID, LData);
  end;
  if not LData.TryGetValue(AKey, Result) then
  begin
    LData.AddOrSetValue(AKey, Result);
  end;
end;

procedure TtgUserDataStorageRAM.SetData(const AID: Int64; const AKey, Value: string);
var
  LData: TDictionary<string, string>;
begin
  if not FData.TryGetValue(AID, LData) then
  begin
    LData := TDictionary<string, string>.Create;
    FData.Add(AID, LData);
  end;
  LData.AddOrSetValue(AKey, Value);
end;

end.
