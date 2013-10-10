unit ImageButton;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, axctrls;

type
  TImageButton = class(TImage)
  private
    { Private-Deklarationen }
    FThemenfarbe1:TColor;
    FThemenfarbe2:TColor;
    FZoom:boolean;
  protected
    { Protected-Deklarationen }
    procedure MouseMove(Shift: TShiftState; X,
      Y: Integer); override;
    function Pixelfarbe(const x,y: integer): TColor;
  public
    { Public-Deklarationen }
    constructor Create(AOwner:TComponent);override;
    procedure BildLaden(Datei: string);
    procedure Vergroessern;
    Procedure Verkleinern;
  published
    { Published-Deklarationen }
    property OnMouseMove;
    property Stretch default true;
    property Themenfarbe1:Tcolor read FThemenfarbe1 write FThemenfarbe1 default clWhite;
    property Themenfarbe2:Tcolor read FThemenfarbe2 write FThemenfarbe2 default clWhite;
    property Zoom : boolean read FZoom write FZoom default false;
  end;


procedure Register;

implementation

var ScreenMitte:TPoint;


constructor TImageButton.Create(AOwner:TComponent);
begin
     inherited Create(AOwner);
     Stretch := true;
     ScreenMitte := Point(Screen.Width div 2,Screen.Height div 2);    // Mitte des Screen wird ermittelt
end;

procedure TImageButton.BildLaden(Datei: string);                      // im Internet gefundene Prozedur zum laden von
var                                                                   // unanimierten gifs mit transparentem Hintergrund
  FStream: TFileStream;
  OLEBild: TOleGraphic;
begin
  OLEBild := TOleGraphic.Create;
  FStream := TFileStream.Create(Datei, fmOpenRead or fmShareDenyNone);
  try
    OLEBild.LoadFromStream(FStream);
    Picture.Assign(OLEBild);
  finally
    FStream.Free;
    OLEBild.free;
  end;
end;


procedure TImageButton.MouseMove(Shift:TShiftState;X,Y:integer);
var k:integer;
begin
     inherited MouseMove(Shift,X,Y);


     if (Pixelfarbe(X+Left,Y+Top) = Themenfarbe1) and     // wenn die Farbe des Pixels unter der Maus
        (Height > k) then Zoom := false;                  // der Themenfarbe entspricht -> Verkleinerungs-Modus

     if (Pixelfarbe(X+Left,Y+Top) <> Themenfarbe1)        // wenn die Farbe des Pixels unter der Maus NICHT
     then Zoom := true;                                   // der Themenfarbe entspricht -> Zoom-Modus
     
end;

procedure TImageButton.Vergroessern;
begin
     if Left + (Width div 2) > ScreenMitte.x then         // Befindet sich das Objekt in der rechten Bildschirmhälfte
     begin
          Left := Left - 4;                               // vergrößert sich das Bild in die linke Richtung.
          Width := Width + 4;
     end else Width := Width + 4;                         // Wenn nicht, dann nach rechts.

     if Top + (Height div 2) > ScreenMitte.y then         // Befindet sich das Objekt in der unteren Bildschrimhälfte
     begin
          Top := Top - 4;                                 // vergrößert sich das Bild nach oben.
          Height := Height + 4;
     end else Height := Height + 4;                       // Wenn nicht dann nach unten.
end;
                                                          // -> Das Bild wird in die Mitte gezogen, wo eventuell das Masskottchen steht...
procedure TImageButton.Verkleinern;
begin
     if Left + (Width div 2) > ScreenMitte.x then         // Gegenstück zum Vergrößern
     begin
          Left := Left + 4;
          Width := Width - 4;
     end else Width := Width - 4;

     if Top + (Height div 2) > ScreenMitte.y then
     begin
          Top := Top + 4;
          Height := Height - 4;
     end else Height := Height - 4;
end;

function TImageButton.Pixelfarbe(const x,y: integer): TColor;
var
   c:TCanvas;
begin
   c:=TCanvas.create;                                      // Diese Funktion gibt die Pixelfarbe
   c.handle:= GetWindowDC(GetDesktopWindow);               // an der Stelle x,y zurück
   result:=getpixel(c.handle,x,y);
   c.free;
end;


procedure Register;
begin
  RegisterComponents('Übung', [TImageButton]);
end;

end.
