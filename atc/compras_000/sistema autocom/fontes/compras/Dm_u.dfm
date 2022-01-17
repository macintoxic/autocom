object DM: TDM
  OldCreateOrder = False
  Left = 338
  Top = 198
  Height = 386
  Width = 291
  object DBAutocom: TIBDatabase
    Connected = True
    DatabaseName = 'D:\autocom_beta_teste\dados\autocom_novo.gdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 160
    Top = 8
  end
  object IBTransaction: TIBTransaction
    Active = True
    DefaultDatabase = DBAutocom
    AutoStopAction = saNone
    Left = 224
    Top = 8
  end
  object tblPedidoCompra: TIBQuery
    Database = DBAutocom
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'select DATA, NUMEROPEDIDO, SITUACAO, TOTALPEDIDO, TOTALPRODUTOS,' +
        ' APROVADO from PEDIDOCOMPRA')
    Left = 48
    Top = 200
    object tblPedidoCompraNUMEROPEDIDO: TIntegerField
      FieldName = 'NUMEROPEDIDO'
      Origin = 'PEDIDOCOMPRA.NUMEROPEDIDO'
      Required = True
    end
    object tblPedidoCompraDATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'PEDIDOCOMPRA.DATA'
      Required = True
    end
    object tblPedidoCompraTOTALPRODUTOS: TFloatField
      FieldName = 'TOTALPRODUTOS'
      Origin = 'PEDIDOCOMPRA.TOTALPRODUTOS'
    end
    object tblPedidoCompraTOTALPEDIDO: TFloatField
      FieldName = 'TOTALPEDIDO'
      Origin = 'PEDIDOCOMPRA.TOTALPEDIDO'
    end
    object tblPedidoCompraSITUACAO: TIBStringField
      FieldName = 'SITUACAO'
      Origin = 'PEDIDOCOMPRA.SITUACAO'
      Size = 1
    end
    object tblPedidoCompraAPROVADO: TIBStringField
      FieldName = 'APROVADO'
      Origin = 'PEDIDOCOMPRA.APROVADO'
      FixedChar = True
      Size = 1
    end
  end
  object tblProduto: TIBQuery
    Database = DBAutocom
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'Select CODIGOPRODUTO, NOMEPRODUTO, a.Unidadefornecedor, a.PRECO,' +
        ' a.FRN_CODFORNECEDOR from PRODUTO'
      
        'inner join PRODUTOFORNECEDOR a on (codigoproduto=ProdutoForneced' +
        'or.CodigoProduto) ORDER BY codigoproduto')
    Left = 48
    Top = 152
    object tblProdutoCODIGOPRODUTO: TIntegerField
      FieldName = 'CODIGOPRODUTO'
      Origin = 'PRODUTOFORNECEDOR.CODIGOPRODUTO'
      Required = True
    end
    object tblProdutoNOMEPRODUTO: TIBStringField
      FieldName = 'NOMEPRODUTO'
      Origin = 'PRODUTO.NOMEPRODUTO'
      Required = True
      Size = 102
    end
  end
  object tblProdutoPedidoCompra: TIBQuery
    Database = DBAutocom
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from PRODUTOPEDIDOCOMPRA')
    Left = 48
    Top = 56
    object tblProdutoPedidoCompraCODIGOPRODUTOPEDIDOCOMPRA: TIntegerField
      FieldName = 'CODIGOPRODUTOPEDIDOCOMPRA'
      Origin = 'PRODUTOPEDIDOCOMPRA.CODIGOPRODUTOPEDIDOCOMPRA'
      Required = True
    end
    object tblProdutoPedidoCompraQUANTIDADE: TFloatField
      FieldName = 'QUANTIDADE'
      Origin = 'PRODUTOPEDIDOCOMPRA.QUANTIDADE'
      Required = True
    end
    object tblProdutoPedidoCompraENTREGUE: TFloatField
      FieldName = 'ENTREGUE'
      Origin = 'PRODUTOPEDIDOCOMPRA.ENTREGUE'
    end
    object tblProdutoPedidoCompraCANCELADO: TFloatField
      FieldName = 'CANCELADO'
      Origin = 'PRODUTOPEDIDOCOMPRA.CANCELADO'
    end
    object tblProdutoPedidoCompraPRECO: TFloatField
      FieldName = 'PRECO'
      Origin = 'PRODUTOPEDIDOCOMPRA.PRECO'
      Required = True
    end
    object tblProdutoPedidoCompraALIQUOTAIPI: TFloatField
      FieldName = 'ALIQUOTAIPI'
      Origin = 'PRODUTOPEDIDOCOMPRA.ALIQUOTAIPI'
    end
    object tblProdutoPedidoCompraALIQUOTAICMS: TFloatField
      FieldName = 'ALIQUOTAICMS'
      Origin = 'PRODUTOPEDIDOCOMPRA.ALIQUOTAICMS'
    end
    object tblProdutoPedidoCompraCODIGOPRODUTO: TIntegerField
      FieldName = 'CODIGOPRODUTO'
      Origin = 'PRODUTOPEDIDOCOMPRA.CODIGOPRODUTO'
      Required = True
    end
    object tblProdutoPedidoCompraCODIGOPEDIDOCOMPRA: TIntegerField
      FieldName = 'CODIGOPEDIDOCOMPRA'
      Origin = 'PRODUTOPEDIDOCOMPRA.CODIGOPEDIDOCOMPRA'
      Required = True
    end
    object tblProdutoPedidoCompraFATORCONVERSAO: TFloatField
      FieldName = 'FATORCONVERSAO'
      Origin = 'PRODUTOPEDIDOCOMPRA.FATORCONVERSAO'
    end
    object tblProdutoPedidoCompraLARGURA: TFloatField
      FieldName = 'LARGURA'
      Origin = 'PRODUTOPEDIDOCOMPRA.LARGURA'
    end
    object tblProdutoPedidoCompraALTURA: TFloatField
      FieldName = 'ALTURA'
      Origin = 'PRODUTOPEDIDOCOMPRA.ALTURA'
    end
    object tblProdutoPedidoCompraMETROQUADRADO: TFloatField
      FieldName = 'METROQUADRADO'
      Origin = 'PRODUTOPEDIDOCOMPRA.METROQUADRADO'
    end
    object tblProdutoPedidoCompraUNIDADE: TIBStringField
      FieldName = 'UNIDADE'
      Origin = 'PRODUTOPEDIDOCOMPRA.UNIDADE'
      Size = 3
    end
    object tblProdutoPedidoCompraCOMPLEMENTO: TIBStringField
      FieldName = 'COMPLEMENTO'
      Origin = 'PRODUTOPEDIDOCOMPRA.COMPLEMENTO'
      Size = 10
    end
    object tblProdutoPedidoCompraKIT: TIntegerField
      FieldName = 'KIT'
      Origin = 'PRODUTOPEDIDOCOMPRA.KIT'
    end
  end
  object tblFornecedor: TIBQuery
    Database = DBAutocom
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from FORNECEDOR'
      '')
    Left = 48
    Top = 104
    object tblFornecedorFRN_CODFORNECEDOR: TIntegerField
      FieldName = 'FRN_CODFORNECEDOR'
      Origin = 'FORNECEDOR.FRN_CODFORNECEDOR'
      Required = True
    end
    object tblFornecedorCODIGOFORNECEDOR: TIntegerField
      FieldName = 'CODIGOFORNECEDOR'
      Origin = 'FORNECEDOR.CODIGOFORNECEDOR'
      Required = True
    end
    object tblFornecedorPES_CODPESSOA: TIntegerField
      FieldName = 'PES_CODPESSOA'
      Origin = 'FORNECEDOR.PES_CODPESSOA'
      Required = True
    end
    object tblFornecedorCON_CODCONTA: TIntegerField
      FieldName = 'CON_CODCONTA'
      Origin = 'FORNECEDOR.CON_CODCONTA'
    end
    object tblFornecedorCODIGONATUREZAOPERACAO: TIntegerField
      FieldName = 'CODIGONATUREZAOPERACAO'
      Origin = 'FORNECEDOR.CODIGONATUREZAOPERACAO'
    end
    object tblFornecedorEMPREITEIRA: TIBStringField
      FieldName = 'EMPREITEIRA'
      Origin = 'FORNECEDOR.EMPREITEIRA'
      FixedChar = True
      Size = 1
    end
    object tblFornecedorOBSERVACAO: TIBStringField
      FieldName = 'OBSERVACAO'
      Origin = 'FORNECEDOR.OBSERVACAO'
      Size = 10000
    end
    object tblFornecedorCFG_CODCONFIG: TIntegerField
      FieldName = 'CFG_CODCONFIG'
      Origin = 'FORNECEDOR.CFG_CODCONFIG'
    end
    object tblFornecedorCLIENTE: TIBStringField
      FieldName = 'CLIENTE'
      Origin = 'FORNECEDOR.CLIENTE'
      FixedChar = True
      Size = 1
    end
  end
  object tblProdutoFornecedor: TIBQuery
    Database = DBAutocom
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from PRODUTOFORNECEDOR'
      '')
    Left = 48
    Top = 8
    object tblProdutoFornecedorFRN_CODFORNECEDOR: TIntegerField
      FieldName = 'FRN_CODFORNECEDOR'
      Origin = 'PRODUTOFORNECEDOR.FRN_CODFORNECEDOR'
      Required = True
    end
    object tblProdutoFornecedorCODIGOPRODUTO: TIntegerField
      FieldName = 'CODIGOPRODUTO'
      Origin = 'PRODUTOFORNECEDOR.CODIGOPRODUTO'
      Required = True
    end
    object tblProdutoFornecedorPRECO: TFloatField
      FieldName = 'PRECO'
      Origin = 'PRODUTOFORNECEDOR.PRECO'
    end
    object tblProdutoFornecedorUNIDADEFORNECEDOR: TIBStringField
      FieldName = 'UNIDADEFORNECEDOR'
      Origin = 'PRODUTOFORNECEDOR.UNIDADEFORNECEDOR'
      Size = 5
    end
  end
  object tblVendedor: TIBQuery
    Database = DBAutocom
    Transaction = IBTransaction
    Active = True
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT * FROM Vendedor INNER JOIN Pessoa ON (Vendedor.PES_CODPES' +
        'SOA = Pessoa.PES_CODPESSOA)')
    Left = 48
    Top = 248
    object tblVendedorCODIGOVENDEDOR: TIntegerField
      FieldName = 'CODIGOVENDEDOR'
      Origin = 'VENDEDOR.CODIGOVENDEDOR'
      Required = True
    end
    object tblVendedorPES_CODPESSOA: TIntegerField
      FieldName = 'PES_CODPESSOA'
      Origin = 'VENDEDOR.PES_CODPESSOA'
      Required = True
    end
    object tblVendedorCOMISSAO: TFloatField
      FieldName = 'COMISSAO'
      Origin = 'VENDEDOR.COMISSAO'
    end
  end
  object tblTransportadora: TIBQuery
    Database = DBAutocom
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'Select TRP_CODTRANSPORTADORA,PES_NOME_A,TELEFONE1 from TRANSPORT' +
        'ADORA inner join PESSOA on (TRANSPORTADORA.PES_CODPESSOA = PESSO' +
        'A.PES_CODPESSOA)')
    Left = 48
    Top = 296
  end
  object tblRede: TIBQuery
    Database = DBAutocom
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 160
    Top = 56
  end
  object Timer: TTimer
    OnTimer = TimerTimer
    Left = 224
    Top = 56
  end
  object tblCondicaoPagam: TIBQuery
    Database = DBAutocom
    Transaction = IBTransaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'select CODIGOCONDICAOPAGAMENTO, CONDICAOPAGAMENTO from CONDICAOP' +
        'AGAMENTO')
    Left = 160
    Top = 104
    object tblCondicaoPagamCODIGOCONDICAOPAGAMENTO: TIntegerField
      FieldName = 'CODIGOCONDICAOPAGAMENTO'
      Origin = 'CONDICAOPAGAMENTO.CODIGOCONDICAOPAGAMENTO'
      Required = True
    end
    object tblCondicaoPagamCONDICAOPAGAMENTO: TIBStringField
      FieldName = 'CONDICAOPAGAMENTO'
      Origin = 'CONDICAOPAGAMENTO.CONDICAOPAGAMENTO'
      Required = True
      Size = 50
    end
  end
end
