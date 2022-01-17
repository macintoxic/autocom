unit uRelatorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, Buttons, uGlobal, DB, StrUtils;

type
  TfRelatorio = class(TForm)
    RadOrdem: TRadioGroup;
    PanTitleOrdem: TPanel;
    PanGrupo: TPanel;
    LlbTitleGrupo: TLabel;
    LblGrupo: TLabel;
    Label14: TLabel;
    BtnGrupo: TSpeedButton;
    EdGrupo: TMaskEdit;
    PanSubGrupo: TPanel;
    LlbTitleSubGrupo: TLabel;
    LblSubGrupo: TLabel;
    Label3: TLabel;
    BtnSubGrupo: TSpeedButton;
    EdSubGrupo: TMaskEdit;
    PanSecao: TPanel;
    LlbTitleSecao: TLabel;
    LblSecao: TLabel;
    Label6: TLabel;
    BtnSecao: TSpeedButton;
    EdSecao: TMaskEdit;
    ChkSubGrupo: TCheckBox;
    ChkSecao: TCheckBox;
    ChkGrupo: TCheckBox;
    PanPreco: TPanel;
    LlbTitlePreco: TLabel;
    LblPrecoTabela: TLabel;
    Label9: TLabel;
    BtnPreco: TSpeedButton;
    EdPreco: TMaskEdit;
    BtnImprimir: TSpeedButton;
    BtnCancelar: TSpeedButton;
    PanPrateleira: TPanel;
    LlbTitlePrateleira: TLabel;
    LblPrateleira: TLabel;
    Label8: TLabel;
    BtnPrateleira: TSpeedButton;
    EdPrateleira: TMaskEdit;
    PanTipo: TPanel;
    LlbTitleTipo: TLabel;
    LblTipo: TLabel;
    Label12: TLabel;
    BtnTipo: TSpeedButton;
    EdTipo: TMaskEdit;
    ChkPrateleira: TCheckBox;
    ChkTipo: TCheckBox;
    ChkPreco: TCheckBox;
    RadRel: TRadioGroup;
    Panel1: TPanel;
    procedure BtnGrupoClick(Sender: TObject);
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnSubGrupoClick(Sender: TObject);
    procedure BtnSecaoClick(Sender: TObject);
    procedure BtnPrecoClick(Sender: TObject);
    procedure ChkPrecoClick(Sender: TObject);
    procedure ChkGrupoClick(Sender: TObject);
    procedure ChkSubGrupoClick(Sender: TObject);
    procedure ChkSecaoClick(Sender: TObject);
    procedure ChkPrateleiraClick(Sender: TObject);
    procedure ChkTipoClick(Sender: TObject);
    procedure BtnTipoClick(Sender: TObject);
    procedure BtnPrateleiraClick(Sender: TObject);
    procedure EdGrupoExit(Sender: TObject);
    procedure EdSubGrupoExit(Sender: TObject);
    procedure EdTipoExit(Sender: TObject);
    procedure EdSecaoExit(Sender: TObject);
    procedure EdPrateleiraExit(Sender: TObject);
    procedure EdPrecoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnImprimirClick(Sender: TObject);
    procedure RadRelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PanelClick(Sender: TObject);
  private
    procedure Validacao;
  public
    DsRelatorio: TDataSet;
  end;

var
  fRelatorio: TfRelatorio;

implementation

uses uCadastro, uConsultaGrupo, uConsultaPreco, uConsultaSecao,
  uConsultaSubGrupos, uConsultaTipo, uDm, uMain, uConsultaPrateleira;

{$R *.dfm}

procedure TfRelatorio.BtnGrupoClick(Sender: TObject);
begin
  with TfConsultaGrupo.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  EdGrupo.Text := FormatFloat('000',ResultConsultaCodigo);
  LblGrupo.Caption := ResultConsultaNome;
  EdGrupo.SetFocus;
end;

procedure TfRelatorio.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfRelatorio.BtnSubGrupoClick(Sender: TObject);
begin
  with TfConsultaSubGrupos.Create(Self) do
    begin
      CodigoGrupo := EdGrupo.Text;
      ShowModal;
      Free;
    end;
  EdSubGrupo.Text := FormatFloat('000',ResultConsultaCodigo);
  LblSubGrupo.Caption := ResultConsultaNome;
  EdSubGrupo.SetFocus;
end;

