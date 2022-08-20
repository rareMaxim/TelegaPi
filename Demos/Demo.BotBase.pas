unit Demo.BotBase;

interface

uses
  TelegaPi;

type
  TDemoBotBase = class
  const
    BOT_TOKEN = '1225990942:AAEfSINTq5fMdAOiswxNScZ8wQUDD_5KDYQ';
  private
    fBot: TTelegramBotApi;
    fPooling: TtgPollingConsole;
  protected
    procedure WhaitEnter;
  public
    constructor Create; virtual;
    destructor Destroy; override;
    property Bot: TTelegramBotApi read fBot write fBot;
    property Pooling: TtgPollingConsole read fPooling write fPooling;
  end;

implementation

{ TDemoBotBase }

constructor TDemoBotBase.Create;
begin
  fBot := TTelegramBotApi.Create(BOT_TOKEN);

  fPooling := TtgPollingConsole.Create;
  fPooling.Bot := fBot;
end;

destructor TDemoBotBase.Destroy;
begin
  fBot.Free;
  fPooling.Free;
  inherited;
end;

procedure TDemoBotBase.WhaitEnter;
begin
  Writeln('Press Enter to stop bot service... ');
  Readln;
  Writeln('Please wait, closing service... ');
end;

end.
