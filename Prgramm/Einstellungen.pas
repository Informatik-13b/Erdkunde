unit Einstellungen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ShapeSchliessen, ExtCtrls, Grids, ColorGrd, jpeg, ImageMaskottchen,
  ShellAPI;

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
    ShpResetE: TShape;
    LblResetE: TLabel;
    ShpResetF: TShape;
    LblResetF: TLabel;
    ShpResetL: TShape;
    LblResetL: TLabel;
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
    procedure StrGrdOrteClick(Sender: TObject);
    procedure LblResetEMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    function DeleteFiles(const AFile: string): boolean;
    procedure LblResetEMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblResetFMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LblResetFMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblResetLMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LblResetLMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
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
     Maskottchen.Laenge := 81;
     Maskottchen.Hintergrund := Themenfarbe2;

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
          Height := ShpHintergrund2.Height - 4*Rand;
          DefaultColWidth := (Width-20) div 2;
          DefaultRowHeight := Height div 21;
          Font.Size := Rand div 2;
          FixedColor := Themenfarbe2;
          Color := Themenfarbe2;
          Font.Color := Themenfarbe1;
     end;
     OrteLaden;

     ShpResetE.Top := 27*Rand;
     ShpResetE.Height := 1*Rand;
     ShpResetE.Left := ShpHintergrund2.Left + Rand;
     ShpResetE.Width := (ShpHintergrund2.Width-4*Rand) div 3;
     ShpResetE.Brush.Color := Themenfarbe1;
     ShpResetE.Pen.Color := Themenfarbe2;

     LblResetE.Font.Color := Themenfarbe2;
     LblResetE.Font.Size := Screen.Height div 40;
     LblResetE.Top := ShpResetE.Top + ShpResetE.Height div 2 - LblResetE.Height div 2;
     LblResetE.Left := ShpResetE.Left + ShpResetE.Width div 2 - LblResetE.Width div 2;
     while LblResetE.Width >= ShpResetE.Width do
           LblResetE.Font.Size := LblResetE.Font.Size - 1;
     LblResetE.Left := ShpResetE.Left + ShpResetE.Width div 2 - LblResetE.Width div 2;
     LblResetE.Top := ShpResetE.Top + ShpResetE.Height div 2 - LblResetE.Height div 2;

     ShpResetF.Top := 27*Rand;
     ShpResetF.Height := 1*Rand;
     ShpResetF.Left := ShpHintergrund2.Left+ ShpResetE.Width + 2*Rand;
     ShpResetF.Width := (ShpHintergrund2.Width-4*Rand) div 3;
     ShpResetF.Brush.Color := Themenfarbe1;
     ShpResetF.Pen.Color := Themenfarbe2;

     LblResetF.Font.Color := Themenfarbe2;
     LblResetF.Font.Size := Screen.Height div 40;
     LblResetF.Top := ShpResetF.Top + ShpResetF.Height div 2 - LblResetF.Height div 2;
     LblResetF.Left := ShpResetF.Left + ShpResetF.Width div 2 - LblResetF.Width div 2;
     LblResetF.Font.Size := LblResetE.Font.Size;
     LblResetF.Left := ShpResetF.Left + ShpResetF.Width div 2 - LblResetF.Width div 2;
     LblResetF.Top := ShpResetF.Top + ShpResetF.Height div 2 - LblResetF.Height div 2;

     ShpResetL.Top := 27*Rand;
     ShpResetL.Height := 1*Rand;
     ShpResetL.Left := ShpHintergrund2.Left+ ShpResetE.Width + ShpResetF.Width + 3*Rand;
     ShpResetL.Width := (ShpHintergrund2.Width-4*Rand) div 3;
     ShpResetL.Brush.Color := Themenfarbe1;
     ShpResetL.Pen.Color := Themenfarbe2;

     LblResetL.Font.Color := Themenfarbe2;
     LblResetL.Font.Size := Screen.Height div 40;
     LblResetL.Top := ShpResetL.Top + ShpResetL.Height div 2 - LblResetL.Height div 2;
     LblResetL.Left := ShpResetL.Left + ShpResetL.Width div 2 - LblResetL.Width div 2;
     LblResetL.Font.Size := LblResetE.Font.Size;
     LblResetL.Left := ShpResetL.Left + ShpResetL.Width div 2 - LblResetL.Width div 2;
     LblResetL.Top := ShpResetL.Top + ShpResetL.Height div 2 - LblResetL.Height div 2;
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
          StrGrdOrte.RowCount := 2;
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
     if ShpResetE.Brush.Color = Themenfarbe2 then
     begin
          ShpResetE.Brush.Color := Themenfarbe1;
          LblResetE.Font.Color := Themenfarbe2;
          ShpResetE.Pen.Color := Themenfarbe2;
     end;
     if ShpResetF.Brush.Color = Themenfarbe2 then
     begin
          ShpResetF.Brush.Color := Themenfarbe1;
          LblResetF.Font.Color := Themenfarbe2;
          ShpResetF.Pen.Color := Themenfarbe2;
     end;
     if ShpResetL.Brush.Color = Themenfarbe2 then
     begin
          ShpResetL.Brush.Color := Themenfarbe1;
          LblResetL.Font.Color := Themenfarbe2;
          ShpResetL.Pen.Color := Themenfarbe2;
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
     ShpResetE.Brush.Color := Themenfarbe1;
     ShpResetE.Pen.Color := Themenfarbe2;
     LblResetE.Font.Color := Themenfarbe2;
     ShpResetF.Brush.Color := Themenfarbe1;
     ShpResetF.Pen.Color := Themenfarbe2;
     LblResetF.Font.Color := Themenfarbe2;
     ShpResetL.Brush.Color := Themenfarbe1;
     ShpResetL.Pen.Color := Themenfarbe2;
     LblResetL.Font.Color := Themenfarbe2;

     Menue.Themenfarbe1 := Themenfarbe1;
     Menue.Themenfarbe2 := Themenfarbe2;
     Menue.Farbenwechseln;

     Menue.MDAtei.Lines[2] := ColorToString(Themenfarbe1);
     Menue.MDatei.Lines[3] := ColorToString(Themenfarbe2);
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
     Maskottchen.FreuDich;
     TMaskottchen.Interval := 200;
