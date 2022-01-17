unit uCadastro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, XPStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, DB,
  ExtCtrls, Grids, DBGrids, ComCtrls, StdCtrls, Mask, Buttons, uGlobal,
  StrUtils;

type
  TLoadData = set of (Pessoa, Endereco, Contato);
  TfCadastro = class(TForm)
    PgCtrlMain: TPageControl;
    TabPessoa: TTabSheet;
    LblNome: TLabel;
    LblReferencia: TLabel;
    LblRG: TLabel;
    LblTelefone: TLabel;
    LblProfissao: TLabel;
    LblDataNascimento: TLabel;
    LblCPF: TLabel;
    Label10: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    LblSexo: TLabel;
    EdNome: TEdit;
    EdReferencia: TEdit;
    MskRG: TMaskEdit;
    MskTeleFoneePessoa: TMaskEdit;
    EdProfissao: TEdit;
    MskCPF: TMaskEdit;
    MemObservacoes: TMemo;
    EdCodigo: TMaskEdit;
    CmbPessoa: TComboBox;
    CmbSexo: TComboBox;
    DateNascimento: TDateTimePicker;
    TabEndereco: TTabSheet;
    GrdEndereco: TDBGrid;
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
    PanEndBtn: TPanel;
    ActionToolBar1: TActionToolBar;
    TabContatos: TTabSheet;
    GrdContato: TDBGrid;
    ActCadastro: TActionManager;
    ActConSalvar: TAction;
    ActConExcluir: TAction;
    ActConNovo: TAction;
    ActConCancelar: TAction;
    ActConEditar: TAction;
    ActCancelar: TAction;
    ActSalvar: TAction;
    ActExcluir: TAction;
    ActEndSalvar: TAction;
    ActEndExcluir: TAction;
    ActEndNovo: TAction;
    ActEndCancelar: TAction;
    ActEndEditar: TAction;
    DSourceEndereco: TDataSource;
    DSourceContato: TDataSource;
    PanDadosContatos: TPanel;
    Label2: TLabel;
    EdFuncao: TEdit;
    Label3: TLabel;
    EdSetor: TEdit;
    Label4: TLabel;
    EdContato: TEdit;
    BtnContato: TSpeedButton;
    Panel2: TPanel;
    ActionToolBar2: TActionToolBar;
    PanButtons: TPanel;
    BtnSalvar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    BtnCancelar: TSpeedButton;
    LblContato: TLabel;
    procedure ActSalvarExecute(Sender: TObject);
    procedure ActExcluirExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdCodigoExit(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure ActEndEditarExecute(Sender: TObject);
    procedure GrdEnderecoDblClick(Sender: TObject);
    procedure CmbEstadoChange(Sender: TObject);
    procedure ActEndNovoExecute(Sender: TObject);
    procedure ActConNovoExecute(Sender: TObject);
    procedure ActConEditarExecute(Sender: TObject);
    procedure ActEndCancelarExecute(Sender: TObject);
    procedure ActConCancelarExecute(Sender: TObject);
    procedure ActEndSalvarExecute(Sender: TObject);
    procedure ActEndExcluirExecute(Sender: TObject);
    procedure CmbPessoaChange(Sender: TObject);
    procedure BtnContatoClick(Sender: TObject);
    procedure EdContatoExit(Sender: TObject);
    procedure PgCtrlMainChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActConSalvarExecute(Sender: TObject);
    procedure ActConExcluirExecute(Sender: TObject);
  private
    DsEndereco: TDataSet;
    DsContato: TDataSet;
    procedure LoadData(Load: TLoadData; CodigoPessoa: String = '');
    procedure EditandoEndereco(Status: Boolean = True);
    procedure EditandoContato(Status: Boolean = True);
    procedure ReplicaEndereco;
  public
    Codigo: Real;
    Estado, EstadoEndereco, EstadoContato: TDataSetState;
  end;

var
  fCadastro: TfCadastro;

implementation

uses uMain, uDm, uConsultaPessoa;

{$R *.dfm}

procedure TfCadastro.ActSalvarExecute(Sender: TObject);
var
  DsSave: TDataSet;
begin
  IsEditNull('Nome/Razão Social',EdNome);

  if CmbPessoa.ItemIndex = 0 then
    begin
      if not ValidaCPF(MskCPF.Text) then
        if Application.MessageBox('O CPF Digitado é inválido, deseja corrigi-lo antes de prosseguir?',Autocom,MB_ICONQUESTION+MB_YESNO) = ID_YES then
          begin
            MskCPF.SetFocus;
            MskCPF.SelectAll;
            Abort;
          end
    end
  else
    if not ValidaCnpj(MskRG.Text) then
      begin
        if Application.MessageBox('O CNPJ Digitado é inválido, deseja corrigi-lo antes de prosseguir?',Autocom,MB_ICONQUESTION+MB_YESNO) = ID_YES then
          begin
            MskRG.SetFocus;
            MskRG.SelectAll;
            Abort;
          end;
      end;
    
  if IsNull(EdCodigo.Text) then
    Estado := DsInsert
  else
    begin
      RunSql('SELECT PES_CODPESSOA FROM PESSOA WHERE PES_CODPESSOA = ' + EdCodigo.Text,dm.dbautocom,DsSave);
      if DsSave.IsEmpty then Estado := DsInsert else Estado := DsEdit;
    end;

  if Application.MessageBox('Deseja salvar as alterações?',Autocom,MB_YESNO) = ID_NO then Exit;
  case Estado of
    DsInsert:
      begin
        try
          RunSql('INSERT INTO PESSOA (TPE_CODTIPOPESSOA, PES_NOME_A, PES_APELIDO_A, PES_RG_IE_A, ' +
                 'PES_CPF_CNPJ_A, TELEFONE1, PES_DATANASCIMENTO_D, ' +
                 'PES_PROFISSAO_RAMO_A, SEXO, PES_OBSERVACOES_T) VALUES (' +
                 KeyLookUp('TPE_DESCRICAO_A','TPE_CODTIPOPESSOA','TIPOPESSOA',QuotedStr(CmbPessoa.Text),dm.dbautocom) + ', ' +
                 QuotedStr(EdNome.Text) + ', ' +
                 QuotedStr(EdReferencia.Text) + ', ' +
                 QuotedStr(MskRG.Text) + ', ' +
                 QuotedStr(MskCPF.Text) + ', ' +
                 QuotedStr(MskTeleFoneePessoa.Text) + ', ' +
                 QuotedStr(FormatDateTime('mm/dd/yyyy',DateNascimento.Date)) + ', ' +
                 QuotedStr(EdProfissao.Text) + ', ' +
                 QuotedStr(Copy(CmbSexo.Text,1,1)) + ', ' +
                 QuotedStr(MemObservacoes.Text) + ')',dm.dbautocom,True);
        except
          Application.MessageBox('Ocorreu um erro na tentativa de salvar!',Autocom,MB_ICONWARNING);
          Abort;
        end;
      end;
    dsEdit:
      begin
        try
          RunSQL(' UPDATE PESSOA SET' +
                 ' TPE_CODTIPOPESSOA = ' + KeyLookUp('TPE_DESCRICAO_A','TPE_CODTIPOPESSOA','TIPOPESSOA',QuotedStr(CmbPessoa.Text),dm.dbautocom) + ', ' +
                 ' PES_NOME_A = ' + QuotedStr(EdNome.Text) + ', ' +
                 ' PES_APELIDO_A = ' + QuotedStr(EdReferencia.Text) + ', ' +
                 ' PES_RG_IE_A = ' + QuotedStr(MskRG.Text) + ', ' +
                 ' PES_CPF_CNPJ_A = ' + QuotedStr(MskCPF.Text) + ', ' +
                 ' TELEFONE1 = ' + QuotedStr(MskTeleFoneePessoa.Text) + ', ' +
                 ' PES_DATANASCIMENTO_D = ' + QuotedStr(FormatDateTime('mm/dd/yyyy',DateNascimento.Date)) + ', ' +
                 ' PES_PROFISSAO_RAMO_A = ' + QuotedStr(EdProfissao.Text) + ', ' +
                 ' SEXO = ' + QuotedStr(Copy(CmbSexo.Text,1,1)) + ', ' +
                 ' PES_OBSERVACOES_T = ' + QuotedStr(MemObservacoes.Text) +
                 ' WHERE PES_CODPESSOA = ' + EdCodigo.Text,
                 dm.dbautocom,True);
        except
          Application.MessageBox('Esta pessoa já está cadastrada como fornecedor!',Autocom,MB_ICONWARNING);;
          Abort;
        end;
      end;
  end;
  Close;
end;

procedure TfCadastro.ActExcluirExecute(Sender: TObject);
begin
  if Application.MessageBox('Deseja excluir?',Autocom,MB_YESNO) = ID_NO then Exit;
  try
    LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + 'Excluindo Pessoa... ' + QuotedStr(EdCodigo.Text) + '!');
    RunSQL('Delete from Pessoa where PES_CODPESSOA = ' + EdCodigo.Text,dm.dbautocom,True);
    ClearEdits(Self);
    Close;
  except
    LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + 'Impossível Excluir!!! ' + QuotedStr(EdCodigo.Text) + '!');
    Application.MessageBox('Impossível Excluir!',Autocom,MB_ICONERROR);
    Abort;
  end;
