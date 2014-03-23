unit Konsole;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, Menus, StdCtrls, ScktComp, ExtCtrls, ShellApi,WinSock,ComCtrls;

type
  TFormKonsole = class(TForm)
    StringGridUbersicht: TStringGrid;
    Label1: TLabel;
    MainMenu: TMainMenu;
    Auswertung1: TMenuItem;
    Bearbeiten1: TMenuItem;
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
    Label7: TLabel;
    EdtIP: TEdit;
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
    function GetLocalIPAddress : String; 
    procedure ServerSocketLehrerClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);


  private
    { Private-Deklarationen }
  public
     Geladene_Klasse: String;
     Anzahl_Online, Stat_Anzahl: Integer;
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
  ka ='-./0123456789Ô?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_´abcdefghijklmnopqrstuvwxyz!';
   //Das ',' musste entfernt werden, da es ansonsten Probleme mit der texdatei gegeben hätte!
   //Es handelt sich hierbei um das Klaralphabet!

implementation

uses Anmeldefenster, Klasse_Anlegen, Klasse_Loschen, Schuler_Hinzufugen,
  Stadt_Auswahl, Menu_Spiel, Leher_Anlegen;

{$R *.DFM}

procedure TFormKonsole.FormCreate(Sender: TObject);
  begin
      Position:=poScreenCenter;   // Mitte des Fensters
      With StringGridUbersicht do
        begin
           Cells[0,0] := 'Nr.';
           Cells[2,0] := 'Vorname';
           Cells[1,0] := 'Name';
           Cells[3,0] := 'ON';
           Cells[4,0] := 'Klasse';   //Trägt die Bezeichnungen ins Grid ein
           Cells[5,0] := 'J/M';
        end;
      ServerSocketLehrer.Port := 8080;
      ComboBoxKlassenNamen.Sorted := True;  //Sortiert die Einträge in der CB
      ComboBoxKlassenNamen.Style := csDropDownList;
      ShapeServerStatus.Brush.Color := clYellow;
      Anzahl_Online := 0;
      BtnBeenden.Caption := 'Beenden';
      BtnModus_Lehrer.Caption := 'Lehrer-Modus';
      BtnServerAktion.Caption := 'Server Öffnen';
      EdtBenutzername_Lehrer.Enabled := False;
      EdtSchuelerAnzahl.Enabled := False;
      EdtSchuelerOnline.Enabled := False;
      EdtSchuelerOnline.Text := '0';
      BtnKlasseChange.Enabled := False;
      BtnKlasseChange.Caption := 'Klasse ändern';
      ServerStatus := False;
      BtnModus_Lehrer.Enabled := True;         //Entwicklung!!!!
      EdtSchuelerOnline.Brush.Color := clLime;
      Schluessel := 'aLH7wm5HfrU';  //sehr sicherer Schlüssel!!!
      EdtNachricht.Visible := False;
      EdtNachricht.Enabled := False;
      EdtPunkte.Visible := False;
      BtnModus_Lehrer.Enabled := False;
      RemoveMenu(GetSystemMenu(handle, false), SC_MOVE, MF_BYCOMMAND);
      EdtIp.Text := GetLocalIPAddress;
      EdtIp.Enabled := False;
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
                 'Copyright © 2013-2014' +#10#13+
                 'OHG-Geesthacht-13b Entwicklerteam' +#10#13+
                 'E-Mail: info@ohg-Lernprogramm.de'); //Entwicklerinformationen
  end;

procedure TFormKonsole.NeueKlasseanlegen1Click(Sender: TObject);
 var i, Zahl: Integer;
  begin
     If ServerSocketLehrer.Active = True then
       begin
          If Application.MessageBox('Spiele-Server bereits geöffnet!' +#10+#13+
                                    'Soll dieser geschlossen werden?' +#10#13+
                                    '-> notwendig für Klassenanmeldung!',
                                    'Warnung', MB_ICONWARNING or MB_OKCANCEL)
             = IDOK then begin
                            FormKlasseAnlegen.ShowModal;
                            Zahl := ServerSocketLehrer.Socket.ActiveConnections;
                            For i := 0 to Zahl -1 do
                              begin
                                 ServerSocketLehrer.Socket.SendText('close');
                              end;        //Bestehende Verbidnugen werden geschlossen!
                            ServerSocketLehrer.Active := False;
                         end;
       end
      Else FormKlasseAnlegen.ShowModal;
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
 var i,k,z,l: Integer;
  begin
     For l := 1 to StringGridUbersicht.RowCount do
       begin
          StringGridUbersicht.Rows[l].Clear;
       end;       // leert das StringGrid auf der Form
     KlassenDatei := TStringList.Create(); //Erzeugt die Datei
     Try
       KlassenDatei.LoadFromFile ('TransportOrdner\KlassenNamen\'+
                                   Geladene_Klasse + '.txt'); //Lädt die Datei
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
           For z := 0 to 6 do              //schließt die 0-Splate aus!
             StringGridUbersicht.Cells[z+1,k+1] := Entschluesseln(StringGridUbersicht.Cells[z+1,k+1]);
        end;
     Finally                               //Grid wird entschlüsselt
       KlassenDatei.Free;   //Gibt die Liste frei
       EdtSchuelerAnzahl.Text := IntToStr (StringGridUbersicht.RowCount -1);
      end;
     With ComboBoxKlassenNamen do ItemIndex := Items.IndexOf (Geladene_Klasse);
     StringGridUbersicht.Row := 1;
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
            ComboBoxKlassenNamen.Items.Add(TextA);  //Die Datei-Endung wird gelöscht
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
      then BtnKlasseChange.Enabled := True //Nur wenn eine Änderung stattgefunden hat
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
             ShapeServerStatus.Brush.Color := clyellow;
          end;
      end
      Else begin
              Geladene_Klasse := ComboBoxKlassenNAmen.Items [ComboBoxKlassenNamen.ItemIndex];
              GridEinlesen();
              BtnKlasseChange.Enabled := False;
              ServerStatus := False;
              BtnServerAktion.Caption := 'Server aktivieren';
              ServerSocketLehrer.Active := False;
              ShapeServerStatus.Brush.Color := clyellow;
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
  end;       //öffnet die Hilfe Datei!!!

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
          FormSchuler_Add.ComboBoxKlassenNamen.ItemIndex := 0;
       end;
  end;

