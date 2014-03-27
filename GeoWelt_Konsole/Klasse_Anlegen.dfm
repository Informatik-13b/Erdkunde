object FormKlasseAnlegen: TFormKlasseAnlegen
  Left = 614
  Top = 270
  Width = 374
  Height = 257
  Caption = 'KlasseAnlegen'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 40
    Top = 64
    Width = 120
    Height = 20
    Caption = 'Schüleranzahl:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 16
    Top = 16
    Width = 322
    Height = 37
    Caption = 'Neue Klasse anlegen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 40
    Top = 144
    Width = 95
    Height = 20
    Caption = 'IP-Adresse:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 40
    Top = 104
    Width = 113
    Height = 20
    Caption = 'Klassenname:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object EdtAnzahl: TEdit
    Left = 184
    Top = 64
    Width = 137
    Height = 21
    TabOrder = 0
    Text = 'EdtAnzahl'
    OnKeyDown = EdtAnzahlKeyDown
    OnKeyPress = EdtAnzahlKeyPress
  end
  object BtnServerOffnen: TButton
    Left = 24
    Top = 176
    Width = 137
    Height = 25
    Caption = 'BtnServerOffnen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BtnServerOffnenClick
  end
  object EdtIPAdresse: TEdit
    Left = 184
    Top = 144
    Width = 137
    Height = 21
    Enabled = False
    TabOrder = 2
    Text = 'EdtIPAdresse'
  end
  object BtnAbbrechen: TButton
    Left = 192
    Top = 176
    Width = 137
    Height = 25
    Caption = 'BtnAbbrechen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BtnAbbrechenClick
  end
  object EdtKlassenName: TEdit
    Left = 184
    Top = 104
    Width = 137
    Height = 21
    TabOrder = 1
    Text = 'EdtKlassenName'
    OnChange = EdtKlassenNameChange
    OnKeyDown = EdtKlassenNameKeyDown
  end
end
