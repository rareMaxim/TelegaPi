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
  TelegramBotApi.Types.Intf,
  TelegramBotApi.Types.Keyboards;

type
  // TtgMessageEntity = class;
  // TtgChatPhoto = class;
  TtgMessage = class;
  // TtgChatPermissions = class;
  // TtgChatLocation = class;
  // TtgPhotosize = class;
  // TtgAnimation = class;
  // TtgVideo = class;
  // TtgVideoNote = class;
  // TtgVenue = class;
  // TtgContact = class;
  // TtgDocument = class;
  // TtgAudio = class;
  // TtgVoice = class;
  // TtgPoll = class;
  // TtgSticker = class;
  // TtgDice = class;
  // TtgGame = class;
  // TtgLocation = class;
  // TtgInvoice = class;
  // TtgSuccessfulPayment = class;
  // TtgPassportData = class;
  // TtgProximityAlertTriggered = class;
  // TtgFileInfo = class;

  /// <summary>
  /// This object represents a unique message identifier.
  /// </summary>
  TtgMessageId = class
  private
    [JsonName('message_id')]
    FMessageID: Int64;
  public
    /// <summary>
    /// Unique message identifier
    /// </summary>
    property MessageID: Int64 read FMessageID write FMessageID;
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
  /// This object represents a file ready to be downloaded. The file can be
  /// downloaded via the link https://api.telegram.org/file/bot<token>/<file_path>.
  /// It is guaranteed that the link will be valid for at least 1 hour. When the link
  /// expires, a new one can be requested by calling getFile.
  /// </summary>
  /// <remarks>
  /// Maximum file size to download is 20 MB
  /// </remarks>
  TtgFile = class(TtgFileInfo)
  private
    [JsonName('file_path')]
    FFilePath: string;
  public
    /// <summary>
    /// Identifier for this file, which can be used to download or reuse the file
    /// </summary>
    property FileId;
    /// <summary>
    /// Unique identifier for this file, which is supposed to be the same over time and
    /// for different bots. Can't be used to download or reuse the file.
    /// </summary>
    property FileUniqueId;
    /// <summary>
    /// Optional. File size, if known
    /// </summary>
    property FileSize;
    /// <summary>
    /// Optional. File path. Use https://api.telegram.org/file/bot<token>/<file_path>
    /// to get the file.
    /// </summary>
    property FilePath: string read FFilePath write FFilePath;
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
    /// Identifier for this file, which can be used to download or reuse the file
    /// </summary>
    property FileId;
    /// <summary>
    /// Unique identifier for this file, which is supposed to be the same over time and
    /// for different bots. Can't be used to download or reuse the file.
    /// </summary>
    property FileUniqueId;
    /// <summary>
    /// Photo width
    /// </summary>
    property Width: Int64 read FWidth write FWidth;
    /// <summary>
    /// Photo height
    /// </summary>
    property Height: Int64 read FHeight write FHeight;
    /// <summary>
    /// Optional. File size
    /// </summary>
    property FileSize;
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
    /// Identifier for this file, which can be used to download or reuse the file
    /// </summary>
    property FileId;
    /// <summary>
    /// Unique identifier for this file, which is supposed to be the same over time and
    /// for different bots. Can't be used to download or reuse the file.
    /// </summary>
    property FileUniqueId;
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
    /// <summary>
    /// Optional. File size
    /// </summary>
    property FileSize;
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
    /// Identifier for this file, which can be used to download or reuse the file
    /// </summary>
    property FileId;
    /// <summary>
    /// Unique identifier for this file, which is supposed to be the same over time and
    /// for different bots. Can't be used to download or reuse the file.
    /// </summary>
    property FileUniqueId;
    /// <summary>
    /// Duration of the audio in seconds as defined by sender
    /// </summary>
    property Duration: Int64 read FDuration write FDuration;
    /// <summary>
    /// Optional. MIME type of the file as defined by sender
    /// </summary>
    property MimeType: string read FMimeType write FMimeType;
    /// <summary>
    /// Optional. File size
    /// </summary>
    property FileSize;
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
    FFilename: string;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// Identifier for this file, which can be used to download or reuse the file
    /// </summary>
    property FileId;
    /// <summary>
    /// Unique identifier for this file, which is supposed to be the same over time and
    /// for different bots. Can't be used to download or reuse the file.
    /// </summary>
    property FileUniqueId;
    /// <summary>
    /// Duration of the audio in seconds as defined by sender
    /// </summary>
    property Duration;
    /// <summary>
    /// Optional. Performer of the audio as defined by sender or by audio tags
    /// </summary>
    property Performer: string read FPerformer write FPerformer;
    /// <summary>
    /// Optional. Title of the audio as defined by sender or by audio tags
    /// </summary>
    property Title: string read FTitle write FTitle;
    /// <summary>
    /// Optional. Original animation filename as defined by sender
    /// </summary>
    property Filename: string read FFilename write FFilename;
    /// <summary>
    /// Optional. MIME type of the file as defined by sender
    /// </summary>
    property MimeType;
    /// <summary>
    /// Optional. File size
    /// </summary>
    property FileSize;
    /// <summary>
    /// Optional. Thumbnail of the album cover to which the music file belongs
    /// </summary>
    property Thumb: TtgPhotosize read FThumb write FThumb;
  end;

  /// <summary>
  /// This object represents a video file.
  /// </summary>
  TtgVideo = class(TtgPhotosize)
  private
    [JsonName('duration')]
    FDuration: Int64;
    [JsonName('thumb')]
    FThumb: TtgPhotosize;
    [JsonName('mime_type')]
    FMimeType: string;
    FFilename: string;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// Identifier for this file, which can be used to download or reuse the file
    /// </summary>
    property FileId;
    /// <summary>
    /// Unique identifier for this file, which is supposed to be the same over time and
    /// for different bots. Can't be used to download or reuse the file.
    /// </summary>
    property FileUniqueId;
    /// <summary>
    /// Video width as defined by sender
    /// </summary>
    property Width;
    /// <summary>
    /// Video height as defined by sender
    /// </summary>
    property Height;
    /// <summary>
    /// Duration of the video in seconds as defined by sender
    /// </summary>
    property Duration: Int64 read FDuration write FDuration;
    /// <summary>
    /// Optional. Video thumbnail
    /// </summary>
    property Thumb: TtgPhotosize read FThumb write FThumb;
    /// <summary>
    /// Optional. Original animation filename as defined by sender
    /// </summary>
    property Filename: string read FFilename write FFilename;
    /// <summary>
    /// Optional. Mime type of a file as defined by sender
    /// </summary>
    property MimeType: string read FMimeType write FMimeType;
    /// <summary>
    /// Optional. File size
    /// </summary>
    property FileSize;
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
    /// Identifier for this file, which can be used to download or reuse the file
    /// </summary>
    property FileId;
    /// <summary>
    /// Unique identifier for this file, which is supposed to be the same over time and
    /// for different bots. Can't be used to download or reuse the file.
    /// </summary>
    property FileUniqueId;
    /// <summary>
    /// Video width as defined by sender
    /// </summary>
    property Width;
    /// <summary>
    /// Video height as defined by sender
    /// </summary>
    property Height;
    /// <summary>
    /// Duration of the video in seconds as defined by sender
    /// </summary>
    property Duration;
    /// <summary>
    /// Optional. Animation thumbnail as defined by sender
    /// </summary>
    property Thumb;
    /// <summary>
    /// Optional. Original animation filename as defined by sender
    /// </summary>
    property Filename: string read FFilename write FFilename;
    /// <summary>
    /// Optional. Mime type of a file as defined by sender
    /// </summary>
    property MimeType;
    /// <summary>
    /// Optional. File size
    /// </summary>
    property FileSize;
  end;

  /// <summary>
  /// This object represents a video message (available in Telegram apps as of v.4.0).
  /// </summary>
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
    /// <summary>
    /// Identifier for this file, which can be used to download or reuse the file
    /// </summary>
    property FileId;
    /// <summary>
    /// Unique identifier for this file, which is supposed to be the same over time and
    /// for different bots. Can't be used to download or reuse the file.
    /// </summary>
    property FileUniqueId;
    /// <summary>
    /// Video width and height (diameter of the video message) as defined by sender
    /// </summary>
    property Length: Int64 read FLength write FLength;
    /// <summary>
    /// Duration of the video in seconds as defined by sender
    /// </summary>
    property Duration: Int64 read FDuration write FDuration;
    /// <summary>
    /// Optional. Video thumbnail
    /// </summary>
    property Thumb: TtgPhotosize read FThumb write FThumb;
    /// <summary>
    /// Optional. File size
    /// </summary>
    property FileSize;
  end;

  /// <summary>This object represents a point on the map.</summary>
  TtgLocation = class
  private
    [JsonName('longitude')]
    FLongitude: Single;
    [JsonName('latitude')]
    FLatitude: Single;
    [JsonName('horizontal_accuracy')]
    FHorizontalAccuracy: Single;
    [JsonName('live_period')]
    FLivePeriod: Integer;
    [JsonName('heading')]
    FHeading: Integer;
    [JsonName('proximity_alert_radius')]
    FProximityAlertRadius: Integer;
  public
    /// <summary>Longitude as defined by sender</summary>
    property Longitude: Single read FLongitude write FLongitude;
    /// <summary>
    /// Latitude as defined by sender
    /// </summary>
    property Latitude: Single read FLatitude write FLatitude;
    /// <summary>
    /// Optional. The radius of uncertainty for the location, measured in meters; 0-1500
    /// </summary>
    property HorizontalAccuracy: Single read FHorizontalAccuracy write FHorizontalAccuracy;
    /// <summary>
    /// Optional. Time relative to the message sending date, during which the location
    /// can be updated, in seconds. For active live locations only.
    /// </summary>
    property LivePeriod: Integer read FLivePeriod write FLivePeriod;
    /// <summary>
    /// Optional. The direction in which user is moving, in degrees; 1-360. For active
    /// live locations only.
    /// </summary>
    property Heading: Integer read FHeading write FHeading;
    /// <summary>
    /// Optional. Maximum distance for proximity alerts about approaching another chat
    /// member, in meters. For sent live locations only.
    /// </summary>
    property ProximityAlertRadius: Integer read FProximityAlertRadius write FProximityAlertRadius;
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
    [JsonName('google_place_id')]
    FGooglePlaceId: string;
    [JsonName('google_place_type')]
    FGooglePlaceType: string;
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
    /// <summary>
    /// Optional. Google Places identifier of the venue
    /// </summary>
    property GooglePlaceId: string read FGooglePlaceId write FGooglePlaceId;
    /// <summary>
    /// Optional. Google Places type of the venue. (See supported types.)
    /// </summary>
    property GooglePlaceType: string read FGooglePlaceType write FGooglePlaceType;
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

  /// <summary>
  /// This object contains information about one answer option in a poll.
  /// </summary>
  TtgPollOption = class
  private
    [JsonName('text')]
    FText: string;
    [JsonName('voter_count')]
    FVoterCount: Integer;
  public
    /// <summary>
    /// Option text, 1-100 characters
    /// </summary>
    property Text: string read FText write FText;
    /// <summary>
    /// Number of users that voted for this option
    /// </summary>
    property VoterCount: Integer read FVoterCount write FVoterCount;
  end;

  /// <summary>
  /// This object represents a Telegram user or bot.
  /// </summary>
  TtgUser = class(TInterfacedObject, ItgUser)
  private
    [JsonName('id')]
    FID: Int64;
    [JsonName('is_bot')]
    FIsBot: Boolean;
    [JsonName('first_name')]
    FFirstName: string;
    [JsonName('last_name')]
    FLastName: string;
    [JsonName('username')]
    FUsername: string;
    [JsonName('language_code')]
    FLanguageCode: string;
    [JsonName('can_join_groups')]
    FCanJoinGroups: Boolean;
    [JsonName('can_read_all_group_messages')]
    FCanReadAllGroupMessages: Boolean;
    [JsonName('supports_inline_queries')]
    FSupportsInlineQueries: Boolean;
    function GetID: Int64;
    function GetIsBot: Boolean;
    function GetFirstName: string;
    function GetLastName: string;
    function GetUsername: string;
    function GetLanguageCode: string;
    function GetCanJoinGroups: Boolean;
    function GetCanReadAllGroupMessages: Boolean;
    function GetSupportsInlineQueries: Boolean;
  public
    /// <summary>
    /// Unique identifier for this user or bot
    /// </summary>
    property ID: Int64 read GetID;
    /// <summary>
    /// True, if this user is a bot
    /// </summary>
    property IsBot: Boolean read GetIsBot;
    /// <summary>
    /// User's or bot's first name
    /// </summary>
    property FirstName: string read GetFirstName;
    /// <summary>
    /// Optional. User's or bot's last name
    /// </summary>
    property LastName: string read GetLastName;
    /// <summary>
    /// Optional. User's or bot's username
    /// </summary>
    property Username: string read GetUsername;
    /// <summary>
    /// Optional. IETF language tag of the user's language (https://en.wikipedia.
    /// org/wiki/IETF_language_tag)
    /// </summary>
    property LanguageCode: string read GetLanguageCode;
    /// <summary>
    /// Optional. True, if the bot can be invited to groups. Returned only in getMe
    /// <see cref="TTelegramBotApi.GetMe"/>.
    /// </summary>
    property CanJoinGroups: Boolean read GetCanJoinGroups;
    /// <summary>
    /// Optional. True, if privacy mode is disabled for the bot. Returned only in getMe
    /// <see cref="TTelegramBotApi.GetMe"/>.
    /// </summary>
    property CanReadAllGroupMessages: Boolean read GetCanReadAllGroupMessages;
    /// <summary>
    /// Optional. True, if the bot supports inline queries. Returned only in getMe <see
    /// cref="TTelegramBotApi.GetMe"/>.
    /// </summary>
    property SupportsInlineQueries: Boolean read GetSupportsInlineQueries;
  end;

  /// <summary>
  /// This object represents an answer of a user in a non-anonymous poll.
  /// </summary>
  TtgPollAnswer = class
  private
    [JsonName('poll_id')]
    FPollId: string;
    [JsonName('user')]
    FUser: TtgUser;
    [JsonName('option_ids')]
    FOptionIDs: TArray<Integer>;
  public
    /// <summary>
    /// Unique poll identifier
    /// </summary>
    property PollId: string read FPollId write FPollId;
    /// <summary>
    /// The user, who changed the answer to the poll
    /// </summary>
    property User: TtgUser read FUser write FUser;
    /// <summary>
    /// 0-based identifiers of answer options, chosen by the user. May be empty if the
    /// user retracted their vote.
    /// </summary>
    property OptionIDs: TArray<Integer> read FOptionIDs write FOptionIDs;
  end;

  /// <summary>
  /// This object represents a sticker.
  /// </summary>
  TtgSticker = class
    { TODO -oOwner -cGeneral : Заполнить }
  end;

  /// <summary>
  /// This object represents an animated emoji that displays a random value.
  /// </summary>
  TtgDice = class
  private
    [JsonName('emoji')]
    FEmoji: string;
    [JsonName('value')]
    FValue: Integer;
  public
    /// <summary>
    /// Emoji on which the dice throw animation is based
    /// </summary>
    property Emoji: string read FEmoji write FEmoji;
    /// <summary>
    /// Value of the dice, 1-6 for “🎲” and “🎯” base emoji, 1-5 for “🏀” and “⚽” base
    /// emoji, 1-64 for “🎰” base emoji
    /// </summary>
    property Value: Integer read FValue write FValue;
  end;

  /// <summary>
  /// This object represents a game. Use BotFather to create and edit games, their short names will act as unique identifiers.
  /// </summary>
  TtgGame = class
    { TODO -oOwner -cGeneral : Заполнить }
  end;

  /// <summary>
  /// This object contains basic information about an invoice.
  /// </summary>
  TtgInvoice = class
    { TODO -oOwner -cGeneral : Заполнить }
  end;

  /// <summary>
  /// This object contains basic information about a successful payment.
  /// </summary>
  TtgSuccessfulPayment = class
    { TODO -oOwner -cGeneral : Заполнить }
  end;

  /// <summary>
  /// Contains information about Telegram Passport data shared with the bot by the user.
  /// </summary>
  TtgPassportData = class
    { TODO -oOwner -cGeneral : Заполнить }
  end;

  /// <summary>
  /// This object represents the content of a service message, sent whenever a user in the chat triggers a proximity alert set by another user.
  /// </summary>
  TtgProximityAlertTriggered = class
  private
    [JsonName('traveler')]
    FTraveler: TtgUser;
    [JsonName('watcher')]
    FWatcher: TtgUser;
    [JsonName('distance')]
    FDistance: Integer;
  public
    /// <summary>
    /// User that triggered the alert
    /// </summary>
    property Traveler: TtgUser read FTraveler write FTraveler;
    /// <summary>
    /// User that set the alert
    /// </summary>
    property Watcher: TtgUser read FWatcher write FWatcher;
    /// <summary>
    /// The distance between the users
    /// </summary>
    property Distance: Integer read FDistance write FDistance;
  end;

  /// <summary>
  /// This object represents a chat photo.
  /// </summary>
  TtgChatPhoto = class
  private
    [JsonName('big_file_unique_id')]
    [JsonName('small_file_id')]
    FSmallFileId: string;
    [JsonName('small_file_unique_id')]
    FSmallFileUniqueId: string;
    [JsonName('big_file_id')]
    FBigFileId: string;
    [JsonName('big_file_unique_id')]
    FBigFileUniqueId: string;
  public
    /// <summary>
    /// File identifier of small (160x160) chat photo. This file_id can be used only
    /// for photo download and only for as long as the photo is not changed.
    /// </summary>
    property SmallFileId: string read FSmallFileId write FSmallFileId;
    /// <summary>
    /// Unique file identifier of small (160x160) chat photo, which is supposed to be
    /// the same over time and for different bots. Can't be used to download or reuse
    /// the file.
    /// </summary>
    property SmallFileUniqueId: string read FSmallFileUniqueId write FSmallFileUniqueId;
    /// <summary>
    /// File identifier of big (640x640) chat photo. This file_id can be used only
    /// for photo download and only for as long as the photo is not changed.
    /// </summary>
    property BigFileId: string read FBigFileId write FBigFileId;
    /// <summary>
    /// Unique file identifier of big (640x640) chat photo, which is supposed to be the
    /// same over time and for different bots. Can't be used to download or reuse the
    /// file.
    /// </summary>
    property BigFileUniqueId: string read FBigFileUniqueId write FBigFileUniqueId;
  end;

  /// <summary>
  /// Describes actions that a non-administrator user is allowed to take in a chat.
  /// </summary>
  TtgChatPermissions = class
  private
    [JsonName('can_send_messages')]
    FCanSendMessages: Boolean;
    [JsonName('can_send_media_messages')]
    FCanSendMediaMessages: Boolean;
    [JsonName('can_send_polls')]
    FCanSendPolls: Boolean;
    [JsonName('can_send_other_messages')]
    FCanSendOtherMessages: Boolean;
    [JsonName('can_add_web_page_previews')]
    FCanAddWebPagePreviews: Boolean;
    [JsonName('can_change_info')]
    FCanChangeInfo: Boolean;
    [JsonName('can_invite_users')]
    FCanInviteUsers: Boolean;
    [JsonName('can_pin_messages')]
    FCanPinMessages: Boolean;
  public
    /// <summary>
    /// Optional. True, if the user is allowed to send text messages, contacts,
    /// locations and venues
    /// </summary>
    property CanSendMessages: Boolean read FCanSendMessages;
    /// <summary>
    /// Optional. True, if the user is allowed to send audios, documents, photos,
    /// videos, video notes and voice notes, implies can_send_messages
    /// </summary>
    property CanSendMediaMessages: Boolean read FCanSendMediaMessages;
    /// <summary>
    /// Optional. True, if the user is allowed to send polls, implies can_send_messages
    /// </summary>
    property CanSendPolls: Boolean read FCanSendPolls;
    /// <summary>
    /// Optional. True, if the user is allowed to send animations, games, stickers and
    /// use inline bots, implies can_send_media_messages
    /// </summary>
    property CanSendOtherMessages: Boolean read FCanSendOtherMessages;
    /// <summary>
    /// Optional. True, if the user is allowed to add web page previews to their
    /// messages, implies can_send_media_messages
    /// </summary>
    property CanAddWebPagePreviews: Boolean read FCanAddWebPagePreviews;
    /// <summary>
    /// Optional. True, if the user is allowed to change the chat title, photo and
    /// other settings. Ignored in public supergroups
    /// </summary>
    property CanChangeInfo: Boolean read FCanChangeInfo;
    /// <summary>
    /// Optional. True, if the user is allowed to invite new users to the chat
    /// </summary>
    property CanInviteUsers: Boolean read FCanInviteUsers;
    /// <summary>
    /// Optional. True, if the user is allowed to pin messages. Ignored in public
    /// supergroups
    /// </summary>
    property CanPinMessages: Boolean read FCanPinMessages;
  end;

  /// <summary>
  /// Represents a location to which a chat is connected.
  /// </summary>
  TtgChatLocation = class
  private
    [JsonName('location')]
    FLocation: TtgLocation;
    [JsonName('address')]
    FAddress: string;
  public
    /// <summary>
    /// The location to which the supergroup is connected. Can't be a live location.
    /// </summary>
    property Location: TtgLocation read FLocation write FLocation;
    /// <summary>
    /// Location address; 1-64 characters, as defined by the chat owner
    /// </summary>
    property Address: string read FAddress write FAddress;
  end;

  TtgInlineQuery = class

  end;

  TtgAnswerInlineQuery = class

  end;

  TtgChosenInlineResult = class

  end;

  /// <summary>
  /// This object represents an incoming callback query from a callback button in an
  /// inline keyboard. If the button that originated the query was attached to a
  /// message sent by the bot, the field message will be present. If the button was
  /// attached to a message sent via the bot (in inline mode), the field
  /// inline_message_id will be present. Exactly one of the fields data or
  /// game_short_name will be present.
  /// </summary>
  TtgCallbackQuery = class
  private
    [JsonName('id')]
    FID: string;
    [JsonName('from')]
    FFrom: TtgUser;
    [JsonName('message')]
    FMessage: TtgMessage;
    [JsonName('inline_message_id')]
    FInlineMessageId: string;
    [JsonName('chat_instance')]
    FChatInstance: string;
    [JsonName('data')]
    FData: string;
    [JsonName('game_short_name')]
    FGameShortName: string;
  public
    /// <summary>
    /// Unique identifier for this query
    /// </summary>
    property ID: string read FID write FID;
    /// <summary>
    /// Sender
    /// </summary>
    property From: TtgUser read FFrom write FFrom;
    /// <summary>
    /// Optional. Message with the callback button that originated the query. Note that
    /// message content and message date will not be available if the message is too old
    /// </summary>
    property Message: TtgMessage read FMessage write FMessage;
    /// <summary>
    /// Optional. Identifier of the message sent via the bot in inline mode, that
    /// originated the query.
    /// </summary>
    property InlineMessageId: string read FInlineMessageId write FInlineMessageId;
    /// <summary>
    /// Global identifier, uniquely corresponding to the chat to which the message with
    /// the callback button was sent. Useful for high scores in games.
    /// </summary>
    property ChatInstance: string read FChatInstance write FChatInstance;
    /// <summary>
    /// Optional. Data associated with the callback button. Be aware that a bad client
    /// can send arbitrary data in this field.
    /// </summary>
    property Data: string read FData write FData;
    /// <summary>
    /// Optional. Short name of a Game to be returned, serves as the unique identifier
    /// for the game
    /// </summary>
    property GameShortName: string read FGameShortName write FGameShortName;
  end;

  TtgShippingQuery = class

  end;

  TtgPreCheckoutQuery = class

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

  ItgResponse<t> = interface(ItgResponseBase)
    ['{B98FE3AF-73DF-4A1D-BC25-C36EA264055B}']
    // private
    function GetResult: t;
    procedure SetResult(const Value: t);
    function GetResponse: IcaResponseBase;
    procedure SetResponse(const Value: IcaResponseBase);
    // public
    /// <summary>
    /// Gets the result object.
    /// </summary>
    property Result: t read GetResult write SetResult;
    property CloudResponse: IcaResponseBase read GetResponse write SetResponse;
  end;

  TtgResponse<t> = class(TtgResponseBase, ItgResponse<t>)
  private
    [JsonName('result')]
    FResult: t;
    FResponse: IcaResponseBase;
    function GetResult: t;
    procedure SetResult(const Value: t);
    function GetResponse: IcaResponseBase;
    procedure SetResponse(const Value: IcaResponseBase);
  public
    constructor Create;
    destructor Destroy; override;
    property Result: t read GetResult write SetResult;
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

  /// <summary>
  /// This object represents the content of a media message to be sent.
  /// </summary>
  TtgInputMedia = class abstract
  protected
    [JsonName('type')]
    FType: string;
    [JsonName('media')]
    FMedia: string;
    [JsonName('caption')]
    FCaption: string;
    [JsonName('parse_mode')]
    [JsonConverter(TtgParseModeConverter)]
    FParseMode: TtgParseMode;
    [JsonIgnoreAttribute]
    FFileToSend: TcaFileToSend;
  public
    function GetFileToSend: TcaFileToSend;
    constructor Create(AMedia: TcaFileToSend; const ACaption: string = ''); virtual;
    property &Type: string read FType;
    property Media: string read FMedia;
    property Caption: string read FCaption write FCaption;
    property ParseMode: TtgParseMode read FParseMode write FParseMode;
  end;

  /// <summary>
  /// Represents a photo to be sent.
  /// </summary>
  TtgInputMediaPhoto = class(TtgInputMedia)
  public
    constructor Create(AMedia: TcaFileToSend; const ACaption: string = ''); override;
    /// <summary>
    /// Type of the result, must be "photo"
    /// </summary>
    property &Type;
    /// <summary>
    /// File to send. Pass a file_id to send a file that exists on the Telegram servers
    /// (recommended), pass an HTTP URL for Telegram to get a file from the Internet,
    /// or pass “attach://<file_attach_name>” to upload a new one using
    /// multipart/form-data under <file_attach_name> name.
    /// </summary>
    property Media;
    /// <summary>
    /// Optional. Caption of the photo to be sent, 0-1024 characters after entities
    /// parsing
    /// </summary>
    property Caption;
    /// <summary>
    /// Optional. Mode for parsing entities in the photo caption. See formatting
    /// options for more details.
    /// </summary>
    property ParseMode;
  end;

  /// <summary>
  /// Represents a general file to be sent.
  /// </summary>
  TtgInputMediaDocument = class(TtgInputMediaPhoto)
  private
    [JsonName('thumb')]
    FThumb: TcaFileToSend;
  public
    constructor Create(AMedia: TcaFileToSend; const ACaption: string = ''); override;
    /// <summary>
    /// Type of the result, must be "document"
    /// </summary>
    property &Type;
    /// <summary>
    /// File to send. Pass a file_id to send a file that exists on the Telegram servers
    /// (recommended), pass an HTTP URL for Telegram to get a file from the Internet,
    /// or pass “attach://<file_attach_name>” to upload a new one using
    /// multipart/form-data under <file_attach_name> name.
    /// </summary>
    property Media;
    /// <summary>
    /// Optional. Thumbnail of the file sent; can be ignored if thumbnail generation
    /// for the file is supported server-side. The thumbnail should be in JPEG format
    /// and less than 200 kB in size. A thumbnail's width and height should not exceed
    /// 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails
    /// can't be reused and can be only uploaded as a new file, so you can pass “attach:
    /// //<file_attach_name>” if the thumbnail was uploaded using multipart/form-data
    /// under <file_attach_name>
    /// </summary>
    property Thumb: TcaFileToSend read FThumb write FThumb;
    /// <summary>
    /// Optional. Caption of the document  to be sent, 0-1024 characters after entities
    /// parsing
    /// </summary>
    property Caption;
    /// <summary>
    /// Optional. Mode for parsing entities in the document caption. See formatting
    /// options for more details.
    /// </summary>
    property ParseMode;
  end;

  /// <summary>
  /// Represents an animation file (GIF or H.264/MPEG-4 AVC video without sound) to
  /// be sent.
  /// </summary>
  TtgInputMediaAnimation = class(TtgInputMediaDocument)
  private
    [JsonName('duration')]
    FDuration: Int64;
    [JsonName('width')]
    FWidth: Int64;
    [JsonName('height')]
    FHeight: Int64;
  public
    constructor Create(AMedia: TcaFileToSend; const ACaption: string = ''); override;
    /// <summary>
    /// Type of the result, must be "animation"
    /// </summary>
    property &Type;
    /// <summary>
    /// File to send. Pass a file_id to send a file that exists on the Telegram servers
    /// (recommended), pass an HTTP URL for Telegram to get a file from the Internet,
    /// or pass “attach://<file_attach_name>” to upload a new one using
    /// multipart/form-data under <file_attach_name> name.
    /// </summary>
    property Media;
    /// <summary>
    /// Optional. Thumbnail of the file sent; can be ignored if thumbnail generation
    /// for the file is supported server-side. The thumbnail should be in JPEG format
    /// and less than 200 kB in size. A thumbnail's width and height should not exceed
    /// 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails
    /// can't be reused and can be only uploaded as a new file, so you can pass “attach:
    /// //<file_attach_name>” if the thumbnail was uploaded using multipart/form-data
    /// under <file_attach_name>
    /// </summary>
    property Thumb;
    /// <summary>
    /// Optional. Caption of the animation to be sent, 0-1024 characters after entities parsing
    /// parsing
    /// </summary>
    property Caption;
    /// <summary>
    /// Optional. Mode for parsing entities in the animation caption.
    /// See formatting options for more details.
    /// </summary>
    property ParseMode;
    /// <summary>
    /// Optional. Animation  width
    /// </summary>
    property Width: Int64 read FWidth write FWidth;
    /// <summary>
    /// Optional. Animation  height
    /// </summary>
    property Height: Int64 read FHeight write FHeight;
    /// <summary>
    /// Optional. Animation  duration
    /// </summary>
    property Duration: Int64 read FDuration write FDuration;
  end;

  /// <summary>
  /// Represents a video to be sent.
  /// </summary>
  TtgInputMediaVideo = class(TtgInputMediaAnimation)
  private
    [JsonName('supports_streaming')]
    FSupportsStreaming: Boolean;
  public
    constructor Create(AMedia: TcaFileToSend; const ACaption: string = ''; const AHeight: Integer = 0;
      const AWidth: Integer = 0; const ADuration: Integer = 0); reintroduce;
    /// <summary>
    /// Type of the result, must be "photo"
    /// </summary>
    property &Type;
    /// <summary>
    /// File to send. Pass a file_id to send a file that exists on the Telegram servers
    /// (recommended), pass an HTTP URL for Telegram to get a file from the Internet,
    /// or pass “attach://<file_attach_name>” to upload a new one using
    /// multipart/form-data under <file_attach_name> name.
    /// </summary>
    property Media;
    /// <summary>
    /// Optional. Thumbnail of the file sent; can be ignored if thumbnail generation
    /// for the file is supported server-side. The thumbnail should be in JPEG format
    /// and less than 200 kB in size. A thumbnail's width and height should not exceed
    /// 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails
    /// can't be reused and can be only uploaded as a new file, so you can pass “attach:
    /// //<file_attach_name>” if the thumbnail was uploaded using multipart/form-data
    /// under <file_attach_name>
    /// </summary>
    property Thumb;
    /// <summary>
    /// Optional. Caption of the video to be sent, 0-1024 characters after entities parsing
    /// parsing
    /// </summary>
    property Caption;
    /// <summary>
    /// Optional. Mode for parsing entities in the video caption.
    /// See formatting options for more details.
    /// </summary>
    property ParseMode;
    /// <summary>
    /// Optional. Video width
    /// </summary>
    property Width;
    /// <summary>
    /// Optional. Video height
    /// </summary>
    property Height;
    /// <summary>
    /// Optional. Video duration
    /// </summary>
    property Duration;
    /// <summary>
    /// Optional. Pass True, if the uploaded video is suitable for streaming
    /// </summary>
    property SupportsStreaming: Boolean read FSupportsStreaming write FSupportsStreaming;
  end;

  /// <summary>
  /// Represents an audio file to be treated as music to be sent.
  /// </summary>
  TtgInputMediaAudio = class(TtgInputMediaDocument)
  private
    [JsonName('duration')]
    FDuration: Int64;
    [JsonName('performer')]
    FPerformer: string;
    [JsonName('title')]
    FTitle: string;
  public
    constructor Create(AMedia: TcaFileToSend; const ACaption: string = ''); override;
    /// <summary>
    /// Type of the result, must be "audio"
    /// </summary>
    property &Type;
    /// <summary>
    /// File to send. Pass a file_id to send a file that exists on the Telegram servers
    /// (recommended), pass an HTTP URL for Telegram to get a file from the Internet,
    /// or pass “attach://<file_attach_name>” to upload a new one using
    /// multipart/form-data under <file_attach_name> name.
    /// </summary>
    property Media;
    /// <summary>
    /// Optional. Thumbnail of the file sent; can be ignored if thumbnail generation
    /// for the file is supported server-side. The thumbnail should be in JPEG format
    /// and less than 200 kB in size. A thumbnail's width and height should not exceed
    /// 320. Ignored if the file is not uploaded using multipart/form-data. Thumbnails
    /// can't be reused and can be only uploaded as a new file, so you can pass “attach:
    /// //<file_attach_name>” if the thumbnail was uploaded using multipart/form-data
    /// under <file_attach_name>
    /// </summary>
    property Thumb;
    /// <summary>
    /// Optional. Caption of the audio to be sent, 0-1024 characters after entities parsing
    /// parsing
    /// </summary>
    property Caption;
    /// <summary>
    /// Optional. Mode for parsing entities in the audio caption.
    /// See formatting options for more details.
    /// </summary>
    property ParseMode;
    /// <summary>
    /// Optional. Duration of the audio in seconds
    /// </summary>
    property Duration: Int64 read FDuration write FDuration;
    /// <summary>
    /// Optional. Performer of the audio
    /// </summary>
    property Performer: string read FPerformer write FPerformer;
    /// <summary>
    /// Optional. Title of the audio
    /// </summary>
    property Title: string read FTitle write FTitle;
  end;

  /// <summary> Contains information about the current status of a webhook.</summary>
  TtgWebhookInfo = class
  private
    [JsonName('allowed_updates')]
    [JsonName('url')]
    FUrl: string;
    [JsonName('has_custom_certificate')]
    FHasCustomCertificate: Boolean;
    [JsonName('pending_update_count')]
    FPendingUpdateCount: Integer;
    [JsonName('last_error_date')]
    [JsonConverter(TJsonUnixTimeConverter)]
    FLastErrorDate: TDateTime;
    [JsonName('last_error_message')]
    FLastErrorMessage: string;
    [JsonName('max_connections')]
    FMaxConnections: Integer;
    [JsonName('allowed_updates')]
    FAllowedUpdates: TAllowedUpdates;
  public
    /// <summary>
    /// Webhook URL, may be empty if webhook is not set up
    /// </summary>
    property Url: string read FUrl write FUrl;
    /// <summary>
    /// True, if a custom certificate was provided for webhook certificate checks
    /// </summary>
    property HasCustomCertificate: Boolean read FHasCustomCertificate write FHasCustomCertificate;
    /// <summary>
    /// Number of updates awaiting delivery
    /// </summary>
    property PendingUpdateCount: Integer read FPendingUpdateCount write FPendingUpdateCount;
    /// <summary>
    /// Optional. Unix time for the most recent error that happened when trying to
    /// deliver an update via webhook
    /// </summary>
    property LastErrorDate: TDateTime read FLastErrorDate write FLastErrorDate;
    /// <summary>
    /// Optional. Error message in human-readable format for the most recent error that
    /// happened when trying to deliver an update via webhook
    /// </summary>
    property LastErrorMessage: string read FLastErrorMessage write FLastErrorMessage;
    /// <summary>
    /// Optional. Maximum allowed number of simultaneous HTTPS connections to the
    /// webhook for update delivery
    /// </summary>
    property MaxConnections: Integer read FMaxConnections write FMaxConnections;
    /// <summary>
    /// Optional. A list of update types the bot is subscribed to. Defaults to all
    /// update types
    /// </summary>
    property AllowedUpdates: TAllowedUpdates read FAllowedUpdates write FAllowedUpdates;
  end;

  /// <summary>
  /// This object represents one special entity in a text message. For example,
  /// hashtags, usernames, URLs, etc.
  /// </summary>
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
    /// <summary>
    /// Type of the entity. Can be “mention” (@username), “hashtag” (#hashtag),
    /// “cashtag” ($USD), “bot_command” (/start@jobs_bot), “url” (https://telegram.org),
    /// “email” (do-not-reply@telegram.org), “phone_number” (+1-212-555-0123), “bold” (
    /// bold text), “italic” (italic text), “underline” (underlined text),
    /// “strikethrough” (strikethrough text), “code” (monowidth string), “pre” (
    /// monowidth block), “text_link” (for clickable text URLs), “text_mention” (for
    /// users without usernames)
    /// </summary>
    property &Type: TtgMessageEntityType read FType write FType;
    /// <summary>
    /// Offset in UTF-16 code units to the start of the entity
    /// </summary>
    property Offset: Int64 read FOffset write FOffset;
    /// <summary>
    /// Length of the entity in UTF-16 code units
    /// </summary>
    property Length: Int64 read FLength write FLength;
    /// <summary>
    /// Optional. For “text_link” only, url that will be opened after user taps on the
    /// text
    /// </summary>
    property Url: string read FUrl write FUrl;
    /// <summary>
    /// Optional. For “text_mention” only, the mentioned user
    /// </summary>
    property User: TtgUser read FUser write FUser;
    /// <summary>
    /// Optional. For “pre” only, the programming language of the entity text
    /// </summary>
    property Language: string read FLanguage write FLanguage;
  end;

  /// <summary>
  /// This object contains information about a poll.
  /// </summary>
  TtgPoll = class
  private
    [JsonName('id')]
    FID: string;
    [JsonName('question')]
    FQuestion: string;
    [JsonName('options')]
    FOptions: TArray<TtgPollOption>;
    [JsonName('total_voter_count')]
    FTotalVoterCount: Integer;
    [JsonName('is_closed')]
    FIsClosed: Boolean;
    [JsonName('is_anonymous')]
    FIsAnonymous: Boolean;
    [JsonName('type')]
    FType: string;
    [JsonName('allows_multiple_answers')]
    FAllowsMultipleAnswers: Boolean;
    [JsonName('correct_option_id')]
    FCorrectOptionId: Integer;
    [JsonName('explanation')]
    FExplanation: string;
    [JsonName('explanation_entities')]
    FExplanationEntities: TArray<TtgMessageEntity>;
    [JsonName('open_period')]
    FOpenPeriod: Integer;
    [JsonName('close_date')]
    [JsonConverter(TJsonUnixTimeConverter)]
    FCloseDate: TDateTime;
  public
    destructor Destroy; override;
    /// <summary>
    /// Unique poll identifier
    /// </summary>
    property ID: string read FID write FID;
    /// <summary>
    /// Poll question, 1-255 characters
    /// </summary>
    property Question: string read FQuestion write FQuestion;
    /// <summary>
    /// List of poll options
    /// </summary>
    property Options: TArray<TtgPollOption> read FOptions write FOptions;
    /// <summary>
    /// Total number of users that voted in the poll
    /// </summary>
    property TotalVoterCount: Integer read FTotalVoterCount write FTotalVoterCount;
    /// <summary>
    /// True, if the poll is closed
    /// </summary>
    property IsClosed: Boolean read FIsClosed write FIsClosed;
    /// <summary>
    /// True, if the poll is anonymous
    /// </summary>
    property IsAnonymous: Boolean read FIsAnonymous write FIsAnonymous;
    /// <summary>
    /// Poll type, currently can be “regular” or “quiz”
    /// </summary>
    property &Type: string read FType write FType;
    /// <summary>
    /// True, if the poll allows multiple answers
    /// </summary>
    property AllowsMultipleAnswers: Boolean read FAllowsMultipleAnswers write FAllowsMultipleAnswers;
    /// <summary>
    /// Optional. 0-based identifier of the correct answer option. Available only for
    /// polls in the quiz mode, which are closed, or was sent (not forwarded) by the
    /// bot or to the private chat with the bot.
    /// </summary>
    property CorrectOptionId: Integer read FCorrectOptionId write FCorrectOptionId;
    /// <summary>
    /// Optional. Special entities like usernames, URLs, bot commands, etc. that appear
    /// in the explanation
    /// </summary>
    property Explanation: string read FExplanation write FExplanation;
    /// <summary>
    /// Optional. Special entities like usernames, URLs, bot commands, etc. that appear
    /// in the explanation
    /// </summary>
    property ExplanationEntities: TArray<TtgMessageEntity> read FExplanationEntities write FExplanationEntities;
    /// <summary>
    /// Optional. Amount of time in seconds the poll will be active after creation
    /// </summary>
    property OpenPeriod: Integer read FOpenPeriod write FOpenPeriod;
    /// <summary>
    /// Optional. Point in time (Unix timestamp) when the poll will be automatically
    /// closed
    /// </summary>
    property CloseDate: TDateTime read FCloseDate write FCloseDate;
  end;

  /// <summary>
  /// This object represents a chat.
  /// </summary>
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
    [JsonName('bio')]
    FBio: string;
    [JsonName('permissions')]
    FPermissions: TtgChatPermissions;
    [JsonName('linked_chat_id')]
    FLinkedChatId: Int64;
    [JsonName('location')]
    FLocation: TtgChatLocation;
  public
    constructor Create;
    destructor Destroy; override;
    /// <summary>
    /// Unique identifier for this chat. This number may be greater than 32 bits and
    /// some programming languages may have difficulty/silent defects in interpreting
    /// it. But it is smaller than 52 bits, so a signed 64 bit integer or
    /// double-precision float type are safe for storing this identifier.
    /// </summary>
    property ID: Int64 read FID write FID;
    /// <summary>
    /// Type of chat, can be either “private”, “group”, “supergroup” or “channel”
    /// </summary>
    property &Type: string read FType write FType;
    /// <summary>
    /// Optional. Title, for supergroups, channels and group chats
    /// </summary>
    property Title: string read FTitle write FTitle;
    /// <summary>
    /// Optional. Username, for private chats, supergroups and channels if available
    /// </summary>
    property Username: string read FUsername write FUsername;
    /// <summary>
    /// Optional. First name of the other party in a private chat
    /// </summary>
    property FirstName: string read FFirstName write FFirstName;
    /// <summary>
    /// Optional. Last name of the other party in a private chat
    /// </summary>
    property LastName: string read FLastName write FLastName;
    /// <summary> Optional. Chat photo. Returned only in getChat <see
    /// cref="TTelegramBotApi.getChat"/>.
    /// </summary>
    property Photo: TtgChatPhoto read FPhoto write FPhoto;
    /// <summary>
    /// Optional. Bio of the other party in a private chat. Returned only in getChat
    /// <see cref="TTelegramBotApi.getChat"/>.
    /// </summary>
    property Bio: string read FBio write FBio;
    /// <summary>
    /// Optional. Description, for groups, supergroups and channel chats. Returned only
    /// in getChat <see cref="TTelegramBotApi.getChat"/>.
    /// </summary>
    property Description: string read FDescription write FDescription;
    /// <summary> Optional. Chat invite link, for groups, supergroups and channel chats.
    /// Each administrator in a chat generates their own invite links, so the bot must
    /// first generate the link using exportChatInviteLink <see cref="TTelegramBotApi.
    /// ExportChatInviteLink"/>.
    /// Returned only in getChat <see cref="TTelegramBotApi.getChat"/>.
    /// </summary>
    property InviteLink: string read FInviteLink write FInviteLink;
    /// <summary>
    /// Optional. The most recent pinned message (by sending date). Returned only in
    /// getChat <see cref="TTelegramBotApi.getChat"/>.
    /// </summary>
    property PinnedMessage: TtgMessage read FPinnedMessage write FPinnedMessage;
    /// <summary>
    /// Optional. Default chat member permissions, for groups and supergroups. Returned
    /// only in getChat <see cref="TTelegramBotApi.getChat"/>.
    /// </summary>
    property Permissions: TtgChatPermissions read FPermissions write FPermissions;
    /// <summary>
    /// Optional. For supergroups, the minimum allowed delay between consecutive
    /// messages sent by each unpriviledged user. Returned only in getChat <see
    /// cref="TTelegramBotApi.getChat"/>.
    /// </summary>
    property SlowModeDelay: Int64 read FSlowModeDelay write FSlowModeDelay;
    /// <summary>
    /// Optional. For supergroups, name of group sticker set. Returned only in getChat
    /// <see cref="TTelegramBotApi.getChat"/>.
    /// </summary>
    property StickerSetName: string read FStickerSetName write FStickerSetName;
    /// <summary>
    /// Optional. True, if the bot can change the group sticker set. Returned only in
    /// getChat <see cref="TTelegramBotApi.getChat"/>.
    /// </summary>
    property CanSetStickerSet: Boolean read FCanSetStickerSet write FCanSetStickerSet;
    /// <summary>
    /// Optional. Unique identifier for the linked chat, i.e. the discussion group
    /// identifier for a channel and vice versa; for supergroups and channel chats.
    /// This identifier may be greater than 32 bits and some programming languages may
    /// have difficulty/silent defects in interpreting it. But it is smaller than 52
    /// bits, so a signed 64 bit integer or double-precision float type are safe for
    /// storing this identifier. Returned only in getChat.
    /// </summary>
    property LinkedChatId: Int64 read FLinkedChatId write FLinkedChatId;
    /// <summary>
    /// Optional. For supergroups, the location to which the supergroup is connected.
    /// Returned only in getChat.
    /// </summary>
    property Location: TtgChatLocation read FLocation write FLocation;
  end;

  /// <summary>
  /// This object represents a message.
  /// </summary>
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
    [JsonName('media_group_id')]
    FMediaGroupId: string;
    [JsonName('poll')]
    FPoll: TtgPoll;
    [JsonName('sender_chat')]
    FSenderChat: TtgChat;
    [JsonName('forward_from')]
    FForwardFrom: TtgUser;
    [JsonName('forward_sender_name')]
    FForwardSenderName: string;
    [JsonName('reply_to_message')]
    FReplyToMessage: TtgMessage;
    [JsonName('via_bot')]
    FViaBot: TtgUser;
    [JsonName('edit_date')]
    [JsonConverter(TJsonUnixTimeConverter)]
    FEditDate: TDateTime;
    [JsonName('author_signature')]
    FAuthorSignature: string;
    [JsonName('sticker')]
    FSticker: TtgSticker;
    [JsonName('dice')]
    FDice: TtgDice;
    [JsonName('game')]
    FGame: TtgGame;
    [JsonName('location')]
    FLocation: TtgLocation;
    [JsonName('new_chat_members')]
    FNewChatMembers: TArray<TtgUser>;
    [JsonName('left_chat_member')]
    FLeftChatMember: TtgUser;
    [JsonName('new_chat_title')]
    FNewChatTitle: string;
    [JsonName('new_chat_photo')]
    FNewChatPhoto: TArray<TtgPhotosize>;
    [JsonName('delete_chat_photo')]
    FDeleteChatPhoto: Boolean;
    [JsonName('group_chat_created')]
    FGroupChatCreated: Boolean;
    [JsonName('supergroup_chat_created')]
    FSupergroupChatCreated: Boolean;
    [JsonName('channel_chat_created')]
    FChannelChatCreated: Boolean;
    [JsonName('migrate_from_chat_id')]
    FMigrateFromChatId: Int64;
    [JsonName('pinned_message')]
    FPinnedMessage: TtgMessage;
    [JsonName('invoice')]
    FInvoice: TtgInvoice;
    [JsonName('successful_payment')]
    FSuccessfulPayment: TtgSuccessfulPayment;
    [JsonName('connected_website')]
    FConnectedWebsite: string;
    [JsonName('passport_data')]
    FPassportData: TtgPassportData;
    [JsonName('proximity_alert_triggered')]
    FProximityAlertTriggered: TtgProximityAlertTriggered;
    [JsonName('reply_markup')]
    FReplyMarkup: TtgInlineKeyboardMarkup;
  public
    constructor Create;
    destructor Destroy; override;
    function &Type: TtgMessageType;
  public
    /// <summary>
    /// Unique message identifier inside this chat
    /// </summary>
    property MessageID: Int64 read FMessageID write FMessageID;
    /// <summary>
    /// Optional. Sender, empty for messages sent to channels
    /// </summary>
    property From: TtgUser read FFrom write FFrom;
    /// <summary>
    /// Optional. Sender of the message, sent on behalf of a chat. The channel itself
    /// for channel messages. The supergroup itself for messages from anonymous group
    /// administrators. The linked channel for messages automatically forwarded to the
    /// discussion group
    /// </summary>
    property SenderChat: TtgChat read FSenderChat write FSenderChat;
    /// <summary>
    /// Date the message was sent in Unix time and converted to TDateTime
    /// </summary>
    property Date: TDateTime read FDate write FDate;
    /// <summary>
    /// Conversation the message belongs to
    /// </summary>
    property Chat: TtgChat read FChat write FChat;
    /// <summary>
    /// Optional. For forwarded messages, sender of the original message
    /// </summary>
    property ForwardFrom: TtgUser read FForwardFrom write FForwardFrom;
    /// <summary>
    /// Optional. For messages forwarded from channels or from anonymous administrators,
    /// information about the original sender chat
    /// </summary>
    property ForwardFromChat: TtgChat read FForwardFromChat write FForwardFromChat;
    /// <summary>
    /// Optional. For messages forwarded from channels, identifier of the original
    /// message in the channel
    /// </summary>
    property ForwardFromMessageId: Int64 read FForwardFromMessageId write FForwardFromMessageId;
    /// <summary>
    /// Optional. For messages forwarded from channels, signature of the post author if
    /// present
    /// </summary>
    property ForwardSignature: string read FForwardSignature write FForwardSignature;
    /// <summary>
    /// Optional. Sender's name for messages forwarded from users who disallow adding a
    /// link to their account in forwarded messages
    /// </summary>
    property ForwardSenderName: string read FForwardSenderName write FForwardSenderName;
    /// <summary>
    /// Optional. For forwarded messages, date the original message was sent in Unix
    /// time
    /// </summary>
    property ForwardDate: TDateTime read FForwardDate write FForwardDate;
    /// <summary>
    /// Optional. For replies, the original message. Note that the Message object in
    /// this field will not contain further reply_to_message fields even if it itself
    /// is a reply.
    /// </summary>
    property ReplyToMessage: TtgMessage read FReplyToMessage;
    /// <summary>
    /// Optional. Bot through which the message was sent
    /// </summary>
    property ViaBot: TtgUser read FViaBot write FViaBot;
    /// <summary>
    /// Optional. Date the message was last edited in Unix time
    /// </summary>
    property EditDate: TDateTime read FEditDate write FEditDate;
    /// <summary>
    /// Optional. The unique identifier of a media message group this message belongs to
    /// </summary>
    property MediaGroupId: string read FMediaGroupId write FMediaGroupId;
    /// <summary>
    /// Optional. Signature of the post author for messages in channels, or the custom
    /// title of an anonymous group administrator
    /// </summary>
    property AuthorSignature: string read FAuthorSignature write FAuthorSignature;
    /// <summary>
    /// Optional. For text messages, the actual UTF-8 text of the message, 0-4096
    /// characters
    /// </summary>
    property Text: string read FText write FText;
    /// <summary>
    /// Optional. For text messages, special entities like usernames, URLs, bot
    /// commands, etc. that appear in the text
    /// </summary>
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
    /// <summary>
    /// Optional. Message is a photo, available sizes of the photo
    /// </summary>
    property Photo: TObjectList<TtgPhotosize> read FPhoto write FPhoto;
    /// <summary>
    /// Optional. Message is a sticker, information about the sticker
    /// </summary>
    property Sticker: TtgSticker read FSticker write FSticker;
    /// <summary>
    /// Optional. Message is a video, information about the video
    /// </summary>
    property Video: TtgVideo read FVideo write FVideo;
    /// <summary>
    /// Optional. Message is a video note, information about the video message
    /// </summary>
    property VideoNote: TtgVideoNote read FVideoNote write FVideoNote;
    /// <summary>
    /// Optional. Message is a voice message, information about the file
    /// </summary>
    property Voice: TtgVoice read FVoice write FVoice;
    /// <summary>
    /// Optional. Caption for the animation, audio, document, photo, video or voice,
    /// 0-1024 characters
    /// </summary>
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
    /// Optional. Message is a dice with random value from 1 to 6
    /// </summary>
    property Dice: TtgDice read FDice write FDice;
    /// <summary>
    /// Optional. Message is a game, information about the game. More about games »
    /// </summary>
    property Game: TtgGame read FGame write FGame;
    /// <summary>
    /// Optional. Message is a native poll, information about the poll
    /// </summary>
    property Poll: TtgPoll read FPoll write FPoll;
    /// <summary>
    /// Optional. Message is a venue, information about the venue. For backward
    /// compatibility, when this field is set, the location field will also be set
    /// </summary>
    property Venue: TtgVenue read FVenue write FVenue;
    /// <summary>
    /// Optional. Message is a shared location, information about the location
    /// </summary>
    property Location: TtgLocation read FLocation write FLocation;
    /// <summary>
    /// Optional. New members that were added to the group or supergroup and
    /// information about them (the bot itself may be one of these members)
    /// </summary>
    property NewChatMembers: TArray<TtgUser> read FNewChatMembers write FNewChatMembers;
    /// <summary>
    /// Optional. A member was removed from the group, information about them (this
    /// member may be the bot itself)
    /// </summary>
    property LeftChatMember: TtgUser read FLeftChatMember write FLeftChatMember;
    /// <summary>
    /// Optional. A chat title was changed to this value
    /// </summary>
    property NewChatTitle: string read FNewChatTitle write FNewChatTitle;
    /// <summary>
    /// Optional. A chat photo was change to this value
    /// </summary>
    property NewChatPhoto: TArray<TtgPhotosize> read FNewChatPhoto write FNewChatPhoto;
    /// <summary>
    /// Optional. Service message: the chat photo was deleted
    /// </summary>
    property DeleteChatPhoto: Boolean read FDeleteChatPhoto write FDeleteChatPhoto;
    /// <summary>
    /// Optional. Service message: the group has been created
    /// </summary>
    property GroupChatCreated: Boolean read FGroupChatCreated write FGroupChatCreated;
    /// <summary>
    /// Optional. Service message: the supergroup has been created. This field can't be
    /// received in a message coming through updates, because bot can't be a member of
    /// a supergroup when it is created. It can only be found in reply_to_message if
    /// someone replies to a very first message in a directly created supergroup.
    /// </summary>
    property SupergroupChatCreated: Boolean read FSupergroupChatCreated write FSupergroupChatCreated;
    /// <summary>
    /// Optional. Service message: the channel has been created. This field can't be
    /// received in a message coming through updates, because bot can't be a member of
    /// a channel when it is created. It can only be found in reply_to_message if
    /// someone replies to a very first message in a channel.
    /// </summary>
    property ChannelChatCreated: Boolean read FChannelChatCreated write FChannelChatCreated;
    /// <summary>
    /// Optional. The supergroup has been migrated from a group with the specified
    /// identifier. This number may be greater than 32 bits and some programming
    /// languages may have difficulty/silent defects in interpreting it. But it is
    /// smaller than 52 bits, so a signed 64 bit integer or double-precision float type
    /// are safe for storing this identifier.
    /// </summary>
    property MigrateFromChatId: Int64 read FMigrateFromChatId write FMigrateFromChatId;
    /// <summary>
    /// Optional. Specified message was pinned. Note that the Message object in this
    /// field will not contain further reply_to_message fields even if it is itself a
    /// reply.
    /// </summary>
    property PinnedMessage: TtgMessage read FPinnedMessage write FPinnedMessage;
    /// <summary>
    /// Optional. Message is an invoice for a payment, information about the invoice.
    /// More about payments »
    /// </summary>
    property Invoice: TtgInvoice read FInvoice write FInvoice;
    /// <summary>
    /// Optional. Message is a service message about a successful payment, information
    /// about the payment. More about payments »
    /// </summary>
    property SuccessfulPayment: TtgSuccessfulPayment read FSuccessfulPayment write FSuccessfulPayment;
    /// <summary>
    /// Optional. The domain name of the website on which the user has logged in. More
    /// about Telegram Login »
    /// </summary>
    property ConnectedWebsite: string read FConnectedWebsite write FConnectedWebsite;
    /// <summary>
    /// Optional. Telegram Passport data
    /// </summary>
    property PassportData: TtgPassportData read FPassportData write FPassportData;
    /// <summary>
    /// Optional. Service message. A user in the chat triggered another user's
    /// proximity alert while sharing Live Location.
    /// </summary>
    property ProximityAlertTriggered: TtgProximityAlertTriggered read FProximityAlertTriggered
      write FProximityAlertTriggered;
    /// <summary>
    /// Optional. Inline keyboard attached to the message. login_url buttons are
    /// represented as ordinary url buttons.
    /// </summary>
    property ReplyMarkup: TtgInlineKeyboardMarkup read FReplyMarkup write FReplyMarkup;
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
  /// This object represent a user's profile pictures.
  /// </summary>
  TtgUserProfilePhotos = class
  private
    [JsonName('total_count')]
    FTotalCount: Integer;
    [JsonName('photos')]
    FPhotos: TArray<TArray<TtgPhotosize>>;
  public
    /// <summary>
    /// Total number of profile pictures the target user has
    /// </summary>
    property TotalCount: Integer read FTotalCount write FTotalCount;
    /// <summary>
    /// Requested profile pictures (in up to 4 sizes each)
    /// </summary>
    property Photos: TArray < TArray < TtgPhotosize >> read FPhotos write FPhotos;
  end;

  /// <summary>
  /// This object contains information about one member of a chat.
  /// </summary>
  TtgChatMember = class
  private
    [JsonName('user')]
    FUser: TtgUser;
    [JsonName('status')]
    FStatus: string;
    [JsonName('custom_title')]
    FCustomTitle: string;
    [JsonName('is_anonymous')]
    FIsAnonymous: Boolean;
    [JsonName('can_be_edited')]
    FCanBeEdited: Boolean;
    [JsonName('can_post_messages')]
    FCanPostMessages: Boolean;
    [JsonName('can_edit_messages')]
    FCanEditMessages: Boolean;
    [JsonName('can_delete_messages')]
    FCanDeleteMessages: Boolean;
    [JsonName('can_restrict_members')]
    FCanRestrictMembers: Boolean;
    [JsonName('can_promote_members')]
    FCanPromoteMembers: Boolean;
    [JsonName('can_change_info')]
    FCanChangeInfo: Boolean;
    [JsonName('can_invite_users')]
    FCanInviteUsers: Boolean;
    [JsonName('can_pin_messages')]
    FCanPinMessages: Boolean;
    [JsonName('is_member')]
    FIsMember: Boolean;
    [JsonName('can_send_messages')]
    FCanSendMessages: Boolean;
    [JsonName('can_send_media_messages')]
    FCanSendMediaMessages: Boolean;
    [JsonName('can_send_polls')]
    FCanSendPolls: Boolean;
    [JsonName('can_send_other_messages')]
    FCanSendOtherMessages: Boolean;
    [JsonName('can_add_web_page_previews')]
    FCanAddWebPagePreviews: Boolean;
    [JsonName('until_date')]
    [JsonConverter(TJsonUnixTimeConverter)]
    FUntilDate: TDateTime;
  public
    /// <summary>
    /// Information about the user
    /// </summary>
    property User: TtgUser read FUser write FUser;
    /// <summary>
    /// The member's status in the chat. Can be “creator”, “administrator”, “member”,
    /// “restricted”, “left” or “kicked”
    /// </summary>
    property Status: string read FStatus write FStatus;
    /// <summary>
    /// Optional. Owner and administrators only. Custom title for this user
    /// </summary>
    property CustomTitle: string read FCustomTitle write FCustomTitle;
    /// <summary>
    /// Optional. Owner and administrators only. True, if the user's presence in the
    /// chat is hidden
    /// </summary>
    property IsAnonymous: Boolean read FIsAnonymous write FIsAnonymous;
    /// <summary>
    /// Optional. Administrators only. True, if the bot is allowed to edit
    /// administrator privileges of that user
    /// </summary>
    property CanBeEdited: Boolean read FCanBeEdited write FCanBeEdited;
    /// <summary>
    /// Optional. Administrators only. True, if the administrator can post in the
    /// channel; channels only
    /// </summary>
    property CanPostMessages: Boolean read FCanPostMessages write FCanPostMessages;
    /// <summary>
    /// Optional. Administrators only. True, if the administrator can edit messages of
    /// other users and can pin messages; channels only
    /// </summary>
    property CanEditMessages: Boolean read FCanEditMessages write FCanEditMessages;
    /// <summary>
    /// Optional. Administrators only. True, if the administrator can delete messages
    /// of other users
    /// </summary>
    property CanDeleteMessages: Boolean read FCanDeleteMessages write FCanDeleteMessages;
    /// <summary>
    /// Optional. Administrators only. True, if the administrator can restrict, ban or
    /// unban chat members
    /// </summary>
    property CanRestrictMembers: Boolean read FCanRestrictMembers write FCanRestrictMembers;
    /// <summary>
    /// Optional. Administrators only. True, if the administrator can add new
    /// administrators with a subset of their own privileges or demote administrators
    /// that he has promoted, directly or indirectly (promoted by administrators that
    /// were appointed by the user)
    /// </summary>
    property CanPromoteMembers: Boolean read FCanPromoteMembers write FCanPromoteMembers;
    /// <summary>
    /// Optional. Administrators and restricted only. True, if the user is allowed to
    /// change the chat title, photo and other settings
    /// </summary>
    property CanChangeInfo: Boolean read FCanChangeInfo write FCanChangeInfo;
    /// <summary>
    /// Optional. Administrators and restricted only. True, if the user is allowed to
    /// invite new users to the chat
    /// </summary>
    property CanInviteUsers: Boolean read FCanInviteUsers write FCanInviteUsers;
    /// <summary>
    /// Optional. Administrators and restricted only. True, if the user is allowed to
    /// pin messages; groups and supergroups only
    /// </summary>
    property CanPinMessages: Boolean read FCanPinMessages write FCanPinMessages;
    /// <summary>
    /// Optional. Restricted only. True, if the user is a member of the chat at the
    /// moment of the request
    /// </summary>
    property IsMember: Boolean read FIsMember write FIsMember;
    /// <summary>
    /// Optional. Restricted only. True, if the user is allowed to send text messages,
    /// contacts, locations and venues
    /// </summary>
    property CanSendMessages: Boolean read FCanSendMessages write FCanSendMessages;
    /// <summary>
    /// Optional. Restricted only. True, if the user is allowed to send audios,
    /// documents, photos, videos, video notes and voice notes
    /// </summary>
    property CanSendMediaMessages: Boolean read FCanSendMediaMessages write FCanSendMediaMessages;
    /// <summary>
    /// Optional. Restricted only. True, if the user is allowed to send polls
    /// </summary>
    property CanSendPolls: Boolean read FCanSendPolls write FCanSendPolls;
    /// <summary>
    /// Optional. Restricted only. True, if the user is allowed to send animations,
    /// games, stickers and use inline bots
    /// </summary>
    property CanSendOtherMessages: Boolean read FCanSendOtherMessages write FCanSendOtherMessages;
    /// <summary>
    /// Optional. Restricted only. True, if the user is allowed to add web page
    /// previews to their messages
    /// </summary>
    property CanAddWebPagePreviews: Boolean read FCanAddWebPagePreviews write FCanAddWebPagePreviews;
    /// <summary>
    /// Optional. Restricted and kicked only. Date when restrictions will be lifted for
    /// this user; unix time
    /// </summary>
    property UntilDate: TDateTime read FUntilDate write FUntilDate;
  end;

  /// <summary>
  /// This object represents a bot command.
  /// </summary>
  TtgBotCommand = class
  private
    [JsonName('command')]
    FCommand: string;
    [JsonName('description')]
    FDescription: string;
  published
    /// <summary>
    /// Text of the command, 1-32 characters. Can contain only lowercase English
    /// letters, digits and underscores.
    /// </summary>
    property Command: string read FCommand write FCommand;
    /// <summary>
    /// Description of the command, 3-256 characters.
    /// </summary>
    property Description: string read FDescription write FDescription;
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

