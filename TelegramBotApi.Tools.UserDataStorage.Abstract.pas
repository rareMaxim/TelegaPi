unit TelegramBotApi.Tools.UserDataStorage.Abstract;

interface

type
  TtgUserDataStorageAbstract = class abstract
  protected
    function GetData(const AID: Int64; const AKey: string): string; virtual; abstract;
    procedure SetData(const AID: Int64; const AKey, Value: string); virtual; abstract;
  public
    property Data[const AID: Int64; const AKey: string]: string read GetData write SetData; default;
  end;

implementation

end.
