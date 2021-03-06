unit Anmeldefenster;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, jpeg, Grids;

type
  TFormAnmeldung = class(TForm)
    EdtPasswort: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EdtBenutzername: TEdit;
    BtnAnmeldung: TButton;
    BtnBeenden: TButton;
    StringGridPasswort: TStringGrid;
    Image1: TImage;
    BtnCopy: TButton;
    BtnAnlegen: TButton;
    StringGrid_GeladeneKlasse: TStringGrid;
    procedure FormPaint(Sender: TObject);
    procedure BtnBeendenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtPasswortClick(Sender: TObject);
    procedure DateiVerbindung();
    procedure ErzeugeGA();
    procedure Addition(x: Integer);
    function Entschluesseln(Text: String): String;   //Funktion um den Text zu verschl�sselm
    procedure BtnAnmeldungClick(Sender: TObject);
    procedure BtnAnmeldungKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtPasswortKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnCopyClick(Sender: TObject);
    procedure BtnAnlegenClick(Sender: TObject);
  private
      //
  public
      //
  end;

var
  FormAnmeldung: TFormAnmeldung;
  ga, ga2: string;
  lenA : integer;
  kt, gt : string;
  lenT, p : integer;
  c : char;
  schl: string;
  LenSchl: integer;
  Schluessel: String;
  PasswortDatei: TStringList;

Const
  ka ='-./0123456789�?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_�abcdefghijklmnopqrstuvwxyz!';
   //Das ',' musste entfernt werden, da es ansonsten Probleme mit der Texdatei gegeben h�tte!
   //Es handelt sich hierbei um das Klaralphabet!
implementation

uses Leher_Anlegen, Konsole, Klasse_Anlegen;

{$R *.DFM}

procedure TFormAnmeldung.FormPaint(Sender: TObject);
  begin
     EdtBenutzername.SetFocus; //setzt den Focus auf das EditFeld
  end;

procedure TFormAnmeldung.BtnBeendenClick(Sender: TObject);
  begin
     Try
       PasswortDatei.Free;     //Die Verbindung wird beendet
       StringGridPasswort.Destroy;   //Das StringGrid wird zerst�rt,
      Finally                        //um alle unverschl�sselten Daten zu l�schen
       Close();
      end;
  end;

procedure TFormAnmeldung.DateiVerbindung ();
 var i,k,z: Integer;
  begin
     PasswortDatei := TStringList.Create(); //Erzeugt die Datei
     Try
       PasswortDatei.LoadFromFile ('Datenbank\PasswortDateiL.txt');   //L�dt die Datei
       StringGridPasswort.RowCount := StrToInt(PasswortDatei[0]);
       StringGridPasswort.ColCount := 2;               //Die Form des Grids wird festgelegt
       For i := 0 to (StringGridPasswort.RowCount -1) do
        begin
           StringGridPasswort.Rows[i].CommaText := PasswortDatei[i + 1];   //Grid wird beschrieben
        end;
       For k := 0 to (StringGridPasswort.RowCount -1) do
        For z := 0 to 1 do
         StringGridPasswort.Cells[z,k] := Entschluesseln(StringGridPasswort.Cells[z,k]);
     Except                          //Grid wird entschl�sselt
      showmessage ('Die Register-Datei fehlt! Bitte wenden Sie sich an den Admin!');
     end;
  end;

procedure TFormAnmeldung.FormCreate(Sender: TObject);
  begin
     Position:=poScreenCenter;
     BtnAnlegen.Caption := 'Benutzer anlegen';
     BtnBeenden.Caption := 'Beenden';
     BtnCopy.Caption := 'C';
     BtnCopy.Font.Size := 14;
     BtnAnmeldung.Caption := 'Anmelden';
     EdtBenutzername.Text := '';
     EdtPasswort.Text := '****';
     FormAnmeldung.Formstyle:=fsStayOnTop;
     Schluessel :=  'aLH7wm5HfrU';  //sehr sicherer Schl�ssel!!!
     DateiVerbindung();    //�ffnet die Datei Verbindung
     StringGridPasswort.Enabled := False;
     StringGridPasswort.Visible := False; //Grid ist dem Anwender nicht sichtbar
     RemoveMenu(GetSystemMenu(handle, false), SC_MOVE, MF_BYCOMMAND);
     RemoveMenu(GetSystemMenu(handle, false),SC_SIZE, MF_BYCOMMAND);
     EdtBenutzername.MaxLength := 25;
     EdtPasswort.MaxLength := 25;
  end;    //verhindert das verschieben der Form!

procedure TFormAnmeldung.EdtPasswortClick(Sender: TObject);
  begin
     If EdtPasswort.Text = '****' then EdtPasswort.Text := '';
  end;

