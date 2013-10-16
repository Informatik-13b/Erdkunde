object Menue: TMenue
  Left = 167
  Top = 207
  Align = alClient
  BorderStyle = bsNone
  ClientHeight = 536
  ClientWidth = 884
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Permanent Marker'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnMouseMove = FormMouseMove
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 15
  object ImageScreen: TImage
    Left = 528
    Top = 128
    Width = 105
    Height = 105
    Stretch = True
  end
  object MenueEffekt: TTimer
    Enabled = False
    Interval = 1
    OnTimer = MenueEffektTimer
    Left = 888
    Top = 64
  end
  object Zoomen: TTimer
    Enabled = False
    Interval = 1
    OnTimer = ZoomenTimer
    Left = 848
    Top = 64
  end
  object TimerStartscreen: TTimer
    Enabled = False
    Interval = 40
    OnTimer = TimerStartscreenTimer
    Left = 848
    Top = 112
  end
end
