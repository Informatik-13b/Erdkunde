program Programm;

uses
  Forms,
  Struktur in 'Struktur.pas' {Menue},
  Karte in 'Karte.pas' {Orte_Finden},
  ImageButton in 'ImageButton.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMenue, Menue);
  Application.CreateForm(TOrte_Finden, Orte_Finden);
  Application.Run;
end.
