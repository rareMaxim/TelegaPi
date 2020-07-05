unit TelegramBotApi.Types;

interface

uses
  CloudAPI.Json.Converters,
  CloudAPI.Types,
  System.Generics.Collections,
  System.Json.Converters,
  System.Json.Serializers,
  TelegramBotApi.Json.Converter,
  TelegramBotApi.Types.Enums,
  TelegramBotApi.Types.Intf;

type
  TtgUser = class(TInterfacedObject, itgUser)
  private
    [JsonName('can_join_groups')]
    FCanJoinGroups: Boolean;
    [JsonName('can_read_all_group_messages')]
    FCanReadAllGroupMessages: Boolean;
    [JsonName('first_name')]
    FFirstName: string;
    [JsonName('id')]
    FID: Int64;
    [JsonName('is_bot')]
    FIsBot: Boolean;
    [JsonName('language_code')]
    FLanguageCode: string;
    [JsonName('last_name')]
    FLastName: string;
    [JsonName('supports_inline_queries')]
    FSupportsInlineQueries: Boolean;
    [JsonName('username')]
    FUsername: string;
    function GetCanJoinGroups: Boolean;
    function GetCanReadAllGroupMessages: Boolean;
    function GetFirstName: string;
    function GetID: Int64;
    function GetIsBot: Boolean;
    function GetLanguageCode: string;
    function GetLastName: string;
    function GetSupportsInlineQueries: Boolean;
    function GetUsername: string;
  public
    property CanJoinGroups: Boolean read GetCanJoinGroups;
    property CanReadAllGroupMessages: Boolean read GetCanReadAllGroupMessages;
    property FirstName: string read GetFirstName;
    property ID: Int64 read GetID;
    property IsBot: Boolean read GetIsBot;
    property LanguageCode: string read GetLanguageCode;
    property LastName: string read GetLastName;
    property SupportsInlineQueries: Boolean read GetSupportsInlineQueries;
    property Username: string read GetUsername;
  end;

  TtgChat = class;

  TtgMessageEntity = class
  private
    [JsonName('language')]
    FLanguage: string;
    [JsonName('user')]
    FUser: TtgUser;
    [JsonName('url')]
    FUrl: string;
    [JsonName('length')]
    FLength: Int64;
    [JsonName('offset')]
    FOffset: Int64;
    [JsonName('type')]
    [JsonConverter(TtgMessageEntityTypeConverter)]
    FType: TtgMessageEntityType;
  public
    constructor Create;
    destructor Destroy; override;
    property &Type: TtgMessageEntityType read FType write FType;
    property Offset: Int64 read FOffset write FOffset;
    property Length: Int64 read FLength write FLength;
    property Url: string read FUrl write FUrl;
    property User: TtgUser read FUser write FUser;
    property Language: string read FLanguage write FLanguage;
  end;

  TtgMessage = class
  private type
    TMessEntConv = class(TJsonListConverter<TtgMessageEntity>);
  private
    [JsonName('chat')]
    FChat: TtgChat;
    [JsonName('message_id')]
    FMessageID: Int64;
    [JsonName('from')]
    FFrom: TtgUser;
    [JsonName('text')]
    FText: string;
    [JsonName('date')]
    [JsonConverter(TJsonUnixTimeConverter)]
    FDate: TDateTime;
    [JsonName('forward_from_chat')]
    FForwardFromChat: TtgChat;
    [JsonName('forward_from_message_id')]
    FForwardFromMessageId: Int64;
    [JsonName('forward_signature')]
    FForwardSignature: string;
    [JsonName('forward_date')]
    [JsonConverter(TJsonUnixTimeConverter)]
    FForwardDate: TDateTime;
    [JsonName('entities')]
    [JsonConverter(TMessEntConv)]
    FEntities: TObjectList<TtgMessageEntity>;
    //
  public
    constructor Create;
    destructor Destroy; override;
    function &Type: TtgMessageType;
  public
    property MessageID: Int64 read FMessageID write FMessageID;
    property Chat: TtgChat read FChat write FChat;
    property ForwardFromChat: TtgChat read FForwardFromChat write FForwardFromChat;
    property ForwardFromMessageId: Int64 read FForwardFromMessageId write FForwardFromMessageId;
    property ForwardSignature: string read FForwardSignature write FForwardSignature;
    property ForwardDate: TDateTime read FForwardDate write FForwardDate;
    property From: TtgUser read FFrom write FFrom;
    property Date: TDateTime read FDate write FDate;
    property Text: string read FText write FText;
    property Entities: TObjectList<TtgMessageEntity> read FEntities write FEntities;
  end;

  TtgChat = class
  private
    [JsonName('id')]
    FID: Int64;
    [JsonName('type')]
    FType: string;
    [JsonName('title')]
    Ftitle: string;
    [JsonName('username')]
    FUsername: string;
    [JsonName('first_name')]
    FFirstName: string;
    [JsonName('last_name')]
    FLastName: string;
    [JsonName('photo')]
    FPhoto: TObject;
    [JsonName('description')]
    FDescription: string;
    [JsonName('invite_link')]
    FInviteLink: string;
    [JsonName('pinned_message')]
    FPinnedMessage: TtgMessage;
    [JsonName('slow_mode_delay')]
    FSlowModeDelay: Int64;
    [JsonName('sticker_set_name')]
    FStickerSetName: string;
    [JsonName('can_set_sticker_set')]
    FCanSetStickerSet: Boolean;
  public
    property ID: Int64 read FID write FID;
    property &Type: string read FType write FType;
    property Title: string read Ftitle write Ftitle;
    property Username: string read FUsername write FUsername;
    property FirstName: string read FFirstName write FFirstName;
    property LastName: string read FLastName write FLastName;
    property Photo: TObject read FPhoto write FPhoto;
    property Description: string read FDescription write FDescription;
    property InviteLink: string read FInviteLink write FInviteLink;
    property PinnedMessage: TtgMessage read FPinnedMessage write FPinnedMessage;
    property SlowModeDelay: Int64 read FSlowModeDelay write FSlowModeDelay;
    property StickerSetName: string read FStickerSetName write FStickerSetName;
    property CanSetStickerSet: Boolean read FCanSetStickerSet write FCanSetStickerSet;
  end;

  TtgInlineQuery = class

  end;

  TtgAnswerInlineQuery = class

  end;

  TtgChosenInlineResult = class

  end;

  TtgCallbackQuery = class

  end;

  TtgShippingQuery = class

  end;

  TtgPreCheckoutQuery = class

  end;

  TtgPoll = class

  end;

  TtgPollAnswer = class

  end;

  TtgUpdate = class
  private
    [JsonName('update_id')]
    FUpdateID: Int64;
    [JsonName('message')]
    FMessage: TtgMessage;
    [JsonName('edited_message')]
    FEditedMessage: TtgMessage;
    [JsonName('channel_post')]
    FChannelPost: TtgMessage;
    [JsonName('edited_channel_post')]
    FEditedChannelPost: TtgMessage;
    [JsonName('inline_query')]
    FInlineQuery: TtgInlineQuery;
    [JsonName('chosen_inline_result')]
    FChosenInlineResult: TtgChosenInlineResult;
    [JsonName('callback_query')]
    FCallbackQuery: TtgCallbackQuery;
    [JsonName('shipping_query')]
    FShippingQuery: TtgShippingQuery;
    [JsonName('pre_checkout_query')]
    FPreCheckoutQuery: TtgPreCheckoutQuery;
    [JsonName('poll')]
    FPoll: TtgPoll;
    [JsonName('poll_answer')]
    FPollAnswer: TtgPollAnswer;
  public
    constructor Create;
    destructor Destroy; override;
    function &Type: TtgUpdateType;
    /// <summary>
    /// The update‘s unique identifier. Update identifiers start from a certain
    /// positive number and increase sequentially. This ID becomes especially handy if
    /// you’re using Webhooks, since it allows you to ignore repeated updates or to
    /// restore the correct update sequence, should they get out of order. If there are
    /// no new updates for at least a week, then identifier of the next update will be
    /// chosen randomly instead of sequentially.
    /// </summary>
    property UpdateID: Int64 read FUpdateID write FUpdateID;
    /// <summary>Optional. New incoming message of any kind — text, photo, sticker, etc.
    /// </summary>
    property &Message: TtgMessage read FMessage write FMessage;
    /// <summary>Optional. New version of a message that is known to the bot and was
    /// edited</summary>
    property EditedMessage: TtgMessage read FEditedMessage write FEditedMessage;
    /// <summary>Optional. New incoming channel post of any kind — text, photo, sticker,
    /// etc.
    /// </summary>
    property ChannelPost: TtgMessage read FChannelPost write FChannelPost;
    /// <summary>Optional. New version of a channel post that is known to the bot and
    /// was edited</summary>
    property EditedChannelPost: TtgMessage read FEditedChannelPost write FEditedChannelPost;
    /// <summary>Optional. New incoming inline query</summary>
    property InlineQuery: TtgInlineQuery read FInlineQuery write FInlineQuery;
    /// <summary>Optional. The result of an inline query that was chosen by a user and
    /// sent to their chat partner. Please see our documentation on the feedback
    /// collecting for details on how to enable these updates for your bot.</summary>
    property ChosenInlineResult: TtgChosenInlineResult read FChosenInlineResult write FChosenInlineResult;
    /// <summary>	Optional. New incoming callback query</summary>
    property CallbackQuery: TtgCallbackQuery read FCallbackQuery write FCallbackQuery;
    /// <summary>Optional. New incoming shipping query. Only for invoices with flexible
    /// price</summary>
    /// type:string
    property ShippingQuery: TtgShippingQuery read FShippingQuery write FShippingQuery;
    /// <summary>Optional. New incoming pre-checkout query. Contains full information
    /// about checkout
    /// </summary>
    property PreCheckoutQuery: TtgPreCheckoutQuery read FPreCheckoutQuery write FPreCheckoutQuery;
    /// <summary>Optional. New poll state. Bots receive only updates about stopped
    /// polls and polls, which are sent by the bot</summary>
    property Poll: TtgPoll read FPoll write FPoll;
    /// <summary>Optional. A user changed their answer in a non-anonymous poll. Bots
    /// receive new votes only in polls that were sent by the bot itself.
    /// </summary>
    property PollAnswer: TtgPollAnswer read FPollAnswer write FPollAnswer;
  end;

  ItgResponseBase = interface
    ['{1657D8E5-0B41-4983-B1BE-443A266CFD40}']
    // private
    function GetDescription: string;
    function GetErrorCode: Integer;
    function GetOk: Boolean;
    procedure SetDescription(const Value: string);
    procedure SetErrorCode(const Value: Integer);
    procedure SetOk(const Value: Boolean);
    // public
    property Description: string read GetDescription write SetDescription;
    property ErrorCode: Integer read GetErrorCode write SetErrorCode;
    property Ok: Boolean read GetOk write SetOk;
  end;

  TtgResponseBase = class(TInterfacedObject, ItgResponseBase)
  private
    [JsonName('description')]
    FDescription: string;
    [JsonName('error_code')]
    FErrorCode: Integer;
    [JsonName('Ok')]
    FOk: Boolean;
    function GetDescription: string;
    function GetErrorCode: Integer;
    function GetOk: Boolean;
    procedure SetDescription(const Value: string);
    procedure SetErrorCode(const Value: Integer);
    procedure SetOk(const Value: Boolean);
  public
    property Description: string read GetDescription write SetDescription;
    property ErrorCode: Integer read GetErrorCode write SetErrorCode;
    property Ok: Boolean read GetOk write SetOk;
  end;

  ItgResponse<T> = interface(ItgResponseBase)
    ['{B98FE3AF-73DF-4A1D-BC25-C36EA264055B}']
    // private
    function GetResult: T;
    procedure SetResult(const Value: T);
    // public
    property Result: T read GetResult write SetResult;
  end;

  TtgResponse<T> = class(TtgResponseBase, ItgResponse<T>)
  private
    [JsonName('result')]
    FResult: T;
    function GetResult: T;
    procedure SetResult(const Value: T);
  public
    constructor Create;
    destructor Destroy; override;
    property Result: T read GetResult write SetResult;
  end;

  TtgUserLink = record
  private
    FID: Int64;
    FUsername: string;
    class function FromID(const AID: Int64): TtgUserLink; static;
    class function FromUserName(const AUsername: string): TtgUserLink; static;
  public
    function IsEmpty: Boolean;
    function IsHaveID: Boolean;
    function IsHaveUsername: Boolean;
    function GetUsernameWithDog: string;
    function ToString: string;
  public
    property ID: Int64 read FID write FID;
    property Username: string read FUsername write FUsername;
  public
    class function Empty: TtgUserLink; static;
    class operator Implicit(AID: Int64): TtgUserLink;
    class operator Implicit(AUsername: string): TtgUserLink;
  end;

  TtgInputMedia = class
  private
    [JsonName('type')]
    FType: string;
    [JsonName('media')]
    FMedia: string;
    [JsonName('caption')]
    FCaption: string;
    [JsonName('parse_mode')]
    FParseMode: string;
    [JsonIgnoreAttribute]
    FFileToSend: TcaFileToSend;
  public
    function GetFileToSend: TcaFileToSend;
    constructor Create(AMedia: TcaFileToSend; const ACaption: string = '';
      const AParseMode: TtgParseMode = TtgParseMode.Default); virtual;
    property &Type: string read FType write FType;
    property Media: string read FMedia write FMedia;
    property Caption: string read FCaption write FCaption;
    property ParseMode: string read FParseMode write FParseMode;
  end;

