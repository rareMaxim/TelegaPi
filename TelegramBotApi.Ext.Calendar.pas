﻿{***************************************************************************}
{                                                                           }
{           TelegaPi                                                        }
{                                                                           }
{           Copyright (C) 2021 Maxim Sysoev                                 }
{                                                                           }
{           https://t.me/CloudAPI                                           }
{                                                                           }
{                                                                           }
{***************************************************************************}
{                                                                           }
{  Licensed under the Apache License, Version 2.0 (the "License");          }
{  you may not use this file except in compliance with the License.         }
{  You may obtain a copy of the License at                                  }
{                                                                           }
{      http://www.apache.org/licenses/LICENSE-2.0                           }
{                                                                           }
{  Unless required by applicable law or agreed to in writing, software      }
{  distributed under the License is distributed on an "AS IS" BASIS,        }
{  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. }
{  See the License for the specific language governing permissions and      }
{  limitations under the License.                                           }
{                                                                           }
{***************************************************************************}

unit TelegramBotApi.Ext.Calendar;

interface

uses
  System.SysUtils,
  TelegramBotApi.Types.Keyboards;

type
  TDayOfWeek = 0 .. 6;

  TtgCalendarControl = class
  private
    FDate: TDate;
    FFS: TFormatSettings;
    FCalendar: TtgInlineKeyboardMarkup;
    FStartOfWeek: TDayOfWeek;
    FMonthOffset: Integer;
    procedure AddButtonSelectMonth;
    procedure AddButtonDayName;
    procedure AddButtonDates;
  protected
    function GetCellText(ACol, ARow: Integer): string;
    function IsLeapYear(AYear: Integer): Boolean; virtual;
    function DaysPerMonth(AYear, AMonth: Integer): Integer; virtual;
    function DaysThisMonth: Integer; virtual;
    function GetDateElement(Index: Integer): Integer;
    procedure SetDateElement(Index: Integer; Value: Integer);
  public
    procedure Clear;
    constructor Create;
    destructor Destroy; override;
    function Keyboard: TtgInlineKeyboardMarkup;
    property Day: Integer index 3 read GetDateElement write SetDateElement stored False;
    property Month: Integer index 2 read GetDateElement write SetDateElement stored False;
    property Year: Integer index 1 read GetDateElement write SetDateElement stored False;
    property StartOfWeek: TDayOfWeek read FStartOfWeek write FStartOfWeek;
  end;

implementation

uses
  System.DateUtils;

{ TtgCalendarControl }

procedure TtgCalendarControl.AddButtonDates;
var
  LBtn: TtgInlineKeyboardButton;
  AYear, AMonth, ADay: Word;
  FirstDate: TDateTime;
  lCol, lRow: Integer;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  FirstDate := EncodeDate(AYear, AMonth, 1);
  FCalendar.AddRow;
  FMonthOffset := 2 - ((DayOfWeek(FirstDate) - StartOfWeek + 7) mod 7); { day of week for 1st of month }
  if FMonthOffset = 2 then
    FMonthOffset := -5;
  // MoveColRow((ADay - FMonthOffset) mod 7, (ADay - FMonthOffset) div 7 + 1, False, False);
  for lRow := 0 to 6 do
  begin
    for lCol := 0 to 6 do
    begin
      LBtn := FCalendar.AddButton;
      LBtn.Text := GetCellText(lCol, lRow);
      LBtn.CallbackData := 'selected_date_' + GetCellText(lCol, lRow);
    end;
    FCalendar.AddRow;
    if (lRow > 0) and (GetCellText(lCol, lRow) = ' ') then
      Exit;
  end;
end;

procedure TtgCalendarControl.AddButtonDayName;
var
  I: Integer;
  LBtn: TtgInlineKeyboardButton;
begin
  FCalendar.AddRow;
  for I := Low(FFS.ShortDayNames) to High(FFS.ShortDayNames) do
  begin
    LBtn := FCalendar.AddButton;
    LBtn.Text := FFS.ShortDayNames[(StartOfWeek + I - 1) mod 7 + 1];
    LBtn.CallbackData := FFS.ShortDayNames[(StartOfWeek + I) mod 7 + 1];
  end;
end;

procedure TtgCalendarControl.AddButtonSelectMonth;
var
  LBtnPrevMonth: TtgInlineKeyboardButton;
  LBtnNextMonth: TtgInlineKeyboardButton;
  LBtnMonthName: TtgInlineKeyboardButton;
begin
  FCalendar.AddRow;

  LBtnPrevMonth := FCalendar.AddButton;
  LBtnPrevMonth.Text := '<'; // FFS.LongMonthNames[MonthOf(IncMonth(FDate, -1))];
  LBtnPrevMonth.CallbackData := 'select_prev_month';
  //
  LBtnMonthName := FCalendar.AddButton;
  LBtnMonthName.Text := FFS.LongMonthNames[MonthOf(FDate)];
  LBtnMonthName.CallbackData := 'select_month';
  //
  LBtnNextMonth := FCalendar.AddButton;
  LBtnNextMonth.Text := '>'; // FFS.LongMonthNames[MonthOf(IncMonth(FDate, +1))];
  LBtnNextMonth.CallbackData := 'select_next_month';
end;

procedure TtgCalendarControl.Clear;
begin
  FCalendar.Clear;
end;

constructor TtgCalendarControl.Create;
begin
  inherited Create;
  FStartOfWeek := 1;
  FDate := Now;
  FFS := TFormatSettings.Create;
  FCalendar := TtgKeyboardBuilder.InlineKb;
end;

function TtgCalendarControl.DaysPerMonth(AYear, AMonth: Integer): Integer;
const
  DaysInMonth: array [1 .. 12] of Integer = (31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
begin
  Result := DaysInMonth[AMonth];
  if (AMonth = 2) and IsLeapYear(AYear) then
    Inc(Result);
  { leap-year Feb is special }
end;

function TtgCalendarControl.DaysThisMonth: Integer;
begin
  Result := DaysPerMonth(Year, Month);
end;

destructor TtgCalendarControl.Destroy;
begin
  // FCalendar.Free;
  inherited Destroy;
end;

function TtgCalendarControl.GetCellText(ACol, ARow: Integer): string;
var
  DayNum: Integer;
begin
  DayNum := FMonthOffset + ACol + (ARow) * 7;
  if (DayNum < 1) or (DayNum > DaysThisMonth) then
    Result := ' '
  else
    Result := IntToStr(DayNum);
end;

function TtgCalendarControl.GetDateElement(Index: Integer): Integer;
var
  AYear, AMonth, ADay: Word;
begin
  DecodeDate(FDate, AYear, AMonth, ADay);
  case Index of
    1:
      Result := AYear;
    2:
      Result := AMonth;
    3:
      Result := ADay;
  else
    Result := -1;
  end;
end;

function TtgCalendarControl.IsLeapYear(AYear: Integer): Boolean;
begin
  Result := (AYear mod 4 = 0) and ((AYear mod 100 <> 0) or (AYear mod 400 = 0));
end;

function TtgCalendarControl.Keyboard: TtgInlineKeyboardMarkup;
begin
  Clear;
  AddButtonSelectMonth;
  AddButtonDayName;
  AddButtonDates;
  Result := FCalendar;
end;

procedure TtgCalendarControl.SetDateElement(Index, Value: Integer);
var
  AYear, AMonth, ADay: Word;
begin
  if Value > 0 then
  begin
    DecodeDate(FDate, AYear, AMonth, ADay);
    case Index of
      1:
        if AYear <> Value then
          AYear := Value
        else
          Exit;
      2:
        if (Value <= 12) and (Value <> AMonth) then
          AMonth := Value
        else
          Exit;
      3:
        if (Value <= DaysThisMonth) and (Value <> ADay) then
          ADay := Value
        else
          Exit;
    else
      Exit;
    end;
    FDate := EncodeDate(AYear, AMonth, ADay);
  end;
end;

end.
