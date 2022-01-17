object fMain: TfMain
  Left = 62
  Top = 7
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Cadastro de Clientes'
  ClientHeight = 533
  ClientWidth = 672
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object BtnSalvar: TSpeedButton
    Left = 2
    Top = 506
    Width = 120
    Height = 22
    Action = ActSalvar
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7CD04C562D773153313362B76E1A7BF97AD872B7721329D21C
      3529343D1F7C1F7C763DBA31BA31742D353E393E7D67FF7FFE7BDD733421B214
      572577311F7C1F7C7641B9319931953138423625774A9C73FF7FFE7F3425B214
      572576351F7C1F7C7641B9319931B5353846B314143ED55A7B6FFF7F3425B214
      572576351F7C1F7C7641B93199319531FA5A794EF95AD65AF85E7B6F3425B214
      572576351F7C1F7C7641BA3199319931F739F739D83599319631B835772D5725
      992D76351F7C1F7C763D7729384239463946394639463946394639463A461842
      B93156351F7C1F7C563DB731FE7FDE7BDE7BDE7BDE7BDE7BDE7BDE7BFE7F7C6F
      B83156311F7C1F7C563DB731FF7FDE7BBD77BD77DE7BDE7BDE7BDE7BDE7B7C6F
      B83156311F7C1F7C563DB731FF7F7B6F5A6B5A6B5A6B5A6B7B6F7B6F9C737C6F
      B83156311F7C1F7C563DB731FE7F9C735A6B7A6F7B6F7B6F7B6F7B6FBC777C6F
      B83156311F7C1F7C563DB731FF7F9C737B6F7B6F7B6F7B6F7B6F7B6FBC777C6F
      B83156311F7C1F7C763DD731FF7F9C739C739C739C739C739C739C73BD779D73
      B83556311F7C1F7C5535B725FD77DD73DD73DD73DD73DD73DD73DD73FD737C67
      B82935351F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    ParentFont = False
  end
  object BtnExcluir: TSpeedButton
    Left = 138
    Top = 506
    Width = 120
    Height = 22
    Action = ActExcluir
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C104210421042104210421042104210421F7C1F7C
      1F7C1F7C1F7C1F7C1F7C104218631863FF7FFF7FFF7FFF7FFF7F186310421042
      1F7C1F7C1F7C1F7C104218631863FF7FFF7FFF7F1F00FF7F10021F0010021863
      10421F7C1F7C1F7C10421863FF7F1863FF7FFF7F100218631F00100010001000
      186310421F7C1F7C104218631863FF7FFF7FFF7F100210021F00FF7FFF7F1863
      1000186310001F7C10421863FF7F1863FF7FFF7F100210021F001F00FF7FFF7F
      1863186310001F7C104218631863FF7FFF7FFF7F1002FF7FFF7FFF7F10001000
      1000186310001F7C10421863FF7F1863FF7FFF7F1863FF031863FF7F18631F00
      1000186310001F7C104218631863FF7FFF7FFF7FFF7F1F00100218631F001000
      1000186310001F7C10421863FF7F1863FF7FFF7FFF7FFF031F001F001002FF7F
      1000186310001F7C104218631863FF7FFF7FFF7FFF7FFF7FFF7F1863FF7F1863
      1863186310001F7C1042FF7F10421F001000100010001042104218631863FF7F
      1863186310001F7C1042FF7F0000100010021042104210421863104210421863
      1863186310001F7C1F7C1042FF7F100010401F00100210421863186318631042
      1042186310001F7C1F7C1F7C104210421863100010401F001F00104218631863
      104210421F7C1F7C1F7C1F7C1F7C1F7C10421042104210421042104210421042
      1F7C1F7C1F7C}
    ParentFont = False
  end
  object BtnRelatorio: TSpeedButton
    Left = 274
    Top = 506
    Width = 120
    Height = 22
    Action = ActRelatorio
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C93319331933193319331933193319331933193319331
      933193311F7C1F7C1F7C794EBF67BF677F677F677F677F677F677F677F677F67
      7F6793311F7C1F7C1F7C794EBF67BF67BF67BF67BF67BF67BF677F677F677F67
      7F6793311F7C1F7C1F7C794EBF671F001F00BF67007CBF67BF677F67007C7F67
      7F6793311F7C1F7C1F7C794EFF33FF33FF33FF33BF67007C007C007C007C7F67
      7F6793311F7C1F7C1F7C794EFF331F001F001F001F00BF67007CBF67007C7F67
      7F6793311F7C1F7C1F7C794EFF33FF33FF33FF33FF33FF33BF67007C007CBF67
      7F6793311F7C1F7C1F7C794EFF331F001F001F001F001F00BF67BF67007CBF67
      7F6793311F7C1F7C1F7C794EFF33FF33FF33FF33FF33FF33FF33BF67BF67BF67
      7F6793311F7C1F7C1F7C794EFF33000000000000FF331F001F001F001F00BF67
      7F6793311F7C1F7C1F7C794EFF33007C007C1042FF33FF33BF67FF33BF673F67
      3F6793311F7C1F7C1F7C794EFF331F00FF7F1042BF671F001F001F001F003F67
      794E93311F7C1F7C1F7C794EFF331F00FF7F1042FF33BF67FF33BF6793319331
      933193311F7C1F7C1F7C794EFF33104210421042FF33FF33FF33FF33794EFF33
      93311F7C1F7C1F7C1F7C794EFF33FF33FF33FF33FF33FF33FF33FF33794E9331
      1F7C1F7C1F7C1F7C1F7C794E794E794E794E794E794E794E794E794E794E1F7C
      1F7C1F7C1F7C}
    ParentFont = False
  end
  object BtnFechar: TSpeedButton
    Left = 547
    Top = 506
    Width = 120
    Height = 22
    Action = ActFechar
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CA944213820340030012C472C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C404000400044004400440044003C212C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C855000480048004C0050004C0048004400402228
      1F7C1F7C1F7C1F7C1F7C8658204C946AD5724258005400546B5D18774A590044
      44341F7C1F7C1F7C1F7C00504254F85AFF7F397B425C8C61FF7BFF7BAE59004C
      003C1F7C1F7C1F7CEC64005800604350F75AFF7F3A7BDE7FFF7BCE5500580054
      004C69401F7C1F7C65600060006800684254396BFF7FFF7FCE61005C00600058
      005423381F7C1F7C656421682170006CC6683973FF7FFF7FEF71216400640160
      005C45401F7C1F7CCF746270427C8C6DDF7BFF77F061D762FF7F397F84700168
      205CAD581F7C1F7C1F7C8278E774BD6FFF77AD5D0070425CD656FF7B316E016C
      415C1F7C1F7C1F7C1F7CEB7C067D315ECF5900780078007C8464314AE7704170
      CA601F7C1F7C1F7C1F7C1F7C2C7D8B7DAD7D6B7D087DE77C087DE878C57CA870
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C6F7D0E7E927E947E307EAC7D277DEE781F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7CD67CB47DAF7DAE7D527DD67C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    ParentFont = False
  end
  object BtnCancelar: TSpeedButton
    Left = 410
    Top = 506
    Width = 120
    Height = 22
    Action = ActCancelar
    Flat = True
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Glyph.Data = {
      42020000424D4202000000000000420000002800000010000000100000000100
      1000030000000002000000000000000000000000000000000000007C0000E003
      00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C00401F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      007C1F7C1F7C1F7C8860007C00401F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C88608872007C00401F7C1F7C1F7C1F7C1F7C1F7C1F7C007C
      1F7C1F7C1F7C1F7C1F7C8860807180601F7C1F7C1F7C1F7C1F7C1F7C007C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C8060007C00401F7C1F7C1F7C1F7C007C00401F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C8060007C00401F7C1F7C007C00401F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C8060007C0040007C00401F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C8060007C00401F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C8060007C0040806000401F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C8060007C00401F7C1F7C806000401F7C1F7C
      1F7C1F7C1F7C1F7C1F7C8060007C007C00401F7C1F7C1F7C1F7C806000401F7C
      1F7C1F7C1F7C1F7C80608872007C00401F7C1F7C1F7C1F7C1F7C1F7C80600040
      1F7C1F7C1F7C1F7C9051806090511F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      80601F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
      1F7C1F7C1F7C}
    ParentFont = False
  end
  object PanCod: TPanel
    Left = 0
    Top = 0
    Width = 672
    Height = 26
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object BtnPesquisar: TSpeedButton
      Left = 427
      Top = 1
      Width = 120
      Height = 22
      Hint = 'Pesquisar'
      Action = ActPesquisar
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1042883110421F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C945210421842883110421F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1063087210521842883110421F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C10420873087210521842883110421F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C10420873087210521842883194521F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C10730873087210521042104294529031883188319031
        10421F7C1F7C1F7C1F7C1F7C10730873086210421042984218533E5318531042
        883110421F7C1F7C1F7C1F7C1F7C9073104218423E533E53FF7FFF7FFF7FFE7F
        1042883110421F7C1F7C1F7C1F7C186310423E533E533E53FF7FFF7FFF7FFF7F
        FE7F903190311F7C1F7C1F7C1F7C18633E533E533E53FF7FFF7FFF7FFF7FFF7F
        FF7F984288311F7C1F7C1F7C1F7C18633E53FF7F3E533E53FF7FFF7FFF7FFF7F
        FF7F185388311F7C1F7C1F7C1F7C18631863FF7F3E533E53FF7FFF7FFF7FFF7F
        FF7F985290311F7C1F7C1F7C1F7C1F7C1863FF7FFF7F3E533E533E53FF7F3E53
        3E53984210421F7C1F7C1F7C1F7C1F7C18633E53FF7FFF7F3E533E533E533E53
        3E5310421F7C1F7C1F7C1F7C1F7C1F7C1F7C1863FE7FFF7FFF7F3E533E533E53
        98421F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1863185398423E533E531042
        1F7C1F7C1F7C}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object BtnNovo: TSpeedButton
      Left = 550
      Top = 1
      Width = 120
      Height = 22
      Hint = 'Novo'
      Action = ActNovo
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C00000000000000000000000000000000000000000000
        000000001F7C1F7C1F7C10421863186318631863186318631863186318631863
        186300001F7C1F7C1F7C1042FF7F1863FF7F1863FF7F1863FF7F1863FF7F1863
        186300001F7C1F7C1F7C1042FF7FFF7F1863FF7F10001000100010001000FF7F
        186300001F7C1F7C1F7C1042FF7F1863FF7F1863FF7F1863FF7F1863FF7F1863
        186300001F7C1F7C1F7C1042FF7FFF7F1000100010001000100010001000FF7F
        186300001F7C1F7C1F7C1042FF7F1863FF7F1863FF7F1863FF7F1863FF7F1863
        186300001F7C1F7C1F7C1042FF7FFF7F1863FF7F10001000100010001000FF7F
        186300001F7C1F7C1F7C1042FF7F1863FF7F1863FF7F1863FF7F1863FF7F1863
        186300001F7C1F7C1F7C1042FF7FFF7F1863FF7F10001000100010001000FF7F
        186300001F7C1F7C1F7C1042FF7F1863FF7F1863FF7F1863FF7F1863FF7F1863
        186300001F7C1F7C1F7C1042FF7FFF7F10001000100010001000FF7F00000000
        000000001F7C1F7C1F7C1042FF7F1863FF7F1863FF7F1863FF7F18631863FF7F
        10421F7C1F7C1F7C1F7C1042FF7FFF7FFF7FFF7FFF7FFF7FFF7FFF7F18631042
        1F7C1F7C1F7C1F7C1F7C10421042104210421042104210421042104210421F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object BtnSelectAll: TSpeedButton
      Left = 400
      Top = 1
      Width = 22
      Height = 22
      Action = ActSelectAll
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        42020000424D4202000000000000420000002800000010000000100000000100
        1000030000000002000000000000000000000000000000000000007C0000E003
        00001F0000001F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7CC618C618C618C618C618C618C618C618C618C618C618C618C618
        C618C6181F7CC618314687598759FF7FFF7F3146FF7FFF7FFF7F3146FF7FFF7F
        FF7FC6181F7CC6183146C07F87598759FF7F3146FF7FFF7FFF7F3146FF7FFF7F
        FF7FC6181F7CC6183146247EC07F875987598759314631463146314631463146
        3146C6181F7CC61831463146247EEF7FC07F87598759FF7FFF7F3146FF7FFF7F
        FF7FC6181F7CC6188759875987598759EF7FC07F87598759FF7F3146FF7FFF7F
        FF7FC6181F7CC618247EEF7FC07FC07FC07FC07FC07F87598759314631463146
        3146C6181F7CC6183146247EEF7FC07F87598759FF7FFF7FFF7F3146FF7FFF7F
        FF7FC6181F7CC618C618C618247EEF7FC07F87598759C618C618C618C618C618
        C618C6181F7CC6181D0A1D0A247EEF7FC07FC07F875987591D0A1D0A1D0A1D0A
        1D0AC6181F7CC6181D0A1D0A1D0A247EEF7FC07FC07F875987591D0A1D0A1D0A
        1D0AC6181F7CC618C618C618C618C618247EEF7FC07FC07F87598759C618C618
        C618C6181F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C1F7C
        1F7C1F7C1F7C}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object EdMain: TEdit
      Left = 3
      Top = 2
      Width = 390
      Height = 21
      Hint = '[F12] Pesquisar'
      CharCase = ecUpperCase
      MaxLength = 64
      TabOrder = 0
      OnKeyDown = EdMainKeyDown
    end
  end
  object PgCtrlMain: TPageControl
    Left = 0
    Top = 185
    Width = 672
    Height = 317
    ActivePage = TabPessoa
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Images = ImgMain
    ParentFont = False
    Style = tsFlatButtons
    TabOrder = 1
    Visible = False
    object TabPessoa: TTabSheet
      Caption = '&Pessoa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 9
      ParentFont = False
      object LblCod: TLabel
        Left = 165
        Top = 20
        Width = 38
        Height = 13
        Caption = 'Pessoa:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object LblNome: TLabel
        Left = 5
        Top = 81
        Width = 31
        Height = 13
        Caption = 'Nome:'
      end
      object LblReferencia: TLabel
        Left = 5
        Top = 112
        Width = 56
        Height = 13
        Caption = 'Refer'#234'ncia:'
      end
      object LblRG: TLabel
        Left = 5
        Top = 143
        Width = 18
        Height = 13
        Caption = 'RG:'
      end
      object LblTelefone: TLabel
        Left = 216
        Top = 173
        Width = 46
        Height = 13
        Caption = 'Telefone:'
      end
      object LblProfissao: TLabel
        Left = 5
        Top = 174
        Width = 48
        Height = 13
        Caption = 'Profiss'#227'o:'
      end
      object LblDataNascimento: TLabel
        Left = 216
        Top = 204
        Width = 59
        Height = 13
        Caption = 'Nascimento:'
      end
      object LblCPF: TLabel
        Left = 216
        Top = 143
        Width = 23
        Height = 13
        Caption = 'CPF:'
      end
      object Label10: TLabel
        Left = 441
        Top = 167
        Width = 67
        Height = 13
        Caption = 'Observa'#231#245'es:'
      end
      object Label1: TLabel
        Left = 5
        Top = 20
        Width = 37
        Height = 13
        Caption = 'C'#243'digo:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object BtnConsultaPessoa: TSpeedButton
        Left = 295
        Top = 16
        Width = 23
        Height = 22
        Cursor = crHandPoint
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
        OnClick = BtnConsultaPessoaClick
      end
      object Label6: TLabel
        Left = 5
        Top = 50
        Width = 38
        Height = 13
        Caption = 'Pessoa:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object LblSexo: TLabel
        Left = 2
        Top = 204
        Width = 28
        Height = 13
        Caption = 'Sexo:'
      end
      object Label5: TLabel
        Left = 165
        Top = 50
        Width = 86
        Height = 13
        Caption = 'Controla Produto:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label2: TLabel
        Left = 335
        Top = 51
        Width = 75
        Height = 13
        Caption = #218'ltimo Contato:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 335
        Top = 21
        Width = 70
        Height = 13
        Caption = 'Cliente Desde:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label3: TLabel
        Left = 498
        Top = 20
        Width = 82
        Height = 13
        Caption = #218'ltima Altera'#231#227'o:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label4: TLabel
        Left = 498
        Top = 50
        Width = 72
        Height = 13
        Caption = 'Prev. Contato:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object LblMae: TLabel
        Left = 5
        Top = 268
        Width = 69
        Height = 13
        Caption = 'Nome do M'#227'e:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object LblPai: TLabel
        Left = 5
        Top = 237
        Width = 63
        Height = 13
        Caption = 'Nome do Pai:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object LblComissao: TLabel
        Left = 437
        Top = 142
        Width = 84
        Height = 13
        Caption = 'Limite de Cr'#233'dito:'
      end
      object EdCodigoPessoa: TMaskEdit
        Left = 208
        Top = 16
        Width = 81
        Height = 21
        Hint = '[F1] Consulta de Pessoa'
        Color = clWhite
        ParentShowHint = False
        ShowHint = True
        TabOrder = 1
        OnExit = EdCodigoPessoaExit
      end
      object EdNome: TEdit
        Left = 76
        Top = 78
        Width = 581
        Height = 21
        CharCase = ecUpperCase
        Color = 15717318
        ReadOnly = True
        TabOrder = 8
      end
      object EdReferencia: TEdit
        Left = 76
        Top = 109
        Width = 581
        Height = 21
        CharCase = ecUpperCase
        Color = 15717318
        ReadOnly = True
        TabOrder = 9
      end
      object MskRG: TMaskEdit
        Left = 75
        Top = 139
        Width = 117
        Height = 21
        Color = 15717318
        MaxLength = 12
        ReadOnly = True
        TabOrder = 10
      end
      object MskTeleFoneePessoa: TMaskEdit
        Left = 294
        Top = 171
        Width = 120
        Height = 21
        Hint = 'Informe o telefone para contato (opcional).'
        BiDiMode = bdRightToLeft
        Color = 15717318
        EditMask = '(9999) 9999-9999;0; '
        MaxLength = 16
        ParentBiDiMode = False
        ReadOnly = True
        TabOrder = 13
      end
      object EdProfissao: TEdit
        Left = 75
        Top = 170
        Width = 119
        Height = 21
        CharCase = ecUpperCase
        Color = 15717318
        ReadOnly = True
        TabOrder = 15
      end
      object MskCPF: TMaskEdit
        Left = 294
        Top = 139
        Width = 122
        Height = 21
        Color = 15717318
        EditMask = '9999999999999999999;0; '
        MaxLength = 19
        ReadOnly = True
        TabOrder = 11
      end
      object MemObservacoes: TMemo
        Left = 440
        Top = 185
        Width = 216
        Height = 100
        Color = 15717318
        ReadOnly = True
        TabOrder = 17
      end
      object EdCodigoCliente: TMaskEdit
        Left = 76
        Top = 17
        Width = 77
        Height = 21
        Color = 15717318
        ReadOnly = True
        TabOrder = 0
      end
      object CmbPessoa: TComboBox
        Left = 76
        Top = 47
        Width = 77
        Height = 21
        Color = 15717318
        Enabled = False
        ItemHeight = 13
        TabOrder = 4
      end
      object CmbSexo: TComboBox
        Left = 75
        Top = 199
        Width = 118
        Height = 21
        Style = csDropDownList
        CharCase = ecUpperCase
        Color = 15717318
        Enabled = False
        ItemHeight = 13
        TabOrder = 16
        Items.Strings = (
          'M'
          'F')
      end
      object DateNascimento: TDateTimePicker
        Left = 294
        Top = 201
        Width = 121
        Height = 21
        Date = 37739.755293067130000000
        Time = 37739.755293067130000000
        Color = 15717318
        Enabled = False
        TabOrder = 14
      end
      object CmbControle: TComboBox
        Left = 256
        Top = 48
        Width = 65
        Height = 21
        Style = csDropDownList
        CharCase = ecUpperCase
        ItemHeight = 13
        ItemIndex = 1
        TabOrder = 5
        Text = 'N'#195'O'
        Items.Strings = (
          'SIM'
          'N'#195'O')
      end
      object DateUltimoContato: TDateTimePicker
        Left = 414
        Top = 48
        Width = 78
        Height = 21
        Date = 37739.755293067130000000
        Time = 37739.755293067130000000
        TabOrder = 7
      end
      object DateClienteDesde: TDateTimePicker
        Left = 414
        Top = 16
        Width = 78
        Height = 21
        Date = 37739.755289351850000000
        Time = 37739.755289351850000000
        Color = 15717318
        Enabled = False
        TabOrder = 2
      end
      object DateUltimaAlteracao: TDateTimePicker
        Left = 582
        Top = 16
        Width = 78
        Height = 21
        Date = 37739.755289351850000000
        Time = 37739.755289351850000000
        Color = 15717318
        Enabled = False
        TabOrder = 3
      end
      object DatePrevContato: TDateTimePicker
        Left = 582
        Top = 48
        Width = 78
        Height = 21
        Date = 37739.755293067130000000
        Time = 37739.755293067130000000
        TabOrder = 6
      end
      object EdNomePai: TEdit
        Left = 76
        Top = 233
        Width = 341
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 18
      end
      object EdNomeMae: TEdit
        Left = 76
        Top = 264
        Width = 341
        Height = 21
        CharCase = ecUpperCase
        TabOrder = 19
      end
      object EdLimite: TEdit
        Left = 528
        Top = 138
        Width = 129
        Height = 21
        TabOrder = 12
        OnEnter = EdLimiteEnter
        OnExit = EdLimiteExit
      end
    end
    object TabEndereco: TTabSheet
      Caption = '&Endere'#231'o'
      ImageIndex = 9
      object PanDadosEndereco: TPanel
        Left = 0
        Top = 0
        Width = 664
        Height = 167
        Align = alClient
        BevelInner = bvSpace
        BevelOuter = bvLowered
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        object LblTipoEndereco: TLabel
          Left = 9
          Top = 9
          Width = 24
          Height = 13
          Caption = 'Tipo:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object LblEndereco: TLabel
          Left = 137
          Top = 9
          Width = 49
          Height = 14
          Caption = 'Endereco:'
        end
        object LblComplemento: TLabel
          Left = 9
          Top = 38
          Width = 67
          Height = 14
          Caption = 'Complemento:'
        end
        object LblCidade: TLabel
          Left = 105
          Top = 67
          Width = 36
          Height = 14
          Caption = 'Cidade:'
        end
        object LblCelular: TLabel
          Left = 9
          Top = 96
          Width = 36
          Height = 14
          Caption = 'Celular:'
        end
        object LblSite: TLabel
          Left = 9
          Top = 126
          Width = 21
          Height = 14
          Caption = 'Site:'
        end
        object LblFax: TLabel
          Left = 153
          Top = 96
          Width = 21
          Height = 14
          Caption = 'Fax:'
        end
        object LblEstado: TLabel
          Left = 9
          Top = 67
          Width = 36
          Height = 14
          Caption = 'Estado:'
        end
        object LblEmail: TLabel
          Left = 273
          Top = 96
          Width = 31
          Height = 14
          Caption = 'E-Mail:'
        end
        object LblCEP: TLabel
          Left = 359
          Top = 67
          Width = 22
          Height = 14
          Caption = 'CEP:'
        end
        object LblBairro: TLabel
          Left = 345
          Top = 38
          Width = 32
          Height = 14
          Caption = 'Bairro:'
        end
        object LblTelefoneEndereco: TLabel
          Left = 489
          Top = 67
          Width = 45
          Height = 14
          Caption = 'Telefone:'
        end
        object CmbTipoEndereco: TComboBox
          Left = 40
          Top = 5
          Width = 81
          Height = 19
          Style = csSimple
          Color = 15717318
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ItemHeight = 13
          ParentFont = False
          TabOrder = 0
        end
        object TxtEndereco: TEdit
          Left = 190
          Top = 5
          Width = 466
          Height = 22
          CharCase = ecUpperCase
          Color = 15717318
          ReadOnly = True
          TabOrder = 1
        end
        object TxtComplemento: TEdit
          Left = 80
          Top = 34
          Width = 257
          Height = 22
          CharCase = ecUpperCase
          Color = 15717318
          ReadOnly = True
          TabOrder = 2
        end
        object CmbCidade: TComboBox
          Left = 144
          Top = 64
          Width = 201
          Height = 22
          Style = csSimple
          CharCase = ecUpperCase
          Color = 15717318
          ItemHeight = 14
          TabOrder = 4
        end
        object MskCelular: TMaskEdit
          Left = 63
          Top = 93
          Width = 82
          Height = 22
          Hint = 'Informe o telefone para contato (opcional).'
          BiDiMode = bdRightToLeft
          Color = 15717318
          EditMask = '(9999) 9999-9999;0; '
          MaxLength = 16
          ParentBiDiMode = False
          ReadOnly = True
          TabOrder = 8
        end
        object TxtSite: TEdit
          Left = 56
          Top = 123
          Width = 601
          Height = 22
          Color = 15717318
          ReadOnly = True
          TabOrder = 11
        end
        object MskFax: TMaskEdit
          Left = 183
          Top = 93
          Width = 82
          Height = 22
          Hint = 'Informe o telefone para contato (opcional).'
          BiDiMode = bdRightToLeft
          Color = 15717318
          EditMask = '(9999) 9999-9999;0; '
          MaxLength = 16
          ParentBiDiMode = False
          ReadOnly = True
          TabOrder = 9
        end
        object CmbEstado: TComboBox
          Left = 56
          Top = 64
          Width = 41
          Height = 22
          Style = csSimple
          CharCase = ecUpperCase
          Color = 15717318
          ItemHeight = 14
          TabOrder = 5
        end
        object TxtEmail: TEdit
          Left = 320
          Top = 93
          Width = 337
          Height = 22
          Color = 15717318
          ReadOnly = True
          TabOrder = 10
        end
        object MskCep: TMaskEdit
          Left = 392
          Top = 64
          Width = 85
          Height = 22
          Color = 15717318
          EditMask = '00000\-000;0; '
          MaxLength = 9
          ReadOnly = True
          TabOrder = 6
        end
        object TxtBairro: TEdit
          Left = 381
          Top = 34
          Width = 274
          Height = 22
          CharCase = ecUpperCase
          Color = 15717318
          ReadOnly = True
          TabOrder = 3
        end
        object MskTelefoneEndereco: TMaskEdit
          Left = 543
          Top = 64
          Width = 113
          Height = 22
          Hint = 'Informe o telefone para contato (opcional).'
          BiDiMode = bdRightToLeft
          Color = 15717318
          EditMask = '(9999) 9999-9999;0; '
          MaxLength = 16
          ParentBiDiMode = False
          ReadOnly = True
          TabOrder = 7
        end
      end
      object GrdEndereco: TDBGrid
        Left = 0
        Top = 167
        Width = 664
        Height = 118
        Align = alBottom
        DataSource = DSourceEndereco
        FixedColor = 13003057
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        TabOrder = 1
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWhite
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        OnDblClick = GrdEnderecoDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'TEN_DESCRICAO_A'
            Title.Caption = 'Tipo'
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ENP_CIDADE_A'
            Title.Caption = 'Cidade'
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ENP_ENDERECO_A'
            Title.Caption = 'Endere'#231'o'
            Width = 390
            Visible = True
          end>
      end
    end
    object TabContatos: TTabSheet
      Caption = 'Co&ntatos'
      ImageIndex = 9
      object GrdContato: TDBGrid
        Left = 0
        Top = 0
        Width = 664
        Height = 285
        Align = alClient
        DataSource = DSourceContato
        FixedColor = 13003057
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWhite
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'PES_NOME_A'
            Title.Caption = 'Nome'
            Width = 395
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COP_FUNCAO_A'
            Title.Caption = 'Fun'#231#227'o'
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COP_LOCAL_A'
            Title.Caption = 'Setor'
            Width = 120
            Visible = True
          end>
      end
    end
  end
  object GrdPessoa: TDBGrid
    Left = 0
    Top = 26
    Width = 672
    Height = 159
    Cursor = crHandPoint
    Align = alTop
    DataSource = DSourceGrid
    FixedColor = 13003057
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgRowLines, dgRowSelect]
    ParentFont = False
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWhite
    TitleFont.Height = -11
    TitleFont.Name = 'Arial'
    TitleFont.Style = [fsBold]
    OnDblClick = GrdPessoaDblClick
    OnEnter = GrdPessoaEnter
    OnExit = GrdPessoaExit
    OnKeyDown = GrdPessoaKeyDown
    Columns = <
      item
        Color = 15717318
        Expanded = False
        FieldName = 'CODIGOCLIENTE'
        Title.Caption = 'C'#243'digo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PES_NOME_A'
        Title.Caption = 'Nome'
        Width = 570
        Visible = True
      end>
  end
  object DSourceGrid: TDataSource
    Left = 464
    Top = 296
  end
  object DSourceEndereco: TDataSource
    Left = 528
    Top = 296
  end
  object DSourceContato: TDataSource
    Left = 576
    Top = 296
  end
  object ActMain: TActionManager
    Images = ImgMain
    Left = 580
    Top = 425
    StyleName = 'XP Style'
    object ActNovo: TAction
      Caption = '&Novo'
      ImageIndex = 4
      ShortCut = 45
      OnExecute = ActNovoExecute
    end
    object ActPesquisar: TAction
      Caption = '&Pesquisar'
      ImageIndex = 0
      ShortCut = 123
      OnExecute = ActPesquisarExecute
    end
    object ActFechar: TAction
      Caption = '&Fechar'
      ImageIndex = 3
      OnExecute = ActFecharExecute
    end
    object ActCancelar: TAction
      Caption = '&Cancelar'
      ImageIndex = 5
      ShortCut = 27
      OnExecute = ActCancelarExecute
    end
    object ActSalvar: TAction
      Caption = '&Salvar'
      ImageIndex = 7
      ShortCut = 16467
      OnExecute = ActSalvarExecute
    end
    object ActExcluir: TAction
      Caption = '&Excluir'
      ImageIndex = 2
      OnExecute = ActExcluirExecute
    end
    object ActRelatorio: TAction
      Caption = '&Relat'#243'rio'
      ImageIndex = 6
      OnExecute = ActRelatorioExecute
    end
    object ActSelectAll: TAction
      Hint = 'Selecionar Todos'
      ImageIndex = 8
      ShortCut = 116
      OnExecute = ActSelectAllExecute
    end
  end
  object ImgMain: TImageList
    Left = 536
    Top = 426
    Bitmap = {
      494C01010A000E00040010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000004000000001002000000000000040
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003131310031313100313131003131
      3100313131003131310031313100313131003131310031313100313131003131
      31003131310031313100313131000000000000000000AD310000AD310000AD31
      0000AD310000AD310000AD310000AD310000AD310000AD310000AD310000AD31
      0000AD310000AD310000AD310000AD3100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000313131008C8C8C003963B5003963
      B500FFFFFF00FFFFFF008C8C8C00FFFFFF00FFFFFF00FFFFFF008C8C8C00FFFF
      FF00FFFFFF00FFFFFF00313131000000000000000000AD310000FFFFFF00FFFF
      FF00FFFFF700FFEFD600FFE7C600FFD6A500FFCE8C00FFC67B00FFC67B00FFC6
      7B00FFC67B00FFC67B00FFC67B00AD3100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000313131008C8C8C0000F7FF003963
      B5003963B500FFFFFF008C8C8C00FFFFFF00FFFFFF00FFFFFF008C8C8C00FFFF
      FF00FFFFFF00FFFFFF00313131000000000000000000AD310000FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFEFD600FFE7C600FFD6A500FFCE8C00FFC67B00FFC6
      7B00FFC67B00FFC67B00FFC67B00AD3100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000313131008C8C8C00218CFF0000F7
      FF003963B5003963B5003963B5008C8C8C008C8C8C008C8C8C008C8C8C008C8C
      8C008C8C8C008C8C8C00313131000000000000000000AD310000FFFFFF001039
      FF001039FF001039FF00FFFFF700731000007310000073100000FFCE8C00006B
      AD00006BAD00006BAD00FFC67B00AD3100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000313131008C8C8C008C8C8C00218C
      FF007BFFFF0000F7FF003963B5003963B500FFFFFF00FFFFFF008C8C8C00FFFF
      FF00FFFFFF00FFFFFF00313131000000000000000000AD310000FFFFFF001039
      FF001039FF001039FF00FFFFFF00731000007310000073100000FFD6A500006B
      AD00006BAD00006BAD00FFC67B00AD3100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000313131003963B5003963B5003963
      B5003963B5007BFFFF0000F7FF003963B5003963B500FFFFFF008C8C8C00FFFF
      FF00FFFFFF00FFFFFF00313131000000000000000000AD310000FFFFFF001039
      FF001039FF001039FF00FFFFFF00731000007310000073100000FFE7C600006B
      AD00006BAD00006BAD00FFC67B00AD3100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000031313100218CFF007BFFFF0000F7
      FF0000F7FF0000F7FF0000F7FF0000F7FF003963B5003963B5008C8C8C008C8C
      8C008C8C8C008C8C8C00313131000000000000000000AD310000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFF700FFEFD600FFE7
      C600FFD6A500FFCE8C00FFC67B00AD3100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000313131008C8C8C00218CFF007BFF
      FF0000F7FF003963B5003963B500FFFFFF00FFFFFF00FFFFFF008C8C8C00FFFF
      FF00FFFFFF00FFFFFF00313131000000000000000000AD310000FFFFFF00AD6B
      6B00AD6B6B00AD6B6B00FFFFFF00D64A0000D64A0000D64A0000FFFFF700006B
      0000006B0000006B0000FFCE8C00AD3100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000313131003131310031313100218C
      FF007BFFFF0000F7FF003963B5003963B5003131310031313100313131003131
      31003131310031313100313131000000000000000000AD310000FFFFFF00AD6B
      6B00AD6B6B00AD6B6B00FFFFFF00D64A0000D64A0000D64A0000FFFFFF00006B
      0000006B0000006B0000FFD6A500AD3100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000031313100EF841000EF841000218C
      FF007BFFFF0000F7FF0000F7FF003963B5003963B500EF841000EF841000EF84
      1000EF841000EF841000313131000000000000000000AD310000FFFFFF00AD6B
      6B00AD6B6B00AD6B6B00FFFFFF00D64A0000D64A0000D64A0000FFFFFF00006B
      0000006B0000006B0000FFE7C600AD3100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000031313100EF841000EF841000EF84
      1000218CFF007BFFFF0000F7FF0000F7FF003963B5003963B500EF841000EF84
      1000EF841000EF841000313131000000000000000000AD310000FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFF700FFEFD600AD3100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000003131310031313100313131003131
      310031313100218CFF007BFFFF0000F7FF0000F7FF003963B5003963B5003131
      31003131310031313100313131000000000000000000AD310000AD310000AD31
      0000AD310000AD310000AD310000AD310000AD310000AD310000AD310000AD31
      0000AD310000AD310000AD310000AD3100000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000000000009C6363009C63
      63009C6363009C6363009C6363009C6363009C6363009C6363009C6363009C63
      63009C6363009C6363009C636300000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6C600C6C6
      C600C6C6C600C6C6C60000000000000000000000000000000000000084000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000FF0000000000000000000000000000000000CE9C9C00FFEF
      CE00FFEFCE00FFDECE00FFDECE00FFDECE00FFDECE00FFDECE00FFDECE00FFDE
      CE00FFDECE00FFDECE009C636300000000000000000084319C00B5525A00BD5A
      63009C5263009C8CC600BDADDE00D6C6F700CEBDF700C6B5E700BDADE7009C42
      520094313900AD4A5200A54A7B0000000000000000000000000084848400FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600C6C6C6000000000000000000000000004221C6000000FF000000
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CE9C9C00FFEF
      CE00FFEFCE00FFEFCE00FFEFCE00FFEFCE00FFEFCE00FFEFCE00FFDECE00FFDE
      CE00FFDECE00FFDECE009C6363000000000000000000B55A7B00D66B6300D66B
      6300A55A5A00AD8C7B00CE8C7B00EFDECE00FFFFFF00F7FFF700EFF7E700A54A
      420094292900BD524A00BD5A630000000000000000000000000084848400FFFF
      FF00FFFFFF00C6C6C600FFFFFF00840000008400000084000000840000008400
      0000FFFFFF00C6C6C6000000000000000000000000004221C60042A5E7000000
      FF00000084000000000000000000000000000000000000000000000000000000
      00000000FF000000000000000000000000000000000000000000CE9C9C00FFEF
      CE00FF000000FF000000FFEFCE000000FF00FFEFCE00FFEFCE00FFDECE000000
      FF00FFDECE00FFDECE009C6363000000000000000000B55A8400CE6B6300CE63
      6300AD636300C68C8400B54A4A00BD9C9400E7E7E700FFFFFF00F7FFFF00A54A
      4A0094292900BD524A00B55A6B0000000000000000000000000084848400FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600C6C6C600000000000000000000000000000000004221C6000063
      E7000021C6000000000000000000000000000000000000000000000000000000
      FF00000000000000000000000000000000000000000000000000CE9C9C00FFFF
      6300FFFF6300FFFF6300FFFF6300FFEFCE000000FF000000FF000000FF000000
      FF00FFDECE00FFDECE009C6363000000000000000000B55A8400CE6B6300CE63
      6300AD6B6B00C68C8C009C292900A5847B00ADB5B500DEDEDE00FFFFFF00A54A
      4A0094292900BD524A00B55A6B0000000000000000000000000084848400FFFF
      FF00FFFFFF008400000084000000840000008400000084000000840000008400
      0000FFFFFF00C6C6C60000000000000000000000000000000000000000000021
      C6000000FF0000008400000000000000000000000000000000000000FF000000
      8400000000000000000000000000000000000000000000000000CE9C9C00FFFF
      6300FF000000FF000000FF000000FF000000FFEFCE000000FF00FFEFCE000000
      FF00FFDECE00FFDECE009C6363000000000000000000B55A8400CE6B6300CE63
      6300AD636300D6BDB500CE9C9C00CEBDB500B5B5B500C6BDBD00DEDEDE00A54A
      4A0094292900BD524A00B55A6B0000000000000000000000000084848400FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600C6C6C60000000000000000000000000000000000000000000000
      00000021C6000000FF000000840000000000000000000000FF00000084000000
      0000000000000000000000000000000000000000000000000000CE9C9C00FFFF
      6300FFFF6300FFFF6300FFFF6300FFFF6300FFFF6300FFEFCE000000FF000000
      FF00FFEFCE00FFDECE009C6363000000000000000000B55A8400D66B6300CE63
      6300CE636300BD7B7300BD7B7300C6736B00CE636300B5636300C66B6B00BD5A
      5A00BD524A00CE635A00B55A6B0000000000000000000000000084848400FFFF
      FF00FFFFFF00C6C6C600FFFFFF00840000008400000084000000840000008400
      0000FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000021C6000000FF00000084000000FF0000008400000000000000
      0000000000000000000000000000000000000000000000000000CE9C9C00FFFF
      6300FF000000FF000000FF000000FF000000FF000000FFEFCE00FFEFCE000000
      FF00FFEFCE00FFDECE009C6363000000000000000000B55A7B00BD5A5200C68C
      8400CE8C8C00CE8C8C00CE8C8C00CE8C8C00CE8C8C00CE8C8C00CE8C8C00D68C
      8C00C6848400CE6B6300B5526B0000000000000000000000000084848400FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600C6C6C60000000000000000000000000000000000000000000000
      000000000000000000000021C6000000FF000000840000000000000000000000
      0000000000000000000000000000000000000000000000000000CE9C9C00FFFF
      6300FFFF6300FFFF6300FFFF6300FFFF6300FFFF6300FFFF6300FFEFCE00FFEF
      CE00FFEFCE00FFDECE009C6363000000000000000000B5527B00BD6B6300F7FF
      FF00F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7F7F700F7FF
      FF00E7DEDE00C66B6300B552630000000000000000000000000084848400FFFF
      FF00FFFFFF00C6C6C600FFFFFF00840000008400000084000000840000008400
      0000FFFFFF00C6C6C60000000000000000000000000000000000000000000000
      0000000000000021C6000000FF00000084000021C60000008400000000000000
      0000000000000000000000000000000000000000000000000000CE9C9C00FFFF
      6300000000000000000000000000FFFF6300FF000000FF000000FF000000FF00
      0000FFEFCE00FFDECE009C6363000000000000000000B5527B00BD6B6300FFFF
      FF00F7F7F700EFEFEF00EFEFEF00F7F7F700F7F7F700F7F7F700F7F7F700F7F7
      F700E7DEDE00C66B6300B552630000000000000000000000000084848400FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFF
      FF00C6C6C600C6C6C60000000000000000000000000000000000000000000000
      00000021C6000000FF000000840000000000000000000021C600000084000000
      0000000000000000000000000000000000000000000000000000CE9C9C00FFFF
      63000000FF000000FF0084848400FFFF6300FFFF6300FFEFCE00FFFF6300FFEF
      CE00FFCECE00FFCECE009C6363000000000000000000B5527B00BD6B6300FFFF
      FF00DEDEDE00D6D6D600D6D6D600D6D6D600D6D6D600DEDEDE00DEDEDE00E7E7
      E700E7DEDE00C66B6300B552630000000000000000000000000084848400FFFF
      FF00FFFFFF008400000084000000840000008400000084000000FFFFFF000000
      00000000000000000000000000000000000000000000000000000021C6000000
      FF000000FF0000008400000000000000000000000000000000000021C6000000
      8400000000000000000000000000000000000000000000000000CE9C9C00FFFF
      6300FF000000FFFFFF0084848400FFEFCE00FF000000FF000000FF000000FF00
      0000FFCECE00CE9C9C009C6363000000000000000000B5527B00BD6B6300F7FF
      FF00E7E7E700D6D6D600D6DEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00E7EF
      EF00E7DEDE00C66B6300B552630000000000000000000000000084848400FFFF
      FF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600FFFFFF00C6C6C600C6C6
      C600FFFFFF00848484000000000000000000000000000021C60042A5E7000000
      FF00000084000000000000000000000000000000000000000000000000000021
      C600000084000000000000000000000000000000000000000000CE9C9C00FFFF
      6300FF000000FFFFFF0084848400FFFF6300FFEFCE00FFFF6300FFEFCE009C63
      63009C6363009C6363009C6363000000000000000000B5527B00BD6B6300FFFF
      FF00E7E7E700DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00DEDEDE00E7EF
      EF00E7DEDE00C66B6300B552630000000000000000000000000084848400FFFF
      FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6
      C60084848400000000000000000000000000000000008463A5000021C6008463
      A500000000000000000000000000000000000000000000000000000000000000
      0000000000000021C60000000000000000000000000000000000CE9C9C00FFFF
      6300848484008484840084848400FFFF6300FFFF6300FFFF6300FFFF6300CE9C
      9C00FFFF63009C636300000000000000000000000000B55A7B00BD736300FFFF
      FF00E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700E7E7E700EFEF
      EF00EFE7E700C66B6B00B5526300000000000000000000000000848484008484
      8400848484008484840084848400848484008484840084848400848484008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CE9C9C00FFFF
      6300FFFF6300FFFF6300FFFF6300FFFF6300FFFF6300FFFF6300FFFF6300CE9C
      9C009C63630000000000000000000000000000000000AD526B00BD6B4A00EFFF
      EF00EFF7E700EFF7E700EFF7E700EFF7E700EFF7E700EFF7E700EFF7E700EFFF
      E700E7DECE00C66B5200AD4A6B00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000CE9C9C00CE9C
      9C00CE9C9C00CE9C9C00CE9C9C00CE9C9C00CE9C9C00CE9C9C00CE9C9C00CE9C
      9C00000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400426363008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400848463008484
      8400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000008484
      8400848484008484840084848400848484008484840084848400848484000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000A5A5A50084848400C68484004263
      6300848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084A5C60084A5E7008463
      8400848484000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084848400C6C6
      C600C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C6008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000004A298C000808730000086B000000630008005A0039105A000000
      00000000000000000000000000000000000084C6C6004284E7008484A500C684
      8400426363008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084E7E70042C6E7008484
      E700846384008484840000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400C6C6C600C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FF000000FFFFFF0084840000FF0000008484
      0000C6C6C6008484840000000000000000000000000000000000000000000000
      0000001084000000840000008C0000008C0000008C0000008C0000007B000808
      5A00000000000000000000000000000000008484840042C6E7004284E7008484
      A500C68484004263630084848400000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000084E7E70042C6
      E7008484E7008463840084848400000000000000000000000000000000000000
      0000000000000000000000000000000000000000000084848400C6C6C600FFFF
      FF00C6C6C600FFFFFF00FFFFFF0084840000C6C6C600FF000000840000008400
      000084000000C6C6C60084848400000000000000000000000000000000002921
      A500000094000000940000009C000000A50000009C000000940000008C000000
      840010085200000000000000000000000000000000008484840042C6E7004284
      E7008484A500C684840042636300A5A5A5000000000000000000000000000000
      00000000000000000000000000000000000000000000848484008484840084A5
      C60042C6E7008484C60084636300848484008484630084848400848484008484
      8400848484008484840084848400000000000000000084848400C6C6C600C6C6
      C600FFFFFF00FFFFFF00FFFFFF008484000084840000FF000000FFFFFF00FFFF
      FF00C6C6C60084000000C6C6C6008400000000000000000000003121B5000008
      9C00A5A5D600ADB5E7001010B5000000AD000000AD005A5ABD00C6C6EF005252
      B50000008C0021106B000000000000000000000000000000000084C6E70042C6
      E7004284E7008484A5008484840084848400A5A5A50084636300426363004263
      63008463630084848400000000000000000000000000C6634200C6634200C663
      420084C6E70084C6C600C6A58400F7CEA500FFFFFF00FFFFFF00FFFFFF008484
      840084848400C6A5840084422100000000000000000084848400C6C6C600FFFF
      FF00C6C6C600FFFFFF00FFFFFF008484000084840000FF000000FF000000FFFF
      FF00FFFFFF00C6C6C600C6C6C6008400000000000000000000000000A5001010
      AD00C6BDB500FFFFFF00CECEF7001010BD006363C600FFFFF700FFFFF700736B
      B50000009C0000007B00000000000000000000000000000000000000000084C6
      E70042C6E7004284C6008484840084848400C6A58400C6C6A500F7CEA500C6C6
      A500848484004263630084848400000000000000000084000000F7FFFF00F7FF
      FF00F7FFFF0084848400F7CEA500F7CEA500F7FFFF00F7FFFF00F7FFFF00FFFF
      FF0084848400F7FFFF0084000000000000000000000084848400C6C6C600C6C6
      C600FFFFFF00FFFFFF00FFFFFF0084840000FFFFFF00FFFFFF00FFFFFF008400
      00008400000084000000C6C6C60084000000000000006339CE000000B5000000
      C6001810A500BDBDB500FFFFFF00D6CEF700F7F7FF00FFFFF7007373AD000000
      B5000000AD0000009C004A188400000000000000000000000000000000000000
      000084E7E70084848400C6848400F7CEA500F7CEA500FFFFFF00FFFFFF00FFFF
      FF00F7FFFF008484840042636300848484000000000084000000F7FFFF00C6DE
      C600C6DEC60084848400F7CEA500F7CEA500C6DEC600C6DEC600F7FFFF00FFFF
      FF0084848400A5A5A50084000000000000000000000084848400C6C6C600FFFF
      FF00C6C6C600FFFFFF00FFFFFF00C6C6C600FFFF0000C6C6C600FFFFFF00C6C6
      C600FF00000084000000C6C6C60084000000000000002918C6000000C6000000
      D6000000D6001010AD00CECED600FFFFFF00FFFFFF007373C6000000BD000000
      C6000000B5000000AD0018087300000000000000000000000000000000000000
      0000C6C6C60084848400F7CEA500F7CEA500F7CEA500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00F7FFFF0084636300846363000000000084000000F7FFFF00C6DE
      C600C6DEC60084848400F7CEA500C6C6A500C6DEC600C6DEC600C6DEC600F7FF
      FF00C6C6A500A5A5A50084000000000000000000000084848400C6C6C600C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FF00000084840000C6C6C600FF00
      00008400000084000000C6C6C60084000000000000002918CE000808D6000808
      E7000000DE003131D600CECEE700FFFFFF00FFFFFF007B7BE7000808CE000000
      CE000800C6000000BD0029108400000000000000000000000000000000000000
      0000C6C6C600F7CEA500F7CEA500F7CEA500FFFFFF00FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6A58400426363000000000084000000F7FFFF00C6DE
      C600C6DEC60084848400F7CEA500F7CEA500F7CEA500F7CEA500F7CEA500FFFF
      FF00C6A58400C6DEC60084000000000000000000000084848400C6C6C600FFFF
      FF00C6C6C600FFFFFF00FFFFFF00FFFFFF00FFFF0000FF000000FF0000008484
      0000FFFFFF0084000000C6C6C60084000000000000007B31EF001018E7001010
      FF006363DE00FFF7F700FFFFEF00847BC600BDB5C600FFFFFF00CECEFF002121
      E7000800D6000008BD006B29B500000000000000000000000000000000000000
      0000C6C6C600F7CEA500FFFFFF00F7CEA500F7CEA500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6C6A500426363000000000084000000F7FFFF00C6DE
      C600C6DEC600C6C6C600C6C6C600F7FFFF00F7CEA500F7CEA500F7CEA500F7CE
      A500A5A5A500FFFFFF0084000000000000000000000084848400C6C6C600C6C6
      C600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00C6C6C600FFFF
      FF00C6C6C600C6C6C600C6C6C6008400000000000000000000001021F7003939
      EF00EFEFDE00FFFFEF006B6BBD000000E7001010BD00B5B5AD00FFFFF7008C8C
      DE000800DE000810BD0000000000000000000000000000000000000000000000
      0000C6C6C600C6C6C600FFFFFF00F7CEA500F7CEA500FFFFFF00FFFFFF00FFFF
      FF00FFFFFF00FFFFFF00C6A5A500846363000000000084000000F7FFFF00C6DE
      C600C6DEC600C6DEC600C6C6C600C6C6C600F7CEA500F7CEA500F7CEA500C6A5
      A500C6DEC600FFFFFF0084000000000000000000000084848400FFFFFF008484
      8400FF0000008400000084000000840000008484840084848400C6C6C600C6C6
      C600FFFFFF00C6C6C600C6C6C6008400000000000000000000005A39FF003142
      FF008C8CBD007B73B5000000F7000000F7000000FF002121CE008C8C94003939
      E7000810E7005231C60000000000000000000000000000000000000000000000
      000000000000C6C6C600FFFFFF00FFFFFF00F7CEA500F7CEA500F7CEA500FFFF
      FF00F7CEA500F7CEA500C6A58400848484000000000084000000F7FFFF00C6DE
      C600C6DEC600F7FFFF00F7FFFF00C6C6C600C6A5A500C6C6C600C6C6C600F7FF
      FF00F7FFFF00FFFFFF0084000000000000000000000084848400FFFFFF000000
      00008400000084840000848484008484840084848400C6C6C600848484008484
      8400C6C6C600C6C6C600C6C6C60084000000000000000000000000000000634A
      FF005A63FF006B6BFF005A5AFF004242FF003939FF004242FF004239F7002931
      FF004229E7000000000000000000000000000000000000000000000000000000
      000000000000C6C6C600F7CEA500FFFFFF00FFFFFF00F7CEA500F7CEA500F7CE
      A500F7CEA500F7CEA50084848400000000000000000084000000F7FFFF00F7FF
      FF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FFFF00F7FF
      FF00F7FFFF00FFFFFF008400000000000000000000000000000084848400FFFF
      FF008400000084008400FF0000008484000084848400C6C6C600C6C6C600C6C6
      C6008484840084848400C6C6C600840000000000000000000000000000000000
      00007B5AFF007384FF0094A5FF00A5A5FF00848CFF00636BFF00394AFF007339
      F700000000000000000000000000000000000000000000000000000000000000
      00000000000000000000C6C6C600F7FFFF00FFFFFF00FFFFFF00F7CEA500F7CE
      A500F7CEA500C6A58400000000000000000000000000C6632100C6842100C684
      2100C6842100C6842100C6842100C6842100C6842100C6842100C6844200C684
      2100C6844200C684630084632100000000000000000000000000000000008484
      840084848400C6C6C6008400000084008400FF000000FF00000084848400C6C6
      C600C6C6C6008484840084848400000000000000000000000000000000000000
      000000000000B531FF00A56BFF007B6BFF00736BFF009452FF00B531FF000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000C6C6C600C6C6A500C6A58400F7CEA500F7CE
      A5008484840000000000000000000000000000000000C6840000C6842100C684
      0000C6840000C6840000C6840000C6840000C6840000C6840000C6840000C684
      0000C6842100C6844200C6846300000000000000000000000000000000000000
      0000000000008484840084848400848484008484840084848400848484008484
      8400848484000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000400000000100010000000000000200000000000000000000
      000000000000000000000000FFFFFF0000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000FFFFFFFF000000000001800000000000
      0001800000000000000180000000000000018000000000000001800000000000
      0001800000000000000180000000000000018000000000000001800000000000
      000180000000000000018000000000000001800000000000FFFFFFFF00000000
      FFFFFFFF00000000FFFFFFFF00000000C001FFFFC001FFFFC001DFFBC0018001
      C0018FFFC0018001C00187F7C0018001C001C7EFC0018001C001E3CFC0018001
      C001F19FC0018001C001F83FC0018001C001FC7FC0018001C001F83FC0018001
      C001F19FC0018001C001C3CFC0018001C00387E7C0018001C0078FFBC0038001
      C00FFFFFC0078001FFFFFFFFC00FFFFF8FFF8FFFE01FFFFF07FF87FFC007F81F
      03FF83FF8003F00F01FFC1FF8001E00780FF80018000C003C00380018000C003
      E001800180008001F000800180008001F000800180008001F000800180008001
      F00080018000C003F00080018000C003F80080018000E007F8018001C000F00F
      FC038001E001F81FFE078001F807FFFF00000000000000000000000000000000
      000000000000}
  end
  object JvBalloonHint: TJvBalloonHint
    CustomAnimationStyle = atCenter
    CustomAnimationTime = 5
    DefaultIcon = ikCustom
    Images = ImgMain
    Options = [boUseDefaultImageIndex]
    ApplicationHintOptions = [ahShowHeaderInHint, ahShowIconInHint, ahUseBalloonAsHint]
    Left = 488
    Top = 424
  end
end
