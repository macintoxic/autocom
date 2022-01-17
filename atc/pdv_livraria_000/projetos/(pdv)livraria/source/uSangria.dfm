object frmSangria: TfrmSangria
  Left = 255
  Top = 217
  ActiveControl = mskValor
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Sistema Autocom - Sangria'
  ClientHeight = 230
  ClientWidth = 379
  Color = clMoneyGreen
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 379
    Height = 230
    Align = alClient
    BevelInner = bvLowered
    ParentColor = True
    TabOrder = 0
    object spdVoltar: TSpeedButton
      Left = 197
      Top = 137
      Width = 177
      Height = 42
      Cursor = crHandPoint
      Caption = '[ESC] - Volta'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spdVoltarClick
    end
    object spdConfirma: TSpeedButton
      Left = 197
      Top = 185
      Width = 177
      Height = 42
      Cursor = crHandPoint
      Caption = '[ENTER] - Confirma'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -15
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = spdConfirmaClick
    end
    object lbFormaPagamentos: TTreeView
      Left = 2
      Top = 2
      Width = 191
      Height = 226
      Cursor = crHandPoint
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Indent = 19
      ParentFont = False
      ShowLines = False
      TabOrder = 0
      OnClick = lbFormaPagamentosClick
      OnEnter = lbFormaPagamentosEnter
      OnExit = lbFormaPagamentosExit
      OnKeyDown = lbFormaPagamentosKeyDown
    end
    object Panel2: TPanel
      Left = 196
      Top = 4
      Width = 177
      Height = 130
      BevelInner = bvLowered
      BevelOuter = bvLowered
      Color = clSkyBlue
      TabOrder = 1
      object lblNome: TLabel
        Left = 8
        Top = 9
        Width = 161
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = ' - '
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 8
        Top = 33
        Width = 161
        Height = 16
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
      object Label2: TLabel
        Left = 8
        Top = 89
        Width = 161
        Height = 16
        Alignment = taCenter
        AutoSize = False
        Caption = 'Motivo'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object mskValor: TMaskEdit
        Left = 9
        Top = 50
        Width = 160
        Height = 21
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
        OnKeyPress = mskValorKeyPress
      end
      object edMotivo: TEdit
        Left = 8
        Top = 104
        Width = 161
        Height = 21
        CharCase = ecUpperCase
        MaxLength = 39
        TabOrder = 1
        OnKeyDown = edMotivoKeyDown
      end
    end
  end
end
