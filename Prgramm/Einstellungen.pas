unit Einstellungen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ShapeSchliessen, ExtCtrls, Grids, ColorGrd, jpeg, ImageMaskottchen;

type
    TOrte = record
     Index : integer;
     Ortsname : string[20];
     Schwierigkeit : string[10];
     KoSy_x, KoSy_y : integer;
    end;
  TProfil = class(TForm)
    ShpHintergrund1: TShape;
    ShpHintergrund2: TShape;
    ImgFarbe: TImage;
    LblFarbe: TLabel;
    StrGrdOrte: TStringGrid;
    TMaskottchen: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FarbeWechseln;
    procedure ImgFarbeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure OrteLaden;
    procedure GridSpeichern;
    procedure GridLaden;
    procedure TMaskottchenTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Profil: TProfil;
  Themenfarbe1: TColor;
  Themenfarbe2: TColor;
  SchliessenShape:TShapeSchliessen;
  Rand:integer;  // Maßeinheit abhängig von der Bildschirmauflösung
  Maskottchen:TImageMaskottchen;

implementation

{$R *.DFM}

uses Struktur;

procedure TProfil.FormCreate(Sender: TObject);
begin
     self.DoubleBuffered := true;

     Themenfarbe1 := Menue.Themenfarbe1;             // Themenfarbe wird aus dem Menü-Formular gelesen
     Themenfarbe2 := Menue.Themenfarbe2;

     Color := Themenfarbe1;

     SchliessenShape := TShapeSchliessen.Create(self);    // Erstellen der Schließen-Komponente
     SchliessenShape.Parent := self;
     SchliessenShape.Themenfarbe1 := Themenfarbe1;        // die Themenfarben werden übergeben
     SchliessenShape.Themenfarbe2 := Themenfarbe2;
     SchliessenShape.Fenster := Profil;           // Wichtig! Das Fenster wird übergeben, damit die Komponente weiß
                                                       // welches Fenster geschlossen werden soll.
     Rand := Screen.Height div 30;

     ShpHintergrund1.Left := Rand;                                                  //   V
     ShpHintergrund1.Top  := Rand;
     ShpHintergrund1.Width := Screen.Width - 6*Rand - ((Screen.Height*133)div 195);
     ShpHintergrund1.Height:= Screen.Height - 2*Rand;
     ShpHintergrund1.Brush.Color := Themenfarbe2;

     ShpHintergrund2.Left := 2*Rand + ShpHintergrund1.Width;
     ShpHintergrund2.Top  := Rand;
     ShpHintergrund2.Width := Screen.Width - ShpHintergrund1.Width - 3*Rand;
     ShpHintergrund2.Height:= Screen.Height - 2*Rand;
     ShpHintergrund2.Brush.Color := Themenfarbe2;

     Maskottchen := TImageMaskottchen.Create(self);
     Maskottchen.Height := 15*Rand;
     Maskottchen.Parent := self;
     Maskottchen.Width := (Maskottchen.Height * 225) div 300;
     Maskottchen.Left := Rand + ShpHintergrund1.Width div 2 - Maskottchen.Width div 2;
     Maskottchen.Top := 16*Rand;
     Maskottchen.Zustand := 'Normal';
     Maskottchen.aktuellesBild := 0;
     Maskottchen.Normalzustand := true;
     Maskottchen.Laenge := 27;

     ImgFarbe.Left := 2*Rand;
     ImgFarbe.Top := 3*Rand;
     ImgFarbe.Height := 12*Rand;
     ImgFarbe.Width := ShpHintergrund1.Width - 2*Rand;

     LblFarbe.Left := 2*Rand;
     LblFarbe.Top := 1*Rand;
     LblFarbe.Font.Color := Themenfarbe1;
     LblFarbe.Caption := 'Rechtsklick = Fensterfarbe | Linksklick = Objektfarbe';
     while LblFarbe.Width > ImgFarbe.Width do
       LblFarbe.Font.Size := LblFarbe.Font.Size - 1;
     if LblFarbe.Font.Size < 10 then
     begin
          LblFarbe.Caption := 'Rechtsklick = Fensterfarbe' + #13 + 'Linksklick = Objektfarbe';
          LblFarbe.Font.Size := 15;
     end;

     with StrGrdOrte do
     begin
          Cells[0,0] := 'Stadt';
          Cells[1,0] := 'beste Ortung in km';
          Left := ShpHintergrund2.Left + Rand;
          Width := ShpHintergrund2.Width - 2*Rand;
          Top := 2* Rand;
          Height := ShpHintergrund2.Height - 2*Rand;
          DefaultColWidth := (Width-20) div 2;
          DefaultRowHeight := Height div 21;
          Font.Size := Rand div 2;
          FixedColor := Themenfarbe2;
          Color := Themenfarbe2;
          Font.Color := Themenfarbe1;
     end;
     OrteLaden;
