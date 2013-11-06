unit ShapeSchliessen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TShapeSchliessen = class(TShape)
  private
    { Private-Deklarationen }
    FThemenfarbe1:TColor;
    FThemenfarbe2:TColor;
    FFenster:TForm;
    FInaktiv:boolean;
  protected
    { Protected-Deklarationen }
    procedure MouseMove(Shift: TShiftState; X,
      Y: Integer); override;
    procedure MouseDown(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer); override;
  public
    { Public-Deklarationen }
    constructor Create(AOwner:TComponent);override;
    procedure Paint; override;
  published
    { Published-Deklarationen }
    property Left default 0;
    property OnMouseMove;
    property Themenfarbe1:Tcolor read FThemenfarbe1 write FThemenfarbe1 default clWhite;
    property Themenfarbe2:Tcolor read FThemenfarbe2 write FThemenfarbe2 default clWhite;
    property Fenster:TForm read FFenster write FFenster;
    property inaktiv:boolean read FInaktiv write FInaktiv default true;
  end;

procedure Register;

implementation

var dif:integer;

constructor TShapeSchliessen.Create(AOwner:TComponent);
begin
     inherited Create(AOwner);
     Left := 0;                            // Das Shape wird im
     Top := 0;                             // asl kleine Leiste im oberen Bereich
     Width := Screen.Width+1;              // des Bildschirm erstellt.
     Height := Screen.Height div 30;

     Cursor := crHandpoint;

     Pen.Style := psClear;
end;

procedure TShapeSchliessen.Paint;
var Textposition:integer;
    Text:string;
begin
     inherited Paint;
     Text := 'zum Schließen, Fenster nach unter ziehen';
     if inaktiv = true then
     begin
          Brush.Style := bsClear;       // im inaktiven Modus macht sich das Shape unsichtbar

     with Canvas do
     begin
          Font.Color := Themenfarbe2;                 // und einen Hilfs-Text
          Brush.Style := bsClear;                     // in die Mitte des Shapes
          Font.Charset := Ansi_Charset;
          Font.Name := 'permanent marker';
          Font.Size := (3*Height)div 5 ;
          Textposition := TextWidth(Text) div 2;
          TextOut((Screen.Width div 2)-Textposition,-5,Text);
     end;
     end else
     begin
          Brush.Style := bsSolid;
          Brush.Color := Themenfarbe2;   // im aktiven Modus bekommt es die Themenfarbe 2

     with Canvas do
     begin
          Font.Color := Themenfarbe1;                 // und einen Hilfs-Text
          Brush.Style := bsClear;                     // in die Mitte des Shapes
          Font.Charset := Ansi_Charset;
          Font.Name := 'permanent marker';
          Font.Size := (3*Height)div 5 ;
          Textposition := TextWidth(Text) div 2;
          TextOut((Screen.Width div 2)-Textposition,-5,Text);
     end;
     end;
end;

procedure TShapeSchliessen.MouseMove(Shift: TShiftState; X,
      Y: Integer);
begin
     inherited MouseMove(Shift,X,Y);

     if inaktiv then                      // wenn das Shape inaktiv ist
     begin
          inaktiv := false;               // wird es auf aktiv gesetzt
          repaint;                        // und neu gezeichnet
     end;

     if Fenster.Align = alNone then                // wenn die Maus gedrückt wurde
     begin
          Fenster.Top := Mouse.CursorPos.y - dif;  // wird das Fenster in der Mausrichtung bewegt
     end;
end;

procedure TShapeSchliessen.MouseDown(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     inherited MouseDown(Button,Shift,X,Y);

     dif := Y;

     if Button = mbleft then                 // Wenn die linke Maustaste gedrückt wird,
     begin                                   // wird aus dem Vollbild "Normalbild".
          Fenster.Align := alNone;           // Dies muss geschehen, damit man das Fenster
     end;                                    // in Höhe und Breite verändern kann!


end;

procedure TShapeSchliessen.MouseUp(Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     inherited MouseUp(Button,Shift,X,Y);

     if Mouse.CursorPos.y > Screen.Height div 2 then   // Wenn die Maus (das Fenster)
     begin                                             // unter die Bildschirmmitte gezogen wurde,
          repeat;
                 Fenster.Top := Fenster.Top + 15;      // verschwindet das Fenster "langsam" nach unten
                 sleep(1);
          until Fenster.Top > Screen.Height;
          Fenster.Close;                              // und wird geschlossen
     end else
     begin                                            // befindet sich das Fenster beim
          if Fenster.Top > 10 then                    // Loslassen der linken Maustaste überhalb
          begin                                       // der Bildschirmmitte ( aber unter dem 10. pixel)
               repeat;
                      Fenster.Top := Fenster.Top - 15; // gelangt das Fenster "langsam" wieder
                      sleep(1);                        // seine Ausgangsposition
               until Fenster.Top < 0;
          end;
          Fenster.Align := alClient;                   // das Fenster wird wird zum Vollbild
     end;
end;

procedure Register;
begin
  RegisterComponents('Übung', [TShapeSchliessen]);
end;

end.
