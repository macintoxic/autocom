// Projeto    : Autocom
// Data       : 30/01/2003
// Programador: Carlos Watanabe
// Descricao  : Nota Fiscal de Entrada e de Sa?da

unit Nota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  DB, Grids, DBGrids, StdCtrls, ComCtrls, Buttons,
  ExtCtrls, Mask, IBQuery, IniFiles, ActnMan, ActnColorMaps;

type
  TfrmNota = class(TForm)
    cmdConsultaCodigoTransportador: TBitBtn;
    cmdGravar: TBitBtn;
    cmdImprimir: TBitBtn;
    cmdCancelarNotaFiscal: TBitBtn;
    cmdFechar: TBitBtn;
    cmbFretePorConta: TComboBox;
    cmbUF: TComboBox;
    DataSource1: TDataSource;
    txtNomeTransportador: TEdit;
    txtPlacaVeiculo: TEdit;
    txtEspecie: TEdit;
    txtMarca: TEdit;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    mskBaseCalculoICMS: TMaskEdit;
    mskValorICMS: TMaskEdit;
    mskBaseCalculoICMSSub: TMaskEdit;
    mskValorICMSSub: TMaskEdit;
    mskValorTotalProdutos: TMaskEdit;
    mskValorTotalIPI: TMaskEdit;
    mskValorSeguro: TMaskEdit;
    mskOutrasDespesas: TMaskEdit;
    mskValorFrete: TMaskEdit;
    mskValorTotalNota: TMaskEdit;
    mskCodigoTransportador: TMaskEdit;
    mskQuantidadeVolumes: TMaskEdit;
    mskNumero: TMaskEdit;
    mskPesoBruto: TMaskEdit;
    mskPesoLiquido: TMaskEdit;
    tstrPageControl: TPageControl;
    Panel1: TPanel;
    tabCalculoImposto: TTabSheet;
    tabTransportador: TTabSheet;
    Panel2: TPanel;
    optEntrada: TRadioButton;
    optSaida: TRadioButton;
    Label45: TLabel;
    Panel3: TPanel;
    Label44: TLabel;
    PageControl1: TPageControl;
    TabCabecalho: TTabSheet;
    TabProduto: TTabSheet;
    Label1: TLabel;
    mskCodNotaFiscal: TMaskEdit;
    cmdConsultaNotaFiscal: TBitBtn;
    Label2: TLabel;
    mskCFOP: TMaskEdit;
    cmdConsultaCFOP: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    mskOrcamento: TMaskEdit;
    cmdConsultaOrcamento: TBitBtn;
    Label13: TLabel;
    cmbCondicaoPagamento: TComboBox;
    Label14: TLabel;
    mskSerie: TMaskEdit;
    Label5: TLabel;
    mskIndicador: TMaskEdit;
    cmdConsultaIndicador: TBitBtn;
    Label6: TLabel;
    Label9: TLabel;
    mskPedido: TMaskEdit;
    Label7: TLabel;
    mskDestinatarioRemetente: TMaskEdit;
    cmdConsultaDestinatarioRemetente: TBitBtn;
    Label8: TLabel;
    Label10: TLabel;
    datDataEmissao: TDateTimePicker;
    Label11: TLabel;
    datDataEntradaSaida: TDateTimePicker;
    Label12: TLabel;
    datHoraSaida: TDateTimePicker;
    grdStringGrid: TStringGrid;
    dgrdDBGrid: TDBGrid;
    Label21: TLabel;
    Label16: TLabel;
    mskProduto: TMaskEdit;
    mskAcrescimo: TMaskEdit;
    cmdConsultaProduto: TBitBtn;
    Label17: TLabel;
    Label22: TLabel;
    mskDesconto: TMaskEdit;
    Label18: TLabel;
    cmbPreco: TComboBox;
    mskpreco: TMaskEdit;
    Label20: TLabel;
    mskQuantidade: TMaskEdit;
    Label15: TLabel;
    msklote: TMaskEdit;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure optEntradaClick(Sender: TObject);
    procedure optEntradaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure optSaidaClick(Sender: TObject);
    procedure optSaidaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskCodNotaFiscalEnter(Sender: TObject);
    procedure mskCodNotaFiscalKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskCodNotaFiscalExit(Sender: TObject);
    procedure cmdConsultaNotaFiscalClick(Sender: TObject);
    procedure mskCFOPEnter(Sender: TObject);
    procedure mskCFOPKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskCFOPExit(Sender: TObject);
    procedure cmdConsultaCFOPClick(Sender: TObject);
    procedure mskOrcamentoEnter(Sender: TObject);
    procedure mskOrcamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskOrcamentoExit(Sender: TObject);
    procedure cmdConsultaOrcamentoClick(Sender: TObject);
    procedure cmbCondicaoPagamentoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskSerieKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskIndicadorEnter(Sender: TObject);
    procedure mskIndicadorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskIndicadorExit(Sender: TObject);
    procedure cmdConsultaIndicadorClick(Sender: TObject);
    procedure mskDestinatarioRemetenteEnter(Sender: TObject);
    procedure mskDestinatarioRemetenteKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure mskDestinatarioRemetenteExit(Sender: TObject);
    procedure cmdConsultaDestinatarioRemetenteClick(Sender: TObject);
    procedure mskPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskPedidoExit(Sender: TObject);
    procedure datDataEmissaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure datDataEntradaSaidaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure datHoraSaidaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskProdutoEnter(Sender: TObject);
    procedure mskProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskProdutoExit(Sender: TObject);
    procedure cmdConsultaProdutoClick(Sender: TObject);
    procedure cmbPrecoChange(Sender: TObject);
    procedure cmbPrecoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbPrecoExit(Sender: TObject);
    procedure mskQuantidadeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskQuantidadeExit(Sender: TObject);
    procedure dgrdDBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grdStringGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskValorSeguroKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskValorSeguroExit(Sender: TObject);
    procedure mskOutrasDespesasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskOutrasDespesasExit(Sender: TObject);
    procedure mskValorFreteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskValorFreteExit(Sender: TObject);
    procedure mskCodigoTransportadorEnter(Sender: TObject);
    procedure mskCodigoTransportadorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskCodigoTransportadorExit(Sender: TObject);
    procedure cmdConsultaCodigoTransportadorClick(Sender: TObject);
    procedure txtNomeTransportadorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbFretePorContaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtPlacaVeiculoKeyPress(Sender: TObject; var Key: Char);
    procedure txtPlacaVeiculoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmbUFKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskQuantidadeVolumesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskQuantidadeVolumesExit(Sender: TObject);
    procedure txtEspecieKeyPress(Sender: TObject; var Key: Char);
    procedure txtEspecieKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtEspecieExit(Sender: TObject);
    procedure txtMarcaKeyPress(Sender: TObject; var Key: Char);
    procedure txtMarcaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txtMarcaExit(Sender: TObject);
    procedure mskNumeroKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskNumeroExit(Sender: TObject);
    procedure mskPesoBrutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskPesoBrutoExit(Sender: TObject);
    procedure mskPesoLiquidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskPesoLiquidoExit(Sender: TObject);
    procedure cmdGravarClick(Sender: TObject);
    procedure cmdImprimirClick(Sender: TObject);
    procedure cmdCancelarNotaFiscalClick(Sender: TObject);
    procedure cmdFecharClick(Sender: TObject);
    procedure mskAcrescimoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskDescontoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskprecoExit(Sender: TObject);
    procedure MaskEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskloteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    ad_Preco: Array of Double;
    ad_CondicaoPagamento: Array of Integer;
    b_Sair: Boolean;
    s_CFOP: String;
    s_CodigoInicial: String;
    s_ImpressoraSimples: String;
    s_Filtro: String;
    s_LimiteItem: String;
    s_Loja: String;
    s_Operador: String;
    s_Orcamento: String;
    s_Path: String;

    { Variaveis com conteudo das chaves de replicacao }
    s_CodigoNotaFiscal: String;
    s_CodigoPedido: String;
    s_CodigoCondicaoPagamento: String;
    s_CodigoVendedor: String;
    s_CodigoCliente: String;
    s_CodigoFornecedor: String;
    s_CodigoTransportadora: String;


    s_UF_endereco:string; // armazena a UF do endereco do destinatario/remetente

    // Variaveis de controle de totais da nota fiscal (calculo de imposto)
    db_BaseCalculoICMS: Double;
    db_ValorICMS: Double;
    db_ValorTotalProdutos: Double;
    db_ValorTotalIPI: Double;
    db_PesoBruto: Double;
    db_PesoLiquido: Double;
    ICMS_Frete: Double;
    s_aliquota_ICMSPRODUTO:String;

    function AllTrim(s_String: String): String;
    function AtualizaEstoque(obj_TIBQuery: TIBQuery; s_Tipo: String; s_Produto: String; s_Quantidade,Lote: String): Boolean;
    function Filtrar(s_String: String; s_Filtro: String): String;
    function FormataNumero(s_String: String; i_CasasInteiras: Integer = 0; i_CasasDecimais: Integer = 0; preenchimento:string = '0'): String;
    function NumeroNota(): String;
    function TrocaTexto(s_String: String; s_Find: String; s_Replace: String): String;
    function Validacao(): Boolean;

    procedure Botao_Alterar();
    procedure Botao_Cancelar();
    procedure Botao_Gravar();
    procedure Botao_Fechar();
    procedure Calcula_Valor_Total_Nota();
    procedure Captura_Valores();
    procedure Carrega_Ini();
    procedure Carrega_Op();
    procedure Conecta_DB();
    procedure Desconecta_DB();
    procedure Exclui_Dados_StringGrid(i_Row: Integer);
    procedure Executa_SQL(obj_IBQuery: TIBQuery; s_SQL: String; b_Open: Boolean = true);
    procedure Formata_StringGrid();
    procedure Habilita_Campos();
    procedure Imprime_NF();
    procedure Insere_Dados_StringGrid();
    procedure Limpa_Campos();
    procedure Log(s_String: String);
    procedure Monta_Condicao_Pagamento();
    procedure Processa_Valores_DBGrid();
    procedure Processa_Valores_StringGrid();
    procedure Retira_Virgula_MaskEdit();
    procedure Troca_Maskara(b_Literal: Boolean);
    procedure FaturaNota(numero_nota:string); // Fatura a nota fiscal, de acordo com o numero
    procedure Pega_Produto; // carrega os dados referente a determinado produto
  end;

  procedure ImpNF; external 'impnf.dll' index 1;

var
  frmNota: TfrmNota;

  i_Handle: Integer;
  Produto_controla_lote:boolean;

implementation

uses Tabelas, StrUtils, Listagem;

{$R *.dfm}

{*******************************************************************************
                                Eventos
******************************************************************************}

procedure TfrmNota.FormActivate(Sender: TObject);
begin

    frmNota.Width := 800;
    frmNota.Height := 600;

    s_Path := ExtractFilePath(Application.exeName) + 'dados\';

    // Procedure que efetua conexao com as tabelas do Banco de Dados
    Conecta_DB;

    // Procedure que apaga o conteudo de todos os componentes de tela
    Limpa_Campos;

    //
    Carrega_Ini;

    //
    Carrega_op;

    //
    Executa_SQL(frmTabelas.rede, 'Commit', false);

    mskCodNotaFiscal.Text := FormataNumero(NumeroNota(), 8);

    SetForegroundWindow(Application.Handle);
end;

procedure TfrmNota.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    // Procedure que desconecta das tabelas do Banco de Dados
    Desconecta_DB;
end;

procedure TfrmNota.optEntradaClick(Sender: TObject);
begin
    Label45.Caption := 'Nota Fiscal de Entrada';

    mskCodNotaFiscal.Enabled := true;
    cmdConsultaNotaFiscal.Enabled := true;
    mskCodNotaFiscal.Text := FormataNumero(NumeroNota(), 8);

    mskDestinatarioRemetente.Left := 74;
    cmdConsultaDestinatarioRemetente.Left := 165;
    Label8.Left := 191;
    Label9.Left := 608;
    mskPedido.Left := 736;

    Label7.Caption := 'Fornecedor:';
    Label9.Caption := 'Pedido do Fornecedor:';
    Label11.Caption := 'Data da Entrada';

    mskOrcamento.Enabled := true;
    cmdConsultaOrcamento.Enabled := true;
    cmbPreco.Enabled := false;
    cmbPreco.Style := csDropDown;
    cmbPreco.Text := 'Pre?o de Custo';
    mskpreco.color:=clwhite;
    mskpreco.readonly:=false;


    mskCodNotaFiscal.setfocus;
end;

procedure TfrmNota.optEntradaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.optSaidaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.optSaidaClick(Sender: TObject);
begin
    Label45.Caption := 'Nota Fiscal de Sa?da';

    mskCodNotaFiscal.Enabled := true;
    cmdConsultaNotaFiscal.Enabled := true;
    mskCodNotaFiscal.Text := FormataNumero(NumeroNota(), 8);

    mskDestinatarioRemetente.Left := 48;
    cmdConsultaDestinatarioRemetente.Left := 139;
    Label8.Left := 165;
    Label9.Left := 634;
    mskPedido.Left := 736;

    Label7.Caption := 'Cliente:';
    Label9.Caption := 'Pedido do Cliente:';
    Label11.Caption := 'Data da Sa?da';

    mskOrcamento.Enabled := true;
    cmdConsultaOrcamento.Enabled := true;
    cmbPreco.Enabled := true;
    cmbPreco.Style := csDropDownList;
    cmbPreco.ItemIndex := -1;
    mskpreco.color:=clSkyBlue;
    mskpreco.readonly:=true;

    mskCodNotaFiscal.setfocus;
end;

procedure TfrmNota.mskCodNotaFiscalEnter(Sender: TObject);
begin
    Label44.Caption := '[F1] - Consulta de Nota Fiscal';

    if optEntrada.Checked then
    begin
        Label45.Caption := 'Nota Fiscal de Entrada';
    end
    else
    begin
        Label45.Caption := 'Nota Fiscal de Sa?da';
    end;
end;

procedure TfrmNota.mskCodNotaFiscalKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);

    if Key = VK_F1 then
        cmdConsultaNotaFiscal.Click;
end;

procedure TfrmNota.mskCodNotaFiscalExit(Sender: TObject);
var b_TemNota: Boolean;
    s_SQL: String;
begin
    Label44.Caption := '[F1] - Consulta...';

    if (not optEntrada.Focused) and (not optSaida.Focused) and (not cmdConsultaNotaFiscal.Focused) and (not cmdFechar.Focused) and (b_Sair) then
    begin
        Executa_SQL(frmTabelas.tbl_NotaFiscal, 'Commit', false);
        Log('Enviando um Commit ao banco de dados');

        Botao_Cancelar;

        b_TemNota := true;

        s_CodigoNOtaFiscal := 'null';

        if Length(AllTrim(mskCodNotaFiscal.Text)) > 0 then
        begin
            mskCodNotaFiscal.Text := FormataNumero(AllTrim(mskCodNotaFiscal.Text), 8);

            if optEntrada.Checked then
                s_SQL := 'SELECT * FROM NotaFiscalEntrada WHERE NUMERONOTA = ' + AllTrim(mskCodNotaFiscal.Text)
            else
                s_SQL := 'SELECT * FROM NotaFiscalSaida WHERE NUMERONOTA = ' + AllTrim(mskCodNotaFiscal.Text);

            Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL);

            if frmTabelas.tbl_NotaFiscal.RecordCount <= 0 then
                b_TemNota := false
            else
            begin
                if frmTabelas.tbl_NotaFiscal.RecordCount > 1 then
                begin
                    if optEntrada.Checked then
                    begin
                        Executa_SQL(frmTabelas.tbl_NotaFiscalEntrada, s_SQL);
                        frmListagem.DataSource1.DataSet := frmTabelas.tbl_NotaFiscalEntrada;
                        frmListagem.Caption := 'Selecione uma nota fiscal de entrada';
                    end
                    else
                    begin
                        Executa_SQL(frmTabelas.tbl_NotaFiscalSaida, s_SQL);
                        frmListagem.DataSource1.DataSet := frmTabelas.tbl_NotaFiscalSaida;
                        frmListagem.Caption := 'Selecione uma nota fiscal de sa?da';
                    end;
                    frmListagem.ShowModal;
                end;
            end;

            if b_TemNota then
            begin
                Captura_Valores;

                cmbCondicaoPagamento.Enabled := false;
                mskSerie.Enabled := false;
                mskCFOP.Enabled := false;
                cmdConsultaCFOP.Enabled := false;
                mskOrcamento.Enabled := false;
                cmdConsultaOrcamento.Enabled := false;
                mskIndicador.Enabled := false;
                cmdConsultaIndicador.Enabled := false;
                mskDestinatarioRemetente.Enabled := false;
                cmdConsultaDestinatarioRemetente.Enabled := false;
                mskPedido.Enabled := false;
                datDataEmissao.Enabled := false;
                datDataEntradaSaida.Enabled := false;
                datHoraSaida.Enabled := false;
                mskProduto.Enabled := false;
                cmdConsultaProduto.Enabled := false;
                cmbPreco.Enabled := false;
                mskQuantidade.Enabled := false;

                dgrdDBGrid.ShowHint := false;

                mskValorSeguro.Enabled := false;
                mskOutrasDespesas.Enabled := false;
                mskValorFrete.Enabled := false;

                mskCodigoTransportador.Enabled := false;
                cmdConsultaCodigoTransportador.Enabled := false;
                cmbFretePorConta.Enabled := false;
                txtPlacaVeiculo.Enabled := false;
                cmbUF.Enabled := false;
                mskQuantidadeVolumes.Enabled := false;
                txtEspecie.Enabled := false;
                txtMarca.Enabled := false;
                mskNumero.Enabled := false;
                mskPesoBruto.Enabled := false;
                mskPesoLiquido.Enabled := false;

                Label45.Caption := '';

                if (frmTabelas.tbl_NotaFiscal.FieldByName('CANCELADA').AsString = 'T') or
                   (frmTabelas.tbl_NotaFiscal.FieldByName('FATURADO').AsString = 'T') or
                   (frmTabelas.tbl_NotaFiscal.FieldByName('IMPRESSO').AsString = 'T') then
                begin
                    if (frmTabelas.tbl_NotaFiscal.FieldByName('IMPRESSO').AsString = 'T')  then
                       begin
                          Label45.Caption := ' - Impressa';
                          cmdGravar.Enabled := false;
                          cmdImprimir.Enabled := true;
                          cmdCancelarNotaFiscal.Enabled := true;
                       end;
                    if (frmTabelas.tbl_NotaFiscal.FieldByName('FATURADO').AsString = 'T')  then
                       begin
                          Label45.Caption := Label45.Caption+' - Faturada';
                          cmdGravar.Enabled := false;
                          cmdImprimir.Enabled := true;
                          cmdCancelarNotaFiscal.Enabled := true;
                       end;
                    if (frmTabelas.tbl_NotaFiscal.FieldByName('CANCELADA').AsString = 'T') then
                       begin
                          Label45.Caption := Label45.Caption+' - Cancelada';
                          cmdGravar.Enabled := false;
                          cmdImprimir.Enabled := false;
                          cmdCancelarNotaFiscal.Enabled := false;
                       end;

                    if optEntrada.Checked then
                    begin
                        Label45.Caption := 'Nota Fiscal de Entrada' + Label45.Caption;
                    end
                    else
                    begin
                        Label45.Caption := 'Nota Fiscal de Sa?da' + Label45.Caption;
                    end;

                    Botao_Gravar;

                    cmdFechar.SetFocus;
                end
                else
                begin
                    if optEntrada.Checked then
                    begin
                        Label45.Caption := 'Nota Fiscal de Entrada';
                    end
                    else
                    begin
                        Label45.Caption := 'Nota Fiscal de Sa?da';
                    end;

                    Botao_Alterar;

                    cmdGravar.Enabled := true;
                    cmdImprimir.Enabled := true;
                    cmdCancelarNotaFiscal.Enabled := true;
                    cmdFechar.SetFocus;
                end;
            end
            else
            begin
                mskCodNotaFiscal.Text := FormataNumero(AllTrim(mskCodNotaFiscal.Text), 8);
                Log('Emiss?o da Nota Fiscal n? '+ mskCodNotaFiscal.Text);

                cmdGravar.Enabled := true;

                if optEntrada.Checked then
                    s_SQL := 'DELETE FROM NotaFiscalEntrada WHERE NUMERONOTA = ' + AllTrim(mskCodNotaFiscal.Text)
                else
                    s_SQL := 'DELETE FROM NotaFiscalSaida WHERE NUMERONOTA = ' + AllTrim(mskCodNotaFiscal.Text);

                Executa_SQL(frmTabelas.rede, s_SQL, false);
            end;
        end
        else
        begin
            mskCodNotaFiscal.Text := FormataNumero(NumeroNota(), 8);
            Log('Emiss?o da Nota Fiscal n? ' + mskCodNotaFiscal.text);
            cmdGravar.Enabled := true;

            if optEntrada.Checked then
                s_SQL := 'DELETE FROM NotaFiscalEntrada WHERE NUMERONOTA = ' + AllTrim(mskCodNotaFiscal.Text)
            else
                s_SQL := 'DELETE FROM NotaFiscalSaida WHERE NUMERONOTA = ' + AllTrim(mskCodNotaFiscal.Text);

            Executa_SQL(frmTabelas.rede, s_SQL, false);
        end;

        optEntrada.Enabled := false;
        optSaida.Enabled := false;
        mskCodNotaFiscal.Enabled := false;
        cmdConsultaNotaFiscal.Enabled := false;
    end;

    b_Sair := true;
end;

procedure TfrmNota.cmdConsultaNotaFiscalClick(Sender: TObject);
var s_SQL: String;
begin
    if optEntrada.Checked then
    begin
        s_SQL := 'SELECT NFEntrada.CODIGONOTAFISCALENTRADA, NFEntrada.NUMERONOTA, NFEntrada.DATAEMISSAO, Pessoa.PES_NOME_A ' +
                 'FROM NotaFiscalEntrada NFEntrada, Pessoa Pessoa, Fornecedor Fornecedor ' +
                 'WHERE Fornecedor.FRN_CODFORNECEDOR = NFEntrada.FRN_CODFORNECEDOR AND Fornecedor.PES_CODPESSOA = Pessoa.PES_CODPESSOA ' +
                 'ORDER BY 3,2';
        Executa_SQL(frmTabelas.tbl_NotaFiscalEntrada, s_SQL);
        frmListagem.DataSource1.DataSet := frmTabelas.tbl_NotaFiscalEntrada;
    end
    else
    begin
        s_SQL := 'SELECT NFSaida.CODIGONOTAFISCALSAIDA, NFSaida.NUMERONOTA, NFSaida.DATAEMISSAO, Pessoa.PES_NOME_A ' +
                 'FROM NotaFiscalSaida NFSaida, Pessoa Pessoa, Cliente Cliente ' +
                 'WHERE Cliente.CLI_CODCLIENTE = NFSaida.CLI_CODCLIENTE AND Cliente.PES_CODPESSOA = Pessoa.PES_CODPESSOA ' +
                 'ORDER BY 3,2';
        Executa_SQL(frmTabelas.tbl_NotaFiscalSaida, s_SQL);
        frmListagem.DataSource1.DataSet := frmTabelas.tbl_NotaFiscalSaida;
    end;

    frmListagem.Caption := 'Autocom PLUS  -  Notas Fiscais';
    frmListagem.ShowModal;
end;

procedure TfrmNota.mskCFOPEnter(Sender: TObject);
begin
    s_CFOP := mskCFOP.Text;
    Label44.Caption := '[F1] - Consulta de CFOP';
end;

procedure TfrmNota.mskCFOPKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
    begin
        if s_CFOP = AllTrim(FormataNumero(mskCFOP.Text, 6)) then
        begin
            if mskOrcamento.Enabled then
                mskOrcamento.SetFocus
            else
            begin
                mskCFOP.SetFocus;
                mskCFOP.SelectAll;
            end;
        end
        else
        begin
            if AllTrim(mskCFOP.Text) = '' then
                cmdConsultaCFOP.Click
            else
                Panel1.SetFocus;
        end;
    end;

    if Key = VK_F1 then
        cmdConsultaCFOP.Click;
end;