procedure TfRelatorio.BtnSecaoClick(Sender: TObject);
begin
  with TfConsultaSecao.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  EdSecao.Text := FormatFloat('000',ResultConsultaCodigo);
  LblSecao.Caption := ResultConsultaNome;
  EdSecao.SetFocus;
end;

procedure TfRelatorio.BtnPrecoClick(Sender: TObject);
begin
  with TfConsultaPreco.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  EdPreco.Text := FormatFloat('000',ResultConsultaCodigo);
  LblPrecoTabela.Caption := ResultConsultaNome;
  EdPreco.SetFocus;
end;

procedure TfRelatorio.ChkPrecoClick(Sender: TObject);
begin
  if ChkPreco.Checked then
    begin
      //RadOrdem.Items.Text := 'Código' + #13 + 'Nome' + #13 + 'Grupo' + #13 + 'Sub-Grupo' + #13 + 'Seção' + #13 + 'Preço';
      EnableFields(True,PanPreco);
    end
  else
    begin
      //RadOrdem.Items.Text := 'Código' + #13 + 'Nome' + #13 + 'Grupo' + #13 + 'Sub-Grupo' + #13 + 'Seção';
      EnableFields(False,PanPreco);
      LlbTitlePreco.Enabled := True;
      LblPrecoTabela.Caption := NullAsStringValue;
    end;
  RadRelClick(Self); //Formata Ordens;
end;

procedure TfRelatorio.ChkGrupoClick(Sender: TObject);
begin
  if ChkGrupo.Checked then
    begin
      EnableFields(True,PanGrupo);
      ChkSubGrupo.Enabled := True;
    end
  else
    begin
      EnableFields(False,PanGrupo);
      LlbTitleGrupo.Enabled := True;
      LblGrupo.Caption := NullAsStringValue;
      ChkSubGrupo.Checked := False;
      ChkSubGrupo.Enabled := False;
    end;
end;

procedure TfRelatorio.ChkSubGrupoClick(Sender: TObject);
begin
  if ChkSubGrupo.Checked then
    begin
      if IsNull( EdGrupo.Text) then
        begin
          Application.MessageBox('Antes é preciso selecionar um grupo válido!',Autocom,MB_ICONWARNING);
          EdGrupo.SetFocus;
          abort;
        end;
      EnableFields(True,PanSubGrupo);
    end
  else
    begin
      EnableFields(False,PanSubGrupo);
      LlbTitleSubGrupo.Enabled := True;
      LblSubGrupo.Caption := NullAsStringValue;
    end;
end;

procedure TfRelatorio.ChkSecaoClick(Sender: TObject);
begin
  if ChkSecao.Checked then
    begin
      EnableFields(True,PanSecao);
      ChkPrateleira.Enabled := True;
    end
  else
    begin
      EnableFields(False,PanSecao);
      LlbTitleSecao.Enabled := True;
      LblSecao.Caption := NullAsStringValue;
      ChkPrateleira.Checked := False;
      ChkPrateleira.Enabled := False;
    end;
end;

procedure TfRelatorio.ChkPrateleiraClick(Sender: TObject);
begin
  if ChkPrateleira.Checked then
    begin
      if IsNull(EdSecao.Text) then
        begin
          Application.MessageBox('Antes é preciso selecionar uma seção válida!',Autocom,MB_ICONWARNING);
          EdSecao.SetFocus;
          abort;
        end;
      EnableFields(True,PanPrateleira);
    end
  else
    begin
      EnableFields(False,PanPrateleira);
      LlbTitlePrateleira.Enabled := True;
      LblPrateleira.Caption := NullAsStringValue;      
    end;
end;

procedure TfRelatorio.ChkTipoClick(Sender: TObject);
begin
  if ChkTipo.Checked then
    begin
      EnableFields(True,PanTipo);
    end
  else
    begin
      EnableFields(False,PanTipo);
      LlbTitleTipo.Enabled := True;
      LblTipo.Caption := NullAsStringValue;
    end;
end;

procedure TfRelatorio.BtnTipoClick(Sender: TObject);
begin
  with TfConsultaTipo.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  EdTipo.Text := FormatFloat('000',ResultConsultaCodigo);
  LblTipo.Caption := ResultConsultaNome;
  EdTipo.SetFocus;
end;

