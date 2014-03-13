object FormKlasseLoschen: TFormKlasseLoschen
  Left = 586
  Top = 211
  Width = 308
  Height = 415
  BorderIcons = [biSystemMenu]
  Caption = 'Klasse -Löschen'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 32
    Top = 16
    Width = 226
    Height = 36
    Caption = 'Klasse Löschen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -31
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object StringGridKlassenAuswahl: TStringGrid
    Left = 32
    Top = 72
    Width = 233
    Height = 185
    ColCount = 2
    DefaultColWidth = 40
    DefaultRowHeight = 35
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ParentFont = False
    TabOrder = 0
    OnSelectCell = StringGridKlassenAuswahlSelectCell
    ColWidths = (
      40
      180)
  end
  object BtnAbbrechen: TButton
    Left = 24
    Top = 328
    Width = 249
    Height = 33
    Caption = 'BtnAbbrechen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = BtnAbbrechenClick
  end
  object BtnLoschen: TButton
    Left = 24
    Top = 272
    Width = 249
    Height = 33
    Caption = 'BtnLoschen'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = BtnLoschenClick
  end
end
