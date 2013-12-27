object FLexikon: TFLexikon
  Left = 193
  Top = 225
  Align = alClient
  BorderStyle = bsNone
  Caption = 'FLexikon'
  ClientHeight = 525
  ClientWidth = 1071
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
  object ShpHintergrund2: TShape
    Left = 88
    Top = 256
    Width = 65
    Height = 65
    Pen.Style = psClear
    OnMouseMove = FormMouseMove
  end
  object ShpHintergrund1: TShape
    Left = 72
    Top = 72
    Width = 65
    Height = 65
    Pen.Style = psClear
    OnMouseMove = FormMouseMove
  end
  object Maskottchen: TLabel
    Left = 216
    Top = 144
    Width = 413
    Height = 38
    Caption = 'Platzhalter für das Maskottchen'
    Color = clGrayText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    OnMouseMove = FormMouseMove
  end
  object LblText: TLabel
    Left = 264
    Top = 56
    Width = 68
    Height = 26
    AutoSize = False
    Caption = 'LblText'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object LBStichwoerter: TListBox
    Left = 312
    Top = 200
    Width = 121
    Height = 97
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ItemHeight = 28
    ParentCtl3D = False
    ParentFont = False
    Sorted = True
    TabOrder = 0
    OnClick = LBStichwoerterClick
  end
  object REdtDatei: TRichEdit
    Left = 712
    Top = 136
    Width = 185
    Height = 89
    Lines.Strings = (
      'REdtDatei')
    TabOrder = 1
    Visible = False
  end
end
