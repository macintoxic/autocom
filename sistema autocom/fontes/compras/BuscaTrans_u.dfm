object fBuscaTransportadora: TfBuscaTransportadora
  Left = 192
  Top = 107
  Width = 400
  Height = 400
  Caption = 'fBuscaTransportadora'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object grdTransportadora: TDBGrid
    Left = 0
    Top = 0
    Width = 392
    Height = 345
    Align = alClient
    DataSource = DSTransportadora
    FixedColor = clSkyBlue
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = grdTransportadoraDblClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 345
    Width = 392
    Height = 28
    Align = alBottom
    TabOrder = 1
    object CmdProcurar: TSpeedButton
      Left = 307
      Top = 4
      Width = 82
      Height = 21
      Cursor = crHandPoint
      Hint = '[F12] - Procurar registro'
      Caption = '&Procurar'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000120B0000120B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333300000000
        0000333377777777777733330FFFFFFFFFF033337F3FFF3F3FF733330F000F0F
        00F033337F777373773733330FFFFFFFFFF033337F3FF3FF3FF733330F00F00F
        00F033337F773773773733330FFFFFFFFFF033337FF3333FF3F7333300FFFF00
        F0F03333773FF377F7373330FB00F0F0FFF0333733773737F3F7330FB0BF0FB0
        F0F0337337337337373730FBFBF0FB0FFFF037F333373373333730BFBF0FB0FF
        FFF037F3337337333FF700FBFBFB0FFF000077F333337FF37777E0BFBFB000FF
        0FF077FF3337773F7F37EE0BFB0BFB0F0F03777FF3733F737F73EEE0BFBF00FF
        00337777FFFF77FF7733EEEE0000000003337777777777777333}
      NumGlyphs = 2
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object TxtPesquisa: TEdit
      Left = 2
      Top = 4
      Width = 303
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 0
    end
  end
  object DSTransportadora: TDataSource
    DataSet = DM.tblTransportadora
    Left = 312
    Top = 8
  end
end
