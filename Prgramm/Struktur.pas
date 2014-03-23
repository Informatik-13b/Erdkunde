unit Struktur;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Math, jpeg, ImageButton, ShapeSchliessen, ImageMaskottchen;

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
    Registrierungstimer: TTimer;
    EdtRPasswort: TEdit;
    StLoescheRP: TStaticText;
    ImgSichtbarRP: TImage;
    LblZurueck: TLabel;
    ShpZurueck: TShape;
    ZurueckRTimer: TTimer;
    ZurueckATimer: TTimer;
    EdtBenutzernameR: TEdit;
    STLoescheRB: TStaticText;
    MDatei: TMemo;
    TMaskottchen: TTimer;
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
    procedure EdtRPasswortChange(Sender: TObject);
    procedure ImgSichtbarRPMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImgSichtbarRPMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure EdtVornameChange(Sender: TObject);
    procedure EdtNameChange(Sender: TObject);
    procedure STLoescheVClick(Sender: TObject);
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
    procedure LblZurueckMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblZurueckMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ZurueckRTimerTimer(Sender: TObject);
    procedure ZurueckATimerTimer(Sender: TObject);
    procedure LblAnmeldenMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GBAnmeldungMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LbLNeuMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LblZurueckMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure GBRegistrierungMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure LblBestaetigenMouseMove(Sender: TObject; Shift: TShiftState;
      X, Y: Integer);
    procedure STLoescheRBMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure STLoescheRBMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure STLoescheRBClick(Sender: TObject);
    procedure EdtBenutzernameRClick(Sender: TObject);
    procedure EdtBenutzernameRChange(Sender: TObject);
    function Verschluesseln(Text:string) :string;
    procedure ErzeugeGa;
    procedure addition(x:integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtPasswortKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TMaskottchenTimer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    Themenfarbe1: TColor;
    Themenfarbe2: TColor;
    angemeldet:boolean;
    index :integer;
    procedure FensterOeffnen(Button:integer);
    procedure FarbenWechseln;
  end;

Const ka = ',-./0123456789:;Ô?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz';

var
  Menue: TMenue;
  MenuePos:integer = 1;
  ScreenMitte:TPoint;
  ScreenZaehler: Integer;
  MenueObjekt : array[1..6] of TImageButton;
  SchliessenShape : TShapeSchliessen;
  Maskottchen:TImageMaskottchen;
  k,l:integer;

  ga, ga2: string;
  lenA : integer;
  kt, gt : string;
  lenT, p : integer;
  c : char;
  schl: string;
  LenSchl: integer;
  Schluessel: String;
  temp:string;


implementation

uses Karte,Lexikon,Atlas,Einstellungen,Lehrermodus;

{$R *.DFM}

procedure TMenue.FormPaint(Sender: TObject);
begin
     Menue.Color := Themenfarbe1;
end;

procedure TMenue.FarbenWechseln;
var i:integer;
begin
     Menue.Color := Themenfarbe1;
     SchliessenShape.Themenfarbe1 := Themenfarbe1;        // die Themenfarben werden übergeben
     SchliessenShape.Themenfarbe2 := Themenfarbe2;
     SchliessenShape.Repaint;
     for i := 1 to 6 do
     begin                                                            // Die Menüobjekte werden vom Typ
          MenueObjekt[i].Themenfarbe1 := Themenfarbe1;                // und es wird ihnen die aktuellen Themenfarbe
          MenueObjekt[i].Themenfarbe2 := Themenfarbe2;                // übermittelt.
     end;
end;

procedure TMenue.FormCreate(Sender: TObject);
var i : integer;
begin
     k := round(3*((Screen.Height / 3)) / 4);        // (normale Größe)
     l := round(15*((Screen.Height / 3)) / 18);      // (zoom Größe)

     Rand := Screen.Height div 30;
     Maskottchen := TImageMaskottchen.Create(self);
     Maskottchen.Height := 17*Rand;
     Maskottchen.Parent := self;
     Maskottchen.Width := (Maskottchen.Height * 225) div 300;
     Maskottchen.Left := Screen.Width div 2 - Maskottchen.Width div 2;
     Maskottchen.Top := Screen.Height div 2 - Maskottchen.Height div 2 + Rand;
     Maskottchen.Zustand := 'Normal';
     Maskottchen.aktuellesBild := 0;
     Maskottchen.Normalzustand := true;
     Maskottchen.Laenge := 27;

     GBAnmeldung.Top := -GBAnmeldung.Height;
     GBAnmeldung.Left := Screen.Width div 2 - GBAnmeldung.Width div 2;
     GBRegistrierung.Top := -GBRegistrierung.Height;
     GBRegistrierung.Left := Screen.Width div 2 - GBRegistrierung.Width div 2;


     Themenfarbe1 := RGB(244,164,96);         //Themenfarben können sich durchs ganze
     Themenfarbe2 := RGB(205,133,63);         //Programm ziehen... (sind noch nicht beschlossen)
     Self.DoubleBuffered := True;
     ScreenMitte := Point(Screen.Width div 2,Screen.Height div 2);    // Mitte des Screen wird ermittelt

     for i := 1 to 6 do
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
     MenueObjekt[5].BildLaden(ExtractFilePath(ParamStr(0)) + 'Bilder/Lehrermodus-Menüpunkt.gif');
     MenueObjekt[6].Titel := true;
     MenueObjekt[6].BildLaden(ExtractFilePath(ParamStr(0)) + 'Bilder/Titel.gif');

     SchliessenShape := TShapeSchliessen.Create(self);    // Erstellen der Schließen-Komponente
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
     for i := 1 to 5 do
     begin
          MenueObjekt[i].Width := ButtonBreite;
          MenueObjekt[i].Height:= ButtonBreite;
     end;

     MenueObjekt[6].Width := (ButtonBreite*5) div 2;
     MenueObjekt[6].Height:= ButtonBreite;
                                                                      // im Folgenden werden die Menüpunkte im Kreis(Ellipse) angeordnet:
     Radius_x := Radius*(Screen.Width / Screen.Height);               // Radius in x-Richtung
     Radius_y := Radius;                                              // Radius in y-Richtung
     Anzahl := 6;
     for i := 1 to 6 do
     begin
          x := Kreisposition_x(i,Anzahl,ScreenMitte,Radius_x);        // x- und y-Koordinate für das i-te Objekt wird ermittelt
          y := Kreisposition_y(i,Anzahl,ScreenMitte,Radius_y);        // dabei werden oben bestimmte Parameter übergeben

          if i <> 6 then
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
var i :integer;
begin
     for i := 1 to 5 do                       // 1-5: Titel wird nicht gezoomt!!!
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

     for i := 1 to 5 do
     begin
          If MenueObjekt[i].Zoom = true          // Sicherheitsverkleinern: Wenn die Maus wieder auf der Form ist
          then MenueObjekt[i].Zoom := false;     // und das Menüobjekt noch nicht am Verkleinrn ist.
     end;

     if ShpAnmelden.Brush.Color = clBlack then
     begin
          LblAnmelden.Font.Color := clBlack;
          ShpAnmelden.Brush.Color := clWhite;
          ShpAnmelden.Left := ShpAnmelden.Left + 10;
          ShpAnmelden.Width := ShpAnmelden.Width - 20;
     end;

     if ShpNeu.Brush.Color = clBlack then
     begin
          LblNeu.Font.Color := clBlack;
          ShpNeu.Brush.Color := clWhite;
          ShpNeu.Left := ShpNeu.Left + 10;
          ShpNeu.Width := ShpNeu.Width - 20;
     end;

     if ShpZurueck.Brush.Color = clBlack then
     begin
          LblZurueck.Font.Color := clBlack;
          ShpZurueck.Brush.Color := clWhite;
          ShpZurueck.Left := ShpZurueck.Left + 10;
          ShpZurueck.Width := ShpZurueck.Width - 20;
     end;
     if ShpBestaetigen.Brush.Color = clBlack then
     begin
          LblBestaetigen.Font.Color := clBlack;
          ShpBestaetigen.Brush.Color := clWhite;
          ShpBestaetigen.Left := ShpBestaetigen.Left + 10;
          ShpBestaetigen.Width := ShpBestaetigen.Width - 20;
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
     5: begin
             Application.CreateForm(TLehrer,Lehrer);
             Lehrer.BringToFront;
             Lehrer.ShowModal;
        end;
     end;
end;





////Anmeldung & Registrierung\\\\


procedure TMenue.AnmeldungstimerTimer(Sender: TObject);
begin
    if GBAnmeldung.Top < Screen.Height div 2 - GBAnmeldung.Height div 2 then
    begin
         GBAnmeldung.Top := GBAnmeldung.Top + 30;
    end else
    begin
         Anmeldungstimer.Enabled := false;
         GBAnmeldung.Enabled := true;
         EdtBenutzername.SetFocus;
    end;
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
     if EdtPasswort.Font.Color = clGray then EdtPasswort.SelStart := 0;
end;

procedure TMenue.EdtBenutzernameClick(Sender: TObject);
begin
     if EdtBenutzername.Font.Color = clGray then EdtBenutzername.SelStart := 0;
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
var Benutzername,Passwort : string;
begin
     LblAnmelden.Top := LblAnmelden.Top - 2;
     ShpAnmelden.Top := ShpAnmelden.Top - 2;

     Benutzername := Verschluesseln(EdtBenutzername.Text);
     Passwort := Verschluesseln(EdtPasswort.Text);

     if not FileExists(ExtractFilePath(ParamStr(0)) + 'Dateien\index.dat') then
     begin
          RegistrierungsTimer.Enabled := true;
          exit;   // !!!
     end;

     MDatei.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Dateien\index.dat');
     index := MDatei.Lines.IndexOf(Benutzername);

     if FileExists(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(index) + '.dat') then
     begin
          MDatei.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(index) + '.dat');
          if Passwort = MDatei.Lines[0] then
          begin
               MDatei.Lines[7] := 'online';
               MDatei.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(index) + '.dat');
               ZurueckATimer.Enabled := true;
               angemeldet := true;
               Themenfarbe1 := StringToColor(MDatei.Lines[5]);
               Themenfarbe2 := StringToColor(MDatei.Lines[6]);
               FarbenWechseln;
          end else
             Showmessage('Falsches Passwort');
     end else
     begin
          Showmessage('Falscher Benutzername');
          exit;
     end;
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
var Benutzername, Vorname, Nachname,
    Passwort: String;
    index:integer;
