unit Struktur;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Math, jpeg, ImageButton, ShapeSchliessen, ScktComp;

type
  TMenue = class(TForm)
    MenueEffekt: TTimer;
    Zoomen: TTimer;
    Anmeldungstimer: TTimer;
    GBAnmeldung: TGroupBox;
    EdtBenutzername: TEdit;
    EdtPasswort: TEdit;
    LbLNeu: TLabel;
    ShpNeu: TShape;
    LblAnmelden: TLabel;
    ShpAnmelden: TShape;
    StLoescheB: TStaticText;
    STLoescheP: TStaticText;
    ImgSichtbarP: TImage;
    GBRegistrierung: TGroupBox;
    ShpBestaetigen: TShape;
    LblBestaetigen: TLabel;
    EdtVorname: TEdit;
    EdtName: TEdit;
    STLoescheV: TStaticText;
    StLoescheN: TStaticText;
    RgGeschlecht: TRadioGroup;
    EdtIP: TEdit;
    CSRegistrierung: TClientSocket;
    MIndex: TMemo;
    Registrierungstimer: TTimer;
    EdtRPasswort: TEdit;
    StLoescheRP: TStaticText;
    ImgSichtbarRP: TImage;
    LblZurueck: TLabel;
    ShpZurueck: TShape;
    ZurueckTimer: TTimer;
    procedure FormPaint(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure MenuePosition(Radius:integer);
    function Kreisposition_x(Objektnummer:integer;Objektanzahl:integer;
             Zentrum:TPoint;Radius:real): integer;
    function Kreisposition_y(Objektnummer:integer;Objektanzahl:integer;
             Zentrum:TPoint;Radius:real): integer;
    procedure MenueEffektTimer(Sender: TObject);
    procedure ZoomenTimer(Sender: TObject);
    procedure LblBestaetigenMouseDown(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure LblBestaetigenMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AnmeldungstimerTimer(Sender: TObject);
    procedure EdtBenutzernameChange(Sender: TObject);
    procedure EdtPasswortClick(Sender: TObject);
    procedure EdtBenutzernameClick(Sender: TObject);
    procedure EdtPasswortChange(Sender: TObject);
    procedure StLoescheBClick(Sender: TObject);
    procedure STLoeschePClick(Sender: TObject);
    procedure ImgSichtbarPMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImgSichtbarPMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RegistrierungstimerTimer(Sender: TObject);
    procedure EdtVornameClick(Sender: TObject);
    procedure EdtNameClick(Sender: TObject);
    procedure EdtRPasswortClick(Sender: TObject);
    procedure EdtIPClick(Sender: TObject);
    procedure EdtRPasswortChange(Sender: TObject);
    procedure ImgSichtbarRPMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImgSichtbarRPMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EdtVornameChange(Sender: TObject);
    procedure EdtNameChange(Sender: TObject);
    procedure STLoescheVClick(Sender: TObject);
    procedure EdtIPChange(Sender: TObject);
    procedure StLoescheNClick(Sender: TObject);
    procedure StLoescheRPClick(Sender: TObject);
    procedure LbLNeuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LbLNeuMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblAnmeldenMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblAnmeldenMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure STLoeschePMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure STLoeschePMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StLoescheBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StLoescheBMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure STLoescheVMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure STLoescheVMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StLoescheNMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StLoescheNMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StLoescheRPMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StLoescheRPMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RgGeschlechtClick(Sender: TObject);
    procedure CSRegistrierungError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure CSRegistrierungRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure LblZurueckMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblZurueckMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ZurueckTimerTimer(Sender: TObject);
  private
    { Private-Deklarationen }
     
  public
    { Public-Deklarationen }
    Themenfarbe1: TColor;
    Themenfarbe2: TColor;
    angemeldet:boolean;
    procedure FensterOeffnen(Button:integer);
  end;



var
  Menue: TMenue;
  MenuePos:integer = 1;
  ScreenMitte:TPoint;
  ScreenZaehler: Integer;
  MenueObjekt : array[1..6] of TImageButton;
  SchliessenShape : TShapeSchliessen;

  Geschlecht: String;

implementation

uses Karte,Lexikon,Atlas,Einstellungen;

{$R *.DFM}

procedure TMenue.FormPaint(Sender: TObject);
begin
     Menue.Color := Themenfarbe1;
end;

procedure TMenue.FormCreate(Sender: TObject);
var i : integer;
begin
     GBAnmeldung.Top := -GBAnmeldung.Height;
     GBAnmeldung.Left := Screen.Width div 2 - GBAnmeldung.Width div 2;

     GBRegistrierung.Top := -GBRegistrierung.Height;
     GBRegistrierung.Left := Screen.Width div 2 - GBRegistrierung.Width div 2;


     Themenfarbe1 := RGB(244,164,96);         //Themenfarben können sich durchs ganze
     Themenfarbe2 := RGB(205,133,63);         //Programm ziehen... (sind noch nicht beschlossen)
     Self.DoubleBuffered := True;
     ScreenMitte := Point(Screen.Width div 2,Screen.Height div 2);    // Mitte des Screen wird ermittelt

     for i := 1 to 5 do
     begin                                                            // Die Menüobjekte werden vom Typ
          MenueObjekt[i]:= TImageButton.Create(self);                 // ImageButton erstellt
          MenueObjekt[i].Parent := self;
          MenueObjekt[i].Themenfarbe1 := Themenfarbe1;                // und es wird ihnen die aktuellen Themenfarbe
          MenueObjekt[i].Themenfarbe2 := Themenfarbe2;                // übermittelt.
          MenueObjekt[i].Button := i;
          MenueObjekt[i].Enabled := false;
     end;
     MenueObjekt[1].BildLaden(ExtractFilePath(ParamStr(0)) + 'Bilder/Karten-Menüpunkt.gif');         // Jedes Menüobjekt lädt sein bestimmtes Bild
     MenueObjekt[2].BildLaden(ExtractFilePath(ParamStr(0)) + 'Bilder/Lexikon-Menüpunkt.gif');        // im gif-Format
     MenueObjekt[3].BildLaden(ExtractFilePath(ParamStr(0)) + 'Bilder/Profil-Menüpunkt.gif');
     MenueObjekt[4].BildLaden(ExtractFilePath(ParamStr(0)) + 'Bilder/Spiel-Menüpunkt.gif');
     MenueObjekt[5].BildLaden(ExtractFilePath(ParamStr(0)) + 'Bilder/Titel.gif');
     MenueObjekt[5].Titel := true;

     SchliessenShape := TShapeSchliessen.Create(self);    // Erstellen des Schließen-Komponente
     SchliessenShape.Parent := self;
     SchliessenShape.Themenfarbe1 := Themenfarbe1;        // die Themenfarben werden übergeben
     SchliessenShape.Themenfarbe2 := Themenfarbe2;
     SchliessenShape.Fenster := Menue;           // Wichtig! Das Fenster wird übergeben, damit die Komponente weiß
                                                 // welches Fenster geschlossen werden soll.
end;




procedure TMenue.MenueEffektTimer(Sender: TObject);
begin
     Inc(MenuePos,3);                 // Timer lässt das Menue aus der Bildschirmmitte erscheinen
     MenuePosition(MenuePos);
     If MenuePos >= Screen.Height div 3 then
     begin
          MenueEffekt.Enabled := False;

          Anmeldungstimer.Enabled := true;
     end;
end;

procedure TMenue.MenuePosition(Radius:integer);
var i : integer;
    x,y : integer;
    Radius_x,Radius_y : real;
    Buttonbreite : integer;
    Anzahl:integer;
begin
     ButtonBreite := (3*Radius)div 4;                       // Buttonbreite wird in Abhängigkeit der Bildschrimgröße bestimmt
     for i := 1 to 4 do
     begin
          MenueObjekt[i].Width := ButtonBreite;
          MenueObjekt[i].Height:= ButtonBreite;
     end;

     MenueObjekt[5].Width := (ButtonBreite*5) div 2;
     MenueObjekt[5].Height:= ButtonBreite;
                                                                      // im Folgenden werden die Menüpunkte im Kreis(Ellipse) angeordnet:
     Radius_x := Radius*(Screen.Width / Screen.Height);               // Radius in x-Richtung
     Radius_y := Radius;                                              // Radius in y-Richtung
     Anzahl := 5;
     for i := 1 to 5 do
     begin
          x := Kreisposition_x(i,Anzahl,ScreenMitte,Radius_x);        // x- und y-Koordinate für das i-te Objekt wird ermittelt
          y := Kreisposition_y(i,Anzahl,ScreenMitte,Radius_y);        // dabei werden oben bestimmte Parameter übergeben

          if i <> 5 then
          begin
               MenueObjekt[i].Left := x - ButtonBreite div 2;         // jeder Komponente wird ihre Position übergeben.
               MenueObjekt[i].Top  := y - ButtonBreite div 2;
          end else
          begin
               MenueObjekt[i].Left := x - ((ButtonBreite*5) div 2) div 2;         // jeder Komponente wird ihre Position übergeben.
               MenueObjekt[i].Top  := y - ButtonBreite div 2;
          end;
     end;
end;

function TMenue.Kreisposition_x(Objektnummer:integer;Objektanzahl:integer;Zentrum:TPoint;
         Radius:real) : integer;                            // Parameterübergabe
var
   RadWinkel  : real;
   x          : integer;
begin
     RadWinkel := Objektnummer*((2*pi)/Objektanzahl);          // Winkel des aktuellen Objektes wird errechnet
     x := round(Zentrum.x + cos(RadWinkel+(pi/2))*Radius);     // daraus wird die x-Koordinate des Objektes ermittelt
     result := x;
end;

function TMenue.Kreisposition_y(Objektnummer:integer;Objektanzahl:integer;Zentrum:TPoint;
         Radius:real) : integer;                            // Parameterübergabe
var
   RadWinkel  : real;
   y          : integer;
begin
     RadWinkel := Objektnummer*((2*pi)/Objektanzahl);          // Winkel des aktuellen Objektes wird errechnet
     y := round(Zentrum.y - sin(RadWinkel+(pi/2))*Radius);     // daraus wird die y-Koordinate des Objektes ermittelt
     result := y;
end;

procedure TMenue.ZoomenTimer(Sender: TObject);       // Ein permanenter Timer...
var i,k,l :integer;
begin
     k := round(3*((Screen.Height / 3)) / 4);        // (normale Größe)
     l := round(15*((Screen.Height / 3)) / 18);      // (zoom Größe)
     for i := 1 to 4 do                       // 1-4: Titel wird nicht gezoomt!!!
     begin
          if (MenueObjekt[i].Zoom = true) and         // prüft ob, ein Menüobjekt im Zoom-Modus ist
             (MenueObjekt[i].Height < l) then         // und kleiner als die Zoom-End-Größe ist
          begin
               MenueObjekt[i].Vergroessern;           // und lässt sie sich vergrößern,
          end;
          if (MenueObjekt[i].Zoom = false) and        // oder wenn es nicht der Fall ist und das Menüobjekt
             (MenueObjekt[i].Height > k) then         // auch nicht seine normale Größe besitzt
          begin
               MenueObjekt[i].Verkleinern;            // schrumpft das Objekt wieder.
          end;
     end;
end;



procedure TMenue.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var i : byte;
begin
     if SchliessenShape.inaktiv = false then    // Wenn das Shape zum Schließen noch
     begin                                      // aktiv ist,
          SchliessenShape.inaktiv := true;      // wird sein Status auf inaktiv gesetzt
          SchliessenShape.Repaint;              // und es zeichnet sich neu.
     end;

     for i := 1 to 4 do
     begin
          If MenueObjekt[i].Zoom = true          // Sicherheitsverkleinern: Wenn die Maus wieder auf der Form ist
          then MenueObjekt[i].Zoom := false;     // und das Menüobjekt noch nicht am Verkleinrn ist.
     end;
end;


procedure TMenue.FensterOeffnen(Button:integer);               // Fenster öffnen
begin
     case Button of
     1: begin
             Application.CreateForm(TKarten, Karten);
             Karten.BringToFront;
             Karten.ShowModal;
        end;
     2: begin
             Application.CreateForm(TFLexikon, FLexikon);
             FLexikon.BringToFront;
             FLexikon.ShowModal;
        end;
     3: begin
             Application.CreateForm(TProfil, Profil);
             Profil.BringToFront;
             Profil.ShowModal;
        end;
     4: begin
             Application.CreateForm(TOrte_Finden, Orte_Finden);
             Orte_Finden.BringToFront;
             Orte_Finden.ShowModal;
        end;
     end;
end;





////Anmeldung & Registrierung\\\\


procedure TMenue.AnmeldungstimerTimer(Sender: TObject);
begin
    if GBAnmeldung.Top < Screen.Height div 2 - GBAnmeldung.Height div 2 then
    begin
         GBAnmeldung.Top := GBAnmeldung.Top + 30;
    end else Anmeldungstimer.Enabled := false;
end;


procedure TMenue.EdtBenutzernameChange(Sender: TObject);
begin
     with EdtBenutzername do
     begin

     if Text = '' then
     begin
          Text := 'Benutzername';
          Font.Color := clGray;
     end;
     if (Length(Text) = 13) and
        (Font.Color = clGray) then
     begin
          Font.Color := clBlack;
          Text := Text[1];
          SelStart := 1;
     end;
     if (Font.Color = clGray) and
        (Length(Text) < 12) then
        Text := 'Benutzername';

     end;
end;

procedure TMenue.EdtPasswortClick(Sender: TObject);
begin
     EdtPasswort.SelStart := 0;
end;

procedure TMenue.EdtBenutzernameClick(Sender: TObject);
begin
     EdtBenutzername.SelStart := 0;
end;

procedure TMenue.EdtPasswortChange(Sender: TObject);
begin
     with EdtPasswort do
     begin

     if Text = '' then
     begin
          Text := 'Passwort';
          Font.Color := clGray;
          PasswordChar := #0;
          ImgSichtbarP.Visible := false;
     end;
     if (Length(Text) = 9) and
        (Font.Color = clGray) then
     begin
          Font.Color := clBlack;
          Text := Text[1];
          PasswordChar := #7;
          SelStart := 1;
          ImgSichtbarP.Visible := true;
     end;
     if (Font.Color = clGray) and
        (Length(Text) < 8) then
     begin
           Text := 'Passwort';
     end;

     end;
end;

procedure TMenue.StLoescheBClick(Sender: TObject);
begin
     EdtBenutzername.Clear;
end;

procedure TMenue.STLoeschePClick(Sender: TObject);
begin
     EdtPasswort.Clear;
end;

procedure TMenue.ImgSichtbarPMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     EdtPasswort.PasswordChar := #0;
     EdtPasswort.SelStart := Length(EdtPasswort.Text);

     ImgSichtbarP.Top := ImgSichtbarP.Top + 2;
end;

procedure TMenue.ImgSichtbarPMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     EdtPasswort.PasswordChar := #7;
     EdtPasswort.SelStart := Length(EdtPasswort.Text);

     ImgSichtbarP.Top := ImgSichtbarP.Top - 2;
end;

procedure TMenue.RegistrierungstimerTimer(Sender: TObject);
begin
     if GBRegistrierung.Top < Screen.Height div 2 - GBRegistrierung.Height div 2 then
    begin
         GBRegistrierung.Top := GBRegistrierung.Top + 30;
    end else Registrierungstimer.Enabled := false;
end;

procedure TMenue.EdtVornameClick(Sender: TObject);
begin
     if (EdtVorname.Font.Color = clGray) or (EdtVorname.Font.Color = clRed) then
     begin
          EdtVorname.SelStart := 0;
          EdtVorname.Font.Color := clGray;
     end;
end;

procedure TMenue.EdtNameClick(Sender: TObject);
begin
     if (EdtName.Font.Color = clGray) or (EdtName.Font.Color = clRed) then
     begin
          EdtName.SelStart := 0;
          EdtName.Font.Color := clGray;
     end;
end;

procedure TMenue.EdtRPasswortClick(Sender: TObject);
begin
     if (EdtRPasswort.Font.Color = clGray) or (EdtRPasswort.Font.Color = clRed) then
     begin
          EdtRPasswort.SelStart := 0;
          EdtRPasswort.Font.Color := clGray;
     end;
end;

procedure TMenue.EdtIPClick(Sender: TObject);
begin
     if (EdtIP.Font.Color = clGray) or (EdtIP.Font.Color = clRed) then
     begin
          EdtIP.SelStart := 0;
          EdtIP.Font.Color := clGray;
     end;
end;

procedure TMenue.EdtRPasswortChange(Sender: TObject);
begin
     with EdtRPasswort do
     begin

     if Text = '' then
     begin
          Text := 'Passwort';
          Font.Color := clGray;
          PasswordChar := #0;
          ImgSichtbarRP.Visible := false;
     end;
     if (Length(Text) = 9) and
        (Font.Color = clGray) then
     begin
          Font.Color := clBlack;
          Text := Text[1];
          PasswordChar := #7;
          SelStart := 1;
          ImgSichtbarRP.Visible := true;
     end;
     if (Font.Color = clGray) and
        (Length(Text) < 8) then
     begin
           Text := 'Passwort';
     end;

     end;
end;

procedure TMenue.ImgSichtbarRPMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     EdtRPasswort.PasswordChar := #0;
     EdtRPasswort.SelStart := Length(EdtRPasswort.Text);

     ImgSichtbarRP.Top := ImgSichtbarRP.Top + 2;
end;

procedure TMenue.ImgSichtbarRPMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     EdtRPasswort.PasswordChar := #7;
     EdtRPasswort.SelStart := Length(EdtRPasswort.Text);

     ImgSichtbarRP.Top := ImgSichtbarRP.Top - 2;
end;

procedure TMenue.EdtVornameChange(Sender: TObject);
begin
     with EdtVorname do
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

procedure TMenue.EdtNameChange(Sender: TObject);
begin
     with EdtName do
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

procedure TMenue.STLoescheVClick(Sender: TObject);
begin
     EdtVorname.Clear;
end;

procedure TMenue.EdtIPChange(Sender: TObject);
begin
     with EdtIP do
     begin

     if Text = '' then
     begin
          Text := 'IP-Addresse';
          Font.Color := clGray;
     end;
     if (Length(Text) = 12) and
        (Font.Color = clGray) then
     begin
          Font.Color := clBlack;
          Text := Text[1];
          SelStart := 1;
     end;
     if (Font.Color = clGray) and
        (Length(Text) < 11) then
        Text := 'IP-Addresse';

     end;
end;

procedure TMenue.StLoescheNClick(Sender: TObject);
begin
     EdtName.Clear;
end;

procedure TMenue.StLoescheRPClick(Sender: TObject);
begin
     EdtRPasswort.Clear;
end;

procedure TMenue.LbLNeuMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     ShpNeu.Top := ShpNeu.Top + 2;
     LblNeu.Top := LblNeu.Top + 2;
end;

procedure TMenue.LbLNeuMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     ShpNeu.Top := ShpNeu.Top - 2;
     LblNeu.Top := LblNeu.Top - 2;

     Registrierungstimer.Enabled := true;
end;


procedure TMenue.LblAnmeldenMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     LblAnmelden.Top := LblAnmelden.Top + 2;
     ShpAnmelden.Top := ShpAnmelden.Top + 2;
end;

procedure TMenue.LblAnmeldenMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     LblAnmelden.Top := LblAnmelden.Top - 2;
     ShpAnmelden.Top := ShpAnmelden.Top - 2;
end;

procedure TMenue.STLoeschePMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     STLoescheP.Top := STLoescheP.Top + 2;
end;

procedure TMenue.STLoeschePMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     STLoescheP.Top := STLoescheP.Top - 2;
end;

procedure TMenue.StLoescheBMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     STLoescheB.Top := STLoescheB.Top + 2;
end;

procedure TMenue.StLoescheBMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     STLoescheB.Top := STLoescheB.Top - 2;
end;

procedure TMenue.STLoescheVMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     STLoescheV.Top := STLoescheV.Top + 2;
end;

procedure TMenue.STLoescheVMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     STLoescheV.Top := STLoescheV.Top - 2;
end;

procedure TMenue.StLoescheNMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     STLoescheN.Top := STLoescheN.Top + 2;
end;

procedure TMenue.StLoescheNMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     STLoescheN.Top := STLoescheN.Top - 2;
end;

procedure TMenue.StLoescheRPMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     STLoescheRP.Top := STLoescheRP.Top + 2;
end;

procedure TMenue.StLoescheRPMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     STLoescheRP.Top := STLoescheRP.Top - 2;
end;

procedure TMenue.LblBestaetigenMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     LblBestaetigen.Top := LblBestaetigen.Top + 2;
     ShpBestaetigen.Top := ShpBestaetigen.Top + 2;
end;

procedure TMenue.LblBestaetigenMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var Adresse, Vorname, Nachname{,Passwort}: String;
begin
     LblBestaetigen.Top := LblBestaetigen.Top - 2;
     ShpBestaetigen.Top := ShpBestaetigen.Top - 2;

     if (EdtVorname.Font.Color = clGray) then
     begin
          EdtVorname.Font.Color := clRed;
          exit;
     end;
     if (EdtName.Font.Color = clGray) then
     begin
          EdtName.Font.Color := clRed;
          exit;
     end;
     if (EdtRPasswort.Font.Color = clGray) then
     begin
          EdtRPasswort.Font.Color := clRed;
          exit;
     end;
     if (EdtIP.Font.Color = clGray) then
     begin
          EdtIP.Font.Color := clRed;
          exit;
     end;
     if RgGeschlecht.ItemIndex = -1 then
     begin
          RgGeschlecht.Font.Color := clRed;
          exit;
     end;

     case RgGeschlecht.ItemIndex of
          0 : Geschlecht := 'M';
          1 : Geschlecht := 'J';
     end;

     Adresse := EdtIP.Text;
     Vorname := EdtVorname.Text;
     Nachname := EdtName.Text;
     //Passwort := EdtRPasswort.Text;
     Try
      With CSRegistrierung do
       begin
          Port := 23; //Festlegung des Ports
          Host := Adresse; //IP des Zielrechners
          Active := True; //Aufbau der Verbindung
          Socket.SendText ('1' + Vorname);
          Socket.SendText ('2' + Nachname);
          Socket.SendText ('3' + Geschlecht);
          //Socket.SendText ('4' + Passwort);
       end;
     Except
       showmessage('Fehler bei der Verbindung');
      end;  

end;

procedure TMenue.RgGeschlechtClick(Sender: TObject);
begin
     RgGeschlecht.Font.Color := clBlack;
end;

procedure TMenue.CSRegistrierungError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
     showmessage ('Fehler bei der Verbindung!' + #13#10 +
                  'Fehler: ' + IntToStr(ErrorCode));;  //Gibt den FehlerCode aus!
end;

procedure TMenue.CSRegistrierungRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
     MIndex.Lines.Add (Socket.ReceiveText);
     MIndex.Lines.SaveToFile('SchülerIndex.txt');
     CSRegistrierung.Active := False;
end;

procedure TMenue.LblZurueckMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     LblZurueck.Top := LblZurueck.Top + 2;
     ShpZurueck.Top := ShpZurueck.Top + 2;
end;

procedure TMenue.LblZurueckMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     LblZurueck.Top := LblZurueck.Top - 2;
     ShpZurueck.Top := ShpZurueck.Top - 2;

     ZurueckTimer.Enabled := true;
end;

procedure TMenue.ZurueckTimerTimer(Sender: TObject);
begin
     if GBRegistrierung.Top > -GBRegistrierung.Height then
     begin
          GBRegistrierung.Top := GBRegistrierung.Top - 30;
     end else ZurueckTimer.Enabled := false;

end;

end.
