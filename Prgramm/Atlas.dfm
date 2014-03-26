object Karten: TKarten
  Left = 442
  Top = 208
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Karten'
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
  object LblUeberschrift: TLabel
    Left = 560
    Top = 56
    Width = 207
    Height = 38
    Caption = 'LblUeberschrift'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentFont = False
  end
  object ImgKarte: TImage
    Left = 576
    Top = 168
    Width = 105
    Height = 105
    Cursor = crHandPoint
    ParentShowHint = False
    ShowHint = False
    Stretch = True
    OnClick = ImgKarteClick
    OnMouseMove = FormMouseMove
  end
  object LBRegion: TListBox
    Left = 200
    Top = 104
    Width = 121
    Height = 97
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ItemHeight = 28
    Items.Strings = (
      'Afrika'
      'Asien'
      'Australien'
      'Deutschland'
      'Europa'
      'Nordamerika'
      'Südamerika')
    ParentCtl3D = False
    ParentFont = False
    Sorted = True
    TabOrder = 0
    OnClick = LBKartenTypClick
    OnMouseMove = FormMouseMove
  end
  object LBKartenTyp: TListBox
    Left = 336
    Top = 112
    Width = 121
    Height = 97
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ItemHeight = 28
    Items.Strings = (
      'Politik'
      'Relief'
      'Satellit')
    ParentCtl3D = False
    ParentFont = False
    Sorted = True
    TabOrder = 1
    OnClick = LBKartenTypClick
    OnMouseMove = FormMouseMove
  end
  object TMaskottchen: TTimer
    Interval = 200
    OnTimer = TMaskottchenTimer
    Left = 32
    Top = 40
  end
end
