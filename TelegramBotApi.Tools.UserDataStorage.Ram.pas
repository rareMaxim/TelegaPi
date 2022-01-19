unit TelegramBotApi.Tools.UserDataStorage.Ram;

interface

uses
  System.Generics.Collections,
  TelegramBotApi.Tools.UserDataStorage.Abstract;

type

  TtgUserDataStorage = class(TtgUserDataStorageAbstract)
  protected type
    TData = TDictionary<Int64, TDictionary<string, string>>;
  protected
    FData: TData;
    function GetData(const AID: Int64; const AKey: string): string; override;
    procedure SetData(const AID: Int64; const AKey: string; const Value: string); override;
  public
    constructor Create; virtual;
    destructor Destroy; override;
  end;

implementation

{ TtgUserDataStorageRAM }

constructor TtgUserDataStorage.Create;
begin
  FData := TObjectDictionary < Int64, TDictionary < string, string >>.Create;
end;

destructor TtgUserDataStorage.Destroy;
begin
  FData.Free;
  inherited;
end;

function TtgUserDataStorage.GetData(const AID: Int64; const AKey: string): string;
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

procedure TtgUserDataStorage.SetData(const AID: Int64; const AKey, Value: string);
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