procedure TfrmNota.mskCFOPExit(Sender: TObject);
begin
    Label44.Caption := '[F1] - Consulta...';

    if (not cmdConsultaCFOP.Focused) and (not cmdFechar.Focused) and (not mskCodNotaFiscal.Focused) and (b_Sair) then
    begin
        mskCFOP.Text := FormataNumero(mskCFOP.Text, 6);

        if s_CFOP = AllTrim(FormataNumero(mskCFOP.Text, 6)) then
            exit;

        if Length(Trim(mskCFOP.Text)) > 0 then
        begin
            Executa_SQL(frmTabelas.tbl_NaturezaOperacao, 'SELECT * FROM NATUREZAOPERACAO WHERE CODIGONATUREZAOPERACAO = ' + AllTrim(mskCFOP.Text));

            mskCFOP.Text := FormataNumero(mskCFOP.Text, 6);

            try
                Label3.Caption := Trim(frmTabelas.tbl_NaturezaOperacao.FieldByName('NATUREZAOPERACAO').Value);

                cmbCondicaoPagamento.Enabled := true;
                mskSerie.Enabled := true;
                mskIndicador.Enabled := true;
                cmdConsultaIndicador.Enabled := true;
                mskDestinatarioRemetente.Enabled := true;
                cmdConsultaDestinatarioRemetente.Enabled := true;
                mskPedido.Enabled := true;
                datDataEmissao.Enabled := true;
                datDataEntradaSaida.Enabled := true;
                datHoraSaida.Enabled := true;
                mskProduto.Enabled := true;
                cmdConsultaProduto.Enabled := true;
                mskQuantidade.Enabled := true;

                mskOrcamento.SetFocus;
            except
                mskDestinatarioRemetente.Left := 143;
                cmdConsultaDestinatarioRemetente.Left := 234;
                Label8.Left := 260;
                Label8.Width := 268;
                Label9.Left := 539;
                mskPedido.Left := 736;

                Label3.Caption:='C?digo Inv?lido';
                Label7.Caption := 'Destinat?rio/Remetente:';
                Label9.Caption := 'Pedido do Destinat?rio/Remetente:';
                Label11.Caption := 'Data da Sa?da/Entrada:';
                beep;

                cmbCondicaoPagamento.Enabled := false;
                mskSerie.Enabled := false;
                mskOrcamento.Enabled := false;
                cmdConsultaOrcamento.Enabled := false;
                mskIndicador.Enabled := false;
                cmdConsultaIndicador.Enabled := false;
                mskDestinatarioRemetente.Enabled := false;
                cmdConsultaDestinatarioRemetente.Enabled := false;
                mskPedido.Enabled := false;
                datDataEmissao.Enabled := false;
                datDataEntradaSaida.Enabled := false;
                datHoraSaida.Enabled := false;
                mskProduto.Enabled := false;
                cmdConsultaProduto.Enabled := false;
                mskQuantidade.Enabled := false;
                mskCFOP.SelectAll;
                mskCFOP.SetFocus;
            end;

            cmbCondicaoPagamento.ItemIndex := -1;
            mskSerie.Clear;
            mskOrcamento.Clear;
            mskIndicador.Clear;
            Label6.Caption := '';
            mskDestinatarioRemetente.Clear;
            Label8.Caption := '';
            mskPedido.Clear;
            datDataEmissao.Date := Date;
            datDataEntradaSaida.Date := Date;
            datHoraSaida.Time := Time;
            mskProduto.Clear;
            Label17.Caption := '';
            mskPreco.Text    := '         000';
            mskQuantidade.Clear;
        end;
    end;
    b_Sair := true;
end;

procedure TfrmNota.cmdConsultaCFOPClick(Sender: TObject);
begin
    Executa_SQL(frmTabelas.tbl_NaturezaOperacao, 'SELECT * FROM NaturezaOperacao ORDER BY NATUREZAOPERACAO');

    frmListagem.DataSource1.DataSet := frmTabelas.tbl_NaturezaOperacao;
    frmListagem.Caption := 'Autocom PLUS  -  C?digos Fiscais de Opera??es';
    frmListagem.ShowModal;
end;

procedure TfrmNota.mskOrcamentoEnter(Sender: TObject);
begin
    Label44.Caption := '[F1] - Consulta de ' + LeftStr(Trim(Label4.Caption), Length(Trim(Label4.Caption)) - 1);
end;

procedure TfrmNota.mskOrcamentoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
    begin
        if Length(AllTrim(mskOrcamento.Text)) > 0 then
            mskSerie.SetFocus
        else
        begin
            cmbCondicaoPagamento.Enabled := true;
            mskSerie.Enabled := true;
            mskIndicador.Enabled := true;
            cmdConsultaIndicador.Enabled := true;
            mskDestinatarioRemetente.Enabled := true;
            cmdConsultaDestinatarioRemetente.Enabled := true;
            mskProduto.Enabled := true;
            cmdConsultaProduto.Enabled := true;
            Label17.Caption := '';
            mskPreco.Text    := '         000';
            mskQuantidade.Enabled := true;
            dgrdDBGrid.Visible := false;
            grdStringGrid.Visible := true;
            cmbCondicaoPagamento.SetFocus;
        end;
    end;

    if Key = VK_F1 then cmdConsultaOrcamento.Click;
end;

procedure TfrmNota.mskOrcamentoExit(Sender: TObject);
var i: Integer;
    s_SQL: String;
begin
    Label44.Caption := '[F1] - Consulta...';

    if (not cmdConsultaOrcamento.Focused) and (not cmdFechar.Focused) and (b_Sair) then
    begin
        s_CodigoPedido := 'null';

        if Length(AllTrim(mskOrcamento.Text)) > 0 then
        begin
            if frmNota.optEntrada.Checked then
            begin// Nota de entrada
                LOG('Consultando Pedido de compra: '+'SELECT * FROM PedidoCompra WHERE NUMEROPEDIDO = ' + AllTrim(mskOrcamento.Text));
                Executa_SQL(frmTabelas.tbl_PedidoCompra, 'SELECT * FROM PedidoCompra WHERE NUMEROPEDIDO = ' + AllTrim(mskOrcamento.Text));

                if frmTabelas.tbl_PedidoCompra.Isempty then
                   begin
                      beep;
                      log('Pedido de compra nao encontrado');
                      showmessage('Pedido n?o encontrado');
                      mskOrcamento.SelectAll;
                      mskOrcamento.SetFocus;
                      exit;
                   end
                else
                   begin
                      try
                         mskOrcamento.Text := FormataNumero(AllTrim(frmTabelas.tbl_PedidoCompra.FieldByName('NUMEROPEDIDO').AsString), 13);
                         s_CodigoCondicaoPagamento := AllTrim(frmTabelas.tbl_PedidoCompra.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString);

                         for i := 0 to cmbCondicaoPagamento.Items.Count do
                            begin
                               if ad_CondicaoPagamento[i] = StrToInt(s_CodigoCondicaoPagamento) then
                                  begin
                                     cmbCondicaoPagamento.ItemIndex := i;
                                     break;
                                  end;
                            end;

                         s_CodigoVendedor := FormataNumero(AllTrim(frmTabelas.tbl_PedidoCompra.FieldByName('VEN_CODVENDEDOR').AsString), 13);
                         s_SQL := 'SELECT Vendedor.CODIGOVENDEDOR, Pessoa.PES_NOME_A FROM Vendedor, Pessoa WHERE Pessoa.PES_CODPESSOA = Vendedor.PES_CODPESSOA AND Vendedor.VEN_CODVENDEDOR = ' + AllTrim(s_CodigoVendedor);
                         Executa_SQL(frmTabelas.tbl_Pessoa, s_SQL);

                         mskIndicador.Text := FormataNumero(AllTrim(frmTabelas.tbl_Pessoa.FieldByName('CODIGOVENDEDOR').AsString), 13);
                         Label6.Caption := Trim(frmTabelas.tbl_Pessoa.FieldByName('PES_NOME_A').AsString);

                         s_CodigoFornecedor := FormataNumero(AllTrim(frmTabelas.tbl_PedidoCompra.FieldByName('FRN_CODFORNECEDOR').AsString), 13);
                         s_SQL := 'SELECT Fornecedor.CODIGOFORNECEDOR,Pessoa.PES_NOME_A,Fornecedor.FRN_CODFORNECEDOR, Pessoa.PES_CPF_CNPJ_A,EP.enp_estado_a '+
                         'FROM Fornecedor, Pessoa, EnderecoPessoa EP  '+
                         'WHERE Pessoa.PES_CODPESSOA = Fornecedor.PES_CODPESSOA '+
                         'AND Pessoa.PES_CODPESSOA = EnderecoPessoa.PES_CODPESSOA '+
                         'AND EnderecoPessoa.TEN_CODTIPOENDERECO = 4 '+
                         'AND Fornecedor.FRN_CODFORNECEDOR = ' + frmNota.AllTrim(frmNota.s_CodigoFornecedor);
                         Executa_SQL(frmTabelas.tbl_Pessoa, s_SQL);

                         mskDestinatarioRemetente.Text := FormataNumero(AllTrim(frmTabelas.tbl_Pessoa.FieldByName('CODIGOFORNECEDOR').AsString), 13);

                         frmNota.s_UF_endereco:=Trim(frmTabelas.tbl_Pessoa.FieldByName('enp_estado_a').Asstring);
                         Label8.Caption := Trim(frmTabelas.tbl_Pessoa.FieldByName('PES_NOME_A').AsString)+' - '+frmNota.s_UF_endereco;

                         s_CodigoPedido := FormataNumero(AllTrim(frmTabelas.tbl_PedidoCompra.FieldByName('CODIGOPEDIDOCOMPRA').AsString), 13);
                         s_SQL := 'SELECT Produto.CODIGOPRODUTO, Produto.NOMEPRODUTO, ' +
                                    'ProdutoPedidoCompra.QUANTIDADE, ProdutoPedidoCompra.PRECO, ' +
                                    'ProdutoPedidoCompra.ALIQUOTAICMS, ProdutoPedidoCompra.ALIQUOTAIPI, ' +
                                    'Produto.PESOBRUTO, Produto.PESOLIQUIDO, ClassificacaoFiscal.CODIGOCLASSIFICACAOFISCAL, ' +
                                    'ClassificacaoFiscal.CLASSIFICACAOFISCAL, SituacaoTributaria.CODIGOSITUACAOTRIBUTARIA, ' +
                                    'SituacaoTributaria.SITUACAOTRIBUTARIA ' +
                             'FROM Produto, ProdutoPedidoCompra, ClassificacaoFiscal, SituacaoTributaria ' +
                             'WHERE ProdutoPedidoCompra.CODIGOPRODUTO = Produto.CODIGOPRODUTO ' +
                             'AND ClassificacaoFiscal.CODIGOCLASSIFICACAOFISCAL = Produto.CODIGOCLASSIFICACAOFISCAL ' +
                             'AND SituacaoTributaria.CODIGOSITUACAOTRIBUTARIA = Produto.CODIGOSITUACAOTRIBUTARIA ' +
                             'AND (ProdutoPedidoCompra.ENTREGUE <> ProdutoPedidoCompra.QUANTIDADE or ProdutoPedidoCompra.ENTREGUe is null )'+
                             'AND ProdutoPedidoCompra.CODIGOPEDIDOCOMPRA = ' + s_CodigoPedido +
                             'ORDER BY Produto.CODIGOPRODUTO';
                         Log('Carregando produtos do pedido de compra: '+s_SQL);
                         Executa_SQL(frmTabelas.tbl_ProdutoPedidoCompra, s_SQL);

                         dgrdDBGrid.Visible := true;
                         grdStringGrid.Visible := false;

                         dgrdDBGrid.DataSource.Enabled := faLSE;
                         dgrdDBGrid.DataSource.DataSet := frmTabelas.tbl_ProdutoPedidoCompra;
                         dgrdDBGrid.DataSource.Enabled := true;
                      except
                         beep;
                         showmessage('Pedido n?o encontrado');
                         mskOrcamento.SelectAll;
                         mskOrcamento.SetFocus;
                         exit;
                      end;
                   end;
            end
            else
            begin
                // Nota de saida
                Log('Consultando pedido de venda: '+'SELECT * FROM PedidoVenda WHERE NUMEROPEDIDO = ' + AllTrim(mskOrcamento.Text));
                Executa_SQL(frmTabelas.tbl_PedidoVenda, 'SELECT * FROM PedidoVenda WHERE NUMEROPEDIDO = ' + AllTrim(mskOrcamento.Text));
                if frmTabelas.tbl_PedidoVenda.FieldByName('SITUACAO').AsString='F' then
                   begin
                      beep;
                      showmessage('Pedido j? faturado');
                      mskOrcamento.SelectAll;
                      mskOrcamento.SetFocus;
                      exit;
                   end;

                if frmTabelas.tbl_PedidoVenda.Isempty then
                   begin
                      beep;
                      showmessage('Pedido n?o encontrado');
                      mskOrcamento.SelectAll;
                      mskOrcamento.SetFocus;
                      exit;
                   end
                else
                   begin
                      try
                         mskOrcamento.Text  := FormataNumero(AllTrim(frmTabelas.tbl_PedidoVenda.FieldByName('NUMEROPEDIDO').AsString), 13);
                         mskValorFrete.Text := FormataNumero(frmTabelas.tbl_PedidoVenda.FieldByName('FRETE').AsString, 10, 2);
                         mskDesconto.Text   := FormataNumero(frmTabelas.tbl_PedidoVenda.FieldByName('Desconto').AsString, 10, 2);
                         mskAcrescimo.Text  := FormataNumero(frmTabelas.tbl_PedidoVenda.FieldByName('DespesasAcessorias').AsString, 10, 2);
                         mskPedido.Text     := FormataNumero(AllTrim(frmTabelas.tbl_PedidoVenda.FieldByName('NUMPESSOAS').AsString), 10);

                         s_CodigoCondicaoPagamento := AllTrim(frmTabelas.tbl_PedidoVenda.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString);

                         for i := 0 to cmbCondicaoPagamento.Items.Count do
                            begin
                               if ad_CondicaoPagamento[i] = StrToInt(s_CodigoCondicaoPagamento) then
                                  begin
                                     cmbCondicaoPagamento.ItemIndex := i;
                                     break;
                                  end;
                            end;

                         s_CodigoVendedor := FormataNumero(AllTrim(frmTabelas.tbl_PedidoVenda.FieldByName('VEN_CODVENDEDOR').AsString), 13);
                         s_SQL := 'SELECT Vendedor.CODIGOVENDEDOR, Pessoa.PES_NOME_A FROM Vendedor, Pessoa WHERE Pessoa.PES_CODPESSOA = Vendedor.PES_CODPESSOA AND Vendedor.VEN_CODVENDEDOR = ' + AllTrim(s_CodigoVendedor);
                         Executa_SQL(frmTabelas.tbl_Pessoa, s_SQL);

                         mskIndicador.Text := FormataNumero(AllTrim(frmTabelas.tbl_Pessoa.FieldByName('CODIGOVENDEDOR').AsString), 13);
                         Label6.Caption := Trim(frmTabelas.tbl_Pessoa.FieldByName('PES_NOME_A').AsString);

                         s_CodigoCliente := FormataNumero(AllTrim(frmTabelas.tbl_PedidoVenda.FieldByName('CLI_CODCLIENTE').AsString), 13);

                         s_SQL := 'SELECT Cliente.CODIGOCLIENTE, Pessoa.PES_NOME_A, Cliente.CLI_CODCLIENTE, Pessoa.PES_CPF_CNPJ_A,EP.enp_estado_a '+
                         'FROM Cliente, Pessoa, EnderecoPessoa EP '+
                         'WHERE Pessoa.PES_CODPESSOA = Cliente.PES_CODPESSOA '+
                         'AND Pessoa.PES_CODPESSOA = EnderecoPessoa.PES_CODPESSOA '+
                         'AND EnderecoPessoa.TEN_CODTIPOENDERECO = 4 '+
                         'AND Cliente.CLI_CODCLIENTE = ' + AllTrim(s_CodigoCliente);

                         Executa_SQL(frmTabelas.tbl_Pessoa, s_SQL);

                         mskDestinatarioRemetente.Text := FormataNumero(AllTrim(frmTabelas.tbl_Pessoa.FieldByName('CODIGOCLIENTE').AsString), 13);
                         frmNota.s_UF_endereco:=Trim(frmTabelas.tbl_Pessoa.FieldByName('enp_estado_a').Asstring);
                         Label8.Caption := Trim(frmTabelas.tbl_Pessoa.FieldByName('PES_NOME_A').AsString)+' - '+frmNota.s_UF_endereco;

                         s_CodigoPedido := FormataNumero(AllTrim(frmTabelas.tbl_PedidoVenda.FieldByName('CODIGOPEDIDOVENDA').AsString), 13);
                         s_SQL := 'SELECT Produto.CODIGOPRODUTO, Produto.NOMEPRODUTO, ' +
                                    'ProdutoPedidoVenda.QUANTIDADE, ProdutoPedidoVenda.PRECO, ' +
                                    'ProdutoPedidoVenda.ALIQUOTAICMS, ProdutoPedidoVenda.ALIQUOTAIPI, ' +
                                    'Produto.PESOBRUTO, Produto.PESOLIQUIDO, ClassificacaoFiscal.CODIGOCLASSIFICACAOFISCAL, ' +
                                    'ClassificacaoFiscal.CLASSIFICACAOFISCAL, SituacaoTributaria.CODIGOSITUACAOTRIBUTARIA, ' +
                                    'SituacaoTributaria.SITUACAOTRIBUTARIA ' +
                             'FROM Produto, ProdutoPedidoVenda, ClassificacaoFiscal, SituacaoTributaria ' +
                             'WHERE ProdutoPedidoVenda.CODIGOPRODUTO = Produto.CODIGOPRODUTO ' +
                             'AND ClassificacaoFiscal.CODIGOCLASSIFICACAOFISCAL = Produto.CODIGOCLASSIFICACAOFISCAL ' +
                             'AND SituacaoTributaria.CODIGOSITUACAOTRIBUTARIA = Produto.CODIGOSITUACAOTRIBUTARIA ' +
                             'AND (ProdutoPedidoVenda.ENTREGUE <> ProdutoPedidoVenda.QUANTIDADE or ProdutoPedidoVenda.ENTREGUE is null )'+
                             'AND ProdutoPedidoVenda.CODIGOPEDIDOVENDA = ' + s_CodigoPedido +
                             'ORDER BY Produto.CODIGOPRODUTO';
                         Log('Carregando produtos do pedido de venda: '+s_SQL);
                         Executa_SQL(frmTabelas.tbl_ProdutoPedidoVenda, s_SQL);

                         dgrdDBGrid.Visible := true;
                         grdStringGrid.Visible := false;

                         dgrdDBGrid.DataSource.Enabled := false;
                         dgrdDBGrid.DataSource.DataSet := frmTabelas.tbl_ProdutoPedidoVenda;
                         dgrdDBGrid.DataSource.Enabled := true;
                      except
                         beep;
                         mskOrcamento.SelectAll;
                         mskOrcamento.SetFocus;
                         exit;
                      end;
                   end;
            end;

            // Limpa filtro de exlusao dos produtos do grid
            s_Filtro := '';

            cmbCondicaoPagamento.Enabled := false;
            mskIndicador.Enabled := false;
            cmdConsultaIndicador.Enabled := false;
            mskDestinatarioRemetente.Enabled := false;
            cmdConsultaDestinatarioRemetente.Enabled := false;
            mskProduto.Enabled := false;
            cmdConsultaProduto.Enabled := false;
            cmbPreco.Enabled := false;
            mskPreco.Text    := '         000';
            mskPreco.readonly:= true;
            mskQuantidade.Enabled := false;

            Processa_Valores_DBGrid;
        end;
    end;
    b_Sair:= true;
end;

procedure TfrmNota.cmdConsultaOrcamentoClick(Sender: TObject);
begin
    if optEntrada.Checked then
    begin
        Executa_SQL(frmTabelas.tbl_PedidoCompra, 'SELECT * FROM PedidoCompra ORDER BY NUMEROPEDIDO');
        frmListagem.DataSource1.DataSet := frmTabelas.tbl_PedidoCompra;
    end
    else
    begin
        Executa_SQL(frmTabelas.tbl_PedidoVenda, 'SELECT * FROM PedidoVenda where situacao<>'+quotedstr('F')+' ORDER BY NUMEROPEDIDO');
        frmListagem.DataSource1.DataSet := frmTabelas.tbl_PedidoVenda;
    end;

    frmListagem.Caption := 'Autocom PLUS  -  ' + Trim(Label4.Caption);
    frmListagem.ShowModal;
end;

procedure TfrmNota.cmbCondicaoPagamentoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.mskSerieKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.mskIndicadorEnter(Sender: TObject);
begin
    Label44.Caption := '[F1] - Consulta de ' + LeftStr(Trim(Label5.Caption), Length(Trim(Label5.Caption)) - 1);
end;

procedure TfrmNota.mskIndicadorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        mskDestinatarioRemetente.SetFocus;

    if Key = VK_F1 then
        cmdConsultaIndicador.Click;
end;

procedure TfrmNota.mskIndicadorExit(Sender: TObject);
begin
    Label44.Caption := '[F1] - Consulta...';

    if (not cmdConsultaIndicador.Focused) and (not cmdFechar.Focused) and (b_Sair) then
    begin
        s_CodigoVendedor := '';

        if Length(AllTrim(mskIndicador.Text)) > 0 then
        begin
            Executa_SQL(frmTabelas.tbl_Vendedor, 'SELECT * FROM Vendedor Vendedor, Pessoa Pessoa WHERE Pessoa.PES_CODPESSOA = Vendedor.PES_CODPESSOA AND Vendedor.CODIGOVENDEDOR = ' + AllTrim(mskIndicador.Text));

            mskIndicador.Text := FormataNumero(AllTrim(mskIndicador.Text), 13);

            try
                s_CodigoVendedor := FormataNumero(IntToStr(frmTabelas.tbl_Vendedor.FieldByName('VEN_CODVENDEDOR').Value), 13);
                Label6.Caption := frmTabelas.tbl_Vendedor.FieldByName('PES_NOME_A').Value;
            except
                Label6.Caption := 'C?digo Iv?lido';
                beep;
                mskIndicador.SelectAll;
                mskIndicador.SetFocus;
            end;
        end
        else
           begin
              Label6.Caption := '';
              s_CodigoVendedor := 'null';
           end;
    end;

    b_Sair := true;
end;

procedure TfrmNota.cmdConsultaIndicadorClick(Sender: TObject);
begin
    Executa_SQL(frmTabelas.tbl_Vendedor, 'SELECT * FROM Vendedor INNER JOIN Pessoa ON (Vendedor.PES_CODPESSOA = Pessoa.PES_CODPESSOA)');

    frmListagem.DataSource1.DataSet := frmTabelas.tbl_Vendedor;
    frmListagem.Caption := 'Autocom PLUS  -  Indicadores';
    frmListagem.ShowModal;
end;

procedure TfrmNota.mskDestinatarioRemetenteEnter(Sender: TObject);
begin
    Label44.Caption := '[F1] - Consulta de ' + LeftStr(Trim(Label7.Caption), Length(Trim(Label7.Caption)) - 1);
end;

procedure TfrmNota.mskDestinatarioRemetenteKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if Key = VK_RETURN then
        mskPedido.SetFocus;

    if Key = VK_F1 then
        cmdConsultaDestinatarioRemetente.Click;
end;

procedure TfrmNota.mskDestinatarioRemetenteExit(Sender: TObject);
var i_TipoErro: Integer;
    s_CPF_CNPJ: String;
    s_SQL: String;