constructor TtgResponse<t>.Create;
begin
  inherited Create;

end;

destructor TtgResponse<t>.Destroy;
begin
  case GetTypeKind(t) of
    tkClass:
      PObject(@FResult).Free; // DONE -o@rareMax -cMemLeack: Проверить, рабочий ли это способ очистки памяти
  end;
  inherited Destroy;
end;

function TtgResponse<t>.GetResponse: IcaResponseBase;
begin
  Result := FResponse;
end;

function TtgResponse<t>.GetResult: t;
begin
  Result := FResult;
end;

{ TtgResponse<T> }

procedure TtgResponse<t>.SetResponse(const Value: IcaResponseBase);
begin
  FResponse := Value;
end;

procedure TtgResponse<t>.SetResult(const Value: t);
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
  else if Assigned(Poll) then
    Exit(TtgMessageType.Poll)
  else
  begin
    Result := TtgMessageType.Unknown;
    TcaExceptionManager.Current.Alert('TtgMessage.Type', 'Unknown TtgMessage.Type');
  end;
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
    TtgMessageType.Poll:
      FPoll.Free;
  end;
  FCaptionEntities.Free;
  FEntities.Free;
  FFrom.Free;
  FChat.Free;
  FForwardFromChat.Free;
  FPhoto.Free;
  inherited;