procedure TfRelatorio.BtnPrateleiraClick(Sender: TObject);
begin
  with TfConsultaPrateleira.Create(Self) do
    begin
      CodigoSecao := EdSecao.Text;
      ShowModal;
      Free;
    end;
  EdPrateleira.Text := FormatFloat('000',ResultConsultaCodigo);
  LblPrateleira.Caption := ResultConsultaNome;
  EdPrateleira.SetFocus;
end;

procedure TfRelatorio.EdGrupoExit(Sender: TObject);
var
  DataSetLookUp: TDataSet;
begin
  FormatEdit(Sender,Float,3,0);
  if (IsNull((Sender as TCustomEdit).Text)) or (StrToFloatDef((Sender as TCustomEdit).Text,0) = 0)  then
    begin
      (Sender as TCustomEdit).Clear;
      EdSubGrupo.Clear;
      LblGrupo.Caption := NullAsStringValue;
      LblSubGrupo.Caption := NullAsStringValue;
      Exit;
    end;
  RunSQL('SELECT CODIGOGRUPOPRODUTO, GRUPOPRODUTO FROM GRUPOPRODUTO  WHERE CODIGOGRUPOPRODUTO = ' +  (Sender as TCustomEdit).Text + ' ORDER BY GRUPOPRODUTO', Dm.DBAutocom, DataSetLookUp);
  if DataSetLookUp.IsEmpty then
    begin
      MessageBox(Handle,'Digite um código válido para o campo grupo!',Autocom,MB_ICONWARNING);
      (Sender as TCustomEdit).SetFocus; (Sender as TCustomEdit).SelectAll;
      Exit;
    end;
  LblGrupo.Caption := DataSetLookUp.Fields[1].AsString;
  FreeAndNil(DataSetLookUp);
end;

procedure TfRelatorio.EdSubGrupoExit(Sender: TObject);
var
  DataSetLookUp: TDataSet;
begin
  FormatEdit(Sender,Float,3,0);
  if IsNull((Sender as TCustomEdit).Text) or (StrToFloatDef((Sender as TCustomEdit).Text,0) = 0) then
  begin
    (Sender as TCustomEdit).Clear;
    LblSubGrupo.Caption := NullAsStringValue;
    Exit;
  end;

  if IsNull(EdGrupo.Text) then
    begin
      MessageBox(Handle,'Antes é necessario selecionar um grupo!',Autocom,MB_ICONWARNING);
      EdSubGrupo.Clear;
      EdGrupo.SetFocus;
      Exit;
    end;

  RunSQL('SELECT CODIGOSUBGRUPO , SUBGRUPO FROM SUBGRUPOPRODUTO WHERE CODIGOSUBGRUPO = ' + EdSubGrupo.Text + ' AND CODIGOGRUPOPRODUTO = ' + EdGrupo.Text, Dm.DBAutocom, DataSetLookUp);
  if DataSetLookUp.IsEmpty then
    begin
      MessageBox(Handle,'Digite um código válido para o campo sub-grupo!',Autocom,MB_ICONWARNING);
      (Sender as TCustomEdit).SetFocus; (Sender as TCustomEdit).SelectAll;
      Exit;
    end;
  LblSubGrupo.Caption := DataSetLookUp.Fields[1].AsString;
  FreeAndNil(DataSetLookUp);
end;

procedure TfRelatorio.EdTipoExit(Sender: TObject);
var
  DataSetLookUp: TDataSet;
begin
  FormatEdit(Sender,Float,3,0);
  if (IsNull((Sender as TCustomEdit).Text)) or (StrToFloatDef((Sender as TCustomEdit).Text,0) = 0) then
    begin
      (Sender as TCustomEdit).Clear;
      LblTipo.Caption := NullAsStringValue;
      Exit;
    end;
  RunSQL('SELECT CODIGOTIPOPRODUTO , DESCRICAO FROM TIPOPRODUTO WHERE CODIGOTIPOPRODUTO = ' +  (Sender as TCustomEdit).Text, Dm.DBAutocom, DataSetLookUp);
  if DataSetLookUp.IsEmpty then
    begin
      MessageBox(Handle,'Digite um código válido para o campo tipo!',Autocom,MB_ICONWARNING);
      (Sender as TCustomEdit).SetFocus; (Sender as TCustomEdit).SelectAll;
      Exit;
    end;
  LblTipo.Caption := DataSetLookUp.Fields[1].AsString;
  FreeAndNil(DataSetLookUp);
end;

