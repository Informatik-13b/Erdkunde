unit ImageOrten;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, Math;

type
  TOrte = record
     Index : integer;
     Ortsname : string[20];
     Schwierigkeit : string[10];
     KoSy_x, KoSy_y : integer;
  end;
  TImageOrten = class(TImage)
  private
    { Private-Deklarationen }
    aktueller_record : integer;
    ROrte : TOrte;
    Orte_Datei : file of TOrte;
  protected
    { Protected-Deklarationen }
    procedure MouseUp(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
      procedure TextOutAngle(const Canvas: TCanvas; X, Y: Integer;
                             const AText: string; AAngle: Integer);
  public
    { Public-Deklarationen }
    constructor Create(AOwner:TComponent); override;
    function SatzLadenAnzeigen(index:integer) : string;
  published
    { Published-Deklarationen }
  end;

procedure Register;

implementation

var

KoSy: array of array of boolean;
Ort:TPoint;

constructor TImageOrten.Create(AOwner:TComponent);
begin
     inherited Create(AOwner);

     Height := (Screen.Height*14) div 15;
     Width := (Height*19) div 26;
     Top := Screen.Height div 30;
     Left := Screen.Width - Width - Top; //(Screen.Width div 3) - (Width div 2);
     Cursor := crCross;
     Stretch := true;
     Picture.LoadFromFile('Bilder/DKarte ohne Städte.bmp');
end;

function TImageOrten.SatzLadenAnzeigen(index:integer): string;
var i,k:integer;
begin
     SetLength(KoSy,1900,2600);
     for i := Low(KoSy) to High(KoSy) do
        for k := Low(KoSy[i]) to High(KoSy[i]) do
           KoSy[i,k] := false;

     AssignFile(Orte_Datei,'Ortskoordinaten/Orte_KoSy.dat');
     aktueller_record := index-1;
     if FileExists('Ortskoordinaten/Orte_KoSy.dat') then
     begin
          Reset(Orte_Datei);
     end else exit;

     Seek(Orte_Datei,aktueller_record);
     if FileSize(Orte_Datei) > 0 then
     begin
          Read(Orte_Datei,ROrte);
          with ROrte do
          begin
               KoSy[KoSy_x,KoSy_y] := true;

               for i := Low(KoSy) to High(KoSy) do
                  for k := Low(KoSy[i]) to High(KoSy[i]) do
                     if KoSy[i,k] = true then
                     begin
                          Ort := Point(i,k);
                          break;
                     end;
               Canvas.MoveTo(Ort.x,Ort.y);
               result := Ortsname + ', ' + Schwierigkeit;
          end;
     end;
     CloseFile(Orte_Datei);
end;

procedure TImageOrten.MouseUp(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
var
Entfernung:real;
dif_x, dif_y : real;
dif_hoch:real;
Winkel : real;
Text_x,Text_y : real;
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

     if dif_x = 0 then dif_x := 1;

     Winkel:= 10 * RadToDeg(ArcTan( dif_y / dif_x ));
                                                {1.Quadrant}
     if x < 0 then Winkel:=180+Winkel else
     begin	                                {2. bzw. 3.Quadrant}
          if y < 0 then Winkel:=360+Winkel;	{4.Quadrant}
     end;

     Text_x := X-(dif_x / 2)-(Canvas.TextWidth(FloatToStr(Round(Entfernung))+' km') / 2);
     Text_y := Y-(dif_y / 2)-(Canvas.TextHeight(FloatToStr(Round(Entfernung))+' km'));

     TextOutAngle(self.Canvas,
                  round(Text_x),round(Text_y),
                  FloatToStr(Round(Entfernung))+' km',
                  3600 - round(Winkel));

     Canvas.Pen.Width := 6;
     Canvas.Pen.Color := clGreen;
     Canvas.Ellipse(Ort.x-29,Ort.y-29,Ort.x+29,Ort.y+29);
     Canvas.Pen.Color := clYellow;
     Canvas.Ellipse(Ort.x-146,Ort.y-146,Ort.x+146,Ort.y+146);
     Canvas.Pen.Color := clRed;
     Canvas.Ellipse(Ort.x-292,Ort.y-292,Ort.x+292,Ort.y+292);
end;

procedure TImageOrten.TextOutAngle(const Canvas: TCanvas; X, Y: Integer;
                                  const AText: string; AAngle: Integer);
var
   hCurFont: HFONT;
   LogFont: TLogFont;
begin
   with Canvas do
   begin
     hCurFont := Font.Handle;
     try
       GetObject(Font.Handle, SizeOf(LogFont), @LogFont);
       LogFont.lfEscapement := AAngle;
       LogFont.lfOrientation := AAngle;
   
       Font.Handle := CreateFontIndirect(LogFont);
       try
         TextOut(X, Y, AText);
       finally
         DeleteObject(Font.Handle);        
       end;
     finally
       Font.Handle := hCurFont;
     end;
   end;
end;

procedure Register;
begin
  RegisterComponents('Übung', [TImageOrten]);
end;

end.
