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
// Resources:      Win32 API                                                    |
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
  AppEvnts, ExtCtrls, DB, DBClient, ActnList, XPStyleActnCtrls, ActnMan,
  Buttons, Mask, StdCtrls, DBGrids, ComCtrls, dialogs, Grids;


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
    dsItensPedido: TDataSource;
    tmrStatus: TTimer;
    pnlPedido: TPanel;
    lblCliente: TLabel;
    lblVendedor: TLabel;
    lblIndicador: TLabel;
    mskIndicador: TMaskEdit;
    lblFechamento: TLabel;
    mskControle: TLabeledEdit;
    mskCliente: TLabeledEdit;
    ApplicationEvents: TApplicationEvents;
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
    cdsItensPedido: TClientDataSet;
    cdsItensPedidocodigo: TStringField;
    cdsItensPedidoDescricao: TStringField;
    cdsItensPedidoValorUnitario: TFloatField;
    cdsItensPedidoQuantidade: TFloatField;
    cdsItensPedidoTotal: TFloatField;
    cdsItensPedidoControle: TAutoIncField;
    cdsItensPedidoPedido: TFloatField;
    cdsItensPedidoObservacao: TMemoField;
    cdsItensPedidoImpresso: TStringField;
    cdsItensPedidoCasasDecimais: TIntegerField;
    cdsItensPedidoSituacao: TIntegerField;
    pnlOpcoes: TPanel;
    lblOpcoes: TLabel;
    spdConsulta: TSpeedButton;
    spdGravar: TSpeedButton;
    spdCancelaItem: TSpeedButton;
    spdImprimir: TSpeedButton;
    spdCancela: TSpeedButton;
    spdFechamento: TSpeedButton;
    spdFuncoes: TSpeedButton;
    gbItens: TGroupBox;
    dbgrdItens: TDBGrid;
    GBCliente: TPanel;
    Label21: TLabel;
    Label22: TLabel;
    edBairro: TEdit;
    Label23: TLabel;
    edMunicipio: TEdit;
    cbUF: TComboBox;
    Label24: TLabel;
    Label25: TLabel;
    mskNome: TMaskEdit;
    mskFone: TMaskEdit;
    Label26: TLabel;
    mskEndereco: TEdit;
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
    procedure cbTabelaPrecoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actGravarExecute(Sender: TObject);
    procedure actFuncoesExecute(Sender: TObject);
    procedure actCancelarExecute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mskControleExit(Sender: TObject);
    procedure mskClienteExit(Sender: TObject);
    procedure mskIndicadorExit(Sender: TObject);
    procedure mskControleKeyPress(Sender: TObject; var Key: Char);
    procedure cbTipoEndChange(Sender: TObject);
    procedure lblClienteDblClick(Sender: TObject);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure ApplicationEventsActionExecute(Action: TBasicAction;
      var Handled: Boolean);
    procedure cbUFKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure mskControleEnter(Sender: TObject);
    procedure mskProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure GBClienteExit(Sender: TObject);
    procedure edObservacaoEnter(Sender: TObject);
    procedure mskClienteKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    strNaturezaOperacao,
    strCodigoCondicaoPagamento,
    iTabelaPreco:string;
    ptrEditaItem,  //edicao do item.
    ptrObservacao:Pointer; // para gravar a observação, caso esteja habilitada.
    bLancouMeio:Boolean;
    strMascaraFechamento:string;
    FTotalProdutos: Real;
    FPedidoAberto: Boolean;
    function  CalculaTotalPedido(Pedido:pointer):string;
    procedure Imprime;
    procedure LimpaCabecalhoPedido;
    procedure LimpaCaptionVenda;
    procedure LimpaDadosCliente;
    procedure VerificaHabilitados;
    procedure SetTotalProdutos(const Value: Real);
    procedure SetPedidoAberto(const Value: Boolean);
  protected
    { Public declarations }
  public
    { Public declarations }
    property TotalProdutos:Real read FTotalProdutos write SetTotalProdutos;
    property PedidoAberto:Boolean read FPedidoAberto write SetPedidoAberto;
    procedure printgrill(pedido:integer;nome_pedido,nome_vendedor:string);
  end;

var
  frmPDV: TfrmPDV;


implementation

uses StrUtils, udmPDV, Math, uFechaPedido, uFechaNormal,
  uDadosDelivery, uBuscaProduto, uBuscaVendedor, uConsultaPedido,
  uConsultaClientes, uFuncoes, IniFiles, uOpcoes, urotinas,
  uDadosChequeLeitor, uQrFechamento;

{$R *.dfm}

procedure TfrmPDV.cdsItensPedidoAfterPost(DataSet: TDataSet);
var
   auxValor:Real;
   auxDataset:TDataSet;
begin
     //calcula o valor total do pedido para painel com o total
     // e  a etiqueta com o total + servico.
     auxValor := StrToFloat(CalculaTotalPedido(@cdsItensPedido));
     (dataset as tclientdataset).SaveToFile((dataset as tclientdataset).filename);
     lblTotal.Caption := CurrencyString + FloatToStrf(auxValor,ffFixed,18,2);
     if LeINI('terminal','usa_servico') = 1 then
     begin
          auxDataset := dmORC.ConsultaPedido(mskControle.Text);
          if auxDataset.FieldByName('despesasacessorias').AsFloat > 0 then
             lblTotalComServico.Caption := 'Total + Serviço ' + CurrencyString +' '+  FloatToStrF(auxValor +  auxDataset.FieldByName('despesasacessorias').AsFloat ,ffFixed,18,2)
          else
              if strtointdef(LeINI('terminal','servico_per'),0) > 0 then
                 lblTotalComServico.Caption := 'Total + Serviço  ' + CurrencyString  +' '+ floattostrf(auxValor + dmORC.CalculaAcrescimo(floattostr(auxValor) ,LeINI('terminal','servico_per') / 100),ffFixed,18,2)
                 else
                      lblTotalComServico.Caption := 'Total + Serviço ' + CurrencyString +' '+  FloatToStrF(auxValor + StrToFloat(LeINI('terminal','servico_val'))/ 100,ffFixed,18,2);
          FreeAndNil(auxdataset);
     end;
end;

procedure TfrmPDV.cdsItensPedidoCalcFields(DataSet: TDataSet);
begin
  //calcula o total por item.
  cdsItensPedidototal.Value := cdsItensPedidoValorUnitario.AsFloat * cdsItensPedidoQuantidade.AsFloat;
end;

procedure TfrmPDV.FormCreate(Sender: TObject);
var
   hand :thandle;
   ECF_INFO:FECF_INFO;
   InicioDia:FInicioDia;
   strAux:string;
