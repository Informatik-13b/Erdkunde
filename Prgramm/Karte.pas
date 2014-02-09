unit Karte;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImageOrten, ShapeSchliessen, OleCtrls, SHDocVw, StdCtrls, ExtCtrls;

type
  TOrte_Finden = class(TForm)
    BtnNeu: TButton;
    ShpHintergrund1: TShape;
    LblUeberschrift: TLabel;
    Maskottchen: TLabel;
    LblStadt: TLabel;
    LblSchwierigkeit: TLabel;
    pruefenTimer: TTimer;
    LblPunkte: TLabel;
    LblEntfernung: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BtnNeuClick(Sender: TObject);
    procedure ShpHintergrund1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure pruefenTimerTimer(Sender: TObject);
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
  Rand:integer;
  index:integer = 1;

implementation

uses Struktur;

{$R *.DFM}

procedure TOrte_Finden.FormCreate(Sender: TObject);
//var Stadt:integer;
begin
     self.DoubleBuffered := true;

     Themenfarbe1 := Menue.Themenfarbe1;             // Themenfarbe wird aus dem Menü-Formular gelesen
     Themenfarbe2 := Menue.Themenfarbe2;

     Orte_Finden.Color := Themenfarbe1;

     SuchKarte := TImageOrten.Create(self);          // Die Suchkarte wird erzeugt
     SuchKarte.Parent := self;

     SuchKarte.Picture.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Bilder/DKarte Ohne Städte.bmp'); // Die Deutschlandkarte wird geladen

     LblStadt.Caption := SuchKarte.SatzLadenAnzeigen(1);   // ein zufälliger Datensatz wird geladen



     SchliessenShape := TShapeSchliessen.Create(self);    // Erstellen der Schließen-Komponente
     SchliessenShape.Parent := self;
     SchliessenShape.Themenfarbe1 := Themenfarbe1;        // die Themenfarben werden übergeben
     SchliessenShape.Themenfarbe2 := Themenfarbe2;
     SchliessenShape.Fenster := Orte_Finden;           // Wichtig! Das Fenster wird übergeben, damit die Komponente weiß
                                                       // welches Fenster geschlossen werden soll.

     Rand := Screen.Height div 30;                    // Rand ist eine bestimme Länge in Abhängigkeit der Fensterhöhe

     ShpHintergrund1.Left := Rand;                                                   // Objekte werden platziert
     ShpHintergrund1.Top  := Rand;
     ShpHintergrund1.Width := Screen.Width - 3*Rand - ((Screen.Height*133)div 195);
     ShpHintergrund1.Height:= Screen.Height - 2*Rand;
     ShpHintergrund1.Brush.Color := Themenfarbe2;

     LblUeberschrift.Font.Size := Screen.Height div 30;
     LblUeberschrift.Top := 2*Rand;
     LblUeberschrift.Left := ((ShpHintergrund1.Width + 2*Rand) div 2)
                              - LblUeberschrift.Width div 2;

     Maskottchen.Top := 17*Rand;
     Maskottchen.Left := 2*Rand;
     Maskottchen.Width := Screen.Width - 5*Rand - ((Screen.Height*133)div 195);
     Maskottchen.Height := 11*Rand;

     LblStadt.Font.Size := Screen.Height div 30;
     LblStadt.Top := 5*Rand;
     LblStadt.Left := (ShpHintergrund1.Width div 2 + Rand)-(LblStadt.Width div 2);

     LblSchwierigkeit.Font.Size := Screen.Height div 40;
     LblSchwierigkeit.Top := 7*Rand;
     LblSchwierigkeit.Left := (ShpHintergrund1.Width div 2 + Rand)-(LblSchwierigkeit.Width div 2);

     LblPunkte.Font.Size := Screen.Height div 30;
     LblPunkte.Top := 9*Rand;
     LblPunkte.Left := (ShpHintergrund1.Width div 2 + Rand)-(LblPunkte.Width div 2);

     LblEntfernung.Font.Size := Screen.Height div 40;
     LblEntfernung.Top := 11*Rand;
     LblEntfernung.Left := (ShpHintergrund1.Width div 2 + Rand)-(LblEntfernung.Width div 2);
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
     SuchKarte.Picture := nil;                                                                              // Die Suchkarte wird geleert und
     SuchKarte.Picture.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Bilder/DKarte Ohne Städte.bmp'); // neu geladen
     SuchKarte.geklickt := false;
     if index = 77 then index := 1 else inc(index);                                                             // ein neuer zufälliger Datensatz wird geladen
     LblStadt.Caption := SuchKarte.SatzLadenAnzeigen(index);
     LblStadt.Left := (ShpHintergrund1.Width div 2 + Rand)-(LblStadt.Width div 2);
     LblSchwierigkeit.Caption := SuchKarte.ROrte.Schwierigkeit;
     LblSchwierigkeit.Left := (ShpHintergrund1.Width div 2 + Rand)-(LblSchwierigkeit.Width div 2);
     pruefenTimer.Enabled := true;
end;

procedure TOrte_Finden.ShpHintergrund1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
     if SchliessenShape.inaktiv = false then    // Wenn das Shape zum Schließen noch
     begin                                      // aktiv ist,
          SchliessenShape.inaktiv := true;      // wird sein Status auf inaktiv gesetzt
          SchliessenShape.Repaint;              // und es zeichnet sich neu.
     end;
end;

procedure TOrte_Finden.pruefenTimerTimer(Sender: TObject);
begin
     if SuchKarte.geklickt = true then                                 // Wenn geklickt wurde,
     begin
          LblPunkte.Caption := IntToStr(SuchKarte.Punkte);                     // werden die berechneten Punkte 
          LblEntfernung.Caption := IntToStr(SuchKarte.Entfernung) + ' km';     // und die Entfernung in km  aus der Suchkarte gelesen
          LblPunkte.Left := (ShpHintergrund1.Width div 2 + Rand)-(LblPunkte.Width div 2);
          LblEntfernung.Left := (ShpHintergrund1.Width div 2 + Rand)-(LblEntfernung.Width div 2);
          pruefenTimer.Enabled := false;
     end;
end;

end.
