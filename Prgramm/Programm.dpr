program Programm;

uses
  Forms,
  Struktur in 'Struktur.pas' {Menue},
  Karte in 'Karte.pas' {Orte_Finden},
  ImageButton in 'ImageButton.pas',
  Lexikon in 'Lexikon.pas' {FLexikon},
  Atlas in 'Atlas.pas' {Karten},
  Grossbild in 'Grossbild.pas' {Vollbild},
  Einstellungen in 'Einstellungen.pas' {Profil},
  Lehrermodus in 'Lehrermodus.pas' {Lehrer};

{$R *.RES}

begin
  Application.Initialize;
  Application.HelpFile := 'C:\Users\Arne\Documents\Schule\13\Informatik\Info-13b\Erdkunde\README.md';
  Application.Title := 'GEOWELT';
  Application.CreateForm(TMenue, Menue);
  Application.Run;
end.
