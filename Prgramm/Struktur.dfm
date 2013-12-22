object Menue: TMenue
  Left = 206
  Top = 161
  Align = alClient
  BorderStyle = bsNone
  ClientHeight = 557
  ClientWidth = 1018
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
