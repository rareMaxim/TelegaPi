unit TelegramBotApi.Json.Converter;

interface

uses
  System.Json.Serializers,
  System.Json.Readers,
  System.Json.Writers,
  System.TypInfo,
  System.Rtti;

type
  TtgMessageEntityTypeConverter = class(TJsonConverter)
  public
    function ReadJson(const AReader: TJsonReader; ATypeInf: PTypeInfo; const AExistingValue: TValue;
      const ASerializer: TJsonSerializer): TValue; override;
    procedure WriteJson(const AWriter: TJsonWriter; const AValue: TValue; const ASerializer: TJsonSerializer); override;
    function CanConvert(ATypeInf: PTypeInfo): Boolean; override;
  end;

  TtgParseModeConverter = class(TJsonConverter)
  public
    function ReadJson(const AReader: TJsonReader; ATypeInf: PTypeInfo; const AExistingValue: TValue;
      const ASerializer: TJsonSerializer): TValue; override;
    procedure WriteJson(const AWriter: TJsonWriter; const AValue: TValue; const ASerializer: TJsonSerializer); override;
    function CanConvert(ATypeInf: PTypeInfo): Boolean; override;
  end;

implementation

uses
  System.SysUtils,
  TelegramBotApi.Types.Enums,
  TelegramBotApi.Types.Helpers;
{ TtgMessageEntityTypeConverter }

function TtgMessageEntityTypeConverter.CanConvert(ATypeInf: PTypeInfo): Boolean;
begin
  Result := ATypeInf^.Name = 'TtgMessageEntityType';
end;

function TtgMessageEntityTypeConverter.ReadJson(const AReader: TJsonReader; ATypeInf: PTypeInfo;
  const AExistingValue: TValue; const ASerializer: TJsonSerializer): TValue;
var
  LEnumValue: TtgMessageEntityType;
begin
  LEnumValue := TtgMessageEntityType.FromString(AReader.Value.AsString);
  TValue.Make(@LEnumValue, ATypeInf, Result);
end;

procedure TtgMessageEntityTypeConverter.WriteJson(const AWriter: TJsonWriter; const AValue: TValue;
  const ASerializer: TJsonSerializer);
begin
  AWriter.WriteValue(AValue.AsType<TtgMessageEntityType>.ToString);
end;

{ TtgParseModeConverter }

function TtgParseModeConverter.CanConvert(ATypeInf: PTypeInfo): Boolean;
begin
  Result := ATypeInf^.Name = 'TtgParseMode';
end;

function TtgParseModeConverter.ReadJson(const AReader: TJsonReader; ATypeInf: PTypeInfo; const AExistingValue: TValue;
  const ASerializer: TJsonSerializer): TValue;
var
  LEnumValue: TtgParseMode;
begin
  LEnumValue := TtgParseMode.FromString(AReader.Value.AsString);
  TValue.Make(@LEnumValue, ATypeInf, Result);
end;

procedure TtgParseModeConverter.WriteJson(const AWriter: TJsonWriter; const AValue: TValue;
  const ASerializer: TJsonSerializer);
begin
  AWriter.WriteValue(AValue.AsType<TtgParseMode>.ToString);
end;

end.
