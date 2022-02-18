unit TelegramBotApi.Request.Stickers;

interface

uses
  CloudAPI.Attributes,
  CloudAPI.Types,
  TelegramBotApi.Types;

type

  /// <summary> Use this method to create a new sticker set owned by a user. The bot
  /// will be able to edit the sticker set thus created. You must use exactly one of
  /// the fields png_sticker, tgs_sticker, or webm_sticker. Returns True on success.
  /// </summary>
  [caName('createNewStickerSet')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgCreateNewStickerSet = class abstract
  private
    [caName('user_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FUserID: Int64;
    [caName('name')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FName: string;
    [caName('title')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FTitle: string;
    [caName('emojis')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FEmojis: string;
    [caName('contains_masks')]
    [caDefaultValueBoolean(False)]
    FContainsMasks: Boolean;
    [caName('mask_position')]
    FMaskPosition: TtgMaskPosition;
  public
    constructor Create; virtual; abstract;
    /// <summary>
    /// User identifier of created sticker set owner
    /// </summary>
    property UserID: Int64 read FUserID write FUserID;
    /// <summary>
    /// Short name of sticker set, to be used in t.me/addstickers/ URLs (e.g., animals).
    /// Can contain only english letters, digits and underscores. Must begin with a
    /// letter, can't contain consecutive underscores and must end in “_by_<bot
    /// username>”. <bot_username> is case insensitive. 1-64 characters.
    /// </summary>
    property Name: string read FName write FName;
    /// <summary>
    /// Sticker set title, 1-64 characters
    /// </summary>
    property Title: string read FTitle write FTitle;
    /// <summary>
    /// One or more emoji corresponding to the sticker
    /// </summary>
    property Emojis: string read FEmojis write FEmojis;
    /// <summary>
    /// Pass True, if a set of mask stickers should be created
    /// </summary>
    property ContainsMasks: Boolean read FContainsMasks write FContainsMasks;
    /// <summary>
    /// A JSON-serialized object for position where the mask should be placed on faces
    /// </summary>
    property MaskPosition: TtgMaskPosition read FMaskPosition write FMaskPosition;
  end;

  TtgCreateNewStickerSetPng = class(TtgCreateNewStickerSet)
  private
    [caName('png_sticker')]
    [caDefaultValueString('')]
    FPngSticker: TcaFileToSend;
  public
    constructor Create; override;
    /// <summary>
    /// PNG image with the sticker, must be up to 512 kilobytes in size, dimensions
    /// must not exceed 512px, and either width or height must be exactly 512px. Pass a
    /// file_id as a String to send a file that already exists on the Telegram servers,
    /// pass an HTTP URL as a String for Telegram to get a file from the Internet, or
    /// upload a new one using multipart/form-data. More info on Sending Files »
    /// </summary>
    property PngSticker: TcaFileToSend read FPngSticker write FPngSticker;
  end;

  TtgCreateNewStickerSetTgs = class(TtgCreateNewStickerSet)
  private
    [caName('tgs_sticker')]
    [caDefaultValueString('')]
    FTgdSticker: TcaFileToSend;
  public
    constructor Create; override;
    /// <summary>
    /// Tgs image with the sticker, must be up to 512 kilobytes in size, dimensions
    /// must not exceed 512px, and either width or height must be exactly 512px. Pass a
    /// file_id as a String to send a file that already exists on the Telegram servers,
    /// pass an HTTP URL as a String for Telegram to get a file from the Internet, or
    /// upload a new one using multipart/form-data. More info on Sending Files »
    /// </summary>
    property TgdSticker: TcaFileToSend read FTgdSticker write FTgdSticker;
  end;

  TtgCreateNewStickerSetWebM = class(TtgCreateNewStickerSet)
  private
    [caName('webm_sticker')]
    [caDefaultValueString('')]
    FWebMSticker: TcaFileToSend;
  public
    constructor Create; override;
    /// <summary>
    /// WebM image with the sticker, must be up to 512 kilobytes in size, dimensions
    /// must not exceed 512px, and either width or height must be exactly 512px. Pass a
    /// file_id as a String to send a file that already exists on the Telegram servers,
    /// pass an HTTP URL as a String for Telegram to get a file from the Internet, or
    /// upload a new one using multipart/form-data. More info on Sending Files »
    /// </summary>
    property WebMSticker: TcaFileToSend read FWebMSticker write FWebMSticker;
  end;

implementation

{ TtgCreateNewStickerSetPng }

constructor TtgCreateNewStickerSetPng.Create;
begin
  FPngSticker := nil;
end;

{ TtgCreateNewStickerSetTgs }

constructor TtgCreateNewStickerSetTgs.Create;
begin
  FTgdSticker := nil;
end;

{ TtgCreateNewStickerSetWebM }

constructor TtgCreateNewStickerSetWebM.Create;
begin
  FWebMSticker := nil;
end;

end.
