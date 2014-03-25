object Form1: TForm1
  Left = 266
  Top = 126
  Width = 544
  Height = 585
  Caption = 'Form1'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object BtnSchlafen: TButton
    Left = 56
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Schlafen'
    TabOrder = 0
    OnClick = BtnSchlafenClick
  end
  object BtnFreuen: TButton
    Left = 160
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Freuen'
    TabOrder = 1
    OnClick = BtnFreuenClick
  end
  object BtnTraurig: TButton
    Left = 264
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Traurig'
    TabOrder = 2
    OnClick = BtnTraurigClick
  end
  object BtnWeinen: TButton
    Left = 368
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Weinen'
    TabOrder = 3
    OnClick = BtnWeinenClick
  end
  object TMaskottchen: TTimer
    Interval = 200
    OnTimer = TMaskottchenTimer
    Left = 480
    Top = 24
  end
end
