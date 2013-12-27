unit Struktur;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Math, jpeg, ImageButton, ShapeSchliessen;

type
  TMenue = class(TForm)
    MenueEffekt: TTimer;
    Zoomen: TTimer;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MenuePosition(Radius:integer);
    function Kreisposition_x(Objektnummer:integer;Objektanzahl:integer;
             Zentrum:TPoint;Radius:real): integer;
    function Kreisposition_y(Objektnummer:integer;Objektanzahl:integer;
             Zentrum:TPoint;Radius:real): integer;
    procedure MenueEffektTimer(Sender: TObject);
    procedure ZoomenTimer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    Themenfarbe1: TColor;
    Themenfarbe2: TColor;
    procedure FensterOeffnen(Button:integer);
  end;



var
  Menue: TMenue;
  MenuePos:integer = 1;
  ScreenMitte:TPoint;
  ScreenZaehler: Integer;
  MenueObjekt : array[1..6] of TImageButton;
  SchliessenShape : TShapeSchliessen;

implementation

uses Karte,Lexikon;

{$R *.DFM}

procedure TMenue.FormPaint(Sender: TObject);
begin
     Menue.Color := Themenfarbe1;
end;

procedure TMenue.FormCreate(Sender: TObject);
var i : integer;
  begin
     Themenfarbe1 := RGB(244,164,96);         //Themenfarben können sich durchs ganze
     Themenfarbe2 := RGB(205,133,63);         //Programm ziehen... (sind noch nicht beschlossen)
     Self.DoubleBuffered := True;
     ScreenMitte := Point(Screen.Width div 2,Screen.Height div 2);    // Mitte des Screen wird ermittelt

     for i := 1 to 5 do
     begin                                                            // Die Menüobjekte werden vom Typ
          MenueObjekt[i]:= TImageButton.Create(self);                 // ImageButton erstellt
          MenueObjekt[i].Parent := self;
          MenueObjekt[i].Themenfarbe1 := Themenfarbe1;                // und es wird ihnen die aktuellen Themenfarbe
          MenueObjekt[i].Themenfarbe2 := Themenfarbe2;                // übermittelt.
          MenueObjekt[i].Button := i;
          MenueObjekt[i].Enabled := false;
     end;
     MenueObjekt[1].BildLaden('Bilder/Karten-Menüpunkt.gif');         // Jedes Menüobjekt lädt sein bestimmtes Bild
     MenueObjekt[2].BildLaden('Bilder/Lexikon-Menüpunkt.gif');        // im gif-Format
     MenueObjekt[3].BildLaden('Bilder/Profil-Menüpunkt.gif');
     MenueObjekt[4].BildLaden('Bilder/Spiel-Menüpunkt.gif');
     MenueObjekt[5].BildLaden('Bilder/Titel.gif');
     MenueObjekt[5].Titel := true;

     SchliessenShape := TShapeSchliessen.Create(self);    // Erstellen des Schließen-Komponente
     SchliessenShape.Parent := self;
     SchliessenShape.Themenfarbe1 := Themenfarbe1;        // die Themenfarben werden übergeben
     SchliessenShape.Themenfarbe2 := Themenfarbe2;
     SchliessenShape.Fenster := Menue;           // Wichtig! Das Fenster wird übergeben, damit die Komponente weiß
                                                 // welches Fenster geschlossen werden soll.
end;


procedure TMenue.MenueEffektTimer(Sender: TObject);
begin
     Inc(MenuePos,3);                 // Timer lässt das Menue aus der Bildschirmmitte erscheinen
     MenuePosition(MenuePos);
     If MenuePos >= Screen.Height div 3 then
     begin
          MenueEffekt.Enabled := False;
          MenueObjekt[1].Enabled := true;
          MenueObjekt[2].Enabled := true;
          MenueObjekt[3].Enabled := true;
          MenueObjekt[4].Enabled := true;
     end;
end;

procedure TMenue.MenuePosition(Radius:integer);
var i : integer;
    x,y : integer;
    Radius_x,Radius_y : real;
    Buttonbreite : integer;
    Anzahl:integer;
