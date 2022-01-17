object Dm: TDm
  OldCreateOrder = False
  Left = 268
  Top = 252
  Height = 169
  Width = 291
  object Transaction: TIBTransaction
    Active = False
    DefaultDatabase = DBAutocom
    AutoStopAction = saNone
    Left = 105
    Top = 8
  end
  object DBAutocom: TIBDatabase
    DatabaseName = 'd:\autocom.gdb'
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
  object Tbl_TabelaPreco: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select *  from TABELAPRECO')
    Left = 184
    Top = 8
    object Tbl_TabelaPrecoCODIGOTABELAPRECO: TIntegerField
      Alignment = taLeftJustify
      FieldName = 'CODIGOTABELAPRECO'
      Origin = 'TABELAPRECO.CODIGOTABELAPRECO'
      Required = True
      Visible = False
    end
    object Tbl_TabelaPrecoCODIGOTABELA: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGOTABELA'
      Origin = 'TABELAPRECO.CODIGOTABELA'
      Required = True
    end
    object Tbl_TabelaPrecoTABELAPRECO: TIBStringField
      DisplayLabel = 'Tabela'
      FieldName = 'TABELAPRECO'
      Origin = 'TABELAPRECO.TABELAPRECO'
      Required = True
      Size = 50
    end
  end
  object Tbl_Impressoras: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select * from IMPRESSORA')
    Left = 24
    Top = 72
  end
  object Rede: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'select *  from TABELAPRECO')
    Left = 184
    Top = 72
  end
  object pt: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 120
    Top = 72
  end
end
