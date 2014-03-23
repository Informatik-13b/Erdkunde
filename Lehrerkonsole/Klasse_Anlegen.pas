unit Klasse_Anlegen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, ScktComp, WinSock;

type
  TFormKlasseAnlegen = class(TForm)
    EdtAnzahl: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    BtnServerOffnen: TButton;
    EdtIPAdresse: TEdit;
    BtnAbbrechen: TButton;
    Label4: TLabel;
    EdtKlassenName: TEdit;
    function GetLocalIpAddress : string;
    procedure FormCreate(Sender: TObject);
    procedure BtnServerOffnenClick(Sender: TObject);
    procedure BtnAbbrechenClick(Sender: TObject);
    procedure EdtAnzahlKeyPress(Sender: TObject; var Key: Char);
    procedure EdtAnzahlKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtKlassenNameChange(Sender: TObject);
    procedure EdtKlassenNameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private-Deklarationen }
  public
    Anzahl: String;
  end;

var
  FormKlasseAnlegen: TFormKlasseAnlegen;

implementation

uses KlasseVerbinden, Konsole;

{$R *.DFM}

function TFormKlasseAnlegen.GetLocalIpAddress : string;
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

procedure TFormKlasseAnlegen.FormCreate(Sender: TObject);
  begin
     Position:=poScreenCenter;
     EdtIpAdresse.Text := GetLocalIpAddress;
     BtnServerOffnen.Caption := 'Verbindung öffnen';
     BtnAbbrechen.Caption := 'Abbrechen';
     EdtAnzahl.Text := '';
     BtnServerOffnen.Enabled := False;
     EdtKlassenName.Text := '';
     RemoveMenu(GetSystemMenu(handle, false), SC_MOVE, MF_BYCOMMAND);
    // RemoveMenu(GetSystemMenu(handle, false),SC_SIZE, MF_BYCOMMAND);
  end;        //verhindert das verschieben er Form!

procedure TFormKlasseAnlegen.BtnServerOffnenClick(Sender: TObject);
 var ClickForm: TFormKlasseVerbinden;
     NeuDatei: TStringList;
  begin
     If Not FileExists('KlassenNamen\'+EdtKlassenName.Text + '.txt') then
      begin
        NeuDatei := TStringList.Create; //Objekt erzeugen
          Try  //Es wird eine Fehlmermeldung verhindert;
           NeuDatei.Add(EdtAnzahl.Text); //Text hinzufügen
           NeuDatei.Add('8');
           NeuDatei.SaveToFile('TransportOrdner\KlassenNamen\'
                                +EdtKlassenName.Text + '.txt'); //Datei speichern
          Finally
           NeuDatei.free; //Objekt wieder freigeben
          end;
        showmessage('Geben Sie folgende IP-Adresse an die Schüler weiter:'
                    +#10#13+ 'IP-Adresse:  ' + GetLocalIPAddress);
        ClickForm := TFormKlasseVerbinden.Create(self);
       Try         //Die Form wird erst erstellt, damit die Variablen übergeben werden können
        ClickForm.EdtSchueleranzahl.Text := EdtAnzahl.Text;
        ClickForm.EdtKlassenname.Text := EdtKlassenName.Text;
        ClickForm.ServerSocketAnmeldung.Active := True;
        ClickForm.ShapeServerStatus.Brush.Color := clLime;
        ClickForm.PositionGrid := 0;
        ClickForm.IP_DateiSchreiben ();
        ClickForm.ProgressBarFortschritt.Max := StrToInt (EdtAnzahl.Text);
        ClickForm.ProgressBarFortschritt.Position := 0; 
        ClickForm.DateiVerbindung; //Stellt die Verbindung zur Textdatei her!
        ClickForm.ShowModal;
       Finally
        ClickForm.Free;
        Self.Hide;
       end;
      end;
 end;
 

procedure TFormKlasseAnlegen.BtnAbbrechenClick(Sender: TObject);
  begin
     Close();
     FormKonsole.Show;   //öffnet wieder die Konsolen ansicht!
  end;

  
procedure TFormKlasseAnlegen.EdtAnzahlKeyPress(Sender: TObject;
 var Key: Char);
  begin
    If Not (Key in ['0'..'9', Char(VK_Back)]) then Key := #0;
  end;         //lässt nur Zahlen als Eingabe zu

procedure TFormKlasseAnlegen.EdtAnzahlKeyDown(Sender: TObject;
 var Key: Word; Shift: TShiftState);
  begin
     If (EdtAnzahl.Text <> '') and (Key = VK_RETURN) Then EdtKlassenName.SetFocus;
  end;

procedure TFormKlasseAnlegen.EdtKlassenNameChange(Sender: TObject);
  begin
     If (EdtKlassenName.Text <> '') and
        (EdtAnzahl.Text <> '') then BtnServerOffnen.Enabled := True
      Else BtnServerOffnen.Enabled := False;
  end;        //Button nur Enbaled = True, wenn etwas im Edit-Feld steht

procedure TFormKlasseAnlegen.EdtKlassenNameKeyDown(Sender: TObject;
 var Key: Word; Shift: TShiftState);
  begin
     If (BtnServerOffnen.Enabled = True) and (Key = VK_RETURN)
      Then BtnServerOffnen.Click;
  end;

end.