end;

procedure TfCadastro.LoadData(Load: TLoadData; CodigoPessoa: String);
var
  DsAux: TDataSet;
  i: integer;
begin
  if Pessoa in Load then
    begin
      LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - **** ' + 'Carregando Dados da Pessoa ' + QuotedStr(CodigoPessoa) + '!');
      RunSql('SELECT * FROM PESSOA WHERE PES_CODPESSOA =  ' + CodigoPessoa,dm.dbautocom,DsAux);
      EdCodigo.Text := DsAux.FieldByName('PES_CODPESSOA').AsString;
      EdNome.Text := DsAux.FieldByName('PES_NOME_A').AsString;
      EdReferencia.Text := DsAux.FieldByName('PES_APELIDO_A').AsString;
      MskRG.Text := DsAux.FieldByName('PES_RG_IE_A').AsString;
      MskCPF.Text := DsAux.FieldByName('PES_CPF_CNPJ_A').AsString;
      EdProfissao.Text := DsAux.FieldByName('PES_PROFISSAO_RAMO_A').AsString;
      MskTeleFoneePessoa.Text := DsAux.FieldByName('TELEFONE1').AsString;
      CmbSexo.ItemIndex := StrToInt(IfThen(DsAux.FieldByName('SEXO').AsString = 'F','1','0'));
      DateNascimento.Date := DsAux.FieldByName('PES_DATANASCIMENTO_D').AsDateTime;
      MemObservacoes.Text := DsAux.FieldByName('PES_OBSERVACOES_T').AsString;
      for i := 0 to CmbPessoa.Items.Count do
        begin
          CmbPessoa.ItemIndex := i;
          if CmbPessoa.Text = KeyLookUp('TPE_CODTIPOPESSOA','TPE_DESCRICAO_A','TIPOPESSOA',DsAux.FieldByName('TPE_CODTIPOPESSOA').AsString,dm.dbautocom) then Break;
        end;
      CmbPessoaChange(Self);
      RunSql('SELECT EP.*, TE.TEN_DESCRICAO_A FROM ENDERECOPESSOA EP inner join tipoendereco TE on(TE.TEN_CODTIPOENDERECO = EP.TEN_CODTIPOENDERECO) WHERE PES_CODPESSOA =  ' + CodigoPessoa,dm.dbautocom, DsEndereco);
      DSourceEndereco.DataSet := DsEndereco;
      RunSQL('SELECT * FROM CONTATOPESSOA CP, PESSOA P WHERE CP.PES_CODPESSOA = ' + CodigoPessoa + ' AND P.PES_CODPESSOA = CP.PES_CODPESSOA_CONTATO' ,dm.dbautocom,DsContato);
      DSourceContato.DataSet := DsContato;
    end;
  if Endereco in Load then
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
          ZeroMemory(@i,SizeOf(i));
          for i := 0 to CmbEstado.Items.Count do
            begin
              CmbEstado.ItemIndex := i;
              if CmbEstado.Text = DsEndereco.FieldByName('ENP_ESTADO_A').AsString then break;
            end;
          CmbEstadoChange(Self);
          CmbCidade.Text := DsEndereco.FieldByName('ENP_CIDADE_A').AsString;
    end;
  if Contato in Load then
    begin
      EnableFields(True,PanDadosContatos);
      EdContato.Text := DsContato.FieldByName('PES_CODPESSOA_CONTATO').AsString;
      EdContatoExit(EdContato);
      EdFuncao.Text := DsContato.FieldByName('COP_FUNCAO_A').AsString;
      EdSetor.Text := DsContato.FieldByName('COP_LOCAL_A').AsString;
    end;    
  FreeAndNil(DsAux);
