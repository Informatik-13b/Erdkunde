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
    procedure FormPaint(Sender: TObject);
    procedure BtnBeendenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure EdtPasswortClick(Sender: TObject);
    procedure DateiVerbindung();
    procedure ErzeugeGA();
    procedure Addition(x: Integer);
    function Entschluesseln(Text: String): String;
    procedure BtnAnmeldungClick(Sender: TObject);
    procedure BtnAnmeldungKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtPasswortKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnCopyClick(Sender: TObject);
    procedure BtnAnlegenClick(Sender: TObject);
  private
    procedure WMWindowPosChanging
              (var msg: TWMWindowPosChanging); message WM_WINDOWPOSCHANGING;
  public

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
  ka ='-./0123456789Ô?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_´abcdefghijklmnopqrstuvwxyz!';
   //Das ',' musste entfernt werden, da es ansonsten Probleme mit der texdatei gegeben hätte!
   //Es handelt sich hierbei um das Klaralphabet!
implementation

uses Leher_Anlegen;

{$R *.DFM}

procedure TFormAnmeldung.FormPaint(Sender: TObject);
  begin
     EdtBenutzername.SetFocus; //setzt den Focus auf das EditFeld
  end;

procedure TFormAnmeldung.BtnBeendenClick(Sender: TObject);
  begin
     Try
       PasswortDatei.Free;     //Die Verbindung wird beendet
       StringGridPasswort.Destroy;   //Das StringGrid wird zerstört,
      Finally                        //um alle unverschlüsselten Daten zu löschen
       Close();
      end;
  end;

procedure TFormAnmeldung.DateiVerbindung ();
 var Feld: String;
     i,k,z: Integer;
  begin
     PasswortDatei := TStringList.Create(); //Erzeugt die Datei
     Try
       PasswortDatei.LoadFromFile ('Datenbank\PasswortDatei.txt');   //Lädt die Datei
       StringGridPasswort.RowCount := StrToInt(PasswortDatei[0]);
       StringGridPasswort.ColCount := 2;               //Die Form des Grids wird festgelegt
       For i := 0 to (StringGridPasswort.RowCount - 1) do
        begin
           StringGridPasswort.Rows[i].CommaText := PasswortDatei[i + 1];   //Grid wird beschrieben
        end;
       For k := 0 to (StringGridPasswort.RowCount) do
        For z := 0 to 2 do
         StringGridPasswort.Cells[k,z] := Entschluesseln(StringGridPasswort.Cells[k,z]);
     Except                          //Grid wird entschlüsselt
      showmessage ('Die Register-Datei fehlt! Bitte wenden Sie sich an den Admin!');
     end;  
  end;

procedure TFormAnmeldung.FormCreate(Sender: TObject);
  begin
     BtnAnlegen.Caption := 'Benutzer anlegen';
     BtnBeenden.Caption := 'Beenden';
     BtnCopy.Caption := 'C';
     BtnCopy.Font.Size := 14;
     BtnAnmeldung.Caption := 'Anmelden';
     EdtBenutzername.Text := '';
     EdtPasswort.Text := '****';
     FormAnmeldung.Formstyle:=fsStayOnTop;
     Schluessel :=  'aLH7wm5HfrU';  //sehr sicherer Schlüssel!!!
     DateiVerbindung();    //Öffnet die Datei Verbindung
     StringGridPasswort.Enabled := False;
     StringGridPasswort.Visible := False; //Grid ist dem Anwender nicht sichtbar
  end;

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
  end;              //Hier wird das Geheimalphabet aus dem Schlüssel erzeugt


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
     Result := gt;       //Das entschlüsselte Wort wird als Result ausgegeben
 end;


procedure TFormAnmeldung.BtnAnmeldungClick(Sender: TObject);
 var Benutzername, Passwort: String;
     i: Integer;
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
                  showmessage('Yeah!');
                  Exit;
               end
              Else begin
                     showmessage('Sie haben ein falsches Passwort eingegeben!');
                     EdtPasswort.Text := '';
                     EdtPasswort.SetFocus;
                     Exit;
                   end;
            end;
           If i = StringGridPasswort.RowCount then
            begin
                showmessage('Ihr Benutzername existiert nicht!');
                EdtPasswort.Text := '';
                EdtBenutzername.SetFocus;
            end;
          end;
     end
    Else showmessage('Eingabe nicht vollständig!'); 
  end;

procedure TFormAnmeldung.BtnAnmeldungKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  begin
      If (Key = VK_RETURN) Then BtnAnmeldung.Click; //wenn Enter gedrückt wird...
  end;

procedure TFormAnmeldung.EdtPasswortKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  begin
     If (Key = VK_RETURN) Then BtnAnmeldung.Click;     //wenn Enter gedrückt wird...
  end;

procedure TFormAnmeldung.BtnCopyClick(Sender: TObject);
  begin
     showmessage('Lehrerkonsole V0.1' +#10#13+
                 'Copyright © 2013-2014' +#10#13+
                 'OHG-Geesthacht-13b Entwicklerteam' +#10#13+
                 'E-Mail: info@ohg-Lernprogramm.de');    //Entwicklerinformationen

  end;

procedure TFormAnmeldung.BtnAnlegenClick(Sender: TObject);
  begin
      If Application.MessageBox('Admin Passwort benötigt,' +#10#13+
                             'um einen neuen Nutzer anzulegen!' +#10#13+
                             'E-Mail: info@ohg-Lernprogramm.de',
                             'Warnung', MB_ICONWARNING or MB_OKCANCEL)
         = IDOK then FormAnlegen.ShowModal;  //Neue Form wird geöffnet, wenn ein
  end;                                       //neuer Lehrer angelegt werden soll

procedure TFormAnmeldung.WMWindowPosChanging(var msg: TWMWindowPosChanging);
  begin
     inherited;
     msg.WindowPos^.flags := msg.WindowPos^.flags or SWP_NOMOVE;
  end;    //Falls versucht wird die Form zu verschieben, wird dies hierdurch verhindert!

end.
