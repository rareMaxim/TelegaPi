unit TelegramBotApi.Tools.CommandParser;

interface

uses
  TelegramBotApi.Types;

type
  TtgCommandParser = class
    class function Parse(AMsg: TtgMessage): TtgCommandParser; static;
  end;

implementation

uses
  TelegramBotApi.Types.Helpers;
{ TtgCommandParser }

class function TtgCommandParser.Parse(AMsg: TtgMessage): TtgCommandParser;
var
  LgMessageEntity: TtgMessageEntity;
begin
  for LgMessageEntity in AMsg.Entities do
  begin
    Writeln(LgMessageEntity.&Type.ToString);
  end;
end;

end.
