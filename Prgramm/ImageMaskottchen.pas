unit ImageMaskottchen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, axctrls ;

type
  TImageMaskottchen = class(TImage)
  private
    { Private-Deklarationen }
  protected
    { Protected-Deklarationen }
    procedure Click; override;
    procedure MouseMove(Shift: TShiftState; X,
      Y: Integer); override;
    function Pixelfarbe(const x,y:integer):TColor;
  public
    { Public-Deklarationen }
    Zustand:string;
    laenge:integer;
    aktuellesBild:integer;
    Normalzustand:boolean;
    Hintergrund:TColor;
    property OnMouseMove;
    constructor Create(AOwner:TComponent);override;
    procedure BildLaden(Datei: string);
    procedure GehSchlafen;
    procedure FreuDich;
    procedure SeiTraurig;
    procedure Weine;
  published
    { Published-Deklarationen }
  end;

var Pfad :string;


procedure Register;

implementation

constructor TImageMaskottchen.Create(AOwner:TComponent);
begin
     inherited Create(AOwner);
     Stretch := true;
     Pfad := ExtractFilePath(ParamStr(0));
     Cursor := crHandPoint;
end;

procedure TImageMaskottchen.MouseMove(Shift:TShiftState;X,Y:integer);
begin
     inherited MouseMove(Shift,X,Y);
     if Pixelfarbe(x+Left,y+Top) = Hintergrund then
     begin
          Cursor := crDefault;
     end else Cursor := crHandpoint;
end;

function TImageMaskottchen.Pixelfarbe(const x,y: integer): TColor;
var
   c:TCanvas;
begin
   c:=TCanvas.create;                                      // Diese Funktion gibt die Pixelfarbe
   c.handle:= GetWindowDC(GetDesktopWindow);               // an der Stelle x,y zur�ck
   result:=getpixel(c.handle,x,y);
   c.free;
end;

procedure TImageMaskottchen.Click;
var i:byte;
begin
     inherited Click;
     if Cursor = crHandpoint then
     begin

     randomize;
     i := random(3);
     case i of
     0: SeiTraurig;
     1: Weine;
     2: FreuDich;
     end;

     end;
end;

procedure TImageMaskottchen.BildLaden(Datei: string);
var
   FStream : TFileStream;
   OLEBild : TOleGraphic;
begin
     OLEBild := TOleGraphic.Create;
     FStream := TFileStream.Create(Pfad + '\' + Datei, fmOpenRead or fmShareDenyNone);
     try
        OLEBild.LoadFromStream(FStream);
        Picture.Assign(OLEBild);
     finally
            FStream.Free;
            OLEBild.Free;
     end;
end;

procedure TImageMaskottchen.GehSchlafen;
begin
     aktuellesBild := 0;
     Zustand := 'Schlafen';
     Normalzustand := false;
     laenge := 27;
end;

procedure TImageMaskottchen.Weine;
begin
     aktuellesBild := 0;
     Zustand := 'TotalWeinen';
     Normalzustand := false;
     laenge := 17;
end;

procedure TImageMaskottchen.SeiTraurig;
begin
     aktuellesBild := 0;
     Zustand := 'Weinen';
     Normalzustand := false;
     laenge := 23;
end;

procedure TImageMaskottchen.FreuDich;
begin
     aktuellesBild := 0;
     Zustand := 'Lachen';
     Normalzustand := false;
     laenge := 20;
end;


procedure Register;
begin
  RegisterComponents('�bung', [TImageMaskottchen]);
end;

end.
