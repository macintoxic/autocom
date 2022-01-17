object fConsultaEstado: TfConsultaEstado
  Left = 285
  Top = 244
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Estados'
  ClientHeight = 373
  ClientWidth = 392
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object GrdConsulta: TDBGrid
    Left = 0
    Top = 0
    Width = 392
    Height = 373
    Align = alClient
    Ctl3D = False
    DataSource = DsEstados
    FixedColor = 13003057
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    ParentCtl3D = False
    ParentFont = False
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWhite
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = [fsBold]
    OnDblClick = GrdConsultaDblClick
    OnKeyDown = GrdConsultaKeyDown
  end
  object DsEstados: TDataSource
    Left = 230
    Top = 289
  end
end
