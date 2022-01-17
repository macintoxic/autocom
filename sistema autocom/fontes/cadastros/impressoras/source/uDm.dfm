object Dm: TDm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 325
  Top = 206
  Height = 150
  Width = 302
  object DBAutocom: TIBDatabase
    DatabaseName = 'd:\dev\autocom_novo.gdb'
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
    Left = 105
    Top = 8
  end
end