procedure TfRelatorio.EdSecaoExit(Sender: TObject);
var
  DataSetLookUp: TDataSet;
begin
  FormatEdit(Sender,Float,3,0);
  if (IsNull((Sender as TCustomEdit).Text) or (StrToFloatDef((Sender as TCustomEdit).Text,0) = 0))  then
    begin
      (Sender as TCustomEdit).Clear;
      LblSecao.Caption := NullAsStringValue;
      Exit;
    end;
  RunSQL('SELECT CODIGOSECAO, DESCRICAO FROM SECAO WHERE CODIGOSECAO = ' +  (Sender as TCustomEdit).Text + ' ORDER BY DESCRICAO', Dm.DBAutocom, DataSetLookUp);
  if DataSetLookUp.IsEmpty then
    begin
      MessageBox(Handle,'Digite um código válido para o campo seção!',Autocom,MB_ICONWARNING);
      (Sender as TCustomEdit).SetFocus; (Sender as TCustomEdit).SelectAll;
      Exit;
    end;
  LblSecao.Caption := DataSetLookUp.Fields[1].AsString;
  FreeAndNil(DataSetLookUp);
end;

procedure TfRelatorio.EdPrateleiraExit(Sender: TObject);
var
  DataSetLookUp: TDataSet;
begin
//  FormatEdit(Sender,Float,0,0);
  if (IsNull((Sender as TCustomEdit).Text) or (StrToFloatDef((Sender as TCustomEdit).Text,0) = 0))  then
    begin
      (Sender as TCustomEdit).Clear;
      LblPrateleira.Caption := NullAsStringValue;
      Exit;
    end;

  if IsNull(EdSecao.Text) then
    begin
      MessageBox(Handle,'Antes é necessario selecionar uma secão!',Autocom,MB_ICONWARNING);
      EdPrateleira.Clear;
      EdSecao.SetFocus;
      Exit;
    end;

  RunSQL('SELECT CODIGOPRATELEIRA FROM PRATELEIRA WHERE CODIGOPRATELEIRA = ' +  (Sender as TCustomEdit).Text + ' ORDER BY CODIGOPRATELEIRA', Dm.DBAutocom, DataSetLookUp);
  if DataSetLookUp.IsEmpty then
    begin
      MessageBox(Handle,'Digite um código válido para o campo prateleira!',Autocom,MB_ICONWARNING);
      (Sender as TCustomEdit).SetFocus; (Sender as TCustomEdit).SelectAll;
      Exit;
    end;
  LblPrateleira.Caption := DataSetLookUp.Fields[0].AsString;
  FreeAndNil(DataSetLookUp);
end;

procedure TfRelatorio.EdPrecoExit(Sender: TObject);
var
  DataSetLookUp: TDataSet;
begin
  FormatEdit(Sender,Float,3,0);
  if (IsNull((Sender as TCustomEdit).Text) or (StrToFloatDef((Sender as TCustomEdit).Text,0) = 0))  then
    begin
      (Sender as TCustomEdit).Clear;
      LblPrecoTabela.Caption := NullAsStringValue;
      Exit;
    end;

  RunSQL('SELECT TABELAPRECO FROM TABELAPRECO WHERE CODIGOTABELA = ' +  (Sender as TCustomEdit).Text + ' ORDER BY TABELAPRECO', Dm.DBAutocom, DataSetLookUp);
  if DataSetLookUp.IsEmpty then
    begin
      MessageBox(Handle,'Digite um código válido!',Autocom,MB_ICONWARNING);
      (Sender as TCustomEdit).SetFocus; (Sender as TCustomEdit).SelectAll;
      Abort;
    end;
  LblPrecoTabela.Caption := DataSetLookUp.Fields[0].AsString;
  FreeAndNil(DataSetLookUp);
end;


procedure TfRelatorio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key of
    VK_RETURN: Perform(WM_NEXTDLGCTL,0,0);
  end;
end;