begin
    Label44.Caption := '[F1] - Consulta...';

    if (not cmdConsultaDestinatarioRemetente.Focused) and (not cmdFechar.Focused) and (b_Sair) then
    begin
        s_CodigoCliente := 'null';
        s_CodigoFornecedor := 'null';

        if Length(AllTrim(mskDestinatarioRemetente.Text)) > 0 then
        begin
            s_CPF_CNPJ := '';

            i_TipoErro := 0;

            mskDestinatarioRemetente.Text := FormataNumero(AllTrim(mskDestinatarioRemetente.Text), 13);

            if optEntrada.Checked then // verifica se ? nota fiscal de saida ou entrada
                s_SQL := 'SELECT Fornecedor.CODIGOFORNECEDOR,Pessoa.PES_NOME_A,Fornecedor.FRN_CODFORNECEDOR, Pessoa.PES_CPF_CNPJ_A,EP.enp_estado_a '+
                         'FROM Fornecedor, Pessoa, EnderecoPessoa EP  '+
                         'WHERE Pessoa.PES_CODPESSOA = Fornecedor.PES_CODPESSOA '+
                         'AND Pessoa.PES_CODPESSOA = EnderecoPessoa.PES_CODPESSOA '+
                         'AND EnderecoPessoa.TEN_CODTIPOENDERECO = 4 '+
                         'AND Fornecedor.CODIGOFORNECEDOR = ' + AllTrim(mskDestinatarioRemetente.Text)


            else
                s_SQL := 'SELECT Cliente.CODIGOCLIENTE, Pessoa.PES_NOME_A, Cliente.CLI_CODCLIENTE, Pessoa.PES_CPF_CNPJ_A,EP.enp_estado_a '+
                         'FROM Cliente, Pessoa, EnderecoPessoa EP '+
                         'WHERE Pessoa.PES_CODPESSOA = Cliente.PES_CODPESSOA '+
                         'AND Pessoa.PES_CODPESSOA = EnderecoPessoa.PES_CODPESSOA '+
                         'AND EnderecoPessoa.TEN_CODTIPOENDERECO = 4 '+
                         'AND Cliente.CODIGOCLIENTE = ' + AllTrim(mskDestinatarioRemetente.Text);


            Executa_SQL(frmTabelas.tbl_Pessoa, s_SQL);

            try
                if optEntrada.Checked then
                    s_CodigoFornecedor := FormataNumero(IntToStr(frmTabelas.tbl_Pessoa.FieldByName('FRN_CODFORNECEDOR').Value), 13)
                else
                    s_CodigoCliente := FormataNumero(IntToStr(frmTabelas.tbl_Pessoa.FieldByName('CLI_CODCLIENTE').Value), 13);

                s_UF_endereco:=Trim(frmTabelas.tbl_Pessoa.FieldByName('enp_estado_a').Asstring);

                Label8.Caption := Trim(frmTabelas.tbl_Pessoa.FieldByName('PES_NOME_A').Value) +' - '+s_UF_endereco;

                s_CPF_CNPJ := Trim(frmTabelas.tbl_Pessoa.FieldByName('PES_CPF_CNPJ_A').Value);


            except
                if optEntrada.Checked then
                begin
                    if (s_CodigoFornecedor = 'null') or (Length(Label8.Caption)  = 0) then
                        i_TipoErro := 1
                    else
                        i_TipoErro := 2;
                end
                else
                begin
                    if (s_CodigoCliente = 'null') or (Length(Label8.Caption)  = 0) then
                        i_TipoErro := 1
                    else
                        i_TipoErro := 2;
                end;
            end;

            case i_TipoErro of
                1:
                begin
                    Label8.Caption := 'C?digo Inv?lido';
                    beep;
                    mskDestinatarioRemetente.SelectAll;
                    mskDestinatarioRemetente.SetFocus;
                end;
                2:
                begin
                    Label8.Caption:='Falta CPF / CNPJ';
                    beep;
                    mskDestinatarioRemetente.SetFocus;
                    mskDestinatarioRemetente.selectall;
                end;
            end;
        end
        else
            Label8.Caption := '';
    end;

    b_Sair := true;
end;

procedure TfrmNota.cmdConsultaDestinatarioRemetenteClick(Sender: TObject);
var s_sql:string;
begin
    if optEntrada.Checked then
    begin
                s_SQL := 'SELECT Fornecedor.CODIGOFORNECEDOR,Fornecedor.FRN_CODFORNECEDOR, Pessoa.PES_NOME_A, Pessoa.PES_CPF_CNPJ_A,EP.enp_estado_a '+
                         'FROM Fornecedor, Pessoa, EnderecoPessoa EP  '+
                         'WHERE Pessoa.PES_CODPESSOA = Fornecedor.PES_CODPESSOA '+
                         'AND Pessoa.PES_CODPESSOA = EnderecoPessoa.PES_CODPESSOA '+
                         'AND EnderecoPessoa.TEN_CODTIPOENDERECO = 4 ';
        LOG('Consultando lista de fornecedores: '+s_SQL);
        Executa_SQL(frmTabelas.tbl_pessoa, s_sql);
        frmListagem.DataSource1.DataSet := frmTabelas.tbl_Pessoa;
        frmListagem.Caption := 'Autocom PLUS  -  Fornecedores';
    end
    else
    begin
                s_SQL := 'SELECT Cliente.CODIGOCLIENTE,Cliente.CLI_CODCLIENTE, Pessoa.PES_NOME_A, Pessoa.PES_CPF_CNPJ_A,EP.enp_estado_a '+
                         'FROM Cliente, Pessoa, EnderecoPessoa EP '+
                         'WHERE Pessoa.PES_CODPESSOA = Cliente.PES_CODPESSOA '+
                         'AND Pessoa.PES_CODPESSOA = EnderecoPessoa.PES_CODPESSOA '+
                         'AND EnderecoPessoa.TEN_CODTIPOENDERECO = 4 ';

        LOG('Consultando lista de clientes: '+s_SQL);
        Executa_SQL(frmTabelas.tbl_pessoa, s_sql);
        frmListagem.DataSource1.DataSet := frmTabelas.tbl_Pessoa;
        frmListagem.Caption := 'Autocom PLUS  -  Clientes';
    end;

    frmListagem.ShowModal;
end;

procedure TfrmNota.mskPedidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL,0,0);
end;

procedure TfrmNota.mskPedidoExit(Sender: TObject);
begin
    if Length(AllTrim(mskPedido.Text)) > 0 then
        mskPedido.Text := AllTrim(mskPedido.Text);
end;

procedure TfrmNota.datDataEmissaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.datDataEntradaSaidaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.datHoraSaidaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.mskProdutoEnter(Sender: TObject);
begin
    Label44.Caption := '[F1] - Consulta de Produto';
end;

procedure TfrmNota.mskProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
    begin
        if optSaida.checked=true then
           begin
              cmbPreco.SelectAll;
              cmbPreco.SetFocus;
           end;

        if optEntrada.checked=true then
           begin
              if Produto_controla_lote=true then
                 begin
                    mskLote.SelectAll;
                    mskLote.SetFocus;
                 end
              else
                 begin
                    mskPreco.SelectAll;
                    mskPreco.SetFocus;
                 end;
           end;
    end;

    if Key = VK_F1 then
        cmdConsultaProduto.Click;
end;

procedure TfrmNota.mskProdutoExit(Sender: TObject);
var
   s_codigo:string;
begin
    Label44.Caption := '[F1] - Consulta...';

    if (not cmdConsultaProduto.Focused) and (not cmdFechar.Focused) and (not cmdGravar.Focused) and (b_Sair) then
    begin
        s_codigo:=AllTrim(trim(mskProduto.Text));
        if Length(s_codigo) > 0 then
        begin
            mskProduto.Text := FormataNumero(AllTrim(mskProduto.Text), 13);
            Pega_Produto;
        end
        else
        begin
            Label17.Caption := '';
            cmbPreco.Clear;
            mskPreco.Text    := '         000';
            mskQuantidade.Clear;
            mskProduto.setfocus;
        end;

    end;

    b_Sair := true;
end;


procedure TfrmNota.cmdConsultaProdutoClick(Sender: TObject);
begin
    Executa_SQL(frmTabelas.tbl_Produto, 'SELECT * FROM ClassificacaoFiscal, Produto, SituacaoTributaria, ICMSProduto ' +
                                        'WHERE ClassificacaoFiscal.CODIGOCLASSIFICACAOFISCAL = Produto.CODIGOCLASSIFICACAOFISCAL ' +
                                        'AND SituacaoTributaria.CODIGOSITUACAOTRIBUTARIA = Produto.CODIGOSITUACAOTRIBUTARIA ' +
                                        'AND ICMSProduto.UF='+quotedstr(s_UF_endereco)+
                                        ' AND ICMSProduto.CODIGOPRODUTO = Produto.CODIGOPRODUTO'+
                                        ' order by produto.CODIGOPRODUTO');

    frmListagem.DataSource1.DataSet := frmTabelas.tbl_Produto;
    frmListagem.Caption := 'Autocom PLUS  -  Produtos';
    frmListagem.ShowModal;

    if Length(AllTrim(mskProduto.Text)) > 0 then
       begin
          mskProduto.Text := FormataNumero(AllTrim(mskProduto.Text), 13);
          Pega_Produto;
          mskProduto.setfocus;
       end
    else
       begin
          Label17.Caption := '';
          cmbPreco.Clear;
          mskPreco.Text    := '         000';
          mskQuantidade.Clear;
          mskProduto.setfocus;
       end;
end;


procedure TfrmNota.Pega_Produto;
var
   s_cmdSQL:String;
begin
     s_cmdSQL:='SELECT * FROM ClassificacaoFiscal, Produto, SituacaoTributaria, ICMSProduto ' +
                                                'WHERE ClassificacaoFiscal.CODIGOCLASSIFICACAOFISCAL = Produto.CODIGOCLASSIFICACAOFISCAL ' +
                                                'AND SituacaoTributaria.CODIGOSITUACAOTRIBUTARIA = Produto.CODIGOSITUACAOTRIBUTARIA ' +
                                                'AND ICMSProduto.CODIGOPRODUTO = Produto.CODIGOPRODUTO ' +
                                                'AND ICMSProduto.UF='+quotedstr(s_UF_endereco)+
                                                ' AND Produto.CODIGOPRODUTO = ' + AllTrim(mskProduto.Text);

     LOG('Procurando o Produto: '+s_cmdSQL);
     Executa_SQL(frmTabelas.tbl_Produto, s_cmdSQL);

     if frmTabelas.tbl_Produto.IsEmpty then
        begin
           Label17.Caption:='C?digo Inv?lido';
           beep;
           showmessage('Produto n?o cadastrado ou sem aliquota de ICMS para o Estado '+s_UF_endereco);
           mskProduto.Clear;

           mskProduto.SelectAll;
           mskProduto.SetFocus;
        end
     else
        begin
           Label17.Caption := frmTabelas.tbl_Produto.FieldByName('NOMEPRODUTO').AsString;

           s_aliquota_ICMSPRODUTO:=frmTabelas.tbl_Produto.FieldByName('ALIQUOTA').AsString;

           if frmTabelas.tbl_Produto.FieldByName('Controla_lote').AsString='1' then
              begin
                 Produto_controla_lote:=true;
                 Label15.visible:=true;
                 mskLote.visible:=true;
              end
           else
              begin
                 Produto_controla_lote:=false;
                 Label15.visible:=false;
                 mskLote.visible:=false;
              end;

           if optSaida.checked=true then
              begin// Nota Fiscal de saida
                 cmbPreco.enabled:=true;
                 Executa_SQL(frmTabelas.tbl_TabelaPreco, 'SELECT COUNT(*) FROM TabelaPreco INNER JOIN ProdutoTabelaPreco ' +
                                                        'ON (TabelaPreco.CODIGOTABELAPRECO = ProdutoTabelaPreco.CODIGOTABELAPRECO) ' +
                                                        'WHERE ProdutoTabelaPreco.CODIGOPRODUTO = ' + mskProduto.Text);

                 SetLength(ad_Preco, frmTabelas.tbl_TabelaPreco.Fields[0].AsInteger);

                 Executa_SQL(frmTabelas.tbl_TabelaPreco, 'SELECT * FROM TabelaPreco INNER JOIN ProdutoTabelaPreco ' +
                                                        'ON (TabelaPreco.CODIGOTABELAPRECO = ProdutoTabelaPreco.CODIGOTABELAPRECO) ' +
                                                        'WHERE ProdutoTabelaPreco.CODIGOPRODUTO = ' + mskProduto.Text);

                 cmbPreco.Clear;

                 if frmTabelas.tbl_TabelaPreco.RecordCount > 0 then // verifica se o produto tem tabela de preco
                    begin
                       while (not frmTabelas.tbl_TabelaPreco.Eof) do
                          begin
                             cmbPreco.Items.Add(frmTabelas.tbl_TabelaPreco.FieldByName('TABELAPRECO').AsString);
                             ad_Preco[frmTabelas.tbl_TabelaPreco.RecNo - 1] := frmTabelas.tbl_TabelaPreco.FieldByName('PRECO').AsFloat;
                             frmTabelas.tbl_TabelaPreco.Next;
                          end;
                    end
                 else
                    begin
                       showmessage('Produto sem tabela de pre?o!');
                       mskProduto.setfocus;
                    end;
              end;
           if optEntrada.checked=true then
              begin// Nota Fiscal de entrada
                 cmbPreco.enabled:=false;
                 Executa_SQL(frmTabelas.tbl_Estoque, 'SELECT PRECOREPOSICAO FROM ESTOQUE WHERE CODIGOPRODUTO='+mskProduto.Text);
                 mskPreco.readonly:=false;

                 mskPreco.EditMask := '9999999999,99;1; ';
                 mskPreco.Text := FormataNumero(AllTrim(frmTabelas.tbl_Estoque.FieldByName('PRECOREPOSICAO').AsString), 10, 2);
                 mskPreco.EditMask := '9999999999,9;0; ';
              end;
        end;

end;
procedure TfrmNota.cmbPrecoChange(Sender: TObject);
begin
     mskPreco.EditMask := '9999999999,99;1; ';
     mskPreco.Text:=FormataNumero(AllTrim(FloatToStr(ad_Preco[cmbPreco.ItemIndex])), 0, 2);
     mskPreco.EditMask := '9999999999,9;0; ';
     mskPreco.readonly:=true;
end;

procedure TfrmNota.cmbPrecoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.cmbPrecoExit(Sender: TObject);
var i: Integer;
    db_Preco: Double;
    s_Preco: String;
begin
    if (cmbPreco.ItemIndex = -1) or (cmdFechar.Focused) then
        exit;

    db_Preco := 0;
    for i := 0 to (cmbPreco.Items.Count - 1) do
        db_Preco := db_Preco + ad_Preco[i];

    s_Preco := AllTrim(Filtrar(mskPreco.Text, 'R$'));

    if StrToFloat(s_Preco) <= 0 then
    begin
        if db_Preco > 0 then
        begin
            s_Preco := 'Produto sem pre?o unit?rio (' + cmbPreco.Items.Strings[cmbPreco.ItemIndex] + ').';
            Application.MessageBox(PChar(s_Preco), 'Autocom PLUS', 16);
            cmbPreco.SelectAll;
            cmbPreco.SetFocus;
        end
        else
        begin
            s_Preco := 'Produto sem Tabela de Pre?o.';
            Application.MessageBox(PChar(s_Preco), 'Autocom PLUS', 16);
            mskProduto.SelectAll;
            mskProduto.SetFocus;
        end;
    end;
end;

procedure TfrmNota.mskQuantidadeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var s_preco:string;
begin
    if Key = VK_RETURN then
    begin
        if Length(AllTrim(mskQuantidade.Text)) > 0 then
        begin
           if optSaida.checked=true then
              begin
                 if (Length(AllTrim(mskProduto.Text)) > 0) and (cmbPreco.ItemIndex > -1) then
                    begin
                       if grdStringGrid.RowCount > 21 then
                          begin
                             Application.MessageBox('O limite m?ximo de itens por nota j? foi alcan?ado.', 'Autocom PLUS', 16);
                             exit;
                          end;
                       Insere_Dados_StringGrid
                    end
                 else
                    begin
                       Application.MessageBox(PChar('Selecione um pre?o.'), 'Autocom', 16);
                       beep;
                       mskProduto.SelectAll;
                       mskProduto.SetFocus;
                    end;
              end;
           if optEntrada.checked=true then
              begin
                 if (Length(AllTrim(mskProduto.Text)) > 0) then
                    begin
                       mskPreco.EditMask:='9999999999,99;1; ';
                       s_Preco:=mskPreco.text;
                       mskPreco.Text := FormataNumero(s_Preco, 10, 2);
                       mskQuantidade.EditMask := '99999999,999;0; ';

                       if STRtoFloat(s_preco) <=0 then
                          begin
                             Application.MessageBox(PChar('Informe o pre?o de custo do produto.'), 'Autocom', 16);
                             beep;
                             mskPreco.SelectAll;
                             mskPreco.SetFocus;
                          end
                       else
                          begin
                             Insere_Dados_StringGrid;
                          end;
                    end;
              end;
        end;
    end;
end;

procedure TfrmNota.mskQuantidadeExit(Sender: TObject);
var s_Valor: String;
begin
    mskQuantidade.EditMask := '99999999,999;1; ';
    s_Valor := mskQuantidade.Text;
    mskQuantidade.Text := FormataNumero(s_Valor, 8, 3);
    mskQuantidade.EditMask := '99999999,999;0; ';
end;

procedure TfrmNota.dgrdDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var s_CodigoPedido: String;
    s_CodigoProduto: String;
    s_SQL: String;
begin
    if Key = VK_DELETE then
    begin
        if (not cmdGravar.Enabled) or (not mskOrcamento.Enabled) or (frmTabelas.tbl_ProdutoPedidoVenda.RecordCount <= 0) then
            exit;

        try
            if Application.MessageBox('Deseja retirar o produto da lista?', 'Autocom PLUS', 36) = mrYes then
            begin
                if AllTrim(mskOrcamento.Text) <> '' then
                begin
                    if optEntrada.Checked then
                    begin
                        s_CodigoPedido := FormataNumero(AllTrim(frmTabelas.tbl_PedidoCompra.FieldByName('CODIGOPEDIDOCOMPRA').AsString), 13);

                        s_CodigoProduto := AllTrim(frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('CODIGOPRODUTO').AsString);
                        s_Filtro := s_Filtro + ' AND Produto.CODIGOPRODUTO <> ' + s_CodigoProduto;

                        s_SQL := 'SELECT Produto.CODIGOPRODUTO, Produto.NOMEPRODUTO, ' +
                                 'ProdutoPedidoCompra.QUANTIDADE, ProdutoPedidoCompra.PRECO, ' +
                                 'ProdutoPedidoCompra.ALIQUOTAICMS, ProdutoPedidoCompra.ALIQUOTAIPI, ' +
                                 'Produto.PESOBRUTO, Produto.PESOLIQUIDO, ClassificacaoFiscal.CODIGOCLASSIFICACAOFISCAL, ' +
                                 'ClassificacaoFiscal.CLASSIFICACAOFISCAL, SituacaoTributaria.CODIGOSITUACAOTRIBUTARIA, ' +
                                 'SituacaoTributaria.SITUACAOTRIBUTARIA ' +
                                 'FROM Produto, ProdutoPedidoCompra, ClassificacaoFiscal, SituacaoTributaria ' +
                                 'WHERE ProdutoPedidoCompra.CODIGOPRODUTO = Produto.CODIGOPRODUTO' +
                                 ' AND ClassificacaoFiscal.CODIGOCLASSIFICACAOFISCAL = Produto.CODIGOCLASSIFICACAOFISCAL' +
                                 ' AND SituacaoTributaria.CODIGOSITUACAOTRIBUTARIA = Produto.CODIGOSITUACAOTRIBUTARIA' +
                                 ' AND ProdutoPedidoCompra.ENTREGUE <> ProdutoPedidoCompra.QUANTIDADE ' +
                                 ' AND ProdutoPedidoCompra.CODIGOPEDIDOCOMPRA = ' + s_CodigoPedido + s_Filtro +
                                 ' ORDER BY Produto.CODIGOPRODUTO';

                        Executa_SQL(frmTabelas.tbl_ProdutoPedidoCompra, s_SQL);

                        if frmTabelas.tbl_ProdutoPedidoCompra.RecordCount <= 0 then
                            exit;
                    end
                    else
                    begin
                        s_CodigoPedido := FormataNumero(AllTrim(frmTabelas.tbl_PedidoVenda.FieldByName('CODIGOPEDIDOVENDA').AsString), 13);

                        s_CodigoProduto := AllTrim(frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('CODIGOPRODUTO').AsString);
                        s_Filtro := s_Filtro + ' AND Produto.CODIGOPRODUTO <> ' + s_CodigoProduto;

                        s_SQL := 'SELECT Produto.CODIGOPRODUTO, Produto.NOMEPRODUTO, ' +
                                 'ProdutoPedidoVenda.QUANTIDADE, ProdutoPedidoVenda.PRECO, ' +
                                 'ProdutoPedidoVenda.ALIQUOTAICMS, ProdutoPedidoVenda.ALIQUOTAIPI, ' +
                                 'Produto.PESOBRUTO, Produto.PESOLIQUIDO, ClassificacaoFiscal.CODIGOCLASSIFICACAOFISCAL, ' +
                                 'ClassificacaoFiscal.CLASSIFICACAOFISCAL, SituacaoTributaria.CODIGOSITUACAOTRIBUTARIA, ' +
                                 'SituacaoTributaria.SITUACAOTRIBUTARIA ' +
                                 'FROM Produto, ProdutoPedidoVenda, ClassificacaoFiscal, SituacaoTributaria ' +
                                 'WHERE ProdutoPedidoVenda.CODIGOPRODUTO = Produto.CODIGOPRODUTO' +
                                 ' AND ClassificacaoFiscal.CODIGOCLASSIFICACAOFISCAL = Produto.CODIGOCLASSIFICACAOFISCAL' +
                                 ' AND SituacaoTributaria.CODIGOSITUACAOTRIBUTARIA = Produto.CODIGOSITUACAOTRIBUTARIA' +
                                 ' AND ProdutoPedidoVenda.ENTREGUE <> ProdutoPedidoVenda.QUANTIDADE ' +
                                 ' AND ProdutoPedidoVenda.CODIGOPEDIDOVENDA = ' + s_CodigoPedido + s_Filtro +
                                 ' ORDER BY Produto.CODIGOPRODUTO';

                        Executa_SQL(frmTabelas.tbl_ProdutoPedidoVenda, s_SQL);

                        if frmTabelas.tbl_ProdutoPedidoVenda.RecordCount <= 0 then
                            exit;
                    end;
                    Processa_Valores_DBGrid;

                    dgrdDBGrid.SetFocus;
                end;
            end;
        except
            if optEntrada.Checked then
            begin
                if frmTabelas.tbl_ProdutoPedidoCompra.RecordCount <= 0 then
                    frmTabelas.tbl_ProdutoPedidoCompra.Close;
            end
            else
            begin
                if frmTabelas.tbl_ProdutoPedidoVenda.RecordCount <= 0 then
                    frmTabelas.tbl_ProdutoPedidoVenda.Close;
            end;
        end;
    end;
end;

procedure TfrmNota.grdStringGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_DELETE then
    begin
        if (not cmdGravar.Enabled) or (not mskOrcamento.Enabled) then
            exit;

        if (grdStringGrid.Row > 0) and (grdStringGrid.Row < grdStringGrid.RowCount-1) then
        begin
            Exclui_Dados_StringGrid(grdStringGrid.Row);
            Processa_Valores_StringGrid;
            Retira_Virgula_MaskEdit;
        end;
    end;
end;

procedure TfrmNota.mskValorSeguroKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.mskValorSeguroExit(Sender: TObject);
begin
    Calcula_Valor_Total_Nota;
end;

procedure TfrmNota.mskOutrasDespesasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.mskOutrasDespesasExit(Sender: TObject);
begin
    Calcula_Valor_Total_Nota;
end;

procedure TfrmNota.mskValorFreteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.mskValorFreteExit(Sender: TObject);
begin
    Calcula_Valor_Total_Nota;
end;

procedure TfrmNota.mskCodigoTransportadorEnter(Sender: TObject);
begin
    Label44.Caption := '[F1] - Consulta de Transportadora';
end;

procedure TfrmNota.mskCodigoTransportadorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if Key = VK_RETURN then
        cmbFretePorConta.SetFocus;

    if Key = VK_F1 then
        cmdConsultaCodigoTransportador.Click;
end;

procedure TfrmNota.mskCodigoTransportadorExit(Sender: TObject);
begin
    Label44.Caption := '[F1] - Consulta...';

    if (not cmdConsultaCodigoTransportador.Focused) and (not cmdFechar.Focused) and (b_Sair) then
    begin
        s_CodigoTransportadora := 'null';
        
        if Length(AllTrim(mskCodigoTransportador.Text)) > 0 then
        begin
            Executa_SQL(frmTabelas.tbl_Pessoa, 'SELECT Transportadora.TRP_CODTRANSPORTADORA, Pessoa.PES_NOME_A FROM Transportadora, Pessoa WHERE Transportadora.PES_CODPESSOA = Pessoa.PES_CODPESSOA AND Transportadora.CODIGOTRANSPORTADORA = ' + AllTrim(mskCodigoTransportador.Text));

            mskCodigoTransportador.Text := FormataNumero(AllTrim(mskCodigoTransportador.Text), 4);

            try
                s_CodigoTransportadora := FormataNumero(AllTrim(frmTabelas.tbl_Pessoa.FieldByName('TRP_CODTRANSPORTADORA').AsString), 4);
                txtNomeTransportador.Text := Trim(frmTabelas.tbl_Pessoa.FieldByName('PES_NOME_A').Value);
            except
                txtNomeTransportador.Text := 'C?digo Inv?lido';
                beep;
                mskCodigoTransportador.SelectAll;
                mskCodigoTransportador.SetFocus;
            end;
        end
        else
            txtNomeTransportador.Text := '';
    end;
end;

procedure TfrmNota.cmdConsultaCodigoTransportadorClick(Sender: TObject);
begin
    Executa_SQL(frmTabelas.tbl_Transportadora, 'SELECT * FROM Transportadora INNER JOIN Pessoa ON (Transportadora.PES_CODPESSOA = Pessoa.PES_CODPESSOA)');

    frmListagem.DataSource1.DataSet := frmTabelas.tbl_Transportadora;
    frmListagem.Caption := 'Autocom PLUS  -  Transportadoras';
    frmListagem.ShowModal;
