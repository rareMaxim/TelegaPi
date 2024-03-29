{***************************************************************************}
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

unit TelegramBotApi.Polling.Base;

interface

uses
  System.Classes,
  System.SyncObjs,
  TelegramBotApi.Client,
  TelegramBotApi.UpdateParser,
  TelegramBotApi.Types.Enums;

type
  TtgPollingBase = class(TTgBotUpdateParser)
  private
    FEvent: TEvent;
    fWorker: TThread;
    FBot: TTelegramBotApi;
    FMessageOffset: Int64;
    FAllowedUpdates: TAllowedUpdates;
    FLimit: Int64;
    FPollingInterval: Int64;
  protected
    procedure Go;
  public
    constructor Create; overload;
    constructor Create(ABot: TTelegramBotApi); overload;
    procedure Start; virtual;
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
  System.SysUtils,
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

constructor TtgPollingBase.Create(ABot: TTelegramBotApi);
begin
  Self.Create;
  FBot := ABot;
end;

destructor TtgPollingBase.Destroy;
begin
  Stop;
  FEvent.Free;
  inherited Destroy;
end;

procedure TtgPollingBase.Go;
var
  LUpdateArg: TtgGetUpdatesArgument;
  LBot: TTelegramBotApi;
  LUpdates: ItgResponse<TArray<TtgUpdate>>;
  i: Integer;
begin
  LUpdateArg := TtgGetUpdatesArgument.Default;
  LUpdateArg.Offset := FMessageOffset;
  LUpdateArg.AllowedUpdates := FAllowedUpdates;
  LUpdateArg.Limit := FLimit;
  LBot := TTelegramBotApi.Create;
  LBot.Assign(FBot);
  try
    LUpdates := LBot.GetUpdates(LUpdateArg);
    if Assigned(LUpdates) and (Length(LUpdates.Result) > 0) then
    begin
      EventParser(LUpdates.Result);
      FMessageOffset := LUpdates.Result[High(LUpdates.Result)].UpdateID + 1;
      for i := Low(LUpdates.Result) to High(LUpdates.Result) do
        LUpdates.Result[i].Free;
    end;
  finally
    LBot.Free;
  end;
end;

procedure TtgPollingBase.Start;
begin
  if Assigned(fWorker) then
    Exit;
  fWorker := TThread.CreateAnonymousThread(
    procedure
    var
      lWaitResult: TWaitResult;
    begin
      while True do
      begin
        lWaitResult := FEvent.WaitFor(FPollingInterval);
        if lWaitResult = wrTimeout then
          Go
        else
          Break;
      end;
    end);
  fWorker.FreeOnTerminate := False;
  fWorker.Start;
end;

procedure TtgPollingBase.Stop;
begin
  FEvent.SetEvent;
  if Assigned(fWorker) then
    fWorker.WaitFor;
  FreeAndNil(fWorker);
end;

end.
