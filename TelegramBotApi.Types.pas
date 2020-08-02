unit TelegramBotApi.Types;

interface

uses
  CloudAPI.Json.Converters,
  CloudAPI.Response,
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

  TtgFileInfo = class
  private
    [JsonName('file_id')]
    FFileId: string;
    [JsonName('file_unique_id')]
    FFileUniqueId: string;
    [JsonName('file_size')]
    FFileSize: Int64;
  public
    /// <summary>
    /// Identifier for this file, which can be used to download or reuse the file
    /// </summary>
    property FileId: string read FFileId write FFileId;
    /// <summary>
    /// Unique identifier for this file, which is supposed to be the same over time and
    /// for different bots. Can't be used to download or reuse the file.
    /// </summary>
    property FileUniqueId: string read FFileUniqueId write FFileUniqueId;
    /// <summary>
    /// Optional. File size
    /// </summary>
    property FileSize: Int64 read FFileSize write FFileSize;
  end;

  /// <summary>
  /// This object represents one size of a photo or a file / sticker thumbnail
  /// </summary>
  TtgPhotosize = class(TtgFileInfo)
  private
    [JsonName('width')]
    FWidth: Int64;
    [JsonName('height')]
    FHeight: Int64;
  public
    /// <summary>
    /// Photo width
    /// </summary>
    property Width: Int64 read FWidth write FWidth;
    /// <summary>
    /// Photo height
    /// </summary>
    property Height: Int64 read FHeight write FHeight;
  end;

  /// <summary>
  /// This object represents a general file (as opposed to photos, voice messages and audio files).
  /// </summary>
  TtgDocument = class(TtgFileInfo)
  private
    [JsonName('thumb')]
    FThumb: TtgPhotosize;
    [JsonName('file_name')]
    FFilename: string;
    [JsonName('mime_type')]
    FMimeType: string;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// Optional. Document thumbnail as defined by sender
    /// </summary>
    property Thumb: TtgPhotosize read FThumb write FThumb;
    /// <summary>
    /// Optional. Original filename as defined by sender
    /// </summary>
    property Filename: string read FFilename write FFilename;
    /// <summary>
    /// Optional. MIME type of the file as defined by sender
    /// </summary>
    property MimeType: string read FMimeType write FMimeType;
  end;

  /// <summary>
  /// This object represents a voice note.
  /// </summary>
  TtgVoice = class(TtgFileInfo)
  private
    [JsonName('duration')]
    FDuration: Int64;
    [JsonName('mime_type')]
    FMimeType: string;
  public
    /// <summary>
    /// Duration of the audio in seconds as defined by sender
    /// </summary>
    property Duration: Int64 read FDuration write FDuration;
    /// <summary>
    /// Optional. MIME type of the file as defined by sender
    /// </summary>
    property MimeType: string read FMimeType write FMimeType;
  end;

  /// <summary>
  /// This object represents an audio file to be treated as music by the Telegram clients.
  /// </summary>
  TtgAudio = class(TtgVoice)
  private
    [JsonName('performer')]
    FPerformer: string;
    [JsonName('title')]
    FTitle: string;
    [JsonName('thumb')]
    FThumb: TtgPhotosize;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// Optional. Performer of the audio as defined by sender or by audio tags
    /// </summary>
    property Performer: string read FPerformer write FPerformer;
    /// <summary>
    /// Optional. Title of the audio as defined by sender or by audio tags
    /// </summary>
    property Title: string read FTitle write FTitle;
    /// <summary>
    /// Optional. Thumbnail of the album cover to which the music file belongs
    /// </summary>
    property Thumb: TtgPhotosize read FThumb write FThumb;
  end;

  TtgVideo = class(TtgPhotosize)
  private
    [JsonName('duration')]
    FDuration: Int64;
    [JsonName('thumb')]
    FThumb: TtgPhotosize;
    [JsonName('mime_type')]
    FMimeType: string;
  public
    constructor Create;
    destructor Destroy; override;
    property Duration: Int64 read FDuration write FDuration;
    property Thumb: TtgPhotosize read FThumb write FThumb;
    property MimeType: string read FMimeType write FMimeType;
  end;

  /// <summary>
  /// This object represents an animation file (GIF or H.264/MPEG-4 AVC video without
  /// sound).
  /// </summary>
  TtgAnimation = class(TtgVideo)
  private
    [JsonName('file_name')]
    FFilename: string;
  public
    /// <summary>
    /// Optional. Original animation filename as defined by sender
    /// </summary>
    property Filename: string read FFilename write FFilename;
  end;

  TtgVideoNote = class(TtgFileInfo)
  private
    [JsonName('length')]
    FLength: Int64;
    [JsonName('duration')]
    FDuration: Int64;
    [JsonName('thumb')]
    FThumb: TtgPhotosize;
  public
    constructor Create;
    destructor Destroy; override;
    property Length: Int64 read FLength write FLength;
    property Duration: Int64 read FDuration write FDuration;
    property Thumb: TtgPhotosize read FThumb write FThumb;
  end;

  /// <summary>This object represents a point on the map.</summary>
  TtgLocation = class
  private
    [JsonName('longitude')]
    FLongitude: Single;
    [JsonName('latitude')]
    FLatitude: Single;
  public
    /// <summary>Longitude as defined by sender</summary>
    property Longitude: Single read FLongitude write FLongitude;
    /// <summary>
    /// Latitude as defined by sender
    /// </summary>
    property Latitude: Single read FLatitude write FLatitude;
  end;

  /// <summary>
  /// This object represents a venue.
  /// </summary>
  TtgVenue = class
  private
    [JsonName('location')]
    FLocation: TtgLocation;
    [JsonName('title')]
    FTitle: string;
    [JsonName('address')]
    FAddress: string;
    [JsonName('foursquare_id')]
    FFoursquareId: string;
    [JsonName('foursquare_type')]
    FFoursquareType: string;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// Venue location
    /// </summary>
    property Location: TtgLocation read FLocation write FLocation;
    /// <summary>Name of the venue</summary>
    property Title: string read FTitle write FTitle;
    /// <summary>
    /// Address of the venue
    /// </summary>
    property Address: string read FAddress write FAddress;
    /// <summary>
    /// Optional. Foursquare identifier of the venue
    /// </summary>
    property FoursquareId: string read FFoursquareId write FFoursquareId;
    /// <summary>
    /// Optional. Foursquare type of the venue. (For example,
    /// “arts_entertainment/default”, “arts_entertainment/aquarium” or “food/icecream”.)
    /// </summary>
    property FoursquareType: string read FFoursquareType write FFoursquareType;
  end;

  /// <summary>
  /// This object represents a phone contact.
  /// </summary>
  TtgContact = class
  private
    [JsonName('phone_number')]
    FPhoneNumber: string;
    [JsonName('first_name')]
    FFirstName: string;
    [JsonName('last_name')]
    FLastName: string;
    [JsonName('user_id')]
    FUserId: Int64;
    [JsonName('vcard')]
    FVCard: string;
  public
    /// <summary>
    /// Contact's phone number
    /// </summary>
    property PhoneNumber: string read FPhoneNumber write FPhoneNumber;
    /// <summary>
    /// Contact's first name
    /// </summary>
    property FirstName: string read FFirstName write FFirstName;
    /// <summary>
    /// Optional. Contact's last name
    /// </summary>
    property LastName: string read FLastName write FLastName;
    /// <summary>
    /// Optional. Contact's user identifier in Telegram
    /// </summary>
    property UserId: Int64 read FUserId write FUserId;
    /// <summary>
    /// Optional. Additional data about the contact in the form of a vCard
    /// </summary>
    property VCard: string read FVCard write FVCard;
  end;

  TtgMessage = class
  private type
    TMessEntConv = class(TJsonListConverter<TtgMessageEntity>);
    TMessPhotoConv = class(TJsonListConverter<TtgPhotosize>);
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
    [JsonName('animation')]
    FAnimation: TtgAnimation;
    [JsonName('video')]
    FVideo: TtgVideo;
    [JsonName('caption')]
    FCaption: string;
    [JsonName('video_note')]
    FVideoNote: TtgVideoNote;
    [JsonName('venue')]
    FVenue: TtgVenue;
    [JsonName('photo')]
    [JsonConverter(TMessPhotoConv)]
    FPhoto: TObjectList<TtgPhotosize>;
    [JsonName('caption_entities')]
    [JsonConverter(TMessEntConv)]
    FCaptionEntities: TObjectList<TtgMessageEntity>;
    [JsonName('contact')]
    FContact: TtgContact;
    [JsonName('document')]
    FDocument: TtgDocument;
    [JsonName('audio')]
    FAudio: TtgAudio;
    [JsonName('voice')]
    FVoice: TtgVoice;
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
    /// <summary>
    /// Optional. Message is an animation, information about the animation. For
    /// backward compatibility, when this field is set, the document field will also be
    /// set
    /// </summary>
    property Animation: TtgAnimation read FAnimation write FAnimation;
    /// <summary>
    /// Optional. Message is an audio file, information about the file
    /// </summary>
    property Audio: TtgAudio read FAudio write FAudio;
    /// <summary>
    /// Optional. Message is a general file, information about the file
    /// </summary>
    property Document: TtgDocument read FDocument write FDocument;
    property Photo: TObjectList<TtgPhotosize> read FPhoto write FPhoto;
    property Video: TtgVideo read FVideo write FVideo;
    property VideoNote: TtgVideoNote read FVideoNote write FVideoNote;
    /// <summary>
    /// Optional. Message is a voice message, information about the file
    /// </summary>
    property Voice: TtgVoice read FVoice write FVoice;
    property Caption: string read FCaption write FCaption;
    /// <summary>
    /// Optional. For messages with a caption, special entities like usernames, URLs,
    /// bot commands, etc. that appear in the caption
    /// </summary>
    property CaptionEntities: TObjectList<TtgMessageEntity> read FCaptionEntities write FCaptionEntities;
    /// <summary>
    /// Optional. Message is a shared contact, information about the contact
    /// </summary>
    property Contact: TtgContact read FContact write FContact;
    /// <summary>
    /// Optional. Message is a venue, information about the venue. For backward
    /// compatibility, when this field is set, the location field will also be set
    /// </summary>
    property Venue: TtgVenue read FVenue write FVenue;
  end;

  TtgChatPhoto = class

  end;

  TtgChat = class
  private
    [JsonName('id')]
    FID: Int64;
    [JsonName('type')]
    FType: string;
    [JsonName('title')]
    FTitle: string;
    [JsonName('username')]
    FUsername: string;
    [JsonName('first_name')]
    FFirstName: string;
    [JsonName('last_name')]
    FLastName: string;
    [JsonName('photo')]
    FPhoto: TtgChatPhoto;
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
    constructor Create;
    destructor Destroy; override;
    property ID: Int64 read FID write FID;
    property &Type: string read FType write FType;
    property Title: string read FTitle write FTitle;
    property Username: string read FUsername write FUsername;
    property FirstName: string read FFirstName write FFirstName;
    property LastName: string read FLastName write FLastName;
    property Photo: TtgChatPhoto read FPhoto write FPhoto;
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

  /// <summary>
  /// Contains information about why a request was unsuccessful.
  /// </summary>
  TtgResponseParameters = class
  private
    [JsonName('migrate_to_chat_id')]
    FMigrateToChatId: Int64;
    [JsonName('retry_after')]
    FRetryAfter: Integer;
  public
    /// <summary>
    /// Optional. The group has been migrated to a supergroup
    /// with the specified identifier. This number may be greater than 32 bits
    /// and some programming languages may have difficulty/silent
    /// defects in interpreting it. But it is smaller than 52 bits,
    /// so a signed 64 bit integer or double-precision float type are safe
    /// for storing this identifier.
    /// </summary>
    property MigrateToChatId: Int64 read FMigrateToChatId write FMigrateToChatId;
    /// <summary>
    /// Optional. In case of exceeding flood control, the number of seconds left
    /// to wait before the request can be repeated.
    /// </summary>
    property RetryAfter: Integer read FRetryAfter write FRetryAfter;
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
    function GerParameters: TtgResponseParameters;
    // public
    property Description: string read GetDescription write SetDescription;
    property ErrorCode: Integer read GetErrorCode write SetErrorCode;
    property Ok: Boolean read GetOk write SetOk;
    property Parameters: TtgResponseParameters read GerParameters;
  end;

  /// <summary>
  /// Represents bot API response
  /// </summary>
  TtgResponseBase = class(TInterfacedObject, ItgResponseBase)
  private
    [JsonName('description')]
    FDescription: string;
    [JsonName('error_code')]
    FErrorCode: Integer;
    [JsonName('Ok')]
    FOk: Boolean;
    [JsonName('parameters')]
    FParameters: TtgResponseParameters;
    function GetDescription: string;
    function GetErrorCode: Integer;
    function GetOk: Boolean;
    procedure SetDescription(const Value: string);
    procedure SetErrorCode(const Value: Integer);
    procedure SetOk(const Value: Boolean);
    function GerParameters: TtgResponseParameters;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// Gets the error message.
    /// </summary>
    property Description: string read GetDescription write SetDescription;
    /// <summary>
    /// Gets the error code.
    /// </summary>
    property ErrorCode: Integer read GetErrorCode write SetErrorCode;
    /// <summary>
    /// Gets a value indicating whether the request was successful.
    /// </summary>
    property Ok: Boolean read GetOk write SetOk;
    /// <summary>
    /// Contains information about why a request was unsuccessful.
    /// </summary>
    property Parameters: TtgResponseParameters read GerParameters;
  end;

  ItgResponse<T> = interface(ItgResponseBase)
    ['{B98FE3AF-73DF-4A1D-BC25-C36EA264055B}']
    // private
    function GetResult: T;
    procedure SetResult(const Value: T);
    function GetResponse: IcaResponseBase;
    procedure SetResponse(const Value: IcaResponseBase);
    // public
    /// <summary>
    /// Gets the result object.
    /// </summary>
    property Result: T read GetResult write SetResult;
    property CloudResponse: IcaResponseBase read GetResponse write SetResponse;
  end;

  TtgResponse<T> = class(TtgResponseBase, ItgResponse<T>)
  private
    [JsonName('result')]
    FResult: T;
    FResponse: IcaResponseBase;
    function GetResult: T;
    procedure SetResult(const Value: T);
    function GetResponse: IcaResponseBase;
    procedure SetResponse(const Value: IcaResponseBase);
  public
    constructor Create;
    destructor Destroy; override;
    property Result: T read GetResult write SetResult;
    property CloudResponse: IcaResponseBase read GetResponse write SetResponse;
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
  CloudAPI.Exceptions,
  System.SysUtils;

