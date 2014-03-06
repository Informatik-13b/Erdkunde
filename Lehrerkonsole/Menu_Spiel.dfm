object FormSpiel: TFormSpiel
  Left = 314
  Top = 157
  Width = 1190
  Height = 662
  Caption = 'FormSpiel'
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
    Left = 424
    Top = 16
    Width = 192
    Height = 45
    Caption = 'Spiel-Modus'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -37
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StringGridAuswahl: TStringGrid
    Left = 32
    Top = 80
    Width = 353
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
    Left = 576
    Top = 80
    Width = 569
    Height = 489
    DefaultColWidth = 40
    DefaultRowHeight = 32
    Enabled = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goRowSelect]
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
  object ProgressBarZeit: TProgressBar
    Left = 32
    Top = 584
    Width = 833
    Height = 25
    Min = 0
    Max = 100
    TabOrder = 2
  end
  object BtnAktion: TButton
    Left = 392
    Top = 384
    Width = 105
    Height = 33
    Caption = 'BtnAktion'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    OnClick = BtnAktionClick
  end
  object BtnCopy: TButton
    Left = 392
    Top = 536
    Width = 105
    Height = 33
    Caption = 'BtnCopy'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = BtnCopyClick
  end
  object BtnAuto: TButton
    Left = 392
    Top = 432
    Width = 105
    Height = 33
    Caption = 'BtnAuto'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 5
  end
  object BtnAbbrechen: TButton
    Left = 392
    Top = 480
    Width = 105
    Height = 33
    Caption = 'BtnAbbrechen'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = BtnAbbrechenClick
  end
  object TimerZeit: TTimer
    Enabled = False
    Interval = 1005
    OnTimer = TimerZeitTimer
    Left = 16
    Top = 16
  end
end
