object FormKonsole: TFormKonsole
  Left = 294
  Top = 180
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Konsole'
  ClientHeight = 518
  ClientWidth = 788
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
    Left = 288
    Top = 8
    Width = 216
    Height = 37
    Caption = 'Lehrerkonsole'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -32
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold, fsUnderline]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 432
    Top = 472
    Width = 108
    Height = 20
    Caption = 'Serverstatus:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ShapeServerStatus: TShape
    Left = 552
    Top = 464
    Width = 33
    Height = 33
    Shape = stEllipse
  end
  object Label3: TLabel
    Left = 432
    Top = 120
    Width = 165
    Height = 20
    Caption = 'ausgewählte Klasse:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 432
    Top = 272
    Width = 120
    Height = 20
    Caption = 'Schüleranzahl:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 432
    Top = 80
    Width = 123
    Height = 20
    Caption = 'Benutzername:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label6: TLabel
    Left = 432
    Top = 312
    Width = 52
    Height = 20
    Caption = 'Online'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StringGridUbersicht: TStringGrid
    Left = 16
    Top = 64
    Width = 393
    Height = 441
    ColCount = 7
    DefaultColWidth = 50
    DefaultRowHeight = 30
    RowCount = 14
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ScrollBars = ssVertical
    TabOrder = 0
    OnDblClick = StringGridUbersichtDblClick
    ColWidths = (
      50
      110
      108
      37
      79
      40
      50)
  end
  object EdtSchuelerAnzahl: TEdit
    Left = 576
    Top = 264
    Width = 65
    Height = 32
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    Text = 'EdtSchuelerAnzahl'
  end
  object BtnBeenden: TButton
    Left = 432
    Top = 408
    Width = 329
    Height = 33
    Caption = 'BtnBeenden'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    OnClick = BtnBeendenClick
  end
  object EdtBenutzername_Lehrer: TEdit
    Left = 608
    Top = 80
    Width = 153
    Height = 28
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Text = 'EdtBenutzername_Lehrer'
  end
  object ComboBoxKlassenNamen: TComboBox
    Left = 608
    Top = 120
    Width = 153
    Height = 28
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ItemHeight = 20
    ParentFont = False
    TabOrder = 4
    Text = 'ComboBoxKlassenNamen'
    OnChange = ComboBoxKlassenNamenChange
  end
  object BtnServerAktion: TButton
    Left = 432
    Top = 216
    Width = 329
    Height = 33
    Caption = 'BtnServerAktion'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 5
    OnClick = BtnServerAktionClick
  end
  object BtnModus_Lehrer: TButton
    Left = 432
    Top = 360
    Width = 329
    Height = 33
    Caption = 'BtnModus_Lehrer'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 6
    OnClick = BtnModus_LehrerClick
  end
  object EdtSchuelerOnline: TEdit
    Left = 576
    Top = 304
    Width = 65
    Height = 32
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clLime
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    Text = 'EdtSchuelerOnline'
  end
  object BtnKlasseChange: TButton
    Left = 432
    Top = 168
    Width = 329
    Height = 33
    Caption = 'BtnKlasseChange'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnClick = BtnKlasseChangeClick
  end
  object EdtNachricht: TEdit
    Left = 104
    Top = 8
    Width = 73
    Height = 21
    TabOrder = 9
    Text = 'EdtNachricht'
    Visible = False
  end
  object EdtPunkte: TEdit
    Left = 104
    Top = 32
    Width = 73
    Height = 21
    TabOrder = 10
    Text = 'EdtPunkte'
    Visible = False
  end
  object MainMenu: TMainMenu
    Left = 8
    Top = 8
    object Auswertung2: TMenuItem
      Caption = 'Klasse'
      object NeueKlasseanlegen1: TMenuItem
        Caption = 'Neue Klasse anlegen'
        OnClick = NeueKlasseanlegen1Click
      end
      object Klasselschen1: TMenuItem
        Caption = 'Klasse löschen'
        OnClick = Klasselschen1Click
      end
    end
    object Auswertung1: TMenuItem
      Caption = 'Schülerdaten'
      object Bearbeiten1: TMenuItem
        Caption = 'Schüler anlegen'
        OnClick = Bearbeiten1Click
      end
      object SchlerLschen1: TMenuItem
        Caption = 'Schüler Löschen'
      end
    end
    object Hilfe1: TMenuItem
      Caption = 'Hilfe'
      object Adminkontaktieren1: TMenuItem
        Caption = 'Admin kontaktieren'
        OnClick = Adminkontaktieren1Click
      end
      object Anleitungffnen1: TMenuItem
        Caption = 'Anleitung öffnen'
        OnClick = Anleitungffnen1Click
      end
    end
  end
  object ServerSocketLehrer: TServerSocket
    Active = False
    Port = 8080
    ServerType = stNonBlocking
    ThreadCacheSize = 25
    OnClientDisconnect = ServerSocketLehrerClientDisconnect
    OnClientRead = ServerSocketLehrerClientRead
    OnClientError = ServerSocketLehrerClientError
    Left = 48
    Top = 8
  end
end
