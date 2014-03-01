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
    RGStufe: TRadioGroup;
    RGKlasse: TRadioGroup;
    GBLehreranmeldung: TGroupBox;
    EdtVornameL: TEdit;
    EdtNameL: TEdit;
    STLoescheVornameL: TStaticText;
    STLoescheNameL: TStaticText;
    RGeschlecht: TRadioGroup;
    EdtIP: TEdit;
    STLoescheIP: TStaticText;
    LblSenden: TLabel;
    ShpSenden: TShape;
    CSSenden: TClientSocket;
    VerbindenTimer: TTimer;
    VerbindenZurueckTimer: TTimer;
    LblZurueckL: TLabel;
    ShpZurueckL: TShape;
    ShpVerbinden: TShape;
    LblVerbinden: TLabel;
    MIndex: TMemo;
    MDatei: TMemo;
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
    procedure RgGeschlechtClick(Sender: TObject);
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
    procedure RGStufeClick(Sender: TObject);
    procedure RGKlasseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdtPasswortKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdtVornameLChange(Sender: TObject);
    procedure EdtNameLChange(Sender: TObject);
    procedure EdtNameLClick(Sender: TObject);
    procedure EdtVornameLClick(Sender: TObject);
    procedure EdtIPChange(Sender: TObject);
    procedure EdtIPClick(Sender: TObject);
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
    procedure STLoescheIPClick(Sender: TObject);
    procedure STLoescheVornameLClick(Sender: TObject);
    procedure STLoescheNameLClick(Sender: TObject);
    procedure LblSendenMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblSendenMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblSendenMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure RGeschlechtClick(Sender: TObject);
    procedure CSSendenError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure GBLehreranmeldungMouseMove(Sender: TObject;
      Shift: TShiftState; X, Y: Integer);
    procedure VerbindenTimerTimer(Sender: TObject);
    procedure VerbindenZurueckTimerTimer(Sender: TObject);
    procedure LblZurueckLMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblZurueckLMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LblZurueckLMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblVerbindenMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblVerbindenMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LblVerbindenMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure CSSendenRead(Sender: TObject; Socket: TCustomWinSocket);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    Themenfarbe1: TColor;
    Themenfarbe2: TColor;
    angemeldet:boolean;
    index :integer;
    procedure FensterOeffnen(Button:integer);
  end;

Const ka = ',-./0123456789:;�?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz';

var
  Menue: TMenue;
  MenuePos:integer = 1;
  ScreenMitte:TPoint;
  ScreenZaehler: Integer;
  MenueObjekt : array[1..6] of TImageButton;
  SchliessenShape : TShapeSchliessen;

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

procedure TMenue.FormCreate(Sender: TObject);
var i : integer;
begin
     GBAnmeldung.Top := -GBAnmeldung.Height;
     GBAnmeldung.Left := Screen.Width div 2 - GBAnmeldung.Width div 2;
     GBRegistrierung.Top := -GBRegistrierung.Height;
     GBRegistrierung.Left := Screen.Width div 2 - GBRegistrierung.Width div 2;
     GBLehreranmeldung.Top := -GBLehreranmeldung.Height;
     GBLehreranmeldung.Left := Screen.Width div 2 - GBLehreranmeldung.Width div 2;


     Themenfarbe1 := RGB(244,164,96);         //Themenfarben k�nnen sich durchs ganze
     Themenfarbe2 := RGB(205,133,63);         //Programm ziehen... (sind noch nicht beschlossen)
     Self.DoubleBuffered := True;
     ScreenMitte := Point(Screen.Width div 2,Screen.Height div 2);    // Mitte des Screen wird ermittelt

     for i := 1 to 6 do
     begin                                                            // Die Men�objekte werden vom Typ
          MenueObjekt[i]:= TImageButton.Create(self);                 // ImageButton erstellt
          MenueObjekt[i].Parent := self;
          MenueObjekt[i].Themenfarbe1 := Themenfarbe1;                // und es wird ihnen die aktuellen Themenfarbe
          MenueObjekt[i].Themenfarbe2 := Themenfarbe2;                // �bermittelt.
          MenueObjekt[i].Button := i;
          MenueObjekt[i].Enabled := false;
     end;
     MenueObjekt[1].BildLaden(ExtractFilePath(ParamStr(0)) + 'Bilder/Karten-Men�punkt.gif');         // Jedes Men�objekt l�dt sein bestimmtes Bild
     MenueObjekt[2].BildLaden(ExtractFilePath(ParamStr(0)) + 'Bilder/Lexikon-Men�punkt.gif');        // im gif-Format
     MenueObjekt[3].BildLaden(ExtractFilePath(ParamStr(0)) + 'Bilder/Profil-Men�punkt.gif');
     MenueObjekt[4].BildLaden(ExtractFilePath(ParamStr(0)) + 'Bilder/Spiel-Men�punkt.gif');
     MenueObjekt[5].BildLaden(ExtractFilePath(ParamStr(0)) + 'Bilder/Lehrermodus-Men�punkt.gif');
     MenueObjekt[6].Titel := true;
     MenueObjekt[6].BildLaden(ExtractFilePath(ParamStr(0)) + 'Bilder/Titel.gif');

     SchliessenShape := TShapeSchliessen.Create(self);    // Erstellen der Schlie�en-Komponente
     SchliessenShape.Parent := self;
     SchliessenShape.Themenfarbe1 := Themenfarbe1;        // die Themenfarben werden �bergeben
     SchliessenShape.Themenfarbe2 := Themenfarbe2;
     SchliessenShape.Fenster := Menue;           // Wichtig! Das Fenster wird �bergeben, damit die Komponente wei�
                                                 // welches Fenster geschlossen werden soll.
