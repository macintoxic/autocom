object flogs: Tflogs
  Left = 224
  Top = 268
  Width = 394
  Height = 260
  Caption = 'Logs'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 112
    Width = 367
    Height = 13
    Caption = 
      'N'#227'o se esque'#231'a de alterar a propriedade connected do dbautocom p' +
      'ara false'
  end
  object memo1: TRichEdit
    Left = 0
    Top = 136
    Width = 337
    Height = 89
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    Lines.Strings = (
      '1234567890123456789012345678901234567890')
    ParentFont = False
    TabOrder = 0
  end
  object LogAtual: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      '')
    Left = 16
    Top = 8
  end
  object LogUltimo: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      '')
    Left = 96
    Top = 8
  end
  object Log: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      '')
    Left = 176
    Top = 8
  end
  object DbAutocom: TIBDatabase
    DatabaseName = '192.168.0.230:f:\desenvolvimento\autocom\dados\autocom.gdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = IBTransaction1
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    AllowStreamedConnected = False
    Left = 336
    Top = 8
  end
  object IBTransaction1: TIBTransaction
    Active = False
    DefaultDatabase = DbAutocom
    AutoStopAction = saNone
    Left = 336
    Top = 64
  end
  object print: TIBQuery
    Database = DbAutocom
    Transaction = IBTransaction1
    BufferChunks = 1000
    CachedUpdates = False
    SQL.Strings = (
      '')
    Left = 176
    Top = 64
  end
end
