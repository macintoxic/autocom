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
    DBGrids, DBTables;

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
        dsItensPedido: TDataSource;
        cdsItensPedido: TClientDataSet;
        tmrStatus: TTimer;
        pnlPedido: TPanel;
        lblVendedor: TLabel;
        lblIndicador: TLabel;
        mskIndicador: TMaskEdit;
        lblFechamento: TLabel;
        lblcbTabelaPreco:TLabel;
        cdsItensPedidoControle: TAutoIncField;
        cdsItensPedidoPedido: TFloatField;
        cdsItensPedidocodigo: TStringField;
        cdsItensPedidoDescricao: TStringField;
        cdsItensPedidoValorUnitario: TFloatField;
        cdsItensPedidoQuantidade: TFloatField;
        cdsItensPedidoObservacao: TMemoField;
        cdsItensPedidoTotal: TFloatField;
        mskControle: TLabeledEdit;
        ApplicationEvents: TApplicationEvents;
        cdsItensPedidoImpresso: TStringField;
        cdsItensPedidoCasasDecimais: TIntegerField;
        dbgrdItens: TDBGrid;
        pnlOpcoes: TPanel;
        lblOpcoes: TLabel;
        spdConsulta: TSpeedButton;
        spdGravar: TSpeedButton;
        spdCancelaItem: TSpeedButton;
        spdFuncoes: TSpeedButton;
        spdFechamento: TSpeedButton;
        spdCancela: TSpeedButton;
        cdsItensPedidoSituacao: TIntegerField;
        pnlProdutos: TPanel;
        Panel5: TPanel;
        pnlQtd: TPanel;
        Label5: TLabel;
        Label13: TLabel;
        lblPrecoUnitario: TLabel;
        mskQTDE: TMaskEdit;
        pnlOBS: TPanel;
        Label27: TLabel;
        edObservacao: TEdit;
        pnlProduto: TPanel;
        Label4: TLabel;
        lblDescricao: TLabel;
        mskProduto: TMaskEdit;
        Panel1: TPanel;
        lblTotalComServico: TLabel;
        Panel3: TPanel;
        Label16: TLabel;
        lblTotal: TLabel;
        cbtabelapreco: TComboBox;
        mskCliente:TLabeledEdit;
        lblCliente:TLabel;
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
        procedure ApplicationEventsException(Sender: TObject; E: Exception);
        procedure ApplicationEventsActionExecute(Action: TBasicAction;
            var Handled: Boolean);
        procedure ApplicationEventsSettingChange(Sender: TObject;
            Flag: Integer; const Section: string; var Result: Integer);
        procedure cbUFKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure mskProdutoKeyPress(Sender: TObject; var Key: Char);
        procedure mskProdutoEnter(Sender: TObject);
        procedure edObservacaoEnter(Sender: TObject);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure lblClienteDblClick(Sender: TObject);
        procedure cbTabelaPrecoChange(Sender: TObject);
        procedure cbTabelaPrecoKeyDown(Sender: TObject; var Key: Word;
          Shift: TShiftState);
        procedure mskClienteExit(Sender: TObject);
        procedure edObservacaoExit(Sender: TObject);
  private
    FAbriuCF: Boolean;
    procedure SetAbriuCF(const Value: Boolean);
    private
        { Private declarations }
        FTotalProdutos: Real;
        FPedidoAberto: Boolean;
        strNaturezaOperacao,
        strCodigoCondicaoPagamento,
        iTabelaPreco,
        oldTabelaPreco: string;
        funcoes_ecf,
        ptrEditaItem, //edicao do item.
        ptrObservacao: Pointer;// para gravar a observação, caso esteja habilitada.'
        bLancouMeio: Boolean;
        strMascaraFechamento: string;
        function CalculaTotalPedido(Pedido: pointer): string;
        procedure LimpaCabecalhoPedido;
        procedure LimpaCaptionVenda;
        procedure VerificaHabilitados;
        procedure SetTotalProdutos(const Value: Real);
        procedure SetPedidoAberto(const Value: Boolean);
        procedure AjustaPrecos(strTabela: string);
        procedure CarregaTabelaPreco;
        property TotalProdutos: Real read FTotalProdutos write SetTotalProdutos;
        property PedidoAberto: Boolean read FPedidoAberto write SetPedidoAberto;
        property AbriuCF:Boolean read FAbriuCF write SetAbriuCF;

    protected
        { Public declarations }
    public
        { Public declarations }
    end;

