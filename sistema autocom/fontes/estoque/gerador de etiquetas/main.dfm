object FrmMain: TFrmMain
  Left = 276
  Top = 201
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Gerador de Etiquetas'
  ClientHeight = 369
  ClientWidth = 442
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object CmdConfig: TSpeedButton
    Left = 56
    Top = 336
    Width = 161
    Height = 25
    Caption = '&Configurar'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555550FF0559
      1950555FF75F7557F7F757000FF055591903557775F75557F77570FFFF055559
      1933575FF57F5557F7FF0F00FF05555919337F775F7F5557F7F700550F055559
      193577557F7F55F7577F07550F0555999995755575755F7FFF7F5570F0755011
      11155557F755F777777555000755033305555577755F75F77F55555555503335
      0555555FF5F75F757F5555005503335505555577FF75F7557F55505050333555
      05555757F75F75557F5505000333555505557F777FF755557F55000000355557
      07557777777F55557F5555000005555707555577777FF5557F55553000075557
      0755557F7777FFF5755555335000005555555577577777555555}
    NumGlyphs = 2
    OnClick = CmdConfigClick
  end
  object CmdPrint: TSpeedButton
    Left = 224
    Top = 336
    Width = 161
    Height = 25
    Caption = '&Imprimir'
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000130B0000130B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      00033FFFFFFFFFFFFFFF0888888888888880777777777777777F088888888888
      8880777777777777777F0000000000000000FFFFFFFFFFFFFFFF0F8F8F8F8F8F
      8F80777777777777777F08F8F8F8F8F8F9F0777777777777777F0F8F8F8F8F8F
      8F807777777777777F7F0000000000000000777777777777777F3330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3FF7F3733333330F08F0F0333333337F7737F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    NumGlyphs = 2
    OnClick = CmdPrintClick
  end
  object ListKinds: TListBox
    Left = 0
    Top = 169
    Width = 442
    Height = 153
    Cursor = crHandPoint
    Align = alTop
    Color = clWhite
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = []
    ItemHeight = 15
    Items.Strings = (
      '01 - Etiqueta Descri'#231#227'o, codigo de barras e pre'#231'o 6,5 x 3,0 cm'
      
        '02 - Etiqueta Descri'#231#227'o, codigo de barras, pre'#231'o e observa'#231#227'o 6,' +
        '5 x 3,0 cm'
      '03 - Etiqueta Descri'#231#227'o, c'#243'digo de barras 3,3 x 2,2 cm')
    ParentFont = False
    TabOrder = 1
  end
  object PanTop: TPanel
    Left = 0
    Top = 0
    Width = 442
    Height = 169
    Align = alTop
    TabOrder = 0
    object LblQuantidade: TLabel
      Left = 10
      Top = 99
      Width = 139
      Height = 15
      Caption = '&Quantidade de Etiquetas:'
      FocusControl = MskQuantidade
    end
    object LblCod: TLabel
      Left = 10
      Top = 35
      Width = 106
      Height = 15
      Caption = 'C'#243'digo do &Produto:'
      FocusControl = MskCodProduto
    end
    object LblObs: TLabel
      Left = 10
      Top = 131
      Width = 69
      Height = 15
      Caption = 'Observa'#231#227'o:'
      FocusControl = MskObs
    end
    object Label1: TLabel
      Left = 26
      Top = 59
      Width = 93
      Height = 15
      Caption = 'Tabela de Pre'#231'o:'
      FocusControl = MskCodProduto
    end
    object CmdPreco: TSpeedButton
      Left = 228
      Top = 56
      Width = 25
      Height = 25
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = CmdPrecoClick
    end
    object CmdProduto: TSpeedButton
      Left = 228
      Top = 31
      Width = 25
      Height = 25
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = CmdProdutoClick
    end
    object LblPreco: TLabel
      Left = 260
      Top = 60
      Width = 173
      Height = 15
      AutoSize = False
      Caption = 'R$'
      Font.Charset = ANSI_CHARSET
      Font.Color = clNavy
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
    end
    object MskQuantidade: TMaskEdit
      Left = 160
      Top = 96
      Width = 113
      Height = 23
      EditMask = '999999999999999;0; '
      MaxLength = 15
      TabOrder = 3
      OnClick = MskQuantidadeClick
      OnKeyDown = MskCodProdutoKeyDown
    end
    object MskCodProduto: TMaskEdit
      Left = 128
      Top = 32
      Width = 97
      Height = 23
      EditMask = '9999999999999;0; '
      MaxLength = 13
      TabOrder = 1
      OnClick = MskCodProdutoClick
      OnExit = MskCodProdutoExit
      OnKeyDown = MskCodProdutoKeyDown
    end
    object MskObs: TMaskEdit
      Left = 88
      Top = 128
      Width = 345
      Height = 23
      TabOrder = 4
      OnClick = MskQuantidadeClick
      OnKeyDown = MskCodProdutoKeyDown
    end
    object MskTabelaPreco: TMaskEdit
      Left = 128
      Top = 56
      Width = 97
      Height = 23
      EditMask = '9999999999999;0; '
      MaxLength = 13
      TabOrder = 2
      OnClick = MskTabelaPrecoClick
      OnExit = MskTabelaPrecoExit
      OnKeyDown = MskTabelaPrecoKeyDown
    end
    object PanDesc: TPanel
      Left = 1
      Top = 1
      Width = 440
      Height = 24
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      object LblDescProduto: TLabel
        Left = 0
        Top = 8
        Width = 440
        Height = 16
        Align = alBottom
        Alignment = taCenter
        AutoSize = False
        Caption = 'Descricao do Produto'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -12
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
  end
  object XPMenu: TXPMenu
    DimLevel = 30
    GrayLevel = 10
    Font.Charset = ANSI_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Color = clBtnFace
    DrawMenuBar = False
    IconBackColor = clBtnFace
    MenuBarColor = clBtnFace
    SelectColor = clHighlight
    SelectBorderColor = clHighlight
    SelectFontColor = clMenuText
    DisabledColor = clInactiveCaption
    SeparatorColor = clBtnFace
    CheckedColor = clHighlight
    IconWidth = 24
    DrawSelect = True
    UseSystemColors = True
    UseDimColor = False
    OverrideOwnerDraw = False
    Gradient = False
    FlatMenu = False
    AutoDetect = True
    Active = True
    Left = 272
    Top = 216
  end
  object Rede: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 160
    Top = 216
  end
  object DBAutocom: TIBDatabase
    DatabaseName = '10.1.2.240:c:\autocom\dados\autocom.gdb'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = Transaction
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 32
    Top = 216
  end
  object Transaction: TIBTransaction
    Active = False
    DefaultDatabase = DBAutocom
    AutoStopAction = saNone
    Left = 96
    Top = 216
  end
  object Tbl_Produto: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 216
    Top = 216
  end
  object Tbl_ProdutoC: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'Select CODIGOPRODUTO, NOMEPRODUTO from PRODUTO')
    Left = 328
    Top = 216
    object Tbl_ProdutoCCODIGOPRODUTO: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGOPRODUTO'
      Origin = 'PRODUTO.CODIGOPRODUTO'
      Required = True
    end
    object Tbl_ProdutoCNOMEPRODUTO: TIBStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 140
      FieldName = 'NOMEPRODUTO'
      Origin = 'PRODUTO.NOMEPRODUTO'
      Required = True
      Size = 102
    end
  end
  object Tbl_Preco: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'select * from produtotabelapreco ptp inner join tabelapreco tp o' +
        'n (ptp.codigotabelapreco = tp.codigotabelapreco)'
      'where ptp.codigoproduto = :codigoproduto')
    Left = 392
    Top = 216
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'codigoproduto'
        ParamType = ptUnknown
      end>
    object Tbl_PrecoCODIGOPRODUTOTABELAPRECO: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'CODIGOPRODUTOTABELAPRECO'
      Origin = 'PRODUTOTABELAPRECO.CODIGOPRODUTOTABELAPRECO'
      Required = True
    end
    object Tbl_PrecoCODIGOPRODUTO: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'CODIGOPRODUTO'
      Origin = 'PRODUTOTABELAPRECO.CODIGOPRODUTO'
      Required = True
    end
    object Tbl_PrecoPRECO: TFloatField
      Alignment = taLeftJustify
      FieldName = 'PRECO'
      Origin = 'PRODUTOTABELAPRECO.PRECO'
      Required = True
      DisplayFormat = '#####0.00'
    end
    object Tbl_PrecoCODIGOTABELAPRECO: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'CODIGOTABELAPRECO'
      Origin = 'PRODUTOTABELAPRECO.CODIGOTABELAPRECO'
      Required = True
    end
    object Tbl_PrecoCODIGOTABELAPRECO1: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'CODIGOTABELAPRECO1'
      Origin = 'TABELAPRECO.CODIGOTABELAPRECO'
      Required = True
    end
    object Tbl_PrecoCODIGOTABELA: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'CODIGOTABELA'
      Origin = 'TABELAPRECO.CODIGOTABELA'
      Required = True
    end
    object Tbl_PrecoTABELAPRECO: TIBStringField
      FieldName = 'TABELAPRECO'
      Origin = 'TABELAPRECO.TABELAPRECO'
      Required = True
      Size = 50
    end
    object Tbl_PrecoDATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'TABELAPRECO.DATA'
      Required = True
    end
    object Tbl_PrecoCFG_CODCONFIG: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'CFG_CODCONFIG'
      Origin = 'TABELAPRECO.CFG_CODCONFIG'
      Required = True
    end
  end
end
