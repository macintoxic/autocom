object dmORC: TdmORC
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 274
  Top = 287
  Height = 205
  Width = 359
  object IBDatabase: TIBDatabase
    DatabaseName = 'D:\projetos\autocom_beta_teste\dados\autocom_novo.gdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 24
    Top = 16
  end
  object IBTransaction: TIBTransaction
    Active = False
    DefaultDatabase = IBDatabase
    AutoStopAction = saNone
    Left = 96
    Top = 16
  end
end
