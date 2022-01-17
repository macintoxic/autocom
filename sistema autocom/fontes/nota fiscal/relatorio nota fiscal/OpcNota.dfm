object frmOpcNota: TfrmOpcNota
  Left = 143
  Top = 22
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Relat'#243'rio de Notas Fiscais Emitidas'
  ClientHeight = 361
  ClientWidth = 401
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 64
    Top = 97
    Width = 17
    Height = 13
    Caption = 'De:'
    Enabled = False
  end
  object Label3: TLabel
    Left = 240
    Top = 97
    Width = 19
    Height = 13
    Caption = 'At'#233':'
    Enabled = False
  end
  object Label4: TLabel
    Left = 64
    Top = 166
    Width = 17
    Height = 13
    Caption = 'De:'
    Enabled = False
  end
  object Label5: TLabel
    Left = 240
    Top = 166
    Width = 19
    Height = 13
    Caption = 'At'#233':'
    Enabled = False
  end
  object Label6: TLabel
    Left = 64
    Top = 225
    Width = 17
    Height = 13
    Caption = 'De:'
    Enabled = False
  end
  object Label7: TLabel
    Left = 240
    Top = 225
    Width = 19
    Height = 13
    Caption = 'At'#233':'
    Enabled = False
  end
  object Label8: TLabel
    Left = 8
    Top = 264
    Width = 72
    Height = 13
    Caption = 'Ordenar por:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel2: TPanel
    Left = 4
    Top = 8
    Width = 394
    Height = 49
    BevelOuter = bvNone
    TabOrder = 0
    object optNotaEntrada: TRadioButton
      Left = 61
      Top = 16
      Width = 115
      Height = 17
      Cursor = crHandPoint
      Caption = 'Nota de Entrada'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = optNotaEntradaClick
      OnKeyDown = optNotaEntradaKeyDown
    end
    object optNotaSaida: TRadioButton
      Left = 237
      Top = 16
      Width = 105
      Height = 17
      Cursor = crHandPoint
      Caption = 'Nota de Sa'#237'da'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = optNotaSaidaClick
      OnKeyDown = optNotaEntradaKeyDown
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 3
    Width = 401
    Height = 3
    TabOrder = 16
  end
  object chkNumeroNota: TCheckBox
    Left = 8
    Top = 71
    Width = 129
    Height = 17
    Cursor = crHandPoint
    Caption = 'N'#186' da Nota Fiscal'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = chkNumeroNotaClick
    OnKeyDown = optNotaEntradaKeyDown
  end
  object mskNumNotaDe: TMaskEdit
    Left = 83
    Top = 94
    Width = 59
    Height = 21
    Enabled = False
    EditMask = '99999999;0; '
    MaxLength = 8
    TabOrder = 2
    OnExit = mskNumNotaDeExit
    OnKeyDown = optNotaEntradaKeyDown
  end
  object mskNumNotaAte: TMaskEdit
    Left = 261
    Top = 94
    Width = 59
    Height = 21
    Enabled = False
    EditMask = '99999999;0; '
    MaxLength = 8
    TabOrder = 3
    OnExit = mskNumNotaAteExit
    OnKeyDown = optNotaEntradaKeyDown
  end
  object Panel4: TPanel
    Left = 0
    Top = 123
    Width = 401
    Height = 3
    TabOrder = 18
  end
  object chkDataEmissao: TCheckBox
    Left = 8
    Top = 139
    Width = 119
    Height = 17
    Cursor = crHandPoint
    Caption = 'Data de emiss'#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = chkDataEmissaoClick
    OnKeyDown = optNotaEntradaKeyDown
  end
  object datDataEmissaoDe: TDateTimePicker
    Left = 83
    Top = 163
    Width = 82
    Height = 21
    Date = 37074.642571643500000000
    Time = 37074.642571643500000000
    Enabled = False
    TabOrder = 5
    OnKeyDown = optNotaEntradaKeyDown
  end
  object datDataEmissaoAte: TDateTimePicker
    Left = 261
    Top = 163
    Width = 82
    Height = 21
    Date = 37074.642571643500000000
    Time = 37074.642571643500000000
    Enabled = False
    TabOrder = 6
    OnKeyDown = optNotaEntradaKeyDown
  end
  object Panel5: TPanel
    Left = 0
    Top = 195
    Width = 401
    Height = 3
    TabOrder = 19
  end
  object chkClienteFornecedor: TCheckBox
    Left = 8
    Top = 203
    Width = 89
    Height = 17
    Cursor = crHandPoint
    Caption = 'Fornecedor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 7
    OnClick = chkClienteFornecedorClick
    OnKeyDown = optNotaEntradaKeyDown
  end
  object mskClienteFornecedorDe: TMaskEdit
    Left = 83
    Top = 222
    Width = 87
    Height = 21
    Enabled = False
    EditMask = '9999999999999;0; '
    MaxLength = 13
    TabOrder = 8
    OnExit = mskClienteFornecedorDeExit
    OnKeyDown = optNotaEntradaKeyDown
  end
  object mskClienteFornecedorAte: TMaskEdit
    Left = 261
    Top = 222
    Width = 87
    Height = 21
    Enabled = False
    EditMask = '9999999999999;0; '
    MaxLength = 13
    TabOrder = 9
    OnExit = mskClienteFornecedorAteExit
    OnKeyDown = optNotaEntradaKeyDown
  end
  object Panel6: TPanel
    Left = 0
    Top = 251
    Width = 401
    Height = 3
    TabOrder = 20
  end
  object optNumeroNotaFiscal: TRadioButton
    Left = 104
    Top = 267
    Width = 129
    Height = 17
    Cursor = crHandPoint
    Caption = 'N'#186' da Nota Fiscal'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 10
    TabStop = True
    OnKeyDown = optNotaEntradaKeyDown
  end
  object optDataEmissao: TRadioButton
    Left = 248
    Top = 267
    Width = 113
    Height = 17
    Cursor = crHandPoint
    Caption = 'Data de emiss'#227'o'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 11
    OnKeyDown = optNotaEntradaKeyDown
  end
  object optClienteFornecedor: TRadioButton
    Left = 104
    Top = 299
    Width = 113
    Height = 17
    Cursor = crHandPoint
    Caption = 'Fornecedor'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 12
    OnKeyDown = optNotaEntradaKeyDown
  end
  object optValorNota: TRadioButton
    Left = 248
    Top = 299
    Width = 105
    Height = 17
    Cursor = crHandPoint
    Caption = 'Valor da Nota'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 13
    OnKeyDown = optNotaEntradaKeyDown
  end
  object Panel7: TPanel
    Left = 0
    Top = 323
    Width = 401
    Height = 3
    TabOrder = 21
  end
  object cmdOk: TBitBtn
    Left = 232
    Top = 331
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = '&OK'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 14
    OnClick = cmdOkClick
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object cmdFechar: TBitBtn
    Left = 320
    Top = 331
    Width = 75
    Height = 25
    Cursor = crHandPoint
    Caption = '&Fechar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 15
    OnClick = cmdFecharClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00330000000000
      03333377777777777F333301111111110333337F333333337F33330111111111
      0333337F333333337F333301111111110333337F333333337F33330111111111
      0333337F333333337F333301111111110333337F333333337F33330111111111
      0333337F3333333F7F333301111111B10333337F333333737F33330111111111
      0333337F333333337F333301111111110333337F33FFFFF37F3333011EEEEE11
      0333337F377777F37F3333011EEEEE110333337F37FFF7F37F3333011EEEEE11
      0333337F377777337F333301111111110333337F333333337F33330111111111
      0333337FFFFFFFFF7F3333000000000003333377777777777333}
    NumGlyphs = 2
  end
  object Panel3: TPanel
    Left = 0
    Top = 59
    Width = 401
    Height = 3
    TabOrder = 17
  end
  object DbAutocom: TIBDatabase
    Connected = True
    DatabaseName = '10.1.2.99:d:\autocom\dados\autocom_novo.gdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 17
    Top = 318
  end
  object IBTransaction1: TIBTransaction
    Active = True
    AutoStopAction = saNone
    Left = 88
    Top = 318
  end
  object rede: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 352
    Top = 179
  end
  object tbl_NFEntrada: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT NotaFiscalEntrada.DATAEMISSAO, NotaFiscalEntrada.NUMERONO' +
        'TA, PedidoCompra.NUMEROPEDIDO, Pessoa.PES_NOME_A, CondicaoPagame' +
        'nto.CONDICAOPAGAMENTO, NotaFiscalEntrada.TOTALNOTA, NotaFiscalEn' +
        'trada.CANCELADA, NotaFiscalEntrada.FATURADO FROM Pessoa, Fornece' +
        'dor, CondicaoPagamento, NotaFiscalEntrada LEFT JOIN PedidoCompra' +
        ' ON NotaFiscalEntrada.CODIGOPEDIDOCOMPRA = PedidoCompra.CODIGOPE' +
        'DIDOCOMPRA WHERE Fornecedor.FRN_CODFORNECEDOR = NotaFiscalEntrad' +
        'a.FRN_CODFORNECEDOR AND Pessoa.PES_CODPESSOA = Fornecedor.PES_CO' +
        'DPESSOA AND CondicaoPagamento.CODIGOCONDICAOPAGAMENTO = NotaFisc' +
        'alEntrada.CODIGOCONDICAOPAGAMENTO')
    Left = 352
    Top = 67
    object tbl_NFEntradaDATAEMISSAO: TDateTimeField
      FieldName = 'DATAEMISSAO'
      Origin = 'NOTAFISCALENTRADA.DATAEMISSAO'
    end
    object tbl_NFEntradaNUMERONOTA: TIntegerField
      FieldName = 'NUMERONOTA'
      Origin = 'NOTAFISCALENTRADA.NUMERONOTA'
      Required = True
    end
    object tbl_NFEntradaNUMEROPEDIDO: TIntegerField
      FieldName = 'NUMEROPEDIDO'
      Origin = 'PEDIDOCOMPRA.NUMEROPEDIDO'
    end
    object tbl_NFEntradaPES_NOME_A: TIBStringField
      FieldName = 'PES_NOME_A'
      Origin = 'PESSOA.PES_NOME_A'
      Required = True
      Size = 50
    end
    object tbl_NFEntradaCONDICAOPAGAMENTO: TIBStringField
      FieldName = 'CONDICAOPAGAMENTO'
      Origin = 'CONDICAOPAGAMENTO.CONDICAOPAGAMENTO'
      Required = True
      Size = 50
    end
    object tbl_NFEntradaTOTALNOTA: TFloatField
      FieldName = 'TOTALNOTA'
      Origin = 'NOTAFISCALENTRADA.TOTALNOTA'
    end
    object tbl_NFEntradaCANCELADA: TIBStringField
      FieldName = 'CANCELADA'
      Origin = 'NOTAFISCALENTRADA.CANCELADA'
      Required = True
      FixedChar = True
      Size = 1
    end
    object tbl_NFEntradaFATURADO: TIBStringField
      FieldName = 'FATURADO'
      Origin = 'NOTAFISCALENTRADA.FATURADO'
      FixedChar = True
      Size = 1
    end
  end
  object XPMenu1: TXPMenu
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
    Gradient = True
    FlatMenu = False
    AutoDetect = True
    Active = True
    Left = 353
    Top = 11
  end
  object tbl_NFSaida: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT NotaFiscalSaida.DATAEMISSAO, NotaFiscalSaida.NUMERONOTA, ' +
        'PedidoVenda.NUMEROPEDIDO, Pessoa.PES_NOME_A, CondicaoPagamento.C' +
        'ONDICAOPAGAMENTO, NotaFiscalSaida.TOTALNOTA, NotaFiscalSaida.CAN' +
        'CELADA, NotaFiscalSaida.FATURADO FROM Pessoa, Cliente, CondicaoP' +
        'agamento, NotaFiscalSaida LEFT JOIN PedidoVenda ON NotaFiscalSai' +
        'da.CODIGOPEDIDOVENDA = PedidoVenda.CODIGOPEDIDOVENDA WHERE Clien' +
        'te.CLI_CODCLIENTE = NotaFiscalSaida.CLI_CODCLIENTE AND Pessoa.PE' +
        'S_CODPESSOA = Cliente.PES_CODPESSOA AND CondicaoPagamento.CODIGO' +
        'CONDICAOPAGAMENTO = NotaFiscalSaida.CODIGOCONDICAOPAGAMENTO')
    Left = 352
    Top = 123
    object tbl_NFSaidaDATAEMISSAO: TDateTimeField
      FieldName = 'DATAEMISSAO'
      Origin = 'NOTAFISCALSAIDA.DATAEMISSAO'
      Required = True
    end
    object tbl_NFSaidaNUMERONOTA: TIntegerField
      FieldName = 'NUMERONOTA'
      Origin = 'NOTAFISCALSAIDA.NUMERONOTA'
      Required = True
    end
    object tbl_NFSaidaNUMEROPEDIDO: TIntegerField
      FieldName = 'NUMEROPEDIDO'
      Origin = 'PEDIDOVENDA.NUMEROPEDIDO'
    end
    object tbl_NFSaidaPES_NOME_A: TIBStringField
      FieldName = 'PES_NOME_A'
      Origin = 'PESSOA.PES_NOME_A'
      Required = True
      Size = 50
    end
    object tbl_NFSaidaCONDICAOPAGAMENTO: TIBStringField
      FieldName = 'CONDICAOPAGAMENTO'
      Origin = 'CONDICAOPAGAMENTO.CONDICAOPAGAMENTO'
      Required = True
      Size = 50
    end
    object tbl_NFSaidaTOTALNOTA: TFloatField
      FieldName = 'TOTALNOTA'
      Origin = 'NOTAFISCALSAIDA.TOTALNOTA'
    end
    object tbl_NFSaidaCANCELADA: TIBStringField
      FieldName = 'CANCELADA'
      Origin = 'NOTAFISCALSAIDA.CANCELADA'
      Required = True
      FixedChar = True
      Size = 1
    end
    object tbl_NFSaidaFATURADO: TIBStringField
      FieldName = 'FATURADO'
      Origin = 'NOTAFISCALSAIDA.FATURADO'
      FixedChar = True
      Size = 1
    end
  end
end
