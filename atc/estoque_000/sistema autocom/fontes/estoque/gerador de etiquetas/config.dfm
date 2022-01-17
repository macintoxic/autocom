object FrmConfig: TFrmConfig
  Left = 238
  Top = 334
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Configura'#231#245'es'
  ClientHeight = 138
  ClientWidth = 299
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object LblImpressora: TLabel
    Left = 16
    Top = 56
    Width = 67
    Height = 15
    Caption = 'Impressora:'
  end
  object Label1: TLabel
    Left = 16
    Top = 23
    Width = 129
    Height = 15
    Caption = 'Porta de Comunica'#231#227'o:'
  end
  object BitBtn1: TBitBtn
    Left = 96
    Top = 104
    Width = 113
    Height = 25
    TabOrder = 0
    OnClick = BitBtn1Click
    Kind = bkOK
  end
  object CmbPorta: TComboBox
    Left = 152
    Top = 19
    Width = 129
    Height = 23
    Cursor = crHandPoint
    ItemHeight = 15
    TabOrder = 1
    Items.Strings = (
      'COM1'
      'COM2'
      'COM3'
      'COM4'
      'COM5'
      'COM6'
      'COM7'
      'COM8'
      'LPT1'
      'LPT2')
  end
  object CmbImpressora: TComboBox
    Left = 102
    Top = 56
    Width = 179
    Height = 23
    Cursor = crHandPoint
    ItemHeight = 15
    TabOrder = 2
    Items.Strings = (
      '01 - ZEBRA TLP 2742'
      '02 - ARGOX')
  end
  object XPMenu: TXPMenu
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
    Gradient = False
    FlatMenu = False
    AutoDetect = True
    Active = True
    Left = 256
    Top = 88
  end
end
