object FormKonsole: TFormKonsole
  Left = 318
  Top = 149
  Width = 816
  Height = 593
  BorderIcons = [biSystemMenu]
  Caption = 'FormKonsole'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 248
    Top = 16
    Width = 216
    Height = 37
    Caption = 'Lehrerkonsole'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 32
    Top = 392
    Width = 62
    Height = 13
    Caption = 'Serverstatus:'
  end
  object ShapeServerStatus: TShape
    Left = 104
    Top = 384
    Width = 33
    Height = 33
    Shape = stEllipse
  end
  object Label3: TLabel
    Left = 40
    Top = 88
    Width = 165
    Height = 20
    Caption = 'ausgewählte Klasse:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 368
    Top = 88
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
  object Label5: TLabel
    Left = 40
    Top = 64
    Width = 71
    Height = 13
    Caption = 'Benutzername:'
  end
  object StringGridUbersicht: TStringGrid
    Left = 32
    Top = 128
    Width = 657
    Height = 233
    DefaultColWidth = 50
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
    TabOrder = 0
    ColWidths = (
      50
      102
      97
      84
      130)
  end
  object EdtSchuelerAnzahl: TEdit
    Left = 496
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'EdtSchuelerAnzahl'
  end
  object BtnBeenden: TButton
    Left = 24
    Top = 440
    Width = 249
    Height = 25
    Caption = 'BtnBeenden'
    TabOrder = 2
    OnClick = BtnBeendenClick
  end
  object EdtKlassenName: TEdit
    Left = 216
    Top = 88
    Width = 121
    Height = 21
    TabOrder = 3
    Text = 'EditKlassenName'
  end
  object EdtBenutzername_Lehrer: TEdit
    Left = 216
    Top = 56
    Width = 121
    Height = 21
    TabOrder = 4
    Text = 'EdtBenutzername_Lehrer'
  end
  object MainMenu: TMainMenu
    Left = 8
    Top = 8
    object Auswertung2: TMenuItem
      Caption = 'Klasse'
      object Klassendern1: TMenuItem
        Caption = 'Klasse ändern'
      end
      object NeueKlasseanlegen1: TMenuItem
        Caption = 'Neue Klasse anlegen'
        OnClick = NeueKlasseanlegen1Click
      end
      object Klasselschen1: TMenuItem
        Caption = 'Klasse löschen'
      end
    end
    object Auswertung1: TMenuItem
      Caption = 'Schülerdaten'
      object Schlerbearbeiten1: TMenuItem
        Caption = 'Schüler bearbeiten'
      end
      object Bearbeiten1: TMenuItem
        Caption = 'Schüler anlegen'
      end
      object SchlerLschen1: TMenuItem
        Caption = 'Schüler Löschen'
      end
    end
    object Auswertung3: TMenuItem
      Caption = 'Auswertung'
    end
    object Hilfe1: TMenuItem
      Caption = 'Hilfe'
      object Adminkontaktieren1: TMenuItem
        Caption = 'Admin kontaktieren'
        OnClick = Adminkontaktieren1Click
      end
      object Anleitungffnen1: TMenuItem
        Caption = 'Anleitung öffnen'
      end
    end
  end
  object ServerSocketLehrer: TServerSocket
    Active = False
    Port = 8080
    ServerType = stNonBlocking
    ThreadCacheSize = 25
    OnClientError = ServerSocketLehrerClientError
    Left = 48
    Top = 8
  end
end
