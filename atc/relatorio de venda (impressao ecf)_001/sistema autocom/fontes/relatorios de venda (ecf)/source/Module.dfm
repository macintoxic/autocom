object Dm: TDm
  OldCreateOrder = False
  Left = 250
  Top = 241
  Height = 217
  Width = 362
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
  object Net: TIBQuery
    Database = dbautocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 160
    Top = 8
  end
  object CdsOperadoresF: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CodigoCondicaoPagamento'
        DataType = ftFloat
      end
      item
        Name = 'CondicaoPagamento'
        DataType = ftString
        Size = 40
      end
      item
        Name = 'SangriaQtde'
        DataType = ftFloat
      end
      item
        Name = 'SangriaValor'
        DataType = ftFloat
      end
      item
        Name = 'FinalizadoraQtde'
        DataType = ftFloat
      end
      item
        Name = 'FinalizadoraValor'
        DataType = ftFloat
      end
      item
        Name = 'Repique'
        DataType = ftFloat
      end
      item
        Name = 'ContraVale'
        DataType = ftFloat
      end
      item
        Name = 'SomaSaldo'
        DataType = ftBoolean
      end
      item
        Name = 'IdUsuario'
        DataType = ftFloat
      end
      item
        Name = 'Fcx'
        DataType = ftFloat
      end
      item
        Name = 'Troco'
        DataType = ftFloat
      end>
    IndexDefs = <
      item
        Name = 'CodigoCondicaoPagamento'
        DescFields = 'CodigoCondicaoPagamento'
        Fields = 'CodigoCondicaoPagamento'
        Options = [ixDescending]
      end>
    IndexName = 'CodigoCondicaoPagamento'
    Params = <>
    StoreDefs = True
    OnCalcFields = CdsOperadoresFCalcFields
    Left = 224
    Top = 8
    object CdsOperadoresFCodigoCondicaoPagamento: TFloatField
      FieldName = 'CodigoCondicaoPagamento'
    end
    object CdsOperadoresFCondicaoPagamento: TStringField
      FieldName = 'CondicaoPagamento'
      Size = 40
    end
    object CdsOperadoresFSangriaQtde: TFloatField
      FieldName = 'SangriaQtde'
    end
    object CdsOperadoresFSangriaValor: TFloatField
      FieldName = 'SangriaValor'
      currency = True
    end
    object CdsOperadoresFFinalizadoraQtde: TFloatField
      FieldName = 'FinalizadoraQtde'
    end
    object CdsOperadoresFFinalizadoraValor: TFloatField
      FieldName = 'FinalizadoraValor'
      currency = True
    end
    object CdsOperadoresFRepique: TFloatField
      FieldName = 'Repique'
      currency = True
    end
    object CdsOperadoresFContraVale: TFloatField
      FieldName = 'ContraVale'
      currency = True
    end
    object CdsOperadoresFSaldoFinal: TFloatField
      FieldKind = fkCalculated
      FieldName = 'SaldoFinal'
      currency = True
      Calculated = True
    end
    object CdsOperadoresFSomaSaldo: TBooleanField
      FieldName = 'SomaSaldo'
    end
    object CdsOperadoresFIdUsuario: TFloatField
      FieldName = 'IdUsuario'
    end
    object CdsOperadoresFSomaSaldoSimbolo: TStringField
      FieldKind = fkCalculated
      FieldName = 'SomaSaldoSimbolo'
      Size = 1
      Calculated = True
    end
    object CdsOperadoresFFcx: TFloatField
      FieldName = 'Fcx'
      currency = True
    end
    object CdsOperadoresFFinalizadoraValorL: TFloatField
      FieldKind = fkCalculated
      FieldName = 'FinalizadoraValorL'
      currency = True
      Calculated = True
    end
    object CdsOperadoresFTroco: TFloatField
      FieldName = 'Troco'
      currency = True
    end
  end
  object CDSeXTRATOcliente: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CDSeXTRATOclienteField1'
      end>
    IndexDefs = <
      item
        Name = 'indice'
        Fields = 'data;codigo'
        Options = [ixPrimary, ixUnique]
      end>
    IndexName = 'indice'
    Params = <>
    StoreDefs = True
    Left = 224
    Top = 70
    object CDSeXTRATOclientedata: TDateField
      FieldName = 'data'
    end
    object CDSeXTRATOclientecodigo: TIntegerField
      FieldName = 'codigo'
    end
    object CDSeXTRATOclienteproduto: TStringField
      FieldName = 'produto'
      Size = 100
    end
    object CDSeXTRATOclienteqtde: TFloatField
      FieldName = 'qtde'
    end
    object CDSeXTRATOclientevalor: TFloatField
      FieldName = 'valor'
    end
  end
end
