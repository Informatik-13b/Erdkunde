unit Einstellungen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ShapeSchliessen, ExtCtrls, Grids;

type
  TProfil = class(TForm)
    Maskottchen: TLabel;
    ShpHintergrund1: TShape;
    ShpHintergrund2: TShape;
    ListBoxAuswahl: TListBox;
    StringGridDaten: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ListBoxAuswahlClick(Sender: TObject);
    procedure Menue_Verbindung();
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

     With ListBoxAuswahl do
      begin
         Left := 2*Rand;
         Top := 2*Rand;
         Width := ShpHintergrund1.Width - 2*Rand;
         Height := ShpHintergrund1.Height - Maskottchen.Height - 3* Rand;
         Color := Themenfarbe1;
         Items.Add('Anmedlung Lehrerkonsole');
         Items.Add('Benutzerdaten');
      end;

    With StringGridDaten do
      begin
         Left := ShpHintergrund2.Left + Rand;
         Top  := 2*Rand;
         Width := ShpHintergrund2.Width - 2*Rand;
         Height := ShpHintergrund2.Height - 2*Rand;
         Color := Themenfarbe1;

      end;
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

procedure TProfil.ListBoxAuswahlClick(Sender: TObject);
 var Auswahl: String;
  begin
     Auswahl := ListBoxAuswahl.Items.Strings[ListBoxAuswahl.ItemIndex];
     If Auswahl = 'Anmeldung Lehrekonsole' then Menue_Verbindung;
     //If Auswahl = 'Benutzerdaten' then 
  end;

procedure TProfil.Menue_Verbindung();
  begin
     //
  end;

end.
