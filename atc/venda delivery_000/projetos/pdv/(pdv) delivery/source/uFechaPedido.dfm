object frmFechaFaturamento: TfrmFechaFaturamento
  Left = 293
  Top = 43
  ActiveControl = mskAcrescimo
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Totais do pedido'
  ClientHeight = 551
  ClientWidth = 562
  Color = clMoneyGreen
  Constraints.MaxHeight = 600
  Constraints.MaxWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  DesignSize = (
    562
    551)
  PixelsPerInch = 96
  TextHeight = 13
  object spdVoltar: TSpeedButton
    Left = 10
    Top = 519
    Width = 272
    Height = 31
    Cursor = crHandPoint
    Action = Action1
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object spdEnviar: TSpeedButton
    Left = 290
    Top = 519
    Width = 272
    Height = 31
    Cursor = crHandPoint
    Action = Action2
    Anchors = [akLeft]
    BiDiMode = bdLeftToRight
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -15
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    ParentBiDiMode = False
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 562
    Height = 257
    Align = alTop
    Caption = 'Condi'#231#245'es de pagamento'
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Panel1: TPanel
      Left = 2
      Top = 18
      Width = 558
      Height = 237
      Align = alClient
      BevelInner = bvLowered
      Color = clMoneyGreen
      TabOrder = 0
      object lbFormaPagamentos: TTreeView
        Left = 2
        Top = 2
        Width = 319
        Height = 233
        Cursor = crHandPoint
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrack = True
        Indent = 19
        ParentFont = False
        ReadOnly = True
        RowSelect = True
        ShowLines = False
        ShowRoot = False
        TabOrder = 0
        OnChange = lbFormaPagamentosChange
        OnClick = lbFormaPagamentosClick
        OnEnter = memObsEnter
        OnExit = memObsExit
        OnKeyDown = lbFormaPagamentosKeyDown
      end
      object Panel2: TPanel
        Left = 363
        Top = 2
        Width = 193
        Height = 233
        Align = alRight
        Alignment = taLeftJustify
        BevelInner = bvLowered
        BevelOuter = bvLowered
        Color = clSkyBlue
        TabOrder = 1
        object Panel3: TPanel
          Left = 4
          Top = 8
          Width = 185
          Height = 217
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Color = clSkyBlue
          TabOrder = 0
          object Label3: TLabel
            Left = 5
            Top = 5
            Width = 132
            Height = 16
            Caption = 'N'#250'mero de parcelas:'
          end
          object Label4: TLabel
            Left = 5
            Top = 77
            Width = 173
            Height = 16
            Caption = 'Intervalo entre as parcelas:'
          end
          object Label5: TLabel
            Left = 5
            Top = 151
            Width = 163
            Height = 16
            Caption = 'Data da primeira parcela:'
          end
          object lblParcelas: TLabel
            Left = 10
            Top = 24
            Width = 20
            Height = 16
            Caption = '     '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsItalic]
            ParentFont = False
          end
          object lblDataPrimeira: TLabel
            Left = 10
            Top = 168
            Width = 20
            Height = 16
            Caption = '     '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsItalic]
            ParentFont = False
          end
          object lblIntervalo: TLabel
            Left = 10
            Top = 96
            Width = 24
            Height = 16
            Caption = '      '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsItalic]
            ParentFont = False
          end
        end
      end
    end
  end
  object Panel_valor: TPanel
    Left = 0
    Top = 257
    Width = 562
    Height = 259
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clSkyBlue
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 2
      Top = 112
      Width = 558
      Height = 49
      Align = alTop
      Caption = 'Peso total do pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 1
      object Label7: TLabel
        Left = 312
        Top = 18
        Width = 92
        Height = 19
        Caption = 'Peso Bruto:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 13
        Top = 20
        Width = 107
        Height = 19
        Caption = 'Peso L'#237'quido:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPesoLiquido: TLabel
        Left = 137
        Top = 20
        Width = 122
        Height = 19
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,000'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPesobruto: TLabel
        Left = 436
        Top = 18
        Width = 122
        Height = 19
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,000'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object GroupBox3: TGroupBox
      Left = 2
      Top = 2
      Width = 558
      Height = 110
      Align = alTop
      Caption = ' Totais '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
      object Label2: TLabel
        Left = 11
        Top = 29
        Width = 119
        Height = 19
        Caption = '(+) Acr'#233'scimos:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label18: TLabel
        Left = 11
        Top = 57
        Width = 108
        Height = 19
        Caption = '(-) Descontos:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 11
        Top = 83
        Width = 44
        Height = 19
        Caption = 'Total:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotalCupom: TLabel
        Left = 85
        Top = 83
        Width = 160
        Height = 19
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Shape1: TShape
        Left = 8
        Top = 79
        Width = 240
        Height = 3
        Brush.Color = clRed
      end
      object Label13: TLabel
        Left = 378
        Top = 7
        Width = 77
        Height = 19
        Caption = 'Descri'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edOBSAcrescimo: TEdit
        Left = 309
        Top = 27
        Width = 223
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsItalic]
        MaxLength = 100
        ParentFont = False
        TabOrder = 1
      end
      object edOBSDesconto: TEdit
        Left = 309
        Top = 55
        Width = 223
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        MaxLength = 100
        ParentFont = False
        TabOrder = 3
      end
      object mskDesconto: TEdit
        Left = 144
        Top = 55
        Width = 101
        Height = 21
        AutoSize = False
        BevelOuter = bvRaised
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MaxLength = 15
        ParentFont = False
        TabOrder = 2
        OnExit = mskDescontoExit
        OnKeyPress = mskAcrescimoKeyPress
      end
      object mskAcrescimo: TEdit
        Left = 144
        Top = 27
        Width = 101
        Height = 21
        AutoSize = False
        BevelOuter = bvRaised
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MaxLength = 15
        ParentFont = False
        TabOrder = 0
        OnExit = mskDescontoExit
        OnKeyPress = mskAcrescimoKeyPress
      end
    end
    object GroupBox4: TGroupBox
      Left = 2
      Top = 161
      Width = 558
      Height = 96
      Align = alClient
      TabOrder = 2
      object Label9: TLabel
        Left = 2
        Top = 15
        Width = 554
        Height = 19
        Align = alTop
        Caption = 'Observa'#231#245'es:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object memObs: TMemo
        Left = 2
        Top = 34
        Width = 554
        Height = 60
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
        OnEnter = memObsEnter
        OnExit = memObsExit
      end
    end
  end
  object ActionManager: TActionManager
    Left = 456
    Top = 384
    StyleName = 'XP Style'
    object Action1: TAction
      Category = 'funcoes'
      Caption = '[F11] - Voltar'
      ShortCut = 122
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Category = 'funcoes'
      Caption = '[F12] - Enviar para faturamento'
      ShortCut = 123
      OnExecute = Action2Execute
    end
  end
end
