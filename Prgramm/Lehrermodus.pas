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
    GBLehreranmeldung: TGroupBox;
    ShpSenden: TShape;
    LblSenden: TLabel;
    ShpZurueckL: TShape;
    LblZurueckL: TLabel;
    EdtVornameL: TEdit;
    EdtNameL: TEdit;
    STLoescheVornameL: TStaticText;
    STLoescheNameL: TStaticText;
    EdtIPV: TEdit;
    STLoescheIP: TStaticText;
    VerbindenTimer: TTimer;
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
    procedure EdtVornameLChange(Sender: TObject);
    procedure EdtNameLChange(Sender: TObject);
    procedure EdtNameLClick(Sender: TObject);
    procedure EdtVornameLClick(Sender: TObject);
    procedure EdtIPVChange(Sender: TObject);
    procedure EdtIPVClick(Sender: TObject);
    procedure STLoescheVornameLMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure STLoescheVornameLMouseUp(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure STLoescheNameLMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure STLoescheNameLMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure STLoescheIPMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure STLoescheIPMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblSendenMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblSendenMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblSendenMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GBLehreranmeldungMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure VerbindenTimerTimer(Sender: TObject);
    procedure LblZurueckLMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblZurueckLMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LblZurueckLMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure StatusAnpassen;
    procedure CSSendenDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure EdtVornameLKeyPress(Sender: TObject; var Key: Char);
    procedure EdtNameLKeyPress(Sender: TObject; var Key: Char);
  private
    { Private-Deklarationen }
    function IPpruefen(Text:string):boolean;
  public
    { Public-Deklarationen }
  end;

var
  Lehrer: TLehrer;
  Zeit,sZeit:integer;
  stadt:integer;
  index:integer =20;
  Suchkarte:TImageOrten;
  Erstanmeldung : boolean;


implementation

uses Struktur;

{$R *.DFM}

procedure TLehrer.FormCreate(Sender: TObject);
begin
     Lehrer.Color := clBlack;
     Self.DoubleBuffered := True;

     GBLehreranmeldung.Top := -GBLehreranmeldung.Height;
     GBLehreranmeldung.Left := Screen.Width div 2 - GBLehreranmeldung.Width div 2;

     LblStatus.Left := 10;
     LblSpielzeit.Left := 10;
     LblStatus.Caption := ' ';
     LblSpielzeit.Caption := ' ';

     if Menue.MDatei.Lines[4] = 'index' then   // Wenn dem angemeldeten Schüler noch keine index
     begin                                     // einer in der Leherkonsole angelegten Klasse zugewiesen wurde
          VerbindenTimer.Enabled := true;      // wird das Modus zum erstanmelden geöffnet
          Erstanmeldung := true;
          EdtIP.Enabled := false;
     end else
     begin
          index := StrToInt(Menue.MDatei.Lines[4]);  // ansonsten der Index ausgelesen
          Erstanmeldung := false;
          EdtIP.Visible := true;
          EdtIP.Left := Screen.Width div 2 - EdtIP.Width div 2;
          EdtIP.Top := Screen.Height div 2 - EdtIP.Height div 2;
     end;
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
          StatusAnpassen;
          pruefenTimer.Enabled := false;
          SuchKarte.geklickt := true;
          SuchKarte.Enabled := false;
     end;
end;

procedure TLehrer.CSSendenConnect(Sender: TObject;
  Socket: TCustomWinSocket);
  var indexMessage,Vorname,Nachname:string;
begin
     if Erstanmeldung = true then
     begin
          Vorname := EdtVornameL.Text;   // Bei der Erstanmeldung werden der Lehrerkonsole
          Nachname := EdtNameL.Text;     // die Namen gesendet

          CSSenden.Socket.SendText(',' + Vorname + ',' + Nachname +',,'); // Eine Nachricht im Kommatextformat

          {sleep(100);
          CSSenden.Socket.SendText ('1' + Vorname);
          sleep(100);
          CSSenden.Socket.SendText ('2' + Nachname);
          sleep(100); }
     end else                                    // ansonsten der index
     begin
          if index < 10 then IndexMessage := 'i0' + IntToStr(index)
                        else IndexMessage := 'i'  + IntToStr(index);
          CSSenden.Socket.SendText(IndexMessage);

          SuchKarte := TImageOrten.Create(self);          // Die Suchkarte wird erzeugt
          SuchKarte.Parent := self;

          SuchKarte.Height := Screen.Height;
          SuchKarte.Width := (SuchKarte.Height*19) div 26;
          SuchKarte.Top := 0;
          SuchKarte.Left := Screen.Width div 2 - SuchKarte.Width div 2;
          SuchKarte.Picture.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Bilder/DKarte Ohne Städte.bmp'); // Die Deutschlandkarte wird geladen
          SuchKarte.geklickt := true;                                     //Die Karte wird geöffnet
          SuchKarte.Enabled := false;

          EdtIP.Visible := false;
          EdtIP.Enabled := false;
     end;
end;

procedure TLehrer.FormClick(Sender: TObject);
begin
     if not CSSenden.Active = true then close;
end;

procedure TLehrer.CSSendenRead(Sender: TObject; Socket: TCustomWinSocket);
var Nachricht, indexMessage:string;
begin
     Nachricht := Socket.ReceiveText;   // Empfangene Nachricht wird ausgelesen
     EdtIP.Text := Nachricht;

     if Erstanmeldung = false then
     begin

     if Nachricht[1] = 'Z' then    // Spielzeit wird gespeichert
     begin

          sZeit := 10 * StrToInt(Nachricht[2]);
          sZeit := sZeit + StrToInt(Nachricht[3]);
     end;
     if Nachricht[1] = 'S' then         // empfangene Stadt wird gespeichert und geladen
     begin
          if length(Nachricht) = 2 then stadt := StrToInt(Nachricht[2])
          else
          begin
               stadt := 10 * StrToInt(Nachricht[2]);
               stadt := stadt + StrToInt(Nachricht[3]);
          end;
          Zeit := sZeit;
          SuchKarte.Picture.Bitmap.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Bilder/DKarte Ohne Städte.bmp'); // neu geladen
          LblStatus.Caption := SuchKarte.SatzLadenAnzeigen(stadt)+ '?';
          StatusAnpassen;
          SuchKarte.geklickt := false;
          SuchKarte.Enabled := true;
          LblSpielzeit.Caption := IntToStr(Zeit);
          pruefenTimer.Enabled := true;
          Spielzeit.Enabled := true;
     end;
     if Nachricht = 'close' then close;

     if Nachricht = 'NewIndex' then    // Index wird auf Anfrage erneut gesendet
     begin
          if index < 10 then indexMessage := 'i0' + IntToStr(index)
                   else indexMessage := 'i' + IntToStr(index);
          Socket.SendText(indexMessage);
     end;

     end else
     begin                  // während der Erstanmeldung wird die Empfangende Index beim Schüler gespeichert
          Menue.MDatei.Lines[4] := Nachricht;
          Menue.MDatei.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(Menue.index) + '.dat');
          CSSenden.Active := false;
          ShowMessage('Du hast dich erfolgreich angemeldet!');
          close;
     end;
