unit Leher_Anlegen;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, FileCtrl;

type
  TFormAnlegen = class(TForm)
    Label1: TLabel;
    EdtAdminPasswort: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EdtAdminName: TEdit;
    Bevel1: TBevel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    EdtLehrerName: TEdit;
    EdtLehrerPasswort1: TEdit;
    EdtLehrerPasswort2: TEdit;
    BtnAdminAnmeldung: TButton;
    BtnLehrerErstellen: TButton;
    Bevel2: TBevel;
    procedure FormCreate(Sender: TObject);
    procedure BtnAdminAnmeldungClick(Sender: TObject);
    procedure EdtAdminPasswortClick(Sender: TObject);
    procedure EdtLehrerPasswort1Click(Sender: TObject);
    procedure EdtLehrerPasswort2Click(Sender: TObject);
    procedure BtnLehrerErstellenClick(Sender: TObject);
    procedure SchreibeDatei(NameLehrer: String; Passwort: String);
    procedure EdtLehrerNameExit(Sender: TObject);
    procedure Erzeuge_Ordner();
  private
     //
  public
    { Public-Deklarationen }
  end;

var
  FormAnlegen: TFormAnlegen;

implementation

uses Anmeldefenster;

{$R *.DFM}

procedure TFormAnlegen.FormCreate(Sender: TObject);
  begin
     Position:=poScreenCenter;
     RemoveMenu(GetSystemMenu(handle, false), SC_MOVE, MF_BYCOMMAND);
     RemoveMenu(GetSystemMenu(handle, false),SC_SIZE, MF_BYCOMMAND);
     FormAnlegen.Position := poScreenCenter; //Form wird zentriert
     EdtAdminName.Text := 'Admin';
     EdtAdminPasswort.Text := '****';
     EdtLehrerName.Enabled := False;
     EdtLehrerPasswort1.Enabled := False;
     EdtLehrerPasswort2.Enabled := False;
     BtnLehrerErstellen.Enabled := False;
     EdtLehrerName.Text := 'Name';
     EdtLehrerPasswort1.Text := '****';
     EdtLehrerPasswort2.Text := '****';
     BtnAdminAnmeldung.Caption := 'Lehrer-Anmeldung freischalten';
     BtnLehrerErstellen.Caption := 'Neuen Lehrer anlegen';
  end;     //Komponenten werden beschriftet


procedure TFormAnlegen.BtnAdminAnmeldungClick(Sender: TObject);
  begin
      If (EdtAdminName.Text <> '') and (EdtAdminPasswort.Text <> '*') then
       If EdtAdminName.Text = 'Admin' then
         If EdtAdminPasswort.Text = '123456' then         //Admin Passwort wird kontrolliert
           Begin
              BtnAdminAnmeldung.Enabled := False;
              EdtAdminPasswort.Enabled := False;
              EdtAdminName.Enabled := False;
              EdtLehrerName.Enabled := True;
              EdtLehrerName.SetFocus;
              EdtLehrerPasswort1.Enabled := True;
              EdtLehrerPasswort2.Enabled := True;
              BtnLehrerErstellen.Enabled := True;    //Lehrer-Edt-Felder werden sichtbar
           end
          Else begin
                  Application.MessageBox('Falsches Admin-Passwort',
                                         'Passworteingabe',
                                          MB_ICONWARNING or MB_OK) ;
                  EdtAdminPasswort.Text := '';
               end
        Else begin
                Application.MessageBox('Falscher Admin-Benutzername',
                                       'Benutzername',
                                        MB_ICONWARNING or MB_OK) ;
                EdtAdminPasswort.Text := '';
                EdtAdminName.SetFocus;         //Meldungen bei verschiedenen Eingaben
             end;

  end;

procedure TFormAnlegen.EdtAdminPasswortClick(Sender: TObject);
  begin
     If EdtAdminPasswort.Text = '****' then EdtAdminPasswort.Text := '';
  end;

procedure TFormAnlegen.EdtLehrerPasswort1Click(Sender: TObject);
  begin
     If EdtLehrerPasswort1.Text = '****' then EdtLehrerPasswort2.Text := '';
  end;

procedure TFormAnlegen.EdtLehrerPasswort2Click(Sender: TObject);
  begin
     If EdtLehrerPasswort2.Text = '****' then EdtLehrerPasswort2.Text := '';
  end;

