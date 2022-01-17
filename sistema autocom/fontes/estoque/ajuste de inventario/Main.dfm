object FrmMain: TFrmMain
  Left = 329
  Top = 182
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Ajuste de Invent'#225'rio'
  ClientHeight = 373
  ClientWidth = 352
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
  object LblCodProduto: TLabel
    Left = 8
    Top = 24
    Width = 107
    Height = 15
    Caption = 'C'#243'digo do Produto:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object CmdProduto: TSpeedButton
    Left = 263
    Top = 20
    Width = 25
    Height = 25
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
    OnClick = CmdProdutoClick
  end
  object LblNomeProduto: TLabel
    Left = 113
    Top = 65
    Width = 240
    Height = 15
    AutoSize = False
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Label3: TLabel
    Left = 8
    Top = 65
    Width = 101
    Height = 15
    Caption = 'Nome do Produto:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 8
    Top = 138
    Width = 81
    Height = 15
    Caption = 'Estoque Atual:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblEstMin: TLabel
    Left = 8
    Top = 179
    Width = 93
    Height = 15
    Caption = 'Estoque M'#237'nimo:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object LblEstMax: TLabel
    Left = 8
    Top = 221
    Width = 97
    Height = 15
    Caption = 'Estoque M'#225'ximo:'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl_consulta: TLabel
    Left = 8
    Top = 305
    Width = 328
    Height = 20
    Alignment = taCenter
    AutoSize = False
    Caption = '[F1] Consulta Produtos'
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -16
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    Visible = False
  end
  object cmdgravar: TBitBtn
    Left = 12
    Top = 341
    Width = 129
    Height = 25
    Cursor = crHandPoint
    Caption = '&Gravar'
    Enabled = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = cmdgravarClick
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00555555555555
      555555FFFFFFFFFF5F5557777777777505555777777777757F55555555555555
      055555555555FF5575F555555550055030555555555775F7F7F55555550FB000
      005555555575577777F5555550FB0BF0F05555555755755757F555550FBFBF0F
      B05555557F55557557F555550BFBF0FB005555557F55575577F555500FBFBFB0
      305555577F555557F7F5550E0BFBFB003055557575F55577F7F550EEE0BFB0B0
      305557FF575F5757F7F5000EEE0BFBF03055777FF575FFF7F7F50000EEE00000
      30557777FF577777F7F500000E05555BB05577777F75555777F5500000555550
      3055577777555557F7F555000555555999555577755555577755}
    NumGlyphs = 2
  end
  object cmdfechar: TBitBtn
    Left = 211
    Top = 341
    Width = 129
    Height = 25
    Cursor = crHandPoint
    Caption = '&Fechar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = cmdfecharClick
    Kind = bkClose
  end
  object MskCodProduto: TMaskEdit
    Left = 128
    Top = 21
    Width = 130
    Height = 23
    EditMask = '9999999999999;0; '
    MaxLength = 13
    TabOrder = 2
    OnEnter = MskCodProdutoEnter
    OnExit = MskCodProdutoExit
    OnKeyDown = MskCodProdutoKeyDown
  end
  object MskEstoqueAtual: TMaskEdit
    Left = 128
    Top = 133
    Width = 118
    Height = 23
    EditMask = '9999999999,999;1; '
    MaxLength = 14
    TabOrder = 3
    Text = '          ,   '
    OnExit = MskEstoqueAtualExit
    OnKeyDown = MskEstoqueAtualKeyDown
  end
  object MskEstMin: TMaskEdit
    Left = 128
    Top = 173
    Width = 118
    Height = 23
    Color = clSkyBlue
    EditMask = '9999999999,999;1; '
    MaxLength = 14
    ReadOnly = True
    TabOrder = 4
    Text = '          ,   '
    OnKeyDown = MskEstoqueAtualKeyDown
  end
  object MskEstMax: TMaskEdit
    Left = 128
    Top = 213
    Width = 118
    Height = 23
    Color = clSkyBlue
    EditMask = '9999999999,999;1; '
    MaxLength = 14
    ReadOnly = True
    TabOrder = 5
    Text = '          ,   '
    OnKeyDown = MskEstoqueAtualKeyDown
  end
end