constructor TtgResponseBase.Create;
begin
  inherited Create();
  FParameters := TtgResponseParameters.Create;
end;

destructor TtgResponseBase.Destroy;
begin
  FParameters.Free;
  inherited Destroy;
end;

function TtgResponseBase.GerParameters: TtgResponseParameters;
begin
  Result := FParameters;
end;

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

function TtgResponse<T>.GetResponse: IcaResponseBase;
begin
  Result := FResponse;
end;

function TtgResponse<T>.GetResult: T;
begin
  Result := FResult;
end;

{ TtgResponse<T> }

procedure TtgResponse<T>.SetResponse(const Value: IcaResponseBase);
begin
  FResponse := Value;
end;

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
    Exit(TtgMessageType.Text)
  else if Assigned(Video) then
    Exit(TtgMessageType.Video)
  else if Assigned(VideoNote) then
    Exit(TtgMessageType.VideoNote)
  else if Assigned(Venue) then
    Exit(TtgMessageType.Venue)
  else if Photo.Count > 0 then
    Exit(TtgMessageType.Photo)
  else if Assigned(Audio) then
    Exit(TtgMessageType.Audio)
  else if Assigned(Voice) then
    Exit(TtgMessageType.Voice)
  else if Assigned(Document) then
    Exit(TtgMessageType.Document)
  else if Assigned(Contact) then
    Exit(TtgMessageType.Contact)
  else
    TcaExceptionManager.Current.Alert('TtgMessage.Type', 'Unknown TtgMessage.Type');
