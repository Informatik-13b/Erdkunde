object FLexikon: TFLexikon
  Left = 318
  Top = 188
  VertScrollBar.Smooth = True
  VertScrollBar.Size = 10
  Align = alClient
  BorderStyle = bsNone
  Caption = 'FLexikon'
  ClientHeight = 524
  ClientWidth = 1008
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
  object ShpHintergrund2: TShape
    Left = 88
    Top = 256
    Width = 65
    Height = 65
    Pen.Style = psClear
    OnMouseMove = FormMouseMove
  end
  object ShpHintergrund1: TShape
    Left = 96
    Top = 144
    Width = 65
    Height = 65
    Pen.Style = psClear
    OnMouseMove = FormMouseMove
  end
  object LblStichwort: TLabel
    Left = 88
    Top = 64
    Width = 166
    Height = 38
    Caption = 'LblStichwort'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    OnMouseMove = FormMouseMove
  end
  object LBStichwoerter: TListBox
    Left = 312
    Top = 200
    Width = 121
    Height = 84
    Cursor = crHandPoint
    TabStop = False
    BorderStyle = bsNone
    Columns = 2
    Ctl3D = False
    ExtendedSelect = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    IntegralHeight = True
    ItemHeight = 28
    ParentCtl3D = False
    ParentFont = False
    Sorted = True
    TabOrder = 0
    OnClick = LBStichwoerterClick
    OnMouseMove = FormMouseMove
  end
  object REdtDatei: TRichEdit
    Left = 712
    Top = 136
    Width = 185
    Height = 89
    TabStop = False
    Lines.Strings = (
      'REdtDatei')
    TabOrder = 1
    Visible = False
    WordWrap = False
  end
  object MText: TRichEdit
    Left = 296
    Top = 24
    Width = 185
    Height = 89
    TabStop = False
    BorderStyle = bsNone
    BorderWidth = 5
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentCtl3D = False
    ParentFont = False
    PlainText = True
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 2
    WantReturns = False
    OnMouseMove = FormMouseMove
  end
  object TMaskottchen: TTimer
    Interval = 200
    OnTimer = TMaskottchenTimer
    Left = 32
    Top = 40
  end
end
