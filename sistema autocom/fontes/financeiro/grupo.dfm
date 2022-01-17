object frmgrupo: Tfrmgrupo
  Left = 296
  Top = 271
  Width = 366
  Height = 391
  BorderIcons = [biSystemMenu]
  Caption = 'Movimenta'#231#227'o'
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object grd_grupo: TDBGrid
    Left = 0
    Top = 0
    Width = 358
    Height = 288
    Align = alClient
    Ctl3D = False
    DataSource = Ds_Grupo
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = grd_grupoDblClick
    OnKeyDown = grd_grupoKeyDown
  end
  object PanBaixo: TPanel
    Left = 0
    Top = 331
    Width = 358
    Height = 33
    Align = alBottom
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 1
    object cmd_inserir: TSpeedButton
      Left = 3
      Top = 4
      Width = 115
      Height = 25
      Caption = '&Inserir'
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      Glyph.Data = {
        76010000424D7601000000000000760000002800000020000000100000000100
        04000000000000010000130B0000130B00001000000000000000000000000000
        800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF0033333333B333
        333B33FF33337F3333F73BB3777BB7777BB3377FFFF77FFFF77333B000000000
        0B3333777777777777333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333337F33333337F333330FFFFFFFF07333337F33333337F333330FFFFFFFF
        07333FF7F33333337FFFBBB0FFFFFFFF0BB37777F3333333777F3BB0FFFFFFFF
        0BBB3777F3333FFF77773330FFFF000003333337F333777773333330FFFF0FF0
        33333337F3337F37F3333330FFFF0F0B33333337F3337F77FF333330FFFF003B
        B3333337FFFF77377FF333B000000333BB33337777777F3377FF3BB3333BB333
        3BB33773333773333773B333333B3333333B7333333733333337}
      NumGlyphs = 2
      ParentFont = False
      OnClick = cmd_inserirClick
    end
    object cmd_Alterar: TSpeedButton
      Left = 120
      Top = 4
      Width = 115
      Height = 25
      Caption = '&Alterar'
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
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500000000055
        555557777777775F55550FFFFFFFFF0555557F5555555F7FFF5F0FEEEEEE0000
        05007F555555777775770FFFFFF0BFBFB00E7F5F5557FFF557770F0EEEE000FB
        FB0E7F75FF57775555770FF00F0FBFBFBF0E7F57757FFFF555770FE0B00000FB
        FB0E7F575777775555770FFF0FBFBFBFBF0E7F5575FFFFFFF5770FEEE0000000
        FB0E7F555777777755770FFFFF0B00BFB0007F55557577FFF7770FEEEEE0B000
        05557F555557577775550FFFFFFF0B0555557FF5F5F57575F55500F0F0F0F0B0
        555577F7F7F7F7F75F5550707070700B055557F7F7F7F7757FF5507070707050
        9055575757575757775505050505055505557575757575557555}
      NumGlyphs = 2
      ParentFont = False
      OnClick = cmd_AlterarClick
    end
    object cmd_excluir: TSpeedButton
      Left = 241
      Top = 4
      Width = 115
      Height = 25
      Caption = '&Excluir'
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
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00500005000555
        555557777F777555F55500000000555055557777777755F75555005500055055
        555577F5777F57555555005550055555555577FF577F5FF55555500550050055
        5555577FF77577FF555555005050110555555577F757777FF555555505099910
        555555FF75777777FF555005550999910555577F5F77777775F5500505509990
        3055577F75F77777575F55005055090B030555775755777575755555555550B0
        B03055555F555757575755550555550B0B335555755555757555555555555550
        BBB35555F55555575F555550555555550BBB55575555555575F5555555555555
        50BB555555555555575F555555555555550B5555555555555575}
      NumGlyphs = 2
      ParentFont = False
      OnClick = cmd_excluirClick
    end
  end
  object PanEdit: TPanel
    Left = 0
    Top = 288
    Width = 358
    Height = 43
    Align = alBottom
    BevelInner = bvSpace
    BevelOuter = bvLowered
    TabOrder = 2
    Visible = False
    object cmd_ok: TSpeedButton
      Left = 329
      Top = 15
      Width = 26
      Height = 22
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000C40E0000C40E00001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00AAAAAAAAAAAA
        AAAAAA0000000000000AA03300000077030AA03300000077030AA03300000077
        030AA03300000000030AA03333333333330AA03300000000330AA03077777777
        030AA03077777777030AA03077777777030AA03077777777030AA03077777777
        000AA030777777770A0AA00000000000000AAAAAAAAAAAAAAAAA}
      OnClick = cmd_okClick
    end
    object Label1: TLabel
      Left = 4
      Top = 1
      Width = 37
      Height = 13
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 55
      Top = 1
      Width = 91
      Height = 13
      Caption = 'Nome do conjunto:'
    end
    object Label3: TLabel
      Left = 240
      Top = 1
      Width = 38
      Height = 13
      Caption = 'Origem:'
    end
    object txt_codsecao: TEdit
      Left = 3
      Top = 15
      Width = 45
      Height = 22
      Color = clSkyBlue
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      OnKeyDown = txt_codsecaoKeyDown
    end
    object txt_nomesecao: TEdit
      Left = 54
      Top = 15
      Width = 182
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
      OnKeyDown = txt_nomesecaoKeyDown
    end
    object cmborigem: TComboBox
      Left = 240
      Top = 15
      Width = 81
      Height = 21
      ItemHeight = 13
      TabOrder = 2
      OnDropDown = cmborigemDropDown
    end
  end
  object Ds_Grupo: TDataSource
    DataSet = Dm.Consulta
    Left = 72
    Top = 128
  end
end
