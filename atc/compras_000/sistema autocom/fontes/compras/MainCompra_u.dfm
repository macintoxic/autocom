object fMainCompra: TfMainCompra
  Left = 176
  Top = 146
  Width = 752
  Height = 537
  Caption = 'Autocom PLUS - Compras'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Label16: TLabel
    Left = 11
    Top = 22
    Width = 107
    Height = 15
    Caption = 'Codigo da Compra:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label19: TLabel
    Left = 571
    Top = 14
    Width = 29
    Height = 15
    Caption = 'Data:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label23: TLabel
    Left = 267
    Top = -3
    Width = 138
    Height = 37
    Caption = 'Compras'
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -32
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    Transparent = True
    WordWrap = True
  end
  object F1: TLabel
    Left = 344
    Top = 488
    Width = 19
    Height = 19
    Caption = 'F1'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SpdConsCompra: TSpeedButton
    Left = 205
    Top = 16
    Width = 23
    Height = 22
    Flat = True
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333333333333333333FFF333333333333000333333333
      3333777FFF3FFFFF33330B000300000333337F777F777773F333000E00BFBFB0
      3333777F773333F7F333000E0BFBF0003333777F7F3337773F33000E0FBFBFBF
      0333777F7F3333FF7FFF000E0BFBF0000003777F7F3337777773000E0FBFBFBF
      BFB0777F7F33FFFFFFF7000E0BF000000003777F7FF777777773000000BFB033
      33337777773FF733333333333300033333333333337773333333333333333333
      3333333333333333333333333333333333333333333333333333333333333333
      3333333333333333333333333333333333333333333333333333}
    NumGlyphs = 2
    OnClick = SpdConsCompraClick
  end
  object Panel2: TPanel
    Left = 0
    Top = 40
    Width = 741
    Height = 73
    Align = alCustom
    BevelInner = bvLowered
    BevelOuter = bvLowered
    TabOrder = 0
    object Label6: TLabel
      Left = 5
      Top = 14
      Width = 107
      Height = 15
      Caption = 'Codigo do Produto:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LblProd: TLabel
      Left = 190
      Top = 14
      Width = 3
      Height = 15
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Left = 156
      Top = 47
      Width = 68
      Height = 15
      Caption = 'Quantidade:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label14: TLabel
      Left = 317
      Top = 47
      Width = 68
      Height = 15
      Caption = 'Preco Total:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label15: TLabel
      Left = 482
      Top = 47
      Width = 49
      Height = 15
      Caption = 'Unidade:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label21: TLabel
      Left = 550
      Top = 14
      Width = 122
      Height = 15
      Caption = 'Ultimo Fornecedor N'#186':'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object spdConsProd: TSpeedButton
      Left = 165
      Top = 8
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333333333333333333FFF333333333333000333333333
        3333777FFF3FFFFF33330B000300000333337F777F777773F333000E00BFBFB0
        3333777F773333F7F333000E0BFBF0003333777F7F3337773F33000E0FBFBFBF
        0333777F7F3333FF7FFF000E0BFBF0000003777F7F3337777773000E0FBFBFBF
        BFB0777F7F33FFFFFFF7000E0BF000000003777F7FF777777773000000BFB033
        33337777773FF733333333333300033333333333337773333333333333333333
        3333333333333333333333333333333333333333333333333333333333333333
        3333333333333333333333333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = spdConsProdClick
    end
    object Label25: TLabel
      Left = 7
      Top = 47
      Width = 62
      Height = 15
      Caption = 'Preco Unit:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtCodProd: TEdit
      Left = 112
      Top = 8
      Width = 49
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      OnEnter = edtCodProdEnter
      OnExit = edtCodProdExit
      OnKeyDown = edtCodProdKeyDown
      OnKeyPress = edtCodProdKeyPress
    end
    object edtQuant: TEdit
      Left = 232
      Top = 41
      Width = 73
      Height = 21
      TabOrder = 3
      OnEnter = edtQuantEnter
      OnExit = edtQuantExit
      OnKeyDown = edtFornKeyDown
    end
    object edtUnidade: TEdit
      Left = 532
      Top = 41
      Width = 45
      Height = 21
      TabOrder = 4
      OnKeyDown = edtFornKeyDown
    end
    object mskPrecoTot: TMaskEdit
      Left = 385
      Top = 41
      Width = 72
      Height = 21
      Enabled = False
      EditMask = '9999999999,99;0; '
      MaxLength = 13
      TabOrder = 5
      OnKeyDown = edtFornKeyDown
    end
    object edtForn: TEdit
      Left = 675
      Top = 8
      Width = 56
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      OnKeyDown = edtFornKeyDown
    end
    object MskPrecoUn: TMaskEdit
      Left = 70
      Top = 41
      Width = 72
      Height = 21
      EditMask = '9999999999,99;0; '
      MaxLength = 13
      TabOrder = 2
      OnKeyDown = edtFornKeyDown
    end
    object BtnInsProd: TBitBtn
      Left = 671
      Top = 43
      Width = 61
      Height = 20
      Caption = 'Inserir'
      TabOrder = 6
      OnClick = BtnInsProdClick
    end
  end
  object edtCodCompra: TEdit
    Left = 128
    Top = 16
    Width = 73
    Height = 21
    CharCase = ecUpperCase
    TabOrder = 6
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 120
    Width = 742
    Height = 361
    ActivePage = TabSheet3
    MultiLine = True
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Pedido'
      object Label20: TLabel
        Left = 5
        Top = 143
        Width = 141
        Height = 15
        Caption = 'Condi'#231#227'o de Pagamento:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SpdConsPag: TSpeedButton
        Left = 229
        Top = 137
        Width = 19
        Height = 22
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333FFF333333333333000333333333
          3333777FFF3FFFFF33330B000300000333337F777F777773F333000E00BFBFB0
          3333777F773333F7F333000E0BFBF0003333777F7F3337773F33000E0FBFBFBF
          0333777F7F3333FF7FFF000E0BFBF0000003777F7F3337777773000E0FBFBFBF
          BFB0777F7F33FFFFFFF7000E0BF000000003777F7FF777777773000000BFB033
          33337777773FF733333333333300033333333333337773333333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        OnClick = SpdConsPagClick
      end
      object Label30: TLabel
        Left = 148
        Top = 172
        Width = 65
        Height = 15
        Caption = 'Acr'#233'scimo:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label10: TLabel
        Left = 5
        Top = 172
        Width = 57
        Height = 15
        Caption = 'Desconto:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label32: TLabel
        Left = 551
        Top = 168
        Width = 88
        Height = 19
        Caption = 'Valor Total:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label9: TLabel
        Left = 611
        Top = 106
        Width = 79
        Height = 15
        Caption = 'Total de Itens:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label12: TLabel
        Left = 690
        Top = 104
        Width = 4
        Height = 19
        Color = clBtnFace
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = True
        WordWrap = True
      end
      object Label4: TLabel
        Left = 5
        Top = 0
        Width = 90
        Height = 15
        Caption = 'Itens do Pedido:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtCodPaga: TEdit
        Left = 152
        Top = 137
        Width = 69
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 0
        OnEnter = edtCodProdEnter
        OnExit = edtCodProdExit
        OnKeyDown = edtCodProdKeyDown
        OnKeyPress = edtCodProdKeyPress
      end
      object mskAcrescimo: TMaskEdit
        Left = 213
        Top = 166
        Width = 75
        Height = 21
        EditMask = '9999999999,99;0; '
        MaxLength = 13
        TabOrder = 1
      end
      object mskDesconto: TMaskEdit
        Left = 63
        Top = 166
        Width = 77
        Height = 21
        EditMask = '9999999999,99;0; '
        MaxLength = 13
        TabOrder = 2
      end
      object mskValorTotalNota: TMaskEdit
        Left = 639
        Top = 166
        Width = 93
        Height = 21
        TabStop = False
        Color = clSkyBlue
        Enabled = False
        EditMask = '9999999999,99;0; '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MaxLength = 13
        ParentFont = False
        ReadOnly = True
        TabOrder = 3
      end
      object Panel1: TPanel
        Left = 612
        Top = 16
        Width = 119
        Height = 81
        BevelOuter = bvLowered
        TabOrder = 4
        object GroupBox1: TGroupBox
          Left = 4
          Top = 2
          Width = 113
          Height = 34
          Caption = 'Entregue?'
          TabOrder = 0
          object CheckBox1: TCheckBox
            Left = 8
            Top = 14
            Width = 49
            Height = 17
            Caption = 'Sim'
            TabOrder = 0
          end
          object CheckBox2: TCheckBox
            Left = 56
            Top = 14
            Width = 41
            Height = 17
            Caption = 'N'#227'o'
            TabOrder = 1
          end
        end
        object GroupBox2: TGroupBox
          Left = 4
          Top = 39
          Width = 113
          Height = 34
          Caption = 'Aprovado?'
          TabOrder = 1
          object CheckBox3: TCheckBox
            Left = 8
            Top = 14
            Width = 49
            Height = 18
            Caption = 'Sim'
            TabOrder = 0
          end
          object CheckBox4: TCheckBox
            Left = 56
            Top = 15
            Width = 41
            Height = 17
            Caption = 'N'#227'o'
            TabOrder = 1
          end
        end
      end
      object grdStringGrid: TStringGrid
        Left = 2
        Top = 16
        Width = 604
        Height = 115
        Cursor = crHandPoint
        Hint = 'Clique DELETE para retirar algum produto da lista'
        ColCount = 2
        Ctl3D = False
        DefaultColWidth = 11
        DefaultRowHeight = 20
        FixedColor = clSkyBlue
        RowCount = 2
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Options = [goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goTabs, goRowSelect]
        ParentCtl3D = False
        ParentFont = False
        ParentShowHint = False
        ShowHint = True
        TabOrder = 5
        ColWidths = (
          11
          64)
      end
      object Button1: TButton
        Left = 472
        Top = 280
        Width = 89
        Height = 25
        Caption = 'Fechar Pedido'
        TabOrder = 6
        OnClick = Button1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Cota'#231#227'o'
      Enabled = False
      ImageIndex = 1
      object Label26: TLabel
        Left = 257
        Top = 140
        Width = 3
        Height = 15
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label22: TLabel
        Left = 5
        Top = 3
        Width = 155
        Height = 15
        Caption = 'Dados Produto\Fornecedor:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object DBGrid1: TDBGrid
        Left = 1
        Top = 25
        Width = 720
        Height = 264
        FixedColor = clSkyBlue
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'CODIGOPRODUTO'
            Title.Caption = 'Codigo:'
            Width = 49
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NOMEPRODUTO'
            Title.Caption = 'Produto:'
            Width = 433
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UNIDADE'
            Title.Caption = 'Unidade:'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'PRECO'
            Title.Caption = 'Pre'#231'o:'
            Visible = True
          end
          item
            Expanded = False
            Title.Caption = 'Fornecedor'
            Width = 72
            Visible = True
          end>
      end
      object BitBtn1: TBitBtn
        Left = 590
        Top = 296
        Width = 131
        Height = 25
        Caption = 'Gerar Pedido Cota'#231#227'o'
        TabOrder = 1
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000130B0000130B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333303
          333333333333337FF3333333333333903333333333333377FF33333333333399
          03333FFFFFFFFF777FF3000000999999903377777777777777FF0FFFF0999999
          99037F3337777777777F0FFFF099999999907F3FF777777777770F00F0999999
          99037F773777777777730FFFF099999990337F3FF777777777330F00FFFFF099
          03337F773333377773330FFFFFFFF09033337F3FF3FFF77733330F00F0000003
          33337F773777777333330FFFF0FF033333337F3FF7F3733333330F08F0F03333
          33337F7737F7333333330FFFF003333333337FFFF77333333333000000333333
          3333777777333333333333333333333333333333333333333333}
        NumGlyphs = 2
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Transportadora'
      Enabled = False
      ImageIndex = 2
      object Label1: TLabel
        Left = 10
        Top = 26
        Width = 151
        Height = 15
        Caption = 'Codigo da Transportadora:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label29: TLabel
        Left = 10
        Top = 62
        Width = 94
        Height = 15
        Caption = 'Valor do Seguro:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label13: TLabel
        Left = 203
        Top = 61
        Width = 82
        Height = 15
        Caption = 'Valor do Frete:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 275
        Top = 23
        Width = 86
        Height = 15
        Caption = 'transportadora'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object spdConsTrans: TSpeedButton
        Left = 244
        Top = 19
        Width = 23
        Height = 22
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333FFF333333333333000333333333
          3333777FFF3FFFFF33330B000300000333337F777F777773F333000E00BFBFB0
          3333777F773333F7F333000E0BFBF0003333777F7F3337773F33000E0FBFBFBF
          0333777F7F3333FF7FFF000E0BFBF0000003777F7F3337777773000E0FBFBFBF
          BFB0777F7F33FFFFFFF7000E0BF000000003777F7FF777777773000000BFB033
          33337777773FF733333333333300033333333333337773333333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        OnClick = spdConsTransClick
      end
      object mskValorFrete: TMaskEdit
        Left = 293
        Top = 56
        Width = 78
        Height = 21
        EditMask = '9999999999,99;0; '
        MaxLength = 13
        TabOrder = 0
      end
      object MskValorSeg: TMaskEdit
        Left = 113
        Top = 56
        Width = 78
        Height = 21
        EditMask = '9999999999,99;0; '
        MaxLength = 13
        TabOrder = 1
      end
      object EdtCodTrans: TEdit
        Left = 165
        Top = 19
        Width = 73
        Height = 21
        TabOrder = 2
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Contato/Vendedor'
      Enabled = False
      ImageIndex = 3
      object Label17: TLabel
        Left = 5
        Top = 141
        Width = 117
        Height = 15
        Caption = 'Codigo do Vendedor:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object spdConsVend: TSpeedButton
        Left = 240
        Top = 135
        Width = 22
        Height = 22
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          3333333333333333333333333333333333333FFF333333333333000333333333
          3333777FFF3FFFFF33330B000300000333337F777F777773F333000E00BFBFB0
          3333777F773333F7F333000E0BFBF0003333777F7F3337773F33000E0FBFBFBF
          0333777F7F3333FF7FFF000E0BFBF0000003777F7F3337777773000E0FBFBFBF
          BFB0777F7F33FFFFFFF7000E0BF000000003777F7FF777777773000000BFB033
          33337777773FF733333333333300033333333333337773333333333333333333
          3333333333333333333333333333333333333333333333333333333333333333
          3333333333333333333333333333333333333333333333333333}
        NumGlyphs = 2
        OnClick = spdConsVendClick
      end
      object Label18: TLabel
        Left = 267
        Top = 141
        Width = 53
        Height = 15
        Caption = 'vendedor'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 585
        Top = 141
        Width = 60
        Height = 15
        Caption = 'Comiss'#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtCodVend: TEdit
        Left = 123
        Top = 135
        Width = 114
        Height = 21
        TabOrder = 0
      end
      object mskValorComissao: TMaskEdit
        Left = 645
        Top = 135
        Width = 65
        Height = 21
        Color = clSkyBlue
        Enabled = False
        EditMask = '9999999999,99;0; '
        MaxLength = 13
        TabOrder = 1
      end
    end
    object TabSheet5: TTabSheet
      Caption = 'Observa'#231#245'es'
      Enabled = False
      ImageIndex = 4
      object Label3: TLabel
        Left = 7
        Top = 6
        Width = 79
        Height = 15
        Caption = 'Observa'#231#245'es:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 15
        Top = 158
        Width = 102
        Height = 15
        Caption = 'Outras Despesas:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object memObs: TMemo
        Left = 7
        Top = 24
        Width = 714
        Height = 89
        Lines.Strings = (
          'Seu texto aqui')
        TabOrder = 0
        WordWrap = False
      end
      object mskOutrasDespesas: TMaskEdit
        Left = 126
        Top = 152
        Width = 80
        Height = 21
        EditMask = '9999999999,99;0; '
        MaxLength = 13
        TabOrder = 1
      end
    end
  end
  object BtnGravar: TBitBtn
    Left = 24
    Top = 485
    Width = 75
    Height = 25
    Caption = 'Gravar'
    TabOrder = 2
    OnClick = BtnGravarClick
  end
  object BtnFechar: TBitBtn
    Left = 667
    Top = 485
    Width = 75
    Height = 25
    Caption = 'Fechar'
    TabOrder = 3
    OnClick = BtnFecharClick
  end
  object BitBtn5: TBitBtn
    Left = 200
    Top = 485
    Width = 75
    Height = 25
    Caption = 'BitBtn5'
    TabOrder = 4
    OnClick = BitBtn5Click
  end
  object BtnCancelar: TBitBtn
    Left = 112
    Top = 485
    Width = 75
    Height = 25
    Caption = 'Cancelar'
    TabOrder = 5
  end
  object mskValorICMS: TMaskEdit
    Left = 537
    Top = 484
    Width = 76
    Height = 21
    TabStop = False
    Color = clSkyBlue
    EditMask = '9999999999,99;0; '
    MaxLength = 13
    ReadOnly = True
    TabOrder = 7
    Visible = False
  end
  object mskValorIPI: TMaskEdit
    Left = 500
    Top = 484
    Width = 80
    Height = 21
    TabStop = False
    Color = clSkyBlue
    EditMask = '9999999999,99;0; '
    MaxLength = 13
    ReadOnly = True
    TabOrder = 8
    Visible = False
  end
  object DatData: TDateTimePicker
    Left = 608
    Top = 8
    Width = 129
    Height = 21
    Date = 37761.755889629630000000
    Time = 37761.755889629630000000
    TabOrder = 9
  end
  object DSitensPedido: TDataSource
    DataSet = DM.tblProdutoPedidoCompra
    Left = 392
    Top = 432
  end
end
