unit Menu_Spiel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ComCtrls, ExtCtrls;

type
  TFormSpiel = class(TForm)
    StringGridAuswahl: TStringGrid;
    StringGridPunkte: TStringGrid;
    Label1: TLabel;
    BtnAktion: TButton;
    BtnCopy: TButton;
    BtnAbbrechen: TButton;
    Bevel1: TBevel;
    Bevel2: TBevel;
    ComboBoxFunktion: TComboBox;
    Label2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Auswahl_Einlesen();
    procedure BtnCopyClick(Sender: TObject);
    procedure BtnAktionClick(Sender: TObject);
    procedure StringGridAuswahlDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure BtnAbbrechenClick(Sender: TObject);
    procedure GridEinlesen();
    procedure StringGridPunkteSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure ComboBoxFunktionChange(Sender: TObject);
  private
     //private Deklarationen
  public
    Zellen_Position : Array of Integer;    //dynamisches Array
    Position: Integer;
    Sortier_Modus: Integer;
  end;

var
  FormSpiel: TFormSpiel;

const
  Gesamtentfernung = 3;
  Letzte_Entfernung = 2;

implementation

uses Konsole;

{$R *.DFM}

procedure TFormSpiel.FormCreate(Sender: TObject);
  begin
     RemoveMenu(GetSystemMenu(handle, false), SC_MOVE, MF_BYCOMMAND);
     StringGridPunkte.Row := 2;
     StringGridAuswahl.Enabled := False;
     ComboBoxFunktion.Style := csDropDownList;
     Sortier_Modus := Gesamtentfernung;
     ComboBoxFunktion.ItemIndex := 0;
     FormSpiel.Visible := False;
     With StringGridPunkte do
       begin
          Cells[0,0] := 'Nr.';
          Cells[1,0] := 'Vorname';
          Cells[2,0] := 'Punkte Stadt';
          Cells[3,0] := 'Gesamt-Punkte';
       end;
     With StringGridAuswahl do
       begin
          Cells[0,0] := 'Nr.';
          Cells[1,0] := 'Stadtname';
       end;
     Auswahl_Einlesen();
     BtnCopy.Caption := 'Admin';
     BtnAbbrechen.Caption := 'Abbrechen';
  end;

procedure TFormSpiel.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
     FormKonsole.Visible := True;
     FormKonsole.Show;
     FormKonsole.BringToFront;
  end;

procedure TFormSpiel.Auswahl_Einlesen();
  begin
     //
  end;

procedure TFormSpiel.BtnCopyClick(Sender: TObject);
  begin
      showmessage('Lehrerkonsole V0.1' +#10#13+
                 'Benutzung auf eigene Gefahr!!!' +#10#13+
                 'Copyright � 2013-2014' +#10#13+
                 'OHG-Geesthacht-13b Entwicklerteam' +#10#13+
                 'E-Mail: info@ohg-Lernprogramm.de');    //Entwicklerinformationen

  end;

procedure TFormSpiel.BtnAktionClick(Sender: TObject);
 var Anzahl_Verbindungen,i,k,Pos: Integer;
  begin
     BtnAktion.Enabled := False;
     BtnAktion.Caption := 'Weiter';
     If Position < (StringGridAuswahl.RowCount -1) then Inc(Position);
     StringGridAuswahl.Row := Position;
     Zellen_Position[Position-1] := 1;
     Pos := Position; //"Position" ist ein bereits definierter Bezeichner!
     For k := 1 to (StringGridPunkte.RowCount -1) do
       begin
           StringGridPunkte.Cells[2,k]:= 'warten ...';
       end;
     With FormKonsole do
       begin
          Anzahl_Verbindungen := ServerSocketLehrer.Socket.ActiveConnections;
          For i := 0 to Anzahl_Verbindungen -1 do
          ServerSocketLehrer.Socket.Connections[i].SendText('S'
                                             +StringGridAuswahl.Cells[2,Pos]);
       end;               //sendet den Index der Stadt !!!
     StringGridAuswahl.Row := Position;
  end;

procedure TFormSpiel.StringGridAuswahlDrawCell(Sender: TObject; ACol,
 ARow: Integer; Rect: TRect; State: TGridDrawState);
  begin
       If Zellen_Position[ARow] = 1 then   //Abrfrage, ob makiert werden muss
       With StringGridAuswahl do
         begin
            Canvas.Brush.Color := clBtnShadow;
            Canvas.FillRect(Rect);
            Canvas.TextOut(Rect.Left+2, Rect.Top+2, Cells[ACol, ARow]);
         end;    //F�rbt die ausgew�hlte Reihe in der Farbe clBtnShadow!
  end;


procedure TFormSpiel.BtnAbbrechenClick(Sender: TObject);
  begin
     If Application.MessageBox('Ein Abbruch wird nicht empfohlen!!!' +#10#13+
                               'Probleme bei Serververbindung!',
                               'Warnung', MB_ICONWARNING or MB_OKCANCEL)
         = IDOK then begin
                        FormSpiel.Close;
                        FormKonsole.BringToFront;
                      end;
  end;

procedure TFormSpiel.GridEinlesen();
 var i, Anzahl: Integer;
  begin
     Anzahl := 0;
     With FormKonsole do
       begin
          For i := 1 to StringGridUbersicht.RowCount do
            begin
               If StringGridUbersicht.Cells[3,i] = 'X' then Inc (Anzahl);
            end;
          StringGridPunkte.RowCount := (Anzahl +1);    //erh�ht RowCount!!!
          For i := 1 to StringGridUbersicht.RowCount do
            begin
               If StringGridUbersicht.Cells[3,i] = 'X' then
                 begin
                    StringGridPunkte.Cells[1,i] := StringGridUbersicht.Cells[2,i];
                    StringGridPunkte.Cells[4,i] := StringGridUbersicht.Cells[6,i];
                    StringGridPunkte.Cells[2,i] := '0';
                    StringGridPunkte.Cells[3,i] := '0';
                 end;
            end;
       end;
  end;

procedure TFormSpiel.StringGridPunkteSelectCell(Sender: TObject; ACol,
 ARow: Integer; var CanSelect: Boolean);
  begin
     CanSelect := False; //verhindert, dass eine Reihe Selected wird!
  end;

procedure TFormSpiel.ComboBoxFunktionChange(Sender: TObject);
  begin
     If ComboBoxFunktion.ItemIndex = 0 then Sortier_Modus := Gesamtentfernung
       Else Sortier_Modus := Letzte_Entfernung;  //Konstanten f�r das Grid werden zugewiesen
  end;

end.
