unit Konsole;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Menus, StdCtrls, ScktComp, ExtCtrls;

type
  TFormKonsole = class(TForm)
    StringGridUbersicht: TStringGrid;
    Label1: TLabel;
    MainMenu: TMainMenu;
    Auswertung1: TMenuItem;
    Bearbeiten1: TMenuItem;
    SchlerLschen1: TMenuItem;
    Schlerbearbeiten1: TMenuItem;
    Auswertung2: TMenuItem;
    Hilfe1: TMenuItem;
    Adminkontaktieren1: TMenuItem;
    NeueKlasseanlegen1: TMenuItem;
    Klasselschen1: TMenuItem;
    Anleitungffnen1: TMenuItem;
    Auswertung3: TMenuItem;
    Klassendern1: TMenuItem;
    ServerSocketLehrer: TServerSocket;
    Label2: TLabel;
    ShapeServerStatus: TShape;
    Label3: TLabel;
    Label4: TLabel;
    EdtSchuelerAnzahl: TEdit;
    BtnBeenden: TButton;
    EdtKlassenName: TEdit;
    EdtBenutzername_Lehrer: TEdit;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Adminkontaktieren1Click(Sender: TObject);
    procedure NeueKlasseanlegen1Click(Sender: TObject);
    procedure ServerSocketLehrerClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ErzeugeGa();
    procedure Addition(x: Integer);
    function Entschluesseln(Text: String) :String;
    procedure GridEinlesen();
    procedure BtnBeendenClick(Sender: TObject);
  
  private
    { Private-Deklarationen }
  public
     Geladene_Klasse: String;
  end;

var
  FormKonsole: TFormKonsole;
  KlassenDatei: TStringList;

implementation

uses Anmeldefenster, Klasse_Anlegen;

{$R *.DFM}

procedure TFormKonsole.FormCreate(Sender: TObject);
  begin
      With StringGridUbersicht do
        begin
           Cells[0,0] := 'Nr.';
           Cells[1,0] := 'Vorname';
           Cells[2,0] := 'Name';
           Cells[3,0] := 'Klasse';
           Cells[4,0] := 'Status';   //Trägt die Bezeichnungen ins Grid ein
        end;
      ServerSocketLehrer.Port := 8080;
  end;

procedure TFormKonsole.FormClose(Sender: TObject;
  var Action: TCloseAction);
  begin
     FormAnmeldung.Close();
  end;

procedure TFormKonsole.Adminkontaktieren1Click(Sender: TObject);
  begin
     showmessage('Lehrerkonsole V0.1' +#10#13+
                 'Copyright © 2013-2014' +#10#13+
                 'OHG-Geesthacht-13b Entwicklerteam' +#10#13+
                 'E-Mail: info@ohg-Lernprogramm.de'); //Entwicklerinformationen
  end;

procedure TFormKonsole.NeueKlasseanlegen1Click(Sender: TObject);
  begin
     FormKlasseAnlegen.ShowModal;
  end;

procedure TFormKonsole.ServerSocketLehrerClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
 var ErrorCode: Integer);
  begin
     showmessage('Server-Fehler' + IntToStr(ErrorCode));
     ShapeServerStatus.Brush.Color := clRed;
     ErrorCode := 0;    //Fehlermeldung bei Server
  end;

function TFormKonsole.Entschluesseln(Text:String): String;
 var i : integer;
  begin
     lenT := length (Text);
     gt := '';
     For i := 1 to lenT do
      begin
         ErzeugeGa();
         addition (i);
         c := Text [i];
         p := pos (c, ga2);
         If p <> 0 then gt := gt + copy (ka, p, 1)
          Else gt := gt +c;
      end;
     Result := gt;       //Das entschlüsselte Wort wird als Result ausgegeben
 end;

procedure TFormKonsole.Addition (x: integer);
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

Procedure TFormKonsole.ErzeugeGa();
 Var Wert1, Wert2: integer;
     i: integer;
     schlZahl: integer;
  Begin
    ga := '';
    schlZahl := ord (schluessel[1]);
    lenA := length(ka);
    For i := 1 to lenA do
     begin
        c := ka[i];
        Wert1 := ord(c);
        Wert2 := ((Wert1-44)*schlZahl mod 79)+44;
        ga := ga + chr(Wert2);
     end;
  end;              //Hier wird das Geheimalphabet aus dem Schlüssel erzeugt

procedure TFormKonsole.GridEinlesen();
 var i,k,z: Integer;
  begin
     KlassenDatei := TStringList.Create(); //Erzeugt die Datei
     Try
       KlassenDatei.LoadFromFile ('TransportOrdner\KlassenNamen\'+
                                   Geladene_Klasse + '.txt'); //Lädt die Datei
       If KlassenDatei.Count = 0 then
        begin                     //falls noch keine Klasse angelegt wurde
          EdtKlassenName.Text := '...';
          EdtSchuelerAnzahl.Text := '...';
          FormKlasseAnlegen.ShowModal;
          Exit;
        end;
       StringGridUbersicht.RowCount := StrToInt(KlassenDatei[0]);
       StringGridUbersicht.ColCount := StrToInt(KlassenDatei[1]);  //Die Form des Grids wird festgelegt
       For i := 0 to (StringGridUbersicht.RowCount) -1 do
        begin
           StringGridUbersicht.Rows[i +1].CommaText := KlassenDatei[i + 2];   //Grid wird beschrieben
        end;
       StringGridUbersicht.RowCount := StringGridUbersicht.RowCount +1;
       For k := 0 to (StringGridUbersicht.RowCount -1)  do
        begin
           If (k <> 0) then StringGridUbersicht.Cells[0,k] := IntToStr (k);
           For z := 0 to 8 do              //schließt die 0-Splate aus!
             StringGridUbersicht.Cells[z+1,k+1] := Entschluesseln(StringGridUbersicht.Cells[z+1,k+1]);
        end;
     Finally                               //Grid wird entschlüsselt
       KlassenDatei.Free;   //Gibt die Liste frei
       EdtSchuelerAnzahl.Text := IntToStr (StringGridUbersicht.RowCount -1);
       If StringGridUbersicht.RowCount < 9 then StringGridUbersicht.RowCount := 9;
      end;       //Weist dem Grid eine Mindestanzahl an Row´s zu!
     EdtKlassenName.Text := Geladene_Klasse;
  end;


procedure TFormKonsole.BtnBeendenClick(Sender: TObject);
 var LastClass_Liste: TStringList;
  begin
     LastClass_Liste := TStringList.Create;
     Try
       LastClass_Liste.Add (Geladene_Klasse);
       LastClass_Liste.SaveToFile ('TransportOrdner\LehrerOrdner'
                                   + EdtBenutzername_Lehrer.Text 
                                   + 'Last_Class.txt');
      Finally
          LastClass_Liste.Free;    //Speichert die zuletz geladene Klasse!
       end;
     FormAnmeldung.Close();
     FormKonsole.Close();
  end;

end.