procedure TFormAnlegen.BtnLehrerErstellenClick(Sender: TObject);
 begin
     If (EdtLehrerName.Text <> '') and (EdtLehrerPasswort1.Text <> '****')
        and (EdtLehrerPasswort2.Text <> '') then
         If EdtLehrerPasswort1.Text = EdtLehrerPasswort2.Text then
           begin
             If MessageDlg('Name: ' + EdtLehrerName.Text + #10#13 +
                           'Passwort: *****' + #10#13 +
                           'Eingabe in Ordnung?',
                           mtConfirmation, mbYesNoCancel, 0) = mrYes
              then SchreibeDatei(EdtLehrername.Text,EdtLehrerPasswort1.Text);
           end         //Hier wird die Procedure aufgerufen, die in die Textdatei schreibt
          Else begin
                  Application.MessageBox('Die Passwörter stimmen nicht überein!',
                                         'Passworteingabe',
                                          MB_ICONWARNING or MB_OK) ;
                  EdtLehrerPasswort1.SetFocus;
                  EdtLehrerPasswort2.Text := '';
               end
      Else begin
              Application.MessageBox('Eingabe überprüfen!',
                                         'Falsche Eingabe',
                                          MB_ICONWARNING or MB_OK) ;
           end;
  end;

procedure TFormAnlegen.SchreibeDatei(NameLehrer: String; Passwort: String);
 var i,k,z,L: Integer;
     PasswortDateiV: TStringList;
  begin
     With FormAnmeldung do
      begin
         StringGridPasswort.RowCount := StringGridPasswort.RowCount +1;
         StringGridPasswort.Cells[0,StringGridPasswort.RowCount-1] := NameLehrer;
         StringGridPasswort.Cells[1,StringGridPasswort.RowCount-1] := Passwort;
         For i := 0 to 1 do          //StringGrid wird erweitert
          For k := 0 to (StringGridPasswort.RowCount -1) do
           begin
              kt := StringGridPasswort.Cells[i,k];
              lenT := length (kt);
              gt := '';
              For z := 1 to lenT do
               begin
                ErzeugeGa();
                addition(z);
                c := kt [z];
                p := pos (c, ka);
                If p <> 0 then gt := gt +copy (ga2, p, 1)
                 Else gt := gt +c;              //Hier wird verschlüsselt
               end;
              StringGridPasswort.Cells[i,k] := gt;
           end;          //Das StringGrid ist nun verschlüsselt!
         PasswortDateiV := TStringList.Create; //Abbild vom StringGrid wird erschaffen
         Try
           PasswortDateiV.Add(IntToStr(StringGridPasswort.RowCount));
           For L := 0 to (StringGridPasswort.RowCount -1) do
            PasswortdateiV.Add(StringGridPasswort.Rows[L].CommaText);

           PasswortDateiV.SaveToFile('Datenbank\PasswortDateiL.txt');
           showmessage('Ein neuer Lehrer wurde angelegt.' +#10#13+
                       'Starten Sie das Programm neu, um sich anzumelden!');
           Erzeuge_Ordner();  //Erzeugt die notwendigen Datein!
           FormAnmeldung.Close();       //Programm schließt, wenn Lehrer eingefügt wurde,
           Close();                     //damit es später keine Probleme beim Anmelden gibt
          Finally
           PasswortDateiV.Free;
           end;
      end; 
  end;

procedure TFormAnlegen.EdtLehrerNameExit(Sender: TObject);
 var i: Integer;         //Es wird kontrolliert, ob der Lehrername schon vergeben ist 
  begin
     With FormAnmeldung do
       begin
           For i := 0 to StringGridPasswort.RowCount do
            If EdtLehrerName.Text = StringGridPasswort.Cells[0,i] then
              begin
                  showmessage('Der Benutzername ist schon vergeben!');
                  EdtLehrerName.SetFocus;
                  EdtLehrerPasswort1.Text := '';
                  EdtLehrerPasswort2.Text := '';
                  Exit;
              end
       end;
  end;

procedure TFormAnlegen.Erzeuge_Ordner();
 var Liste: TStringList;
  begin
     If DirectoryExists('TransportOrdner\LehrerOrdner' + EdtLehrerName.Text) = False
       then CreateDir('TransportOrdner\LehrerOrdner\' +EdtLehrerName.Text);
     Liste := TStringList.Create;
     Try
       Liste.SaveToFile ('TransportOrdner\LehrerOrdner\'
                         + EdtLehrerName.Text + '\Lehrer_Adresse.txt');
       Liste.Add ('Exit');                  
       Liste.SaveToFile ('TransportOrdner\LehrerOrdner\'
                         + EdtLehrerName.Text + '\Last_Class.txt');
      Finally
         Liste.Free;
       end;            //Notwendige Ordner, bzw. Dateien werden erstellt!
  end;

end.