procedure TfRelatorio.BtnImprimirClick(Sender: TObject);
var SQLCMD:string;
begin
  Validacao;
  DM.Rave.ProjectFile:=ExtractFilePath(application.exename)+'CProdFar.rav';
  if RadRel.ItemIndex = 0 then
    begin
      //Relatório Reduzido
          SQLCMD:=' SELECT P.CODIGOPRODUTO, P.NOMEPRODUTO '+
                 ifthen(ChkPreco.Checked=true,', (SELECT PRECO FROM PRODUTOTABELAPRECO WHERE CODIGOPRODUTO = P.CODIGOPRODUTO AND CODIGOTABELAPRECO = ' + KeyLookUp('CODIGOTABELA','CODIGOTABELAPRECO','TABELAPRECO',EdPreco.Text,Dm.DBAutocom) + ')AS PRECO') +
                 ifthen(ChkPreco.Checked=true,
                 ' FROM PRODUTO P, Grupoproduto G, SubGrupoproduto SG, Secao S,Prateleira Pr, Tipoproduto Tp, ESTOQUE E INNER JOIN PRODUTOTABELAPRECO T ON (P.CODIGOPRODUTO = T.CODIGOPRODUTO)',
                 ' FROM Grupoproduto G, SubGrupoproduto SG, Secao S,Prateleira Pr, Tipoproduto Tp,PRODUTO P INNER JOIN ESTOQUE E ON (E.CODIGOPRODUTO = P.CODIGOPRODUTO)')+
                 ' WHERE E.CODIGOPRODUTO = P.CODIGOPRODUTO' +
                 '   and pr.CODPRATELEIRA = E.CODPRATELEIRA' +
                 '   and S.CODSECAO = Pr.CODSECAO' +
                 '   and sg.codigosubgrupoproduto=p.codigosubgrupoproduto' +
                 '   and g.codigogrupoproduto=sg.codigogrupoproduto' +
                 '   and Tp.CODTIPOPRODUTO = P.CODTIPOPRODUTO' +
                 IfThen(CHKgrupo.checked=true,' and g.CODIGOGRUPOPRODUTO='+edgrupo.Text)+
                 IfThen(CHKsubgrupo.checked=true,' and sg.CODIGOSUBGRUPO='+edsubgrupo.Text)+
                 IfThen(CHKsecao.checked=true,' and S.CODSECAO='+edsecao.Text)+
                 IfThen(CHKprateleira.checked=true,' and pr.CODPRATELEIRA='+edprateleira.Text)+
                 IfThen(CHKtipo.checked=true,' and Tp.CODTIPOPRODUTO='+edtipo.Text)+

                 IfThen(RadOrdem.ItemIndex = 0,' ORDER BY P.CODIGOPRODUTO') +
                 IfThen(RadOrdem.ItemIndex = 1,' ORDER BY P.NOMEPRODUTO') +
                 IfThen(RadOrdem.ItemIndex = 2,' ORDER BY T.PRECO') +
                 IfThen(RadOrdem.ItemIndex = 3,' ORDER BY T.PRECO DESC');

          LogSend('logs\CADPROD' + FormatDateTime('yyyymmdd',Now)+'.log',SQLCMD);

          RunSql(SQLCMd,Dm.DBAutocom,DsRelatorio);

      if ChkPreco.Checked then
        begin
          //Fomata campo Preço como currency
          TFloatField(DsRelatorio.FieldByName('PRECO')).currency := True;
          //Imprime Relatório
          Dm.RvDs.DataSet := DsRelatorio;
          DsRelatorio.First;
          DsRelatorio.Last;
          Dm.Rave.SetParam('Total',IntToStr(DsRelatorio.RecordCount));
          Dm.Rave.ExecuteReport('RProdutoPreco');
        end
      else
        begin
          //Imprime Relatório
          Dm.RvDs.DataSet := DsRelatorio;
          DsRelatorio.First;
          DsRelatorio.Last;
          Dm.Rave.SetParam('Total',IntToStr(DsRelatorio.RecordCount));
          Dm.Rave.ExecuteReport('RProdutoBasico');
        end;
    end
  else
    begin
      //Relatório Completo
          SQLCMD:=' SELECT P.CODIGOPRODUTO, P.PRODUTO, P.NOMEPRODUTO, '+ifthen(ChkPreco.Checked=true,'T.PRECO,')+' P.UNIDADE, ' +
                 ' P.PESOBRUTO, P.PESOLIQUIDO, P.DIMENSAOCAIXA, P.VOLUME, ' +
                 ' P.PERCENTUALCOMISSAO, P.ALIQUOTAIPI AS IPI, E.MARGEMLUCRO, ' +
                 ifthen(ChkPreco.Checked=true,' (SELECT PRECO FROM PRODUTOTABELAPRECO WHERE CODIGOPRODUTO = P.CODIGOPRODUTO AND CODIGOTABELAPRECO = ' + KeyLookUp('CODIGOTABELA','CODIGOTABELAPRECO','TABELAPRECO',EdPreco.Text,Dm.DBAutocom) + ')AS PRECO,') +
                 ' G.GRUPOPRODUTO AS GRUPO,' +
                 ' sg.SUBGRUPO AS SUBGRUPO,' +
                 ' S.DESCRICAO AS SECAO,' +
                 ' pr.CODIGOPRATELEIRA AS PRATELEIRA,' +
                 ' tp.DESCRICAO AS TIPO,' +
                 ' (SELECT CLASSIFICACAOFISCAL FROM CLASSIFICACAOFISCAL WHERE CODIGOCLASSIFICACAOFISCAL = P.CODIGOCLASSIFICACAOFISCAL) AS CF,' +
                 ' (SELECT SITUACAOTRIBUTARIA FROM SITUACAOTRIBUTARIA WHERE CODIGOSITUACAOTRIBUTARIA = P.CODIGOSITUACAOTRIBUTARIA) AS SITUACAOTRIBUTARIA' +
                 ifthen(ChkPreco.Checked=true,
                 ' FROM PRODUTO P, Grupoproduto G, SubGrupoproduto SG, Secao S,Prateleira Pr, Tipoproduto Tp, ESTOQUE E INNER JOIN PRODUTOTABELAPRECO T ON (P.CODIGOPRODUTO = T.CODIGOPRODUTO)',
                 ' FROM Grupoproduto G, SubGrupoproduto SG, Secao S,Prateleira Pr, Tipoproduto Tp,PRODUTO P INNER JOIN ESTOQUE E ON (E.CODIGOPRODUTO = P.CODIGOPRODUTO)')+
                 ' WHERE E.CODIGOPRODUTO = P.CODIGOPRODUTO' +
                 '   and pr.CODPRATELEIRA = E.CODPRATELEIRA' +
                 '   and S.CODSECAO = Pr.CODSECAO' +
                 '   and sg.codigosubgrupoproduto=p.codigosubgrupoproduto' +
                 '   and g.codigogrupoproduto=sg.codigogrupoproduto' +
                 '   and Tp.CODTIPOPRODUTO = P.CODTIPOPRODUTO' +
                 IfThen(CHKgrupo.checked=true,' and g.CODIGOGRUPOPRODUTO='+edgrupo.Text)+
                 IfThen(CHKsubgrupo.checked=true,' and sg.CODIGOSUBGRUPO='+edsubgrupo.Text)+
                 IfThen(CHKsecao.checked=true,' and S.CODSECAO='+edsecao.Text)+
                 IfThen(CHKprateleira.checked=true,' and pr.CODPRATELEIRA='+edprateleira.Text)+
                 IfThen(CHKtipo.checked=true,' and Tp.CODTIPOPRODUTO='+edtipo.Text)+

                 IfThen(RadOrdem.ItemIndex = 0,' ORDER BY P.CODIGOPRODUTO') +
                 IfThen(RadOrdem.ItemIndex = 1,' ORDER BY P.NOMEPRODUTO') +
                 IfThen(RadOrdem.ItemIndex = 2,' ORDER BY T.PRECO') +
                 IfThen(RadOrdem.ItemIndex = 3,' ORDER BY T.PRECO DESC');

          LogSend('logs\CADPROD' + FormatDateTime('yyyymmdd',Now)+'.log',SQLCMD);

          RunSql(SQLCMd,Dm.DBAutocom,DsRelatorio);

          //Fomata campos
          TFloatField(DsRelatorio.FieldByName('IPI')).DisplayFormat := '0.00%';
          TFloatField(DsRelatorio.FieldByName('MARGEMLUCRO')).DisplayFormat := '0.00%';
          TFloatField(DsRelatorio.FieldByName('PESOLIQUIDO')).DisplayFormat := '0.000';
          TFloatField(DsRelatorio.FieldByName('PESOBRUTO')).DisplayFormat := '0.000';

          //Imprime Relatório
     if ChkPreco.Checked=true then
        begin
          //Fomata campos
          TFloatField(DsRelatorio.FieldByName('PRECO')).currency := True;
          Dm.RvDs.DataSet := DsRelatorio;
          DsRelatorio.First;
          DsRelatorio.Last;
          Dm.Rave.SetParam('Total',IntToStr(DsRelatorio.RecordCount));
          Dm.Rave.ExecuteReport('RProdutoFullPreco');
        end
      else
        begin
          //Relatório Completo sem Preço
          //Imprime Relatório
          Dm.RvDs.DataSet := DsRelatorio;
          DsRelatorio.First;
          DsRelatorio.Last;
          Dm.Rave.SetParam('Total',IntToStr(DsRelatorio.RecordCount));
          Dm.Rave.ExecuteReport('RProdutoFull');
        end;
    end;
