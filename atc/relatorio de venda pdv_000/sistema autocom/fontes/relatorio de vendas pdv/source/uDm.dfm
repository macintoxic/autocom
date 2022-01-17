object Dm: TDm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 13
  Top = 153
  Height = 381
  Width = 766
  object DBAutocom: TIBDatabase
    DatabaseName = 'localhost:c:\atcpserver\dados\autocom.gdb'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = Transaction
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 24
    Top = 8
  end
  object Transaction: TIBTransaction
    Active = False
    DefaultDatabase = DBAutocom
    AutoStopAction = saNone
    Left = 97
    Top = 8
  end
  object QrProdutos: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT DISTINCT P.CODIGOPRODUTO , P.NOMEPRODUTO, SUM(PD.QTDE) AS' +
        ' QTDE, SUM(PD.VALORUN * PD.QTDE) AS VALORSOMA, SUM(PD.VALORUN) a' +
        's TOTUNID, SUM(PD.ACRESCIMO) as TOTACRES, SUM(PD.DESCONTO) as TO' +
        'TDESC FROM PRODUTO P, PDV_DETALHECUPOM PD  WHERE PD.CFG_CODCONFI' +
        'G = 1 GROUP BY P.CODIGOPRODUTO, P.NOMEPRODUTO ORDER BY P.CODIGOP' +
        'RODUTO')
    Left = 24
    Top = 72
    object QrProdutosCODIGOPRODUTO: TIntegerField
      FieldName = 'CODIGOPRODUTO'
      Required = True
    end
    object QrProdutosNOMEPRODUTO: TIBStringField
      FieldName = 'NOMEPRODUTO'
      Required = True
      Size = 100
    end
    object QrProdutosQTDE: TFloatField
      FieldName = 'QTDE'
      DisplayFormat = '0.000'
    end
    object QrProdutosVALORSOMA: TFloatField
      FieldName = 'VALORSOMA'
      currency = True
    end
    object QrProdutosTOTUNID: TFloatField
      FieldName = 'TOTUNID'
      currency = True
    end
    object QrProdutosTOTACRES: TFloatField
      FieldName = 'TOTACRES'
      currency = True
    end
    object QrProdutosTOTDESC: TFloatField
      FieldName = 'TOTDESC'
      currency = True
    end
  end
  object QrIndicadores: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    OnCalcFields = QrIndicadoresCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT DISTINCT P.PES_NOME_A, SUM(PF.VALORRECEBIDO) AS VALOR, SU' +
        'M(PF.REPIQUE) AS REPIQUE, SUM(PF.CONTRAVALE) AS CONTRAVALE, SUM(' +
        'PF.TROCO) AS TROCO, COUNT(PF.VALORRECEBIDO) AS QTDE,  (SELECT SU' +
        'M(NUMEROCLIENTES) FROM PDV_CABECALHOCUPOM WHERE CFG_CODCONFIG = ' +
        '1 AND VEN_CODVENDEDOR = V.VEN_CODVENDEDOR AND SITUACAO = 0) AS N' +
        'PESSOAS,  V.COMISSAO, V.CODIGOVENDEDOR FROM PDV_FECHAMENTOCUPOM ' +
        'PF, PESSOA P, VENDEDOR V WHERE VENDEDOR.PES_CODPESSOA = PESSOA.P' +
        'ES_CODPESSOA  AND V.VEN_CODVENDEDOR = PF.VEN_CODVENDEDOR  AND PF' +
        '.CFG_CODCONFIG = 1 GROUP BY P.PES_NOME_A, V.COMISSAO, V.CODIGOVE' +
        'NDEDOR ORDER BY V.CODIGOVENDEDOR')
    Left = 97
    Top = 72
    object QrIndicadoresPES_NOME_A: TIBStringField
      FieldName = 'PES_NOME_A'
      Required = True
      Size = 50
    end
    object QrIndicadoresVALOR: TFloatField
      FieldName = 'VALOR'
      currency = True
    end
    object QrIndicadoresREPIQUE: TFloatField
      FieldName = 'REPIQUE'
      currency = True
    end
    object QrIndicadoresCONTRAVALE: TFloatField
      FieldName = 'CONTRAVALE'
      currency = True
    end
    object QrIndicadoresTROCO: TFloatField
      FieldName = 'TROCO'
      currency = True
    end
    object QrIndicadoresQTDE: TIntegerField
      FieldName = 'QTDE'
      Required = True
    end
    object QrIndicadoresNPESSOAS: TIntegerField
      FieldName = 'NPESSOAS'
    end
    object QrIndicadoresCOMISSAO: TFloatField
      FieldName = 'COMISSAO'
    end
    object QrIndicadoresCODIGOVENDEDOR: TIntegerField
      FieldName = 'CODIGOVENDEDOR'
      Required = True
    end
    object QrIndicadoresVALORL: TFloatField
      FieldKind = fkCalculated
      FieldName = 'VALORL'
      currency = True
      Calculated = True
    end
    object QrIndicadoresCOMISSAOL: TFloatField
      FieldKind = fkCalculated
      FieldName = 'COMISSAOL'
      currency = True
      Calculated = True
    end
  end
  object QrGrupos: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        ' SELECT DISTINCT  GP.GRUPOPRODUTO, SGP.SUBGRUPO, SGP.CODIGOSUBGR' +
        'UPO, SUM(PD.QTDE) AS QTDE, SUM((VALORUN * QTDE)  + ACRESCIMO - D' +
        'ESCONTO) AS VALORSOMA, GP.CODIGOGRUPOPRODUTO FROM PRODUTO P, SUB' +
        'GRUPOPRODUTO SGP, PDV_DETALHECUPOM PD INNER JOIN GRUPOPRODUTO GP' +
        ' ON (SGP.CODIGOGRUPOPRODUTO = GP.CODIGOGRUPOPRODUTO AND SGP.CODI' +
        'GOSUBGRUPOPRODUTO = P.CODIGOSUBGRUPOPRODUTO AND P.CODIGOPRODUTO ' +
        '= PD.CODIGOPRODUTO) WHERE (PD.SITUACAO IS NULL OR PD.SITUACAO <>' +
        ' 1) AND P.CODIGOSUBGRUPOPRODUTO = SGP.CODIGOSUBGRUPOPRODUTO  AND' +
        ' SGP.CODIGOGRUPOPRODUTO = GP.CODIGOGRUPOPRODUTO  AND PD.CFG_CODC' +
        'ONFIG = 1 GROUP BY GP.GRUPOPRODUTO, SGP.SUBGRUPO, GP.CODIGOGRUPO' +
        'PRODUTO,   '
      'SGP.CODIGOSUBGRUPO'
      ''
      ' ORDER BY GP.CODIGOGRUPOPRODUTO, SGP.SUBGRUPO')
    Left = 171
    Top = 72
    object QrGruposGRUPOPRODUTO: TIBStringField
      FieldName = 'GRUPOPRODUTO'
      Required = True
      Size = 50
    end
    object QrGruposSUBGRUPO: TIBStringField
      FieldName = 'SUBGRUPO'
      Required = True
      Size = 50
    end
    object QrGruposQTDE: TFloatField
      FieldName = 'QTDE'
    end
    object QrGruposVALORSOMA: TFloatField
      FieldName = 'VALORSOMA'
      currency = True
    end
    object QrGruposCODIGOGRUPOPRODUTO: TIntegerField
      FieldName = 'CODIGOGRUPOPRODUTO'
      Required = True
    end
    object QrGruposCODIGOSUBGRUPO: TIntegerField
      FieldName = 'CODIGOSUBGRUPO'
      Required = True
    end
  end
  object QrCheques: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT PF.*, P.PES_CPF_CNPJ_A FROM PDV_FECHAMENTOCUPOM PF, CLIEN' +
        'TE C, PESSOA P WHERE C.CLI_CODCLIENTE = PF.CLI_CODCLIENTE  AND C' +
        '.PES_CODPESSOA =  P.PES_CODPESSOA AND  PF.CFG_CODCONFIG = 1')
    Left = 380
    Top = 72
    object QrChequesOID: TIntegerField
      FieldName = 'OID'
      Origin = 'PDV_FECHAMENTOCUPOM.OID'
      Required = True
    end
    object QrChequesDATAHORA: TDateTimeField
      FieldName = 'DATAHORA'
      Origin = 'PDV_FECHAMENTOCUPOM.DATAHORA'
      Required = True
    end
    object QrChequesCFG_CODCONFIG: TIntegerField
      FieldName = 'CFG_CODCONFIG'
      Origin = 'PDV_FECHAMENTOCUPOM.CFG_CODCONFIG'
      Required = True
    end
    object QrChequesCLI_CODCLIENTE: TIntegerField
      FieldName = 'CLI_CODCLIENTE'
      Origin = 'PDV_FECHAMENTOCUPOM.CLI_CODCLIENTE'
      Required = True
    end
    object QrChequesVEN_CODVENDEDOR: TIntegerField
      FieldName = 'VEN_CODVENDEDOR'
      Origin = 'PDV_FECHAMENTOCUPOM.VEN_CODVENDEDOR'
      Required = True
    end
    object QrChequesIDUSUARIO: TIntegerField
      FieldName = 'IDUSUARIO'
      Origin = 'PDV_FECHAMENTOCUPOM.IDUSUARIO'
      Required = True
    end
    object QrChequesCODIGOCONDICAOPAGAMENTO: TIntegerField
      FieldName = 'CODIGOCONDICAOPAGAMENTO'
      Origin = 'PDV_FECHAMENTOCUPOM.CODIGOCONDICAOPAGAMENTO'
      Required = True
    end
    object QrChequesTERMINAL: TIBStringField
      FieldName = 'TERMINAL'
      Origin = 'PDV_FECHAMENTOCUPOM.TERMINAL'
      Required = True
      FixedChar = True
      Size = 4
    end
    object QrChequesNCP: TIBStringField
      FieldName = 'NCP'
      Origin = 'PDV_FECHAMENTOCUPOM.NCP'
      Required = True
      FixedChar = True
      Size = 10
    end
    object QrChequesREPIQUE: TFloatField
      FieldName = 'REPIQUE'
      Origin = 'PDV_FECHAMENTOCUPOM.REPIQUE'
    end
    object QrChequesCONTRAVALE: TFloatField
      FieldName = 'CONTRAVALE'
      Origin = 'PDV_FECHAMENTOCUPOM.CONTRAVALE'
    end
    object QrChequesTROCO: TFloatField
      FieldName = 'TROCO'
      Origin = 'PDV_FECHAMENTOCUPOM.TROCO'
    end
    object QrChequesVALORRECEBIDO: TFloatField
      FieldName = 'VALORRECEBIDO'
      Origin = 'PDV_FECHAMENTOCUPOM.VALORRECEBIDO'
      currency = True
    end
    object QrChequesBANCO: TIBStringField
      FieldName = 'BANCO'
      Origin = 'PDV_FECHAMENTOCUPOM.BANCO'
      Size = 4
    end
    object QrChequesNUMEROCHEQUE: TIBStringField
      FieldName = 'NUMEROCHEQUE'
      Origin = 'PDV_FECHAMENTOCUPOM.NUMEROCHEQUE'
      Size = 13
    end
    object QrChequesAGENCIA: TIBStringField
      FieldName = 'AGENCIA'
      Origin = 'PDV_FECHAMENTOCUPOM.AGENCIA'
      Size = 13
    end
    object QrChequesCONTA: TIBStringField
      FieldName = 'CONTA'
      Origin = 'PDV_FECHAMENTOCUPOM.CONTA'
      Size = 13
    end
    object QrChequesDATAPRE: TIBStringField
      FieldName = 'DATAPRE'
      Origin = 'PDV_FECHAMENTOCUPOM.DATAPRE'
      Size = 10
    end
    object QrChequesPES_CPF_CNPJ_A: TIBStringField
      FieldName = 'PES_CPF_CNPJ_A'
      Origin = 'PESSOA.PES_CPF_CNPJ_A'
    end
  end
  object QrSangrias: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT DATA, (VALOR * -1) AS VALOR, DESCRICAO  FROM PDV_MOVIMENT' +
        'OEXTRA  WHERE CFG_CODCONFIG = 1 AND VALOR < 0')
    Left = 528
    Top = 72
    object QrSangriasDATA: TDateTimeField
      FieldName = 'DATA'
      Origin = 'PDV_MOVIMENTOEXTRA.DATA'
      Required = True
    end
    object QrSangriasVALOR: TFloatField
      FieldName = 'VALOR'
      currency = True
    end
    object QrSangriasDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Origin = 'PDV_MOVIMENTOEXTRA.DESCRICAO'
      Size = 40
    end
  end
  object RvAutocom: TRvProject
    Engine = RvSystem
    ProjectFile = 'RPDV.rav'
    Left = 168
    Top = 8
  end
  object RvProdutos: TRvDataSetConnection
    FieldAliasList.Strings = (
      '')
    RuntimeVisibility = rtDeveloper
    DataSet = QrProdutos
    Left = 24
    Top = 128
  end
  object RvSystem: TRvSystem
    TitleSetup = 'Sistema Autocom Plus - Op'#231#245'es'
    TitleStatus = 'Sistema Autocom Plus - Report Status'
    TitlePreview = 'Sistema Autocom Plus - Visualiza'#231#227'o do Relat'#243'rio'
    SystemSetups = [ssAllowCopies, ssAllowCollate, ssAllowDuplex, ssAllowDestPreview, ssAllowDestPrinter, ssAllowDestFile, ssAllowPrinterSetup, ssAllowPreviewSetup]
    SystemFiler.StatusFormat = 'Processando P'#225'gina %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Imprimindo P'#225'gina %p'
    SystemPrinter.Title = 'Sistema Autocom Plus'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 240
    Top = 8
  end
  object RvIndicadores: TRvDataSetConnection
    FieldAliasList.Strings = (
      '')
    RuntimeVisibility = rtDeveloper
    DataSet = QrIndicadores
    Left = 96
    Top = 128
  end
  object RvGrupos: TRvDataSetConnection
    FieldAliasList.Strings = (
      '')
    RuntimeVisibility = rtDeveloper
    DataSet = QrGrupos
    Left = 168
    Top = 128
  end
  object RvCheques: TRvDataSetConnection
    FieldAliasList.Strings = (
      '')
    RuntimeVisibility = rtDeveloper
    DataSet = QrCheques
    Left = 376
    Top = 128
  end
  object RvHoras: TRvDataSetConnection
    FieldAliasList.Strings = (
      '')
    RuntimeVisibility = rtDeveloper
    DataSet = CdsHoras
    Left = 448
    Top = 128
  end
  object RvSangrias: TRvDataSetConnection
    FieldAliasList.Strings = (
      '')
    RuntimeVisibility = rtDeveloper
    DataSet = QrSangrias
    Left = 528
    Top = 128
  end
  object CdsHoras: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'Hora'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'Clientes'
        DataType = ftInteger
      end
      item
        Name = 'Valor'
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'Hora'
        DescFields = 'Hora'
        Fields = 'Hora'
        Options = [ixPrimary, ixUnique, ixDescending]
      end>
    IndexName = 'Hora'
    Params = <>
    StoreDefs = True
    Left = 456
    Top = 72
    object CdsHorasHora: TStringField
      FieldName = 'Hora'
    end
    object CdsHorasClientes: TIntegerField
      FieldName = 'Clientes'
    end
    object CdsHorasValor: TFloatField
      FieldName = 'Valor'
      currency = True
    end
  end
  object RvOperadores: TRvDataSetConnection
    FieldAliasList.Strings = (
      '')
    RuntimeVisibility = rtDeveloper
    DataSet = QrOperadores
    Left = 600
    Top = 128
  end
  object QrOperadores: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT  U.IDUSUARIO, U.NOMEUSUARIO,  (SELECT COUNT(CFG_CODCONFIG' +
        ') FROM PDV_CABECALHOCUPOM WHERE (SITUACAO <> 1 OR SITUACAO IS NU' +
        'LL)  AND CFG_CODCONFIG = 1) AS QUANTIDADE, SUM(PC.VALORCUPOM - A' +
        'CRESCIMO) AS VALOR, (SELECT COUNT(CFG_CODCONFIG) FROM PDV_DETALH' +
        'ECUPOM WHERE SITUACAO = 1  AND CFG_CODCONFIG = 1)  AS CANCITEM, ' +
        '(SELECT COUNT(CFG_CODCONFIG) FROM PDV_CABECALHOCUPOM WHERE SITUA' +
        'CAO = 1  AND CFG_CODCONFIG = 1)  AS CANCVENDA, COUNT(ACRESCIMO) ' +
        'AS QTDEACRESCIMO,  SUM(ACRESCIMO) AS VALORACRESCIMO,  COUNT(DESC' +
        'ONTO) AS QTDEDESCONTO,  SUM(DESCONTO) AS VALORDESCONTO,  (SELECT' +
        ' COUNT(VALOR) FROM PDV_MOVIMENTOEXTRA WHERE VALOR > 0  AND CFG_C' +
        'ODCONFIG =  1 ) AS FCXQTDE,  (SELECT SUM(VALOR) FROM PDV_MOVIMEN' +
        'TOEXTRA WHERE VALOR > 0  AND CFG_CODCONFIG =  1 ) AS FCXVALOR  F' +
        'ROM PDV_CABECALHOCUPOM PC INNER JOIN USUARIOSISTEMA U ON (U.IDUS' +
        'UARIO = PC.IDUSUARIO)  WHERE PC.CFG_CODCONFIG = 1 GROUP BY U.IDU' +
        'SUARIO, U.NOMEUSUARIO ORDER BY U.IDUSUARIO')
    Left = 600
    Top = 72
    object QrOperadoresIDUSUARIO: TIntegerField
      FieldName = 'IDUSUARIO'
      Required = True
    end
    object QrOperadoresNOMEUSUARIO: TIBStringField
      FieldName = 'NOMEUSUARIO'
      Required = True
    end
    object QrOperadoresQUANTIDADE: TIntegerField
      FieldName = 'QUANTIDADE'
    end
    object QrOperadoresVALOR: TFloatField
      FieldName = 'VALOR'
      currency = True
    end
    object QrOperadoresCANCITEM: TIntegerField
      FieldName = 'CANCITEM'
    end
    object QrOperadoresCANCVENDA: TIntegerField
      FieldName = 'CANCVENDA'
    end
    object n: TIntegerField
      FieldName = 'QTDEACRESCIMO'
      Required = True
    end
    object QrOperadoresVALORACRESCIMO: TFloatField
      FieldName = 'VALORACRESCIMO'
      currency = True
    end
    object QrOperadoresQTDEDESCONTO: TIntegerField
      FieldName = 'QTDEDESCONTO'
      Required = True
    end
    object QrOperadoresVALORDESCONTO: TFloatField
      FieldName = 'VALORDESCONTO'
      currency = True
    end
    object QrOperadoresFCXQTDE: TIntegerField
      FieldName = 'FCXQTDE'
    end
    object QrOperadoresFCXVALOR: TFloatField
      FieldName = 'FCXVALOR'
      currency = True
    end
  end
  object RvOperadoresF: TRvDataSetConnection
    FieldAliasList.Strings = (
      '')
    RuntimeVisibility = rtDeveloper
    DataSet = CdsOperadoresF
    Left = 680
    Top = 128
  end
  object CdsOperadoresF: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CodigoCondicaoPagamento'
        DataType = ftFloat
      end
      item
        Name = 'CondicaoPagamento'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'SangriaQtde'
        DataType = ftFloat
      end
      item
        Name = 'SangriaValor'
        DataType = ftFloat
      end
      item
        Name = 'FinalizadoraQtde'
        DataType = ftFloat
      end
      item
        Name = 'FinalizadoraValor'
        DataType = ftFloat
      end
      item
        Name = 'Repique'
        DataType = ftFloat
      end
      item
        Name = 'ContraVale'
        DataType = ftFloat
      end
      item
        Name = 'SomaSaldo'
        DataType = ftBoolean
      end
      item
        Name = 'IdUsuario'
        DataType = ftFloat
      end
      item
        Name = 'Fcx'
        DataType = ftFloat
      end
      item
        Name = 'Troco'
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'CodigoCondicaoPagamento'
        DescFields = 'CodigoCondicaoPagamento'
        Fields = 'CodigoCondicaoPagamento'
        Options = [ixDescending]
      end>
    IndexName = 'CodigoCondicaoPagamento'
    Params = <>
    StoreDefs = True
    OnCalcFields = CdsOperadoresFCalcFields
    Left = 680
    Top = 72
    object CdsOperadoresFCodigoCondicaoPagamento: TFloatField
      FieldName = 'CodigoCondicaoPagamento'
    end
    object CdsOperadoresFCondicaoPagamento: TStringField
      FieldName = 'CondicaoPagamento'
      Size = 40
    end
    object CdsOperadoresFSangriaQtde: TFloatField
      FieldName = 'SangriaQtde'
    end
    object CdsOperadoresFSangriaValor: TFloatField
      FieldName = 'SangriaValor'
      currency = True
    end
    object CdsOperadoresFFinalizadoraQtde: TFloatField
      FieldName = 'FinalizadoraQtde'
    end
    object CdsOperadoresFFinalizadoraValor: TFloatField
      FieldName = 'FinalizadoraValor'
      currency = True
    end
    object CdsOperadoresFRepique: TFloatField
      FieldName = 'Repique'
      currency = True
    end
    object CdsOperadoresFContraVale: TFloatField
      FieldName = 'ContraVale'
      currency = True
    end
    object CdsOperadoresFSaldoFinal: TFloatField
      FieldKind = fkCalculated
      FieldName = 'SaldoFinal'
      currency = True
      Calculated = True
    end
    object CdsOperadoresFSomaSaldo: TBooleanField
      FieldName = 'SomaSaldo'
    end
    object CdsOperadoresFIdUsuario: TFloatField
      FieldName = 'IdUsuario'
    end
    object CdsOperadoresFSomaSaldoSimbolo: TStringField
      FieldKind = fkCalculated
      FieldName = 'SomaSaldoSimbolo'
      Size = 1
      Calculated = True
    end
    object CdsOperadoresFFcx: TFloatField
      FieldName = 'Fcx'
      currency = True
    end
    object CdsOperadoresFFinalizadoraValorL: TFloatField
      FieldKind = fkCalculated
      FieldName = 'FinalizadoraValorL'
      currency = True
      Calculated = True
    end
    object CdsOperadoresFTroco: TFloatField
      FieldName = 'Troco'
      currency = True
    end
  end
  object QrGrupos2: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    ParamCheck = False
    SQL.Strings = (
      
        'SELECT DISTINCT  GP.GRUPOPRODUTO, GP.CODIGOGRUPOPRODUTO FROM PRO' +
        'DUTO P, SUBGRUPOPRODUTO SGP, PDV_DETALHECUPOM PD'
      
        'INNER JOIN GRUPOPRODUTO GP ON (SGP.CODIGOGRUPOPRODUTO = GP.CODIG' +
        'OGRUPOPRODUTO'
      
        'AND SGP.CODIGOSUBGRUPOPRODUTO = P.CODIGOSUBGRUPOPRODUTO AND P.CO' +
        'DIGOPRODUTO = PD.CODIGOPRODUTO)'
      
        'WHERE (PD.SITUACAO IS NULL OR PD.SITUACAO <> 1) AND P.CODIGOSUBG' +
        'RUPOPRODUTO = SGP.CODIGOSUBGRUPOPRODUTO'
      
        'AND SGP.CODIGOGRUPOPRODUTO = GP.CODIGOGRUPOPRODUTO  AND PD.CFG_C' +
        'ODCONFIG = 1'
      'GROUP BY GP.GRUPOPRODUTO, SGP.SUBGRUPO, GP.CODIGOGRUPOPRODUTO'
      'ORDER BY GP.CODIGOGRUPOPRODUTO, SGP.SUBGRUPO')
    Left = 259
    Top = 72
    object QrGrupos2GRUPOPRODUTO: TIBStringField
      FieldName = 'GRUPOPRODUTO'
      Required = True
      Size = 50
    end
    object QrGrupos2CODIGOGRUPOPRODUTO: TIntegerField
      FieldName = 'CODIGOGRUPOPRODUTO'
      Required = True
    end
  end
  object RvGrupos2: TRvDataSetConnection
    FieldAliasList.Strings = (
      '')
    RuntimeVisibility = rtDeveloper
    DataSet = QrGrupos2
    Left = 256
    Top = 128
  end
  object generico: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 528
    Top = 8
  end
  object QROperadorcancelados: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 320
    Top = 168
    object QROperadorcanceladosDATAHORA: TDateTimeField
      FieldName = 'DATAHORA'
      Origin = 'PDV_DETALHECUPOM.DATAHORA'
      Required = True
    end
    object QROperadorcanceladosPES_NOME_A: TIBStringField
      FieldName = 'PES_NOME_A'
      Origin = 'PESSOA.PES_NOME_A'
      Required = True
      Size = 50
    end
    object QROperadorcanceladosNOMEPRODUTO: TIBStringField
      FieldName = 'NOMEPRODUTO'
      Origin = 'PRODUTO.NOMEPRODUTO'
      Required = True
      Size = 100
    end
    object QROperadorcanceladosMOTIVO_CANCELAMENTO: TIBStringField
      FieldName = 'MOTIVO_CANCELAMENTO'
      Origin = 'PDV_DETALHECUPOM.MOTIVO_CANCELAMENTO'
      Size = 100
    end
    object QROperadorcanceladosNUMEROPEDIDO: TIntegerField
      FieldName = 'NUMEROPEDIDO'
      Origin = 'PDV_DETALHECUPOM.NUMEROPEDIDO'
    end
    object QROperadorcanceladosQTDE: TFloatField
      FieldName = 'QTDE'
      Origin = 'PDV_DETALHECUPOM.QTDE'
    end
  end
  object RVOperadorCancelados: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = QROperadorcancelados
    Left = 320
    Top = 216
  end
  object Rvextratocliente: TRvDataSetConnection
    FieldAliasList.Strings = (
      '')
    RuntimeVisibility = rtDeveloper
    DataSet = CDSeXTRATOcliente
    Left = 40
    Top = 248
  end
  object CDSeXTRATOcliente: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CDSeXTRATOclienteField1'
      end>
    IndexDefs = <
      item
        Name = 'indice'
        Fields = 'data;codigo'
        Options = [ixPrimary, ixUnique]
      end>
    IndexName = 'indice'
    Params = <>
    StoreDefs = True
    Left = 40
    Top = 192
    object CDSeXTRATOclientedata: TDateField
      FieldName = 'data'
    end
    object CDSeXTRATOclientecodigo: TIntegerField
      FieldName = 'codigo'
    end
    object CDSeXTRATOclienteproduto: TStringField
      FieldName = 'produto'
      Size = 100
    end
    object CDSeXTRATOclienteqtde: TFloatField
      FieldName = 'qtde'
    end
    object CDSeXTRATOclientevalor: TFloatField
      FieldName = 'valor'
    end
  end
  object generico2: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 584
    Top = 8
  end
end