end;


procedure TMenue.MenueEffektTimer(Sender: TObject);
begin
     Inc(MenuePos,3);                 // Timer l�sst das Menue aus der Bildschirmmitte erscheinen
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
     ButtonBreite := (3*Radius)div 4;                       // Buttonbreite wird in Abh�ngigkeit der Bildschrimgr��e bestimmt
     for i := 1 to 5 do
     begin
          MenueObjekt[i].Width := ButtonBreite;
          MenueObjekt[i].Height:= ButtonBreite;
     end;

     MenueObjekt[6].Width := (ButtonBreite*5) div 2;
     MenueObjekt[6].Height:= ButtonBreite;
                                                                      // im Folgenden werden die Men�punkte im Kreis(Ellipse) angeordnet:
     Radius_x := Radius*(Screen.Width / Screen.Height);               // Radius in x-Richtung
     Radius_y := Radius;                                              // Radius in y-Richtung
     Anzahl := 6;
     for i := 1 to 6 do
     begin
          x := Kreisposition_x(i,Anzahl,ScreenMitte,Radius_x);        // x- und y-Koordinate f�r das i-te Objekt wird ermittelt
          y := Kreisposition_y(i,Anzahl,ScreenMitte,Radius_y);        // dabei werden oben bestimmte Parameter �bergeben

          if i <> 6 then
          begin
               MenueObjekt[i].Left := x - ButtonBreite div 2;         // jeder Komponente wird ihre Position �bergeben.
               MenueObjekt[i].Top  := y - ButtonBreite div 2;
          end else
          begin
               MenueObjekt[i].Left := x - ((ButtonBreite*5) div 2) div 2;         // jeder Komponente wird ihre Position �bergeben.
               MenueObjekt[i].Top  := y - ButtonBreite div 2;
          end;
     end;
end;

function TMenue.Kreisposition_x(Objektnummer:integer;Objektanzahl:integer;Zentrum:TPoint;
         Radius:real) : integer;                            // Parameter�bergabe
var
   RadWinkel  : real;
   x          : integer;
begin
     RadWinkel := Objektnummer*((2*pi)/Objektanzahl);          // Winkel des aktuellen Objektes wird errechnet
     x := round(Zentrum.x + cos(RadWinkel+(pi/2))*Radius);     // daraus wird die x-Koordinate des Objektes ermittelt
     result := x;
end;

function TMenue.Kreisposition_y(Objektnummer:integer;Objektanzahl:integer;Zentrum:TPoint;
         Radius:real) : integer;                            // Parameter�bergabe
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
     k := round(3*((Screen.Height / 3)) / 4);        // (normale Gr��e)
     l := round(15*((Screen.Height / 3)) / 18);      // (zoom Gr��e)
     for i := 1 to 5 do                       // 1-5: Titel wird nicht gezoomt!!!
     begin
          if (MenueObjekt[i].Zoom = true) and         // pr�ft ob, ein Men�objekt im Zoom-Modus ist
             (MenueObjekt[i].Height < l) then         // und kleiner als die Zoom-End-Gr��e ist
          begin
               MenueObjekt[i].Vergroessern;           // und l�sst sie sich vergr��ern,
          end;
          if (MenueObjekt[i].Zoom = false) and        // oder wenn es nicht der Fall ist und das Men�objekt
             (MenueObjekt[i].Height > k) then         // auch nicht seine normale Gr��e besitzt
          begin
               MenueObjekt[i].Verkleinern;            // schrumpft das Objekt wieder.
          end;
     end;
