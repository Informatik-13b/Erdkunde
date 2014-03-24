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
    procedure Ausfuehren(Emotion:string);
  published
    { Published-Deklarationen }
  end;


procedure Register;

implementation

constructor TImageMaskottchen.Create(AOwner:TComponent);
var i,k:integer;
begin
     inherited Create(AOwner);
     Height := 200;
     Width := 150;
     Top := 100;
     Left := -100;
     Stretch := true;
end;

procedure TImageMaskottchen.BildLaden(Datei: string);
var
   FStream : TFileStream;
   OLEBild : TOleGraphic;
begin
     OLEBild := TOleGraphic.Create;
     FStream := TFileStream.Create(Datei, fmOpenRead or fmShareDenyNone);
     try
        OLEBild.LoadFromStream(FStream);
        Picture.Assign(OLEBild);
     finally
            FStream.Free;
            OLEBild.Free;
     end;
end;

{procedure TImageMaskottchen.pause(zeit:longint);
var zeit1 : longint;
begin
     zeit1 := GetTickCount;
     repeat
           Application.ProcessMessages;
     until (GetTickCount - zeit1 > zeit);
end;  }

procedure TImageMaskottchen.Ausfuehren(Emotion:string);
var i : integer;
begin
   {  if Emotion = 'Gehen' then
     begin
          laenge := 64;
          Zeit := 8;
          Height := 200;
          Width := 450;
     end else
     if Emotion = 'Weinen' then
     begin
          laenge := 24;
          Zeit := 8;
          left := 200;
          Height := 300;
          Width := 225;
     end else
     if Emotion = 'Schlafen' then
     begin
          laenge := 28;
          Zeit := 8;
          left := 200;
          Height := 300;
          Width := 225;
     end else
     if Emotion = 'TotalWeinen' then
     begin
          laenge := 18;
          Zeit := 1;
          left := 200;
          Height := 300;
          Width := 225;
     end;     }

{for i := 1 to laenge do
begin
     BildLaden(Emotion + '/'+ IntToStr(i) + '.gif');
     pause(Zeit);
end; }
end;

procedure Register;
begin
  RegisterComponents('Übung', [TImageMaskottchen]);
end;

end.
