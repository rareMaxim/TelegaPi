unit TelegaPi;

interface

uses
  TelegramBotApi.Client,
  TelegramBotApi.Types,
  TelegramBotApi.Types.AvailableMethods,
  TelegramBotApi.Types.UpdatingMessages, TelegramBotApi.Types.Enums;

type
{$REGION ''}
{$ENDREGION}
  TTelegramBotApi = TelegramBotApi.Client.TTelegramBotApi;
{$REGION 'TelegramBotApi.Types.AvailableMethods'}
  TtgSendMessageArgument = TelegramBotApi.Types.AvailableMethods.TtgSendMessageArgument;
{$ENDREGION}
{$REGION 'Types.Request.UpdatingMessages'}
  TtgEditMessageTextArgument = TelegramBotApi.Types.UpdatingMessages.TtgEditMessageTextArgument;
  TtgEditMessageTextInlineArgument = TelegramBotApi.Types.UpdatingMessages.TtgEditMessageTextInlineArgument;
  TtgDeleteMessageArgument = TelegramBotApi.Types.UpdatingMessages.TtgDeleteMessageArgument;
{$ENDREGION}
{$REGION 'TelegramBotApi.Types'}
  TtgMessage = TelegramBotApi.Types.TtgMessage;
{$ENDREGION}
  TtgParseMode = TelegramBotApi.Types.Enums.TtgParseMode;
  TtgMessageType = TelegramBotApi.Types.Enums.TtgMessageType;

implementation

end.