implementation

uses
  System.SysUtils; // PObject

function TtgResponseBase.GetDescription: string;
begin
  Result := FDescription;
end;

function TtgResponseBase.GetErrorCode: Integer;
begin
  Result := FErrorCode;
end;

function TtgResponseBase.GetOk: Boolean;
begin
  Result := FOk;
end;

procedure TtgResponseBase.SetDescription(const Value: string);
begin
  FDescription := Value;
end;

procedure TtgResponseBase.SetErrorCode(const Value: Integer);
begin
  FErrorCode := Value;
end;

procedure TtgResponseBase.SetOk(const Value: Boolean);
begin
  FOk := Value;
end;

constructor TtgResponse<T>.Create;
begin
  inherited Create;

end;

destructor TtgResponse<T>.Destroy;
begin
  case GetTypeKind(T) of
    tkClass:
      PObject(@FResult).Free; // DONE -o@rareMax -cMemLeack: Проверить, рабочий ли это способ очистки памяти
  end;
  inherited Destroy;
end;

function TtgResponse<T>.GetResult: T;
begin
  Result := FResult;
end;

{ TtgResponse<T> }

procedure TtgResponse<T>.SetResult(const Value: T);
begin
  FResult := Value;
end;
{ TtgUserLink }

class function TtgUserLink.Empty: TtgUserLink;
begin
  Result.ID := 0;
  Result.Username := '';
