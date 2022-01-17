object Dm: TDm
  OldCreateOrder = False
  Left = 368
  Top = 354
  Height = 150
  Width = 334
  object DBAutocom: TIBDatabase
    DatabaseName = '10.1.2.95:C:\replicas\autocom\autocom.gdb'
    Params.Strings = (
      'User_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = Trans
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 24
  end
  object Trans: TIBTransaction
    Active = False
    DefaultDatabase = DBAutocom
    AutoStopAction = saNone
    Left = 96
  end
  object portadores: TIBQuery
    Database = DBAutocom
    Transaction = Trans
    BufferChunks = 1000
    CachedUpdates = False
    Left = 24
    Top = 64
  end
  object Consulta: TIBQuery
    Database = DBAutocom
    Transaction = Trans
    BufferChunks = 1000
    CachedUpdates = False
    Left = 80
    Top = 64
  end
  object principal: TIBQuery
    Database = DBAutocom
    Transaction = Trans
    BufferChunks = 1000
    CachedUpdates = False
    Left = 144
  end
  object Inclusao: TIBQuery
    Database = DBAutocom
    Transaction = Trans
    BufferChunks = 1000
    CachedUpdates = False
    Left = 120
    Top = 64
  end
  object Aux: TIBQuery
    Database = DBAutocom
    Transaction = Trans
    BufferChunks = 1000
    CachedUpdates = False
    Left = 168
    Top = 64
  end
end
