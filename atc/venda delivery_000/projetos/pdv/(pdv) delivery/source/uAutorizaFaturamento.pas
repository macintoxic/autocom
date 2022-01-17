//******************************************************************************
// 
//                 UNIT UAUTORIZAFATURAMENTO (-)
// 
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           uAutorizaFaturamento.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: uAutorizaFaturamento.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:      
// 
// 1.0.0 01/01/2001 First Version
// 
//******************************************************************************

unit uAutorizaFaturamento;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, db, IBQuery;

type
  TqrAutorizacao = class(TQuickRep)
    TitleBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel2: TQRLabel;
    qrChildFaturamento: TQRChildBand;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel3: TQRLabel;
    qrCobranca: TQRChildBand;
    QRLabel29: TQRLabel;
    QRLabel30: TQRLabel;
    QRLabel32: TQRLabel;
    QRLabel27: TQRLabel;
    QRLabel31: TQRLabel;
    a: TQRLabel;
    QRLabel35: TQRLabel;
    QRLabel33: TQRLabel;
    QRLabel36: TQRLabel;
    qrEntrega: TQRChildBand;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRLabel15: TQRLabel;
    qrpagamento: TQRChildBand;
    QRLabel16: TQRLabel;
    QRLabel28: TQRLabel;
    QRLabel43: TQRLabel;
    QRLabel26: TQRLabel;
    QRLabel25: TQRLabel;
    QRSubDetail1: TQRSubDetail;
    qrdbtextQTD: TQRDBText;
    qrdbtextCodigoProduto: TQRDBText;
    qrdbtextNomeProduto: TQRDBText;
    qrdbtextPreco: TQRDBText;
    QRBand3: TQRBand;
    QRLabel42: TQRLabel;
    QRLabel44: TQRLabel;
    QRLabel45: TQRLabel;
    ChildBand2: TQRChildBand;
    QRLabel52: TQRLabel;
    QRShape52: TQRShape;
    ChildBand3: TQRChildBand;
    QRLabel46: TQRLabel;
    QRLabel53: TQRLabel;
    QRLabel51: TQRLabel;
    QRLabel47: TQRLabel;
    QRLabel54: TQRLabel;
    QRLabel55: TQRLabel;
    QRLabel48: TQRLabel;
    QRLabel49: TQRLabel;
    QRLabel50: TQRLabel;
    QRLabel57: TQRLabel;
    QRLabel56: TQRLabel;
    QRShape1: TQRShape;
    ChildBand4: TQRChildBand;
    QRLabel58: TQRLabel;
    QRLabel59: TQRLabel;
    QRLabel60: TQRLabel;
    QRLabel61: TQRLabel;
    QRLabel62: TQRLabel;
    QRLabel12: TQRLabel;
    lblNomeCompleto: TQRLabel;
    lblEnderecoFaturamento: TQRLabel;
    lblFone: TQRLabel;
    lblCNPJ: TQRLabel;
    lblCelular: TQRLabel;
    lblRG: TQRLabel;
    lblEstado: TQRLabel;
    lblBairroFaturamento: TQRLabel;
    lblCidade: TQRLabel;
    lblFax: TQRLabel;
    lblCEP: TQRLabel;
    lblEnderecoCobranca: TQRLabel;
    lblBairroCobranca: TQRLabel;
    lblCidadeCobranca: TQRLabel;
    lblCepCobranca: TQRLabel;
    lblFoneCobranca: TQRLabel;
    lblCelCObranca: TQRLabel;
    lblEstadoCobranca: TQRLabel;
    lblFaxCobranca: TQRLabel;
    lblEnderecoEntrega: TQRLabel;
    lblBairroEntrega: TQRLabel;
    lblcidadeEntrega: TQRLabel;
    lblCepEntrega: TQRLabel;
    lblFoneEntrega: TQRLabel;
    lblEstadoEntrega: TQRLabel;
    lblCelEntrega: TQRLabel;
    lblFaxEntrega: TQRLabel;
    QRLabel34: TQRLabel;
    lblAcrescimo: TQRLabel;
    lblDescontos: TQRLabel;
    lblTotal: TQRLabel;
    QRLabel37: TQRLabel;
    qrlblFormaPagamento: TQRLabel;
    lblIntervaloParcelas: TQRLabel;
    lblDataPrimeiraParcela: TQRLabel;
    lblNumeroParcelas: TQRLabel;
    memOBS: TQRLabel;
    procedure QRLabel37Print(sender: TObject; var Value: String);
    procedure lblAcrescimoPrint(sender: TObject; var Value: String);
  private
    FPedido: string;
    dspedido,
    dsdetalhe:TDataSet;
    procedure SetPedido(const Value: string);
  public
        dsFormaPagamento:^TDataSet;
        property  Pedido:string read FPedido write SetPedido;
  end;

var
  qrAutorizacao: TqrAutorizacao;

implementation
uses udmPDV;
{$R *.DFM}

{ TqrAutorizacao }


{-----------------------------------------------------------------------------
  Procedure: TqrAutorizacao.SetPedido
  Autor:    charles
  Data:      26-mar-2003
  Argumentos: const Value: string
  Retorno:    None

  Ajusta a propriedade do pedido e os labels que são feitos a partir de querys.
-----------------------------------------------------------------------------}
procedure TqrAutorizacao.SetPedido(const Value: string);
var i:Integer;
begin
     dspedido := dmORC.ConsultaPedido(value);
     dsdetalhe:= dmORC.ConsultaDetalhePedido(value);

     QRSubDetail1.DataSet := dsdetalhe;

     //seta o dataset dos labels dos items do pedido
     // para o dataset dsdetalhe.
     for i := 0 to QRSubDetail1.ControlCount - 1 do
         if QRSubDetail1.Controls[i] is TQRDBText then
            (QRSubDetail1.Controls[i] as TQRDBText).DataSet := dsdetalhe;

     //ponteiro que veio da tela de fechamento do pedido.
     with dsformapagamento^ do
     begin
          qrlblFormaPagamento.Caption  :=   FieldByName('FORMAFATURAMENTO').AsString;
          lblIntervaloParcelas.Caption :=   FieldByName('CONDICAOPAGAMENTO').AsString;
          lblDataPrimeiraParcela.Caption := DateTimeToStr(Now +  FieldByName('PRIMEIRAPARCELA').Value);
          lblNumeroParcelas.Caption      := FieldByName('NUMEROPARCELAS').AsString;
     end;

     lblAcrescimo.Caption := dspedido.FieldByName('DESPESASACESSORIAS').AsString;
     lblDescontos.Caption := dspedido.FieldByName('DESCONTO').AsString;
     lblTotal.Caption     := dspedido.FieldByName('TOTALPEDIDO').AsString;
     memOBS.Caption       := dspedido.FieldByName('OBSERVACAO').AsString;
     FreeAndNil(dspedido);
     FPedido := Value;
end;

procedure TqrAutorizacao.QRLabel37Print(sender: TObject;
  var Value: String);
begin
     //calcula o total do pedido
     Value := FloatToStrF(dsdetalhe.FieldByName('quantidade').Value * dsdetalhe.FieldByName('preco').Value,ffFixed,18,2);
end;

procedure TqrAutorizacao.lblAcrescimoPrint(sender: TObject;
  var Value: String);
begin
     //formata o texto do label
     Value := FloatToStrF(StrToFloat(Value),ffFixed,18,2)
end;

end.
 
//******************************************************************************
//*                          End of File uAutorizaFaturamento.pas
//******************************************************************************
