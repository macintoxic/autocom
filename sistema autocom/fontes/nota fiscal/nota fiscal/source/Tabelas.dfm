object frmTabelas: TfrmTabelas
  Left = 16
  Top = 164
  Width = 748
  Height = 218
  Caption = 'frmTabelas'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object IBTransaction1: TIBTransaction
    Active = False
    DefaultDatabase = DbAutocom
    AutoStopAction = saRollbackRetaining
    Left = 672
    Top = 87
  end
  object DbAutocom: TIBDatabase
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    AllowStreamedConnected = False
    Left = 672
    Top = 23
  end
  object rede: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 600
    Top = 15
  end
  object rede2: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 600
    Top = 63
  end
  object tbl_Produto: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT Produto.CODIGOPRODUTO, Produto.NOMEPRODUTO, TabelaICMSPro' +
        'duto.ALIQUOTAICMS, Produto.ALIQUOTAIPI, Produto.PESOBRUTO, Produ' +
        'to.PESOLIQUIDO, ClassificacaoFiscal.CODIGOCLASSIFICACAOFISCAL, C' +
        'lassificacaoFiscal.CLASSIFICACAOFISCAL, SituacaoTributaria.CODIG' +
        'OSITUACAOTRIBUTARIA, SituacaoTributaria.SITUACAOTRIBUTARIA FROM ' +
        'ClassificacaoFiscal, Produto, SituacaoTributaria, TabelaICMSProd' +
        'uto')
    Left = 314
    Top = 72
  end
  object tbl_Cliente: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT * FROM Cliente INNER JOIN Pessoa ON (Cliente.PES_CODPESSO' +
        'A = Pessoa.PES_CODPESSOA)')
    Left = 18
    Top = 15
    object tbl_ClienteCLI_CODCLIENTE: TIntegerField
      FieldName = 'CLI_CODCLIENTE'
      Origin = 'CLIENTE.CLI_CODCLIENTE'
      Required = True
      Visible = False
    end
    object tbl_ClienteCODIGOCLIENTE: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGOCLIENTE'
      Origin = 'CLIENTE.CODIGOCLIENTE'
      Required = True
    end
    object tbl_ClientePES_CODPESSOA: TIntegerField
      FieldName = 'PES_CODPESSOA'
      Origin = 'CLIENTE.PES_CODPESSOA'
      Required = True
      Visible = False
    end
    object tbl_ClienteCON_CODCONTA: TIntegerField
      FieldName = 'CON_CODCONTA'
      Origin = 'CLIENTE.CON_CODCONTA'
      Visible = False
    end
    object tbl_ClienteVEN_CODVENDEDOR: TIntegerField
      FieldName = 'VEN_CODVENDEDOR'
      Origin = 'CLIENTE.VEN_CODVENDEDOR'
      Visible = False
    end
    object tbl_ClienteCODIGOSISTEMACOMPRA: TIntegerField
      FieldName = 'CODIGOSISTEMACOMPRA'
      Origin = 'CLIENTE.CODIGOSISTEMACOMPRA'
      Visible = False
    end
    object tbl_ClienteCODIGOPOTENCIALCLIENTE: TIntegerField
      FieldName = 'CODIGOPOTENCIALCLIENTE'
      Origin = 'CLIENTE.CODIGOPOTENCIALCLIENTE'
      Visible = False
    end
    object tbl_ClienteCODIGOOBJECAOCOMPRA: TIntegerField
      FieldName = 'CODIGOOBJECAOCOMPRA'
      Origin = 'CLIENTE.CODIGOOBJECAOCOMPRA'
      Visible = False
    end
    object tbl_ClienteCODIGONATUREZAOPERACAO: TIntegerField
      FieldName = 'CODIGONATUREZAOPERACAO'
      Origin = 'CLIENTE.CODIGONATUREZAOPERACAO'
      Visible = False
    end
    object tbl_ClienteCODIGOFASEATENDIMENTO: TIntegerField
      FieldName = 'CODIGOFASEATENDIMENTO'
      Origin = 'CLIENTE.CODIGOFASEATENDIMENTO'
      Visible = False
    end
    object tbl_ClienteULTIMAALTERACAO: TDateTimeField
      FieldName = 'ULTIMAALTERACAO'
      Origin = 'CLIENTE.ULTIMAALTERACAO'
      Visible = False
    end
    object tbl_ClienteULTIMOCONTATO: TDateTimeField
      FieldName = 'ULTIMOCONTATO'
      Origin = 'CLIENTE.ULTIMOCONTATO'
      Visible = False
    end
    object tbl_ClientePREVISAOCONTATO: TDateTimeField
      FieldName = 'PREVISAOCONTATO'
      Origin = 'CLIENTE.PREVISAOCONTATO'
      Visible = False
    end
    object tbl_ClienteLIMITECREDITO: TFloatField
      FieldName = 'LIMITECREDITO'
      Origin = 'CLIENTE.LIMITECREDITO'
      Visible = False
    end
    object tbl_ClienteFUNCIONARIO: TIntegerField
      FieldName = 'FUNCIONARIO'
      Origin = 'CLIENTE.FUNCIONARIO'
      Visible = False
    end
    object tbl_ClienteOBSERVACAO: TIBStringField
      FieldName = 'OBSERVACAO'
      Origin = 'CLIENTE.OBSERVACAO'
      Visible = False
      Size = 10000
    end
    object tbl_ClienteCFG_CODCONFIG: TIntegerField
      FieldName = 'CFG_CODCONFIG'
      Origin = 'CLIENTE.CFG_CODCONFIG'
      Visible = False
    end
    object tbl_ClienteNOMEPAI: TIBStringField
      FieldName = 'NOMEPAI'
      Origin = 'CLIENTE.NOMEPAI'
      Visible = False
      Size = 50
    end
    object tbl_ClienteNOMEMAE: TIBStringField
      FieldName = 'NOMEMAE'
      Origin = 'CLIENTE.NOMEMAE'
      Visible = False
      Size = 50
    end
    object tbl_ClienteRELATORIO: TIBStringField
      FieldName = 'RELATORIO'
      Origin = 'CLIENTE.RELATORIO'
      Visible = False
      Size = 30
    end
    object tbl_ClienteLOGIN: TIBStringField
      FieldName = 'LOGIN'
      Origin = 'CLIENTE.LOGIN'
      Visible = False
      Size = 102
    end
    object tbl_ClienteSENHA: TIBStringField
      FieldName = 'SENHA'
      Origin = 'CLIENTE.SENHA'
      Visible = False
      Size = 10
    end
    object tbl_ClienteCLIENTEDESDE: TDateTimeField
      FieldName = 'CLIENTEDESDE'
      Origin = 'CLIENTE.CLIENTEDESDE'
      Visible = False
    end
    object tbl_ClienteDATAFUNDACAO: TDateTimeField
      FieldName = 'DATAFUNDACAO'
      Origin = 'CLIENTE.DATAFUNDACAO'
      Visible = False
    end
    object tbl_ClienteFORNECEDOR: TIBStringField
      FieldName = 'FORNECEDOR'
      Origin = 'CLIENTE.FORNECEDOR'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbl_ClienteCONTROLA_PRODCONV: TIBStringField
      FieldName = 'CONTROLA_PRODCONV'
      Origin = 'CLIENTE.CONTROLA_PRODCONV'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbl_ClientePES_CODPESSOA1: TIntegerField
      FieldName = 'PES_CODPESSOA1'
      Origin = 'PESSOA.PES_CODPESSOA'
      Required = True
      Visible = False
    end
    object tbl_ClienteTPE_CODTIPOPESSOA: TIntegerField
      FieldName = 'TPE_CODTIPOPESSOA'
      Origin = 'PESSOA.TPE_CODTIPOPESSOA'
      Required = True
      Visible = False
    end
    object tbl_ClientePES_NOME_A: TIBStringField
      DisplayLabel = 'Nome'
      FieldName = 'PES_NOME_A'
      Origin = 'PESSOA.PES_NOME_A'
      Required = True
      Size = 50
    end
    object tbl_ClientePES_APELIDO_A: TIBStringField
      FieldName = 'PES_APELIDO_A'
      Origin = 'PESSOA.PES_APELIDO_A'
      Visible = False
      Size = 50
    end
    object tbl_ClientePES_RG_IE_A: TIBStringField
      FieldName = 'PES_RG_IE_A'
      Origin = 'PESSOA.PES_RG_IE_A'
      Visible = False
    end
    object tbl_ClientePES_CPF_CNPJ_A: TIBStringField
      FieldName = 'PES_CPF_CNPJ_A'
      Origin = 'PESSOA.PES_CPF_CNPJ_A'
      Visible = False
    end
    object tbl_ClientePES_PROFISSAO_RAMO_A: TIBStringField
      FieldName = 'PES_PROFISSAO_RAMO_A'
      Origin = 'PESSOA.PES_PROFISSAO_RAMO_A'
      Visible = False
      Size = 50
    end
    object tbl_ClientePES_DATANASCIMENTO_D: TDateTimeField
      FieldName = 'PES_DATANASCIMENTO_D'
      Origin = 'PESSOA.PES_DATANASCIMENTO_D'
      Visible = False
    end
    object tbl_ClienteCOP_CODCONTATO_PRINCIPAL: TIntegerField
      FieldName = 'COP_CODCONTATO_PRINCIPAL'
      Origin = 'PESSOA.COP_CODCONTATO_PRINCIPAL'
      Visible = False
    end
    object tbl_ClienteTELEFONE1: TIBStringField
      FieldName = 'TELEFONE1'
      Origin = 'PESSOA.TELEFONE1'
      Visible = False
    end
    object tbl_ClientePES_OBSERVACOES_T: TIBStringField
      FieldName = 'PES_OBSERVACOES_T'
      Origin = 'PESSOA.PES_OBSERVACOES_T'
      Visible = False
      Size = 10000
    end
    object tbl_ClienteSEXO: TIBStringField
      FieldName = 'SEXO'
      Origin = 'PESSOA.SEXO'
      Visible = False
      Size = 1
    end
  end
  object tbl_Fornecedor: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT * FROM Fornecedor INNER JOIN Pessoa ON (Fornecedor.PES_CO' +
        'DPESSOA = Pessoa.PES_CODPESSOA)')
    Left = 152
    Top = 15
    object tbl_FornecedorFRN_CODFORNECEDOR: TIntegerField
      FieldName = 'FRN_CODFORNECEDOR'
      Origin = 'FORNECEDOR.FRN_CODFORNECEDOR'
      Required = True
      Visible = False
    end
    object tbl_FornecedorCODIGOFORNECEDOR: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGOFORNECEDOR'
      Origin = 'FORNECEDOR.CODIGOFORNECEDOR'
      Required = True
    end
    object tbl_FornecedorPES_CODPESSOA: TIntegerField
      FieldName = 'PES_CODPESSOA'
      Origin = 'FORNECEDOR.PES_CODPESSOA'
      Required = True
      Visible = False
    end
    object tbl_FornecedorCON_CODCONTA: TIntegerField
      FieldName = 'CON_CODCONTA'
      Origin = 'FORNECEDOR.CON_CODCONTA'
      Visible = False
    end
    object tbl_FornecedorCODIGONATUREZAOPERACAO: TIntegerField
      FieldName = 'CODIGONATUREZAOPERACAO'
      Origin = 'FORNECEDOR.CODIGONATUREZAOPERACAO'
      Visible = False
    end
    object tbl_FornecedorEMPREITEIRA: TIBStringField
      FieldName = 'EMPREITEIRA'
      Origin = 'FORNECEDOR.EMPREITEIRA'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbl_FornecedorOBSERVACAO: TIBStringField
      FieldName = 'OBSERVACAO'
      Origin = 'FORNECEDOR.OBSERVACAO'
      Visible = False
      Size = 10000
    end
    object tbl_FornecedorCFG_CODCONFIG: TIntegerField
      FieldName = 'CFG_CODCONFIG'
      Origin = 'FORNECEDOR.CFG_CODCONFIG'
      Visible = False
    end
    object tbl_FornecedorCLIENTE: TIBStringField
      FieldName = 'CLIENTE'
      Origin = 'FORNECEDOR.CLIENTE'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbl_FornecedorPES_CODPESSOA1: TIntegerField
      FieldName = 'PES_CODPESSOA1'
      Origin = 'PESSOA.PES_CODPESSOA'
      Required = True
      Visible = False
    end
    object tbl_FornecedorTPE_CODTIPOPESSOA: TIntegerField
      FieldName = 'TPE_CODTIPOPESSOA'
      Origin = 'PESSOA.TPE_CODTIPOPESSOA'
      Required = True
      Visible = False
    end
    object tbl_FornecedorPES_NOME_A: TIBStringField
      DisplayLabel = 'Nome'
      FieldName = 'PES_NOME_A'
      Origin = 'PESSOA.PES_NOME_A'
      Required = True
      Size = 50
    end
    object tbl_FornecedorPES_APELIDO_A: TIBStringField
      FieldName = 'PES_APELIDO_A'
      Origin = 'PESSOA.PES_APELIDO_A'
      Visible = False
      Size = 50
    end
    object tbl_FornecedorPES_RG_IE_A: TIBStringField
      FieldName = 'PES_RG_IE_A'
      Origin = 'PESSOA.PES_RG_IE_A'
      Visible = False
    end
    object tbl_FornecedorPES_CPF_CNPJ_A: TIBStringField
      FieldName = 'PES_CPF_CNPJ_A'
      Origin = 'PESSOA.PES_CPF_CNPJ_A'
      Visible = False
    end
    object tbl_FornecedorPES_PROFISSAO_RAMO_A: TIBStringField
      FieldName = 'PES_PROFISSAO_RAMO_A'
      Origin = 'PESSOA.PES_PROFISSAO_RAMO_A'
      Visible = False
      Size = 50
    end
    object tbl_FornecedorPES_DATANASCIMENTO_D: TDateTimeField
      FieldName = 'PES_DATANASCIMENTO_D'
      Origin = 'PESSOA.PES_DATANASCIMENTO_D'
      Visible = False
    end
    object tbl_FornecedorCOP_CODCONTATO_PRINCIPAL: TIntegerField
      FieldName = 'COP_CODCONTATO_PRINCIPAL'
      Origin = 'PESSOA.COP_CODCONTATO_PRINCIPAL'
      Visible = False
    end
    object tbl_FornecedorTELEFONE1: TIBStringField
      FieldName = 'TELEFONE1'
      Origin = 'PESSOA.TELEFONE1'
      Visible = False
    end
    object tbl_FornecedorPES_OBSERVACOES_T: TIBStringField
      FieldName = 'PES_OBSERVACOES_T'
      Origin = 'PESSOA.PES_OBSERVACOES_T'
      Visible = False
      Size = 10000
    end
    object tbl_FornecedorSEXO: TIBStringField
      FieldName = 'SEXO'
      Origin = 'PESSOA.SEXO'
      Visible = False
      Size = 1
    end
  end
  object tbl_Vendedor: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT * FROM Vendedor INNER JOIN Pessoa ON (Vendedor.PES_CODPES' +
        'SOA = Pessoa.PES_CODPESSOA)')
    Left = 152
    Top = 136
    object tbl_VendedorVEN_CODVENDEDOR: TIntegerField
      FieldName = 'VEN_CODVENDEDOR'
      Origin = 'VENDEDOR.VEN_CODVENDEDOR'
      Required = True
      Visible = False
    end
    object tbl_VendedorCODIGOVENDEDOR: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGOVENDEDOR'
      Origin = 'VENDEDOR.CODIGOVENDEDOR'
      Required = True
    end
    object tbl_VendedorPES_CODPESSOA: TIntegerField
      FieldName = 'PES_CODPESSOA'
      Origin = 'VENDEDOR.PES_CODPESSOA'
      Required = True
      Visible = False
    end
    object tbl_VendedorCON_CODCONTA: TIntegerField
      FieldName = 'CON_CODCONTA'
      Origin = 'VENDEDOR.CON_CODCONTA'
      Visible = False
    end
    object tbl_VendedorCOMISSAO: TFloatField
      FieldName = 'COMISSAO'
      Origin = 'VENDEDOR.COMISSAO'
      Visible = False
    end
    object tbl_VendedorSENHA: TIBStringField
      FieldName = 'SENHA'
      Origin = 'VENDEDOR.SENHA'
      Visible = False
      Size = 10
    end
    object tbl_VendedorCFG_CODCONFIG: TIntegerField
      FieldName = 'CFG_CODCONFIG'
      Origin = 'VENDEDOR.CFG_CODCONFIG'
      Visible = False
    end
    object tbl_VendedorVEN_CODVENDEDORSUP: TIntegerField
      FieldName = 'VEN_CODVENDEDORSUP'
      Origin = 'VENDEDOR.VEN_CODVENDEDORSUP'
      Visible = False
    end
    object tbl_VendedorEXPECTATIVA: TFloatField
      FieldName = 'EXPECTATIVA'
      Origin = 'VENDEDOR.EXPECTATIVA'
      Visible = False
    end
    object tbl_VendedorVEN_CODVENDEDORAGENTE: TIntegerField
      FieldName = 'VEN_CODVENDEDORAGENTE'
      Origin = 'VENDEDOR.VEN_CODVENDEDORAGENTE'
      Visible = False
    end
    object tbl_VendedorVEN_CODVENDEDORGERENTE: TIntegerField
      FieldName = 'VEN_CODVENDEDORGERENTE'
      Origin = 'VENDEDOR.VEN_CODVENDEDORGERENTE'
      Visible = False
    end
    object tbl_VendedorCODCOMISSAO: TIntegerField
      FieldName = 'CODCOMISSAO'
      Origin = 'VENDEDOR.CODCOMISSAO'
      Visible = False
    end
    object tbl_VendedorPES_CODPESSOA1: TIntegerField
      FieldName = 'PES_CODPESSOA1'
      Origin = 'PESSOA.PES_CODPESSOA'
      Required = True
      Visible = False
    end
    object tbl_VendedorTPE_CODTIPOPESSOA: TIntegerField
      FieldName = 'TPE_CODTIPOPESSOA'
      Origin = 'PESSOA.TPE_CODTIPOPESSOA'
      Required = True
      Visible = False
    end
    object tbl_VendedorPES_NOME_A: TIBStringField
      DisplayLabel = 'Nome'
      FieldName = 'PES_NOME_A'
      Origin = 'PESSOA.PES_NOME_A'
      Required = True
      Size = 50
    end
    object tbl_VendedorPES_APELIDO_A: TIBStringField
      FieldName = 'PES_APELIDO_A'
      Origin = 'PESSOA.PES_APELIDO_A'
      Visible = False
      Size = 50
    end
    object tbl_VendedorPES_RG_IE_A: TIBStringField
      FieldName = 'PES_RG_IE_A'
      Origin = 'PESSOA.PES_RG_IE_A'
      Visible = False
    end
    object tbl_VendedorPES_CPF_CNPJ_A: TIBStringField
      FieldName = 'PES_CPF_CNPJ_A'
      Origin = 'PESSOA.PES_CPF_CNPJ_A'
      Visible = False
    end
    object tbl_VendedorPES_PROFISSAO_RAMO_A: TIBStringField
      FieldName = 'PES_PROFISSAO_RAMO_A'
      Origin = 'PESSOA.PES_PROFISSAO_RAMO_A'
      Visible = False
      Size = 50
    end
    object tbl_VendedorPES_DATANASCIMENTO_D: TDateTimeField
      FieldName = 'PES_DATANASCIMENTO_D'
      Origin = 'PESSOA.PES_DATANASCIMENTO_D'
      Visible = False
    end
    object tbl_VendedorCOP_CODCONTATO_PRINCIPAL: TIntegerField
      FieldName = 'COP_CODCONTATO_PRINCIPAL'
      Origin = 'PESSOA.COP_CODCONTATO_PRINCIPAL'
      Visible = False
    end
    object tbl_VendedorTELEFONE1: TIBStringField
      FieldName = 'TELEFONE1'
      Origin = 'PESSOA.TELEFONE1'
      Visible = False
    end
    object tbl_VendedorPES_OBSERVACOES_T: TIBStringField
      FieldName = 'PES_OBSERVACOES_T'
      Origin = 'PESSOA.PES_OBSERVACOES_T'
      Visible = False
      Size = 10000
    end
    object tbl_VendedorSEXO: TIBStringField
      FieldName = 'SEXO'
      Origin = 'PESSOA.SEXO'
      Visible = False
      Size = 1
    end
  end
  object tbl_NaturezaOperacao: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM NaturezaOperacao')
    Left = 250
    Top = 15
    object tbl_NaturezaOperacaoCODIGONATUREZAOPERACAO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGONATUREZAOPERACAO'
      Origin = 'NATUREZAOPERACAO.CODIGONATUREZAOPERACAO'
      Required = True
    end
    object tbl_NaturezaOperacaoNATUREZAOPERACAO: TIBStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'NATUREZAOPERACAO'
      Origin = 'NATUREZAOPERACAO.NATUREZAOPERACAO'
      Required = True
      Size = 50
    end
    object tbl_NaturezaOperacaoCODIGOTIPOBASEICMS: TIntegerField
      FieldName = 'CODIGOTIPOBASEICMS'
      Origin = 'NATUREZAOPERACAO.CODIGOTIPOBASEICMS'
      Required = True
      Visible = False
    end
    object tbl_NaturezaOperacaoCODIGOTIPOBASEIPI: TIntegerField
      FieldName = 'CODIGOTIPOBASEIPI'
      Origin = 'NATUREZAOPERACAO.CODIGOTIPOBASEIPI'
      Required = True
      Visible = False
    end
    object tbl_NaturezaOperacaoALIQUOTAICMS: TFloatField
      FieldName = 'ALIQUOTAICMS'
      Origin = 'NATUREZAOPERACAO.ALIQUOTAICMS'
      Visible = False
    end
    object tbl_NaturezaOperacaoTRIBUTAICMS: TIBStringField
      FieldName = 'TRIBUTAICMS'
      Origin = 'NATUREZAOPERACAO.TRIBUTAICMS'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbl_NaturezaOperacaoTRIBUTAIPI: TIBStringField
      FieldName = 'TRIBUTAIPI'
      Origin = 'NATUREZAOPERACAO.TRIBUTAIPI'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbl_NaturezaOperacaoMOVIMENTAESTOQUE: TIBStringField
      FieldName = 'MOVIMENTAESTOQUE'
      Origin = 'NATUREZAOPERACAO.MOVIMENTAESTOQUE'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbl_NaturezaOperacaoGERACONTABILIDADE: TIBStringField
      FieldName = 'GERACONTABILIDADE'
      Origin = 'NATUREZAOPERACAO.GERACONTABILIDADE'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbl_NaturezaOperacaoMOVIMENTACONTAS: TIBStringField
      DisplayLabel = 'Movimenta Contas'
      FieldName = 'MOVIMENTACONTAS'
      Origin = 'NATUREZAOPERACAO.MOVIMENTACONTAS'
      FixedChar = True
      Size = 1
    end
    object tbl_NaturezaOperacaoIPIBASEICMS: TIBStringField
      FieldName = 'IPIBASEICMS'
      Origin = 'NATUREZAOPERACAO.IPIBASEICMS'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbl_NaturezaOperacaoDEVOLUCAO: TIBStringField
      FieldName = 'DEVOLUCAO'
      Origin = 'NATUREZAOPERACAO.DEVOLUCAO'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbl_NaturezaOperacaoTERCEIROS: TIBStringField
      FieldName = 'TERCEIROS'
      Origin = 'NATUREZAOPERACAO.TERCEIROS'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbl_NaturezaOperacaoDECRETOLEI: TIBStringField
      FieldName = 'DECRETOLEI'
      Origin = 'NATUREZAOPERACAO.DECRETOLEI'
      Visible = False
      Size = 10000
    end
    object tbl_NaturezaOperacaoCONTAICMS: TIntegerField
      FieldName = 'CONTAICMS'
      Origin = 'NATUREZAOPERACAO.CONTAICMS'
      Visible = False
    end
    object tbl_NaturezaOperacaoCONTAIPI: TIntegerField
      FieldName = 'CONTAIPI'
      Origin = 'NATUREZAOPERACAO.CONTAIPI'
      Visible = False
    end
    object tbl_NaturezaOperacaoCONTADESPESAS: TIntegerField
      FieldName = 'CONTADESPESAS'
      Origin = 'NATUREZAOPERACAO.CONTADESPESAS'
      Visible = False
    end
    object tbl_NaturezaOperacaoCONTASUBSTITUICAO: TIntegerField
      FieldName = 'CONTASUBSTITUICAO'
      Origin = 'NATUREZAOPERACAO.CONTASUBSTITUICAO'
      Visible = False
    end
    object tbl_NaturezaOperacaoCONTASEGURO: TIntegerField
      FieldName = 'CONTASEGURO'
      Origin = 'NATUREZAOPERACAO.CONTASEGURO'
      Visible = False
    end
    object tbl_NaturezaOperacaoCONTADESCONTO: TIntegerField
      FieldName = 'CONTADESCONTO'
      Origin = 'NATUREZAOPERACAO.CONTADESCONTO'
      Visible = False
    end
    object tbl_NaturezaOperacaoCONTAAPURACAOICMS: TIntegerField
      FieldName = 'CONTAAPURACAOICMS'
      Origin = 'NATUREZAOPERACAO.CONTAAPURACAOICMS'
      Visible = False
    end
    object tbl_NaturezaOperacaoCONTAFRETE: TIntegerField
      FieldName = 'CONTAFRETE'
      Origin = 'NATUREZAOPERACAO.CONTAFRETE'
      Visible = False
    end
    object tbl_NaturezaOperacaoCONTATOTALPRODUTO: TIntegerField
      FieldName = 'CONTATOTALPRODUTO'
      Origin = 'NATUREZAOPERACAO.CONTATOTALPRODUTO'
      Visible = False
    end
    object tbl_NaturezaOperacaoCONTAIPIFATURADO: TIntegerField
      FieldName = 'CONTAIPIFATURADO'
      Origin = 'NATUREZAOPERACAO.CONTAIPIFATURADO'
      Visible = False
    end
    object tbl_NaturezaOperacaoALIQUOTAISS: TFloatField
      FieldName = 'ALIQUOTAISS'
      Origin = 'NATUREZAOPERACAO.ALIQUOTAISS'
      Visible = False
    end
    object tbl_NaturezaOperacaoTRIBUTAISS: TIBStringField
      FieldName = 'TRIBUTAISS'
      Origin = 'NATUREZAOPERACAO.TRIBUTAISS'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbl_NaturezaOperacaoCONTAISS: TIntegerField
      FieldName = 'CONTAISS'
      Origin = 'NATUREZAOPERACAO.CONTAISS'
      Visible = False
    end
    object tbl_NaturezaOperacaoCONTADESPESAISS: TIntegerField
      FieldName = 'CONTADESPESAISS'
      Origin = 'NATUREZAOPERACAO.CONTADESPESAISS'
      Visible = False
    end
    object tbl_NaturezaOperacaoDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Origin = 'NATUREZAOPERACAO.DESCRICAO'
      Visible = False
      Size = 70
    end
  end
  object tbl_Transportadora: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT * FROM Transportadora INNER JOIN Pessoa ON (Transportador' +
        'a.PES_CODPESSOA = Pessoa.PES_CODPESSOA)')
    Left = 323
    Top = 136
    object tbl_TransportadoraTRP_CODTRANSPORTADORA: TIntegerField
      FieldName = 'TRP_CODTRANSPORTADORA'
      Origin = 'TRANSPORTADORA.TRP_CODTRANSPORTADORA'
      Required = True
      Visible = False
    end
    object tbl_TransportadoraCODIGOTRANSPORTADORA: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGOTRANSPORTADORA'
      Origin = 'TRANSPORTADORA.CODIGOTRANSPORTADORA'
      Required = True
    end
    object tbl_TransportadoraPES_CODPESSOA: TIntegerField
      FieldName = 'PES_CODPESSOA'
      Origin = 'TRANSPORTADORA.PES_CODPESSOA'
      Required = True
      Visible = False
    end
    object tbl_TransportadoraCON_CODCONTA: TIntegerField
      FieldName = 'CON_CODCONTA'
      Origin = 'TRANSPORTADORA.CON_CODCONTA'
      Visible = False
    end
    object tbl_TransportadoraCFG_CODCONFIG: TIntegerField
      FieldName = 'CFG_CODCONFIG'
      Origin = 'TRANSPORTADORA.CFG_CODCONFIG'
      Visible = False
    end
    object tbl_TransportadoraPES_CODPESSOA1: TIntegerField
      FieldName = 'PES_CODPESSOA1'
      Origin = 'PESSOA.PES_CODPESSOA'
      Required = True
      Visible = False
    end
    object tbl_TransportadoraTPE_CODTIPOPESSOA: TIntegerField
      FieldName = 'TPE_CODTIPOPESSOA'
      Origin = 'PESSOA.TPE_CODTIPOPESSOA'
      Required = True
      Visible = False
    end
    object tbl_TransportadoraPES_NOME_A: TIBStringField
      DisplayLabel = 'Nome'
      FieldName = 'PES_NOME_A'
      Origin = 'PESSOA.PES_NOME_A'
      Required = True
      Size = 50
    end
    object tbl_TransportadoraPES_APELIDO_A: TIBStringField
      FieldName = 'PES_APELIDO_A'
      Origin = 'PESSOA.PES_APELIDO_A'
      Visible = False
      Size = 50
    end
    object tbl_TransportadoraPES_RG_IE_A: TIBStringField
      FieldName = 'PES_RG_IE_A'
      Origin = 'PESSOA.PES_RG_IE_A'
      Visible = False
    end
    object tbl_TransportadoraPES_CPF_CNPJ_A: TIBStringField
      FieldName = 'PES_CPF_CNPJ_A'
      Origin = 'PESSOA.PES_CPF_CNPJ_A'
      Visible = False
    end
    object tbl_TransportadoraPES_PROFISSAO_RAMO_A: TIBStringField
      FieldName = 'PES_PROFISSAO_RAMO_A'
      Origin = 'PESSOA.PES_PROFISSAO_RAMO_A'
      Visible = False
      Size = 50
    end
    object tbl_TransportadoraPES_DATANASCIMENTO_D: TDateTimeField
      FieldName = 'PES_DATANASCIMENTO_D'
      Origin = 'PESSOA.PES_DATANASCIMENTO_D'
      Visible = False
    end
    object tbl_TransportadoraCOP_CODCONTATO_PRINCIPAL: TIntegerField
      FieldName = 'COP_CODCONTATO_PRINCIPAL'
      Origin = 'PESSOA.COP_CODCONTATO_PRINCIPAL'
      Visible = False
    end
    object tbl_TransportadoraTELEFONE1: TIBStringField
      FieldName = 'TELEFONE1'
      Origin = 'PESSOA.TELEFONE1'
      Visible = False
    end
    object tbl_TransportadoraPES_OBSERVACOES_T: TIBStringField
      FieldName = 'PES_OBSERVACOES_T'
      Origin = 'PESSOA.PES_OBSERVACOES_T'
      Visible = False
      Size = 10000
    end
    object tbl_TransportadoraSEXO: TIBStringField
      FieldName = 'SEXO'
      Origin = 'PESSOA.SEXO'
      Visible = False
      Size = 1
    end
  end
  object tbl_PedidoVenda: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM PedidoVenda ORDER BY NUMEROPEDIDO')
    Left = 237
    Top = 72
    object tbl_PedidoVendaCODIGOPEDIDOVENDA: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGOPEDIDOVENDA'
      Origin = 'PEDIDOVENDA.CODIGOPEDIDOVENDA'
      Required = True
    end
    object tbl_PedidoVendaNUMEROPEDIDO: TIntegerField
      DisplayLabel = 'N'#250'mero do Pedido'
      FieldName = 'NUMEROPEDIDO'
      Origin = 'PEDIDOVENDA.NUMEROPEDIDO'
      Required = True
    end
    object tbl_PedidoVendaDATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      Origin = 'PEDIDOVENDA.DATA'
      Required = True
    end
    object tbl_PedidoVendaCLI_CODCLIENTE: TIntegerField
      FieldName = 'CLI_CODCLIENTE'
      Origin = 'PEDIDOVENDA.CLI_CODCLIENTE'
      Required = True
      Visible = False
    end
    object tbl_PedidoVendaCODIGONATUREZAOPERACAO: TIntegerField
      FieldName = 'CODIGONATUREZAOPERACAO'
      Origin = 'PEDIDOVENDA.CODIGONATUREZAOPERACAO'
      Required = True
      Visible = False
    end
    object tbl_PedidoVendaCODIGOCONDICAOPAGAMENTO: TIntegerField
      FieldName = 'CODIGOCONDICAOPAGAMENTO'
      Origin = 'PEDIDOVENDA.CODIGOCONDICAOPAGAMENTO'
      Required = True
      Visible = False
    end
    object tbl_PedidoVendaVEN_CODVENDEDOR: TIntegerField
      FieldName = 'VEN_CODVENDEDOR'
      Origin = 'PEDIDOVENDA.VEN_CODVENDEDOR'
      Required = True
      Visible = False
    end
    object tbl_PedidoVendaCOMISSAO: TFloatField
      FieldName = 'COMISSAO'
      Origin = 'PEDIDOVENDA.COMISSAO'
      Visible = False
    end
    object tbl_PedidoVendaSITUACAO: TIBStringField
      FieldName = 'SITUACAO'
      Origin = 'PEDIDOVENDA.SITUACAO'
      Visible = False
      Size = 1
    end
    object tbl_PedidoVendaCODIGOTABELAPRECO: TIntegerField
      FieldName = 'CODIGOTABELAPRECO'
      Origin = 'PEDIDOVENDA.CODIGOTABELAPRECO'
      Visible = False
    end
    object tbl_PedidoVendaTOTALPRODUTOS: TFloatField
      FieldName = 'TOTALPRODUTOS'
      Origin = 'PEDIDOVENDA.TOTALPRODUTOS'
      Visible = False
    end
    object tbl_PedidoVendaTRP_CODTRANSPORTADORA: TIntegerField
      FieldName = 'TRP_CODTRANSPORTADORA'
      Origin = 'PEDIDOVENDA.TRP_CODTRANSPORTADORA'
      Visible = False
    end
    object tbl_PedidoVendaOBSERVACAO: TIBStringField
      FieldName = 'OBSERVACAO'
      Origin = 'PEDIDOVENDA.OBSERVACAO'
      Visible = False
      Size = 10000
    end
    object tbl_PedidoVendaCFG_CODCONFIG: TIntegerField
      FieldName = 'CFG_CODCONFIG'
      Origin = 'PEDIDOVENDA.CFG_CODCONFIG'
      Required = True
      Visible = False
    end
    object tbl_PedidoVendaDESCONTO: TFloatField
      FieldName = 'DESCONTO'
      Origin = 'PEDIDOVENDA.DESCONTO'
      Visible = False
    end
    object tbl_PedidoVendaFRETE: TFloatField
      FieldName = 'FRETE'
      Origin = 'PEDIDOVENDA.FRETE'
      Visible = False
    end
    object tbl_PedidoVendaSEGURO: TFloatField
      FieldName = 'SEGURO'
      Origin = 'PEDIDOVENDA.SEGURO'
      Visible = False
    end
    object tbl_PedidoVendaDESPESASACESSORIAS: TFloatField
      FieldName = 'DESPESASACESSORIAS'
      Origin = 'PEDIDOVENDA.DESPESASACESSORIAS'
      Visible = False
    end
    object tbl_PedidoVendaTOTALPEDIDO: TFloatField
      FieldName = 'TOTALPEDIDO'
      Origin = 'PEDIDOVENDA.TOTALPEDIDO'
      Visible = False
    end
    object tbl_PedidoVendaAPROVADO: TIBStringField
      FieldName = 'APROVADO'
      Origin = 'PEDIDOVENDA.APROVADO'
      Visible = False
      FixedChar = True
      Size = 1
    end
    object tbl_PedidoVendaCOMISSAOAGENTE: TFloatField
      FieldName = 'COMISSAOAGENTE'
      Origin = 'PEDIDOVENDA.COMISSAOAGENTE'
      Visible = False
    end
    object tbl_PedidoVendaCOMISSAOGERENTE: TFloatField
      FieldName = 'COMISSAOGERENTE'
      Origin = 'PEDIDOVENDA.COMISSAOGERENTE'
      Visible = False
    end
    object tbl_PedidoVendaCOMISSAOSUPERVISOR: TFloatField
      FieldName = 'COMISSAOSUPERVISOR'
      Origin = 'PEDIDOVENDA.COMISSAOSUPERVISOR'
      Visible = False
    end
    object tbl_PedidoVendaVEN_CODVENDEDORAGENTE: TIntegerField
      FieldName = 'VEN_CODVENDEDORAGENTE'
      Origin = 'PEDIDOVENDA.VEN_CODVENDEDORAGENTE'
      Visible = False
    end
    object tbl_PedidoVendaVEN_CODVENDEDORGERENTE: TIntegerField
      FieldName = 'VEN_CODVENDEDORGERENTE'
      Origin = 'PEDIDOVENDA.VEN_CODVENDEDORGERENTE'
      Visible = False
    end
    object tbl_PedidoVendaVEN_CODVENDEDORSUPERVISOR: TIntegerField
      FieldName = 'VEN_CODVENDEDORSUPERVISOR'
      Origin = 'PEDIDOVENDA.VEN_CODVENDEDORSUPERVISOR'
      Visible = False
    end
    object tbl_PedidoVendaOBR_CODOBRA: TIntegerField
      FieldName = 'OBR_CODOBRA'
      Origin = 'PEDIDOVENDA.OBR_CODOBRA'
      Visible = False
    end
    object tbl_PedidoVendaORIGEMPEDIDO: TIBStringField
      FieldName = 'ORIGEMPEDIDO'
      Origin = 'PEDIDOVENDA.ORIGEMPEDIDO'
      Visible = False
      Size = 2
    end
    object tbl_PedidoVendaDESCRICAODESCONTO: TIBStringField
      FieldName = 'DESCRICAODESCONTO'
      Origin = 'PEDIDOVENDA.DESCRICAODESCONTO'
      Visible = False
      Size = 100
    end
    object tbl_PedidoVendaDESCRICAOACRESCIMO: TIBStringField
      FieldName = 'DESCRICAOACRESCIMO'
      Origin = 'PEDIDOVENDA.DESCRICAOACRESCIMO'
      Visible = False
      Size = 100
    end
    object tbl_PedidoVendaNUMPESSOAS: TIntegerField
      FieldName = 'NUMPESSOAS'
      Origin = 'PEDIDOVENDA.NUMPESSOAS'
      Visible = False
    end
  end
  object tbl_PedidoCompra: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM PedidoCompra ORDER BY NUMEROPEDIDO')
    Left = 142
    Top = 72
    object tbl_PedidoCompraCODIGOPEDIDOCOMPRA: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGOPEDIDOCOMPRA'
      Origin = 'PEDIDOCOMPRA.CODIGOPEDIDOCOMPRA'
      Required = True
    end
    object tbl_PedidoCompraNUMEROPEDIDO: TIntegerField
      DisplayLabel = 'N'#250'mero do Pedido'
      FieldName = 'NUMEROPEDIDO'
      Origin = 'PEDIDOCOMPRA.NUMEROPEDIDO'
      Required = True
    end
    object tbl_PedidoCompraDATA: TDateTimeField
      DisplayLabel = 'Data'
      FieldName = 'DATA'
      Origin = 'PEDIDOCOMPRA.DATA'
      Required = True
    end
    object tbl_PedidoCompraCOMISSAO: TFloatField
      FieldName = 'COMISSAO'
      Origin = 'PEDIDOCOMPRA.COMISSAO'
      Visible = False
    end
    object tbl_PedidoCompraTOTALPRODUTOS: TFloatField
      FieldName = 'TOTALPRODUTOS'
      Origin = 'PEDIDOCOMPRA.TOTALPRODUTOS'
      Visible = False
    end
    object tbl_PedidoCompraSITUACAO: TIBStringField
      FieldName = 'SITUACAO'
      Origin = 'PEDIDOCOMPRA.SITUACAO'
      Visible = False
      Size = 1
    end
    object tbl_PedidoCompraFRN_CODFORNECEDOR: TIntegerField
      FieldName = 'FRN_CODFORNECEDOR'
      Origin = 'PEDIDOCOMPRA.FRN_CODFORNECEDOR'
      Required = True
      Visible = False
    end
    object tbl_PedidoCompraCODIGONATUREZAOPERACAO: TIntegerField
      FieldName = 'CODIGONATUREZAOPERACAO'
      Origin = 'PEDIDOCOMPRA.CODIGONATUREZAOPERACAO'
      Required = True
      Visible = False
    end
    object tbl_PedidoCompraCODIGOCONDICAOPAGAMENTO: TIntegerField
      FieldName = 'CODIGOCONDICAOPAGAMENTO'
      Origin = 'PEDIDOCOMPRA.CODIGOCONDICAOPAGAMENTO'
      Required = True
      Visible = False
    end
    object tbl_PedidoCompraVEN_CODVENDEDOR: TIntegerField
      FieldName = 'VEN_CODVENDEDOR'
      Origin = 'PEDIDOCOMPRA.VEN_CODVENDEDOR'
      Visible = False
    end
    object tbl_PedidoCompraTRP_CODTRANSPORTADORA: TIntegerField
      FieldName = 'TRP_CODTRANSPORTADORA'
      Origin = 'PEDIDOCOMPRA.TRP_CODTRANSPORTADORA'
      Visible = False
    end
    object tbl_PedidoCompraOBSERVACAO: TIBStringField
      FieldName = 'OBSERVACAO'
      Origin = 'PEDIDOCOMPRA.OBSERVACAO'
      Visible = False
      Size = 10000
    end
    object tbl_PedidoCompraCFG_CODCONFIG: TIntegerField
      FieldName = 'CFG_CODCONFIG'
      Origin = 'PEDIDOCOMPRA.CFG_CODCONFIG'
      Required = True
      Visible = False
    end
    object tbl_PedidoCompraDESCONTO: TFloatField
      FieldName = 'DESCONTO'
      Origin = 'PEDIDOCOMPRA.DESCONTO'
      Visible = False
    end
    object tbl_PedidoCompraFRETE: TFloatField
      FieldName = 'FRETE'
      Origin = 'PEDIDOCOMPRA.FRETE'
      Visible = False
    end
    object tbl_PedidoCompraSEGURO: TFloatField
      FieldName = 'SEGURO'
      Origin = 'PEDIDOCOMPRA.SEGURO'
      Visible = False
    end
    object tbl_PedidoCompraDESPESASACESSORIAS: TFloatField
      FieldName = 'DESPESASACESSORIAS'
      Origin = 'PEDIDOCOMPRA.DESPESASACESSORIAS'
      Visible = False
    end
    object tbl_PedidoCompraTOTALPEDIDO: TFloatField
      FieldName = 'TOTALPEDIDO'
      Origin = 'PEDIDOCOMPRA.TOTALPEDIDO'
      Visible = False
    end
    object tbl_PedidoCompraCODIGOTABELAPRECO: TIntegerField
      FieldName = 'CODIGOTABELAPRECO'
      Origin = 'PEDIDOCOMPRA.CODIGOTABELAPRECO'
      Visible = False
    end
    object tbl_PedidoCompraAPROVADO: TIBStringField
      FieldName = 'APROVADO'
      Origin = 'PEDIDOCOMPRA.APROVADO'
      Visible = False
      FixedChar = True
      Size = 1
    end
  end
  object tbl_Estoque: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      '')
    Left = 79
    Top = 15
  end
  object tbl_NotaFiscalEntrada: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT * FROM NotaFiscalEntrada NFEntrada, Pessoa Pessoa, Fornec' +
        'edor Fornecedor ')
    Left = 364
    Top = 15
    object tbl_NotaFiscalEntradaCODIGONOTAFISCALENTRADA: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGONOTAFISCALENTRADA'
      Origin = 'NOTAFISCALENTRADA.CODIGONOTAFISCALENTRADA'
      Required = True
    end
    object tbl_NotaFiscalEntradaNUMERONOTA: TIntegerField
      DisplayLabel = 'N'#250'mero da Nota'
      FieldName = 'NUMERONOTA'
      Origin = 'NOTAFISCALENTRADA.NUMERONOTA'
      Required = True
    end
    object tbl_NotaFiscalEntradaDATAEMISSAO: TDateTimeField
      DisplayLabel = 'Data de Emiss'#227'o'
      FieldName = 'DATAEMISSAO'
      Origin = 'NOTAFISCALENTRADA.DATAEMISSAO'
    end
    object tbl_NotaFiscalEntradaPES_NOME_A: TIBStringField
      DisplayLabel = 'Destinat'#225'rio / Remetente'
      FieldName = 'PES_NOME_A'
      Origin = 'PESSOA.PES_NOME_A'
      Required = True
      Size = 50
    end
  end
  object tbl_NotaFiscalSaida: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT * FROM NotaFiscalSaida NFSaida, Pessoa Pessoa, Cliente Cl' +
        'iente'
      '')
    Left = 40
    Top = 72
    object tbl_NotaFiscalSaidaCODIGONOTAFISCALSAIDA: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGONOTAFISCALSAIDA'
      Origin = 'NOTAFISCALSAIDA.CODIGONOTAFISCALSAIDA'
      Required = True
    end
    object tbl_NotaFiscalSaidaNUMERONOTA: TIntegerField
      DisplayLabel = 'N'#250'mero da Nota'
      FieldName = 'NUMERONOTA'
      Origin = 'NOTAFISCALSAIDA.NUMERONOTA'
      Required = True
    end
    object tbl_NotaFiscalSaidaDATAEMISSAO: TDateTimeField
      DisplayLabel = 'Data de Emiss'#227'o'
      FieldName = 'DATAEMISSAO'
      Origin = 'NOTAFISCALSAIDA.DATAEMISSAO'
      Required = True
    end
    object tbl_NotaFiscalSaidaPES_NOME_A: TIBStringField
      DisplayLabel = 'Destinat'#225'rio / Remetente'
      FieldName = 'PES_NOME_A'
      Origin = 'PESSOA.PES_NOME_A'
      Required = True
      Size = 50
    end
  end
  object tbl_NotaFiscal: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      '')
    Left = 518
    Top = 15
  end
  object tbl_Pessoa: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      '')
    Left = 518
    Top = 73
  end
  object tbl_ProdutoPedidoCompra: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT Produto.CODIGOPRODUTO, Produto.NOMEPRODUTO, ProdutoPedido' +
        'Compra.QUANTIDADE, ProdutoPedidoCompra.PRECO, ProdutoPedidoCompr' +
        'a.ALIQUOTAICMS, ProdutoPedidoCompra.ALIQUOTAIPI, Produto.PESOBRU' +
        'TO, Produto.PESOLIQUIDO, ClassificacaoFiscal.CODIGOCLASSIFICACAO' +
        'FISCAL, ClassificacaoFiscal.CLASSIFICACAOFISCAL, SituacaoTributa' +
        'ria.CODIGOSITUACAOTRIBUTARIA, SituacaoTributaria.SITUACAOTRIBUTA' +
        'RIA FROM Produto, ProdutoPedidoCompra, ClassificacaoFiscal, Situ' +
        'acaoTributaria'
      '')
    Left = 412
    Top = 72
    object tbl_ProdutoPedidoCompraCODIGOPRODUTO: TIntegerField
      DisplayLabel = 'C'#243'digo do Produto'
      FieldName = 'CODIGOPRODUTO'
      Origin = 'PRODUTO.CODIGOPRODUTO'
      Required = True
    end
    object tbl_ProdutoPedidoCompraNOMEPRODUTO: TIBStringField
      DisplayLabel = 'Nome do Produto'
      FieldName = 'NOMEPRODUTO'
      Origin = 'PRODUTO.NOMEPRODUTO'
      Required = True
      Size = 102
    end
    object tbl_ProdutoPedidoCompraQUANTIDADE: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTIDADE'
      Origin = 'PRODUTOPEDIDOCOMPRA.QUANTIDADE'
      Required = True
    end
    object tbl_ProdutoPedidoCompraPRECO: TFloatField
      DisplayLabel = 'Pre'#231'o'
      FieldName = 'PRECO'
      Origin = 'PRODUTOPEDIDOCOMPRA.PRECO'
      Required = True
    end
    object tbl_ProdutoPedidoCompraALIQUOTAICMS: TFloatField
      DisplayLabel = 'Al'#237'quota ICMS'
      FieldName = 'ALIQUOTAICMS'
      Origin = 'PRODUTOPEDIDOCOMPRA.ALIQUOTAICMS'
    end
    object tbl_ProdutoPedidoCompraALIQUOTAIPI: TFloatField
      DisplayLabel = 'Al'#237'quota IPI'
      FieldName = 'ALIQUOTAIPI'
      Origin = 'PRODUTOPEDIDOCOMPRA.ALIQUOTAIPI'
    end
    object tbl_ProdutoPedidoCompraPESOBRUTO: TFloatField
      DisplayLabel = 'Peso Bruto'
      FieldName = 'PESOBRUTO'
      Origin = 'PRODUTO.PESOBRUTO'
    end
    object tbl_ProdutoPedidoCompraPESOLIQUIDO: TFloatField
      DisplayLabel = 'Peso L'#237'quido'
      FieldName = 'PESOLIQUIDO'
      Origin = 'PRODUTO.PESOLIQUIDO'
    end
    object tbl_ProdutoPedidoCompraCODIGOCLASSIFICACAOFISCAL: TIntegerField
      FieldName = 'CODIGOCLASSIFICACAOFISCAL'
      Origin = 'CLASSIFICACAOFISCAL.CODIGOCLASSIFICACAOFISCAL'
      Required = True
      Visible = False
    end
    object tbl_ProdutoPedidoCompraCLASSIFICACAOFISCAL: TIBStringField
      FieldName = 'CLASSIFICACAOFISCAL'
      Origin = 'CLASSIFICACAOFISCAL.CLASSIFICACAOFISCAL'
      Required = True
      Visible = False
      Size = 50
    end
    object tbl_ProdutoPedidoCompraCODIGOSITUACAOTRIBUTARIA: TIntegerField
      FieldName = 'CODIGOSITUACAOTRIBUTARIA'
      Origin = 'SITUACAOTRIBUTARIA.CODIGOSITUACAOTRIBUTARIA'
      Required = True
      Visible = False
    end
    object tbl_ProdutoPedidoCompraSITUACAOTRIBUTARIA: TIBStringField
      DisplayLabel = 'Situa'#231#227'o Tribut'#225'ria'
      FieldName = 'SITUACAOTRIBUTARIA'
      Origin = 'SITUACAOTRIBUTARIA.SITUACAOTRIBUTARIA'
      Required = True
      Size = 50
    end
  end
  object tbl_ProdutoPedidoVenda: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT Produto.CODIGOPRODUTO, Produto.NOMEPRODUTO, ProdutoPedido' +
        'Venda.QUANTIDADE, ProdutoPedidoVenda.PRECO, ProdutoPedidoVenda.A' +
        'LIQUOTAICMS, ProdutoPedidoVenda.ALIQUOTAIPI, Produto.PESOBRUTO, ' +
        'Produto.PESOLIQUIDO, ClassificacaoFiscal.CODIGOCLASSIFICACAOFISC' +
        'AL, ClassificacaoFiscal.CLASSIFICACAOFISCAL, SituacaoTributaria.' +
        'CODIGOSITUACAOTRIBUTARIA, SituacaoTributaria.SITUACAOTRIBUTARIA ' +
        'FROM Produto, ProdutoPedidoVenda, ClassificacaoFiscal, SituacaoT' +
        'ributaria')
    Left = 51
    Top = 136
    object tbl_ProdutoPedidoVendaCODIGOPRODUTO: TIntegerField
      DisplayLabel = 'C'#243'digo do Produto'
      FieldName = 'CODIGOPRODUTO'
      Origin = 'PRODUTO.CODIGOPRODUTO'
      Required = True
    end
    object tbl_ProdutoPedidoVendaNOMEPRODUTO: TIBStringField
      DisplayLabel = 'Nome do Produto'
      FieldName = 'NOMEPRODUTO'
      Origin = 'PRODUTO.NOMEPRODUTO'
      Required = True
      Size = 102
    end
    object tbl_ProdutoPedidoVendaQUANTIDADE: TFloatField
      DisplayLabel = 'Quantidade'
      FieldName = 'QUANTIDADE'
      Origin = 'PRODUTOPEDIDOVENDA.QUANTIDADE'
      Required = True
    end
    object tbl_ProdutoPedidoVendaPRECO: TFloatField
      DisplayLabel = 'Pre'#231'o'
      FieldName = 'PRECO'
      Origin = 'PRODUTOPEDIDOVENDA.PRECO'
      Required = True
    end
    object tbl_ProdutoPedidoVendaALIQUOTAICMS: TFloatField
      DisplayLabel = 'Al'#237'quota ICMS'
      FieldName = 'ALIQUOTAICMS'
      Origin = 'PRODUTOPEDIDOVENDA.ALIQUOTAICMS'
    end
    object tbl_ProdutoPedidoVendaALIQUOTAIPI: TFloatField
      DisplayLabel = 'Al'#237'quota IPI'
      FieldName = 'ALIQUOTAIPI'
      Origin = 'PRODUTOPEDIDOVENDA.ALIQUOTAIPI'
    end
    object tbl_ProdutoPedidoVendaPESOBRUTO: TFloatField
      DisplayLabel = 'Peso Bruto'
      FieldName = 'PESOBRUTO'
      Origin = 'PRODUTO.PESOBRUTO'
    end
    object tbl_ProdutoPedidoVendaPESOLIQUIDO: TFloatField
      DisplayLabel = 'Peso L'#237'quido'
      FieldName = 'PESOLIQUIDO'
      Origin = 'PRODUTO.PESOLIQUIDO'
    end
    object tbl_ProdutoPedidoVendaCODIGOCLASSIFICACAOFISCAL: TIntegerField
      FieldName = 'CODIGOCLASSIFICACAOFISCAL'
      Origin = 'CLASSIFICACAOFISCAL.CODIGOCLASSIFICACAOFISCAL'
      Required = True
      Visible = False
    end
    object tbl_ProdutoPedidoVendaCLASSIFICACAOFISCAL: TIBStringField
      FieldName = 'CLASSIFICACAOFISCAL'
      Origin = 'CLASSIFICACAOFISCAL.CLASSIFICACAOFISCAL'
      Required = True
      Visible = False
      Size = 50
    end
    object tbl_ProdutoPedidoVendaCODIGOSITUACAOTRIBUTARIA: TIntegerField
      FieldName = 'CODIGOSITUACAOTRIBUTARIA'
      Origin = 'SITUACAOTRIBUTARIA.CODIGOSITUACAOTRIBUTARIA'
      Required = True
      Visible = False
    end
    object tbl_ProdutoPedidoVendaSITUACAOTRIBUTARIA: TIBStringField
      DisplayLabel = 'Situa'#231#227'o Tribut'#225'ria'
      FieldName = 'SITUACAOTRIBUTARIA'
      Origin = 'SITUACAOTRIBUTARIA.SITUACAOTRIBUTARIA'
      Required = True
      Size = 50
    end
  end
  object tbl_TabelaPreco: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      '')
    Left = 231
    Top = 136
  end
  object tbl_CondicaoPagamento: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      ''
      '')
    Left = 435
    Top = 136
  end
end
