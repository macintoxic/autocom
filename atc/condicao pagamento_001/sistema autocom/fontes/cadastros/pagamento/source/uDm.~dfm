object Dm: TDm
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 276
  Top = 401
  Height = 175
  Width = 329
  object Transaction: TIBTransaction
    Active = False
    DefaultDatabase = dbautocom
    AutoStopAction = saNone
    Left = 33
    Top = 8
  end
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
  object RvDs: TRvDataSetConnection
    RuntimeVisibility = rtDeveloper
    DataSet = CdsCP
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
    ProjectFile = 'CPagamento.rav'
    Left = 24
    Top = 80
  end
  object CdsCP: TClientDataSet
    Active = True
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CODIGOCONDICAOPAGAMENTO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'CONDICAOPAGAMENTO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 50
      end
      item
        Name = 'CODIGOFORMAFATURAMENTO'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'NUMEROPARCELAS'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'PRIMEIRAPARCELA'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'INTERVALOPARCELAS'
        Attributes = [faRequired]
        DataType = ftInteger
      end
      item
        Name = 'AUTENTICA'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'IMPRESSAOCHEQUE'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'TIPOTROCO'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'FUNCAOESPECIAL'
        DataType = ftString
        Size = 60
      end
      item
        Name = 'ATIVOVENDA'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'ATIVOFINANCEIRO'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'SOMASALDO'
        DataType = ftString
        Size = 5
      end
      item
        Name = 'FORMAFATURAMENTO'
        Attributes = [faRequired]
        DataType = ftString
        Size = 50
      end>
    IndexDefs = <>
    Params = <>
    StoreDefs = True
    Left = 176
    Top = 8
    Data = {
      D10100009619E0BD01000000180000000E000000000003000000D10117434F44
      49474F434F4E444943414F504147414D454E544F040001000400000011434F4E
      444943414F504147414D454E544F010049000400010005574944544802000200
      320016434F4449474F464F524D414641545552414D454E544F04000100040000
      000E4E554D45524F50415243454C415304000100040000000F5052494D454952
      4150415243454C41040001000400000011494E54455256414C4F50415243454C
      4153040001000400000009415554454E54494341010049000000010005574944
      54480200020005000F494D5052455353414F4348455155450100490000000100
      055749445448020002000500095449504F54524F434F01004900000001000557
      49445448020002003C000E46554E43414F455350454349414C01004900000001
      00055749445448020002003C000A415449564F56454E44410100490000000100
      0557494454480200020005000F415449564F46494E414E434549524F01004900
      0000010005574944544802000200050009534F4D4153414C444F010049000000
      010005574944544802000200050010464F524D414641545552414D454E544F01
      004900040001000557494454480200020032000000}
    object CdsCPCODIGOCONDICAOPAGAMENTO: TIntegerField
      FieldName = 'CODIGOCONDICAOPAGAMENTO'
      Origin = 'CONDICAOPAGAMENTO.CODIGOCONDICAOPAGAMENTO'
    end
    object CdsCPCONDICAOPAGAMENTO: TIBStringField
      FieldName = 'CONDICAOPAGAMENTO'
      Origin = 'CONDICAOPAGAMENTO.CONDICAOPAGAMENTO'
      Size = 50
    end
    object CdsCPCODIGOFORMAFATURAMENTO: TIntegerField
      FieldName = 'CODIGOFORMAFATURAMENTO'
      Origin = 'CONDICAOPAGAMENTO.CODIGOFORMAFATURAMENTO'
    end
    object CdsCPNUMEROPARCELAS: TIntegerField
      FieldName = 'NUMEROPARCELAS'
      Origin = 'CONDICAOPAGAMENTO.NUMEROPARCELAS'
    end
    object CdsCPPRIMEIRAPARCELA: TIntegerField
      FieldName = 'PRIMEIRAPARCELA'
      Origin = 'CONDICAOPAGAMENTO.PRIMEIRAPARCELA'
    end
    object CdsCPINTERVALOPARCELAS: TIntegerField
      FieldName = 'INTERVALOPARCELAS'
      Origin = 'CONDICAOPAGAMENTO.INTERVALOPARCELAS'
    end
    object CdsCPAUTENTICA: TIBStringField
      FieldName = 'AUTENTICA'
      Origin = 'CONDICAOPAGAMENTO.AUTENTICA'
      FixedChar = True
      Size = 5
    end
    object CdsCPIMPRESSAOCHEQUE: TIBStringField
      FieldName = 'IMPRESSAOCHEQUE'
      Origin = 'CONDICAOPAGAMENTO.IMPRESSAOCHEQUE'
      FixedChar = True
      Size = 5
    end
    object CdsCPFUNCAOESPECIAL: TStringField
      FieldName = 'FUNCAOESPECIAL'
      Origin = 'CONDICAOPAGAMENTO.FUNCAOESPECIAL'
      Size = 60
    end
    object CdsCPATIVOVENDA: TIBStringField
      FieldName = 'ATIVOVENDA'
      Origin = 'CONDICAOPAGAMENTO.ATIVOVENDA'
      FixedChar = True
      Size = 5
    end
    object CdsCPATIVOFINANCEIRO: TIBStringField
      FieldName = 'ATIVOFINANCEIRO'
      Origin = 'CONDICAOPAGAMENTO.ATIVOFINANCEIRO'
      FixedChar = True
      Size = 5
    end
    object CdsCPSOMASALDO: TIBStringField
      FieldName = 'SOMASALDO'
      Origin = 'CONDICAOPAGAMENTO.SOMASALDO'
      FixedChar = True
      Size = 5
    end
    object CdsCPFORMAFATURAMENTO: TIBStringField
      FieldName = 'FORMAFATURAMENTO'
      Origin = 'FORMAFATURAMENTO.FORMAFATURAMENTO'
      Size = 50
    end
    object CdsCPTIPOTROCO: TStringField
      FieldName = 'TIPOTROCO'
      Size = 60
    end
  end
end
