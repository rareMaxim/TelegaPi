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

unit TelegramBotApi.Types.Abstract;

interface

uses
  CloudAPI.Attributes,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Keyboards,
  TelegramBotApi.Types.Enums, CloudAPI.Types;

type
  TtgMessageAbstract = class
  private
    [caName('chat_id')]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caDefaultValueBoolean(False)]
    [caName('disable_notification')]
    FDisableNotification: Boolean;
    [caName('reply_markup')]
    FReplyMarkup: TtgKeyboardAbstractProto;
  public
    constructor Create; virtual; abstract;
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;

    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification: Boolean read FDisableNotification write FDisableNotification;
    /// <summary>
    /// A JSON-serialized object for an keyboard
    /// </summary>
    property ReplyMarkup: TtgKeyboardAbstractProto read FReplyMarkup write FReplyMarkup;
  end;

  TtgSendMessageBase = class(TtgMessageAbstract)
  private
    [caName('reply_to_message_id')]
    [caDefaultValueInt64(0)]
    FReplyToMessageId: Int64;
    [caName('allow_sending_without_reply')]
    [caDefaultValueBoolean(False)]
    FAllowSendingWithoutReply: Boolean;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification;
    /// <summary>If the message is a reply, ID of the original message</summary>
    property ReplyToMessageId: Int64 read FReplyToMessageId write FReplyToMessageId;
    /// <summary>
    /// Pass True, if the message should be sent even if the specified replied-to
    /// message is not found
    /// </summary>
    property AllowSendingWithoutReply: Boolean read FAllowSendingWithoutReply write FAllowSendingWithoutReply;
    constructor Create; override;
  end;

  TtgSendMessageBaseWithParseMode = class(TtgSendMessageBase)
  private
    [caName('parse_mode')]
    [caDefaultValueString('')]
    FParseMode: TtgParseMode;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in your bot's message.   </summary>
    property ParseMode: TtgParseMode read FParseMode write FParseMode;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification;
    /// <summary>If the message is a reply, ID of the original message</summary>
    property ReplyToMessageId;
    /// <summary>
    /// Pass True, if the message should be sent even if the specified replied-to
    /// message is not found
    /// </summary>
    property AllowSendingWithoutReply;
    constructor Create; override;
  end;

  TtgSendMediaAbstractArgument = class(TtgSendMessageBaseWithParseMode)
  private
    [caName('caption')]
    [caDefaultValueStringAttribute('')]
    FCaption: string;
    [caName('caption_entities')]
    [caDefaultValueString('[]')]
    FCaptionEntities: TArray<TtgMessageEntity>;
  public
    constructor Create; override;
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>Caption, 0-1024 characters after entities parsing</summary>
    property Caption: string read FCaption write FCaption;
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in your bot's message.   </summary>
    property ParseMode;
    /// <summary> List of special entities that appear in the new caption, which can be
    /// specified instead of parse_mode
    /// </summary>
    property CaptionEntities: TArray<TtgMessageEntity> read FCaptionEntities write FCaptionEntities;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification;
    /// <summary>If the message is a reply, ID of the original message</summary>
    property ReplyToMessageId;
    /// <summary>
    /// Pass True, if the message should be sent even if the specified replied-to
    /// message is not found
    /// </summary>
    property AllowSendingWithoutReply;
  end;

  TtgSendMediaWithThumbAbstractArgument = class(TtgSendMediaAbstractArgument)
  private
    [caName('thumb')]
    [caDefaultValueStringAttribute('')]
    fThumb: TcaFileToSend;
  public
    constructor Create; override;
    /// <summary>Thumbnail of the file sent; can be ignored if thumbnail generation for
    /// the file is supported server-side. The thumbnail should be in JPEG format and
    /// less than 200 kB in size. A thumbnail‘s width and height should not exceed 320.
    /// Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t
    /// be reused and can be only uploaded as a new file, so you can pass “attach:
    /// file_attach_name” if the thumbnail was uploaded using multipart/form-data
    /// under file_attach_name. More info on Sending Files »</summary>
    property Thumb: TcaFileToSend read fThumb write fThumb;
  end;

  TtgSendVideoOrAnimationArgument = class(TtgSendMediaWithThumbAbstractArgument)
  private
    [caName('duration')]
    [caDefaultValueInt64(0)]
    fDuration: Int64;
    [caName('width')]
    [caDefaultValueInt64(0)]
    fWidth: Int64;
    [caName('height')]
    [caDefaultValueInt64(0)]
    fHeight: Int64;
    [caName('supports_streaming')]
    [caDefaultValueBoolean(False)]
    fSupportsStreaming: Boolean;
    [caDefaultValueBoolean(False)]
    [caName('protect_content')]
    FProtectContent: Boolean;
  public
    constructor Create; override;
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>Duration of sent video in seconds</summary>
    property Duration: Int64 read fDuration write fDuration;
    /// <summary>Video width</summary>
    property Width: Int64 read fWidth write fWidth;
    /// <summary>Video height</summary>
    property Height: Int64 read fHeight write fHeight;
    /// <summary>Thumbnail of the file sent; can be ignored if thumbnail generation for
    /// the file is supported server-side. The thumbnail should be in JPEG format and
    /// less than 200 kB in size. A thumbnail‘s width and height should not exceed 320.
    /// Ignored if the file is not uploaded using multipart/form-data. Thumbnails can’t
    /// be reused and can be only uploaded as a new file, so you can pass “attach:
    /// file_attach_name” if the thumbnail was uploaded using multipart/form-data
    /// under file_attach_name. More info on Sending Files »</summary>
    property Thumb;
    /// <summary>Document caption (may also be used when resending documents by file_id)
    /// , 0-1024 characters after entities parsing</summary>
    property Caption;
    /// <summary>Send Markdown or HTML, if you want Telegram apps to show bold, italic,
    /// fixed-width text or inline URLs in the media caption.</summary>
    property ParseMode;
    /// <summary> List of special entities that appear in the new caption, which can be
    /// specified instead of parse_mode
    /// </summary>
    property CaptionEntities;
    /// <summary>Pass True, if the uploaded video is suitable for streaming</summary>
    property SupportsStreaming: Boolean read fSupportsStreaming write fSupportsStreaming;
    /// <summary>Sends the message silently. Users will receive a notification with no
    /// sound.</summary>
    property DisableNotification;
    /// <summary>If the message is a reply, ID of the original message</summary>
    property ReplyToMessageId;
    /// <summary>
    /// Pass True, if the message should be sent even if the specified replied-to
    /// message is not found
    /// </summary>
    property AllowSendingWithoutReply;
    /// <summary>
    /// Protects the contents of the sent message from forwarding and saving
    /// </summary>
    property ProtectContent: Boolean read FProtectContent write FProtectContent;
  end;

implementation

{ TtgSendMessageBaseWithParseMode }

constructor TtgSendMessageBaseWithParseMode.Create;
begin
  inherited Create;
  FParseMode := TtgParseMode.Default;
end;

{ TtgSendMessageBase }

constructor TtgSendMessageBase.Create;
begin
  FReplyToMessageId := 0;
  FAllowSendingWithoutReply := False;
end;

{ TtgSendMediaAbstractArgument }

constructor TtgSendMediaAbstractArgument.Create;
begin
  inherited Create;
  FCaption := '';
  FCaptionEntities := nil;
end;

{ TtgSendMediaWithThumbAbstractArgument }

constructor TtgSendMediaWithThumbAbstractArgument.Create;
begin
  inherited Create();
  fThumb := TcaFileToSend.Empty;
end;

{ TtgSendVideoOrAnimationArgument }

constructor TtgSendVideoOrAnimationArgument.Create;
begin
  inherited Create;
  Duration := 0;
  Width := 0;
  Height := 0;
  Caption := '';
  fSupportsStreaming := False;
end;

end.
