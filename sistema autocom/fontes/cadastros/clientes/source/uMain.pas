unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponent, JvBalloonHint, ImgList, uGlobal, ActnList, XPStyleActnCtrls,
  ActnMan, DB, Grids, DBGrids, ComCtrls, StdCtrls, Mask, ExtCtrls, Buttons, StrUtils;

type
  TLoadData = (Pessoa, Endereco, Cliente);
  TfMain = class(TForm)
    BtnSalvar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    BtnRelatorio: TSpeedButton;
    BtnFechar: TSpeedButton;
    BtnCancelar: TSpeedButton;
    PanCod: TPanel;
    BtnPesquisar: TSpeedButton;
    BtnNovo: TSpeedButton;
    BtnSelectAll: TSpeedButton;
    EdMain: TEdit;
    PgCtrlMain: TPageControl;
    TabPessoa: TTabSheet;
    LblCod: TLabel;
    LblNome: TLabel;
    LblReferencia: TLabel;
    LblRG: TLabel;
    LblTelefone: TLabel;
    LblProfissao: TLabel;
    LblDataNascimento: TLabel;
    LblCPF: TLabel;
    Label10: TLabel;
    Label1: TLabel;
    BtnConsultaPessoa: TSpeedButton;
    Label6: TLabel;
    LblSexo: TLabel;
    EdCodigoPessoa: TMaskEdit;
    EdNome: TEdit;
    EdReferencia: TEdit;
    MskRG: TMaskEdit;
    MskTeleFoneePessoa: TMaskEdit;
    EdProfissao: TEdit;
    MskCPF: TMaskEdit;
    MemObservacoes: TMemo;
    EdCodigoCliente: TMaskEdit;
    CmbPessoa: TComboBox;
    CmbSexo: TComboBox;
    DateNascimento: TDateTimePicker;
    TabEndereco: TTabSheet;
    PanDadosEndereco: TPanel;
    LblTipoEndereco: TLabel;
    LblEndereco: TLabel;
    LblComplemento: TLabel;
    LblCidade: TLabel;
    LblCelular: TLabel;
    LblSite: TLabel;
    LblFax: TLabel;
    LblEstado: TLabel;
    LblEmail: TLabel;
    LblCEP: TLabel;
    LblBairro: TLabel;
    LblTelefoneEndereco: TLabel;
    CmbTipoEndereco: TComboBox;
    TxtEndereco: TEdit;
    TxtComplemento: TEdit;
    CmbCidade: TComboBox;
    MskCelular: TMaskEdit;
    TxtSite: TEdit;
    MskFax: TMaskEdit;
    CmbEstado: TComboBox;
    TxtEmail: TEdit;
    MskCep: TMaskEdit;
    TxtBairro: TEdit;
    MskTelefoneEndereco: TMaskEdit;
    GrdEndereco: TDBGrid;
    TabContatos: TTabSheet;
    GrdContato: TDBGrid;
    GrdPessoa: TDBGrid;
    DSourceGrid: TDataSource;
    DSourceEndereco: TDataSource;
    DSourceContato: TDataSource;
    ActMain: TActionManager;
    ActNovo: TAction;
    ActPesquisar: TAction;
    ActFechar: TAction;
    ActCancelar: TAction;
    ActSalvar: TAction;
    ActExcluir: TAction;
    ActRelatorio: TAction;
    ActSelectAll: TAction;
    ImgMain: TImageList;
    JvBalloonHint: TJvBalloonHint;
    Label5: TLabel;
    CmbControle: TComboBox;
    Label2: TLabel;
    DateUltimoContato: TDateTimePicker;
    DateClienteDesde: TDateTimePicker;
    Label9: TLabel;
    Label3: TLabel;
    DateUltimaAlteracao: TDateTimePicker;
    DatePrevContato: TDateTimePicker;
    Label4: TLabel;
    EdNomePai: TEdit;
    EdNomeMae: TEdit;
    LblMae: TLabel;
    LblPai: TLabel;
    LblComissao: TLabel;
    EdLimite: TEdit;
    procedure ActFecharExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GrdPessoaDblClick(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure GrdEnderecoDblClick(Sender: TObject);
    procedure ActSalvarExecute(Sender: TObject);
    procedure ActSelectAllExecute(Sender: TObject);
    procedure EdMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnConsultaPessoaClick(Sender: TObject);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure ActNovoExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrdPessoaEnter(Sender: TObject);
    procedure GrdPessoaExit(Sender: TObject);
    procedure GrdPessoaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActRelatorioExecute(Sender: TObject);
    procedure EdCodigoPessoaExit(Sender: TObject);
    procedure ActExcluirExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EdLimiteExit(Sender: TObject);
    procedure EdLimiteEnter(Sender: TObject);
  private
    Estado: TDataSetState;
    DsGrid: TDataSet;
    DsEndereco: TDataSet;
    DsContato: TDataSet;
    procedure LoadData(Load: TLoadData; CodigoPessoa: String = '');
    procedure Editando(Status: Boolean = True);
    procedure GeraCodigo(Codigo: Integer = 0);
  public
  end;

var
  fMain: TfMain;

implementation

uses uDm, DateUtils, uConsultaPessoa, uRelatorio;

{$R *.dfm}

procedure TfMain.ActFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TfMain.FormActivate(Sender: TObject);
begin
  ForceDirectories(ExtractFilePath(Application.ExeName) + '\logs');
  LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + 'Abrindo Cadastro de Clientes.');
  EnableFields(False,PanDadosEndereco);
  Editando(FAlse);
  Dm.dbautocom.Close;
  Dm.dbautocom.DatabaseName := LeINI('ATCPLUS','IP_SERVER') + ':' + LeINI('ATCPLUS','PATH_DB');
  Dm.dbautocom.Open;
  Dm.Transaction.Active := True;
  //Carrega Tipos de Pessoa no Combo
  RunSql('SELECT TPE_DESCRICAO_A FROM TIPOPESSOA ORDER BY TPE_DESCRICAO_A',dm.dbautocom, DsGrid);
  While not DsGrid.Eof do
    begin
      CmbPessoa.Items.Add(DsGrid.FieldByName('TPE_DESCRICAO_A').AsString);
      DsGrid.Next;
    end;
  //Carrega Tipo de Endereco no Combo
  RunSql('SELECT TEN_DESCRICAO_A FROM TIPOENDERECO ORDER BY TEN_DESCRICAO_A', dm.dbautocom,DsGrid);
  While not DsGrid.Eof do
    begin
      CmbTipoEndereco.Items.Add(DsGrid.FieldByName('TEN_DESCRICAO_A').AsString);
      DsGrid.Next;
    end;
  //Carrega Dados no Grid
  ActSelectAll.Execute;
