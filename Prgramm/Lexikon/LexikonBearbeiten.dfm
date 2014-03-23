object Form1: TForm1
  Left = 193
  Top = 120
  Width = 1215
  Height = 680
  Caption = 'Form1'
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
    Left = 96
    Top = 16
    Width = 44
    Height = 13
    Caption = 'Stichwort'
  end
  object Label2: TLabel
    Left = 224
    Top = 16
    Width = 70
    Height = 13
    Caption = 'Text/Definition'
  end
  object Label3: TLabel
    Left = 16
    Top = 16
    Width = 25
    Height = 13
    Caption = 'index'
  end
  object Label4: TLabel
    Left = 8
    Top = 464
    Width = 32
    Height = 13
    Caption = 'Label4'
  end
  object EdtStichwort: TEdit
    Left = 96
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'EdtStichwort'
  end
  object EdtIndex: TEdit
    Left = 16
    Top = 32
    Width = 33
    Height = 21
    ReadOnly = True
    TabOrder = 1
    Text = 'EdtIndex'
  end
  object BtnErsetzen: TButton
    Left = 96
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Ersetzen'
    TabOrder = 2
    OnClick = BtnErsetzenClick
  end
  object BtnNeu: TButton
    Left = 16
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Neu'
    TabOrder = 3
    OnClick = BtnNeuClick
  end
  object BtnWeiter: TButton
    Left = 96
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Weiter'
    TabOrder = 4
    OnClick = BtnWeiterClick
  end
  object BtnZurueck: TButton
    Left = 16
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Zurück'
    TabOrder = 5
    OnClick = BtnZurueckClick
  end
  object BtnSpeichern: TButton
    Left = 96
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Speichern'
    Enabled = False
    TabOrder = 6
    OnClick = BtnSpeichernClick
  end
  object REdtText: TRichEdit
    Left = 224
    Top = 32
    Width = 313
    Height = 449
    ScrollBars = ssHorizontal
    TabOrder = 7
    WordWrap = False
  end
  object REdtKopie: TRichEdit
    Left = 544
    Top = 32
    Width = 617
    Height = 449
    Lines.Strings = (
      'RichEdit1')
    ScrollBars = ssBoth
    TabOrder = 8
    WordWrap = False
  end
end
