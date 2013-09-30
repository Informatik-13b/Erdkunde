unit Struktur;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TMenue = class(TForm)
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
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
begin
     Menue.Color := Themenfarbe1;
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
     if Y < 50 then                              // Wenn sich die Maus im oberen Bildschirmbereich
     begin
          Cursor := crHandpoint;                 // befindet, bekommt sie ein Handsymbol und
          Canvas.Brush.Color := Themenfarbe2;
          Canvas.Pen.Color   := Themenfarbe2;    // mit Canvas wird der obere Bildschirmbereich
          Canvas.Rectangle(0,0,ClientWidth,50);  // in der 2. Themenfarbe gefärbt.
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
end;


procedure TMenue.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     if Button = mbleft then                 // Wenn die linke Maustaste gedrückt wird
     begin
          if Cursor = crHandpoint then       // und sich die Maus im oberen Bildschirmberech befindet (s.o.),
          begin                              // wird aus dem Vollbild "Normalbild" (ist aber nicht sichtbar,
          end;                               // da dich Höhe und Breite des Fenstern NICHT ändert!
               Menue.Align := alNone;        // Dies muss aber geschehen, damit man das Fenster im
     end;                                    // nächsten Schritt verschieben kann.
end;

procedure TMenue.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i: byte;
begin
     if Button = mbleft then                             // linke Taste wird gelöst:
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
               for i := Mouse.CursorPos.y downto 0 do
               begin
                    Menue.Top := i;                      // gelangt das Fenster wieder "langsam" in
                    sleep(1);                            // die Ausgangsposition und zum Schluss wieder
               end;
               Menue.Align := alClient;                  // in den unverschiebbaren Vollbildmodus
          end;
     end;
end;

end.
