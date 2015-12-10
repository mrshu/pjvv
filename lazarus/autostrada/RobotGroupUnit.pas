unit RobotGroupUnit;
// verzia 251109
{$mode objfpc}{$H+}

interface

uses
  Graphics, ExtCtrls, RobotUnit;

type
  TRobotGroup = class
  private
    FR: array of TRobot;
    FNum: Integer;
    function GetRobot(I: Integer): TRobot;
  public
    destructor Destroy; override;
    procedure NewRobot;
    procedure NewRobot(X, Y: Real; Angle: Real = 0);
    procedure NewRobot(Robot: TRobot);
    procedure EraseRobot(I: Integer);
    procedure EraseRobot(Robot: TRobot);
    procedure Compact;

    procedure Fd(D: Real);
    procedure Rt(Angle: Real);
    procedure Lt(Angle: Real);
    procedure SetH(Angle: Real);
    procedure SetXY(X, Y: Real);
    procedure MoveXY(X, Y: Real);
    procedure SetX(X: Real);
    procedure SetY(Y: Real);
    procedure PU;
    procedure PD;
    procedure SetPen(Down: Boolean);
    procedure SetPC(Color: TColor);
    procedure SetPW(Width: Integer);

    procedure Point(D: Real = 0);
    procedure Text(const Text: string);
    procedure Fill(Color: TColor);
    function  IsNear(X, Y: Real): TRobot;
    procedure Draw;

    property  R[I: Integer]: TRobot read GetRobot; default;
    property  Num: Integer read FNum;
    property  PW: Integer write SetPW;
    property  PC: TColor write SetPC;
  end;

implementation

destructor TRobotGroup.Destroy;
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    FR[I].Free;
end;

function TRobotGroup.GetRobot(I: Integer): TRobot;
begin
  if (I < 0) or (I >= FNum) then
    Result := nil
  else
    Result := FR[I];
end;

procedure TRobotGroup.NewRobot;
begin
  NewRobot(TRobot.Create);
end;

procedure TRobotGroup.NewRobot(X, Y, Angle: Real);
begin
  NewRobot(TRobot.Create(X, Y, Angle));
end;

procedure TRobotGroup.NewRobot(Robot: TRobot);
begin
  if FNum > High(FR) then
    SetLength(FR, Length(FR)+10);
  FR[FNum] := Robot;
  Inc(FNum);
end;

procedure TRobotGroup.EraseRobot(I: Integer);
begin
  if (I >= 0) and (I < FNum) then
  begin
    FR[I].Free;
    FR[I] := nil;
  end;
end;

procedure TRobotGroup.EraseRobot(Robot: TRobot);
var
  I: Integer;
begin
  I := 0;
  while (I < FNum) and (FR[I] <> Robot) do
    Inc(I);
  EraseRobot(I);
end;

procedure TRobotGroup.Compact;
var
  I, J: Integer;
begin
  J := 0;
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
    begin
      FR[J] := FR[I];
      Inc(J);
    end;
  FNum := J;
end;

////////////////////////////////////////////////////////

procedure TRobotGroup.Fd(D: Real);
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].Fd(D);
end;

procedure TRobotGroup.Rt(Angle: Real);
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].Rt(Angle);
end;

procedure TRobotGroup.Lt(Angle: Real);
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].Lt(Angle);
end;

procedure TRobotGroup.SetH(Angle: Real);
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].SetH(Angle);
end;

procedure TRobotGroup.SetXY(X, Y: Real);
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].SetXY(X, Y);
end;

procedure TRobotGroup.SetX(X: Real);
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].SetX(X);
end;

procedure TRobotGroup.SetY(Y: Real);
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].SetY(Y);
end;

procedure TRobotGroup.MoveXY(X, Y: Real);
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].MoveXY(X, Y);
end;

procedure TRobotGroup.PU;
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].PU;
end;

procedure TRobotGroup.PD;
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].PD;
end;

procedure TRobotGroup.SetPen(Down: Boolean);
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].SetPen(Down);
end;

procedure TRobotGroup.SetPC(Color: TColor);
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].SetPC(Color);
end;

procedure TRobotGroup.SetPW(Width: Integer);
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].SetPW(Width);
end;

procedure TRobotGroup.Text(const Text: string);
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].Text(Text);
end;

procedure TRobotGroup.Fill(Color: TColor);
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].Fill(Color);
end;

function  TRobotGroup.IsNear(X, Y: Real): TRobot;
var
  I: Integer;
begin
  I := FNum-1;
  while (I >= 0) and ((FR[I] = nil) or not FR[I].IsNear(X, Y)) do
    Dec(I);
  if I < 0 then
    Result := nil
  else
    Result := FR[I];
end;

procedure TRobotGroup.Draw;
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].Draw;
end;

procedure TRobotGroup.Point(D: Real);
var
  I: Integer;
begin
  for I := 0 to FNum-1 do
    if FR[I] <> nil then
      FR[I].Point(D);
end;

end.
