object FormKlasseVerbinden: TFormKlasseVerbinden
  Left = 468
  Top = 188
  Width = 645
  Height = 558
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'FormKlasseVerbinden'
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
  object LabelAnweisung: TLabel
    Left = 16
    Top = 56
    Width = 88
    Height = 20
    Caption = 'Die Schüle'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 216
    Top = 16
    Width = 198
    Height = 29
    Caption = 'Anmeldevorgang'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 216
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
  object Label3: TLabel
    Left = 296
    Top = 184
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
  object Bevel1: TBevel
    Left = 16
    Top = 168
    Width = 593
    Height = 1
  end
  object Bevel2: TBevel
    Left = 16
    Top = 248
    Width = 585
    Height = 1
  end
  object Label4: TLabel
    Left = 40
    Top = 304
    Width = 78
    Height = 20
    Caption = 'Vorname:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 288
    Top = 304
    Width = 91
    Height = 20
    Caption = 'Nachname:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 24
    Top = 264
    Width = 131
    Height = 24
    Caption = 'Schülerdaten:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label7: TLabel
    Left = 16
    Top = 480
    Width = 92
    Height = 16
    Caption = 'Serverstatus:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ShapeServerStatus: TShape
    Left = 120
    Top = 472
    Width = 33
    Height = 33
    Shape = stEllipse
  end
  object Label8: TLabel
    Left = 16
    Top = 392
    Width = 328
    Height = 24
    Caption = 'Fortschritt Anmeldung der Schüler:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label9: TLabel
    Left = 24
    Top = 184
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
  object EdtIPAdresse: TEdit
    Left = 152
    Top = 216
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'EdtIPAdresse'
  end
  object EdtSchueleranzahl: TEdit
    Left = 440
    Top = 184
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'EdtSchueleranzahl'
  end
  object EdtSchuelerVorname: TEdit
    Left = 136
    Top = 304
    Width = 121
    Height = 21
    TabOrder = 2
    Text = 'EdtSchuelerVorname'
  end
  object EdtSchuelerNachname: TEdit
    Left = 400
    Top = 304
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'EdtSchuelerNachname'
  end
  object BtnBestaetigen: TButton
    Left = 16
    Top = 344
    Width = 593
    Height = 33
    Caption = 'BtnBestaetigen'
    TabOrder = 4
    OnClick = BtnBestaetigenClick
  end
  object ProgressBarFortschritt: TProgressBar
    Left = 16
    Top = 432
    Width = 593
    Height = 25
    Min = 0
    Max = 24
    TabOrder = 5
  end
  object BtnAbbrechen: TButton
    Left = 168
    Top = 472
    Width = 377
    Height = 33
    Caption = 'BtnAbbrechen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = BtnAbbrechenClick
  end
  object BtnCopy: TButton
    Left = 568
    Top = 472
    Width = 43
    Height = 33
    Caption = 'BtnCopy'
    TabOrder = 7
    OnClick = BtnCopyClick
  end
  object EdtKlassenname: TEdit
    Left = 152
    Top = 184
    Width = 121
    Height = 21
    TabOrder = 8
    Text = 'EdtKlassenname'
  end
  object StringGridKlassenNamen: TStringGrid
    Left = 56
    Top = 16
    Width = 33
    Height = 33
    TabOrder = 9
  end
  object Memo: TMemo
    Left = 560
    Top = 288
    Width = 41
    Height = 33
    Lines.Strings = (
      'Memo')
    TabOrder = 10
    Visible = False
  end
  object EdtPos: TEdit
    Left = 96
    Top = 16
    Width = 25
    Height = 21
    TabOrder = 11
    Text = 'EdtPos'
    Visible = False
  end
  object ServerSocketAnmeldung: TServerSocket
    Active = False
    Port = 8080
    ServerType = stNonBlocking
    ThreadCacheSize = 25
    OnClientRead = ServerSocketAnmeldungClientRead
    OnClientError = ServerSocketAnmeldungClientError
    Left = 16
    Top = 16
  end
end
