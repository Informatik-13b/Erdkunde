unit Stadt_Auswahl;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Grids, ExtCtrls, WinSock, ComCtrls, ShellAPI;

type
  TOrte = record
     Index : Integer;
     Ortsname : string[20];
     Schwierigkeit : string[10];
     KoSy_x, KoSy_y : integer;
   end;
  TFormStadt_Auswahl = class(TForm)
    Label1: TLabel;
    StringGridStadt: TStringGrid;
    BtnStart: TButton;
    BtnAbbrechen: TButton;
    Label2: TLabel;
    EdtAnzahl: TEdit;
    Label3: TLabel;
    EdtKlasse: TEdit;
    Label4: TLabel;
    ComboBoxZeit: TComboBox;
    Label5: TLabel;
    EdtSpielzeit: TEdit;
    Bevel1: TBevel;
    Label6: TLabel;
    EdtIP: TEdit;
    Label7: TLabel;
    EdtOnline: TEdit;
    procedure BtnAbbrechenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure OrteEintragen ();
    procedure SatzLadenAnzeigen();
    procedure StringGridStadtDblClick(Sender: TObject);
    procedure StringGridStadtDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure BtnStartClick(Sender: TObject);
    procedure ComboBoxZeitChange(Sender: TObject);
    function GetLocalIPAddress : String;

  private
    { Private-Deklarationen }
  public
    Zellen_Farbe : Array of Integer;    //dynamisches Array, da Anzahl variabel
  end;

var
  FormStadt_Auswahl: TFormStadt_Auswahl;
  aktueller_record : integer;
  ROrte : TOrte;
  Orte_Datei : file of TOrte;  //Orte-Datei
  Zeit :Integer;
implementation

uses Konsole, Menu_Spiel;

{$R *.DFM}

procedure TFormStadt_Auswahl.BtnAbbrechenClick(Sender: TObject);
  begin
     FormStadt_Auswahl.Visible := False;
     FormKonsole.Show;
     FormKonsole.BringToFront;
     CloseFile(Orte_Datei);
  end;

procedure TFormStadt_Auswahl.FormCreate(Sender: TObject);
  begin                      //initialisiert die Form
     Position:=poScreenCenter;
     ComboBoxZeit.ItemIndex := 0;
     FormStadt_Auswahl.Visible := False;
     RemoveMenu(GetSystemMenu(handle, false), SC_MOVE, MF_BYCOMMAND);
     RemoveMenu(GetSystemMenu(handle, false),SC_SIZE, MF_BYCOMMAND);
     With StringGridStadt do      //verhindern, dass die Form verschoben wird!
       begin
          Cells[0,0] := 'Nr.';
          Cells[1,0] := 'Stadt-Name';
       end;
     EdtAnzahl.Enabled := False;
     BtnStart.Caption := 'Spiel starten';
     BtnAbbrechen.Caption := 'Abbrechen';
     EdtKlasse.Enabled := False;
     EdtSpielzeit.Enabled := False;
     EdtSpielZeit.Text := '0s';
     Zeit := 10;
     BtnStart.Enabled := False;
     EdtIp.Text := GetLocalIPAddress;
     EdtOnline.Enabled := False;
     EdtOnline.Brush.Color := clRed;
  end;


procedure TFormStadt_Auswahl.OrteEintragen();
 var i: integer;
  begin
      AssignFile(Orte_Datei,'Orte_Koordinaten.dat');      // Datei wird geöffnet
      aktueller_record := 1;
      If FileExists('Orte_Koordinaten.dat') then
        begin
           Reset(Orte_Datei);
           SatzLadenAnzeigen;                 // erster Datensatz wird geladen
           StringGridStadt.RowCount := FileSize(Orte_Datei)+2;  //Grid wird initialisiert

           While aktueller_record < FileSize(Orte_Datei) do
             begin                            //gesamtes Grid wird gefüllt
                aktueller_record := aktueller_record +1;
                SatzLadenAnzeigen;
             end;
        end
       Else Rewrite(Orte_Datei);
       SetLength(Zellen_Farbe, FileSize(Orte_Datei)+1);  //legt die Länge des Arrays fest
           For i := 1 to High(Zellen_Farbe) do Zellen_Farbe[i] := 0;
  end;

procedure TFormStadt_Auswahl.SatzLadenAnzeigen;
  begin
     Seek(Orte_Datei,aktueller_record-1);
     If FileSize(Orte_Datei) > 0 then
      begin
         Read(Orte_Datei,ROrte);      // Der Datensatz wird in den Record geladen
         With ROrte do
           begin
               StringGridStadt.Cells[0,aktueller_record] := IntToStr(aktueller_record);
               StringGridStadt.Cells[2,aktueller_record] := IntToStr(Index);
               StringGridStadt.Cells[1,aktueller_record] := Ortsname;
           end;     //Das StringGrid wird beschrieben
      end;
  end;