begin
     LblBestaetigen.Top := LblBestaetigen.Top - 2;
     ShpBestaetigen.Top := ShpBestaetigen.Top - 2;

     if (EdtBenutzernameR.Font.Color = clGray) or (EdtBenutzernameR.Font.Color = clRed) then
     begin
          EdtBenutzernameR.Font.Color := clRed;
          exit;
     end;
     if (EdtVorname.Font.Color = clGray) or (EdtVorname.Font.Color = clRed) then
     begin
          EdtVorname.Font.Color := clRed;
          exit;
     end;
     if (EdtName.Font.Color = clGray) or (EdtName.Font.Color = clRed) then
     begin
          EdtName.Font.Color := clRed;
          exit;
     end;
     if (EdtRPasswort.Font.Color = clGray) or (EdtRPAsswort.Font.Color = clRed) then
     begin
          EdtRPasswort.Font.Color := clRed;
          exit;
     end;

     Benutzername := EdtBenutzernameR.Text;
     Vorname := EdtVorname.Text;
     Nachname := EdtName.Text;
     Passwort := EdtRPasswort.Text;

     Mdatei.Clear;
     if not FileExists(ExtractFilePath(ParamStr(0)) + 'Dateien\index.dat') then
        MDatei.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien\index.dat');

     MDatei.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Dateien\index.dat');
     MDatei.Lines.Add(Verschluesseln(Benutzername));
     index := MDatei.Lines.IndexOf(Verschluesseln(Benutzername));
     MDatei.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien\index.dat');


     MDatei.Lines.Clear;
     MDatei.Lines.Add(Verschluesseln(Passwort));      //0
     MDatei.Lines.Add(Verschluesseln(Benutzername));  //1
     MDatei.Lines.Add(Verschluesseln(Vorname));       //2
     MDatei.Lines.Add(Verschluesseln(Nachname));      //3
     MDatei.Lines.Add('index');                       //4
     MDAtei.Lines.Add(ColorToString(Themenfarbe1));   //5
     MDatei.Lines.Add(ColorToString(Themenfarbe2));   //6

     MDatei.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(index) + '.dat');


     ZurueckRTimer.Enabled := true;


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

     ZurueckRTimer.Enabled := true;
