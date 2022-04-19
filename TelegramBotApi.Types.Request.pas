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

unit TelegramBotApi.Types.Request;

interface

uses
  CloudAPI.Attributes,
  CloudAPI.Types,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Abstract,
  TelegramBotApi.Types.Enums,
  TelegramBotApi.Types.Keyboards;

type
  TtgEmptyArgument = class(TInterfacedObject);

  [caName('getMe')]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>
  /// A simple method for testing your bot's auth token.
  /// Requires no parameters.
  /// Returns basic information about the bot in form of a User object.
  /// </summary>
  TtgGetMeArgunent = class(TtgEmptyArgument);
  /// <summary>
  /// Use this method to log out from the cloud Bot API server before launching the
  /// bot locally. You must log out the bot before running it locally, otherwise
  /// there is no guarantee that the bot will receive updates. After a successful
  /// call, you can immediately log in on a local server, but will not be able to log
  /// in back to the cloud Bot API server for 10 minutes. Returns True on success.
  /// Requires no parameters.
  /// </summary>
  [caName('logOut')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgLogOutArgunent = class(TtgEmptyArgument);
  /// <summary>Use this method to close the bot instance before moving it from one
  /// local server to another. You need to delete the webhook before calling this
  /// method to ensure that the bot isn't launched again after server restart. The
  /// method will return error 429 in the first 10 minutes after the bot is launched.
  /// Returns True on success. Requires no parameters.</summary>
  [caName('close')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgCloseArgunent = class(TtgEmptyArgument);

  [caName('editMessageLiveLocation')]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>Use this method to edit live location messages. A location can be
  /// edited until its live_period expires or editing is explicitly disabled by a
  /// call to stopMessageLiveLocation. On success, if the edited message was sent by
  /// the bot, the edited Message is returned, otherwise True is returned.</summary>
  TtgEditMessageLiveLocationHaveInlineMessageIDArgument = record
  public
    [caName('inline_message_id')]
    [caIsRequaired]
    [caDefaultValueString('')]
    /// <summary>If the message is a reply, ID of the original message</summary>
    InlineMessageId: Int64;
    [caName('latitude')]
    [caIsRequaired]
    [caDefaultValueSingle(0.0)]
    /// <summary> Latitude of the location</summary>
    Latitude: Single;
    [caName('longitude')]
    [caIsRequaired]
    [caDefaultValueSingle(0.0)]
    /// <summary> Longitude of the location</summary>
    Longitude: Single;
    class function Default: TtgEditMessageLiveLocationHaveInlineMessageIDArgument; static;
  end;

  [caName('editMessageLiveLocation')]
  [caParameterType(TcaParameterType.QueryString)]
  /// <summary>Use this method to edit live location messages. A location can be
  /// edited until its live_period expires or editing is explicitly disabled by a
  /// call to stopMessageLiveLocation. On success, if the edited message was sent by
  /// the bot, the edited Message is returned, otherwise True is returned.</summary>
  TtgEditMessageLiveLocationArgument = record
  public
    /// <summary>Required if inline_message_id is not specified. Unique identifier for
    /// the target chat or username of the target channel (in the format
    /// @channelusername)</summary>
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    ChatId: TtgUserLink;
    /// <summary>Required if inline_message_id is not specified. Identifier of the
    /// message to edit</summary>
    [caName('message_id')]
    [caDefaultValueInt64(0)]
    MessageID: Int64;
    [caName('latitude')]
    [caIsRequaired]
    [caDefaultValueSingle(0.0)]
    /// <summary> Latitude of the location</summary>
    Latitude: Single;
    [caName('longitude')]
    [caIsRequaired]
    [caDefaultValueSingle(0.0)]
    /// <summary> Longitude of the location</summary>
    Longitude: Single;
    class function Default: TtgEditMessageLiveLocationArgument; static;
  end;

  /// <summary>Use this method to stop updating a live location message before
  /// live_period expires. On success, if the message was sent by the bot, the sent
  /// Message is returned, otherwise True is returned.</summary>
  [caName('stopMessageLiveLocation')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgStopMessageLiveLocationHaveInlineMessageIDArgument = record
  public
    [caName('inline_message_id')]
    [caIsRequaired]
    [caDefaultValueString('')]
    /// <summary>If the message is a reply, ID of the original message</summary>
    InlineMessageId: Int64;
    class function Default: TtgStopMessageLiveLocationHaveInlineMessageIDArgument; static;
  end;

  /// <summary>Use this method to stop updating a live location message before
  /// live_period expires. On success, if the message was sent by the bot, the sent
  /// Message is returned, otherwise True is returned.</summary>
  [caName('stopMessageLiveLocation')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgStopMessageLiveLocationArgument = record
  public
    /// <summary>Required if inline_message_id is not specified. Unique identifier for
    /// the target chat or username of the target channel (in the format
    /// @channelusername)</summary>
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    ChatId: TtgUserLink;
    /// <summary>Required if inline_message_id is not specified. Identifier of the
    /// message to edit</summary>
    [caName('message_id')]
    [caDefaultValueInt64(0)]
    MessageID: Int64;
    class function Default: TtgStopMessageLiveLocationArgument; static;
  end;

  [caName('getUpdates')]
  [caParameterType(TcaParameterType.GetOrPost)]
  [caMethod(TcaMethod.POST)]
  /// <summary>
  /// Use this method to send video files, Telegram clients support mp4 videos (other
  /// formats may be sent as Document). On success, the sent Message is returned.
  /// Bots can currently send video files of up to 50 MB in size, this limit may be
  /// changed in the future.
  /// </summary>
  TtgGetUpdatesArgument = record
  public
    [caName('offset')]
    [caDefaultValueInt64(0)]
    /// <summary>Identifier of the first update to be returned. Must be greater by one
    /// than the highest among the identifiers of previously received updates. By
    /// default, updates starting with the earliest unconfirmed update are returned. An
    /// update is considered confirmed as soon as getUpdates is called with an offset
    /// higher than its update_id. The negative offset can be specified to retrieve
    /// updates starting from -offset update from the end of the updates queue. All
    /// previous updates will forgotten.</summary>
    Offset: Int64;
    /// <summary>
    /// Limits the number of updates to be retrieved. Values between 1—100 are accepted.
    /// Defaults to 100.</summary>
    [caName('limit')]
    [caDefaultValueInt64(100)]
    Limit: Int64;
    [caName('timeout')]
    [caDefaultValueInt64(0)]
    /// <summary>
    /// Timeout in seconds for long polling. Defaults to 0, i.e. usual short polling.
    /// Should be positive, short polling should be used for testing purposes only.
    /// </summary>
    Timeout: Int64;
    [caName('allowed_updates')]
    [caDefaultValueString('')]
    /// <summary>A JSON-serialized list of the update types you want your bot to
    /// receive. For example, specify [“message”, “edited_channel_post”,
    /// “callback_query”] to only receive updates of these types. See Update for a
    /// complete list of available update types. Specify an empty list to receive all
    /// updates regardless of type (default). If not specified, the previous setting
    /// will be used.
    ///
    /// Please note that this parameter doesn't affect updates created before the call
    /// to the getUpdates, so unwanted updates may be received for a short period of
    /// time.</summary>
    AllowedUpdates: TAllowedUpdates;
    class function Default: TtgGetUpdatesArgument; static;
  end;

  /// <summary>Use this method to specify a url and receive incoming updates via an
  /// outgoing webhook. Whenever there is an update for the bot, we will send an
  /// HTTPS POST request to the specified url, containing a JSON-serialized Update.
  /// In case of an unsuccessful request, we will give up after a reasonable amount
  /// of attempts. Returns True on success.
  /// </summary>
  /// <remarks>
  /// If you'd like to make sure that the Webhook request comes from Telegram, we
  /// recommend using a secret path in the URL, e.g. https://www.example.com/<token>.
  /// Since nobody else knows your bot's token, you can be pretty sure it's us.
  /// </remarks>
  [caName('setWebhook')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSetWebhookArgument = record
  public
    /// <summary>HTTPS url to send updates to. Use an empty string to remove webhook
    /// integration</summary>
    [caIsRequaired]
    [caName('url')]
    [caDefaultValueString('')]
    Url: string;
    /// <summary>Upload your public key certificate so that the root certificate in use
    /// can be checked. See our self-signed guide for details.</summary>
    [caName('certificate')]
    [caDefaultValueString('')]
    Certificate: TcaFileToSend;
    /// <summary>
    /// The fixed IP address which will be used to send webhook requests instead of the
    /// IP address resolved through DNS
    /// </summary>
    [caName('ip_address')]
    [caDefaultValueString('')]
    IpAddress: string;
    /// <summary> Maximum allowed number of simultaneous HTTPS connections to the
    /// webhook for update delivery, 1-100. Defaults to 40. Use lower values to limit
    /// the load on your bot's server, and higher values to increase your bot's
    /// throughput.</summary>
    [caName('max_connections')]
    [caDefaultValueInt64(40)]
    MaxConnections: Int64;
    [caName('allowed_updates')]
    [caDefaultValueString('')]
    /// <summary>A JSON-serialized list of the update types you want your bot to
    /// receive. For example, specify [“message”, “edited_channel_post”,
    /// “callback_query”] to only receive updates of these types. See Update for a
    /// complete list of available update types. Specify an empty list to receive all
    /// updates regardless of type (default). If not specified, the previous setting
    /// will be used.
    ///
    /// Please note that this parameter doesn't affect updates created before the call
    /// to the getUpdates, so unwanted updates may be received for a short period of
    /// time.</summary>
    AllowedUpdates: TAllowedUpdates;
    /// <summary>
    /// Pass True to drop all pending updates
    /// </summary>
    [caName('drop_pending_updates')]
    [caDefaultValueBoolean(False)]
    DropPendingUpdates: Boolean;
    class function Default: TtgSetWebhookArgument; static;
  end;

  /// <summary>Use this method to remove webhook integration if you decide to switch
  /// back to getUpdates. Returns True on success.
  /// <summary>
  [caName('deleteWebhook')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgDeleteWebhookArgument = record
  public
    /// <summary>
    /// Pass True to drop all pending updates
    /// </summary>
    [caName('drop_pending_updates')]
    [caDefaultValueBoolean(False)]
    DropPendingUpdates: Boolean;
    class function Default: TtgDeleteWebhookArgument; static;
  end;

  /// <summary> Use this method to get current webhook status. Requires no parameters.
  /// On success, returns a WebhookInfo object. If the bot is using getUpdates, will
  /// return an object with the url field empty.</summary>
  [caName('getWebhookInfo')]
  [caParameterType(TcaParameterType.QueryString)]
  TtgGetWebhookInfoArgument = record
  public
    class function Default: TtgGetWebhookInfoArgument; static;
  end;

  [caName('exportChatInviteLink')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.GetOrPost)]
  TtgExportChatInviteLinkArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    class function Default: TtgExportChatInviteLinkArgument; static;
  end;

  [caName('getChat')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.GetOrPost)]
  TtgGetChatArgument = record
  public
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    ChatId: TtgUserLink;
    class function Default: TtgGetChatArgument; static;
  end;

  /// <summary>
  /// Use this method to get basic info about a file and prepare it for downloading.
  /// For the moment, bots can download files of up to 20MB in size. On success, a
  /// File object is returned. The file can then be downloaded via the link https:
  /// //api.telegram.org/file/bot<token>/<file_path>, where <file_path> is taken from
  /// the response. It is guaranteed that the link will be valid for at least 1 hour.
  /// When the link expires, a new one can be requested by calling getFile again.
  /// </summary>
  [caName('getFile')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.GetOrPost)]
  TtgGetFileArgument = class
  private
    [caName('file_id')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FFileId: string;
  public
    constructor Create(const AFileID: string);
    /// <summary>File identifier to get info about</summary>
    property FileId: string read FFileId write FFileId;
  end;

  /// <summary> Use this method to unban a previously kicked user in a supergroup or
  /// channel. The user will not return to the group or channel automatically, but
  /// will be able to join via link, etc. The bot must be an administrator for this
  /// to work. By default, this method guarantees that after the call the user is not
  /// a member of the chat, but will be able to join it. So if the user is a member
  /// of the chat they will also be removed from the chat. If you don't want this,
  /// use the parameter only_if_banned. Returns True on success.</summary>
  [caName('unbanChatMember')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgUnbanChatMemberArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caName('user_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FUserID: Int64;
    [caName('only_if_banned')]
    [caDefaultValueBoolean(False)]
    FOnlyIfBanned: Boolean;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    /// <summary> Unique identifier of the target user.</summary>
    property UserId: Int64 read FUserID write FUserID;
    /// <summary>
    /// Do nothing if the user is not banned
    /// </summary>
    property OnlyIfBanned: Boolean read FOnlyIfBanned write FOnlyIfBanned;
    constructor Create(AChatId: TtgUserLink; const AUserId: Int64; const AOnlyIfBanned: Boolean = True);
  end;

  /// <summary>Use this method to remove a message from the list of pinned messages
  /// in a chat. If the chat is not a private chat, the bot must be an administrator
  /// in the chat for this to work and must have the 'can_pin_messages' admin right
  /// in a supergroup or 'can_edit_messages' admin right in a channel. Returns True
  /// on success.
  /// </summary>
  [caName('unpinChatMessage')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgUnpinChatMessageArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caName('message_id')]
    [caDefaultValueInt64(0)]
    FMessageID: Int64;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    /// <summary>Identifier of a message to unpin. If not specified, the most recent
    /// pinned message (by sending date) will be unpinned.</summary>
    property MessageID: Int64 read FMessageID write FMessageID;
    constructor Create(AChatId: TtgUserLink; const AMessageId: Int64 = 0);
  end;

  /// <summary>Use this method to remove a message from the list of pinned messages
  /// in a chat. If the chat is not a private chat, the bot must be an administrator
  /// in the chat for this to work and must have the 'can_pin_messages' admin right
  /// in a supergroup or 'can_edit_messages' admin right in a channel. Returns True
  /// on success.
  /// </summary>
  [caName('unpinAllChatMessages')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgUnpinAllChatMessagesArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    constructor Create(AChatId: TtgUserLink);
  end;

  /// <summary>
  /// Use this method to create an additional invite link for a chat. The bot must be
  /// an administrator in the chat for this to work and must have the appropriate
  /// admin rights. The link can be revoked using the method revokeChatInviteLink.
  /// Returns the new invite link as ChatInviteLink object.
  /// </summary>
  [caName('createChatInviteLink')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgCreateChatInviteLinkArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caName('expire_date')]
    FExpireDate: TDateTime;
    [caName('member_limit')]
    FMemberLimit: Integer;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    /// <summary>
    /// Point in time (Unix timestamp) when the link will expire
    /// </summary>
    property ExpireDate: TDateTime read FExpireDate write FExpireDate;
    /// <summary>
    /// Maximum number of users that can be members of the chat simultaneously after
    /// joining the chat via this invite link; 1-99999
    /// </summary>
    property MemberLimit: Integer read FMemberLimit write FMemberLimit;
  end;

  /// <summary>
  /// Use this method to edit a non-primary invite link created by the bot. The bot
  /// must be an administrator in the chat for this to work and must have the
  /// appropriate admin rights. Returns the edited invite link as a ChatInviteLink
  /// object.
  /// </summary>
  [caName('editChatInviteLink')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgEditChatInviteLinkArgument = class(TtgCreateChatInviteLinkArgument)
  private
    [caName('invite_link')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FInviteLink: string;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId;
    /// <summary>
    /// The invite link to edit
    /// </summary>
    property InviteLink: string read FInviteLink write FInviteLink;
    /// <summary>
    /// Point in time (Unix timestamp) when the link will expire
    /// </summary>
    property ExpireDate;
    /// <summary>
    /// Maximum number of users that can be members of the chat simultaneously after
    /// joining the chat via this invite link; 1-99999
    /// </summary>
    property MemberLimit;
  end;

  /// <summary> Use this method to revoke an invite link created by the bot. If the
  /// primary link is revoked, a new link is automatically generated. The bot must be
  /// an administrator in the chat for this to work and must have the appropriate
  /// admin rights. Returns the revoked invite link as ChatInviteLink object.
  /// </summary>
  [caName('revokeChatInviteLink')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgRevokeChatInviteLinkArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caName('invite_link')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FInviteLink: string;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    /// <summary>
    /// The invite link to revoke
    /// </summary>
    property InviteLink: string read FInviteLink write FInviteLink;
  end;

  /// <summary> Use this method to promote or demote a user in a supergroup or a
  /// channel. The bot must be an administrator in the chat for this to work and must
  /// have the appropriate admin rights. Pass False for all boolean parameters to
  /// demote a user. Returns True on success.
  /// </summary>
  TtgPromoteChatMemberArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caName('user_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FUserID: Int64;
    [caName('is_anonymous')]
    [caDefaultValueBoolean(False)]
    FIsAnonymous: Boolean;
    [caName('can_manage_chat')]
    [caDefaultValueBoolean(False)]
    FCanManageChat: Boolean;
    [caName('can_post_messages')]
    [caDefaultValueBoolean(False)]
    FCanPostMessages: Boolean;
    [caName('can_edit_messages')]
    [caDefaultValueBoolean(False)]
    FCanEditMessages: Boolean;
    [caName('can_delete_messages')]
    [caDefaultValueBoolean(False)]
    FCanDeleteMessages: Boolean;
    [caName('can_manage_video_chats')]
    [caDefaultValueBoolean(False)]
    FCanManageVideoChats: Boolean;
    [caName('can_restrict_members')]
    [caDefaultValueBoolean(False)]
    FCanRestrictMembers: Boolean;
    [caName('can_promote_members')]
    [caDefaultValueBoolean(False)]
    FCanPromoteMembers: Boolean;
    [caName('can_change_info')]
    [caDefaultValueBoolean(False)]
    FCanChangeInfo: Boolean;
    [caName('can_invite_users')]
    [caDefaultValueBoolean(False)]
    FCanInviteUsers: Boolean;
    [caName('can_pin_messages')]
    [caDefaultValueBoolean(False)]
    FCanPinMessages: Boolean;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    /// <summary>
    /// Unique identifier of the target user
    /// </summary>
    property UserId: Int64 read FUserID write FUserID;
    /// <summary> Pass True, if the administrator's presence in the chat is
    /// hidden</summary>
    property IsAnonymous: Boolean read FIsAnonymous write FIsAnonymous;
    /// <summary> Pass True, if the administrator can access the chat event log, chat
    /// statistics, message statistics in channels, see channel members, see anonymous
    /// administrators in supergroups and ignore slow mode. Implied by any other
    /// administrator privilege
    /// </summary>
    property CanManageChat: Boolean read FCanManageChat write FCanManageChat;
    /// <summary> Pass True, if the administrator can create channel posts, channels
    /// only </summary>
    property CanPostMessages: Boolean read FCanPostMessages write FCanPostMessages;
    /// <summary> Pass True, if the administrator can edit messages of other users and
    /// can pin messages, channels only</summary>
    property CanEditMessages: Boolean read FCanEditMessages write FCanEditMessages;
    /// <summary>Pass True, if the administrator can delete messages of other
    /// users</summary>
    property CanDeleteMessages: Boolean read FCanDeleteMessages write FCanDeleteMessages;
    /// <summary>Pass True, if the administrator can manage video chats</summary>
    property CanManageVideoChats: Boolean read FCanManageVideoChats write FCanManageVideoChats;
    /// <summary> Pass True, if the administrator can restrict, ban or unban chat
    /// members</summary>
    property CanRestrictMembers: Boolean read FCanRestrictMembers write FCanRestrictMembers;
    /// <summary>Pass True, if the administrator can add new administrators with a
    /// subset of their own privileges or demote administrators that he has promoted,
    /// directly or indirectly (promoted by administrators that were appointed by him)
    /// </summary>
    property CanPromoteMembers: Boolean read FCanPromoteMembers write FCanPromoteMembers;
    /// <summary> Pass True, if the administrator can change chat title, photo and
    /// other settings</summary>
    property CanChangeInfo: Boolean read FCanChangeInfo write FCanChangeInfo;
    /// <summary> Pass True, if the administrator can invite new users to the
    /// chat</summary>
    property CanInviteUsers: Boolean read FCanInviteUsers write FCanInviteUsers;
    /// <summary> Pass True, if the administrator can pin messages, supergroups
    /// only</summary>
    property CanPinMessages: Boolean read FCanPinMessages write FCanPinMessages;
  end;

  /// <summary> Use this method to kick a user from a group, a supergroup or a
  /// channel. In the case of supergroups and channels, the user will not be able to
  /// return to the chat on their own using invite links, etc., unless unbanned first.
  /// The bot must be an administrator in the chat for this to work and must have the
  /// appropriate admin rights. Returns True on success.</summary>
  [caName('banChatMember')]
  [caMethod(TcaMethod.GET)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgBanChatMember = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caName('user_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FUserID: Int64;
    [caName('until_date')]
    [caDefaultValueSingle(0)]
    FUntilDate: TDateTime;
    [caName('revoke_messages')]
    [caDefaultValueBoolean(False)]
    FRevokeMessages: Boolean;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    /// <summary> Unique identifier of the target user.</summary>
    property UserId: Int64 read FUserID write FUserID;
    /// <summary>
    /// Date when the user will be unbanned, unix time. If user is banned for more than
    /// 366 days or less than 30 seconds from the current time they are considered to
    /// be banned forever. Applied for supergroups and channels only.
    /// </summary>
    property UntilDate: TDateTime read FUntilDate write FUntilDate;
    /// <summary>
    /// Pass True to delete all messages from the chat for the user that is being
    /// removed. If False, the user will be able to see messages in the group that were
    /// sent before the user was removed. Always True for supergroups and channels.
    /// </summary>
    property RevokeMessages: Boolean read FRevokeMessages write FRevokeMessages;
    constructor Create;
  end;

  /// <summary> Use this method to get the current list of the bot's commands for the
  /// given scope and user language. Returns Array of BotCommand on success. If
  /// commands aren't set, an empty list is returned.</summary>
  [caName('getMyCommands')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgGetMyCommandsArgument = class
  private
    [caName('scope')]
    [caDefaultValueString('{}')]
    FScope: TtgBotCommandScope;
    [caName('language_code')]
    [caDefaultValueString('')]
    FLanguageCode: string;
  public
    /// <summary>A JSON-serialized object, describing scope of users. Defaults to
    /// BotCommandScopeDefault.</summary>
    property Scope: TtgBotCommandScope read FScope write FScope;
    /// <summary>
    /// A two-letter ISO 639-1 language code or an empty string
    /// </summary>
    property LanguageCode: string read FLanguageCode write FLanguageCode;
  end;

  /// <summary> Use this method to change the list of the bot's commands. See https:
  /// //core.telegram.org/bots#commands for more details about bot commands. Returns
  /// True on success.</summary>
  [caName('setMyCommands')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgSetMyCommandsArgument = class
  private
    [caName('commands')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FCommands: TArray<TtgBotCommand>;
    [caName('scope')]
    [caDefaultValueString('{}')]
    FScope: TtgBotCommandScope;
    [caName('language_code')]
    [caDefaultValueString('')]
    FLanguageCode: string;
  public
    destructor Destroy; override;
    /// <summary>
    /// A JSON-serialized list of bot commands to be set as the list of the bot's
    /// commands. At most 100 commands can be specified.
    /// </summary>
    property Commands: TArray<TtgBotCommand> read FCommands write FCommands;
    /// <summary>A JSON-serialized object, describing scope of users. Defaults to
    /// BotCommandScopeDefault.</summary>
    property Scope: TtgBotCommandScope read FScope write FScope;
    /// <summary>
    /// A two-letter ISO 639-1 language code or an empty string
    /// </summary>
    property LanguageCode: string read FLanguageCode write FLanguageCode;
  end;

  /// <summary> Use this method to get the number of members in a chat. Returns Int
  /// on success.</summary>
  [caName('getChatMemberCount')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgGetChatMemberCountArgument = class
  private
    [caName('chat_id')]
    [caIsRequaired]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
  public
    /// <summary>Unique identifier for the target chat or username of the target
    /// channel (in the format @channelusername)</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
  end;

  /// <summary>
  /// Use this method to send answers to callback queries sent from inline keyboards.
  /// The answer will be displayed to the user as a notification at the top of the
  /// chat screen or as an alert. On success, True is returned.
  /// </summary>
  [caName('answerCallbackQuery')]
  [caMethod(TcaMethod.POST)]
  [caParameterType(TcaParameterType.QueryString)]
  TtgAnswerCallbackQueryArgument = record
  private
    [caName('callback_query_id')]
    [caIsRequaired]
    [caDefaultValueString('')]
    FCallbackQueryId: string;
    [caDefaultValueString('')]
    [caName('text')]
    FText: string;
    [caName('show_alert')]
    [caDefaultValueBoolean(False)]
    FShowAlert: Boolean;
    [caName('url')]
    [caDefaultValueString('')]
    FUrl: string;
    [caName('cache_time')]
    [caDefaultValueInt(0)]
    FCacheTime: Integer;
  public
    /// <summary>
    /// Unique identifier for the query to be answered
    /// </summary>
    property CallbackQueryId: string read FCallbackQueryId write FCallbackQueryId;
    /// <summary>
    /// Text of the notification. If not specified, nothing will be shown to the user,
    /// 0-200 characters
    /// </summary>
    property Text: string read FText write FText;
    /// <summary>
    /// If True, an alert will be shown by the client instead of a notification at the
    /// top of the chat screen. Defaults to false.
    /// </summary>
    property ShowAlert: Boolean read FShowAlert write FShowAlert;
    /// <summary>
    /// URL that will be opened by the user's client. If you have created a Game and
    /// accepted the conditions via @Botfather, specify the URL that opens your game —
    /// note that this will only work if the query comes from a callback_game button.
    ///
    /// Otherwise, you may use links like t.me/your_bot?start=XXXX that open your bot with a parameter.
    /// </summary>
    property Url: string read FUrl write FUrl;
    /// <summary>
    /// The maximum amount of time in seconds that the result of the callback query may
    /// be cached client-side. Telegram apps will support caching starting in version 3.
    /// 14. Defaults to 0.
    /// </summary>
    property CacheTime: Integer read FCacheTime write FCacheTime;
  end;

  /// <summary> Use this method to get the current default administrator rights of
  /// the bot. Returns ChatAdministratorRights on success.
  /// </summary>
  TtgGetMyDefaultAdministratorRightsArgument = class
  private
    [caName('for_channels')]
    [caDefaultValueBoolean(False)]
    FForChannels: Boolean;
  public
    /// <summary> Pass True to get default administrator rights of the bot in channels.
    /// Otherwise, default administrator rights of the bot for groups and supergroups
    /// will be returned.
    /// </summary>
    property ForChannels: Boolean read FForChannels write FForChannels;
  end;

/// <summary>
  /// Use this method to change the default administrator rights requested by the bot
  /// when it's added as an administrator to groups or channels. These rights will be
  /// suggested to users, but they are are free to modify the list before adding the
  /// bot. Returns True on success.
  /// </summary>
  TtgSetMyDefaultAdministratorRightsArgument = class(TtgGetMyDefaultAdministratorRightsArgument)
  private
    [caName('rights')]
    [caDefaultValueString('{}')]
    FRights: TtgChatAdministratorRights;
  public
    /// <summary>
    /// A JSON-serialized object describing new default administrator rights. If not
    /// specified, the default administrator rights will be cleared.
    /// </summary>
    property Rights: TtgChatAdministratorRights read FRights write FRights;
    /// <summary>
    /// Pass True to change the default administrator rights of the bot in channels.
    /// Otherwise, the default administrator rights of the bot for groups and
    /// supergroups will be changed.
    /// </summary>
    property ForChannels;
  end;

  /// <summary>
  /// Use this method to change the bot's menu button in a private chat, or the
  /// default menu button. Returns True on success.
  /// </summary>
  TtgSetChatMenuButtonArgument = record
  private
    [caName('chat_id')]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
    [caName('menu_button')]
    FMenuButton: TtgMenuButtonAbstract;
  public
    /// <summary>Unique identifier for the target private chat. If not specified,
    /// default bot's menu button will be changed</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
    /// <summary>
    /// A JSON-serialized object for the new bot's menu button. Defaults to
    /// MenuButtonDefault
    /// </summary>
    property MenuButton: TtgMenuButtonAbstract read FMenuButton write FMenuButton;
  end;

  /// <summary>Use this method to get the current value of the bot's menu button in a
  /// private chat, or the default menu button. Returns MenuButton on success.
  /// </summary>
  TtgGetChatMenuButtonArgument = record
  private
    [caName('chat_id')]
    [caDefaultValueInt64(0)]
    FChatId: TtgUserLink;
  public
    /// <summary>Unique identifier for the target private chat. If not specified,
    /// default bot's menu button will be returned</summary>
    property ChatId: TtgUserLink read FChatId write FChatId;
  end;

implementation

uses System.SysUtils;

{ TtgGetUpdatesArgument }

class function TtgGetUpdatesArgument.Default: TtgGetUpdatesArgument;
begin
  Result.Offset := 0;
  Result.Limit := 100;
  Result.Timeout := 0;
  Result.AllowedUpdates := UPDATES_ALLOWED_ALL;
end;

{ TtgGetChatArgument }

class function TtgGetChatArgument.Default: TtgGetChatArgument;
begin
  Result.ChatId := 0;
end;

{ TtgSetWebhookArgument }

class function TtgSetWebhookArgument.Default: TtgSetWebhookArgument;
begin
  Result.Url := '';
  Result.Certificate := TcaFileToSend.Empty;
  Result.IpAddress := '';
  Result.MaxConnections := 40;
  Result.AllowedUpdates := UPDATES_ALLOWED_ALL;
  Result.DropPendingUpdates := False;
end;

{ TtgDeleteWebhookArgument }

class function TtgDeleteWebhookArgument.Default: TtgDeleteWebhookArgument;
begin
  Result.DropPendingUpdates := False;
end;

{ TtgGetWebhookInfoArgument }

class function TtgGetWebhookInfoArgument.Default: TtgGetWebhookInfoArgument;
begin

end;

{ TtgEditMessageLiveLocationHaveInlineMessageIDArgument }

class function TtgEditMessageLiveLocationHaveInlineMessageIDArgument.Default
  : TtgEditMessageLiveLocationHaveInlineMessageIDArgument;
begin
  Result.InlineMessageId := 0;
  Result.Latitude := 0.0;
  Result.Longitude := 0.0;
end;

{ TtgEditMessageLiveLocationArgument }

class function TtgEditMessageLiveLocationArgument.Default: TtgEditMessageLiveLocationArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
  Result.MessageID := 0;
  Result.Latitude := 0.0;
  Result.Longitude := 0.0;
end;

{ TtgStopMessageLiveLocationArgument }

class function TtgStopMessageLiveLocationArgument.Default: TtgStopMessageLiveLocationArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
  Result.MessageID := 0;
end;

{ TtgStopMessageLiveLocationHaveInlineMessageIDArgument }

class function TtgStopMessageLiveLocationHaveInlineMessageIDArgument.Default
  : TtgStopMessageLiveLocationHaveInlineMessageIDArgument;
begin
  Result.InlineMessageId := 0;
end;

{ TtgExportChatInviteLinkArgument }

class function TtgExportChatInviteLinkArgument.Default: TtgExportChatInviteLinkArgument;
begin
  Result.ChatId := TtgUserLink.Empty;
end;

{ TtgUnbanChatMemberArgument }

constructor TtgUnbanChatMemberArgument.Create(AChatId: TtgUserLink; const AUserId: Int64;
  const AOnlyIfBanned: Boolean = True);
begin
  FChatId := AChatId;
  FUserID := AUserId;
  FOnlyIfBanned := AOnlyIfBanned;
end;

{ TtgGetFileArgument }

constructor TtgGetFileArgument.Create(const AFileID: string);
begin
  FFileId := AFileID;
end;

constructor TtgUnpinChatMessageArgument.Create(AChatId: TtgUserLink; const AMessageId: Int64 = 0);
begin
  inherited Create();
  FChatId := AChatId;
  FMessageID := AMessageId;
end;

constructor TtgUnpinAllChatMessagesArgument.Create(AChatId: TtgUserLink);
begin
  inherited Create();
  FChatId := AChatId;
end;

{ TtgKickChatMemberArgument }

constructor TtgBanChatMember.Create;
begin
  FChatId := TtgUserLink.Empty;
  FUserID := 0;
  FUntilDate := 0;
  FRevokeMessages := False;
end;

destructor TtgSetMyCommandsArgument.Destroy;
begin
  if Assigned(FScope) then
    FreeAndNil(FScope);
  inherited;
end;

end.
