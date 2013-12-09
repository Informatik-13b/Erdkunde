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

implementation

uses Struktur;

{$R *.DFM}

procedure TOrte_Finden.FormCreate(Sender: TObject);
var Stadt:integer;
begin
     self.DoubleBuffered := true;

     Themenfarbe1 := Menue.Themenfarbe1;
     Themenfarbe2 := Menue.Themenfarbe2;

     Orte_Finden.Color := Themenfarbe1;

     SuchKarte := TImageOrten.Create(self);
     SuchKarte.Parent := self;
     randomize;
     Stadt := random(75)+1;
     LblStadt.Caption := SuchKarte.SatzLadenAnzeigen(Stadt);

     SchliessenShape := TShapeSchliessen.Create(self);    // Erstellen der Schlie�en-Komponente
     SchliessenShape.Parent := self;
     SchliessenShape.Themenfarbe1 := Themenfarbe1;        // die Themenfarben werden �bergeben
     SchliessenShape.Themenfarbe2 := Themenfarbe2;
     SchliessenShape.Fenster := Orte_Finden;           // Wichtig! Das Fenster wird �bergeben, damit die Komponente wei�
                                                       // welches Fenster geschlossen werden soll.

     Rand := Screen.Height div 30;

     ShpHintergrund1.Left := Rand;
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
     if SchliessenShape.inaktiv = false then    // Wenn das Shape zum Schlie�en noch
     begin                                      // aktiv ist,
          SchliessenShape.inaktiv := true;      // wird sein Status auf inaktiv gesetzt
          SchliessenShape.Repaint;              // und es zeichnet sich neu.
     end;
end;


procedure TOrte_Finden.BtnNeuClick(Sender: TObject);
var index:integer;
begin
     SuchKarte.Picture := nil;
     SuchKarte.Picture.LoadFromFile('Bilder/DKarte ohne St�dte.bmp');
     SuchKarte.geklickt := false;
     index := random(75)+1;
     LblStadt.Caption := SuchKarte.SatzLadenAnzeigen(index);
     LblStadt.Left := (ShpHintergrund1.Width div 2 + Rand)-(LblStadt.Width div 2);
     LblSchwierigkeit.Caption := SuchKarte.ROrte.Schwierigkeit;
     LblSchwierigkeit.Left := (ShpHintergrund1.Width div 2 + Rand)-(LblSchwierigkeit.Width div 2);
     pruefenTimer.Enabled := true;
end;

procedure TOrte_Finden.ShpHintergrund1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
     if SchliessenShape.inaktiv = false then    // Wenn das Shape zum Schlie�en noch
     begin                                      // aktiv ist,
          SchliessenShape.inaktiv := true;      // wird sein Status auf inaktiv gesetzt
          SchliessenShape.Repaint;              // und es zeichnet sich neu.
     end;
end;

procedure TOrte_Finden.pruefenTimerTimer(Sender: TObject);
begin
     if SuchKarte.geklickt = true then
     begin
          LblPunkte.Caption := IntToStr(SuchKarte.Punkte);
          LblEntfernung.Caption := IntToStr(SuchKarte.Entfernung) + ' km';
          LblPunkte.Left := (ShpHintergrund1.Width div 2 + Rand)-(LblPunkte.Width div 2);
          LblEntfernung.Left := (ShpHintergrund1.Width div 2 + Rand)-(LblEntfernung.Width div 2);
          pruefenTimer.Enabled := false;
     end;
end;

end.