procedure TFormStadt_Auswahl.FormClose(Sender: TObject;
 var Action: TCloseAction);                //die Form wird geschlossen
  begin
     CloseFile(Orte_Datei);
     FormKonsole.Visible := True;
     FormKonsole.Show;
     FormKonsole.BringToFront;
  end;

procedure TFormStadt_Auswahl.StringGridStadtDblClick(Sender: TObject);
 var i,k: Integer;             //nur bei Doppelklick auf das Grid
  begin
     If StringGridStadt.Row +1 < StringGridStadt.RowCount then
     begin
     k := 0;
     With StringGridStadt do
      begin
       If Zellen_Farbe[Row] = 1 then Zellen_Farbe[Row] := 0
        Else Zellen_Farbe[Row] := 1;
       Row :=  StringGridStadt.Row +1;      //zellenfarbe wird festgelegt!
      end;
     For i := 1 to High(Zellen_Farbe) do
      If Zellen_Farbe[i] = 1 then Inc(k);
     EdtAnzahl.Text := IntToStr(k);
     EdtSpielzeit.Text := (IntToStr(k*Zeit) + ' Sekunden');
     If k = 0 then BtnStart.Enabled := False Else BtnStart.Enabled := True;
  end; end;

procedure TFormStadt_Auswahl.StringGridStadtDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
  begin
      If Zellen_Farbe[ARow] = 1 then   //Abrfrage, ob makiert werden muss
       With StringGridStadt do
         begin
            Canvas.Brush.Color := clLime;
            Canvas.FillRect(Rect);
            Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[ACol, ARow]);
         end;    //Färbt die ausgewählte Reihe in der Farbe clLime!
  end;


procedure TFormStadt_Auswahl.BtnStartClick(Sender: TObject);
 var Anzahl_Verbindungen, i, k, Pos, z: Integer;
  begin
     FormKonsole.Stat_Anzahl := 0;  //Bisher haben null Schüler gespielt!
     Pos := 1;
     FormSpiel.Visible := True;
     FormStadt_Auswahl.Visible := False;
     FormSpiel.Show;
     FormSpiel.BringToFront;
     With FormKonsole.ServerSocketLehrer do
       begin
          Anzahl_Verbindungen := Socket.ActiveConnections;
          For i := 0 to Anzahl_Verbindungen -1 do
            Socket.Connections[i].SendText('Z' + IntToStr(Zeit));
       end;
    With FormSpiel do            // Zugriff auf die nächste Form
      begin
         Gespielt := 0;
         ProgressBarStand.Max := Anzahl_Verbindungen; //initiallisiert die ProgressBar
         GridEinlesen();
         BtnAktion.Caption := 'Starten';
         Position1 := 0;
         SetLength(Zellen_Position, (StrToInt(EdtAnzahl.Text)));  //legt die Länge des Arrays fest
         StringGridAuswahl.RowCount := (StrToInt(EdtAnzahl.Text)) +1;
         For k := 1 to High(Zellen_Farbe) do
           begin
              If Zellen_Farbe[k] = 1 then
                begin
                  StringGridAuswahl.Cells[1,Pos] := StringGridStadt.Cells[1,k];
                  StringGridAuswahl.Cells[2,Pos] := StringGridStadt.Cells[2,k];
                  Inc(Pos); //erhöht die Position im Grid
                end;
           end;

         For z := 1 to StringGridAuswahl.RowCount do
           StringGridAuswahl.Cells[0,z] := IntToStr (z);
      end;
    SetLength(FormSpiel.Wert, FormSpiel.StringGridPunkte.RowCount-1);
  end;

procedure TFormStadt_Auswahl.ComboBoxZeitChange(Sender: TObject);
 var Anzahl: Integer;     //Die Zeit wird geändert!
  begin
     Zeit := StrToInt (ComboBoxZeit.Items [ComboBoxZeit.ItemIndex]);
     Anzahl := StrToInt(EdtAnzahl.Text);
     EdtSpielzeit.Text := (IntToStr(Anzahl*Zeit) + ' Sekunden');
  end;

function TFormStadt_Auswahl.GetLocalIpAddress : string;
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
      WSACleanup;  //Mit dieser Funktion wird die IP-Adresse des Users ausgelsen!
  end;            //übernommen von Wb

end.
