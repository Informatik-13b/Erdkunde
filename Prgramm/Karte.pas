unit Karte;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImageOrten, ShapeSchliessen, OleCtrls, SHDocVw, StdCtrls;

type
  TOrte_Finden = class(TForm)
    Label1: TLabel;
    BtnNeu: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BtnNeuClick(Sender: TObject);
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
     self.DoubleBuffered := true;

     Themenfarbe1 := Menue.Themenfarbe1;
     Themenfarbe2 := Menue.Themenfarbe2;

     Orte_Finden.Color := Themenfarbe1;

     SuchKarte := TImageOrten.Create(self);
     SuchKarte.Parent := self;
     randomize;
     Label1.Caption := SuchKarte.SatzLadenAnzeigen(random(75)+1);

     SchliessenShape := TShapeSchliessen.Create(self);    // Erstellen des Schließen-Komponente
     SchliessenShape.Parent := self;
     SchliessenShape.Themenfarbe1 := Themenfarbe1;        // die Themenfarben werden übergeben
     SchliessenShape.Themenfarbe2 := Themenfarbe2;
     SchliessenShape.Fenster := Orte_Finden;           // Wichtig! Das Fenster wird übergeben, damit die Komponente weiß
                                                       // welches Fenster geschlossen werden soll.
end;

procedure TOrte_Finden.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
     if SchliessenShape.inaktiv = false then    // Wenn das Shape zum Schließen noch
     begin                                      // aktiv ist,
          SchliessenShape.inaktiv := true;      // wird sein Status auf inaktiv gesetzt
          SchliessenShape.Repaint;              // und es zeichnet sich neu.
     end;
end;


procedure TOrte_Finden.BtnNeuClick(Sender: TObject);
begin
     SuchKarte.Picture := nil;
     SuchKarte.Picture.LoadFromFile('Bilder/DKarte ohne Städte.bmp');
     Label1.Caption := SuchKarte.SatzLadenAnzeigen(random(75)+1);
end;

end.
