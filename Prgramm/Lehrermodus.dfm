object Lehrer: TLehrer
  Left = 245
  Top = 248
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Lehrer'
  ClientHeight = 525
  ClientWidth = 1072
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClick = FormClick
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LblSpielzeit: TLabel
    Left = 72
    Top = 112
    Width = 224
    Height = 55
    Caption = 'LblSpielzeit'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -40
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object LblStatus: TLabel
    Left = 72
    Top = 168
    Width = 185
    Height = 55
    Caption = 'LblStauts'
    Color = clBlack
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -40
    Font.Name = 'Comic Sans MS'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
  end
  object EdtIP: TEdit
    Left = 392
    Top = 240
    Width = 241
    Height = 62
    AutoSelect = False
    Color = clBackground
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -40
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    HideSelection = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    Text = 'IP-Adresse'
    OnChange = EdtIPChange
    OnClick = EdtIPClick
    OnKeyDown = EdtIPKeyDown
  end
  object MIndex: TMemo
    Left = 392
    Top = 80
    Width = 57
    Height = 25
    Lines.Strings = (
      'MIndex')
    TabOrder = 1
    Visible = False
  end
  object CSSenden: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = CSSendenConnect
    OnRead = CSSendenRead
    OnError = CSSendenError
    Left = 128
    Top = 48
  end
  object Spielzeit: TTimer
    Enabled = False
    OnTimer = SpielzeitTimer
    Left = 24
    Top = 24
  end
  object pruefenTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = pruefenTimerTimer
    Left = 680
    Top = 16
  end
end
