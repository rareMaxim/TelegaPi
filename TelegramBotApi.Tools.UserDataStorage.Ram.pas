{***************************************************************************}
{                                                                           }
{           TelegaPi                                                        }
{                                                                           }
{           Copyright (C) 2021 Maxim Sysoev                                 }
{                                                                           }
{           https://t.me/CloudAPI                                           }
{                                                                           }
{                                                                           }
{***************************************************************************}
{                                                                           }
{  Licensed under the Apache License, Version 2.0 (the "License");          }
{  you may not use this file except in compliance with the License.         }
{  You may obtain a copy of the License at                                  }
{                                                                           }
{      http://www.apache.org/licenses/LICENSE-2.0                           }
{                                                                           }
{  Unless required by applicable law or agreed to in writing, software      }
{  distributed under the License is distributed on an "AS IS" BASIS,        }
{  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{  See the License for the specific language governing permissions and      }
{  limitations under the License.                                           }
{                                                                           }
{***************************************************************************}

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
    function Count: Integer;
    constructor Create; virtual;
    destructor Destroy; override;
    function GetUsers: TArray<Int64>;
  end;

implementation

{ TtgUserDataStorageRAM }

function TtgUserDataStorage.Count: Integer;
begin
  Result := FData.Count;
end;

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

function TtgUserDataStorage.GetUsers: TArray<Int64>;
begin
  for var LUser in FData do
    Result := Result + [LUser.Key];
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