end;

class function TtgUserLink.FromID(const AID: Int64): TtgUserLink;
begin
  Result.ID := AID;
end;

class function TtgUserLink.FromUserName(const AUsername: string): TtgUserLink;
begin
  Result.Username := AUsername;
end;

function TtgUserLink.GetUsernameWithDog: string;
begin
  if Username.StartsWith('@') then
    Result := Username
  else
    Result := '@' + Username;
end;

class operator TtgUserLink.Implicit(AUsername: string): TtgUserLink;
begin
  Result := TtgUserLink.FromUserName(AUsername);
end;

function TtgUserLink.IsEmpty: Boolean;
begin
  Result := not(IsHaveID or IsHaveUsername);
end;

function TtgUserLink.IsHaveID: Boolean;
begin
  Result := ID <> 0;
end;

function TtgUserLink.IsHaveUsername: Boolean;
begin
  Result := not Username.IsEmpty;
end;

function TtgUserLink.ToString: string;
begin
  if IsHaveID then
    Result := ID.ToString
  else if IsHaveUsername then
    Result := GetUsernameWithDog
  else
    Result := string.Empty;
end;

class operator TtgUserLink.Implicit(AID: Int64): TtgUserLink;
begin
  Result := TtgUserLink.FromID(AID);
end;

function TtgMessage.&Type: TtgMessageType;
begin
  if not FText.IsEmpty then
    Exit(TtgMessageType.Text);
  raise Exception.Create('Unknown TtgMessage.Type');
