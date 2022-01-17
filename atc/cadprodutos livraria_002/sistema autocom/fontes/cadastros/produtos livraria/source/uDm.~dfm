object Dm: TDm
  OldCreateOrder = False
  Left = 233
  Top = 214
  Height = 275
  Width = 531
  object Transaction: TIBTransaction
    Active = False
    DefaultDatabase = DBAutocom
    AutoStopAction = saNone
    Left = 88
    Top = 16
  end
  object DBAutocom: TIBDatabase
    DatabaseName = 'C:\autocom.gdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = Transaction
    IdleTimer = 0
    SQLDialect = 1
    TraceFlags = []
    Left = 24
    Top = 16
  end
  object QrProduto: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'SELECT CODIGOPRODUTO,  NOMEPRODUTO FROM PRODUTO ORDER BY CODIGOP' +
        'RODUTO')
    Left = 152
    Top = 16
    object QrProdutoCODIGOPRODUTO: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGOPRODUTO'
      Origin = 'PRODUTO.CODIGOPRODUTO'
      Required = True
    end
    object QrProdutoNOMEPRODUTO: TIBStringField
      DisplayLabel = 'Descri'#231#227'o'
      DisplayWidth = 95
      FieldName = 'NOMEPRODUTO'
      Origin = 'PRODUTO.NOMEPRODUTO'
      Required = True
      Size = 100
    end
  end
  object Rave: TRvProject
    Engine = RvSys
    ProjectFile = 'CProdutos.rav'
    Left = 88
    Top = 72
  end
  object RvDs: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    Left = 160
    Top = 72
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
    Left = 224
    Top = 72
  end
end
