unit Karte;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImageOrten, ShapeSchliessen, OleCtrls, SHDocVw, StdCtrls, ExtCtrls, Grids,
  ImageMaskottchen;

type
    TOrte = record
     Index : integer;
     Ortsname : string[20];
     Schwierigkeit : string[10];
     KoSy_x, KoSy_y : integer;
    end;
  TOrte_Finden = class(TForm)
    ShpHintergrund1: TShape;
    LblUeberschrift: TLabel;
    LblStadt: TLabel;
    LblSchwierigkeit: TLabel;
    pruefenTimer: TTimer;
    LblEntfernung: TLabel;
    StrGrdOrte: TStringGrid;
    LblWeiter: TLabel;
    ShpWeiter: TShape;
    TMaskottchen: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure ShpHintergrund1MouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure pruefenTimerTimer(Sender: TObject);
    procedure OrteLaden;
    procedure GridSpeichern;
    procedure GridLaden;
    procedure LblWeiterMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LblWeiterClick(Sender: TObject);
    procedure ShpWeiterMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TMaskottchenTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
    procedure weiter;
    procedure EntfernungSpeichern;
    procedure StadtAnpassen;
  public
    { Public-Deklarationen }
  end;

var
  Orte_Finden: TOrte_Finden;
  Themenfarbe1: TColor;
  Themenfarbe2: TColor;
  SchliessenShape:TShapeSchliessen;
  SuchKarte:TImageOrten;
  Rand:integer;
  Ort:integer;
  Orteanzahl:integer;
  Maskottchen:TImageMaskottchen;

implementation

uses Struktur;

{$R *.DFM}

procedure TOrte_Finden.FormCreate(Sender: TObject);
begin

     self.DoubleBuffered := true;

     Themenfarbe1 := Menue.Themenfarbe1;             // Themenfarbe wird aus dem Men�-Formular gelesen
     Themenfarbe2 := Menue.Themenfarbe2;

     Orte_Finden.Color := Themenfarbe1;

     SuchKarte := TImageOrten.Create(self);          // Die Suchkarte wird erzeugt
     SuchKarte.Parent := self;

     SuchKarte.Height := (Screen.Height*14) div 15;          // Die Komponente platziert sich auf dem Formular.
     SuchKarte.Width := (SuchKarte.Height*19) div 26;
     SuchKarte.Top := Screen.Height div 30;
     SuchKarte.Left := Screen.Width - SuchKarte.Width - SuchKarte.Top;

     SchliessenShape := TShapeSchliessen.Create(self);    // Erstellen der Schlie�en-Komponente
     SchliessenShape.Parent := self;
     SchliessenShape.Themenfarbe1 := Themenfarbe1;        // die Themenfarben werden �bergeben
     SchliessenShape.Themenfarbe2 := Themenfarbe2;
     SchliessenShape.Fenster := Orte_Finden;           // Wichtig! Das Fenster wird �bergeben, damit die Komponente wei�
                                                       // welches Fenster geschlossen werden soll.

     Rand := Screen.Height div 30;                    // Rand ist eine bestimme L�nge in Abh�ngigkeit der Fensterh�he

     ShpHintergrund1.Left := Rand;                                                   // Objekte werden platziert
     ShpHintergrund1.Top  := Rand;
     ShpHintergrund1.Width := Screen.Width - 3*Rand - ((Screen.Height*133)div 195);
     ShpHintergrund1.Height:= Screen.Height - 2*Rand;
     ShpHintergrund1.Brush.Color := Themenfarbe2;

     Maskottchen := TImageMaskottchen.Create(self);
     Maskottchen.Height := 15*Rand;
     Maskottchen.Parent := self;
     Maskottchen.Width := (Maskottchen.Height * 225) div 300;
     Maskottchen.Left := Rand + ShpHintergrund1.Width div 2 - Maskottchen.Width div 2;
     Maskottchen.Top := 16*Rand;
     Maskottchen.Zustand := 'Normal';
     Maskottchen.aktuellesBild := 0;
     Maskottchen.Normalzustand := true;
     Maskottchen.Laenge := 81;
     Maskottchen.Hintergrund := Themenfarbe2;

     LblUeberschrift.Font.Size := Screen.Height div 30;
     LblUeberschrift.Top := 2*Rand;
     LblUeberschrift.Font.Color := Themenfarbe1;
     while LblUeberschrift.Width > ShpHintergrund1.Width - 2*Rand do
     begin
          LblUeberschrift.Font.Size := LblUeberschrift.Font.Size - 1;
     end;
     LblUeberschrift.Left := ((ShpHintergrund1.Width + 2*Rand) div 2)
                              - LblUeberschrift.Width div 2;

     LblStadt.Font.Size := Screen.Height div 20;
     LblStadt.Top := 5*Rand;
     LblStadt.Font.Color := Themenfarbe1;

     LblSchwierigkeit.Font.Size := Screen.Height div 40;
     LblSchwierigkeit.Top := 8*Rand;
     LblSchwierigkeit.Left := ShpHintergrund1.Left + ShpHintergrund1.Width div 2 - LblSchwierigkeit.Width div 2;
     LblSchwierigkeit.Caption := '';
     LblSchwierigkeit.Font.Color := Themenfarbe1;

     LblEntfernung.Font.Size := Screen.Height div 40;
     LblEntfernung.Top := 10*Rand;
     LblEntfernung.Left := ShpHintergrund1.Left + ShpHintergrund1.Width div 2 - LblEntfernung.Width div 2;
     LblEntfernung.Caption := '';
     LblEntfernung.Font.Color := Themenfarbe1;

     ShpWeiter.Top := 13*Rand;
     ShpWeiter.Height := 3*Rand;
     ShpWeiter.Left := 2*Rand;
     ShpWeiter.Width := ShpHintergrund1.Width - 2*Rand;
     ShpWeiter.Brush.Color := Themenfarbe1;
     ShpWeiter.Pen.Color := Themenfarbe2;

     LblWeiter.Font.Color := Themenfarbe2;
     LblWeiter.Font.Size := Screen.Height div 30;
     LblWeiter.Top := ShpWeiter.Top + ShpWeiter.Height div 2 - LblWeiter.Height div 2;
     LblWeiter.Left := ShpWeiter.Left + ShpWeiter.Width div 2 - LblWeiter.Width div 2;

     StrGrdOrte.Cells[0,0] := 'Stadt';
     StrGrdOrte.Cells[1,0] := 'beste Ortung in km';
     OrteLaden;

     randomize;
     weiter;
