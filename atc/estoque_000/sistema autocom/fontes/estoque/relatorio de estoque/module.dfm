object Dm: TDm
  OldCreateOrder = False
  Left = 218
  Top = 304
  Height = 256
  Width = 531
  object Tbl_Produto: TIBQuery
    Database = dbautocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'Select * from Produto P inner Join Estoque E on (P.CodigoProduto' +
        ' = E.CodigoProduto) order by P.NomeProduto')
    Left = 160
    Top = 16
    object Tbl_ProdutoCODIGOPRODUTO: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGOPRODUTO'
      Origin = 'PRODUTO.CODIGOPRODUTO'
      Required = True
    end
    object Tbl_ProdutoNOMEPRODUTO: TIBStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 39
      FieldName = 'NOMEPRODUTO'
      Origin = 'PRODUTO.NOMEPRODUTO'
      Required = True
      Size = 110
    end
    object Tbl_ProdutoCODIGOESTOQUE: TIntegerField
      FieldName = 'CODIGOESTOQUE'
      Origin = 'ESTOQUE.CODIGOESTOQUE'
      Required = True
      Visible = False
    end
    object Tbl_ProdutoESTOQUEATUAL: TFloatField
      FieldName = 'ESTOQUEATUAL'
      Origin = 'ESTOQUE.ESTOQUEATUAL'
      Visible = False
    end
    object Tbl_ProdutoESTOQUEMINIMO: TFloatField
      FieldName = 'ESTOQUEMINIMO'
      Origin = 'ESTOQUE.ESTOQUEMINIMO'
      Visible = False
    end
    object Tbl_ProdutoESTOQUEMAXIMO: TFloatField
      FieldName = 'ESTOQUEMAXIMO'
      Origin = 'ESTOQUE.ESTOQUEMAXIMO'
      Visible = False
    end
  end
  object Transaction: TIBTransaction
    Active = False
    DefaultDatabase = dbautocom
    AutoStopAction = saNone
    Left = 88
    Top = 16
  end
  object dbautocom: TIBDatabase
    DatabaseName = '10.1.2.240:c:\autocom\dados\autocom.gdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = Transaction
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 24
    Top = 16
  end
  object rede: TIBQuery
    Database = dbautocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 472
    Top = 8
  end
  object rede2: TIBQuery
    Database = dbautocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 472
    Top = 56
  end
  object Tbl_SubGrupo: TIBQuery
    Database = dbautocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from SUBGRUPOPRODUTO'
      'where CODIGOGRUPOPRODUTO = :CODIGOGRUPOPRODUTO'
      'order by SUBGRUPO')
    Left = 256
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CODIGOGRUPOPRODUTO'
        ParamType = ptUnknown
      end>
    object Tbl_SubGrupoCODIGOSUBGRUPOPRODUTO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGOSUBGRUPOPRODUTO'
      Origin = 'SUBGRUPOPRODUTO.CODIGOSUBGRUPOPRODUTO'
      Required = True
      Visible = False
    end
    object Tbl_SubGrupoCODIGOSUBGRUPO: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 12
      FieldName = 'CODIGOSUBGRUPO'
      Origin = 'SUBGRUPOPRODUTO.CODIGOSUBGRUPO'
      Required = True
    end
    object Tbl_SubGrupoCODIGOGRUPOPRODUTO: TIntegerField
      FieldName = 'CODIGOGRUPOPRODUTO'
      Origin = 'SUBGRUPOPRODUTO.CODIGOGRUPOPRODUTO'
      Required = True
      Visible = False
    end
    object Tbl_SubGrupoSUBGRUPO: TIBStringField
      DisplayLabel = 'Nome do SubGrupo'
      DisplayWidth = 56
      FieldName = 'SUBGRUPO'
      Origin = 'SUBGRUPOPRODUTO.SUBGRUPO'
      Required = True
      Size = 50
    end
    object Tbl_SubGrupoOBSERVACAO: TIBStringField
      FieldName = 'OBSERVACAO'
      Origin = 'SUBGRUPOPRODUTO.OBSERVACAO'
      Visible = False
      Size = 10000
    end
  end
  object Tbl_Prateleira: TIBQuery
    Database = dbautocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from PRATELEIRA WHERE CODSECAO = :CODSECAO ')
    Left = 40
    Top = 72
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'CODSECAO'
        ParamType = ptUnknown
      end>
    object Tbl_PrateleiraCODPRATELEIRA: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = 'C'#243'digo da Prateleira'
      DisplayWidth = 45
      FieldName = 'CODPRATELEIRA'
      Origin = 'PRATELEIRA.CODPRATELEIRA'
      Visible = False
    end
    object Tbl_PrateleiraCODSECAO: TIntegerField
      FieldName = 'CODSECAO'
      Origin = 'PRATELEIRA.CODSECAO'
      Required = True
      Visible = False
    end
    object Tbl_PrateleiraCODIGOPRATELEIRA: TIntegerField
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 68
      FieldName = 'CODIGOPRATELEIRA'
      Origin = 'PRATELEIRA.CODIGOPRATELEIRA'
      Required = True
    end
  end
  object Tbl_Grupo: TIBQuery
    Database = dbautocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from GRUPOPRODUTO order by GRUPOPRODUTO')
    Left = 40
    Top = 136
    object Tbl_GrupoCODIGOGRUPOPRODUTO: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 12
      FieldName = 'CODIGOGRUPOPRODUTO'
      Origin = 'GRUPOPRODUTO.CODIGOGRUPOPRODUTO'
      Required = True
    end
    object Tbl_GrupoGRUPOPRODUTO: TIBStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 56
      FieldName = 'GRUPOPRODUTO'
      Origin = 'GRUPOPRODUTO.GRUPOPRODUTO'
      Required = True
      Size = 50
    end
    object Tbl_GrupoOBSERVACAO: TIBStringField
      FieldName = 'OBSERVACAO'
      Origin = 'GRUPOPRODUTO.OBSERVACAO'
      Visible = False
      Size = 10000
    end
    object Tbl_GrupoGERAREQUIPAMENTO: TIBStringField
      FieldName = 'GERAREQUIPAMENTO'
      Origin = 'GRUPOPRODUTO.GERAREQUIPAMENTO'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object Tbl_GrupoGERARCOMPONENTE: TIBStringField
      FieldName = 'GERARCOMPONENTE'
      Origin = 'GRUPOPRODUTO.GERARCOMPONENTE'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object Tbl_GrupoCODIGOIMPRESSORA: TIntegerField
      FieldName = 'CODIGOIMPRESSORA'
      Origin = 'GRUPOPRODUTO.CODIGOIMPRESSORA'
      Visible = False
    end
  end
  object Tbl_Secao: TIBQuery
    Database = dbautocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from SECAO order by DESCRICAO')
    Left = 232
    Top = 80
    object Tbl_SecaoCODSECAO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODSECAO'
      Origin = 'SECAO.CODSECAO'
      Visible = False
    end
    object Tbl_SecaoCFG_CODCONFIG: TIntegerField
      FieldName = 'CFG_CODCONFIG'
      Origin = 'SECAO.CFG_CODCONFIG'
      Required = True
      Visible = False
    end
    object Tbl_SecaoCODIGOSECAO: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = 'C'#243'digo'
      DisplayWidth = 12
      FieldName = 'CODIGOSECAO'
      Origin = 'SECAO.CODIGOSECAO'
      Required = True
    end
    object Tbl_SecaoDESCRICAO: TIBStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 56
      FieldName = 'DESCRICAO'
      Origin = 'SECAO.DESCRICAO'
      Required = True
      Size = 50
    end
  end
  object Tbl_Relatorio: TIBQuery
    Database = dbautocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT P.CODIGOPRODUTO, P.NOMEPRODUTO, E.ESTOQUEMAXIMO, E.ESTOQU' +
        'EMINIMO, E.ESTOQUEATUAL, GP.CODIGOGRUPOPRODUTO, GP.GRUPOPRODUTO,' +
        ' SP.CODIGOSUBGRUPOPRODUTO, SP.SUBGRUPO, S.CODIGOSECAO, S.DESCRIC' +
        'AO, PP.CODPRATELEIRA, PP.CODIGOPRATELEIRA, PP.CODSECAO FROM PROD' +
        'UTO P, ESTOQUE E, GRUPOPRODUTO GP, SUBGRUPOPRODUTO SP, SECAO S, ' +
        'PRATELEIRA PP WHERE P.CODIGOPRODUTO = E.CODIGOPRODUTO AND P.CODI' +
        'GOSUBGRUPOPRODUTO = SP.CODIGOSUBGRUPOPRODUTO AND SP.CODIGOGRUPOP' +
        'RODUTO = GP.CODIGOGRUPOPRODUTO AND E.CODPRATELEIRA = PP.CODPRATE' +
        'LEIRA AND PP.CODSECAO = S.CODSECAO ORDER BY P.CODIGOPRODUTO')
    Left = 336
    Top = 8
    object Tbl_RelatorioCODIGOPRODUTO: TIntegerField
      FieldName = 'CODIGOPRODUTO'
      Origin = 'PRODUTO.CODIGOPRODUTO'
      Required = True
    end
    object Tbl_RelatorioNOMEPRODUTO: TIBStringField
      FieldName = 'NOMEPRODUTO'
      Origin = 'PRODUTO.NOMEPRODUTO'
      Required = True
      Size = 102
    end
    object Tbl_RelatorioESTOQUEMAXIMO: TFloatField
      FieldName = 'ESTOQUEMAXIMO'
      Origin = 'ESTOQUE.ESTOQUEMAXIMO'
    end
    object Tbl_RelatorioESTOQUEMINIMO: TFloatField
      FieldName = 'ESTOQUEMINIMO'
      Origin = 'ESTOQUE.ESTOQUEMINIMO'
    end
    object Tbl_RelatorioESTOQUEATUAL: TFloatField
      FieldName = 'ESTOQUEATUAL'
      Origin = 'ESTOQUE.ESTOQUEATUAL'
    end
    object Tbl_RelatorioCODIGOGRUPOPRODUTO: TIntegerField
      FieldName = 'CODIGOGRUPOPRODUTO'
      Origin = 'GRUPOPRODUTO.CODIGOGRUPOPRODUTO'
      Required = True
    end
    object Tbl_RelatorioGRUPOPRODUTO: TIBStringField
      FieldName = 'GRUPOPRODUTO'
      Origin = 'GRUPOPRODUTO.GRUPOPRODUTO'
      Required = True
      Size = 50
    end
    object Tbl_RelatorioCODIGOSUBGRUPOPRODUTO: TIntegerField
      FieldName = 'CODIGOSUBGRUPOPRODUTO'
      Origin = 'SUBGRUPOPRODUTO.CODIGOSUBGRUPOPRODUTO'
      Required = True
    end
    object Tbl_RelatorioSUBGRUPO: TIBStringField
      FieldName = 'SUBGRUPO'
      Origin = 'SUBGRUPOPRODUTO.SUBGRUPO'
      Required = True
      Size = 50
    end
    object Tbl_RelatorioCODIGOSECAO: TIntegerField
      FieldName = 'CODIGOSECAO'
      Origin = 'SECAO.CODIGOSECAO'
      Required = True
    end
    object Tbl_RelatorioDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Origin = 'SECAO.DESCRICAO'
      Required = True
      Size = 50
    end
    object Tbl_RelatorioCODPRATELEIRA: TIntegerField
      FieldName = 'CODPRATELEIRA'
      Origin = 'PRATELEIRA.CODPRATELEIRA'
      Required = True
    end
    object Tbl_RelatorioCODIGOPRATELEIRA: TIntegerField
      FieldName = 'CODIGOPRATELEIRA'
      Origin = 'PRATELEIRA.CODIGOPRATELEIRA'
      Required = True
    end
    object Tbl_RelatorioCODSECAO: TIntegerField
      FieldName = 'CODSECAO'
      Origin = 'PRATELEIRA.CODSECAO'
      Required = True
    end
  end
end
