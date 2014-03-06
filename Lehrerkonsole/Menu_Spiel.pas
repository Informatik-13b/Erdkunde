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
    ProgressBarZeit: TProgressBar;
    BtnAktion: TButton;
    BtnCopy: TButton;
    BtnAuto: TButton;
    BtnAbbrechen: TButton;
    TimerZeit: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Auswahl_Einlesen();
    procedure BtnCopyClick(Sender: TObject);
    procedure BtnAktionClick(Sender: TObject);
    procedure StringGridAuswahlDrawCell(Sender: TObject; ACol,
      ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure TimerZeitTimer(Sender: TObject);
    procedure BtnAbbrechenClick(Sender: TObject);
    procedure GridEinlesen();
    procedure StringGridPunkteSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
  private
     //private Deklarationen
  public
    Zellen_Position : Array of Integer;    //dynamisches Array
    Position: Integer;
    Spielzeit: Integer;
  end;

var
  FormSpiel: TFormSpiel;
  Aktuelle_Zeit: Integer;

implementation

uses Konsole;

{$R *.DFM}

procedure TFormSpiel.FormCreate(Sender: TObject);
  begin
     StringGridPunkte.Row := 2;
     StringGridAuswahl.Enabled := False;
     TimerZeit.Enabled := False;
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
                 'Copyright © 2013-2014' +#10#13+
                 'OHG-Geesthacht-13b Entwicklerteam' +#10#13+
                 'E-Mail: info@ohg-Lernprogramm.de');    //Entwicklerinformationen

  end;

procedure TFormSpiel.BtnAktionClick(Sender: TObject);
 var Anzahl_Verbindungen, i, Pos: Integer;
  begin
     BtnAktion.Enabled := False;
     Aktuelle_Zeit := 0;  // Für den Timer!
     BtnAktion.Caption := 'Weiter';
     If Position < (StringGridAuswahl.RowCount -1) then Inc(Position);
     StringGridAuswahl.Row := Position;
     Zellen_Position[Position-1] := 1;
     Pos := Position; //"Position" ist ein bereits definierter Bezeichner!
     With FormKonsole do
       begin
          Anzahl_Verbindungen := ServerSocketLehrer.Socket.ActiveConnections;
          For i := 0 to Anzahl_Verbindungen -1 do
          ServerSocketLehrer.Socket.Connections[i].SendText('S'
                                             +StringGridAuswahl.Cells[2,Pos]);
       end;               //sendet den Index der Stadt !!!
     StringGridAuswahl.Row := Position;
     TimerZeit.Enabled := True;  //aktiviert den Timer mit der PB!
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
         end;    //Färbt die ausgewählte Reihe in der Farbe clBtnShadow!
  end;

procedure TFormSpiel.TimerZeitTimer(Sender: TObject);
  begin
     Inc (Aktuelle_Zeit);
     ProgressBarZeit.Position := Aktuelle_Zeit;
     If Aktuelle_Zeit >= Spielzeit + 2 then
       begin
          If Position >= (StringGridAuswahl.RowCount -1) then
            begin
               BtnAktion.Enabled := False;
               BtnAktion.Caption := '..beendet..';
            end
           Else BtnAktion.Enabled := True;  
          TimerZeit.Enabled := False;
          Aktuelle_Zeit := 0;
       end;
  end;

procedure TFormSpiel.BtnAbbrechenClick(Sender: TObject);
  begin
     If Application.MessageBox('Ein Abbruch wird nicht empfohlen!!!' +#10#13#+
                               'Probleme bei Serververbindung!',
                               'Warnung', MB_ICONWARNING or MB_OKCANCEL)
         = IDOK then FormSpiel.Close;
  end;

procedure TFormSpiel.GridEinlesen();
 var i, Anzahl: Integer;
  begin
     With FormKonsole do
       begin
          For i := 1 to StringGridUbersicht.RowCount do
            begin
               If StringGridUbersicht.Cells[3,i] <> '' then Inc ( Anzahl);
            end;
          StringGridPunkte.RowCount := (Anzahl +1);
          For i := 1 to StringGridUbersicht.RowCount do
            begin
               If StringGridUbersicht.Cells[3,i] <> '' then
                 begin
                    StringGridPunkte.Cells[1,i] := StringGridUbersicht.Cells[2,i];
                    StringGridPunkte.Cells[4,i] := StringGridUbersicht.Cells[6,i];
                 end;
            end;
       end;
  end;

procedure TFormSpiel.StringGridPunkteSelectCell(Sender: TObject; ACol,
 ARow: Integer; var CanSelect: Boolean);
  begin
     CanSelect := False; //verhindert, dass eine Reihe Selected wird!
  end;

end.
