object Menue: TMenue
  Left = 215
  Top = 162
  Align = alClient
  BorderStyle = bsNone
  ClientHeight = 536
  ClientWidth = 971
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnMouseDown = FormMouseDown
  OnMouseMove = FormMouseMove
  OnMouseUp = FormMouseUp
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object ImageScreen: TImage
    Left = 528
    Top = 128
    Width = 105
    Height = 105
    Stretch = True
  end
  object MenueEffekt: TTimer
    Interval = 1
    OnTimer = MenueEffektTimer
    Left = 888
    Top = 64
  end
  object Zoomen: TTimer
    Interval = 1
    OnTimer = ZoomenTimer
    Left = 848
    Top = 64
  end
end
