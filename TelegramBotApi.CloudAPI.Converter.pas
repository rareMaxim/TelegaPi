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

unit TelegramBotApi.CloudAPI.Converter;

interface

uses
  System.SysUtils,
  System.Rtti;

type
  TtgConverters = class
  protected
    class procedure TtgUserLinkConverter;
    class procedure TtgParseModeConverter;
    class procedure TtgAllowedUpdatesConverter;
    class procedure TtgChatActionConverter;
  public
    class procedure TelegramConverter;
  end;

implementation

uses
  CloudAPI.Client.Base,
  CloudAPI.Types,
  CloudAPI.RequestArgument,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Enums,
  TelegramBotApi.Types.Helpers,
  TelegramBotApi.Types.Keyboards,
  TelegramBotApi.Types.Payments;
{ TtgConverters }

class procedure TtgConverters.TtgAllowedUpdatesConverter;
begin
  TcaRequestArgument.Current.RegisterConverter<TAllowedUpdates>(
    function(AValue: TValue): string
    begin
      Result := AValue.AsType<TAllowedUpdates>.ToString;
    end);
end;

class procedure TtgConverters.TtgChatActionConverter;
begin
  TcaRequestArgument.Current.RegisterConverter<TtgChatAction>(
    function(AValue: TValue): string
    begin
      Result := AValue.AsType<TtgChatAction>.ToString;
    end);
end;

class procedure TtgConverters.TelegramConverter;
begin
  TtgUserLinkConverter;
  TtgParseModeConverter;
  TtgAllowedUpdatesConverter;
  TtgChatActionConverter;

  TcaRequestArgument.Current.RegisterToJson<TArray<TtgBotCommand>>;
  TcaRequestArgument.Current.RegisterToJson<TArray<TcaFileToSend>>;
  TcaRequestArgument.Current.RegisterToJson<TArray<TtgInputMedia>>;
  TcaRequestArgument.Current.RegisterToJson<TtgBotCommandScopeDefault>;
  TcaRequestArgument.Current.RegisterToJson<TtgBotCommandScopeAllPrivateChats>;
  TcaRequestArgument.Current.RegisterToJson<TtgBotCommandScopeAllGroupChats>;
  TcaRequestArgument.Current.RegisterToJson<TtgBotCommandScopeAllChatAdministrators>;
  TcaRequestArgument.Current.RegisterToJson<TtgBotCommandScopeChat>;
  TcaRequestArgument.Current.RegisterToJson<TtgBotCommandScopeChatAdministrators>;
  TcaRequestArgument.Current.RegisterToJson<TtgBotCommandScopeChatMember>;
  TcaRequestArgument.Current.RegisterToJson<TtgInlineKeyboardMarkup>;
  TcaRequestArgument.Current.RegisterToJson<TtgReplyKeyboardMarkup>;
  TcaRequestArgument.Current.RegisterToJson<TtgReplyKeyboardRemove>;
  TcaRequestArgument.Current.RegisterToJson<TtgForceReply>;
  TcaRequestArgument.Current.RegisterToJson<TArray<TtgLabeledPrice>>;
end;

class procedure TtgConverters.TtgParseModeConverter;
begin
  TcaRequestArgument.Current.RegisterConverter<TtgParseMode>(
    function(AValue: TValue): string
    var
      lVal: TtgParseMode;
    begin
      lVal := AValue.AsType<TtgParseMode>;
      case lVal of
        TtgParseMode.Default:
          Result := '';
        TtgParseMode.Markdown:
          Result := 'Markdown';
        TtgParseMode.Markdownv2:
          Result := 'MarkdownV2';
        TtgParseMode.HTML:
          Result := 'HTML';
      else
        begin
          raise Exception.Create(TRttiEnumerationType.GetName(lVal));
        end;
      end;
    end);
end;

class procedure TtgConverters.TtgUserLinkConverter;
begin
  TcaRequestArgument.Current.RegisterConverter<TtgUserLink>(
    function(AValue: TValue): string
    begin
      Result := AValue.AsType<TtgUserLink>.ToString;
    end);
end;

end.