end;

procedure TLehrer.StatusAnpassen;
begin
     if LblStatus.Width > (Screen.Width - Suchkarte.Width)div 2 - 20 then
     begin
          while LblStatus.Width > (Screen.Width - Suchkarte.Width) div 2 - 20 do
          begin
               LblStatus.Font.Size := LblStatus.Font.Size - 1;
          end;
     end else
     begin
          while LblStatus.Width < (Screen.Width - Suchkarte.Width) div 2 - 20 do
          begin
               LblStatus.Font.Size := LblStatus.Font.Size + 1;
          end;
     end;
end;

procedure TLehrer.pruefenTimerTimer(Sender: TObject);
begin                      // Timer prueft, die stadt schon geortet wurde
     if SuchKarte.geklickt = true then    // und beendet den Ortungsmodus
     begin
          KilometerSenden;
          pruefenTimer.Enabled := false;
          SPielzeit.Enabled := false;
          LblSpielzeit.Caption := 'PAUSE';
          SuchKarte.Enabled := false;
     end;
end;

procedure TLehrer.KilometerSenden;
var indexMessage,EntfernungMessage:string;
begin
     if index < 10 then indexMessage := 'i0' + IntToStr(index) // indexMessage wird erstellt
                   else indexMessage := 'i' + IntToStr(index);

     EntfernungMessage := 'e' + IntToStr(SuchKarte.Entfernung);   // Kilometermessage wird erstellt
     if SuchKarte.Entfernung < 100 then EntfernungMessage := 'e0' + IntToStr(SuchKarte.Entfernung);
     if SuchKarte.Entfernung < 10  then EntfernungMessage := 'e00' + IntToStr(SuchKarte.Entfernung);

     if CsSenden.Active = true then
     CsSenden.Socket.SendText(indexMessage + EntfernungMessage); // Message wird gesendet
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
begin
     If (Key = VK_RETURN) then
     begin
          if IPpruefen(EdtIP.Text) then
          begin
               CSSenden.Host := EdtIP.Text;
               CSSenden.Active := true;
               sleep(100);
          end else ShowMessage('IP-Adresse überprüfen!');
     end;
