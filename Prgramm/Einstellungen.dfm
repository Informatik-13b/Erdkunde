object Profil: TProfil
  Left = 215
  Top = 175
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Profil'
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
  object ShpHintergrund1: TShape
    Left = 72
    Top = 72
    Width = 65
    Height = 65
    Pen.Style = psClear
    OnMouseMove = FormMouseMove
  end
  object Maskottchen: TLabel
    Left = 80
    Top = 408
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
  end
  object ShpHintergrund2: TShape
    Left = 88
    Top = 256
    Width = 65
    Height = 65
    Pen.Style = psClear
    OnMouseMove = FormMouseMove
  end
  object ListBoxAuswahl: TListBox
    Left = 320
    Top = 72
    Width = 121
    Height = 97
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ItemHeight = 28
    ParentFont = False
    TabOrder = 0
    OnClick = ListBoxAuswahlClick
  end
  object StringGridDaten: TStringGrid
    Left = 496
    Top = 64
    Width = 489
    Height = 249
    DefaultColWidth = 80
    DefaultRowHeight = 30
    TabOrder = 1
  end
end