end;

procedure TfCadastro.FormShow(Sender: TObject);
var
  DsAux: TDataSet;
begin
  EditandoEndereco(False);
  EditandoContato(False);
  ClearEdits(Self);
  ComboGet('select codigoestado from estado order by codigoestado',CmbEstado,dm.dbautocom);
  ComboGet('SELECT TPE_DESCRICAO_A FROM TIPOPESSOA ORDER BY TPE_DESCRICAO_A',CmbPessoa,dm.dbautocom);
  ComboGet('SELECT TEN_DESCRICAO_A FROM TIPOENDERECO ORDER BY TEN_DESCRICAO_A',CmbTipoEndereco,dm.dbautocom);
  EnableFields(False,PanDadosEndereco);
  EnableFields(False,PanDadosContatos);

  if Codigo = 0 {cria código posteriormente por Generator} then
    EdCodigo.Clear
  else
    begin
      RunSql('SELECT PES_CODPESSOA FROM PESSOA WHERE PES_CODPESSOA = ' + FloatToStr(Codigo),dm.dbautocom,DsAux);
      if DsAux.IsEmpty then
        Estado := DsInsert
      else
        begin
          Estado := DsEdit;
          LoadData([Pessoa],FloatToStr(Codigo));
        end;
    end;
  FreeAndNil(DsAux);
  PgCtrlMain.TabIndex := 0;