end;

function TLehrer.IPpruefen(Text:string):boolean;
var i,laenge,Punkte : integer;
    c:char;
begin
     result := false;
     laenge := length(Text);
     Punkte := 0;
     for i := 1 to laenge do
     begin
          c := Text[i];
          if c = '.' then inc(Punkte);
     end;
     if Punkte = 3 then result := true;
end;

procedure TLehrer.CSSendenError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
     ErrorCode := 0;
     Showmessage('Server nicht erreichbar!' + #13 + 'Ip-Adresse überprüfen!');
     if Erstanmeldung = true then LblSenden.Enabled := true;
     CSSenden.Active := false;
end;

procedure TLehrer.EdtVornameLChange(Sender: TObject);
begin
      with EdtVornameL do
     begin

     if Text = '' then
     begin
          Text := 'Vorname';
          Font.Color := clGray;
     end;
     if (Length(Text) = 8) and
        (Font.Color = clGray) then
     begin
          Font.Color := clBlack;
          Text := Text[1];
          SelStart := 1;
     end;
     if (Font.Color = clGray) and
        (Length(Text) < 7) then
        Text := 'Vorname';

     end;
end;

procedure TLehrer.EdtNameLChange(Sender: TObject);
begin
     with EdtNameL do
     begin

     if Text = '' then
     begin
          Text := 'Name';
          Font.Color := clGray;
     end;
     if (Length(Text) = 5) and
        (Font.Color = clGray) then
     begin
          Font.Color := clBlack;
          Text := Text[1];
          SelStart := 1;
     end;
     if (Font.Color = clGray) and
        (Length(Text) < 4) then
        Text := 'Name';

     end;
end;

procedure TLehrer.EdtNameLClick(Sender: TObject);
begin
     if (EdtNameL.Font.Color = clGray) or (EdtNameL.Font.Color = clRed) then
     begin
          EdtNameL.SelStart := 0;
          EdtNameL.Font.Color := clGray;
     end;
end;

procedure TLehrer.EdtVornameLClick(Sender: TObject);
begin
     if (EdtVornameL.Font.Color = clGray) or (EdtVornameL.Font.Color = clRed) then
     begin
          EdtVornameL.SelStart := 0;
          EdtVornameL.Font.Color := clGray;
     end;
end;

procedure TLehrer.EdtIPVChange(Sender: TObject);
begin
     with EdtIPV do
     begin

     if Text = '' then
     begin
          Text := 'IP-Adresse';
          Font.Color := clGray;
     end;
     if (Length(Text) = 11) and
        (Font.Color = clGray) then
     begin
          Font.Color := clBlack;
          Text := Text[1];
          SelStart := 1;
     end;
     if (Font.Color = clGray) and
        (Length(Text) < 10) then
        Text := 'IP-Adresse';

     end;
end;

procedure TLehrer.EdtIPVClick(Sender: TObject);
begin
     if (EdtIPV.Font.Color = clGray) or (EdtIPV.Font.Color = clRed) then
     begin
          EdtIPV.SelStart := 0;
          EdtIPV.Font.Color := clGray;
     end;
end;

procedure TLehrer.STLoescheVornameLMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     STLoescheVornameL.Top := STLoescheVornameL.Top + 2;
end;

procedure TLehrer.STLoescheVornameLMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     STLoescheVornameL.Top := STLoescheVornameL.Top - 2;
     EdtVornameL.Clear;
end;

procedure TLehrer.STLoescheNameLMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     STLoescheNameL.Top := STLoescheNameL.Top + 2;
end;

procedure TLehrer.STLoescheNameLMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     STLoescheNameL.Top := STLoescheNameL.Top - 2;
     EdtNameL.Clear;
end;

procedure TLehrer.STLoescheIPMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     STLoescheIP.Top := STLoescheIP.Top + 2;
end;

procedure TLehrer.STLoescheIPMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     STLoescheIP.Top := STLoescheIP.Top - 2;
     EdtIPV.Clear;
end;

procedure TLehrer.LblSendenMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     LblSenden.Top := LblSenden.Top + 2;
     ShpSenden.Top := ShpSenden.Top + 2;
end;

procedure TLehrer.LblSendenMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Adresse : string;
begin
     LblSenden.Top := LblSenden.Top - 2;
     ShpSenden.Top := ShpSenden.Top - 2;

     if (EdtVornameL.Font.Color = clGray) or (EdtVornameL.Font.Color = clRed) then
     begin
          EdtVornameL.Font.Color := clRed;
          exit;
     end;

     if (EdtNameL.Font.Color = clGray) or (EdtNameL.Font.Color = clRed) then
     begin
          EdtNameL.Font.Color := clRed;
          exit;
     end;
     if (EdtIPV.Font.Color = clGray) or (EdtIPV.Font.Color = clRed) or
        (IPpruefen(EdtIPV.Text) = false) then
     begin
          EdtIPV.Font.Color := clRed;
          exit;
     end;

     CSSenden.Active := false;
     Adresse := EdtIPV.Text;

     With CSSenden do
       begin
          Host := Adresse; //IP des Zielrechners
          Active := True; //Aufbau der Verbindung
       end;
     sleep(100);

     LblSenden.Enabled := false;
end;

procedure TLehrer.LblSendenMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
     if ShpSenden.Brush.Color = clWhite then
     begin
          LblSenden.Font.Color := clWhite;
          ShpSenden.Brush.Color := clBlack;
          ShpSenden.Left := ShpSenden.Left - 10;
          ShpSenden.Width := ShpSenden.Width + 20;
     end;
     if ShpZurueckL.Brush.Color = clBlack then
     begin
          LblZurueckL.Font.Color := clBlack;
          ShpZurueckL.Brush.Color := clWhite;
          ShpZurueckL.Left := ShpZurueckL.Left + 10;
          ShpZurueckL.Width := ShpZurueckL.Width - 20;
     end;
end;


procedure TLehrer.GBLehreranmeldungMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
     if ShpSenden.Brush.Color = clBlack then
     begin
          LblSenden.Font.Color := clBlack;
          ShpSenden.Brush.Color := clWhite;
          ShpSenden.Left := ShpSenden.Left + 10;
          ShpSenden.Width := ShpSenden.Width - 20;
     end;
     if ShpZurueckL.Brush.Color = clBlack then
     begin
          LblZurueckL.Font.Color := clBlack;
          ShpZurueckL.Brush.Color := clWhite;
          ShpZurueckL.Left := ShpZurueckL.Left + 10;
          ShpZurueckL.Width := ShpZurueckL.Width - 20;
     end;
end;

procedure TLehrer.VerbindenTimerTimer(Sender: TObject);
begin
     if GBLehreranmeldung.Top < Screen.Height div 2 - GBLehreranmeldung.Height div 2 then
    begin
         GBLehreranmeldung.Top := GBLehreranmeldung.Top + 30;
    end else VerbindenTimer.Enabled := false;
end;


procedure TLehrer.LblZurueckLMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     LblZurueckL.Top := LblZurueckL.Top + 2;
     ShpZurueckL.Top := ShpZurueckL.Top + 2;
end;

procedure TLehrer.LblZurueckLMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
     if ShpZurueckL.Brush.Color = clWhite then
     begin
          LblZurueckL.Font.Color := clWhite;
          ShpZurueckL.Brush.Color := clBlack;
          ShpZurueckL.Left := ShpZurueckL.Left - 10;
          ShpZurueckL.Width := ShpZurueckL.Width + 20;
     end;
     if ShpSenden.Brush.Color = clBlack then
     begin
          LblSenden.Font.Color := clBlack;
          ShpSenden.Brush.Color := clWhite;
          ShpSenden.Left := ShpSenden.Left + 10;
          ShpSenden.Width := ShpSenden.Width - 20;
     end;
end;

procedure TLehrer.LblZurueckLMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     close;
end;

procedure TLehrer.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     CSSenden.Close;
end;

procedure TLehrer.CSSendenDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
     Close;
end;

procedure TLehrer.EdtVornameLKeyPress(Sender: TObject; var Key: Char);
begin
     if Key = ',' then Key := #0;
end;

procedure TLehrer.EdtNameLKeyPress(Sender: TObject; var Key: Char);
begin
     if Key = ',' then Key := #0;
end;

end.