end;

procedure TMenue.ZurueckRTimerTimer(Sender: TObject);
begin
     if GBRegistrierung.Top > -GBRegistrierung.Height then
     begin
          GBRegistrierung.Top := GBRegistrierung.Top - 30;
     end else ZurueckRTimer.Enabled := false;

end;

procedure TMenue.ZurueckATimerTimer(Sender: TObject);
begin
     if GBAnmeldung.Top > -GBAnmeldung.Height then
     begin
          GBAnmeldung.Top := GBAnmeldung.Top - 30;
     end else
     begin
          ZurueckATimer.Enabled := false;
          MenueObjekt[1].Enabled := true;
          MenueObjekt[2].Enabled := true;
          MenueObjekt[3].Enabled := true;
          MenueObjekt[4].Enabled := true;
          MenueObjekt[5].Enabled := true;
          Zoomen.Enabled := true;
          TMaskottchen.Enabled := true;
     end;
end;

procedure TMenue.LblAnmeldenMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
     if ShpAnmelden.Brush.Color = clWhite then
     begin
          LblAnmelden.Font.Color := clWhite;
          ShpAnmelden.Brush.Color := clBlack;
          ShpAnmelden.Left := ShpAnmelden.Left - 10;
          ShpAnmelden.Width := ShpAnmelden.Width + 20;
     end;
     if ShpNeu.Brush.Color = clBlack then
     begin
          LblNeu.Font.Color := clBlack;
          ShpNeu.Brush.Color := clWhite;
          ShpNeu.Left := ShpNeu.Left + 10;
          ShpNeu.Width := ShpNeu.Width - 20;
     end;
