unit Test.Assert;

interface

uses
  DUnitX.Assert;

type
  TgAssert = class(Assert)
    class procedure InRange(actual, low, hight: single; const message: string = ''); overload;
    class procedure InRange(actual, low, hight: int64; const message: string = ''); overload;
    class procedure IsDefault<T>(actual: T; const message: string = ''); overload;
    class procedure IsDefault(actual: integer; const message: string = ''); overload;
  end;

implementation

uses
  System.Math,
  System.SysUtils;
{ TgAssert }

class procedure TgAssert.InRange(actual, low, hight: single; const message: string = '');
begin
  DoAssert;
  if System.Math.CompareValue(actual, low) = -1 then
    FailFmt('%f < %f. %s', [actual, low, message], ReturnAddress)
  else if System.Math.CompareValue(actual, hight) = 1 then
    FailFmt('%f > %f. %s', [actual, hight, message], ReturnAddress);
end;

class procedure TgAssert.InRange(actual, low, hight: int64; const message: string);
begin
  DoAssert;
  if System.Math.CompareValue(actual, low) = -1 then
    FailFmt('%f < %f. %s', [actual, low, message], ReturnAddress)
  else if System.Math.CompareValue(actual, hight) = 1 then
    FailFmt('%f > %f. %s', [actual, hight, message], ReturnAddress);
end;

class procedure TgAssert.IsDefault(actual: integer; const message: string);
begin
  IsDefault<integer>(actual);
end;

class procedure TgAssert.IsDefault<T>(actual: T; const message: string);
begin
  AreEqual(Default (T), actual);
end;

end.