end;

procedure TfCadastro.EdCodigoExit(Sender: TObject);
var
  DsAux: TDataSet;
begin
  if IsNull(EdCodigo.Text) then Exit;
  RunSql('SELECT PES_CODPESSOA FROM PESSOA WHERE PES_CODPESSOA = ' + EdCodigo.Text,dm.dbautocom,DsAux);
  if DsAux.IsEmpty then
    begin
      Application.MessageBox('Código Inválido, Verifique!',Autocom,MB_ICONASTERISK);
      EdCodigo.SetFocus;
      EdCodigo.SelectAll;
    end
  else
    LoadData([Pessoa],EdCodigo.Text);
end;

procedure TfCadastro.ActCancelarExecute(Sender: TObject);
begin
  Close;
end;

procedure TfCadastro.ActEndEditarExecute(Sender: TObject);
begin
  EstadoEndereco := DsEdit;
  LoadData([Endereco],EdCodigo.Text);
  EditandoEndereco;
end;

procedure TfCadastro.GrdEnderecoDblClick(Sender: TObject);
begin
  ActEndEditar.Execute;
end;

procedure TfCadastro.CmbEstadoChange(Sender: TObject);
begin
  ComboGet('select distinct nome from cidade c inner join estado e on (c.est_codestado = e.est_codestado) where e.codigoestado = ' + QuotedStr(CmbEstado.Text) + ';',CmbCidade,dm.dbautocom);
end;

procedure TfCadastro.ActEndNovoExecute(Sender: TObject);
begin
  EstadoEndereco := DsInsert;
  EditandoEndereco;
end;

procedure TfCadastro.ActConNovoExecute(Sender: TObject);
begin
  EstadoContato := DsInsert;
  EditandoContato;
end;

procedure TfCadastro.ActConEditarExecute(Sender: TObject);
begin
  EstadoContato := DsEdit;
  LoadData([Contato]);
  EditandoContato;    
end;

procedure TfCadastro.ActEndCancelarExecute(Sender: TObject);
begin
  EstadoEndereco := dsBrowse;
  EditandoEndereco(False);
end;

