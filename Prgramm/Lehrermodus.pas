unit Lehrermodus;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ScktComp, StdCtrls, ExtCtrls, ImageOrten;

type
  TLehrer = class(TForm)
    CSSenden: TClientSocket;
    Spielzeit: TTimer;
    LblSpielzeit: TLabel;
    pruefenTimer: TTimer;
    LblStatus: TLabel;
    EdtIP: TEdit;
    MIndex: TMemo;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure SpielzeitTimer(Sender: TObject);
    procedure CSSendenConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormClick(Sender: TObject);
    procedure CSSendenRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure pruefenTimerTimer(Sender: TObject);
    procedure KilometerSenden;
    procedure EdtIPChange(Sender: TObject);
    procedure EdtIPClick(Sender: TObject);
    procedure EdtIPKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CSSendenError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure Button1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Lehrer: TLehrer;
  Zeit,sZeit:integer;
  stadt:integer;
  index:integer =20;
  Suchkarte:TImageOrten;


implementation

uses Struktur;

{$R *.DFM}

procedure TLehrer.FormCreate(Sender: TObject);
begin
     Lehrer.Color := clBlack;
     Self.DoubleBuffered := True;

     LblStatus.Caption := '123';
     LblSpielzeit.Caption := '123';

     EdtIP.Left := Screen.Width div 2 - EdtIP.Width div 2;
     EdtIP.Top := Screen.Height div 2 - EdtIP.Height div 2;

     MIndex.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Dateien/index.dat');
     index := StrToInt(MIndex.Lines[0]);
end;

procedure TLehrer.SpielzeitTimer(Sender: TObject);
begin
     dec(Zeit);
     LblSpielzeit.Caption := IntToStr(Zeit);
     if Zeit = 0 then
     begin
          SuchKarte.Entfernung := 999;
          KilometerSenden;
          Spielzeit.Enabled := false;
          LblSpielzeit.Caption := IntToStr(sZeit);
          LblStatus.Caption := 'PAUSE';
          pruefenTimer.Enabled := false;
          SuchKarte.geklickt := true;
     end;
end;

procedure TLehrer.CSSendenConnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
     SuchKarte := TImageOrten.Create(self);          // Die Suchkarte wird erzeugt
     SuchKarte.Parent := self;

     SuchKarte.Height := Screen.Height;
     SuchKarte.Width := (SuchKarte.Height*19) div 26;
     SuchKarte.Top := 0;
     SuchKarte.Left := Screen.Width div 2 - SuchKarte.Width div 2;

     SuchKarte.Picture.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Bilder/DKarte Ohne Städte.bmp'); // Die Deutschlandkarte wird geladen
end;

procedure TLehrer.FormClick(Sender: TObject);
begin
     close;
end;

procedure TLehrer.CSSendenRead(Sender: TObject; Socket: TCustomWinSocket);
var Nachricht:string;
begin
     Nachricht := Socket.ReceiveText;
     EdtIP.Text := Nachricht;

     if Nachricht[1] = 'Z' then
     begin

          sZeit := 10 * StrToInt(Nachricht[2]);
          sZeit := sZeit + StrToInt(Nachricht[3]);
     end;
     if Nachricht[1] = 'S' then
     begin
          if length(Nachricht) = 2 then stadt := StrToInt(Nachricht[2])
          else
          begin
               stadt := 10 * StrToInt(Nachricht[2]);
               stadt := stadt + StrToInt(Nachricht[3]);
          end;
          Zeit := sZeit;
          SuchKarte.Picture.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Bilder/DKarte Ohne Städte.bmp'); // neu geladen
          LblStatus.Caption := 'BEREIT!?';
          LblSpielzeit.Caption := '3';
          repaint;
          sleep(1000);
          LblSpielzeit.Caption := '2';
          repaint;
          sleep(1000);
          LblSpielzeit.Caption := '1';
          repaint;
          sleep(1000);
          LblStatus.Caption := 'Wo ist ' + SuchKarte.SatzLadenAnzeigen(stadt);
          Spielzeit.Enabled := true;
          pruefenTimer.Enabled := true;
          SuchKarte.geklickt := false;
          LblSpielzeit.Caption := IntToStr(Zeit);
     end;
     if Nachricht = 'close' then close;
end;

procedure TLehrer.pruefenTimerTimer(Sender: TObject);
begin
     if SuchKarte.geklickt = true then
     begin
          KilometerSenden;
          pruefenTimer.Enabled := false;
          SPielzeit.Enabled := false;
     end;
end;

procedure TLehrer.KilometerSenden;
var indexMessage,EntfernungMessage:string;
begin
     if index < 10 then indexMessage := 'i0' + IntToStr(index)
                   else indexMessage := 'i' + IntToStr(index);

     EntfernungMessage := 'e' + IntToStr(SuchKarte.Entfernung);
     if SuchKarte.Entfernung < 100 then EntfernungMessage := 'e0' + IntToStr(SuchKarte.Entfernung);
     if SuchKarte.Entfernung < 10  then EntfernungMessage := 'e00' + IntToStr(SuchKarte.Entfernung);

     if CsSenden.Active = true then
     CsSenden.Socket.SendText(indexMessage + EntfernungMessage);
end;

procedure TLehrer.EdtIPChange(Sender: TObject);
begin
     with EdtIP do
     begin

     if Text = '' then
     begin
          Text := 'IP-Adresse';
          Font.Color := clGray;
     end;
     if (Length(Text) = 11) and
        (Font.Color = clGray) then
     begin
          Font.Color := clWhite;
          Text := Text[1];
          SelStart := 1;
     end;
     if (Font.Color = clGray) and
        (Length(Text) < 10) then
        Text := 'IP-Adresse';

     end;
end;

procedure TLehrer.EdtIPClick(Sender: TObject);
begin
     if (EdtIP.Font.Color = clGray) then
     begin
          EdtIP.SelStart := 0;
          EdtIP.Font.Color := clGray;
     end;
end;

procedure TLehrer.EdtIPKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var indexMessage:string;
begin
     If (Key = VK_RETURN) then
     begin
          CSSenden.Host := EdtIP.Text;
          CSSenden.Port := 8080;
          CSSenden.Active := true;
          sleep(100);
          if index < 10 then IndexMessage := 'i0' + IntToStr(index)
                        else IndexMessage := 'i'  + IntToStr(index);
          CSSenden.Socket.SendText(IndexMessage);
     end;
end;

procedure TLehrer.CSSendenError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
     close;
end;

procedure TLehrer.Button1Click(Sender: TObject);
begin
     CsSenden.Active := false;
     //CsSenden.Close;

end;

end.