end;


procedure TfMain.LoadData(Load: TLoadData; CodigoPessoa: String);
var
  DsAux: TDataSet;
  i: integer;
begin
  if Load = Pessoa then
    begin
      Editando;
      RunSql('SELECT * FROM CLIENTE T INNER JOIN PESSOA P ON (P.PES_CODPESSOA = T.PES_CODPESSOA) WHERE P.PES_CODPESSOA =  ' + CodigoPessoa,dm.dbautocom,DsAux);
      if DsAux.IsEmpty then
        RunSql('SELECT * from PESSOA WHERE PES_CODPESSOA =  ' + CodigoPessoa,dm.dbautocom,DsAux)
      else
        if IsNull(EdCodigoCliente.Text) then
          EdCodigoCliente.Text := DsAux.FieldByName('CodigoCliente').AsString;

      EdCodigoPessoa.Text := DsAux.FieldByName('PES_CODPESSOA').AsString;
      EdNome.Text := DsAux.FieldByName('PES_NOME_A').AsString;
      EdReferencia.Text := DsAux.FieldByName('PES_APELIDO_A').AsString;
      MskRG.Text := DsAux.FieldByName('PES_RG_IE_A').AsString;
      MskCPF.Text := DsAux.FieldByName('PES_CPF_CNPJ_A').AsString;
      EdProfissao.Text := DsAux.FieldByName('PES_PROFISSAO_RAMO_A').AsString;
      MskTeleFoneePessoa.Text := DsAux.FieldByName('TELEFONE1').AsString;
      CmbSexo.ItemIndex := StrToInt(IfThen(DsAux.FieldByName('SEXO').AsString = 'F','2','1'));
      DateNascimento.Date := StrToDateDef('PES_DATANASCIMENTO_D',Date);

      for i := 0 to CmbPessoa.Items.Count do
        begin
          CmbPessoa.ItemIndex := i;
          if CmbPessoa.Text = KeyLookUp('TPE_CODTIPOPESSOA','TPE_DESCRICAO_A','TIPOPESSOA',DsAux.FieldByName('TPE_CODTIPOPESSOA').AsString,Dm.dbautocom)  then Break;
        end;
        if UpperCase(CmbPessoa.Text) = 'JURIDICA' then
          begin
            LblRG.Caption := 'CNPJ:';
            LblCPF.Caption := 'IE:';
            LblProfissao.Caption := 'Cargo:';
            CmbSexo.Visible := False;
            LblSexo.Visible := False;
            LblDataNascimento.Caption := 'Ini. Opera??o:';
            LblMae.Visible := False;
            LblPai.Visible := False;
            EdNomePai.Visible := False;
            EdNomeMae.Visible := False;
          end
        else
          begin
            LblRG.Caption := 'RG:';
            LblCPF.Caption := 'CPF:';
            LblProfissao.Caption := 'Profiss?o:';
            CmbSexo.Visible := True;
            LblSexo.Visible := True;
            LblDataNascimento.Caption := 'Nascimento:';
            LblMae.Visible := True;
            LblPai.Visible := True;
            EdNomePai.Visible := True;
            EdNomeMae.Visible := True;
          end;

      RunSql('SELECT EP.*, TE.TEN_DESCRICAO_A FROM ENDERECOPESSOA EP inner join tipoendereco TE on(TE.TEN_CODTIPOENDERECO = EP.TEN_CODTIPOENDERECO) WHERE PES_CODPESSOA =  ' + CodigoPessoa,dm.dbautocom,DsEndereco);
      DSourceEndereco.DataSet := DsEndereco;
      RunSQL('SELECT * FROM CONTATOPESSOA CP, PESSOA P WHERE CP.PES_CODPESSOA = ' + CodigoPessoa + ' AND P.PES_CODPESSOA = CP.PES_CODPESSOA_CONTATO' ,dm.dbautocom,DsContato);
      DSourceContato.DataSet := DsContato;
    end;

      if Load = Cliente then
        begin
          RunSql('SELECT * FROM CLIENTE T INNER JOIN PESSOA P ON (P.PES_CODPESSOA = T.PES_CODPESSOA) WHERE P.PES_CODPESSOA =  ' + CodigoPessoa,dm.dbautocom,DsAux);
          if DsAux.FieldByName('CONTROLA_PRODCONV').AsString = 'T' then CmbControle.ItemIndex := 0 else CmbControle.ItemIndex := 1;
          EdNomePai.Text := DsAux.FieldByName('NOMEPAI').AsString;
          EdNomeMae.Text := DsAux.FieldByName('NOMEMAE').AsString;
          EdLimite.Text := DsAux.FieldByName('LIMITECREDITO').AsString;
          EdLimiteExit(EdLimite);
          DateUltimoContato.Date := DsAux.FieldByName('ULTIMOCONTATO').AsDateTime;
          DateClienteDesde.Date := DsAux.FieldByName('CLIENTEDESDE').AsDateTime;
          DateUltimaAlteracao.Date := DsAux.FieldByName('ULTIMAALTERACAO').AsDateTime;
          DatePrevContato.Date := DsAux.FieldByName('PREVISAOCONTATO').AsDateTime;
        end;


  if Load = Endereco then
    begin
      EnableFields(True,PanDadosEndereco);
      ZeroMemory(@i,SizeOf(i));
      if DsEndereco.IsEmpty then Exit;
      for i := 0 to CmbTipoEndereco.Items.Count do
        begin
          CmbTipoEndereco.ItemIndex := i;
          if CmbTipoEndereco.Text = DsEndereco.FieldByName('TEN_DESCRICAO_A').AsString then Break;
        end;
          TxtEndereco.Text := DsEndereco.FieldByName('ENP_ENDERECO_A').AsString;
          TxtComplemento.Text := DsEndereco.FieldByName('ENP_COMPLEMENTO_A').AsString;
          TxtBairro.Text := DsEndereco.FieldByName('ENP_BAIRRO_A').AsString;
          MskCep.Text := DsEndereco.FieldByName('ENP_CEP_I').AsString;
          MskTelefoneEndereco.Text := DsEndereco.FieldByName('ENP_TELEFONE_A').AsString;
          MskCelular.Text := DsEndereco.FieldByName('ENP_CELULAR_A').AsString;
          MskFax.Text := DsEndereco.FieldByName('ENP_FAX_A').AsString;
          TxtEmail.Text := DsEndereco.FieldByName('ENP_EMAIL_A').AsString;
          TxtSite.Text := DsEndereco.FieldByName('ENP_SITE_A').AsString;
          CmbEstado.Text := DsEndereco.FieldByName('ENP_ESTADO_A').AsString;
          CmbCidade.Text := DsEndereco.FieldByName('ENP_CIDADE_A').AsString;
    end;
  FreeAndNil(DsAux);