procedure TFormKonsole.BtnModus_LehrerClick(Sender: TObject);
  begin
     FormStadt_Auswahl.Show;
     FormStadt_Auswahl.BringToFront;
     FormStadt_Auswahl.OrteEintragen;
     FormStadt_Auswahl.EdtKlasse.Text := Geladene_Klasse;
     FormStadt_Auswahl.EdtAnzahl.Text := '0';
     FormStadt_Auswahl.EdtOnline.Text := EdtSchuelerOnline.Text;
     FormKonsole.Visible := False;
  end;
 
procedure TFormKonsole.ServerSocketLehrerClientRead(Sender: TObject;
 Socket: TCustomWinSocket);
 var Nachricht,x,h: String;
     Index,i,k,l,z,m,Gesamtpunkte: Integer;
  begin
     EdtNachricht.Text := '';
     Nachricht := Socket.ReceiveText;
     If (Nachricht[1] = 'i') and (length(Nachricht) = 3) then
       begin                         // Nur wenn Verbindung hergestellt wird!!!
          EdtSchuelerOnline.TExt := IntToStr(ServerSocketLehrer.Socket.ActiveConnections);
          FormStadt_Auswahl.EdtOnline.Text := IntToStr(ServerSocketLehrer.Socket.ActiveConnections);
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
       begin                         //Abfrage, ob Entfernung gesendet wurde!!!
          EdtNachricht.Text := Nachricht;
          x := EdtNachricht.Text;
          EdtNachricht.Clear;
          For i := 2 to 3 do
            EdtNachricht.Text := EdtNachricht.Text + x[i];
          Index := StrToInt(EdtNachricht.Text);
          EdtPunkte.Text := Nachricht;
          h := EdtPunkte.Text;
          EdtPunkte.Clear;
          For k := 5 to 7 do EdtPunkte.Text := EdtPunkte.Text + h[k];
          With FormSpiel do
            begin
               For m := 1 to StringGridPunkte.RowCount -1 do
                 begin
                    If StringGridPunkte.Cells[4,m] = IntToStr (Index) then
                      begin
                         StringGridPunkte.Cells[2,m] := EdtPunkte.Text;
                         Gesamtpunkte := StrToInt (StringGridPunkte.Cells[2,m])
                                         + StrToInt(StringGridPunkte.Cells[3,m]);
                         StringGridPunkte.Cells[3,m] := IntToStr (Gesamtpunkte);
                         If FormSpiel.Spielen = True then FormSpiel.InsertionSort();
                      end;
                 end;

            end;
          Stat_Anzahl := Stat_Anzahl +1;
          FormSpiel.ProgressBarStand.Position :=Stat_Anzahl;
          If Stat_Anzahl = ServerSocketLehrer.Socket.ActiveConnections then
            begin
               FormSpiel.BtnAktion.Enabled := True;
               showmessage('Alle Schüler haben geantwortet!');  //Ende der Runde!
               FormSpiel.Spielen := False;
               FormSpiel.InsertionSort;
            end;
       end;
  end;

function TFormKonsole.GetLocalIpAddress : string;
 type pu_long = ^u_long;
 var varTWSAData : TWSAData;
     varPHostEnt : PHostEnt;
     varTInAddr : TInAddr;
     namebuf : Array[0..255] of char;
     fd : integer;
     rc : integer;
  begin
      result := '';
      rc := WSAStartup($101,varTWSAData);
      if rc <> 0 then exit;
      gethostname(namebuf,sizeof(namebuf));
      varPHostEnt := gethostbyname(namebuf);
      varTInAddr.S_addr := u_long(pu_long(varPHostEnt^.h_addr_list^)^);
      result := inet_ntoa(varTInAddr);
      fd := WinSock.Socket( PF_INET, SOCK_STREAM, 0 );
      if fd = INVALID_SOCKET then
      exit;
      WSACleanup;  //Mit dieser Funktion wird die IP-Adresse des Users ausgelsen
  end;


procedure TFormKonsole.ServerSocketLehrerClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
 var i,k: Integer;
  begin                       //Falls die Verbindung unterbrochen wird!!!
     EdtSchuelerOnline.Text := IntToStr(ServerSocketLehrer.Socket.ActiveConnections);
     FormStadt_Auswahl.EdtOnline.Text := EdtSchuelerOnline.Text;
     For k := 1 to StringGridUbersicht.RowCount -1 do
       begin
          StringGridUbersicht.Cells[3,k] := '';
       end;
     For i := 0 to ServerSocketLehrer.Socket.ActiveConnections do
       begin
          ServerSocketLehrer.Socket.Connections[i].SendText('NewIndex');
       end;            //Es wird überprüft, wer noch online ist!
  end;



end.
