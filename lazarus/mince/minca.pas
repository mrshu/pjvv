unit Minca;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, RobotUnit;

type
  TMinca = class(TRobot)
  public
    Znak: Boolean;
    constructor Create(NewX, NewY: Real; Angle: Real = 0);
    procedure Otoc;
    procedure DrawOut;
    procedure Poly(N: Integer; S, U: Real);
  end;

implementation

{ TMinca }

constructor TMinca.Create(NewX, NewY, Angle: Real);
begin
  inherited;
  PU;
  SetY(NewY + 50);
  PD;
  Znak := Random > 0.5;
end;

procedure TMinca.Otoc;
begin
  Znak := not Znak;
end;

procedure TMinca.Poly(N: Integer; S, U: Real);
begin
  while N > 0 do
  begin
    Fd(S);
    Rt(U);
    Dec(N);
  end;
end;

procedure TMinca.DrawOut;
begin
  if Znak then begin
      Poly(3, 60, 120);
  end
  else begin
      Poly(6, 30, 60);
  end;
end;


end.
