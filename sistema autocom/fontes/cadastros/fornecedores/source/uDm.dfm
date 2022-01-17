object Dm: TDm
  OldCreateOrder = False
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
  object QrRelatorio: TIBQuery
    Database = dbautocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT T.CODIGOFORNECEDOR, P.*, E.*'
      'FROM FORNECEDOR T, PESSOA P'
      'LEFT JOIN ENDERECOPESSOA E'
      'ON (E.PES_CODPESSOA = P.PES_CODPESSOA)'
      'WHERE T.PES_CODPESSOA = P.PES_CODPESSOA')
    Left = 32
    Top = 64
  end
  object RvConn: TRvProject
    Engine = RvSys
    ProjectFile = 'CFornecedores.rav'
    Left = 168
    Top = 8
  end
  object RvDs: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = QrRelatorio
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
    Left = 176
    Top = 72
  end
end