end;

procedure TfMain.GrdPessoaDblClick(Sender: TObject);
begin
  Estado := DsEdit;
  LoadData(Pessoa,DsGrid.FieldByName('PES_CODPESSOA').AsString);
  LoadData(Cliente,DsGrid.FieldByName('PES_CODPESSOA').AsString);
end;

procedure TfMain.Editando(Status: Boolean);
begin
  if Status then
    begin
      PgCtrlMain.Visible := True;
      ActSalvar.Enabled := True;
      if Estado = dsEdit then ActExcluir.Enabled := True else ActExcluir.Enabled := False;
      ActCancelar.Enabled := True;
      ActRelatorio.Enabled := False;
      ActFechar.Enabled := False;
      EdMain.Enabled := False;
      GrdPessoa.Enabled := False;
      GrdPessoa.Repaint;
      FreeAndNil(DsEndereco);
      FreeAndNil(DsContato);
      PgCtrlMain.TabIndex := 0;
      if IsNull(EdLimite.Text) then FormatEdit(EdLimite,CurrencyOut);
    end
  else
    begin
      ClearEdits(Self);
      PgCtrlMain.Visible := False;
      ActSalvar.Enabled := False;
      ActExcluir.Enabled := False;
      ActCancelar.Enabled := False;
      ActRelatorio.Enabled := True;
      ActFechar.Enabled := True;
      EdMain.Enabled := True;
      GrdPessoa.Enabled := True;
      GrdPessoa.Repaint;
      EdMain.SetFocus;
    end;
