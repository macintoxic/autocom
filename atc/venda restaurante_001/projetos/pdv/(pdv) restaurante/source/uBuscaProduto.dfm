object frmConsultaProduto: TfrmConsultaProduto
  Left = 185
  Top = 219
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
    object Label6: TLabel
      Left = 8
      Top = 5
      Width = 308
      Height = 16
      Caption = 'Digite aqui o c'#243'digo ou o nome a ser consultado'
      Font.Charset = ANSI_CHARSET
      Font.Color = clMaroon
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object imgProduto: TImage
      Left = 599
      Top = 3
      Width = 140
      Height = 140
      Stretch = True
    end
    object edConsulta: TEdit
      Left = 8
      Top = 25
      Width = 585
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
      OnChange = edConsultaChange
      OnKeyDown = edConsultaKeyDown
    end
    object Panel2: TPanel
      Left = 7
      Top = 55
      Width = 193
      Height = 30
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
