unit LexikonBearbeiten;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    EdtStichwort: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    EdtIndex: TEdit;
    Label3: TLabel;
    BtnErsetzen: TButton;
    BtnNeu: TButton;
    Label4: TLabel;
    BtnWeiter: TButton;
    BtnZurueck: TButton;
    BtnSpeichern: TButton;
    REdtText: TRichEdit;
    REdtKopie: TRichEdit;
    Btn: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnErsetzenClick(Sender: TObject);
    procedure BtnNeuClick(Sender: TObject);
    procedure Laden(Datensatz:integer);
    procedure schreiben(Datensatz:integer);
    procedure BtnWeiterClick(Sender: TObject);
    procedure BtnZurueckClick(Sender: TObject);
    procedure BtnSpeichernClick(Sender: TObject);
    procedure speichern;
    function Datensaetze:integer;
    procedure Verschluesseln;
    procedure Entschluesseln;
    procedure ErzeugeGa;
    procedure addition(x:integer);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  Menge: integer;

  ga, ga2: string;
  lenA : integer;
  kt, gt : string;
  lenT, p : integer;
  c : char;
  schl: string;
  LenSchl: integer;
  Schluessel: String;

Const
  ka = ',-./0123456789:;?ABCDEFGHIJKLMNOPQRSTUVWXYZÖÜÄ`abcdefghijklmnopqrstuvwxyzüöäß';

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
     REdtKopie.Lines.LoadfromFile('Lexikon.txt');
     Menge := Datensaetze;

     Schluessel := 'arne';
     //Verschluesseln;
     //Entschluesseln;

     Laden(2);
     Label4.Caption := IntToStr(Menge);
end;

function TForm1.Datensaetze:integer;
var i, Datensatz:integer;
temp:string;
begin
     i := 0;
     Datensatz := -1;
     repeat
           inc(i);
           temp := REdtKopie.Lines[i];
           if length(temp) < 4 then inc(Datensatz);
     until temp = '';
     result := Datensatz;
end;

procedure TForm1.Laden(Datensatz:integer);
var Linie,j:integer;
temp:string;
begin
     EdtIndex.Text := IntToStr(Datensatz);
     temp := '';
     Linie := 1;
     j := -1;
     repeat
           temp := REdtKopie.Lines[Linie];
           inc(Linie);
     until temp = IntToStr(Datensatz);
     EdtStichwort.Text := REdtKopie.Lines[Linie];

     repeat
          inc(Linie);
          inc(j);
          temp := REdtKopie.Lines[Linie];
          REdtText.Lines.add(temp);
     until (temp = IntToStr(Datensatz+1)) or (temp = '');
     REdtText.Lines[j] := '';
end;


procedure TForm1.BtnErsetzenClick(Sender: TObject);
begin
     schreiben(StrToInt(EdtIndex.Text));
end;


procedure TForm1.schreiben(Datensatz:integer);
var temp:string;
Linie,Linie2,i,dif:integer;
begin
     if Datensatz < Menge then
     begin

     Linie := 1;
     repeat
           temp := REdtKopie.Lines[Linie];
           inc(Linie);
     until temp = IntToStr(Datensatz);
     Linie2 := Linie;
     repeat
           temp := REdtKopie.Lines[Linie2];
           inc(Linie2);
     until temp = IntToStr(Datensatz+1);

     dif := Linie2-Linie+1;
     repeat
           temp := REdtKopie.Lines[Linie+dif-1];
           if (length(temp) > 3) then REdtKopie.Lines[Linie] := temp
           else  if temp <> '' then REdtKopie.Lines[Linie] := IntToStr(StrToInt(temp)-1);
           inc(Linie);
     until temp = '';
     REdtKopie.Lines[Linie-1] := IntToStr(Menge);
     REdtKopie.Lines[Linie] := EdtStichwort.Text;
     inc(Linie);

     for i := 1 to REdtText.Lines.Capacity do
     begin
           if i > dif-3 then REdtKopie.Lines.add(REdtText.Lines[i-1])
           else REdtKopie.Lines[Linie+i] := REdtText.Lines[i];
     end;
     EdtIndex.Text := IntToStr(Menge);

     end else
     begin

     Linie := 1;
     repeat
           temp := REdtKopie.Lines[Linie];
           inc(Linie);
     until temp = IntToStr(Menge);
     Linie2 := Linie;
     repeat
           temp := REdtKopie.Lines[Linie2];
           inc(Linie2);
     until temp = '';
     dif := Linie2-Linie+1;

     REdtKopie.Lines[Linie] := EdtStichwort.Text;
     inc(Linie);

     for i := 1 to REdtText.Lines.Capacity do
     begin
           if i > dif-3 then REdtKopie.Lines.add(REdtText.Lines[i-1])
           else REdtKopie.Lines[Linie+i] := REdtText.Lines[i];
     end;
     end;
end;


procedure TForm1.BtnWeiterClick(Sender: TObject);
begin
     if StrToInt(EdtIndex.Text) < Menge then
     begin
          REdtText.Lines.Clear;
          Laden(StrToInt(EdtIndex.Text)+1);
     end;
end;

procedure TForm1.BtnZurueckClick(Sender: TObject);
begin
     if StrToInt(EdtIndex.Text) > 1 then
     begin
          REdtText.Lines.Clear;
          Laden(StrToInt(EdtIndex.Text)-1);
     end;
end;


procedure TForm1.BtnNeuClick(Sender: TObject);
begin
     inc(Menge);
     EdtIndex.Text := IntToStr(Menge);
     EdtStichwort.Text := '';
     REdtText.Lines.Clear;

     BtnErsetzen.Enabled := false;
     BtnWeiter.Enabled := false;
     BtnZurueck.Enabled := false;
     BtnNeu.Enabled := false;
     BtnSpeichern.Enabled := true;
end;


procedure TForm1.BtnSpeichernClick(Sender: TObject);
begin
     speichern;
end;

procedure TForm1.speichern;
begin
     REdtKopie.Lines[0] := IntToStr(Menge);
     REdtKopie.Lines.add(IntToStr(Menge));
     REdtKopie.Lines.add(EdtStichwort.Text);
     REdtKopie.Lines.add(REdtText.Lines[1-1]);
     REdtKopie.Lines.add(REdtText.Lines[2-1]);
     REdtKopie.Lines.add(REdtText.Lines[3-1]);

     BtnErsetzen.Enabled := true;
     BtnWeiter.Enabled := true;
     BtnZurueck.Enabled := true;
     BtnNeu.Enabled := true;
     BtnSpeichern.Enabled := false;
end;

procedure TForm1.Verschluesseln;
var i:integer;
begin
     kt := REdtKopie.Text;
     lenT := length(kt);
     gt := '';
     for i := 1 to lenT do
     begin
          ErzeugeGa;
          addition(i);
          c := kt[i];
          p := pos(c,ka);
          if p <> 0 then gt := gt + copy (ga2,p,1)
          else gt := gt + c;
     end;
     REdtKopie.Text := gt;
end;

procedure TForm1.Entschluesseln;
var i:integer;
begin
     gt := REdtKopie.Text;
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
     REdtKopie.Text := kt;
end;

procedure TForm1.ErzeugeGa;
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

procedure TForm1.addition (x: integer);
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



end.
