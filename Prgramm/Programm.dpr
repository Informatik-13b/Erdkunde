program Programm;

uses
  Forms,
  Struktur in 'Struktur.pas' {Menue},
  Karte in 'Karte.pas' {Orte_Finden},
  ImageButton in 'ImageButton.pas',
  Lexikon in 'Lexikon.pas' {FLexikon};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMenue, Menue);
  Application.CreateForm(TFLexikon, FLexikon);
  Application.Run;
end.
