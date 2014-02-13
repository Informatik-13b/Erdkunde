program Lehrerkonsole;

uses
  Forms,
  Anmeldefenster in 'Anmeldefenster.pas' {FormAnmeldung},
  Leher_Anlegen in 'Leher_Anlegen.pas' {FormAnlegen},
  Konsole in 'Konsole.pas' {FormKonsole},
  Klasse_Anlegen in 'Klasse_Anlegen.pas' {FormKlasseAnlegen},
  KlasseVerbinden in 'KlasseVerbinden.pas' {FormKlasseVerbinden};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormAnmeldung, FormAnmeldung);
  Application.CreateForm(TFormAnlegen, FormAnlegen);
  Application.CreateForm(TFormKonsole, FormKonsole);
  Application.CreateForm(TFormKlasseAnlegen, FormKlasseAnlegen);
  Application.CreateForm(TFormKlasseVerbinden, FormKlasseVerbinden);
  Application.Run;
end.
