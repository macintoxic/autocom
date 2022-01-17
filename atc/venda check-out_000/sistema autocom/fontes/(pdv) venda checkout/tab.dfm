object ftabelas: Tftabelas
  Left = 102
  Top = 119
  Width = 364
  Height = 480
  Caption = 'ftabelas'
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object tbl_vendedores: TIBQuery
    Database = DbAutocom
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    Left = 48
    Top = 272
  end
  object tbl_condicaopagamento: TIBQuery
    Database = DbAutocom
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    Left = 56
    Top = 152
  end
  object DbAutocom: TIBDatabase
    DatabaseName = '10.1.2.101:d:\autocom_beta_teste\dados\autocom_novo.gdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = Transacao
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 16
    Top = 16
  end
  object Transacao: TIBTransaction
    Active = False
    DefaultDatabase = DbAutocom
    AutoStopAction = saNone
    Left = 56
    Top = 64
  end
  object tbop: TIBQuery
    Database = DbAutocom
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    Left = 192
    Top = 104
  end
  object tbl_produtos: TIBQuery
    Database = DbAutocom
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from acr102')
    Left = 136
    Top = 272
  end
  object tbl_produtoassociado: TIBQuery
    Database = DbAutocom
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    Left = 224
    Top = 272
  end
  object acr400: TIBQuery
    Database = DbAutocom
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    Left = 264
    Top = 160
  end
  object tbteclado: TIBQuery
    Database = DbAutocom
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from pdv_teclado')
    Left = 296
    Top = 104
    object tbtecladoCODIGO_FUNCAO: TIBStringField
      FieldName = 'CODIGO_FUNCAO'
      Origin = 'PDV_TECLADO.CODIGO_FUNCAO'
      Required = True
      Size = 4
    end
    object tbtecladoCFG_CODCONFIG: TIntegerField
      FieldName = 'CFG_CODCONFIG'
      Origin = 'PDV_TECLADO.CFG_CODCONFIG'
      Required = True
    end
    object tbtecladoTERMINAL: TIBStringField
      FieldName = 'TERMINAL'
      Origin = 'PDV_TECLADO.TERMINAL'
      Required = True
      Size = 4
    end
    object tbtecladoTIPO: TIBStringField
      FieldName = 'TIPO'
      Origin = 'PDV_TECLADO.TIPO'
      Required = True
      FixedChar = True
      Size = 1
    end
    object tbtecladoTECLA: TIntegerField
      FieldName = 'TECLA'
      Origin = 'PDV_TECLADO.TECLA'
      Required = True
    end
    object tbtecladoABREV: TIBStringField
      FieldName = 'ABREV'
      Origin = 'PDV_TECLADO.ABREV'
      Size = 4
    end
    object tbtecladoCODIGOPRODUTO: TIntegerField
      FieldName = 'CODIGOPRODUTO'
      Origin = 'PDV_TECLADO.CODIGOPRODUTO'
    end
    object tbtecladoOID: TIntegerField
      FieldName = 'OID'
      Origin = 'PDV_TECLADO.OID'
      Required = True
    end
  end
  object querylog: TIBQuery
    Database = DbAutocom
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    Left = 160
    Top = 8
  end
  object Query2: TIBQuery
    Database = DbAutocom
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    Left = 120
    Top = 8
  end
  object Query1: TIBQuery
    Database = DbAutocom
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    Left = 80
    Top = 8
  end
  object tbl_Formafaturamento: TIBQuery
    Database = DbAutocom
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    Left = 56
    Top = 208
  end
  object tbl_tabelapreco: TIBQuery
    Database = DbAutocom
    Transaction = Transacao
    BufferChunks = 1000
    CachedUpdates = False
    Left = 48
    Top = 320
  end
end
