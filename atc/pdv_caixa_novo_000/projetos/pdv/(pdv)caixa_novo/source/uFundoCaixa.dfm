object frmFundoCaixa: TfrmFundoCaixa
  Left = 323
  Top = 230
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Sistema Autocom'
  ClientHeight = 231
  ClientWidth = 217
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 217
    Height = 231
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvNone
    ParentColor = True
    TabOrder = 0
    object spdVolta: TSpeedButton
      Left = 11
      Top = 128
      Width = 194
      Height = 42
      Cursor = crHandPoint
      Caption = '[ESC] - Volta'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spdVoltaClick
    end
    object spdConfirma: TSpeedButton
      Left = 11
      Top = 178
      Width = 194
      Height = 42
      Cursor = crHandPoint
      Caption = '[ENTER] - Confirma'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spdConfirmaClick
    end
    object Panel2: TPanel
      Left = 12
      Top = 11
      Width = 192
      Height = 111
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      DesignSize = (
        192
        111)
      object Label8: TLabel
        Left = 8
        Top = 4
        Width = 176
        Height = 21
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'Fundo de Caixa'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 8
        Top = 36
        Width = 176
        Height = 21
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Caption = 'Informe o Valor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -19
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object mskValor: TMaskEdit
        Left = 18
        Top = 66
        Width = 157
        Height = 31
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        BevelOuter = bvRaised
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        Text = '0,00'
        OnEnter = mskValorEnter
        OnKeyDown = mskValorKeyDown
        OnKeyPress = mskValorKeyPress
      end
    end
  end
end