end;

procedure TfrmNota.txtNomeTransportadorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.cmbFretePorContaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.txtPlacaVeiculoKeyPress(Sender: TObject; var Key: Char);
begin
    if (Key = #34) or (Key = #39) then
    begin
        Key := #00;
        Beep;
    end;
end;

procedure TfrmNota.txtPlacaVeiculoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.cmbUFKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.mskQuantidadeVolumesKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.mskQuantidadeVolumesExit(Sender: TObject);
var s_Valor: String;
begin
     mskQuantidadeVolumes.EditMask := '99999999,999;1; ';
     s_Valor := AllTrim(mskQuantidadeVolumes.Text);
     mskQuantidadeVolumes.Text := FormataNumero(s_Valor, 8, 3);
     mskQuantidadeVolumes.EditMask := '99999999,999;0; ';
end;

procedure TfrmNota.txtEspecieKeyPress(Sender: TObject; var Key: Char);
begin
    if (Key = #34) or (Key = #39) then
    begin
        Key := #00;
        Beep;
    end;
end;

procedure TfrmNota.txtEspecieKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.txtEspecieExit(Sender: TObject);
begin
    txtEspecie.Text := Trim(txtEspecie.Text);
end;

procedure TfrmNota.txtMarcaKeyPress(Sender: TObject; var Key: Char);
begin
    if (Key = #34) or (Key = #39) then
    begin
        Key := #00;
        Beep;
    end;
end;

procedure TfrmNota.txtMarcaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.txtMarcaExit(Sender: TObject);
begin
    txtMarca.Text := Trim(txtMarca.Text);
end;

procedure TfrmNota.mskNumeroKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.mskNumeroExit(Sender: TObject);
begin
    mskNumero.Text := FormataNumero(AllTrim(mskNumero.Text), 13);
end;

procedure TfrmNota.mskPesoBrutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.mskPesoBrutoExit(Sender: TObject);
var s_Valor: String;
begin
     mskPesoBruto.EditMask := '99999999,999;1; ';
     s_Valor := AllTrim(mskPesoBruto.Text);
     mskPesoBruto.Text := FormataNumero(s_Valor, 8, 3);
     mskPesoBruto.EditMask := '99999999,999;0; ';

     if StrToFloat(AllTrim(mskPesoLiquido.Text)) <= 0 then
     begin
        s_Valor := FloatToStrF((StrToFloat(AllTrim(s_Valor)) * 0.9), ffNumber, 8, 3);
        mskPesoLiquido.EditMask := '99999999,999;1; ';
        mskPesoLiquido.Text := FormataNumero(s_Valor, 8, 3);
        mskPesoLiquido.EditMask := '99999999,999;0; ';
     end;
end;

procedure TfrmNota.mskPesoLiquidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.mskPesoLiquidoExit(Sender: TObject);
var s_Valor: String;
begin
    mskPesoLiquido.EditMask := '99999999,999;1; ';
    s_Valor := AllTrim(mskPesoLiquido.Text);
    mskPesoLiquido.Text := FormataNumero(s_Valor, 8, 3);
    mskPesoLiquido.EditMask := '99999999,999;0; ';

    if StrToFloat(AllTrim(mskPesoBruto.Text)) <= 0 then
    begin
        s_Valor := FloatToStrF((StrToFloat(AllTrim(s_Valor)) * 1.11111111), ffNumber, 8, 3);
        mskPesoBruto.EditMask := '99999999,999;1; ';
        mskPesoBruto.Text := FormataNumero(s_Valor, 8, 3);
        mskPesoBruto.EditMask := '99999999,999;0; ';
    end;
end;

procedure TfrmNota.cmdGravarClick(Sender: TObject);
var i: Integer;
    i_DivisaoInteira: Integer;
    i_Resto: Integer;
    i_Inicio: Integer;
    i_Final: Integer;
    s_NumeroNota: String;
    s_SQL: String;
begin
    if cmdGravar.Caption = '&Gravar' then
    begin
        if Application.MessageBox('Confirma a grava??o da Nota Fiscal?', 'Autocom PLUS', 36) = mrYes then
        begin

            if not Validacao then exit;

            Troca_Maskara(true);

            if optEntrada.Checked then
            begin // nota fiscal de entrada
               Log('Grava??o da emiss?o da Nota Fiscal de Entrada n? '+ mskCodNotaFiscal.Text);

                Executa_SQL(frmTabelas.rede, 'SELECT * FROM NotaFiscalEntrada WHERE NUMERONOTA = ' + mskCodNotaFiscal.Text);

                if frmTabelas.rede.IsEmpty=false then
                begin
                    s_SQL := 'UPDATE NOTAFISCALENTRADA SET ' +
                             'CODIGONATUREZAOPERACAO = ' + mskCFOP.Text + ', ' +
                             'CODIGOPEDIDOCOMPRA = ' + s_CodigoPedido + ', ' +
                             'SERIE = ' + chr(39) + mskSerie.Text + chr(39)+ ', ' +
                             'VEN_CODVENDEDOR = ' + s_CodigoVendedor + ', ' +
                             'FRN_CODFORNECEDOR = ' + s_CodigoFornecedor + ', ' +
                             'PEDIDOEXTERNO = ' + chr(39) + mskPedido.Text + chr(39) + ', ' +
                             'DATAEMISSAO = ' + chr(39) + FormatDateTime('mm/dd/yyyy', datDataEmissao.Date) + chr(39) + ', ' +
                             'DATAENTREGA = ' + chr(39) + FormatDateTime('mm/dd/yyyy', datDataEntradaSaida.Date) + chr(39) + ', ' +
                             'HORASAIDA = ' + chr(39) + FormatDateTime('mm/dd/yyyy', Date) + ' ' + FormatDateTime('hh:nn:ss', datHoraSaida.Time) + chr(39) + ', ' +
                             'BASEICMS = ' + TrocaTexto(mskBaseCalculoICMS.Text, ',', '.') + ', ' +
                             'ICMS = ' + TrocaTexto(mskValorICMS.Text, ',', '.') + ', ' +
                             'BASEICMSSUBSTITUICAO = ' + TrocaTexto(mskBaseCalculoICMSSub.Text, ',', '.') + ', ' +
                             'ICMSSUBSTITUICAO = ' + TrocaTexto(mskValorICMSSub.Text, ',', '.') + ', ' +
                             'TOTALPRODUTOS = ' + TrocaTexto(mskValorTotalProdutos.Text, ',', '.') + ', ' +
                             'IPI = ' + TrocaTexto(mskValorTotalIPI.Text, ',', '.') + ', ' +
                             'SEGURO = ' + TrocaTexto(mskValorSeguro.Text, ',', '.') + ', ' +
                             'DESPESASACESSORIAS = ' + TrocaTexto(mskOutrasDespesas.Text, ',', '.') + ', ' +
                             'FRETE = ' + TrocaTexto(mskValorFrete.Text, ',', '.') + ', ' +
                             'TOTALNOTA = ' + TrocaTexto(mskValorTotalNota.Text, ',', '.') + ', ' +
                             'TRP_CODTRANSPORTADORA = ' + s_CodigoTransportadora + ', ' +
                             'TIPOFRETE = ' + IntToStr(cmbFretePorConta.ItemIndex + 1) + ', ' +
                             'PLACAVEICULO = ' + chr(39) + txtPlacaVeiculo.Text + chr(39) + ', ' +
                             'UFPLACA = ' + chr(39) + cmbUF.Items.Strings[cmbUF.ItemIndex] + chr(39) + ', ' +
                             'QUANTIDADE = ' + TrocaTexto(mskQuantidadeVolumes.Text, ',', '.') + ', ' +
                             'ESPECIE = ' + chr(39) + txtEspecie.Text + chr(39) + ', ' +
                             'MARCA = ' + chr(39) + txtMarca.Text + chr(39) + ', ' +
                             'NUMERO = ' + mskNumero.Text + ', ' +
                             'PESOBRUTO = ' + TrocaTexto(mskPesoBruto.Text, ',', '.') + ', ' +
                             'PESOLIQUIDO = ' + TrocaTexto(mskPesoLiquido.Text, ',', '.') +
                             ' WHERE CODIGONOTAFISCALENTRADA = ' + s_CodigoNotaFiscal +
                             ' AND NUMERONOTA = ' + mskCodNotaFiscal.Text;
                    log('Gravando Nota fiscal de entrada: '+s_SQL);
                    Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);
                end
                else
                begin
                    s_SQL := 'INSERT INTO NotaFiscalEntrada(NUMERONOTA, ' +
                                                           'CODIGONATUREZAOPERACAO, ' +
                                                           'CODIGOPEDIDOCOMPRA, ' +
                                                           'CODIGOCONDICAOPAGAMENTO, ' +
                                                           'SERIE, ' +
                                                           'VEN_CODVENDEDOR, ' +
                                                           'FRN_CODFORNECEDOR, ' +
                                                           'PEDIDOEXTERNO, ' +
                                                           'DATAEMISSAO, ' +
                                                           'DATAENTREGA, ' +
                                                           'HORASAIDA, ' +
                                                           'BASEICMS, ' +
                                                           'ICMS, ' +
                                                           'BASEICMSSUBSTITUICAO, ' +
                                                           'ICMSSUBSTITUICAO, ' +
                                                           'TOTALPRODUTOS, ' +
                                                           'IPI, ' +
                                                           'SEGURO, ' +
                                                           'DESPESASACESSORIAS, ' +
                                                           'FRETE, ' +
                                                           'TOTALNOTA, ' +
                                                           'TRP_CODTRANSPORTADORA, ' +
                                                           'TIPOFRETE, ' +
                                                           'PLACAVEICULO, ' +
                                                           'UFPLACA, ' +
                                                           'QUANTIDADE, ' +
                                                           'ESPECIE, ' +
                                                           'MARCA, ' +
                                                           'NUMERO, ' +
                                                           'PESOBRUTO, ' +
                                                           'PESOLIQUIDO, ' +
                                                           'CANCELADA, ' +
                                                           'ESTOQUE, ' +
                                                           'FATURADO, ' +
                                                           'IMPRESSO, ' +
                                                           'CFG_CODCONFIG) ' +
                                                   'VALUES(' +
                                                            mskCodNotaFiscal.Text + ', ' +
                                                            mskCFOP.Text + ', ' +
                                                            s_CodigoPedido + ', ' +
                                                            IntToStr(ad_CondicaoPagamento[cmbCondicaoPagamento.ItemIndex]) + ', ' +
                                                            chr(39) + mskSerie.Text + chr(39) + ', ' +
                                                            s_CodigoVendedor + ', ' +
                                                            s_CodigoFornecedor + ', ' +
                                                            chr(39) + mskPedido.Text + chr(39) + ', ' +
                                                            chr(39) + FormatDateTime('mm/dd/yyyy', datDataEmissao.Date) + chr(39) + ', ' +
                                                            chr(39) + FormatDateTime('mm/dd/yyyy', datDataEntradaSaida.Date) + chr(39) + ', ' +
                                                            chr(39) + FormatDateTime('mm/dd/yyyy', Date) + ' ' + FormatDateTime('hh:nn:ss', datHoraSaida.Time) + chr(39) + ', ' +
                                                            TrocaTexto(mskBaseCalculoICMS.Text, ',', '.') + ', ' +
                                                            TrocaTexto(mskValorICMS.Text, ',', '.') + ', ' +
                                                            TrocaTexto(mskBaseCalculoICMSSub.Text, ',', '.') + ', ' +
                                                            TrocaTexto(mskValorICMSSub.Text, ',', '.') + ', ' +
                                                            TrocaTexto(mskValorTotalProdutos.Text, ',', '.') + ', ' +
                                                            TrocaTexto(mskValorTotalIPI.Text, ',', '.') + ', ' +
                                                            TrocaTexto(mskValorSeguro.Text, ',', '.') + ', ' +
                                                            TrocaTexto(mskOutrasDespesas.Text, ',', '.') + ', ' +
                                                            TrocaTexto(mskValorFrete.Text, ',', '.') + ', ' +
                                                            TrocaTexto(mskValorTotalNota.Text, ',', '.') + ', ' +
                                                            s_CodigoTransportadora + ', ' +
                                                            IntToStr(cmbFretePorConta.ItemIndex + 1) + ', ' +
                                                            chr(39) + txtPlacaVeiculo.Text + chr(39) + ', ' +
                                                            chr(39) + cmbUF.Items.Strings[cmbUF.ItemIndex] + chr(39) + ', ' +
                                                            TrocaTexto(mskQuantidadeVolumes.Text, ',', '.') + ', ' +
                                                            chr(39) + txtEspecie.Text + chr(39) + ', ' +
                                                            chr(39) + txtMarca.Text + chr(39) + ', ' +
                                                            mskNumero.Text + ', ' +
                                                            TrocaTexto(mskPesoBruto.Text, ',', '.') + ', ' +
                                                            TrocaTexto(mskPesoLiquido.Text, ',', '.') + ', ' +
                                                            chr(39) + 'F' + chr(39) + ', ' +
                                                            chr(39) + 'F' + chr(39) + ', ' +
                                                            chr(39) + 'F' + chr(39) + ', ' +
                                                            chr(39) + 'F' + chr(39) + ', ' +
                                                            '1)';
                    log('Gravando Nota fiscal de entrada: '+s_SQL);
                    Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);

                    // Executa select para descobrir a chave que o generator criou na inclusao, pois este codigo e uma FK do proximo insert
                    Executa_SQL(frmTabelas.tbl_NotaFiscal, 'SELECT CODIGONOTAFISCALENTRADA FROM NotaFiscalEntrada WHERE NUMERONOTA = ' + mskCodNotaFiscal.Text);

                    s_CodigoNotaFiscal := frmTabelas.tbl_NotaFiscal.FieldByName('CODIGONOTAFISCALENTRADA').AsString;

                    if Length(AllTrim(mskOrcamento.Text)) > 0 then
                    begin
                        frmTabelas.tbl_ProdutoPedidoCompra.First;
                        while not (frmTabelas.tbl_ProdutoPedidoCompra.Eof) do
                        begin
                            s_SQL := 'INSERT INTO ProdutoNotaEntrada(' +
                                                                     'CODIGOPRODUTO, ' +
                                                                     'QUANTIDADE, ' +
                                                                     'PRECO, ' +
                                                                     'ALIQUOTAICMS, ' +
                                                                     'ALIQUOTAIPI, ' +
                                                                     'CODIGOSITUACAOTRIBUTARIA, ' +
                                                                     'CODIGONOTAFISCALENTRADA) ' +
                                                              'VALUES(' +
                                                                      frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('CODIGOPRODUTO').AsString + ', ' +
                                                                      TrocaTexto(FloatToStr(frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('QUANTIDADE').AsFloat), ',', '.') + ', ' +
                                                                      TrocaTexto(FloatToStr(frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('PRECO').AsFloat), ',', '.') + ', ' +
                                                                      TrocaTexto(FloatToStr(frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('ALIQUOTAICMS').AsFloat), ',', '.') + ', ' +
                                                                      TrocaTexto(FloatToStr(frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('ALIQUOTAIPI').AsFloat), ',', '.') + ', ' +
                                                                      frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('CODIGOSITUACAOTRIBUTARIA').AsString + ', ' +
                                                                      s_CodigoNotaFiscal + ')';
                            log('Gravando Produtos da Nota fiscal de entrada: '+s_SQL);
                            Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);


                            // Atualiza o preco de custo do produto no cadastro de produto
                            s_SQL := 'UPDATE ESTOQUE SET PRECOREPOSICAO = ' + TrocaTexto(FloatToStr(frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('PRECO').AsFloat), ',', '.') +
                                     ' where CODIGOPRODUTO = ' + frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('CODIGOPRODUTO').AsString;
                            log('Atualizando Preco de custo: '+s_SQL);
                            Executa_SQL(frmTabelas.tbl_Estoque, s_SQL, false);

                            frmTabelas.tbl_ProdutoPedidoCompra.Next;
                        end;
                    end
                    else
                    begin
                        for i := 1 to grdStringGrid.RowCount - 2 do
                        begin
                            s_SQL := 'INSERT INTO ProdutoNotaEntrada(' +
                                                                     'CODIGOPRODUTO, ' +
                                                                     'QUANTIDADE, ' +
                                                                     'PRECO, ' +
                                                                     'ALIQUOTAICMS, ' +
                                                                     'ALIQUOTAIPI, ' +
                                                                     'CODIGOSITUACAOTRIBUTARIA, ' +
                                                                     'CODIGONOTAFISCALENTRADA) ' +
                                                              'VALUES(' +
                                                                      grdStringGrid.Cells[1, i] + ', ' +
                                                                      TrocaTexto(grdStringGrid.Cells[3, i], ',', '.') + ', ' +
                                                                      TrocaTexto(grdStringGrid.Cells[4, i], ',', '.') + ', ' +
                                                                      TrocaTexto(grdStringGrid.Cells[5, i], ',', '.') + ', ' +
                                                                      TrocaTexto(grdStringGrid.Cells[6, i], ',', '.') + ', ' +
                                                                      grdStringGrid.Cells[9, i] + ', ' +
                                                                      s_CodigoNotaFiscal + ')';
                            log('Gravando Produtos da Nota fiscal de entrada: '+s_SQL);
                            Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);

                            // Atualiza o preco de custo do produto no cadastro de produto
                            s_SQL := 'UPDATE ESTOQUE SET PRECOREPOSICAO = ' + TrocaTexto(grdStringGrid.Cells[4, i], ',', '.') +
                                     ' where CODIGOPRODUTO = ' + grdStringGrid.Cells[1, i];
                            log('Atualizando Preco de custo: '+s_SQL);
                            Executa_SQL(frmTabelas.tbl_Estoque, s_SQL, false);


                        end;
                    end;
                end;
            end
            else
            begin // Nota Fiscal saida

               Log('Grava??o da emiss?o da Nota Fiscal de Saida n? '+ mskCodNotaFiscal.Text);

                Executa_SQL(frmTabelas.rede, 'SELECT * FROM NotaFiscalSaida WHERE NUMERONOTA = ' + mskCodNotaFiscal.Text);

                if frmTabelas.rede.FieldByName('NUMERONOTA').Value <> NULL then
                begin
                    s_SQL := 'UPDATE NOTAFISCALSAIDA SET ' +
                             'CODIGONATUREZAOPERACAO = ' + mskCFOP.Text + ', ' +
                             'CODIGOPEDIDOVENDA = ' + s_CodigoPedido + ', ' +
                             'SERIE = ' + chr(39) + mskSerie.Text + chr(39) + ', ' +
                             'VEN_CODVENDEDOR = ' + s_CodigoVendedor + ', ' +
                             'CLI_CODCLIENTE = ' + s_CodigoCliente + ', ' +
                             'PEDIDOEXTERNO = ' + chr(39) + mskPedido.Text + chr(39) + ', ' +
                             'DATAEMISSAO = ' + chr(39) + FormatDateTime('mm/dd/yyyy', datDataEmissao.Date) + chr(39) + ', ' +
                             'DATAENTREGA = ' + chr(39) + FormatDateTime('mm/dd/yyyy', datDataEntradaSaida.Date) + chr(39) + ', ' +
                             'HORASAIDA = ' + chr(39) + FormatDateTime('mm/dd/yyyy', Date) + ' ' + FormatDateTime('hh:nn:ss', datHoraSaida.Time) + chr(39) + ', ' +
                             'BASEICMS = ' + TrocaTexto(mskBaseCalculoICMS.Text, ',', '.') + ', ' +
                             'ICMS = ' + TrocaTexto(mskValorICMS.Text, ',', '.') + ', ' +
                             'BASEICMSSUBSTITUICAO = ' + TrocaTexto(mskBaseCalculoICMSSub.Text, ',', '.') + ', ' +
                             'ICMSSUBSTITUICAO = ' + TrocaTexto(mskValorICMSSub.Text, ',', '.') + ', ' +
                             'TOTALPRODUTOS = ' + TrocaTexto(mskValorTotalProdutos.Text, ',', '.') + ', ' +
                             'IPI = ' + TrocaTexto(mskValorTotalIPI.Text, ',', '.') + ', ' +
                             'SEGURO = ' + TrocaTexto(mskValorSeguro.Text, ',', '.') + ', ' +
                             'DESPESASACESSORIAS = ' + TrocaTexto(mskOutrasDespesas.Text, ',', '.') + ', ' +
                             'FRETE = ' + TrocaTexto(mskValorFrete.Text, ',', '.') + ', ' +
                             'TOTALNOTA = ' + TrocaTexto(mskValorTotalNota.Text, ',', '.') + ', ' +
                             'TRP_CODTRANSPORTADORA = ' + s_CodigoTransportadora + ', ' +
                             'TIPOFRETE = ' + IntToStr(cmbFretePorConta.ItemIndex + 1) + ', ' +
                             'PLACAVEICULO = ' + chr(39) + txtPlacaVeiculo.Text + chr(39) + ', ' +
                             'UFPLACA = ' + chr(39) + cmbUF.Items.Strings[cmbUF.ItemIndex] + chr(39) + ', ' +
                             'QUANTIDADE = ' + TrocaTexto(mskQuantidadeVolumes.Text, ',', '.') + ', ' +
                             'ESPECIE = ' + chr(39) + txtEspecie.Text + chr(39) + ', ' +
                             'MARCA = ' + chr(39) + txtMarca.Text + chr(39) + ', ' +
                             'NUMERO = ' + mskNumero.Text + ', ' +
                             'PESOBRUTO = ' + TrocaTexto(mskPesoBruto.Text, ',', '.') + ', ' +
                             'PESOLIQUIDO = ' + TrocaTexto(mskPesoLiquido.Text, ',', '.') +
                             ' WHERE CODIGONOTAFISCALSAIDA = ' + s_CodigoNotaFiscal +
                             ' AND NUMERONOTA = ' + mskCodNotaFiscal.Text;

                    Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);
                end
                else
                begin
                    s_SQL := 'INSERT INTO NotaFiscalSaida(NUMERONOTA, ' +
                                                         'CODIGONATUREZAOPERACAO, ' +
                                                         'CODIGOPEDIDOVENDA, ' +
                                                         'CODIGOCONDICAOPAGAMENTO, ' +
                                                         'SERIE, ' +
                                                         'VEN_CODVENDEDOR, ' +
                                                         'CLI_CODCLIENTE, ' +
                                                         'PEDIDOEXTERNO, ' +
                                                         'DATAEMISSAO, ' +
                                                         'DATAENTREGA, ' +
                                                         'HORASAIDA, ' +
                                                         'BASEICMS, ' +
                                                         'ICMS, ' +
                                                         'BASEICMSSUBSTITUICAO, ' +
                                                         'ICMSSUBSTITUICAO, ' +
                                                         'TOTALPRODUTOS, ' +
                                                         'IPI, ' +
                                                         'SEGURO, ' +
                                                         'DESPESASACESSORIAS, ' +
                                                         'FRETE, ' +
                                                         'TOTALNOTA, ' +
                                                         'TRP_CODTRANSPORTADORA, ' +
                                                         'TIPOFRETE, ' +
                                                         'PLACAVEICULO, ' +
                                                         'UFPLACA, ' +
                                                         'QUANTIDADE, ' +
                                                         'ESPECIE, ' +
                                                         'MARCA, ' +
                                                         'NUMERO, ' +
                                                         'PESOBRUTO, ' +
                                                         'PESOLIQUIDO, ' +
                                                         'CANCELADA, ' +
                                                         'ESTOQUE, ' +
                                                         'FATURADO, ' +
                                                         'IMPRESSO, ' +
                                                         'CFG_CODCONFIG) ' +
                                                 'VALUES(' +
                                                          mskCodNotaFiscal.Text + ', ' +
                                                          mskCFOP.Text + ', ' +
                                                          s_CodigoPedido + ', ' +
                                                          IntToStr(ad_CondicaoPagamento[cmbCondicaoPagamento.ItemIndex]) + ', ' +
                                                          chr(39) + mskSerie.Text + chr(39) + ', ' +
                                                          s_CodigoVendedor + ', ' +
                                                          s_CodigoCliente + ', ' +
                                                          chr(39) + mskPedido.Text + chr(39) + ', ' +
                                                          chr(39) + FormatDateTime('mm/dd/yyyy', datDataEmissao.Date) + chr(39) + ', ' +
                                                          chr(39) + FormatDateTime('mm/dd/yyyy', datDataEntradaSaida.Date) + chr(39) + ', ' +
                                                          chr(39) + FormatDateTime('mm/dd/yyyy', Date) + ' ' + FormatDateTime('hh:nn:ss', datHoraSaida.Time) + chr(39) + ', ' +
                                                          TrocaTexto(mskBaseCalculoICMS.Text, ',', '.') + ', ' +
                                                          TrocaTexto(mskValorICMS.Text, ',', '.') + ', ' +
                                                          TrocaTexto(mskBaseCalculoICMSSub.Text, ',', '.') + ', ' +
                                                          TrocaTexto(mskValorICMSSub.Text, ',', '.') + ', ' +
                                                          TrocaTexto(mskValorTotalProdutos.Text, ',', '.') + ', ' +
                                                          TrocaTexto(mskValorTotalIPI.Text, ',', '.') + ', ' +
                                                          TrocaTexto(mskValorSeguro.Text, ',', '.') + ', ' +
                                                          TrocaTexto(mskOutrasDespesas.Text, ',', '.') + ', ' +
                                                          TrocaTexto(mskValorFrete.Text, ',', '.') + ', ' +
                                                          TrocaTexto(mskValorTotalNota.Text, ',', '.') + ', ' +
                                                          s_CodigoTransportadora + ', ' +
                                                          IntToStr(cmbFretePorConta.ItemIndex + 1) + ', ' +
                                                          chr(39) + txtPlacaVeiculo.Text + chr(39) + ', ' +
                                                          chr(39) + cmbUF.Items.Strings[cmbUF.ItemIndex] + chr(39) + ', ' +
                                                          TrocaTexto(mskQuantidadeVolumes.Text, ',', '.') + ', ' +
                                                          chr(39) + txtEspecie.Text + chr(39) + ', ' +
                                                          chr(39) + txtMarca.Text + chr(39) + ', ' +
                                                          mskNumero.Text + ', ' +
                                                          TrocaTexto(mskPesoBruto.Text, ',', '.') + ', ' +
                                                          TrocaTexto(mskPesoLiquido.Text, ',', '.') + ', ' +
                                                          chr(39) + 'F' + chr(39) + ', ' +
                                                          chr(39) + 'F' + chr(39) + ', ' +
                                                          chr(39) + 'F' + chr(39) + ', ' +
                                                          chr(39) + 'F' + chr(39) + ', ' +
                                                          '1)';

                    Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);

                    // Executa select para descobrir a chave que o generator criou na inclusao, pois este codigo e uma FK do proximo insert
                    Executa_SQL(frmTabelas.tbl_NotaFiscal, 'SELECT CODIGONOTAFISCALSAIDA FROM NotaFiscalSaida WHERE NUMERONOTA = ' + mskCodNotaFiscal.Text);

                    s_CodigoNotaFiscal := frmTabelas.tbl_NotaFiscal.FieldByName('CODIGONOTAFISCALSAIDA').AsString;

                    if Length(AllTrim(mskOrcamento.Text)) > 0 then
                    begin
                        frmTabelas.tbl_ProdutoPedidoVenda.First;
                        while not (frmTabelas.tbl_ProdutoPedidoVenda.Eof) do
                        begin
                            s_SQL := 'INSERT INTO ProdutoNotaSaida(' +
                                                                  'CODIGOPRODUTO, ' +
                                                                  'QUANTIDADE, ' +
                                                                  'PRECO, ' +
                                                                  'ALIQUOTAICMS, ' +
                                                                  'ALIQUOTAIPI, ' +
                                                                  'CODIGOSITUACAOTRIBUTARIA, ' +
                                                                  'CODIGONOTAFISCALSAIDA) ' +
                                                           'VALUES(' +
                                                                   frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('CODIGOPRODUTO').AsString + ', ' +
                                                                   TrocaTexto(FloatToStr(frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('QUANTIDADE').AsFloat), ',', '.') + ', ' +
                                                                   TrocaTexto(FloatToStr(frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('PRECO').AsFloat), ',', '.') + ', ' +
                                                                   TrocaTexto(FloatToStr(frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('ALIQUOTAICMS').AsFloat), ',', '.') + ', ' +
                                                                   TrocaTexto(FloatToStr(frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('ALIQUOTAIPI').AsFloat), ',', '.') + ', ' +
                                                                   frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('CODIGOSITUACAOTRIBUTARIA').AsString + ', ' +
                                                                   s_CodigoNotaFiscal + ')';
                            Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);