begin
      Log('Inicializando aplicação delivery.');
     //armazenameto dos itens dos pedidos
     FTotalProdutos := 0;

     cdsItensPedido.Close;
     cdsItensPedido.FileName := ExtractFilePath(Application.ExeName) + 'ITENS_PEDIDO.XML';

     if not FileExists(cdsItensPedido.FileName) then
        cdsItensPedido.CreateDataSet;
     cdsItensPedido.Open;
     cdsItensPedido.EmptyDataSet;
     lblTotal.Caption      := CurrencyString +  CalculaTotalPedido(@cdsItensPedido);

     // configura o status bar - Charles
     sbInfo.Panels[2].Text := 'Loja: '     + formatfloat('0000',LeINI('Loja','LojaNum'));
     sbInfo.Panels[3].Text := 'Terminal: ' + formatfloat('0000',LeINI('terminal','PDVNum'));
     sbInfo.Panels[4].Text := 'Operador: ' + LeINI('oper','nome','dados\oper.ini');
     Self.Caption          := Self.Caption + LeINI('OPER','DATA','dados\oper.ini');
     iTabelaPreco := LeINI(TIPO_TERMINAL,'tabelapreco');

     //inicialização das propriedades do form.
     ptrEditaItem := nil;
     ptrObservacao:= nil;

     //Configuração da janela de acordo com o modo de operacao
     //coloquei vários panels para não precisar ficar movendo componentes.
     //charles.

     pnlOBS.Visible := (StrToIntDef(leini(TIPO_TERMINAL,'ObservacaoProduto'),0) = 1);

     mskControle.EditLabel.Caption := leini(TIPO_TERMINAL,'legenda');
     lblIndicador.Caption := LeINI(TIPO_TERMINAL,'NOMEIND');
     bLancouMeio :=False;

     strMascaraFechamento := Format( lblFechamento.Caption,[
                                      AnsiLowerCase(mskControle.EditLabel.Caption[ Length(mskControle.EditLabel.Caption)]),
                                      mskControle.EditLabel.Caption,'%s' ]);
     Log('Carregando dll do ecf: ' + LeINI('modulos','dll_ECF'));
     strAux := LeINI('modulos','dll_ECF');
     hand := LoadLibrary(PChar(straux));
     Log('Handle dll ecf:' + IntToStr(hand));
     log('Carregando funçoes dll ecf.');
     @ECF_Info := GetProcAddress(hand,'ECF_INFO');
     @InicioDia:= GetProcAddress(hand,'InicioDia');
     straux := ECF_Info( StrToInt(leini('terminal','ModECF')),StrToInt(leini('terminal','comECF')));
     NumeroEcf := Copy(strAux,2,4); // armazena o numero do ecf para uso posterior;

     sbInfo.Panels[5].Text := 'ECF :' + Copy(straux ,2,4);

     Log('INicio de dia : ' + straux[6]);
     case straux[6] of
          '1': begin
               log('Efetuando abertura de dia.');
               straux :=InicioDia( StrToInt(leini('terminal','ModECF')),StrToInt(leini('terminal','comECF')),
                                   LeINI('terminal','hv'),LeINI('oper','codigo','dados\oper.ini'),dmORC.FormasPagamento);
               if straux[1] = '#' then
                  Application.MessageBox( Pchar('Ocorreu um erro durante o envio do comando para a impressora'#13 +
                                          'Erro: ' + Copy(strAux,2,Length(straux))), TITULO_MENSAGEM, MB_ICONERROR + MB_OK)
          end;
          '2': begin
               Application.MessageBox('Dia Encerrado.',TITULO_MENSAGEM, MB_OK + MB_ICONHAND);
               FreeLibrary(hand);
               Close;
          end;
     end;
     log('Liberando dll ecf.');
     FreeLibrary(hand);
end;

procedure TfrmPDV.actFechamentoExecute(Sender: TObject);
var
   auxdataset:TDataSet;
   auxResp:Integer;
   tmpControle:string;
   bDireto:Boolean;
   COO:FCOO;
   hand:THandle;
   straux:string;
begin
     { DONE -oCharles -cImplementação : mudar label para recebimento para delivery e restaurante }
     tmpControle := mskControle.Text;
     bDireto := True;

     if StrToFloatDef(mskControle.Text,0) <> 0 then
     begin
           //verifica se o pedido na tela já está gravado.
           auxdataset := dmORC.ConsultaPedido(mskControle.Text);
           if auxdataset.IsEmpty then
           begin
                //spdGravar.Click;
                actGravarExecute(actFechamento);
                bDireto := False;
           end;
           freeandnil(auxdataset);

           mskControle.Text := tmpControle;
           actGravarExecute(actFechamento);

           auxDataSet          := dmORC.ConsultaDetalhePedido(mskControle.Text);
           cdsItensPedido.EmptyDataSet;
           auxdataset.Last;
           auxdataset.First;
           while not auxDataSet.Eof do
           begin
                cdsItensPedido.Insert;
                cdsItensPedidoPedido.AsString := mskControle.Text;
                cdsItensPedidocodigo.AsString := auxDataSet.FieldByName('codigoproduto').AsString;
                cdsItensPedidoDescricao.AsString := auxDataSet.FieldByName('nomeproduto').AsString;
                cdsItensPedidoValorUnitario.AsString:= auxDataSet.FieldByName('preco').AsString;
                cdsItensPedidoQuantidade.AsString := auxDataSet.FieldByName('quantidade').AsString;
                cdsItensPedidoImpresso.Value      := auxDataSet.FieldByName('impresso').AsString;
                cdsItensPedidoCasasDecimais.Value := auxDataSet.FieldByName('Decimais').AsInteger;
                cdsItensPedido.Post;
                auxDataSet.Next;
           end;
           FreeAndNil(auxdataset);

           //caso esteja gravado, mostra a msg de confirmação de fechamento, caso contrario assume que
           //o pedido será fechado.
           if bDireto then
             auxResp :=  Application.MessageBox(pchar( 'Confirma ' + copy(actFechamento.Caption,7,20) +
                                                       Format(' d%s %s ?', [ AnsiLowerCase(mskControle.EditLabel.Caption[ Length(mskControle.EditLabel.Caption)]),mskControle.EditLabel.Caption])
                                                       ), TITULO_MENSAGEM,MB_YESNOCANCEL + MB_ICONQUESTION)
             else
             auxResp := IDYES;

           case auxResp of
               IDYES:
                       begin
                            lblTotal.Caption := CurrencyString + CalculaTotalPedido(@cdsItensPedido);
                            if LEini(Tipo_Terminal,'codigo_origem') = 2 then // PEDIDO DE VENDA -> mandar para o faturamento
                            begin
                                 frmFechaFaturamento := tfrmFechaFaturamento.Create(Self);
                                 frmFechaFaturamento.TabelaPreco := iTabelaPreco;
                                 frmFechaFaturamento.Pedido := mskControle.Text;
                                 if frmFechaFaturamento.ShowModal = mrCancel then
                                 begin
                                      //dsItensPedido.DataSet := cdsItensPedido;
                                     //Exit;
                                 end;
                                 freeandnil(frmFechaFaturamento);
                            end
                            else //
                                 begin
                                     strAux := ExtractFilePath(Application.ExeName) + LeINI('modulos','dll_ECF');
                                     hand := LoadLibrary(PChar(straux));
                                     @COO       := GetProcAddress(hand,'COO');
                                     cdsItensPedido.First;
                                     frmFechaECF := TfrmFechaECF.Create(self);
                                     frmFechaECF.NumeroECF := NumeroEcf;
                                     frmFechaECF.dsItems := @cdsItensPedido;
                                     log('qtd Items antes :' + IntToStr(cdsItensPedido.RecordCount));
                                     LancaCupomFiscal(cdsItensPedido,mskControle.Text,mskIndicador.Text,
                                                       Copy(COO(StrToInt(leini('terminal','ModECF')),StrToInt(leini('terminal','comECF')),'1'),2,6),
                                                       NumeroEcf);//alterado para acelerar a emissao dos itens. - Charles
                                     frmFechaECF.TabelaPreco := iTabelaPreco;
                                     frmFechaECF.Pedido := mskControle.Text;
                                     frmFechaECF.ShowModal;
                                     freeandnil(frmFechaECF);
                                     FreeAndNil(auxdataset);
                                end;
                           mskControle.Enabled :=True;
                           mskCliente.Enabled := True;
                           mskIndicador.Enabled := True;
                           cdsItensPedido.EmptyDataSet;
                           LimpaCaptionVenda;
                           LimpaCabecalhoPedido;
                           LimpaDadosCliente;
                           mskControle.SetFocus;
                       end;
               IDNO:
                    begin
                        cdsItensPedido.EmptyDataSet;
                        LimpaCaptionVenda;
                        LimpaCabecalhoPedido;
                        LimpaDadosCliente;
                        mskControle.SetFocus;
               end;
           end;
     end;
end;

procedure TfrmPDV.tmrStatusTimer(Sender: TObject);
begin
     sbInfo.Panels[0].Text := datetostr(now);
     sbInfo.Panels[1].Text := FormatDateTime('hh:mm',now);
end;

procedure TfrmPDV.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case key of
          VK_RETURN,VK_DOWN:Perform(WM_NEXTDLGCTL,0,0);
          VK_UP: Perform(WM_NEXTDLGCTL,1,0);
          VK_ESCAPE: begin
               if ActiveControl <> nil then
                   if (ActiveControl.Parent.Name = pnlPedido.Name) or (ActiveControl.Parent.Name = GBCliente.Name) then
                   begin
                        ActiveControl := nil;
                        LimpaCaptionVenda;
                        LimpaCabecalhoPedido;
                        LimpaDadosCliente;
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
     KeyPreview := False; //precisa desabilitar para navegar entre os items do grid.
     VerificaHabilitados;
end;

procedure TfrmPDV.dbgrdItensExit(Sender: TObject);
begin
     KeyPreview := True; //habilitando na saida.
     VerificaHabilitados;