end;



procedure TMenue.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
var i : byte;
begin
     if SchliessenShape.inaktiv = false then    // Wenn das Shape zum Schlie�en noch
     begin                                      // aktiv ist,
          SchliessenShape.inaktiv := true;      // wird sein Status auf inaktiv gesetzt
          SchliessenShape.Repaint;              // und es zeichnet sich neu.
     end;

     for i := 1 to 5 do
     begin
          If MenueObjekt[i].Zoom = true          // Sicherheitsverkleinern: Wenn die Maus wieder auf der Form ist
          then MenueObjekt[i].Zoom := false;     // und das Men�objekt noch nicht am Verkleinrn ist.
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


procedure TMenue.FensterOeffnen(Button:integer);               // Fenster �ffnen
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

     if not FileExists(ExtractFilePath(ParamStr(0)) + 'Dateien\index.txt') then
        exit;   // !!!

     MDatei.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Dateien\index.txt');
     index := MDatei.Lines.IndexOf(Benutzername);

     if FileExists(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(index) + '.txt') then
     begin
          MDatei.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(index) + '.txt');
          if Passwort = MDatei.Lines[0] then
          begin
               MDatei.Lines[5] := 'online';
               MDatei.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(index) + '.txt');
               ZurueckATimer.Enabled := true;
               angemeldet := true;
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
    Geschlecht, Passwort, Klasse: String;
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
     if RgGeschlecht.ItemIndex < 0 then
     begin
          RgGeschlecht.Font.Color := clRed;
          exit;
     end;
     if RgStufe.ItemIndex = -1 then
     begin
          RgStufe.Font.Color := clRed;
          exit;
     end;
     if RgKlasse.ItemIndex = -1 then
     begin
          RgKlasse.Font.Color := clRed;
          exit;
     end;

     case RgGeschlecht.ItemIndex of
          0 : Geschlecht := 'M�dchen';
          1 : Geschlecht := 'Junge';
     end;
     case RgStufe.ItemIndex of
          0 : Klasse := '5';
          1 : Klasse := '6';
          2 : Klasse := '7';
     end;
     case RGKlasse.ItemIndex of
          0 : Klasse := Klasse + 'a';
          1 : Klasse := Klasse + 'b';
          2 : Klasse := Klasse + 'c';
          3 : Klasse := Klasse + 'd';
          4 : Klasse := Klasse + 'e';
          5 : Klasse := Klasse + 'f';
     end;

     Benutzername := EdtBenutzernameR.Text;
     Vorname := EdtVorname.Text;
     Nachname := EdtName.Text;
     Passwort := EdtRPasswort.Text;

     Mdatei.Clear;
     if not FileExists(ExtractFilePath(ParamStr(0)) + 'Dateien\index.txt') then
        MDatei.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien\index.txt');

     MDatei.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Dateien\index.txt');
     MDatei.Lines.Add(Verschluesseln(Benutzername));
     index := MDatei.Lines.IndexOf(Verschluesseln(Benutzername));
     MDatei.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien\index.txt');


     MDatei.Lines.Clear;
     MDatei.Lines.Add(Verschluesseln(Passwort));      //0
     MDatei.Lines.Add(Verschluesseln(Benutzername));  //1
     MDatei.Lines.Add(Verschluesseln(Vorname));       //2
     MDatei.Lines.Add(Verschluesseln(Nachname));      //3
     MDatei.Lines.Add(Verschluesseln(Geschlecht));    //4
     MDatei.Lines.Add(Verschluesseln(Klasse));        //5

     MDatei.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(index) + '.txt');


     ZurueckRTimer.Enabled := true;


end;

