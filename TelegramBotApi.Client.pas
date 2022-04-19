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

unit TelegramBotApi.Client;

interface

uses
  CloudApi.Client.Sync,
  CloudApi.IAuthenticator,
  CloudApi.Request,
  System.Classes,
  TelegramBotApi.Request.Stickers,
  TelegramBotApi.Types,
  TelegramBotApi.Types.AvailableMethods,
  TelegramBotApi.Types.Games,
  TelegramBotApi.Types.Payments,
  TelegramBotApi.Types.Request,
  TelegramBotApi.Types.UpdatingMessages,
  TelegramBotApi.Types.WebApps;

type
  TTelegramBotApi = class(TPersistent)
  public const
    LIB_VERSION = '5.7.0';
  private
    FCloudApi: TCloudApiClient;
    FBotToken: string;
    FAutoFreeRequestArgument: Boolean;
    function GetBotToken: string;
    procedure SetBotToken(const Value: string);
  protected
    function TryInternalExecute<TArgument, TResult>(AArgument: TArgument; var AResp: ItgResponse<TResult>)
      : Boolean; overload;
    function TryInternalExecute<TResult>(ARequest: IcaRequest; var AResp: ItgResponse<TResult>): Boolean; overload;
    function TryInternalExecuteCustom<TResult>(ARequest: IcaRequest; var AResult: TResult): Boolean; overload;
    function InternalExecuteCustom<TArgument: record; TResult>(AArgument: TArgument): TResult; overload;
  public
{$REGION 'Getting updates'}
    function GetUpdates(AGetUpdatesArgument: TtgGetUpdatesArgument): ItgResponse<TArray<TtgUpdate>>; overload;
    class function GetUpdates(const AJson: string): ItgResponse<TArray<TtgUpdate>>; overload;
    function SetWebhook(SetWebhookArgument: TtgSetWebhookArgument): Boolean;
    function DeleteWebhook(ADeleteWebhook: TtgDeleteWebhookArgument): Boolean;
    function GetWebhookInfo(): ItgResponse<TtgWebhookInfo>; overload;
{$ENDREGION}
{$REGION 'Games'}
    /// <summary>
    /// Use this method to send a game. On success, the sent Message is returned.
    /// </summary>
    function SendGame(ASendGameArgument: TtgSendGameArgument): ItgResponse<TtgMessage>;
{$ENDREGION}
{$REGION 'Available methods'}
    /// <summary>
    /// A simple method for testing your bot's auth token. Requires no parameters.
    /// Returns basic information about the bot in form of a User object.
    /// </summary>
    function GetMe: ItgResponse<TtgUser>;
    /// <summary>
    /// Use this method to log out from the cloud Bot API server before launching the
    /// bot locally. You must log out the bot before running it locally, otherwise
    /// there is no guarantee that the bot will receive updates. After a successful
    /// call, you can immediately log in on a local server, but will not be able to log
    /// in back to the cloud Bot API server for 10 minutes. Returns True on success.
    /// Requires no parameters.
    /// </summary>
    function LogOut: ItgResponse<Boolean>;
    /// <summary>
    /// Use this method to close the bot instance before moving it from one local
    /// server to another. You need to delete the webhook before calling this method to
    /// ensure that the bot isn't launched again after server restart. The method will
    /// return error 429 in the first 10 minutes after the bot is launched. Returns
    /// True on success. Requires no parameters.
    /// </summary>
    function Close: ItgResponse<Boolean>;
    /// <summary>
    /// Use this method to send text messages. On success, the sent Message is returned.
    /// </summary>
    function SendMessage(ASendMessageArgument: TtgSendMessageArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to forward messages of any kind. On success, the sent Message
    /// is returned.
    /// </summary>
    function ForwardMessage(AForwardMessageArgument: TtgForwardMessageArgument): ItgResponse<TtgMessage>;
    /// <summary> Use this method to copy messages of any kind. The method is analogous
    /// to the method forwardMessages, but the copied message doesn't have a link to
    /// the original message. Returns the MessageId of the sent message on success.
    /// </summary>
    function CopyMessage(ACopyMessageArgument: TtgCopyMessageArgument): ItgResponse<TtgMessageId>;
    /// <summary>
    /// Use this method to send photos. On success, the sent Message is returned.
    /// </summary>
    function SendPhoto(ASendPhotoArgument: TtgSendPhotoArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send audio files, if you want Telegram clients to display
    /// them in the music player. Your audio must be in the .MP3 or .M4A format. On
    /// success, the sent Message is returned. Bots can currently send audio files of
    /// up to 50 MB in size, this limit may be changed in the future.
    ///
    /// For sending voice messages, use the sendVoice method instead.
    /// </summary>
    function SendAudio(ASendAudioArgument: TtgSendAudioArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send general files. On success, the sent Message is returned.
    /// Bots can currently send files of any type of up to 50 MB in size, this limit
    /// may be changed in the future.
    /// </summary>
    function SendDocument(ASendDocumentArgument: TtgSendDocumentArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send video files, Telegram clients support mp4 videos (other
    /// formats may be sent as Document). On success, the sent Message is returned.
    /// Bots can currently send video files of up to 50 MB in size, this limit may be
    /// changed in the future.
    /// </summary>
    function SendVideo(ASendVideoArgument: TtgSendVideoArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send animation files (GIF or H.264/MPEG-4 AVC video without
    /// sound). On success, the sent Message is returned. Bots can currently send
    /// animation files of up to 50 MB in size, this limit may be changed in the future.
    /// </summary>
    function SendAnimation(ASendAnimationArgument: TtgSendAnimationArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send audio files, if you want Telegram clients to display
    /// the file as a playable voice message. For this to work, your audio must be in
    /// an .OGG file encoded with OPUS (other formats may be sent as Audio or Document).
    /// On success, the sent Message is returned. Bots can currently send voice
    /// messages of up to 50 MB in size, this limit may be changed in the future.
    /// </summary>
    function SendVoice(ASendVoiceArgument: TtgSendVoiceArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// As of v.4.0, Telegram clients support rounded square mp4 videos of up to 1
    /// minute long. Use this method to send video messages. On success, the sent
    /// Message is returned.
    /// </summary>
    function SendVideoNote(ASendVideoNoteArgument: TtgSendVideoNoteArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send a group of photos or videos as an album. On success, an
    /// array of the sent Messages is returned.
    /// </summary>
    function SendMediaGroup(ASendMediaGroupArgument: TtgSendMediaGroupArgument): ItgResponse<TArray<TtgMessage>>;
    /// <summary>
    /// Use this method to send point on the map. On success, the sent Message is
    /// returned.
    /// </summary>
    /// <returns> :ItgResponse<TtgMessage>
    /// </returns>
    function SendLocation(ASendLocationArgument: TtgSendLocationArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to edit live location messages. A location can be edited until
    /// its live_period expires or editing is explicitly disabled by a call to
    /// stopMessageLiveLocation. On success, if the edited message was sent by the bot,
    /// the edited Message is returned, otherwise True is returned.
    /// </summary>
    function EditMessageLiveLocation(AEditMessageLiveLocationArgument
      : TtgEditMessageLiveLocationHaveInlineMessageIDArgument): ItgResponse<TtgMessage>; overload;
    /// <summary>
    /// Use this method to edit live location messages. A location can be edited until
    /// its live_period expires or editing is explicitly disabled by a call to
    /// stopMessageLiveLocation. On success, if the edited message was sent by the bot,
    /// the edited Message is returned, otherwise True is returned.
    /// </summary>
    function EditMessageLiveLocation(AEditMessageLiveLocationArgument: TtgEditMessageLiveLocationArgument)
      : ItgResponse<TtgMessage>; overload;
    /// <summary> Use this method to stop updating a live location message before
    /// live_period expires. On success, if the message was sent by the bot, the sent
    /// Message is returned, otherwise True is returned.</summary>
    function StopMessageLiveLocation(AEditMessageLiveLocationArgument
      : TtgStopMessageLiveLocationHaveInlineMessageIDArgument): ItgResponse<TtgMessage>; overload;
    /// <summary> Use this method to stop updating a live location message before
    /// live_period expires. On success, if the message was sent by the bot, the sent
    /// Message is returned, otherwise True is returned.</summary>
    function StopMessageLiveLocation(AEditMessageLiveLocationArgument: TtgStopMessageLiveLocationArgument)
      : ItgResponse<TtgMessage>; overload;
    /// <summary>
    /// Use this method to send information about a venue. On success, the sent Message
    /// is returned.
    /// </summary>
    function SendVenue(ASendVenueArgument: TtgSendVenueArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send phone contacts. On success, the sent Message is
    /// returned.
    /// </summary>
    function SendContact(ASendContactArgument: TtgSendContactArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send a native poll. On success, the sent Message is returned.
    /// </summary>
    function SendPool(ASendPollArgument: TtgSendPollArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send an animated emoji that will display a random value. On
    /// success, the sent Message is returned.
    /// </summary>
    function SendDice(ASendDice: TtgSendDiceArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method when you need to tell the user that something is happening on
    /// the bot's side. The status is set for 5 seconds or less (when a message arrives
    /// from your bot, Telegram clients clear its typing status). Returns True on
    /// success.
    /// </summary>
    /// <remarks>
    /// We only recommend using this method when a response from the bot will take a
    /// noticeable amount of time to arrive.
    /// </remarks>
    function SendChatAction(AChatAction: TtgSendChatActionArgument): ItgResponse<Boolean>;
{$ENDREGION}
    /// <summary> Use this method to generate a new invite link for a chat; any
    /// previously generated link is revoked. The bot must be an administrator in the
    /// chat for this to work and must have the appropriate admin rights.
    /// </summary>
    /// <returns>  Returns the new invite link as String on success.
    /// </returns>
    function ExportChatInviteLink(AChatID: TtgExportChatInviteLinkArgument): ItgResponse<string>;
    function getChat(AGetChatArgument: TtgGetChatArgument): ItgResponse<TtgChat>;
    /// <summary>
    /// Use this method to kick a user from a group, a supergroup or a channel. In the
    /// case of supergroups and channels, the user will not be able to return to the
    /// chat on their own using invite links, etc., unless unbanned first. The bot must
    /// be an administrator in the chat for this to work and must have the appropriate
    /// admin rights. Returns True on success.
    /// </summary>
    function BanChatMember(ABanChatMember: TtgBanChatMember): ItgResponse<Boolean>;
    function UnbanChatMember(AUnbanChatMember: TtgUnbanChatMemberArgument): ItgResponse<Boolean>;
    /// <summary>
    /// Use this method to remove a message from the list of pinned messages in a chat.
    /// If the chat is not a private chat, the bot must be an administrator in the chat
    /// for this to work and must have the 'can_pin_messages' admin right in a
    /// supergroup or 'can_edit_messages' admin right in a channel. Returns True on
    /// success.
    /// </summary>
    function UnpinChatMessage(AUnpinChatMessage: TtgUnpinChatMessageArgument): ItgResponse<Boolean>;
    /// <summary>
    /// Use this method to clear the list of pinned messages in a chat. If the chat is
    /// not a private chat, the bot must be an administrator in the chat for this to
    /// work and must have the 'can_pin_messages' admin right in a supergroup or
    /// 'can_edit_messages' admin right in a channel. Returns True on success.
    /// </summary>
    function UnpinAllChatMessages(AUnpinAllChatMessages: TtgUnpinAllChatMessagesArgument): ItgResponse<Boolean>;
    /// <summary>
    /// Use this method to get basic info about a file and prepare it for downloading.
    /// For the moment, bots can download files of up to 20MB in size. On success, a
    /// File object is returned. The file can then be downloaded via the link https:
    /// //api.telegram.org/file/bot<token>/<file_path>, where <file_path> is taken from
    /// the response. It is guaranteed that the link will be valid for at least 1 hour.
    /// When the link expires, a new one can be requested by calling getFile again.
    /// </summary>
    function GetFile(AGetFile: TtgGetFileArgument): ItgResponse<TtgFile>;
    /// <summary>
    /// Use this method to create an additional invite link for a chat. The bot must be
    /// an administrator in the chat for this to work and must have the appropriate
    /// admin rights. The link can be revoked using the method revokeChatInviteLink.
    /// Returns the new invite link as ChatInviteLink object.
    /// </summary>
    function CreateChatInviteLink(ACreateChatInviteLink: TtgCreateChatInviteLinkArgument)
      : ItgResponse<TtgChatInviteLink>;
    /// <summary>
    /// Use this method to edit a non-primary invite link created by the bot. The bot
    /// must be an administrator in the chat for this to work and must have the
    /// appropriate admin rights. Returns the edited invite link as a ChatInviteLink
    /// object.
    /// </summary>
    function EditChatInviteLink(AEditChatInviteLink: TtgEditChatInviteLinkArgument): ItgResponse<TtgChatInviteLink>;
    /// <summary>
    /// Use this method to revoke an invite link created by the bot. If the primary
    /// link is revoked, a new link is automatically generated. The bot must be an
    /// administrator in the chat for this to work and must have the appropriate admin
    /// rights. Returns the revoked invite link as ChatInviteLink object.
    /// </summary>
    function RevokeChatInviteLink(ARevokeChatInviteLink: TtgRevokeChatInviteLinkArgument)
      : ItgResponse<TtgChatInviteLink>;
    /// <summary>
    /// Use this method to promote or demote a user in a supergroup or a channel. The
    /// bot must be an administrator in the chat for this to work and must have the
    /// appropriate admin rights. Pass False for all boolean parameters to demote a
    /// user. Returns True on success.
    /// </summary>
    function PromoteChatMember(PromoteChatMember: TtgPromoteChatMemberArgument): ItgResponse<Boolean>;
{$REGION 'Payments'}
    /// <summary>
    /// Use this method to send invoices. On success, the sent Message is returned.
    /// </summary>
    function SendInvoice(ASendInvoiceArgument: TtgSendInvoiceArgument): ItgResponse<TtgMessage>;
    /// <summary> If you sent an invoice requesting a shipping address and the
    /// parameter is_flexible was specified, the Bot API will send an Update with a
    /// shipping_query field to the bot. Use this method to reply to shipping queries.
    /// On success, True is returned.
    /// </summary>
    function AnswerShippingQuery(AAnswerShippingQuery: TtgAnswerShippingQuery): ItgResponse<Boolean>;
{$ENDREGION}
{$REGION 'Updating messages'}
    /// <summary>
    /// Use this method to edit text and game messages. On success, if the edited
    /// message is not an inline message, the edited Message is returned, otherwise
    /// True is returned.
    /// </summary>
    function EditMessageText(AEditMessageArgument: TtgEditMessageTextArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to delete a message, including service messages, with the
    /// following limitations:
    /// - A message can only be deleted if it was sent less than 48 hours ago.
    /// - A dice message in a private chat can only be deleted if it was sent more than
    /// 24 hours ago.
    /// - Bots can delete outgoing messages in private chats, groups, and supergroups.
    /// - Bots can delete incoming messages in private chats.
    /// - Bots granted can_post_messages permissions can delete outgoing messages in
    /// channels.
    /// - If the bot is an administrator of a group, it can delete any message there.
    /// - If the bot has can_delete_messages permission in a supergroup or a channel,
    /// it can delete any message there.
    /// Returns True on success.
    /// </summary>
    function DeleteMessage(ADeleteMessageeArgument: TtgDeleteMessageArgument): ItgResponse<Boolean>;
{$ENDREGION}
    /// <summary>
    /// Use this method to get the current list of the bot's commands for the given
    /// scope and user language. Returns Array of BotCommand on success. If commands
    /// aren't set, an empty list is returned.
    /// </summary>
    function GetMyCommands(AGetMyCommands: TtgGetMyCommandsArgument): ItgResponse<TArray<TtgBotCommand>>;
    /// <summary>
    /// Use this method to change the list of the bot's commands. See https://core.
    /// telegram.org/bots#commands for more details about bot commands. Returns True on
    /// success.
    /// </summary>
    function SetMyCommands(ASetMyCommands: TtgSetMyCommandsArgument): ItgResponse<Boolean>;
    /// <summary>
    /// Use this method to get the number of members in a chat. Returns Int on success.
    /// </summary>
    function GetChatMemberCount(AGetChatMemberCount: TtgGetChatMemberCountArgument): ItgResponse<Integer>;
    /// <summary>
    /// Use this method to send answers to callback queries sent from inline keyboards.
    /// The answer will be displayed to the user as a notification at the top of the
    /// chat screen or as an alert. On success, True is returned.
    /// </summary>
    /// <remarks>
    /// Alternatively, the user can be redirected to the specified Game URL. For this
    /// option to work, you must first create a game for your bot via @Botfather and
    /// accept the terms. Otherwise, you may use links like t.me/your_bot?start=XXXX
    /// that open your bot with a parameter.
    /// </remarks>
    function AnswerCallbackQuery(AAnswerCallbackQuery: TtgAnswerCallbackQueryArgument): ItgResponse<Boolean>;
    /// <summary>
    /// Use this method to send static .WEBP or animated .TGS stickers. On success, the sent Message is returned.
    /// </summary>
    function SendSticker(ASticker: TtgSendStickerArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to create a new sticker set owned by a user. The bot will be
    /// able to edit the sticker set thus created. You must use exactly one of the
    /// fields png_sticker, tgs_sticker, or webm_sticker. Returns True on success.
    /// </summary>
    function CreateNewStickerSet(AStickerSet: TtgCreateNewStickerSet): ItgResponse<Boolean>;
    /// <summary> Use this method to add a new sticker to a set created by the bot. You
    /// must use exactly one of the fields png_sticker, tgs_sticker, or webm_sticker.
    /// Animated stickers can be added to animated sticker sets and only to them.
    /// Animated sticker sets can have up to 50 stickers. Static sticker sets can have
    /// up to 120 stickers. Returns True on success.</summary>
    function AddStickerToSet(ASticker: TtgAddStickerToSet): ItgResponse<Boolean>;

    /// <summary>
    /// Use this method to change the default administrator rights requested by the bot
    /// when it's added as an administrator to groups or channels. These rights will be
    /// suggested to users, but they are are free to modify the list before adding the
    /// bot. Returns True on success.
    /// </summary>
    function SetMyDefaultAdministratorRights(ASetMyDefaultAdministratorRightsArgument
      : TtgSetMyDefaultAdministratorRightsArgument): ItgResponse<Boolean>;
    /// <summary>
    /// Use this method to get the current default administrator rights of the bot.
    /// Returns ChatAdministratorRights on success.
    /// </summary>
    function GetMyDefaultAdministratorRights(AGetMyDefaultAdministratorRightsArgument
      : TtgGetMyDefaultAdministratorRightsArgument): ItgResponse<TtgChatAdministratorRights>;
    /// <summary>
    /// Use this method to change the bot's menu button in a private chat, or the
    /// default menu button. Returns True on success.
    /// </summary>
    function SetChatMenuButton(ASetChatMenuButtonArgument: TtgSetChatMenuButtonArgument): ItgResponse<Boolean>;
    /// <summary>
    /// Use this method to get the current value of the bot's menu button in a private
    /// chat, or the default menu button. Returns MenuButton on success.
    /// </summary>
    function GetChatMenuButton(AGetChatMenuButtonArgument: TtgGetChatMenuButtonArgument): ItgResponse<TtgMenuButton>;
    /// <summary>
    /// Use this method to set the result of an interaction with a Web App and send a
    /// corresponding message on behalf of the user to the chat from which the query
    /// originated. On success, a SentWebAppMessage object is returned.
    /// </summary>
    function AnswerWebAppQuery(AAnswerWebAppQueryArgument: TTgAnswerWebAppQueryArgument)
      : ItgResponse<TtgSentWebAppMessage>;
    constructor Create; overload;
    constructor Create(const AToken: string); overload;
    destructor Destroy; override;
    procedure Assign(Source: TPersistent); override;
    property BotToken: string read GetBotToken write SetBotToken;
    property CloudApi: TCloudApiClient read FCloudApi write FCloudApi;
    property AutoFreeRequestArgument: Boolean read FAutoFreeRequestArgument write FAutoFreeRequestArgument;
  end;

implementation

uses
  CloudApi.Response,
  CloudApi.RequestArgument,
  CloudApi.Types,
  System.Net.HttpClient,
  TelegramBotApi.CloudApi.Authenticator,
  TelegramBotApi.CloudApi.Converter;

constructor TTelegramBotApi.Create;
begin
  inherited Create;
  FCloudApi := TCloudApiClient.Create;
  FCloudApi.Authenticator := TTelegramAuthenticator.Create(BotToken);
  FCloudApi.HttpClient.SecureProtocols := [THTTPSecureProtocol.TLS12];
  TtgConverters.TelegramConverter;
  FCloudApi.BaseUrl := 'https://api.telegram.org/bot{token}';
  FCloudApi.HttpClient.UserAgent := 'TelegaPi v.' + TTelegramBotApi.LIB_VERSION + ', ' + FCloudApi.HttpClient.UserAgent;
  FAutoFreeRequestArgument := False;
end;

constructor TTelegramBotApi.Create(const AToken: string);
begin
  Self.Create;
  BotToken := AToken;
end;

function TTelegramBotApi.CreateChatInviteLink(ACreateChatInviteLink: TtgCreateChatInviteLinkArgument)
  : ItgResponse<TtgChatInviteLink>;
begin
  TryInternalExecute<TtgCreateChatInviteLinkArgument, TtgChatInviteLink>(ACreateChatInviteLink, Result);
end;

function TTelegramBotApi.CreateNewStickerSet(AStickerSet: TtgCreateNewStickerSet): ItgResponse<Boolean>;
begin
  TryInternalExecute<TtgCreateNewStickerSet, Boolean>(AStickerSet, Result);
end;

function TTelegramBotApi.DeleteMessage(ADeleteMessageeArgument: TtgDeleteMessageArgument): ItgResponse<Boolean>;
begin
  TryInternalExecute<TtgDeleteMessageArgument, Boolean>(ADeleteMessageeArgument, Result);
end;

function TTelegramBotApi.DeleteWebhook(ADeleteWebhook: TtgDeleteWebhookArgument): Boolean;
begin
  Result := InternalExecuteCustom<TtgDeleteWebhookArgument, Boolean>(ADeleteWebhook);
end;

destructor TTelegramBotApi.Destroy;
begin
  FCloudApi.Free;
  inherited Destroy;
end;

function TTelegramBotApi.AddStickerToSet(ASticker: TtgAddStickerToSet): ItgResponse<Boolean>;
begin
  TryInternalExecute<TtgAddStickerToSet, Boolean>(ASticker, Result);
end;

function TTelegramBotApi.AnswerCallbackQuery(AAnswerCallbackQuery: TtgAnswerCallbackQueryArgument)
  : ItgResponse<Boolean>;
begin
  TryInternalExecute<TtgAnswerCallbackQueryArgument, Boolean>(AAnswerCallbackQuery, Result);
end;

function TTelegramBotApi.AnswerShippingQuery(AAnswerShippingQuery: TtgAnswerShippingQuery): ItgResponse<Boolean>;
begin
  TryInternalExecute<TtgAnswerShippingQuery, Boolean>(AAnswerShippingQuery, Result);
end;

function TTelegramBotApi.AnswerWebAppQuery(AAnswerWebAppQueryArgument: TTgAnswerWebAppQueryArgument)
  : ItgResponse<TtgSentWebAppMessage>;
begin
  TryInternalExecute<TTgAnswerWebAppQueryArgument, TtgSentWebAppMessage>(AAnswerWebAppQueryArgument, Result);
end;

function TTelegramBotApi.Close: ItgResponse<Boolean>;
var
  lClose: TtgCloseArgunent;
begin
  lClose := TtgCloseArgunent.Create;
  try
    TryInternalExecute<TtgCloseArgunent, Boolean>(lClose, Result);
  finally
    lClose.Free;
  end;
end;

function TTelegramBotApi.CopyMessage(ACopyMessageArgument: TtgCopyMessageArgument): ItgResponse<TtgMessageId>;
begin
  TryInternalExecute<TtgCopyMessageArgument, TtgMessageId>(ACopyMessageArgument, Result);
end;

function TTelegramBotApi.EditChatInviteLink(AEditChatInviteLink: TtgEditChatInviteLinkArgument)
  : ItgResponse<TtgChatInviteLink>;
begin
  TryInternalExecute<TtgEditChatInviteLinkArgument, TtgChatInviteLink>(AEditChatInviteLink, Result);
end;

function TTelegramBotApi.EditMessageLiveLocation(AEditMessageLiveLocationArgument: TtgEditMessageLiveLocationArgument)
  : ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgEditMessageLiveLocationArgument, TtgMessage>(AEditMessageLiveLocationArgument, Result);
end;

function TTelegramBotApi.EditMessageLiveLocation(AEditMessageLiveLocationArgument
  : TtgEditMessageLiveLocationHaveInlineMessageIDArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgEditMessageLiveLocationHaveInlineMessageIDArgument, TtgMessage>
    (AEditMessageLiveLocationArgument, Result);
end;

function TTelegramBotApi.ExportChatInviteLink(AChatID: TtgExportChatInviteLinkArgument): ItgResponse<string>;
begin
  TryInternalExecute<TtgExportChatInviteLinkArgument, string>(AChatID, Result);
end;

function TTelegramBotApi.ForwardMessage(AForwardMessageArgument: TtgForwardMessageArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgForwardMessageArgument, TtgMessage>(AForwardMessageArgument, Result);
end;

function TTelegramBotApi.GetBotToken: string;
begin
  Result := FBotToken;
end;

function TTelegramBotApi.getChat(AGetChatArgument: TtgGetChatArgument): ItgResponse<TtgChat>;
begin
  TryInternalExecute<TtgGetChatArgument, TtgChat>(AGetChatArgument, Result);
end;

function TTelegramBotApi.GetChatMemberCount(AGetChatMemberCount: TtgGetChatMemberCountArgument): ItgResponse<Integer>;
var
  lGetChatMemberCount: TtgGetChatMemberCountArgument;
begin
  lGetChatMemberCount := TtgGetChatMemberCountArgument.Create;
  try
    TryInternalExecute<TtgGetChatMemberCountArgument, Integer>(lGetChatMemberCount, Result);
  finally
    lGetChatMemberCount.Free;
  end;
end;

function TTelegramBotApi.GetChatMenuButton(AGetChatMenuButtonArgument: TtgGetChatMenuButtonArgument)
  : ItgResponse<TtgMenuButton>;
begin
  TryInternalExecute<TtgGetChatMenuButtonArgument, TtgMenuButton>(AGetChatMenuButtonArgument, Result);
end;

function TTelegramBotApi.GetFile(AGetFile: TtgGetFileArgument): ItgResponse<TtgFile>;
begin
  TryInternalExecute<TtgGetFileArgument, TtgFile>(AGetFile, Result);
end;

function TTelegramBotApi.GetMe: ItgResponse<TtgUser>;
var
  lGetMe: TtgGetMeArgunent;
begin
  lGetMe := TtgGetMeArgunent.Create;
  try
    TryInternalExecute<TtgGetMeArgunent, TtgUser>(lGetMe, Result);
  finally
    lGetMe.Free;
  end;
end;

function TTelegramBotApi.GetMyCommands(AGetMyCommands: TtgGetMyCommandsArgument): ItgResponse<TArray<TtgBotCommand>>;
begin
  TryInternalExecute < TtgGetMyCommandsArgument, TArray < TtgBotCommand >> (AGetMyCommands, Result);
end;

function TTelegramBotApi.GetUpdates(AGetUpdatesArgument: TtgGetUpdatesArgument): ItgResponse<TArray<TtgUpdate>>;
begin
  TryInternalExecute < TtgGetUpdatesArgument, TArray < TtgUpdate >> (AGetUpdatesArgument, Result);
end;

class function TTelegramBotApi.GetUpdates(const AJson: string): ItgResponse<TArray<TtgUpdate>>;
var
  lCA: TCloudApiClient;
begin
  lCA := TCloudApiClient.Create;
  try
    Result := lCA.Serializer.Deserialize < TtgResponse < TArray<TtgUpdate> >> (AJson);
  finally
    lCA.Free;
  end;
end;

function TTelegramBotApi.GetWebhookInfo: ItgResponse<TtgWebhookInfo>;
begin
  TryInternalExecute<TtgGetWebhookInfoArgument, TtgWebhookInfo>(TtgGetWebhookInfoArgument.Default, Result);
end;

function TTelegramBotApi.TryInternalExecute<TArgument, TResult>(AArgument: TArgument;
  var AResp: ItgResponse<TResult>): Boolean;
var
  LReq: IcaRequest;
begin
  LReq := TcaRequestArgument.Current.ObjToRequest<TArgument>(AArgument);
  Result := TryInternalExecute<TResult>(LReq, AResp);
end;

function TTelegramBotApi.TryInternalExecute<TResult>(ARequest: IcaRequest; var AResp: ItgResponse<TResult>): Boolean;
var
  LCloudResponse: IcaResponse<TtgResponse<TResult>>;
begin
  if FCloudApi.TryExecute < TtgResponse < TResult >> (ARequest, LCloudResponse) then
  begin
    AResp := LCloudResponse.Data;
    if Assigned(AResp) then
      AResp.CloudResponse := LCloudResponse;
  end;
end;

function TTelegramBotApi.InternalExecuteCustom<TArgument, TResult>(AArgument: TArgument): TResult;
var
  LReq: IcaRequest;
begin
  LReq := TcaRequestArgument.Current.ObjToRequest<TArgument>(AArgument);
  TryInternalExecuteCustom<TResult>(LReq, Result);
end;

function TTelegramBotApi.TryInternalExecuteCustom<TResult>(ARequest: IcaRequest; var AResult: TResult): Boolean;
var
  LCloudResponse: IcaResponse<TResult>;
begin
  Result := False;
  if FCloudApi.TryExecute<TResult>(ARequest, LCloudResponse) then
  begin
    AResult := LCloudResponse.Data;
    Result := True;
  end;
end;

procedure TTelegramBotApi.Assign(Source: TPersistent);
begin
  if Source is TTelegramBotApi then
  begin
    FCloudApi.Assign((Source as TTelegramBotApi).CloudApi);
    BotToken := (Source as TTelegramBotApi).BotToken;
  end
  else
    inherited Assign(Source);
end;

function TTelegramBotApi.BanChatMember(ABanChatMember: TtgBanChatMember): ItgResponse<Boolean>;
begin
  TryInternalExecute<TtgBanChatMember, Boolean>(ABanChatMember, Result);
end;

function TTelegramBotApi.EditMessageText(AEditMessageArgument: TtgEditMessageTextArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgEditMessageTextArgument, TtgMessage>(AEditMessageArgument, Result);
end;

function TTelegramBotApi.GetMyDefaultAdministratorRights(AGetMyDefaultAdministratorRightsArgument
  : TtgGetMyDefaultAdministratorRightsArgument): ItgResponse<TtgChatAdministratorRights>;
begin
  TryInternalExecute<TtgGetMyDefaultAdministratorRightsArgument, TtgChatAdministratorRights>
    (AGetMyDefaultAdministratorRightsArgument, Result);
end;

function TTelegramBotApi.LogOut: ItgResponse<Boolean>;
var
  lLogOut: TtgLogOutArgunent;
begin
  lLogOut := TtgLogOutArgunent.Create;
  try
    TryInternalExecute<TtgLogOutArgunent, Boolean>(lLogOut, Result);
  finally
    lLogOut.Free;
  end;
end;

function TTelegramBotApi.PromoteChatMember(PromoteChatMember: TtgPromoteChatMemberArgument): ItgResponse<Boolean>;
begin
  TryInternalExecute<TtgPromoteChatMemberArgument, Boolean>(PromoteChatMember, Result);
end;

function TTelegramBotApi.RevokeChatInviteLink(ARevokeChatInviteLink: TtgRevokeChatInviteLinkArgument)
  : ItgResponse<TtgChatInviteLink>;
begin
  TryInternalExecute<TtgRevokeChatInviteLinkArgument, TtgChatInviteLink>(ARevokeChatInviteLink, Result);
end;

function TTelegramBotApi.SendAnimation(ASendAnimationArgument: TtgSendAnimationArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgSendAnimationArgument, TtgMessage>(ASendAnimationArgument, Result);
end;

function TTelegramBotApi.SendAudio(ASendAudioArgument: TtgSendAudioArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgSendAudioArgument, TtgMessage>(ASendAudioArgument, Result);
end;

function TTelegramBotApi.SendChatAction(AChatAction: TtgSendChatActionArgument): ItgResponse<Boolean>;
begin
  TryInternalExecute<TtgSendChatActionArgument, Boolean>(AChatAction, Result);
end;

function TTelegramBotApi.SendContact(ASendContactArgument: TtgSendContactArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgSendContactArgument, TtgMessage>(ASendContactArgument, Result);
end;

function TTelegramBotApi.SendDice(ASendDice: TtgSendDiceArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgSendDiceArgument, TtgMessage>(ASendDice, Result);
end;

function TTelegramBotApi.SendDocument(ASendDocumentArgument: TtgSendDocumentArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgSendDocumentArgument, TtgMessage>(ASendDocumentArgument, Result);
end;

function TTelegramBotApi.SendGame(ASendGameArgument: TtgSendGameArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgSendGameArgument, TtgMessage>(ASendGameArgument, Result);
end;

function TTelegramBotApi.SendInvoice(ASendInvoiceArgument: TtgSendInvoiceArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgSendInvoiceArgument, TtgMessage>(ASendInvoiceArgument, Result);
end;

function TTelegramBotApi.SendLocation(ASendLocationArgument: TtgSendLocationArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgSendLocationArgument, TtgMessage>(ASendLocationArgument, Result);
end;

function TTelegramBotApi.SendMediaGroup(ASendMediaGroupArgument: TtgSendMediaGroupArgument)
  : ItgResponse<TArray<TtgMessage>>;
var
  LRequest: IcaRequest;
  LMedia: TtgInputMedia;
begin
  LRequest := TcaRequestArgument.Current.ObjToRequest<TtgSendMediaGroupArgument>(ASendMediaGroupArgument);
  for LMedia in ASendMediaGroupArgument.Media do
  begin
    case LMedia.GetFileToSend.&Type of
      TcaFileToSendType.File, TcaFileToSendType.Stream:
        LRequest.AddFile(LMedia.GetFileToSend);
    end;
  end;
  TryInternalExecute < TArray < TtgMessage >> (LRequest, Result);
end;

function TTelegramBotApi.SendMessage(ASendMessageArgument: TtgSendMessageArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgSendMessageArgument, TtgMessage>(ASendMessageArgument, Result);
end;

function TTelegramBotApi.SendPhoto(ASendPhotoArgument: TtgSendPhotoArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgSendPhotoArgument, TtgMessage>(ASendPhotoArgument, Result);
end;

function TTelegramBotApi.SendPool(ASendPollArgument: TtgSendPollArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgSendPollArgument, TtgMessage>(ASendPollArgument, Result);
end;

function TTelegramBotApi.SendSticker(ASticker: TtgSendStickerArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgSendStickerArgument, TtgMessage>(ASticker, Result);
end;

function TTelegramBotApi.SendVenue(ASendVenueArgument: TtgSendVenueArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgSendVenueArgument, TtgMessage>(ASendVenueArgument, Result);
end;

function TTelegramBotApi.SendVideo(ASendVideoArgument: TtgSendVideoArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgSendVideoArgument, TtgMessage>(ASendVideoArgument, Result);
end;

function TTelegramBotApi.SendVideoNote(ASendVideoNoteArgument: TtgSendVideoNoteArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgSendVideoNoteArgument, TtgMessage>(ASendVideoNoteArgument, Result);
end;

function TTelegramBotApi.SendVoice(ASendVoiceArgument: TtgSendVoiceArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgSendVoiceArgument, TtgMessage>(ASendVoiceArgument, Result);
end;

procedure TTelegramBotApi.SetBotToken(const Value: string);
begin
  if FBotToken <> Value then
  begin
    FBotToken := Value;
    TTelegramAuthenticator(FCloudApi.Authenticator).BotToken := Value;
  end;
end;

function TTelegramBotApi.SetChatMenuButton(ASetChatMenuButtonArgument: TtgSetChatMenuButtonArgument)
  : ItgResponse<Boolean>;
begin
  TryInternalExecute<TtgSetChatMenuButtonArgument, Boolean>(ASetChatMenuButtonArgument, Result);
end;

function TTelegramBotApi.SetMyCommands(ASetMyCommands: TtgSetMyCommandsArgument): ItgResponse<Boolean>;
begin
  TryInternalExecute<TtgSetMyCommandsArgument, Boolean>(ASetMyCommands, Result);
end;

function TTelegramBotApi.SetMyDefaultAdministratorRights(ASetMyDefaultAdministratorRightsArgument
  : TtgSetMyDefaultAdministratorRightsArgument): ItgResponse<Boolean>;
begin
  TryInternalExecute<TtgSetMyDefaultAdministratorRightsArgument, Boolean>
    (ASetMyDefaultAdministratorRightsArgument, Result);
end;

function TTelegramBotApi.SetWebhook(SetWebhookArgument: TtgSetWebhookArgument): Boolean;
begin
  Result := InternalExecuteCustom<TtgSetWebhookArgument, Boolean>(SetWebhookArgument);
end;

function TTelegramBotApi.StopMessageLiveLocation(AEditMessageLiveLocationArgument
  : TtgStopMessageLiveLocationHaveInlineMessageIDArgument): ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgStopMessageLiveLocationHaveInlineMessageIDArgument, TtgMessage>
    (AEditMessageLiveLocationArgument, Result);
end;

function TTelegramBotApi.StopMessageLiveLocation(AEditMessageLiveLocationArgument: TtgStopMessageLiveLocationArgument)
  : ItgResponse<TtgMessage>;
begin
  TryInternalExecute<TtgStopMessageLiveLocationArgument, TtgMessage>(AEditMessageLiveLocationArgument, Result);
end;

function TTelegramBotApi.UnbanChatMember(AUnbanChatMember: TtgUnbanChatMemberArgument): ItgResponse<Boolean>;
begin
  TryInternalExecute<TtgUnbanChatMemberArgument, Boolean>(AUnbanChatMember, Result);
end;

function TTelegramBotApi.UnpinAllChatMessages(AUnpinAllChatMessages: TtgUnpinAllChatMessagesArgument)
  : ItgResponse<Boolean>;
begin
  TryInternalExecute<TtgUnpinAllChatMessagesArgument, Boolean>(AUnpinAllChatMessages, Result);
end;

function TTelegramBotApi.UnpinChatMessage(AUnpinChatMessage: TtgUnpinChatMessageArgument): ItgResponse<Boolean>;
begin
  TryInternalExecute<TtgUnpinChatMessageArgument, Boolean>(AUnpinChatMessage, Result);
end;

end.