Procedure TFormAnmeldung.ErzeugeGa();
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
  end;              //Hier wird das Geheimalphabet aus dem Schl�ssel erzeugt


procedure TFormAnmeldung.addition (x: integer);
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


function TFormAnmeldung.Entschluesseln(Text:String): String;
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
     Result := gt;       //Das entschl�sselte Wort wird als Result ausgegeben
 end;


procedure TFormAnmeldung.BtnAnmeldungClick(Sender: TObject);
 var Benutzername, Passwort: String;
     i: Integer;
     GeladeneKlassen_Liste: TStringList;
  begin
     If (EdtBenutzername.Text <> '') and (EdtPasswort.Text <> '') then
      begin
         Benutzername := EdtBenutzername.Text;
         Passwort := EdtPasswort.Text;      //Daten werden eingelsen
         For i := 0 to StringGridPasswort.RowCount do
          begin                 //Grid wird nach dem Benutzernamen durchsucht
           If Benutzername = StringGridPasswort.Cells[0,i] then
            begin
              If Passwort = StringGridPasswort.Cells[1,i] then
               begin          //nur wenn was Passwort richttig ist ->
                  FormKonsole.Visible := True;
                  FormAnmeldung.Visible := False;
                  FormKonsole.EdtBenutzername_Lehrer.Text := Benutzername;
                  GeladeneKlassen_Liste := TStringList.Create;
                  Try
                    GeladeneKlassen_Liste.LoadFromFile('TransportOrdner\LehrerOrdner\'
                                                      + Benutzername + '\Last_Class.txt');
                    StringGrid_GeladeneKlasse.Rows[0].CommaText := GeladeneKlassen_Liste[0];
                    If (StringGrid_GeladeneKlasse.Cells[0,0] <> 'Exit') then  //nur, wenn vorhanden
                      begin
                         FormKonsole.Geladene_Klasse := StringGrid_GeladeneKlasse.Cells[0,0];
                         FormKonsole.KlassenNamen_Finden;
                         FormKonsole.GridEinlesen ();
                         FormKonsole.ComboBoxKlassenNamen.SetFocus;
                         //FormKonsole.BtnServerAktion.Click; //aktiviert den Server
                      end         //initialisiert die Konsolen-Form
                     Else FormKlasseAnlegen.Visible := True;    
                  Finally
                    GeladeneKlassen_Liste.Free;
                   end;
                  Try
                    FormAnlegen.Close();  //Schlie�t diese Form
                  Finally
                   end;
                  Exit; //verl�sst die Schleife!
               end
              Else begin
                     showmessage('Sie haben ein falsches Passwort eingegeben!');
                     EdtPasswort.Text := '';
                     EdtPasswort.SetFocus; //Falls falsches Passwort eingeben wurde
                     Exit;
                   end;
            end;
           If i = StringGridPasswort.RowCount then
            begin
                showmessage('Ihr Benutzername existiert nicht!');
                EdtPasswort.Text := '';
                EdtBenutzername.SetFocus;  //Falscher Benutzername
            end;
          end;
     end
    Else showmessage('Eingabe nicht vollst�ndig!'); 
  end;

procedure TFormAnmeldung.BtnAnmeldungKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  begin
      If (Key = VK_RETURN) Then BtnAnmeldung.Click; //wenn Enter gedr�ckt wird...
  end;

procedure TFormAnmeldung.EdtPasswortKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  begin
     If (Key = VK_RETURN) Then BtnAnmeldung.Click;     //wenn Enter gedr�ckt wird...
  end;

procedure TFormAnmeldung.BtnCopyClick(Sender: TObject);
  begin
     showmessage('Lehrerkonsole V0.1' +#10#13+
                 'Copyright � 2013-2014' +#10#13+
                 'Benutzung auf eigene Gefahr!' +#10#13+
                 'OHG-Geesthacht-13b Entwicklerteam' +#10#13+
                 'E-Mail: info@ohg-Lernprogramm.de');    //Entwicklerinformationen

  end;

procedure TFormAnmeldung.BtnAnlegenClick(Sender: TObject);
  begin
      If Application.MessageBox('Admin Passwort ben�tigt,' +#10#13+
                             'um einen neuen Nutzer anzulegen!' +#10#13+
                             'E-Mail: info@ohg-Lernprogramm.de',
                             'Warnung', MB_ICONWARNING or MB_OKCANCEL)
         = IDOK then FormAnlegen.ShowModal;  //Neue Form wird ge�ffnet, wenn ein
  end;                                       //neuer Lehrer angelegt werden soll



end.
