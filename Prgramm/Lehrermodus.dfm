object Lehrer: TLehrer
  Left = 272
  Top = 218
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Lehrer'
  ClientHeight = 525
  ClientWidth = 784
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClick = FormClick
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object LblSpielzeit: TLabel
    Left = 24
    Top = 96
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
    Left = 32
    Top = 192
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
    Left = 344
    Top = 96
    Width = 337
    Height = 62
    AutoSelect = False
    Color = clBlack
    Ctl3D = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -40
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    HideSelection = False
    MaxLength = 15
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    Text = 'IP-Adresse'
    Visible = False
    OnChange = EdtIPChange
    OnClick = EdtIPClick
    OnKeyDown = EdtIPKeyDown
  end
  object GBLehreranmeldung: TGroupBox
    Left = 216
    Top = 169
    Width = 400
    Height = 240
    Caption = '                Verbinden                '
    Color = clWhite
    Ctl3D = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -27
    Font.Name = 'Comic Sans MS'
    Font.Style = []
    ParentColor = False
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 1
    OnMouseMove = GBLehreranmeldungMouseMove
    object ShpSenden: TShape
      Left = 208
      Top = 184
      Width = 177
      Height = 41
      Cursor = crHandPoint
      Shape = stRoundRect
    end
    object LblSenden: TLabel
      Left = 232
      Top = 185
      Width = 128
      Height = 38
      Cursor = crHandPoint
      Caption = 'Verbinden'
      Transparent = True
      OnMouseDown = LblSendenMouseDown
      OnMouseMove = LblSendenMouseMove
      OnMouseUp = LblSendenMouseUp
    end
    object ShpZurueckL: TShape
      Left = 16
      Top = 184
      Width = 177
      Height = 41
      Cursor = crHandPoint
      Shape = stRoundRect
    end
    object LblZurueckL: TLabel
      Left = 61
      Top = 184
      Width = 89
      Height = 38
      Cursor = crHandPoint
      Alignment = taCenter
      Caption = 'Zurück'
      Transparent = True
      OnMouseDown = LblZurueckLMouseDown
      OnMouseMove = LblZurueckLMouseMove
      OnMouseUp = LblZurueckLMouseUp
    end
    object EdtVornameL: TEdit
      Left = 16
      Top = 56
      Width = 265
      Height = 34
      AutoSelect = False
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -20
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 0
      Text = 'Vorname'
      OnChange = EdtVornameLChange
      OnClick = EdtVornameLClick
      OnKeyPress = EdtVornameLKeyPress
    end
    object EdtNameL: TEdit
      Left = 16
      Top = 96
      Width = 265
      Height = 34
      AutoSelect = False
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -20
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 1
      Text = 'Name'
      OnChange = EdtNameLChange
      OnClick = EdtNameLClick
      OnKeyPress = EdtNameLKeyPress
    end
    object STLoescheVornameL: TStaticText
      Left = 290
      Top = 50
      Width = 26
      Height = 39
      Cursor = crHandPoint
      AutoSize = False
      Caption = 'X'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -31
      Font.Name = 'Comic Sans MS'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnMouseDown = STLoescheVornameLMouseDown
      OnMouseUp = STLoescheVornameLMouseUp
    end
    object STLoescheNameL: TStaticText
      Left = 290
      Top = 90
      Width = 26
      Height = 39
      Cursor = crHandPoint
      AutoSize = False
      Caption = 'X'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -31
      Font.Name = 'Comic Sans MS'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
      OnMouseDown = STLoescheNameLMouseDown
      OnMouseUp = STLoescheNameLMouseUp
    end
    object EdtIPV: TEdit
      Left = 16
      Top = 136
      Width = 265
      Height = 34
      AutoSelect = False
      Color = clSilver
      Font.Charset = ANSI_CHARSET
      Font.Color = clGray
      Font.Height = -20
      Font.Name = 'Comic Sans MS'
      Font.Style = []
      MaxLength = 20
      ParentFont = False
      TabOrder = 4
      Text = 'IP-Adresse'
      OnChange = EdtIPVChange
      OnClick = EdtIPVClick
    end
    object STLoescheIP: TStaticText
      Left = 290
      Top = 130
      Width = 26
      Height = 39
      Cursor = crHandPoint
      AutoSize = False
      Caption = 'X'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -31
      Font.Name = 'Comic Sans MS'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnMouseDown = STLoescheIPMouseDown
      OnMouseUp = STLoescheIPMouseUp
    end
  end
  object CSSenden: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 8080
    OnConnect = CSSendenConnect
    OnDisconnect = CSSendenDisconnect
    OnRead = CSSendenRead
    OnError = CSSendenError
    Left = 72
    Top = 24
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
  object VerbindenTimer: TTimer
    Enabled = False
    Interval = 1
    OnTimer = VerbindenTimerTimer
    Left = 536
    Top = 184
  end
end
