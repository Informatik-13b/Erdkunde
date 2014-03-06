unit Konsole;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Menus, StdCtrls, ScktComp, ExtCtrls, ShellApi;

type
  TFormKonsole = class(TForm)
    StringGridUbersicht: TStringGrid;
    Label1: TLabel;
    MainMenu: TMainMenu;
    Auswertung1: TMenuItem;
    Bearbeiten1: TMenuItem;
    SchlerLschen1: TMenuItem;
    Auswertung2: TMenuItem;
    Hilfe1: TMenuItem;
    Adminkontaktieren1: TMenuItem;
    NeueKlasseanlegen1: TMenuItem;
    Klasselschen1: TMenuItem;
    Anleitungffnen1: TMenuItem;
    ServerSocketLehrer: TServerSocket;
    Label2: TLabel;
    ShapeServerStatus: TShape;
    Label3: TLabel;
    Label4: TLabel;
    EdtSchuelerAnzahl: TEdit;
    BtnBeenden: TButton;
    EdtBenutzername_Lehrer: TEdit;
    Label5: TLabel;
    ComboBoxKlassenNamen: TComboBox;
    BtnServerAktion: TButton;
    BtnModus_Lehrer: TButton;
    Label6: TLabel;
    EdtSchuelerOnline: TEdit;
    BtnKlasseChange: TButton;
    EdtNachricht: TEdit;
    EdtPunkte: TEdit;
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
    procedure KlassenNamen_Finden();
    procedure ComboBoxKlassenNamenChange(Sender: TObject);
    procedure BtnServerAktionClick(Sender: TObject);
    procedure BtnKlasseChangeClick(Sender: TObject);
    procedure StringGridUbersichtDblClick(Sender: TObject);
    procedure Klasselschen1Click(Sender: TObject);
    procedure Anleitungffnen1Click(Sender: TObject);
    procedure Bearbeiten1Click(Sender: TObject);
    procedure BtnModus_LehrerClick(Sender: TObject);
    procedure ServerSocketLehrerClientRead(Sender: TObject;
      Socket: TCustomWinSocket);

  private
    { Private-Deklarationen }
  public
     Geladene_Klasse: String;
     Anzahl_Online: Integer; 
  end;

var
  FormKonsole: TFormKonsole;
  KlassenDatei: TStringList;
  ServerStatus: Boolean;
  Anzahl_Klassen: Integer;
  ga, ga2: string;
  lenA : integer;
  lenT, p : integer;
  c : char;
  schl: string;
  LenSchl: integer;
  Schluessel: String;

const
  ka ='-./0123456789�?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_�abcdefghijklmnopqrstuvwxyz!';
   //Das ',' musste entfernt werden, da es ansonsten Probleme mit der texdatei gegeben h�tte!
   //Es handelt sich hierbei um das Klaralphabet!

implementation

uses Anmeldefenster, Klasse_Anlegen, Klasse_Loschen, Schuler_Hinzufugen,
  Stadt_Auswahl, Menu_Spiel;

{$R *.DFM}

procedure TFormKonsole.FormCreate(Sender: TObject);
  begin
      With StringGridUbersicht do
        begin
           Cells[0,0] := 'Nr.';
           Cells[2,0] := 'Vorname';
           Cells[1,0] := 'Name';
           Cells[3,0] := 'ON';
           Cells[4,0] := 'Klasse';   //Tr�gt die Bezeichnungen ins Grid ein
           Cells[5,0] := 'J/M';
        end;
      ServerSocketLehrer.Port := 8080;
      ComboBoxKlassenNamen.Sorted := True;  //Sortiert die Eintr�ge in der CB
      ComboBoxKlassenNamen.Style := csDropDownList;
      ShapeServerStatus.Brush.Color := clYellow;
      Anzahl_Online := 0;
      BtnBeenden.Caption := 'Beenden';
      BtnModus_Lehrer.Caption := 'Lehrer-Modus';
      BtnServerAktion.Caption := 'Server �ffnen';
      EdtBenutzername_Lehrer.Enabled := False;
      EdtSchuelerAnzahl.Enabled := False;
      EdtSchuelerOnline.Enabled := False;
      EdtSchuelerOnline.Text := '0';
      BtnKlasseChange.Enabled := False;
      BtnKlasseChange.Caption := 'Klasse �ndern';
      ServerStatus := False;
      BtnModus_Lehrer.Enabled := True;         //Entwicklung!!!!
      EdtSchuelerOnline.Brush.Color := clLime;
      Schluessel := 'aLH7wm5HfrU';  //sehr sicherer Schl�ssel!!!
      EdtNachricht.Visible := False;
      EdtNachricht.Enabled := False;
      EdtPunkte.Visible := False;
  end;