var
    frmPDV: TfrmPDV;
    handECF:THandle;
implementation

uses
    StrUtils, udmPDV, Math, uBuscaProduto, uBuscaVendedor, uConsultaPedido,
    uConsultaClientes, uFuncoes, IniFiles, uOpcoes, urotinas,
    uFechaPedido, uFechaNormal;

{$R *.dfm}

procedure TfrmPDV.cdsItensPedidoAfterPost(DataSet: TDataSet);
begin
    (dataset as tclientdataset).SaveToFile((dataset as tclientdataset).filename);
end;

procedure TfrmPDV.cdsItensPedidoCalcFields(DataSet: TDataSet);
begin
    //calcula o total por item.
    cdsItensPedidototal.Value := cdsItensPedidoValorUnitario.Value * cdsItensPedidoQuantidade.Value;
end;

procedure TfrmPDV.FormCreate(Sender: TObject);
var
   straux:string;
begin
    Log('Inicializando ' + TIPO_TERMINAL + ' .');
    //armazenameto dos itens dos pedidos
    TotalProdutos := 0;
    PedidoAberto  := False;
    cdsItensPedido.Close;
    cdsItensPedido.FileName := ExtractFilePath(Application.ExeName) + 'ITENS_PEDIDO.XML';
    if not FileExists(cdsItensPedido.FileName) then
        cdsItensPedido.CreateDataSet;
    cdsItensPedido.Open;
    cdsItensPedido.EmptyDataSet;
    lblTotal.Caption      := CurrencyString + CalculaTotalPedido(@cdsItensPedido);
    // configura o status bar - Charles
    sbInfo.Panels[2].Text := 'Loja: ' + formatfloat('0000', LeINI('Loja','LojaNum'));
    sbInfo.Panels[3].Text := 'Terminal: ' + formatfloat('0000',LeINI('terminal','PDVNum'));
    sbInfo.Panels[4].Text := 'Operador: ' + LeINI('oper', 'nome','dados\oper.ini');
    Self.Caption          := Self.Caption + LeINI('OPER', 'DATA', 'dados\oper.ini');
    //inicialização das propriedades do form.
    ptrEditaItem                  := nil;
    ptrObservacao                 := nil;
    pnlOBS.Visible                := strtointdef(leini(TIPO_TERMINAL, 'observacaoproduto'), 0) =1;
    lblTotalComServico.Visible    := strtointdef(LeINI(TIPO_TERMINAL, 'usa_servico'), 0) = 1;
    cbtabelapreco.Visible         := strtointdef(LeINI(TIPO_TERMINAL, 'hab_precos'),0)= 1;
    lblcbTabelaPreco.Visible      := cbtabelapreco.Visible;
    mskControle.EditLabel.Caption := leini(TIPO_TERMINAL, 'legenda');
    lblIndicador.Caption          := LeINI(TIPO_TERMINAL, 'nomeind');
    bLancouMeio                   := False;
    iTabelaPreco                  := leini(TIPO_TERMINAL, 'tabelapreco');// no restaurante é fixo.
    strMascaraFechamento          := Format(lblFechamento.Caption, [
       AnsiLowerCase(mskControle.EditLabel.Caption[Length(mskControle.EditLabel.Caption)]),
    mskControle.EditLabel.Caption, '%s']);
    funcoes_ecf := GetProcAddress(handECF,'ECF_INFO');
    straux      := FECF_INFO(funcoes_ecf)(LeINI('TERMINAL','MODECF'),LeINI('TERMINAL','COMECF'));

    sbInfo.Panels[5].Text := 'ECF:' + Copy(straux,2,4);
    NumeroECf := Copy(straux,2,4);
    if strtointdef(Copy(straux,2,4),-1) = -1 then
    begin
         try
            raise Exception.Create('Número do ECF incorreto. Finalizando.');
            except
            Close;
         end;
    end;

    if not trataerroimpressora(straux) then
    begin
         try
            raise Exception.Create('Ocorreu um erro de comunicção com o ecf. Finalizando o aplicativo');
            except
                  Close;
         end;
    end;

    if straux[10] = '1' then //caso haja cupom aberto cancela. Charles.
    begin
         funcoes_ecf := GetProcAddress(handECF,'Cancelacupom');
         if trataerroimpressora(fcancelacupom(funcoes_ecf)(StrToInt(leini('terminal', 'ModECF')),
            StrToInt(leini('terminal', 'comECF')),
            '0',leini(TIPO_TERMINAL,'valorultimocupom' ))) then
            GravaCancelamentoVenda(LeINI(TIPO_TERMINAL,'ultimocupom'));
    end;
    // Verificação da abertura do dia.
    case straux[6] of
        '1':
            begin
                funcoes_ecf := GetProcAddress(handECF, 'InicioDia');
                straux := FInicioDia(funcoes_ecf)(StrToInt(leini('terminal', 'ModECF')),
                    StrToInt(leini('terminal', 'comECF')),
                    LeINI('terminal', 'hv'), LeINI('oper', 'codigo','dados\oper.ini'),
                    dmORC.FormasPagamento);
                if not TrataerroImpressora(straux, false) then
                begin
                    raise Exception.Create('Não foi possível estabelecer comunicação com a impressora fiscal.'#13' Finalizando sistema.');
                    Close;
                end;
            end;
        '2':
            begin
                raise Exception.Create('Dia Encerrado.');
                Close;
            end;
    end;

end;

procedure TfrmPDV.actFechamentoExecute(Sender: TObject);
var
    auxdataset: TDataSet;
    auxResp: Integer;
    tmpControle: string;
    bDireto: Boolean;
    straux: string;
begin
    { DONE -oCharles -cImplementação : mudar label para recebimento para delivery e restaurante }
    if PedidoAberto then
    begin
        tmpControle := mskControle.Text;
        bDireto     := True;
        if StrToFloatDef(mskControle.Text, 0) <> 0 then
        begin
            //verifica se o pedido na tela já está gravado.
            dmorc.Commit;
            auxdataset       := dmORC.ConsultaPedido(mskControle.Text);
            freeandnil(auxdataset);
            mskControle.Text := tmpControle;
            actGravarExecute(actFechamento);
            auxDataSet       := dmORC.ConsultaDetalhePedido(mskControle.Text);
            cdsItensPedido.EmptyDataSet;
            auxdataset.Last;
            auxdataset.First;
            while not auxDataSet.Eof do
            begin
                cdsItensPedido.Insert;
                cdsItensPedidoPedido.AsString        := mskControle.Text;
                cdsItensPedidocodigo.AsString        := auxDataSet.FieldByName('codigoproduto').AsString;
                cdsItensPedidoDescricao.AsString     := auxDataSet.FieldByName('nomeproduto').AsString;
                cdsItensPedidoValorUnitario.AsString := auxDataSet.FieldByName('preco').AsString;
                cdsItensPedidoQuantidade.AsString    := auxDataSet.FieldByName('quantidade').AsString;
                cdsItensPedidoImpresso.Value         := auxDataSet.FieldByName('impresso').AsString;
                cdsItensPedidoCasasDecimais.Value    := auxDataSet.FieldByName('Decimais').AsInteger;
                cdsItensPedidoSituacao.Value         := auxdataset.FieldByName('CANCELADO').AsInteger;
                cdsItensPedido.Post;
                auxDataSet.Next;
            end;
            FreeAndNil(auxdataset);
            //caso esteja gravado, mostra a msg de confirmação de fechamento, caso contrario assume que
            //o pedido será fechado.
            if bDireto then
                auxResp := Application.MessageBox(pchar('Confirma ' + copy(actFechamento.Caption, 7, 20) + Format(' d%s %s ?',
                    [AnsiLowerCase(mskControle.EditLabel.Caption[Length(mskControle.EditLabel.Caption)]), mskControle.EditLabel.Caption])
                    ), TITULO_MENSAGEM, MB_YESNOCANCEL + MB_ICONQUESTION)
            else
                auxResp := IDYES;

            case auxResp of
                IDYES:
                    begin
                        auxdataset       := dmORC.ConsultaPedido(mskControle.Text);
                        lblTotal.Caption := CurrencyString + auxdataset.FieldByName('totalpedido').AsString;
                        strAux           := ExtractFilePath(Application.ExeName) + LeINI('modulos', 'dll_ECF');
                        cdsItensPedido.First;
                        frmFechaECF := TfrmFechaECF.Create(Self);
                        frmFechaECF.TabelaPreco := iTabelaPreco;
                        frmFechaECF.Pedido :=  mskControle.Text;
                        frmFechaECF.dsItems := @cdsItensPedido;
                        frmFechaECF.ShowModal;
                        FreeAndNil(frmFechaECF);
                        FreeAndNil(auxdataset);
                        mskControle.Enabled  := True;
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
        Application.MessageBox(pchar('Não há ' + mskControle.EditLabel.caption + ' em edição.'), TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
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
    dmorc.RunSQL('SELECT CODIGONATUREZAOPERACAO FROM NATUREZAOPERACAO', auxDataset);
    strNaturezaOperacao := auxDataset.FieldByName('CODIGONATUREZAOPERACAO').AsString;
    freeandnil(auxDataset);
    dmorc.RunSQL('SELECT CODIGOCONDICAOPAGAMENTO FROM CONDICAOPAGAMENTO', auxDataset);
    strCodigoCondicaoPagamento := auxDataset.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString;
    freeandnil(auxDataset);
    SetForegroundWindow(strtointdef(ParamStr(2),0));
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
            Application.MessageBox(pchar('Não há ' + mskControle.EditLabel.caption + ' em edição.'), TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
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
            lblPrecoUnitario.Caption := FloatToStrF(strtofloatdef('', 0),ffFixed, 15,2);
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
    (Sender as TMaskEdit).Text := FormatFloat('0.000', StrToFloatDef((Sender as TMaskEdit).Text, 0));
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
            Application.MessageBox(pchar('Não há ' + mskControle.EditLabel.caption + ' em edição.'), TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
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
            auxProd  := dmORC.buscaProduto(mskProduto.Text, iTabelaPreco);
            cdsItensPedidoPedido.AsString     := mskControle.Text;
            cdsItensPedidocodigo.Value        := auxProd.codigo;
            cdsItensPedidoDescricao.Value     := auxProd.descricao;
            cdsItensPedidoValorUnitario.Value := preco;
            cdsItensPedidoCasasDecimais.Value := auxProd.decimais;
            cdsItensPedidoQuantidade.Value    := StrToFloat(mskQTDE.Text);
            TotalProdutos := TotalProdutos + cdsItensPedidoTotal.AsFloat;
//            cdsItensPedido.Post;

            funcoes_ecf   := GetProcAddress(handECF,'ECF_INFO');

            log('o helder que pedio');
            log(FECF_INFO(funcoes_ecf)(1,1));

            //colocar flag para abrir cupom ou não.
            funcoes_ecf   := GetProcAddress(handECF,'Abrecupom');

            if not AbriuCF then
               AbriuCF := Fabrecupom(funcoes_ecf)(StrToInt(leini('terminal', 'ModECF')), StrToInt(leini('terminal', 'comECF')), '')[1] = '@';

            funcoes_ecf := GetProcAddress(handECF,'Lancaitem');
            while True do
            begin
              //Tenta enviar o item para a impressora fiscal.
              //Em caso de erro, ele pergunta se envia novamente,
              //ou se cancela a tentativa.
              //Charles.
              if not trataerroimpressora(FLancaitem(funcoes_ecf)(StrToInt(leini('terminal', 'ModECF')),
                    StrToInt(leini('terminal', 'comECF')),
                    cdsItensPedido.FieldByName('CODIGO').AsString,
                    cdsItensPedido.FieldByName('DESCRICAO').AsString, (
                    cdsItensPedido.FieldByName('CasasDecimais').AsString + format('%4.' +
                    cdsItensPedido.FieldByName('CasasDecimais').AsString + 'f',
                    [cdsItensPedido.FieldByName('QUANTIDADE').AsFloat])),
                    cdsItensPedido.FieldByName('Valor Unitario').AsString,
                    cdsItensPedido.FieldByName('TOTAL').AsString,
                    dmORC.BuscaTributacao(leini('Loja', 'UFLoja'),
                    cdsItensPedido.FieldByName('CODIGO').AsString)),False) then
                    begin
                         if Application.messagebox( 'Erro durante lançamento do item na impressora.'#13 +
                                                    'Tentar novamente?',TITULO_MENSAGEM,MB_ICONERROR + MB_YESNO) = idyes then
                         begin
                            Continue;
                         end
                         else
                             begin
                                 cdsItensPedido.Cancel;
                                 break;
                             end;
                     end
                        else
                        begin
                            cdsItensPedido.Post;
                            break;
                        end;
             end; 
            //until True;
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
            Application.MessageBox(pchar('Não há ' + mskControle.EditLabel.caption + ' em edição.'), TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
            Exit;
        end;

        if (edObservacao.Text <> '') and (ptrObservacao <> nil) then
        begin
            cdsItensPedido.GotoBookmark(ptrObservacao);
            cdsItensPedido.Edit;
            cdsItensPedidoObservacao.Value := edObservacao.Text;
            cdsItensPedido.Post;
            edObservacao.Clear;
            ptrObservacao := nil;
        end;
        mskProduto.Clear;
        lblDescricao.Caption     := '';
        lblPrecoUnitario.Caption := '0' + DecimalSeparator + '00';
        mskProduto.SetFocus;
    end;
end;

procedure TfrmPDV.dbgrdItensDblClick(Sender: TObject);
begin
      ptrEditaItem := cdsItensPedido.GetBookmark;
      //guarda a posicao do registro atual.
      if ptrEditaItem <> nil then
      begin
        mskProduto.SetFocus;
        mskProduto.Text          := cdsItensPedidocodigo.Value;
        mskQTDE.Text             := cdsItensPedidoQuantidade.Text;
        lblPrecoUnitario.Caption := cdsItensPedidoValorUnitario.AsString;
        lblDescricao.Caption     := cdsItensPedidoDescricao.Value;
        TotalProdutos            := TotalProdutos - cdsItensPedidoTotal.Value;
      end;
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
              if Application.MessageBox( PChar('Confirma o cancelamento deste item?'#13 + 'Produto : ' + cdsItensPedidoDescricao.Value),TITULO_MENSAGEM,
                  MB_YESNO + MB_ICONQUESTION ) = idyes then
              begin
                  dbgrdItens.DataSource.DataSet.Edit;
                  dbgrdItens.DataSource.DataSet.FieldByName('situacao').Value := 1;
                  auxTotalItem  := dbgrdItens.DataSource.DataSet.FieldByName('total').AsFloat;
                  dbgrdItens.DataSource.DataSet.post;
                  TotalProdutos := TotalProdutos - auxTotalItem;
                  ptrEditaItem  := nil;
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
                        ptrEditaItem  := nil;
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
    lblDescricao.Caption       := '';
    lblPrecoUnitario.Caption   := '0,00';
    lblTotal.Caption           := CurrencyString + '0,00';
    mskQTDE.Text               := '1' + DecimalSeparator + '000';
    lblTotalComServico.Caption := ' - ';
    edObservacao.Clear;
    mskProduto.Clear;

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
             freeandnil(frmConsultaPedido.qryPedido);
             FreeAndNil(frmConsultaPedido);
             Exit;
        end;
        if not frmConsultaPedido.qryPedido.IsEmpty then
        begin
            mskControle.Text :=
                frmConsultaPedido.qryPedido.FieldByName('Pedido').AsString;
            mskControleExit(mskControle);
            mskClienteExit(mskCliente);
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
        freeandnil(frmConsultaProduto.dsListagemProdutos);
        freeandnil(frmConsultaProduto);
    end else if mskCliente.Focused then
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
        DMORC.RunSQL('SELECT CLI_CODCLIENTE FROM CLIENTE WHERE CODIGOCLIENTE = 1', auxdataset);
        if cdsItensPedido.RecordCount > 0 then
            // quando o meliante pedir o fechamento direto, precisa gravar antes.
            if UpperCase((Sender as TComponent).Name) <> UpperCase('actFechamento') then
                aux := Application.MessageBox('Confirma a gravação do pedido?', TITULO_MENSAGEM, MB_YESNOCANCEL + MB_ICONQUESTION)
            else
                aux := IDYES;

        auxPedido  := dmORC.ConsultaPedido(mskControle.Text);
        auxServico := auxPedido.FieldByName('DESPESASACESSORIAS').AsFloat;
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

            //insere ou atualiza os dados do pedido.
            dmorc.InserePedido(cdsItensPedido, //items do pedido
                FormatDateTime('mm/dd/yyyy hh:nn:ss', StrToDate(LeINI('oper',
                    'data',
                'dados\oper.ini')) + time), //Data do movimento.
                mskControle.Text, //numero do pedido
                dmORC.PegaCodigoInternoCliente(mskCliente.Text),
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
                ptrEditaItem  := nil;
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
                ptrEditaItem  := nil;
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
    FTotalProdutos        := 0;
    lblVendedor.Caption   := '';
    lblCliente.Caption    := '';
    mskIndicador.Enabled  := True;
    mskControle.Enabled   := True;
    cbtabelapreco.Enabled := True;
    mskCliente.Enabled    := True;
    PedidoAberto          := False;
    FAbriuCF              := False;
    mskControle.Clear;
    mskCliente.Clear;
    mskIndicador.Clear;
    lblFechamento.Hide;
end;

procedure TfrmPDV.mskControleExit(Sender: TObject);
var
    auxdataset: TDataSet;
begin
    VerificaHabilitados;
    mskcontrole.Text := FormatFloat('0', StrToFloatDef(mskcontrole.Text, 0));
    ptrEditaItem     := nil;
    ptrObservacao    := nil;
    if not (activecontrol = nil) then
    begin
         auxDataSet := dmORC.ConsultaPedido(mskControle.Text);
         if auxdataset.IsEmpty then
         begin
              if (StrToIntDef(leini(TIPO_TERMINAL,'TIPO_CONTADOR'),0)) = 0 then
              begin
                  if (((strtoint((Sender as TLabeledEdit).Text) < strtointdef(leini('terminal','LIMITEPEDIDOMINIMO'), 1)) or
                      (strtoint((Sender as TLabeledEdit).Text)  > strtointdef(leini('terminal','LIMITEPEDIDOMAXIMO'), 999)))) then
                  begin
                      if strtoint((Sender as TLabeledEdit).Text) <> 0 then
                      begin
                          Application.messagebox('O número informado está fora da faixa especificada', TITULO_MENSAGEM, MB_OK + MB_ICONWARNING);
                          mskControle.Clear;
                          mskControle.SetFocus;
                      end;
                      Exit;
                  end;
              end
                 else
                      mskControle.Text := dmORC.CalculaNumeroPedido(DateToStr(Now));
         end;
        dmorc.Commit;
        //verifica se o tipo de terminal é o mesmo.
        PedidoAberto := true;
        if not auxdataset.IsEmpty then
            if auxdataset.FieldByName('ORIGEMPEDIDO').AsString = inttostr(strtointdef(LEINI(TIPO_TERMINAL, 'codigo_origem'), 2)) then
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
                Application.MessageBox('Acesso negado.', TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
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
        mskControle.Enabled   := False;
        if not auxDataSet.IsEmpty then
        begin
            mskIndicador.Text := dmORC.ConsultaCodigoVendedor(auxDataSet.FieldByName('ven_codvendedor').AsString);
            mskCliente.Text   := auxdataset.FieldByName('cli_codcliente').AsString;
            FreeAndNil(auxdataset);
            //puxa os dados do cliente
            // no caso de restaurante é sempre 1
            auxdataset      := dmORC.ConsultaCliCodCliente(mskCliente.Text);
            mskCliente.Text := auxdataset.FieldByName('CODIGOCLIENTE').AsString;
            FreeAndNil(auxdataset);
            auxDataSet      := dmORC.ConsultaCliente(mskCliente.Text);
            if not auxDataSet.IsEmpty then
                mskClienteExit(mskCliente);
            FreeAndNil(auxDataSet);
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
        auxDataSet              := dmORC.ConsultaDetalhePedido(mskControle.Text); //busca os itens do pedido.
        auxDataSet.Last;
        auxDataSet.First;
        cdsItensPedido.EmptyDataSet;
        while not auxDataSet.Eof do
        begin
            cdsItensPedido.Insert;
            cdsItensPedidoPedido.AsString        := mskControle.Text;
            cdsItensPedidocodigo.AsString        := auxDataSet.FieldByName('codigoproduto').AsString;
            cdsItensPedidoDescricao.AsString     := auxDataSet.FieldByName('nomeproduto').AsString;
            cdsItensPedidoValorUnitario.AsString := auxDataSet.FieldByName('preco').AsString;
            cdsItensPedidoQuantidade.AsString    := auxDataSet.FieldByName('quantidade').AsString;
            cdsItensPedidoImpresso.Value         := auxDataSet.FieldByName('impresso').AsString;
            cdsItensPedidoCasasDecimais.Value    := auxDataSet.FieldByName('Decimais').AsInteger;
            cdsItensPedidoSituacao.Value         := auxDataSet.FieldByName('CANCELADO').AsInteger;
            cdsItensPedido.Post;
            TotalProdutos := TotalProdutos + IfThen(cdsItensPedidoSituacao.AsFloat = 0, cdsItensPedidoTotal.asfloat, 0);
            auxDataSet.Next;
        end;
        FreeAndNil(auxdataset);
        cdsItensPedido.Filtered := True;
        if not cdsItensPedido.IsEmpty then //Lança o cupom se o pedido já existir.
           LancaCupomFiscal(cdsItensPedido,mskControle.Text,dmORC.ConsultaVen_CodigoVendedor(mskIndicador.Text),'',NumeroECf);
        mskcontrole.Text := FormatFloat('000000000000', strtofloatdef(mskcontrole.Text, 0));
    end;
end;

procedure TfrmPDV.mskIndicadorExit(Sender: TObject);
var
    auxdataset: TDataSet;
    straux:string;
begin
    VerificaHabilitados;
    if not (ActiveControl = nil) then
    begin
        if StrToIntDef(mskIndicador.Text, 0) > 0 then
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
        end
           else
           begin
                straux :='É necessário digitar o código de um '+ leini(TIPO_TERMINAL,'nomeind') +'para continuar.';
                Application.MessageBox(PChar(straux),TITULO_MENSAGEM, MB_OK+MB_ICONERROR);
                mskIndicador.SetFocus;
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
            'dados\pdv_'+Copy(TIPO_TERMINAL,1,3)+'.ini'), 0);
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

procedure TfrmPDV.SetTotalProdutos(const Value: Real);
var
    auxdataset: TDataSet;
begin
    FTotalProdutos := Value;
    //calcula o valor total do pedido para painel com o total
    // e  a etiqueta com o total + servico.
    lblTotal.Caption := CurrencyString + FloatToStrf(FTotalProdutos, ffFixed,18,2);
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
                lblTotalComServico.Caption := 'Total + Serviço  ' + CurrencyString
                    + ' ' + floattostrf(FTotalProdutos
                    + dmORC.CalculaAcrescimo(floattostr(FTotalProdutos),
                    LeINI('terminal','servico_per') / 100), ffFixed, 18, 2)
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

procedure TfrmPDV.lblClienteDblClick(Sender: TObject);
var
    proc_info: TProcessInformation;
    startinfo: TStartupInfo;
    ExitCode: longword;
begin
      // Initialize the structures
      FillChar(proc_info, sizeof(TProcessInformation), 0);
      FillChar(startinfo, sizeof(TStartupInfo), 0);
      startinfo.cb := sizeof(TStartupInfo);
      // Attempts to create the process
      if CreateProcess('CADCLI.EXE', 'handle 0', nil,
      nil, false, NORMAL_PRIORITY_CLASS, nil, nil,
      startinfo, proc_info) <> False then begin
      // The process has been successfully created
      // No let's wait till it ends...
      WaitForSingleObject(proc_info.hProcess, INFINITE);
      // Process has finished. Now we should close it.
      GetExitCodeProcess(proc_info.hProcess, ExitCode); // Optional
      CloseHandle(proc_info.hThread);
      CloseHandle(proc_info.hProcess);
//      Application.MessageBox(
//      PChar(Format('Notepad finished! (Exit code=%d)', [ExitCode])),
//      'Info', MB_ICONINFORMATION);
      end
          else
              begin
                  // Failure creating the process
                  Application.MessageBox('Couldn''t execute the '
                  + 'application', 'Error', MB_ICONEXCLAMATION);
              end;//if
end;


procedure TfrmPDV.CarregaTabelaPreco;
var
   dataAux, dataAux2:TDataSet;
begin
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
              Application.MessageBox('Cliente não cadastrado',TITULO_MENSAGEM,MB_OK +MB_ICONERROR);
              mskCliente.SetFocus;
           end
              else
              begin
                   lblCliente.Caption := auxDataSet.FieldByName('completo').AsString;
                   mskCliente.Enabled := False;
              end;
     end;
     FreeAndNil(auxDataSet);
end;

procedure TfrmPDV.edObservacaoExit(Sender: TObject);
begin
     VerificaHabilitados;
end;


var
   straux:string;
procedure TfrmPDV.SetAbriuCF(const Value: Boolean);
begin
  FAbriuCF := Value;
end;

initialization
begin
     straux  := ExtractFilePath(Application.exename) + leini('modulos','dll_ecf');
     handECF := LoadLibrary(PChar(straux));
end;

finalization
begin
     FreeLibrary(handecf);
end;

end.
//******************************************************************************
//*                          End of File uOrcamento.pas                        |
//******************************************************************************