end;

constructor TtgMessage.Create;
begin
  inherited;
  FFrom := TtgUser.Create;
  FChat := TtgChat.Create;
  FForwardFromChat := TtgChat.Create;
  FEntities := TObjectList<TtgMessageEntity>.Create;
  FCaptionEntities := TObjectList<TtgMessageEntity>.Create;
  FPhoto := TObjectList<TtgPhotosize>.Create;
end;

destructor TtgMessage.Destroy;
begin
  case &Type of
    TtgMessageType.Photo:
      FPhoto.Clear;
    TtgMessageType.Audio:
      FAudio.Free;
    TtgMessageType.Video:
      FVideo.Free;
    TtgMessageType.VideoNote:
      FVideoNote.Free;
    TtgMessageType.Voice:
      FVoice.Free;
    TtgMessageType.Document:
      begin
        FDocument.Free;
        if Assigned(FAnimation) then
          FAnimation.Free;
      end;
    // TtgMessageType.Sticker:
    // TtgMessageType.Game:
    // TtgMessageType.Location:
    TtgMessageType.Contact:
      FContact.Free;
    // TtgMessageType.Service:
    TtgMessageType.Venue:
      FVenue.Free;
  end;
  FCaptionEntities.Free;
  FEntities.Free;
  FFrom.Free;
  FChat.Free;
  FForwardFromChat.Free;
  FPhoto.Free;
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

