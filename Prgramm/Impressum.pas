unit Impressum;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, jpeg;

type
  TAutor = class(TForm)
    Schliessen: TTimer;
    Effekt: TTimer;
    Image1: TImage;
    procedure SchliessenTimer(Sender: TObject);
    procedure EffektTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Image1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Autor: TAutor;
  Sec:integer = 4;
  x:integer = 10;
  y:integer = -10;

implementation

{$R *.DFM}

procedure TAutor.SchliessenTimer(Sender: TObject);
begin
     dec(sec);
     if sec = 0 then Effekt.Enabled := true;
end;

procedure TAutor.EffektTimer(Sender: TObject);
begin
     with Autor do
     begin
          Width := Width - 8;
          Height := Height - 8;
          if Left <= 0 then x := 10;
          if Left >= Screen.Width - Width then x := -10;
          if Top <= 0 then y := 10;
          if Top >= Screen.Height - Height then y := - 10;
          Left := Left + 7*x;
          Top := Top + 5*y;
          if Height <= 0 then close;
     end;
end;

procedure TAutor.FormCreate(Sender: TObject);
begin
     self.DoubleBuffered := true;
end;

procedure TAutor.Image1Click(Sender: TObject);
begin
     Schliessen.Enabled := false;
     Effekt.Enabled := true;
end;

end.
