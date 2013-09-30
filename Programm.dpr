program Programm;

uses
  Forms,
  Struktur in 'Struktur.pas' {Menue};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMenue, Menue);
  Application.Run;
end.
