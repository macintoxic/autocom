object fdaruma: Tfdaruma
  Left = 183
  Top = 157
  Width = 112
  Height = 87
  Caption = 'fdaruma'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object serial: TComPort
    BaudRate = br9600
    Port = 'COM1'
    Parity.Bits = prNone
    StopBits = sbTwoStopBits
    DataBits = dbEight
    DiscardNull = True
    Events = []
    FlowControl.OutCTSFlow = True
    FlowControl.OutDSRFlow = True
    FlowControl.ControlDTR = dtrEnable
    FlowControl.ControlRTS = rtsHandshake
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    Left = 24
    Top = 8
  end
end
