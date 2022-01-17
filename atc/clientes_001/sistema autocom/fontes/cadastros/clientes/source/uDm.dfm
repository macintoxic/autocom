object Dm: TDm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 221
  Top = 265
  Height = 150
  Width = 243
  object dbautocom: TIBDatabase
    DatabaseName = 'c:\autocom.gdb'
    Params.Strings = (
      'user_name=SYSDBA'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = Transaction
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 106
    Top = 8
  end
  object Transaction: TIBTransaction
    Active = False
    DefaultDatabase = dbautocom
    AutoStopAction = saNone
    Left = 33
    Top = 8
  end
  object RvConn: TRvProject
    Engine = RvSys
    ProjectFile = 'CClientes.rav'
    Left = 168
    Top = 8
  end
  object RvDs: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    Left = 104
    Top = 64
  end
  object RvSys: TRvSystem
    TitleSetup = 'Output Options'
    TitleStatus = 'Report Status'
    TitlePreview = 'Report Preview'
    SystemSetups = [ssAllowCopies, ssAllowCollate, ssAllowDuplex, ssAllowDestPreview, ssAllowDestPrinter, ssAllowDestFile, ssAllowPrinterSetup, ssAllowPreviewSetup]
    SystemFiler.StatusFormat = 'Generating page %p'
    SystemPreview.FormState = wsMaximized
    SystemPreview.ZoomFactor = 100.000000000000000000
    SystemPrinter.ScaleX = 100.000000000000000000
    SystemPrinter.ScaleY = 100.000000000000000000
    SystemPrinter.StatusFormat = 'Printing page %p'
    SystemPrinter.Title = 'ReportPrinter Report'
    SystemPrinter.UnitsFactor = 1.000000000000000000
    Left = 168
    Top = 64
  end
end
