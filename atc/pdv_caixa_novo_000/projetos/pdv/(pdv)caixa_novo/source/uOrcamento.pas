//******************************************************************************
//                                                                             |
//                 UNIT UORCAMENTO (-)                                         |
//                                                                             |
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO                                      |
// File:           uOrcamento.pas                                              |
// Directory:      D:\projetos\pdv - novo\source\                              |
// Function:       ..                                                          |
// Description:    ..                                                          |
// Author:         Charles Alves                                               |
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5    |
// Compiled state: Delphi Compiled Unit: uOrcamento.dcu                        |
// Resources:      Win32 API                                                   |
// Notes:          ..                                                          |
// Revisions:                                                                  |
//                                                                             |
// 1.0.0 01/01/2001 First Version                                              |
//                                                                             |
//******************************************************************************
unit uOrcamento;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    midaslib, ImgList, AppEvnts, ExtCtrls, DB, DBClient, ActnList,
    XPStyleActnCtrls, ActnMan, Buttons, StdCtrls, Mask, ComCtrls, Grids,
    DBGrids;

type
    TfrmPDV = class(TForm)
        sbInfo: TStatusBar;
        actAcoes: TActionManager;
        actConsulta: TAction;
        actFuncoes: TAction;
        actGravar: TAction;
        actFechamento: TAction;
        actCancelaItem: TAction;
        actCancelar: TAction;
        actImprimir: TAction;
        gbItens: TGroupBox;
        pnlProdutos: TPanel;
        dsItensPedido: TDataSource;
        cdsItensPedido: TClientDataSet;
        tmrStatus: TTimer;
        pnlPedido: TPanel;
        Panel5: TPanel;
        pnlQtd: TPanel;
        Label5: TLabel;
        mskQTDE: TMaskEdit;
        Label13: TLabel;
        lblPrecoUnitario: TLabel;
        pnlOBS: TPanel;
        Label27: TLabel;
        edObservacao: TEdit;
        pnlProduto: TPanel;
        Label4: TLabel;
        mskProduto: TMaskEdit;
        lblDescricao: TLabel;
        lblFechamento: TLabel;
        cdsItensPedidoControle: TAutoIncField;
        cdsItensPedidoPedido: TFloatField;
        cdsItensPedidocodigo: TStringField;
        cdsItensPedidoDescricao: TStringField;
        cdsItensPedidoValorUnitario: TFloatField;
        cdsItensPedidoQuantidade: TFloatField;
        cdsItensPedidoObservacao: TMemoField;
        cdsItensPedidoTotal: TFloatField;
        pnlOpcoes: TPanel;
        lblOpcoes: TLabel;
        spdConsulta: TSpeedButton;
        spdGravar: TSpeedButton;
        spdCancelaItem: TSpeedButton;
        spdImprimir: TSpeedButton;
        spdFuncoes: TSpeedButton;
        spdFechamento: TSpeedButton;
        spdCancela: TSpeedButton;
        mskControle: TLabeledEdit;
        ApplicationEvents: TApplicationEvents;
        cdsItensPedidoImpresso: TStringField;
        cdsItensPedidoCasasDecimais: TIntegerField;
        ImageList: TImageList;
        Panel1: TPanel;
        lblTotalComServico: TLabel;
        Panel3: TPanel;
        Label16: TLabel;
        lblTotal: TLabel;
        cdsItensPedidoSituacao: TIntegerField;
    dbgrdItens: TDBGrid;
    Label1: TLabel;
    lblcbTabelaPreco: TLabel;
    cbTabelaPreco: TComboBox;
    lblCliente: TLabel;
    mskCliente: TLabeledEdit;
    lblVendedor: TLabel;
    mskIndicador: TMaskEdit;
    lblIndicador: TLabel;
        procedure cdsItensPedidoAfterPost(DataSet: TDataSet);
        procedure cdsItensPedidoCalcFields(DataSet: TDataSet);
        procedure FormCreate(Sender: TObject);
        procedure actFechamentoExecute(Sender: TObject);
        procedure tmrStatusTimer(Sender: TObject);
        procedure FormKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure dbgrdItensEnter(Sender: TObject);
        procedure dbgrdItensExit(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure mskProdutoKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure mskQTDEExit(Sender: TObject);
        procedure mskQTDEKeyPress(Sender: TObject; var Key: Char);
        procedure mskQTDEKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure edObservacaoKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure dbgrdItensDblClick(Sender: TObject);
        procedure actCancelaItemExecute(Sender: TObject);
        procedure dbgrdItensKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure actConsultaExecute(Sender: TObject);
        procedure actGravarExecute(Sender: TObject);
        procedure actFuncoesExecute(Sender: TObject);
        procedure actCancelarExecute(Sender: TObject);
        procedure mskControleExit(Sender: TObject);
        procedure mskIndicadorExit(Sender: TObject);
        procedure mskControleKeyPress(Sender: TObject; var Key: Char);
        procedure actImprimirExecute(Sender: TObject);
        procedure ApplicationEventsException(Sender: TObject; E: Exception);
        procedure ApplicationEventsActionExecute(Action: TBasicAction;
            var Handled: Boolean);
        procedure ApplicationEventsSettingChange(Sender: TObject;
            Flag: Integer; const Section: string; var Result: Integer);
        procedure cbUFKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure mskProdutoKeyPress(Sender: TObject; var Key: Char);
        procedure cdsItensPedidoBeforeDelete(DataSet: TDataSet);
        procedure mskProdutoEnter(Sender: TObject);
        procedure FormActivate(Sender: TObject);
        procedure tabMesasShow(Sender: TObject);
        procedure pgDadosChanging(Sender: TObject; var AllowChange: Boolean);
        procedure edObservacaoEnter(Sender: TObject);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cbTabelaPrecoChange(Sender: TObject);
    procedure cbTabelaPrecoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskClienteExit(Sender: TObject);
    procedure cbTabelaPrecoClick(Sender: TObject);
    private
        FTotalProdutos: Real;
        FPedidoAberto: Boolean;
        procedure SetTotalProdutos(const Value: Real);
        procedure SetPedidoAberto(const Value: Boolean);
    private
        { Private declarations }
        strNaturezaOperacao,
            strCodigoCondicaoPagamento,
            iTabelaPreco,
            oldTabelaPreco,
            strMascaraFechamento: string;
        ptrEditaItem, //edicao do item.
        ptrObservacao: Pointer;
            // para gravar a observação, caso esteja habilitada.
        bLancouMeio: Boolean;
        property TotalProdutos: Real read FTotalProdutos write SetTotalProdutos;
        property PedidoAberto: Boolean read FPedidoAberto write SetPedidoAberto;
        function CalculaTotalPedido(Pedido: pointer): string;
        procedure Imprime;
        procedure LimpaCabecalhoPedido;
        procedure LimpaCaptionVenda;
        procedure VerificaHabilitados;
        procedure AjustaPrecos(strTabela: string);
        procedure CarregaTabelaPreco;
    protected

        { Public declarations }
    public
        { Public declarations }
    end;

var
    frmPDV: TfrmPDV;

implementation

uses StrUtils, udmPDV, Math, uFechaNormal,
    uDadosDelivery, uBuscaProduto, uBuscaVendedor, uConsultaPedido,
    uConsultaClientes, uFuncoes, IniFiles, uDadosRestaurante, uOpcoes, urotinas,
    uDadosChequeLeitor, uQrFechamento, uCadCliente;

{$R *.dfm}

procedure TfrmPDV.cdsItensPedidoAfterPost(DataSet: TDataSet);
begin
    (dataset as tclientdataset).SaveToFile((dataset as
        tclientdataset).filename);
end;

procedure TfrmPDV.cdsItensPedidoCalcFields(DataSet: TDataSet);
begin
    //calcula o total por item.
    cdsItensPedidototal.Value := cdsItensPedidoValorUnitario.Value *
        cdsItensPedidoQuantidade.Value;
end;

procedure TfrmPDV.FormCreate(Sender: TObject);
var
    hand: thandle;
    ECF_INFO: FECF_INFO;
    InicioDia: FInicioDia;
    strAux: string;
begin
    Log('Inicializando ' + TIPO_TERMINAL + ' .');
    //armazenameto dos itens dos pedidos
    TotalProdutos := 0;
    PedidoAberto := False;
    cbtabelapreco.Visible         := strtointdef(LeINI(TIPO_TERMINAL, 'hab_precos'),0)= 1;
    lblcbTabelaPreco.Visible      := cbtabelapreco.Visible;

    if strtointdef(LeINI('oper', 'codigo', 'dados\oper.ini'), 0) = 0 then
    begin
        Application.MessageBox('Operador Inválido. Favor reiniciar o sistema',
            TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
        Application.Terminate;
    end;

    cdsItensPedido.Close;
    cdsItensPedido.FileName := ExtractFilePath(Application.ExeName) +
        'ITENS_PEDIDO.XML';

    if not FileExists(cdsItensPedido.FileName) then
        cdsItensPedido.CreateDataSet;
    cdsItensPedido.Open;
    cdsItensPedido.EmptyDataSet;
    lblTotal.Caption := CurrencyString + CalculaTotalPedido(@cdsItensPedido);

    // configura o status bar - Charles
    sbInfo.Panels[2].Text := 'Loja: ' + formatfloat('0000', LeINI('Loja',
        'LojaNum'));
    sbInfo.Panels[3].Text := 'Terminal: ' + formatfloat('0000',
        LeINI('terminal',
        'PDVNum'));
    sbInfo.Panels[4].Text := 'Operador: ' + LeINI('oper', 'nome',
        'dados\oper.ini');
    Self.Caption := Self.Caption + LeINI('OPER', 'DATA', 'dados\oper.ini');

    //inicialização das propriedades do form.
    ptrEditaItem := nil;
    ptrObservacao := nil;

    //Configuração da janela de acordo com o modo de operacao
    //coloquei vários panels para não precisar ficar movendo componentes.
    //charles.
    pnlOBS.Visible := strtointdef(leini(TIPO_TERMINAL, 'observacaoproduto'), 0)
        =
        1;
    lblTotalComServico.Visible := strtointdef(LeINI('terminal', 'usa_servico'),
        0)
        = 1;
    mskControle.EditLabel.Caption := leini(TIPO_TERMINAL, 'legenda');
    lblIndicador.Caption := LeINI(TIPO_TERMINAL, 'NOMEIND');
    bLancouMeio := False;
    iTabelaPreco := leini(TIPO_TERMINAL, 'tabelapreco');
        // no restaurante é fixo.

    strMascaraFechamento := Format(lblFechamento.Caption, [
        AnsiLowerCase(mskControle.EditLabel.Caption[Length(mskControle.EditLabel.Caption)]),
        mskControle.EditLabel.Caption, '%s']);
    Log('Carregando dll do ecf.');

    strAux := LeINI('modulos', 'dll_ECF');
    hand := LoadLibrary(PChar(straux));

    log('Carregando funçoes dll ecf.');
    @ECF_Info := GetProcAddress(hand, 'ECF_INFO');
    @InicioDia := GetProcAddress(hand, 'InicioDia');

    straux := ECF_Info(StrToInt(leini('terminal', 'ModECF')),
        StrToInt(leini('terminal', 'comECF')));
    if not TrataerroImpressora(straux, true) then
    begin //21/05/2003 - Charles. O helder pediu para abortar.
        Application.MessageBox('Não foi possível estabelecer comunicação com a impressora fiscal.'#13' Finalizando sistema.', TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
        PostMessage(Handle, WM_SYSCOMMAND, SC_CLOSE, SC_CLOSE);
    end;

    NumeroEcf := Copy(strAux, 2, 4);

    // armazena o numero do ecf para uso posterior;
    if strtointdef(NumeroECf, -1) = -1 then
        PostMessage(Handle, WM_SYSCOMMAND, SC_CLOSE, SC_CLOSE);

    sbInfo.Panels[5].Text := 'ECF :' + Copy(straux, 2, 4);
    Log('INicio de dia : ' + straux[6]);
    case straux[6] of
        '1':
            begin
                straux := InicioDia(StrToInt(leini('terminal', 'ModECF')),
                    StrToInt(leini('terminal', 'comECF')),
                    LeINI('terminal', 'hv'), LeINI('oper', 'codigo','dados\oper.ini'),
                    dmORC.FormasPagamento);
                if not TrataerroImpressora(straux, true) then
                begin
                    Application.MessageBox('Não foi possível estabelecer comunicação com a impressora fiscal.'#13' Finalizando sistema.', TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
                    PostMessage(Handle, WM_SYSCOMMAND, SC_CLOSE, SC_CLOSE);
                end;
            end;
        '2':
            begin
                Application.MessageBox('Dia Encerrado.', TITULO_MENSAGEM, MB_OK
                    +
                    MB_ICONHAND);
                FreeLibrary(hand);
                PostMessage(Handle, WM_SYSCOMMAND, SC_CLOSE, SC_CLOSE);
            end;
    end;
    log('Liberando dll ecf.');
    FreeLibrary(hand);
end;

procedure TfrmPDV.actFechamentoExecute(Sender: TObject);
var
    auxdataset: TDataSet;
    auxResp: Integer;
    tmpControle: string;
    bDireto: Boolean;
    COO: FCOO;
    hand: THandle;
    straux: string;
    i: Integer;
begin
    { DONE -oCharles -cImplementação : mudar label para recebimento para delivery e restaurante }
    if PedidoAberto then
    begin
        tmpControle := mskControle.Text;
        bDireto := True;
        if StrToFloatDef(mskControle.Text, 0) <> 0 then
        begin
            //verifica se o pedido na tela já está gravado.
            dmorc.Commit;
            auxdataset := dmORC.ConsultaPedido(mskControle.Text);
            if auxdataset.FieldByName('situacao').AsString <> 'Z' then
                actImprimirExecute(actFechamento);

            freeandnil(auxdataset);
            mskControle.Text := tmpControle;
            actGravarExecute(actFechamento);
            auxDataSet := dmORC.ConsultaDetalhePedido(mskControle.Text);
            cdsItensPedido.EmptyDataSet;
            auxdataset.Last;
            auxdataset.First;
            while not auxDataSet.Eof do
            begin
                cdsItensPedido.Insert;
                cdsItensPedidoPedido.AsString := mskControle.Text;
                cdsItensPedidocodigo.AsString :=
                    auxDataSet.FieldByName('codigoproduto').AsString;
                cdsItensPedidoDescricao.AsString :=
                    auxDataSet.FieldByName('nomeproduto').AsString;
                cdsItensPedidoValorUnitario.AsString :=
                    auxDataSet.FieldByName('preco').AsString;
                cdsItensPedidoQuantidade.AsString :=
                    auxDataSet.FieldByName('quantidade').AsString;
                cdsItensPedidoImpresso.Value :=
                    auxDataSet.FieldByName('impresso').AsString;
                cdsItensPedidoCasasDecimais.Value :=
                    auxDataSet.FieldByName('Decimais').AsInteger;
                cdsItensPedidoSituacao.Value :=
                    auxdataset.FieldByName('CANCELADO').AsInteger;
                //não esquecer de ajustar no delivery e nos outros.
                cdsItensPedido.Post;
                auxDataSet.Next;
            end;
            FreeAndNil(auxdataset);
            //caso esteja gravado, mostra a msg de confirmação de fechamento, caso contrario assume que
            //o pedido será fechado.
            if bDireto then
                auxResp := Application.MessageBox(pchar('Confirma ' +
                    copy(actFechamento.Caption, 7, 20) +
                    Format(' d%s %s ?',
                    [AnsiLowerCase(mskControle.EditLabel.Caption[Length(mskControle.EditLabel.Caption)]), mskControle.EditLabel.Caption])
                    ), TITULO_MENSAGEM, MB_YESNOCANCEL + MB_ICONQUESTION)
            else
                auxResp := IDYES;

            case auxResp of
                IDYES:
                    begin
                        auxdataset := dmORC.ConsultaPedido(mskControle.Text);
                        lblTotal.Caption := CurrencyString +
                            auxdataset.FieldByName('totalpedido').AsString;
                        strAux := ExtractFilePath(Application.ExeName) +
                            LeINI('modulos',
                            'dll_ECF');
                        hand := LoadLibrary(PChar(straux));
                        @COO := GetProcAddress(hand, 'COO');
                        cdsItensPedido.First;
                        frmFechaECF := TfrmFechaECF.Create(self);
                        frmFechaECF.NumeroECF := NumeroEcf;
                        frmFechaECF.dsItems := @cdsItensPedido;
                        log('qtd Items antes :' +
                            IntToStr(cdsItensPedido.RecordCount));

                        straux := COO(StrToInt(leini('terminal', 'ModECF')),
                            StrToInt(leini('terminal', 'comECF')), '1');
                        i := 0;
                        while straux[1] <> '@' do
                        begin
                            // corrigido para tentar algumas vezes antes de sair por erro.
                            strAux := COO(StrToInt(leini('terminal', 'ModECF')),
                                StrToInt(leini('terminal', 'comECF')), '1');
                            Inc(i);
                            if i > 2 then
                            begin
                                TrataerroImpressora(strAux);
                                Exit;
                            end;
                        end;
                        straux := Copy(straux, 2, 6);
                        LancaCupomFiscal(cdsItensPedido, mskControle.Text,
                            mskIndicador.Text,
                            Copy(COO(StrToInt(leini('terminal', 'ModECF')),
                            StrToInt(leini('terminal', 'comECF')), '1'), 2, 6),
                            NumeroEcf,Handle);
                                //alterado para acelerar a emissao dos itens. - Charles
                        frmFechaECF.TabelaPreco := iTabelaPreco;
                        frmFechaECF.Pedido := mskControle.Text;
                        frmFechaECF.ShowModal;
                        freeandnil(frmFechaECF);
                        FreeAndNil(auxdataset);
                        mskControle.Enabled := True;
                        mskIndicador.Enabled := True;
                        cdsItensPedido.EmptyDataSet;
                        LimpaCaptionVenda;
                        LimpaCabecalhoPedido;
                        mskControle.SetFocus;
                    end;
                IDNO:
                    begin
                        cdsItensPedido.EmptyDataSet;
                        LimpaCaptionVenda;
                        LimpaCabecalhoPedido;
                        mskControle.SetFocus;
                    end;
            end;
        end
    end
    else
        Application.MessageBox(pchar('Não há ' + mskControle.EditLabel.caption +
            ' em edição.'), TITULO_MENSAGEM, MB_OK + MB_ICONERROR);

end;

procedure TfrmPDV.tmrStatusTimer(Sender: TObject);
begin
    sbInfo.Panels[0].Text := datetostr(now);
    sbInfo.Panels[1].Text := FormatDateTime('hh:mm', now);
end;

procedure TfrmPDV.FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    case key of
        VK_RETURN, VK_DOWN, vk_tab:
            begin
                Perform(WM_NEXTDLGCTL, 0, 0);
                VerificaHabilitados;
                if key = VK_TAB then
                    key := 0;
            end;
        VK_UP:
            begin
                Perform(WM_NEXTDLGCTL, 1, 0);
                VerificaHabilitados;
            end;
        VK_ESCAPE:
            begin
                if ActiveControl <> nil then
                    if (ActiveControl.Parent.Name = pnlPedido.Name) then
                    begin
                        ActiveControl := nil;
                        LimpaCaptionVenda;
                        LimpaCabecalhoPedido;
                        cdsItensPedido.EmptyDataSet;
                        mskControle.SetFocus;
                    end
                    else
                    begin
                        if (ActiveControl.Parent.Name = pnlProduto.Name) or
                            (ActiveControl.Parent.Name = pnlOBS.Name) or
                            (ActiveControl.Parent.Name = pnlQtd.Name) then
                            actCancelar.Execute;
                    end;
            end;
    end;
end;

procedure TfrmPDV.dbgrdItensEnter(Sender: TObject);
begin
    KeyPreview := False;
    VerificaHabilitados;
end;

procedure TfrmPDV.dbgrdItensExit(Sender: TObject);
begin
    KeyPreview := True;
    VerificaHabilitados;
end;

{
  Procedure: TfrmPDV.CalculaTotalPedido
  Author:    charles
  Date:      11-mar-2003
  Arguments: None
  Result:    string
  Calcula o total do pedido e retorna uma string, com o formato monetário
}

function TfrmPDV.CalculaTotalPedido(Pedido: Pointer): string;
begin
    Result := FloatToStrF(FTotalProdutos, ffFixed, 18, 2);
end;

procedure TfrmPDV.FormShow(Sender: TObject);
var
    auxDataSet: TDataSet;
begin
    //carrega valores padrao para a gravacao dos pedidos.
    CarregaTabelaPreco;
    dmorc.RunSQL('SELECT CODIGONATUREZAOPERACAO FROM NATUREZAOPERACAO',
        auxDataset);
    strNaturezaOperacao :=
        auxDataset.FieldByName('CODIGONATUREZAOPERACAO').AsString;
    freeandnil(auxDataset);

    dmorc.RunSQL('SELECT CODIGOCONDICAOPAGAMENTO FROM CONDICAOPAGAMENTO',
        auxDataset);
    strCodigoCondicaoPagamento :=
        auxDataset.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString;
    freeandnil(auxDataset);
end;

procedure TfrmPDV.mskProdutoKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
var
    prdProduto: TProd;
begin
    if key = vk_return then
    begin
        if mskControle.Enabled then
        begin
            Application.MessageBox('Não há mesa ativa. Selecione uma mesa antes de continuar. ', TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
            Exit;
        end;
        prdProduto := dmORC.BuscaProduto(mskProduto.Text, iTabelaPreco);
        if prdProduto.descricao = '' then
        begin
            (Sender as TCustomEdit).SetFocus;
            //LimpaCaptionVenda;
            Application.MessageBox('Produto não cadastrado.', TITULO_MENSAGEM,
                MB_OK +
                MB_ICONINFORMATION);
            Exit;
        end
        else if prdProduto.preco = '0' then
        begin
            (Sender as TCustomEdit).SetFocus;
            lblPrecoUnitario.Caption := '';
            lblDescricao.Caption := '';
            lblPrecoUnitario.Caption := FloatToStrF(strtofloatdef('', 0),
                ffFixed, 15,
                2);
            Application.MessageBox('Produto sem preço cadastrado para a tabela de preços selecionada.', TITULO_MENSAGEM, MB_OK + MB_ICONINFORMATION);
            Exit;
        end
        else
        begin
            mskProduto.Text := prdProduto.codigo;
            lblPrecoUnitario.Caption := prdProduto.preco;
            lblDescricao.Caption := prdProduto.descricao;
            lblPrecoUnitario.Caption :=
                FloatToStrF(strtofloatdef(prdProduto.preco,
                0), ffFixed, 15, 2);
        end;
    end;
end;

procedure TfrmPDV.mskQTDEExit(Sender: TObject);
begin
    //Formata a quantidade.
    (Sender as TMaskEdit).Text := FormatFloat('0.000', StrToFloatDef((Sender as
        TMaskEdit).Text, 0));
    VerificaHabilitados;
end;

procedure TfrmPDV.mskQTDEKeyPress(Sender: TObject; var Key: Char);
begin
    //prefiro fazer o controle dessa forma. Charles.
    if key = '.' then
        key := ',';
    if not (key in ['0'..'9', #8, DecimalSeparator]) then
        key := #0;
    if (key = DecimalSeparator) and (Pos(DecimalSeparator, (Sender as
        TCustomEdit).Text) > 0) and
        (Length((Sender as TCustomEdit).Text) <> Length((Sender as
        TCustomEdit).SelText)) then
        key := #0;
end;

procedure TfrmPDV.mskQTDEKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
var
    preco: real;
    auxProd: TProd;
begin
    if key = vk_return then
    begin
        if mskControle.Enabled then
        begin
            Application.MessageBox('Não há mesa ativa. Selecione uma mesa antes de continuar. ', TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
            Exit;
        end;

        if (StrToFloatDef(mskQTDE.Text, 0) = 0) or (mskProduto.Text = '') then
        begin
            mskQTDE.SetFocus;
            Exit;
        end
        else
        begin
            // Controle de meio-a-meio.
            if Assigned(ptrObservacao) then
                cdsItensPedido.GotoBookmark(ptrObservacao);
            preco := StrToFloat(lblPrecoUnitario.Caption);
            if not (bLancouMeio) and (cdsItensPedidoQuantidade.Value = 0.5) and
                (StrToFloat(mskQTDE.Text) = 0.5) then
            begin
                case StrToIntDef(leini(TIPO_TERMINAL, 'politic_preco'), 3) of
                    1: // menor preco.
                        begin
                            preco := Min(cdsItensPedidoValorUnitario.Value,
                                StrToFloat(lblPrecoUnitario.Caption));
                            cdsItensPedido.Edit;
                            cdsItensPedidoValorUnitario.Value := preco;
                            cdsItensPedido.Post;
                        end;
                    2: // maior preco
                        begin
                            preco := Max(cdsItensPedidoValorUnitario.Value,
                                StrToFloat(lblPrecoUnitario.Caption));
                            cdsItensPedido.Edit;
                            cdsItensPedidoValorUnitario.Value := preco;
                            cdsItensPedido.Post;
                        end;
                    3: // média
                        begin
                            preco := Mean([cdsItensPedidoValorUnitario.Value,
                                StrToFloat(lblPrecoUnitario.Caption)]);
                            cdsItensPedido.Edit;
                            cdsItensPedidoValorUnitario.Value := preco;
                            cdsItensPedido.Post;
                        end;
                end;
                bLancouMeio := True;
            end
            else
                bLancouMeio := False;

            if ptrEditaItem = nil then // 12/05/2003 - Estava sempre somando!
                if cdsItensPedido.Locate('codigo', mskProduto.Text, []) then
                begin
                    ptrEditaItem := cdsItensPedido.GetBookmark;
                    mskQTDE.Text := floattostr(StrToFloat(mskQTDE.Text) +
                        cdsItensPedidoQuantidade.Value);
                end;

            if ptrEditaItem = nil then
                cdsItensPedido.Insert
            else
            begin
                //agrupa os itens pedidos.
                cdsItensPedido.GotoBookmark(ptrEditaItem);
                ptrEditaItem := nil;
                cdsItensPedido.Edit;
            end;

            auxProd := dmORC.buscaProduto(mskProduto.Text, iTabelaPreco);
            cdsItensPedidoPedido.AsString := mskControle.Text;
            cdsItensPedidocodigo.Value := auxProd.codigo;
            cdsItensPedidoDescricao.Value := auxProd.descricao;
            cdsItensPedidoValorUnitario.Value := preco;
            cdsItensPedidoCasasDecimais.Value := auxProd.decimais;
            cdsItensPedidoQuantidade.Value := StrToFloat(mskQTDE.Text);
            TotalProdutos := TotalProdutos + cdsItensPedidoTotal.AsFloat;
            cdsItensPedido.Post;
            ptrObservacao := cdsItensPedido.GetBookmark;
            mskQTDE.Text := '1' + DecimalSeparator + '000';
        end;
        if pnlOBS.Visible then
            edObservacao.SetFocus
        else
        begin
            mskProduto.SetFocus;
            mskQTDE.Text := '1' + DecimalSeparator + '000';
            mskProduto.Clear;
            lblPrecoUnitario.Caption := '0' + DecimalSeparator + '00';
        end;
    end;
end;

procedure TfrmPDV.edObservacaoKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    if key = VK_RETURN then
    begin
        //caso tenha uma observaçao para o item, utilizo o bookmark
        //que foi gravado na saida do componente qtde. - charles
        if mskControle.Enabled then
        begin
            Application.MessageBox('Não há mesa ativa. Selecione uma mesa antes de continuar. ', TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
            Exit;
        end;

        if (edObservacao.Text <> '') and (ptrObservacao <> nil) then
        begin
            cdsItensPedido.GotoBookmark(ptrObservacao);
            cdsItensPedido.Edit;
            cdsItensPedidoObservacao.Value := edObservacao.Text;
            cdsItensPedido.Post;
            ptrObservacao := nil;
            edObservacao.Clear;
        end;
        mskProduto.Clear;
        lblDescricao.Caption := '';
        lblPrecoUnitario.Caption := '0' + DecimalSeparator + '00';
        mskProduto.SetFocus;
    end;
end;

procedure TfrmPDV.dbgrdItensDblClick(Sender: TObject);
begin
    //  ptrEditaItem := cdsItensPedido.GetBookmark;
    //  //guarda a posicao do registro atual.
    //  if ptrEditaItem <> nil then
    //  begin
    //    mskProduto.SetFocus;
    //    mskProduto.Text := cdsItensPedidocodigo.Value;
    //    mskQTDE.Text := cdsItensPedidoQuantidade.Text;
    //    lblPrecoUnitario.Caption := cdsItensPedidoValorUnitario.AsString;
    //    lblDescricao.Caption := cdsItensPedidoDescricao.Value;
    //    TotalProdutos := TotalProdutos - cdsItensPedidoTotal.Value;
    //  end;
end;

procedure TfrmPDV.actCancelaItemExecute(Sender: TObject);
var
    i: Integer;
    auxTotalItem: Real;
begin
    if PedidoAberto then
    begin
        if dbgrdItens.SelectedRows.Count = 0 then
            dbgrdItens.SetFocus
        else
            for i := 1 to dbgrdItens.SelectedRows.Count do
            begin
                if
                    Application.MessageBox(PChar('Confirma o cancelamento deste item?'#13 +
                    'Produto : ' + cdsItensPedidoDescricao.Value),
                        TITULO_MENSAGEM,
                    MB_YESNO + MB_ICONQUESTION
                    ) = idyes then
                    dbgrdItens.DataSource.DataSet.Edit;
                dbgrdItens.DataSource.DataSet.FieldByName('situacao').Value :=
                    1;
                auxTotalItem :=
                    dbgrdItens.DataSource.DataSet.FieldByName('total').AsFloat;
                dbgrdItens.DataSource.DataSet.post;
                TotalProdutos := TotalProdutos - auxTotalItem;
                ptrEditaItem := nil;
                ptrObservacao := nil;
                mskProduto.SetFocus;
            end;
    end
    else
        Application.MessageBox(pchar('Não há ' + mskControle.EditLabel.caption +
            ' em edição.'), TITULO_MENSAGEM, MB_OK + MB_ICONERROR);

end;

procedure TfrmPDV.dbgrdItensKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    if (key = VK_DELETE) and (ssCtrl in shift) then
        Key := 0;
    case key of
        VK_SPACE: dbgrdItens.SelectedRows.CurrentRowSelected := True;
        VK_ESCAPE:
            begin
                if ptrEditaItem <> nil then
                begin
                    if Application.MessageBox('Cancela a edição do item?',
                        TITULO_MENSAGEM, MB_YESNO + MB_ICONQUESTION) = idyes
                            then
                    begin
                        ptrEditaItem := nil;
                        ptrObservacao := nil;
                        LimpaCaptionVenda;
                    end;
                end;
            end;
        VK_RETURN: dbgrdItensDblClick(nil);
        VK_DELETE: actCancelaItem.Execute;
    end;
end;

procedure TfrmPDV.LimpaCaptionVenda;
begin
    lblDescricao.Caption := '';
    lblPrecoUnitario.Caption := '0,00';
    lblTotal.Caption := CurrencyString + '0,00';
    mskQTDE.Text := '1' + DecimalSeparator + '000';
    edObservacao.Clear;
    mskProduto.Clear;
    lblTotalComServico.Caption := ' - '
end;

procedure TfrmPDV.actConsultaExecute(Sender: TObject);
var
    key: Word;
begin
    key := VK_RETURN;
    if mskControle.Focused then
    begin
        frmConsultaPedido := TfrmConsultaPedido.Create(Self);
        if frmconsultapedido.ShowModal = mrcancel then
        begin
             freeandnil(frmconsultapedido);
             Exit;
        end;
        if not frmConsultaPedido.qryPedido.IsEmpty then
        begin
            mskControle.Text :=
                frmConsultaPedido.qryPedido.FieldByName('Pedido').AsString;
            mskControleExit(mskControle);
            mskProduto.SetFocus;
        end;
        freeandnil(frmConsultaPedido.qryPedido);
        freeandnil(frmConsultaPedido);
    end
    else if mskIndicador.Focused then
    begin
        frmBuscaVendedor := TfrmBuscaVendedor.Create(Self);
        if frmBuscaVendedor.ShowModal = mrok then
        begin
            mskIndicador.Text :=
                frmBuscaVendedor.auxdataset.FieldByName('CODIGOVENDEDOR').AsString;
            mskIndicador.OnExit(mskIndicador);
        end;
        FreeAndNil(frmBuscaVendedor.auxdataset);
        freeandnil(frmBuscaVendedor);
    end
    else if mskProduto.Focused then
    begin
        frmConsultaProduto := TfrmConsultaProduto.Create(self);
        frmConsultaProduto.Tabela := iTabelaPreco;
        //case frmConsultaProduto.ShowModal of
        if frmConsultaProduto.ShowModal = mrok then
        begin
            mskProduto.Text :=
                frmConsultaProduto.dsListagemProdutos.FieldByName('CODIGOPRODUTO').AsString;
            FreeAndNil(frmConsultaProduto.dsListagemProdutos);
            //sempre liberará os dataset´s alocados!
            mskProduto.OnKeyDown(mskProduto, key, []);
        end;
        freeandnil(frmConsultaProduto);
    end else if mskcliente.Focused then
    begin
         frmConsultaCliente := TfrmConsultaCliente.Create(self);
         if frmConsultaCliente.ShowModal = mrok then
         begin
               mskCliente.Text := frmConsultaCliente.dsCliente.FieldByName('codigo').AsString;
               mskClienteExit(mskCliente);
               mskIndicador.SetFocus;
         end;
         FreeAndNil(frmConsultaCliente.dsCliente);
         FreeAndNil(frmConsultaCliente);
    end;
end;

procedure TfrmPDV.actGravarExecute(Sender: TObject);
var
    aux: Integer;
    auxServico: Real;
    auxdataset, auxPedido: TDataSet;
begin
    if PedidoAberto then
    begin
        aux := 0;
        DMORC.RunSQL('SELECT CLI_CODCLIENTE FROM CLIENTE WHERE CODIGOCLIENTE = 1',
            auxdataset);
        if cdsItensPedido.RecordCount > 0 then
            // quando o meliante pedir o fechamento direto, precisa gravar antes.
            if UpperCase((Sender as TComponent).Name) <>
                UpperCase('actFechamento') then
                aux := Application.MessageBox('Confirma a gravação do pedido?',
                    TITULO_MENSAGEM, MB_YESNOCANCEL + MB_ICONQUESTION)
            else
                aux := IDYES;

        auxPedido := dmORC.ConsultaPedido(mskControle.Text);
        auxServico := auxPedido.FieldByName('DESPESASACESSORIAS').AsFloat;

        if (aux = IDYES) and (UpperCase((Sender as tcomponent).Name) = uppercase(actGravar.Name)) then
          if Application.MessageBox('Deseja imprimir o orçamento?',TITULO_MENSAGEM,MB_YESNO + MB_ICONQUESTION) = IDYES then
             Imprime;

        if aux = IDYES then
        begin
            log(
                FormatDateTime('mm/dd/yyyy', StrToDate(LeINI('oper', 'data',
                'dados\oper.ini'))) + ',' +
                mskControle.Text + ',' +
                '1' + ',' +
                strNaturezaOperacao + ',' +
                strCodigoCondicaoPagamento + ',' +
                dmORC.ConsultaVen_CodigoVendedor(mskIndicador.Text) + ',' +
                iTabelaPreco + ',' +
                ' ' + ',' +
                '1' + ',' +
                '0' + ',' +
                ' ' + ',' +
                '0' + ',' +
                ' ' + ',' +
                '0' + ',' +
                inttostr(strtointdef(LEINI(TIPO_TERMINAL, 'codigo_origem'),
                    2)));
            dbgrdItens.DataSource := nil;
            dmorc.InserePedido(cdsItensPedido, //items do pedido
                FormatDateTime('mm/dd/yyyy hh:nn:ss', StrToDate(LeINI('oper',
                    'data',
                'dados\oper.ini')) + time), //Data do movimento.
                mskControle.Text, //numero do pedido
                '1',
                strNaturezaOperacao, //natureza de operaçao
                strCodigoCondicaoPagamento, //condicao pagamento
                dmORC.ConsultaVen_CodigoVendedor(mskIndicador.Text),
                iTabelaPreco,
                ' ', //Observação do delivery
                '1', // cfg_codconfig. POr enqto está fixo em 1.
                '0',
                ' ',
                floattostr(auxservico),
                //IFthen(auxPedido.FieldByName('DESPESASACESSORIAS').AsFloat > 0, dmORC.CalculaAcrescimo(PChar(@lblTotal.Caption[Length(CurrencyString)+1]),floattostr(auxServico)),  //valor da taxa do servico
                ' ', //descricao do acrescimo
                inttostr(strtointdef(LEINI(TIPO_TERMINAL, 'codigo_origem'), 2))
                // restaurante.
                );
            dmORC.Commit;
            FreeAndNil(auxdataset);
            dbgrdItens.DataSource := dsItensPedido;
            FTotalProdutos := 0;
            if strtointdef(leini('terminal', 'printgrill'), 0) = 1 then
                printgrill2(StrToInt(mskControle.Text), leini(TIPO_TERMINAL,
                    'legenda'),
                    mskIndicador.Text);

            if UpperCase((Sender as TComponent).Name) <>
                UpperCase('actFechamento') then
            begin
                cdsItensPedido.EmptyDataSet;
                LimpaCaptionVenda;
                LimpaCabecalhoPedido;
                mskControle.SetFocus;
            end;
        end;
        //caso o user responda não, apaga o pedido atual.
        //sem choro nem vela.
        if aux = mrno then
        begin
            cdsItensPedido.EmptyDataSet;
            LimpaCaptionVenda;
            LimpaCabecalhoPedido;
            mskControle.SetFocus;
        end;
    end
    else
        Application.MessageBox(pchar('Não há ' + mskControle.EditLabel.caption +
            ' em edição.'), TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
end;

procedure TfrmPDV.actFuncoesExecute(Sender: TObject);
begin
    frmFuncoes := TfrmFuncoes.Create(self);
    frmFuncoes.ShowModal;
    freeandnil(frmFuncoes);
//    tabMesasShow(tabMesas);
end;

procedure TfrmPDV.actCancelarExecute(Sender: TObject);
var
    auxDataset: TDataSet;
    strAux: string;
begin
    frmOpcoes := TfrmOpcoes.Create(SELF);
    frmOpcoes.SpeedButton2.Enabled := (not lblFechamento.Visible) and
        (pedidoaberto);
    case frmOpcoes.ShowModal of
        mrOk:
            begin
                dmorc.RunSQL('select codigopedidovenda from pedidovenda where numeropedido = ' + QuotedStr(mskControle.Text), auxDataset);
                strAux := auxDataset.Fields[0].AsString;
                if not auxdataset.IsEmpty then
                begin
                    dmorc.RunSQL('DELETE FROM PRODUTOPEDIDOVENDA WHERE CODIGOPEDIDOVENDA = ' + QuotedStr(strAux));
                    dmORC.RunSQL('DELETE FROM PEDIDOVENDA WHERE NUMEROPEDIDO = '
                        +
                        QuotedStr(mskControle.Text));
                end;
                ActiveControl := nil;
                ptrObservacao := nil;
                ptrEditaItem := nil;
                LimpaCaptionVenda;
                LimpaCabecalhoPedido;
                cdsItensPedido.EmptyDataSet;
                mskControle.SetFocus;
                dmORC.Commit;
            end;
        mrCancel:
            begin
                ActiveControl := nil;
                ptrObservacao := nil;
                ptrEditaItem := nil;
                LimpaCaptionVenda;
                LimpaCabecalhoPedido;
                cdsItensPedido.EmptyDataSet;
                mskControle.SetFocus;
            end;
    end;
    FreeAndNil(auxDataset);
    FreeAndNil(frmOpcoes);
end;

procedure TfrmPDV.LimpaCabecalhoPedido;
begin
    FTotalProdutos := 0;
    PedidoAberto   := False;
    mskControle.Clear;
    mskIndicador.Clear;
    mskCliente.Clear;
    lblVendedor.Caption  := '';
    lblCliente.Caption  := '';

    mskIndicador.Enabled := True;
    mskControle.Enabled  := True;
    mskCliente.Enabled   := TRUE;
    lblFechamento.Hide;
end;

procedure TfrmPDV.mskControleExit(Sender: TObject);
var
    auxdataset: TDataSet;
begin
    VerificaHabilitados;
    mskcontrole.Text := FormatFloat('0', StrToFloatDef(mskcontrole.Text, 0));
    ptrEditaItem := nil;
    ptrObservacao := nil;
    if not (activecontrol = nil) then
    begin
        if (((strtoint((Sender as TLabeledEdit).Text) <
            strtointdef(leini('terminal',
            'LIMITEPEDIDOMINIMO'), 1)) or
            (strtoint((Sender as TLabeledEdit).Text) >
                strtointdef(leini('terminal',
            'LIMITEPEDIDOMaximo'), 999)))) then
        begin
            if strtoint((Sender as TLabeledEdit).Text) <> 0 then
            begin
                Application.messagebox('O número informado está fora da faixa especificada', TITULO_MENSAGEM, MB_OK + MB_ICONWARNING);
                mskControle.Clear;
                mskControle.SetFocus;
            end;
            Exit;
        end;
        dmorc.Commit;
        auxDataSet := dmORC.ConsultaPedido(mskControle.Text);
        //verifica se o tipo de terminal é o mesmo.
        PedidoAberto := true;
        if not auxdataset.IsEmpty then
            if auxdataset.FieldByName('ORIGEMPEDIDO').AsString =
                inttostr(strtointdef(LEINI(TIPO_TERMINAL, 'codigo_origem'), 2))
                    then
            begin
                //verifica se o pedido já foi fechado.
                if auxdataset.FieldByName('SITUACAO').AsString = 'X' then
                begin
                    Application.MessageBox('Pedido fechado!', TITULO_MENSAGEM,
                        MB_OK +
                        MB_ICONINFORMATION);
                    LimpaCabecalhoPedido;
                    mskControle.SetFocus;
                    Exit;
                end;
            end
            else
            begin
                //caso o pedido seja de outro tipo de terminal.
                Application.MessageBox('Acesso negado.', TITULO_MENSAGEM, MB_OK
                    +
                    MB_ICONERROR);
                LimpaCabecalhoPedido;
                mskControle.SetFocus;
                Exit;
            end;
        if auxdataset.FieldByName('SITUACAO').AsString = 'Z' then
        begin
            lblFechamento.Caption := Format(strMascaraFechamento,
                [datetostr(auxdataset.FieldByName('data').AsDateTime),
                TimeToStr(auxdataset.FieldByName('data').AsDateTime)]);
            lblFechamento.Show;
        end
        else
            lblFechamento.Hide;
        mskControle.Enabled := False;
        if not auxDataSet.IsEmpty then
        begin
            mskIndicador.Text :=
                dmORC.ConsultaCodigoVendedor(auxDataSet.FieldByName('ven_codvendedor').AsString);
            mskCliente.Text := dmORC.ConsultaCodigoVendedor(auxDataSet.FieldByName('cli_codcliente').AsString);
            FreeAndNil(auxdataset);
            //puxa os dados do cliente
            mskClienteExit(mskCliente);

            //puxa os dados do indicador (vendedor)
            auxDataSet := dmORC.ConsultaVendedor(mskIndicador.Text);
            if not auxDataSet.IsEmpty then
            begin
                mskIndicador.Enabled := False;
                mskProduto.SetFocus;
            end;
            lblVendedor.Caption := auxDataSet.FieldByName('NOME').AsString;
            FreeAndNil(auxDataSet);
        end;
        FreeAndNil(auxDataSet);
        cdsItensPedido.Filtered := False;
        auxDataSet := dmORC.ConsultaDetalhePedido(mskControle.Text);
        auxDataSet.Last;
        auxDataSet.First;
        cdsItensPedido.EmptyDataSet;
        while not auxDataSet.Eof do
        begin
            cdsItensPedido.Insert;
            cdsItensPedidoPedido.AsString := mskControle.Text;
            cdsItensPedidocodigo.AsString :=
                auxDataSet.FieldByName('codigoproduto').AsString;
            cdsItensPedidoDescricao.AsString :=
                auxDataSet.FieldByName('nomeproduto').AsString;
            cdsItensPedidoValorUnitario.AsString :=
                auxDataSet.FieldByName('preco').AsString;
            cdsItensPedidoQuantidade.AsString :=
                auxDataSet.FieldByName('quantidade').AsString;
            cdsItensPedidoImpresso.Value :=
                auxDataSet.FieldByName('impresso').AsString;
            cdsItensPedidoCasasDecimais.Value :=
                auxDataSet.FieldByName('Decimais').AsInteger;
            cdsItensPedidoSituacao.Value :=
                auxDataSet.FieldByName('CANCELADO').AsInteger;
            cdsItensPedido.Post;
            TotalProdutos := TotalProdutos +
                IfThen(cdsItensPedidoSituacao.AsFloat =
                0, cdsItensPedidoTotal.asfloat, 0);
            auxDataSet.Next;
        end;
        FreeAndNil(auxdataset);
        cdsItensPedido.Filtered := True;
        mskcontrole.Text := FormatFloat('000000000000',
            strtofloatdef(mskcontrole.Text, 0));
    end;
end;

procedure TfrmPDV.mskIndicadorExit(Sender: TObject);
var
    auxdataset: TDataSet;
begin
    VerificaHabilitados;
    if not (ActiveControl = nil) then
    begin
        //if StrToIntDef(mskControle.Text, 0) <> 0 then
        begin
            auxdataset := dmORC.ConsultaVendedor(mskIndicador.Text);
            if (auxdataset.IsEmpty) or
                (auxdataset.FieldByName('ven_codvendedor').AsInteger = 0) then
            begin
                Application.messagebox(Pchar('É necessário digitar o número do(a) ' +
                    lblIndicador.Caption + ' para continuar.'),
                    TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
                mskIndicador.SetFocus;
            end
            else
            begin
                FreeAndNil(auxdataset);
                auxdataset := dmORC.ConsultaVendedor(mskIndicador.Text);
                { DONE -oCharles -cImplementação : Adicionar controle para quando o pedido já existir, e quando for restaurante. }
                mskIndicador.Enabled := auxdataset.IsEmpty;
                lblVendedor.Caption := auxdataset.FieldByName('NOME').AsString;
                FreeAndNil(auxdataset);
            end;
        end;
    end;
end;

procedure TfrmPDV.VerificaHabilitados;
var
    aux, I: Integer;
begin
    { DONE -oCharles -cImplementação : Tentar tirar o flicker dos botoes. }
    if ActiveControl <> nil then
    begin
        aux := strtointdef(LeINI('Componentes', ActiveControl.Name,
            'dados\pdv_res.ini'), 0);
        for i := 0 to actAcoes.ActionCount - 1 do
            (actAcoes.Actions[i] as TAction).Enabled := Boolean(aux and
                (actAcoes.Actions[i] as TAction).Tag);
    end;
end;

procedure TfrmPDV.mskControleKeyPress(Sender: TObject; var Key: Char);
begin
    if not (key in ['0'..'9', #8]) then
        key := #0;
    if (key = DecimalSeparator) and (Pos(DecimalSeparator, (Sender as
        TCustomEdit).Text) > 0) then
        key := #0;
end;

procedure TfrmPDV.Imprime();
var
    LeituraX: FLeituraX;
    TextoNF: FTextoNF;
    FecharCupom: FFecharCupom;
    hand: THandle;
    straux: string;
    cupom: TStrings;
    total_pedido: Real;
    i: Integer;
    txtFile: TextFile;
    auxdataset: TDataSet;
begin
    straux := ExtractFilePath(application.ExeName) + LeINI('modulos',
        'dll_ECF');
    auxdataset := dmORC.ConsultaPedido(mskControle.Text);
    total_pedido := auxdataset.FieldByName('TOTALPRODUTOS').AsFloat;
    //dados que serão impressos.
    cupom := TStringList.Create;
    cupom.Clear;
    cupom.Add('----------------------------------------');
    cupom.Add('DATA    : ' + DateToStr(NOW) + ' HORA : ' + TimeToStr(Now));
    cupom.Add(mskControle.EditLabel.Caption + ' ' + mskControle.Text);
    cupom.Add('ITEM    CODIGO           DESCRICAO');
    cupom.Add('QUANTIDADE x VALOR UNIT.     VALOR (' + CurrencyString + ')');
    cupom.Add('----------------------------------------');
    cdsItensPedido.First;
    log('Numero de itens' + IntToStr(cdsItensPedido.RecordCount));
    while not cdsItensPedido.Eof do
    begin
        cupom.Add(Format('%.3d %.13d %s ', [cdsItensPedido.RecNo,
            cdsItensPedidocodigo.AsInteger, cdsItensPedidoDescricao.Value]));
        cupom.Add(Format('%3.3fx%11.2f = ' + CurrencyString + '%17.2f',
            [cdsItensPedidoQuantidade.Value, cdsItensPedidoValorUnitario.Value,
                cdsItensPedidoTotal.Value]));
        cdsItensPedido.Next;
    end;
    cupom.Add('----------------------------------------');
    cupom.Add('');

    //Corrigido - 28/04/2003 - Puxa o acréscimo digitado
    //pelo operador. - Charles
    if auxdataset.FieldByName('DESPESASACESSORIAS').AsFloat > 0 then
        cupom.Add(Format('SERVICO     = %26.2f%', [auxdataset.FieldByName('DESPESASACESSORIAS').AsFloat]));

    //tirei a linha abaixo do if, para imprimir o total mesmo
    //se não ocorrer acréscimo. 7/6/2003 charles.
    cupom.Add(Format('TOT A PAGAR = %25.2f ',[total_pedido + auxdataset.FieldByName('DESPESASACESSORIAS').AsFloat]));
    cupom.Add('');
    cupom.Add(CenterText(lblIndicador.Caption + ' ' + mskIndicador.Text, 40));
    if auxdataset.FieldByName('NUMPESSOAS').Value > 1 then
        cupom.add( format('Total por pessoa (%2d) %17.2f', [auxdataset.FieldByName('NUMPESSOAS').AsInteger,
                   RoundUP((total_pedido + auxdataset.FieldByName('despesasacessorias').AsFloat) /
                   auxdataset.FieldByName('NUMPESSOAS').AsFloat)]));
    cupom.Add('----------' + TITULO_MENSAGEM + '----------');
    case Leini(TIPO_TERMINAL, 'Tipo_imp') of
        1: //dll ecf
            begin
                hand := LoadLibrary(PChar(STRAUX));
                @LeituraX := GetProcAddress(hand, 'LeituraX');
                @TextoNF := GetProcAddress(hand, 'TextoNF');
                @FecharCupom := GetProcAddress(hand, 'FecharCupom');
                LeituraX(StrToInt(leini('terminal', 'ModECF')),
                    StrToInt(leini('terminal', 'comECF')), '1');
                for i := 0 to cupom.Count - 1 do
                begin
                    case TextoNF(StrToInt(leini('terminal', 'ModECF')),
                        StrToInt(leini('terminal', 'comECF')),
                        cupom.Strings[i], '0')[1] of
                        '#':
                            Application.MessageBox(Pchar('Ocorreu um erro durante o envio do comando para a impressora'#13 +
                                'Erro: ' + Copy(strAux, 2, Length(straux))),
                                    TITULO_MENSAGEM,
                                MB_ICONERROR + MB_OK);
                    end;
                end;

                case FecharCupom(StrToInt(leini('terminal', 'ModECF')),
                    StrToInt(leini('terminal', 'comECF')),
                    '0', '0',
                    leini('cortesia', 'MCLinha1'),
                    leini('cortesia', 'MCLinha2'),
                    leini('cortesia', 'MCLinha3'),
                    leini('cortesia', 'MCLinha4'),
                    leini('cortesia', 'MCLinha5'),
                    leini('cortesia', 'MCLinha6'),
                    leini('cortesia', 'MCLinha7'),
                    leini('cortesia', 'MCLinha8'))[1] of
                    '#':
                        Application.MessageBox(Pchar('Ocorreu um erro durante o envio do comando para a impressora'#13 +
                            'Erro: ' + Copy(strAux, 2, Length(straux))),
                                TITULO_MENSAGEM, MB_ICONERROR + MB_OK);
                end;
            end;
        2: // windows 40 colunas
            begin
                AssignFile(txtFile,
                    dmORC.ConsultaPathImpressora(LeINI(TIPO_TERMINAL,'IMPRESSORAPEDIDO')));
                // Personalizei o erro,para qdo a impressora estiver desligada/offline
                // 30/09/2003 - Charles
                try
                   Rewrite(txtFile);
                   except
                   on e:EInOutError do
                   begin
                        Application.MessageBox(pchar('Erro durante a impressão.'#13'Erro:' +e.Message),TITULO_MENSAGEM,MB_OK + MB_ICONERROR);
                        freeandnil(auxdataset);
                        freeandnil(cupom);
                        Exit;
                   end;
                end;

                for i := 0 to cupom.Count - 1 do
                begin
                    straux := cupom.Strings[i];
                    if Length(straux) > 40 then
                    begin
                        Insert(#10#13, straux, 40);
                        cupom.Strings[i] := straux;
                    end;
                end;
                for i := 0 to cupom.Count - 1 do
                    Writeln(txtfile, cupom.Strings[i]);
                with TIniFile.Create('dados\Autocom.ini') do
                begin
                    ReadSectionValues('CORTESIA', cupom);
                    Free;
                end;
                for i := 0 to cupom.Count - 1 do
                    Writeln(txtfile, Copy(cupom.Strings[i], Pos('=',
                        cupom.Strings[i]) +
                        1, 40));
                for i := 1 to strtointdef(leini(TIPO_TERMINAL,
                    'SaltoEntreCupom'), 9) do
                    writeln(txtfile, ' ');
                closefile(txtFile);
            end;
    end;
    FreeAndNil(cupom);
    freeandnil(auxdataset);
end;

procedure TfrmPDV.actImprimirExecute(Sender: TObject);
begin
    if PedidoAberto then
    begin
        actGravarExecute(actFechamento); //Grava antes de imprimir
        frmDadosRestaurante := TfrmDadosRestaurante.Create(Self);
        frmDadosRestaurante.NumeroPedido := mskControle.Text;
        if frmDadosRestaurante.ShowModal = mrok then
        begin
            if TComponent(SENDER).Name <> actFechamento.Name then
            begin
                Imprime;
                LimpaCaptionVenda;
                LimpaCabecalhoPedido;
                cdsItensPedido.EmptyDataSet;
                mskControle.SetFocus;
                TotalProdutos := 0;
            end;
        end;
        FreeAndNil(frmDadosRestaurante);
    end
    else
        Application.MessageBox(pchar('Não há ' + mskControle.EditLabel.caption +
            ' em edição.'), TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
end;

procedure TfrmPDV.ApplicationEventsException(Sender: TObject;
    E: Exception);
begin
    log(Format(' %s %s ', [(Sender as TComponent).name, e.Message]));
    { DONE -ocharles -cArranjo técnico : Não esquecer de tirar ini antes da feira. }
    //Mostra a exceção apenas se estiver configurada.
    if strtointdef(leini(TIPO_TERMINAL, 'prolixo'), 0) = 1 then
        Application.ShowException(e);
end;

procedure TfrmPDV.ApplicationEventsActionExecute(Action: TBasicAction;
    var Handled: Boolean);
begin
    log(Action.Name);
end;

procedure TfrmPDV.ApplicationEventsSettingChange(Sender: TObject;
    Flag: Integer; const Section: string; var Result: Integer);
begin
    log('Alteração no sistema: Secao = ' + Section);
end;

procedure TfrmPDV.cbUFKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    if key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmPDV.mskProdutoKeyPress(Sender: TObject; var Key: Char);
begin
    //prefiro fazer o controle dessa forma. Charles.
    if key = '.' then
        key := ',';
    if not (key in ['0'..'9', #8]) then
        key := #0;
end;

procedure TfrmPDV.cdsItensPedidoBeforeDelete(DataSet: TDataSet);
begin
    TotalProdutos := TotalProdutos - DataSet.FieldByName('total').AsFloat;
end;

procedure TfrmPDV.SetTotalProdutos(const Value: Real);
var
    auxdataset: TDataSet;
begin
    FTotalProdutos := Value;
    //calcula o valor total do pedido para painel com o total
    // e  a etiqueta com o total + servico.
    lblTotal.Caption := CurrencyString + FloatToStrf(FTotalProdutos, ffFixed,
        18,
        2);
    if LeINI('terminal', 'usa_servico') = 1 then
    begin
        if mskControle.Text <> '' then
        begin
            auxDataset := dmORC.ConsultaPedido(mskControle.Text);
            if auxDataset.FieldByName('despesasacessorias').AsFloat > 0 then
                lblTotalComServico.Caption := 'Total + Serviço ' + CurrencyString
                    + ' '
                    + FloatToStrF(FTotalProdutos +
                    auxDataset.FieldByName('despesasacessorias').AsFloat,
                        ffFixed, 18, 2)
            else if strtointdef(LeINI('terminal', 'servico_per'), 0) > 0 then
                lblTotalComServico.Caption := 'Total + Serviço  ' +
                    CurrencyString + ' '
                    + floattostrf(FTotalProdutos +
                    dmORC.CalculaAcrescimo(floattostr(FTotalProdutos),
                        LeINI('terminal',
                    'servico_per') / 100), ffFixed, 18, 2)
            else
                lblTotalComServico.Caption := 'Total + Serviço ' + CurrencyString
                    + ' '
                    + FloatToStrF(FTotalProdutos + StrToFloat(LeINI('terminal',
                    'servico_val')) / 100, ffFixed, 18, 2);
            FreeAndNil(auxdataset);
        end;
    end;
end;

procedure TfrmPDV.mskProdutoEnter(Sender: TObject);
begin
    VerificaHabilitados;
    lblDescricao.Caption := '';
    lblPrecoUnitario.Caption := '0' + DecimalSeparator + '00';
end;

procedure TfrmPDV.FormActivate(Sender: TObject);
begin
end;

{
  Procedure: TfrmPDV.SetPedidoAberto
  Autor:    charles
  Data:      08-mai-2003
  Argumentos: const Value: Boolean
  Retorno:    None

  Quando o estado do 'pedido' é alterado, permite ou não a navegação entre as
  abas do pagecontrol.
}

procedure TfrmPDV.SetPedidoAberto(const Value: Boolean);
begin
    FPedidoAberto := Value;
end;

{
  Procedure: TfrmPDV.tabMesasShow
  Autor:    charles
  Data:      08-mai-2003
  Argumentos: Sender: TObject
  Retorno:    None
  Atualiza os ícones das mesas quando a página das mesas é exibida
}

procedure TfrmPDV.tabMesasShow(Sender: TObject);
begin
end;

{
  Procedure: TfrmPDV.lvMesasKeyDown
  Autor:    charles
  Data:      08-mai-2003
  Argumentos: Sender: TObject; var Key: Word; Shift: TShiftState
  Retorno:    None
  Seleciona o pedido selecionado
}
procedure TfrmPDV.pgDadosChanging(Sender: TObject;
    var AllowChange: Boolean);
begin
    AllowChange := not PedidoAberto;
end;

procedure TfrmPDV.edObservacaoEnter(Sender: TObject);
begin
    VerificaHabilitados;
end;

procedure TfrmPDV.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
    dmORC.IBDatabase.Close;
    Log('Finalizando ' + TIPO_TERMINAL + '.');
    CanClose := True;
end;

procedure TfrmPDV.cbTabelaPrecoChange(Sender: TObject);
var
   auxDataSet:TDataSet;
begin
      if cbTabelaPreco.Text <> '' then
      begin
            dmorc.RunSQL('SELECT CODIGOTABELAPRECO FROM TABELAPRECO WHERE TABELAPRECO = ' + QuotedStr( cbTabelaPreco.Text),auxDataset);
            if not auxDataset.IsEmpty then
            begin
                oldTabelaPreco := iTabelaPreco; //registra a tabela de precos anterior.
                iTabelaPreco   := auxDataset.FieldByName('CODIGOTABELAPRECO').Value; ;
                AjustaPrecos(iTabelaPreco);
            end
               else
                   AjustaPrecos(oldTabelaPreco);//atualiza os precos dos items vendidos
            freeandnil(auxDataset);
      end;
end;

procedure TfrmPDV.cbTabelaPrecoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key = VK_ESCAPE then
        FormKeyDown(Self,key,[]);
     if key = VK_RETURN then
        mskProduto.SetFocus;
end;

procedure TfrmPDV.mskClienteExit(Sender: TObject);
var
   auxDataSet:TDataSet;
begin
     mskCliente.Text := FormatFloat('0',StrToFloatDef(mskCliente.Text,0));
     VerificaHabilitados;
     if ActiveControl <> nil then
     begin
           auxDataSet := dmORC.ConsultaCliente(mskcliente.text);
           if auxDataSet.IsEmpty then
           begin
              if (strtofloatdef(mskcliente.Text,0) <> 0)  and (Application.MessageBox('Cliente não cadastrado.'#13'Gostaria de cadastrá-lo ?',TITULO_MENSAGEM,MB_YESNO+MB_ICONQUESTION) = id_yes) then
              begin
                   frmCadastroCliente := TfrmCadastroCliente.Create(nil);
                   frmCadastroCliente.mskCodigo.Text := mskCliente.Text;
                   if frmCadastroCliente.ShowModal = mrOk then
                   begin
                        mskCliente.Text := frmCadastroCliente.mskCodigo.Text;
                        mskClienteExit(Self);
                   end;
                   freeandnil(frmCadastroCliente);
              end;
              if mskCliente.Enabled then
                 mskCliente.SetFocus;
           end
              else
              begin
                   lblCliente.Caption := auxDataSet.FieldByName('completo').AsString;
                   mskCliente.Tag     := auxDataSet.FieldByName('CLI_CODCLIENTE').AsInteger;
                   mskCliente.Enabled := False;
              end;
     end;
     FreeAndNil(auxDataSet);
end;

procedure TfrmPDV.AjustaPrecos(strTabela: string);
var
   auxProd:TProd;
   auxDataset:TDataSet;
begin
     dbgrdItens.DataSource := nil;
     cdsItensPedido.First;
     while not cdsItensPedido.Eof do
     begin
          auxProd := dmORC.BuscaProduto(cdsItensPedidocodigo.Value,strTabela);
          if auxprod.preco <> '0' then
          begin
               cdsItensPedido.Edit;
               cdsItensPedidoValorUnitario.Value := StrToFloat(auxprod.preco);
               cdsItensPedido.Post
          end
             else
             begin
                  Application.MessageBox('Não existe preço cadastrado para este produto nesta tabela.',TITULO_MENSAGEM, MB_OK + MB_ICONINFORMATION);
                  iTabelaPreco := oldTabelaPreco;
                  dmORC.RunSQL('SELECT * FROM TABELAPRECO WHERE '+      //
                               'CODIGOTABELAPRECO = ' + oldTabelaPreco, auxDataset);// Restaura a tabela anterior.
                  cbTabelaPreco.ItemIndex := cbTabelaPreco.Items.IndexOf(auxDataset.FieldByName('TABELAPRECO').Value);
                  Freeandnil(auxDataset);
                  break;
             end;
           cdsItensPedido.Next;
     end;
     dbgrdItens.DataSource := dsItensPedido;
end;

procedure TfrmPDV.CarregaTabelaPreco;
var
   dataAux, dataAux2:TDataSet;
begin
     cbTabelaPreco.Items.Clear;
       dmORC.RunSQL('select TABELAPRECO from TABELAPRECO  order by TABELAPRECO',dataAux);
       while not dataAux.Eof do
       begin
             if (dataAux.FieldByName('TABELAPRECO').AsString <> '') and (cbTabelaPreco.Text = '') then
                cbTabelaPreco.itemindex := 1;
             cbTabelaPreco.Items.Add(dataAux.FieldByName('TABELAPRECO').Value);
             dataAux.Next;
       end;
       FreeAndNil(dataaux);
       dmORC.RunSQL('SELECT CODIGOTABELAPRECOPDV FROM CONFIGURACOESPDV',dataAux);

       if not dataAux.Fields[0].IsNull then // verifica se há configuração padrão. Caso contrario pega a primeira da lista.
          dmORC.RunSQL('SELECT TABELAPRECO FROM TABELAPRECO WHERE CODIGOTABELAPRECO = ' + dataAux.Fields[0].AsString, dataAux2)
            else
                dmORC.RunSQL('SELECT TABELAPRECO FROM TABELAPRECO ', dataAux2);
       cbTabelaPreco.ItemIndex := cbTabelaPreco.Items.IndexOf( dataAux2.Fields[0].AsString);
       FreeAndNil(dataaux);
       FreeAndNil(dataaux2);
       cbTabelaPrecoChange(nil); // é necessário para setar a variável itabelapreco
                                 //quando o form é criado. Charles.
end;


procedure TfrmPDV.cbTabelaPrecoClick(Sender: TObject);
begin
       //
end;

end.
//******************************************************************************
//*                          End of File uOrcamento.pas                        |
//******************************************************************************
