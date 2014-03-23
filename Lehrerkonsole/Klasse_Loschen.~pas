unit Klasse_Loschen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, StdCtrls;

type
  TFormKlasseLoschen = class(TForm)
    StringGridKlassenAuswahl: TStringGrid;
    BtnAbbrechen: TButton;
    Label1: TLabel;
    BtnLoschen: TButton;
    procedure FormCreate(Sender: TObject);
    procedure BtnAbbrechenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StringGridKlassenAuswahlSelectCell(Sender: TObject; ACol,
      ARow: Integer; var CanSelect: Boolean);
    procedure KlassenNamen_Finden();
    procedure BtnLoschenClick(Sender: TObject);
    procedure LetzteKlasse_Schreiben();
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  FormKlasseLoschen: TFormKlasseLoschen;
  Auswahl: String;
implementation

uses Konsole;

{$R *.DFM}

procedure TFormKlasseLoschen.FormCreate(Sender: TObject);
  begin
     With StringGridKlassenAuswahl do
       begin
          FormKlasseLoschen.Visible := False;
          Cells[0,0] := 'Nr.';
          Cells[1,0] := 'Klassen-Name';
          Selection := TGridRect (Rect(1,0,0,0)); //wählt nur die oberste aus
          RowCount := 15;
       end;
     BtnLoschen.Enabled := False;
     BtnLoschen.Caption := 'Klasse löschen';
     BtnAbbrechen.Caption := 'Vorgang abbrechen';
     RemoveMenu(GetSystemMenu(handle, false), SC_MOVE, MF_BYCOMMAND);
     RemoveMenu(GetSystemMenu(handle, false),SC_SIZE, MF_BYCOMMAND);
  end;

procedure TFormKlasseLoschen.BtnAbbrechenClick(Sender: TObject);
  begin
     FormKlasseLoschen.Close;
  end;

procedure TFormKlasseLoschen.FormClose(Sender: TObject; var Action: TCloseAction);
  begin
     FormKonsole.Visible := True;
     FormKonsole.BringToFront;
  end;

procedure TFormKlasseLoschen.StringGridKlassenAuswahlSelectCell(
 Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
  begin
     Auswahl := StringGridKlassenAuswahl.Cells[1,ARow];
     BtnLoschen.Enabled := True;
  end;

procedure TFormKlasseLoschen.KlassenNamen_Finden();
 var Suche : TSearchRec;
     Verzeichnis   : String;
     Text, TextA: String;
     Laenge, i, k: Integer;
  begin
      k := 1;
      Verzeichnis := 'Transportordner\KlassenNamen\';  //Verzeichnis wird festgelegt
      If FindFirst(Verzeichnis + '*.*' , faAnyFile, Suche) = 0 then
      Try Repeat   //Solange noch Dateien gefunden werden
        TextA := '';
        If (Suche.Attr and faArchive) = faArchive then
         begin
            Text := Suche.Name;
            Laenge := length(Text);
            For i := 1 to (Laenge - 4) do TextA := TextA + Text[i];
            StringGridKlassenAuswahl.Cells[1,k] := TextA;  //Die Datei-Endung wird gelöscht
            Inc (k);
         end;
       Until FindNext(Suche) <> 0;
      Finally
        SysUtils.FindClose(Suche);
       end;
  end;

procedure TFormKlasseLoschen.BtnLoschenClick(Sender: TObject);
  begin
     If Application.MessageBox('Wollen Sie die Klasse wirklich löschen?'
                                +#10#13+
                                'Alle Datensätze gehen verloren!!!',
                                'Warnung', MB_ICONWARNING or MB_OKCANCEL)
        = IDOK then             //Sicherheitsabfrage
         begin
            Try
              DeleteFile('TransportOrdner\KlassenNamen\'
                       + Auswahl +'.txt');
              FormKonsole.KlassenNamen_Finden;
              FormKonsole.Geladene_Klasse := FormKonsole.ComboBoxKlassenNamen.Items [0];
              showmessage('Die Klasse wurde erfolgreich gelöscht!');
              LetzteKlasse_Schreiben; // ändert die letzte Klasse
              FormKonsole.GridEinlesen();
            Except
              showmessage ('Fehler bei dem Löschen der Datei');
              Close();
              FormKonsole.Close();
             end;
            FormKonsole.Visible := True;
            FormKlasseLoschen.Visible := False;
            FormKonsole.BringToFront;
            FormKonsole.ComboBoxKlassenNamen.SetFocus;
         end;
  end;

procedure TFormKlasseLoschen.LetzteKlasse_Schreiben();
 var LastClass_Liste: TStringList;
  begin
     LastClass_Liste := TStringList.Create;
     Try
       LastClass_Liste.Add (FormKonsole.Geladene_Klasse);
       LastClass_Liste.SaveToFile ('TransportOrdner\LehrerOrdner\'
                                   + FormKonsole.EdtBenutzername_Lehrer.Text
                                   + '\Last_Class.txt');
      Finally
         LastClass_Liste.Free;    //Speichert die zuletz geladene Klasse!
       end;
  end;

end.
