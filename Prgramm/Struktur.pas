unit Struktur;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Math, jpeg, ImageButton;

type
  TMenue = class(TForm)
    MenueEffekt: TTimer;
    ImageScreen: TImage;
    Zoomen: TTimer;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MenuePosition(Radius:integer);
    function Kreisposition_x(Objektnummer:integer;Objektanzahl:integer;
             Zentrum:TPoint;Radius:real): integer;
    function Kreisposition_y(Objektnummer:integer;Objektanzahl:integer;
             Zentrum:TPoint;Radius:real): integer;
    procedure MenueEffektTimer(Sender: TObject);
    procedure Startansicht();
    procedure ZoomenTimer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Menue: TMenue;
  Themenfarbe1: TColor;
  Themenfarbe2: TColor;
  MenuePos:integer = 1;
  ScreenMitte:TPoint;

  MenueObjekt : array[1..10] of TImageBUtton;

implementation

{$R *.DFM}

procedure TMenue.FormPaint(Sender: TObject);
begin
     Menue.Color := Themenfarbe1;
     Menue.Startansicht;
end;

procedure TMenue.FormCreate(Sender: TObject);
var i : integer;
begin
     Themenfarbe1 := RGB(244,164,96);         //Themenfarben können sich durchs ganze
     Themenfarbe2 := RGB(205,133,63);         //Programm ziehen... (sind noch nicht beschlossen)
     Self.DoubleBuffered := true;
     ScreenMitte := Point(Screen.Width div 2,Screen.Height div 2);    // Mitte des Screen wird ermittelt

     for i := 1 to 5 do
     begin                                                            // Die Menüobjekte werden vom Typ
          MenueObjekt[i]:= TImageButton.Create(self);                 // ImageButton erstellt
          MenueObjekt[i].Parent := self;
          MenueObjekt[i].Themenfarbe1 := Themenfarbe1;                // und es wird ihnen die aktuellen Themenfarbe
          MenueObjekt[i].Themenfarbe2 := Themenfarbe2;                // übermittelt.
     end;
     MenueObjekt[1].BildLaden('Bilder/Karten-Menüpunkt.gif');         // Jedes Menüobjekt lädt sein bestimmtes Bild
     MenueObjekt[2].BildLaden('Bilder/Lexikon-Menüpunkt.gif');        // im gif-Format
     MenueObjekt[3].BildLaden('Bilder/Profil-Menüpunkt.gif');
     MenueObjekt[4].BildLaden('Bilder/Spiel-Menüpunkt.gif');
     MenueObjekt[5].BildLaden('Bilder/Titel.gif');
end;

procedure TMenue.Startansicht();
 var Startscreen: TBitmap;
     i: Integer;
  begin
    ImageScreen.Left := 0;
    ImageScreen.Top := 0;
    ImageScreen.Width := Menue.Width;
    ImageScreen.Height := Menue.Height;
    Startscreen := TBitmap.Create;
     Try
        Startscreen.LoadFromFile('Testbild.bmp');
        ImageScreen.Picture.Bitmap.Assign(Startscreen);
      Finally
         Startscreen.Free;
      end;
      ImageScreen.Visible := False;
      //Sleep(1000);
   {  For i := 1 to 500 do begin
     
       If i = 500 then
       begin
          MenueEffekt.Enabled := True;
          ImageScreen.Visible := False;
      end;
      end;   }
  end;


procedure TMenue.MenueEffektTimer(Sender: TObject);
begin
     Inc(MenuePos,3);                 // Timer lässt das Menue aus der Bildschirmmitte erscheinen
     MenuePosition(MenuePos);
     If MenuePos >= Screen.Height div 3 then MenueEffekt.Enabled := False;
end;

procedure TMenue.MenuePosition(Radius:integer);
var i : integer;
    x,y : integer;
    Radius_x,Radius_y : real;
    Buttonbreite : integer;
    Anzahl:integer;
