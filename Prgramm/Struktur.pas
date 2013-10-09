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
    MenueEffekt: TTimer;
    Image5: TImage;
    Image6: TImage;
    Image7: TImage;
    ImageScreen: TImage;
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

implementation

{$R *.DFM}

procedure TMenue.FormPaint(Sender: TObject);
begin
     Menue.Color := Themenfarbe1;
     Menue.Startansicht;
end;

procedure TMenue.FormCreate(Sender: TObject);
begin
     Themenfarbe1 := RGB(244,164,96);         //Themenfarben k�nnen sich durchs ganze
     Themenfarbe2 := RGB(205,133,63);         //Programm ziehen... (sind noch nicht beschlossen)
     Self.DoubleBuffered := true;
     ScreenMitte := Point(Screen.Width div 2,Screen.Height div 2);    // Mitte des Screen wird ermittelt
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
        Startscreen.LoadFromFile('C:\Users\Steffen\Documents\GitHub\Erdkunde\Testbild.bmp');
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
     Inc(MenuePos,3);                 // Timer l�sst das Menue aus der Bildschirmmitte erscheinen
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
     ButtonBreite := (3*Radius)div 4;                       // Buttonbreite wird in Abh�ngigkeit der
     Image1.Width := ButtonBreite;                          // Bildschrimgr��e bestimmt
     Image1.Height := ButtonBreite;
     Image2.Width := ButtonBreite;                          // provisorisch habe ich Images als Platzhalter
     Image2.Height := ButtonBreite;                         // f�r die sp�teren Butten genommen...
     Image3.Width := ButtonBreite;                          // sie k�nnten Bilder enth�lten, Zeichen, nur Text
     Image3.Height := ButtonBreite;                         // Form steht auch nicht fest...
     Image4.Width := ButtonBreite;                          // Das Alles wird sich alles im Laufe der
     Image4.Height := ButtonBreite;                         // Programmentwicklung noch ergeben.
     Image5.Width := ButtonBreite;
     Image5.Height := ButtonBreite;
     Image6.Width := ButtonBreite;
     Image6.Height := ButtonBreite;
     Image7.Width := ButtonBreite;
     Image7.Height := ButtonBreite;
                                                                      // im Folgenden werden die Men�punkte im Kreis(Ellipse) angeordnet:
     Radius_x := Radius*(Screen.Width / Screen.Height);               // Radius in x-Richtung
     Radius_y := Radius;                                              // Radius in y-Richtung
     Anzahl := 7;
     for i := 1 to Anzahl do
     begin
          x := Kreisposition_x(i,Anzahl,ScreenMitte,Radius_x);        // x- und y-Koordinate f�r das i-te Objekt wird ermittelt
          y := Kreisposition_y(i,Anzahl,ScreenMitte,Radius_y);        // dabei werden oben bestimmte Parameter �bergeben
          case i of
          1: begin
                  Image1.Left := x - ButtonBreite div 2;              // den Men�objekten werden ihre Koordinaten zugeordnet
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
          6: begin
                  Image6.Left := x - ButtonBreite div 2;
                  Image6.Top  := y - ButtonBreite div 2;
             end;
          7: begin
                  Image7.Left := x - ButtonBreite div 2;
                  Image7.Top  := y - ButtonBreite div 2;
             end;
          end;
     end;
end;

function TMenue.Kreisposition_x(Objektnummer:integer;Objektanzahl:integer;Zentrum:TPoint;
         Radius:real) : integer;                            // Parameter�bergabe
var
   RadWinkel  : real;
   x          : integer;
begin
     RadWinkel := Objektnummer*((2*pi)/Objektanzahl);          // Winkel des aktuellen Objektes wird errechnet
     x := round(Zentrum.x + cos(RadWinkel+(pi/2))*Radius);     // daraus wird die x-Koordinate des Objektes ermittelt
     result := x;
end;

function TMenue.Kreisposition_y(Objektnummer:integer;Objektanzahl:integer;Zentrum:TPoint;
         Radius:real) : integer;                            // Parameter�bergabe
var
   RadWinkel  : real;
   y          : integer;
begin
     RadWinkel := Objektnummer*((2*pi)/Objektanzahl);          // Winkel des aktuellen Objektes wird errechnet
     y := round(Zentrum.y - sin(RadWinkel+(pi/2))*Radius);     // daraus wird die y-Koordinate des Objektes ermittelt
     result := y;
end;





procedure TMenue.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var dif:integer;
begin
     if Y < 20 then                              // Wenn sich die Maus im oberen Bildschirmbereich
     begin
          Cursor := crHandpoint;                 // befindet, bekommt sie ein Handsymbol und
          Canvas.Brush.Color := Themenfarbe2;
          Canvas.Pen.Color   := Themenfarbe2;    // mit Canvas wird der obere Bildschirmbereich
          Canvas.Rectangle(0,0,ClientWidth,20);  // in der 2. Themenfarbe gef�rbt.
     end else
     begin                                       // andererseits wird,
          if Cursor = crHandpoint then           // nur wenn es nicht schon der Fall ist,
          begin
               Cursor := crDefault;              // der Maus der Normale Zeiger zugeordnet
               refresh;                          // und der andersfarbige Bereich wieder gel�scht.
          end;
     end;

     if Menue.Align = alNone then             // Wenn das Men�-Fenster im verschiebbaren Modus ist,
     begin
          dif := Mouse.CursorPos.y -Y;        
          Menue.Top := Y+dif;                 // verschiebt sich das Fenster mit der Maus in y-Richtung.
     end;

     if Menue.Top > (Screen.Height div 6) * 5 then close;  // Sicherheitsschlie�en
end;


procedure TMenue.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     if Button = mbleft then                 // Wenn die linke Maustaste gedr�ckt wird
     begin
          if Cursor = crHandpoint then       // und sich die Maus im oberen Bildschirmberech befindet (s.o.),
          begin                              // wird aus dem Vollbild "Normalbild" (ist aber nicht sichtbar,
               Menue.Align := alNone;        // da dich H�he und Breite des Fenstern NICHT �ndert!
          end;                               // Dies muss aber geschehen, damit man das Fenster im
     end;                                    // n�chsten Schritt verschieben kann.
end;

procedure TMenue.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i: byte;
begin
     if (Button = mbleft) and (Cursor = crHandpoint) then// linke Taste wird gel�st:
     begin
          if Menue.Top > Screen.Height div 2 then        // Wenn das Fenster bis unter die H�lfte 
          begin                                          // der Bildschirmh�he gezogen wurde,
               for i := Y to Screen.Height - 100 do      // wird das Men� bis zum Verschwinden
               begin
                    Menue.Top := Menue.Top + i;          // weiter nach unten verschoben
                    sleep(10);                           // (nicht sofort, sondern "langsam")
               end;
               close;                                    // und schlie�lich geschlossen.
          end else                                       // Wird das Fenster nicht gen�gend weit
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
