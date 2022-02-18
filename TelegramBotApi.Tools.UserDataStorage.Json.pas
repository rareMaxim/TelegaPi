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