begin
     ButtonBreite := (3*Radius)div 4;                       // Buttonbreite wird in Abhängigkeit der Bildschrimgröße bestimmt
     for i := 1 to 4 do
     begin
          MenueObjekt[i].Width := ButtonBreite;
          MenueObjekt[i].Height:= ButtonBreite;
     end;

     MenueObjekt[5].Width := (ButtonBreite*5) div 2;
     MenueObjekt[5].Height:= ButtonBreite;
                                                                      // im Folgenden werden die Menüpunkte im Kreis(Ellipse) angeordnet:
     Radius_x := Radius*(Screen.Width / Screen.Height);               // Radius in x-Richtung
     Radius_y := Radius;                                              // Radius in y-Richtung
     Anzahl := 5;
     for i := 1 to 5 do
     begin
          x := Kreisposition_x(i,Anzahl,ScreenMitte,Radius_x);        // x- und y-Koordinate für das i-te Objekt wird ermittelt
          y := Kreisposition_y(i,Anzahl,ScreenMitte,Radius_y);        // dabei werden oben bestimmte Parameter übergeben

          if i <> 5 then
          begin
               MenueObjekt[i].Left := x - ButtonBreite div 2;         // jeder Komponente wird ihre Position übergeben.
               MenueObjekt[i].Top  := y - ButtonBreite div 2;
          end else
          begin
               MenueObjekt[i].Left := x - ((ButtonBreite*5) div 2) div 2;         // jeder Komponente wird ihre Position übergeben.
               MenueObjekt[i].Top  := y - ButtonBreite div 2;
          end;
     end;
end;

function TMenue.Kreisposition_x(Objektnummer:integer;Objektanzahl:integer;Zentrum:TPoint;
         Radius:real) : integer;                            // Parameterübergabe
var
   RadWinkel  : real;
   x          : integer;
begin
     RadWinkel := Objektnummer*((2*pi)/Objektanzahl);          // Winkel des aktuellen Objektes wird errechnet
     x := round(Zentrum.x + cos(RadWinkel+(pi/2))*Radius);     // daraus wird die x-Koordinate des Objektes ermittelt
     result := x;
end;

function TMenue.Kreisposition_y(Objektnummer:integer;Objektanzahl:integer;Zentrum:TPoint;
         Radius:real) : integer;                            // Parameterübergabe
var
   RadWinkel  : real;
   y          : integer;
begin
     RadWinkel := Objektnummer*((2*pi)/Objektanzahl);          // Winkel des aktuellen Objektes wird errechnet
     y := round(Zentrum.y - sin(RadWinkel+(pi/2))*Radius);     // daraus wird die y-Koordinate des Objektes ermittelt
     result := y;
end;

procedure TMenue.ZoomenTimer(Sender: TObject);       // Ein permanenter Timer...
var i,k,l :integer;
begin
     k := round(3*((Screen.Height / 3)) / 4);        // (normale Größe)
     l := round(15*((Screen.Height / 3)) / 18);      // (zoom Größe)
     for i := 1 to 4 do                       // 1-4: Titel wird nicht gezoomt!!!
     begin
          if (MenueObjekt[i].Zoom = true) and         // prüft ob, ein Menüobjekt im Zoom-Modus ist
             (MenueObjekt[i].Height < l) then         // und kleiner als die Zoom-End-Größe ist
          begin
               MenueObjekt[i].Vergroessern;           // und lässt sie sich vergrößern,
          end;
          if (MenueObjekt[i].Zoom = false) and        // oder wenn es nicht der Fall ist und das Menüobjekt
             (MenueObjekt[i].Height > k) then         // auch nicht seine normale Größe besitzt
          begin
               MenueObjekt[i].Verkleinern;            // schrumpft das Objekt wieder.
          end;
     end;
end;



procedure TMenue.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var i : byte;
begin
     if SchliessenShape.inaktiv = false then    // Wenn das Shape zum Schließen noch
     begin                                      // aktiv ist,
          SchliessenShape.inaktiv := true;      // wird sein Status auf inaktiv gesetzt
          SchliessenShape.Repaint;              // und es zeichnet sich neu.
     end;

     for i := 1 to 4 do
     begin
          If MenueObjekt[i].Zoom = true          // Sicherheitsverkleinern: Wenn die Maus wieder auf der Form ist
          then MenueObjekt[i].Zoom := false;     // und das Menüobjekt noch nicht am Verkleinrn ist.
     end;
end;


procedure TMenue.FensterOeffnen(Button:integer);
begin
     case Button of
     2: begin
             Application.CreateForm(TFLexikon, FLexikon);
             FLexikon.BringToFront;
             FLexikon.ShowModal
        end;
     4: begin
             Application.CreateForm(TOrte_Finden, Orte_Finden);
             Orte_Finden.BringToFront;
             Orte_Finden.ShowModal
        end;
     end;
end;



end.
