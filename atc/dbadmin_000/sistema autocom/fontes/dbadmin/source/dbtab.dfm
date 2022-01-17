object tab: Ttab
  Left = 261
  Top = 217
  Width = 136
  Height = 103
  Caption = 'tab'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object transacao: TIBTransaction
    Active = False
    DefaultDatabase = dbautocom
    AutoStopAction = saNone
    Left = 80
  end
  object dbautocom: TIBDatabase
    DatabaseName = '192.168.0.230:f:\desenvolvimento\autocom\dados\autocom.gdb'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey')
    LoginPrompt = False
    DefaultTransaction = transacao
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    AllowStreamedConnected = False
    Left = 8
  end
end