end;

procedure TMenue.GBAnmeldungMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
     if ShpAnmelden.Brush.Color = clBlack then
     begin
          LblAnmelden.Font.Color := clBlack;
          ShpAnmelden.Brush.Color := clWhite;
          ShpAnmelden.Left := ShpAnmelden.Left + 10;
          ShpAnmelden.Width := ShpAnmelden.Width - 20;
     end;

     if ShpNeu.Brush.Color = clBlack then
     begin
          LblNeu.Font.Color := clBlack;
          ShpNeu.Brush.Color := clWhite;
          ShpNeu.Left := ShpNeu.Left + 10;
          ShpNeu.Width := ShpNeu.Width - 20;
     end;
end;

procedure TMenue.LbLNeuMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
     if ShpNeu.Brush.Color = clWhite then
     begin
          LblNeu.Font.Color := clWhite;
          ShpNeu.Brush.Color := clBlack;
          ShpNeu.Left := ShpNeu.Left - 10;
          ShpNeu.Width := ShpNeu.Width + 20;
     end;
     if ShpAnmelden.Brush.Color = clBlack then
     begin
          LblAnmelden.Font.Color := clBlack;
          ShpAnmelden.Brush.Color := clWhite;
          ShpAnmelden.Left := ShpAnmelden.Left + 10;
          ShpAnmelden.Width := ShpAnmelden.Width - 20;
     end;
end;

procedure TMenue.LblZurueckMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
     if ShpZurueck.Brush.Color = clWhite then
     begin
          LblZurueck.Font.Color := clWhite;
          ShpZurueck.Brush.Color := clBlack;
          ShpZurueck.Left := ShpZurueck.Left - 10;
          ShpZurueck.Width := ShpZurueck.Width + 20;
     end;
     if ShpBestaetigen.Brush.Color = clBlack then
     begin
          LblBestaetigen.Font.Color := clBlack;
          ShpBestaetigen.Brush.Color := clWhite;
          ShpBestaetigen.Left := ShpBestaetigen.Left + 10;
          ShpBestaetigen.Width := ShpBestaetigen.Width - 20;
     end;
end;

procedure TMenue.GBRegistrierungMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
     if ShpZurueck.Brush.Color = clBlack then
     begin
          LblZurueck.Font.Color := clBlack;
          ShpZurueck.Brush.Color := clWhite;
          ShpZurueck.Left := ShpZurueck.Left + 10;
          ShpZurueck.Width := ShpZurueck.Width - 20;
     end;
     if ShpBestaetigen.Brush.Color = clBlack then
     begin
          LblBestaetigen.Font.Color := clBlack;
          ShpBestaetigen.Brush.Color := clWhite;
          ShpBestaetigen.Left := ShpBestaetigen.Left + 10;
          ShpBestaetigen.Width := ShpBestaetigen.Width - 20;
     end;
end;

