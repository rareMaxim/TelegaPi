unit TelegramBotApiTests.Tools;

interface

Uses
  System.IniFiles;

type
  TTelegramTools = class

  public
    class procedure GenerateEmptyConfigFile;
  end;

implementation

{ TTelegramTools }

class procedure TTelegramTools.GenerateEmptyConfigFile;
var
  LIni: TMemIniFile;
begin
  LIni := TMemIniFile.Create('config-empty.ini');
  try
    LIni.WriteString('Telegram', 'BotToken', '');
    LIni.WriteString('Telegram', 'SendToID', '');
    LIni.WriteString('SendMessage', 'Markdown', 'Markdown.md');
    LIni.WriteString('SendMessage', 'MarkdownV2', 'MarkdownV2.md');
    LIni.WriteString('SendMessage', 'html', 'HTML style.html');
    LIni.UpdateFile;
  finally
    LIni.Free;
  end;
end;

end.
