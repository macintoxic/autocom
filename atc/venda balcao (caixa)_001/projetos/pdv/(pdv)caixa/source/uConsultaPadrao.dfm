object frmConsultaPadrao: TfrmConsultaPadrao
  Left = 198
  Top = 198
  Width = 600
  Height = 363
  BorderIcons = []
  Caption = 'Sisterma Autocom'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  OnCloseQuery = FormCloseQuery
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDicas: TPanel
    Left = 0
    Top = 295
    Width = 592
    Height = 41
    Align = alBottom
    Caption = 
      '[ENTER] - Seleciona o produto                           [ESC] - ' +
      'Voltar'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -19
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
  end
  object dsClientes: TDataSource
    Left = 632
    Top = 320
  end
end
