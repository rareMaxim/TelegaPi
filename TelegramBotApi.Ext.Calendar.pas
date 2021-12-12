unit TelegramBotApi.Ext.Calendar;

interface

uses
  System.SysUtils,
  TelegramBotApi.Types.Keyboards;

type
  TtgCalendarControl = class
  private
    FCurentData: TDate;
    FFS: TFormatSettings;
    FCalendar: TtgInlineKeyboardMarkup;
    procedure AddButtonSelectMonth;
    procedure AddButtonDayName;
    procedure AddButtonDates;

  public

    constructor Create;
    destructor Destroy; override;
    function Keyboard: TtgInlineKeyboardMarkup;
  end;

implementation

uses
  System.DateUtils;

{ TtgCalendarControl }

procedure TtgCalendarControl.AddButtonDates;
var
  lYear, lMonth, lDay: Word;
  lDateCursor: TDate;
  lBeginDay, lEndDay: Word;
  lTotalDays: Word;
  I: Integer;
  lRowCursor: Byte;
  LBtn: TtgInlineKeyboardButton;
begin
  lRowCursor := 2;
  DecodeDate(FCurentData, lYear, lMonth, lDay);
  lTotalDays := DaysInMonth(FCurentData);
  lDateCursor := EncodeDate(lYear, lMonth, 1);
  lBeginDay := DayOfTheWeek(lDateCursor);
  lDateCursor := EncodeDate(lYear, lMonth, lTotalDays);
  lEndDay := DayOfTheWeek(lDateCursor);

  for I := 0 - lBeginDay to lTotalDays do
  begin
    FCalendar[lRowCursor, I - ((lRowCursor - 2) * 7)] := TtgInlineKeyboardButton.Create;
    LBtn := FCalendar[lRowCursor, I - ((lRowCursor - 2) * 7)];
    if I < 0 then
    begin
      LBtn.Text := '0';
      LBtn.CallbackData := 'empty_date';
    end
    else
    begin
      LBtn.Text := I.ToString;
      LBtn.CallbackData := 'empty_date';
    end;

    if I mod 7 = 0 then
      Inc(lRowCursor);
  end;

end;

procedure TtgCalendarControl.AddButtonDayName;
var
  I: Integer;
  LBtn: TtgInlineKeyboardButton;
begin
  for I := Low(FFS.ShortDayNames) to High(FFS.ShortDayNames) do
  begin
    LBtn := TtgInlineKeyboardButton.Create;
    LBtn.Text := FFS.ShortDayNames[I];
    LBtn.CallbackData := FFS.ShortDayNames[I];
    FCalendar.Button[1, I - 1] := LBtn;
  end;
end;

procedure TtgCalendarControl.AddButtonSelectMonth;
var
  LBtn: TtgInlineKeyboardButton;
begin
  LBtn := TtgInlineKeyboardButton.Create;
  LBtn.Text := FFS.LongMonthNames[MonthOf(FCurentData)];
  LBtn.CallbackData := 'select_month';
  FCalendar.Button[0, 0] := LBtn;
end;

constructor TtgCalendarControl.Create;
begin
  inherited Create;
  FCurentData := Now;
  FFS := TFormatSettings.Create;
  FCalendar := TtgKeyboardBuilder.InlineKb;
  AddButtonSelectMonth;
  AddButtonDayName;
  // AddButtonDates;
end;

destructor TtgCalendarControl.Destroy;
begin
  // FCalendar.Free;
  inherited Destroy;
end;

function TtgCalendarControl.Keyboard: TtgInlineKeyboardMarkup;
begin
  Result := FCalendar;
end;

end.
