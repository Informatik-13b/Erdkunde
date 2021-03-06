unit Schuler_Hinzufugen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ScktComp, WinSock, ExtCtrls, Grids;

type
  TFormSchuler_Add = class(TForm)
    ComboBoxKlassenNamen: TComboBox;
    Label1: TLabel;
    Label2: TLabel;
    BtnFreischalten: TButton;
    Label3: TLabel;
    Label4: TLabel;
    EdtAdresse: TEdit;
    Label5: TLabel;
    EdtVorname: TEdit;
    EdtName: TEdit;
    BtnAdd: TButton;
    ServerSocketSchuler_Add: TServerSocket;
    BtnAbbrechen: TButton;
    ShapeServerStatus: TShape;
    Label6: TLabel;
    EdtPos: TEdit;
    EdtAuswahl: TEdit;
    StringGridName: TStringGrid;
    procedure FormCreate(Sender: TObject);
    function GetLocalIpAddress : String;
    procedure ServerSocketSchuler_AddClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure BtnAbbrechenClick(Sender: TObject);
    procedure BtnFreischaltenClick(Sender: TObject);
    procedure KlassenNAmen_Finden();
    procedure ServerSocketSchuler_AddClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure BtnAddClick(Sender: TObject);
    procedure SchreibeKlassenDatei();
    procedure ErzeugeGa();
    procedure Addition(x: Integer);

  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormSchuler_Add: TFormSchuler_Add;
  Klassen_Auswahl, Geschlecht, kt, gt: String;
  Index: Integer;
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

uses Konsole;

{$R *.DFM}

procedure TFormSchuler_Add.FormCreate(Sender: TObject);
  begin
     Position:=poScreenCenter;
     BtnFreischalten.Caption := 'Verbindung �ffnen';
     EdtAdresse.Text := GetLocalIpAddress;
     FormSchuler_Add.Visible := False;
     EdtAdresse.Enabled := False;
     BtnAdd.Caption := 'Sch�ler hinzuf�gen';
     BtnAdd.Enabled := False;
     BtnAbbrechen.Caption := 'Anmeldung Abbrechen';
     ShapeServerStatus.Brush.Color := clYellow;
     ServerSocketSchuler_Add.Port := 8080;
     ServerSocketSchuler_Add.Active := False;
     EdtName.Enabled := False;
     EdtVorname.Enabled := False;
     RemoveMenu(GetSystemMenu(handle, false), SC_MOVE, MF_BYCOMMAND);
     RemoveMenu(GetSystemMenu(handle, false),SC_SIZE, MF_BYCOMMAND);
     EdtPos.Visible := False;
     EdtPos.Text := '0';
     EdtAuswahl.visible := False;
     Schluessel := 'aLH7wm5HfrU';  //sehr sicherer Schl�ssel!!!
     ComboBoxKlassenNamen.Style := csDropDownList;
  end;

function TFormSchuler_Add.GetLocalIpAddress : string;
 type
    pu_long = ^u_long;
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
      WSACleanup;   //IP-Adresse des Users wird geladen
  end;

procedure TFormSchuler_Add.ServerSocketSchuler_AddClientError(
 Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
 var ErrorCode: Integer);
  begin
     showmessage('Server-Fehler' + #10#13 +
                  'Code: ' + IntToStr(ErrorCode));
     ShapeServerStatus.Brush.Color := clRed;
     ErrorCode := 0;    //Fehlermeldung bei Server
  end;

procedure TFormSchuler_Add.BtnAbbrechenClick(Sender: TObject);
  begin
     ServerSocketSchuler_Add.Active := False;
     FormSchuler_Add.Visible := False;
     FormKonsole.Visible := True;
     FormKonsole.BringToFront;
  end;

procedure TFormSchuler_Add.BtnFreischaltenClick(Sender: TObject);
  begin
     If FormKonsole.ServerSocketLehrer.Active = False then
       begin
          BtnFreischalten.Enabled := False;
          ServerSocketSchuler_Add.Active := True;
          ShapeServerStatus.Brush.Color := clLime;
          EdtVorname.Text := 'warte ...';
          EdtName.Text := '...';
          Klassen_Auswahl := ComboBoxKlassenNAmen.Items [ComboBoxKlassenNamen.ItemIndex];
          EdtAuswahl.Text := Klassen_Auswahl;
          FormKonsole.ComboBoxKlassenNamen.ItemIndex := ComboBoxKlassenNamen.ItemIndex;
          FormKonsole.Geladene_Klasse := Klassen_Auswahl;
          FormKonsole.GridEinlesen();
          Index := FormKonsole.StringGridUbersicht.RowCount -1;
       end
      Else showmessage ('Konsolen-Server muss beendet werden!'); 
  end;

