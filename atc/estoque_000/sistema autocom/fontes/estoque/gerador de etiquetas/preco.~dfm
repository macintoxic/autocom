object FrmPreco: TFrmPreco
  Left = 292
  Top = 171
  Width = 376
  Height = 424
  BorderIcons = [biSystemMenu]
  Caption = 'Selecione a Tabela de Pre'#231'os'
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
  object GrdProdutos: TDBGrid
    Left = 0
    Top = 0
    Width = 368
    Height = 397
    Align = alClient
    DataSource = Ds_Preco
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = GrdProdutosDblClick
    OnKeyDown = GrdProdutosKeyDown
    Columns = <
      item
        Color = clMoneyGreen
        Expanded = False
        FieldName = 'TABELAPRECO'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        Title.Caption = 'Tabela'
        Width = 244
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PRECO'
        Title.Caption = 'Pre'#231'o'
        Width = 91
        Visible = True
      end>
  end
  object Ds_Preco: TDataSource
    DataSet = FrmMain.Tbl_Preco
    Left = 160
    Top = 120
  end
end
