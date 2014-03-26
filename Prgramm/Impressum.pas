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
  Sec:integer = 5;
  xR:integer;
  yR:integer;
  bewegen:boolean=false;

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
          Width := Width - 5;
          Height := Height - 5;
          if Left <= 0 then xR := xR*-1;
          if Left >= Screen.Width - Width then xR := xR*-1;
          if Top <= 0 then yR := yR*-1;
          if Top >= Screen.Height - Height then yR := yR*-1;
          Left := Left + 10*xR;
          Top := Top + 10*yR;
          if Height <= 0 then close;
     end;
end;

procedure TAutor.FormCreate(Sender: TObject);
begin
     self.DoubleBuffered := true;
     randomize;
     xR := random(20)-10;
     yR := random(20)-10;
end;

procedure TAutor.Image1Click(Sender: TObject);
begin
     Schliessen.Enabled := false;
     Effekt.Enabled := true;
end;

end.
