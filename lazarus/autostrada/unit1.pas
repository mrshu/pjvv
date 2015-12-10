unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, ExtCtrls,
  StdCtrls, RobotUnit, RobotGroupUnit, LCLType;

type

  { TForm1 }

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    ScrollBar1: TScrollBar;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Label1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { private declarations }
  public
    { public declarations }
  end;

var
  Form1: TForm1;
  Player: TRobot;
  Group: TRobotGroup;
  Subor: file of Integer;

procedure ClearGame;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.Timer1Timer(Sender: TObject);
var
  P, M, I: Integer;
  R: TRobot;
begin
  CS;
  Player.Point(10);

  P := StrToInt(Edit1.Text);
  M := StrToInt(Edit2.Text);

  if Random(10) > 3 then begin
     if Random(2) = 0 then
        R := TRobot.Create(0,  (1 + 2*Random(P div 2)) * ( M + 10 ), 90)
     else begin
         R := TRobot.Create(600,  (1 + 2*Random(P div 2)) * ( M + 10 ), 270);
     end;
     R.Value := 1 + Random(9);
     Group.NewRobot(R);
  end;

  if Group.IsNear(Player.X, Player.Y) <> nil then begin
     ShowMessage('Koniec hry!');
     ClearGame;
  end;

  if Player.Y >= 400 then begin
     ShowMessage('Gratulujeme, vyhrali ste!');
     ClearGame;
  end;

  if (Player.Y < 0) or (Player.Y > 400) then
     Player.SetY(0);

  for I := 0 to Group.Num-1 do
    if Group.R[I] <> nil then
       if (Group.R[I].X < 0) or (Group.R[I].X > 600) then
          Group.EraseRobot(I);
  Group.Compact;

  Group.Point(5);
  for I := 0 to Group.Num-1 do
    if Group.R[I] <> nil then
       Group.R[I].Fd(ScrollBar1.Position * Group.R[I].Value);

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Player := TRobot.Create(300, 0, 0);
  Player.SetPen(false);
  Player.SetPW(10);
  Player.SetPC(clBlue);

  Form1.KeyPreview := True;

  Group := TRobotGroup.Create;
  { Group.SetPen(False); }

  Randomize;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  I: Integer;
begin
  if SaveDialog1.Execute then begin
     AssignFile(Subor, SaveDialog1.Filename);
     Rewrite(Subor);
     Write(Subor, StrToInt(Edit1.Text));
     Write(Subor, StrToInt(Edit2.Text));
     Write(Subor, StrToInt(Edit3.Text));
     CloseFile(Subor);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  N: Integer;
begin
  if OpenDialog1.Execute then begin
     AssignFile(Subor, OpenDialog1.Filename);
     Reset(Subor);
     Read(Subor, N);
     Edit1.Text := IntToStr(N);
     Read(Subor, N);
     Edit2.Text := IntToStr(N);
     Read(Subor, N);
     Edit3.Text := IntToStr(N);
     CloseFile(Subor);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ClearGame;
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if (Key = VK_DOWN) then begin
    Player.Fd(-StrToInt(Edit3.Text));
  end;

  if (Key = VK_UP) then begin
    Player.Fd(StrToInt(Edit3.Text));
  end;
end;

procedure TForm1.Label1Click(Sender: TObject);
begin

end;

procedure ClearGame;
begin
  Group.Destroy;
  Group := TRobotGroup.Create;
  Player.SetY(0);
  CS;

end;

end.

