object Fdm: TFdm
  OldCreateOrder = False
  Left = 192
  Top = 107
  Height = 150
  Width = 215
  object dbautocom: TIBDatabase
    DatabaseName = 'C:\atcpserver\dados\AUTOCOM.GDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 32
    Top = 16
  end
  object IBTransaction1: TIBTransaction
    Active = False
    AutoStopAction = saNone
    Left = 136
    Top = 24
  end
  object query: TIBQuery
    Database = dbautocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    Left = 32
    Top = 64
  end
end
