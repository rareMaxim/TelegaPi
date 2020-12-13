unit TelegramBotApi.CloudAPI.Converter;

interface

type
  TtgConverters = class
  private
    class procedure TtgUserLinkConverter;
    class procedure TtgParseModeConverter;
    class procedure TtgAllowedUpdates;
    class procedure TArrayTcaFileToSend;
    class procedure TArrayTtgInputMedia;
  public
    class procedure TelegramConverter;
  end;

implementation

uses
  CloudAPI.Client.Base,
  CloudAPI.Types,
  CloudAPI.RequestArgument,

  System.SysUtils,
  System.Rtti,
  TelegramBotApi.Types,
  TelegramBotApi.Types.Enums,
  TelegramBotApi.Types.Helpers;
{ TtgConverters }

class procedure TtgConverters.TtgAllowedUpdates;
begin
  TcaRequestArgument.Current.RegisterConverter<TAllowedUpdates>(
    function(AValue: TValue): string
    begin
      Result := AValue.AsType<TAllowedUpdates>.ToString;
    end);
end;

class procedure TtgConverters.TArrayTcaFileToSend;
begin
  TcaRequestArgument.Current.RegisterConverter < TArray < TcaFileToSend >> (
    function(AValue: TValue): string
    var
      LArray: TArray<TcaFileToSend>;
      lCA: TCloudApiClientBase;
    begin
      LArray := AValue.AsType<TArray<TcaFileToSend>>;
      lCA := TCloudApiClientBase.Create;
      try
        Result := lCA.Serializer.Serialize < TArray < TcaFileToSend >> (LArray);
      finally
        lCA.Free;
      end;
    end);
end;

class procedure TtgConverters.TArrayTtgInputMedia;
begin
  TcaRequestArgument.Current.RegisterConverter < TArray < TtgInputMedia >> (
    function(AValue: TValue): string
    var
      LArray: TArray<TtgInputMedia>;
      lCA: TCloudApiClientBase;
    begin
      LArray := AValue.AsType<TArray<TtgInputMedia>>;
      lCA := TCloudApiClientBase.Create;
      try
        Result := lCA.Serializer.Serialize < TArray < TtgInputMedia >> (LArray);
      finally
        lCA.Free;
      end;
    end);
end;

class procedure TtgConverters.TelegramConverter;
begin
  TtgUserLinkConverter;
  TtgParseModeConverter;
  TtgAllowedUpdates;
  TArrayTcaFileToSend;
  TArrayTtgInputMedia;
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