end;

constructor TtgMessage.Create;
begin
  inherited;
  FFrom := TtgUser.Create;
  FChat := TtgChat.Create;
  FForwardFromChat := TtgChat.Create;
  FEntities := TObjectList<TtgMessageEntity>.Create;
end;

destructor TtgMessage.Destroy;
begin
  FEntities.Free;
  FFrom.Free;
  FChat.Free;
  FForwardFromChat.Free;
  inherited;
end;

constructor TtgUpdate.Create;
begin
  inherited Create;
  FMessage := TtgMessage.Create;
  FEditedMessage := TtgMessage.Create;

end;

destructor TtgUpdate.Destroy;
begin
  FEditedMessage.Free;
  FMessage.Free;
  inherited Destroy;

end;

{ TtgUpdate }

function TtgUpdate.&Type: TtgUpdateType;
begin
  if CallbackQuery <> nil then
    Result := TtgUpdateType.CallbackQueryUpdate
  else if ChannelPost <> nil then
    Result := (TtgUpdateType.ChannelPost)
  else if ChosenInlineResult <> nil then
    Result := (TtgUpdateType.ChosenInlineResultUpdate)
  else if EditedChannelPost <> nil then
    Result := (TtgUpdateType.EditedChannelPost)
  else if EditedMessage <> nil then
    Result := (TtgUpdateType.EditedMessage)
  else if InlineQuery <> nil then
    Result := (TtgUpdateType.InlineQueryUpdate)
  else if Message <> nil then
    Result := (TtgUpdateType.MessageUpdate)
  else if PreCheckoutQuery <> nil then
    Result := (TtgUpdateType.PreCheckoutQueryUpdate)
  else if ShippingQuery <> nil then
    Result := (TtgUpdateType.ShippingQueryUpdate)
  else
    Result := TtgUpdateType.UnknownUpdate;
