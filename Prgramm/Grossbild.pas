unit Grossbild;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, jpeg;

type
  TVollbild = class(TForm)
    Bild: TImage;
    procedure FormClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
    procedure ImageAusrichten;
  end;

var
  Vollbild: TVollbild;

implementation

{$R *.DFM}

uses Atlas;

procedure TVollbild.FormCreate(Sender: TObject);
begin
     Bild.Stretch := false;
     Bild.Autosize := true;
     Bild.Picture.LoadFromFile(ExtractFilePath(ParamStr(0)) + 'Bilder/Atlas/' + Atlas.Region + Atlas.Typ + '.jpg');
     ImageAusrichten;
end;


procedure TVollbild.ImageAusrichten;
begin
     if Bild.Height <> Screen.Height then    // s.Atlas
     begin
          Bild.AutoSize := false;
          Bild.Width := round(Bild.Width*Screen.Height / Bild.Height);
          Bild.Height:= Screen.Height;
          Bild.Stretch := true;

     end;

     if Bild.Width > Screen.Width then
     begin
          Bild.Height := round(Bild.Height * Screen.Width / Bild.Width);
          Bild.Width := Screen.Width;

          Bild.Top := round((Screen.Height-Bild.Height)/2);
          Bild.Left :=  0;
     end else
     begin
          Bild.Left := round((Screen.Width-Bild.Width)/ 2);
          Bild.Top := 0;
     end;
end;

procedure TVollbild.FormClick(Sender: TObject);
begin
     close;
end;









end.
