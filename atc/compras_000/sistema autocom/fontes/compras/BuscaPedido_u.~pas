unit BuscaPedido_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids;

type
  TfBuscaPedido = class(TForm)
    grdPedidos: TDBGrid;
    DSPedido: TDataSource;
    Inserir: TBitBtn;
    procedure grdPedidosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
//    procedure CmdProcurarClick(Sender: TObject);
    procedure grdPedidosDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fBuscaPedido: TfBuscaPedido;

implementation

uses Dm_u, MainCompra_u;

{$R *.dfm}

procedure TfBuscaPedido.grdPedidosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_Return then GrdPedidosDblClick(Self);
   if Key = VK_Escape then Close;
end;

{procedure TfBuscaPedido.CmdProcurarClick(Sender: TObject);
begin
   Dm.TblPedidoCompra.close;
   Dm.TblPedidoCompra.SQL.Clear;
   if TxtPesquisa.text='' then
      Dm.TblPedidoCompra.SQL.Add('SELECT numeropedido as Codigo_Compra, data as Data, totalprodutos as TotalProdutos, totalpedido TotalGeral, situacao as Situacao, aprovado as Aprovado FROM'+
                                 '= pedidocompra ORDER BY numeropedido')
   else
   begin
      try
         StrToInt(TxtPesquisa.Text);
//         Dm.TblPedidoCompra.SQL.Add('Select numeropedido, data, totalprodutos, totalpedido, situacao, aprovado from pedidocompra where data='+FormatDateTime('mm/dd/yyyy',TfMainCompra.DatData.date)+
  //                                  'Order by numeropedido');
      except
         Dm.TblPedidoCompra.SQL.Add('Select numeropedido, data, totalprodutos, totalpedido, situacao, aprovado from pedidocompra where numeropedido LIKE  %'+Strtofloat(TxtPesquisa.Text)+'% order by P.CodigoProduto', dm.tblpedidocompra);
      end;
   end;
   Dm.TblProduto.Prepare;
   Dm.TblProduto.Open;
   GrdProdutos.SetFocus;
end;}

procedure TfBuscaPedido.grdPedidosDblClick(Sender: TObject);
begin
   FMainCompra.edtCodCompra.Text:= Dm.tblPedidoCompraNUMEROPEDIDO.AsString;
end;

end.