//                            s_SQL := 'UPDATE PRODUTOPEDIDOVENDA SET ENTREGUE = QUANTIDADE WHERE CODIGOPRODUTO = ' + frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('CODIGOPRODUTO').AsString;
//                            Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);

                            frmTabelas.tbl_ProdutoPedidoVenda.Next;
                        end;
                    end
                    else
                    begin
                        for i := 1 to grdStringGrid.RowCount - 2 do
                        begin
                            s_SQL := 'INSERT INTO ProdutoNotaSaida(' +
                                                                  'CODIGOPRODUTO, ' +
                                                                  'QUANTIDADE, ' +
                                                                  'PRECO, ' +
                                                                  'ALIQUOTAICMS, ' +
                                                                  'ALIQUOTAIPI, ' +
                                                                  'CODIGOSITUACAOTRIBUTARIA, ' +
                                                                  'CODIGONOTAFISCALSAIDA) ' +
                                                           'VALUES(' +
                                                                      grdStringGrid.Cells[1, i] + ', ' +
                                                                      TrocaTexto(grdStringGrid.Cells[3, i], ',', '.') + ', ' +
                                                                      TrocaTexto(grdStringGrid.Cells[4, i], ',', '.') + ', ' +
                                                                      TrocaTexto(grdStringGrid.Cells[5, i], ',', '.') + ', ' +
                                                                      TrocaTexto(grdStringGrid.Cells[6, i], ',', '.') + ', ' +
                                                                      grdStringGrid.Cells[9, i] + ', ' +
                                                                      s_CodigoNotaFiscal + ')';
                            Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);
                        end;
                    end;
                end;
            end;

            Executa_SQL(frmTabelas.tbl_NotaFiscal, 'Commit', false);

            // realiza o faturamento da nota fiscal
            FaturaNota(s_CodigoNotaFiscal);

            Troca_Maskara(false);

            // pergunta de deseja imprimir a nota fiscal
            cmdImprimir.Click;


            mskCodNotaFiscal.Text := FormataNumero(NumeroNota(), 8);

            cmdFechar.Click;
        end;
    end
    else
    begin
        Botao_Gravar;

        Habilita_Campos;

        mskcfop.SelectAll;
        mskCFOP.SetFocus;
    end;
end;

procedure TfrmNota.FaturaNota(numero_nota:string);
var s_SQL: String;
    i:integer;
begin
        if optEntrada.Checked then
        begin// nota fiscal de entrada
           Log('Faturamento da Nota Fiscal de Entrada n? ' + mskCodNotaFiscal.Text);
           Log('CodigoNotaFiscalEntrada da NF :' + numero_nota);

           if length(Trim(mskOrcamento.text))>0 then
              begin
                 frmTabelas.tbl_ProdutoPedidoCompra.First;
                 while not frmTabelas.tbl_ProdutoPedidoCompra.Eof do
                    begin
                       if not AtualizaEstoque(frmTabelas.tbl_NotaFiscal, '+', frmTabelas.tbl_ProdutoPedidoCompraCODIGOPRODUTO.AsString, frmTabelas.tbl_ProdutoPedidoCompraQUANTIDADE.AsString) then
                          begin
                             Application.MessageBox('Ocorreu um erro durante o processo de atualiza??o de estoque.', 'Autocom PLUS', 16);
                             cmdFechar.Click;
                             exit;
                          end;
                       frmTabelas.tbl_ProdutoPedidoCompra.Next;
                    end;
              end
           else
              begin
                 for i := 1 to grdStringGrid.RowCount - 2 do
                    begin
                       if not AtualizaEstoque(frmTabelas.tbl_NotaFiscal, '+', grdStringGrid.Cells[1, i], TrocaTexto(grdStringGrid.Cells[3, i], ',', '.')) then
                          begin
                             Application.MessageBox('Ocorreu um erro durante o processo de atualiza??o de estoque.', 'Autocom PLUS', 16);
                             cmdFechar.Click;
                             exit;
                          end;
                    end
              end;
//utilizar esta procedure quando o modulo financeiro estiver pronto!
//pois serao necessariso as contas de cliente cadastradas!!!
//APGAR A ROTINA DE UPDATE ABAIXO QUANDO FOR UTILIZAR ESTA!!!!!
//Por Helder Frederico
//            s_SQL := 'EXECUTE PROCEDURE SPCRIACONTANOTAFISCALENTRADA(' + numero_nota + ')';
//            Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);

            s_SQL := 'UPDATE NotaFiscalEntrada SET FATURADO = ' + chr(39) + 'T' + chr(39) +
                     ' WHERE CODIGONOTAFISCALENTRADA = ' + s_CodigoNotaFiscal +
                     ' AND NUMERONOTA = ' + mskCodNotaFiscal.Text;
            log('Marcando FLAG de nota fiscal de entrada faturada: '+s_sql);
            Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);
        end;

        if optSaida.Checked then
        begin// nota fiscal de saida
           Log('Faturamento da Nota Fiscal de Saida n? ' + mskCodNotaFiscal.Text);
           Log('CodigoNotaFiscalSaida da NF :' + numero_nota);

           if length(Trim(mskOrcamento.text))>0 then
              begin
                 frmTabelas.tbl_ProdutoPedidoVenda.First;
                 while not frmTabelas.tbl_ProdutoPedidoVenda.Eof do
                    begin
                       if not AtualizaEstoque(frmTabelas.tbl_NotaFiscal, '-', frmTabelas.tbl_ProdutoPedidoVendaCODIGOPRODUTO.AsString, frmTabelas.tbl_ProdutoPedidoVendaQUANTIDADE.AsString) then
                          begin
                             Application.MessageBox('Ocorreu um erro durante o processo de atualiza??o de estoque.', 'Autocom PLUS', 16);
                             cmdFechar.Click;
                             exit;
                          end;
                       frmTabelas.tbl_ProdutoPedidoVenda.Next;
                    end;
              end
           else
              begin
                 for i := 1 to grdStringGrid.RowCount - 2 do
                    begin
                       if not AtualizaEstoque(frmTabelas.tbl_NotaFiscal, '-', grdStringGrid.Cells[1, i], TrocaTexto(grdStringGrid.Cells[3, i], ',', '.')) then
                          begin
                             Application.MessageBox('Ocorreu um erro durante o processo de atualiza??o de estoque.', 'Autocom PLUS', 16);
                             cmdFechar.Click;
                             exit;
                          end;
                    end
              end;


//utilizar esta procedure quando o modulo financeiro estiver pronto!
//pois serao necessariso as contas de cliente cadastradas!!!
//APGAR A ROTINA DE UPDATE ABAIXO QUANDO FOR UTILIZAR ESTA!!!!!
//Por Helder Frederico
//            s_SQL := 'EXECUTE PROCEDURE SPCRIACONTANOTAFISCALSAIDA(' + numero_nota + ')';
//            Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);

            s_SQL := 'UPDATE NotaFiscalSaida SET FATURADO = ' + chr(39) + 'T' + chr(39) +
                     ' WHERE CODIGONOTAFISCALSAIDA = ' + numero_nota +
                     ' AND NUMERONOTA = ' + mskCodNotaFiscal.Text;
            log('Marcando FLAG de nota fiscal de saida faturada: '+s_sql);
            Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);

            // flega o pedido como faturado
            try
               if strtofloat(mskOrcamento.Text)>0 then
                  begin
                     s_SQL := 'UPDATE PedidoVenda SET Situacao = ' + chr(39) + 'F' + chr(39) +
                              ' WHERE NUMEROPEDIDO = ' + mskOrcamento.Text;
                     log('Marcando FLAG de pedido de venda faturado: '+s_sql);
                     Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);
                  end;
            except
               // nao faz nada
            end;

        end;

        Executa_SQL(frmTabelas.tbl_NotaFiscal, 'Commit');
end;

procedure TfrmNota.cmdImprimirClick(Sender: TObject);
var s_SQL: String;
begin
    if Application.MessageBox('Deseja imprimir a Nota Fiscal?', 'Autocom Plus', 36) = mrYes then
    begin
        Imprime_NF;
        Log('Impress?o da Nota Fiscal n? ' + mskCodNotaFiscal.Text);

        if optEntrada.Checked then
            s_SQL := 'UPDATE NotaFiscalEntrada SET IMPRESSO = ' + chr(39) + 'T' + chr(39) +
                     ' WHERE CODIGONOTAFISCALENTRADA = ' + s_CodigoNotaFiscal +
                     ' AND NUMERONOTA = ' + mskCodNotaFiscal.Text
        else
            s_SQL := 'UPDATE NotaFiscalSaida SET IMPRESSO = ' + chr(39) + 'T' + chr(39) +
                     ' WHERE CODIGONOTAFISCALSAIDA = ' + s_CodigoNotaFiscal +
                     ' AND NUMERONOTA = ' + mskCodNotaFiscal.Text;

        Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);
        Executa_SQL(frmTabelas.tbl_NotaFiscal, 'Commit');

        mskCodNotaFiscal.Text := FormataNumero(NumeroNota(), 8);

        cmdFechar.Click;
    end;
end;

procedure TfrmNota.cmdCancelarNotaFiscalClick(Sender: TObject);
var s_SQL: String;
begin
    if Application.MessageBox('Deseja cancelar a Nota Fiscal?', 'Autocom Plus', 36) = mrYes then
    begin
        Log('Cancelamento da Nota Fiscal n? ' + mskCodNotaFiscal.Text);

        if optEntrada.Checked then
            s_SQL := 'UPDATE NotaFiscalEntrada SET CANCELADA = ' + chr(39) + 'T' + chr(39) +
                     ' WHERE NUMERONOTA = ' + mskCodNotaFiscal.Text
        else
            s_SQL := 'UPDATE NotaFiscalSaida SET CANCELADA = ' + chr(39) + 'T' + chr(39) +
                     ' WHERE NUMERONOTA = ' + mskCodNotaFiscal.Text;

        Log('Cancelamento da Nota Fiscal n? ' + s_Sql);
        Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);


        if optEntrada.Checked then
           begin
              frmTabelas.tbl_ProdutoPedidoCompra.First;
              while not frmTabelas.tbl_ProdutoPedidoCompra.Eof do
                 begin
                    if not AtualizaEstoque(frmTabelas.tbl_NotaFiscal, '-', frmTabelas.tbl_ProdutoPedidoCompraCODIGOPRODUTO.AsString, frmTabelas.tbl_ProdutoPedidoCompraQUANTIDADE.AsString) then
                       begin
                          Application.MessageBox('Ocorreu um erro durante o processo de atualiza??o de estoque.', 'Autocom PLUS', 16);
                          cmdFechar.Click;
                          exit;
                       end;
                    frmTabelas.tbl_ProdutoPedidoCompra.Next;
                 end;
           end;

        if optSaida.Checked then
           begin
              frmTabelas.tbl_ProdutoPedidoVenda.First;
              while not frmTabelas.tbl_ProdutoPedidoVenda.Eof do
                 begin
                    if not AtualizaEstoque(frmTabelas.tbl_NotaFiscal, '+', frmTabelas.tbl_ProdutoPedidoVendaCODIGOPRODUTO.AsString, frmTabelas.tbl_ProdutoPedidoVendaQUANTIDADE.AsString) then
                       begin
                          Application.MessageBox('Ocorreu um erro durante o processo de atualiza??o de estoque.', 'Autocom PLUS', 16);
                          cmdFechar.Click;
                          exit;
                       end;
                    frmTabelas.tbl_ProdutoPedidoCompra.Next;
                 end;
           end;


        // desflega o pedido como faturado
        try
           if strtofloat(mskOrcamento.Text)>0 then
              begin
                 s_SQL := 'UPDATE PedidoVenda SET Situacao = ' + chr(39) + 'X' + chr(39) +
                              ' WHERE NUMEROPEDIDO = ' + mskOrcamento.Text;
                 log('DesMarcando FLAG de pedido de venda faturado: '+s_sql);
                 Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL, false);
              end;
        except
               // nao faz nada
        end;

        Executa_SQL(frmTabelas.tbl_NotaFiscal, 'Commit');

        mskCodNotaFiscal.Text := FormataNumero(NumeroNota(), 8);

        cmdFechar.Click;
    end;
end;

procedure TfrmNota.cmdFecharClick(Sender: TObject);
begin
    if cmdFechar.Caption = '&Cancelar' then
    begin
        Limpa_Campos;
        Botao_Gravar;
        Botao_Fechar;
        mskCodNotaFiscal.SelectAll;
        mskCodNotaFiscal.SetFocus;
    end
    else
    begin
        if cmdFechar.Caption = '&Fechar' then
            Close;
    end;
end;

{*******************************************************************************
                                Funcoes
******************************************************************************}

{ Funcao que retira espacos em branco a esquerda e a direita }
function TfrmNota.AllTrim(s_String: String): String;
begin
    while Pos(' ', s_String) > 0 do
        Delete(s_String, Pos(' ', s_String), 1);

    while Pos('', s_String) > 0 do
        Delete(s_String, Pos('', s_String), 1);

    Result := s_String;
end;

function TfrmNota.AtualizaEstoque(obj_TIBQuery: TIBQuery; s_Tipo, s_Produto, s_Quantidade, s_Lote: String): Boolean;
var s_SQL: String;
    lote:boolean;
begin
// Funcao que atualiza a quantidade do produto em estoque }
//
//  s_Tipo: Tipo de opera??o  +   -> Adiciona no estoque
//                            -   -> Subtrai do estoque
//  s_Produto: codigo do produto
//  s_Quantidade: quantidade do produto
    if legenth(s_lote)>0 then lote:=true else Lote:=false;

    if trim(frmTabelas.tbl_NaturezaOperacao.fieldbyname('MOVIMENTAESTOQUE').Asstring)='T' then
       begin
          if s_Tipo = '+' then
            s_SQL := 'UPDATE ESTOQUE SET ESTOQUEATUAL = (ESTOQUEATUAL + ' + s_Quantidade + ') WHERE CODIGOPRODUTO = ' + s_Produto + ifthen(lote,' and Lote='+trim(msklote.text));

          if s_Tipo = '-' then
            s_SQL := 'UPDATE ESTOQUE SET ESTOQUEATUAL = (ESTOQUEATUAL - ' + s_Quantidade + ') WHERE CODIGOPRODUTO = ' + s_Produto + ifthen(lote,' and Lote='+trim(msklote.text));

          try
             Log('Atualizando Estoque '+s_tipo+' :' + s_sql);
             Executa_SQL(obj_TIBQuery, s_SQL);
             Result := true;
          except
             on e:exception do
                begin
                   Log('Erro ao atualizar o estoque '+s_tipo+' :' + s_sql);
                   Log(e.message);
                   Result := false;
                end;
          end;
       end
    else
       begin
          Log('Estoque nao requer atualizacao, de acordo com a CFOP'+mskCFOP.text);
       end;


end;

{ Funcao que retira uma string de outra string }
function TfrmNota.Filtrar(s_String, s_Filtro: String): String;
begin
    while Pos(s_Filtro, s_String) > 0 do
        Delete(s_String, Pos(s_Filtro, s_String), Length(s_Filtro));

    Result := s_String;
end;

function TfrmNota.FormataNumero(s_String: String; i_CasasInteiras: Integer = 0; i_CasasDecimais: Integer = 0; preenchimento:string = '0'): String;
var s_BeforeComma: String;
    s_AfterComma: String;
begin
    s_String := AllTrim(s_String);

    if Pos(',', s_String) > 0 then
    begin
        s_BeforeComma := LeftStr(s_String, Pos(',', s_String) - 1);
        s_AfterComma := RightStr(s_String, Length(s_String) - Pos(',', s_String));
    end
    else
    begin
        s_BeforeComma := s_String;
        s_AfterComma := '';
    end;

    while (Length(s_BeforeComma)) < i_CasasInteiras do
        s_BeforeComma := preenchimento + s_BeforeComma;

    while (Length(s_AfterComma)) < i_CasasDecimais do
        s_AfterComma := s_AfterComma + preenchimento;

    if i_CasasDecimais > 0 then
        s_String := s_BeforeComma + ',' + s_AfterComma
    else
        s_String := s_BeforeComma;

    Result := s_String;
end;

function TfrmNota.NumeroNota: String;
begin
    if optEntrada.Checked then
        Executa_SQL(frmTabelas.tbl_NotaFiscal, 'SELECT MAX(NUMERONOTA) FROM NotaFiscalEntrada')
    else
        Executa_SQL(frmTabelas.tbl_NotaFiscal, 'SELECT MAX(NUMERONOTA) FROM NotaFiscalSaida');

    if frmTabelas.tbl_NotaFiscal.Fields[0].Value = null then
        Result := FormataNumero(s_CodigoInicial, 8)
    else
        Result := FormataNumero(FloatToStr(frmTabelas.tbl_NotaFiscal.Fields[0].AsFloat + 1), 8);
end;

function TfrmNota.TrocaTexto(s_String, s_Find, s_Replace: String): String;
var i_Count: Integer;
    s_AuxFind: String;
begin
    i_Count := 0;
    while i_Count < Length(s_String) do
    begin
        s_AuxFind := MidStr(s_String, i_Count, Length(s_Find));
        if s_Find = s_AuxFind then
        begin
            s_String := LeftStr(s_String, Pos(s_Find, s_String) - 1) + s_Replace + RightStr(s_String, Length(s_String) - (Pos(s_Find, s_String)));
            i_Count := i_Count + Length(s_Replace);
        end
        else
            i_Count := i_Count + Length(s_Find);
    end;

    Result := s_String;
end;

function TfrmNota.Validacao(): Boolean;
var s_MensagemErro: String;
begin
    Result := true;

    if (AllTrim(mskCFOP.Text) = '') or (Label3.Caption = 'C?digo Inv?lido') then
    begin
        Application.MessageBox('O c?digo fiscal de opera??es est? inv?lido. Verifique!', 'Autocom PLUS', 16);
        mskCFOP.SelectAll;
        mskCFOP.SetFocus;
        Result := false;
        exit;
    end;

    if cmbCondicaoPagamento.ItemIndex = -1 then
    begin
        Application.MessageBox('A condi??o de pagamento est? inv?lida. Verifique!', 'Autocom PLUS', 16);
        cmbCondicaoPagamento.SetFocus;
        Result := false;
        exit;
    end;

    if AllTrim(mskSerie.Text) = '' then
    begin
        Application.MessageBox('A s?rie est? inv?lida. Verifique!', 'Autcom PLUS', 16);
        mskSerie.SelectAll;
        mskSerie.SetFocus;
        Result := false;
        exit;
    end;

    if AllTrim(mskDestinatarioRemetente.Text) = '' then
    begin
        s_MensagemErro := 'O c?digo do ' + Trim(Copy(Label7.Caption, 1, Length(Trim(Label7.Caption)) - 1)) + ' est? inv?lido. Verifique!';
        Application.MessageBox(PChar(s_MensagemErro), 'Autcom PLUS', 16);
        mskDestinatarioRemetente.SelectAll;
        mskDestinatarioRemetente.SetFocus;
        Result := false;
        exit;
    end;

    if datDataEmissao.Date < Date then
    begin
        if Application.MessageBox('A data de emiss?o ? anterior ? data de hoje. Deseja mant?-la?', 'Autocom PLUS', 36) = mrNo then
        begin
            datDataEmissao.SetFocus;
            Result := false;
            exit;
        end;
    end;

    if datDataEntradaSaida.Date < Date then
    begin
        if optEntrada.Checked then
            s_MensagemErro := 'A data da entrada ? anterior ? data de hoje. Deseja mant?-la?'
        else
            s_MensagemErro := 'A data da sa?da ? anterior ? data de hoje. Deseja mant?-la?';

        if Application.MessageBox(PChar(s_MensagemErro), 'Autocom PLUS', 36) = mrNo then
        begin
            datDataEntradaSaida.SetFocus;
            Result := false;
            exit;
        end;
    end;

    if Length(AllTrim(mskOrcamento.Text)) > 0 then
    begin
        if ( (optEntrada.Checked) and (frmTabelas.tbl_ProdutoPedidoCompra.RecordCount > StrToInt(s_LimiteItem)) ) or
           ( (optSaida.Checked)   and (frmTabelas.tbl_ProdutoPedidoVenda.RecordCount > StrToInt(s_LimiteItem)) ) then
        begin
            s_MensagemErro := 'A quantidade de itens selecionados ? superior ao Limite de ' + s_LimiteItem + ' Itens por Nota Fiscal. Verifique!';
            Application.MessageBox(PChar(s_MensagemErro), 'Autocom PLUS', 16);
            dgrdDBGrid.SetFocus;
            Result := false;
            exit;
        end;
    end;

    if (AllTrim(mskCodigoTransportador.Text) = '') or (txtNomeTransportador.Text = 'C?digo Inv?lido') then
    begin
        Application.MessageBox('O c?digo da transportadora est? inv?lido. Verifique!', 'Autocom PLUS', 16);
        tstrPageControl.ActivePage := tabTransportador;
        mskCodigoTransportador.SelectAll;
        mskCodigoTransportador.SetFocus;
        Result := false;
        exit;
    end;

    if cmbFretePorConta.ItemIndex = -1 then
    begin
        Application.MessageBox('O frete est? inv?lido. Verifique!', 'Autocom PLUS', 16);
        tstrPageControl.ActivePage := tabTransportador;
        cmbFretePorConta.SetFocus;
        Result := false;
        exit;
    end;
