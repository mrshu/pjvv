unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls,
  ExtCtrls, RobotGroupUnit, RobotUnit, Minca;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Image1: TImage;
    Label1: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    procedure NewGame;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { private declarations }
  public
    { public declarations }
  end;

procedure Redraw;

var
  Form1: TForm1;
  Mince: TRobotGroup;
  Subor: file of Integer;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  CS;
  Randomize;
  Mince := TRobotGroup.Create;
end;

procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
  Z. R: Boolean;
begin
  for I := 0 to Mince.Num-1 do begin
      if Mince.R[I].Dist(X, Y) <= 140.0 then begin
        TMinca(Mince.R[I]).Otoc;
      end;
  end;
  Redraw;

  Z := TMinca(Mince.R[0]).Znak;
  R := True;
  for I := 1 to Mince.Num-1 do begin
      if TMinca(Mince.R[I]).Znak <> Z then
         R := False;
  end;

  if R then begin
    ShowMessage('Gratulujeme, vyhrali ste!');
    NewGame;
  end;

end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  NewGame;
end;

procedure Redraw;
var
  I: Integer;
begin
  CS;
  for I := 0 to Mince.Num-1 do begin
      TMinca(Mince.R[I]).DrawOut;
  end;
end;


procedure TForm1.Button2Click(Sender: TObject);
var
  I: Integer;
begin
  if SaveDialog1.Execute then begin
     AssignFile(Subor, SaveDialog1.Filename);
     Rewrite(Subor);
     Write(Subor, Mince.Num);
     for I := 0 to Mince.Num-1 do begin
         Write(Subor, Integer(TMinca(Mince.R[I]).Znak));
     end;
     CloseFile(Subor);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  I,N, Znak: Integer;
  M: TMinca;
begin
  if OpenDialog1.Execute then begin
     AssignFile(Subor, OpenDialog1.Filename);
     Reset(Subor);
     Read(Subor, N);
     Edit1.Text := IntToStr(N);
     Mince.Destroy;
     Mince := TRobotGroup.Create;
     CS;
     for I := 0 to N-1 do begin
         M := TMinca.Create(20 + I*100, 200, 0);
         Read(Subor, Znak);
         M.Znak := Boolean(Znak);
         Mince.NewRobot(M);
         M.DrawOut;
     end;
     CloseFile(Subor);
  end;
end;

procedure TForm1.NewGame;
var
  N, I: Integer;
  M: TMinca;
begin
  CS;
  N := StrToInt(Edit1.Text);
  for I := 0 to N-1 do begin
      M := TMinca.Create(20 + I*100, 200, 0);
      Mince.NewRobot(M);
      M.DrawOut;
  end;
end;

end.