procedure TfCadastro.ActConCancelarExecute(Sender: TObject);
begin
  EstadoContato := dsBrowse;
  EditandoContato(False);
end;

procedure TfCadastro.ActEndSalvarExecute(Sender: TObject);
begin
  if EstadoEndereco = dsInsert then
    begin
      LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + 'Inserindo Endereço...!');
      RunSql(' INSERT INTO ENDERECOPESSOA (' +
             ' PES_CODPESSOA, TEN_CODTIPOENDERECO, ENP_ENDERECO_A, ' +
             ' ENP_BAIRRO_A, ENP_COMPLEMENTO_A, ENP_CEP_I, ENP_CIDADE_A, ' +
             ' ENP_ESTADO_A, ENP_TELEFONE_A, ENP_FAX_A, ENP_CELULAR_A, ' +
             ' ENP_EMAIL_A, ENP_SITE_A, CID_CODCIDADE) VALUES (' +
             EdCodigo.Text + ', ' +
             KeyLookUp('TEN_DESCRICAO_A','TEN_CODTIPOENDERECO','TIPOENDERECO',QuotedStr(CmbTipoEndereco.Text),dm.dbautocom)  + ', ' +
             SqlStringTest(QuotedStr(TxtEndereco.Text))  + ', ' +
             SqlStringTest(QuotedStr(TxtBairro.Text))  + ', ' +
             SqlStringTest(QuotedStr(TxtComplemento.Text))  + ', ' +
             SqlStringTest(QuotedStr(MskCep.Text))  + ', ' +
             SqlStringTest(QuotedStr(CmbCidade.Text))  + ', ' +
             SqlStringTest(QuotedStr(CmbEstado.Text))  + ', ' +
             SqlStringTest(QuotedStr(MskTelefoneEndereco.Text))  + ', ' +
             SqlStringTest(QuotedStr(MskFax.Text))  + ', ' +
             SqlStringTest(QuotedStr(MskCelular.Text))  + ', ' +
             SqlStringTest(QuotedStr(TxtEmail.Text))  + ', ' +
             SqlStringTest(QuotedStr(TxtSite.Text))  + ', ' +
             IfThen(KeyLookUp('NOME','CID_CODCIDADE','CIDADE',QuotedStr(CmbCidade.Text),dm.dbautocom) = NullAsStringValue,'NULL', KeyLookUp('NOME','CID_CODCIDADE','CIDADE',QuotedStr(CmbCidade.Text),dm.dbautocom)) + ');',dm.dbautocom,True);
    end;
  if EstadoEndereco = dsEdit then
    begin
      LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + 'Editando Endereço...');
      RunSql(' UPDATE ENDERECOPESSOA SET' +
             ' ENP_ENDERECO_A = ' + SqlStringTest(QuotedStr(TxtEndereco.Text))  + ', ' +
             ' ENP_BAIRRO_A = ' + SqlStringTest(QuotedStr(TxtBairro.Text))  + ', ' +
             ' ENP_COMPLEMENTO_A = ' + SqlStringTest(QuotedStr(TxtComplemento.Text))  + ', ' +
             ' ENP_CEP_I = ' + SqlStringTest(QuotedStr(MskCep.Text))  + ', ' +
             ' ENP_CIDADE_A = ' + SqlStringTest(QuotedStr(CmbCidade.Text))  + ', ' +
             ' ENP_ESTADO_A = ' + SqlStringTest(QuotedStr(CmbEstado.Text))  + ', ' +
             ' ENP_TELEFONE_A = ' + SqlStringTest(QuotedStr(MskTelefoneEndereco.Text))  + ', ' +
             ' ENP_FAX_A = ' + SqlStringTest(QuotedStr(MskFax.Text))  + ', ' +
             ' ENP_CELULAR_A = ' + SqlStringTest(QuotedStr(MskCelular.Text))  + ', ' +
             ' ENP_EMAIL_A = ' + SqlStringTest(QuotedStr(TxtEmail.Text))  + ', ' +
             ' ENP_SITE_A = ' + SqlStringTest(QuotedStr(TxtSite.Text))  + ', ' +
             ' CID_CODCIDADE = ' + IfThen(KeyLookUp('NOME','CID_CODCIDADE','CIDADE',QuotedStr(CmbCidade.Text),dm.dbautocom) = NullAsStringValue,'NULL', KeyLookUp('NOME','CID_CODCIDADE','CIDADE',QuotedStr(CmbCidade.Text),dm.dbautocom)) +
             ' WHERE PES_CODPESSOA = ' + EdCodigo.Text +
             ' AND TEN_CODTIPOENDERECO = ' + KeyLookUp('TEN_DESCRICAO_A','TEN_CODTIPOENDERECO','TIPOENDERECO',QuotedStr(CmbTipoEndereco.Text),dm.dbautocom),dm.dbautocom,True);

    end;
  ReplicaEndereco;
  RunSql('SELECT EP.*, TE.TEN_DESCRICAO_A FROM ENDERECOPESSOA EP inner join tipoendereco TE on(TE.TEN_CODTIPOENDERECO = EP.TEN_CODTIPOENDERECO) WHERE PES_CODPESSOA =  ' + EdCodigo.Text,dm.dbautocom, DsEndereco);
  DSourceEndereco.DataSet := DsEndereco;
  ActEndCancelar.Execute;
