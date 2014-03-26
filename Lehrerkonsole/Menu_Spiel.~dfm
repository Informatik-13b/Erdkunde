object FormSpiel: TFormSpiel
  Left = 173
  Top = 176
  Width = 910
  Height = 625
  VertScrollBar.Visible = False
  Caption = 'Spiel -Lehrermodus'
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
    Left = 288
    Top = 8
    Width = 251
    Height = 59
    Caption = 'Spiel-Modus'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -48
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel1: TBevel
    Left = 248
    Top = 408
    Width = 129
    Height = 1
  end
  object Bevel2: TBevel
    Left = 248
    Top = 344
    Width = 129
    Height = 1
  end
  object Label2: TLabel
    Left = 248
    Top = 200
    Width = 104
    Height = 19
    Caption = 'Sortieren nach:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel3: TBevel
    Left = 248
    Top = 472
    Width = 129
    Height = 1
  end
  object Label3: TLabel
    Left = 248
    Top = 272
    Width = 79
    Height = 19
    Caption = 'Antworten:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Bevel4: TBevel
    Left = 240
    Top = 256
    Width = 137
    Height = 1
  end
  object StringGridAuswahl: TStringGrid
    Left = 16
    Top = 80
    Width = 217
    Height = 489
    ColCount = 3
    DefaultColWidth = 40
    DefaultRowHeight = 32
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
    OnDrawCell = StringGridAuswahlDrawCell
    ColWidths = (
      40
      171
      40)
  end
  object StringGridPunkte: TStringGrid
    Left = 392
    Top = 80
    Width = 481
    Height = 489
    DefaultColWidth = 40
    DefaultRowHeight = 32
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 1
    OnSelectCell = StringGridPunkteSelectCell
    ColWidths = (
      40
      124
      154
      155
      40)
  end
  object BtnAktion: TButton
    Left = 248
    Top = 360
    Width = 129
    Height = 33
    Caption = 'BtnAktion'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BtnAktionClick
  end
  object BtnCopy: TButton
    Left = 248
    Top = 536
    Width = 129
    Height = 33
    Caption = 'BtnCopy'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BtnCopyClick
  end
  object BtnAbbrechen: TButton
    Left = 248
    Top = 488
    Width = 129
    Height = 33
    Caption = 'BtnAbbrechen'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BtnAbbrechenClick
  end
  object ComboBoxFunktion: TComboBox
    Left = 248
    Top = 224
    Width = 129
    Height = 23
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ItemHeight = 15
    ParentFont = False
    TabOrder = 5
    Text = 'ComboBoxFunktion'
    OnChange = ComboBoxFunktionChange
    Items.Strings = (
      'Gesamtentfernung'
      'letzte Entfernung')
  end
  object BtnPrint: TButton
    Left = 248
    Top = 424
    Width = 129
    Height = 33
    Caption = 'BtnPrint'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = BtnPrintClick
  end
  object RichEditPrint: TRichEdit
    Left = 16
    Top = 576
    Width = 217
    Height = 33
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -25
    Font.Name = 'Courier'
    Font.Style = [fsBold]
    Lines.Strings = (
      'RichEditPrint')
    ParentFont = False
    TabOrder = 7
    Visible = False
  end
  object EdtText: TEdit
    Left = 56
    Top = 16
    Width = 25
    Height = 21
    TabOrder = 8
    Text = 'EdtText'
    Visible = False
  end
  object ProgressBarStand: TProgressBar
    Left = 248
    Top = 304
    Width = 129
    Height = 25
    Min = 0
    Max = 100
    TabOrder = 9
  end
  object PrintDialog: TPrintDialog
    Left = 16
    Top = 8
  end
end