end;

procedure TfMain.ActCancelarExecute(Sender: TObject);
begin
  Editando(False);
  ClearEdits(Self);
end;

procedure TfMain.GrdEnderecoDblClick(Sender: TObject);
begin
  LoadData(Endereco);
end;

procedure TfMain.ActSalvarExecute(Sender: TObject);
begin
  if IsNull(EdCodigoPessoa.Text) then
    begin
      Application.MessageBox('O campo pessoa n?o pode ficar em branco, Verifique!',Autocom,MB_ICONWARNING);
      EdCodigoPessoa.SetFocus;
      EdCodigoPessoa.SelectAll;
      Abort;
    end
  else
    EdCodigoPessoaExit(Self);

  if Application.MessageBox('Deseja salvar as altera??es?',Autocom,MB_YESNO) = ID_NO then Exit;
  FormatEdit(EdLimite,CurrencyIn);
  case Estado of
    DsInsert:
      begin                       
        try
          RunSQL(' INSERT INTO CLIENTE  ' +
                 ' (CODIGOCLIENTE, PES_CODPESSOA, CLIENTEDESDE, ULTIMOCONTATO, ' +
                 ' PREVISAOCONTATO, ULTIMAALTERACAO, NOMEPAI, NOMEMAE, ' +
                 ' CONTROLA_PRODCONV, LIMITECREDITO, CFG_CODCONFIG) VALUES (' +
                 EdCodigoCliente.Text + ', ' +
                 EdCodigoPessoa.Text + ', ' +
                 QuotedStr(FormatDateTime('mm/dd/yyyy', Date)) + ', ' +
                 QuotedStr(FormatDateTime('mm/dd/yyyy', DateUltimoContato.Date)) + ', ' +
                 QuotedStr(FormatDateTime('mm/dd/yyyy', DatePrevContato.Date)) + ', ' +
                 QuotedStr(FormatDateTime('mm/dd/yyyy', Date)) + ', ' +
                 QuotedStr(EdNomePai.Text) + ', ' +
                 QuotedStr(EdNomeMae.Text) + ', ' +
                 QuotedStr(IfThen(CmbControle.ItemIndex = 0,'T','F')) + ', ' +
                 StringReplace(EdLimite.Text, ',', '.', []) + ', ' +
                 LeINI('Loja','LojaNum') + ')',dm.dbautocom,True);
        except
          Application.MessageBox('Esta pessoa j? est? cadastrada como cliente!',Autocom,MB_ICONWARNING);
          Abort;
        end;
      end;
    dsEdit:
      begin
        try
          RunSQL(' UPDATE CLIENTE SET' +
                 ' PES_CODPESSOA = ' + EdCodigoPessoa.Text + ', ' +
                 ' ULTIMOCONTATO = ' + QuotedStr(FormatDateTime('mm/dd/yyyy', DateUltimoContato.Date)) + ', ' +
                 ' PREVISAOCONTATO = ' + QuotedStr(FormatDateTime('mm/dd/yyyy', DatePrevContato.Date)) + ', ' +
                 ' ULTIMAALTERACAO = ' + QuotedStr(FormatDateTime('mm/dd/yyyy', Date)) + ', ' +
                 ' NOMEPAI = ' + QuotedStr(EdNomePai.Text) + ', ' +
                 ' NOMEMAE = ' + QuotedStr(EdNomeMae.Text) + ', ' +
                 ' CONTROLA_PRODCONV = ' + QuotedStr(IfThen(CmbControle.ItemIndex = 0,'T','F')) + ', ' +
                 ' LIMITECREDITO = ' + StringReplace(EdLimite.Text, ',', '.', []) + 
                 ' WHERE CLI_CODCLIENTE = ' + DsGrid.FieldByName('CLI_CODCLIENTE').AsString,
                 dm.dbautocom,True);
        except
          Application.MessageBox('Esta pessoa j? est? cadastrada como cliente!',Autocom,MB_ICONWARNING);;
          Abort;
        end;
      end;
  end;
  Editando(False);
  ActSelectAll.Execute;
