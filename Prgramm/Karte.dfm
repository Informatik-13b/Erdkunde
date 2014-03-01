object Orte_Finden: TOrte_Finden
  Left = 391
  Top = 239
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Orte_Finden'
  ClientHeight = 525
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnMouseMove = FormMouseMove
  PixelsPerInch = 96
  TextHeight = 13
  object ShpHintergrund1: TShape
    Left = 112
    Top = 40
    Width = 65
    Height = 65
    Pen.Style = psClear
    OnMouseMove = ShpHintergrund1MouseMove
  end
  object LblUeberschrift: TLabel
    Left = 200
    Top = 40
    Width = 121
    Height = 16
    Caption = 'Wo liegt eigentlich...?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Maskottchen: TLabel
    Left = 200
    Top = 288
    Width = 413
    Height = 38
    Caption = 'Platzhalter für das Maskottchen'
    Color = clAppWorkSpace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object LblStadt: TLabel
    Left = 224
    Top = 112
    Width = 46
    Height = 16
    Caption = 'LblStadt'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object LblSchwierigkeit: TLabel
    Left = 224
    Top = 144
    Width = 87
    Height = 16
    Caption = 'LblSchwierigkeit'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object LblPunkte: TLabel
    Left = 224
    Top = 184
    Width = 51
    Height = 16
    Caption = 'LblPunkte'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object LblEntfernung: TLabel
    Left = 224
    Top = 208
    Width = 75
    Height = 16
    Caption = 'LblEntfernung'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object Lblverbleibend: TLabel
    Left = 112
    Top = 112
    Width = 76
    Height = 16
    Caption = 'Lblverbleibend'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentFont = False
    Transparent = True
  end
  object BtnNeu: TButton
    Left = 552
    Top = 336
    Width = 75
    Height = 25
    Caption = 'Neu'
    TabOrder = 0
    OnClick = BtnNeuClick
  end
  object BtnWeiter: TButton
    Left = 632
    Top = 336
    Width = 75
    Height = 25
    Caption = 'Weiter'
    Enabled = False
    TabOrder = 1
    OnClick = BtnWeiterClick
  end
  object pruefenTimer: TTimer
    Interval = 1
    OnTimer = pruefenTimerTimer
    Left = 704
    Top = 24
  end
end
