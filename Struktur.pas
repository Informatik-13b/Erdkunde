unit Struktur;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Math, jpeg;

type
  TMenue = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    function Kreisposition_x(Objektnummer:integer;Objektanzahl:integer;
             Zentrum:TPoint;Radius:integer): integer;
    function Kreisposition_y(Objektnummer:integer;Objektanzahl:integer;
             Zentrum:TPoint;Radius:integer): integer;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Menue: TMenue;
  Themenfarbe1: TColor;
  Themenfarbe2: TColor;

implementation

{$R *.DFM}

procedure TMenue.FormPaint(Sender: TObject);
var i : integer;
    x,y : integer;
    ScreenMitte: TPoint;
    Anzahl:integer;
    Radius_x,Radius_y : integer;
    Buttonbreite : integer;
begin
     Menue.Color := Themenfarbe1;

     ButtonBreite := Screen.Width div 6;                    // Buttonbreite wird in Abhängigkeit der
     Image1.Width := ButtonBreite;                          // Bildschrimgröße bestimmt
     Image1.Height := ButtonBreite;
     Image2.Width := ButtonBreite;                          // provisorisch habe ich Images als Platzhalter
     Image2.Height := ButtonBreite;                         // für die späteren Butten genommen...
     Image3.Width := ButtonBreite;                          // sie könnten Bilder enthälten, Zeichen, nur Text
     Image3.Height := ButtonBreite;                         // Form steht auch nicht fest...
     Image4.Width := ButtonBreite;                          // Das Alles wird sich alles im Laufe der
     Image4.Height := ButtonBreite;                         // Programmentwicklung noch ergeben.
     Image5.Width := ButtonBreite;
     Image5.Height := ButtonBreite;
                                                                      // im Folgenden werden die Menüpunkte im Kreis(Ellipse) angeordnet:
     ScreenMitte := Point(Screen.Width div 2,Screen.Height div 2);    // Mitte des Screen wird ermittelt
     Anzahl := 5;                                                     // Anzahl der Menüobjekte
     Radius_x := Screen.Width div 3;                                  // Radius in x-Richtung
     Radius_y := Screen.Height div 3;                                 // Radius in y-Richtung
     for i := 1 to Anzahl do
     begin
          x := Kreisposition_x(i,Anzahl,ScreenMitte,Radius_x);        // x- und y-Koordinate für das i-te Objekt wird ermittelt
          y := Kreisposition_y(i,Anzahl,ScreenMitte,Radius_y);        // dabei werden oben bestimmte Parameter übergeben
          case i of
          1: begin
                  Image1.Left := x - ButtonBreite div 2;              // den Menüobjekten werden ihre Koordinaten zugeordnet
                  Image1.Top  := y - ButtonBreite div 2;
             end;
          2: begin
                  Image2.Left := x - ButtonBreite div 2;
                  Image2.Top  := y - ButtonBreite div 2;
             end;
          3: begin
                  Image3.Left := x - ButtonBreite div 2;
                  Image3.Top  := y - ButtonBreite div 2;
             end;
          4: begin
                  Image4.Left := x - ButtonBreite div 2;
                  Image4.Top  := y - ButtonBreite div 2;
             end;
          5: begin
                  Image5.Left := x - ButtonBreite div 2;
                  Image5.Top  := y - ButtonBreite div 2;
             end;
          end;
     end;
end;

function TMenue.Kreisposition_x(Objektnummer:integer;Objektanzahl:integer;Zentrum:TPoint;
         Radius:integer) : integer;                            // Parameterübergabe
var
   RadWinkel  : real;
   x          : integer;
begin
     RadWinkel := Objektnummer*((2*pi)/Objektanzahl);          // Winkel des aktuellen Objektes wird errechnet
     x := round(Zentrum.x + cos(RadWinkel+(pi/2))*Radius);     // daraus wird die x-Koordinate des Objektes ermittelt
     result := x;
end;

function TMenue.Kreisposition_y(Objektnummer:integer;Objektanzahl:integer;Zentrum:TPoint;
         Radius:integer) : integer;                            // Parameterübergabe
var
   RadWinkel  : real;
   y          : integer;
begin
     RadWinkel := Objektnummer*((2*pi)/Objektanzahl);          // Winkel des aktuellen Objektes wird errechnet
     y := round(Zentrum.y - sin(RadWinkel+(pi/2))*Radius);     // daraus wird die y-Koordinate des Objektes ermittelt
     result := y;
end;

procedure TMenue.FormCreate(Sender: TObject);
begin
     Themenfarbe1 := RGB(244,164,96);         //Themenfarben können sich durchs ganze
     Themenfarbe2 := RGB(205,133,63);         //Programm ziehen... (sind noch nicht beschlossen)
     self.DoubleBuffered := true;
end;


procedure TMenue.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var dif:integer;
begin
     if Y < 10 then                              // Wenn sich die Maus im oberen Bildschirmbereich
     begin
          Cursor := crHandpoint;                 // befindet, bekommt sie ein Handsymbol und
          Canvas.Brush.Color := Themenfarbe2;
          Canvas.Pen.Color   := Themenfarbe2;    // mit Canvas wird der obere Bildschirmbereich
          Canvas.Rectangle(0,0,ClientWidth,10);  // in der 2. Themenfarbe gefärbt.
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