end;

procedure TfRelatorio.RadRelClick(Sender: TObject);
begin
  if RadRel.ItemIndex = 0 then
    begin
    //Relatorio Reduzido

      //Desabilita Opções
{      ChkGrupo.Enabled := False;
      ChkSecao.Enabled := False;
      ChkSubGrupo.Enabled := False;
      ChkPrateleira.Enabled := False;
      ChkTipo.Enabled := False;
      ChkGrupo.Checked := False;
      ChkSecao.Checked := False;
      ChkSubGrupo.Checked := False;
      ChkPrateleira.Checked := False;
      ChkTipo.Checked := False;
}
      //Habilita Opções
      ChkGrupo.Enabled := True;
      ChkSecao.Enabled := True;
      ChkSubGrupo.Enabled := False;
      ChkPrateleira.Enabled := False;
      ChkTipo.Enabled := True;
      ChkGrupo.Checked := False;
      ChkSecao.Checked := False;
      ChkSubGrupo.Checked := False;
      ChkPrateleira.Checked := False;
      ChkTipo.Checked := False;
    end
  else
    begin
      //Habilita Opções
      ChkGrupo.Enabled := True;
      ChkSecao.Enabled := True;
      ChkSubGrupo.Enabled := False;
      ChkPrateleira.Enabled := False;
      ChkTipo.Enabled := True;
      ChkGrupo.Checked := False;
      ChkSecao.Checked := False;
      ChkSubGrupo.Checked := False;
      ChkPrateleira.Checked := False;
      ChkTipo.Checked := False;
      //Relatorio Completo
      RadOrdem.Columns := 3;
    end;
    if ChkPreco.Checked then
      begin
        RadOrdem.Items.Text := 'Código' + #13 + 'Nome' + #13 + 'Preço (Crescente)' + #13 + 'Preço (Decrescente)';;
        RadOrdem.Columns := 2;
      end
    else
      begin
        RadOrdem.Items.Text := 'Código' + #13 + 'Nome';
        RadOrdem.Columns := 1;
      end;
