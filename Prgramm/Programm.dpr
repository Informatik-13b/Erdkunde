program Programm;

uses
  Forms,
  Struktur in 'Struktur.pas' {Menue},
  Karte in 'Karte.pas' {Orte_Finden},
  ImageButton in 'ImageButton.pas',
  Lexikon in 'Lexikon.pas' {FLexikon},
  Atlas in 'Atlas.pas' {Karten},
  Grossbild in 'Grossbild.pas' {Vollbild},
  Einstellungen in 'Einstellungen.pas' {Profil};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TMenue, Menue);
  Application.Run;
end.