end;


procedure TProfil.TMaskottchenTimer(Sender: TObject);
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

procedure TProfil.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     TMaskottchen.Enabled := false;
     Maskottchen.Free;
end;

procedure TProfil.StrGrdOrteClick(Sender: TObject);
begin
      Maskottchen.FreuDich;                                                //Maskottchen Lacht
      TMaskottchen.Interval := 200;
end;

procedure TProfil.LblResetEMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
     if ShpResetE.Brush.Color = Themenfarbe1 then
     begin
          ShpResetE.Brush.Color := Themenfarbe2;
          LblResetE.Font.Color := Themenfarbe1;
          ShpResetE.Pen.Color := Themenfarbe1;
     end;
     if ShpResetF.Brush.Color = Themenfarbe2 then
     begin
          ShpResetF.Brush.Color := Themenfarbe1;
          LblResetF.Font.Color := Themenfarbe2;
          ShpResetF.Pen.Color := Themenfarbe2;
     end;
end;

function TProfil.DeleteFiles(const AFile: string): boolean;
var
   sh: SHFileOpStruct;
begin
   ZeroMemory(@sh, SizeOf(sh));
   with sh do
   begin
     Wnd := Application.Handle;
     wFunc := FO_DELETE;
     pFrom := PChar(AFile +#0);
     fFlags := FOF_SILENT or FOF_NOCONFIRMATION;
   end;
   result := SHFileOperation(sh) = 0;

end;

procedure TProfil.LblResetEMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Text:string;
begin
     Text := 'Spielergebnisse wirklich zurücksetzen?' + #13 + #13 +
             'Alle Spielfortschritte gehen verloren!';
     if MessageDlg(Text,mtConfirmation,[mbYes,mbNo],0) = mrYes then

     if DeleteFiles(ExtractFilePath(ParamStr(0)) + 'Dateien\Ergebnisse\' + IntToStr(Menue.index) + '.dat') then
     begin
          OrteLaden;
     end;
end;

procedure TProfil.LblResetFMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
     if ShpResetF.Brush.Color = Themenfarbe1 then
     begin
          ShpResetF.Brush.Color := Themenfarbe2;
          LblResetF.Font.Color := Themenfarbe1;
          ShpResetF.Pen.Color := Themenfarbe1;
     end;
     if ShpResetE.Brush.Color = Themenfarbe2 then
     begin
          ShpResetE.Brush.Color := Themenfarbe1;
          LblResetE.Font.Color := Themenfarbe2;
          ShpResetE.Pen.Color := Themenfarbe2;
     end;
     if ShpResetL.Brush.Color = Themenfarbe2 then
     begin
          ShpResetL.Brush.Color := Themenfarbe1;
          LblResetL.Font.Color := Themenfarbe2;
          ShpResetL.Pen.Color := Themenfarbe2;
     end;
end;

procedure TProfil.LblResetFMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     if MessageDlg('Spielfarben wirklich zurücksetzen?',mtConfirmation,[mbYes,mbNo],0) = mrYes then
     begin
          Themenfarbe1 := RGB(244,164,96);
          Themenfarbe2 := RGB(205,133,63);
          FarbeWechseln;
     end;
end;

procedure TProfil.LblResetLMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
     if ShpResetL.Brush.Color = Themenfarbe1 then
     begin
          ShpResetL.Brush.Color := Themenfarbe2;
          LblResetL.Font.Color := Themenfarbe1;
          ShpResetL.Pen.Color := Themenfarbe1;
     end;
     if ShpResetF.Brush.Color = Themenfarbe2 then
     begin
          ShpResetF.Brush.Color := Themenfarbe1;
          LblResetF.Font.Color := Themenfarbe2;
          ShpResetF.Pen.Color := Themenfarbe2;
     end;
end;

procedure TProfil.LblResetLMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Text : string;
begin
     if Menue.MDatei.Lines[4] = 'index' then
     begin
          Showmessage('Dieser Benutzer ist noch keiner Klasse in der Leherkonsole '+
                      'zugeordnet!');
          exit;
     end;
     Text := 'Aktuelle Klasse wirklich verlassen?' + #13 + #13 +
             'Dieser Benutzer muss sich für den Prüfmodus erneut an der Lehrerkonsole anmelden!';
     if MessageDlg(Text,mtConfirmation,[mbYes,mbNo],0) = mrYes then
     begin
          Menue.MDatei.Lines[4] := 'index';
          Menue.MDatei.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(Menue.index) + '.dat');
     end;
end;

end.
