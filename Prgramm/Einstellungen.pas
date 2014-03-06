unit Einstellungen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ShapeSchliessen, ExtCtrls, Grids, ColorGrd, jpeg;

type
  TProfil = class(TForm)
    Maskottchen: TLabel;
    ShpHintergrund1: TShape;
    ShpHintergrund2: TShape;
    ImgFarbe: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ImgFarbeClick(Sender: TObject);
    procedure FarbeWechseln;
    procedure ImgFarbeMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Profil: TProfil;
  Themenfarbe1: TColor;
  Themenfarbe2: TColor;
  SchliessenShape:TShapeSchliessen;
  Rand:integer;  // Maßeinheit abhängig von der Bildschirmauflösung
  Farbe1:boolean=true;

implementation

{$R *.DFM}

uses Struktur;

procedure TProfil.FormCreate(Sender: TObject);
begin
     self.DoubleBuffered := true;

     Themenfarbe1 := Menue.Themenfarbe1;             // Themenfarbe wird aus dem Menü-Formular gelesen
     Themenfarbe2 := Menue.Themenfarbe2;

     Color := Themenfarbe1;

     SchliessenShape := TShapeSchliessen.Create(self);    // Erstellen der Schließen-Komponente
     SchliessenShape.Parent := self;
     SchliessenShape.Themenfarbe1 := Themenfarbe1;        // die Themenfarben werden übergeben
     SchliessenShape.Themenfarbe2 := Themenfarbe2;
     SchliessenShape.Fenster := Profil;           // Wichtig! Das Fenster wird übergeben, damit die Komponente weiß
                                                       // welches Fenster geschlossen werden soll.
     Rand := Screen.Height div 30;
     Maskottchen.Top := 17*Rand;
     Maskottchen.Left := 2*Rand;                                                    // Platzvergabe der Objekte in Abhängigkeit der Auflösung
     Maskottchen.Width := Screen.Width - 8*Rand - ((Screen.Height*133)div 195);     //   |
     Maskottchen.Height := 11*Rand;

     ShpHintergrund1.Left := Rand;                                                  //   V
     ShpHintergrund1.Top  := Rand;
     ShpHintergrund1.Width := Screen.Width - 6*Rand - ((Screen.Height*133)div 195);
     ShpHintergrund1.Height:= Screen.Height - 2*Rand;
     ShpHintergrund1.Brush.Color := Themenfarbe2;

     ShpHintergrund2.Left := 2*Rand + ShpHintergrund1.Width;
     ShpHintergrund2.Top  := Rand;
     ShpHintergrund2.Width := Screen.Width - ShpHintergrund1.Width - 3*Rand;
     ShpHintergrund2.Height:= Screen.Height - 2*Rand;
     ShpHintergrund2.Brush.Color := Themenfarbe2;



     //ImgFarben.Left :=

end;


procedure TProfil.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     if SchliessenShape.inaktiv = false then    // Wenn das Shape zum Schließen noch
     begin                                      // aktiv ist,
          SchliessenShape.inaktiv := true;      // wird sein Status auf inaktiv gesetzt
          SchliessenShape.Repaint;              // und es zeichnet sich neu.
     end;
end;


procedure TProfil.ImgFarbeClick(Sender: TObject);
begin
     if Farbe1 = true then Farbe1 := false else Farbe1 := true;
     if Themenfarbe1 <> Themenfarbe2 then FarbeWechseln;
end;


procedure TProfil.FarbeWechseln;
begin
     Profil.Color := Themenfarbe1;
     ShpHintergrund1.Brush.Color := Themenfarbe2;
     ShpHintergrund2.Brush.Color := Themenfarbe2;
     SchliessenShape.Themenfarbe1 := Themenfarbe1;
     SchliessenShape.Themenfarbe2 := Themenfarbe2;
     SchliessenShape.repaint;
     Menue.Themenfarbe1 := Themenfarbe1;
     Menue.Themenfarbe2 := Themenfarbe2;
     Menue.Farbenwechseln;
end;


procedure TProfil.ImgFarbeMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     x := round(x * 640 / ImgFarbe.Height);
     y := round(y * 640 / ImgFarbe.Height);
     if Farbe1 = true then Themenfarbe1 := ImgFarbe.Canvas.Pixels[x,y] //Pixelfarbe(x,y)
                      else Themenfarbe2 := ImgFarbe.Canvas.Pixels[x,y]; //Pixelfarbe(x,y);
end;

end.
