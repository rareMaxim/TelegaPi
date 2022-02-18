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

unit TelegramBotApi.Types.Games;

interface

uses
  CloudApi.Attributes,
  CloudApi.Types,
  System.JSON.Serializers,
  TelegramBotApi.Types.Abstract;

type

  /// <summary>
  /// Use this method to send a game. On success, the sent Message is returned.
  /// </summary>
  [caName('sendGame')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.GetOrPost)]
  TtgSendGameArgument = class(TtgSendMessageBase)
  private
    [caName('game_short_name')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FGameShortName: string;
    [caName('protect_content')]
    FProtectContent: Boolean;
  public
    property ChatId;
    /// <summary>
    /// Short name of the game, serves as the unique identifier for the game. Set up
    /// your games via Botfather.
    /// </summary>
    property GameShortName: string read FGameShortName write FGameShortName;
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
  end;

implementation

end.