end;

{*******************************************************************************
                        Procedimentos
*******************************************************************************}

procedure TfrmNota.Botao_Alterar;
begin
    cmdGravar.Kind := bkCustom;
    cmdGravar.ModalResult := mrNone;
    cmdGravar.Caption := '&Alterar';
end;

procedure TfrmNota.Botao_Cancelar;
begin
    cmdFechar.Kind := bkCancel;
    cmdFechar.Kind := bkCustom;
    cmdFechar.ModalResult := mrNone;
    cmdFechar.Caption := '&Cancelar';
end;

procedure TfrmNota.Botao_Fechar;
begin
    cmdFechar.Kind := bkClose;
    cmdFechar.Kind := bkCustom;
    cmdFechar.ModalResult := mrNone;
    cmdFechar.Caption := '&Fechar';
end;

procedure TfrmNota.Botao_Gravar;
begin
    cmdGravar.Kind := bkCustom;
    cmdGravar.ModalResult := mrNone;
    cmdGravar.Caption := '&Gravar';
end;

procedure TfrmNota.Calcula_Valor_Total_Nota;
var s_ValorTotalProdutos: String;
    s_ValorTotalIPI: String;
    s_ValorSeguro: String;
    s_OutrasDespesas: String;
    s_ValorFrete: String;
    s_ValorTotalNota: String;
    s_Acrescimo:String;
    s_Desconto:String;
begin
     mskValorTotalProdutos.EditMask := '9999999999,99;1; ';
     mskValorTotalIPI.EditMask := '9999999999,99;1; ';
     mskValorSeguro.EditMask := '9999999999,99;1; ';
     mskOutrasDespesas.EditMask := '9999999999,99;1; ';
     mskValorFrete.EditMask := '9999999999,99;1; ';
     mskValorTotalNota.EditMask := '9999999999,99;1; ';
     mskBaseCalculoICMS.EditMask := '9999999999,99;1; ';
     mskValorICMS.EditMask := '9999999999,99;1; ';
     mskDesconto.EditMask := '9999999999,99;1; ';
     mskAcrescimo.EditMask := '9999999999,99;1; ';

     s_ValorTotalProdutos := FormataNumero(AllTrim(mskValorTotalProdutos.Text), 10, 2);
     s_ValorTotalIPI := FormataNumero(AllTrim(mskValorTotalIPI.Text), 10, 2);
     s_ValorSeguro := FormataNumero(AllTrim(mskValorSeguro.Text), 10, 2);
     s_OutrasDespesas := FormataNumero(AllTrim(mskOutrasDespesas.Text), 10, 2);
     s_ValorFrete := FormataNumero(AllTrim(mskValorFrete.Text), 10, 2);
     s_Desconto := FormataNumero(AllTrim(mskDesconto.Text), 10, 2);
     s_Acrescimo := FormataNumero(AllTrim(mskAcrescimo.Text), 10, 2);

     s_ValorTotalNota := FloatToStr(StrToFloat(s_ValorTotalProdutos) + StrToFloat(s_ValorTotalIPI) +
                         StrToFloat(s_ValorSeguro) + StrToFloat(s_OutrasDespesas) +
                         StrToFloat(s_ValorFrete));

     mskValorTotalProdutos.Text := FormataNumero(s_ValorTotalProdutos, 10, 2);
     mskValorTotalIPI.Text := FormataNumero(s_ValorTotalIPI, 10, 2);
     mskValorSeguro.Text := FormataNumero(s_ValorSeguro, 10, 2);
     mskOutrasDespesas.Text := FormataNumero(s_OutrasDespesas, 10, 2);
     mskValorFrete.Text := FormataNumero(s_ValorFrete, 10, 2);


     mskBaseCalculoICMS.Text := FormataNumero(FloatToStr(db_BaseCalculoICMS+strtofloat(s_valorFrete)), 10, 2);
     mskValorICMS.Text := FormataNumero(FloatToStr(db_ValorICMS+(strtofloat(s_valorFrete)*ICMS_Frete)), 10, 2);


     mskValorTotalNota.Text := FormataNumero(s_ValorTotalNota, 10, 2);

     mskValorTotalProdutos.EditMask := '9999999999,99;0; ';
     mskValorTotalIPI.EditMask := '9999999999,99;0; ';
     mskValorSeguro.EditMask := '9999999999,99;0; ';
     mskOutrasDespesas.EditMask := '9999999999,99;0; ';
     mskValorFrete.EditMask := '9999999999,99;0; ';
     mskValorTotalNota.EditMask := '9999999999,99;0; ';
     mskBaseCalculoICMS.EditMask := '9999999999,99;0; ';
     mskValorICMS.EditMask := '9999999999,99;0; ';
     mskDesconto.EditMask := '9999999999,99;0; ';
     mskAcrescimo.EditMask := '9999999999,99;0; ';
end;

procedure TfrmNota.Captura_Valores;
var i: Integer;
begin

    mskCFOP.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('CODIGONATUREZAOPERACAO').AsString, 6);
    Executa_SQL(frmTabelas.tbl_NaturezaOperacao, 'SELECT * FROM NaturezaOperacao WHERE CODIGONATUREZAOPERACAO = ' + mskCFOP.Text);
    Label3.Caption := frmTabelas.tbl_NaturezaOperacao.FieldByName('NATUREZAOPERACAO').AsString;

    if frmTabelas.tbl_NotaFiscal.FieldByName('VEN_CODVENDEDOR').AsInteger > 0 then
    begin
        s_CodigoVendedor := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('VEN_CODVENDEDOR').AsString, 13);
        Executa_SQL(frmTabelas.tbl_Pessoa, 'SELECT Vendedor.CODIGOVENDEDOR, Pessoa.PES_NOME_A FROM Pessoa Pessoa, Vendedor Vendedor WHERE Pessoa.PES_CODPESSOA = Vendedor.PES_CODPESSOA AND Vendedor.VEN_CODVENDEDOR = ' + s_CodigoVendedor);
        mskIndicador.Text := FormataNumero(frmTabelas.tbl_Pessoa.FieldByName('CODIGOVENDEDOR').AsString, 13);
        Label6.Caption := frmTabelas.tbl_Pessoa.FieldByName('PES_NOME_A').AsString;
    end;

    if optEntrada.Checked then
    begin
        s_CodigoNotaFiscal := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('CODIGONOTAFISCALENTRADA').AsString, 8);

        s_CodigoPedido := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('CODIGOPEDIDOCOMPRA').AsString, 13);
        Executa_SQL(frmTabelas.tbl_PedidoCompra, 'SELECT * FROM PedidoCompra WHERE CODIGOPEDIDOCOMPRA = ' + s_CodigoPedido);
        mskOrcamento.Text := FormataNumero(frmTabelas.tbl_PedidoCompra.FieldByName('NUMEROPEDIDO').AsString, 13);

        s_CodigoFornecedor := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('FRN_CODFORNECEDOR').AsString, 13);
        Executa_SQL(frmTabelas.tbl_Pessoa, 'SELECT Fornecedor.CODIGOFORNECEDOR, Pessoa.PES_NOME_A FROM Pessoa Pessoa, Fornecedor Fornecedor WHERE Pessoa.PES_CODPESSOA = Fornecedor.PES_CODPESSOA AND Fornecedor.FRN_CODFORNECEDOR = ' + s_CodigoFornecedor);

        Label7.Caption := 'Fornecedor:';
        mskDestinatarioRemetente.Text := FormataNumero(frmTabelas.tbl_Pessoa.FieldByName('CODIGOFORNECEDOR').AsString, 13);
        Label8.Caption := Trim(frmTabelas.tbl_Pessoa.Fieldbyname('PES_NOME_A').AsString);

        mskDestinatarioRemetente.Left := 74;
        cmdConsultaDestinatarioRemetente.Left := 165;
        Label8.Left := 191;
        Label8.Width := 406;
        Label9.Left := 608;
        Label9.Caption := 'Pedido do Fornecedor:';
        mskPedido.Left := 736;
        Label11.Caption := 'Data da Entrada';

        Executa_SQL(frmTabelas.tbl_ProdutoPedidoCompra, 'SELECT * FROM ClassificacaoFiscal, Produto, ProdutoNotaEntrada, SituacaoTributaria ' +
                                                        'WHERE Produto.CODIGOPRODUTO = ProdutoNotaEntrada.CODIGOPRODUTO ' +
                                                        'AND ClassificacaoFiscal.CODIGOCLASSIFICACAOFISCAL = Produto.CODIGOCLASSIFICACAOFISCAL ' +
                                                        'AND SituacaoTributaria.CODIGOSITUACAOTRIBUTARIA = Produto.CODIGOSITUACAOTRIBUTARIA ' +
                                                        'AND ProdutoNotaEntrada.CODIGONOTAFISCALENTRADA = ' + s_CodigoNotaFiscal);

        dgrdDBGrid.DataSource.Enabled := true;
        dgrdDBGrid.DataSource.DataSet := frmTabelas.tbl_ProdutoPedidoCompra;
    end
    else
    begin
        s_CodigoNotaFiscal := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('CODIGONOTAFISCALSAIDA').AsString, 8);

        s_CodigoPedido := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('CODIGOPEDIDOVENDA').AsString, 13);
        Executa_SQL(frmTabelas.tbl_PedidoVenda, 'SELECT * FROM PedidoVenda WHERE CODIGOPEDIDOVENDA = ' + s_CodigoPedido);
        mskOrcamento.Text := FormataNumero(frmTabelas.tbl_PedidoVenda.FieldByName('NUMEROPEDIDO').AsString, 13);

        s_CodigoCliente := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('CLI_CODCLIENTE').AsString, 13);
        Executa_SQL(frmTabelas.tbl_Pessoa, 'SELECT Cliente.CODIGOCLIENTE, Pessoa.PES_NOME_A FROM Pessoa Pessoa, Cliente Cliente WHERE Pessoa.PES_CODPESSOA = Cliente.PES_CODPESSOA AND Cliente.CLI_CODCLIENTE = ' + s_CodigoCliente);

        Label7.Caption := 'Cliente:';
        mskDestinatarioRemetente.Text := FormataNumero(frmTabelas.tbl_Pessoa.FieldByName('CODIGOCLIENTE').AsString, 13);
        Label8.Caption := Trim(frmTabelas.tbl_Pessoa.Fieldbyname('PES_NOME_A').AsString);

        mskDestinatarioRemetente.Left := 48;
        cmdConsultaDestinatarioRemetente.Left := 139;
        Label8.Left := 165;
        Label8.Width := 458;
        Label9.Left := 634;
        Label9.Caption := 'Pedido do Cliente:';
        mskPedido.Left := 736;
        Label11.Caption := 'Data da Sa?da';

        Executa_SQL(frmTabelas.tbl_ProdutoPedidoVenda, 'SELECT * FROM ClassificacaoFiscal, Produto, ProdutoNotaSaida, SituacaoTributaria ' +
                                                       'WHERE Produto.CODIGOPRODUTO = ProdutoNotaSaida.CODIGOPRODUTO ' +
                                                       'AND ClassificacaoFiscal.CODIGOCLASSIFICACAOFISCAL = Produto.CODIGOCLASSIFICACAOFISCAL ' +
                                                       'AND SituacaoTributaria.CODIGOSITUACAOTRIBUTARIA = Produto.CODIGOSITUACAOTRIBUTARIA ' +
                                                       'AND ProdutoNotaSaida.CODIGONOTAFISCALSAIDA = ' + s_CodigoNotaFiscal);

        dgrdDBGrid.DataSource.Enabled := true;
        dgrdDBGrid.DataSource.DataSet := frmTabelas.tbl_ProdutoPedidoVenda;
    end;

    s_CodigoCondicaoPagamento := frmTabelas.tbl_NotaFiscal.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString;
    for i := 0 to cmbCondicaoPagamento.Items.Count do
    begin
        if ad_CondicaoPagamento[i] = StrToInt(s_CodigoCondicaoPagamento) then
        begin
            cmbCondicaoPagamento.ItemIndex := i;
            break;
        end;
    end;

    mskSerie.Text := frmTabelas.tbl_NotaFiscal.FieldByName('SERIE').AsString;
    mskPedido.Text := frmTabelas.tbl_NotaFiscal.FieldByName('PEDIDOEXTERNO').AsString;
    datDataEmissao.Date := frmTabelas.tbl_NotaFiscal.FieldByName('DATAEMISSAO').AsDateTime;
    datDataEntradaSaida.Date := frmTabelas.tbl_NotaFiscal.FieldByName('DATAENTREGA').AsDateTime;
    datHoraSaida.Time := frmTabelas.tbl_NotaFiscal.FieldByName('HORASAIDA').AsDateTime;

    // Produto, Preco e Quantidade
    mskProduto.Clear;
    Label17.Caption := '';
    cmbPreco.Clear;
    mskPreco.Text:= '         000';
    mskQuantidade.Clear;

    mskAcrescimo.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('ACRESCIMO').AsString, 10, 2);
    mskDesconto.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('DESCONTO').AsString, 10, 2);

    mskBaseCalculoICMS.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('BASEICMS').AsString, 10, 2);
    mskValorICMS.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('ICMS').AsString, 10, 2);
    mskBaseCalculoICMSSub.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('BASEICMSSUBSTITUICAO').AsString, 10, 2);
    mskValorICMSSub.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('ICMSSUBSTITUICAO').AsString, 10, 2);
    mskValorTotalProdutos.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('TOTALPRODUTOS').AsString, 10, 2);
    mskValorTotalIPI.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('IPI').AsString, 10, 2);
    mskValorSeguro.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('SEGURO').AsString, 10, 2);
    mskOutrasDespesas.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('DESPESASACESSORIAS').AsString, 10, 2);
    mskValorFrete.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('FRETE').AsString, 10, 2);
    mskValorTotalNota.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('TOTALNOTA').AsString, 10, 2);

    s_CodigoTransportadora := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('TRP_CODTRANSPORTADORA').AsString, 4, 0);
    Executa_SQL(frmTabelas.tbl_Pessoa, 'SELECT Transportadora.CODIGOTRANSPORTADORA, Pessoa.PES_NOME_A FROM Pessoa Pessoa, Transportadora Transportadora WHERE Pessoa.PES_CODPESSOA = Transportadora.PES_CODPESSOA AND Transportadora.TRP_CODTRANSPORTADORA = ' + s_CodigoTransportadora);
    mskCodigoTransportador.Text := FormataNumero(frmTabelas.tbl_Pessoa.FieldByName('CODIGOTRANSPORTADORA').AsString, 4, 0);
    txtNomeTransportador.Text := frmTabelas.tbl_Pessoa.FieldByName('PES_NOME_A').AsString;

    cmbFretePorConta.ItemIndex := frmTabelas.tbl_NotaFiscal.FieldByName('TIPOFRETE').AsInteger - 1;
    txtPlacaVeiculo.Text := frmTabelas.tbl_NotaFiscal.FieldByName('PLACAVEICULO').AsString;

    cmbUF.ItemIndex := -1;
    if frmTabelas.tbl_NotaFiscal.FieldByName('UFPLACA').Value <> NULL then
    begin
        for i := 0 to cmbUF.Items.Count do
        begin
            if cmbUF.Items[i] = frmTabelas.tbl_NotaFiscal.FieldByName('UFPLACA').AsString then
            begin
                cmbUF.ItemIndex := i;
                break;
            end;
        end;
    end;

    mskQuantidadeVolumes.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('QUANTIDADE').AsString, 8, 3);
    txtEspecie.Text := frmTabelas.tbl_NotaFiscal.FieldByName('ESPECIE').AsString;
    txtMarca.Text := frmTabelas.tbl_NotaFiscal.FieldByName('MARCA').AsString;
    mskNumero.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('NUMERO').AsString, 13);
    mskPesoBruto.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('PESOBRUTO').AsString, 8, 3);
    mskPesoLiquido.Text := FormataNumero(frmTabelas.tbl_NotaFiscal.FieldByName('PESOLIQUIDO').AsString, 8, 3);

    Processa_Valores_DBGrid;
end;

procedure TfrmNota.Carrega_Ini;
var Autocom: TIniFile;
begin
    Autocom := TIniFile.Create(s_Path + 'Autocom.ini');

    // Nome do tipo de or?amento
    Label4.Caption := Trim(Autocom.ReadString('PREVENDA', 'Legenda', 'Or?amento')) + ':';

    if Label4.Width > 150 then
    begin
        Label4.AutoSize := false;
        Label4.Width := 150;
    end
    else
        Label4.AutoSize := true;

    Label4.Left := 678 - Label4.Width;
    Label3.Width := Label4.Left - 306;

    // Nome do indicador parametrizado no sistema
    Label5.Caption := Trim(Autocom.ReadString('TERMINAL', 'NOMEIND', 'Indicador')) + ':';

    if Label5.Width > 200 then
    begin
        Label5.AutoSize := false;
        Label5.Width := 200;
    end
    else
        Label5.AutoSize := true;

    mskIndicador.Left := Label5.Width + 6;
    cmdConsultaIndicador.Left := Label5.Width + 97;
    Label6.Left := Label5.Width + 123;

    s_CodigoInicial := AllTrim(Autocom.ReadString('NF', 'Contador_inicial', '1'));
    s_LimiteItem := AllTrim(Autocom.ReadString('NF', 'Lim_Item', '0'));
    s_ImpressoraSimples := AllTrim(Autocom.ReadString('LOJA', 'usa_imp_simples', '1'));
    s_Loja := AllTrim(Autocom.ReadString('LOJA', 'LojaNum', '1'));
    s_Orcamento := AllTrim(Autocom.ReadString('PREVENDA', 'armazena_orc', '1'));

    Autocom.Free;
end;

procedure TfrmNota.Carrega_Op;
var Oper: TIniFile;
begin
    Oper := TIniFile.Create(s_Path + 'oper.ini');
    s_Operador := Trim(Oper.ReadString('OPER', 'Codigo', '0'));
    Oper.Free;
end;

procedure TfrmNota.Conecta_DB;
var IniFile: TIniFile;
    s_T1, s_T2: String;
begin
    frmTabelas.IBTransaction1.Active := false;
    frmTabelas.DBAutocom.Connected := false;

    IniFile := TIniFile.Create(s_Path + 'Autocom.ini');
    s_T1 := IniFile.ReadString('ATCPLUS', 'IP_SERVER', '' );
    s_T2 := IniFile.ReadString('ATCPLUS', 'PATH_DB', '');
    IniFile.Free;

    frmTabelas.DbAutocom.DatabaseName := s_T1 + ':' + s_T2;

    frmTabelas.DbAutocom.Connected := true;
    frmTabelas.IBTransaction1.Active := true;
end;

procedure TfrmNota.Desconecta_DB;
begin
    frmTabelas.IBTransaction1.Active := false;
    frmTabelas.DBAutocom.Connected := false;
end;

procedure TfrmNota.Exclui_Dados_StringGrid(i_Row: Integer);
var i: Integer;
begin
    grdStringGrid.Rows[i_Row].Text := '';

    for i := i_Row to (grdStringGrid.RowCount - 1) do
    begin
        grdStringGrid.Rows[i].Text := grdStringGrid.Rows[i+1].Text;
    end;

    grdStringGrid.RowCount := grdStringGrid.RowCount - 1;

    grdStringGrid.FixedCols := 1;
    grdStringGrid.FixedRows := 1;
end;

procedure TfrmNota.Executa_SQL(obj_IBQuery: TIBQuery; s_SQL: String; b_Open: Boolean = true);
begin
    obj_IBQuery.Close;
    obj_IBQuery.SQL.Clear;
    obj_IBQuery.SQL.Add(s_SQL);
    obj_IBQuery.Prepare;

    if b_Open then
        obj_IBQuery.Open
    else
        obj_IBQuery.ExecSQL;
end;

procedure TfrmNota.Formata_StringGrid;
var i: Integer;
begin
    for i := 0 to grdStringGrid.ColCount do
    begin
        grdStringGrid.Cols[i].Clear;
        grdStringGrid.Rows[i].Clear;
    end;

    grdStringGrid.ColCount := 11;
    grdStringGrid.RowCount := 2;
    grdStringGrid.FixedCols := 1;
    grdStringGrid.FixedRows := 1;

    grdStringGrid.ColWidths[0] := 11;
    grdStringGrid.Cols[0].Text := '';
    grdStringGrid.ColWidths[1] := 124;
    grdStringGrid.Cols[1].Text := 'C?digo do Produto';
    grdStringGrid.ColWidths[2] := 616;
    grdStringGrid.Cols[2].Text := 'Nome do Produto';
    grdStringGrid.ColWidths[3] := 78;
    grdStringGrid.Cols[3].Text := 'Quantidade';
    grdStringGrid.ColWidths[4] := 65;
    grdStringGrid.Cols[4].Text := 'Pre?o';
    grdStringGrid.ColWidths[5] := 94;
    grdStringGrid.Cols[5].Text := 'Al?quota ICMS';
    grdStringGrid.ColWidths[6] := 78;
    grdStringGrid.Cols[6].Text := 'Al?quota IPI';
    grdStringGrid.ColWidths[7] := 72;
    grdStringGrid.Cols[7].Text := 'Peso Bruto';
    grdStringGrid.ColWidths[8] := 87;
    grdStringGrid.Cols[8].Text := 'Peso L?quido';
    grdStringGrid.ColWidths[9] := 90;
    grdStringGrid.Cols[9].Text := 'C?digo Situa??o';
    grdStringGrid.ColWidths[10] := 302;
    grdStringGrid.Cols[10].Text := 'Situa??o Tribut?ria';
end;

procedure TfrmNota.Habilita_Campos;
begin
    mskCFOP.Enabled := true;
    cmdConsultaCFOP.Enabled := true;

    mskOrcamento.Enabled := false;
    cmdConsultaOrcamento.Enabled := false;
    cmbCondicaoPagamento.Enabled := false;

    mskSerie.Enabled := true;
    mskIndicador.Enabled := true;
    cmdConsultaIndicador.Enabled := true;
    mskDestinatarioRemetente.Enabled := true;
    cmdConsultaDestinatarioRemetente.Enabled := true;
    mskPedido.Enabled := true;
    datDataEmissao.Enabled := true;
    datDataEntradaSaida.Enabled := true;
    datHoraSaida.Enabled := true;

    mskProduto.Enabled := false;
    cmdConsultaProduto.Enabled := false;
    cmbPreco.Enabled := false;
    mskQuantidade.Enabled := false;

    dgrdDBGrid.DataSource.Enabled := true;
    dgrdDBGrid.ShowHint := false;

    mskValorSeguro.Enabled := true;
    mskOutrasDespesas.Enabled := true;
    mskValorFrete.Enabled := true;

    mskCodigoTransportador.Enabled := true;
    cmdConsultaCodigoTransportador.Enabled := true;
    cmbFretePorConta.Enabled := true;
    txtPlacaVeiculo.Enabled := true;
    cmbUF.Enabled := true;
    mskQuantidadeVolumes.Enabled := true;
    txtEspecie.Enabled := true;
    txtMarca.Enabled := true;
    mskNumero.Enabled := true;
    mskPesoBruto.Enabled := true;
    mskPesoLiquido.Enabled := true;
end;

procedure TfrmNota.Imprime_NF;
var Ini: TIniFile;
    b_CodigoFiscal: Boolean;
    i_Cont: Integer;
    i_ContArray: Integer;
    i_QuantidadeProdutos: Integer;
    ad_CodFiscal: Array[1..26] of String;
    ad_SiglaFiscal: Array[1..26] of String;
    s_MaiorSigla: String;
    s_cep:String;