procedure TFormKonsole.FormClose(Sender: TObject; var Action: TCloseAction);
 var LastClass_Liste: TStringList;
  begin
     LastClass_Liste := TStringList.Create;
     Try
       LastClass_Liste.Add (Geladene_Klasse);
       LastClass_Liste.SaveToFile ('TransportOrdner\LehrerOrdner\'
                                   + EdtBenutzername_Lehrer.Text
                                   + '\Last_Class.txt');
      Finally
        LastClass_Liste.Free;    //Speichert die zuletz geladene Klasse!
       end;
     FormAnmeldung.Close();
     FormSchuler_Add.Close();
  end;

procedure TFormKonsole.Adminkontaktieren1Click(Sender: TObject);
  begin
     showmessage('Lehrerkonsole V0.1' +#10#13+
                 'Copyright � 2013-2014' +#10#13+
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
     Result := gt;       //Das entschl�sselte Wort wird als Result ausgegeben
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
  end;              //Hier wird das Geheimalphabet aus dem Schl�ssel erzeugt

procedure TFormKonsole.GridEinlesen();
 var i,k,z,l: Integer;
  begin
     For l := 1 to StringGridUbersicht.RowCount do
       begin
          StringGridUbersicht.Rows[l].Clear;
       end;       // leert das StringGrid auf der Form
     KlassenDatei := TStringList.Create(); //Erzeugt die Datei
     Try
       KlassenDatei.LoadFromFile ('TransportOrdner\KlassenNamen\'+
                                   Geladene_Klasse + '.txt'); //L�dt die Datei
       If KlassenDatei.Count = 0 then
        begin                     //falls noch keine Klasse angelegt wurde
          ComboBoxKlassenNamen.Text := '...';
          EdtSchuelerAnzahl.Text := '...';
          FormKlasseAnlegen.ShowModal;
          Exit;
        end;
       StringGridUbersicht.RowCount := StrToInt(KlassenDatei[0]);
       StringGridUbersicht.ColCount := StrToInt(KlassenDatei[1]);  //Die Form des Grids wird festgelegt
       For i := 0 to (StringGridUbersicht.RowCount) -1 do
        begin
           StringGridUbersicht.Rows[i +1].CommaText := KlassenDatei[i + 2];   
        end;                    // Grid wird beschrieben
       StringGridUbersicht.RowCount := StringGridUbersicht.RowCount +1;
       For k := 0 to (StringGridUbersicht.RowCount -1)  do
        begin
           If (k <> 0) then StringGridUbersicht.Cells[0,k] := IntToStr (k);
           For z := 0 to 6 do              //schlie�t die 0-Splate aus!
             StringGridUbersicht.Cells[z+1,k+1] := Entschluesseln(StringGridUbersicht.Cells[z+1,k+1]);
        end;
     Finally                               //Grid wird entschl�sselt
       KlassenDatei.Free;   //Gibt die Liste frei
       EdtSchuelerAnzahl.Text := IntToStr (StringGridUbersicht.RowCount -1);
      end;       
     With ComboBoxKlassenNamen do ItemIndex := Items.IndexOf (Geladene_Klasse);
  end;                 //weist der ComboBox die Klasse zu


procedure TFormKonsole.BtnBeendenClick(Sender: TObject);
 var LastClass_Liste: TStringList;
  begin
     LastClass_Liste := TStringList.Create;
     Try
       LastClass_Liste.Add (Geladene_Klasse);
       LastClass_Liste.SaveToFile ('TransportOrdner\LehrerOrdner\'
                                   + EdtBenutzername_Lehrer.Text
                                   + '\Last_Class.txt');
      Finally
         LastClass_Liste.Free;    //Speichert die zuletz geladene Klasse!
       end;
     FormAnmeldung.Close();
     FormKonsole.Close();
  end;


procedure TFormKonsole.KlassenNamen_Finden();
 var Suche : TSearchRec;
     Verzeichnis   : String;
     Text, TextA: String;
     Laenge, i: Integer;
  begin
      ComboBoxKlassenNamen.Clear;
      Anzahl_Klassen := 1;
      Verzeichnis := 'Transportordner\KlassenNamen\';  //Verzeichnis wird festgelegt
      If FindFirst(Verzeichnis + '*.*' , faAnyFile, Suche) = 0 then
      Try Repeat   //Solange noch Dateien gefunden werden
        TextA := '';
        If (Suche.Attr and faArchive) = faArchive then
         begin
            Text := Suche.Name;
            Laenge := length(Text);
            For i := 1 to (Laenge - 4) do TextA := TextA + Text[i];
            ComboBoxKlassenNamen.Items.Add(TextA);  //Die Datei-Endung wird gel�scht
            Inc(Anzahl_Klassen);
         end;
       Until FindNext(Suche) <> 0;
      Finally
        SysUtils.FindClose(Suche);
       end;
  end;


procedure TFormKonsole.ComboBoxKlassenNamenChange(Sender: TObject);
  begin
     If Geladene_Klasse <> ComboBoxKlassenNamen.Items [ComboBoxKlassenNAmen.ItemIndex]
      then BtnKlasseChange.Enabled := True //Nur wenn eine �nderung stattgefunden hat
     Else BtnKlasseChange.Enabled := False;
  end;

procedure TFormKonsole.BtnServerAktionClick(Sender: TObject);
  begin
     BtnServerAktion.Enabled := False;
     If ServerStatus = False then
       begin
          ServerSocketLehrer.Open;
          ServerSocketLehrer.Active := True;
          ShapeServerStatus.Brush.Color := clLime;
          BtnServerAktion.Caption := 'Server deaktivieren';
          ServerStatus := True;        //Aktiviert den Server
          BtnModus_Lehrer.Enabled := True;
       end
     Else If Application.MessageBox('Wollen Sie den Server wirklich beenden?'
                                    +#10#13+
                                    'Alle Verbindungen gehen verloren!!!',
                                    'Warnung', MB_ICONWARNING or MB_OKCANCEL)
      = IDOK then             //Sicherheitsabfrage
               begin
                  ServerSocketLehrer.Active := False;
                  ShapeServerStatus.Brush.Color := clRed;
                  BtnServerAktion.Caption := 'Server aktivieren';
                  ServerStatus := False;    //Deaktiviert den Server
                  BtnModus_Lehrer.Enabled := False;
               end;
     BtnServerAktion.Enabled := True;
  end;

procedure TFormKonsole.BtnKlasseChangeClick(Sender: TObject);
  begin
     If ServerStatus = True then
      begin
       If Application.MessageBox('Wollen Sie den Server wirklich beenden?'
                                +#10#13+
                                'Alle Verbindungen gehen verloren!!!',
                                'Warnung', MB_ICONWARNING or MB_OKCANCEL)
        = IDOK then             //Sicherheitsabfrage
          begin
             Geladene_Klasse := ComboBoxKlassenNAmen.Items [ComboBoxKlassenNamen.ItemIndex];
             GridEinlesen();
             BtnKlasseChange.Enabled := False;
             ServerStatus := False;
             BtnServerAktion.Caption := 'Server aktivieren';
             ServerSocketLehrer.Active := False;
          end;
      end
      Else begin
              Geladene_Klasse := ComboBoxKlassenNAmen.Items [ComboBoxKlassenNamen.ItemIndex];
              GridEinlesen();
              BtnKlasseChange.Enabled := False;
              ServerStatus := False;
              BtnServerAktion.Caption := 'Server aktivieren';
              ServerSocketLehrer.Active := False;
           end;
  end;

procedure TFormKonsole.StringGridUbersichtDblClick(Sender: TObject);
  begin
     //Doppelklick
  end;

procedure TFormKonsole.Klasselschen1Click(Sender: TObject);
 var i: Integer;
  begin
      With FormKlasseLoschen.StringGridKlassenAuswahl do
        begin
          RowCount := Anzahl_Klassen;
          For i := 1 to (RowCount -1) do Cells [0,i] := IntToStr (i);
        end;
      FormKonsole.Visible := False;
      FormKlasseLoschen.Visible := True;
      FormKlasseLoschen.BringToFront;  // holt die Form in den Vordergrund
      FormKlasseLoschen.KlassenNamen_Finden;

  end;

procedure TFormKonsole.Anleitungffnen1Click(Sender: TObject);
  begin
     ShellExecute(Application.Handle, 'open', PChar
                 ('Transportordner\Anleitung_Lehrer.txt'), nil, nil, SW_NORMAL);
  end;       //�ffnet die Hilfe Datei!!!

procedure TFormKonsole.Bearbeiten1Click(Sender: TObject);
  begin
     With FormSchuler_Add do
       begin
          EdtName.Text := '...';
          EdtVorname.Text := '...';
          ShapeServerStatus.Brush.Color := clYellow;
          BtnFreischalten.Enabled := True;
          BtnAdd.Enabled := False;
          KlassenNamen_Finden();
          FormSchuler_Add.Visible := True;
          FormSchuler_Add.BringToFront;
       end;
  end;

procedure TFormKonsole.BtnModus_LehrerClick(Sender: TObject);
  begin
     FormStadt_Auswahl.Show;
     FormStadt_Auswahl.BringToFront;
     FormStadt_Auswahl.OrteEintragen;
     FormStadt_Auswahl.EdtKlasse.Text := Geladene_Klasse;
     FormStadt_Auswahl.EdtAnzahl.Text := '0';
     FormKonsole.Visible := False;
  end;

procedure TFormKonsole.ServerSocketLehrerClientRead(Sender: TObject;
 Socket: TCustomWinSocket);
 var Nachricht,x,h: String;
     Index,i,k,l,z,m: Integer;
  begin
     //If ServerSocketLehrer.Active Connections <> 0
      // then BtnModus_Lehrer.Enabled := True;
     EdtNachricht.Text := '';
     Nachricht := Socket.ReceiveText;
     If (Nachricht[1] = 'i') and (length(Nachricht) = 3) then
       begin
          EdtSchuelerOnline.TExt := IntToStr(ServerSocketLehrer.Socket.ActiveConnections);
          EdtNachricht.Text := Nachricht;
          x := EdtNachricht.Text;
          EdtNachricht.Clear;
          For z := 2 to 3 do EdtNachricht.Text := EdtNachricht.Text + x[z];
          Index := StrToInt(EdtNachricht.Text);
          For l := 1 to StringGridUbersicht.RowCount do
            begin
               If StringGridUbersicht.Cells[6,l] = IntToStr(Index) then
                 begin
                    StringGridUbersicht.Cells[3,l] := 'X';
                 end;
            end;
       end;
     If (Nachricht[1] = 'i') and (Nachricht[4] = 'e') then
       begin
          EdtNachricht.Text := Nachricht;
          x := EdtNachricht.Text;
          EdtNachricht.Clear;
          For i := 2 to 3 do
            EdtNachricht.Text := EdtNachricht.Text + x[i];
          Index := StrToInt(EdtNachricht.Text);
          EdtPunkte.Text := Nachricht;
          h := EdtPunkte.Text;
          EdtPunkte.Clear;
          For k := 5 to 7 do
            EdtPunkte.Text := EdtPunkte.Text + h[k];
          With FormSpiel do
            begin
               For m := 1 to StringGridPunkte.RowCount -1 do
                 begin
                    If StringGridPunkte.Cells[4,m] = IntToStr (Index) then
                      begin
                         StringGridPunkte.Cells[2,m] := EdtPunkte.Text;
                      end;
                 end;

            end;
     
       end;
       end;
 

end.
