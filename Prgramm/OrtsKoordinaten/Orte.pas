unit Orte;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls;

type
  TOrte = record
     Index : integer;
     Ortsname : string[20];
     Schwierigkeit : string[10];
     KoSy_x, KoSy_y : integer;
  end;
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    EdtIndex: TEdit;
    EdtOrt: TEdit;
    EdtKoSy_x: TEdit;
    Label4: TLabel;
    EdtKoSy_y: TEdit;
    BtnSpeichern: TButton;
    BtnWeiter: TButton;
    BtnZurueck: TButton;
    BtnNeu: TButton;
    Label5: TLabel;
    EdtSchwierigkeit: TEdit;
    Label6: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure SatzLadenAnzeigen;
    procedure SatzSpeichern;
    procedure Neu;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnSpeichernClick(Sender: TObject);
    procedure BtnWeiterClick(Sender: TObject);
    procedure BtnZurueckClick(Sender: TObject);
    procedure BtnNeuClick(Sender: TObject);
  private
    { Private-Deklarationen }
    aktueller_record : integer;
    ROrte : TOrte;
    Orte_Datei : file of TOrte;
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation

{$R *.DFM}

procedure TForm1.FormCreate(Sender: TObject);
begin
     AssignFile(Orte_Datei,'Orte_KoSy.dat');      // Datei wird ge�ffnet
     aktueller_record := 1;
     if FileExists('Orte_KoSy.dat') then
     begin
          Reset(Orte_Datei);
          SatzLadenAnzeigen;                       // erster Datensatz wird geladen
     end
     else Rewrite(Orte_Datei);
     Label5.Caption := IntToStr(aktueller_record);
end;

procedure TForm1.SatzLadenAnzeigen;
begin
     Seek(Orte_Datei,aktueller_record-1);
     if FileSize(Orte_Datei) > 0 then
     begin
          Read(Orte_Datei,ROrte);                      // Der Datensatz wird in den Record geladen
          with ROrte do
          begin
               EdtIndex.Text  := IntToStr(Index);      // und in den Edits ausgegeben
               EdtOrt.Text    := Ortsname;
               EdtSchwierigkeit.Text := Schwierigkeit;
               EdtKoSy_x.Text := IntToStr(KoSy_x);
               EdtKoSy_y.Text := IntToStr(KoSy_y);
          end;
     end;
     Label5.Caption := IntToStr(aktueller_record);
end;

procedure TForm1.BtnSpeichernClick(Sender: TObject);
begin
     SatzSpeichern;
end;

procedure TForm1.SatzSpeichern;                       // Speichern...
begin
     with ROrte do
     begin
          Index    := StrToInt(EdtIndex.Text);
          Ortsname := EdtOrt.Text;
          Schwierigkeit := EdtSchwierigkeit.Text;
          KoSy_x   := StrToInt(EdtKoSy_x.Text);
          KoSy_y   := StrToInt(EdtKoSy_y.Text);
     end;
     Seek(Orte_Datei,aktueller_record-1);
     Write(Orte_Datei,ROrte);
     Label5.Caption := IntToStr(aktueller_record);
end;

procedure TForm1.Neu;
begin
     SatzSpeichern;
     aktueller_record := FileSize(Orte_Datei) + 1;
     EdtIndex.Text := IntToStr(aktueller_record);
     EdtOrt.Text := '';
     EdtSchwierigkeit.Text := '';
     EdtKoSy_x.Text := '';
     EdtKoSy_y.Text := '';
     Label5.Caption := IntToStr(aktueller_record);
end;


procedure TForm1.BtnWeiterClick(Sender: TObject);
begin
     SatzSpeichern;
     if aktueller_record < FileSize(Orte_Datei) then
     begin
          inc(aktueller_record);
          SatzLadenAnzeigen;
     end;
     Label5.Caption := IntToStr(aktueller_record);
end;

procedure TForm1.BtnZurueckClick(Sender: TObject);
begin
     SatzSpeichern;
     if aktueller_record > 1 then
     begin
          dec(aktueller_record);
          SatzLadenAnzeigen;
     end;
     Label5.Caption := IntToStr(aktueller_record);
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     CloseFile(Orte_Datei);
end;

procedure TForm1.BtnNeuClick(Sender: TObject);
begin
     SatzSpeichern;
     neu;
end;

end.
