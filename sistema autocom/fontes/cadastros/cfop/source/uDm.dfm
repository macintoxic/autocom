object Dm: TDm
  OldCreateOrder = False
  Left = 392
  Top = 290
  Height = 221
  Width = 308
  object RvDs: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = CdsCFOP
    Left = 96
    Top = 80
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
    Left = 160
    Top = 80
  end
  object Rave: TRvProject
    Engine = RvSys
    ProjectFile = 'CCFOP.rav'
    Left = 24
    Top = 80
  end
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
  object CdsCFOP: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODIGONATUREZAOPERACAO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NATUREZAOPERACAO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 50
      end
      item
        Name = 'DESCRICAO'
        DataType = ftString
        Size = 70
      end
      item
        Name = 'TRIBUTAICMS'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'TRIBUTAIPI'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'TRIBUTAISS'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'MOVIMENTACONTAS'
        DataType = ftString
        Size = 3
      end
      item
        Name = 'MOVIMENTAESTOQUE'
        DataType = ftString
        Size = 3
      end>
    IndexDefs = <
      item
        Name = 'Codigo'
        DescFields = 'CODIGONATUREZAOPERACAO'
        Fields = 'CODIGONATUREZAOPERACAO'
        Options = [ixPrimary, ixUnique]
      end
      item
        Name = 'Natureza'
        DescFields = 'NATUREZAOPERACAO'
        Fields = 'NATUREZAOPERACAO'
      end>
    IndexFieldNames = 'CODIGONATUREZAOPERACAO'
    Params = <>
    StoreDefs = True
    Left = 160
    Top = 16
    Data = {
      230100009619E0BD010000001800000008000000000003000000230116434F44
      49474F4E41545552455A414F5045524143414F0400010004000000104E415455
      52455A414F5045524143414F0100490004000100055749445448020002003200
      0944455343524943414F01004900000001000557494454480200020046000B54
      52494255544149434D5301004900000001000557494454480200020003000A54
      52494255544149504901004900000001000557494454480200020003000A5452
      494255544149535301004900000001000557494454480200020003000F4D4F56
      494D454E5441434F4E5441530100490000000100055749445448020002000300
      104D4F56494D454E54414553544F515545010049000000010005574944544802
      00020003000000}
    object CdsCFOPCODIGONATUREZAOPERACAO: TIntegerField
      FieldName = 'CODIGONATUREZAOPERACAO'
      Origin = 'NATUREZAOPERACAO.CODIGONATUREZAOPERACAO'
    end
    object CdsCFOPNATUREZAOPERACAO: TIBStringField
      FieldName = 'NATUREZAOPERACAO'
      Origin = 'NATUREZAOPERACAO.NATUREZAOPERACAO'
      Size = 50
    end
    object CdsCFOPDESCRICAO: TIBStringField
      FieldName = 'DESCRICAO'
      Origin = 'NATUREZAOPERACAO.DESCRICAO'
      Size = 70
    end
    object CdsCFOPTRIBUTAICMS: TIBStringField
      FieldName = 'TRIBUTAICMS'
      Origin = 'NATUREZAOPERACAO.TRIBUTAICMS'
      FixedChar = True
      Size = 3
    end
    object CdsCFOPTRIBUTAIPI: TIBStringField
      FieldName = 'TRIBUTAIPI'
      Origin = 'NATUREZAOPERACAO.TRIBUTAIPI'
      FixedChar = True
      Size = 3
    end
    object CdsCFOPTRIBUTAISS: TIBStringField
      FieldName = 'TRIBUTAISS'
      Origin = 'NATUREZAOPERACAO.TRIBUTAISS'
      FixedChar = True
      Size = 3
    end
    object CdsCFOPMOVIMENTACONTAS: TIBStringField
      FieldName = 'MOVIMENTACONTAS'
      Origin = 'NATUREZAOPERACAO.MOVIMENTACONTAS'
      FixedChar = True
      Size = 3
    end
    object CdsCFOPMOVIMENTAESTOQUE: TIBStringField
      FieldName = 'MOVIMENTAESTOQUE'
      Origin = 'NATUREZAOPERACAO.MOVIMENTAESTOQUE'
      FixedChar = True
      Size = 3
    end
  end
end