end;

{ TtgUpdate }
constructor TtgUpdate.Create;
begin
  inherited Create;
  FMessage := nil;
  FEditedMessage := nil;

end;

destructor TtgUpdate.Destroy;
begin
  if Assigned(FEditedMessage) then
    FEditedMessage.Free;
  if Assigned(FMessage) then
    FMessage.Free;
  inherited Destroy;
end;

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

constructor TtgInputMedia.Create(AMedia: TcaFileToSend; const ACaption: string = '');
begin
  FFileToSend := AMedia;
  FCaption := ACaption;
  case AMedia.&Type of
    TcaFileToSendType.ID, TcaFileToSendType.Url:
      FMedia := AMedia.GetUrlOrIdOrFilePath;
    TcaFileToSendType.File, TcaFileToSendType.Stream:
      FMedia := 'attach://' + ExtractFileName(AMedia.Name);
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

{ TtgInputMediaPhoto }

constructor TtgInputMediaPhoto.Create(AMedia: TcaFileToSend; const ACaption: string = '');
begin
  inherited Create(AMedia, ACaption);
  FType := 'photo';
end;

{ TtgInputMediaAudio }

constructor TtgInputMediaVideo.Create(AMedia: TcaFileToSend; const ACaption: string = ''; const AHeight: Integer = 0;
  const AWidth: Integer = 0; const ADuration: Integer = 0);
begin
  inherited Create(AMedia, ACaption);
  FType := 'video';
  FHeight := AHeight;
  FWidth := AWidth;
  FDuration := ADuration;
end;

{ TtgInputMediaAudio }

constructor TtgInputMediaAudio.Create(AMedia: TcaFileToSend; const ACaption: string = '');
begin
  inherited Create(AMedia, ACaption);
  FType := 'audio';
end;

{ TtgInputMediaAnimation }

constructor TtgInputMediaAnimation.Create(AMedia: TcaFileToSend; const ACaption: string = '');
begin
  inherited Create(AMedia, ACaption);
  FType := 'animation';
end;

{ TtgInputMediaDocument }

constructor TtgInputMediaDocument.Create(AMedia: TcaFileToSend; const ACaption: string = '');
begin
  inherited Create(AMedia, ACaption);
  FType := 'document';
end;

{ TtgPoll }

destructor TtgPoll.Destroy;
var
  I: Integer;
begin
  for I := Low(FOptions) to High(FOptions) do
    FOptions[I].Free;
  inherited;
end;

end.