procedure TMenue.LblBestaetigenMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
begin
     if ShpBestaetigen.Brush.Color = clWhite then
     begin
          LblBestaetigen.Font.Color := clWhite;
          ShpBestaetigen.Brush.Color := clBlack;
          ShpBestaetigen.Left := ShpBestaetigen.Left - 10;
          ShpBestaetigen.Width := ShpBestaetigen.Width + 20;
     end;
     if ShpZurueck.Brush.Color = clBlack then
     begin
          LblZurueck.Font.Color := clBlack;
          ShpZurueck.Brush.Color := clWhite;
          ShpZurueck.Left := ShpZurueck.Left + 10;
          ShpZurueck.Width := ShpZurueck.Width - 20;
     end;
end;


procedure TMenue.STLoescheRBMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     STLoescheRB.Top := STLoescheRB.Top + 2;
end;

procedure TMenue.STLoescheRBMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     STLoescheRB.Top := STLoescheRB.Top - 2;
end;

procedure TMenue.STLoescheRBClick(Sender: TObject);
begin
     EdtBenutzernameR.Clear;
end;

procedure TMenue.EdtBenutzernameRClick(Sender: TObject);
begin
     if (EdtBenutzernameR.Font.Color = clGray) or (EdtBenutzernameR.Font.Color = clRed) then
     begin
          EdtBenutzernameR.SelStart := 0;
          EdtBenutzernameR.Font.Color := clGray;
     end;
end;

procedure TMenue.EdtBenutzernameRChange(Sender: TObject);
begin
     with EdtBenutzernameR do
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


////////////////Verschlüsselung\\\\\\\\\\\\

function TMenue.Verschluesseln(Text:string):string;
var i:integer;
begin
     schluessel := 'paiowuujen';

     kt := Text;
     lenT := length(kt);
     gt := '';
     for i := 1 to lenT do
     begin
          ErzeugeGa;
          addition(i);
          c := kt[i];
          p := pos(c,ka);
          if p <> 0 then gt := gt + copy (ga2,p,1)
          else gt := gt + c;
     end
;
     result := gt;
end;

procedure TMenue.ErzeugeGa;
var Wert1, Wert2: integer;
     i: integer;
     schlZahl: integer;
begin
    ga := '';
    schlZahl := ord(schluessel[1]);
    lenA := length(ka);
    For i := 1 to lenA do
     begin
        c := ka[i];
        Wert1 := ord(c);
        Wert2 := ((Wert1-44)*schlZahl mod 79)+44;
        ga := ga + chr(Wert2);
     end;
end;

procedure TMenue.addition (x: integer);
 var c2: char;
     p2, zaehler: integer;
  begin
     lenSchl := length (schluessel);
     zaehler := x mod lenSchl +1;
     c2 := schluessel[zaehler];
     p2 := pos (c2, ga);
     ga2 := copy (ga, p2, lenA -p2+1)
            + copy (ga, 1, p2-1);
  end;

procedure TMenue.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if angemeldet then
     begin
          MDatei.Lines[7] := 'offline';
          MDAtei.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(index) + '.dat');
          angemeldet := false;
     end;
end;

procedure TMenue.EdtPasswortKeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
 var Benutzername, Passwort: String;
  begin
     If (Key = VK_RETURN) then
       begin
          Benutzername := Verschluesseln(EdtBenutzername.Text);
          Passwort := Verschluesseln(EdtPasswort.Text);

          If not FileExists(ExtractFilePath(ParamStr(0)) + 'Dateien\index.dat') then
           Exit;   // !!!

     MDatei.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Dateien\index.dat');
     Index := MDatei.Lines.IndexOf(Benutzername);

     If FileExists(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(index) + '.dat') then
       begin
          MDatei.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(index) + '.dat');
          if Passwort = MDatei.Lines[0] then
          begin
               MDatei.Lines[7] := 'online';
               MDatei.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(index) + '.dat');
               ZurueckATimer.Enabled := true;
               angemeldet := true;
               Themenfarbe1 := StringToColor(MDatei.Lines[5]);
               Themenfarbe2 := StringToColor(MDatei.Lines[6]);
               FarbenWechseln;
          end else
             Showmessage('Falsches Passwort');
       end else
     begin
          Showmessage('Falscher Benutzername');
          exit;
     end;
       end;
  end;


procedure TMenue.TMaskottchenTimer(Sender: TObject);
begin
     with Maskottchen do
     begin
          if Normalzustand = true then
          begin
               inc(aktuellesBild);
               if aktuellesBild <= laenge then
                  BildLaden('Bilder\Maskottchen\' + Zustand + '\'+ IntToStr(aktuellesBild) + '.gif')

          else
          begin
               aktuellesBild := 0;
          end;
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

end.
