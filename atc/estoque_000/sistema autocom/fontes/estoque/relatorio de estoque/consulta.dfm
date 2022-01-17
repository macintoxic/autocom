object FrmConsulta: TFrmConsulta
  Left = 306
  Top = 224
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = '  '
  ClientHeight = 375
  ClientWidth = 455
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
  object GrdConsulta: TDBGrid
    Left = 0
    Top = 0
    Width = 455
    Height = 375
    Align = alClient
    DataSource = DataSource
    Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = GrdConsultaDblClick
    OnKeyDown = GrdConsultaKeyDown
  end
  object DataSource: TDataSource
    DataSet = Dm.Tbl_Secao
    Left = 144
    Top = 72
  end
end