end;


{-----------------------------------------------------------------------------
  Procedure: TfrmPDV.CalculaTotalPedido
  Author:    charles
  Date:      11-mar-2003
  Arguments: None
  Result:    string
  Calcula o total do pedido e retorna uma string, com o formato monetário
-----------------------------------------------------------------------------}
function TfrmPDV.CalculaTotalPedido(Pedido:Pointer): string;
begin
     Result := FloatToStrF(FTotalProdutos,ffFixed,18,2);
end;

procedure TfrmPDV.FormShow(Sender: TObject);
var
   auxDataSet:TDataSet;
begin
     //carrega valores padrao para a gravacao dos pedidos.
     dmorc.RunSQL('SELECT CODIGONATUREZAOPERACAO FROM NATUREZAOPERACAO',auxDataset);
     strNaturezaOperacao := auxDataset.FieldByName('CODIGONATUREZAOPERACAO').AsString;
     freeandnil(auxDataset);

     dmorc.RunSQL('SELECT CODIGOCONDICAOPAGAMENTO FROM CONDICAOPAGAMENTO',auxDataset);
     strCodigoCondicaoPagamento := auxDataset.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString;
     freeandnil(auxDataset);
end;

procedure TfrmPDV.mskProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   prdProduto:TProd;
begin
     if key = vk_return then
     begin
          prdProduto := dmORC.BuscaProduto(mskProduto.Text,iTabelaPreco);
          if prdProduto.descricao = '' then
          begin
             (Sender as TCustomEdit).SetFocus;
             //LimpaCaptionVenda;
             Application.MessageBox('Produto não cadastrado.',TITULO_MENSAGEM, MB_OK + MB_ICONINFORMATION);
             Exit;
          end
             else
                  if prdProduto.preco = '0' then
                  begin
                     (Sender as TCustomEdit).SetFocus;
                      lblPrecoUnitario.Caption := '';
                      lblDescricao.Caption := '';
                      lblPrecoUnitario.Caption := FloatToStrF(strtofloatdef('',0),ffFixed,15,2);
                      Application.MessageBox('Produto sem preço cadastrado para a tabela de preços selecionada.',TITULO_MENSAGEM, MB_OK + MB_ICONINFORMATION);
                     Exit;
                  end
                  else
                  begin
                      mskProduto.Text := prdProduto.codigo;
                      lblPrecoUnitario.Caption := prdProduto.preco;
                      lblDescricao.Caption := prdProduto.descricao;
                      lblPrecoUnitario.Caption := FloatToStrF(strtofloatdef(prdProduto.preco,0),ffFixed,15,2);
                  end;
     end;
end;

procedure TfrmPDV.mskQTDEExit(Sender: TObject);
begin
     //Formata a quantidade.
     (Sender as TMaskEdit).Text := FormatFloat('0.000',StrToFloatDef((Sender as TMaskEdit).Text,0));
     VerificaHabilitados;
end;

