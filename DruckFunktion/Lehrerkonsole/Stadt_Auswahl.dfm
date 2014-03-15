object FormStadt_Auswahl: TFormStadt_Auswahl
  Left = 572
  Top = 160
  Width = 415
  Height = 626
  Caption = 'Städte -Auswahl'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 88
    Top = 24
    Width = 228
    Height = 42
    Caption = 'Auswahl Städte'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -35
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 256
    Top = 153
    Width = 90
    Height = 18
    Caption = 'Stadt-Auswahl'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 256
    Top = 80
    Width = 121
    Height = 18
    Caption = 'ausgewählte Klasse'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 256
    Top = 376
    Width = 133
    Height = 21
    Caption = 'Antwort-Zeit (sec.)'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 256
    Top = 224
    Width = 58
    Height = 18
    Caption = 'Spielzeit:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 256
    Top = 368
    Width = 129
    Height = 1
  end
  object Label6: TLabel
    Left = 256
    Top = 296
    Width = 71
    Height = 18
    Caption = 'IP-Adresse:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StringGridStadt: TStringGrid
    Left = 24
    Top = 80
    Width = 217
    Height = 489
    ColCount = 3
    DefaultColWidth = 40
    DefaultRowHeight = 32
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnDblClick = StringGridStadtDblClick
    OnDrawCell = StringGridStadtDrawCell
    ColWidths = (
      40
      171
      40)
  end
  object BtnStart: TButton
    Left = 256
    Top = 480
    Width = 129
    Height = 33
    Caption = 'BtnStart'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BtnStartClick
  end
  object BtnAbbrechen: TButton
    Left = 256
    Top = 528
    Width = 129
    Height = 33
    Caption = 'BtnAbbrechen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BtnAbbrechenClick
  end
  object EdtAnzahl: TEdit
    Left = 264
    Top = 184
    Width = 121
    Height = 27
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    Text = 'EdtAnzahl'
  end
  object EdtKlasse: TEdit
    Left = 264
    Top = 112
    Width = 121
    Height = 27
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    Text = 'EdtKlasse'
  end
  object ComboBoxZeit: TComboBox
    Left = 264
    Top = 400
    Width = 121
    Height = 21
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ItemHeight = 13
    ParentFont = False
    Sorted = True
    TabOrder = 5
    OnChange = ComboBoxZeitChange
    Items.Strings = (
      '10'
      '15'
      '20'
      '25'
      '30'
      '35')
  end
  object EdtSpielzeit: TEdit
    Left = 264
    Top = 256
    Width = 121
    Height = 27
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    Text = 'EdtSpielzeit'
  end
  object EdtIP: TEdit
    Left = 264
    Top = 328
    Width = 121
    Height = 24
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    Text = 'EdtIP'
  end
end
