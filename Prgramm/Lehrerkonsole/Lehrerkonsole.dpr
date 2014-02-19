program Lehrerkonsole;

uses
  Forms,
  Anmeldefenster in 'Anmeldefenster.pas' {FormAnmeldung},
  Leher_Anlegen in 'Leher_Anlegen.pas' {FormAnlegen};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFormAnmeldung, FormAnmeldung);
  Application.CreateForm(TFormAnlegen, FormAnlegen);
  Application.Run;
end.