procedure TFormSchuler_Add.KlassenNamen_Finden();
 var Suche : TSearchRec;
     Verzeichnis   : String;
     Text, TextA: String;
     Laenge, i: Integer;
  begin
      ComboBoxKlassenNamen.Clear;
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
         end;
       Until FindNext(Suche) <> 0;
      Finally
        SysUtils.FindClose(Suche);
       end;
  end;

procedure TFormSchuler_Add.ServerSocketSchuler_AddClientRead(
 Sender: TObject; Socket: TCustomWinSocket);
 var Nachricht: String;
  begin
    Try
      Nachricht := Socket.ReceiveText;  //Empfangene Nachricht wird eingelesen!
      BtnAdd.Enabled := True; //Lehrer kann fortfahren
      StringGridName.Rows[1].CommaText := Nachricht;
      EdtVorname.Text := StringGridName.Cells[1,1];
      EdtName.Text := StringGridName.Cells[2,1];
      Geschlecht := 'J';
      
      EdtPos.Text := IntToStr (Index);
      ServerSocketSchuler_Add.Socket.Connections[0].SendText(EdtPos.Text);  //Sendet den Index
     Except showmessage('Fehler bei Datenempfang');
     end;
  end;


procedure TFormSchuler_Add.BtnAddClick(Sender: TObject);
 var i: Integer;
  begin
     With FormKonsole.StringGridUbersicht do
       begin
          RowCount := RowCount +1;
          Cells[1,RowCount-1] := EdtName.Text;
          Cells[2,RowCount-1] := EdtVorname.Text;
          Cells[3,RowCount-1] := '';
          Cells[4,RowCount-1] := Klassen_Auswahl;
          Cells[6,RowCount-1] := IntToStr (Index);
          //showmessage(Cells[6,RowCount-1]);
       end;
     SchreibeKlassenDatei();
     Showmessage('Der Sch�ler: ' + #10#13 +
                 EdtName.Text + #10#13 +
                 'wurde erfolgreich angelegt!');
     ServerSocketSchuler_Add.Active := False;
     FormSchuler_Add.Visible := False;
     FormKonsole.Visible := True;
     FormKonsole.BringToFront;
     FormKonsole.GridEinlesen;
     With FormKonsole.StringGridUbersicht do
        begin
           For i := 1 to RowCount -1 do Cells[0,i] := IntToStr(i);
           Cells[0,0] := 'Nr.';
           Cells[2,0] := 'Vorname';
           Cells[1,0] := 'Name';
           Cells[3,0] := 'ON';
           Cells[4,0] := 'Klasse';   //Tr�gt die Bezeichnungen ins Grid ein
        end;
  end;

procedure TFormSchuler_Add.SchreibeKlassenDatei();
 var i,k,L,z: Integer;
     KlassenNamenDateiS: TStringList;
  begin
    KlassenNamenDateiS := TStringList.Create;
    KlassenNamenDateiS.Add (IntToStr(FormKonsole.StringGridUbersicht.RowCount-1));
    KlassenNamenDateiS.Add ('8');
    For i := 0 to 7 do         //Alle 6 Spalten werden eingelesen
    For k := 1 to (FormKonsole.StringGridUbersicht.RowCount) do
     begin
        kt := FormKonsole.StringGridUbersicht.Cells[i,k];
        lenT := length (kt);
        gt := '';
        For z := 1 to lenT do
         begin
            ErzeugeGa();
            addition(z);
            c := kt [z];
            p := pos (c, ka);
            If p <> 0 then gt := gt +copy (ga2, p, 1)
             Else gt := gt +c;              //Hier wird verschl�sselt
         end;
        FormKonsole.StringGridUbersicht.Cells[i,k] := gt;  //Das StringGrid liegt nun
     end;                                         //verschl�ssetl vor
    Try
     For L := 1 to (FormKonsole.StringGridUbersicht.RowCount -1) do
      KlassenNamenDateiS.Add(FormKonsole.StringGridUbersicht.Rows[L].CommaText);
     KlassenNamenDateiS.SaveToFile('TransportOrdner\KlassenNamen\'
                                  + EdtAuswahl.Text +'.txt');
    Except showmessage('Fehler beim Anlegen');
    KlassenNamenDateiS.Free;
    end;
 end;

procedure TFormSchuler_Add.Addition (x: integer);
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

Procedure TFormSchuler_Add.ErzeugeGa();
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

end.
