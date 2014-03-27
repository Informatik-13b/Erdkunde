object Orte_Finden: TOrte_Finden
  Left = 207
  Top = 277
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
  OnClose = FormClose
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
  object ShpWeiter: TShape
    Left = 56
    Top = 200
    Width = 65
    Height = 65
    Cursor = crHandPoint
    Pen.Width = 3
    Shape = stRoundRect
    OnMouseDown = ShpWeiterMouseDown
    OnMouseMove = LblWeiterMouseMove
  end
  object LblWeiter: TLabel
    Left = 72
    Top = 224
    Width = 104
    Height = 15
    Cursor = crHandPoint
    Caption = 'nächste Zufallsstadt'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    Transparent = True
    OnClick = LblWeiterClick
    OnMouseMove = LblWeiterMouseMove
  end
  object StrGrdOrte: TStringGrid
    Left = 15
    Top = 464
    Width = 186
    Height = 49
    BorderStyle = bsNone
    ColCount = 2
    Ctl3D = False
    FixedCols = 0
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    GridLineWidth = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    Visible = False
    RowHeights = (
      24
      24)
  end
  object pruefenTimer: TTimer
    Interval = 1
    OnTimer = pruefenTimerTimer
    Left = 704
    Top = 24
  end
  object TMaskottchen: TTimer
    Interval = 200
    OnTimer = TMaskottchenTimer
    Left = 32
    Top = 40
  end
end
