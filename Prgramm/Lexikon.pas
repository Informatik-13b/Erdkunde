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
    LBStichwoerter: TListBox;
    REdtDatei: TRichEdit;
    MText: TRichEdit;
    LblStichwort: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DateiLaden;
    procedure StichwoerterAuflisten;
    procedure AbsaetzeLaden(Stichwort:string);
    procedure LBStichwoerterClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    Themenfarbe1: TColor;
    Themenfarbe2: TColor;
  end;

var
  FLexikon: TFLexikon;
  SchliessenShape : TShapeSchliessen;

implementation

uses Struktur;

{$R *.DFM}

procedure TFLexikon.FormCreate(Sender: TObject);
var Rand:integer;
begin
     Themenfarbe1 := Menue.Themenfarbe1;                   //Übergabe der Themenfarbe
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
     Maskottchen.Left := 2*Rand;                                                    // Platzvergabe der Objekte in Abhängigkeit der Auflösung
     Maskottchen.Width := Screen.Width - 8*Rand - ((Screen.Height*133)div 195);     //   |
     Maskottchen.Height := 11*Rand;                                                 //   |
                                                                                    //   |
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

     LBStichwoerter.Left := ShpHintergrund2.Left + Rand;
     LBStichwoerter.Top  := 2*Rand;
     LBStichwoerter.Width := ShpHintergrund2.Width - 2*Rand;
     LBStichwoerter.Height := ShpHintergrund2.Height - 2*Rand;
     LBStichwoerter.Color := Themenfarbe1;
     LBStichwoerter.Font.Color := Themenfarbe2;

     MText.Left := 2*Rand;
     MText.Top := 5*Rand;
     MText.Width := ShpHintergrund1.Width - 2*Rand;
     MText.Height := ShpHintergrund1.Height - Maskottchen.Height - 6* Rand;
     MText.Color := Themenfarbe1;
     MText.Font.Color := Themenfarbe2;

     LblStichwort.Top := 2*Rand;
     LblStichwort.Left := 2*Rand;
     LblStichwort.Color := Themenfarbe2;
     LblStichwort.Font.Color := Themenfarbe1;
     LblStichwort.Font.Size := Rand;
     LblStichwort.Caption := 'Wähle ein Stichwort';
                                                                                       // Lexikondatei wird geladen und entschlüsselt
     DateiLaden;                                                         // die Sitchwörter werden gelistet
     StichwoerterAuflisten;
end;

procedure TFLexikon.DateiLaden;
begin
     REdtDatei.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Lexikon/Lexikon.txt');   // Ins UNSICHTBARE REditDatei wird die Lexikondatei geladen
end;


procedure TFLexikon.StichwoerterAuflisten;
var i,Linie: integer;
tmp:string;
begin
     Linie := 0;
     for i := 1 to StrToInt(REdtDatei.Lines[0]) do       // in der ersten Linie des REdtDatei ist die 
     begin                                               // Menge der vorandenen Stichwörter hinterlegt
          repeat
                inc(Linie);
                tmp := REdtDatei.Lines[Linie];          // die Linien werden ausgelesen
          until tmp = IntToStr(i);                      // bis ein neuer Datensatz auftaucht .
          inc(Linie);                                   // In der nächsten Linie/Zeile
          tmp := REdtDatei.Lines[Linie];                // befindet sich das Stichwort und
          LbStichwoerter.Items.Add(tmp);                // es wird dem LBStichwoerter Objekt hinzugefügt
     end;
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



procedure TFLexikon.LBStichwoerterClick(Sender: TObject);                 // LbStichwoerter ist ein RichEdit, dessen Eigenschaft "sorted" auf true gesetzt wurde,
var Stichwort:string;                                                     // das heißt, dass keine eigene procedure zum sortieren der Stichwörter geschrieben werden muss
begin
     Stichwort := LbStichwoerter.Items.Strings[LbStichwoerter.ItemIndex]; // Das angeklickte Stichwort wird ermittelt
     AbsaetzeLaden(Stichwort);                                            // und die dazugehörigen Absätze werden geladen
     LblStichwort.Caption := Stichwort;
end;

procedure TFLexikon.AbsaetzeLaden(Stichwort:string);
var tmp:string;
Linie:integer;
begin                                                                     // MText wird geleert
     MText.Clear;
     Linie := 0;
     repeat
           inc(Linie);                                                    // Das Stichwort wird in der UNSICHTBAREN Liste gesucht
           tmp := REdtDatei.Lines[Linie];
     until tmp = Stichwort;

     repeat                                                               // danach werden die folgenden Zeilen / Linien
           inc(Linie);                                                    // ausgelsen und in MText übertragen
           tmp := REdtDatei.Lines[Linie];
           if length(tmp) > 4 then
             if MText.Lines[0] = '' then MText.Lines.Add(tmp)
               else begin
                         MText.Lines.Add('');
                         MText.Lines.Add(tmp);
               end;
     until length(tmp) < 4;                                               // bis ein neuer Datensatz erreicht wird
end;

end.
