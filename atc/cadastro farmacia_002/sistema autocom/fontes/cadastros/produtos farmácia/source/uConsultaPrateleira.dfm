inherited fConsultaPrateleira: TfConsultaPrateleira
  Left = 336
  Top = 216
  Caption = 'Prateleira'
  OldCreateOrder = True
  PixelsPerInch = 96
  TextHeight = 13
  inherited GrdConsulta: TDBGrid
    Height = 288
    OnDblClick = GrdConsultaDblClick
    OnKeyDown = GrdConsultaKeyDown
  end
  inherited PanFields: TPanel
    Top = 288
    Height = 51
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 37
      Height = 13
      Caption = 'C'#243'digo:'
    end
    object Label2: TLabel
      Left = 96
      Top = 8
      Width = 50
      Height = 13
      Caption = 'Prateleira:'
    end
    object EdCodigo: TEdit
      Left = 8
      Top = 22
      Width = 81
      Height = 21
      CharCase = ecUpperCase
      Color = 15717318
      ReadOnly = True
      TabOrder = 0
    end
    object EdNome: TMaskEdit
      Left = 96
      Top = 24
      Width = 286
      Height = 21
      EditMask = '9999999999;0; '
      MaxLength = 10
      TabOrder = 1
    end
  end
  inherited PanBtns: TPanel
    inherited BtnSalvar: TSpeedButton
      OnClick = BtnSalvarClick
    end
  end
end
