unit Menu_Spiel;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls, ComCtrls, ExtCtrls, Printers;

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
    BtnPrint: TButton;
    Bevel3: TBevel;
    PrintDialog: TPrintDialog;
    RichEditPrint: TRichEdit;
    EdtText: TEdit;
    Label3: TLabel;
    ProgressBarStand: TProgressBar;
    Bevel4: TBevel;
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
    procedure InsertionSort();
    procedure BtnPrintClick(Sender: TObject);
  private
     //private Deklarationen
  public
    Zellen_Position : Array of Integer;    //dynamisches Array
    Position1: Integer;
    Sortier_Modus: Integer;
    Wert : array of Integer;
    Spielen: Boolean;
  end;

var
  FormSpiel: TFormSpiel;

const
  Gesamtentfernung = 3;
  Letzte_Entfernung = 2;

implementation

uses Konsole, Stadt_Auswahl;

{$R *.DFM}

procedure TFormSpiel.FormCreate(Sender: TObject);
  begin
     EdtText.Visible := False;
     Spielen := False;
     Position := poScreenCenter;
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
          Cells[2,0] := 'Entfernung-Stadt';
          Cells[3,0] := 'Gesamt-Entfernung';
       end;
     With StringGridAuswahl do
       begin
          Cells[0,0] := 'Nr.';
          Cells[1,0] := 'Stadtname';
       end;
     Auswahl_Einlesen();
     BtnCopy.Caption := 'Admin';
     BtnAbbrechen.Caption := 'Abbrechen';
     BtnPrint.Caption := 'Drucken';
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
 var Anzahl_Verbindungen,i,k,Pos: Integer;
  begin
     If StringGridAuswahl.RowCount = StringGridAuswahl.Row then
       begin
          FormSpiel.Close;
          Exit;  //verlässt die Procedure!!
       end;
     ProgressBarStand.Position := 0;
     Spielen := True;
     FormKonsole.Stat_Anzahl := 0;
     BtnAktion.Enabled := False;
     BtnAktion.Caption := 'Weiter';
     If Position1 < (StringGridAuswahl.RowCount -1) then Inc(Position1);
     StringGridAuswahl.Row := Position1;
     Zellen_Position[Position1 -1] := 1;
     Pos := Position1; //"Position" ist ein bereits definierter Bezeichner!
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
     StringGridAuswahl.Row := Position1;
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


procedure TFormSpiel.BtnAbbrechenClick(Sender: TObject);
 var i, Zahl: Integer;
  begin
     If Application.MessageBox('Ein Abbruch wird nicht empfohlen!!!' +#10#13+
                               'Probleme bei Serververbindung!',
                               'Warnung', MB_ICONWARNING or MB_OKCANCEL)
         = IDOK then begin
                        FormSpiel.Close;
                        FormKonsole.BringToFront;
                        Zahl := FormKonsole.ServerSocketLehrer.Socket.ActiveConnections;
                        For i := 0 to Zahl -1 do
                          FormKonsole.ServerSocketLehrer.Socket.Connections[i].SendText('close');
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
          StringGridPunkte.RowCount := (Anzahl +1);    //erhöht RowCount!!!
          If StringGridPunkte.RowCount > 1 then StringGridPunkte.Row := 1;
          For i := 1 to StringGridUbersicht.RowCount do
            begin
               If StringGridUbersicht.Cells[3,i] = 'X' then
                 begin
                    StringGridPunkte.Cells[0,i] := IntToStr (i);
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
       Else Sortier_Modus := Letzte_Entfernung;  //Konstanten für das Grid werden zugewiesen
     If (Sortier_Modus = Gesamtentfernung) then InsertionSort();  //sortiert nach...
  end;

procedure TFormSpiel.InsertionSort();
 var i,j,Merke,Anzahl,k: integer;
     Zelle,Zelle_Merke: String;
  begin                       //nur eine Zahl wird nachträglich eingefügt.
     Try
      Anzahl := StringGridPunkte.RowCount -1;
      For j := 1 to Anzahl do
        begin
           Merke := StrToInt (StringGridPunkte.Cells[Sortier_Modus,j]);
           Zelle_Merke := StringGridPunkte.Rows[j].CommaText;
           i := j;
           While (i>1) and (Merke < (StrToInt(StringGridPunkte.Cells[Sortier_Modus,i-1]))) do
             begin
                Zelle := StringGridPunkte.Rows[i-1].CommaText;
                StringGridPunkte.Rows[i].CommaText := Zelle;
                Dec(i);
             end;
           StringGridPunkte.Rows[i].CommaText := Zelle_Merke;
        end;
      For k := 1 to StringGridPunkte.RowCount -1 do
      begin
         StringGridPunkte.Cells[0,k]:= IntToStr(k);
      end;
     Finally end; 
  end;

procedure TFormSpiel.BtnPrintClick(Sender: TObject);
 var i,lg: Integer;
  begin
     If PrintDialog.Execute then
       begin
          RichEditPrint.Clear;
          RichEditPrint.Lines.Add ('');
          RichEditPrint.Lines.Add ('  Erdkundelernprogramm' + '   '
                                   + 'OHG  '
                                   + FormatDateTime('dd.mm.yyyy, hh:nn', now));
          RichEditPrint.Lines.Add ('');                         
          RichEditPrint.Lines.Add ('  Benutzername:  '
                                   + FormKonsole.EdtBenutzername_Lehrer.Text);
          RichEditPrint.Lines.Add ('  Klasse:  '
                                   + FormStadt_Auswahl.EdtKlasse.Text);
          RichEditPrint.Lines.Add ('  Anzahl Städte:  '
                                    + IntToStr (StringGridAuswahl.RowCount -1));
          RichEditPrint.Lines.Add ('');
          RichEditPrint.Lines.Add ('  Platz   ' + 'Vorname   '
                                   + 'Gesamt-Entfernung');
          For i := 1 to StringGridPunkte.RowCount -1 do
            begin
               EdtText.Text := ('    ' + StringGridPunkte.Cells[0,i]
                                + '     ' +StringGridPunkte.Cells[1,i]);
               lg := length(EdtText.Text);
               While lg < 23 do
                 begin
                    Inc(lg);
                    EdtText.Text := EdtText.Text + ' ';
                 end;
               EdtText.Text := EdtText.Text + StringGridPunkte.Cells[3,i];  
               RichEditPrint.Lines.Add (EdtText.Text);
            end;
          RichEditPrint.Lines.Add ('');
          RichEditPrint.Lines.Add ('');
          RichEditPrint.Lines.Add ('   '
                                   +'OHG-Geesthacht Informatikprojekt 13b 2014');  
          RichEditPrint.Print('Delphi_RichEdit');
       end;
  end;

end.
