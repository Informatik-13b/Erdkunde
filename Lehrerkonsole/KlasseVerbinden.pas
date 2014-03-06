unit KlasseVerbinden;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ScktComp, WinSock, ComCtrls, ShellAPI, Grids;

type
  TFormKlasseVerbinden = class(TForm)
    LabelAnweisung: TLabel;
    Label1: TLabel;
    EdtIPAdresse: TEdit;
    Label2: TLabel;
    EdtSchueleranzahl: TEdit;
    Label3: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    EdtSchuelerVorname: TEdit;
    Label4: TLabel;
    EdtSchuelerNachname: TEdit;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    ShapeServerStatus: TShape;
    BtnBestaetigen: TButton;
    ProgressBarFortschritt: TProgressBar;
    Label8: TLabel;
    BtnAbbrechen: TButton;
    BtnCopy: TButton;
    Label9: TLabel;
    EdtKlassenname: TEdit;
    ServerSocketAnmeldung: TServerSocket;
    StringGridKlassenNamen: TStringGrid;
    Memo: TMemo;
    EdtPos: TEdit;
    procedure FormCreate(Sender: TObject);
    function GetLocalIpAddress : string;
    procedure BtnAbbrechenClick(Sender: TObject);
    procedure BtnCopyClick(Sender: TObject);
    procedure ServerSocketAnmeldungClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ServerSocketAnmeldungClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure BtnBestaetigenClick(Sender: TObject);
    procedure DateiVerbindung();
    procedure Addition (x: Integer);
    procedure ErzeugeGA();
    procedure SchreibeKlassenDatei();
    procedure IP_DateiSchreiben();
  private
     //
  public
     PositionGrid: Integer;
  end;

var
  FormKlasseVerbinden: TFormKlasseVerbinden;
  KlassenNamenDatei: TStringList;
  Geschlecht: String;
  ga, ga2: string;
  lenA : integer;
  kt, gt : string;
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

uses Klasse_Anlegen, Konsole;

{$R *.DFM}

procedure TFormKlasseVerbinden.FormCreate(Sender: TObject);
 var H: THandle;
  begin
     //ServerSocketAnmeldung.Port := 8080;  //Port wird zugewiesen
     //ServerSocketAnmeldung.Active := True;
     H := GetSystemMenu(Handle, False);
     If H <> 0 then
      begin
         DeleteMenu(H, SC_CLOSE, MF_BYCOMMAND);
         DrawMenuBar(Handle);           //Der Close-Button wird deaktiviert
      end;

     RemoveMenu(GetSystemMenu(handle, false), SC_MOVE, MF_BYCOMMAND);
     RemoveMenu(GetSystemMenu(handle, false),SC_SIZE, MF_BYCOMMAND);
         //verhindert das Verschieben deer Form! Sie ist im Vordergrund!
     LabelAnweisung.Caption :=
      ('Achtung: Jeder Schüler muss sich einzeln anmelden!' +#10#13+
      '1. Lassen Sie einen beliebigen Schüler die Verbindung herstellen.' +#10#13+
      '2. Sobald eine Verbindung zustande kommt, wird dies angezeigt.'
      +#10#13+ '3. Überprüfen und bestätigen Sie die Eingabe.' +#10#13+
      '4. Lassen Sie einen weiteren Schüler sich anmelden.');  //Text wird dem Label
     EdtIPAdresse.Enabled := False;                            //zugeordnet!
     EdtSchueleranzahl.Enabled := False;
     EdtIPAdresse.Text := GetLocalIPAddress;
     
     BtnBestaetigen.Caption := 'Schüler-Daten speichern und Fortfahren';
     BtnBestaetigen.Enabled := False;
     BtnBestaetigen.Font.Size := 14;
     BtnAbbrechen.Caption := 'Anmeldung abbrechen';
     EdtSchuelerVorname.Enabled := False;
     EdtSchuelerNachname.Enabled := False;
     EdtSchuelerVorname.Text := ' warte auf den Schüler';
     EdtSchuelerNachname.Text := '...';
     BtnCopy.Font.Size := 15;
     BtnCopy.Caption := 'C';
     EdtKlassenName.Enabled := False;      //Die Form wird gestaltet
     StringGridKlassenNamen.Visible := False;
     Schluessel := 'aLH7wm5HfrU';  //sehr sicherer Schlüssel!!!
     PositionGrid := 0;
     EdtPos.Visible := False;
  end;