procedure TMenue.RgGeschlechtClick(Sender: TObject);
begin
     RgGeschlecht.Font.Color := clBlack;
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
     if ShpVerbinden.Brush.Color = clBlack then
     begin
          LblVerbinden.Font.Color := clBlack;
          ShpVerbinden.Brush.Color := clWhite;
          ShpVerbinden.Left := ShpVerbinden.Left + 10;
          ShpVerbinden.Width := ShpVerbinden.Width - 20;
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
     if ShpVerbinden.Brush.Color = clBlack then
     begin
          LblVerbinden.Font.Color := clBlack;
          ShpVerbinden.Brush.Color := clWhite;
          ShpVerbinden.Left := ShpVerbinden.Left + 10;
          ShpVerbinden.Width := ShpVerbinden.Width - 20;
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
     if ShpVerbinden.Brush.Color = clBlack then
     begin
          LblVerbinden.Font.Color := clBlack;
          ShpVerbinden.Brush.Color := clWhite;
          ShpVerbinden.Left := ShpVerbinden.Left + 10;
          ShpVerbinden.Width := ShpVerbinden.Width - 20;
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


////////////////Verschl�sselung\\\\\\\\\\\\

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

procedure TMenue.RGStufeClick(Sender: TObject);
begin
     RgStufe.Font.Color := clBlack;
end;

procedure TMenue.RGKlasseClick(Sender: TObject);
begin
     RgKlasse.Font.Color := clBlack;
end;

procedure TMenue.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     if angemeldet then
     begin
          MDatei.Lines[5] := 'offline';
          MDAtei.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(index) + '.txt');
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

          If not FileExists(ExtractFilePath(ParamStr(0)) + 'Dateien\index.txt') then
           Exit;   // !!!

     MDatei.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Dateien\index.txt');
     Index := MDatei.Lines.IndexOf(Benutzername);

     If FileExists(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(index) + '.txt') then
       begin
          MDatei.Lines.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(index) + '.txt');
          if Passwort = MDatei.Lines[0] then
          begin
               MDatei.Lines[5] := 'online';
               MDatei.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien\' + IntToStr(index) + '.txt');
               ZurueckATimer.Enabled := true;
               angemeldet := true;
          end else
             Showmessage('Falsches Passwort');
       end else
     begin
          Showmessage('Falscher Benutzername');
          exit;
     end;
       end;
  end;

procedure TMenue.EdtVornameLChange(Sender: TObject);
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

procedure TMenue.EdtNameLChange(Sender: TObject);
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

procedure TMenue.EdtNameLClick(Sender: TObject);
begin
     if (EdtNameL.Font.Color = clGray) or (EdtNameL.Font.Color = clRed) then
     begin
          EdtNameL.SelStart := 0;
          EdtNameL.Font.Color := clGray;
     end;
end;

procedure TMenue.EdtVornameLClick(Sender: TObject);
begin
     if (EdtVornameL.Font.Color = clGray) or (EdtVornameL.Font.Color = clRed) then
     begin
          EdtVornameL.SelStart := 0;
          EdtVornameL.Font.Color := clGray;
     end;
end;

procedure TMenue.EdtIPChange(Sender: TObject);
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
          Font.Color := clBlack;
          Text := Text[1];
          SelStart := 1;
     end;
     if (Font.Color = clGray) and
        (Length(Text) < 10) then
        Text := 'IP-Adresse';

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

procedure TMenue.STLoescheVornameLMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     STLoescheVornameL.Top := STLoescheVornameL.Top + 2;
end;

procedure TMenue.STLoescheVornameLMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     STLoescheVornameL.Top := STLoescheVornameL.Top - 2;
end;

procedure TMenue.STLoescheNameLMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     STLoescheNameL.Top := STLoescheNameL.Top + 2;
end;

procedure TMenue.STLoescheNameLMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     STLoescheNameL.Top := STLoescheNameL.Top - 2;
end;

procedure TMenue.STLoescheIPMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     STLoescheIP.Top := STLoescheIP.Top + 2;
end;

procedure TMenue.STLoescheIPMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     STLoescheIP.Top := STLoescheIP.Top - 2;
end;

procedure TMenue.STLoescheIPClick(Sender: TObject);
begin
     EdtIP.Clear;
end;

procedure TMenue.STLoescheVornameLClick(Sender: TObject);
begin
     EdtVornameL.Clear;
end;

procedure TMenue.STLoescheNameLClick(Sender: TObject);
begin
     EdtNameL.Clear;
end;

procedure TMenue.LblSendenMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     LblSenden.Top := LblSenden.Top + 2;
     ShpSenden.Top := ShpSenden.Top + 2;
end;

