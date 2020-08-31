unit TelegramBotApi.Client;

interface

uses
  TelegramBotApi.Types,
  TelegramBotApi.Types.Request,
  CloudApi.IAuthenticator,
  CloudApi.Request,
  CloudApi.Client.Sync;

type
  TTelegramBotApi = class
  public const
    LIB_VERSION = '4.6.0.alpha';
  private
    FCloudApi: TCloudApiClient;
    FBotToken: string;
    function GetBotToken: string;
    procedure SetBotToken(const Value: string);
  protected
    function InternalExecute<TArgument: record; TResult>(AArgument: TArgument): ItgResponse<TResult>; overload;
    function InternalExecute<TResult>(ARequest: IcaRequest): ItgResponse<TResult>; overload;
    function InternalExecuteCustom<TResult>(ARequest: IcaRequest): TResult; overload;
    function InternalExecuteCustom<TArgument: record; TResult>(AArgument: TArgument): TResult; overload;
  public
    function GetUpdates(AGetUpdatesArgument: TtgGetUpdatesArgument): ItgResponse<TArray<TtgUpdate>>; overload;
    class function GetUpdates(const AJson: string): ItgResponse<TArray<TtgUpdate>>; overload;
    function SetWebhook(SetWebhookArgument: TtgSetWebhookArgument): Boolean;
    function DeleteWebhook(): Boolean;
    function GetWebhookInfo(): ItgResponse<TtgWebhookInfo>; overload;

    function GetMe: ItgResponse<TtgUser>;
    function SendMessage(ASendMessageArgument: TtgMessageArgument): ItgResponse<TtgMessage>;
    function ForwardMessage(AForwardMessageArgument: TtgForwardMessageArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send photos. On success, the sent Message is returned.
    /// </summary>
    function SendPhoto(ASendPhotoArgument: TtgSendPhotoArgument): ItgResponse<TtgMessage>;
    function SendAudio(ASendAudioArgument: TtgSendAudioArgument): ItgResponse<TtgMessage>;
    function SendDocument(ASendDocumentArgument: TtgSendDocumentArgument): ItgResponse<TtgMessage>;
    function SendVideo(ASendVideoArgument: TtgSendVideoArgument): ItgResponse<TtgMessage>;
    function SendAnimation(ASendAnimationArgument: TtgSendAnimationArgument): ItgResponse<TtgMessage>;
    function SendVoice(ASendVoiceArgument: TtgSendVoiceArgument): ItgResponse<TtgMessage>;
    function SendVideoNote(ASendVideoNoteArgument: TtgSendVideoNoteArgument): ItgResponse<TtgMessage>;
    function SendMediaGroup(ASendMediaGroupArgument: TtgSendMediaGroupArgument): ItgResponse<TArray<TtgMessage>>;
    function SendVenue(ASendVenueArgument: TtgSendVenueArgument): ItgResponse<TtgMessage>;
    function SendContact(ASendContactArgument: TtgSendContactArgument): ItgResponse<TtgMessage>;
    /// <summary>
    /// Use this method to send a native poll. On success, the sent Message is returned.
    /// </summary>
    function SendPool(ASendPollArgument: TtgSendPollArgument): ItgResponse<TtgMessage>;

    function getChat(AGetChatArgument: TtgGetChatArgument): ItgResponse<TtgChat>;
    constructor Create; overload;
    constructor Create(const AToken: string); overload;

    destructor Destroy; override;
    property BotToken: string read GetBotToken write SetBotToken;
    property CloudApi: TCloudApiClient read FCloudApi write FCloudApi;
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
end;

constructor TTelegramBotApi.Create(const AToken: string);
begin
  Self.Create;
  BotToken := AToken;
end;

function TTelegramBotApi.DeleteWebhook: Boolean;
begin
  Result := InternalExecuteCustom<TtgDeleteWebhookArgument, Boolean>(TtgDeleteWebhookArgument.Default);
end;

destructor TTelegramBotApi.Destroy;
begin
  FCloudApi.Free;
  inherited Destroy;
end;

function TTelegramBotApi.ForwardMessage(AForwardMessageArgument: TtgForwardMessageArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgForwardMessageArgument, TtgMessage>(AForwardMessageArgument);
end;

function TTelegramBotApi.GetBotToken: string;
begin
  Result := FBotToken;
end;

function TTelegramBotApi.getChat(AGetChatArgument: TtgGetChatArgument): ItgResponse<TtgChat>;
begin
  Result := InternalExecute<TtgGetChatArgument, TtgChat>(AGetChatArgument);
end;

function TTelegramBotApi.GetMe: ItgResponse<TtgUser>;
begin
  Result := InternalExecute<TtgGetMeArgument, TtgUser>(TtgGetMeArgument.Default);
end;

function TTelegramBotApi.GetUpdates(AGetUpdatesArgument: TtgGetUpdatesArgument): ItgResponse<TArray<TtgUpdate>>;
begin
  Result := InternalExecute < TtgGetUpdatesArgument, TArray < TtgUpdate >> (AGetUpdatesArgument);
end;

class function TTelegramBotApi.GetUpdates(const AJson: string): ItgResponse<TArray<TtgUpdate>>;
begin
  Result := TCloudApiClient.Serializer.Deserialize < TtgResponse < TArray<TtgUpdate> >> (AJson);
end;

function TTelegramBotApi.GetWebhookInfo: ItgResponse<TtgWebhookInfo>;
begin
  Result := InternalExecute<TtgGetWebhookInfoArgument, TtgWebhookInfo>(TtgGetWebhookInfoArgument.Default);
end;

function TTelegramBotApi.InternalExecute<TArgument, TResult>(AArgument: TArgument): ItgResponse<TResult>;
var
  LReq: IcaRequest;
begin
  LReq := TcaRequestArgument.ObjToRequest<TArgument>(AArgument);
  Result := InternalExecute<TResult>(LReq);
end;

function TTelegramBotApi.InternalExecute<TResult>(ARequest: IcaRequest): ItgResponse<TResult>;
var
  LCloudResponse: IcaResponse<TtgResponse<TResult>>;
begin
  LCloudResponse := FCloudApi.Execute < TtgResponse < TResult >> (ARequest);
  Result := LCloudResponse.Data;
  Result.CloudResponse := LCloudResponse;
end;

function TTelegramBotApi.InternalExecuteCustom<TArgument, TResult>(AArgument: TArgument): TResult;
var
  LReq: IcaRequest;
begin
  LReq := TcaRequestArgument.ObjToRequest<TArgument>(AArgument);
  Result := InternalExecuteCustom<TResult>(LReq);
end;

function TTelegramBotApi.InternalExecuteCustom<TResult>(ARequest: IcaRequest): TResult;
var
  LCloudResponse: IcaResponse<TResult>;
begin
  LCloudResponse := FCloudApi.Execute<TResult>(ARequest);
  Result := LCloudResponse.Data;
end;

function TTelegramBotApi.SendAnimation(ASendAnimationArgument: TtgSendAnimationArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendAnimationArgument, TtgMessage>(ASendAnimationArgument);
end;

function TTelegramBotApi.SendAudio(ASendAudioArgument: TtgSendAudioArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendAudioArgument, TtgMessage>(ASendAudioArgument);
end;

function TTelegramBotApi.SendContact(ASendContactArgument: TtgSendContactArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendContactArgument, TtgMessage>(ASendContactArgument);
end;

function TTelegramBotApi.SendDocument(ASendDocumentArgument: TtgSendDocumentArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendDocumentArgument, TtgMessage>(ASendDocumentArgument);
end;

function TTelegramBotApi.SendMediaGroup(ASendMediaGroupArgument: TtgSendMediaGroupArgument)
  : ItgResponse<TArray<TtgMessage>>;
var
  LRequest: IcaRequest;
  LMedia: TtgInputMedia;
begin
  LRequest := TcaRequestArgument.ObjToRequest<TtgSendMediaGroupArgument>(ASendMediaGroupArgument);
  for LMedia in ASendMediaGroupArgument.Media do
  begin
    case LMedia.GetFileToSend.&Type of
      TcaFileToSendType.File, TcaFileToSendType.Stream:
        LRequest.AddFile(LMedia.GetFileToSend);
    end;
  end;
  Result := InternalExecute < TArray < TtgMessage >> (LRequest);
end;

function TTelegramBotApi.SendMessage(ASendMessageArgument: TtgMessageArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgMessageArgument, TtgMessage>(ASendMessageArgument);
end;

function TTelegramBotApi.SendPhoto(ASendPhotoArgument: TtgSendPhotoArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendPhotoArgument, TtgMessage>(ASendPhotoArgument);
end;

function TTelegramBotApi.SendPool(ASendPollArgument: TtgSendPollArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendPollArgument, TtgMessage>(ASendPollArgument);
end;

function TTelegramBotApi.SendVenue(ASendVenueArgument: TtgSendVenueArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendVenueArgument, TtgMessage>(ASendVenueArgument);
end;

function TTelegramBotApi.SendVideo(ASendVideoArgument: TtgSendVideoArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendVideoArgument, TtgMessage>(ASendVideoArgument);
end;

function TTelegramBotApi.SendVideoNote(ASendVideoNoteArgument: TtgSendVideoNoteArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendVideoNoteArgument, TtgMessage>(ASendVideoNoteArgument);
end;

function TTelegramBotApi.SendVoice(ASendVoiceArgument: TtgSendVoiceArgument): ItgResponse<TtgMessage>;
begin
  Result := InternalExecute<TtgSendVoiceArgument, TtgMessage>(ASendVoiceArgument);
end;

procedure TTelegramBotApi.SetBotToken(const Value: string);
begin
  if FBotToken <> Value then
  begin
    FBotToken := Value;
    TTelegramAuthenticator(FCloudApi.Authenticator).BotToken := Value;
  end;
end;

function TTelegramBotApi.SetWebhook(SetWebhookArgument: TtgSetWebhookArgument): Boolean;
begin
  Result := InternalExecuteCustom<TtgSetWebhookArgument, Boolean>(SetWebhookArgument);
end;

end.
