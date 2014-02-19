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
    Lblverbleibend: TLabel;
    BtnWeiter: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure BtnNeuClick(Sender: TObject);
    procedure ShpHintergrund1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure pruefenTimerTimer(Sender: TObject);
    procedure BtnWeiterClick(Sender: TObject);
    procedure PunkteSpeichern;
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure Runde;
  end;

var
  Orte_Finden: TOrte_Finden;
  Themenfarbe1: TColor;
  Themenfarbe2: TColor;
  SchliessenShape:TShapeSchliessen;
  SuchKarte:TImageOrten;
  Rand:integer;
  index:integer;
  Durchlauf:integer;

implementation

uses Struktur;

{$R *.DFM}

procedure TOrte_Finden.FormCreate(Sender: TObject);
//var Stadt:integer;
begin
     Durchlauf := 1;

     self.DoubleBuffered := true;

     Themenfarbe1 := Menue.Themenfarbe1;             // Themenfarbe wird aus dem Menü-Formular gelesen
     Themenfarbe2 := Menue.Themenfarbe2;

     Orte_Finden.Color := Themenfarbe1;

     SuchKarte := TImageOrten.Create(self);          // Die Suchkarte wird erzeugt
     SuchKarte.Parent := self;

     SuchKarte.Picture.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Bilder/DKarte Ohne Städte.bmp'); // Die Deutschlandkarte wird geladen

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

     LblStadt.Font.Size := Screen.Height div 20;
     LblStadt.Top := 5*Rand;
     LblStadt.Left := (ShpHintergrund1.Width div 2 + Rand)-(LblStadt.Width div 2);
     LblStadt.Caption := '';

     LblSchwierigkeit.Font.Size := Screen.Height div 40;
     LblSchwierigkeit.Top := 8*Rand;
     LblSchwierigkeit.Left := (ShpHintergrund1.Width div 2 + Rand)-(LblSchwierigkeit.Width div 2);
     LblSchwierigkeit.Caption := '';

     LblPunkte.Font.Size := Screen.Height div 20;
     LblPunkte.Top := 12*Rand;
     LblPunkte.Left := (ShpHintergrund1.Width div 2 + Rand)-(LblPunkte.Width div 2);
     LblPunkte.Caption := '';

     LblEntfernung.Font.Size := Screen.Height div 40;
     LblEntfernung.Top := 10*Rand;
     LblEntfernung.Left := (ShpHintergrund1.Width div 2 + Rand)-(LblEntfernung.Width div 2);
     LblEntfernung.Caption := '';

     Lblverbleibend.Font.Size := Screen.Height div 20;
     Lblverbleibend.Top := 5*Rand;
     Lblverbleibend.Left := 2*Rand;
     Lblverbleibend.Caption := '';
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
     Durchlauf := 10;
     runde;
     BtnNeu.Enabled := false;
     Lblverbleibend.Caption := IntToStr(Durchlauf);

end;

procedure TOrte_Finden.BtnWeiterClick(Sender: TObject);
begin
     if Durchlauf > 0 then
     begin
          dec(Durchlauf);
          runde;
          Lblverbleibend.Caption := IntToStr(Durchlauf);
          BtnWeiter.Enabled := false;
          PunkteSpeichern;
     end;
end;

procedure TOrte_Finden.PunkteSpeichern;
begin
     if Menue.MDatei.Lines.Count < 7 then
     begin
          Menue.MDatei.Lines.add(LblPunkte.Caption);
          Menue.MDatei.Lines.add('Orten');
     end else
     begin
          Menue.MDatei.Lines[6] := LblPunkte.Caption;
          Menue.MDatei.Lines[7] := 'Orten';
     end;
     Menue.MDatei.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(Menue.index) + '.txt');
end;

procedure TOrte_Finden.Runde;
begin
     SuchKarte.geklickt := false;
     SuchKarte.Picture := nil;                                                                              // Die Suchkarte wird geleert und
     SuchKarte.Picture.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Bilder/DKarte Ohne Städte.bmp'); // neu geladen
     SuchKarte.geklickt := false;
     randomize;
     index := random(76)+1;
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

     if Durchlauf > 1 then Orte_Finden.BtnWeiter.Enabled := true
     else
     begin
          Orte_Finden.BtnNeu.Enabled := true;
          Orte_Finden.PunkteSpeichern;
     end;
     end;
end;

end.
