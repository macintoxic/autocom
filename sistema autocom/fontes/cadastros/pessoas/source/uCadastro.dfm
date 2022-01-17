object fCadastro: TfCadastro
  Left = 56
  Top = 4
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Cadastro de Pessoas'
  ClientHeight = 513
  ClientWidth = 672
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poDesktopCenter
  OnKeyDown = FormKeyDown
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object PgCtrlMain: TPageControl
    Left = 0
    Top = 0
    Width = 672
    Height = 479
    ActivePage = TabPessoa
    Align = alTop
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    Images = fMain.ImgMain
    ParentFont = False
    Style = tsFlatButtons
    TabOrder = 0
    OnChanging = PgCtrlMainChanging
    object TabPessoa: TTabSheet
      Caption = '&Pessoa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 9
      ParentFont = False
      object LblNome: TLabel
        Left = 5
        Top = 81
        Width = 31
        Height = 13
        Caption = 'Nome:'
      end
      object LblReferencia: TLabel
        Left = 5
        Top = 112
        Width = 56
        Height = 13
        Caption = 'Refer'#234'ncia:'
      end
      object LblRG: TLabel
        Left = 5
        Top = 143
        Width = 18
        Height = 13
        Caption = 'RG:'
      end
      object LblTelefone: TLabel
        Left = 379
        Top = 173
        Width = 46
        Height = 13
        Caption = 'Telefone:'
      end
      object LblProfissao: TLabel
        Left = 5
        Top = 174
        Width = 48
        Height = 13
        Caption = 'Profiss'#227'o:'
      end
      object LblDataNascimento: TLabel
        Left = 379
        Top = 204
        Width = 59
        Height = 13
        Caption = 'Nascimento:'
      end
      object LblCPF: TLabel
        Left = 379
        Top = 143
        Width = 23
        Height = 13
        Caption = 'CPF:'
      end
      object Label10: TLabel
        Left = 2
        Top = 238
        Width = 67
        Height = 13
        Caption = 'Observa'#231#245'es:'
      end
      object Label1: TLabel
        Left = 5
        Top = 20
        Width = 37
        Height = 13
        Caption = 'C'#243'digo:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 5
        Top = 50
        Width = 38
        Height = 13
        Caption = 'Pessoa:'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object LblSexo: TLabel
        Left = 4
        Top = 204
        Width = 28
        Height = 13
        Caption = 'Sexo:'
      end
      object EdNome: TEdit
        Left = 76
        Top = 78
        Width = 581
        Height = 21
        CharCase = ecUpperCase
        Color = clWhite
        TabOrder = 2
      end
      object EdReferencia: TEdit
        Left = 76
        Top = 109
        Width = 581
        Height = 21
        CharCase = ecUpperCase
        Color = clWhite
        TabOrder = 3
      end
      object MskRG: TMaskEdit
        Left = 75
        Top = 139
        Width = 197
        Height = 21
        Color = clWhite
        EditMask = '999999999999999999;0; '
        MaxLength = 18
        TabOrder = 4
      end
      object MskTeleFoneePessoa: TMaskEdit
        Left = 457
        Top = 171
        Width = 200
        Height = 21
        Hint = 'Informe o telefone para contato (opcional).'
        BiDiMode = bdRightToLeft
        Color = clWhite
        EditMask = '(9999) 9999-9999;0; '
        MaxLength = 16
        ParentBiDiMode = False
        TabOrder = 7
      end
      object EdProfissao: TEdit
        Left = 75
        Top = 170
        Width = 200
        Height = 21
        CharCase = ecUpperCase
        Color = clWhite
        TabOrder = 6
      end
      object MskCPF: TMaskEdit
        Left = 457
        Top = 139
        Width = 200
        Height = 21
        Color = clWhite
        EditMask = '9999999999999999999;0; '
        MaxLength = 19
        TabOrder = 5
      end
      object MemObservacoes: TMemo
        Left = 2
        Top = 259
        Width = 657
        Height = 179
        Color = clWhite
        TabOrder = 10
      end
      object EdCodigo: TMaskEdit
        Left = 76
        Top = 17
        Width = 125
        Height = 21
        Color = 15717318
        TabOrder = 0
      end
      object CmbPessoa: TComboBox
        Left = 76
        Top = 47
        Width = 125
        Height = 21
        Style = csDropDownList
        Color = clWhite
        ItemHeight = 13
        TabOrder = 1
        OnChange = CmbPessoaChange
      end
      object CmbSexo: TComboBox
        Left = 75
        Top = 199
        Width = 200
        Height = 21
        Style = csDropDownList
        CharCase = ecUpperCase
        Color = clWhite
        ItemHeight = 13
        TabOrder = 8
        Items.Strings = (
          'MASCULINO'
          'FEMININO')
      end
      object DateNascimento: TDateTimePicker
        Left = 457
        Top = 201
        Width = 200
        Height = 21
        Date = 37739.755293067130000000
        Time = 37739.755293067130000000
        Color = clWhite
        TabOrder = 9
      end
    end
    object TabEndereco: TTabSheet
      Caption = '&Endere'#231'o'
      ImageIndex = 9
      object GrdEndereco: TDBGrid
        Left = 0
        Top = 181
        Width = 664
        Height = 266
        Align = alClient
        DataSource = DSourceEndereco
        FixedColor = 13003057
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWhite
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        OnDblClick = GrdEnderecoDblClick
        Columns = <
          item
            Expanded = False
            FieldName = 'TEN_DESCRICAO_A'
            Title.Caption = 'Tipo'
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ENP_CIDADE_A'
            Title.Caption = 'Cidade'
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ENP_ENDERECO_A'
            Title.Caption = 'Endere'#231'o'
            Width = 385
            Visible = True
          end>
      end
      object PanDadosEndereco: TPanel
        Left = 0
        Top = 0
        Width = 664
        Height = 152
        Align = alTop
        BevelInner = bvSpace
        BevelOuter = bvLowered
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object LblTipoEndereco: TLabel
          Left = 9
          Top = 9
          Width = 24
          Height = 13
          Caption = 'Tipo:'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object LblEndereco: TLabel
          Left = 177
          Top = 9
          Width = 49
          Height = 14
          Caption = 'Endereco:'
        end
        object LblComplemento: TLabel
          Left = 9
          Top = 38
          Width = 67
          Height = 14
          Caption = 'Complemento:'
        end
        object LblCidade: TLabel
          Left = 105
          Top = 67
          Width = 36
          Height = 14
          Caption = 'Cidade:'
        end
        object LblCelular: TLabel
          Left = 9
          Top = 96
          Width = 36
          Height = 14
          Caption = 'Celular:'
        end
        object LblSite: TLabel
          Left = 9
          Top = 126
          Width = 21
          Height = 14
          Caption = 'Site:'
        end
        object LblFax: TLabel
          Left = 169
          Top = 96
          Width = 21
          Height = 14
          Caption = 'Fax:'
        end
        object LblEstado: TLabel
          Left = 9
          Top = 67
          Width = 36
          Height = 14
          Caption = 'Estado:'
        end
        object LblEmail: TLabel
          Left = 305
          Top = 96
          Width = 31
          Height = 14
          Caption = 'E-Mail:'
        end
        object LblCEP: TLabel
          Left = 359
          Top = 67
          Width = 22
          Height = 14
          Caption = 'CEP:'
        end
        object LblBairro: TLabel
          Left = 345
          Top = 38
          Width = 32
          Height = 14
          Caption = 'Bairro:'
        end
        object LblTelefoneEndereco: TLabel
          Left = 489
          Top = 67
          Width = 45
          Height = 14
          Caption = 'Telefone:'
        end
        object CmbTipoEndereco: TComboBox
          Left = 40
          Top = 5
          Width = 129
          Height = 21
          Style = csDropDownList
          Color = clWhite
          Enabled = False
          Font.Charset = ANSI_CHARSET
          Font.Color = clBlack
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ItemHeight = 0
          ParentFont = False
          TabOrder = 0
        end
        object TxtEndereco: TEdit
          Left = 232
          Top = 5
          Width = 424
          Height = 22
          CharCase = ecUpperCase
          Color = clWhite
          TabOrder = 1
        end
        object TxtComplemento: TEdit
          Left = 80
          Top = 34
          Width = 257
          Height = 22
          CharCase = ecUpperCase
          Color = clWhite
          TabOrder = 2
        end
        object CmbCidade: TComboBox
          Left = 144
          Top = 64
          Width = 201
          Height = 22
          CharCase = ecUpperCase
          Color = clWhite
          ItemHeight = 0
          TabOrder = 5
        end
        object MskCelular: TMaskEdit
          Left = 55
          Top = 93
          Width = 100
          Height = 22
          Hint = 'Informe o telefone para contato (opcional).'
          BiDiMode = bdRightToLeft
          Color = clWhite
          EditMask = '(9999) 9999-9999;0; '
          MaxLength = 16
          ParentBiDiMode = False
          TabOrder = 8
        end
        object TxtSite: TEdit
          Left = 56
          Top = 123
          Width = 601
          Height = 22
          Color = clWhite
          TabOrder = 11
        end
        object MskFax: TMaskEdit
          Left = 199
          Top = 93
          Width = 100
          Height = 22
          Hint = 'Informe o telefone para contato (opcional).'
          BiDiMode = bdRightToLeft
          Color = clWhite
          EditMask = '(9999) 9999-9999;0; '
          MaxLength = 16
          ParentBiDiMode = False
          TabOrder = 9
        end
        object CmbEstado: TComboBox
          Left = 56
          Top = 64
          Width = 41
          Height = 22
          Style = csDropDownList
          CharCase = ecUpperCase
          Color = clWhite
          ItemHeight = 0
          TabOrder = 4
          OnChange = CmbEstadoChange
        end
        object TxtEmail: TEdit
          Left = 344
          Top = 93
          Width = 313
          Height = 22
          Color = clWhite
          TabOrder = 10
        end
        object MskCep: TMaskEdit
          Left = 392
          Top = 64
          Width = 83
          Height = 22
          Color = clWhite
          EditMask = '99999\-999;0; '
          MaxLength = 9
          TabOrder = 6
        end
        object TxtBairro: TEdit
          Left = 381
          Top = 34
          Width = 274
          Height = 22
          CharCase = ecUpperCase
          Color = clWhite
          TabOrder = 3
        end
        object MskTelefoneEndereco: TMaskEdit
          Left = 543
          Top = 64
          Width = 113
          Height = 22
          Hint = 'Informe o telefone para contato (opcional).'
          BiDiMode = bdRightToLeft
          Color = clWhite
          EditMask = '(9999) 9999-9999;0; '
          MaxLength = 16
          ParentBiDiMode = False
          TabOrder = 7
        end
      end
      object PanEndBtn: TPanel
        Left = 0
        Top = 152
        Width = 664
        Height = 29
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object ActionToolBar1: TActionToolBar
          Left = 0
          Top = 0
          Width = 664
          Height = 28
          ActionManager = ActCadastro
          Caption = 'ActionToolBar1'
          ColorMap.HighlightColor = 14410210
          ColorMap.BtnSelectedColor = clBtnFace
          ColorMap.UnusedColor = 14410210
          HorzMargin = 5
          Spacing = 80
          VertMargin = 2
        end
      end
    end
    object TabContatos: TTabSheet
      Caption = 'Co&ntatos'
      ImageIndex = 9
      object GrdContato: TDBGrid
        Left = 0
        Top = 116
        Width = 664
        Height = 331
        Align = alClient
        DataSource = DSourceContato
        FixedColor = 13003057
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlack
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        Options = [dgTitles, dgIndicator, dgColumnResize, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ParentFont = False
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWhite
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = [fsBold]
        Columns = <
          item
            Expanded = False
            FieldName = 'PES_NOME_A'
            Title.Caption = 'Nome'
            Width = 390
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COP_FUNCAO_A'
            Title.Caption = 'Fun'#231#227'o'
            Width = 120
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'COP_LOCAL_A'
            Title.Caption = 'Setor'
            Width = 120
            Visible = True
          end>
      end
      object PanDadosContatos: TPanel
        Left = 0
        Top = 0
        Width = 664
        Height = 87
        Align = alTop
        BevelInner = bvSpace
        BevelOuter = bvLowered
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        object Label2: TLabel
          Left = 9
          Top = 35
          Width = 39
          Height = 13
          Caption = 'Fun'#231#227'o:'
        end
        object Label3: TLabel
          Left = 20
          Top = 59
          Width = 30
          Height = 13
          Caption = 'Setor:'
        end
        object Label4: TLabel
          Left = 9
          Top = 11
          Width = 43
          Height = 13
          Caption = 'Contato:'
        end
        object BtnContato: TSpeedButton
          Left = 117
          Top = 6
          Width = 23
          Height = 22
          Enabled = False
          Flat = True
          Glyph.Data = {
            36060000424D3606000000000000360400002800000020000000100000000100
            08000000000000020000C40E0000C40E00000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0CA
            A6000020400000206000002080000020A0000020C0000020E000004000000040
            20000040400000406000004080000040A0000040C0000040E000006000000060
            20000060400000606000006080000060A0000060C0000060E000008000000080
            20000080400000806000008080000080A0000080C0000080E00000A0000000A0
            200000A0400000A0600000A0800000A0A00000A0C00000A0E00000C0000000C0
            200000C0400000C0600000C0800000C0A00000C0C00000C0E00000E0000000E0
            200000E0400000E0600000E0800000E0A00000E0C00000E0E000400000004000
            20004000400040006000400080004000A0004000C0004000E000402000004020
            20004020400040206000402080004020A0004020C0004020E000404000004040
            20004040400040406000404080004040A0004040C0004040E000406000004060
            20004060400040606000406080004060A0004060C0004060E000408000004080
            20004080400040806000408080004080A0004080C0004080E00040A0000040A0
            200040A0400040A0600040A0800040A0A00040A0C00040A0E00040C0000040C0
            200040C0400040C0600040C0800040C0A00040C0C00040C0E00040E0000040E0
            200040E0400040E0600040E0800040E0A00040E0C00040E0E000800000008000
            20008000400080006000800080008000A0008000C0008000E000802000008020
            20008020400080206000802080008020A0008020C0008020E000804000008040
            20008040400080406000804080008040A0008040C0008040E000806000008060
            20008060400080606000806080008060A0008060C0008060E000808000008080
            20008080400080806000808080008080A0008080C0008080E00080A0000080A0
            200080A0400080A0600080A0800080A0A00080A0C00080A0E00080C0000080C0
            200080C0400080C0600080C0800080C0A00080C0C00080C0E00080E0000080E0
            200080E0400080E0600080E0800080E0A00080E0C00080E0E000C0000000C000
            2000C0004000C0006000C0008000C000A000C000C000C000E000C0200000C020
            2000C0204000C0206000C0208000C020A000C020C000C020E000C0400000C040
            2000C0404000C0406000C0408000C040A000C040C000C040E000C0600000C060
            2000C0604000C0606000C0608000C060A000C060C000C060E000C0800000C080
            2000C0804000C0806000C0808000C080A000C080C000C080E000C0A00000C0A0
            2000C0A04000C0A06000C0A08000C0A0A000C0A0C000C0A0E000C0C00000C0C0
            2000C0C04000C0C06000C0C08000C0C0A000F0FBFF00A4A0A000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FDA4A3A4FDFD
            FDFDFDFDFDFDFDFDFDFDFDA4A4A4FDFDFDFDFDFDFDFDFDFDFDFDFDAEAF9CA4FD
            FDFDFDFDFDFDFDFDFDFDFDA407A4A4FDFDFDFDFDFDFDFDFDFDFDFDBF77A79CA4
            FDFDFDFDFDFDFDFDFDFDFD07FBA4A4A4FDFDFDFDFDFDFDFDFDFDFDFDBF77A79C
            A4FDFDFDFDFDFDFDFDFDFDFD07FBA4A4A4FDFDFDFDFDFDFDFDFDFDA4A4AE77A6
            9BA4A3A4A4A4A4A4A4FDFDA4A4A4FBA4A4A4A4A4A4A4A4A4A4FDFDDADADAB7B6
            EC09FFFFFFA4A4EC91FDFD0707070707A407FFFFFFA4A4A407FDFD04F6F6F6A4
            0909F6F6F6FFA4F604FDFD07FFFFFFA40707FFFFFFFFA4FF07FDFD04F60808A4
            09090808F6FFA4F704FDFD07FF0707A407070707FFFFA40707FDFD04F60808A4
            09F5080808F6F5F704FDFD07FF0707A40707070707FF070707FDFD04F60808A4
            0909090909FFEC0804FDFD07FF0707A40707070707FFA40707FDFD04F6080807
            07F609090909F7FF04FDFD07FF07070707FF0707070707FF07FDFD04F6080808
            0707090909ED08FF04FDFD07FF07070707070707070707FF07FDFD04F60808F6
            F607ED0707F6F6FF04FDFD07FF0707FFFF07070707FFFFFF07FDFD04F6F6F6F6
            F6F6F6F6F6F6F6FF04FDFD07FFFFFFFFFFFFFFFFFFFFFFFF07FDFDD9E1E1E1E1
            E1E1E1E1E2E1E2E399FDFD070707070707070707070707A407FDFDE0E1E0E0E0
            E0E0E0E0E0E0E1E2E3FDFD07070707070707070707070707A4FD}
          NumGlyphs = 2
          OnClick = BtnContatoClick
        end
        object LblContato: TLabel
          Left = 149
          Top = 9
          Width = 507
          Height = 13
          AutoSize = False
          Color = 15717318
          ParentColor = False
        end
        object EdFuncao: TEdit
          Left = 56
          Top = 31
          Width = 600
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          TabOrder = 1
        end
        object EdSetor: TEdit
          Left = 56
          Top = 55
          Width = 600
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          TabOrder = 2
        end
        object EdContato: TEdit
          Left = 56
          Top = 7
          Width = 57
          Height = 21
          CharCase = ecUpperCase
          Color = clWhite
          TabOrder = 0
          OnExit = EdContatoExit
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 87
        Width = 664
        Height = 29
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
        object ActionToolBar2: TActionToolBar
          Left = 0
          Top = 0
          Width = 664
          Height = 28
          ActionManager = ActCadastro
          Caption = 'ActionToolBar1'
          ColorMap.HighlightColor = 14410210
          ColorMap.BtnSelectedColor = clBtnFace
          ColorMap.UnusedColor = 14410210
          HorzMargin = 5
          Spacing = 80
          VertMargin = 2
        end
      end
    end
  end
  object PanButtons: TPanel
    Left = 0
    Top = 479
    Width = 672
    Height = 34
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object BtnSalvar: TSpeedButton
      Left = 2
      Top = 1
      Width = 120
      Height = 30
      Action = ActSalvar
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        08000000000040020000220B0000220B00000001000000010000942121009429
        2900943131009C3131009C393900A5393900944242009C424200A5424200AD42
        4200A54A42009C424A009C4A4A00A54A4A00AD4A4A00B54A4A009C525200B552
        5200BD525200C6525200BD5A5A00C65A5A00CE5A5A009C636300A5636300C663
        6300CE6363009C6B6B00B56B6B00BD6B6B00C66B6B00CE6B6B00AD736B00B573
        6B009C737300A5737300B5737300BD737300C6737300CE737300B5847300A57B
        7B00AD7B7B00BD7B7B00C67B7B00CE7B7B00A5848400B5848400BD848400C684
        8400B58C8400A58C8C00AD8C8C00B58C8C00C68C8C00CE8C8C00BD949400D694
        94009C9C9C00BD9C9C00C69C9C00CE9C9C00CEA59C00ADA5A500CEA5A500D6A5
        A500C6ADAD00CEADAD00D6ADAD00B5B5B500BDB5B500DEB5B500BDBDB500B5BD
        BD00BDBDBD00D6BDBD00DEBDBD00C6C6C600CEC6C600DEC6C600E7C6C600C6CE
        CE00CECECE00D6CECE00DECECE00D6D6D600DEDED600DEDEDE00E7DEDE00E7E7
        DE00EFE7DE00E7E7E700EFE7E700F7E7E700EFEFE700F7EFE700EFEFEF00F7EF
        EF00F7F7EF00F7F7F700FFF7F700FFFFF700FF00FF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00666620100C10
        0C2345454546464545454523060C0C0C0C6666281E19191A111B455259606262
        5C58572401020414190C66281E1A1A1A141B332F43546265635E5B2401020415
        190C66281E1A1A1A14222904213C5C636462602B01020415190C66281E1A1A1A
        14232E02072456606364632B01020415190C66281E1A1A1A14233402020C4D59
        6064672C01020415190C66281E1A1A1A112A350101023F525961673101020415
        190C66281E1A1A1A112A421818173A455560673101020414190C66281E1A1A1A
        1424413C3B3834343C44502608090E19190C66281E1A1A1A1A1A1A1A1A1A1A1A
        1919191A1A1A1A1A190C66281E1914191E2727272727272727272727272D1F1A
        190C66281E0E0A1C36434B4B4B4B4B4B4B4B4B4B4B4F371A190C66281E093D62
        616161616161616161616161615C3715190C66281E0940676363636363636363
        63636363645C3714190C66281E094067616161616161616161616161635C3714
        190C66281E0940675B4E5252525252525252524D585C3714190C66281E094067
        615C5C5C5C5C5C5C5C5C5C5C615C3714190C66281E0940675C53535353535353
        535353525B5C3714190C66281E0940675E5858585858585858585858605C3714
        190C66281E0940675E5858585858585858585858605C3714190C66281E094067
        5B52535353535353535353525B5C3714190C66281E0940676464646464646464
        64646464645C3715190C66281D093D605C5C5C5C5C5C5C5C5C5C5C5C5E583611
        140C6666200832514D4D4D4D4D4D4D4D4D4D4D4D4D4E2F060C66}
      ParentFont = False
    end
    object BtnExcluir: TSpeedButton
      Left = 138
      Top = 1
      Width = 120
      Height = 30
      Action = ActExcluir
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000120B0000120B00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFF2BC85F4C490F4C997F4C794
        F3C38FF4BF88F2BE87F3C089F2BE87F2BE87F2BE87FF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFF8D9ACFBE9C2FB
        E9C2FAE0B6F7D6A8F4CB99F3C18CF3C089F5C793F6CE9DF7D2A2F5CD9CF3C08B
        F2BE87FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFBE9
        C2FFFDDEFEF9D9FCEBC6FAE0B6F6D5A7F9CD9DF7C28EF4BF88FFCDA2FFD8B3FF
        E2BFFFE9C4FCEBC6F6CF9EF2BE87FF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFDF5D3FFFFE1FEF6D5FCEBC5FAE0B6FAD7AADBD09CE9CFA1F7CE
        A596BF7073B85C9AC77DEEE8C4FFF9DAFFF8D6F5CB9AF2BE87FF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFF8DBAFFFFFE2FEF9D9FBEBC6F9E0B7FFD9B0
        B7CA894AAE4056B04600940000920000910034A92FDDEBC4FFFFE7FAE3BBF2BE
        87FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFF2BD86F2BB83F7D6A8FEF5D3FD
        F3D0F9E3B9FFD7ACC9CE940398060094000397030C990A1BA018008F004CB447
        FCFDE7FBDEB4F2BE87FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFF2BD86F2BC
        85F1B981F3C48FF8DDB2FBE9C2FFE6C1D5D9A70F9B0E009400169D14C2E3BDF0
        F8EEF2BE87079908AECF8DFEC799F2BE87F2BE87FF00FFFF00FFFF00FFFF00FF
        FF00FFF2BF89F3C08BF2BF89F2BC85F2BB83F3C089FACC9DDDD8A90799080091
        0000920087CC84FCFEFBFFFFFF95D29265AF48FBC596F2BC85F2BE87FF00FFFF
        00FFFF00FFFF00FFFF00FFF5C593F6C798F5C696F5C594F5C391F4C28FF7BF8B
        EACB9E60BA5B60BB5D6AC06781C77BEDF6E9FFFFFFFFFFFFC2D8AAEBC28DF2BC
        85F2BE87FF00FFFF00FFFF00FFFF00FFF2BE87F8CEA3F9CFA6F9CEA4F8CDA2F8
        CCA0F7CB9EF9CA9CE9D3A9FBF8F1FFFFFFFFFFFFF2F7EED6ECD2CEE9CBC2E4BF
        D4DDB6F6C695F2BD86F2BE87FF00FFFF00FFFF00FFFF00FFF5C391FCD7B5FCD7
        B5FCD5B2FBD5B0FBD3AEFAD2ADFFD3ADD7D1A27CC676FFFFFFFFFFFFB6DFB21C
        9F190998080094005DB149FED0AAF4C18CF4C18CFF00FFFF00FFFF00FFFF00FF
        F7CEA2FEE1C3FDDEBFFDDDBDFDDBBBFDDBBBFDDBBBFFD9B9F9DFC337A82E80C9
        7DFFFFFFFFFFFF9BD39600940000940051B044FED8B7F7C595F7C595FF00FFFF
        00FFFF00FFFF00FFFBDCB6FFE9CBFEE6C7FEE5C6FEE4C5FEE3C4FEE2C3FEE0C0
        FFE6D0A2CD8B00920052B54D7CC77935AA3305960400940048AE3EFDDFC4FACC
        A1FACCA1F2BE87FF00FFFF00FFF3C38DFEEDCDFEF1D2FEEFD0FEEECEFEEDCDFE
        EBCCFEEBCCFEEACAFFE9CBFCEED753B44A008C00008F00009400009400179E15
        3DAC37FAE5CBFDD5AFFDD5AFF2BE87FF00FFFF00FFF6CD9CFFF9DAFFF9DAFFF8
        D8FFF5D6FFF5D5FFF4D4FFF3D4FFF2D3FEF1D1FFF1D6EEEED06DBF6324A22114
        9D1359B750D6E6C296CD86F2E9C9FFE0BDFFE0BDF2BE87FF00FFFF00FFF8DBAF
        FFFFE2FFFCDDFFFCDDFFFCDDFFFCDDFFFADCFFFADBFFFADBFFF9DAFFF8D8FFFA
        DCFFFAE3F4F4D8EFF2D3FFF6DEFFF5DBFFF5DBFDF1D4FDECCAFDECCAF2BE87FF
        00FFFF00FFFBE9C2FFFFE2FFFCDDFFFCDDFFFCDDFFFCDDFFFCDDFFFCDDFFFCDD
        FFFCDDFFFDDEFFFEDFFFFFE2FFFFE4FFFFE2FFFFE2FFFDDEFFFADBFFF9DAFEF6
        D5FEF6D5F5C793FF00FFFF00FFFCEFCCFFFFE2FFFCDDFFFCDDFFFCDDFFFCDDFF
        FDDEFFFDDEFFFEDFFFFFE2FFFFE2FDF5D3F9DEAEF7D199F7D199F8DBAAFCECC6
        FFF8D8FFFFE1FFFEDFFFFEDFF6CE9DFF00FFFF00FFF7D6A8FEFCDDFFFFE2FFFF
        E1FFFEDFFFFDDEFFFCDDFEF9D9FCF0CAFAE2B5F6CE96F2BA77F0B169F0B169F0
        B169F0B574F3C089FACF9FFDE2BAFFF5D5FFF5D5F6D5A7FF00FFFF00FFFF00FF
        F4C997F8D9ACF7D7AAF7D3A5F6D0A1F5CC9BF3C38DF2BB7FF1B777F1B473F1B5
        70F1B56FF1B56FF1B674F2BC83F6C592FACC9DFBCB9CFCD1A3F9CD9DFACC9DFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFF1B670F2BA7CF4C18CFACB9BFBCEA0FBCE9FFBCD
        9EFBCD9EFACC9DFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFF7C693FBCE9F
        FBCE9FFBCE9FFBCE9FFBCE9FFBCEA0FF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFBCE9FFBCE9FFBCE9FFBCE9FFF00FFFF00FF}
      ParentFont = False
    end
    object BtnCancelar: TSpeedButton
      Left = 546
      Top = 1
      Width = 120
      Height = 30
      Action = ActCancelar
      Flat = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      Glyph.Data = {
        76060000424D7606000000000000360400002800000018000000180000000100
        08000000000040020000220B0000220B000000010000000100000031DE00FF00
        FF000031FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010100000101010101010101010101010101010101010101010000
        0001010100000001010101010101010101010101010000000101010100000000
        0101010101010101010101000000000101010101000000000001010101010101
        0101000000000101010101010100000000000101010101010100000000010101
        0101010101010200000000010101010100000000010101010101010101010101
        0000000001010000000000010101010101010101010101010100000000000000
        0000010101010101010101010101010101010000020002000001010101010101
        0101010101010101010101000000020001010101010101010101010101010101
        0101000002000002020101010101010101010101010101010100000200020202
        0002010101010101010101010101010102020200020101020202020101010101
        0101010101010102020002020101010102020202010101010101010101010202
        0202020101010101010102020201010101010101010202020202010101010101
        0101010202020101010101010202020202010101010101010101010101020101
        0101010202020202010101010101010101010101010101010101010202020201
        0101010101010101010101010101010101010102020201010101010101010101
        0101010101010101010101010101010101010101010101010101010101010101
        0101010101010101010101010101010101010101010101010101}
      ParentFont = False
    end
  end
  object ActCadastro: TActionManager
    ActionBars = <
      item
        Items = <
          item
            Action = ActEndNovo
            ImageIndex = 4
          end
          item
            Action = ActEndEditar
            Caption = '&Editar'
            ImageIndex = 10
          end
          item
            Action = ActEndSalvar
            ImageIndex = 7
          end
          item
            Action = ActEndExcluir
            ImageIndex = 2
          end
          item
            Action = ActEndCancelar
            ImageIndex = 5
          end>
      end
      item
        Items = <
          item
            Action = ActEndNovo
            Caption = '&Novo'
            ImageIndex = 4
          end
          item
            Action = ActEndEditar
            Caption = '&Editar'
            ImageIndex = 10
          end
          item
            Action = ActEndSalvar
            Caption = '&Salvar'
            ImageIndex = 7
          end
          item
            Action = ActEndExcluir
            Caption = 'E&xcluir'
            ImageIndex = 2
          end
          item
            Action = ActEndCancelar
            Caption = '&Cancelar'
            ImageIndex = 5
          end>
        ActionBar = ActionToolBar1
      end
      item
        Items = <
          item
            Action = ActConNovo
            Caption = '&Novo'
            ImageIndex = 4
          end
          item
            Action = ActConEditar
            Caption = '&Editar'
            ImageIndex = 10
          end
          item
            Action = ActConSalvar
            Caption = '&Salvar'
            ImageIndex = 7
          end
          item
            Action = ActConExcluir
            Caption = 'E&xcluir'
            ImageIndex = 2
          end
          item
            Action = ActConCancelar
            Caption = '&Cancelar'
            ImageIndex = 5
          end>
        ActionBar = ActionToolBar2
      end>
    Images = fMain.ImgMain
    Left = 580
    Top = 425
    StyleName = 'XP Style'
    object ActConSalvar: TAction
      Category = 'Contato'
      Caption = 'Salvar'
      ImageIndex = 7
      OnExecute = ActConSalvarExecute
    end
    object ActConExcluir: TAction
      Category = 'Contato'
      Caption = 'Excluir'
      ImageIndex = 2
      OnExecute = ActConExcluirExecute
    end
    object ActConNovo: TAction
      Category = 'Contato'
      Caption = 'Novo'
      ImageIndex = 4
      OnExecute = ActConNovoExecute
    end
    object ActConCancelar: TAction
      Category = 'Contato'
      Caption = 'Cancelar'
      ImageIndex = 5
      OnExecute = ActConCancelarExecute
    end
    object ActConEditar: TAction
      Category = 'Contato'
      Caption = 'Editar'
      ImageIndex = 10
      OnExecute = ActConEditarExecute
    end
    object ActCancelar: TAction
      Caption = '&Cancelar'
      ImageIndex = 5
      ShortCut = 27
      OnExecute = ActCancelarExecute
    end
    object ActSalvar: TAction
      Caption = '&Salvar'
      ImageIndex = 7
      ShortCut = 16467
      OnExecute = ActSalvarExecute
    end
    object ActExcluir: TAction
      Caption = '&Excluir'
      ImageIndex = 2
      OnExecute = ActExcluirExecute
    end
    object ActEndSalvar: TAction
      Category = 'Endereco'
      Caption = 'Salvar'
      ImageIndex = 7
      OnExecute = ActEndSalvarExecute
    end
    object ActEndExcluir: TAction
      Category = 'Endereco'
      Caption = 'Excluir'
      ImageIndex = 2
      OnExecute = ActEndExcluirExecute
    end
    object ActEndNovo: TAction
      Category = 'Endereco'
      Caption = 'Novo'
      ImageIndex = 4
      OnExecute = ActEndNovoExecute
    end
    object ActEndCancelar: TAction
      Category = 'Endereco'
      Caption = 'Cancelar'
      ImageIndex = 5
      OnExecute = ActEndCancelarExecute
    end
    object ActEndEditar: TAction
      Category = 'Endereco'
      Caption = 'Editar'
      ImageIndex = 10
      OnExecute = ActEndEditarExecute
    end
  end
  object DSourceEndereco: TDataSource
    Left = 528
    Top = 296
  end
  object DSourceContato: TDataSource
    Left = 576
    Top = 296
  end
end