end;

procedure TfRelatorio.Validacao;
begin
  if ChkPreco.Checked then EdPrecoExit(EdPreco);
  if ChkTipo.Checked then EdTipoExit(EdTipo);
  if ChkGrupo.Checked then EdGrupoExit(EdGrupo);
  if ChkSubGrupo.Checked then EdSubGrupoExit(EdSubGrupo);
  if ChkSecao.Checked then EdSecaoExit(EdSecao);
  if ChkPrateleira.Checked then EdPrateleiraExit(EdPrateleira);
  if IsNull(EdPreco.Text) then ChkPreco.Checked := False;
  if IsNull(EdTipo.Text) then ChkTipo.Checked := False;
  if IsNull(EdGrupo.Text) then ChkGrupo.Checked := False;
  if IsNull(EdSubGrupo.Text) then ChkSubGrupo.Checked := False;
  if IsNull(EdSecao.Text) then ChkSecao.Checked := False;
  if IsNull(EdPrateleira.Text) then ChkPrateleira.Checked := False;
end;

procedure TfRelatorio.FormShow(Sender: TObject);
begin
   //Habilita Opções
   RadRelClick(Self);
end;

procedure TfRelatorio.PanelClick(Sender: TObject);
var
  Chk: ^TCheckBox;
begin
  if Sender = LlbTitleGrupo then Chk := @ChkGrupo else
  if Sender = LlbTitleSubGrupo then Chk := @ChkSubGrupo else
  if Sender = LlbTitleSecao then Chk := @ChkSecao else
  if Sender = LlbTitlePrateleira then Chk := @ChkPrateleira else
  if Sender = LlbTitlePreco then Chk := @ChkPreco else
  if Sender = LlbTitleTipo then Chk := @ChkTipo;
  if Chk.Enabled then
    if Chk.Checked then
      Chk.Checked := False
    else
      Chk.Checked := True;
end;

end.