function TFormKlasseVerbinden.GetLocalIpAddress : string;
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

procedure TFormKlasseVerbinden.BtnAbbrechenClick(Sender: TObject);
  begin
     If Application.MessageBox('Wollen Sie wirklich die Anmeldung beenden?' +#10#13+
                             'Alle bereits gespeicherten Daten gehen verloren!',
                             'Warnung', MB_ICONWARNING or MB_OKCANCEL)
         = IDOK then begin     //Fragt den User, ob wirklich beendet werden soll!
                       KlassenNamenDatei.Free;
                       DeleteFile('TransportOrdner\KlassenNamen\'
                                  + EdtKlassenname.Text +'.txt');
                       Close();  //Löscht die zuvor angelegte Datei!
                       FormKlasseAnlegen.Close;
                       FormKonsole.Show; //Kehrt zrück zum Anmeldefenster
                     end;
  end;

procedure TFormKlasseVerbinden.BtnCopyClick(Sender: TObject);
  begin
     showmessage('Lehrerkonsole V0.1' +#10#13+
                 'Copyright © 2013-2014' +#10#13+
                 'OHG-Geesthacht-13b Entwicklerteam' +#10#13+
                 'E-Mail: info@ohg-Lernprogramm.de');    //Entwicklerinformationen
  end;

procedure TFormKlasseVerbinden.ServerSocketAnmeldungClientError(
 Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
 var ErrorCode: Integer);
  begin
     showmessage('Server-Fehler' + #10#13 +
                  'Code: ' + IntToStr(ErrorCode));
     ShapeServerStatus.Brush.Color := clRed;
     ErrorCode := 0;    //Fehlermeldung bei Server
  end;

procedure TFormKlasseVerbinden.ServerSocketAnmeldungClientRead(
 Sender: TObject; Socket: TCustomWinSocket);
 var Nachricht: String;
     x: String;
     i: integer;
  begin
    Try
      Nachricht := Socket.ReceiveText;  //Empfangene Nachricht wird eingelesen!
      BtnBestaetigen.Enabled := True; //Lehrer kann fortfahren!
      If Nachricht[1] = '1' then
        begin
           EdtPos.Text := IntToStr (PositionGrid);
           ServerSocketAnmeldung.Socket.Connections[0].SendText(EdtPos.Text);  //Sendet den Index
           EdtSchuelerVorname.Text := Nachricht;
           x := EdtSchuelerVorname.Text;
           EdtSchuelerVorname.Clear;
           For i := 2 to Length(x) do
             EdtSchuelerVorname.Text := EdtSchuelerVorname.Text + x[i];
        end;     //Das 1.Zeichen muss gelöscht werden, da es sich um eine Zahl handelt
      If Nachricht[1] = '2' then
        begin
           EdtSchuelerNachname.Text := Nachricht;
           x := EdtSchuelerNachname.Text;
           EdtSchuelerNachname.Clear;
           For i := 2 to Length(x) do
             EdtSchuelerNachname.Text := EdtSchuelerNachname.Text + x[i];
        end;   //Das 1.Zeichen muss gelöscht werden, da es sich um den Server-Index handelt
      If Nachricht[1] = '3' then Geschlecht := Nachricht[2];
    Except showmessage('Fehler bei Datenempfang');
     end;
  end;

procedure TFormKlasseVerbinden.DateiVerbindung ();
  begin
     KlassenNamenDatei := TStringList.Create(); //Erzeugt die Datei
     Try
       KlassenNamenDatei.LoadFromFile ('TransportOrdner\KlassenNamen\'
                                       + EdtKlassenname.Text +'.txt');
       StringGridKlassenNamen.RowCount := StrToInt(KlassenNamenDatei[0]);
       StringGridKlassenNAmen.ColCount := 8;  //Initialisiert das StringGrid
     Except
       showmessage ('Fehler bei einer Datenbank! Programm Neu Starten!');
     end;
  end;