end;

function TtgUser.GetCanJoinGroups: Boolean;
begin
  Result := FCanJoinGroups;
end;

function TtgUser.GetCanReadAllGroupMessages: Boolean;
begin
  Result := FCanReadAllGroupMessages;
end;

function TtgUser.GetFirstName: string;
begin
  Result := FFirstName;
end;

function TtgUser.GetID: Int64;
begin
  Result := FID;
end;

function TtgUser.GetIsBot: Boolean;
begin
  Result := FIsBot;
end;

function TtgUser.GetLanguageCode: string;
begin
  Result := FLanguageCode;
end;

function TtgUser.GetLastName: string;
begin
  Result := FLastName;
end;

function TtgUser.GetSupportsInlineQueries: Boolean;
begin
  Result := FSupportsInlineQueries;
end;

function TtgUser.GetUsername: string;
begin
  Result := FUsername;
end;

{ TtgInputMedia }

constructor TtgInputMedia.Create(AMedia: TcaFileToSend; const ACaption: string;
  const AParseMode: TtgParseMode);
begin
  FCaption := ACaption;
  FParseMode := TG_PARSE_MODES[Ord(AParseMode)];
  FFileToSend := AMedia;
  case AMedia.Tag of
    TcaFileToSendTag.ID, TcaFileToSendTag.FromURL:
      FMedia := ExtractFileName(AMedia.Data);
    TcaFileToSendTag.FromFile, TcaFileToSendTag.FromStream:
      FMedia := 'attach://' + ExtractFileName(AMedia.Data);
  end;
end;

function TtgInputMedia.GetFileToSend: TcaFileToSend;
begin
  Result := FFileToSend;
end;

{ TtgMessageEntity }

constructor TtgMessageEntity.Create;
begin
  FUser := TtgUser.Create;
end;

destructor TtgMessageEntity.Destroy;
begin
  FUser.Free;
  inherited;
end;

end.