procedure TMenue.LblSendenMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var Adresse,Vorname,Nachname,Geschlecht:string;
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
     if (EdtIP.Font.Color = clGray) or (EdtIP.Font.Color = clRed) then
     begin
          EdtIP.Font.Color := clRed;
          exit;
     end;
     if RGeschlecht.ItemIndex < 0 then
     begin
          RGEschlecht.Font.Color := clRed;
          exit;
     end;

     Adresse := EdtIP.Text;
     Vorname := EdtVornameL.Text;
     Nachname := EdtNameL.Text;

     case RGeschlecht.ItemIndex of
     0: Geschlecht := 'M';
     1: Geschlecht := 'J';
     end;

     

     Try
      With CSSenden do
       begin
          Port := 8080; //Festlegung des Ports
          Host := Adresse; //IP des Zielrechners
          Active := True; //Aufbau der Verbindung
          sleep(100);
          Socket.SendText ('1' + Vorname);
          sleep(100);
          Socket.SendText ('2' + Nachname);
          sleep(1000);
          Socket.SendText ('3' + Geschlecht);
       end;
     Except
       showmessage('Fehler bei der Verbindung');
      end;

end;

procedure TMenue.LblSendenMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
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

procedure TMenue.RGeschlechtClick(Sender: TObject);
begin
     RGeschlecht.Font.Color := clBlack;
end;


procedure TMenue.CSSendenError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
     showmessage ('Fehler bei der Verbindung!' + #13#10 +
                  'Fehler: ' + IntToStr(ErrorCode));;  //Gibt den FehlerCode aus!
end;

procedure TMenue.GBLehreranmeldungMouseMove(Sender: TObject;
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

procedure TMenue.VerbindenTimerTimer(Sender: TObject);
begin
     if GBLehreranmeldung.Top < Screen.Height div 2 - GBLehreranmeldung.Height div 2 then
    begin
         GBLehreranmeldung.Top := GBLehreranmeldung.Top + 30;
    end else VerbindenTimer.Enabled := false;
end;

procedure TMenue.VerbindenZurueckTimerTimer(Sender: TObject);
begin
     if GBLehreranmeldung.Top > -GBLehreranmeldung.Height then
     begin
          GBLehreranmeldung.Top := GBLehreranmeldung.Top - 30;
     end else
     begin
          VerbindenZurueckTimer.Enabled := false;
     end;
end;

procedure TMenue.LblZurueckLMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     LblZurueckL.Top := LblZurueckL.Top + 2;
     ShpZurueckL.Top := ShpZurueckL.Top + 2;
end;

procedure TMenue.LblZurueckLMouseMove(Sender: TObject; Shift: TShiftState;
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

procedure TMenue.LblZurueckLMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     LblZurueckL.Top := LblZurueckL.Top - 2;
     ShpZurueckL.Top := ShpZurueckL.Top - 2;

     VerbindenZurueckTimer.Enabled := true;
end;

procedure TMenue.LblVerbindenMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     LblVerbinden.Top := LblVerbinden.Top + 2;
     ShpVerbinden.Top := ShpVerbinden.Top + 2;
end;

procedure TMenue.LblVerbindenMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
     LblVerbinden.Top := LblVerbinden.Top - 2;
     ShpVerbinden.Top := ShpVerbinden.Top - 2;
     VerbindenTimer.Enabled := true;
end;

procedure TMenue.LblVerbindenMouseMove(Sender: TObject; Shift: TShiftState;
  X, Y: Integer);
begin
     if ShpVerbinden.Brush.Color = clWhite then
     begin
          LblVerbinden.Font.Color := clWhite;
          ShpVerbinden.Brush.Color := clBlack;
          ShpVerbinden.Left := ShpVerbinden.Left - 10;
          ShpVerbinden.Width := ShpVerbinden.Width + 20;
     end;
     if ShpNeu.Brush.Color = clBlack then
     begin
          LblNeu.Font.Color := clBlack;
          ShpNeu.Brush.Color := clWhite;
          ShpNeu.Left := ShpNeu.Left + 10;
          ShpNeu.Width := ShpNeu.Width - 20;
     end;
     if ShpAnmelden.Brush.Color = clBlack then
     begin
          LblAnmelden.Font.Color := clBlack;
          ShpAnmelden.Brush.Color := clWhite;
          ShpAnmelden.Left := ShpAnmelden.Left + 10;
          ShpAnmelden.Width := ShpAnmelden.Width - 20;
     end;
end;

procedure TMenue.CSSendenRead(Sender: TObject; Socket: TCustomWinSocket);
begin
     MIndex.clear;
     MIndex.Lines.add(Socket.ReceiveText);
     MIndex.Lines.SaveToFile(ExtractFilePath(ParamStr(0)) + 'Dateien/index.dat');
     CSSenden.Active := false;
end;


end.