procedure TfrmPDV.mskQTDEKeyPress(Sender: TObject; var Key: Char);
begin
     //prefiro fazer o controle dessa forma. Charles.
     if key = '.' then
        key := ',';
     if not (key in ['0'..'9',#8,DecimalSeparator]) then
        key := #0;
     if (key = DecimalSeparator) and (Pos(DecimalSeparator,(Sender as TCustomEdit).Text) > 0) and
        (Length((Sender as TCustomEdit).Text) <> Length((Sender as TCustomEdit).SelText)) then
        key := #0;
end;

procedure TfrmPDV.mskQTDEKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
   preco: real;
   auxProd:TProd;
   
begin
     if key = vk_return then
     begin
          if (StrToFloatDef(mskQTDE.Text,0) = 0) or (mskProduto.Text = '') then
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
                  if not (bLancouMeio) and (cdsItensPedidoQuantidade.Value = 0.5) and (StrToFloat(mskQTDE.Text) = 0.5) then
                  begin
                       case StrToIntDef(leini(TIPO_TERMINAL,'politic_preco'),3) of
                            1:// menor preco.
                              begin
                                   preco := Min(cdsItensPedidoValorUnitario.Value, StrToFloat(lblPrecoUnitario.Caption));
                                   cdsItensPedido.Edit;
                                   cdsItensPedidoValorUnitario.Value := preco;
                                   cdsItensPedido.Post;
                            end;
                            2:// maior preco
                              begin
                                   preco := Max(cdsItensPedidoValorUnitario.Value, StrToFloat(lblPrecoUnitario.Caption));
                                   cdsItensPedido.Edit;
                                   cdsItensPedidoValorUnitario.Value := preco;
                                   cdsItensPedido.Post;
                            end;
                            3:// média
                            begin
                                 preco := Mean([cdsItensPedidoValorUnitario.Value, StrToFloat(lblPrecoUnitario.Caption)]);
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
                      if cdsItensPedido.Locate('codigo',mskProduto.Text,[]) then
                      begin
                           ptrEditaItem := cdsItensPedido.GetBookmark;
                           mskQTDE.Text :=  floattostr(StrToFloat(mskQTDE.Text) + cdsItensPedidoQuantidade.Value) ;
                      end;

                  if ptrEditaItem = nil then
                      cdsItensPedido.Insert
                     else
                     begin
                          //agrupa os itens pedidos.
                          cdsItensPedido.GotoBookmark(ptrEditaItem);
                          ptrEditaItem := nil;
                          cdsItensPedido.Edit;
                          cdsItensPedidoImpresso.Value := '';
                     end;

                     auxProd := dmORC.buscaProduto(mskProduto.Text, iTabelaPreco);
                     cdsItensPedidoPedido.AsString := mskControle.Text;
                     cdsItensPedidocodigo.Value := auxProd.codigo;
                     cdsItensPedidoDescricao.Value := auxProd.descricao;
                     cdsItensPedidoValorUnitario.AsFloat:=  preco;
                     cdsItensPedidoCasasDecimais.AsInteger := auxProd.decimais;
                     cdsItensPedidoQuantidade.AsFloat := StrToFloat(mskQTDE.Text);
                     TotalProdutos := TotalProdutos + cdsItensPedidoTotal.AsFloat;
                     cdsItensPedido.Post;
                     ptrObservacao := cdsItensPedido.GetBookmark;
                     mskQTDE.Text := '1'+DecimalSeparator +'000';
             end;
             if pnlOBS.Visible then
                edObservacao.SetFocus
                else
                    begin
                         mskProduto.SetFocus;
                         mskQTDE.Text := '1'+DecimalSeparator +'000';
                         mskProduto.Clear;
                         lblPrecoUnitario.Caption := '0'+DecimalSeparator+'00';
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
        mskProduto.SetFocus;
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
        lblPrecoUnitario.Caption := '0'+DecimalSeparator+'00';
     end;
end;

procedure TfrmPDV.dbgrdItensDblClick(Sender: TObject);
begin
     ptrEditaItem := cdsItensPedido.GetBookmark; //guarda a posicao do registro atual.
     if ptrEditaItem <> nil then
     begin
           mskProduto.Text := cdsItensPedidocodigo.Value;
           mskQTDE.Text    := cdsItensPedidoQuantidade.Text;
           lblPrecoUnitario.Caption := cdsItensPedidoValorUnitario.AsString;
           lblDescricao.Caption := cdsItensPedidoDescricao.Value;
           mskProduto.SetFocus;
     end;
end;

procedure TfrmPDV.actCancelaItemExecute(Sender: TObject);
var i:Integer;
    auxTotalItem:Real;
begin
     if dbgrdItens.SelectedRows.Count = 0 then
        dbgrdItens.SetFocus
        else
             for i := 1 to dbgrdItens.SelectedRows.Count do
             begin
                  if Application.MessageBox(PChar('Confirma a exclusão deste item?'#13+
                                             'Produto : ' + cdsItensPedidoDescricao.Value), TITULO_MENSAGEM, MB_YESNO + MB_ICONQUESTION
                                             ) = idyes then
                     dbgrdItens.DataSource.DataSet.Edit;
                     dbgrdItens.DataSource.DataSet.FieldByName('situacao').Value := 1;
                     auxTotalItem := dbgrdItens.DataSource.DataSet.FieldByName('total').AsFloat;
                     dbgrdItens.DataSource.DataSet.post;
                     TotalProdutos := TotalProdutos - auxTotalItem;
                     ptrEditaItem  := nil;
                     ptrObservacao := nil;
                     mskProduto.SetFocus;
             end;
end;

procedure TfrmPDV.dbgrdItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if (key = VK_DELETE) and (ssCtrl in shift) then
        Key := 0;
     case key of
          VK_SPACE: dbgrdItens.SelectedRows.CurrentRowSelected := True;
          VK_ESCAPE:begin
                         if ptrEditaItem <> nil then
                         begin
                              if Application.MessageBox('Cancela a edição do item?',TITULO_MENSAGEM, MB_YESNO + MB_ICONQUESTION) = idyes then
                              begin
                                        ptrEditaItem := nil;
                                        ptrObservacao := nil;
                                        LimpaCaptionVenda;
                              end;
                         end;
          end;
          VK_RETURN: dbgrdItensDblClick(NIL);
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
   key:Word;
begin
    key := VK_RETURN;
    if mskControle.Focused then
    begin
        frmConsultaPedido := TfrmConsultaPedido.Create(Self);
        if frmconsultapedido.ShowModal = mrcancel then
        begin
             freeandnil(frmConsultaPedido.qryPedido);
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
    else if mskCliente.Focused then
           begin
                frmConsultaCliente := TfrmConsultaCliente.Create(nil);
                if frmConsultaCliente.ShowModal = mrok then
                begin
                    mskCliente.Text :=  frmConsultaCliente.dsCliente.FieldByName('CODIGO').AsString;
                    mskClienteExit(mskCliente);
                end;
                freeandnil(frmConsultaCliente.dsCliente);
                freeandnil(frmConsultaCliente);
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
    end;
end;

procedure TfrmPDV.cbTabelaPrecoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key = vk_return then
        Perform(WM_NEXTDLGCTL,0,0);
     if key = VK_ESCAPE then
        frmPDV.OnKeyDown(Sender,key,[]);
end;

procedure TfrmPDV.actGravarExecute(Sender: TObject);
var
   aux:Integer;
   auxServico:Real;
   auxdataset, auxPedido:TDataSet;
begin
     if PedidoAberto then
     begin
          aux := 0;
          DMORC.RunSQL( 'SELECT CLI_CODCLIENTE FROM CLIENTE WHERE CODIGOCLIENTE = ' + QuotedStr(mskCliente.Text), auxdataset);
          if cdsItensPedido.RecordCount > 0 then
              // quando o meliante pedir o fechamento direto, precisa gravar antes.
              if UpperCase((Sender as TComponent).Name) <> UpperCase('actFechamento') then
                 aux := Application.MessageBox('Confirma a gravação do pedido?',TITULO_MENSAGEM, MB_YESNOCANCEL + MB_ICONQUESTION)
                 else
                     aux := IDYES;

              auxPedido := dmORC.ConsultaPedido(mskControle.Text);
              auxServico := auxPedido.FieldByName('DESPESASACESSORIAS').AsFloat;
              if aux = IDYES then
              begin
                   log(
                       FormatDateTime('mm/dd/yyyy',StrToDate(LeINI('oper','data','dados\oper.ini')))+','+
                                          mskControle.Text+','+
                                          mskCliente.Text+','+
                                          strNaturezaOperacao+','+
                                          strCodigoCondicaoPagamento+','+
                                          dmORC.ConsultaVen_CodigoVendedor(mskIndicador.Text)+','+
                                          iTabelaPreco+','+
                                          ' '+','+
                                          '1'+','+
                                          '0'+','+
                                          ' '+','+
                                          '0'+','+
                                          ' '+','+
                                          '0'+','+
                                          IntToStr(leini(TIPO_TERMINAL,'codigo_origem')));

                    dbgrdItens.DataSource := nil;
                    dmorc.InserePedido( cdsItensPedido, //items do pedido
                                        FormatDateTime('mm/dd/yyyy hh:nn:ss',StrToDate(LeINI('oper','data','dados\oper.ini')) + time ), //Data do movimento.
                                        mskControle.Text, //numero do pedido
                                        ifthen ( StrToIntDef(mskCliente.Text,0) = 0 ,'1', auxdataset.Fields[0].AsString),
                                        strNaturezaOperacao, //natureza de operaçao
                                        strCodigoCondicaoPagamento, //condicao pagamento
                                        dmORC.ConsultaVen_CodigoVendedor(mskIndicador.Text),
                                        iTabelaPreco,
                                        ' ', //Observação do delivery
                                        '1',// cfg_codconfig. POr enqto está fixo em 1.
                                        '0',
                                        ' ',
                                        floattostr(auxservico), //IFthen(auxPedido.FieldByName('DESPESASACESSORIAS').AsFloat > 0, dmORC.CalculaAcrescimo(PChar(@lblTotal.Caption[Length(CurrencyString)+1]),floattostr(auxServico)),  //valor da taxa do servico
                                        ' ', //descricao do acrescimo
                                        IntToStr(leini(TIPO_TERMINAL,'codigo_origem'))
                                        );
                    dbgrdItens.DataSource := dsItensPedido;
                    cdsItensPedido.Filtered := True;

                    dmORC.Commit;
                    FreeAndNil(auxdataset);
                    FTotalProdutos := 0;

                  if (UpperCase((Sender as TComponent).Name) = UpperCase('actGravar')) then
                  begin
                      frmDadosDelivery := TfrmDadosDelivery.Create(self);
                      //precisa passar o número do pedido para o form de dados
                      // do delivery para realizar a consulta do total do pedido
                      frmDadosDelivery.NumeroPedido := mskControle.Text;
                      frmDadosDelivery.ShowModal;
                      FreeAndNil(frmDadosDelivery);
                  end;
                  dmORC.Commit;

                    //só pergunta se imprime no restaurante.
                    if (UpperCase((Sender as TComponent).Name) <> UpperCase('actFechamento'))  then //neste caso não é restaurante.
                           if Application.MessageBox('Deseja imprimir?', TITULO_MENSAGEM,MB_YESNO + MB_ICONQUESTION) = idyes then
                                Imprime();


                    if strtointdef(leini('terminal','printgrill'), 0) = 1 then
                       printgrill(StrToInt(mskControle.Text), leini(TIPO_TERMINAL,'legenda'), lblIndicador.Caption);


                    if UpperCase((Sender as TComponent).Name) <> UpperCase('actFechamento') then
                    begin
                        cdsItensPedido.EmptyDataSet;
                        LimpaCaptionVenda;
                        LimpaCabecalhoPedido;
                        LimpaDadosCliente;
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
                  LimpaDadosCliente;
                  mskControle.SetFocus;
              end;
     end;
end;

procedure TfrmPDV.actFuncoesExecute(Sender: TObject);
begin
     frmFuncoes := TfrmFuncoes.Create(self);
     frmFuncoes.ShowModal;
     freeandnil(frmFuncoes);
end;

procedure TfrmPDV.actCancelarExecute(Sender: TObject);
var
   auxDataset:TDataSet;
   strAux:string;
begin
             frmOpcoes := TfrmOpcoes.Create(SELF);
             frmOpcoes.SpeedButton2.Enabled := not lblFechamento.Visible;
             case frmOpcoes.ShowModal of
                  mrOk: begin
                        dmorc.RunSQL('select codigopedidovenda from pedidovenda where numeropedido = '  + QuotedStr(mskControle.Text), auxDataset);
                        strAux := auxDataset.Fields[0].AsString;
                        if not auxdataset.IsEmpty then
                        begin
                            dmorc.RunSQL('DELETE FROM PRODUTOPEDIDOVENDA WHERE CODIGOPEDIDOVENDA = ' + QuotedStr(strAux));
                            dmORC.RunSQL('DELETE FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' + QuotedStr(mskControle.Text));
                        end;
                        ActiveControl := nil;
                        ptrObservacao := nil;
                        ptrEditaItem  := nil;
                        LimpaCaptionVenda;
                        LimpaCabecalhoPedido;
                        LimpaDadosCliente;
                        cdsItensPedido.EmptyDataSet;
                        mskControle.SetFocus;
                        dmORC.Commit;
                  end;
                  mrCancel: begin
                            ActiveControl := nil;
                            ptrObservacao := nil;
                            ptrEditaItem  := nil;
                            LimpaCaptionVenda;
                            LimpaCabecalhoPedido;
                            LimpaDadosCliente;
                            cdsItensPedido.EmptyDataSet;
                            mskControle.SetFocus;
                  end;
             end;
             FreeAndNil(auxDataset);
             FreeAndNil(frmOpcoes);
end;

procedure TfrmPDV.LimpaCabecalhoPedido;
begin
     mskControle.Clear;
     PedidoAberto   := False;
     mskIndicador.Clear;
     lblCliente.Caption := '';
     lblVendedor.Caption := '';
     mskEndereco.Enabled := True;
     mskCliente.Enabled := True;
     mskIndicador.Enabled := True;
     mskControle.Enabled := True;
     lblFechamento.Hide;
     TotalProdutos := 0;
end;

procedure TfrmPDV.LimpaDadosCliente;
var
   i:Integer;
begin
     for i := 0 to GBCliente.ControlCount - 1 do
      if GBCliente.Controls[i] is TCustomEdit then
        (GBCliente.Controls[i] as TCustomEdit).Clear;
end;

procedure TfrmPDV.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
     Log('Finalizando prevenda.');
     dmORC.IBDatabase.Close;
     CanClose := True;
end;

procedure TfrmPDV.mskControleExit(Sender: TObject);
var
   auxConsultaCliente,auxdataset:TDataSet;
begin
     (Sender as TLabeledEdit).Text := FormatFloat('0',StrToFloatDef((Sender as TLabeledEdit).Text,0));
     VerificaHabilitados;
     ptrEditaItem := nil;
     ptrObservacao := nil;
     cdsItensPedido.Filtered := True;
      if not (activecontrol = nil) then
      begin
              if (strtointdef(LeINI(TIPO_TERMINAL,'tipo_contador'),0) = 0) and  (StrToFloatDef((Sender as TLabeledEdit).Text,0) = 0) then
              begin
                   if (strtointdef(LeINI(TIPO_TERMINAL,'tipo_contador'),0) = 0 )then
                   begin
                         Application.messagebox( Pchar('É necessário digitar o número do(a) ' + (Sender as TLabeledEdit).EditLabel.Caption + ' para continuar.'),
                                                 TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
                         (Sender as TLabeledEdit).SetFocus;

                   end;
              end
                 else
                 begin
                      // controle de quantidade de mesas - Charles - 25/05/2003
                     if  (strtointdef(LeINI(TIPO_TERMINAL,'tipo_contador'),0) = 0) and
                         ((strtoint((Sender as TLabeledEdit).Text) < strtointdef(leini('terminal','LIMITEPEDIDOMINIMO'),1)) or
                         (strtoint((Sender as TLabeledEdit).Text) > strtointdef(leini('terminal','LIMITEPEDIDOMaximo'),999))) then
                     begin
                          Application.messagebox('O número informado está fora da faixa especificada',TITULO_MENSAGEM, MB_OK + MB_ICONWARNING);
                          mskControle.SetFocus;
                          Exit;
                     end;

                     dmorc.Commit;
                     auxDataSet          := dmORC.ConsultaPedido(mskControle.Text);
                     if auxdataset.IsEmpty then
                       if StrToIntDef(LeINI(TIPO_TERMINAL,'tipo_contador'),0) = 1 then
                       begin
                             mskControle.Text := FormatFloat('0000000000000',strtofloat(dmorc.CalculaNumeroPedido(DateToStr(now))));
                             mskControle.Enabled := False;
                       end;
                     //verifica se o tipo de terminal é o mesmo.
                     if not auxdataset.IsEmpty then
                         if auxdataset.FieldByName('ORIGEMPEDIDO').AsString = LeINI(TIPO_TERMINAL,'codigo_origem') then
                         begin
                              //verifica se o pedido já foi fechado.
                              if auxdataset.FieldByName('SITUACAO').AsString = 'X' then
                              begin
                                 Application.MessageBox('Pedido fechado!',TITULO_MENSAGEM,MB_OK + MB_ICONINFORMATION);
                                 LimpaCabecalhoPedido;
                                 mskControle.SetFocus;
                                 Exit;
                              end;
                         end
                             else
                                 begin
                                      //caso o pedido seja de outro tipo de terminal.
                                      Application.MessageBox('Acesso negado.',TITULO_MENSAGEM,MB_OK + MB_ICONERROR);
                                      LimpaCabecalhoPedido;
                                      mskControle.SetFocus;
                                      Exit;
                                 end;
                     if auxdataset.FieldByName('SITUACAO').AsString = 'Z' then
                     begin
                        lblFechamento.Caption := Format(strMascaraFechamento,[datetostr(auxdataset.FieldByName('data').AsDateTime), TimeToStr(auxdataset.FieldByName('data').AsDateTime)]);
                        lblFechamento.Show;
                     end
                        else
                            lblFechamento.Hide;

                     mskControle.Enabled := False;
                     PedidoAberto := True;
                     if not auxDataSet.IsEmpty then
                     begin
                           auxConsultaCliente := dmORC.ConsultaCliCodCliente( auxDataSet.FieldByName('cli_codcliente').AsString);
                           mskCliente.Text     :=  auxConsultaCliente.FieldByName('codigocliente').AsString;
                           FreeAndNil(auxConsultaCliente);
                           mskIndicador.Text   := dmORC.ConsultaCodigoVendedor(auxDataSet.FieldByName('ven_codvendedor').AsString);
                           FreeAndNil(auxdataset);
                           //puxa os dados do cliente
                           auxDataSet          := dmORC.ConsultaCliente(mskCliente.text);
                           if not auxDataSet.IsEmpty then
                           begin
                                 mskCliente.Enabled := False;
                                 auxDataSet.First;
                           end;
                           lblCliente.Caption  := auxDataSet.FieldByName('NOME').AsString;
                           mskEndereco.Text    := auxDataSet.FieldByName('ENDERECO').AsString;
                           edBairro.Text       := auxDataSet.FieldByName('BAIRRO').AsString;
                           edMunicipio.Text    := auxDataSet.FieldByName('CIDADE').AsString;
                           mskFone.Text        := auxDataSet.FieldByName('FONE').AsString;
                           cbUF.ItemIndex      := cbUF.Items.IndexOf(auxDataSet.FieldByName('ESTADO').AsString);
                           mskNome.Text        := auxDataSet.FieldByName('completo').AsString;
                           FreeAndNil(auxDataSet);

                           //puxa os dados do indicador (vendedor)
                           auxDataSet          := dmORC.ConsultaVendedor(mskIndicador.Text);
                           mskIndicador.Enabled := auxDataSet.IsEmpty;
                           lblVendedor.Caption := auxDataSet.FieldByName('NOME').AsString;
                           FreeAndNil(auxDataSet);
                     end;
                     FreeAndNil(auxDataSet);
                     auxDataSet          := dmORC.ConsultaDetalhePedido(mskControle.Text);
                     auxDataSet.Last;
                     auxDataSet.First;
                     cdsItensPedido.EmptyDataSet;
                     while not auxDataSet.Eof do
                     begin
                          cdsItensPedido.Insert;
                          cdsItensPedidoPedido.AsString := mskControle.Text;
                          cdsItensPedidocodigo.AsString := auxDataSet.FieldByName('codigoproduto').AsString;
                          cdsItensPedidoDescricao.AsString := auxDataSet.FieldByName('nomeproduto').AsString;
                          cdsItensPedidoValorUnitario.AsString:= auxDataSet.FieldByName('preco').AsString;
                          cdsItensPedidoQuantidade.AsString := auxDataSet.FieldByName('quantidade').AsString;
                          cdsItensPedidoImpresso.Value      := auxDataSet.FieldByName('impresso').AsString;
                          cdsItensPedidoCasasDecimais.Value := auxDataSet.FieldByName('Decimais').AsInteger;
                          cdsItensPedidoSituacao.Value := auxDataSet.FieldByName('CANCELADO').AsInteger;
                          cdsItensPedido.Post;
                          TotalProdutos := TotalProdutos + IfThen(cdsItensPedidoSituacao.AsFloat = 0, cdsItensPedidoTotal.asfloat, 0);
                          auxDataSet.Next;
                     end;
                     FreeAndNil(auxdataset);
                     (Sender as TCustomEdit).Text :=  FormatFloat('000000000000',strtofloatdef((Sender as TCustomEdit).Text,0));
                 end;
      end;
end;

procedure TfrmPDV.mskClienteExit(Sender: TObject);
var
   auxDataSet:TDataSet;
begin
     VerificaHabilitados;
      if not (ActiveControl = nil) then
        if strtofloatdef(mskCliente.Text,0) = 0 then
        begin
             Application.MessageBox('É necessário digitar o nome do cliente para continuar.',TITULO_MENSAGEM,MB_OK + MB_ICONERROR);
             mskCliente.SetFocus;
        end
           else
               begin
                    auxDataSet          := dmORC.ConsultaCliente(floattostr(strtofloatdef(mskCliente.Text,0)));
                    mskCliente.Enabled  := auxDataSet.IsEmpty;
                    lblCliente.Caption  := auxDataSet.FieldByName('COMPLETO').AsString;
                    mskNoMe.Text        := auxDataSet.FieldByName('COMPLETO').AsString;
                    mskEndereco.Text    := auxDataSet.FieldByName('ENDERECO').AsString;
                    edBairro.Text       := auxDataSet.FieldByName('BAIRRO').AsString;
                    edMunicipio.Text    := auxDataSet.FieldByName('CIDADE').AsString;
                    mskFone.Text        := auxDataSet.FieldByName('FONE').AsString;
                    cbUF.ItemIndex      := cbUF.Items.IndexOf(auxDataSet.FieldByName('ESTADO').AsString);
                    //puxar os dados do vendedor caso já esteja no cadastro do cliente.
                    if not auxDataSet.FieldByName('VEN_CODVENDEDOR').IsNull THEN
                     begin
                         mskIndicador.Text := dmORC.ConsultaCodigoVendedor(auxDataSet.FieldByName('VEN_CODVENDEDOR').AsString);  //auxDataSet.FieldByName('CODIGOVENDEDOR').AsString;
                         mskIndicador.OnExit(Self);
                     end;
                    FreeAndNil(auxdataset);
               end;
end;

procedure TfrmPDV.mskIndicadorExit(Sender: TObject);
var auxdataset:TDataSet;
begin
     VerificaHabilitados;
      if not (ActiveControl = nil) then
      begin
            auxdataset := dmORC.ConsultaVendedor(mskIndicador.Text);
            if auxdataset.IsEmpty then
            begin
                 Application.messagebox( Pchar('É necessário digitar o número do(a) ' + lblIndicador.Caption + ' para continuar.'),
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
                    FreeAndNil(auxdataset );
               end;
      end;
end;

procedure TfrmPDV.VerificaHabilitados;
var
   aux,I:Integer;
begin
     { TODO -oCharles -cImplementação : Tentar tirar o flicker dos botoes. }
    if ActiveControl <> nil then
    begin
        aux := strtointdef(LeINI('Componentes',ActiveControl.Name,'dados\pdv_del.ini'),0);
        for i := 0 to actAcoes.ActionCount -1 do
        begin
             if (actAcoes.Actions[i] as TAction).Enabled  <> Boolean(aux and (actAcoes.Actions[i] as TAction).Tag) then
                (actAcoes.Actions[i] as TAction).Enabled :=  Boolean(aux and (actAcoes.Actions[i] as TAction).Tag);
        end;
    end;
end;

procedure TfrmPDV.mskControleKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9',#8]) then
        key := #0;
     if (key = DecimalSeparator) and (Pos(DecimalSeparator,(Sender as TCustomEdit).Text) > 0) then
        key := #0;
end;

procedure TfrmPDV.cbTipoEndChange(Sender: TObject);
var
   auxDataSet:TDataSet;
begin
    auxDataSet := dmORC.ConsultaCliente(mskCliente.Text);
    mskEndereco.Text    := auxDataSet.FieldByName('ENDERECO').AsString;
    edBairro.Text       := auxDataSet.FieldByName('BAIRRO').AsString;
    edMunicipio.Text    := auxDataSet.FieldByName('CIDADE').AsString;
    mskFone.Text        := auxDataSet.FieldByName('FONE').AsString;
    cbUF.ItemIndex      := cbUF.Items.IndexOf(auxDataSet.FieldByName('ESTADO').AsString);
    mskNome.Text        := auxDataSet.FieldByName('Completo').AsString;
    freeandnil(auxDataSet);
end;

procedure TfrmPDV.Imprime();
var
   LeituraX:FLeituraX;
   TextoNF:FTextoNF;
   FecharCupom:FFecharCupom;
   hand :THandle;
   straux:string;
   cupom:TStrings;
   total_pedido :Real;
   i :Integer;
   txtFile:TextFile;
   auxdataset:TDataSet;
begin
     straux := ExtractFilePath(application.ExeName)+LeINI('modulos','dll_ECF');
     auxdataset := dmORC.ConsultaPedido(mskControle.Text);
     total_pedido := auxdataset.FieldByName('TOTALPRODUTOS').AsFloat;
     //dados que serão impressos.
     cupom := TStringList.Create;
     cupom.Clear;
     cupom.Add('----------------------------------------');
     cupom.Add('DATA    : ' + DateToStr(NOW) + ' HORA : ' + TimeToStr(Now));
     cupom.Add(mskControle.EditLabel.Caption + ' ' + mskControle.Text);
     cupom.Add('ITEM    CODIGO           DESCRICAO');
     cupom.Add('QUANTIDADE x VALOR UNIT.     VALOR ('+ CurrencyString + ')');
     cupom.Add('----------------------------------------');
     cdsItensPedido.First;
     log('Numero de itens' + IntToStr(cdsItensPedido.RecordCount));
     while not cdsItensPedido.Eof do
     begin
          cupom.Add(Format('%.3d %.13d %s ',[ cdsItensPedido.RecNo,
                                            cdsItensPedidocodigo.AsInteger,
                                            cdsItensPedidoDescricao.Value ]));
          cupom.Add(Format('%3.3fx%11.2f = '+CurrencyString+'%17.2f',[ cdsItensPedidoQuantidade.Value,
                                                        cdsItensPedidoValorUnitario.Value,
                                                        cdsItensPedidoTotal.Value ]));
          cdsItensPedido.Next;
     end;
     cupom.Add(Format('TOT. %34.2f',[total_pedido]));
     cupom.Add('----------------------------------------');
     cupom.Add('');

     //Corrigido - 28/04/2003 - Puxa o acréscimo digitado
     //pelo operador. - Charles
    if auxdataset.FieldByName('DESPESASACESSORIAS').AsFloat > 0 then
    begin
       cupom.Add( Format( 'SERVICO = %s %f',
                  [ currencystring,auxdataset.FieldByName('DESPESASACESSORIAS').AsFloat]));

       cupom.Add( Format( 'TOT A PAGAR = %s %-8.2f',
                  [ currencystring, total_pedido + auxdataset.FieldByName('DESPESASACESSORIAS').AsFloat]));
    end;

     cupom.Add('');
     cupom.Add(CenterText(lblIndicador.Caption + ' ' + mskIndicador.Text, 40));
     if auxdataset.FieldByName('NUMPESSOAS').Value > 1 then
        cupom.add(format('Total por pessoa (%d) '+CurrencyString+'%8.2f',[ auxdataset.FieldByName('NUMPESSOAS').AsInteger,
                                                         RoundUP((total_pedido + auxdataset.FieldByName('despesasacessorias').AsFloat) / auxdataset.FieldByName('NUMPESSOAS').AsFloat) ]));
     cupom.Add('----------------------------------------');

     CenterText('DADOS DO CLIENTE',40);
     cupom.Add('NOME        : ' + mskNome.Text);
     cupom.Add('ENDERECO    : ' + mskEndereco.Text);
     cupom.Add('BAIRRO      : ' + edBairro.Text);
     cupom.Add('MUNICIPIO   : ' + edMunicipio.Text + ' ESTADO: ' + cbUF.Text);
     cupom.Add('FONE        : ' + mskFone.Text);
     cupom.Add('OBSERCACOES :');
     CUpom.Add(auxdataset.FieldByName('observacao').Text);
     cupom.Add('----------'+ TITULO_MENSAGEM + '----------');


     case Leini(TIPO_TERMINAL,'Tipo_imp') of
          1: //dll ecf
            begin
                 hand := LoadLibrary( PChar(STRAUX));
                 @LeituraX := GetProcAddress(hand,'LeituraX');
                 @TextoNF  := GetProcAddress(hand,'TextoNF');
                 @FecharCupom := GetProcAddress(hand, 'FecharCupom');
                 LeituraX( StrToInt(leini('terminal','ModECF')),
                           StrToInt(leini('terminal','comECF')),'1');
                 for i := 0 to cupom.Count -1 do
                 begin
                      case TextoNF( StrToInt(leini('terminal','ModECF')),
                                         StrToInt(leini('terminal','comECF')),
                                         cupom.Strings[i],'0')[1] of
                          '#':
                             Application.MessageBox( Pchar('Ocorreu um erro durante o envio do comando para a impressora'#13 +
                                                     'Erro: ' + Copy(strAux,2,Length(straux))), TITULO_MENSAGEM, MB_ICONERROR + MB_OK);
                      end;

                 end;

                 case FecharCupom( StrToInt(leini('terminal','ModECF')),
                                  StrToInt(leini('terminal','comECF')),
                                  '0','0',
                                  leini('cortesia', 'MCLinha1'),
                                  leini('cortesia', 'MCLinha2'),
                                  leini('cortesia', 'MCLinha3'),
                                  leini('cortesia', 'MCLinha4'),
                                  leini('cortesia', 'MCLinha5'),
                                  leini('cortesia', 'MCLinha6'),
                                  leini('cortesia', 'MCLinha7'),
                                  leini('cortesia', 'MCLinha8'))[1] of
                      '#':
                          Application.MessageBox( Pchar('Ocorreu um erro durante o envio do comando para a impressora'#13 +
                                                  'Erro: ' + Copy(strAux,2,Length(straux))), TITULO_MENSAGEM, MB_ICONERROR + MB_OK);
                 end;
          end;
          2: // windows 40 colunas
            begin
                 AssignFile(txtFile,dmORC.ConsultaPathImpressora(LeINI(TIPO_TERMINAL,'IMPRESSORAPEDIDO')));
                 Rewrite(txtFile);
                 for i := 0 to cupom.Count - 1 do
                 begin
                      straux := cupom.Strings[i];
                      if Length(straux) > 40 then
                      begin
                          Insert(#10#13,straux,40);
                          cupom.Strings[i] := straux;
                      end;
                 end;
                 for i := 0 to cupom.Count - 1 do
                     Writeln(txtfile,cupom.Strings[i]);
                 with TIniFile.Create('dados\Autocom.ini') do
                 begin
                     ReadSectionValues('CORTESIA',cupom);
                     Free;
                 end;
                 for i := 0 to cupom.Count - 1 do
                     Writeln(txtfile,Copy(cupom.Strings[i],Pos('=',cupom.Strings[i])+1,40));
                 for i := 1 to strtointdef(leini(TIPO_TERMINAL, 'SaltoEntreCupom'),9) do
                     writeln(txtfile,' ');
                 closefile(txtFile);
          end;
     end;
     FreeAndNil(cupom);
     freeandnil(auxdataset);
end;

procedure TfrmPDV.lblClienteDblClick(Sender: TObject);
begin
     try
        Self.Visible := False;
        FreeLibrary(LoadLibrary('cadcli.dll'));
        Self.Visible := True;
        except
              begin
                Self.Visible := True;
                Application.MessageBox('Ocorreu um erro ao executar o módulo de cadastro.',
                                       TITULO_MENSAGEM,MB_OK + MB_ICONERROR);
              end;
     end;
end;

procedure TfrmPDV.ApplicationEventsException(Sender: TObject;
  E: Exception);
begin
     log( Format(' %s %s ' ,[(Sender as TComponent).name, e.Message]));
     { DONE -ocharles -cArranjo técnico : Não esquecer de tirar ini antes da feira. }
     //Mostra a exceção apenas se estiver configurada.
     if strtointdef(leini(TIPO_TERMINAL,'prolixo'),0) = 1 then
        Application.ShowException(e);
end;

procedure TfrmPDV.ApplicationEventsActionExecute(Action: TBasicAction;
  var Handled: Boolean);
begin
     log(Action.Name);
end;

procedure TfrmPDV.cbUFKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key = VK_RETURN then
        Perform(WM_NEXTDLGCTL,0,0);
end;

procedure TfrmPDV.mskControleEnter(Sender: TObject);
begin
     VerificaHabilitados;
     if mskCliente.Visible then
        mskCliente.Clear
        else
            mskCliente.Text := '0';
end;

procedure TfrmPDV.mskProdutoKeyPress(Sender: TObject; var Key: Char);
begin
     //prefiro fazer o controle dessa forma. Charles.
     if key = '.' then
        key := ',';
     if not (key in ['0'..'9',#8]) then
        key := #0;
end;

procedure TfrmPDV.SetTotalProdutos(const Value: Real);
var
   auxdataset:TDataSet;
begin
     FTotalProdutos := Value;
     //calcula o valor total do pedido para painel com o total
     // e  a etiqueta com o total + servico.
    lblTotal.Caption := CurrencyString + FloatToStrf(FTotalProdutos,ffFixed,18,2);
    if LeINI('terminal','usa_servico') = 1 then
    begin
         if mskControle.Text <> '' then
         begin
             auxDataset := dmORC.ConsultaPedido(mskControle.Text);
             if  auxDataset.FieldByName('despesasacessorias').AsFloat > 0 then
                lblTotalComServico.Caption := 'Total + Serviço ' + CurrencyString +' '+  FloatToStrF(FTotalProdutos +  auxDataset.FieldByName('despesasacessorias').AsFloat ,ffFixed,18,2)
             else
                 if strtointdef(LeINI(tipo_terminal,'servico_per'),0) > 0 then
                    lblTotalComServico.Caption := 'Total + Serviço  ' + CurrencyString  +' '+ floattostrf(FTotalProdutos + dmORC.CalculaAcrescimo(floattostr(FTotalProdutos) ,LeINI('terminal','servico_per') / 100),ffFixed,18,2)
                     else
                          lblTotalComServico.Caption := 'Total + Serviço ' + CurrencyString +' '+  FloatToStrF(FTotalProdutos + StrToFloat(LeINI('terminal','servico_val'))/ 100,ffFixed,18,2);
              FreeAndNil(auxdataset);
         end;
     end;
end;

procedure TfrmPDV.SetPedidoAberto(const Value: Boolean);
begin
  FPedidoAberto := Value;
end;

procedure TfrmPDV.GBClienteExit(Sender: TObject);
var
   auxdataset:TDataSet;
begin
     if activecontrol <> nil then
         if (Trim(mskEndereco.Text) = '') then
         begin
              Application.MessageBox('É necessário digitar o endereço antes de continuar.',TITULO_MENSAGEM, MB_OK + MB_ICONEXCLAMATION);
              mskEndereco.Text;
         end
            else
            begin
              auxdataset := dmORc.ConsultaCliente(mskCliente.Text);
              if auxdataset.IsEmpty then
              begin
                   if Trim(msknome.Text) = '' then
                   begin
                        Application.MessageBox('É necessário digitar o nome do cliente antes de continuar.',TITULO_MENSAGEM, MB_OK + MB_ICONEXCLAMATION);
                        mskNome.SetFocus;
                        Exit;                        
                   end;
                   dmORC.RunSQL( 'INSERT INTO PESSOA '+
                                 '(TPE_CODTIPOPESSOA, PES_NOME_A, TELEFONE1) ' +
                                 'VALUES (' +
                                 QuotedStr('1') + ',' +
                                 QuotedStr(mskNome.Text) + ',' +
                                 QuotedStr(mskCliente.Text) + ')'
                               );
                   FreeAndNil(auxdataset);
                   Log('INSERINDO DADOS DA PESSOA.');
                   DMORC.Commit;
                   dmORC.RunSQL('SELECT * FROM PESSOA WHERE PES_NOME_A = '  + QuotedStr(mskNome.TEXT) + 'AND TELEFONE1 = ' + QuotedStr(mskCliente.Text), auxdataset);
                   DMORC.Commit;
                   Log('INSERINDO ENDERECO DO CLIENTE.');
                   DMORC.RunSQL( 'INSERT INTO ENDERECOPESSOA ' +
                                 '(PES_CODPESSOA, TEN_CODTIPOENDERECO, ENP_ENDERECO_A, '+
                                 'ENP_BAIRRO_A, ENP_CIDADE_A, ENP_ESTADO_A, ENP_TELEFONE_A ) ' +
                                 'VALUES' +
                                 '( ' + auxdataset.FieldByName('PES_CODPESSOA').AsString +', '+
                                       LEINI(TIPO_TERMINAL,'TIPOENDERECOENTREGA') +', '+
                                       QuotedStr(mskEndereco.Text) + ', ' +
                                       QuotedStr(edBairro.Text) +', '+
                                       QuotedStr(edMunicipio.Text) + ', '+
                                       QuotedStr(cbUF.Text) + ', '+
                                       QuotedStr(mskfone.Text) + ' )');
                   DMORC.Commit;

                   Log('INSERINDO DADOS DO CLIENTE.');
                   DMORC.RunSQL( ' INSERT INTO CLIENTE '+
                                   '( CODIGOCLIENTE, PES_CODPESSOA, CFG_CODCONFIG )' +
                                   'VALUES (' +
                                   mskCliente.Text + ', '+
                                   auxdataset.FieldByName('PES_CODPESSOA').AsString +', '+
                                   '1)');
              end
                 else
                     begin
                          //atualiza os dados do cliente.
                          LOG('ATUALIZANDO OS DADOS DO CLIENTE. ');
                          dmorc.RunSQL( 'UPDATE ENDERECOPESSOA SET ' +
                                        'ENP_ENDERECO_A = ' + QuotedStr(mskEndereco.Text) + ', ' +
                                        'ENP_BAIRRO_A   = ' + QuotedStr(edBairro.Text) +', '+
                                        'ENP_CIDADE_A   = ' + QuotedStr(edMunicipio.Text) + ', '+
                                        'ENP_ESTADO_A   = ' + QuotedStr(cbUF.Text) + ', '+
                                        'ENP_TELEFONE_A = ' + QuotedStr(mskfone.Text) +
                                        ' WHERE PES_CODPESSOA = ' + auxdataset.FieldByName('pes_codpessoa').AsString
                                        );
                          Log('ATUALIZANDO PESSOA.');
                          dmorc.RunSQL( 'UPDATE PESSOA SET ' +
                                        'PES_NOME_A = ' + QuotedStr(mskNome.Text) + ', ' +
                                        'PES_APELIDO_A = ' + QuotedStr(mskNome.Text) +
                                        'WHERE PES_CODPESSOA = ' + auxdataset.FieldByName('pes_codpessoa').AsString);
                     end;
              DMORC.Commit;
              mskClienteExit(mskCliente);
              FreeAndNil(auxdataset);
            end;
end;

procedure TfrmPDV.edObservacaoEnter(Sender: TObject);
begin
     VerificaHabilitados;
end;

procedure TfrmPDV.mskClienteKeyPress(Sender: TObject; var Key: Char);
begin
     if not (key in ['0'..'9',#8]) then
        Key  := #0;
end;

procedure TfrmPDV.printgrill(pedido: integer; nome_pedido,
  nome_vendedor: string);
var
   a:integer;
   v_codigo, v_quantidade, v_desc, v_obs:string;
   grill:TextFile;
   cupom:Tstrings;
   dsImpressoras, dsPT,
   auxDataset:TDataSet;

begin
{Objetivo: Realizar a impressão dos produtos em impressoras remotas para produção
Esta função deve ser usadas nos módulos de venda que realizam pedidos de venda  ,
tais como: Venda Pedido, Micro Terminais e Comandas eletrônicas                 }
     Log(Format('Printgrill - pedido:%d - vendedor %s - NomePedido', [pedido,nome_vendedor, nome_pedido]));

     dmORC.Commit;

     dmorc.RunSQL('select codigoimpressora,caminhoimpressora,NOMEIMPRESSORA from impressora order by codigoimpressora;',dsImpressoras);

     try
        if dsImpressoras.IsEmpty=false then
           begin
              dsImpressoras.first;
              while not dsImpressoras.eof do
                 begin
                    dmORC.RunSQL('select ppv.codigoproduto, ppv.quantidade, ppv.observacao, prod.nomeproduto, ppv.codigopedidovenda '+
                             'from produtopedidovenda ppv, produto prod ,pedidovenda pv, subgrupoproduto sg, grupoproduto g '+
                             'where ppv.codigoproduto=prod.codigoproduto '+
                             ' and (ppv.impresso<>'+chr(39)+'X'+chr(39)+' or ppv.impresso is null)'+
                             ' and (ppv.cancelado<>'+'1'+' or ppv.cancelado is null)'+
                             ' and ppv.codigopedidovenda=pv.codigopedidovenda'+
                             ' and pv.numeropedido='+inttostr(pedido)+
                             ' and prod.codigosubgrupoproduto=sg.codigosubgrupoproduto'+
                             ' and sg.codigogrupoproduto=g.codigogrupoproduto'+
                             ' and g.codigoimpressora='+dsImpressoras.fieldbyname('codigoimpressora').asstring +
                             ' ORDER BY ppv.codigoprodutopedido ', dsPT);
                    if dspt.IsEmpty=false then
                       begin
                          dmorc.runsql('select p.pes_nome_a '+
                             'from pessoa p, vendedor v,pedidovenda pv '+
                             'where pv.ven_codvendedor=v.ven_codvendedor '+
                             ' and v.pes_codpessoa=p.pes_codpessoa '+
                             ' and pv.numeropedido='+inttostr(pedido),auxDataset);

                          cupom := TStringList.Create;
                          cupom.add('******************************');
                          cupom.add('  '+nome_pedido+' : '+inttostr(pedido));
                          cupom.add('******************************');
                          cupom.add('  '+nome_vendedor+' : '+auxDataset.fieldbyname('pes_nome_a').asstring);
                          cupom.add('******************************');
                          cupom.add('Data: '+datetostr(date));
                          cupom.add('Hora: '+timetostr(time));

                          dspt.first;
                          While not dspt.eof do
                             Begin
                                v_codigo:=dspt.fieldbyname('codigoproduto').asstring;
                                v_quantidade:=dspt.fieldbyname('quantidade').asstring;
                                v_desc:=dspt.fieldbyname('nomeproduto').asstring;
                                v_obs:=trim(dspt.fieldbyname('observacao').asstring);

                                cupom.add(copy(v_quantidade,1,4)+'.'+copy(v_quantidade,5,3)+' ['+v_desc+']');
                                if length(v_obs)>0 then
                                   begin
                                      cupom.add(v_obs);
                                   end;
                                dmorc.runsql('update produtopedidovenda set impresso='+chr(39)+'X'+chr(39)+
                                ' where codigoproduto='+v_codigo+
                                ' and codigopedidovenda='+dspt.fieldbyname('codigopedidovenda').asstring,auxDataset);

                                dspt.next;
                             End;
                          cupom.add('Area de impressao: '+trim(dsImpressoras.fieldbyname('NOMEIMPRESSORA').asstring));
                          //cupom.add('Terminal: Micro-terminal '+inttostr(codigo));
                          cupom.add('-- Sistema Autocom --');
                          cupom.add(chr(10)+chr(13));
                          cupom.add(chr(10)+chr(13));
                          cupom.add(chr(10)+chr(13));
                          cupom.add(chr(10)+chr(13));
                          cupom.add(chr(10)+chr(13));
                          cupom.add(chr(10)+chr(13));
                          cupom.add(chr(10)+chr(13));

                          AssignFile(grill, trim(dsImpressoras.fieldbyname('caminhoimpressora').asstring));
                          rewrite(grill);
                          for a:=0 to cupom.count-1 do
                             begin
                                writeln(grill,cupom.Strings[a]);
                             end;
                          closefile(grill);
                          FreeAndNil(cupom);
                       end;
                    dsImpressoras.next;
                 end;
           end;

        dmorc.Commit;
        //LogSend('logs\MT' + IntToStr(Codigo)+'\' + FormatDateTime('YYYYMMDD',Date) + ' SMT.LOG','Printgrill do pedido '+inttostr(pedido)+' OK!!!');

     except
     end;

     if Assigned(dsImpressoras) then
        freeandnil(dsImpressoras);
     if Assigned(dsPT) then
        freeandnil(dsPT);
     if Assigned(auxDataset) then
        freeandnil(auxDataset);
end;

end.

//******************************************************************************
//*                          End of File uOrcamento.pas                        |
//******************************************************************************
