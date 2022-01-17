object frmFechaECF: TfrmFechaECF
  Left = 335
  Top = 54
  HelpContext = 100
  ActiveControl = lbFormaPagamentos
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Sistema Autocom'
  ClientHeight = 511
  ClientWidth = 435
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 435
    Height = 73
    HelpContext = 101
    Align = alTop
    Caption = ' VALOR TOTAL '
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object lblTotalCupom: TLabel
      Left = 2
      Top = 26
      Width = 431
      Height = 45
      HelpContext = 102
      Align = alClient
      Alignment = taRightJustify
      Caption = '0,00'
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -40
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
  end
  object gbReceber: TGroupBox
    Left = 0
    Top = 438
    Width = 435
    Height = 73
    HelpContext = 103
    Align = alBottom
    Caption = ' A RECEBER '
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 1
    object lblFalta: TLabel
      Left = 2
      Top = 26
      Width = 431
      Height = 45
      HelpContext = 104
      Align = alClient
      Alignment = taRightJustify
      Caption = '0,00'
      Color = clMoneyGreen
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -40
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 73
    Width = 435
    Height = 365
    HelpContext = 105
    Align = alClient
    BevelInner = bvLowered
    Color = clMoneyGreen
    TabOrder = 2
    object spdVoltar: TSpeedButton
      Left = 262
      Top = 279
      Width = 169
      Height = 33
      HelpContext = 106
      Caption = '[ESC] - Voltar'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -17
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spdVoltarClick
    end
    object Panel2: TPanel
      Left = 262
      Top = 189
      Width = 169
      Height = 89
      HelpContext = 107
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clSkyBlue
      TabOrder = 0
      object lblFormaFaturamento: TLabel
        Left = 2
        Top = 2
        Width = 165
        Height = 16
        HelpContext = 108
        Align = alTop
        Alignment = taCenter
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        WordWrap = True
      end
      object Label9: TLabel
        Left = 16
        Top = 33
        Width = 137
        Height = 16
        HelpContext = 109
        Alignment = taCenter
        AutoSize = False
        Caption = 'Informe o Valor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object mskValor: TMaskEdit
        Left = 25
        Top = 60
        Width = 118
        Height = 21
        HelpContext = 110
        AutoSize = False
        BevelOuter = bvRaised
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        OnExit = mskValorExit
        OnKeyDown = mskValorKeyDown
        OnKeyPress = mskValorKeyPress
      end
    end
    object lbFormaPagamentos: TTreeView
      Left = 2
      Top = 137
      Width = 255
      Height = 226
      Cursor = crHandPoint
      HelpContext = 111
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      HotTrack = True
      Indent = 19
      MultiSelectStyle = []
      ParentFont = False
      ReadOnly = True
      RowSelect = True
      ShowButtons = False
      ShowLines = False
      TabOrder = 1
      OnChange = lbFormaPagamentosChange
      OnKeyDown = lbFormaPagamentosKeyDown
    end
    object Panel3: TPanel
      Left = 2
      Top = 2
      Width = 431
      Height = 135
      HelpContext = 112
      Align = alTop
      Color = clMoneyGreen
      TabOrder = 2
      object pnlModificador: TPanel
        Left = 280
        Top = 58
        Width = 142
        Height = 69
        HelpContext = 113
        BevelInner = bvLowered
        BevelOuter = bvLowered
        Color = clSkyBlue
        TabOrder = 0
        Visible = False
        object lblModificador: TLabel
          Left = 2
          Top = 2
          Width = 138
          Height = 16
          HelpContext = 114
          Align = alTop
          Alignment = taCenter
          Font.Charset = ANSI_CHARSET
          Font.Color = clNavy
          Font.Height = -13
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object mskModificadores: TMaskEdit
          Left = 12
          Top = 39
          Width = 118
          Height = 21
          HelpContext = 115
          AutoSize = False
          BevelOuter = bvRaised
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          TabOrder = 0
          Text = '0,00'
          OnExit = mskValorExit
          OnKeyDown = mskModificadoresKeyDown
          OnKeyPress = mskValorKeyPress
        end
      end
      object pnlModificadores: TPanel
        Left = 1
        Top = 1
        Width = 272
        Height = 133
        HelpContext = 116
        Align = alLeft
        BevelOuter = bvNone
        Color = clMoneyGreen
        TabOrder = 1
        object spdAcrescimoValor: TSpeedButton
          Tag = 1
          Left = 4
          Top = 3
          Width = 265
          Height = 25
          Cursor = crHandPoint
          HelpContext = 117
          Caption = '[F1] - Acr'#233'scimo em valor'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = spdAcrescimoValorClick
        end
        object spdAcrescimoPercentual: TSpeedButton
          Tag = 2
          Left = 4
          Top = 28
          Width = 265
          Height = 25
          Cursor = crHandPoint
          HelpContext = 118
          Caption = '[F2] - Acr'#233'scimo em percentual'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = spdAcrescimoValorClick
        end
        object spDescontoValor: TSpeedButton
          Tag = 3
          Left = 4
          Top = 53
          Width = 265
          Height = 25
          Cursor = crHandPoint
          HelpContext = 119
          Caption = '[F3] - Desconto em valor'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = spdAcrescimoValorClick
        end
        object spDescontoPercentual: TSpeedButton
          Tag = 4
          Left = 4
          Top = 78
          Width = 265
          Height = 25
          Cursor = crHandPoint
          HelpContext = 120
          Caption = '[F4] - Desconto em percentual'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = spdAcrescimoValorClick
        end
        object spCancelaVenda: TSpeedButton
          Tag = 5
          Left = 4
          Top = 104
          Width = 265
          Height = 25
          Cursor = crHandPoint
          HelpContext = 121
          Caption = '[F5] - Cancelamento da Venda'
          Flat = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clNavy
          Font.Height = -16
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          OnClick = spdAcrescimoValorClick
        end
      end
    end
  end
  object tmrFecha: TTimer
    Enabled = False
    Interval = 6000
    OnTimer = tmrFechaTimer
    Left = 280
    Top = 393
  end
  object tmrGaveta: TTimer
    Enabled = False
    OnTimer = tmrGavetaTimer
    Left = 360
    Top = 393
  end
end