end;


procedure TfCadastro.ActEndExcluirExecute(Sender: TObject);
begin
  if Application.MessageBox('Deseja excluir?',Autocom,MB_YESNO) = ID_YES then
    begin
      try
        LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + 'Excluindo Endereço!');
        RunSql('DELETE FROM ENDERECOPESSOA WHERE PES_CODPESSOA = ' + EdCodigo.Text + ' AND TEN_CODTIPOENDERECO = ' + KeyLookUp('TEN_DESCRICAO_A','TEN_CODTIPOENDERECO','TIPOENDERECO',QuotedStr(CmbTipoEndereco.Text),dm.dbautocom),dm.dbautocom,True);
        ActEndCancelar.Execute;
        RunSql('SELECT EP.*, TE.TEN_DESCRICAO_A FROM ENDERECOPESSOA EP inner join tipoendereco TE on(TE.TEN_CODTIPOENDERECO = EP.TEN_CODTIPOENDERECO) WHERE PES_CODPESSOA =  ' + EdCodigo.Text,dm.dbautocom, DsEndereco);
        DSourceEndereco.DataSet := DsEndereco;
      except
        LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + 'Impossível Excluir!');
        Application.MessageBox('Impossível Excluir!',Autocom,MB_ICONERROR);
        Abort;
      end;
    end;
end;

procedure TfCadastro.EditandoContato(Status: Boolean);
begin
  if Status then
    begin
      EnableFields(False,PanButtons);
      EnableFields(True,PanDadosContatos);
      ActConSalvar.Enabled := True;
      ActConExcluir.Enabled := True;
      ActConCancelar.Enabled := True;
      ActConNovo.Enabled := False;
      ActConEditar.Enabled := False;
      PanButtons.Enabled := False;
      if EstadoContato = dsEdit then
        begin
          EdContato.ReadOnly := True;
          EdContato.Color := $00EFD3C6;
          BtnContato.Enabled := False;
        end
      else
        begin
          EdContato.ReadOnly := False;
          EdContato.Color := clWhite;
          BtnContato.Enabled := True;
        end;
    end
  else
    begin
      EnableFields(True,PanButtons);
      EnableFields(False,PanDadosContatos);
      LblContato.Caption := NullAsStringValue;
      ActConSalvar.Enabled := False;
      ActConExcluir.Enabled := False;
      ActConCancelar.Enabled := False;
      ActConNovo.Enabled := True;
      ActConEditar.Enabled := True;
      PanButtons.Enabled := True;
      EstadoContato := dsBrowse;
    end;
end;

