unit TelegramBotApi.UpdateParser;

interface

uses
  TelegramBotApi.Types;

type
  TTgBotUpdateParser = class(TObject)
  private
  protected
    procedure EventParser(AUpdates: TArray<TtgUpdate>); virtual;
    procedure TypeUpdate(AUpdate: TtgUpdate); virtual;
    // События
    procedure DoOnUpdates(AUpdates: TArray<TtgUpdate>); virtual; abstract;
    procedure DoOnUpdate(AUpdate: TtgUpdate); virtual; abstract;
    procedure DoOnMessage(AMessage: TTgMessage); virtual; abstract;
    procedure DoOnInlineQuery(AInlineQuery: TtgInlineQuery); virtual; abstract;
    procedure DoOnChosenInlineResult(AChosenInlineResult: TtgChosenInlineResult); virtual; abstract;
    procedure DoOnCallbackQuery(ACallbackQuery: TtgCallbackQuery); virtual; abstract;
    procedure DoOnEditedMessage(AEditedMessage: TTgMessage); virtual; abstract;
    procedure DoOnChannelPost(AChannelPost: TTgMessage); virtual; abstract;
    procedure DoOnEditedChannelPost(AEditedChannelPost: TTgMessage); virtual; abstract;
    procedure DoOnShippingQuery(AShippingQuery: TtgShippingQuery); virtual; abstract;
    procedure DoOnPreCheckoutQuery(APreCheckoutQuery: TtgPreCheckoutQuery); virtual; abstract;
  public
    procedure ParseResponse(const JSON: string);
  end;

implementation

uses
  System.Generics.Collections,
  System.SysUtils,
  TelegramBotApi.Client,
  TelegramBotApi.Types.Enums;

{ TTgBotUpdateParser }

procedure TTgBotUpdateParser.EventParser(AUpdates: TArray<TtgUpdate>);
var
  LUpdate: TtgUpdate;
begin
  DoOnUpdates(AUpdates);
  for LUpdate in AUpdates do
  begin
    DoOnUpdate(LUpdate);
    TypeUpdate(LUpdate);
  end;
end;

procedure TTgBotUpdateParser.ParseResponse(const JSON: string);
var
  LUpdates: ItgResponse<TArray<TtgUpdate>>;
begin
  LUpdates := TTelegramBotApi.GetUpdates(JSON);
  EventParser(LUpdates.Result);
end;

procedure TTgBotUpdateParser.TypeUpdate(AUpdate: TtgUpdate);
begin
  case AUpdate.&Type of
    TtgUpdateType.MessageUpdate:
      DoOnMessage(AUpdate.Message);

    TtgUpdateType.InlineQueryUpdate:
      DoOnInlineQuery(AUpdate.InlineQuery);

    TtgUpdateType.ChosenInlineResultUpdate:
      DoOnChosenInlineResult(AUpdate.ChosenInlineResult);

    TtgUpdateType.CallbackQueryUpdate:
      DoOnCallbackQuery(AUpdate.CallbackQuery);

    TtgUpdateType.EditedMessage:
      DoOnEditedMessage(AUpdate.EditedMessage);

    TtgUpdateType.ChannelPost:
      DoOnChannelPost(AUpdate.ChannelPost);

    TtgUpdateType.EditedChannelPost:
      DoOnEditedChannelPost(AUpdate.EditedChannelPost);

    TtgUpdateType.ShippingQueryUpdate:
      DoOnShippingQuery(AUpdate.ShippingQuery);

    TtgUpdateType.PreCheckoutQueryUpdate:
      DoOnPreCheckoutQuery(AUpdate.PreCheckoutQuery);
  end;
end;

end.
