unit MincaGroup;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Minca, RobotGroupUnit;

type
  TMincaGroup = class(TRobotGroup)
    procedure CreateNew(N: Integer);
  end;

implementation

{ TMincaGroup }

procedure TMincaGroup.CreateNew(N: Integer);
var
  I: Integer;
begin

end;

end.