procedure TFormKlasseVerbinden.BtnBestaetigenClick(Sender: TObject);
 var Anzahl: Integer;
  begin
     BtnBestaetigen.Enabled := False;
     Anzahl := StrToInt (EdtSchuelerAnzahl.Text);
     StringGridKlassenNamen.Cells[1,PositionGrid] := EdtSchuelerNachname.Text;
     StringGridKlassenNAmen.Cells[2,PositionGrid] := EdtSchuelerVorname.Text;
     StringGridKlassenNAmen.Cells[5,PositionGrid] := Geschlecht;
     StringGridKlassenNamen.Cells[3,PositionGrid] := ' ';
     StringGridKlassenNamen.Cells[4,PositionGrid] := EdtKlassenName.Text;
     StringGridKlassenNamen.Cells[6,PositionGrid] := IntToStr(PositionGrid);
     Sleep(150);
     ServerSocketAnmeldung.Close;
     ServerSocketAnmeldung.Active := False;
     Sleep(100);
     ServerSocketAnmeldung.Active := True;
     Inc(PositionGrid);
     ProgressBarFortschritt.Position := PositionGrid;
     If (PositionGrid = Anzahl) then
       begin
          SchreibeKlassenDatei();
          Showmessage('Die Klasse:  ' + #10#13 +
                       EdtKlassenName.Text + #10#13 +
                      'wurde erfolgreich angelegt!');
          FormKonsole.Geladene_Klasse := EdtKlassenName.Text;
          ServerSocketAnmeldung.Active := False;
          FormKlasseVerbinden.Close;
          FormKlasseAnlegen.Close();
          FormKonsole.Visible := True;
          FormKonsole.BringToFront;
       end;
   end;    //Falls kein Schüler mehr folgt, wird das Fenster geschlossen!

procedure TFormKlasseVerbinden.Addition (x: integer);
 var c2: char;
     p2, zaehler: integer;
  begin
     lenSchl  := length (schluessel);
     zaehler := x mod lenSchl +1;
     c2 := schluessel[zaehler];
     p2 := pos (c2, ga);
     ga2 := copy (ga, p2, lenA -p2+1)
            + copy (ga, 1, p2-1);
  end;

Procedure TFormKlasseVerbinden.ErzeugeGa();
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

procedure TFormKlasseVerbinden.SchreibeKlassenDatei();
 var i,k,L,z: Integer;
  begin
    For i := 0 to 6 do         //Alle 8 Spalten werden eingelesen
    For k := 0 to (StringGridKlassenNamen.RowCount -1) do
     begin
        kt := StringGridKlassenNamen.Cells[i,k];
        lenT := length (kt);
        gt := '';
        For z := 1 to lenT do
         begin
            ErzeugeGa();
            addition(z);
            c := kt [z];
            p := pos (c, ka);
            If p <> 0 then gt := gt +copy (ga2, p, 1)
             Else gt := gt +c;              //Hier wird verschlüsselt
         end;
        StringGridKlassenNamen.Cells[i,k] := gt;  //Das StringGrid liegt nun
     end;                                         //verschlüssetl vor
    Try
     For L := 0 to (StringGridKlassenNAmen.RowCount -1) do
      KlassenNamenDatei.Add(StringGridKlassenNamen.Rows[L].CommaText);
     KlassenNamenDatei.SaveToFile('TransportOrdner\KlassenNamen\'
                                  + EdtKlassenname.Text +'.txt');
    Finally
     FormKonsole.Enabled := True;
     FormKonsole.Visible := True;
     Close();
    end;
 end;

procedure TFormKlasseVerbinden.IP_DateiSchreiben ();
  begin
     Try
        Memo.Lines[1] :=  (EdtIpAdresse.Text);
        Memo.Lines.SaveToFile ('Transportordner\LehrerOrdner\'
                                + FormKonsole.EdtBenutzername_Lehrer.Text
                                + '\Lehrer_Adresse.txt');
     Finally;
       Memo.Destroy;
      end;
  end;

  
end.
