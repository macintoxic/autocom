unit BuscaTrans_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, Grids, DBGrids;

type
  TfBuscaTransportadora = class(TForm)
    grdTransportadora: TDBGrid;
    DSTransportadora: TDataSource;
    Panel1: TPanel;
    CmdProcurar: TSpeedButton;
    TxtPesquisa: TEdit;
    procedure grdTransportadoraDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fBuscaTransportadora: TfBuscaTransportadora;

implementation

uses MainCompra_u, Dm_u;

{$R *.dfm}

procedure TfBuscaTransportadora.grdTransportadoraDblClick(Sender: TObject);
begin
//  FMainCompra.EdtCodTrans.Text := Dm.tblTransportadora.;
//  FMainCompra.LblProd.caption    := Dm.TblProdutoNOMEPRODUTO.AsString;

  SQLRun('SELECT Frn_CodFornecedor, UnidadeFornecedor, Preco, CodigoProduto FROM ProdutoFornecedor, Produto where Produtofornecedor.codigoproduto='+ FMainCompra.EdtCodProd.Text+
         'ORDER BY produtofornecedor.codigoproduto', DM.tblProdutoFornecedor);

  FMainCompra.MskPrecoUn.Text := Floattostr(Dm.tblProdutoFornecedorPRECO.Value);
  FMainCompra.EdtUnidade.Text := Dm.tblProdutoFornecedorUnidadeFornecedor.AsString;
  FMainCompra.EdtForn.Text    := floattostr(Dm.tblProdutoFornecedorFrn_CodFornecedor.value);
  Close;
end;

end.
