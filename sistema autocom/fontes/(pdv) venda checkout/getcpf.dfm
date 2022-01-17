object Fgetcpf: TFgetcpf
  Left = 439
  Top = 287
  ActiveControl = edcli
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Consulta'
  ClientHeight = 235
  ClientWidth = 351
  Color = clSilver
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
  object Label5: TLabel
    Left = 0
    Top = 0
    Width = 351
    Height = 22
    Align = alTop
    Alignment = taCenter
    Caption = 'Informe o CPF / CNPJ do cliente'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel1: TPanel
    Left = 0
    Top = 162
    Width = 351
    Height = 73
    Align = alBottom
    BevelInner = bvRaised
    BevelWidth = 3
    BorderStyle = bsSingle
    Caption = 'Panel1'
    Color = clSilver
    TabOrder = 0
    object edcli: TMaskEdit
      Left = 9
      Top = 17
      Width = 328
      Height = 30
      EditMask = '9999999999999999;0; '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      MaxLength = 16
      ParentFont = False
      TabOrder = 0
      OnChange = edcliChange
      OnEnter = edcliEnter
      OnKeyDown = edcliKeyDown
    end
  end
  object TBCONV: TTable
    DatabaseName = 'K:\autocom plus\Dlls\Venda\Venda-padrao\dados'
    IndexFieldNames = 'Codigo'
    TableName = 'AC201'
    Left = 232
    Top = 12
    object TBCONVCodigo: TFloatField
      FieldName = 'Codigo'
    end
    object TBCONVSaldo: TStringField
      FieldName = 'Saldo'
      Size = 12
    end
    object TBCONVData: TDateField
      FieldName = 'Data'
    end
    object TBCONVHora: TTimeField
      FieldName = 'Hora'
    end
    object TBCONVOperador: TFloatField
      FieldName = 'Operador'
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
