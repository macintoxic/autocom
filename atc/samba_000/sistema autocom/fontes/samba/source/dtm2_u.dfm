object Dtm2: TDtm2
  OldCreateOrder = False
  Left = 318
  Top = 184
  Height = 192
  Width = 364
  object vendedores: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 120
    Top = 16
  end
  object DbAutocom: TIBDatabase
    DatabaseName = 'D:\autocom.gdb'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 32
    Top = 16
  end
  object IBTransaction1: TIBTransaction
    Active = False
    DefaultDatabase = DbAutocom
    AutoStopAction = saRollbackRetaining
    Left = 32
    Top = 64
  end
  object produtos: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 120
    Top = 72
  end
  object consubgrpo: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 208
    Top = 16
  end
  object conprod: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 208
    Top = 72
  end
  object Tbl_Impressoras: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 272
    Top = 72
  end
  object Rede: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 272
    Top = 16
  end
  object pt: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 32
    Top = 112
  end
end
