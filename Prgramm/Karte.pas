unit Karte;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImageOrten, ShapeSchliessen, OleCtrls, SHDocVw;

type
  TOrte_Finden = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Orte_Finden: TOrte_Finden;
  Themenfarbe1: TColor;
  Themenfarbe2: TColor;
  SchliessenShape:TShapeSchliessen;
  SuchKarte:TImageOrten;

implementation

uses Struktur;

{$R *.DFM}

procedure TOrte_Finden.FormCreate(Sender: TObject);
begin
     Themenfarbe1 := Menue.Themenfarbe1;
     Themenfarbe2 := Menue.Themenfarbe2;

     Orte_Finden.Color := Themenfarbe1;

     SuchKarte := TImageOrten.Create(self);
     SuchKarte.Parent := self;

     SchliessenShape := TShapeSchliessen.Create(self);    // Erstellen des Schlie�en-Komponente
     SchliessenShape.Parent := self;
     SchliessenShape.Themenfarbe1 := Themenfarbe1;        // die Themenfarben werden �bergeben
     SchliessenShape.Themenfarbe2 := Themenfarbe2;
     SchliessenShape.Fenster := Orte_Finden;           // Wichtig! Das Fenster wird �bergeben, damit die Komponente wei�
                                                       // welches Fenster geschlossen werden soll.
end;

procedure TOrte_Finden.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
     if SchliessenShape.inaktiv = false then    // Wenn das Shape zum Schlie�en noch
     begin                                      // aktiv ist,
          SchliessenShape.inaktiv := true;      // wird sein Status auf inaktiv gesetzt
          SchliessenShape.Repaint;              // und es zeichnet sich neu.
     end;
end;

end.