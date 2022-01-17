object Dm: TDm
  OldCreateOrder = False
  Left = 215
  Top = 214
  Height = 252
  Width = 470
  object Tbl_Produto: TIBQuery
    Database = dbautocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      
        'Select * from Produto P inner Join Estoque E on (P.CodigoProduto' +
        ' = E.CodigoProduto) order by P.NomeProduto')
    Left = 160
    Top = 16
    object Tbl_ProdutoCODIGOPRODUTO: TIntegerField
      Alignment = taLeftJustify
      DisplayLabel = 'C'#243'digo'
      FieldName = 'CODIGOPRODUTO'
      Origin = 'PRODUTO.CODIGOPRODUTO'
      Required = True
    end
    object Tbl_ProdutoNOMEPRODUTO: TIBStringField
      DisplayLabel = 'Nome'
      DisplayWidth = 39
      FieldName = 'NOMEPRODUTO'
      Origin = 'PRODUTO.NOMEPRODUTO'
      Required = True
      Size = 110
    end
    object Tbl_ProdutoCODIGOESTOQUE: TIntegerField
      FieldName = 'CODIGOESTOQUE'
      Origin = 'ESTOQUE.CODIGOESTOQUE'
      Required = True
      Visible = False
    end
    object Tbl_ProdutoESTOQUEATUAL: TFloatField
      FieldName = 'ESTOQUEATUAL'
      Origin = 'ESTOQUE.ESTOQUEATUAL'
      Visible = False
    end
    object Tbl_ProdutoESTOQUEMINIMO: TFloatField
      FieldName = 'ESTOQUEMINIMO'
      Origin = 'ESTOQUE.ESTOQUEMINIMO'
      Visible = False
    end
    object Tbl_ProdutoESTOQUEMAXIMO: TFloatField
      FieldName = 'ESTOQUEMAXIMO'
      Origin = 'ESTOQUE.ESTOQUEMAXIMO'
      Visible = False
    end
  end
  object Transaction: TIBTransaction
    Active = False
    DefaultDatabase = dbautocom
    AutoStopAction = saNone
    Left = 88
    Top = 16
  end
  object dbautocom: TIBDatabase
    DatabaseName = '10.1.2.240:c:\autocom\dados\autocom.gdb'
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
  object Rede: TIBQuery
    Database = dbautocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 224
    Top = 16
  end
end
