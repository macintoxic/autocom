object frmConsultaPedido: TfrmConsultaPedido
  Left = 133
  Top = 147
  BorderStyle = bsDialog
  Caption = 'Sistema Autocom - Consulta Pedidos'
  ClientHeight = 367
  ClientWidth = 738
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 738
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
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 56
    Width = 738
    Height = 311
    Align = alClient
    BevelInner = bvLowered
    TabOrder = 1
    object dbgrProdutos: TDBGrid
      Left = 2
      Top = 2
      Width = 734
      Height = 307
      Cursor = crHandPoint
      Align = alClient
      Color = clWhite
      Ctl3D = True
      DataSource = dsPedidos
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
      OnDrawColumnCell = dbgrProdutosDrawColumnCell
      OnDblClick = dbgrProdutosDblClick
      OnEnter = dbgrProdutosEnter
      OnExit = dbgrProdutosExit
      OnKeyDown = dbgrProdutosKeyDown
    end
  end
  object dsPedidos: TDataSource
    Left = 656
    Top = 288
  end
end
