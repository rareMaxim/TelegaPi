unit TelegramBotApi.CloudAPI.Converter;

interface

type
  TtgConverters = class
  private
    class procedure TtgUserLinkConverter;
    class procedure TtgParseModeConverter;
    class procedure TtgAllowedUpdates;
    class procedure TArrayTcaFileToSend;
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
  TcaRequestArgument.RegisterConverter('TAllowedUpdates',
    function(AValue: TValue): string
    begin
      Result := AValue.AsType<TAllowedUpdates>.ToString;
    end);
end;

class procedure TtgConverters.TArrayTcaFileToSend;
begin
  TcaRequestArgument.RegisterConverter('TArray<TcaFileToSend>',
    function(AValue: TValue): string
    var
      LArray: TArray<TcaFileToSend>;
    begin
      LArray := AValue.AsType<TArray<TcaFileToSend>>;
      Result := TCloudApiClientBase.Serializer.Serialize < TArray < TcaFileToSend >> (LArray);
    end);
end;

class procedure TtgConverters.TelegramConverter;
begin
  TtgUserLinkConverter;
  TtgParseModeConverter;
  TtgAllowedUpdates;
  TArrayTcaFileToSend;
end;

class procedure TtgConverters.TtgParseModeConverter;
begin
  TcaRequestArgument.RegisterConverter('TtgParseMode',
    function(AValue: TValue): string
    begin
      case AValue.AsType<TtgParseMode> of
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
          raise Exception.Create('Error Message');
        end;
      end;
    end);
end;

class procedure TtgConverters.TtgUserLinkConverter;
begin
  TcaRequestArgument.RegisterConverter('TtgUserLink',
    function(AValue: TValue): string
    begin
      Result := AValue.AsType<TtgUserLink>.ToString;
    end);
end;

end.
