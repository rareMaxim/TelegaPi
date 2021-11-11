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
    FOnCallbackQuery: TProc<TtgCallbackQuery>;
    FOnChannelPost: TProc<TtgMessage>;
    FOnChosenInlineResult: TProc<TtgChosenInlineResult>;
    FOnEditedChannelPost: TProc<TtgMessage>;
    FOnMessage: TProc<TtgMessage>;
    FOnInlineQuery: TProc<TtgInlineQuery>;
    FOnEditedMessage: TProc<TtgMessage>;
    FOnShippingQuery: TProc<TtgShippingQuery>;
    FOnPreCheckoutQuery: TProc<TtgPreCheckoutQuery>;
  protected
    procedure DoOnCallbackQuery(ACallbackQuery: TtgCallbackQuery); override;
    procedure DoOnChannelPost(AChannelPost: TtgMessage); override;
    procedure DoOnChosenInlineResult(AChosenInlineResult: TtgChosenInlineResult); override;
    procedure DoOnEditedChannelPost(AEditedChannelPost: TtgMessage); override;
    procedure DoOnEditedMessage(AEditedMessage: TtgMessage); override;
    procedure DoOnInlineQuery(AInlineQuery: TtgInlineQuery); override;
    procedure DoOnMessage(AMessage: TtgMessage); override;
    procedure DoOnPreCheckoutQuery(APreCheckoutQuery: TtgPreCheckoutQuery); override;
    procedure DoOnShippingQuery(AShippingQuery: TtgShippingQuery); override;
    procedure DoOnUpdate(AUpdate: TtgUpdate); override;
    procedure DoOnUpdates(AUpdates: System.TArray<TelegramBotApi.Types.TtgUpdate>); override;
  public
    procedure Start; override;
    property OnCallbackQuery: TProc<TtgCallbackQuery> read FOnCallbackQuery write FOnCallbackQuery;
    property OnChannelPost: TProc<TtgMessage> read FOnChannelPost write FOnChannelPost;
    property OnChosenInlineResult: TProc<TtgChosenInlineResult> read FOnChosenInlineResult write FOnChosenInlineResult;
    property OnEditedChannelPost: TProc<TtgMessage> read FOnEditedChannelPost write FOnEditedChannelPost;
    property OnEditedMessage: TProc<TtgMessage> read FOnEditedMessage write FOnEditedMessage;
    property OnInlineQuery: TProc<TtgInlineQuery> read FOnInlineQuery write FOnInlineQuery;
    property OnMessage: TProc<TtgMessage> read FOnMessage write FOnMessage;
    property OnPreCheckoutQuery: TProc<TtgPreCheckoutQuery> read FOnPreCheckoutQuery write FOnPreCheckoutQuery;
    property OnShippingQuery: TProc<TtgShippingQuery> read FOnShippingQuery write FOnShippingQuery;
    property OnUpdate: TProc<TtgUpdate> read FOnUpdate write FOnUpdate;
    property OnUpdates: TProc < TArray < TtgUpdate >> read FOnUpdates write FOnUpdates;
  end;

implementation

{ TtgPollingConsole }

procedure TtgPollingConsole.DoOnCallbackQuery(ACallbackQuery: TtgCallbackQuery);
begin
  inherited;
  if Assigned(OnCallbackQuery) then
    OnCallbackQuery(ACallbackQuery);
end;

procedure TtgPollingConsole.DoOnChannelPost(AChannelPost: TtgMessage);
begin
  inherited;
  if Assigned(OnChannelPost) then
    OnChannelPost(AChannelPost);
end;

procedure TtgPollingConsole.DoOnChosenInlineResult(AChosenInlineResult: TtgChosenInlineResult);
begin
  inherited;
  if Assigned(OnChosenInlineResult) then
    OnChosenInlineResult(AChosenInlineResult);
end;

procedure TtgPollingConsole.DoOnEditedChannelPost(AEditedChannelPost: TtgMessage);
begin
  inherited;
  if Assigned(OnEditedChannelPost) then
    OnEditedChannelPost(AEditedChannelPost);
end;

procedure TtgPollingConsole.DoOnEditedMessage(AEditedMessage: TtgMessage);
begin
  inherited;
  if Assigned(OnEditedMessage) then
    OnEditedMessage(AEditedMessage);
end;

procedure TtgPollingConsole.DoOnInlineQuery(AInlineQuery: TtgInlineQuery);
begin
  inherited;
  if Assigned(OnInlineQuery) then
    OnInlineQuery(AInlineQuery);
end;

procedure TtgPollingConsole.DoOnMessage(AMessage: TtgMessage);
begin
  inherited;
  if Assigned(OnMessage) then
    OnMessage(AMessage);
end;

procedure TtgPollingConsole.DoOnPreCheckoutQuery(APreCheckoutQuery: TtgPreCheckoutQuery);
begin
  inherited;
  if Assigned(OnPreCheckoutQuery) then
    OnPreCheckoutQuery(APreCheckoutQuery);
end;

procedure TtgPollingConsole.DoOnShippingQuery(AShippingQuery: TtgShippingQuery);
begin
  inherited;
  if Assigned(OnShippingQuery) then
    OnShippingQuery(AShippingQuery);
end;

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

procedure TtgPollingConsole.Start;
begin
  inherited Start;
end;

end.