end;

procedure TOrte_Finden.weiter;
begin
     SuchKarte.Picture := nil;  //Image wird geleert
     SuchKarte.Picture.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Bilder/DKarte Ohne St�dte.bmp'); // Die Deutschlandkarte wird geladen
     Ort := random(Orteanzahl)+1; // eine Zufallsstadt wird gelost
     LblStadt.Caption := SuchKarte.SatzLadenAnzeigen(Ort);  //Stadtname wird angezeigt und der Karte zugewiesen
     StadtAnpassen;
     SuchKarte.geklickt := false;
     LblWeiter.Enabled := false;
     ShpWeiter.Enabled := false;
     LblEntfernung.Caption := '';
     pruefenTimer.Enabled := true;
end;

procedure TOrte_Finden.StadtAnpassen;
begin
     LblStadt.Font.Size := 40;
     if LblStadt.Width > ShpHintergrund1.Width - 2*Rand then
     while LblStadt.Width > ShpHintergrund1.Width - 2*Rand do
       LblStadt.Font.Size := LblStadt.Font.Size - 1;
     LblStadt.Left := ShpHintergrund1.Left + ShpHintergrund1.Width div 2 - LblStadt.Width div 2;  //Position wird angepasst
end;

procedure TOrte_Finden.OrteLaden;  // Ergebnissdatei wird ge�ffnet
var aktueller_record : integer;    // oder neu erzeugt und mit anfangsdaten gef�llt
    ROrte : TOrte;
    Orte_Datei : file of TOrte;
