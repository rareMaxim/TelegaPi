program PoolBot;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  TelegaPi,
  Demo.BotBase in '..\Demo.BotBase.pas',
  Winapi.Windows;

type
  TPoolBot = class(TDemoBotBase)
  private
    FRouteManager: TtgRouter;
    FUserStates: TtgRouteUserStateManagerRAM;

  protected
    procedure UpdateConsoleTitle(ABot: TTelegramBotApi);
    // procedure SendTextMessage(const UserLink: TtgUserLink; const MsgText: string);
  public
    procedure SetupRoutes;
    procedure Main;
    constructor Create; override;
    destructor Destroy; override;
  end;

  { TPoolBot }

constructor TPoolBot.Create;
begin
  inherited;
  FUserStates := TtgRouteUserStateManagerRAM.Create;
  FRouteManager := TtgRouter.Create(FUserStates);
  SetupRoutes;
end;

destructor TPoolBot.Destroy;
begin
  FRouteManager.Free;
  FUserStates.Free;
  inherited;
end;

procedure TPoolBot.Main;
begin
  UpdateConsoleTitle(Bot);
  Pooling.OnMessage := procedure(AMsg: TtgMessage)
    begin
      Writeln(AMsg.Text);
      FRouteManager.SendMessage(AMsg);
      if AMsg.Text.StartsWith('/start') then
      begin

      end;
    end;
  Pooling.Start;
end;

procedure TPoolBot.SetupRoutes;
var
  lStart: TtgRoute;
begin
  lStart := TtgRoute.Create('/start');
  lStart.OnStartCallback := procedure(AUserID: Int64)
    begin
      Writeln(TimeToStr(NOW) + ':"' + lStart.Name + '" start');
    end;
  lStart.OnMessageCallback := procedure(AMsg: TtgMessage)
    var
      lPoolKb: TtgReplyKeyboardMarkup;
      lStartPool: TtgKeyboardButtonPool;
      lMsg: TtgSendMessageArgument;
    begin
      lMsg := TtgSendMessageArgument.Create;
      lPoolKb := TtgKeyboardBuilder.ReplyKb;
      try
        Writeln(TimeToStr(NOW) + ':"' + lStart.Name + '" Message');
        lPoolKb.ResizeKeyboard := True;
        lPoolKb.AddRow;
        lStartPool := lPoolKb.AddButtonPool;
        lStartPool.Text := 'Создать викторину';
        lPoolKb.AddButton.Text := 'Отмена';
        //
        lMsg.ChatId := AMsg.From.ID;
        lMsg.Text := 'Нажмите на кнопку ниже и создайте викторину!';
        lMsg.ReplyMarkup := lPoolKb;
        Bot.SendMessage(lMsg);
      finally
        lMsg.Free;
        // lPoolKb.Free;
      end;

    end;
  lStart.OnStopCallback := procedure(AUserID: Int64)
    begin
      Writeln(TimeToStr(NOW) + ':"' + lStart.Name + '" stop');
    end;

  //
  FRouteManager.RegisterRoutes([lStart]);
end;

procedure TPoolBot.UpdateConsoleTitle(ABot: TTelegramBotApi);
var
  lUser: TtgUser;
begin
  lUser := ABot.GetMe.Result;
  try
    if lUser = nil then
      raise Exception.Create('Check bot token');
    SetConsoleTitle(pwideChar(lUser.Username));
  finally
    // lUser.Free; <-- Autofree in TelegaPi core
  end;
end;

procedure Main;
var
  lCore: TPoolBot;
begin
  lCore := TPoolBot.Create;
  try
    lCore.Main;
    Readln;
  finally
    lCore.Free;
  end;
end;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }
    Main;
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;

end.