procedure TfCadastro.EditandoEndereco(Status: Boolean);
begin
  if Status then
    begin
      EnableFields(False,PanButtons);
      EnableFields(True,PanDadosEndereco);
      ActEndSalvar.Enabled := True;
      ActEndExcluir.Enabled := True;
      ActEndCancelar.Enabled := True;
      ActEndNovo.Enabled := False;
      ActEndEditar.Enabled := False;
      ActSalvar.Enabled := False;
      ActExcluir.Enabled := False;
      ActCancelar.Enabled := False;
    end
  else
    begin
      EnableFields(True,PanButtons);
      EnableFields(False,PanDadosEndereco);
      ActEndSalvar.Enabled := False;
      ActEndExcluir.Enabled := False;
      ActEndCancelar.Enabled := False;
      ActEndNovo.Enabled := True;
      ActEndEditar.Enabled := True;
      ActSalvar.Enabled := True;
      ActExcluir.Enabled := True;
      ActCancelar.Enabled := True;
      EstadoEndereco := dsBrowse;
    end;
end;

procedure TfCadastro.ReplicaEndereco;
var
  DsAux: TDataSet;
begin
  RunSql('select ten_codtipoendereco from tipoendereco where ten_codtipoendereco not in (select ten_codtipoendereco from enderecopessoa where pes_codpessoa = ' + EdCodigo.Text + ')',dm.dbautocom,DsAux);
  if not DsAux.IsEmpty then
    begin
      if (Application.MessageBox('Deseja replicar este endereço para os outros que estiverem em branco?',Autocom,MB_YESNO) = ID_YES) then
        begin
          LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + 'Replicando Endereços...');
          DsAux.Last;
          DsAux.First;
          while not DsAux.Eof do
            begin
              RunSql(' INSERT INTO ENDERECOPESSOA (' +
                     ' PES_CODPESSOA, TEN_CODTIPOENDERECO, ENP_ENDERECO_A, ' +
                     ' ENP_BAIRRO_A, ENP_COMPLEMENTO_A, ENP_CEP_I, ENP_CIDADE_A, ' +
                     ' ENP_ESTADO_A, ENP_TELEFONE_A, ENP_FAX_A, ENP_CELULAR_A, ' +
                     ' ENP_EMAIL_A, ENP_SITE_A, CID_CODCIDADE) VALUES (' +
                     EdCodigo.Text + ', ' +
                     DsAux.Fields[0].AsString  + ', ' +
                     SqlStringTest(QuotedStr(TxtEndereco.Text))  + ', ' +
                     SqlStringTest(QuotedStr(TxtBairro.Text))  + ', ' +
                     SqlStringTest(QuotedStr(TxtComplemento.Text))  + ', ' +
                     SqlStringTest(QuotedStr(MskCep.Text))  + ', ' +
                     SqlStringTest(QuotedStr(CmbCidade.Text))  + ', ' +
                     SqlStringTest(QuotedStr(CmbEstado.Text))  + ', ' +
                     SqlStringTest(QuotedStr(MskTelefoneEndereco.Text))  + ', ' +
                     SqlStringTest(QuotedStr(MskFax.Text))  + ', ' +
                     SqlStringTest(QuotedStr(MskCelular.Text))  + ', ' +
                     SqlStringTest(QuotedStr(TxtEmail.Text))  + ', ' +
                     SqlStringTest(QuotedStr(TxtSite.Text))  + ', ' +
                     IfThen(KeyLookUp('NOME','CID_CODCIDADE','CIDADE',QuotedStr(CmbCidade.Text),dm.dbautocom) = NullAsStringValue,'NULL', KeyLookUp('NOME','CID_CODCIDADE','CIDADE',QuotedStr(CmbCidade.Text),dm.dbautocom)) + ');',dm.dbautocom,True);
              DsAux.Next;
            end;
        end;
    end;
  FreeAndNil(DsAux);
end;

procedure TfCadastro.CmbPessoaChange(Sender: TObject);
begin
  if UpperCase(CmbPessoa.Text) = 'JURIDICA' then
    begin
      LblRG.Caption := 'CNPJ:';
      LblCPF.Caption := 'IE:';
      LblProfissao.Caption := 'Cargo:';
      CmbSexo.Visible := False;
      LblSexo.Visible := False;
      LblDataNascimento.Caption := 'Ini. Operação:';
    end
  else
    begin
      LblRG.Caption := 'RG:';
      LblCPF.Caption := 'CPF:';
      LblProfissao.Caption := 'Profissão:';
      CmbSexo.Visible := True;
      LblSexo.Visible := True;
      LblDataNascimento.Caption := 'Nascimento:';
    end;