begin
    try
        Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'impNF.ini');

        Troca_Maskara(true);

        if optentrada.Checked then
        begin// Nota Fiscal de Entrada
            Ini.WriteString('NF', 'X_entrada_imp', '1');
            Ini.WriteString('NF', 'X_saida_imp', '0');
        end;

        if optSaida.Checked then
        begin// Nota Fiscal de Saida
            Ini.WriteString('NF', 'X_entrada_imp', '0');
            Ini.WriteString('NF', 'X_saida_imp', '1');
        end;

        Ini.WriteString('NF', 'numero_nf', AllTrim(mskCodNotaFiscal.Text));
        Ini.WriteString('NF', 'nome_cfop', Trim(Label3.Caption));
        Ini.WriteString('NF', 'CFPO', AllTrim(mskCFOP.Text));
        Ini.WriteString('NF', 'ie_subs_trib', '');
        Ini.Writestring('NF', 'nome_cli', Trim(Label8.Caption));

        if optsaida.checked=true then
        begin // dados do cliente
            Executa_SQL(frmTabelas.tbl_Pessoa, 'SELECT * FROM Cliente, Pessoa, EnderecoPessoa ' +
                                               'WHERE Pessoa.PES_CODPESSOA = Cliente.PES_CODPESSOA AND ' +
                                               'Pessoa.PES_CODPESSOA = EnderecoPessoa.PES_CODPESSOA AND ' +
                                               'Cliente.CLI_CODCLIENTE = ' + s_CodigoCliente);
         end;

        if optentrada.checked=true then
           begin // Dados do fornecedor
                Executa_SQL(frmTabelas.tbl_Pessoa, 'SELECT * FROM Fornecedor, Pessoa, EnderecoPessoa ' +
                                                   'WHERE Pessoa.PES_CODPESSOA = Fornecedor.PES_CODPESSOA AND ' +
                                                   'Pessoa.PES_CODPESSOA = EnderecoPessoa.PES_CODPESSOA AND ' +
                                                   'Fornecedor.FRN_CODFORNECEDOR = ' + s_CodigoFornecedor);
           end;
        Ini.WriteString('NF', 'cnpj_cli', frmTabelas.tbl_Pessoa.FieldByName('PES_CPF_CNPJ_A').AsString);
        Ini.WriteString('NF', 'endereco_cli', frmTabelas.tbl_Pessoa.FieldByName('ENP_ENDERECO_A').AsString +' - '+ frmTabelas.tbl_Pessoa.FieldByName('ENP_COMPLEMENTO_A').AsString);
        Ini.WriteString('NF', 'bairro_cli', frmTabelas.tbl_Pessoa.FieldByName('ENP_BAIRRO_A').AsString);

        s_cep:=frmTabelas.tbl_Pessoa.FieldByName('ENP_CEP_I').AsString;

        while length(s_cep)<8 do
           begin
              s_cep:='0'+s_cep;
           end;
        s_cep:=copy(s_cep,1,5)+'-'+copy(s_cep,6,3);
        Ini.WriteString('NF', 'cep_cli', s_cep);

        Ini.WriteString('NF', 'municipio_cli', frmTabelas.tbl_Pessoa.FieldByName('ENP_CIDADE_A').AsString);
        Ini.WriteString('NF', 'fone_cli', frmTabelas.tbl_Pessoa.FieldByName('TELEFONE1').AsString);
        Ini.WriteString('NF', 'UF_cli', frmTabelas.tbl_Pessoa.FieldByName('ENP_ESTADO_A').AsString);
        Ini.WriteString('NF', 'ie_cli', frmTabelas.tbl_Pessoa.FieldByName('PES_RG_IE_A').AsString);


        Ini.WriteString('NF', 'data_emissao', FormatDateTime('dd/mm/yyyy', datDataEmissao.Date));
        Ini.WriteString('NF', 'data_saida', FormatDateTime('dd/mm/yyyy', datDataEntradaSaida.Date));
        Ini.WriteString('NF', 'hora saida', TimeToStr(datHoraSaida.Time));

        if Length(AllTrim(mskOrcamento.Text)) > 0 then
        begin
            if optEntrada.Checked then
                Ini.WriteString('NF', 'num_produtos', IntToStr(frmTabelas.tbl_ProdutoPedidoCompra.RecordCount))
            else
                ini.Writestring('NF', 'num_produtos', IntToStr(frmTabelas.tbl_ProdutoPedidoVenda.RecordCount));
        end
        else
            Ini.WriteString('NF', 'num_produtos', IntToStr(frmTabelas.tbl_Produto.RecordCount));

        Ini.WriteString('NF', 'class_fisc_nomeA', '');
        Ini.WriteString('NF', 'class_fisc_nomeB', '');
        Ini.WriteString('NF', 'class_fisc_nomeC', '');
        Ini.WriteString('NF', 'class_fisc_nomeD', '');
        Ini.WriteString('NF', 'class_fisc_nomeE', '');
        Ini.WriteString('NF', 'class_fisc_nomeF', '');
        Ini.WriteString('NF', 'class_fisc_nomeG', '');
        Ini.WriteString('NF', 'class_fisc_nomeH', '');
        Ini.WriteString('NF', 'class_fisc_nomeI', '');
        Ini.WriteString('NF', 'class_fisc_nomeJ', '');
        Ini.WriteString('NF', 'class_fisc_nomeK', '');
        Ini.WriteString('NF', 'class_fisc_nomeL', '');
        Ini.WriteString('NF', 'class_fisc_nomeM', '');
        Ini.WriteString('NF', 'class_fisc_nomeN', '');
        Ini.WriteString('NF', 'class_fisc_nomeO', '');
        Ini.WriteString('NF', 'class_fisc_nomeP', '');
        Ini.WriteString('NF', 'class_fisc_nomeQ', '');
        Ini.WriteString('NF', 'class_fisc_nomeR', '');
        Ini.WriteString('NF', 'class_fisc_nomeS', '');
        Ini.WriteString('NF', 'class_fisc_nomeT', '');
        Ini.WriteString('NF', 'class_fisc_nomeU', '');
        Ini.WriteString('NF', 'class_fisc_nomeV', '');
        Ini.Writestring('NF', 'class_fisc_nomeW', '');
        Ini.WriteString('NF', 'class_fisc_nomeX', '');
        Ini.WriteString('NF', 'class_fisc_nomeY', '');
        Ini.WriteString('NF', 'class_fisc_nomeZ', '');

        // Limpa Arrya Fiscal
        for i_Cont := 1 to 26 do
        begin
            ad_CodFiscal[i_Cont] := '';
            ad_SiglaFiscal[i_Cont] := '';
        end;
        i_Cont := 1;
        s_MaiorSigla := '';

        if optEntrada.Checked then
        begin// Nota Fiscal de Entrada
            if frmTabelas.tbl_ProdutoPedidoCompra.RecordCount > 0 then
            begin
                i_Cont := 1;
                frmTabelas.tbl_ProdutoPedidoCompra.First;

                while not frmTabelas.tbl_ProdutoPedidoCompra.Eof do
                begin
                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'codigo', frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('CODIGOPRODUTO').AsString);
                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'descricao', Trim(frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('NOMEPRODUTO').AsString));

                    b_CodigoFiscal := false;

                    for i_ContArray := 1 to i_Cont do
                    begin
                        if ad_CodFiscal[i_ContArray] = frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('CLASSIFICACAOFISCAL').AsString then
                        begin
                            b_CodigoFiscal := true;
                            Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'class_fiscal', ad_SiglaFiscal[i_ContArray]);
                            ad_SiglaFiscal[i_Cont] := ad_SiglaFiscal[i_ContArray];
                            break;
                        end;
                    end;

                    if not b_CodigoFiscal then
                    begin
                        ad_CodFiscal[i_Cont] := frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('CLASSIFICACAOFISCAL').AsString;
                        if i_Cont = 1 then
                            ad_SiglaFiscal[i_Cont] := 'A'
                        else
                        begin
                            if s_MaiorSigla = 'A' then ad_SiglaFiscal[i_Cont] := 'B';
                            if s_MaiorSigla = 'B' then ad_SiglaFiscal[i_Cont] := 'C';
                            if s_MaiorSigla = 'C' then ad_SiglaFiscal[i_Cont] := 'D';
                            if s_MaiorSigla = 'D' then ad_SiglaFiscal[i_Cont] := 'E';
                            if s_MaiorSigla = 'E' then ad_SiglaFiscal[i_Cont] := 'F';
                            if s_MaiorSigla = 'F' then ad_SiglaFiscal[i_Cont] := 'G';
                            if s_MaiorSigla = 'G' then ad_SiglaFiscal[i_Cont] := 'H';
                            if s_MaiorSigla = 'H' then ad_SiglaFiscal[i_Cont] := 'I';
                            if s_MaiorSigla = 'I' then ad_SiglaFiscal[i_Cont] := 'J';
                            if s_MaiorSigla = 'J' then ad_SiglaFiscal[i_Cont] := 'K';
                            if s_MaiorSigla = 'K' then ad_SiglaFiscal[i_Cont] := 'L';
                            if s_MaiorSigla = 'L' then ad_SiglaFiscal[i_Cont] := 'M';
                            if s_MaiorSigla = 'M' then ad_SiglaFiscal[i_Cont] := 'N';
                            if s_MaiorSigla = 'N' then ad_SiglaFiscal[i_Cont] := 'O';
                            if s_MaiorSigla = 'O' then ad_SiglaFiscal[i_Cont] := 'P';
                            if s_MaiorSigla = 'P' then ad_SiglaFiscal[i_Cont] := 'Q';
                            if s_MaiorSigla = 'Q' then ad_SiglaFiscal[i_Cont] := 'R';
                            if s_MaiorSigla = 'R' then ad_SiglaFiscal[i_Cont] := 'S';
                            if s_MaiorSigla = 'S' then ad_SiglaFiscal[i_Cont] := 'T';
                            if s_MaiorSigla = 'T' then ad_SiglaFiscal[i_Cont] := 'U';
                            if s_MaiorSigla = 'U' then ad_SiglaFiscal[i_Cont] := 'V';
                            if s_MaiorSigla = 'V' then ad_SiglaFiscal[i_Cont] := 'W';
                            if s_MaiorSigla = 'W' then ad_SiglaFiscal[i_Cont] := 'X';
                            if s_MaiorSigla = 'X' then ad_SiglaFiscal[i_Cont] := 'Y';
                            if s_MaiorSigla = 'Y' then ad_SiglaFiscal[i_Cont] := 'Z';
                        end;

                        s_MaiorSigla := ad_SiglaFiscal[i_Cont];
                        Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'class_fiscal', ad_SiglaFiscal[i_Cont]);
                    end;

                    for i_ContArray := 1 to i_Cont do
                    begin
                        if ad_CodFiscal[i_ContArray] = frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('CLASSIFICACAOFISCAL').AsString then
                        begin
                            Ini.WriteString('NF', 'class_fisc_nome' + ad_SiglaFiscal[i_ContArray], ad_SiglaFiscal[i_ContArray] + '            ' + ad_CodFiscal[i_ContArray]);
                            break;
                        end;
                    end;

                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'Sit_trib', frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('SITUACAOTRIBUTARIA').AsString);
                    //Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'UNid_med', frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('').AsString);
                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'Quantidade', AllTrim(FloatToStrF(frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('QUANTIDADE').AsFloat, ffnumber, 10, 3)));
                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'Valor_un', AllTrim(FloatToStrF(frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('PRECO').AsFloat, ffnumber, 10, 2)));
                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'valor_tot', AllTrim(FloatToStrF(frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('QUANTIDADE').AsFloat * frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('PRECO').AsFloat, ffnumber, 10, 2)));
                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'ICMS', AllTrim(FloatToStrF(frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('ALIQUOTAICMS').AsFloat, ffnumber, 2, 2)));
                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'IPI', AllTrim(FloatToStrF(frmTabelas.tbl_ProdutoPedidoCompra.FieldByName('ALIQUOTAIPI').AsFloat, ffnumber, 2, 2)));
//                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'Valor_IPI', AllTrim(FloatToStrF(frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('QUANTIDADE').AsFloat * frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('PRECO').AsFloat, ffnumber, 10, 2)));

                    i_Cont := i_Cont + 1;
                    frmTabelas.tbl_ProdutoPedidoCompra.Next;
                end;
            end;
        end;


        if optSaida.Checked then
        begin// Nota Fiscal de Saida
            if frmTabelas.tbl_ProdutoPedidoVenda.RecordCount > 0 then
            begin
                i_Cont := 1;
                frmTabelas.tbl_ProdutoPedidoVenda.First;

                while not frmTabelas.tbl_ProdutoPedidoVenda.Eof do
                begin
                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'codigo', frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('CODIGOPRODUTO').AsString);
                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'descricao', Trim(frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('NOMEPRODUTO').AsString));

                    b_CodigoFiscal := false;

                    for i_ContArray := 1 to i_Cont do
                    begin
                        if ad_CodFiscal[i_ContArray] = frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('CLASSIFICACAOFISCAL').AsString then
                        begin
                            b_CodigoFiscal := true;
                            Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'class_fiscal', ad_SiglaFiscal[i_ContArray]);
                            ad_SiglaFiscal[i_Cont] := ad_SiglaFiscal[i_ContArray];
                            break;
                        end;
                    end;

                    if not b_CodigoFiscal then
                    begin
                        ad_CodFiscal[i_Cont] := frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('CLASSIFICACAOFISCAL').AsString;
                        if i_Cont = 1 then
                            ad_SiglaFiscal[i_Cont] := 'A'
                        else
                        begin
                            if s_MaiorSigla = 'A' then ad_SiglaFiscal[i_Cont] := 'B';
                            if s_MaiorSigla = 'B' then ad_SiglaFiscal[i_Cont] := 'C';
                            if s_MaiorSigla = 'C' then ad_SiglaFiscal[i_Cont] := 'D';
                            if s_MaiorSigla = 'D' then ad_SiglaFiscal[i_Cont] := 'E';
                            if s_MaiorSigla = 'E' then ad_SiglaFiscal[i_Cont] := 'F';
                            if s_MaiorSigla = 'F' then ad_SiglaFiscal[i_Cont] := 'G';
                            if s_MaiorSigla = 'G' then ad_SiglaFiscal[i_Cont] := 'H';
                            if s_MaiorSigla = 'H' then ad_SiglaFiscal[i_Cont] := 'I';
                            if s_MaiorSigla = 'I' then ad_SiglaFiscal[i_Cont] := 'J';
                            if s_MaiorSigla = 'J' then ad_SiglaFiscal[i_Cont] := 'K';
                            if s_MaiorSigla = 'K' then ad_SiglaFiscal[i_Cont] := 'L';
                            if s_MaiorSigla = 'L' then ad_SiglaFiscal[i_Cont] := 'M';
                            if s_MaiorSigla = 'M' then ad_SiglaFiscal[i_Cont] := 'N';
                            if s_MaiorSigla = 'N' then ad_SiglaFiscal[i_Cont] := 'O';
                            if s_MaiorSigla = 'O' then ad_SiglaFiscal[i_Cont] := 'P';
                            if s_MaiorSigla = 'P' then ad_SiglaFiscal[i_Cont] := 'Q';
                            if s_MaiorSigla = 'Q' then ad_SiglaFiscal[i_Cont] := 'R';
                            if s_MaiorSigla = 'R' then ad_SiglaFiscal[i_Cont] := 'S';
                            if s_MaiorSigla = 'S' then ad_SiglaFiscal[i_Cont] := 'T';
                            if s_MaiorSigla = 'T' then ad_SiglaFiscal[i_Cont] := 'U';
                            if s_MaiorSigla = 'U' then ad_SiglaFiscal[i_Cont] := 'V';
                            if s_MaiorSigla = 'V' then ad_SiglaFiscal[i_Cont] := 'W';
                            if s_MaiorSigla = 'W' then ad_SiglaFiscal[i_Cont] := 'X';
                            if s_MaiorSigla = 'X' then ad_SiglaFiscal[i_Cont] := 'Y';
                            if s_MaiorSigla = 'Y' then ad_SiglaFiscal[i_Cont] := 'Z';
                        end;

                        s_MaiorSigla := ad_SiglaFiscal[i_Cont];
                        Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'class_fiscal', ad_SiglaFiscal[i_Cont]);
                    end;

                    for i_ContArray := 1 to i_Cont do
                    begin
                        if ad_CodFiscal[i_ContArray] = frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('CLASSIFICACAOFISCAL').AsString then
                        begin
                            Ini.WriteString('NF', 'class_fisc_nome' + ad_SiglaFiscal[i_ContArray], ad_SiglaFiscal[i_ContArray] + '            ' + ad_CodFiscal[i_ContArray]);
                            break;
                        end;
                    end;

                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'Sit_trib', frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('SITUACAOTRIBUTARIA').AsString);
                    //Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'UNid_med', frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('UN_VENDA').AsString);
                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'Quantidade', AllTrim(FloatToStrF(frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('QUANTIDADE').AsFloat, ffnumber, 10, 3)));
                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'Valor_un', AllTrim(FloatToStrF(frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('PRECO').AsFloat, ffnumber, 10, 2)));
                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'valor_tot', AllTrim(FloatToStrF(frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('QUANTIDADE').AsFloat * frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('PRECO').AsFloat, ffnumber, 10, 2)));

                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'ICMS', AllTrim(FloatToStrF(frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('ALIQUOTAICMS').AsFloat, ffnumber, 2, 2)));
                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'IPI', AllTrim(FloatToStrF(frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('ALIQUOTAIPI').AsFloat, ffnumber, 2, 2)));
//                    Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'Valor_IPI', AllTrim(FloatToStrF(frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('QUANTIDADE').AsFloat * frmTabelas.tbl_ProdutoPedidoVenda.FieldByName('PRECO').AsFloat, ffnumber, 10, 2)));

                    i_Cont := i_Cont + 1;
                    frmTabelas.tbl_ProdutoPedidoVenda.Next;
                end;
            end;
        end;

        if (optSaida.Checked) and (Length(AllTrim(mskOrcamento.Text)) > 0) then
        begin// Insere no corpo da nota o valor do acrescimo
            i_QuantidadeProdutos := frmTabelas.tbl_ProdutoPedidoVenda.RecordCount;
            if StrToFloat(AllTrim(mskAcrescimo.Text)) > 0 then
            begin
                i_QuantidadeProdutos := i_QuantidadeProdutos + 1;
                Ini.WriteString('NF', 'num_produtos', IntToStr(i_QuantidadeProdutos));
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'descricao', 'Acr?scimos diversos: ');
                Ini.Writestring('NF', FormataNumero(IntToStr(i_Cont), 2) + 'valor_tot', floattostrf(strtofloat(AllTrim(mskAcrescimo.Text)),ffnumber,12,2));
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'codigo', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'class_fiscal', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'Sit_trib', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'UNid_med', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'Quantidade', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'Valor_un', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'ICMS', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'IPI', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'ISS', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'VAlor_ipi', '');
                i_Cont := i_Cont + 1;
            end;

            if StrToFloat(AllTrim(mskDesconto.Text)) > 0 then
            begin// Insere no corpo da nota o desconto
                i_QuantidadeProdutos := i_QuantidadeProdutos + 1;
                Ini.WriteString('NF', 'num_produtos', IntToStr(i_QuantidadeProdutos));
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'descricao', 'Desconto promocional: ');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'valor_tot', floattostrf(strtofloat(AllTrim(mskDesconto.Text)),ffnumber,12,2));
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'codigo', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'class_fiscal', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'Sit_trib', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'UNid_med', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'Quantidade', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'Valor_un', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'ICMS', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'IPI', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'ISS', '');
                Ini.WriteString('NF', FormataNumero(IntToStr(i_Cont), 2) + 'VAlor_ipi', '');
            end;
        end;

        Ini.WriteString('NF', 'obs', '');
        Ini.WriteString('NF', 'Base_icms', floattostrf(strtofloat(AllTrim(mskBaseCalculoICMS.Text)),ffnumber,12,2));
        Ini.WriteString('NF', 'Valor_ICMS', floattostrf(strtofloat(AllTrim(mskValorICMS.Text)),ffnumber,12,2));
        Ini.WriteString('NF', 'Base_icms_sub', floattostrf(strtofloat(AllTrim(mskBaseCalculoICMSSub.Text)),ffnumber,12,2));
        Ini.WriteString('NF', 'Valor_icms_subs', floattostrf(strtofloat(AllTrim(mskValorICMSSub.Text)),ffnumber,12,2));
        Ini.WriteString('NF', 'Total_produtos', floattostrf(strtofloat(AllTrim(mskValorTotalProdutos.Text)),ffnumber,12,2));
        Ini.WriteString('NF', 'Valor_frete', floattostrf(strtofloat(AllTrim(mskValorFrete.Text)),ffnumber,12,2));
        Ini.WriteString('NF', 'Valor_seguro', floattostrf(strtofloat(AllTrim(mskValorSeguro.Text)),ffnumber,12,2));
        Ini.WriteString('NF', 'despesas', floattostrf(strtofloat(AllTrim(mskOutrasDespesas.Text)),ffnumber,12,2));
        Ini.WriteString('NF', 'Valor_tipi', floattostrf(strtofloat(AllTrim(mskValorTotalIPI.Text)),ffnumber,12,2));
        Ini.WriteString('NF', 'Total_nota', floattostrf(strtofloat(AllTrim(mskValorTotalNota.Text)),ffnumber,12,2));
        Ini.WriteString('NF', 'Nome_transp', Trim(txtNomeTransportador.Text));
        Ini.WriteString('NF', 'tipo_frete', IntToStr(cmbFretePorConta.ItemIndex + 1));
        Ini.WriteString('NF', 'PLACA_transp', Trim(txtPlacaVeiculo.Text));

        // dados da transportadora
        Executa_SQL(frmTabelas.tbl_Pessoa, 'SELECT * FROM Transportadora, Pessoa, EnderecoPessoa ' +
                                           'WHERE Pessoa.PES_CODPESSOA = Transportadora.PES_CODPESSOA ' +
                                           'AND Pessoa.PES_CODPESSOA = EnderecoPessoa.PES_CODPESSOA ' +
                                           'AND Transportadora.TRP_CODTRANSPORTADORA = ' + s_CodigoTransportadora);
        Ini.WriteString('NF', 'UF_TRansp_veic', frmTabelas.tbl_Pessoa.FieldByName('ENP_ESTADO_A').AsString);
        if Length(AllTrim(frmTabelas.tbl_Pessoa.FieldByName('PES_CPF_CNPJ_A').AsString)) > 0 then
            Ini.WriteString('NF', 'CNPJ_TRansp', AllTrim(frmTabelas.tbl_Pessoa.FieldByName('PES_CPF_CNPJ_A').AsString))
        else
            Ini.WriteString('NF', 'CNPJ_TRansp', '');
        Ini.WriteString('NF', 'endereco_transp', Trim(frmTabelas.tbl_Pessoa.FieldByName('ENP_ENDERECO_A').AsString));
        Ini.WriteString('NF', 'Municipio_transp', Trim(frmTabelas.tbl_Pessoa.FieldByName('ENP_CIDADE_A').AsString));
        Ini.WriteString('NF', 'UF_TRansp', Trim(frmTabelas.tbl_Pessoa.FieldByName('ENP_ESTADO_A').AsString));
        if Length(AllTrim(frmTabelas.tbl_Pessoa.FieldByName('PES_RG_IE_A').AsString)) > 0 then
            Ini.WriteString('NF', 'IE_TRansp', AllTrim(frmTabelas.tbl_Pessoa.FieldByName('PES_RG_IE_A').AsString))
        else
            Ini.WriteString('NF', 'IE_TRansp', '');
        Ini.WriteString('NF', 'Especie_transp', Trim(txtEspecie.Text));
        Ini.WriteString('NF', 'Marca_transp', Trim(txtMarca.Text));
        Ini.WriteString('NF', 'numero_transp', AllTrim(mskCodigoTransportador.Text));

        try
           Ini.WriteString('NF', 'Quantidade_transp', floattostrf(strtofloat(AllTrim(mskQuantidadeVolumes.Text)),ffnumber,12,2));
        except
           Ini.WriteString('NF', 'Quantidade_transp', AllTrim(mskQuantidadeVolumes.Text));
        end;
        try
           Ini.WriteString('NF', 'Peso_bruto_transp', floattostrf(strtofloat(AllTrim(mskPesoBruto.Text)),ffnumber,12,2));
        except
           Ini.WriteString('NF', 'Peso_bruto_transp', AllTrim(mskPesoBruto.Text));
        end;
        try
           Ini.WriteString('NF', 'Peso_liquido_transp', floattostrf(strtofloat(AllTrim(mskPesoLiquido.Text)),ffnumber,12,2));
        except
           Ini.WriteString('NF', 'Peso_liquido_transp', AllTrim(mskPesoLiquido.Text));
        end;

        Ini.WriteString('NF', 'VENDEDOR', AllTrim(mskIndicador.Text));
        Ini.WriteString('NF', 'PEDIDO', AllTrim(mskOrcamento.Text));
        Ini.WriteString('NF', 'PEDIDO_CLI', AllTrim(mskPedido.Text));
        Ini.WriteString('NF', 'Numero_NF2', AllTrim(mskCodNotaFiscal.Text));

        Troca_Maskara(false);

        Ini.Free;

        try
           ImpNf;
        finally
           beep;
        end;

    except
        Troca_Maskara(false);

        Application.MessageBox('Ocorreu um erro na impress?o. Verifique!', 'Autocom Plus: Erro do sistema', 16);
    end;
