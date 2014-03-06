program Lehrerkonsole;

uses
  Forms,
  Anmeldefenster in 'Anmeldefenster.pas' {FormAnmeldung},
  Leher_Anlegen in 'Leher_Anlegen.pas' {FormAnlegen},
  Konsole in 'Konsole.pas' {FormKonsole},
  Klasse_Anlegen in 'Klasse_Anlegen.pas' {FormKlasseAnlegen},
  KlasseVerbinden in 'KlasseVerbinden.pas' {FormKlasseVerbinden},
  Klasse_Loschen in 'Klasse_Loschen.pas' {FormKlasseLoschen},
  Schuler_Hinzufugen in 'Schuler_Hinzufugen.pas' {FormSchuler_Add},
  Stadt_Auswahl in 'Stadt_Auswahl.pas' {FormStadt_Auswahl},
  Menu_Spiel in 'Menu_Spiel.pas' {FormSpiel};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormAnmeldung, FormAnmeldung);
  Application.CreateForm(TFormAnlegen, FormAnlegen);
  Application.CreateForm(TFormKonsole, FormKonsole);
  Application.CreateForm(TFormKlasseAnlegen, FormKlasseAnlegen);
  Application.CreateForm(TFormKlasseVerbinden, FormKlasseVerbinden);
  Application.CreateForm(TFormKlasseLoschen, FormKlasseLoschen);
  Application.CreateForm(TFormSchuler_Add, FormSchuler_Add);
  Application.CreateForm(TFormStadt_Auswahl, FormStadt_Auswahl);
  Application.CreateForm(TFormSpiel, FormSpiel);
  Application.Run;
end.
