object FrmConfig: TFrmConfig
  Left = 355
  Top = 102
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = 'Configura'#231#245'es'
  ClientHeight = 510
  ClientWidth = 305
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = [fsBold]
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 100
    Height = 13
    Caption = 'N'#250'mero de Terminais'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 32
    Width = 81
    Height = 13
    Caption = 'Nome do Pedido:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label5: TLabel
    Left = 8
    Top = 112
    Width = 95
    Height = 13
    Caption = 'Nome do Vendedor:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 8
    Top = 193
    Width = 38
    Height = 13
    Caption = 'Origem:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 8
    Top = 166
    Width = 81
    Height = 13
    Caption = 'Tabela de Pre'#231'o:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label12: TLabel
    Left = 8
    Top = 139
    Width = 82
    Height = 13
    Caption = 'Politica de Pre'#231'o:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object SpeedButton1: TSpeedButton
    Left = 196
    Top = 163
    Width = 23
    Height = 22
    Hint = 'Consultar Tabelas de Pre'#231'o'
    Flat = True
    Glyph.Data = {
      36050000424D3605000000000000360400002800000010000000100000000100
      08000000000000010000C40E0000C40E00000001000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
      A6000020400000206000002080000020A0000020C0000020E000004000000040
      20000040400000406000004080000040A0000040C0000040E000006000000060
      20000060400000606000006080000060A0000060C0000060E000008000000080
      20000080400000806000008080000080A0000080C0000080E00000A0000000A0
      200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
      200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
      200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
      20004000400040006000400080004000A0004000C0004000E000402000004020
      20004020400040206000402080004020A0004020C0004020E000404000004040
      20004040400040406000404080004040A0004040C0004040E000406000004060
      20004060400040606000406080004060A0004060C0004060E000408000004080
      20004080400040806000408080004080A0004080C0004080E00040A0000040A0
      200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
      200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
      200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
      20008000400080006000800080008000A0008000C0008000E000802000008020
      20008020400080206000802080008020A0008020C0008020E000804000008040
      20008040400080406000804080008040A0008040C0008040E000806000008060
      20008060400080606000806080008060A0008060C0008060E000808000008080
      20008080400080806000808080008080A0008080C0008080E00080A0000080A0
      200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
      200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
      200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
      2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
      2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
      2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
      2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
      2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
      2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
      2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDA4A3A4FDFD
      FDFDFDFDFDFDFDFDFDFDFDAEAF9CA4FDFDFDFDFDFDFDFDFDFDFDFDBF77A79CA4
      FDFDFDFDFDFDFDFDFDFDFDFDBF77A79CA4FDFDFDFDFDFDFDFDFDFDA4A4AE77A6
      9BA4A3A4A4A4A4A4A4FDFDDADADAB7B6EC09FFFFFFA4A4EC91FDFD04F6F6F6A4
      0909F6F6F6FFA4F604FDFD04F60808A409090808F6FFA4F704FDFD04F60808A4
      09F5080808F6F5F704FDFD04F60808A40909090909FFEC0804FDFD04F6080807
      07F609090909F7FF04FDFD04F60808080707090909ED08FF04FDFD04F60808F6
      F607ED0707F6F6FF04FDFD04F6F6F6F6F6F6F6F6F6F6F6FF04FDFDD9E1E1E1E1
      E1E1E1E1E2E1E2E399FDFDE0E1E0E0E0E0E0E0E0E0E0E1E2E3FD}
    ParentShowHint = False
    ShowHint = True
    OnClick = SpeedButton1Click
  end
  object Label13: TLabel
    Left = 10
    Top = 397
    Width = 65
    Height = 13
    Caption = 'Mensagem:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object PanLimite: TPanel
    Left = 6
    Top = 55
    Width = 289
    Height = 46
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 2
    object Label2: TLabel
      Left = 8
      Top = 24
      Width = 17
      Height = 13
      Caption = 'De:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label3: TLabel
      Left = 96
      Top = 24
      Width = 21
      Height = 13
      Caption = 'At'#233':'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label9: TLabel
      Left = 9
      Top = 4
      Width = 154
      Height = 13
      Caption = 'Limite de C'#243'digo do Pedido:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object MskLimiteDe: TMaskEdit
      Left = 36
      Top = 20
      Width = 53
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object MskLimiteeAte: TMaskEdit
      Left = 124
      Top = 20
      Width = 53
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object TxtPedido: TEdit
    Left = 140
    Top = 29
    Width = 156
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
  end
  object TxtVendedor: TEdit
    Left = 140
    Top = 109
    Width = 125
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object CmbOrigem: TComboBox
    Left = 140
    Top = 190
    Width = 80
    Height = 21
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 6
    Items.Strings = (
      '0'
      '1'
      '2')
  end
  object ChkObs: TCheckBox
    Left = 96
    Top = 215
    Width = 153
    Height = 17
    Caption = 'Cadastrar Observa'#231#227'o'
    TabOrder = 8
  end
  object PanServico: TPanel
    Left = 8
    Top = 241
    Width = 289
    Height = 74
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 10
    object Label14: TLabel
      Left = 8
      Top = 24
      Width = 52
      Height = 13
      Caption = 'Acr'#233'scimo:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label15: TLabel
      Left = 8
      Top = 48
      Width = 49
      Height = 13
      Caption = 'Desconto:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object CmbAcrescimo: TComboBox
      Left = 72
      Top = 20
      Width = 93
      Height = 21
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ItemIndex = 0
      ParentFont = False
      TabOrder = 0
      Text = 'Dinheiro'
      OnChange = CmbAcrescimoChange
      Items.Strings = (
        'Dinheiro'
        'Porcentagem')
    end
    object CmbDesconto: TComboBox
      Left = 72
      Top = 44
      Width = 93
      Height = 21
      Style = csDropDownList
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ItemHeight = 13
      ItemIndex = 0
      ParentFont = False
      TabOrder = 2
      Text = 'Dinheiro'
      OnChange = CmbDescontoChange
      Items.Strings = (
        'Dinheiro'
        'Porcentagem')
    end
    object EdAcrescimo: TEdit
      Left = 170
      Top = 21
      Width = 111
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnEnter = EdAcrescimoEnter
      OnExit = EdAcrescimoExit
    end
    object EdDesconto: TEdit
      Left = 170
      Top = 45
      Width = 111
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnEnter = EdDescontoEnter
      OnExit = EdDescontoExit
    end
  end
  object ChkServico: TCheckBox
    Left = 8
    Top = 237
    Width = 148
    Height = 17
    Caption = 'Desconto e Acrescimo'
    TabOrder = 9
    OnClick = ChkServicoClick
  end
  object MskTerminais: TMaskEdit
    Left = 140
    Top = 4
    Width = 156
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
  end
  object MskTabelaPreco: TMaskEdit
    Left = 140
    Top = 163
    Width = 53
    Height = 21
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    ReadOnly = True
    TabOrder = 5
  end
  object ActionToolBar1: TActionToolBar
    Left = 0
    Top = 482
    Width = 305
    Height = 28
    ActionManager = AmConfig
    Align = alBottom
    Caption = 'ActionToolBar1'
    ColorMap.HighlightColor = 14410210
    ColorMap.BtnSelectedColor = clBtnFace
    ColorMap.UnusedColor = 14410210
    Spacing = 140
    VertMargin = 2
  end
  object PanDataBase: TPanel
    Left = 5
    Top = 319
    Width = 289
    Height = 72
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 11
    object Label8: TLabel
      Left = 8
      Top = 28
      Width = 14
      Height = 13
      Caption = 'IP:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label10: TLabel
      Left = 8
      Top = 52
      Width = 49
      Height = 13
      Caption = 'Endere'#231'o:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label11: TLabel
      Left = 9
      Top = 4
      Width = 92
      Height = 13
      Caption = 'Banco de Dados:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Cmd: TSpeedButton
      Left = 259
      Top = 48
      Width = 25
      Height = 22
      Hint = 'Procurar Banco de Dados'
      Action = ActPastas
      Flat = True
      Glyph.Data = {
        36050000424D3605000000000000360400002800000010000000100000000100
        08000000000000010000420B0000420B0000000100000001000000730800087B
        080008841000088C100008A51800108C2100109C210018AD290031C64A0042D6
        6B0052D67B005AE78C0018A5C60018ADD60021ADD60029ADD60031B5DE0052BD
        E7004AC6E7004AC6EF009CDEEF00ADDEEF006BDEF70073DEF700A5EFF700FF00
        FF0084EFFF008CEFFF0094EFFF008CF7FF0094F7FF00A5F7FF0094FFFF009CFF
        FF00ADFFFF00C6FFFF00D6FFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
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
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00191919191919
        19191919191919191919190F100E191919191919191919191919190F141A120E
        0C0C0C19191919191919190F11212017171717120E0C19191919190F11221D1B
        1B1B171717130E191919190F0F151E1E1B1B1B1B171713191919190F170F211D
        1D1D1B1B1B17170C1919190F1E0F1518181F1B1B1B17000C1919190F21170F0C
        0C0C151D1A000B000C19190F211E171717160F15000A09080019190F211E1E1E
        1E17170F0C0508060C19190F23202124241B1C17170207021919190E14232314
        0D0C0C0C0C03041919191919100F0C0C19191919030402191919191919191919
        1900010303011919191919191919191919191919191919191919}
      ParentShowHint = False
      ShowHint = True
    end
    object BtnLocal: TSpeedButton
      Left = 260
      Top = 24
      Width = 23
      Height = 22
      Hint = 'Banco de Dados Local'
      Flat = True
      Glyph.Data = {
        AA020000424DAA02000000000000AA0100002800000010000000100000000100
        08000000000000010000210B0000210B00005D0000005D000000582A2A006031
        2A00603131006A383100733838007B48400098605000B6845800F4A158008F60
        6000C08F6000D48F6000EAA1600084606A00B6846A00C08F6A00CA8F6A00D4A1
        6A00C08F7300D4A17300E0A17300EAAB7300EAB67300F4B673000B067B006058
        7B007B737B00A18F7B00E0AB7B00E0B67B00EAB67B00F4CA7B00FFCA7B000B0B
        8400C0988400E0B68400EAB68400F4C08400F4CA8400FFD4840038508F00E0B6
        8F00EAB68F00CAC08F00EAC08F0058609800F4C09800F4CA98000B1CA100D4B6
        A100E0C0A100EACAA100F4CAA1003150AB001C48B60084B6B600FFE0B600F4E0
        C000FFE0C000CACACA002331D4002338D4006A98D400FFEAD400FFF4D4001C50
        E000388FE000A1C0E000FFF4E000FFF4EA00FFFFEA00116AF400237BF4002A84
        F4006AABF40073B6F400FFFFF400FF00FF000B6AFF001173FF00167BFF001684
        FF001C84FF002A84FF001C8FFF00238FFF002A8FFF001C98FF002398FF002A98
        FF002AA1FF007BB6FF00FFFFFF004D4D4D4D060606064D4D4D4D4D4D4D4D4D4D
        4D060B1E2913060606064D4D4D4D4D4D06130C24332C0702040606064D4D4D06
        1C160C2A392F0E02020A1510064D06251F160C2E3F381202020A1511064D0626
        1F17082E453F2200020A1511064D0626201C1B2E4C453105030F1511064D0620
        2B42473E4645443929231C11064D06375A57524E4A46453F39332413094D4956
        595A55504E4B46453F38311A0D4D4D5356595A55504E4B46463B2D194D4D4D4D
        4956595955504E5B4335284D4D4D4D4D4D56595A5952504E41364D4D4D4D4D4D
        4D4D56595A5848303D4D4D4D4D4D4D4D4D4D4D56594D4D183C4D4D4D4D4D4D4D
        4D4D4D4D4D4D4D213C4D4D4D4D4D}
      ParentShowHint = False
      ShowHint = True
      OnClick = BtnLocalClick
    end
    object MskIp: TMaskEdit
      Left = 72
      Top = 24
      Width = 185
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyPress = MskIpKeyPress
    end
    object MskEndereco: TMaskEdit
      Left = 72
      Top = 48
      Width = 185
      Height = 21
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
    end
  end
  object CmbPoliticaPreco: TComboBox
    Left = 140
    Top = 136
    Width = 125
    Height = 21
    Style = csDropDownList
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 13
    ParentFont = False
    TabOrder = 4
    Items.Strings = (
      'Normal'
      'Menor'
      'Maior'
      'M'#233'dia')
  end
  object ChkPrintGrill: TCheckBox
    Left = 8
    Top = 215
    Width = 81
    Height = 17
    Caption = 'Print Grill'
    TabOrder = 7
  end
  object MemoMensagem: TMemo
    Left = 8
    Top = 415
    Width = 289
    Height = 65
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    OnKeyPress = MemoMensagemKeyPress
  end
  object AmConfig: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = ActGravar
            Caption = '&Gravar'
            ImageIndex = 2
            ShortCut = 16467
          end
          item
            Action = ActCancelar
            Caption = '&Cancelar'
            ImageIndex = 3
            ShortCut = 27
          end>
        ActionBar = ActionToolBar1
      end>
    Images = FrmMain.Img
    Left = 240
    Top = 56
    StyleName = 'XP Style'
    object ActGravar: TAction
      Caption = 'Gravar'
      ImageIndex = 2
      ShortCut = 16467
      OnExecute = ActGravarExecute
    end
    object ActCancelar: TAction
      Caption = 'Cancelar'
      ImageIndex = 3
      ShortCut = 27
      OnExecute = ActCancelarExecute
    end
    object ActPastas: TAction
      ImageIndex = 4
      OnExecute = ActPastasExecute
    end
  end
  object DlgOpen: TOpenDialog
    Filter = 'Banco de Dados|*.GDB'
    Left = 208
    Top = 48
  end
end
