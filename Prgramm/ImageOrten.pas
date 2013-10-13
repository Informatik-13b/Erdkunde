unit ImageOrten;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Math;

type
  TImageOrten = class(TImage)
  private
    { Private-Deklarationen }
  protected
    { Protected-Deklarationen }
    procedure MouseUp(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
  public
    { Public-Deklarationen }
    constructor Create(AOwner:TComponent); override;
  published
    { Published-Deklarationen }
  end;

procedure Register;

implementation

var

KoSy: array of array of boolean;
Ort:TPoint;

constructor TImageOrten.Create(AOwner:TComponent);
var i,k:integer;
begin
     inherited Create(AOwner);

     Left := 100;
     Top := 50;
     Height := 809;
     Width := 633;
     Cursor := crCross;
     Picture.LoadFromFile('Bilder/Deutschland.bmp');

     SetLength(KoSy,633,809);
     for i := Low(KoSy) to High(KoSy) do
        for k := Low(KoSy[i]) to High(KoSy[i]) do
           KoSy[i,k] := false;
     KoSy[283,168] := true;

     for i := Low(KoSy) to High(KoSy) do
        for k := Low(KoSy[i]) to High(KoSy[i]) do
           if KoSy[i,k] = true then
           begin
                Ort := Point(i,k);
                break;
           end;
     Canvas.Brush.Style := bsClear;
     Canvas.Ellipse(Ort.x-10,Ort.y-10,Ort.x+10,Ort.y+10);

     Canvas.MoveTo(Ort.x,Ort.y);
end;

procedure TImageOrten.MouseUp(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
var
Entfernung:real;
dif_x, dif_y : integer;
begin
     Canvas.Pen.Width := 3;
     Canvas.Pen.Color := clRed;
     Canvas.LineTo(X,Y);

     dif_x := X - Ort.x;
     dif_y := Y - Ort.y;

     Entfernung := sqrt( (dif_x * dif_x) + (dif_y * dif_y));

     Entfernung := Entfernung * ( 922 / 809 );

     Canvas.TextOut(x,Y,FloatToStr(Entfernung));
end;

procedure Register;
begin
  RegisterComponents('Übung', [TImageOrten]);
end;

end.
