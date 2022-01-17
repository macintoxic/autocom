unit uCadastro;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ActnList, XPStyleActnCtrls, ActnMan, ComCtrls, DB, uSqlGlobal,
  StdCtrls, Mask, ActnColorMaps, ExtCtrls, Grids, DBGrids, uGlobal, StrUtils,
  JvComponent, JvBalloonHint;

type
  TfCadastro = class(TForm)
    PageControlMain: TPageControl;
    TabGerais: TTabSheet;
    TabFiscais: TTabSheet;
    TabEstoque: TTabSheet;
    ActMain: TActionManager;
    ActNovo: TAction;
    ActPesquisar: TAction;
    ActFechar: TAction;
    ActCancelar: TAction;
    ActSalvar: TAction;
    ActExcluir: TAction;
    ActRelatorio: TAction;
    BtnSalvar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    BtnCancelar: TSpeedButton;
    lbl_descfull: TLabel;
    lbl_cod: TLabel;
    EdNome: TEdit;
    EdCodigo: TMaskEdit;
    lbl_codref: TLabel;
    EdCodReferencia: TEdit;
    Label1: TLabel;
    PanGrupo: TPanel;
    Label2: TLabel;
    LblGrupo: TLabel;
    Label4: TLabel;
    BtnConsultaGrupo: TSpeedButton;
    PanSubGrupo: TPanel;
    Label5: TLabel;
    LblSubGrupo: TLabel;
    Label7: TLabel;
    BtnConsultaSubGrupo: TSpeedButton;
    PanTipo: TPanel;
    Label8: TLabel;
    LblTipo: TLabel;
    Label10: TLabel;
    BtnConsultaTipo: TSpeedButton;
    lbl_casasdec: TLabel;
    CmbCasas: TComboBox;
    lbl_univenda: TLabel;
    CmbUnidade: TComboBox;
    lbl_comisao: TLabel;
    lbl_custo: TLabel;
    lbl_custobruto: TLabel;
    lbl_mglucro: TLabel;
    ActPrecoCancelar: TAction;
    ActPrecoEditar: TAction;
    ActPrecoExcluir: TAction;
    TabPreco: TTabSheet;
    Label3: TLabel;
    PanIPI: TPanel;
    Label6: TLabel;
    LblIPI: TLabel;
    EdIPI: TMaskEdit;
    PanClassificacaoFiscal: TPanel;
    Label12: TLabel;
    LblClassificacaoFiscal: TLabel;
    Label14: TLabel;
    BtnConsultaClassificacaoFiscal: TSpeedButton;
    EdClassificaoFiscal: TMaskEdit;
    PanSituacaoTributaria: TPanel;
    Label15: TLabel;
    LblSituacaoTributaria: TLabel;
    Label17: TLabel;
    BtnConsultaSituacaoTributaria: TSpeedButton;
    EdSituacaoTributaria: TMaskEdit;
    Label18: TLabel;
    PanAliquotas: TPanel;
    Label25: TLabel;
    PanAliquotaFields: TPanel;
    Label19: TLabel;
    edEstado: TMaskEdit;
    CmbAliquotaTipo: TComboBox;
    Label20: TLabel;
    edAliquota: TMaskEdit;
    Label21: TLabel;
    Label22: TLabel;
    edReducao: TMaskEdit;
    edSubstituicao: TMaskEdit;
    Label23: TLabel;
    edIndiceEcf: TMaskEdit;
    Label24: TLabel;
    PanAliquotaButtons: TPanel;
    GrdICMS: TDBGrid;
    ActPrecoSalvar: TAction;
    ActICMSCancelar: TAction;
    ActICMSEditar: TAction;
    ActICMSExcluir: TAction;
    ActICMSSalvar: TAction;
    Label26: TLabel;
    BtnAliquotaSalvar: TSpeedButton;
    BtnAliquotaExcluir: TSpeedButton;
    BtnAliquotaCancelar: TSpeedButton;
    BtnAliquotaNovo: TSpeedButton;
    ActPrecoNovo: TAction;
    ActICMSNovo: TAction;
    BtnAliquotaEditar: TSpeedButton;
    Panel10: TPanel;
    PanPrecoEdit: TPanel;
    Label30: TLabel;
    Label31: TLabel;
    PanPrecoButtons: TPanel;
    BtnPrecoSalvar: TSpeedButton;
    BtnPrecoExcluir: TSpeedButton;
    BtnPrecoCancelar: TSpeedButton;
    BtnPrecoNovo: TSpeedButton;
    BtnPrecoEditar: TSpeedButton;
    GrdPreco: TDBGrid;
    lbl_pesobruto: TLabel;
    lbl_pesoliq: TLabel;
    lbl_dimensao: TLabel;
    lbl_volume: TLabel;
    lbl_estmin: TLabel;
    lbl_estmax: TLabel;
    lbl_estatual: TLabel;
    lbl_datareposicao: TLabel;
    PageControlDescricao: TPageControl;
    TabDescricao: TTabSheet;
    MemDescricao: TMemo;
    TabIndicacao: TTabSheet;
    MemIndicacao: TMemo;
    TabAplicacao: TTabSheet;
    MemAplicacao: TMemo;
    PanSecao: TPanel;
    Label27: TLabel;
    LblSecao: TLabel;
    Label35: TLabel;
    BtnConsultaSecao: TSpeedButton;
    EdSecao: TMaskEdit;
    PanPrateleira: TPanel;
    Label36: TLabel;
    LblPrateleira: TLabel;
    Label38: TLabel;
    BtnConsultaPrateleira: TSpeedButton;
    EdPrateleira: TMaskEdit;
    EdComissao: TEdit;
    EdPrecoCusto: TEdit;
    edMargemLucro: TEdit;
    EdPrecoCustoBruto: TEdit;
    EdBruto: TEdit;
    EdLiquido: TEdit;
    EdDimensao: TEdit;
    EdVolume: TEdit;
    EdMinimo: TEdit;
    EdMaximo: TEdit;
    EdAtual: TEdit;
    BtnConsultaTabelaPreco: TSpeedButton;
    EdPrecoTabela: TEdit;
    EdPrecoPreco: TEdit;
    LblPrecoTabela: TLabel;
    EdGrupo: TEdit;
    EdSubGrupo: TEdit;
    EdTipo: TEdit;
    PanBarCode: TPanel;
    Label9: TLabel;
    GrdBarCode: TDBGrid;
    PanBarCodeEdit: TPanel;
    EdBarCode: TEdit;
    BtnBarCodeAdicionar: TSpeedButton;
    BtnBarCodeExcluir: TSpeedButton;
    EdDataDeReposicao: TDateTimePicker;
    DSourcePreco: TDataSource;
    DSourceICMS: TDataSource;
    JvBalloonHint: TJvBalloonHint;
    ActBarCodeAdicionar: TAction;
    ActBarCodeExcluir: TAction;
    DSourceBarCode: TDataSource;
    Label11: TLabel;
    CmbLote: TComboBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnConsultaSubGrupoClick(Sender: TObject);
    procedure BtnConsultaGrupoClick(Sender: TObject);
    procedure BtnConsultaTipoClick(Sender: TObject);
    procedure EdGrupoExit(Sender: TObject);
    procedure EdSubGrupoExit(Sender: TObject);
    procedure EdTipoExit(Sender: TObject);
    procedure PorcentInF(Sender: TObject);
    procedure PorcentOutF(Sender: TObject);
    procedure CurrencyInF(Sender: TObject);
    procedure Peso(Sender: TObject);
    procedure CurrencyOutF(Sender: TObject);
    procedure BtnConsultaSituacaoTributariaClick(Sender: TObject);
    procedure BtnConsultaClassificacaoFiscalClick(Sender: TObject);
    procedure BtnConsultaSecaoClick(Sender: TObject);
    procedure BtnConsultaPrateleiraClick(Sender: TObject);
    procedure EdClassificaoFiscalExit(Sender: TObject);
    procedure EdSituacaoTributariaExit(Sender: TObject);
    procedure EdIPIEnter(Sender: TObject);
    procedure EdIPIExit(Sender: TObject);
    procedure EdSecaoExit(Sender: TObject);
    procedure EdPrateleiraExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ActSalvarExecute(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure PageControlMainChange(Sender: TObject);
    procedure ActICMSNovoExecute(Sender: TObject);
    procedure ActICMSCancelarExecute(Sender: TObject);
    procedure ActICMSSalvarExecute(Sender: TObject);
    procedure ActICMSEditarExecute(Sender: TObject);
    procedure ActICMSExcluirExecute(Sender: TObject);
    procedure PageControlMainChanging(Sender: TObject;
      var AllowChange: Boolean);
    procedure MemDescricaoEnter(Sender: TObject);
    procedure MemDescricaoExit(Sender: TObject);
    procedure BtnConsultaTabelaPrecoClick(Sender: TObject);
    procedure ActPrecoSalvarExecute(Sender: TObject);
    procedure ActPrecoExcluirExecute(Sender: TObject);
    procedure ActPrecoCancelarExecute(Sender: TObject);
    procedure ActPrecoNovoExecute(Sender: TObject);
    procedure ActPrecoEditarExecute(Sender: TObject);
    procedure EdPrecoTabelaExit(Sender: TObject);
    procedure edIndiceEcfKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdPrecoPrecoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ShowBallon(Sender: TObject);
    procedure ActBarCodeAdicionarExecute(Sender: TObject);
    procedure ActBarCodeExcluirExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    function UnidadeDeVenda: string; overload;
    function UnidadeDeVenda(Unidade: string): Integer; overload;
    procedure SqlProdutos;
    procedure SqlEstoque;
    procedure LoadData(Codigo: String);
    function Validacao: Boolean;
    procedure ICMS;
    procedure TabelaPreco;
    procedure BarCode;
    procedure LockButtons(Status: Boolean);
  public
    Estado: TDataSetState;
    DsICMS: TDataSet;
    DsPreco: TDataSet;
    DsBarCode: TDataSet;
    EstadoICMS: TDataSetState;
    EstadoTabelaPreco: TDataSetState;
    StrAux: string;
  end;

var
  fCadastro: TfCadastro;

implementation

uses uDm, uMain, uConsultaSubGrupos, uConsultaGrupo, uConsultaTipo,
  uSituacaoTributaria, uConsultaClassificacaoFiscal, uConsultaPrateleira,
  uConsultaSecao, Math, DateUtils, uConsultaEstado, uConsultaPreco;

{$R *.dfm}

{§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§}
{                                PROCEDIMENTOS                                 }
{§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§}
procedure TfCadastro.LoadData(Codigo: String);
var
  Ds: TDataSet;
begin
  try
    RunSQL('SELECT * FROM PRODUTO WHERE CODIGOPRODUTO = ' + Codigo, Dm.DBAutocom,Ds);
    EdCodigo.Text := Ds.FieldByName('CODIGOPRODUTO').AsString;
    EdCodReferencia.Text := Ds.FieldByName('ABREVIATURA').AsString;
    EdNome.Text := Ds.FieldByName('NOMEPRODUTO').AsString;
    EdGrupo.Text := KeyLookUp('CODIGOSUBGRUPOPRODUTO','CODIGOGRUPOPRODUTO','SUBGRUPOPRODUTO',Ds.FieldByName('CODIGOSUBGRUPOPRODUTO').AsString,Dm.DBAutocom);
    EdSubGrupo.Text := KeyLookUp('CODIGOSUBGRUPOPRODUTO','CODIGOSUBGRUPO','SUBGRUPOPRODUTO',Ds.FieldByName('CODIGOSUBGRUPOPRODUTO').AsString,Dm.DBAutocom);
    CmbUnidade.ItemIndex := UnidadeDeVenda(Ds.FieldByName('UNIDADE').AsString);
    EdBruto.Text := Ds.FieldByName('PESOBRUTO').AsString;
    EdLiquido.Text := Ds.FieldByName('PESOLIQUIDO').AsString;
    EdDimensao.Text := Ds.FieldByName('DIMENSAOCAIXA').AsString;
    EdVolume.Text := Ds.FieldByName('VOLUME').AsString;
    EdClassificaoFiscal.Text := Ds.FieldByName('CODIGOCLASSIFICACAOFISCAL').AsString;
    EdSituacaoTributaria.Text := Ds.FieldByName('CODIGOSITUACAOTRIBUTARIA').AsString;
    MemDescricao.Text := Ds.FieldByName('DESCRICAO').AsString;
    MemIndicacao.Text := Ds.FieldByName('INDICACAO').AsString;
    MemAplicacao.Text := Ds.FieldByName('APLICACAO').AsString;
    EdIPI.Text := Ds.FieldByName('ALIQUOTAIPI').AsString;
    EdComissao.Text := Ds.FieldByName('PERCENTUALCOMISSAO').AsString;
    EdTipo.Text := KeyLookUp('CODTIPOPRODUTO','CODIGOTIPOPRODUTO','TIPOPRODUTO',Ds.FieldByName('CODTIPOPRODUTO').AsString,Dm.DBAutocom);
    CmbCasas.ItemIndex := IfThen((Ds.FieldByName('DECIMAIS').AsString = '2'),0,1);
    CmbLote.ItemIndex := IfThen(Ds.FieldByName('USUAL').AsString = '1',0,1);

    RunSQL('SELECT * FROM ESTOQUE WHERE CODIGOPRODUTO = ' + Codigo, Dm.DBAutocom, Ds);
    EdMinimo.Text := Ds.FieldByName('ESTOQUEMINIMO').AsString;
    EdMaximo.Text := Ds.FieldByName('ESTOQUEMAXIMO').AsString;
    EdAtual.Text := Ds.FieldByName('ESTOQUEATUAL').AsString;
    EdDataDeReposicao.DateTime := StrToDateTimeDef(Ds.FieldByName('DATAREPOSICAO').AsString,Date);
    EdPrecoCusto.Text := Ds.FieldByName('PRECOREPOSICAO').AsString;
    EdPrecoCustoBruto.Text := Ds.FieldByName('PRECOREPOSICAOBRUTO').AsString;
    EdSecao.Text := KeyLookUp('CODSECAO','CODIGOSECAO','SECAO',KeyLookUp('CODPRATELEIRA','CODSECAO','PRATELEIRA',Ds.FieldByName('CODPRATELEIRA').AsString,dM.DBAutocom),Dm.DBAutocom);;
    EdPrateleira.Text := KeyLookUp('CODPRATELEIRA','CODIGOPRATELEIRA','PRATELEIRA',Ds.FieldByName('CODPRATELEIRA').AsString,Dm.DBAutocom);
    edMargemLucro.Text := Ds.FieldByName('MARGEMLUCRO').AsString;

    FreeAndNil(Ds);
    {Aciona Rotinas de Formatação}
    EdGrupoExit(EdGrupo);
    EdSubGrupoExit(EdSubGrupo);
    EdTipoExit(EdTipo);
    EdClassificaoFiscalExit(EdClassificaoFiscal);
    EdSituacaoTributariaExit(EdSituacaoTributaria);
    EdSecaoExit(EdSecao);
    EdPrateleiraExit(EdPrateleira);
    CurrencyOutF(EdPrecoCusto);
    CurrencyOutF(EdPrecoCustoBruto);
    PorcentOutF(edMargemLucro);
    PorcentOutF(EdComissao);
    PorcentOutF(EdIPI);
    Peso(EdBruto);
    Peso(EdLiquido);
    Peso(EdMinimo);
    Peso(EdMaximo);
    Peso(EdAtual);
  except
    Application.MessageBox('Ocorreu um erro na tentativa de carregar os dados deste produto',Autocom,MB_ICONERROR);
  end;
end;

procedure TfCadastro.SqlProdutos;
begin
  case Estado  of
    dsInsert:
      begin
        RunSQL(
          ' INSERT INTO PRODUTO (CODIGOPRODUTO, PRODUTO, ABREVIATURA, NOMEPRODUTO, CODIGOSUBGRUPOPRODUTO, UNIDADE, ' +
          ' PESOBRUTO, PESOLIQUIDO, DIMENSAOCAIXA, VOLUME, CODIGOCLASSIFICACAOFISCAL,' +
          ' CODIGOSITUACAOTRIBUTARIA, DESCRICAO, INDICACAO, APLICACAO, ALIQUOTAIPI, '+
          ' PERCENTUALCOMISSAO, CODTIPOPRODUTO, DECIMAIS, PRODUTODEBALANCA, USUAL , ORDEM) VALUES (' +
          EdCodigo.Text + ', ' +
          '0,'+
          QuotedStr(EdCodReferencia.Text) + ', ' +
          QuotedStr(EdNome.Text) + ', ' +
          KeyLookUp('CODIGOSUBGRUPO','CODIGOSUBGRUPOPRODUTO','SUBGRUPOPRODUTO',EdSubGrupo.Text,Dm.DBAutocom) + ', ' +
          QuotedStr(UnidadeDeVenda) + ', ' +
          StringReplace(EdBruto.Text,',','.',[]) + ', ' +
          StringReplace(EdLiquido.Text,',','.',[]) + ', ' +
          QuotedStr(EdDimensao.Text) + ', ' +
          StringReplace(EdVolume.Text,',','.',[]) + ', ' +
          EdClassificaoFiscal.Text + ', ' +
          EdSituacaoTributaria.Text + ', ' +
          QuotedStr(MemDescricao.Text) + ', ' +
          QuotedStr(MemIndicacao.Text) + ', ' +
          QuotedStr(MemAplicacao.Text) + ', ' +
          StringReplace(EdIPI.Text,',','.',[]) + ', ' +
          StringReplace(EdComissao.Text,',','.',[]) + ', ' +
          KeyLookUp('CODIGOTIPOPRODUTO','CODTIPOPRODUTO','TIPOPRODUTO',EdTipo.Text,Dm.DBAutocom) + ', ' +
          CmbCasas.Text + ', ' +
          QuotedStr('F') + ', ' +
          QuotedStr(IfThen(CmbLote.ItemIndex = 0,'1','0')) + ', ' +
          '1' + ')'
          ,Dm.DBAutocom);
        LogSend('logs\CADPROD' + FormatDateTime('yyyymmdd',Now)+'.log','Inclusão na tabela de produtos referente ao produto de código ' + EdCodigo.Text);
      end;
    dsEdit:
      begin
        RunSQL(
          ' UPDATE PRODUTO SET ' +
          ' ABREVIATURA = ' + QuotedStr(EdCodReferencia.Text) + ', ' +
          ' NOMEPRODUTO = ' + QuotedStr(EdNome.Text) + ', ' +
          ' CODIGOSUBGRUPOPRODUTO = ' + KeyLookUp('CODIGOSUBGRUPO','CODIGOSUBGRUPOPRODUTO','SUBGRUPOPRODUTO',EdSubGrupo.Text,Dm.DBAutocom) + ', ' +
          ' UNIDADE = ' + QuotedStr(UnidadeDeVenda) + ', ' +
          ' PESOBRUTO = ' + StringReplace(EdBruto.Text,',','.',[]) + ', ' +
          ' PESOLIQUIDO = ' + StringReplace(EdLiquido.Text,',','.',[]) + ', ' +
          ' DIMENSAOCAIXA = ' + QuotedStr(EdDimensao.Text) + ', ' +
          ' VOLUME = ' + StringReplace(EdVolume.Text,',','.',[]) + ', ' +
          ' CODIGOCLASSIFICACAOFISCAL = ' + EdClassificaoFiscal.Text + ', ' +
          ' CODIGOSITUACAOTRIBUTARIA = ' + EdSituacaoTributaria.Text + ', ' +
          ' DESCRICAO = ' + QuotedStr(MemDescricao.Text) + ', ' +
          ' INDICACAO = ' + QuotedStr(MemIndicacao.Text) + ', ' +
          ' APLICACAO = ' + QuotedStr(MemAplicacao.Text) + ', ' +
          ' ALIQUOTAIPI = ' + StringReplace(EdIPI.Text,',','.',[]) + ', ' +
          ' PERCENTUALCOMISSAO = ' + StringReplace(EdComissao.Text,',','.',[]) + ', ' +
          ' CODTIPOPRODUTO = ' + KeyLookUp('CODIGOTIPOPRODUTO','CODTIPOPRODUTO','TIPOPRODUTO',EdTipo.Text,Dm.DBAutocom) + ', ' +
          ' DECIMAIS = ' + CmbCasas.Text + ', ' +
          ' PRODUTODEBALANCA = ' + QuotedStr('F') + ', ' +
          ' USUAL = ' + QuotedStr(IfThen(CmbLote.ItemIndex = 0,'1','0')) + ' ' +
          ' WHERE CODIGOPRODUTO = ' + EdCodigo.Text,Dm.DBAutocom);
        LogSend('logs\CADPROD' + FormatDateTime('yyyymmdd',Now)+'.log','Alteração na tabela de produtos referente ao produto de código ' + EdCodigo.Text);
      end;
  end;
end;

procedure TfCadastro.SqlEstoque;
var
 DsAux: TDataSet;
begin
  case Estado of
    dsInsert:
      begin
        RunSQL('SELECT MAX(CODIGOESTOQUE) FROM ESTOQUE',Dm.DBAutocom,DsAux);
        RunSQL(
         'INSERT INTO ESTOQUE (CODIGOESTOQUE, CODIGOPRODUTO, ' +
         'ESTOQUEMINIMO, ESTOQUEMAXIMO, DATAREPOSICAO, PRECOREPOSICAO, ' +
         'PRECOREPOSICAOBRUTO, CODPRATELEIRA, MARGEMLUCRO, CFG_CODCONFIG, LOTE) VALUES (' +
          IntToStr(DsAux.Fields[0].AsInteger + 1) + ', ' +
          EdCodigo.Text + ', ' +
          StringReplace(EdMinimo.Text,',','.',[]) + ', ' +
          StringReplace(EdMaximo.Text,',','.',[]) + ', ' +
          QuotedStr(FormatDateTime('MM/DD/YYYY',EdDataDeReposicao.DateTime)) + ', ' +
          StringReplace(EdPrecoCusto.Text,',','.',[]) + ', ' +
          StringReplace(EdPrecoCustoBruto.Text,',','.',[]) + ', ' +
          KeyLookUp('CODIGOPRATELEIRA','CODPRATELEIRA','PRATELEIRA',EdPrateleira.Text,Dm.DBAutocom) + ', ' +
          StringReplace(edMargemLucro.Text,',','.',[]) + ', ' + '1,'+quotedstr('0') + ')',
          Dm.DBAutocom);
        LogSend('logs\CADPROD' + FormatDateTime('yyyymmdd',Now)+'.log','Inclusão na tabela de estoque referente ao produto de código ' + EdCodigo.Text);
     end;
    dsEdit:
      begin
      RunSQL(
       ' UPDATE ESTOQUE SET ' +
       ' ESTOQUEMINIMO = ' + StringReplace(EdMinimo.Text,',','.',[]) + ', ' +
       ' ESTOQUEMAXIMO = ' + StringReplace(EdMaximo.Text,',','.',[]) + ', ' +
       ' DATAREPOSICAO = ' + QuotedStr(FormatDateTime('MM/DD/YYYY',EdDataDeReposicao.DateTime)) + ', ' +
       ' PRECOREPOSICAO = ' + StringReplace(EdPrecoCusto.Text,',','.',[]) + ', ' +
       ' PRECOREPOSICAOBRUTO = ' + StringReplace(EdPrecoCustoBruto.Text,',','.',[]) + ', ' +
       ' CODPRATELEIRA = ' + KeyLookUp('CODIGOPRATELEIRA','CODPRATELEIRA','PRATELEIRA',EdPrateleira.Text,Dm.DBAutocom) + ', ' +
       ' MARGEMLUCRO = ' + StringReplace(edMargemLucro.Text,',','.',[]) +
       ' WHERE CODIGOPRODUTO = ' + EdCodigo.Text
       , Dm.DBAutocom);
      LogSend('logs\CADPROD' + FormatDateTime('yyyymmdd',Now)+'.log','Alteração na tabela de estoque referente ao produto de código ' + EdCodigo.Text);
      end;
  end;
  FreeAndNil(DsAux);
end;

procedure TfCadastro.ICMS;
var
  i: Integer;
begin
  RunSQL('Commit;',Dm.DBAutocom);
  RunSQL('SELECT UF, ALIQUOTA, REDUCAO, SUBSTITUICAO, TIPO, UF_DESCRICAO FROM ICMSPRODUTO WHERE CODIGOPRODUTO = ' + EdCodigo.Text, Dm.DBAutocom, DsICMS);
  DSourceICMS.DataSet := DsICMS;
  (DsICMS.FieldByName('ALIQUOTA') as TNumericField).DisplayFormat := '0.00%';
  (DsICMS.FieldByName('REDUCAO') as TNumericField).DisplayFormat := '0.00%';
  (DsICMS.FieldByName('SUBSTITUICAO') as TNumericField).DisplayFormat := '0.00%';

  GrdICMS.Columns[0].Color := $00EFD3C6;

  for i := 0 to 3 do
    begin
     GrdICMS.Columns[i].Width := 155;
     GrdICMS.Columns[i].Alignment := taLeftJustify;
    end;

  GrdICMS.Columns[0].Title.Caption := 'Estado';
  GrdICMS.Columns[1].Title.Caption := 'Alíquota';
  GrdICMS.Columns[2].Title.Caption := 'Redução';
  GrdICMS.Columns[3].Title.Caption := 'Substituição';
  GrdICMS.Columns[4].Visible := False;
  GrdICMS.Columns[5].Visible := False;
end;

procedure TfCadastro.LockButtons(Status: Boolean);
begin
  if Status then
    begin
      ActSalvar.Enabled := False;
      ActExcluir.Enabled := False;
      ActCancelar.Enabled := False;
    end
  else
    begin
      ActSalvar.Enabled := True;
      ActExcluir.Enabled := True;
      ActCancelar.Enabled := True;
    end;
end;

procedure TfCadastro.TabelaPreco;
begin
  RunSQL('Commit;',Dm.DBAutocom);
  RunSQL('SELECT TP.TABELAPRECO, PTP.PRECO,  PTP.CODIGOPRODUTOTABELAPRECO, TP.CODIGOTABELA FROM PRODUTOTABELAPRECO PTP INNER JOIN TABELAPRECO TP ON(TP.CODIGOTABELAPRECO = PTP.CODIGOTABELAPRECO) WHERE PTP.CODIGOPRODUTO = ' + EdCodigo.Text, Dm.DBAutocom, DsPreco);
  DSourcePreco.DataSet := DsPreco;

  (DsPreco.FieldByName('PRECO') as TNumericField).DisplayFormat := CurrencyString +  '0.00';
  GrdPreco.Columns[0].Color := $00EFD3C6;
  GrdPreco.Columns[1].Alignment := taLeftJustify;
  GrdPreco.Columns[0].Title.Caption := 'Tabela';
  GrdPreco.Columns[1].Title.Caption := 'Preço';
  GrdPreco.Columns[0].Width := 450;
  GrdPreco.Columns[1].Width := 170;
  GrdPreco.Columns[2].Visible := False;
  GrdPreco.Columns[3].Visible := False;
end;

procedure TfCadastro.BarCode;
begin
  RunSQL('Commit;',Dm.DBAutocom);
  RunSQL('SELECT CODIGOPRODUTOASSOCIADO FROM PRODUTOASSOCIADO WHERE CODIGOPRODUTO = ' + EdCodigo.Text +' ORDER BY CODIGOPRODUTOASSOCIADO', Dm.DBAutocom, DsBarCode);
  DSourceBarCode.DataSet := DsBarCode;
  GrdBarCode.Columns[0].Alignment := taLeftJustify;
  GrdBarCode.Columns[0].Width := 450;
end;


{§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§}
{                                     FUNCÕES                                  }
{§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§}

function TfCadastro.UnidadeDeVenda: string;
begin
  case CmbUnidade.ItemIndex of
    0 : Result := 'GF';
    1 : Result := 'UN';
    2 : Result := 'KG';
    3 : Result := 'L';
    4 : Result := 'M';
    5 : Result := 'PC';
    6 : Result := 'CX';
    7 : Result := 'BR';
    8 : Result := 'CJ';
    9 : Result := 'PT';
    10 : Result := 'FR';
  end;
end;

function TfCadastro.UnidadeDeVenda(Unidade: string): integer;
begin
    if Unidade = 'GF' then Result := 0
    else if Unidade = 'UN' then Result := 1
    else if Unidade ='KG' then Result := 2
    else if Unidade = 'L' then Result := 3
    else if Unidade = 'M' then Result := 4
    else if Unidade = 'PC' then Result := 5
    else if Unidade = 'CX' then Result := 6
    else if Unidade = 'BR' then Result := 7
    else if Unidade = 'CJ' then Result := 8
    else if Unidade = 'PT' then Result := 9
    else if Unidade = 'FR' then Result := 10
end;

function TfCadastro.Validacao: Boolean;
begin
  Result := True;
  PageControlMain.TabIndex := 0;
  if IsEditNull('Nome',EdNome) then
    begin
      Result := False;
      Exit;
    end;
  if IsEditNull('Grupo',EdGrupo) then
    begin
       Result := False;
       Exit;
    end;
  if IsEditNull('Sub-Grupo',EdSubGrupo) then
    begin
       Result := False;
       Exit;
    end;
  if IsEditNull('Tipo',EdTipo) then
    begin
       Result := False;
       Exit;
    end;
  PageControlMain.TabIndex := 1;
  if IsEditNull('Classificação Fiscal',EdClassificaoFiscal) then
    begin
       Result := False;
       Exit;
    end;
  if IsEditNull('Situação Tributária',EdSituacaoTributaria) then
    begin
       Result := False;
       Exit;
    end;
  PageControlMain.TabIndex := 2;
  if IsEditNull('Seção',EdSecao) then
    begin
       Result := False;
       Exit;
    end;
  if IsEditNull('Prateleira',EdPrateleira) then
    begin
       Result := False;
       Exit;
    end;
  if Estado = DsEdit then
    if DsICMS.IsEmpty then
      begin
        PageControlMain.TabIndex := 1;
        Application.MessageBox('É necessario inserir ao menos uma alíquota de ICMS, Verifique!',Autocom,MB_ICONEXCLAMATION);
        Result := False;
        Exit;
      end;
end;


{§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§}
{                                      EVENTOS                                 }
{§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§§}

procedure TfCadastro.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN:  Perform(WM_NEXTDLGCTL, 0, 0);
    VK_F1:
      begin
        if ActiveControl = EdGrupo then BtnConsultaGrupo.Click
        else if ActiveControl = EdSubGrupo then BtnConsultaSubGrupo.Click
        else if ActiveControl = EdTipo then BtnConsultaTipo.Click
        else if ActiveControl = EdSituacaoTributaria then BtnConsultaSituacaoTributaria.Click
        else if ActiveControl = EdClassificaoFiscal then BtnConsultaClassificacaoFiscal.Click
        else if ActiveControl = EdSecao then BtnConsultaSecao.Click
        else if ActiveControl = EdPrateleira then BtnConsultaPrateleira.Click
        else if ActiveControl = EdPrecoTabela then BtnConsultaTabelaPreco.Click;
      end;
  end;
end;

procedure TfCadastro.BtnConsultaSubGrupoClick(Sender: TObject);
begin
  if IsNull(EdGrupo.Text) or (StrToIntDef(EdGrupo.Text,0) = 0) then
    begin
      MessageBox(Handle,'Antes é necessario selecionar um grupo!',Autocom,MB_ICONWARNING);
      EdGrupoExit(EdGrupo);
      Exit;
    end;
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

procedure TfCadastro.BtnConsultaGrupoClick(Sender: TObject);
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

procedure TfCadastro.BtnConsultaTipoClick(Sender: TObject);
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

procedure TfCadastro.EdGrupoExit(Sender: TObject);
var
  DataSetLookUp: TDataSet;
begin
  FormatEdit(Sender,Float,3,0);
  if (IsNull((Sender as TEdit).Text)) or (StrToFloatDef((Sender as TEdit).Text,0) = 0)  then
    begin
      (Sender as TEdit).Clear;
      EdSubGrupo.Clear;
      LblGrupo.Caption := NullAsStringValue;
      LblSubGrupo.Caption := NullAsStringValue;
      Exit;
    end;
  RunSQL('SELECT CODIGOGRUPOPRODUTO, GRUPOPRODUTO FROM GRUPOPRODUTO  WHERE CODIGOGRUPOPRODUTO = ' +  (Sender as TEdit).Text + ' ORDER BY GRUPOPRODUTO', Dm.DBAutocom, DataSetLookUp);
  if DataSetLookUp.IsEmpty then
    begin
      MessageBox(Handle,'Digite um código válido para o campo grupo!',Autocom,MB_ICONWARNING);
      (Sender as TEdit).SetFocus;
      Exit;
    end;
  LblGrupo.Caption := DataSetLookUp.Fields[1].AsString;
  FreeAndNil(DataSetLookUp);
  JvBalloonHint.CancelHint;
end;

procedure TfCadastro.EdSubGrupoExit(Sender: TObject);
var
  DataSetLookUp: TDataSet;
begin
  FormatEdit(Sender,Float,3,0);
  if IsNull((Sender as TEdit).Text) or (StrToFloatDef((Sender as TEdit).Text,0) = 0) then
  begin
    (Sender as TEdit).Clear;
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

  RunSQL('SELECT CODIGOSUBGRUPO , SUBGRUPO FROM SUBGRUPOPRODUTO WHERE CODIGOSUBGRUPO = ' + fCadastro.EdSubGrupo.Text + ' AND CODIGOGRUPOPRODUTO = ' + EdGrupo.Text, Dm.DBAutocom, DataSetLookUp);
  if DataSetLookUp.IsEmpty then
    begin
      MessageBox(Handle,'Digite um código válido para o campo sub-grupo!',Autocom,MB_ICONWARNING);
      (Sender as TEdit).SetFocus;
      Exit;
    end;
  LblSubGrupo.Caption := DataSetLookUp.Fields[1].AsString;
  FreeAndNil(DataSetLookUp);
  JvBalloonHint.CancelHint;
end;

procedure TfCadastro.EdTipoExit(Sender: TObject);
var
  DataSetLookUp: TDataSet;
begin
  FormatEdit(Sender,Float,3,0);
  if (IsNull((Sender as TEdit).Text)) or (StrToFloatDef((Sender as TEdit).Text,0) = 0) then
    begin
      (Sender as TEdit).Clear;
      LblTipo.Caption := NullAsStringValue;
      Exit;
    end;
  RunSQL('SELECT CODIGOTIPOPRODUTO , DESCRICAO FROM TIPOPRODUTO WHERE CODIGOTIPOPRODUTO = ' +  (Sender as TEdit).Text, Dm.DBAutocom, DataSetLookUp);
  if DataSetLookUp.IsEmpty then
    begin
      MessageBox(Handle,'Digite um código válido para o campo tipo!',Autocom,MB_ICONWARNING);
      (Sender as TEdit).SetFocus;
      Exit;
    end;
  LblTipo.Caption := DataSetLookUp.Fields[1].AsString;
  FreeAndNil(DataSetLookUp);
  JvBalloonHint.CancelHint;
end;

procedure TfCadastro.CurrencyInF(Sender: TObject);
begin
  FormatEdit(Sender,CurrencyIn);
end;

procedure TfCadastro.CurrencyOutF(Sender: TObject);
begin
  FormatEdit(Sender,CurrencyOut);
end;

procedure TfCadastro.PorcentInF(Sender: TObject);
begin
  FormatEdit(Sender,PorcentIn);
end;

procedure TfCadastro.PorcentOutF(Sender: TObject);
begin
  FormatEdit(Sender,PorcentOut);
end;

procedure TfCadastro.BtnConsultaSituacaoTributariaClick(Sender: TObject);
begin

  with TfSituacaoTributaria.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  EdSituacaoTributaria.Text := FormatFloat('000',ResultConsultaCodigo);
  LblSituacaoTributaria.Caption := ResultConsultaNome;
  EdSituacaoTributaria.SetFocus;
end;

procedure TfCadastro.BtnConsultaClassificacaoFiscalClick(Sender: TObject);
begin
  with TfConsultaClassificacaoFiscal.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  EdClassificaoFiscal.Text := FormatFloat('000',ResultConsultaCodigo);
  LblClassificacaoFiscal.Caption := ResultConsultaNome;
  EdClassificaoFiscal.SetFocus;
end;

procedure TfCadastro.BtnConsultaSecaoClick(Sender: TObject);
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

procedure TfCadastro.BtnConsultaPrateleiraClick(Sender: TObject);
begin
  if IsNull(EdSecao.Text) then
    begin
      MessageBox(Handle,'Antes é necessario selecionar uma seção!',Autocom,MB_ICONWARNING);
      EdSecao.SetFocus;
      Exit;
    end;
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

procedure TfCadastro.EdClassificaoFiscalExit(Sender: TObject);
var
  DataSetLookUp: TDataSet;
begin
  FormatEdit(Sender,Float,3,0);
  if (IsNull((Sender as TCustomEdit).Text) or (StrToFloatDef((Sender as TCustomEdit).Text,0) = 0))  then
    begin
      (Sender as TCustomEdit).Clear;
      LblClassificacaoFiscal.Caption := NullAsStringValue;
      Exit;
    end;
  RunSQL('SELECT CODIGOCLASSIFICACAOFISCAL, CLASSIFICACAOFISCAL FROM CLASSIFICACAOFISCAL WHERE CODIGOCLASSIFICACAOFISCAL = ' +  (Sender as TCustomEdit).Text + ' ORDER BY CLASSIFICACAOFISCAL', Dm.DBAutocom, DataSetLookUp);
  if DataSetLookUp.IsEmpty then
    begin
      MessageBox(Handle,'Digite um código válido para o campo classificação fiscal!',Autocom,MB_ICONWARNING);
      (Sender as TCustomEdit).SetFocus;
      Exit;
    end;
  LblClassificacaoFiscal.Caption := DataSetLookUp.Fields[1].AsString;
  FreeAndNil(DataSetLookUp);
  JvBalloonHint.CancelHint;
end;

procedure TfCadastro.EdSituacaoTributariaExit(Sender: TObject);
var
  DataSetLookUp: TDataSet;
begin
  FormatEdit(Sender,Float,3,0);
  if (IsNull((Sender as TCustomEdit).Text) or (StrToFloatDef((Sender as TCustomEdit).Text,0) = 0))  then
    begin
      (Sender as TCustomEdit).Clear;
      LblSituacaoTributaria.Caption := NullAsStringValue;
      Exit;
    end;
  RunSQL('SELECT CODIGOSITUACAOTRIBUTARIA ,SITUACAOTRIBUTARIA FROM SITUACAOTRIBUTARIA WHERE CODIGOSITUACAOTRIBUTARIA = ' +  (Sender as TCustomEdit).Text + ' ORDER BY SITUACAOTRIBUTARIA', Dm.DBAutocom, DataSetLookUp);
  if DataSetLookUp.IsEmpty then
    begin
      MessageBox(Handle,'Digite um código válido para o campo situação tributária!',Autocom,MB_ICONWARNING);
      (Sender as TCustomEdit).SetFocus;
      Exit;
    end;
  LblSituacaoTributaria.Caption := DataSetLookUp.Fields[1].AsString;
  FreeAndNil(DataSetLookUp);
  JvBalloonHint.CancelHint;
end;

procedure TfCadastro.EdIPIEnter(Sender: TObject);
begin
  FormatEdit(Sender,PorcentIn);
end;

procedure TfCadastro.EdIPIExit(Sender: TObject);
begin
  FormatEdit(Sender,PorcentOut);
end;

procedure TfCadastro.EdSecaoExit(Sender: TObject);
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
      (Sender as TCustomEdit).SetFocus;
      Exit;
    end;
  LblSecao.Caption := DataSetLookUp.Fields[1].AsString;
  FreeAndNil(DataSetLookUp);
  JvBalloonHint.CancelHint;
end;

procedure TfCadastro.EdPrateleiraExit(Sender: TObject);
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
      (Sender as TCustomEdit).SetFocus;
      Exit;
    end;
  LblPrateleira.Caption := DataSetLookUp.Fields[0].AsString;
  FreeAndNil(DataSetLookUp);
  JvBalloonHint.CancelHint;
end;

procedure TfCadastro.Peso(Sender: TObject);
begin
  FormatEdit(Sender,Float,0,3);
end;

procedure TfCadastro.FormShow(Sender: TObject);
var
  Ds: TDataSet;
begin
  fMain.JvBalloonHint.CancelHint;
  DataBaseAutocom := Dm.DBAutocom;
  PageControlMain.TabIndex := 0;
  PageControlDescricao.TabIndex := 0;
  case Estado of
    dsEdit:
      begin
        LoadData(Dm.QrProdutoCODIGOPRODUTO.AsString);
        PanBarCode.Visible := True;
        PanAliquotas.Visible := True;
        TabelaPreco;
        ICMS;
        BarCode;
      end;
    dsInsert:
      begin
        ClearEdits(fCadastro);
        PanBarCode.Visible := False;
        PanAliquotas.Visible := False;
        CmbUnidade.ItemIndex := 0;
        CmbCasas.ItemIndex := 0;
        CmbAliquotaTipo.ItemIndex := 0;
        LblGrupo.Caption := NullAsStringValue;
        LblSubGrupo.Caption := NullAsStringValue;
        LblTipo.Caption := NullAsStringValue;
        LblIPI.Caption := NullAsStringValue;
        LblClassificacaoFiscal.Caption := NullAsStringValue;
        LblSecao.Caption := NullAsStringValue;
        LblSituacaoTributaria.Caption := NullAsStringValue;
        LblPrateleira.Caption := NullAsStringValue;
        LblTipo.Caption := NullAsStringValue;
        PorcentOutF(EdComissao);
        PorcentOutF(EdMargemLucro);
        PorcentOutF(EdIPI);
        CurrencyOutF(EdPrecoCusto);
        CurrencyOutF(EdPrecoCustoBruto);
        Peso(EdBruto);
        Peso(EdLiquido);
        Peso(EdVolume);
        Peso(EdMinimo);
        Peso(EdMaximo);
        Peso(EdAtual);
        if IntAux <> 0 then
        EdCodigo.Text := IntToStr(IntAux);
      end;
  end;
  if IsNull(EdCodigo.Text) then
    begin
      RunSQL('SELECT MAX(CODIGOPRODUTO) FROM PRODUTO',Dm.DBAutocom,DS);
      EdCodigo.Text := IntToStr(Ds.Fields[0].AsInteger+1);
    end;
  EnableFields(False, PanPrecoEdit);
  EdCodReferencia.SetFocus;
  FreeAndNil(Ds);
end;

procedure TfCadastro.ActSalvarExecute(Sender: TObject);
begin
  if MessageBox(Handle,'Deseja salvar as alterações?',Autocom,MB_ICONQUESTION + MB_YESNO) = ID_YES then
    begin
      if not Validacao then Exit;

      {Aciona Rotinas de Formatação}
      CurrencyInF(EdPrecoCusto);
      CurrencyInF(EdPrecoCustoBruto);
      PorcentInF(edMargemLucro);
      PorcentInF(EdComissao);
      PorcentInF(EdIPI);
      Peso(EdVolume);
      Peso(EdLiquido);
      Peso(EdBruto);
      SqlProdutos;
      SqlEstoque;

      if Estado = dsInsert then
        begin
          Application.MessageBox('Agora preencha a tabela de preços e insira as alíquotas de ICMS',Autocom,MB_ICONINFORMATION);
          PanBarCode.Visible := True;
          PanAliquotas.Visible := True;
          Estado := dsEdit;
          PageControlMain.TabIndex := 3;
          ICMS;
          TabelaPreco;
          BarCode;
        end
      else
        Close;
    end;
end;

procedure TfCadastro.ActCancelarExecute(Sender: TObject);
begin
  Close;
end;


procedure TfCadastro.PageControlMainChange(Sender: TObject);
begin
  if Estado = dsInsert then
    if PageControlMain.TabIndex = 3 then
      PageControlMain.TabIndex := 2;
end;

procedure TfCadastro.ActICMSNovoExecute(Sender: TObject);
begin
    EstadoICMS := dsInsert;
    LockButtons(True);
    EnableFields(True, PanAliquotaFields);

    PorcentOutF(edAliquota);
    PorcentOutF(edReducao);
    PorcentOutF(edSubstituicao);
    edIndiceEcf.Text := '0';

    ActICMSEditar.Enabled := False;
    ActICMSExcluir.Enabled := False;
    ActICMSNovo.Enabled := False;
    ActICMSSalvar.Enabled := True;
    ActICMSCancelar.Enabled := True;
    
    MessageBox(Handle,'Selecione um Estado','Sistema Autocom Plus',MB_ICONINFORMATION);
    with TfConsultaEstado.Create(Self) do
      begin
        ShowModal;
        edEstado.Text := StrAux;
        Free;
      end;
    CmbAliquotaTipo.SetFocus;
end;

procedure TfCadastro.ActICMSCancelarExecute(Sender: TObject);
begin
  EnableFields(False, PanAliquotaFields);
  ActICMSEditar.Enabled := True;
  ActICMSExcluir.Enabled := True;
  ActICMSNovo.Enabled := True;
  ActICMSSalvar.Enabled := False;
  ActICMSCancelar.Enabled := False;
  LockButtons(False);
end;

procedure TfCadastro.ActICMSSalvarExecute(Sender: TObject);
var
  S_Tipo: string;
begin

  case CmbAliquotaTipo.ItemIndex of
   -1: MessageBox(Handle,'O campo tipo não pode ficar em branco, Verifique!','Erro',MB_ICONWARNING);
    0: S_Tipo := 'I';
    1: S_Tipo := 'F';
    2: S_Tipo := 'N';
    3: S_Tipo := 'T';
    4: S_Tipo := 'S';
  end;

  IsEditNull('Alíquota',edAliquota);
  IsEditNull('Redução',edReducao);
  IsEditNull('Substituicao',edSubstituicao);
  if IsNull(edIndiceEcf.Text) then edIndiceEcf.Text := '0';

  PorcentInF(edAliquota);
  PorcentInF(edReducao);
  PorcentInF(edSubstituicao);

  case EstadoICMS of
    dsInsert:
      begin
        RunSQL('INSERT INTO ICMSPRODUTO ' +
               '(CODIGOPRODUTO, UF,  UF_DESCRICAO, TIPO, ALIQUOTA, REDUCAO, SUBSTITUICAO) VALUES (' +
               EdCodigo.Text + ', ' +
               QuotedStr(edEstado.Text) + ', ' +
               QuotedStr(edIndiceECf.Text) + ', ' +
               QuotedStr(S_Tipo) + ', ' +
               StringReplace(edAliquota.Text,',','.',[]) + ', ' +
               StringReplace(edReducao.Text,',','.',[]) + ', ' +
               StringReplace(edSubstituicao.Text,',','.',[]) + ')', Dm.DBAutocom);
      end;
    dsEdit:
      begin
        RunSQL(' UPDATE ICMSPRODUTO SET' +
               '  UF_DESCRICAO = ' + QuotedStr(edIndiceECf.Text) +
               ', TIPO = ' + QuotedStr(S_Tipo) +
               ', ALIQUOTA = ' + StringReplace(edAliquota.Text,',','.',[]) +
               ', REDUCAO = ' + StringReplace(edReducao.Text,',','.',[]) +
               ', SUBSTITUICAO = ' + StringReplace(edSubstituicao.Text,',','.',[]) +
               ' WHERE CODIGOPRODUTO = ' + EdCodigo.Text +
               ' AND UF = ' + QuotedStr(edEstado.Text) , Dm.DBAutocom);
      end;
  end;
  EnableFields(False, PanAliquotaFields);

  ActICMSEditar.Enabled := True;
  ActICMSExcluir.Enabled := True;
  ActICMSNovo.Enabled := True;
  ActICMSSalvar.Enabled := False;
  ActICMSCancelar.Enabled := False;
  LockButtons(False);
  ICMS;
end;


procedure TfCadastro.ActICMSEditarExecute(Sender: TObject);
begin
  LockButtons(True);
  if DsICMS.IsEmpty then Exit;
  EstadoICMS := dsEdit;
  EnableFields(True, PanAliquotaFields);
  if      DsICMS.FieldByName('TIPO').AsString = 'I' then CmbAliquotaTipo.ItemIndex := 0
  else if DsICMS.FieldByName('TIPO').AsString = 'F' then CmbAliquotaTipo.ItemIndex := 1
  else if DsICMS.FieldByName('TIPO').AsString = 'N' then CmbAliquotaTipo.ItemIndex := 2
  else if DsICMS.FieldByName('TIPO').AsString = 'T' then CmbAliquotaTipo.ItemIndex := 3
  else if DsICMS.FieldByName('TIPO').AsString = 'S' then CmbAliquotaTipo.ItemIndex := 4;

  edEstado.Text := DsICMS.FieldByName('UF').AsString;
  edAliquota.Text := DsICMS.FieldByName('ALIQUOTA').AsString;
  edSubstituicao.Text := DsICMS.FieldByName('SUBSTITUICAO').AsString;
  edReducao.Text := DsICMS.FieldByName('REDUCAO').AsString;
  edIndiceECf.Text := DsICMS.FieldByName('UF_DESCRICAO').AsString;
  PorcentInF(edAliquota);
  PorcentInF(edReducao);
  PorcentInF(edSubstituicao);

  ActICMSEditar.Enabled := False;
  ActICMSExcluir.Enabled := False;
  ActICMSNovo.Enabled := False;
  ActICMSSalvar.Enabled := True;
  ActICMSCancelar.Enabled := True;

  PorcentOutF(edAliquota);
  PorcentOutF(edReducao);
  PorcentOutF(edSubstituicao);

  edEstado.SetFocus;
end;

procedure TfCadastro.ActICMSExcluirExecute(Sender: TObject);
begin
  if DsICMS.IsEmpty then Exit;
  if MessageDlg('Tem Certeza que Deseja excluir ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      try
        RunSQL('DELETE FROM ICMSPRODUTO WHERE CODIGOPRODUTO = ' +  EdCodigo.Text + ' AND UF = ' + QuotedStr(DsICMS.FieldByName('UF').AsString), Dm.DBAutocom);
        ICMS;
      except
        MessageDlg('Impossível Excluir!',mtError,[mbOk],0);
      end;
  end;
end;


procedure TfCadastro.PageControlMainChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
  if not ActSalvar.Enabled then
    begin
      Beep;
      AllowChange := False
    end
  else
    AllowChange := True;
end;

procedure TfCadastro.MemDescricaoEnter(Sender: TObject);
begin
  KeyPreview := False;
end;

procedure TfCadastro.MemDescricaoExit(Sender: TObject);
begin
  KeyPreview := True;
end;

procedure TfCadastro.BtnConsultaTabelaPrecoClick(Sender: TObject);
begin
  with TfConsultaPreco.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  EdPrecoTabela.Text := FormatFloat('000',ResultConsultaCodigo);
  LblPrecoTabela.Caption := ResultConsultaNome;
  EdPrecoTabela.SetFocus;
end;

procedure TfCadastro.ActPrecoSalvarExecute(Sender: TObject);
begin
  if IsNull(EdPrecoTabela.Text) then
    begin
      Application.MessageBox('O campo Tabela não pode ficar vazio!',Autocom,MB_ICONWARNING);
      EdPrecoTabela.SetFocus;
      Exit;
    end;
  if EstadoTabelaPreco = dsInsert then EdPrecoTabelaExit(EdPrecoTabela);
  CurrencyInF(EdPrecoPreco);
  Case EstadoTabelaPreco of
    dsInsert:
      begin
        SqlProdutoTabelaPreco(InsertSql, NullAsStringValue, EdCodigo.Text, StringReplace(EdPrecoPreco.Text,',','.',[]), KeyLookUp('CODIGOTABELA', 'CODIGOTABELAPRECO', 'TABELAPRECO', EdPrecoTabela.Text, Dm.DBAutocom));
      end;
    dsEdit:
      begin
        SqlProdutoTabelaPreco(UpdateSql, DsPreco.FieldByName('CODIGOPRODUTOTABELAPRECO').AsString, EdCodigo.Text , StringReplace(EdPrecoPreco.Text,',','.',[]), KeyLookUp('CODIGOTABELA', 'CODIGOTABELAPRECO', 'TABELAPRECO', EdPrecoTabela.Text, Dm.DBAutocom));
      end;
  end;
  EnableFields(False, PanPrecoEdit);
  ActPrecoEditar.Enabled := True;
  ActPrecoExcluir.Enabled := True;
  ActPrecoNovo.Enabled := True;
  ActPrecoSalvar.Enabled := False;
  ActPrecoCancelar.Enabled := False;
  LockButtons(False);
  TabelaPreco;
end;

procedure TfCadastro.ActPrecoExcluirExecute(Sender: TObject);
begin
  if DsPreco.IsEmpty then Exit;
  if MessageDlg('Tem Certeza que Deseja excluir?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      SqlProdutoTabelaPrecoDelete(DsPreco.FieldByName('CODIGOPRODUTOTABELAPRECO').AsString);
      TabelaPreco;
   end;
end;

procedure TfCadastro.ActPrecoCancelarExecute(Sender: TObject);
begin
  EnableFields(False, PanPrecoEdit);
  ActPrecoEditar.Enabled := True;
  ActPrecoExcluir.Enabled := True;
  ActPrecoNovo.Enabled := True;
  ActPrecoSalvar.Enabled := False;
  ActPrecoCancelar.Enabled := False;
  LockButtons(False);
end;

procedure TfCadastro.ActPrecoNovoExecute(Sender: TObject);
begin
  EstadoTabelaPreco := dsInsert;
  EdPrecoTabela.Enabled := True;
  BtnConsultaTabelaPreco.Enabled := True;
  LockButtons(True);
  EnableFields(True, PanPrecoEdit);
  CurrencyOutF(EdPrecoPreco);
  ActPrecoEditar.Enabled := False;
  ActPrecoExcluir.Enabled := False;
  ActPrecoNovo.Enabled := False;
  ActPrecoSalvar.Enabled := True;
  ActPrecoCancelar.Enabled := True;
  EdPrecoTabela.SetFocus;
  LblPrecoTabela.Caption := NullAsStringValue;
  CurrencyOutF(EdPrecoPreco);
end;

procedure TfCadastro.ActPrecoEditarExecute(Sender: TObject);
begin
  LockButtons(True);
  if DsPreco.IsEmpty then Exit;
  EstadoTabelaPreco := dsEdit;
  EnableFields(True, PanPrecoEdit);

  EdPrecoTabela.Text := DsPreco.FieldByName('CODIGOTABELA').AsString;
  EdPrecoPreco.Text := DsPreco.FieldByName('PRECO').AsString;
  LblPrecoTabela.Caption := DsPreco.FieldByName('TABELAPRECO').AsString;

  CurrencyInF(EdPrecoPreco);

  ActPrecoEditar.Enabled := False;
  ActPrecoExcluir.Enabled := False;
  ActPrecoNovo.Enabled := False;
  ActPrecoSalvar.Enabled := True;
  ActPrecoCancelar.Enabled := True;

  CurrencyOutF(EdPrecoPreco);
  EdPrecoPreco.SetFocus;

  EdPrecoTabela.Enabled := False;
  BtnConsultaTabelaPreco.Enabled := False
end;

procedure TfCadastro.EdPrecoTabelaExit(Sender: TObject);
var
  DataSetLookUp: TDataSet;
begin
  FormatEdit(Sender,Float,3,0);
  if (IsNull((Sender as TCustomEdit).Text) or (StrToFloatDef((Sender as TCustomEdit).Text,0) = 0))  then
    begin
      (Sender as TCustomEdit).Clear;
      LblPrecoTabela.Caption := NullAsStringValue;
      Abort;
    end;

  RunSQL('SELECT TABELAPRECO FROM TABELAPRECO WHERE CODIGOTABELA = ' +  (Sender as TCustomEdit).Text + ' ORDER BY TABELAPRECO', Dm.DBAutocom, DataSetLookUp);
  if DataSetLookUp.IsEmpty then
    begin
      MessageBox(Handle,'Digite um código válido!',Autocom,MB_ICONWARNING);
      (Sender as TCustomEdit).SetFocus;
      Abort;
    end;
  LblPrecoTabela.Caption := DataSetLookUp.Fields[0].AsString;

  {Verifica se já exite preco desta tabela no produto atual}
  DsPreco.First;
  while not DsPreco.Eof do
    begin
      if DsPreco.FieldByName('CODIGOTABELA').AsInteger = StrToIntDef(EdPrecoTabela.Text,0) then
        begin
          Application.MessageBox(PChar('Já existe preço na tabela "' + DataSetLookUp.Fields[0].AsString + '" para este produto!'),Autocom,MB_ICONWARNING);
          EdPrecoTabela.Clear;
          EdPrecoTabela.SetFocus;
          Abort;
        end;
      DsPreco.Next;
    end;
  FreeAndNil(DataSetLookUp);
  JvBalloonHint.CancelHint;     
end;

procedure TfCadastro.edIndiceEcfKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN: ActICMSSalvar.Execute;
  end;
end;

procedure TfCadastro.EdPrecoPrecoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN: ActPrecoSalvar.Execute;
  end;
end;

procedure TfCadastro.ShowBallon(Sender: TObject);
begin
  JvBalloonHint.ActivateHint(Sender as TControl,(Sender as TControl).Hint);
end;

procedure TfCadastro.ActBarCodeAdicionarExecute(Sender: TObject);
var
  DataSetAux: TDataSet;
begin
  if (not IsFloat(EdBarCode.Text)) or (Length(EdBarCode.Text) > 13) or IsNull(EdBarCode.Text) then
    begin
      Application.MessageBox('Um código de barras deve ser um número inteiro positivo que contenha de 1 a 13 digitos!',Autocom,MB_ICONWARNING);
      EdBarCode.SetFocus;
      EdBarCode.SelectAll;
      Abort;
    end;
  RunSQL('SELECT NOMEPRODUTO FROM PRODUTO WHERE CODIGOPRODUTO = ' + EdBarCode.Text,Dm.DBAutocom,DataSetAux);
  if not DataSetAux.IsEmpty then
    begin
      Application.MessageBox(PChar('Este codigo está cadastrado para o produto ' + DataSetAux.Fields[0].AsString),Autocom,MB_ICONEXCLAMATION);
      EdBarCode.SetFocus;
      EdBarCode.SelectAll;
      Abort;
    end;

  RunSQL('SELECT CODIGOPRODUTO FROM PRODUTOASSOCIADO WHERE CODIGOPRODUTOASSOCIADO = ' + EdBarCode.Text,Dm.DBAutocom,DataSetAux);
  if not DataSetAux.IsEmpty then
    begin
      RunSQL('SELECT NOMEPRODUTO FROM PRODUTO WHERE CODIGOPRODUTO = '  + DataSetAux.Fields[0].AsString,Dm.DBAutocom,DataSetAux);
      Application.MessageBox(PChar('Este codigo está cadastrado para o produto ' + DataSetAux.Fields[0].AsString),Autocom,MB_ICONEXCLAMATION);
      EdBarCode.SetFocus;
      EdBarCode.SelectAll;
      Abort;
    end;

  SqlProdutoAssociado(EdBarCode.Text,EdCodigo.Text);
  EdBarCode.Clear;
  BarCode;
end;

procedure TfCadastro.ActBarCodeExcluirExecute(Sender: TObject);
begin
  if DsBarCode.IsEmpty then
    begin
      Beep;
      Exit;
    end;
  SqlProdutoAssociadoDelete(DsBarCode.Fields[0].AsString);
  BarCode;
end;

procedure TfCadastro.FormActivate(Sender: TObject);
begin
     Label11.caption:=Leini('ESTOQUE','NomeTipoLote');
     if Length(label11.caption)<=0 then
        begin
           Label11.caption:='Lote';
           GravaIni('ESTOQUE','NomeTipoLote',Label11.caption)
        end;
     Label11.caption:='Controla '+Label11.caption;
end;

end.


