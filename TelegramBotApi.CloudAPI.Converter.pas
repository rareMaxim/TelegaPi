unit TelegramBotApi.CloudAPI.Converter;

interface

uses
  System.SysUtils,
  System.Rtti;

type
  TtgConverters = class
  private
    class procedure RegisterToJson<T>;
  protected
    class procedure TtgUserLinkConverter;
    class procedure TtgParseModeConverter;
    class procedure TtgAllowedUpdatesConverter;
    class procedure TtgChatActionConverter;
    class procedure ItgReplyMarkupConverter;
  public
    class procedure TelegramConverter;
  end;

implementation

uses
  CloudAPI.Client.Base,
  CloudAPI.Types,
  CloudAPI.RequestArgument,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Enums,
  TelegramBotApi.Types.Helpers,
  TelegramBotApi.Types.Keyboards;
{ TtgConverters }

class procedure TtgConverters.TtgAllowedUpdatesConverter;
begin
  TcaRequestArgument.Current.RegisterConverter<TAllowedUpdates>(
    function(AValue: TValue): string
    begin
      Result := AValue.AsType<TAllowedUpdates>.ToString;
    end);
end;

class procedure TtgConverters.TtgChatActionConverter;
begin
  TcaRequestArgument.Current.RegisterConverter<TtgChatAction>(
    function(AValue: TValue): string
    begin
      Result := AValue.AsType<TtgChatAction>.ToString;
    end);
end;

class procedure TtgConverters.ItgReplyMarkupConverter;
begin
  TcaRequestArgument.Current.RegisterConverter<ItgReplyMarkup>(
    function(AValue: TValue): string
    var
      LValue: TInterfacedObject;
      lCA: TCloudApiClientBase;
    begin
      LValue := TInterfacedObject(AValue.AsInterface);
      lCA := TCloudApiClientBase.Create;
      try
        Result := lCA.Serializer.Serialize<TObject>(LValue);
      finally
        lCA.Free;
      end;
    end);
end;

class procedure TtgConverters.RegisterToJson<T>;
begin
  TcaRequestArgument.Current.RegisterConverter<T>(
    function(AValue: TValue): string
    var
      lData: T;
      lCA: TCloudApiClientBase;
    begin
      lData := AValue.AsType<T>;
      lCA := TCloudApiClientBase.Create;
      try
        Result := lCA.Serializer.Serialize<T>(lData);
      finally
        lCA.Free;
      end;
    end);
end;

class procedure TtgConverters.TelegramConverter;
begin
  TtgUserLinkConverter;
  TtgParseModeConverter;
  TtgAllowedUpdatesConverter;
  RegisterToJson<TArray<TcaFileToSend>>;
  RegisterToJson<TArray<TtgInputMedia>>;
  TtgChatActionConverter;
  ItgReplyMarkupConverter;
  RegisterToJson<TtgBotCommandScopeDefault>;
  RegisterToJson<TArray<TtgBotCommand>>;;
end;

class procedure TtgConverters.TtgParseModeConverter;
begin
  TcaRequestArgument.Current.RegisterConverter<TtgParseMode>(
    function(AValue: TValue): string
    var
      lVal: TtgParseMode;
    begin
      lVal := AValue.AsType<TtgParseMode>;
      case lVal of
        TtgParseMode.Default:
          Result := '';
        TtgParseMode.Markdown:
          Result := 'Markdown';
        TtgParseMode.Markdownv2:
          Result := 'MarkdownV2';
        TtgParseMode.HTML:
          Result := 'HTML';
      else
        begin
          raise Exception.Create(TRttiEnumerationType.GetName(lVal));
        end;
      end;
    end);
end;

class procedure TtgConverters.TtgUserLinkConverter;
begin
  TcaRequestArgument.Current.RegisterConverter<TtgUserLink>(
    function(AValue: TValue): string
    begin
      Result := AValue.AsType<TtgUserLink>.ToString;
    end);
end;

end.