end;

procedure TfrmNota.Insere_Dados_StringGrid;
var s_Quantidade: String;
    s_Preco: String;
begin
    mskQuantidade.EditMask := '99999999,999;1; ';
    mskPreco.EditMask:='9999999999,99;1; ';
    s_Quantidade := mskQuantidade.Text;
    s_Preco:=mskPreco.text;
    mskQuantidade.Text := FormataNumero(s_Quantidade, 8, 3);
    mskPreco.Text := FormataNumero(s_Preco, 10, 2);
    mskQuantidade.EditMask := '99999999,999;0; ';
    mskPreco.EditMask:='9999999999,99;0; ';

    // Codigo do Produto - Col = 1
    grdStringGrid.Cells[1, grdStringGrid.RowCount-1] := frmTabelas.tbl_Produto.FieldByName('CODIGOPRODUTO').AsString;

    // Nome do Produto - Col = 2
    grdStringGrid.Cells[2, grdStringGrid.RowCount-1] := frmTabelas.tbl_Produto.FieldByName('NOMEPRODUTO').AsString;

    // Quantidade - Col = 3
    grdStringGrid.Cells[3, grdStringGrid.RowCount-1] := FloatToStr(StrToFloat(FormataNumero(s_Quantidade, 8, 3)));

    // Pre?o - Col = 4
    grdStringGrid.Cells[4, grdStringGrid.RowCount-1] := FloattoStrF(strtofloat(FormataNumero(s_Preco, 10, 2)),ffnumber,10,2);

    // Aliquota ICMS - Col = 5
    //Este ? o campo de aliquota de ICMS da tabela ICMSPRODUTO
    grdStringGrid.Cells[5, grdStringGrid.RowCount-1] := s_aliquota_ICMSPRODUTO;

    // Aliquota IPI - Col = 6
    grdStringGrid.Cells[6, grdStringGrid.RowCount-1] := frmTabelas.tbl_Produto.FieldByName('ALIQUOTAIPI').AsString;

    // Peso Bruto - Col = 7
    grdStringGrid.Cells[7, grdStringGrid.RowCount-1] := frmTabelas.tbl_Produto.FieldByName('PESOBRUTO').AsString;

    // Peso Liquido - Col = 8
    grdStringGrid.Cells[8, grdStringGrid.RowCount-1] := frmTabelas.tbl_Produto.FieldByName('PESOLIQUIDO').AsString;

    // C?digo Situacao Tributaria - Col = 9
    grdStringGrid.Cells[9, grdStringGrid.RowCount-1] := frmTabelas.tbl_Produto.FieldByName('CODIGOSITUACAOTRIBUTARIA').AsString;

    // Situacao Tributaria - Col = 10
    grdStringGrid.Cells[10, grdStringGrid.RowCount-1] := frmTabelas.tbl_Produto.FieldByName('SITUACAOTRIBUTARIA').AsString;

    // Processa os valores do StringGrid e atualiza os resultados nos MaskEdits
    Processa_Valores_StringGrid;

    Retira_Virgula_MaskEdit;

    // Adiciona uma linha em branco no StringGrid
    grdStringGrid.RowCount := (grdStringGrid.RowCount + 1);

    mskProduto.Clear;
    Label17.Caption := '';
    cmbPreco.Clear;
    mskPreco.Text:= '         000';
    mskQuantidade.Clear;
    mskProduto.SetFocus;
end;

procedure TfrmNota.Limpa_Campos;
begin
    SetLength(ad_Preco, 0);
    SetLength(ad_CondicaoPagamento, 0);

    b_Sair := true;
    s_Filtro := '';

    s_CodigoNotaFiscal := 'null';
    s_CodigoPedido := 'null';
    s_CodigoCondicaoPagamento := 'null';
    s_CodigoVendedor := 'null';
    s_CodigoCliente := 'null';
    s_CodigoFornecedor := 'null';
    s_CodigoTransportadora := 'null';

    // Setando os componentes agrupados no form
    mskCodNotaFiscal.Clear;
    Label3.Caption := '';
    mskCFOP.Clear;
    mskOrcamento.Clear;
    Monta_Condicao_Pagamento;
    mskSerie.Clear;
    mskIndicador.Clear;
    Label6.Caption := '';
    Label7.Caption := 'Destinat?rio/Remetente:';
    mskDestinatarioRemetente.Clear;
    Label8.Caption := '';
    Label9.Caption := 'Pedido do Destinat?rio/Remetente:';
    mskPedido.Clear;
    datDataEmissao.Date := Date;
    Label11.Caption := 'Data da Sa?da/Entrada:';
    datDataEntradaSaida.Date := Date;
    datHoraSaida.Time := Time;
    mskProduto.Clear;
    Label17.Caption := '';
    cmbPreco.Clear;
    mskQuantidade.Clear;
    mskAcrescimo.Text   := '         000';
    mskDesconto.Text    := '         000';
    mskPreco.Text       := '         000';

    // Setando os componentes agrupados no tstrPageControl (tabCalculoImposto)
    mskBaseCalculoICMS.Text     := '         000';
    mskValorICMS.Text           := '         000';
    mskBaseCalculoICMSSub.Text  := '         000';
    mskValorICMSSub.Text        := '         000';
    mskValorTotalProdutos.Text  := '         000';
    mskValorTotalIPI.Text       := '         000';
    mskValorSeguro.Text         := '         000';
    mskOutrasDespesas.Text      := '         000';
    mskValorFrete.Text          := '         000';
    mskValorTotalNota.Text      := '         000';

    // Setando os componentes agrupados no tstrPageControl (tabTransportador)
    mskCodigoTransportador.Clear;
    txtNomeTransportador.Clear;
    cmbFretePorConta.ItemIndex := -1;
    txtPlacaVeiculo.Clear;
    cmbUf.ItemIndex := -1;
    mskQuantidadeVolumes.Text := '       0000';
    txtEspecie.Clear;
    txtMarca.Clear;
    mskNumero.Text      := '0000000000000';
    mskPesoBruto.Text   := '       0000';
    mskPesoLiquido.Text := '       0000';

    // Alinhando os componentes no form
    mskDestinatarioRemetente.Left := 143;
    cmdConsultaDestinatarioRemetente.Left := 234;
    Label8.Left := 260;
    Label8.Width := 268;
    Label9.Left := 539;
    mskPedido.Left := 736;

    mskCFOP.Enabled := true;
    cmdConsultaCFOP.Enabled := true;

    // Desabilitando os componentes agrupados no form
    mskOrcamento.Enabled := false;
    cmdConsultaOrcamento.Enabled := false;
    cmbCondicaoPagamento.Enabled := false;
    mskSerie.Enabled := false;
    mskIndicador.Enabled := false;
    cmdConsultaIndicador.Enabled := false;
    mskDestinatarioRemetente.Enabled := false;
    cmdConsultaDestinatarioRemetente.Enabled := false;
    mskPedido.Enabled := false;
    datDataEmissao.Enabled := false;
    datDataEntradaSaida.Enabled := false;
    datHoraSaida.Enabled := false;
    mskProduto.Enabled := false;
    cmdConsultaProduto.Enabled := false;
    cmbPreco.Enabled := false;
    cmbPreco.Style := csDropDownList;
    mskQuantidade.Enabled := false;
    mskPreco.readonly:=true;

    dgrdDBGrid.DataSource.Enabled := false;
    dgrdDBGrid.ShowHint := true;

    dgrdDBGrid.Visible := true;
    grdStringGrid.Visible := false;

    Formata_StringGrid;

    // Habilitando os componentes do tstrPageControl (tabCalculoImposto)
    mskValorSeguro.Enabled := true;
    mskOutrasDespesas.Enabled := true;
    mskValorFrete.Enabled := true;

    // Habilitando os componentes do tstrPageControl (tabTransportador)
    mskCodigoTransportador.Enabled := true;
    cmdConsultaCodigoTransportador.Enabled := true;
    txtNomeTransportador.Enabled := true;
    cmbFretePorConta.Enabled := true;
    txtPlacaVeiculo.Enabled := true;
    cmbUf.Enabled := true;
    mskQuantidadeVolumes.Enabled := true;
    mskNumero.Enabled := true;
    mskPesoBruto.Enabled := true;
    mskPesoLiquido.Enabled := true;
    txtEspecie.Enabled := true;
    txtMarca.Enabled := true;

    // Desabilitando os botoes no form
    cmdGravar.Enabled := false;
    cmdImprimir.Enabled := false;
    cmdCancelarNotaFiscal.Enabled := false;

    // Preparando para proxima utilizacao
    tstrPageControl.ActivePageIndex := 0;

    optEntrada.Enabled := true;
    optSaida.Enabled := true;
    mskCodNotaFiscal.Enabled := true;
    cmdConsultaNotaFiscal.Enabled := true;
end;

procedure TfrmNota.Log(s_String: String);
{ Procedure que gera o log

  A procedure TFNota.Log cria um log, em formato TXT, no mesmo diretorio do programa
  com os modulos acessados.
  Isso facilita a depuracao de algum eventual BUG no sistema.
}
var LogFile: TextFile;
begin
    AssignFile(LogFile, ExtractFilePath(Application.ExeName) + 'logs\NF_'+formatdatetime('yyyymmdd',date)+'.log');

    if not FileExists(ExtractFilePath(Application.ExeName) + 'logs\NF_'+formatdatetime('yyyymmdd',date)+'.log') then
        Rewrite(LogFile)
    else
        Reset(LogFile);

    Append(LogFile);
    Writeln(LogFile, DateTimeToStr(now) + ' - ' + s_String);
    Flush(LogFile);
    CloseFile(LogFile);
end;

procedure TfrmNota.Monta_Condicao_Pagamento();
begin
    Executa_SQL(frmTabelas.tbl_CondicaoPagamento, 'SELECT COUNT(*) FROM CondicaoPagamento');
    SetLength(ad_CondicaoPagamento, frmTabelas.tbl_CondicaoPagamento.Fields[0].AsInteger);

    Executa_SQL(frmTabelas.tbl_CondicaoPagamento, 'SELECT * FROM CondicaoPagamento');
    if frmTabelas.tbl_CondicaoPagamento.RecordCount > 0 then
    begin
        cmbCondicaoPagamento.Clear;
        while not frmTabelas.tbl_CondicaoPagamento.Eof do
        begin
            cmbCondicaoPagamento.Items.Add(frmTabelas.tbl_CondicaoPagamento.FieldByName('CONDICAOPAGAMENTO').AsString);
            ad_CondicaoPagamento[frmTabelas.tbl_CondicaoPagamento.RecNo - 1] := frmTabelas.tbl_CondicaoPagamento.FieldByName('CODIGOCONDICAOPAGAMENTO').AsInteger;
            frmTabelas.tbl_CondicaoPagamento.Next;
        end;
    end;

    frmTabelas.tbl_CondicaoPagamento.Close;
end;

procedure TfrmNota.Processa_Valores_DBGrid;
begin
    log('Processando valores do DBGRID');
    db_BaseCalculoICMS := 0;
    db_ValorICMS := 0;
    db_ValorTotalProdutos := 0;
    db_ValorTotalIPI := 0;
    db_PesoBruto := 0;
    db_PesoLiquido := 0;

    if optEntrada.Checked then
    begin // Nota Fiscal de Entrada
        frmTabelas.tbl_ProdutoPedidoCompra.First;
        while not frmTabelas.tbl_ProdutoPedidoCompra.Eof do
        begin
           if trim(frmTabelas.tbl_NaturezaOperacao.fieldbyname('TRIBUTAICMS').Asstring)='T' then
              begin
                 if frmTabelas.tbl_ProdutoPedidoCompraALIQUOTAICMS.AsFloat > 0 then
                    begin
                       db_BaseCalculoICMS := db_BaseCalculoICMS + (frmTabelas.tbl_ProdutoPedidoCompraQUANTIDADE.AsFloat * frmTabelas.tbl_ProdutoPedidoCompraPRECO.AsFloat);
                       db_ValorICMS := (db_BaseCalculoICMS * (frmTabelas.tbl_ProdutoPedidoCompraALIQUOTAICMS.AsFloat / 100));
                       ICMS_Frete := (frmTabelas.tbl_ProdutoPedidoCompraALIQUOTAICMS.AsFloat / 100);
                    end;
              end;

           db_ValorTotalProdutos := db_ValorTotalProdutos + (frmTabelas.tbl_ProdutoPedidoCompraQUANTIDADE.AsFloat * frmTabelas.tbl_ProdutoPedidoCompraPRECO.AsFloat);

           if trim(frmTabelas.tbl_NaturezaOperacao.fieldbyname('TRIBUTAIPI').Asstring)='T' then
              begin
                 if frmTabelas.tbl_ProdutoPedidoCompraALIQUOTAIPI.AsFloat > 0 then
                   db_ValorTotalIPI := db_ValorTotalIPI + (frmTabelas.tbl_ProdutoPedidoCompraQUANTIDADE.AsFloat * frmTabelas.tbl_ProdutoPedidoCompraPRECO.AsFloat * frmTabelas.tbl_ProdutoPedidoCompraALIQUOTAIPI.AsFloat / 100);
              end;

           db_PesoBruto := db_PesoBruto + (frmTabelas.tbl_ProdutoPedidoCompraQUANTIDADE.AsFloat * frmTabelas.tbl_ProdutoPedidoCompraPESOBRUTO.AsFloat);
           db_PesoLiquido := db_PesoLiquido + (frmTabelas.tbl_ProdutoPedidoCompraQUANTIDADE.AsFloat * frmTabelas.tbl_ProdutoPedidoCompraPESOLIQUIDO.AsFloat);

           frmTabelas.tbl_ProdutoPedidoCompra.Next;
        end;
        frmTabelas.tbl_ProdutoPedidoCompra.First;
    end;

    if optSaida.Checked then
    begin // Nota Fiscal de Saida
        frmTabelas.tbl_ProdutoPedidoVenda.First;
        while not frmTabelas.tbl_ProdutoPedidoVenda.Eof do
        begin
           if trim(frmTabelas.tbl_NaturezaOperacao.fieldbyname('TRIBUTAICMS').Asstring)='T' then
              begin
                 if frmTabelas.tbl_ProdutoPedidoVendaALIQUOTAICMS.AsFloat > 0 then
                    begin
                       db_BaseCalculoICMS := db_BaseCalculoICMS + (frmTabelas.tbl_ProdutoPedidoVendaQUANTIDADE.AsFloat * frmTabelas.tbl_ProdutoPedidoVendaPRECO.AsFloat);
                       db_ValorICMS := (db_BaseCalculoICMS * (frmTabelas.tbl_ProdutoPedidoVendaALIQUOTAICMS.AsFloat / 100) );
                       ICMS_Frete := (frmTabelas.tbl_ProdutoPedidoVendaALIQUOTAICMS.AsFloat / 100);
                    end;
              end;
            db_ValorTotalProdutos := db_ValorTotalProdutos + (frmTabelas.tbl_ProdutoPedidoVendaQUANTIDADE.AsFloat * frmTabelas.tbl_ProdutoPedidoVendaPRECO.AsFloat);

           if trim(frmTabelas.tbl_NaturezaOperacao.fieldbyname('TRIBUTAIPI').Asstring)='T' then
              begin
                 if frmTabelas.tbl_ProdutoPedidoCompraALIQUOTAIPI.AsFloat > 0 then
                    db_ValorTotalIPI := db_ValorTotalIPI + (frmTabelas.tbl_ProdutoPedidoVendaQUANTIDADE.AsFloat * frmTabelas.tbl_ProdutoPedidoVendaPRECO.AsFloat * frmTabelas.tbl_ProdutoPedidoCompraALIQUOTAIPI.AsFloat / 100);
              end;

            db_PesoBruto := db_PesoBruto + (frmTabelas.tbl_ProdutoPedidoVendaQUANTIDADE.AsFloat * frmTabelas.tbl_ProdutoPedidoVendaPESOBRUTO.AsFloat);
            db_PesoLiquido := db_PesoLiquido + (frmTabelas.tbl_ProdutoPedidoVendaQUANTIDADE.AsFloat * frmTabelas.tbl_ProdutoPedidoVendaPESOLIQUIDO.AsFloat);

            frmTabelas.tbl_ProdutoPedidoVenda.Next;
        end;
        frmTabelas.tbl_ProdutoPedidoVenda.First;
    end;

    // calcula o ICMS do frete na nota fiscal. juntamento com  os descontos e acrescimos do pedido
    mskBaseCalculoICMS.Text := FormataNumero(FloatToStr(db_BaseCalculoICMS+
                               strtofloat(FormataNumero(AllTrim(mskValorFrete.Text), 10, 2)) -
                               strtofloat(FormataNumero(AllTrim(mskDesconto.Text), 10, 2)) +
                               strtofloat(FormataNumero(AllTrim(mskAcrescimo.Text), 10, 2))
                               ), 10, 2);
    mskValorICMS.Text := FormataNumero(FloatToStr(db_ValorICMS+
                         (strtofloat(FormataNumero(AllTrim(mskValorFrete.Text), 10, 2))*ICMS_Frete) -
                         (strtofloat(FormataNumero(AllTrim(mskDesconto.Text), 10, 2))*ICMS_Frete) +
                         (strtofloat(FormataNumero(AllTrim(mskAcrescimo.Text), 10, 2))*ICMS_Frete)
                         ), 10, 2);

    db_ValorTotalProdutos := db_ValorTotalProdutos +
                            (strtofloat(FormataNumero(AllTrim(mskAcrescimo.Text), 10, 2)))-
                            (strtofloat(FormataNumero(AllTrim(mskDesconto.Text), 10, 2)));


//    mskBaseCalculoICMS.Text := FormataNumero(FloatToStr(db_BaseCalculoICMS), 10, 2);
//    mskValorICMS.Text := FormataNumero(FloatToStr(db_ValorICMS), 10, 2);
    mskValorTotalProdutos.Text := FormataNumero(FloatToStr(db_ValorTotalProdutos), 10, 2);
    mskValorTotalIPI.Text := FormataNumero(FloatToStr(db_ValorTotalIPI), 10, 2);
    mskPesoBruto.Text := FormataNumero(FloatToStr(db_PesoBruto), 8, 2);
    mskPesoLiquido.Text := FormataNumero(FloatToStr(db_PesoLiquido), 8, 2);

    mskValorTotalNota.Text := FormataNumero(FloatToStr(db_ValorTotalProdutos +
                                                       db_ValorTotalIPI +
                                                       strtofloat(FormataNumero(AllTrim(mskValorSeguro.Text), 10, 2))+
                                                       strtofloat(FormataNumero(AllTrim(mskOutrasDespesas.Text), 10, 2))+
                                                       strtofloat(FormataNumero(AllTrim(mskValorFrete.Text), 10, 2))), 10, 2);

    Retira_Virgula_MaskEdit;
end;

procedure TfrmNota.Processa_Valores_StringGrid;
var
    i: Integer;
    s_Quantidade: String;
    s_Preco: String;
    s_AliquotaICMS: String;
    s_AliquotaIPI: String;
    s_PesoBruto: String;
    s_PesoLiquido: String;
begin
    db_BaseCalculoICMS := 0;
    db_ValorICMS := 0;
    db_ValorTotalProdutos := 0;
    db_ValorTotalIPI := 0;
    db_PesoBruto := 0;
    db_PesoLiquido := 0;

    for i := 1 to (grdStringGrid.RowCount - 1) do
    begin
        s_Quantidade := grdStringGrid.Cells[3, i];
        s_Preco := grdStringGrid.Cells[4, i];
        s_AliquotaICMS := grdStringGrid.Cells[5, i];
        s_AliquotaIPI := grdStringGrid.Cells[6, i];
        s_PesoBruto := grdStringGrid.Cells[7, i];
        s_PesoLiquido := grdStringGrid.Cells[8, i];

        if (AllTrim(s_Quantidade) <> '')    and
           (AllTrim(s_Preco) <> '')         and
           (AllTrim(s_AliquotaICMS) <> '')  and
           (AllTrim(s_AliquotaIPI) <> '')   and
           (AllTrim(s_PesoBruto) <> '')     and
           (AllTrim(s_PesoLiquido) <> '') then
        begin
           if trim(frmTabelas.tbl_NaturezaOperacao.fieldbyname('TRIBUTAICMS').Asstring)='T' then
              begin
                 db_BaseCalculoICMS := db_BaseCalculoICMS + (StrToFloat(s_Quantidade) * StrToFloat(s_Preco));
                 db_ValorICMS := (db_BaseCalculoICMS*(StrToFloat(s_AliquotaICMS)/100) );
              end;

           db_ValorTotalProdutos := db_ValorTotalProdutos + (StrToFloat(s_Quantidade) * StrToFloat(s_Preco));

           if trim(frmTabelas.tbl_NaturezaOperacao.fieldbyname('TRIBUTAIPI').Asstring)='T' then
              begin
                 db_ValorTotalIPI := db_ValorTotalIPI + (StrToFloat(s_Quantidade) * StrToFloat(s_Preco) * (StrToFloat(s_AliquotaIPI) / 100));
              end;

            db_PesoBruto := db_PesoBruto + (StrToFloat(s_Quantidade) * StrToFloat(s_PesoBruto));
            db_PesoLiquido := db_PesoLiquido + (StrToFloat(s_Quantidade) * StrToFloat(s_PesoLiquido));
        end;
    end;

    mskBaseCalculoICMS.Text := FormataNumero(FloatToStr(db_BaseCalculoICMS), 10, 2);
    mskValorICMS.Text := FormataNumero(FloatToStr(db_ValorICMS), 10, 2);
    mskValorTotalProdutos.Text := FormataNumero(FloatToStr(db_ValorTotalProdutos), 10, 2);
    mskValorTotalIPI.Text := FormataNumero(FloatToStr(db_ValorTotalIPI), 10, 2);
    mskPesoBruto.Text := FormataNumero(FloatToStr(db_PesoBruto), 8, 2);
    mskPesoLiquido.Text := FormataNumero(FloatToStr(db_PesoLiquido), 8, 2);

    mskValorTotalNota.Text := FormataNumero(FloatToStr(db_ValorTotalProdutos + db_ValorTotalIPI), 10, 2);
end;

procedure TfrmNota.Retira_Virgula_MaskEdit;
var i: Integer;
    MaskEdit: TMaskEdit;
    s_EditMask, s_NewEditMask, s_Name, s_Valor: String;
begin
    for i := 0 to (frmNota.ComponentCount - 1) do
    begin
        if frmNota.Components[i] is TMaskEdit then
        begin
            MaskEdit := frmNota.Components[i] as TMaskEdit;
            s_Name := MaskEdit.Name;
            s_Valor := MaskEdit.Text;
            s_EditMask := MaskEdit.EditMask;
            s_NewEditMask := LeftStr(s_EditMask, Pos(';', s_EditMask)) + '1; ';
            MaskEdit.EditMask := s_NewEditMask;

            if Pos(',', s_Valor) > 0 then
                MaskEdit.Text := s_Valor;

            MaskEdit.EditMask := s_EditMask;
        end;
    end;
end;

{ Altera a propriedade EditMask de um MaskEdit }
{ b_Literal = true -> Mascara com literais }
{ b_Literal = false -> Mascara sem literais }
procedure TfrmNota.Troca_Maskara(b_Literal: Boolean);
var i: Integer;
    MaskEdit: TMaskEdit;
    s_EditMask, s_NewEditMask: String;
begin
    for i := 0 to (frmNota.ComponentCount - 1) do
    begin
        if frmNota.Components[i] is TMaskEdit then
        begin
            MaskEdit := frmNota.Components[i] as TMaskEdit;

            s_EditMask := MaskEdit.EditMask;

            if b_Literal then
                s_NewEditMask := LeftStr(s_EditMask, Pos(';', s_EditMask)) + '1; '
            else
                s_NewEditMask := LeftStr(s_EditMask, Pos(';', s_EditMask)) + '0; ';

            MaskEdit.EditMask := s_NewEditMask;
        end;
    end;
end;

procedure TfrmNota.mskAcrescimoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.mskDescontoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmNota.mskprecoExit(Sender: TObject);
var s_Valor: String;
begin
    mskPreco.EditMask := '9999999999,99;1; ';
    s_Valor := mskPreco.Text;
    mskPreco.Text := FormataNumero(s_Valor, 10, 2);
    mskPreco.EditMask := '9999999999,9;0; ';
end;

procedure TfrmNota.mskloteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
    begin
        if optSaida.checked=true then
           begin
              cmbPreco.SelectAll;
              cmbPreco.SetFocus;
           end;

        if optEntrada.checked=true then
           begin
              mskPreco.SelectAll;
              mskPreco.SetFocus;
           end;
    end;
end;

end.


