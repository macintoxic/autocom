object frmDadosDelivery: TfrmDadosDelivery
  Left = 342
  Top = 253
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Sistema Autocom'
  ClientHeight = 213
  ClientWidth = 302
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 302
    Height = 213
    Align = alClient
    BevelInner = bvLowered
    BorderWidth = 3
    ParentBackground = False
    ParentColor = True
    TabOrder = 0
    object Label2: TLabel
      Left = 7
      Top = 24
      Width = 120
      Height = 19
      Caption = 'Taxa de servi'#231'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 10
      Top = 59
      Width = 217
      Height = 19
      Caption = 'Observa'#231#227'o sobre o pedido:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnConfirma: TBitBtn
      Left = 211
      Top = 173
      Width = 81
      Height = 25
      Cursor = crHandPoint
      Caption = 'C&onfirma'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
      OnClick = btnConfirmaClick
      Glyph.Data = {
        F2010000424DF201000000000000760000002800000024000000130000000100
        0400000000007C01000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333334433333
        3333333333388F3333333333000033334224333333333333338338F333333333
        0000333422224333333333333833338F33333333000033422222243333333333
        83333338F3333333000034222A22224333333338F33F33338F33333300003222
        A2A2224333333338F383F3338F33333300003A2A222A222433333338F8333F33
        38F33333000034A22222A22243333338833333F3338F333300004222A2222A22
        2433338F338F333F3338F3330000222A3A2224A22243338F3838F338F3338F33
        0000A2A333A2224A2224338F83338F338F3338F300003A33333A2224A2224338
        333338F338F3338F000033333333A2224A2243333333338F338F338F00003333
        33333A2224A2233333333338F338F83300003333333333A2224A333333333333
        8F338F33000033333333333A222433333333333338F338F30000333333333333
        A224333333333333338F38F300003333333333333A223333333333333338F8F3
        000033333333333333A3333333333333333383330000}
      NumGlyphs = 2
    end
    object memObs: TMemo
      Left = 10
      Top = 80
      Width = 282
      Height = 81
      MaxLength = 1000
      TabOrder = 1
      OnEnter = memObsEnter
      OnExit = memObsExit
    end
    object mskTaxaServico: TEdit
      Left = 176
      Top = 23
      Width = 118
      Height = 21
      BevelOuter = bvRaised
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      MaxLength = 15
      ParentFont = False
      TabOrder = 0
      Text = '0,00'
      OnExit = mskTaxaServicoExit
      OnKeyPress = mskTaxaServicoKeyPress
    end
  end
end
