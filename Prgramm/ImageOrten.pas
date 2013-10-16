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

     Height := (Screen.Height*9) div 10;
     Width := (Height*19) div 26;
     Top := Screen.Height div 20;
     Left := (Screen.Width div 2) - (Width div 2);
     Cursor := crCross;
     Stretch := true;
     Picture.LoadFromFile('Bilder/DKarte mit St�dte.bmp');

     SetLength(KoSy,1900,2600);
     for i := Low(KoSy) to High(KoSy) do
        for k := Low(KoSy[i]) to High(KoSy[i]) do
           KoSy[i,k] := false;
     KoSy[888,524] := true;

     for i := Low(KoSy) to High(KoSy) do
        for k := Low(KoSy[i]) to High(KoSy[i]) do
           if KoSy[i,k] = true then
           begin
                Ort := Point(i,k);
                break;
           end;

     Canvas.MoveTo(Ort.x,Ort.y);
end;

procedure TImageOrten.MouseUp(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
var
Entfernung:real;
dif_x, dif_y : integer;
dif_hoch:real;
begin
     dif_hoch := (2600 / Height);

     X := round(dif_hoch * X);
     Y := round(dif_hoch * Y);

     Canvas.Pen.Width := 8;
     Canvas.Pen.Color := clRed;
     Canvas.LineTo(X,Y);

     dif_x := X - Ort.x;
     dif_y := Y - Ort.y;

     Entfernung := sqrt( (dif_x * dif_x) + (dif_y * dif_y));

     Entfernung := Entfernung * ( 613 / 1791 );

     Canvas.Font.Size := 60;
     Canvas.Font.Name := 'Arial';
     Canvas.Brush.Style := bsClear;
     Canvas.TextOut(x,Y,FloatToStr(Round(Entfernung))+' km');
end;

procedure Register;
begin
  RegisterComponents('�bung', [TImageOrten]);
end;

end.