end;

procedure TfMain.ActSelectAllExecute(Sender: TObject);
begin
  RunSql('SELECT T.CodigoCliente, P.PES_NOME_A, T.CLI_CODCLIENTE, T.PES_CODPESSOA FROM CLIENTE  T INNER JOIN PESSOA P ON (P.PES_CODPESSOA = T.PES_CODPESSOA) ORDER BY P.PES_NOME_A', dm.dbautocom,DsGrid);
  DSourceGrid.DataSet := DsGrid;
end;

procedure TfMain.EdMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      begin
        if IsFloat(EdMain.Text) then
          begin
          RunSql('SELECT T.CodigoCliente, P.PES_NOME_A, T.CLI_CODCLIENTE, T.PES_CODPESSOA FROM CLIENTE T INNER JOIN PESSOA P ON (P.PES_CODPESSOA = T.PES_CODPESSOA) WHERE CodigoCliente = ' + EdMain.Text + ' ORDER BY P.PES_NOME_A',dm.dbautocom,DsGrid);
          if not DsGrid.IsEmpty then
            begin
                LoadData(Pessoa,DsGrid.FieldByName('PES_CODPESSOA').AsString);
                LoadData(Cliente,DsGrid.FieldByName('PES_CODPESSOA').AsString);
            end
          else
            begin
              if Application.MessageBox('C?digo n?o encontrado, deseja cadastra-lo?',Autocom,MB_YESNO) = ID_YES then
                begin
                  GeraCodigo(StrToInt(EdMain.Text));
                  Editando;
                end;
            end;
        end
      else
          ActPesquisar.Execute;
      end;
    VK_DOWN: Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TfMain.GeraCodigo(Codigo: Integer);
var
  DsAux: TDataSet;
begin
  Estado := dsInsert;
  if Codigo <> 0 then
    EdCodigoCliente.Text := IntToStr(Codigo)
  else
    begin
      RunSql('Select Max(CodigoCliente) from CLIENTE',dm.dbautocom,DsAux);
      EdCodigoCliente.Text := IntToStr(StrToIntDef(DsAux.Fields[0].AsString,0) + 1);
    end;
    FreeAndNil(DsAux);
