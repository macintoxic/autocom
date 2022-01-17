object fdadosch: Tfdadosch
  Left = 437
  Top = 264
  BorderStyle = bsNone
  Caption = 'fdadosch'
  ClientHeight = 256
  ClientWidth = 345
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 345
    Height = 256
    Align = alClient
    BevelInner = bvRaised
    BevelWidth = 2
    BorderStyle = bsSingle
    Color = clSilver
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 41
      Width = 69
      Height = 22
      Caption = 'BANCO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 16
      Top = 75
      Width = 84
      Height = 22
      Caption = 'N'#218'MERO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 16
      Top = 108
      Width = 86
      Height = 22
      Caption = 'AG'#202'NCIA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 4
      Top = 4
      Width = 333
      Height = 22
      Align = alTop
      Alignment = taCenter
      Caption = 'DADOS DO CHEQUE'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 16
      Top = 142
      Width = 68
      Height = 22
      Caption = 'CONTA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Left = 243
      Top = 75
      Width = 6
      Height = 22
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Left = 243
      Top = 108
      Width = 6
      Height = 22
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label8: TLabel
      Left = 243
      Top = 142
      Width = 6
      Height = 22
      Caption = '-'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Left = 8
      Top = 182
      Width = 184
      Height = 22
      Caption = 'DATA CHEQUE-PR'#201
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      Visible = False
    end
    object BitBtn1: TBitBtn
      Left = 10
      Top = 213
      Width = 321
      Height = 31
      TabOrder = 8
      OnClick = BitBtn1Click
      OnKeyDown = MaskEdit1KeyDown
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
    end
    object MaskEdit1: TMaskEdit
      Left = 108
      Top = 36
      Width = 85
      Height = 30
      EditMask = '9999;0; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MaxLength = 4
      ParentFont = False
      TabOrder = 0
      OnChange = MaskEdit1Change
      OnEnter = MaskEdit1Enter
      OnKeyDown = MaskEdit1KeyDown
    end
    object MaskEdit3: TMaskEdit
      Left = 108
      Top = 104
      Width = 133
      Height = 30
      EditMask = '9999999999;0; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MaxLength = 10
      ParentFont = False
      TabOrder = 3
      OnChange = MaskEdit1Change
      OnEnter = MaskEdit3Enter
      OnKeyDown = MaskEdit1KeyDown
    end
    object MaskEdit4: TMaskEdit
      Left = 108
      Top = 138
      Width = 133
      Height = 30
      EditMask = '9999999999;0; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MaxLength = 10
      ParentFont = False
      TabOrder = 5
      OnChange = MaskEdit1Change
      OnEnter = MaskEdit4Enter
      OnKeyDown = MaskEdit1KeyDown
    end
    object MaskEdit2: TMaskEdit
      Left = 108
      Top = 70
      Width = 133
      Height = 30
      EditMask = '9999999999;0; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MaxLength = 10
      ParentFont = False
      TabOrder = 1
      Text = '1264567890'
      OnChange = MaskEdit1Change
      OnEnter = MaskEdit2Enter
      OnKeyDown = MaskEdit1KeyDown
    end
    object MaskEdit5: TMaskEdit
      Left = 252
      Top = 138
      Width = 29
      Height = 30
      EditMask = '99;0; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MaxLength = 2
      ParentFont = False
      TabOrder = 6
      OnChange = MaskEdit1Change
      OnKeyDown = MaskEdit1KeyDown
    end
    object MaskEdit6: TMaskEdit
      Left = 252
      Top = 104
      Width = 29
      Height = 30
      EditMask = '99;0; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MaxLength = 2
      ParentFont = False
      TabOrder = 4
      OnChange = MaskEdit1Change
      OnKeyDown = MaskEdit1KeyDown
    end
    object MaskEdit7: TMaskEdit
      Left = 252
      Top = 70
      Width = 29
      Height = 30
      EditMask = '99;0; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MaxLength = 2
      ParentFont = False
      TabOrder = 2
      OnChange = MaskEdit1Change
      OnKeyDown = MaskEdit1KeyDown
    end
    object MaskEdit8: TMaskEdit
      Left = 199
      Top = 178
      Width = 114
      Height = 30
      EditMask = '99/99/9999;1; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MaxLength = 10
      ParentFont = False
      TabOrder = 7
      Text = '30/12/2000'
      Visible = False
      OnChange = MaskEdit1Change
      OnEnter = MaskEdit8Enter
      OnKeyDown = MaskEdit1KeyDown
    end
  end
  object XPMenu1: TXPMenu
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
    Gradient = True
    FlatMenu = False
    AutoDetect = True
    Active = True
    Left = 576
    Top = 384
  end
end
