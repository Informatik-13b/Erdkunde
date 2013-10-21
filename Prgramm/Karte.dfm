object Orte_Finden: TOrte_Finden
  Left = 318
  Top = 214
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Orte_Finden'
  ClientHeight = 525
  ClientWidth = 1072
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
  object Label1: TLabel
    Left = 16
    Top = 16
    Width = 84
    Height = 27
    Caption = 'Label1'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'MS Gothic'
    Font.Style = []
    ParentFont = False
  end
  object BtnNeu: TButton
    Left = 16
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Neu'
    TabOrder = 0
    OnClick = BtnNeuClick
  end
end
