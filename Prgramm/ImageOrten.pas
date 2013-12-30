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
    Orte_Datei : file of TOrte;
  protected
    { Protected-Deklarationen }
    procedure MouseUp(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
  public
    { Public-Deklarationen }
    ROrte : TOrte;
    geklickt:boolean;
    Punkte : integer;
    Entfernung : integer;
    constructor Create(AOwner:TComponent); override;
    function SatzLadenAnzeigen(index:integer) : string;
  published
    { Published-Deklarationen }
  end;

procedure Register;

implementation

uses karte;

var
KoSy: array of array of boolean;                     //Dynamisches zweidimensionales Array welches jedes Pixel auf der Komponente/auf dem Bild darstellt
Ort:TPoint;

constructor TImageOrten.Create(AOwner:TComponent);
begin
     inherited Create(AOwner);

     Height := (Screen.Height*14) div 15;          // Die Komponente platziert sich auf dem Formular.
     Width := (Height*19) div 26;
     Top := Screen.Height div 30;
     Left := Screen.Width - Width - Top;
     Cursor := crCross;                            // Ein Zielkreuz wird als Cursor eingestellt.
     Stretch := true;
     geklickt := false;
end;

function TImageOrten.SatzLadenAnzeigen(index:integer): string;
var i,k:integer;
begin
     SetLength(KoSy,1900,2600);                     // Die Längen des Array werden gesetzt
     for i := Low(KoSy) to High(KoSy) do            // und alle Speicherplätze mit false belegt
        for k := Low(KoSy[i]) to High(KoSy[i]) do
           KoSy[i,k] := false;

     AssignFile(Orte_Datei,ExtractFilePath(ParamStr(0)) + 'Ortskoordinaten/Orte_KoSy.dat');  // Die Datei, in der die Ortskoordinaten hinterlegt sind,
     aktueller_record := index-1;                                                            // wird geöffnet (innerhalb dieser Prozedur wird die Datei auch wieder geschlossen
     if FileExists(ExtractFilePath(ParamStr(0)) + 'Ortskoordinaten/Orte_KoSy.dat') then      //                damit durch kurze Öffnungzeiten, keine Blockierung der Datei
     begin                                                                                   //                zustande kommt! So können mehrer Programme "gleichzeitig" draufzugreifen
          Reset(Orte_Datei);
     end else exit;

     Seek(Orte_Datei,aktueller_record);                                                      // Der Zeiger wird vor den zu Öffnenden Datensatz gesetzt (s.L 69)
     if FileSize(Orte_Datei) > 0 then
     begin
          Read(Orte_Datei,ROrte);
          with ROrte do
          begin                                                                              // Diese Koordinate wird im KoSy auf true gesetzt
               KoSy[KoSy_x,KoSy_y] := true;

               for i := Low(KoSy) to High(KoSy) do
                  for k := Low(KoSy[i]) to High(KoSy[i]) do
                     if KoSy[i,k] = true then
                     begin
                          Ort := Point(i,k);                                                // Die Koordinaten werden in der globalen Variable Ort gespeichert
                          break;
                     end;                                                                    
               Canvas.MoveTo(Ort.x,Ort.y);                                                   // Diese Koordinate wird Canvas.MoveTo zugeordnet
               result := Ortsname;
          end;
     end;
     CloseFile(Orte_Datei);                                                                  // die Datei wird wieder geschlossen
end;

procedure TImageOrten.MouseUp(Button: TMouseButton;                                          //MouseUp
      Shift: TShiftState; X, Y: Integer);
var
dif_x, dif_y : real;
dif_hoch:real;
a,b : integer;
EntfernungTemp:real;
begin
     if geklickt = false then
     begin

     dif_hoch := (2600 / Height);     // Verhältniss zwischen der Bildgröße und der tatsächlichen Auflösung, die vom Bildschrimformat abhängt

     X := round(dif_hoch * X);        // x und y werden nach diesem Verhältnis neu berechnet
     Y := round(dif_hoch * Y);

     Canvas.Pen.Width := 8;
     Canvas.Pen.Color := clRed;
     Canvas.LineTo(X,Y);              // eine Linie wird vom Ort zum gedrückten Maus gezogen

     dif_x := X - Ort.x;              // die Differenz der x und y koordinaten
     dif_y := Y - Ort.y;

     EntfernungTemp := sqrt( (dif_x * dif_x) + (dif_y * dif_y));  // Die Pixelentfernung wird mit dem Satz des Phytagoras errechnet

     Entfernung := round(EntfernungTemp * ( 613 / 1791 ));        // Der Bildspezifische Maßstab wird in die Entfernung mit einbezogen

     if Entfernung < 100 then b := 2 else b := 1;                 // Punktevergabe...
     if Entfernung < 50  then b := 3;
     if Entfernung < 5   then b := 4;

     if ROrte.Schwierigkeit = 'schwer' then a := 3;               // In der Datei sind neben den Ortsnamen und den Koordinaten auch die schwierigkeiten hinterlegt
     if ROrte.Schwierigkeit = 'mittel' then a := 2;
     if ROrte.Schwierigkeit = 'leicht' then a := 1;
     Punkte := round(a*b*(100/Entfernung));  //

     Canvas.Brush.Style := bsClear;
     Canvas.Pen.Width := 6;
     Canvas.Pen.Color := clGreen;
     Canvas.Ellipse(Ort.x-29,Ort.y-29,Ort.x+29,Ort.y+29);   // 10 km Radius     Hilfszeichnungen
     Canvas.Pen.Color := clYellow;
     Canvas.Ellipse(Ort.x-146,Ort.y-146,Ort.x+146,Ort.y+146); // 50 km Radius
     Canvas.Pen.Color := clRed;
     Canvas.Ellipse(Ort.x-292,Ort.y-292,Ort.x+292,Ort.y+292); // 100 km Radius

     geklickt := true;
     end;
end;

procedure Register;
begin
  RegisterComponents('Übung', [TImageOrten]);
end;

end.
