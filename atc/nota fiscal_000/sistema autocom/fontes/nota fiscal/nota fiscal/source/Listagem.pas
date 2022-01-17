unit Listagem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Buttons, Grids, DBGrids;

type
  TfrmListagem = class(TForm)
    dgrdDBGrid: TDBGrid;
    cmdFechar: TBitBtn;
    cmdCadastroProdutos: TBitBtn;
    DataSource1: TDataSource;
    procedure FormActivate(Sender: TObject);
    procedure cmdCadastroProdutosClick(Sender: TObject);
    procedure cmdFecharClick(Sender: TObject);
    procedure dgrdDBGridDblClick(Sender: TObject);
    procedure dgrdDBGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    function Comando(): Boolean;
  end;

var
  frmListagem: TfrmListagem;

implementation

uses Nota, Tabelas;

{$R *.dfm}

procedure TfrmListagem.FormActivate(Sender: TObject);
begin
    SetForegroundWindow(Application.Handle);

    if frmListagem.Caption = 'Autocom PLUS - Produtos' then
        cmdCadastroProdutos.Visible := true
    else
        cmdCadastroProdutos.Visible := false;

    dgrdDBGrid.SetFocus;
end;

procedure TfrmListagem.cmdCadastroProdutosClick(Sender: TObject);
begin
    try
        frmListagem.Enabled := false;
        frmNota.Enabled := false;
        frmNota.Log('Acesso ao módulo de cadastro de produtos');

        winexec('cprodutos.exe',sw_show);

    except
        frmNota.Enabled := true;
        frmListagem.Enabled := true;
        SetForegroundWindow(Application.Handle);
        Application.MessageBox('Não foi possível carregar o módulo de cadastro de produtos.', 'Autocom PLUS', 16);
    end;
    frmNota.Enabled := true;
    frmListagem.Enabled := true;
    SetForegroundWindow(Application.Handle);
end;

procedure TfrmListagem.cmdFecharClick(Sender: TObject);
begin
    if frmListagem.Caption = 'Autocom PLUS  -  Notas Fiscais' then
        frmNota.Limpa_Campos;

    if frmListagem.Caption = 'Autocom PLUS  -  Códigos Fiscais de Operações' then
    begin
        frmNota.mskCFOP.Text := '';
        frmNota.Label3.Caption := '';
    end;

    if frmListagem.Caption = 'Autocom PLUS  -  ' + Trim(frmNota.Label4.Caption) then
    begin
        frmNota.mskOrcamento.Text := '';
        frmNota.mskIndicador.Text := '';
        frmNota.Label6.Caption := '';
        frmNota.mskDestinatarioRemetente.Text := '';
        frmNota.Label8.Caption := '';
    end;

    if frmListagem.Caption = 'Autocom PLUS  -  Indicadores' then
    begin
        frmNota.mskIndicador.Text := '';
        frmNota.Label6.Caption := '';
    end;

    if (frmListagem.Caption = 'Autocom PLUS  -  Clientes') or (frmListagem.Caption = 'Autocom PLUS  -  Fornecedores')then
    begin
        frmNota.mskDestinatarioRemetente.Text := '';
        frmNota.Label8.Caption := '';
    end;

    if frmListagem.Caption = 'Autocom PLUS  -  Produtos' then
    begin
        frmNota.mskProduto.Text := '';
        frmNota.cmbPreco.Clear;
        frmNota.mskPreco.Text:= '         000';
        frmNota.mskQuantidade.Text := '';
    end;

    if frmListagem.Caption = 'Autocom PLUS  -  Transportadoras' then
    begin
        frmNota.mskCodigoTransportador.Text := '';
        frmNota.txtNomeTransportador.Text := '';
    end;

    Close;
end;

procedure TfrmListagem.dgrdDBGridDblClick(Sender: TObject);
begin
    if Comando then Close;
end;

procedure TfrmListagem.dgrdDBGridKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        if Comando then
            Close;

    if Key = VK_ESCAPE then
        cmdFechar.Click;
end;

function TfrmListagem.Comando(): Boolean;
var i: Integer;
    s_SQL: String;