constructor TtgInputMedia.Create(AMedia: TcaFileToSend; const ACaption: string; const AParseMode: TtgParseMode);
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

{ TtgVenue }

constructor TtgVenue.Create;
begin
  FLocation := TtgLocation.Create;
end;

destructor TtgVenue.Destroy;
begin
  FLocation.Free;
  inherited Destroy;
end;

{ TtgChat }

constructor TtgChat.Create;
begin
  FPhoto := nil;
  FPinnedMessage := nil;
end;

destructor TtgChat.Destroy;
begin
  if Assigned(FPhoto) then
    FPhoto.Free;
  if Assigned(FPinnedMessage) then
    FPinnedMessage.Free;
  inherited;
end;

{ TtgVideo }

constructor TtgVideo.Create;
begin
  FThumb := TtgPhotosize.Create;
end;

destructor TtgVideo.Destroy;
begin
  FThumb.Free;
  inherited Destroy;
end;

{ TtgDocument }

constructor TtgDocument.Create;
begin
  FThumb := TtgPhotosize.Create;
end;

destructor TtgDocument.Destroy;
begin
  FThumb.Free;
  inherited;
end;

{ TtgAudio }

constructor TtgAudio.Create;
begin
  FThumb := TtgPhotosize.Create;
end;

destructor TtgAudio.Destroy;
begin
  FThumb.Free;
  inherited;
end;

{ TtgVideoNote }

constructor TtgVideoNote.Create;
begin
  FThumb := TtgPhotosize.Create;
end;

destructor TtgVideoNote.Destroy;
begin
  FThumb.Free;
  inherited;
end;

end.
