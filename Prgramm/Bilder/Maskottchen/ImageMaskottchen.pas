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
  public
    { Public-Deklarationen }
    Zustand:string;
    laenge:integer;
    aktuellesBild:integer;
    Normalzustand:boolean;
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

uses TestProgramm;

constructor TImageMaskottchen.Create(AOwner:TComponent);
begin
     inherited Create(AOwner);
     Stretch := true;
     Pfad := ExtractFilePath(ParamStr(0));
end;

procedure TImageMaskottchen.Click;
var i:byte;
begin
     inherited Click;
     randomize;
     i := random(4);
     case i of
     0: begin
             SeiTraurig;
             Form1.TMaskottchen.Interval := 200;
        end;
     1: begin
             Weine;
             Form1.TMaskottchen.Interval := 200;
        end;
     2: begin
             GehSchlafen;
             Form1.TMaskottchen.Interval := 500;
        end;
     3: begin
             FreuDich;
             Form1.TMaskottchen.Interval := 200;
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
  RegisterComponents('Übung', [TImageMaskottchen]);
end;

end.
