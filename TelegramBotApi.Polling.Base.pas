unit TelegramBotApi.Polling.Base;

interface

uses
  System.SyncObjs,
  System.Threading,
  TelegramBotApi.Client,
  TelegramBotApi.UpdateParser,
  TelegramBotApi.Types.Enums;

type
  TtgPollingBase = class(TTgBotUpdateParser)
  private
    FEvent: TEvent;
    FTask: ITask;
    FBot: TTelegramBotApi;
    FMessageOffset: Int64;
    FAllowedUpdates: TAllowedUpdates;
    FLimit: Int64;
    FPollingInterval: Int64;
  protected
    procedure Go(const AToken: string);
  public
    constructor Create;
    procedure Start;
    procedure Stop;
    destructor Destroy; override;
    property Bot: TTelegramBotApi read FBot write FBot;
    property MessageOffset: Int64 read FMessageOffset write FMessageOffset;
    property AllowedUpdates: TAllowedUpdates read FAllowedUpdates write FAllowedUpdates default UPDATES_ALLOWED_ALL;
    property Limit: Int64 read FLimit write FLimit;
    property PollingInterval: Int64 read FPollingInterval write FPollingInterval;
  end;

implementation

uses
  TelegramBotApi.Types,
  TelegramBotApi.Types.Request;

{ TtgPollingBase }

constructor TtgPollingBase.Create;
begin
  inherited Create();
  FEvent := TEvent.Create();
  FMessageOffset := 0;
  FAllowedUpdates := UPDATES_ALLOWED_ALL;
  FLimit := 100;
  FPollingInterval := 1000;
end;

destructor TtgPollingBase.Destroy;
begin
  Stop;
  FEvent.Free;
  inherited Destroy;
end;

procedure TtgPollingBase.Go(const AToken: string);
var
  LUpdateArg: TtgGetUpdatesArgument;
  LBot: TTelegramBotApi;
  LUpdates: TArray<TtgUpdate>;
begin
  LUpdateArg := TtgGetUpdatesArgument.Default;
  LUpdateArg.Offset := FMessageOffset;
  LUpdateArg.AllowedUpdates := FAllowedUpdates;
  LUpdateArg.Limit := FLimit;
  LBot := TTelegramBotApi.Create(AToken);
  try
    LUpdates := LBot.GetUpdates(LUpdateArg).Result;
    EventParser(LUpdates);
  finally
    LBot.Free;
  end;

end;

procedure TtgPollingBase.Start;
begin
  if FTask <> nil then
    Exit;
  FTask := TTask.Run(
    procedure
    begin
      while TTask.CurrentTask.Status <> TTaskStatus.Canceled do
      begin
        if FEvent.WaitFor(FPollingInterval) <> wrTimeout then
          Break;
        Go(FBot.BotToken);

      end;
    end)
end;

procedure TtgPollingBase.Stop;
begin
  FEvent.SetEvent;
  TTask.WaitForAny([FTask]);
  // FTask.Wait();
  // if Assigned(FTask) then
  // FTask.Cancel;
  // FTask := nil;
end;

end.
