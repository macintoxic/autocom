object frmFechaFaturamento: TfrmFechaFaturamento
  Left = 293
  Top = 43
  ActiveControl = mskAcrescimo
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Totais do pedido'
  ClientHeight = 551
  ClientWidth = 562
  Color = clMoneyGreen
  Constraints.MaxHeight = 600
  Constraints.MaxWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  DesignSize = (
    562
    551)
  PixelsPerInch = 96
  TextHeight = 13
  object spdVoltar: TSpeedButton
    Left = 5
    Top = 500
    Width = 272
    Height = 49
    Cursor = crHandPoint
    Action = Action1
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -15
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    Glyph.Data = {
      F6060000424DF606000000000000360000002800000018000000180000000100
      180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4E27004E27005229005E2E005E2E
      005229005028004E2700FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF4C26005028006431008A4400
      9E4E00A65200A65200A04F009047006A34005229004E2700FF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF66320062300094
      4900B85B00C26000C05F00BE5E00BE5E00C05F00C26000BA5C009C4D006E3600
      522900FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF7238
      00783B00BA5C00C26000BE5E00BA5C00BA5C00BA5C00BA5C00BA5C00BA5C00BC
      5D00C26000BE5E00864200542A00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FF7A3C00864200CC6500C66200BC5D00BA5C00BA5C00B45900B45900BA5C
      00BA5C00BA5C00BA5C00BA5C00BE5E00C260008C4500542A00FF00FFFF00FFFF
      00FFFF00FFFF00FF5C2D00864200D86B00CE6600C66200C26000BC5D00B65A00
      BC5D00BA5C00BA5C00BA5C00BA5C00BA5C00BA5C00BA5C00BC5D00C260008A44
      00522900FF00FFFF00FFFF00FFFF00FF643100D66A00DE6E00D06700CE6600C6
      6200B65A00BE6309E8C8A9FBF5F0FBF5F0DBA979BA5C00BA5C00BA5C00BA5C00
      BA5C00BC5D00C05F00683300FF00FFFF00FFFF00FF703700A65200EE7600DC6D
      00D66A00CC6500BE5E00C26509E9CAACFFFFFFFFFFFFFFFFFFDEB084BA5C00BA
      5C00BA5C00BA5C00BA5C00BA5C00C260009C4D00522900FF00FFFF00FF723800
      E06F00EC7500E27000D66A00C26000C06206E8C7A6FFFFFFFFFFFFFFFFFFE7C5
      A5BE640DBA5C00BA5C00BA5C00BA5C00BA5C00BA5C00BC5D00BC5D00643100FF
      00FF763A00924800F87B00EA7400E67200D46900C76404E6C3A0FFFFFFFFFFFF
      FFFEFEE2BA92BC5D00BA5C00BA5C00BA5C00BA5C00BA5C00BA5C00BA5C00BA5C
      00C260007E3E00562A00763A00B25800FF7E00F27800E67200F27901EFC398FF
      FFFFFFFFFFFFFFFFEED1B5D07D2CD17C29C8792CC6782CC6782CC6782CC6782C
      C6792DC16D1BBA5C00C26000944900562A00803F00CA6400FF860FF87B00FF7E
      00FDC48CFFFFFFFFFFFFFFFFFFFFFFFFFEF8F2FFFAF6FFFCF8FDFBF8FDFBF8FD
      FBF8FDFBF8FDFBF8FDFBF8F6EADEBA5C00C260009E4E00542A008A4400E06F00
      FF9731FF8003FC7D00FFF8F2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFEBC5D00C05F00A04F0066
      3200924800E06F00FFA853FF8F21FC7D00FDAB5BFFFAF6FFFFFFFFFFFFFFFFFF
      FFF1E4FFEAD6FEEDDDF9EBDDF7EADDF7EADDF7EADDF6EADDF7EADEEFD4BABE5E
      00C260009E4E00562A00984B00D86B00FFB267FFA64FFA7C00FC7D00FDA54FFF
      F8F1FFFFFFFFFFFFFEE3C9F38E2CE27101DB720ADB720ADA710ADA710AD66F0A
      D66F0AD66C03C46100C26000904700562A00FF00FFBE5E00FFB165FFC083FF92
      27E87300FC7D00FDA044FFF4EAFFFFFFFFFFFFFEEBD8F39539E06F00DA6C00DA
      6C00DA6C00DA6C00D66A00CE6600C05F00C26000783B00FF00FFFF00FFC66200
      FF9833FFD2A7FFB66FFF8309E87300FA7C00FD9B3AFFF1E4FFFFFFFFFFFFFFF7
      F0F4A04CDC6D00DA6C00D86B00D46900D06700C86300C66200BE5E005E2E00FF
      00FFFF00FFFF00FFE27000FFCB99FFD8B1FFA64FFF7E00E67200F87B00FD9530
      FFEDDBFFFFFFFFFFFFFCCEA1E27000E06F00DA6C00D86B00D46900CC6500D469
      009A4C00FF00FFFF00FFFF00FFFF00FFF47900FF9833FFDAB5FFD8B1FFA44BFF
      8309E87300F87B00FC9128FEDEBEFFF0E2FF9D3EE27000E27000E06F00DC6D00
      D86B00D86B00CE6600663200FF00FFFF00FFFF00FFFF00FFFF00FFD66A00FFAF
      61FFE2C5FFDEBDFFB46BFF9227F87B00F27800FF8309FC7D00F07700F27800EE
      7600EC7500E67200E27000DE6E00884300FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFD26800FFB165FFE2C5FFE8D1FFCFA1FFB267FF9E3FFF8F21FF89
      15FF8B19FF8E1FFF8E1FFF8711FC7D00EA7400924800FF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFE27000FF9C3BFFCB99FFDEBDFFE2C5
      FFD8B1FFCB99FFC287FFBC7BFFB46BFFA44BFF9227F47900944900FF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFE27000E2
      7000FF9E3FFFBC7BFFC893FFC893FFC287FFB771FFA64FFF8B19D06700864200
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFE27000E06F00F87B00F87B00FA7C00EE7600CC65009A
      4C00FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    Layout = blGlyphTop
    ParentFont = False
  end
  object spdEnviar: TSpeedButton
    Left = 285
    Top = 500
    Width = 272
    Height = 49
    Cursor = crHandPoint
    Action = Action2
    Anchors = [akLeft]
    BiDiMode = bdLeftToRight
    Flat = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -15
    Font.Name = 'Verdana'
    Font.Style = [fsBold]
    Glyph.Data = {
      76060000424D7606000000000000360400002800000018000000180000000100
      08000000000040020000330B0000330B00000001000000010000007B00000094
      000000C6000000314A00084263006363630084848400085A940010849C002194
      9C00A5FFA5001873AD002984BD002184C600429CC60042A5C6004AA5C600C6C6
      C600C6FFC6005A5ACE003963CE00107BCE0042A5CE005AA5CE0073B5D6006BBD
      D6007BBDD6006BC6D6004A5ADE0073C6DE007BCEDE0039A5E700299CEF007B9C
      EF008CCEEF0094DEEF0052C6F700FF00FF008C94FF0084A5FF004ABDFF007BE7
      FF0094E7FF009CE7FF008CF7FF00BDFFFF00C6FFFF00D6FFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00252525252525
      2525252525252525252525252525252525252525252525252525252525252525
      2525252525252525252525252525252525252525252525252525252525252525
      2525252525252525252525252506070404040306252525252525252525250607
      0404030625282F2D2C2C201525252525252525252525282F2D2C201525062828
      282828060403252525252525252506282828280625252525272A2D1E100C1325
      2525252525252525252525252525252526222D190E0D1C252525252525252525
      2525252525252525250704040403252525252525252525252525252525252525
      21222D190E0D14252525252500000000000000000000000018232D190E0D0B00
      000025250001010101020A121212121212170404040301010100252500010101
      020A1212120505051A1D2D1B0F0D080101002525000101020A121212052E112E
      222B2D29241F0901010025250001020A121212052E1111111128282828281202
      0100252500010212121212052E2E11112E2E051212121202010025250001020A
      12121212051111111105121212120A0201002525000101020A12121212050505
      05121212120A02010100252500010101020A121212121212121212120A020101
      010025250001010101021212121212121212120A020101010100252500000000
      0000000000000000000000000000000000002525252525252525252525252525
      2525252525252525252525252525252525252525252525252525252525252525
      2525252525252525252525252525252525252525252525252525}
    Layout = blGlyphTop
    ParentFont = False
    ParentBiDiMode = False
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 0
    Width = 562
    Height = 257
    Align = alTop
    Caption = 'Condi'#231#245'es de pagamento'
    Color = clMoneyGreen
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 0
    object Panel1: TPanel
      Left = 2
      Top = 18
      Width = 558
      Height = 237
      Align = alClient
      BevelInner = bvLowered
      Color = clMoneyGreen
      TabOrder = 0
      object lbFormaPagamentos: TTreeView
        Left = 2
        Top = 2
        Width = 319
        Height = 233
        Cursor = crHandPoint
        Align = alLeft
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clNavy
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        HotTrack = True
        Indent = 19
        ParentFont = False
        ReadOnly = True
        RowSelect = True
        ShowLines = False
        ShowRoot = False
        TabOrder = 0
        OnChange = lbFormaPagamentosChange
        OnClick = lbFormaPagamentosClick
        OnEnter = memObsEnter
        OnExit = memObsExit
        OnKeyDown = lbFormaPagamentosKeyDown
      end
      object Panel2: TPanel
        Left = 363
        Top = 2
        Width = 193
        Height = 233
        Align = alRight
        Alignment = taLeftJustify
        BevelInner = bvLowered
        BevelOuter = bvLowered
        Color = clSkyBlue
        TabOrder = 1
        object Panel3: TPanel
          Left = 4
          Top = 8
          Width = 185
          Height = 217
          BevelInner = bvRaised
          BevelOuter = bvLowered
          Color = clSkyBlue
          TabOrder = 0
          object Label3: TLabel
            Left = 5
            Top = 5
            Width = 132
            Height = 16
            Caption = 'N'#250'mero de parcelas:'
          end
          object Label4: TLabel
            Left = 5
            Top = 77
            Width = 173
            Height = 16
            Caption = 'Intervalo entre as parcelas:'
          end
          object Label5: TLabel
            Left = 5
            Top = 151
            Width = 163
            Height = 16
            Caption = 'Data da primeira parcela:'
          end
          object lblParcelas: TLabel
            Left = 10
            Top = 24
            Width = 20
            Height = 16
            Caption = '     '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsItalic]
            ParentFont = False
          end
          object lblDataPrimeira: TLabel
            Left = 10
            Top = 168
            Width = 20
            Height = 16
            Caption = '     '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsItalic]
            ParentFont = False
          end
          object lblIntervalo: TLabel
            Left = 10
            Top = 96
            Width = 24
            Height = 16
            Caption = '      '
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clMaroon
            Font.Height = -13
            Font.Name = 'Arial'
            Font.Style = [fsBold, fsItalic]
            ParentFont = False
          end
        end
      end
    end
  end
  object Panel_valor: TPanel
    Left = 0
    Top = 257
    Width = 562
    Height = 238
    Align = alTop
    BevelInner = bvLowered
    BevelOuter = bvLowered
    Color = clSkyBlue
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 2
      Top = 112
      Width = 558
      Height = 43
      Align = alTop
      Caption = 'Peso total do pedido'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 1
      object Label7: TLabel
        Left = 312
        Top = 18
        Width = 92
        Height = 19
        Caption = 'Peso Bruto:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 13
        Top = 20
        Width = 107
        Height = 19
        Caption = 'Peso L'#237'quido:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPesoLiquido: TLabel
        Left = 137
        Top = 20
        Width = 122
        Height = 19
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,000'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblPesobruto: TLabel
        Left = 436
        Top = 18
        Width = 122
        Height = 19
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,000'
        Font.Charset = ANSI_CHARSET
        Font.Color = clMaroon
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object GroupBox3: TGroupBox
      Left = 2
      Top = 2
      Width = 558
      Height = 110
      Align = alTop
      Caption = ' Totais '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold, fsItalic]
      ParentFont = False
      TabOrder = 0
      object Label2: TLabel
        Left = 11
        Top = 29
        Width = 119
        Height = 19
        Caption = '(+) Acr'#233'scimos:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label18: TLabel
        Left = 11
        Top = 57
        Width = 108
        Height = 19
        Caption = '(-) Descontos:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 11
        Top = 83
        Width = 44
        Height = 19
        Caption = 'Total:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotalCupom: TLabel
        Left = 85
        Top = 83
        Width = 160
        Height = 19
        Alignment = taRightJustify
        AutoSize = False
        Caption = '0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Shape1: TShape
        Left = 8
        Top = 79
        Width = 240
        Height = 3
        Brush.Color = clRed
      end
      object Label13: TLabel
        Left = 378
        Top = 7
        Width = 77
        Height = 19
        Caption = 'Descri'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Transparent = True
      end
      object edOBSAcrescimo: TEdit
        Left = 309
        Top = 27
        Width = 223
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold, fsItalic]
        MaxLength = 100
        ParentFont = False
        TabOrder = 1
      end
      object edOBSDesconto: TEdit
        Left = 309
        Top = 55
        Width = 223
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold, fsItalic]
        MaxLength = 100
        ParentFont = False
        TabOrder = 3
      end
      object mskDesconto: TEdit
        Left = 144
        Top = 55
        Width = 101
        Height = 21
        AutoSize = False
        BevelOuter = bvRaised
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MaxLength = 15
        ParentFont = False
        TabOrder = 2
        OnExit = mskDescontoExit
        OnKeyPress = mskAcrescimoKeyPress
      end
      object mskAcrescimo: TEdit
        Left = 144
        Top = 27
        Width = 101
        Height = 21
        AutoSize = False
        BevelOuter = bvRaised
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        MaxLength = 15
        ParentFont = False
        TabOrder = 0
        OnExit = mskDescontoExit
        OnKeyPress = mskAcrescimoKeyPress
      end
    end
    object GroupBox4: TGroupBox
      Left = 2
      Top = 155
      Width = 558
      Height = 81
      Align = alClient
      TabOrder = 2
      object Label9: TLabel
        Left = 2
        Top = 15
        Width = 554
        Height = 19
        Align = alTop
        Caption = 'Observa'#231#245'es:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clNavy
        Font.Height = -16
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object memObs: TMemo
        Left = 2
        Top = 34
        Width = 554
        Height = 45
        Align = alClient
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 0
        OnEnter = memObsEnter
        OnExit = memObsExit
      end
    end
  end
  object ActionManager: TActionManager
    Left = 456
    Top = 384
    StyleName = 'XP Style'
    object Action1: TAction
      Category = 'funcoes'
      Caption = '[F11] - Voltar'
      ShortCut = 122
      OnExecute = Action1Execute
    end
    object Action2: TAction
      Category = 'funcoes'
      Caption = '[F12] - Enviar para faturamento'
      ShortCut = 123
      OnExecute = Action2Execute
    end
  end
end
