inherited fConsultaSubGrupos: TfConsultaSubGrupos
  Left = 200
  Top = 55
  Caption = 'Sub-Grupos'
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
      Width = 31
      Height = 13
      Caption = 'Nome:'
    end
    object EdCodigo: TEdit
      Left = 8
      Top = 24
      Width = 81
      Height = 21
      CharCase = ecUpperCase
      Color = 15717318
      ReadOnly = True
      TabOrder = 0
    end
    object EdNome: TEdit
      Left = 94
      Top = 24
      Width = 291
      Height = 21
      CharCase = ecUpperCase
      TabOrder = 1
    end
  end
  inherited PanBtns: TPanel
    inherited BtnEditar: TSpeedButton
      Left = 102
    end
    inherited BtnSalvar: TSpeedButton
      Left = 298
      OnClick = BtnSalvarClick
    end
  end
end
