unit TestProgramm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ImageMaskottchen,
  StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
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
     Maskottchen.Parent := self;
     Maskottchen.Left := 100;
     Maskottchen.Top := 100;
     Maskottchen.Height := 300;
     Maskottchen.Width := 225;
     Maskottchen.Zustand := 'Normal';
     Maskottchen.aktuellesBild := 0;
     Maskottchen.Normalzustand := true;
     Maskottchen.Laenge := 7;

     self.DoubleBuffered := true;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
     with Maskottchen do
    begin
         Normalzustand := false;
         Zustand := 'Lachen';
         laenge := 20;
         aktuellesBild := 0;
    end;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
    with Maskottchen do
    begin
         Normalzustand := false;
         Zustand := 'Weinen';
         laenge := 23;
         aktuellesBild := 0;
    end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
    with Maskottchen do
    begin
         Normalzustand := false;
         Zustand := 'Schlafen';
         laenge := 27;
         aktuellesBild := 0;
    end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
      with Maskottchen do
    begin
         Normalzustand := false;
         Zustand := 'TotalWeinen';
         laenge := 17;
         aktuellesBild := 0;
    end;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     with Maskottchen do
     begin
          if Normalzustand = true then
          begin
               inc(aktuellesBild);
               if aktuellesBild <= laenge then
                  BildLaden(Zustand + '/'+ IntToStr(aktuellesBild) + '.gif')
               else aktuellesBild := 0;
          end else
          begin
          
               if aktuellesBild <= laenge then
               begin
                    inc(aktuellesBild);
                    BildLaden(Zustand + '/'+ IntToStr(aktuellesBild) + '.gif');
               end else
               begin
                    Zustand := 'Normal';
                    Normalzustand := true;
                    laenge := 7;
                    aktuellesBild := 0;
               end;

     end;

     end;
end;

end.
