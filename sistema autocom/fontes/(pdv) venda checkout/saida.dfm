object Fsai: TFsai
  Left = 148
  Top = 132
  Cursor = -1
  BorderIcons = [biSystemMenu]
  BorderStyle = bsNone
  Caption = 'Sistema Autocom - Venda'
  ClientHeight = 200
  ClientWidth = 430
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 430
    Height = 200
    Cursor = -1
    Align = alClient
    BevelInner = bvRaised
    BevelOuter = bvLowered
    BevelWidth = 5
    BorderWidth = 5
    BorderStyle = bsSingle
    Color = clSilver
    Ctl3D = True
    ParentCtl3D = False
    TabOrder = 0
    object Label1: TLabel
      Left = 24
      Top = 56
      Width = 382
      Height = 32
      Caption = '0 - Continua na tela de venda'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 24
      Top = 96
      Width = 365
      Height = 32
      Caption = '1 - Voltar ao menu principal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 24
      Top = 136
      Width = 280
      Height = 32
      Caption = '2 - Desliga o terminal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -27
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 24
      Top = 24
      Width = 277
      Height = 24
      Caption = 'Digite uma das op'#231#227'o abaixo:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -19
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 376
      Top = 152
      Width = 17
      Height = 21
      BorderStyle = bsNone
      Color = clSilver
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMoneyGreen
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyPress = Edit1KeyPress
    end
  end
  object XPMenu1: TXPMenu
    DimLevel = 30
    GrayLevel = 10
    Font.Charset = ANSI_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Color = clBtnFace
    DrawMenuBar = False
    IconBackColor = clBtnFace
    MenuBarColor = clBtnFace
    SelectColor = clHighlight
    SelectBorderColor = clHighlight
    SelectFontColor = clMenuText
    DisabledColor = clInactiveCaption
    SeparatorColor = clBtnFace
    CheckedColor = clHighlight
    IconWidth = 24
    DrawSelect = True
    UseSystemColors = True
    UseDimColor = False
    OverrideOwnerDraw = False
    Gradient = True
    FlatMenu = False
    AutoDetect = True
    Active = True
    Left = 576
    Top = 384
  end
end
