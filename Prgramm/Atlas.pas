unit Atlas;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ShapeSchliessen, ExtCtrls, StdCtrls;

type
  TKarten = class(TForm)
    LBRegion: TListBox;
    ShpHintergrund2: TShape;
    ShpHintergrund1: TShape;
    Maskottchen: TLabel;
    LBKartenTyp: TListBox;
    LblUeberschrift: TLabel;
    ImgKarte: TImage;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LBKartenTypClick(Sender: TObject);
    procedure ImageAusrichten;
    procedure ImgKarteClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Karten: TKarten;
  Themenfarbe1: TColor;
  Themenfarbe2: TColor;
  SchliessenShape:TShapeSchliessen;
  Rand:integer;  // Maßeinheit abhängig von der Bildschirmauflösung
  Region,Typ:string;

implementation

uses Struktur,Grossbild;

{$R *.DFM}

procedure TKarten.FormCreate(Sender: TObject);
begin
     self.DoubleBuffered := true;

     Themenfarbe1 := Menue.Themenfarbe1;             // Themenfarbe wird aus dem Menü-Formular gelesen
     Themenfarbe2 := Menue.Themenfarbe2;

     Color := Themenfarbe1;

     SchliessenShape := TShapeSchliessen.Create(self);    // Erstellen der Schließen-Komponente
     SchliessenShape.Parent := self;
     SchliessenShape.Themenfarbe1 := Themenfarbe1;        // die Themenfarben werden übergeben
     SchliessenShape.Themenfarbe2 := Themenfarbe2;
     SchliessenShape.Fenster := Karten;           // Wichtig! Das Fenster wird übergeben, damit die Komponente weiß
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
     ShpHintergrund2.Top  := 5*Rand;
     ShpHintergrund2.Width := Screen.Width - ShpHintergrund1.Width - 3*Rand;
     ShpHintergrund2.Height:= Screen.Height - 6*Rand;
     ShpHintergrund2.Brush.Color := Themenfarbe2;

     ImgKarte.Left :=  2*Rand + ShpHintergrund1.Width;
     ImgKarte.Top := 5*Rand;

     LblUeberschrift.Left := ShpHintergrund2.Left;
     LblUeberschrift.Top := 2*Rand;
     LblUeberschrift.Color := Themenfarbe1;
     LblUeberschrift.Font.Color := Themenfarbe2;
     LblUeberschrift.Font.Size := Rand;

     LBRegion.Left := 2*Rand;
     LBRegion.Top := 2*Rand;
     LBRegion.Width := ShpHintergrund1.Width - 9*Rand;
     LBRegion.Height := ShpHintergrund1.Height - Maskottchen.Height - 3* Rand;
     LBRegion.Color := Themenfarbe1;
     LbRegion.Font.Color := Themenfarbe2;

     LBKartenTyp.Left := 2*Rand + LBRegion.Width;
     LBKartenTyp.Top := 2*Rand;
     LBKartenTyp.Width := ShpHintergrund1.Width - 2*Rand - LBRegion.Width;
     LBKartenTyp.Height := ShpHintergrund1.Height - Maskottchen.Height - 3* Rand;
     LBKartenTyp.Color := Themenfarbe1;
     LbKartenTyp.Font.Color := Themenfarbe2;

     LBRegion.ItemIndex := 0;
     LBKartenTyp.ItemIndex := 0;
     LblUeberschrift.Caption := Region + ' - ' + Typ;
end;


procedure TKarten.LBKartenTypClick(Sender: TObject);
begin
     Region := LBRegion.Items.Strings[LbRegion.ItemIndex];
     Typ := LBKartenTyp.Items.Strings[LBKartenTyp.ItemIndex];
     LblUeberschrift.Caption := Region + ' - ' + Typ;
     ImgKarte.Stretch := false;
     ImgKarte.Autosize := true;
     ImgKarte.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Bilder/Atlas/' + Region + Typ + '.jpg');
     ImageAusrichten;
end;

procedure TKarten.ImageAusrichten;
begin
     if ImgKarte.Width <> ShpHintergrund2.Width then
     begin
          ImgKarte.AutoSize := false;
          ImgKarte.Height := round(ImgKarte.Height * ShpHintergrund2.Width / ImgKarte.Width);
          ImgKarte.Width := ShpHintergrund2.Width;
          ImgKarte.Stretch := true;
     end;
     if ImgKarte.Height > ShpHintergrund2.Width then
     begin
          ImgKarte.Width := round(ImgKarte.Width*ShpHintergrund2.Height / Imgkarte.Height);
          ImgKarte.Height:= ShpHintergrund2.Height;

          ImgKarte.Left := ShpHintergrund2.Left + round((ShpHintergrund2.Width-ImgKarte.Width)/ 2);
          ImgKarte.Top := 5*Rand;
     end else
     begin
          ImgKarte.Top := 5*Rand + round((ShpHintergrund2.Height-ImgKarte.Height)/2);
          ImgKarte.Left :=  2*Rand + ShpHintergrund1.Width;
     end;
end;

procedure TKarten.ImgKarteClick(Sender: TObject);
begin
     Application.CreateForm(TVollbild, Vollbild);
     Vollbild.BringToFront;
     Vollbild.ShowModal;
end;

procedure TKarten.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     if SchliessenShape.inaktiv = false then    // Wenn das Shape zum Schließen noch
     begin                                      // aktiv ist,
          SchliessenShape.inaktiv := true;      // wird sein Status auf inaktiv gesetzt
          SchliessenShape.Repaint;              // und es zeichnet sich neu.
     end;
end;




end.
