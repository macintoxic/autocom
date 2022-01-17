object frmConsultaProduto: TfrmConsultaProduto
  Left = 35
  Top = 85
  BorderStyle = bsDialog
  Caption = 'Sistema Autocom - Consulta de produtos'
  ClientHeight = 417
  ClientWidth = 743
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 743
    Height = 147
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 554
      Top = 24
      Width = 175
      Height = 23
      Cursor = crHandPoint
      Caption = '[F12] - Procura produto'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object Label3: TLabel
      Left = 576
      Top = 5
      Width = 135
      Height = 16
      Caption = 'Aguarde a consulta...'
      Font.Charset = ANSI_CHARSET
      Font.Color = clRed
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object edConsulta: TEdit
      Left = 8
      Top = 25
      Width = 544
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      OnKeyDown = edConsultaKeyDown
    end
    object Panel2: TPanel
      Left = 7
      Top = 55
      Width = 193
      Height = 29
      BevelInner = bvLowered
      BevelOuter = bvLowered
      BevelWidth = 2
      Color = clSkyBlue
      TabOrder = 1
      object dbtxtPreco: TDBText
        Left = 88
        Top = 6
        Width = 97
        Height = 19
        Alignment = taRightJustify
        DataField = 'PRECO'
        DataSource = dsListaProdutos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label7: TLabel
        Left = 8
        Top = 6
        Width = 51
        Height = 19
        Caption = 'Pre'#231'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object Panel4: TPanel
      Left = 7
      Top = 84
      Width = 193
      Height = 28
      BevelInner = bvLowered
      BevelOuter = bvLowered
      BevelWidth = 2
      Color = clSkyBlue
      TabOrder = 2
      object DBText1: TDBText
        Left = 88
        Top = 6
        Width = 97
        Height = 19
        Alignment = taRightJustify
        DataField = 'SECAO'
        DataSource = dsListaProdutos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 8
        Top = 6
        Width = 54
        Height = 19
        Caption = 'Se'#231#227'o:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object Panel5: TPanel
      Left = 7
      Top = 113
      Width = 193
      Height = 28
      BevelInner = bvLowered
      BevelOuter = bvLowered
      BevelWidth = 2
      Color = clSkyBlue
      TabOrder = 3
      object DBText2: TDBText
        Left = 88
        Top = 6
        Width = 97
        Height = 19
        Alignment = taRightJustify
        DataField = 'PRATELEIRA'
        DataSource = dsListaProdutos
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label2: TLabel
        Left = 8
        Top = 6
        Width = 78
        Height = 19
        Caption = 'Prateleira:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object PageControl1: TPageControl
      Left = 216
      Top = 48
      Width = 513
      Height = 96
      Cursor = crHandPoint
      ActivePage = TabSheet1
      TabOrder = 4
      object TabSheet1: TTabSheet
        Caption = 'Descri'#231#227'o'
        object DBMemo1: TDBMemo
          Left = 0
          Top = 0
          Width = 505
          Height = 68
          Align = alClient
          Color = clSkyBlue
          DataField = 'DESCRICAO'
          DataSource = dsListaProdutos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object TabSheet2: TTabSheet
        Caption = 'Indica'#231#227'o'
        ImageIndex = 1
        object DBMemo2: TDBMemo
          Left = 0
          Top = 0
          Width = 505
          Height = 68
          Align = alClient
          Color = clSkyBlue
          DataField = 'INDICACAO'
          DataSource = dsListaProdutos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
      object TabSheet3: TTabSheet
        Caption = 'Aplica'#231#227'o'
        ImageIndex = 2
        object DBMemo3: TDBMemo
          Left = 0
          Top = 0
          Width = 505
          Height = 68
          Align = alClient
          Color = clSkyBlue
          DataField = 'APLICACAO'
          DataSource = dsListaProdutos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
          ReadOnly = True
          ScrollBars = ssVertical
          TabOrder = 0
        end
      end
    end
    object RadioButton1: TRadioButton
      Left = 8
      Top = 5
      Width = 193
      Height = 17
      Caption = 'Procura por c'#243'digo ou nome'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      TabStop = True
    end
    object RadioButton2: TRadioButton
      Left = 248
      Top = 5
      Width = 137
      Height = 17
      Caption = 'Procura por Autor'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 147
    Width = 743
    Height = 270
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 1
    object dbgrProdutos: TDBGrid
      Left = 2
      Top = 2
      Width = 739
      Height = 266
      Cursor = crHandPoint
      Align = alClient
      Color = clWhite
      Ctl3D = True
      DataSource = dsListaProdutos
      FixedColor = clSkyBlue
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgRowLines, dgRowSelect]
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = dbgrProdutosDblClick
      OnKeyDown = dbgrProdutosKeyDown
      Columns = <
        item
          Expanded = False
          FieldName = 'CODIGOPRODUTO'
          Title.Caption = 'C'#243'digo'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Width = 109
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NOMEPRODUTO'
          Title.Caption = 'Produto'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Arial'
          Title.Font.Style = [fsBold]
          Width = 585
          Visible = True
        end>
    end
  end
  object dsListaProdutos: TDataSource
    Left = 632
    Top = 320
  end
end