begin
     ButtonBreite := (3*Radius)div 4;                       // Buttonbreite wird in Abhängigkeit der Bildschrimgröße bestimmt
     for i := 1 to 5 do
     begin
          MenueObjekt[i].Width := ButtonBreite;
          MenueObjekt[i].Height:= ButtonBreite;
     end;
                                                                      // im Folgenden werden die Menüpunkte im Kreis(Ellipse) angeordnet:
     Radius_x := Radius*(Screen.Width / Screen.Height);               // Radius in x-Richtung
     Radius_y := Radius;                                              // Radius in y-Richtung
     Anzahl := 5;
     for i := 1 to Anzahl do
     begin
          x := Kreisposition_x(i,Anzahl,ScreenMitte,Radius_x);        // x- und y-Koordinate für das i-te Objekt wird ermittelt
          y := Kreisposition_y(i,Anzahl,ScreenMitte,Radius_y);        // dabei werden oben bestimmte Parameter übergeben

          MenueObjekt[i].Left := x - ButtonBreite div 2;              // jeder Komponente wird ihre Position übergeben.
          MenueObjekt[i].Top  := y - ButtonBreite div 2;
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
     l := round(15*((Screen.Height / 3)) / 16);      // (zoom Größe)
     for i := 1 to 4 do  // 1-4: Titel wird nicht gezoomt!!!
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
var dif,i:integer;
begin
     if Y < 20 then                              // Wenn sich die Maus im oberen Bildschirmbereich
     begin
          Cursor := crHandpoint;                 // befindet, bekommt sie ein Handsymbol und
          Canvas.Brush.Color := Themenfarbe2;
          Canvas.Pen.Color   := Themenfarbe2;    // mit Canvas wird der obere Bildschirmbereich
          Canvas.Rectangle(0,0,ClientWidth,20);  // in der 2. Themenfarbe gefärbt.
     end else
     begin                                       // andererseits wird,
          if Cursor = crHandpoint then           // nur wenn es nicht schon der Fall ist,
          begin
               Cursor := crDefault;              // der Maus der Normale Zeiger zugeordnet
               refresh;                          // und der andersfarbige Bereich wieder gelöscht.
          end;
     end;

     if Menue.Align = alNone then             // Wenn das Menü-Fenster im verschiebbaren Modus ist,
     begin
          dif := Mouse.CursorPos.y -Y;
          Menue.Top := Y+dif;                 // verschiebt sich das Fenster mit der Maus in y-Richtung.
     end;

     if Menue.Top > (Screen.Height div 6) * 5 then close;  // Sicherheitsschließen

     for i := 1 to 4 do
     begin
          If MenueObjekt[i].Zoom = true          // Sicherheitsverkleinern: Wenn die Maus wieder auf der Form ist
          then MenueObjekt[i].Zoom := false;     // und das Menüobjekt noch nicht am Verkleinrn ist.
     end;
end;


procedure TMenue.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     if Button = mbleft then                 // Wenn die linke Maustaste gedrückt wird
     begin
          if Cursor = crHandpoint then       // und sich die Maus im oberen Bildschirmberech befindet (s.o.),
          begin                              // wird aus dem Vollbild "Normalbild" (ist aber nicht sichtbar,
               Menue.Align := alNone;        // da dich Höhe und Breite des Fenstern NICHT ändert!
          end;                               // Dies muss aber geschehen, damit man das Fenster im
     end;                                    // nächsten Schritt verschieben kann.
end;

procedure TMenue.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i: byte;
begin
     if (Button = mbleft) and (Cursor = crHandpoint) then// linke Taste wird gelöst:
     begin
          if Menue.Top > Screen.Height div 2 then        // Wenn das Fenster bis unter die Hälfte
          begin                                          // der Bildschirmhöhe gezogen wurde,
               for i := Y to Screen.Height - 100 do      // wird das Menü bis zum Verschwinden
               begin
                    Menue.Top := Menue.Top + i;          // weiter nach unten verschoben
                    sleep(10);                           // (nicht sofort, sondern "langsam")
               end;
               close;                                    // und schließlich geschlossen.
          end else                                       // Wird das Fenster nicht genügend weit
          begin                                          // herunter gezogen,
               {for i := Mouse.CursorPos.y downto 0 do
               begin
                    Menue.Top := i;                      // gelangt das Fenster wieder "langsam" in
                    //sleep(1);                            // die Ausgangsposition und zum Schluss wieder
               end;  }
               Menue.Align := alClient;                  // in den unverschiebbaren Vollbildmodus
          end;
     end;
end;



end.
