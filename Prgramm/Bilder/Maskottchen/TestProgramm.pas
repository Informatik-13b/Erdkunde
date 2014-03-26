unit TestProgramm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ImageMaskottchen,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    BtnSchlafen: TButton;
    BtnFreuen: TButton;
    BtnTraurig: TButton;
    BtnWeinen: TButton;
    TMaskottchen: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure BtnSchlafenClick(Sender: TObject);
    procedure BtnFreuenClick(Sender: TObject);
    procedure BtnTraurigClick(Sender: TObject);
    procedure BtnWeinenClick(Sender: TObject);
    procedure TMaskottchenTimer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;
  Maskottchen:TImageMaskottchen;

implementation

{$R *.DFM}



procedure TForm1.FormCreate(Sender: TObject);
begin
     Maskottchen := TImageMaskottchen.Create(self);
     Maskottchen.Height := 500;
     Maskottchen.Parent := self;
     Maskottchen.Width := (Maskottchen.Height * 225) div 300;
     Maskottchen.Left := Form1.Width div 2 - Maskottchen.Width div 2;
     Maskottchen.Top := Form1.Height div 2 - Maskottchen.Height div 2;
     Maskottchen.Zustand := 'Normal';
     Maskottchen.aktuellesBild := 0;
     Maskottchen.Normalzustand := true;
     Maskottchen.Laenge := 81;

     self.DoubleBuffered := true;
end;

procedure TForm1.BtnSchlafenClick(Sender: TObject);
begin
     Maskottchen.GehSchlafen;
     TMaskottchen.Interval := 500;
end;

procedure TForm1.BtnFreuenClick(Sender: TObject);
begin
    Maskottchen.FreuDich;
    TMaskottchen.Interval := 200;
end;

procedure TForm1.BtnTraurigClick(Sender: TObject);
begin
    Maskottchen.SeiTraurig;
    TMaskottchen.Interval := 200;
end;

procedure TForm1.BtnWeinenClick(Sender: TObject);
begin
    Maskottchen.Weine;
    TMaskottchen.Interval := 200;
end;

procedure TForm1.TMaskottchenTimer(Sender: TObject);
begin
     with Maskottchen do
     begin
          if Normalzustand = true then
          begin
               inc(aktuellesBild);
               if aktuellesBild <= laenge then
                  BildLaden(Zustand + '\('+ IntToStr(aktuellesBild) + ').gif')

          else
          begin
               GehSchlafen;
               TMaskottchen.Interval := 500;
          end;
          end else
          begin
               if aktuellesBild <= laenge then
               begin
                    inc(aktuellesBild);
                    BildLaden(Zustand + '\('+ IntToStr(aktuellesBild) + ').gif');
               end else
               begin
                    Zustand := 'Normal';
                    Normalzustand := true;
                    laenge := 81;
                    aktuellesBild := 0;
                    TMaskottchen.Interval := 200;
               end;
          end;
     end;
end;

end.