begin
     if not FileExists(ExtractFilePath(ParamStr(0)) + 'Dateien\Ergebnisse\' + IntToStr(Menue.index) + '.dat') then
     begin
          AssignFile(Orte_Datei,ExtractFilePath(ParamStr(0)) + 'OrtsKoordinaten\Orte_KoSy.dat');      // Datei wird ge�ffnetReset(Orte_Datei);
          Reset(Orte_Datei);
          for aktueller_record := 0 to FileSize(Orte_Datei)-1 do
          begin
               Seek(Orte_Datei,aktueller_record);
               Read(Orte_Datei,ROrte);
               StrGrdOrte.Cells[0,aktueller_record+1] := ROrte.Ortsname;
               StrGrdOrte.Cells[1,aktueller_record+1] := '999';
               StrGrdOrte.RowCount := StrGrdOrte.RowCount + 1;
          end;
          StrGrdOrte.Cells[0,StrGrdOrte.RowCount - 1] := 'Durchschnitt';
          StrGrdOrte.Cells[1,StrGrdOrte.RowCount - 1] := '999';
          CloseFile(Orte_Datei);
          GridSpeichern;
     end else GridLaden;
     Orteanzahl := StrGrdOrte.RowCount-2;
end;

procedure TOrte_Finden.GridSpeichern;  // Tabelle wird gespeichert
var Tabelle:TStringList;
    i:integer;
begin
     Tabelle := TStringList.Create;
     try
        Tabelle.Add(IntToStr(StrGrdOrte.RowCount));
        Tabelle.Add(IntToStr(StrGrdOrte.ColCount));
        for i := 0 to StrGrdOrte.RowCount -1 do
            Tabelle.Add(StrGrdOrte.Rows[i].CommaText);
        Tabelle.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien\Ergebnisse\' + IntToStr(Menue.index) + '.dat');
     finally
        Tabelle.free;
     end;
end;

procedure TOrte_Finden.GridLaden;  //  Tabelle wird geladen
var Tabelle:TStringList;
    i:integer;
begin
     Tabelle := TStringList.Create;
     try
        Tabelle.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Dateien\Ergebnisse\' + IntToStr(Menue.index) + '.dat');
        StrGrdOrte.RowCount := StrToInt(Tabelle[0]);
        StrGrdOrte.ColCount := StrToInt(Tabelle[1]);
        for i := 0 to StrGrdOrte.RowCount - 1 do
            StrGrdOrte.Rows[i].CommaText := Tabelle[i+2];
        finally
            Tabelle.Free;
        end;
end;

procedure TOrte_Finden.FormMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
     if SchliessenShape.inaktiv = false then    // Wenn das Shape zum Schlie�en noch
     begin                                      // aktiv ist,
          SchliessenShape.inaktiv := true;      // wird sein Status auf inaktiv gesetzt
          SchliessenShape.Repaint;              // und es zeichnet sich neu.
     end;
end;



procedure TOrte_Finden.ShpHintergrund1MouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
     if SchliessenShape.inaktiv = false then    // Wenn das Shape zum Schlie�en noch
     begin                                      // aktiv ist,
          SchliessenShape.inaktiv := true;      // wird sein Status auf inaktiv gesetzt
          SchliessenShape.Repaint;              // und es zeichnet sich neu.
     end;
     if ShpWeiter.Brush.Color = Themenfarbe2 then
     begin
          ShpWeiter.Brush.Color := Themenfarbe1;
          LblWeiter.Font.Color := Themenfarbe2;
          ShpWeiter.Pen.Color := Themenfarbe2;
     end;
end;

procedure TOrte_Finden.pruefenTimerTimer(Sender: TObject);
begin
     if SuchKarte.geklickt = true then                                 // Wenn geklickt wurde,
     begin
          LblEntfernung.Caption := IntToStr(SuchKarte.Entfernung) + ' km';     // wird die Entfernung in km  aus der Suchkarte gelesen
          LblEntfernung.Left := ShpHintergrund1.Left + ShpHintergrund1.Width div 2 - LblEntfernung.Width div 2;
          ShpWeiter.Enabled := true;
          LblWeiter.Enabled := true;
          pruefenTimer.Enabled := false;
          EntfernungSpeichern;
          case SuchKarte.Entfernung of
          0..50:
          begin
               Maskottchen.FreuDich;
               TMaskottchen.Interval := 200;
          end;
          51..100:
          begin
               Maskottchen.SeiTraurig;
               TMaskottchen.Interval := 200;
          end;
          101..999:
          begin
               Maskottchen.Weine;
               TMaskottchen.Interval := 50;
          end;
          end;
     end;
end;

procedure TOrte_Finden.EntfernungSpeichern;
var i,Durchschnitt: integer;
begin
     if SuchKarte.Entfernung < StrToInt(StrGrdOrte.Cells[1,Ort]) then
     begin
          StrGrdOrte.Cells[1,Ort] := IntToStr(SuchKarte.Entfernung);
          Durchschnitt := 0;
          for i := 1 to Orteanzahl do
          begin
               Durchschnitt := Durchschnitt + StrToInt(StrGrdOrte.Cells[1,i]);
          end;
          Durchschnitt := Durchschnitt div Orteanzahl;
          StrGrdOrte.Cells[1,StrGrdOrte.RowCount-1] := IntToStr(Durchschnitt);
          GridSpeichern;
     end;
end;

procedure TOrte_Finden.LblWeiterMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
     if ShpWeiter.Brush.Color = Themenfarbe1 then
     begin
          ShpWeiter.Brush.Color := Themenfarbe2;
          LblWeiter.Font.Color := Themenfarbe1;
          ShpWeiter.Pen.Color := Themenfarbe1;
     end;
end;


procedure TOrte_Finden.LblWeiterClick(Sender: TObject);
begin
     weiter;
end;

procedure TOrte_Finden.ShpWeiterMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     weiter;
end;

procedure TOrte_Finden.TMaskottchenTimer(Sender: TObject);
begin
     with Maskottchen do
     begin
          if Normalzustand = true then
          begin
               inc(aktuellesBild);
               if aktuellesBild <= laenge then
                  BildLaden('Bilder\Maskottchen\' + Zustand + '\('+ IntToStr(aktuellesBild) + ').gif')

          else
          begin
               GehSchlafen;
               TMaskottchen.Interval := 500;
          end;
          end else
          begin

               if aktuellesBild <= laenge then
               begin
                    inc(aktuellesBild);
                    BildLaden('Bilder\Maskottchen\' + Zustand + '\('+ IntToStr(aktuellesBild) + ').gif');
               end else
               begin
                    Zustand := 'Normal';
                    Normalzustand := true;
                    laenge := 81;
                    aktuellesBild := 0;
                    TMaskottchen.Interval := 200;
               end;
          end;
     end;
end;

procedure TOrte_Finden.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     TMaskottchen.Enabled := false;
     Maskottchen.Free;
end;

end.
