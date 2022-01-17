object Dm: TDm
  OldCreateOrder = False
  Left = 263
  Top = 319
  Height = 213
  Width = 334
  object Tbl_UsuarioSistema: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    OnCalcFields = Tbl_UsuarioSistemaCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM USUARIOSISTEMA')
    Left = 104
    Top = 64
    object Tbl_UsuarioSistemaIDUSUARIO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'IDUSUARIO'
      Origin = 'USUARIOSISTEMA.IDUSUARIO'
      Required = True
    end
    object Tbl_UsuarioSistemaIDGRUPOUSUARIO: TIntegerField
      DisplayLabel = 'C'#243'digo do Grupo'
      FieldName = 'IDGRUPOUSUARIO'
      Origin = 'USUARIOSISTEMA.IDGRUPOUSUARIO'
      Required = True
    end
    object Tbl_UsuarioSistemaNOMEUSUARIO: TIBStringField
      DisplayLabel = #218'suario'
      FieldName = 'NOMEUSUARIO'
      Origin = 'USUARIOSISTEMA.NOMEUSUARIO'
      Required = True
    end
    object Tbl_UsuarioSistemaSENHA: TIBStringField
      DisplayLabel = 'Senha'
      FieldName = 'SENHA'
      Origin = 'USUARIOSISTEMA.SENHA'
    end
    object Tbl_UsuarioSistemaNOMECOMPLETO: TIBStringField
      DisplayLabel = 'Nome Completo'
      FieldName = 'NOMECOMPLETO'
      Origin = 'USUARIOSISTEMA.NOMECOMPLETO'
      Size = 80
    end
    object Tbl_UsuarioSistemaINATIVO: TIBStringField
      DisplayLabel = 'Status'
      FieldName = 'INATIVO'
      Origin = 'USUARIOSISTEMA.INATIVO'
      FixedChar = True
      Size = 1
    end
    object Tbl_UsuarioSistemaSTATUS: TStringField
      DisplayLabel = 'Status'
      FieldKind = fkCalculated
      FieldName = 'STATUS'
      Size = 10
      Calculated = True
    end
  end
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
  object Rede: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 24
    Top = 64
  end
  object Tbl_GrupoUsuarioSistema: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    OnCalcFields = Tbl_GrupoUsuarioSistemaCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM GRUPOUSUARIOSISTEMA')
    Left = 232
    Top = 64
    object Tbl_GrupoUsuarioSistemaIDGRUPOUSUARIO: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'IDGRUPOUSUARIO'
      Origin = 'GRUPOUSUARIOSISTEMA.IDGRUPOUSUARIO'
      Required = True
    end
    object Tbl_GrupoUsuarioSistemaNOMEGRUPO: TIBStringField
      DisplayLabel = 'Grupo'
      FieldName = 'NOMEGRUPO'
      Origin = 'GRUPOUSUARIOSISTEMA.NOMEGRUPO'
      Required = True
      Size = 50
    end
    object Tbl_GrupoUsuarioSistemaADMINISTRADOR: TIBStringField
      DisplayLabel = 'Administrador'
      FieldName = 'ADMINISTRADOR'
      Origin = 'GRUPOUSUARIOSISTEMA.ADMINISTRADOR'
      FixedChar = True
      Size = 1
    end
    object Tbl_GrupoUsuarioSistemaINATIVO: TIBStringField
      FieldName = 'INATIVO'
      Origin = 'GRUPOUSUARIOSISTEMA.INATIVO'
      FixedChar = True
      Size = 1
    end
    object Tbl_GrupoUsuarioSistemaSTATUS: TStringField
      DisplayLabel = 'Status'
      FieldKind = fkCalculated
      FieldName = 'STATUS'
      Size = 10
      Calculated = True
    end
  end
  object Tbl_PermissaoSistema: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    OnCalcFields = Tbl_PermissaoSistemaCalcFields
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT GP.IDGRUPOPERMISSAO, GP.NOMEGRUPO,'
      'PS.IDPERMISSAOSISTEMA, PS.PERMISSAO,'
      'GU.IDGRUPOUSUARIO, GU.NOMEGRUPO,'
      'GUP.INSERIR, GUP.ALTERAR, GUP.EXCLUIR'
      'FROM PERMISSAOSISTEMA PS,'
      'GRUPOPERMISSAOSISTEMA GP,'
      'GRUPOUSUARIOSISTEMA GU ,'
      'GRUPOUSUARIO_PERMISSAO GUP'
      'WHERE PS.IDGRUPOPERMISSAO = GP.IDGRUPOPERMISSAO'
      'AND  GUP.IDGRUPOUSUARIO = GU.IDGRUPOUSUARIO'
      'AND GUP.IDPERMISSAOSISTEMA = PS.IDPERMISSAOSISTEMA'
      'AND GU.IDGRUPOUSUARIO = :IDGRUPOUSUARIO '
      'ORDER BY GP.NOMEGRUPO, PS.PERMISSAO;')
    Left = 192
    Top = 8
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'IDGRUPOUSUARIO'
        ParamType = ptUnknown
      end>
    object Tbl_PermissaoSistemaIDGRUPOPERMISSAO: TIntegerField
      FieldName = 'IDGRUPOPERMISSAO'
      Origin = 'GRUPOPERMISSAOSISTEMA.IDGRUPOPERMISSAO'
      Required = True
    end
    object Tbl_PermissaoSistemaNOMEGRUPO: TIBStringField
      FieldName = 'NOMEGRUPO'
      Origin = 'GRUPOPERMISSAOSISTEMA.NOMEGRUPO'
      Required = True
      Size = 50
    end
    object Tbl_PermissaoSistemaIDPERMISSAOSISTEMA: TIntegerField
      FieldName = 'IDPERMISSAOSISTEMA'
      Origin = 'PERMISSAOSISTEMA.IDPERMISSAOSISTEMA'
      Required = True
    end
    object Tbl_PermissaoSistemaPERMISSAO: TIBStringField
      FieldName = 'PERMISSAO'
      Origin = 'PERMISSAOSISTEMA.PERMISSAO'
      Required = True
      Size = 50
    end
    object Tbl_PermissaoSistemaIDGRUPOUSUARIO: TIntegerField
      FieldName = 'IDGRUPOUSUARIO'
      Origin = 'GRUPOUSUARIOSISTEMA.IDGRUPOUSUARIO'
      Required = True
    end
    object Tbl_PermissaoSistemaNOMEGRUPO1: TIBStringField
      FieldName = 'NOMEGRUPO1'
      Origin = 'GRUPOUSUARIOSISTEMA.NOMEGRUPO'
      Required = True
      Size = 50
    end
    object Tbl_PermissaoSistemaINSERIR: TIBStringField
      FieldName = 'INSERIR'
      Origin = 'GRUPOUSUARIO_PERMISSAO.INSERIR'
      FixedChar = True
      Size = 1
    end
    object Tbl_PermissaoSistemaALTERAR: TIBStringField
      FieldName = 'ALTERAR'
      Origin = 'GRUPOUSUARIO_PERMISSAO.ALTERAR'
      FixedChar = True
      Size = 1
    end
    object Tbl_PermissaoSistemaEXCLUIR: TIBStringField
      FieldName = 'EXCLUIR'
      Origin = 'GRUPOUSUARIO_PERMISSAO.EXCLUIR'
      FixedChar = True
      Size = 1
    end
    object Tbl_PermissaoSistemaSTATUS: TStringField
      FieldKind = fkCalculated
      FieldName = 'STATUS'
      Size = 40
      Calculated = True
    end
  end
  object Tbl_Permissao: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      'SELECT * FROM PERMISSAOSISTEMA ')
    Left = 96
    Top = 128
    object Tbl_PermissaoIDPERMISSAOSISTEMA: TIntegerField
      FieldName = 'IDPERMISSAOSISTEMA'
      Origin = 'PERMISSAOSISTEMA.IDPERMISSAOSISTEMA'
      Required = True
    end
    object Tbl_PermissaoIDGRUPOPERMISSAO: TIntegerField
      FieldName = 'IDGRUPOPERMISSAO'
      Origin = 'PERMISSAOSISTEMA.IDGRUPOPERMISSAO'
      Required = True
    end
    object Tbl_PermissaoPERMISSAO: TIBStringField
      FieldName = 'PERMISSAO'
      Origin = 'PERMISSAOSISTEMA.PERMISSAO'
      Required = True
      Size = 50
    end
    object Tbl_PermissaoCADASTRO: TIBStringField
      FieldName = 'CADASTRO'
      Origin = 'PERMISSAOSISTEMA.CADASTRO'
      FixedChar = True
      Size = 1
    end
    object Tbl_PermissaoNOMETELA: TIBStringField
      FieldName = 'NOMETELA'
      Origin = 'PERMISSAOSISTEMA.NOMETELA'
      Size = 200
    end
    object Tbl_PermissaoORDEM: TIntegerField
      FieldName = 'ORDEM'
      Origin = 'PERMISSAOSISTEMA.ORDEM'
    end
  end
  object Net: TIBQuery
    Database = DBAutocom
    Transaction = Transaction
    BufferChunks = 1000
    CachedUpdates = False
    Left = 24
    Top = 120
  end
end