begin
    Result := true;

    // Em caso de click no botão de Consulta de Nota Fiscal
    if frmListagem.Caption = 'Autocom PLUS  -  Notas Fiscais' then
    begin

        if frmNota.optEntrada.Checked then
        begin
            if frmTabelas.tbl_NotaFiscalEntrada.RecordCount <= 0 then
            begin
                Result := false;
                exit;
            end;
            frmNota.s_CodigoNotaFiscal := frmNota.FormataNumero(frmTabelas.tbl_NotaFiscalEntrada.FieldByName('CODIGONOTAFISCALENTRADA').AsString, 8);
            frmNota.mskCodNotaFiscal.Text := frmNota.FormataNumero(frmTabelas.tbl_NotaFiscalEntrada.FieldByName('NUMERONOTA').AsString, 8);
            s_SQL := 'SELECT * FROM NotaFiscalEntrada WHERE CODIGONOTAFISCALENTRADA = ' + frmNota.s_CodigoNotaFiscal + ' AND NUMERONOTA = ' + frmNota.mskCodNotaFiscal.Text;
        end
        else
        begin
            if frmTabelas.tbl_NotaFiscalSaida.RecordCount <= 0 then
            begin
                Result := false;
                exit;
            end;
            frmNota.s_CodigoNotaFiscal := frmNota.FormataNumero(frmTabelas.tbl_NotaFiscalSaida.FieldByName('CODIGONOTAFISCALSAIDA').AsString, 8);
            frmNota.mskCodNotaFiscal.Text := frmNota.FormataNumero(frmTabelas.tbl_NotaFiscalSaida.FieldByName('NUMERONOTA').AsString, 8);
            s_SQL := 'SELECT * FROM NotaFiscalSaida WHERE CODIGONOTAFISCALSAIDA = ' + frmNota.s_CodigoNotaFiscal + ' AND NUMERONOTA = ' + frmNota.mskCodNotaFiscal.Text;
        end;

        frmNota.Botao_Cancelar;

        frmNota.Executa_SQL(frmTabelas.tbl_NotaFiscal, s_SQL);

        frmNota.Captura_Valores;

        frmNota.optEntrada.Enabled := false;
        frmNota.optSaida.Enabled := false;
        frmNota.mskCodNotaFiscal.Enabled := false;
        frmNota.cmdConsultaNotaFiscal.Enabled := false;
        frmNota.mskCFOP.Enabled := false;
        frmNota.cmdConsultaCFOP.Enabled := false;
        frmNota.mskOrcamento.Enabled := false;
        frmNota.cmdConsultaOrcamento.Enabled := false;
        frmNota.cmbCondicaoPagamento.Enabled := false;
        frmNota.mskSerie.Enabled := false;
        frmNota.mskIndicador.Enabled := false;
        frmNota.cmdConsultaIndicador.Enabled := false;
        frmNota.mskDestinatarioRemetente.Enabled := false;
        frmNota.cmdConsultaDestinatarioRemetente.Enabled := false;
        frmNota.mskPedido.Enabled := false;
        frmNota.datDataEmissao.Enabled := false;
        frmNota.datDataEntradaSaida.Enabled := false;
        frmNota.datHoraSaida.Enabled := false;
        frmNota.mskProduto.Enabled := false;
        frmNota.cmdConsultaProduto.Enabled := false;
        frmNota.cmbPreco.Enabled := false;
        frmNota.mskQuantidade.Enabled := false;

        frmNota.dgrdDBGrid.ShowHint := false;

        frmNota.mskValorSeguro.Enabled := false;
        frmNota.mskOutrasDespesas.Enabled := false;
        frmNota.mskValorFrete.Enabled := false;
        frmNota.mskCodigoTransportador.Enabled := false;
        frmNota.cmdConsultaCodigoTransportador.Enabled := false;
        frmNota.cmbFretePorConta.Enabled := false;
        frmNota.txtPlacaVeiculo.Enabled := false;
        frmNota.cmbUF.Enabled := false;
        frmNota.mskQuantidadeVolumes.Enabled := false;
        frmNota.txtEspecie.Enabled := false;
        frmNota.txtMarca.Enabled := false;
        frmNota.mskNumero.Enabled := false;
        frmNota.mskPesoBruto.Enabled := false;
        frmNota.mskPesoLiquido.Enabled := false;

        if (frmTabelas.tbl_NotaFiscal.FieldByName('CANCELADA').AsString = 'T') or (frmTabelas.tbl_NotaFiscal.FieldByName('FATURADO').AsString = 'T') then
        begin
            if frmTabelas.tbl_NotaFiscal.FieldByName('CANCELADA').AsString = 'T' then
                frmNota.Label45.Caption := 'Cancelada'
            else
                frmNota.Label45.Caption := 'Faturada';

            if frmNota.optEntrada.Checked then
            begin
                frmNota.Label45.Caption := 'Nota Fiscal de Entrada ' + frmNota.Label45.Caption;
            end
            else
            begin
                frmNota.Label45.Caption := 'Nota Fiscal de Saída ' + frmNota.Label45.Caption;
            end;

            frmNota.Botao_Gravar;

            frmNota.cmdGravar.Enabled := false;
            frmNota.cmdImprimir.Enabled := false;
            frmNota.cmdCancelarNotaFiscal.Enabled := false;
            frmNota.cmdFechar.SetFocus;
        end
        else
        begin
            frmNota.Botao_Alterar;

            frmNota.cmdGravar.Enabled := true;
            frmNota.cmdImprimir.Enabled := true;
            frmNota.cmdCancelarNotaFiscal.Enabled := true;
            frmNota.cmdImprimir.SetFocus;
        end;

        frmNota.b_Sair := false;
        exit;
    end;

    // Em caso de click no botão de Consulta de CFOP
    if frmListagem.Caption = 'Autocom PLUS  -  Códigos Fiscais de Operações' then
    begin
        if frmTabelas.tbl_NaturezaOperacao.RecordCount <= 0 then
        begin
            Result := false;
            exit;
        end;

        frmNota.mskCFOP.Text := frmNota.FormataNumero(frmTabelas.tbl_NaturezaOperacaoCODIGONATUREZAOPERACAO.AsString, 6);

        try
            frmNota.Label3.Caption := Trim(frmTabelas.tbl_NaturezaOperacao.FieldByName('NATUREZAOPERACAO').Value);

            frmNota.cmbCondicaoPagamento.Enabled := true;
            frmNota.mskSerie.Enabled := true;
            frmNota.mskIndicador.Enabled := true;
            frmNota.cmdConsultaIndicador.Enabled := true;
            frmNota.mskDestinatarioRemetente.Enabled := true;
            frmNota.cmdConsultaDestinatarioRemetente.Enabled := true;
            frmNota.mskPedido.Enabled := true;
            frmNota.datDataEmissao.Enabled := true;
            frmNota.datDataEntradaSaida.Enabled := true;
            frmNota.datHoraSaida.Enabled := true;
            frmNota.mskProduto.Enabled := true;
            frmNota.cmdConsultaProduto.Enabled := true;
            frmNota.mskQuantidade.Enabled := true;

            if frmNota.optEntrada.Checked then
            begin
                frmNota.mskDestinatarioRemetente.Left := 74;
                frmNota.cmdConsultaDestinatarioRemetente.Left := 165;
                frmNota.Label8.Left := 191;
                frmNota.Label8.Width := 345;
                frmNota.Label9.Left := 608;
                frmNota.mskPedido.Left := 736;

                frmNota.Label7.Caption := 'Fornecedor:';
                frmNota.Label9.Caption := 'Pedido do Fornecedor:';
                frmNota.Label11.Caption := 'Data da Entrada';

                frmNota.mskOrcamento.Enabled := true;
                frmNota.cmdConsultaOrcamento.Enabled := true;
                frmNota.cmbPreco.Enabled := false;
                frmNota.cmbPreco.Style := csDropDown;
                frmNota.cmbPreco.Text := 'Preço de Custo';
                frmNota.mskOrcamento.SetFocus;
            end
            else
            begin
                frmNota.mskDestinatarioRemetente.Left := 48;
                frmNota.cmdConsultaDestinatarioRemetente.Left := 139;
                frmNota.Label8.Left := 165;
                frmNota.Label8.Width := 458;
                frmNota.Label9.Left := 634;
                frmNota.mskPedido.Left := 736;

                frmNota.Label7.Caption := 'Cliente:';
                frmNota.Label9.Caption := 'Pedido do Cliente:';
                frmNota.Label11.Caption := 'Data da Saída';

                frmNota.mskOrcamento.Enabled := true;
                frmNota.cmdConsultaOrcamento.Enabled := true;
                frmNota.cmbPreco.Enabled := true;
                frmNota.cmbPreco.Style := csDropDownList;
                frmNota.cmbPreco.ItemIndex := -1;
                frmNota.mskOrcamento.SetFocus;
            end;
        except
            frmNota.mskDestinatarioRemetente.Left := 143;
            frmNota.cmdConsultaDestinatarioRemetente.Left := 234;
            frmNota.Label8.Left := 260;
            frmNota.Label8.Width := 268;
            frmNota.Label9.Left := 539;
            frmNota.mskPedido.Left := 736;

            frmNota.Label3.Caption:='Código Inválido';
            frmNota.Label7.Caption := 'Destinatário/Remetente:';
            frmNota.Label9.Caption := 'Pedido do Destinatário/Remetente:';
            frmNota.Label11.Caption := 'Data da Saída/Entrada:';
            beep;

            frmNota.mskOrcamento.Enabled := false;
            frmNota.cmdConsultaOrcamento.Enabled := false;
            frmNota.cmbCondicaoPagamento.Enabled := false;
            frmNota.mskSerie.Enabled := false;
            frmNota.mskIndicador.Enabled := false;
            frmNota.cmdConsultaIndicador.Enabled := false;
            frmNota.mskDestinatarioRemetente.Enabled := false;
            frmNota.cmdConsultaDestinatarioRemetente.Enabled := false;
            frmNota.mskPedido.Enabled := false;
            frmNota.datDataEmissao.Enabled := false;
            frmNota.datDataEntradaSaida.Enabled := false;
            frmNota.datHoraSaida.Enabled := false;
            frmNota.mskProduto.Enabled := false;
            frmNota.cmdConsultaProduto.Enabled := false;
            frmNota.mskQuantidade.Enabled := false;
            frmNota.mskCFOP.SelectAll;
            frmNota.mskCFOP.SetFocus;
        end;

        frmNota.mskOrcamento.Clear;
        frmNota.cmbCondicaoPagamento.ItemIndex := -1;
        frmNota.mskSerie.Clear;
        frmNota.mskIndicador.Clear;
        frmNota.Label6.Caption := '';
        frmNota.mskDestinatarioRemetente.Clear;
        frmNota.Label8.Caption := '';
        frmNota.mskPedido.Clear;
        frmNota.datDataEmissao.Date := Date;
        frmNota.datDataEntradaSaida.Date := Date;
        frmNota.datHoraSaida.Time := Time;
        frmNota.mskProduto.Clear;
        frmNota.Label17.Caption := '';
        frmNota.mskPreco.Text    := '         000';
        frmNota.mskQuantidade.Clear;

        frmNota.b_Sair := false;
        exit;
    end;

    // Em caso de click no botão de Consulta de Orcamento
    if frmListagem.Caption = 'Autocom PLUS  -  ' + Trim(frmNota.Label4.Caption) then
    begin
        if frmNota.optEntrada.Checked then
        begin
            if frmTabelas.tbl_PedidoCompra.RecordCount <= 0 then
            begin
                Result := false;
                exit;
            end;
            frmNota.mskOrcamento.Text := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_PedidoCompra.FieldByName('NUMEROPEDIDO').AsString), 13);

            frmNota.s_CodigoCondicaoPagamento := frmNota.AllTrim(frmTabelas.tbl_PedidoCompra.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString);

            for i := 0 to frmNota.cmbCondicaoPagamento.Items.Count do
            begin
                if frmNota.ad_CondicaoPagamento[i] = StrToInt(frmNota.s_CodigoCondicaoPagamento) then
                begin
                    frmNota.cmbCondicaoPagamento.ItemIndex := i;
                    break;
                end;
            end;

            frmNota.s_CodigoVendedor := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_PedidoCompra.FieldByName('VEN_CODVENDEDOR').AsString), 13);
            s_SQL := 'SELECT Vendedor.CODIGOVENDEDOR, Pessoa.PES_NOME_A FROM Vendedor, Pessoa WHERE Pessoa.PES_CODPESSOA = Vendedor.PES_CODPESSOA AND Vendedor.VEN_CODVENDEDOR = ' + frmNota.AllTrim(frmNota.s_CodigoVendedor);
            frmNota.Executa_SQL(frmTabelas.tbl_Pessoa, s_SQL);

            frmNota.mskIndicador.Text := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_Pessoa.FieldByName('CODIGOVENDEDOR').AsString), 13);
            frmNota.Label6.Caption := Trim(frmTabelas.tbl_Pessoa.FieldByName('PES_NOME_A').AsString);

            frmNota.s_CodigoFornecedor := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_PedidoCompra.FieldByName('FRN_CODFORNECEDOR').AsString), 13);
            s_SQL := 'SELECT Fornecedor.CODIGOFORNECEDOR, Pessoa.PES_NOME_A, EP.enp_estado_a FROM Fornecedor, Pessoa, EnderecoPessoa EP WHERE Pessoa.PES_CODPESSOA = Fornecedor.PES_CODPESSOA and Pessoa.PES_CODPESSOA = EP.PES_CODPESSOA AND Fornecedor.FRN_CODFORNECEDOR = ' + frmNota.AllTrim(frmNota.s_CodigoFornecedor);
            frmNota.Executa_SQL(frmTabelas.tbl_Pessoa, s_SQL);

            frmNota.mskDestinatarioRemetente.Text := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_Pessoa.FieldByName('CODIGOCLIENTE').AsString), 13);
            frmNota.s_UF_endereco:=Trim(frmTabelas.tbl_Pessoa.FieldByName('enp_estado_a').Asstring);
            frmNota.Label8.Caption := Trim(frmTabelas.tbl_Pessoa.FieldByName('PES_NOME_A').AsString)+' - '+frmNota.s_UF_endereco;


            frmNota.s_CodigoPedido := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_PedidoCompra.FieldByName('CODIGOPEDIDOCOMPRA').AsString), 13);


                         s_SQL := 'SELECT Produto.CODIGOPRODUTO, Produto.NOMEPRODUTO, ' +
                                    'ProdutoPedidoVenda.QUANTIDADE, ProdutoPedidoVenda.PRECO, ' +
                                    'ProdutoPedidoVenda.ALIQUOTAICMS, ProdutoPedidoVenda.ALIQUOTAIPI, ' +
                                    'Produto.PESOBRUTO, Produto.PESOLIQUIDO, ClassificacaoFiscal.CODIGOCLASSIFICACAOFISCAL, ' +
                                    'ClassificacaoFiscal.CLASSIFICACAOFISCAL, SituacaoTributaria.CODIGOSITUACAOTRIBUTARIA, ' +
                                    'SituacaoTributaria.SITUACAOTRIBUTARIA ' +
                             'FROM Produto, ProdutoPedidoCompra, ClassificacaoFiscal, SituacaoTributaria ' +
                             'WHERE ProdutoPedidoVenda.CODIGOPRODUTO = Produto.CODIGOPRODUTO ' +
                             'AND ClassificacaoFiscal.CODIGOCLASSIFICACAOFISCAL = Produto.CODIGOCLASSIFICACAOFISCAL ' +
                             'AND SituacaoTributaria.CODIGOSITUACAOTRIBUTARIA = Produto.CODIGOSITUACAOTRIBUTARIA ' +
                             'AND (ProdutoPedidoCompra.ENTREGUE <> ProdutoPedidoCompra.QUANTIDADE or ProdutoPedidoCompra.ENTREGUE is null )'+
                             'AND ProdutoPedidoVenda.CODIGOPEDIDOCOMPRA = ' + frmNota.s_CodigoPedido +
                             'ORDER BY Produto.CODIGOPRODUTO';

            frmNota.Log('Carregando produtos do pedido de venda: '+s_SQL);

            frmNota.Executa_SQL(frmTabelas.tbl_ProdutoPedidoCompra, s_SQL);

            frmNota.dgrdDBGrid.Visible := true;
            frmNota.grdStringGrid.Visible := false;

            frmNota.dgrdDBGrid.DataSource.Enabled := true;
            frmNota.dgrdDBGrid.DataSource.DataSet := frmTabelas.tbl_ProdutoPedidoCompra;
        end
        else
        begin
            if frmTabelas.tbl_PedidoVenda.RecordCount <= 0 then
            begin
                Result := false;
                exit;
            end;
            frmNota.mskOrcamento.Text := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_PedidoVenda.FieldByName('NUMEROPEDIDO').AsString), 13);
            frmNota.mskValorFrete.Text := frmNota.FormataNumero(frmTabelas.tbl_PedidoVenda.FieldByName('FRETE').AsString, 10, 2);
            frmNota.mskDesconto.Text := frmNota.FormataNumero(frmTabelas.tbl_PedidoVenda.FieldByName('Desconto').AsString, 10, 2);
            frmNota.mskAcrescimo.Text := frmNota.FormataNumero(frmTabelas.tbl_PedidoVenda.FieldByName('DespesasAcessorias').AsString, 10, 2);

            frmNota.s_CodigoCondicaoPagamento := frmNota.AllTrim(frmTabelas.tbl_PedidoVenda.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString);

            for i := 0 to frmNota.cmbCondicaoPagamento.Items.Count do
            begin
                if frmNota.ad_CondicaoPagamento[i] = StrToInt(frmNota.s_CodigoCondicaoPagamento) then
                begin
                    frmNota.cmbCondicaoPagamento.ItemIndex := i;
                    break;
                end;
            end;

            frmNota.s_CodigoVendedor := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_PedidoVenda.FieldByName('VEN_CODVENDEDOR').AsString), 13);
            s_SQL := 'SELECT Vendedor.CODIGOVENDEDOR, Pessoa.PES_NOME_A FROM Vendedor, Pessoa WHERE Pessoa.PES_CODPESSOA = Vendedor.PES_CODPESSOA AND Vendedor.VEN_CODVENDEDOR = ' + frmNota.AllTrim(frmNota.s_CodigoVendedor);
            frmNota.Executa_SQL(frmTabelas.tbl_Pessoa, s_SQL);

            frmNota.mskIndicador.Text := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_Pessoa.FieldByName('CODIGOVENDEDOR').AsString), 13);
            frmNota.Label6.Caption := Trim(frmTabelas.tbl_Pessoa.FieldByName('PES_NOME_A').AsString);

            frmNota.s_CodigoCliente := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_PedidoVenda.FieldByName('CLI_CODCLIENTE').AsString), 13);
            s_SQL := 'SELECT Cliente.CODIGOCLIENTE, Pessoa.PES_NOME_A,EP.enp_estado_a FROM Cliente, Pessoa, EnderecoPessoa EP WHERE Pessoa.PES_CODPESSOA = Cliente.PES_CODPESSOA and Pessoa.PES_CODPESSOA = EP.PES_CODPESSOA AND Cliente.CLI_CODCLIENTE = ' + frmNota.AllTrim(frmNota.s_CodigoCliente);
            frmNota.Executa_SQL(frmTabelas.tbl_Pessoa, s_SQL);


            frmNota.mskDestinatarioRemetente.Text := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_Pessoa.FieldByName('CODIGOCLIENTE').AsString), 13);
            frmNota.s_UF_endereco:=Trim(frmTabelas.tbl_Pessoa.FieldByName('enp_estado_a').Asstring);
            frmNota.Label8.Caption := Trim(frmTabelas.tbl_Pessoa.FieldByName('PES_NOME_A').AsString)+' - '+frmNota.s_UF_endereco;


            frmNota.s_CodigoPedido := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_PedidoVenda.FieldByName('CODIGOPEDIDOVENDA').AsString), 13);

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
                             'AND ProdutoPedidoVenda.CODIGOPEDIDOVENDA = ' + frmNota.s_CodigoPedido +
                             'ORDER BY Produto.CODIGOPRODUTO';
            frmNota.Log('Carregando produtos do pedido de venda: '+s_SQL);
            frmNota.Executa_SQL(frmTabelas.tbl_ProdutoPedidoVenda, s_SQL);

            frmNota.dgrdDBGrid.Visible := true;
            frmNota.grdStringGrid.Visible := false;

            frmNota.dgrdDBGrid.DataSource.Enabled := true;
            frmNota.dgrdDBGrid.DataSource.DataSet := frmTabelas.tbl_ProdutoPedidoVenda;
        end;

        // Limpa filtro de exlusao dos produtos do grid
        frmNota.s_Filtro := '';

        frmNota.cmbCondicaoPagamento.Enabled := false;
        frmNota.mskIndicador.Enabled := false;
        frmNota.cmdConsultaIndicador.Enabled := false;
        frmNota.mskDestinatarioRemetente.Enabled := false;
        frmNota.cmdConsultaDestinatarioRemetente.Enabled := false;
        frmNota.mskProduto.Enabled := false;
        frmNota.cmdConsultaProduto.Enabled := false;
        frmNota.cmbPreco.Enabled := false;
        frmNota.mskPreco.Text    := '         000';
        frmNota.mskQuantidade.Enabled := false;

        frmNota.Processa_Valores_DBGrid;

        frmNota.b_Sair := false;
        exit;
    end;

    // Em caso de click no botão de Consulta de Indicador
    if frmListagem.Caption = 'Autocom PLUS  -  Indicadores' then
    begin
        if frmTabelas.tbl_Vendedor.RecordCount <= 0 then
        begin
            Result := false;
            exit;
        end;

        frmNota.s_CodigoVendedor := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_Vendedor.FieldByName('VEN_CODVENDEDOR').AsString), 13);
        frmNota.mskIndicador.Text := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_Vendedor.FieldByName('CODIGOVENDEDOR').AsString), 13);
        frmNota.Label6.Caption := Trim(frmTabelas.tbl_Vendedor.FieldByName('PES_NOME_A').AsString);

        frmNota.b_Sair := false;
        exit;
    end;

    // Em caso de click no botão de Consulta de Destinatario / Remetente
    if (frmListagem.Caption = 'Autocom PLUS  -  Clientes') or (frmListagem.Caption = 'Autocom PLUS  -  Fornecedores') then
    begin
        if frmNota.optEntrada.Checked then
        begin// Nota de entrada
            if frmTabelas.tbl_pessoa.IsEmpty then
            begin
                Result := false;
                exit;
            end;
            frmNota.s_UF_endereco:=Trim(frmTabelas.tbl_pessoa.FieldByName('enp_estado_a').AsString);
            frmNota.Label8.Caption := Trim(frmTabelas.tbl_Pessoa.FieldByName('PES_NOME_A').AsString) +' - '+frmNota.s_UF_endereco;

            frmNota.s_CodigoFornecedor := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_Pessoa.FieldByName('FRN_CODFORNECEDOR').AsString), 13);
            frmNota.mskDestinatarioRemetente.Text := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_Pessoa.FieldByName('CODIGOFORNECEDOR').AsString), 13);
        end;

        if frmNota.optSaida.Checked then
        begin//Nota de Saida
            if frmTabelas.tbl_pessoa.IsEmpty then
            begin
                Result := false;
                exit;
            end;
            frmNota.s_UF_endereco:=Trim(frmTabelas.tbl_Pessoa.FieldByName('enp_estado_a').Asstring);
            frmNota.Label8.Caption := Trim(frmTabelas.tbl_Pessoa.FieldByName('PES_NOME_A').AsString) +' - '+frmNota.s_UF_endereco;

            frmNota.s_CodigoCliente := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_Pessoa.FieldByName('CLI_CODCLIENTE').AsString), 13);
            frmNota.mskDestinatarioRemetente.Text := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_Pessoa.FieldByName('CODIGOCLIENTE').AsString), 13);
        end;


        frmNota.b_Sair := false;
        exit;
    end;

    // Em caso de click no botão de Consulta de Produtos
    if frmListagem.Caption = 'Autocom PLUS  -  Produtos' then
    begin
        if frmTabelas.tbl_Produto.RecordCount <= 0 then
        begin
            Result := false;
            exit;
        end;

        frmNota.mskProduto.Text := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_Produto.FieldByName('CODIGOPRODUTO').AsString), 13);
        frmNota.Label17.Caption := Trim(frmTabelas.tbl_Produto.FieldByName('NOMEPRODUTO').AsString);

        frmNota.b_Sair := false;
        exit;
    end;

    // Em caso de click no botão de Consulta de Transportadras
    if frmListagem.Caption = 'Autocom PLUS  -  Transportadoras' then
    begin
        if frmTabelas.tbl_Transportadora.RecordCount <= 0 then
        begin
            Result := false;
            exit;
        end;

        frmNota.s_CodigoTransportadora := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_Transportadora.FieldByName('TRP_CODTRANSPORTADORA').AsString), 4);
        frmNota.mskCodigoTransportador.Text := frmNota.FormataNumero(frmNota.AllTrim(frmTabelas.tbl_Transportadora.FieldByName('CODIGOTRANSPORTADORA').AsString), 4);
        frmNota.txtNomeTransportador.Text := Trim(frmTabelas.tbl_Transportadora.FieldByName('PES_NOME_A').AsString);

        frmNota.b_Sair := false;
        exit;
    end;

end;

end.
