object Form1: TForm1
  Left = 192
  Top = 124
  Width = 595
  Height = 563
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
    Left = 32
    Top = 32
    Width = 26
    Height = 13
    Caption = 'Index'
  end
  object Label2: TLabel
    Left = 72
    Top = 32
    Width = 14
    Height = 13
    Caption = 'Ort'
  end
  object Label3: TLabel
    Left = 296
    Top = 32
    Width = 61
    Height = 13
    Caption = 'X-Koordinate'
  end
  object Label4: TLabel
    Left = 376
    Top = 32
    Width = 61
    Height = 13
    Caption = 'Y-Koordinate'
  end
  object Label5: TLabel
    Left = 40
    Top = 112
    Width = 32
    Height = 13
    Caption = 'Label5'
  end
  object Label6: TLabel
    Left = 200
    Top = 32
    Width = 89
    Height = 13
    Caption = 'Schwierigkeitsgrad'
  end
  object EdtIndex: TEdit
    Left = 32
    Top = 48
    Width = 33
    Height = 21
    TabStop = False
    ReadOnly = True
    TabOrder = 0
    Text = '1'
  end
  object EdtOrt: TEdit
    Left = 72
    Top = 48
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Ort'
  end
  object EdtKoSy_x: TEdit
    Left = 296
    Top = 48
    Width = 73
    Height = 21
    TabOrder = 3
    Text = 'KoSy_x'
  end
  object EdtKoSy_y: TEdit
    Left = 376
    Top = 48
    Width = 73
    Height = 21
    TabOrder = 4
    Text = 'KoSy_y'
  end
  object BtnSpeichern: TButton
    Left = 480
    Top = 40
    Width = 75
    Height = 25
    Caption = 'Speichern'
    TabOrder = 5
    OnClick = BtnSpeichernClick
  end
  object BtnWeiter: TButton
    Left = 480
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Weiter'
    TabOrder = 6
    OnClick = BtnWeiterClick
  end
  object BtnZurueck: TButton
    Left = 480
    Top = 88
    Width = 75
    Height = 25
    Caption = 'Zurueck'
    TabOrder = 7
    OnClick = BtnZurueckClick
  end
  object BtnNeu: TButton
    Left = 480
    Top = 112
    Width = 75
    Height = 25
    Caption = 'Neu'
    TabOrder = 8
    OnClick = BtnNeuClick
  end
  object EdtSchwierigkeit: TEdit
    Left = 200
    Top = 48
    Width = 89
    Height = 21
    TabOrder = 2
    Text = 'Schwierigkeitsgrad'
  end
end