end;

procedure TfMain.BtnConsultaPessoaClick(Sender: TObject);
begin
  with TfConsultaPessoa.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  LoadData(Pessoa,EdCodigoPessoa.Text);
end;

procedure TfMain.ActPesquisarExecute(Sender: TObject);
begin
  if IsFloat(EdMain.Text) then
    begin
      RunSql('SELECT T.CodigoCliente, P.PES_NOME_A, T.CLI_CODCLIENTE, T.PES_CODPESSOA FROM CLIENTE T INNER JOIN PESSOA P ON (P.PES_CODPESSOA = T.PES_CODPESSOA) WHERE CodigoCliente = ' + EdMain.Text + ' ORDER BY P.PES_NOME_A',dm.dbautocom,DsGrid);
    end
  else
    begin
      RunSql('SELECT T.CodigoCliente, P.PES_NOME_A, T.CLI_CODCLIENTE, T.PES_CODPESSOA FROM CLIENTE T INNER JOIN PESSOA P ON (P.PES_CODPESSOA = T.PES_CODPESSOA) WHERE P.PES_NOME_A LIKE ' + QuotedStr('%'+EdMain.Text+'%') + ' ORDER BY P.PES_NOME_A',dm.dbautocom,DsGrid);
    end;
    DSourceGrid.DataSet := DsGrid;
end;

procedure TfMain.ActNovoExecute(Sender: TObject);
begin
  GeraCodigo;
  Editando;
end;

procedure TfMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key of
    VK_RETURN: Perform(WM_NEXTDLGCTL,0,0);
    VK_F5: ActSelectAll.Execute;
    VK_F1:
      begin
        if ActiveControl = EdCodigoPessoa then BtnConsultaPessoa.Click;
      end;
  end;
end;

procedure TfMain.GrdPessoaEnter(Sender: TObject);
begin
   KeyPreview := False;
end;

procedure TfMain.GrdPessoaExit(Sender: TObject);
begin
  KeyPreview := True;
end;

procedure TfMain.GrdPessoaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_UP: if DsGrid.RecNo = 1 then Perform(WM_NEXTDLGCTL,1,0);
    VK_RETURN:
      begin
        Editando(True);
          LoadData(Pessoa,DsGrid.FieldByName('PES_CODPESSOA').AsString);
          LoadData(Cliente,DsGrid.FieldByName('PES_CODPESSOA').AsString);
      end;
  end;
end;

procedure TfMain.ActRelatorioExecute(Sender: TObject);
begin
  with TfRelatorio.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
end;

procedure TfMain.EdCodigoPessoaExit(Sender: TObject);
var
  DsAux: TDataSet;
begin
  if IsNull(EdCodigoPessoa.Text) then Exit;
  RunSql('SELECT PES_CODPESSOA FROM PESSOA WHERE PES_CODPESSOA = ' + EdCodigoPessoa.Text,dm.dbautocom,DsAux);
  if DsAux.IsEmpty then
    begin
      Application.MessageBox('C?digo Inv?lido, Verifique!',Autocom,MB_ICONASTERISK);
      EdCodigoPessoa.SetFocus;
      EdCodigoPessoa.SelectAll;
    end
  else
    LoadData(Pessoa,EdCodigoPessoa.Text);
end;

procedure TfMain.ActExcluirExecute(Sender: TObject);
begin
  if Application.MessageBox('Deseja excluir?',Autocom,MB_YESNO) = ID_NO then Exit;
  try
    RunSQL('Delete from Cliente where CLI_CODCLIENTE = ' + DsGrid.FieldByName('CLI_CODCLIENTE').AsString,dm.dbautocom);
    Editando(False);
    ClearEdits(Self);
    ActSelectAll.Execute;
  except
    Application.MessageBox('? imposs?vel excluir este fornecedor cliente!',Autocom,MB_ICONWARNING);
    Abort;
  end;  
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + 'Fechando Cadastro de Clientes.');
end;

procedure TfMain.EdLimiteExit(Sender: TObject);
begin
  FormatEdit(Sender,CurrencyOut);
end;

procedure TfMain.EdLimiteEnter(Sender: TObject);
begin
  FormatEdit(Sender,CurrencyIn);
end;

end.
