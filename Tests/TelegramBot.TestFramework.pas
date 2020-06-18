unit TelegramBot.TestFramework;

interface

uses
  DUnitX.TestFramework;

type
  TtgTestRegister = class
  public
    class procedure RegisterTestFixture(const AClass: TClass; const AName: string = '');
  end;

implementation

{ TtgTestRegister }

class procedure TtgTestRegister.RegisterTestFixture(const AClass: TClass;
  const AName: string);
begin

end;

end.
