object frmBuscaVendedor: TfrmBuscaVendedor
  Left = 216
  Top = 213
  BorderStyle = bsDialog
  Caption = 'Sistema Autocom - Cadastro de indicadores'
  ClientHeight = 291
  ClientWidth = 645
  Color = clBtnFace
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
  object Label1: TLabel
    Left = 5
    Top = 328
    Width = 233
    Height = 19
    Caption = '[ENTER] - Seleciona o produto'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 645
    Height = 56
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
  end
  object Panel3: TPanel
    Left = 0
    Top = 56
    Width = 645
    Height = 235
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 1
    object dbgrProdutos: TDBGrid
      Left = 2
      Top = 2
      Width = 641
      Height = 231
      Cursor = crHandPoint
      Align = alClient
      Color = clWhite
      Ctl3D = True
      DataSource = dsListaVendedores
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
          FieldName = 'codigovendedor'
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
          FieldName = 'NOME'
          Title.Caption = 'Vendedor'
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
  object dsListaVendedores: TDataSource
    Left = 632
    Top = 320
  end
end
