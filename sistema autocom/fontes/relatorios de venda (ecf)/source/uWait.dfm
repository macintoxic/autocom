object fWait: TfWait
  Left = 251
  Top = 286
  Cursor = crHourGlass
  HelpType = htKeyword
  AlphaBlend = True
  AlphaBlendValue = 200
  BorderStyle = bsNone
  Caption = 'Processando'
  ClientHeight = 125
  ClientWidth = 232
  Color = 13003057
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object PanWait: TPanel
    Left = 0
    Top = 0
    Width = 232
    Height = 125
    Cursor = crHourGlass
    Align = alClient
    BevelInner = bvSpace
    BevelOuter = bvLowered
    ParentColor = True
    TabOrder = 0
    object LblWait: TLabel
      Left = 2
      Top = 2
      Width = 228
      Height = 121
      Cursor = crHourGlass
      Align = alClient
      Alignment = taCenter
      Caption = 'Aguarde...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -29
      Font.Name = 'Arial Black'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
    end
  end
end
