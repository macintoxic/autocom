unit BuscaProd_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMenu, StdCtrls, Buttons, DB, Grids, DBGrids, ExtCtrls;

type
  TfBuscaProduto = class(TForm)
    grdProdutos: TDBGrid;
    DSProduto: TDataSource;
    Panel1: TPanel;
    CmdProcurar: TSpeedButton;
    TxtPesquisa: TEdit;
    F12: TLabel;
    procedure cmdFecharClick(Sender: TObject);
    procedure grdProdutosDblClick(Sender: TObject);
    procedure grdProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CmdProcurarClick(Sender: TObject);
    procedure TxtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TxtPesquisaEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fBuscaProduto: TfBuscaProduto;

implementation

uses Dm_u,uGlobal, MainCompra_u;

{$R *.dfm}

procedure TfBuscaProduto.cmdFecharClick(Sender: TObject);
begin
   Close;
end;

procedure TfBuscaProduto.grdProdutosDblClick(Sender: TObject);
begin
  FMainCompra.EdtCodProd.Text := Dm.TblProdutoCODIGOPRODUTO.AsString;
  FMainCompra.LblProd.caption    := Dm.TblProdutoNOMEPRODUTO.AsString;

  SQLRun('SELECT Frn_CodFornecedor, UnidadeFornecedor, Preco, CodigoProduto FROM ProdutoFornecedor, Produto where Produtofornecedor.codigoproduto='+ FMainCompra.EdtCodProd.Text+
         'ORDER BY produtofornecedor.codigoproduto', DM.tblProdutoFornecedor);

  FMainCompra.MskPrecoUn.Text := Floattostr(Dm.tblProdutoFornecedorPRECO.Value);
  FMainCompra.EdtUnidade.Text := Dm.tblProdutoFornecedorUnidadeFornecedor.AsString;
  FMainCompra.EdtForn.Text    := floattostr(Dm.tblProdutoFornecedorFrn_CodFornecedor.value);
  Close;
end;

procedure TfBuscaProduto.grdProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_Return then GrdProdutosDblClick(Self);
   if Key = VK_Escape then Close;
end;

procedure TfBuscaProduto.CmdProcurarClick(Sender: TObject);
begin
   Dm.TblProduto.close;
   Dm.TblProduto.SQL.Clear;
   if TxtPesquisa.text='' then
      Dm.Tblproduto.SQL.Add('SELECT codigoproduto, nomeproduto, A.preco, A.UnidadeFornecedor, a.frn_codfornecedor FROM Produto INNER JOIN ProdutoFornecedor A ON (codigoproduto=ProdutoFornecedor.CodigoProduto) ORDER BY codigoproduto')
   else
   begin
      try
         StrToInt(TxtPesquisa.Text);
         Dm.TblProduto.SQL.Add('Select CodigoProduto, NomeProduto, A.Preco, A.UnidadeFornecedor, A.frn_codfornecedor from Produto P, ProdutoFornecedor A where ' +
                               '(P.CodigoProduto = ' + TxtPesquisa.Text +' and P.CodigoProduto=A.CodigoProduto) '+
                               'order by P.CodigoProduto');
      except
         Dm.TblProduto.SQL.Add('Select CodigoProduto, NomeProduto, A.Preco, A.frn_codfornecedor from Produto P, ProdutoFornecedor A ' +
                               'Where P.NomeProduto LIKE ' + Chr(39) + '%' + TxtPesquisa.Text + '%' + Chr(39) +' and P.CodigoProduto=A.CodigoProduto '+
                               ' order by P.CodigoProduto');
      end;
   end;
   Dm.TblProduto.Prepare;
   Dm.TblProduto.Open;
   GrdProdutos.SetFocus;
end;

procedure TfBuscaProduto.TxtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Key = VK_F12) or (Key = VK_Return) then CmdProcurarClick(Self);
end;

procedure TfBuscaProduto.TxtPesquisaEnter(Sender: TObject);
begin
   f12.Visible:=True;
end;

end.
