unit TelegramBotApi.Polling.Console;

interface

uses
  TelegramBotApi.Polling.Base,
  TelegramBotApi.Types,
  System.SysUtils;

type
  TtgPollingConsole = class(TtgPollingBase)
  private
    FOnUpdate: TProc<TtgUpdate>;
    FOnUpdates: TProc<TArray<TtgUpdate>>;

  protected
    procedure DoOnUpdate(AUpdate: TtgUpdate); override;
    procedure DoOnUpdates(AUpdates: System.TArray<TelegramBotApi.Types.TtgUpdate>); override;
  public
    property OnUpdate: TProc<TtgUpdate> read FOnUpdate write FOnUpdate;
    property OnUpdates: TProc < TArray < TtgUpdate >> read FOnUpdates write FOnUpdates;
  end;

implementation

{ TtgPollingConsole }

procedure TtgPollingConsole.DoOnUpdate(AUpdate: TtgUpdate);
begin
  inherited;
  if Assigned(OnUpdate) then
    OnUpdate(AUpdate);
end;

procedure TtgPollingConsole.DoOnUpdates(AUpdates: System.TArray<TelegramBotApi.Types.TtgUpdate>);
begin
  inherited;
  if Assigned(OnUpdates) then
    OnUpdates(AUpdates);
end;

end.
