unit Lexikon;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ShapeSchliessen, StdCtrls, ExtCtrls, ComCtrls;

type
  TFLexikon = class(TForm)
    Maskottchen: TLabel;
    ShpHintergrund1: TShape;
    ShpHintergrund2: TShape;
    LblText: TLabel;
    LBStichwoerter: TListBox;
    REdtDatei: TRichEdit;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DateiLadenEntschluesseln;
    procedure ErzeugeGa;
    procedure addition(x:integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    Themenfarbe1: TColor;
    Themenfarbe2: TColor;
  end;

Const ka = ',-./0123456789:;Ô?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz';

var
  FLexikon: TFLexikon;
  SchliessenShape : TShapeSchliessen;

  ga, ga2: string;
  lenA : integer;
  kt, gt : string;
  lenT, p : integer;
  c : char;
  schl: string;
  LenSchl: integer;
  Schluessel: String;

implementation

uses Struktur;

{$R *.DFM}

procedure TFLexikon.FormCreate(Sender: TObject);
var Rand:integer;
begin
     Themenfarbe1 := Menue.Themenfarbe1;
     Themenfarbe2 := Menue.Themenfarbe2;

     FLexikon.Color := Themenfarbe1;
     Self.DoubleBuffered := True;

     SchliessenShape := TShapeSchliessen.Create(self);    // Erstellen des Schließen-Komponente
     SchliessenShape.Parent := self;
     SchliessenShape.Themenfarbe1 := Themenfarbe1;        // die Themenfarben werden übergeben
     SchliessenShape.Themenfarbe2 := Themenfarbe2;
     SchliessenShape.Fenster := FLexikon;           // Wichtig! Das Fenster wird übergeben, damit die Komponente weiß
                                                 // welches Fenster geschlossen werden soll.
     Rand := Screen.Height div 30;
     Maskottchen.Top := 17*Rand;
     Maskottchen.Left := 2*Rand;
     Maskottchen.Width := Screen.Width - 5*Rand - ((Screen.Height*133)div 195);
     Maskottchen.Height := 11*Rand;

     ShpHintergrund1.Left := Rand;
     ShpHintergrund1.Top  := Rand;
     ShpHintergrund1.Width := Screen.Width - 3*Rand - ((Screen.Height*133)div 195);
     ShpHintergrund1.Height:= Screen.Height - 2*Rand;
     ShpHintergrund1.Brush.Color := Themenfarbe2;

     ShpHintergrund2.Left := 2*Rand + ShpHintergrund1.Width;
     ShpHintergrund2.Top  := Rand;
     ShpHintergrund2.Width := Screen.Width - ShpHintergrund1.Width - 3*Rand;
     ShpHintergrund2.Height:= Screen.Height - 2*Rand;
     ShpHintergrund2.Brush.Color := Themenfarbe2;

     LblText.Left := ShpHintergrund2.Left + Rand;
     LblText.Top  := 2*Rand;
     LblText.Width := ShpHintergrund2.Width - 2*Rand;
     LblText.Height := ShpHintergrund2.Height - 2*Rand;

     LBStichwoerter.Left := 2*Rand;
     LBStichwoerter.Top := 2*Rand;
     LBStichwoerter.Width := ShpHintergrund1.Width - 2*Rand;
     LBStichwoerter.Height := ShpHintergrund1.Height - Maskottchen.Height - 3* Rand;
     LBStichwoerter.Color := Themenfarbe1;

     DateiLadenEntschluesseln;
end;

procedure TFLexikon.DateiLadenEntschluesseln;

var i : integer;
begin
     REdtDatei.Lines.LoadFromFile('Lexikon/Lexikon.txt');

     Schluessel := 'abcd';

     gt := REdtDatei.Text;
     lenT := length(gt);
     kt := '';
     for i := 1 to lenT do
     begin
          ErzeugeGa;
          addition(i);
          c := gt[i];
          p := pos(c,ga2);
          if p <> 0 then kt := kt + copy(ka,p,1)
          else kt := kt + c;;
     end;
     REdtDatei.Text := kt;
end;

procedure TFLexikon.ErzeugeGa;
var Wert1, Wert2: integer;
     i: integer;
     schlZahl: integer;
begin
    ga := '';
    schlZahl := ord(schluessel[1]);
    lenA := length(ka);
    For i := 1 to lenA do
     begin
        c := ka[i];
        Wert1 := ord(c);
        Wert2 := ((Wert1-44)*schlZahl mod 79)+44;
        ga := ga + chr(Wert2);
     end;
end;

procedure TFLexikon.addition (x: integer);
var c2: char;
    p2, zaehler: integer;
begin
     lenSchl := length (schluessel);
     zaehler := x mod lenSchl +1;
     c2 := schluessel[zaehler];
     p2 := pos (c2, ga);
     ga2 := copy (ga, p2, lenA -p2+1)
            + copy (ga, 1, p2-1);
end;

procedure TFLexikon.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     if SchliessenShape.inaktiv = false then    // Wenn das Shape zum Schließen noch
     begin                                      // aktiv ist,
          SchliessenShape.inaktiv := true;      // wird sein Status auf inaktiv gesetzt
          SchliessenShape.Repaint;              // und es zeichnet sich neu.
     end;
end;



end.
