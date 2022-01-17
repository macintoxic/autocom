//******************************************************************************
// 
//                 UNIT UFECHAPEDIDO (-)
// 
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           uFechaPedido.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: uFechaPedido.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:      
// 
// 1.0.0 01/01/2001 First Version
//
//******************************************************************************

unit uFechaPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  ActnList, XPStyleActnCtrls, ActnMan, StdCtrls, ExtCtrls, db,
  ComCtrls, Buttons;

type
  TfrmFechaFaturamento = class(TForm)
    GroupBox2: TGroupBox;
    spdVoltar: TSpeedButton;
    spdEnviar: TSpeedButton;
    ActionManager: TActionManager;
    Action1: TAction;
    Action2: TAction;
    Panel1: TPanel;
    lbFormaPagamentos: TTreeView;
    Panel2: TPanel;
    Panel3: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    lblParcelas: TLabel;
    lblDataPrimeira: TLabel;
    lblIntervalo: TLabel;
    Panel_valor: TPanel;
    GroupBox1: TGroupBox;
    Label7: TLabel;
    Label6: TLabel;
    lblPesoLiquido: TLabel;
    lblPesobruto: TLabel;
    GroupBox3: TGroupBox;
    Label2: TLabel;
    Label18: TLabel;
    Label8: TLabel;
    lblTotalCupom: TLabel;
    edOBSAcrescimo: TEdit;
    edOBSDesconto: TEdit;
    Shape1: TShape;
    GroupBox4: TGroupBox;
    Label9: TLabel;
    memObs: TMemo;
    Label13: TLabel;
    mskDesconto: TEdit;
    mskAcrescimo: TEdit;
    procedure lbFormaPagamentosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Action1Execute(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mskDescontoExit(Sender: TObject);
    procedure mskAcrescimoKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Action2Execute(Sender: TObject);
    procedure memObsEnter(Sender: TObject);
    procedure memObsExit(Sender: TObject);
    procedure lbFormaPagamentosChange(Sender: TObject; Node: TTreeNode);
    procedure lbFormaPagamentosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FTabelaPreco,
    FPedido,
    FCodigoPedido:string;
    FTotalPedido:Real;
    procedure SetTabelaPreco(Tabela:string);
    procedure SetPedido(NumeroPedido:string);
    procedure SetTotalPedido(const Value: real);
  public
    { Public declarations }
    dsFormasPagamento:TDataSet;
    property TabelaPreco:string read FTabelaPreco Write SetTabelaPreco;
    property Pedido:string      read FPedido Write SetPedido;
    property TotalPedido:real read FTotalPedido write SetTotalPedido;
  end;

var
  frmFechaFaturamento: TfrmFechaFaturamento;

implementation
uses
    udmPDV, DateUtils, MaskUtils, uRotinas, uSelecionaEnd;
{$R *.dfm}

procedure TfrmFechaFaturamento.lbFormaPagamentosClick(Sender: TObject);
begin
     dsFormasPagamento.GotoBookmark(lbFormaPagamentos.Selected.Data);
     lblParcelas.Caption := dsFormasPagamento.FieldByName('numeroparcelas').AsString;
     lblIntervalo.Caption := dsFormasPagamento.FieldByName('intervaloparcelas').AsString;
     lblDataPrimeira.Caption := DateToStr(IncDay(now, dsFormasPagamento.FieldByName('primeiraparcela').AsInteger))
end;

procedure TfrmFechaFaturamento.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     FreeAndNil(dsFormasPagamento);
end;


procedure TfrmFechaFaturamento.SetTabelaPreco(Tabela: string);
begin
     FTabelaPreco := Tabela;
     dmORC.RunSQL( 'SELECT F.FORMAFATURAMENTO || '' - '' ||' +
                   ' C.CONDICAOPAGAMENTO,F.FORMAFATURAMENTO , '+
                   ' C.*, F.CODIGOTABELAPRECO FROM FORMAFATURAMENTO F,CONDICAOPAGAMENTO C '+
                   ' WHERE '+
                   ' C.CODIGOFORMAFATURAMENTO = F.CODIGOFORMAFATURAMENTO AND F.CODIGOTABELAPRECO = ' + FTabelaPreco,dsFormasPagamento);
     if dsFormasPagamento.IsEmpty then
         dmORC.RunSQL( 'SELECT F.FORMAFATURAMENTO || '' - '' ||' +
                       ' C.CONDICAOPAGAMENTO,F.FORMAFATURAMENTO , '+
                       ' C.*, F.CODIGOTABELAPRECO FROM FORMAFATURAMENTO F,CONDICAOPAGAMENTO C '+
                       ' WHERE '+
                       ' C.CODIGOFORMAFATURAMENTO = F.CODIGOFORMAFATURAMENTO',dsFormasPagamento);
       while not dsformaspagamento.Eof do
       begin
            lbFormaPagamentos.Items.AddObject(lbFormaPagamentos.TopItem, dsFormasPagamento.FieldByName('F_1').AsString,dsFormasPagamento.GetBookmark);
            dsFormasPagamento.Next;
       end;
       //forca selecionar o primeiro item da lista.
       lbFormaPagamentos.Select(lbFormaPagamentos.Items[0]);
       lbFormaPagamentosClick(nil);
end;

procedure TfrmFechaFaturamento.Action1Execute(Sender: TObject);
begin
     spdVoltar.Tag := 1; //para marcar se cancelou esta tela ou nao.
     Close;
end;

procedure TfrmFechaFaturamento.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
     CanClose := True;
     if Boolean(spdVoltar.Tag) then
        ModalResult := mrCancel
        else
        ModalResult := mrOK;
end;

{-----------------------------------------------------------------------------
  Procedure: TfrmFechaFaturamento.SetPedido
  Autor:    charles
  Data:      21-mar-2003
  Argumentos: NumeroPedido: string
  Retorno:    None

  Quando eu passo número do pedido para o form, já realizo as consultas para
  colocar os dados nos componentes do form.
-----------------------------------------------------------------------------}
procedure TfrmFechaFaturamento.SetPedido(NumeroPedido: string);
var
   auxdataset:TDataSet;
   pesoLiquido,
   PesoBruto:Real;
begin
     pesoLiquido           := 0;
     PesoBruto             := 0;
     FPedido               := NumeroPedido;
     auxdataset            := dmORC.ConsultaPedido(NumeroPedido);
     mskDesconto.Text      := FormatFloat('0.00', auxdataset.FieldByName('DESCONTO').AsFloat);
     lblTotalCupom.Caption :=  FormatFloat('0.00',auxdataset.FieldByName('totalpedido').AsFloat);
     FCodigoPedido         := auxdataset.FieldByName('codigopedidovenda').AsString;
     TotalPedido           := auxdataset.FieldByName('TotalPedido').AsFloat;
     mskAcrescimo.Text     := FORMATFLOAT('0.00', auxdataset.FieldByName('DESPESASACESSORIAS').AsFloat);
     edOBSAcrescimo.Text   := auxdataset.FieldByName('DESCRICAOACRESCIMO').AsString ;
     edOBSDesconto.Text    := auxdataset.FieldByName('DESCRICAODESCONTO').AsString;
     FreeAndNil(auxdataset);
     auxdataset := dmORC.ConsultaDetalhePedido(NumeroPedido);
     while not auxdataset.Eof do
     begin
          pesoLiquido := pesoLiquido +  auxdataset.FieldByName('pesoliquido').AsFloat;
          PesoBruto   := PesoBruto + auxdataset.FieldByName('pesoliquido').AsFloat;
          auxdataset.Next;
     end;
     lblPesoLiquido.Caption := FormatFloat('0.000', pesoLiquido);
     lblPesobruto.Caption   := FormatFloat('0.000', PesoBruto);
     freeandnil(auxdataset);
end;

procedure TfrmFechaFaturamento.mskDescontoExit(Sender: TObject);
var
   auxDataSet:TDataSet;
begin
     (Sender as TEdit).Text := FormatFloat('0.00',StrToFloatDef((Sender as TEdit).Text,0));
     auxDataSet             :=  dmORC.ConsultaPedido(Pedido);
     TotalPedido            := auxDataSet.FieldByName('TOTALPEDIDO').AsFloat + StrToFloatDef(mskAcrescimo.Text,0) - StrToFloatDef(mskDesconto.Text,0);
     FreeAndNil(auxDataSet);
end;

procedure TfrmFechaFaturamento.mskAcrescimoKeyPress(Sender: TObject;
  var Key: Char);
begin
     if key = '.' then
        key := ',';
     if not (key in ['0'..'9',#8,DecimalSeparator]) then
        key := #0;
     if (key = DecimalSeparator) and (Pos(DecimalSeparator,(Sender as TCustomEdit).Text) > 0) and
        (Length((Sender as TCustomEdit).Text) <> Length((Sender as TCustomEdit).SelText)) then
        key := #0;
end;

procedure TfrmFechaFaturamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case key of
          VK_RETURN,VK_DOWN: Perform(WM_NEXTDLGCTL,0,0);
          VK_UP: Perform(WM_NEXTDLGCTL,1,0);
     end;
end;

procedure TfrmFechaFaturamento.Action2Execute(Sender: TObject);
begin
  case Application.MessageBox('Confirma a efetivação do pedido?', TITULO_MENSAGEM,MB_YESNOCANCEL +MB_ICONQUESTION) of
        IDYES : begin
              DecimalSeparator := '.';
              dsFormasPagamento.GotoBookmark(lbFormaPagamentos.Selected.Data);
              dmORC.EnviaFaturamento( FPedido,dsFormasPagamento.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString,
                                      FloatToStr(TotalPedido),
                                      memObs.Text,
                                      StringReplace(mskAcrescimo.Text,',','.',[]),
                                      edOBSAcrescimo.Text,
                                      StringReplace(mskDesconto.Text,',','.',[]),
                                      edOBSDesconto.Text);
              frmEnderecos := TfrmEnderecos.Create(self);
              frmEnderecos.Pedido := FPedido;
              //passa um ponteiro para o dataset com as formas de pagamento
              //para o form de seleção de enderecos.
              //Este por sua vez será passado para o relatorio de autorização
              //para a impressão da forma de pagamento utilizada. - charles
              frmEnderecos.dsFormaPagamento := @dsFormasPagamento;
              Self.Hide;
              DecimalSeparator := '.';
              frmEnderecos.ShowModal;
              Close;
        end;
        IDNO : begin
             spdVoltar.Tag := 1;
             Close;
        end;
  end;
end;

procedure TfrmFechaFaturamento.memObsEnter(Sender: TObject);
begin
     KeyPreview := False;
end;

procedure TfrmFechaFaturamento.memObsExit(Sender: TObject);
begin
     KeyPreview := True;
end;

procedure TfrmFechaFaturamento.lbFormaPagamentosChange(Sender: TObject;
  Node: TTreeNode);
begin
     lbFormaPagamentos.OnClick(lbFormaPagamentos);
end;

procedure TfrmFechaFaturamento.lbFormaPagamentosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     if key = VK_RETURN then
        mskAcrescimo.SetFocus;
end;

procedure TfrmFechaFaturamento.SetTotalPedido(const Value: real);
begin
  FTotalPedido          := Value;
  lblTotalCupom.Caption := FloatToStrF(FTotalPedido,ffCurrency,18,2);
end;

end.

//******************************************************************************
//*                          End of File uFechaPedido.pas
//******************************************************************************
