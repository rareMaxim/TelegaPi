unit Unit10;

interface

uses
  TelegramBotApi.Client,
  TelegramBotApi.Polling.Console,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs;

type
  TForm10 = class(TForm)
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FTg: TTelegramBotApi;
    FRec: TtgPollingConsole;
  public
    { Public declarations }
  end;

var
  Form10: TForm10;

implementation

{$R *.dfm}

procedure TForm10.FormDestroy(Sender: TObject);
begin
  FRec.Free;
  FTg.Free;
end;

procedure TForm10.FormCreate(Sender: TObject);
begin
  FTg := TTelegramBotApi.Create('5014618:AAEclbI1Nbiib7yayj26VCGVKsnLETnuYRw');
  FTg.GetMe;
  FRec := TtgPollingConsole.Create;
  FRec.Bot := FTg;
  FRec.Start;
end;

end.