end;

procedure TfCadastro.BtnContatoClick(Sender: TObject);
begin
  with TfConsultaPessoa.Create(Self) do
    begin
      ShowModal;
      EdContato.Text := ResultCodigo;
      LblContato.Caption := ResultNome;
      Free;      
    end;
end;

procedure TfCadastro.EdContatoExit(Sender: TObject);
var
  DsAux: TDataSet;
begin
  RunSql('Select PES_CODPESSOA, PES_NOME_A from Pessoa WHERE PES_CODPESSOA = ' + EdContato.Text,dm.dbautocom, DsAux);
  if DsAux.IsEmpty then
    begin
      Application.MessageBox('Código Inválido, Verifique!',Autocom,MB_ICONEXCLAMATION);
      LblContato.Caption := NullAsStringValue;
      EdContato.SetFocus;
      EdContato.SelectAll;
      abort;
    end
  else
    LblContato.Caption := DsAux.FieldByName('PES_NOME_A').AsString;
end;

procedure TfCadastro.PgCtrlMainChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if (not ActCancelar.Enabled) or (EdCodigo.Text = NullAsStringValue) then
    begin
      AllowChange := False;
      Beep;
    end;
end;

procedure TfCadastro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN:
      begin
        If not (ActiveControl is TDBGrid) then Perform(WM_NEXTDLGCTL,0,0);
      end;
  end;
end;

procedure TfCadastro.ActConSalvarExecute(Sender: TObject);
begin
  if EstadoContato = dsInsert then
    begin
      LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + 'Inserindo Contato..');
      RunSql('INSERT INTO CONTATOPESSOA (PES_CODPESSOA, PES_CODPESSOA_CONTATO, COP_LOCAL_A, COP_FUNCAO_A) VALUES (' +
             EdCodigo.Text + ', ' + EdContato.Text + ', ' +  QuotedStr(EdSetor.Text) + ', ' + QuotedStr(EdFuncao.Text) + ');',dm.dbautocom,True);
   end;
  if EstadoContato = dsEdit then
    begin
      LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + 'Editando Contato...');
      RunSql(' UPDATE CONTATOPESSOA SET' +
             ' COP_LOCAL_A = ' + SqlStringTest(QuotedStr(EdSetor.Text))  + ', ' +
             ' COP_FUNCAO_A = ' + SqlStringTest(QuotedStr(EdFuncao.Text))  +
             ' WHERE PES_CODPESSOA = ' + EdCodigo.Text +
             ' AND PES_CODPESSOA_CONTATO = ' + EdContato.Text,dm.dbautocom,True);
    end;
      RunSQL('SELECT * FROM CONTATOPESSOA CP, PESSOA P WHERE CP.PES_CODPESSOA = ' + EdCodigo.Text + ' AND P.PES_CODPESSOA = CP.PES_CODPESSOA_CONTATO' ,dm.dbautocom,DsContato);
      DSourceContato.DataSet := DsContato;
      ActConCancelar.Execute;
end;

procedure TfCadastro.ActConExcluirExecute(Sender: TObject);
begin
  if Application.MessageBox('Deseja excluir?',Autocom,MB_YESNO) = ID_YES then
    begin
      try
        LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + 'Excluindo Contato!');
        RunSql(' DELETE FROM CONTATOPESSOA ' +
       ' WHERE PES_CODPESSOA = ' + EdCodigo.Text +
       ' AND PES_CODPESSOA_CONTATO = ' + EdContato.Text,dm.dbautocom);
        RunSQL('SELECT * FROM CONTATOPESSOA CP, PESSOA P WHERE CP.PES_CODPESSOA = ' + EdCodigo.Text + ' AND P.PES_CODPESSOA = CP.PES_CODPESSOA_CONTATO' ,dm.dbautocom,DsContato, True);
        DSourceContato.DataSet := DsContato;
        ActConCancelar.Execute;
      except
        LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + 'Impossível Excluir!');
        Application.MessageBox('Impossível Excluir!',Autocom,MB_ICONERROR);
        Abort;
      end;
    end;
end;

end.
