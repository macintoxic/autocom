object FrmMain: TFrmMain
  Left = 277
  Top = 159
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Relat'#243'rios de Estoque'
  ClientHeight = 468
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 15
  object LblTitle: TLabel
    Left = 0
    Top = 0
    Width = 472
    Height = 29
    Align = alTop
    Alignment = taCenter
    Caption = 'Rel'#225'torios'
    Font.Charset = ANSI_CHARSET
    Font.Color = clTeal
    Font.Height = -24
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblConsulta: TLabel
    Left = 0
    Top = 407
    Width = 472
    Height = 25
    Alignment = taCenter
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object GrpOrganizar: TGroupBox
    Left = 238
    Top = 40
    Width = 230
    Height = 113
    Caption = 'Organizar por'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    object RadNomeProduto: TRadioButton
      Left = 16
      Top = 52
      Width = 129
      Height = 17
      Caption = '&Nome do Produto'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnKeyDown = RadSaldoEstoqueKeyDown
    end
    object RadQuantEstoque: TRadioButton
      Left = 16
      Top = 80
      Width = 161
      Height = 17
      Caption = '&Quantidade em Estoque'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnKeyDown = RadSaldoEstoqueKeyDown
    end
    object RadCodProduto: TRadioButton
      Left = 16
      Top = 24
      Width = 129
      Height = 17
      Caption = '&C'#243'digo do Produto'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnKeyDown = RadSaldoEstoqueKeyDown
    end
  end
  object GrpTipo: TGroupBox
    Left = 6
    Top = 40
    Width = 230
    Height = 113
    Caption = 'Tipo de Relat'#243'rio'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    object RadSaldoEstoque: TRadioButton
      Left = 16
      Top = 24
      Width = 129
      Height = 17
      Caption = '&Saldo em Estoque'
      Checked = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnKeyDown = RadSaldoEstoqueKeyDown
    end
    object RadApuracaoEstoque: TRadioButton
      Left = 16
      Top = 52
      Width = 145
      Height = 17
      Caption = '&Apura'#231#227'o de Estoque'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnKeyDown = RadSaldoEstoqueKeyDown
    end
  end
  object PanFiltroSaldo: TPanel
    Left = 6
    Top = 164
    Width = 459
    Height = 45
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 3
    Visible = False
    object LblFDe: TLabel
      Left = 6
      Top = 18
      Width = 19
      Height = 15
      Caption = '&De:'
      FocusControl = MskDe
    end
    object TxtFAte: TLabel
      Left = 198
      Top = 16
      Width = 20
      Height = 15
      Caption = 'A&t'#233':'
      FocusControl = MskAte
    end
    object MskDe: TMaskEdit
      Left = 31
      Top = 14
      Width = 150
      Height = 23
      EditMask = '999999999999999;0; '
      MaxLength = 15
      TabOrder = 0
      OnClick = MskDeClick
      OnKeyDown = RadSaldoEstoqueKeyDown
    end
    object MskAte: TMaskEdit
      Left = 223
      Top = 14
      Width = 150
      Height = 23
      EditMask = '999999999999999;0; '
      MaxLength = 15
      TabOrder = 1
      OnClick = MskAteClick
      OnKeyDown = RadSaldoEstoqueKeyDown
    end
  end
  object ChkFiltroSaldo: TCheckBox
    Left = 19
    Top = 158
    Width = 150
    Height = 17
    Caption = 'Filtra&r por Quantidade'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = ChkFiltroSaldoClick
    OnKeyDown = RadSaldoEstoqueKeyDown
  end
  object CmbImprimir: TBitBtn
    Left = 129
    Top = 435
    Width = 110
    Height = 25
    Cursor = crHandPoint
    Caption = '&Imprimir'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 8
    OnClick = CmbImprimirClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00300000000000
      0003377777777777777308888888888888807F33333333333337088888888888
      88807FFFFFFFFFFFFFF7000000000000000077777777777777770F8F8F8F8F8F
      8F807F333333333333F708F8F8F8F8F8F9F07F333333333337370F8F8F8F8F8F
      8F807FFFFFFFFFFFFFF7000000000000000077777777777777773330FFFFFFFF
      03333337F3FFFF3F7F333330F0000F0F03333337F77773737F333330FFFFFFFF
      03333337F3FF3FFF7F333330F00F000003333337F773777773333330FFFF0FF0
      33333337F3F37F3733333330F08F0F0333333337F7337F7333333330FFFF0033
      33333337FFFF7733333333300000033333333337777773333333}
    NumGlyphs = 2
  end
  object CmbCancelar: TBitBtn
    Left = 250
    Top = 435
    Width = 110
    Height = 25
    Cursor = crHandPoint
    Caption = '&Fechar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 9
    Kind = bkClose
  end
  object PanSecao: TPanel
    Left = 6
    Top = 222
    Width = 459
    Height = 83
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 5
    Visible = False
    object CmdSecao: TSpeedButton
      Left = 122
      Top = 17
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = CmdSecaoClick
    end
    object LblSecaoNome: TLabel
      Left = 184
      Top = 20
      Width = 265
      Height = 15
      AutoSize = False
      Caption = '-'
    end
    object LblSecao: TLabel
      Left = 7
      Top = 20
      Width = 38
      Height = 15
      Caption = 'Se'#231#227'o:'
    end
    object LblPrateleira: TLabel
      Left = 7
      Top = 52
      Width = 56
      Height = 15
      Caption = 'Prateleira:'
    end
    object CmdPrateleira: TSpeedButton
      Left = 122
      Top = 49
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = CmdPrateleiraClick
    end
    object LblPrateleiraNome: TLabel
      Left = 184
      Top = 52
      Width = 265
      Height = 15
      AutoSize = False
      Caption = '-'
    end
    object CmdClearSecao: TSpeedButton
      Left = 148
      Top = 17
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
        3333333777333777FF3333993333339993333377FF3333377FF3399993333339
        993337777FF3333377F3393999333333993337F777FF333337FF993399933333
        399377F3777FF333377F993339993333399377F33777FF33377F993333999333
        399377F333777FF3377F993333399933399377F3333777FF377F993333339993
        399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
        99333773FF3333777733339993333339933333773FFFFFF77333333999999999
        3333333777333777333333333999993333333333377777333333}
      NumGlyphs = 2
      OnClick = CmdClearSecaoClick
    end
    object CmdClearPrateleira: TSpeedButton
      Left = 148
      Top = 49
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
        3333333777333777FF3333993333339993333377FF3333377FF3399993333339
        993337777FF3333377F3393999333333993337F777FF333337FF993399933333
        399377F3777FF333377F993339993333399377F33777FF33377F993333999333
        399377F333777FF3377F993333399933399377F3333777FF377F993333339993
        399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
        99333773FF3333777733339993333339933333773FFFFFF77333333999999999
        3333333777333777333333333999993333333333377777333333}
      NumGlyphs = 2
      OnClick = CmdClearPrateleiraClick
    end
    object MskSecao: TMaskEdit
      Left = 68
      Top = 17
      Width = 49
      Height = 23
      ReadOnly = True
      TabOrder = 0
      OnEnter = MskSecaoEnter
      OnExit = MskSecaoExit
      OnKeyDown = MskSecaoKeyDown
    end
    object MskPrateleira: TMaskEdit
      Left = 68
      Top = 49
      Width = 49
      Height = 23
      ReadOnly = True
      TabOrder = 1
      OnEnter = MskPrateleiraEnter
      OnExit = MskPrateleiraExit
      OnKeyDown = MskPrateleiraKeyDown
    end
  end
  object chkSecao: TCheckBox
    Left = 20
    Top = 215
    Width = 190
    Height = 17
    Caption = 'Filtra&r por Se'#231#227'o / Prateleira'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = chkSecaoClick
    OnKeyDown = RadSaldoEstoqueKeyDown
  end
  object PanGrupo: TPanel
    Left = 6
    Top = 323
    Width = 459
    Height = 78
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 7
    Visible = False
    object CmdGrupo: TSpeedButton
      Left = 122
      Top = 17
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = CmdGrupoClick
    end
    object LblGrupoNome: TLabel
      Left = 184
      Top = 20
      Width = 265
      Height = 15
      AutoSize = False
      Caption = '-'
    end
    object LblGrupo: TLabel
      Left = 7
      Top = 20
      Width = 37
      Height = 15
      Caption = 'Grupo:'
    end
    object LblSubGrupo: TLabel
      Left = 5
      Top = 52
      Width = 59
      Height = 15
      Caption = 'SubGrupo:'
    end
    object CmdSubGrupo: TSpeedButton
      Left = 122
      Top = 49
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333FF33333333333330003FF3FFFFF3333777003000003333
        300077F777773F333777E00BFBFB033333337773333F7F33333FE0BFBF000333
        330077F3337773F33377E0FBFBFBF033330077F3333FF7FFF377E0BFBF000000
        333377F3337777773F3FE0FBFBFBFBFB039977F33FFFFFFF7377E0BF00000000
        339977FF777777773377000BFB03333333337773FF733333333F333000333333
        3300333777333333337733333333333333003333333333333377333333333333
        333333333333333333FF33333333333330003333333333333777333333333333
        3000333333333333377733333333333333333333333333333333}
      NumGlyphs = 2
      OnClick = CmdSubGrupoClick
    end
    object LblSubGrupoNome: TLabel
      Left = 184
      Top = 52
      Width = 265
      Height = 15
      AutoSize = False
      Caption = '-'
    end
    object CmdClearGrupo: TSpeedButton
      Left = 148
      Top = 17
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
        3333333777333777FF3333993333339993333377FF3333377FF3399993333339
        993337777FF3333377F3393999333333993337F777FF333337FF993399933333
        399377F3777FF333377F993339993333399377F33777FF33377F993333999333
        399377F333777FF3377F993333399933399377F3333777FF377F993333339993
        399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
        99333773FF3333777733339993333339933333773FFFFFF77333333999999999
        3333333777333777333333333999993333333333377777333333}
      NumGlyphs = 2
      OnClick = CmdClearGrupoClick
    end
    object CmdClearSubGrupo: TSpeedButton
      Left = 148
      Top = 49
      Width = 23
      Height = 22
      Flat = True
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333FFFFF3333333333999993333333333F77777FFF333333999999999
        3333333777333777FF3333993333339993333377FF3333377FF3399993333339
        993337777FF3333377F3393999333333993337F777FF333337FF993399933333
        399377F3777FF333377F993339993333399377F33777FF33377F993333999333
        399377F333777FF3377F993333399933399377F3333777FF377F993333339993
        399377FF3333777FF7733993333339993933373FF3333777F7F3399933333399
        99333773FF3333777733339993333339933333773FFFFFF77333333999999999
        3333333777333777333333333999993333333333377777333333}
      NumGlyphs = 2
      OnClick = CmdClearSubGrupoClick
    end
    object MskGrupo: TMaskEdit
      Left = 68
      Top = 17
      Width = 49
      Height = 23
      ReadOnly = True
      TabOrder = 0
      OnEnter = MskGrupoEnter
      OnExit = MskGrupoExit
      OnKeyDown = MskGrupoKeyDown
    end
    object MskSubGrupo: TMaskEdit
      Left = 68
      Top = 49
      Width = 49
      Height = 23
      ReadOnly = True
      TabOrder = 1
      OnEnter = MskSubGrupoEnter
      OnExit = MskSubGrupoExit
      OnKeyDown = MskSubGrupoKeyDown
    end
  end
  object ChkGrupo: TCheckBox
    Left = 20
    Top = 317
    Width = 182
    Height = 17
    Caption = 'Filtar por Grupo / Subgrupo'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 6
    OnClick = ChkGrupoClick
    OnKeyDown = RadSaldoEstoqueKeyDown
  end
  object XPMenu: TXPMenu
    DimLevel = 30
    GrayLevel = 10
    Font.Charset = ANSI_CHARSET
    Font.Color = clMenuText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Color = clBtnFace
    DrawMenuBar = False
    IconBackColor = clBtnFace
    MenuBarColor = clBtnFace
    SelectColor = clHighlight
    SelectBorderColor = clHighlight
    SelectFontColor = clMenuText
    DisabledColor = clInactiveCaption
    SeparatorColor = clBtnFace
    CheckedColor = clHighlight
    IconWidth = 24
    DrawSelect = True
    UseSystemColors = True
    UseDimColor = False
    OverrideOwnerDraw = False
    Gradient = False
    FlatMenu = False
    AutoDetect = True
    Active = True
    Left = 350
    Top = 176
  end
end