end;

procedure TProfil.OrteLaden;
var aktueller_record : integer;
    ROrte : TOrte;
    Orte_Datei : file of TOrte;
begin
     if not FileExists(ExtractFilePath(ParamStr(0)) + 'Dateien\Ergebnisse\' + IntToStr(Menue.index) + '.dat') then
     begin
          AssignFile(Orte_Datei,ExtractFilePath(ParamStr(0)) + 'OrtsKoordinaten\Orte_KoSy.dat');      // Datei wird geöffnetReset(Orte_Datei);
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
end;

procedure TProfil.GridSpeichern;
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

procedure TProfil.GridLaden;
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


procedure TProfil.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     if SchliessenShape.inaktiv = false then    // Wenn das Shape zum Schließen noch
     begin                                      // aktiv ist,
          SchliessenShape.inaktiv := true;      // wird sein Status auf inaktiv gesetzt
          SchliessenShape.Repaint;              // und es zeichnet sich neu.
     end;
end;




procedure TProfil.FarbeWechseln;
begin
     Profil.Color := Themenfarbe1;
     LblFarbe.Font.Color := Themenfarbe1;
     with StrGrdOrte do
     begin
          FixedColor := Themenfarbe2;
          Color := Themenfarbe2;
          Font.Color := Themenfarbe1;
     end;
     ShpHintergrund1.Brush.Color := Themenfarbe2;
     ShpHintergrund2.Brush.Color := Themenfarbe2;
     SchliessenShape.Themenfarbe1 := Themenfarbe1;
     SchliessenShape.Themenfarbe2 := Themenfarbe2;
     SchliessenShape.repaint;
     Menue.Themenfarbe1 := Themenfarbe1;
     Menue.Themenfarbe2 := Themenfarbe2;
     Menue.Farbenwechseln;

     Menue.MDAtei.Lines[5] := ColorToString(Themenfarbe1);
     Menue.MDatei.Lines[6] := ColorToString(Themenfarbe2);
     Menue.MDatei.Lines.SaveTofile(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(Menue.index) + '.dat');
end;



procedure TProfil.ImgFarbeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var tempFarbe:TColor;
begin
     x := round(x * 640 / ImgFarbe.Width);
     y := round(y * 640 / ImgFarbe.Height);
     tempFarbe := ImgFarbe.Canvas.Pixels[x,y];

     if (Button = mbLeft) then
     begin
        if (GetRValue(tempFarbe) < GetRValue(Themenfarbe2) + 10) and
           (GetRValue(tempFarbe) > GetRValue(Themenfarbe2) - 10) then exit;
        if (GetgValue(tempFarbe) < GetgValue(Themenfarbe2) + 10) and
           (GetgValue(tempFarbe) > GetgValue(Themenfarbe2) - 10) then exit;
        if (GetbValue(tempFarbe) < GetbValue(Themenfarbe2) + 10) and
           (GetbValue(tempFarbe) > GetbValue(Themenfarbe2) - 10) then exit;
        Themenfarbe1 := tempFarbe;
        FarbeWechseln;
     end;

     if (Button = mbright) then
     begin
        if (GetRValue(tempFarbe) < GetRValue(Themenfarbe1) + 10) and
           (GetRValue(tempFarbe) > GetRValue(Themenfarbe1) - 10) then exit;
        if (GetgValue(tempFarbe) < GetgValue(Themenfarbe1) + 10) and
           (GetgValue(tempFarbe) > GetgValue(Themenfarbe1) - 10) then exit;
        if (GetbValue(tempFarbe) < GetbValue(Themenfarbe1) + 10) and
           (GetbValue(tempFarbe) > GetbValue(Themenfarbe1) - 10) then exit;
        Themenfarbe2 := tempFarbe;
        FarbeWechseln;
     end;
end;


procedure TProfil.TMaskottchenTimer(Sender: TObject);
begin
     with Maskottchen do
     begin
          if Normalzustand = true then
          begin
               inc(aktuellesBild);
               if aktuellesBild <= laenge then
                  BildLaden('Bilder\Maskottchen\' + Zustand + '\'+ IntToStr(aktuellesBild) + '.gif')

          else aktuellesBild := 0;
          end else
          begin

               if aktuellesBild <= laenge then
               begin
                    inc(aktuellesBild);
                    BildLaden('Bilder\Maskottchen\' + Zustand + '\'+ IntToStr(aktuellesBild) + '.gif');
               end else
               begin
                    Zustand := 'Normal';
                    Normalzustand := true;
                    laenge := 27;
                    aktuellesBild := 0;
               end;
          end;
     end;
end;

procedure TProfil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     TMaskottchen.Enabled := false;
     Maskottchen.Free;
end;

end.
