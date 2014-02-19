object FormAnlegen: TFormAnlegen
  Left = 553
  Top = 215
  BorderStyle = bsToolWindow
  Caption = 'FormAnlegen'
  ClientHeight = 451
  ClientWidth = 334
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 56
    Top = 16
    Width = 215
    Height = 36
    Caption = 'Lehrer anlegen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -31
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 48
    Top = 128
    Width = 123
    Height = 20
    Caption = 'Benutzername:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 48
    Top = 160
    Width = 79
    Height = 20
    Caption = 'Passwort:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 8
    Top = 72
    Width = 305
    Height = 1
  end
  object Label4: TLabel
    Left = 16
    Top = 88
    Width = 211
    Height = 24
    Caption = 'Anmeldung Entwickler'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 16
    Top = 256
    Width = 122
    Height = 24
    Caption = 'Daten Lehrer'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 48
    Top = 296
    Width = 108
    Height = 20
    Caption = 'Beutzername'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 48
    Top = 328
    Width = 79
    Height = 20
    Caption = 'Passwort:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label8: TLabel
    Left = 48
    Top = 360
    Width = 111
    Height = 20
    Caption = 'Wiederholung'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel2: TBevel
    Left = 8
    Top = 248
    Width = 305
    Height = 1
  end
  object EdtAdminPasswort: TEdit
    Left = 200
    Top = 160
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 0
    Text = 'EdtAdminPasswort'
    OnClick = EdtAdminPasswortClick
  end
  object EdtAdminName: TEdit
    Left = 200
    Top = 128
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'EdtAdminName'
  end
  object EdtLehrerName: TEdit
    Left = 200
    Top = 296
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'EdtLehrerName'
    OnExit = EdtLehrerNameExit
  end
  object EdtLehrerPasswort1: TEdit
    Left = 200
    Top = 328
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 3
    Text = 'EdtLehrerPasswort1'
    OnClick = EdtLehrerPasswort1Click
  end
  object EdtLehrerPasswort2: TEdit
    Left = 200
    Top = 360
    Width = 121
    Height = 21
    PasswordChar = '*'
    TabOrder = 4
    Text = 'EdtLehrerPasswort2'
    OnClick = EdtLehrerPasswort2Click
  end
  object BtnAdminAnmeldung: TButton
    Left = 24
    Top = 200
    Width = 289
    Height = 33
    Caption = 'BtnAdminAnmeldung'
    TabOrder = 1
    OnClick = BtnAdminAnmeldungClick
  end
  object BtnLehrerErstellen: TButton
    Left = 24
    Top = 400
    Width = 289
    Height = 33
    Caption = 'BtnLehrerErstellen'
    TabOrder = 5
    OnClick = BtnLehrerErstellenClick
  end
end
