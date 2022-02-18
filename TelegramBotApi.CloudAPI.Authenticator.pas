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
