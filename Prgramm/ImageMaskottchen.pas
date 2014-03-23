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
  public
    { Public-Deklarationen }
    Zustand:string;
    laenge:integer;
    aktuellesBild:integer;
    Normalzustand:boolean;
    constructor Create(AOwner:TComponent);override;
    procedure BildLaden(Datei: string);
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


procedure Register;
begin
  RegisterComponents('Übung', [TImageMaskottchen]);
end;

end.
