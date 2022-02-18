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

unit TelegaPi;

interface

uses
  TelegramBotApi.Client,
  TelegramBotApi.Polling.Console,
  TelegramBotApi.Ext.Calendar,
  TelegramBotApi.Tools.Router,
  TelegramBotApi.Types,
  TelegramBotApi.Types.AvailableMethods,
  TelegramBotApi.Types.Enums,
  TelegramBotApi.Types.Games,
  TelegramBotApi.Types.Keyboards,
  TelegramBotApi.Types.Payments,
  TelegramBotApi.Types.UpdatingMessages;

type
{$REGION ''}
{$ENDREGION}
  TTelegramBotApi = TelegramBotApi.Client.TTelegramBotApi;
{$REGION 'TelegramBotApi.Types.AvailableMethods'}
  TtgSendMessageArgument = TelegramBotApi.Types.AvailableMethods.TtgSendMessageArgument;
  TtgSendChatActionArgument = TelegramBotApi.Types.AvailableMethods.TtgSendChatActionArgument;
  TtgSendPhotoArgument = TelegramBotApi.Types.AvailableMethods.TtgSendPhotoArgument;
  TtgSendVideoArgument = TelegramBotApi.Types.AvailableMethods.TtgSendVideoArgument;
  TtgSendVideoNoteArgument = TelegramBotApi.Types.AvailableMethods.TtgSendVideoNoteArgument;
  TtgSendAnimationArgument = TelegramBotApi.Types.AvailableMethods.TtgSendAnimationArgument;
  TtgSendAudioArgument = TelegramBotApi.Types.AvailableMethods.TtgSendAudioArgument;
  TtgSendVoiceArgument = TelegramBotApi.Types.AvailableMethods.TtgSendVoiceArgument;
  TtgSendDocumentArgument = TelegramBotApi.Types.AvailableMethods.TtgSendDocumentArgument;
  TtgSendStickerArgument = TelegramBotApi.Types.AvailableMethods.TtgSendStickerArgument;
  TtgSendLocationArgument = TelegramBotApi.Types.AvailableMethods.TtgSendLocationArgument;
  TtgSendVenueArgument = TelegramBotApi.Types.AvailableMethods.TtgSendVenueArgument;
  TtgSendContactArgument = TelegramBotApi.Types.AvailableMethods.TtgSendContactArgument;
  TtgSendPollArgument = TelegramBotApi.Types.AvailableMethods.TtgSendPollArgument;
  TtgSendDiceArgument = TelegramBotApi.Types.AvailableMethods.TtgSendDiceArgument;
  TtgSendMediaGroupArgument = TelegramBotApi.Types.AvailableMethods.TtgSendMediaGroupArgument;
  TtgCopyMessageArgument = TelegramBotApi.Types.AvailableMethods.TtgCopyMessageArgument;
  TtgForwardMessageArgument = TelegramBotApi.Types.AvailableMethods.TtgForwardMessageArgument;
{$ENDREGION}
{$REGION 'TelegramBotApi.Types.Payments'}
  TtgSendInvoiceArgument = TelegramBotApi.Types.Payments.TtgSendInvoiceArgument;
  TtgLabeledPrice = TelegramBotApi.Types.Payments.TtgLabeledPrice;
{$ENDREGION}
{$REGION 'TelegramBotApi.Types.Games'}
  TtgSendGameArgument = TelegramBotApi.Types.Games.TtgSendGameArgument;
{$ENDREGION}
{$REGION 'Types.Request.UpdatingMessages'}
  TtgEditMessageTextArgument = TelegramBotApi.Types.UpdatingMessages.TtgEditMessageTextArgument;
  TtgEditMessageTextInlineArgument = TelegramBotApi.Types.UpdatingMessages.TtgEditMessageTextInlineArgument;
  TtgDeleteMessageArgument = TelegramBotApi.Types.UpdatingMessages.TtgDeleteMessageArgument;
{$ENDREGION}
{$REGION 'TelegramBotApi.Types'}
  TtgMessage = TelegramBotApi.Types.TtgMessage;
  TtgUpdate = TelegramBotApi.Types.TtgUpdate;
  TtgCallbackQuery = TelegramBotApi.Types.TtgCallbackQuery;
{$ENDREGION}
  TtgParseMode = TelegramBotApi.Types.Enums.TtgParseMode;
  TtgMessageType = TelegramBotApi.Types.Enums.TtgMessageType;
  TtgPollingConsole = TelegramBotApi.Polling.Console.TtgPollingConsole;
  TtgUserLink = TelegramBotApi.Types.TtgUserLink;
  TtgUser = TelegramBotApi.Types.TtgUser;
  TtgChatAction = TelegramBotApi.Types.Enums.TtgChatAction;
  TtgReplyKeyboardMarkup = TelegramBotApi.Types.Keyboards.TtgReplyKeyboardMarkup;
  TtgKeyboardButton = TelegramBotApi.Types.Keyboards.TtgKeyboardButton;
  TtgKeyboardButtonPool = TelegramBotApi.Types.Keyboards.TtgKeyboardButtonPool;
  TtgKeyboardBuilder = TelegramBotApi.Types.Keyboards.TtgKeyboardBuilder;
  TtgRoute = TelegramBotApi.Tools.Router.TtgRoute;
  TtgRouter = TelegramBotApi.Tools.Router.TtgRouter;
  TtgCalendarControl = TelegramBotApi.Ext.Calendar.TtgCalendarControl;

implementation

end.
