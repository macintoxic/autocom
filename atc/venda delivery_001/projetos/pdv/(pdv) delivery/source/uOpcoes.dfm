inherited frmOpcoes: TfrmOpcoes
  Left = 322
  Top = 298
  ClientHeight = 151
  ClientWidth = 307
  Color = clSkyBlue
  OldCreateOrder = True
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 307
    Height = 151
    Align = alClient
    BevelInner = bvLowered
    BevelOuter = bvSpace
    ParentColor = True
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Tag = 1
      Left = 9
      Top = 7
      Width = 289
      Height = 41
      Caption = '[F1] - Cancelar as altera'#231#245'es'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object SpeedButton2: TSpeedButton
      Tag = 2
      Left = 9
      Top = 55
      Width = 289
      Height = 41
      Caption = '[F2] - Apagar Pedido'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton1Click
    end
    object SpeedButton3: TSpeedButton
      Tag = 3
      Left = 9
      Top = 103
      Width = 289
      Height = 41
      Caption = '[F3] - Voltar'
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clNavy
      Font.Height = -19
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      OnClick = SpeedButton1Click
    end
  end
end
