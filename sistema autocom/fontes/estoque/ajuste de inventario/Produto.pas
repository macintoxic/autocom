unit Produto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, Buttons, StdCtrls, DB;

type
  TFrmProduto = class(TForm)
    Panel1: TPanel;
    GrdProdutos: TDBGrid;
    CmdProcurar: TSpeedButton;
    TxtPesquisa: TEdit;
    Ds_ProdutoS: TDataSource;
    procedure GrdProdutosDblClick(Sender: TObject);
    procedure GrdProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CmdProcurarClick(Sender: TObject);
    procedure TxtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmProduto: TFrmProduto;

implementation

uses Main, Module;

{$R *.dfm}

procedure TFrmProduto.GrdProdutosDblClick(Sender: TObject);
begin
  FrmMain.MskCodProduto.Text := Dm.Tbl_ProdutoCODIGOPRODUTO.AsString;
  FrmMain.LblNomeProduto.Caption := Dm.Tbl_ProdutoNOMEPRODUTO.AsString;
  I_CodigoEstoque := Dm.Tbl_ProdutoCODIGOESTOQUE.AsInteger;
  FrmMain.MskEstoqueAtual.Text := Dm.Tbl_ProdutoESTOQUEATUAL.AsString;
  FrmMain.MskEstMin.Text := Dm.Tbl_ProdutoESTOQUEMINIMO.AsString;
  FrmMain.MskEstMax.Text := Dm.Tbl_ProdutoESTOQUEMAXIMO.AsString;
  FrmMain.Editando(True);
  Close;
end;

procedure TFrmProduto.GrdProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then GrdProdutosDblClick(Self);
  if Key = VK_Escape then Close;
end;

procedure TFrmProduto.CmdProcurarClick(Sender: TObject);
begin
  Dm.Tbl_Produto.Close;
  Dm.Tbl_Produto.SQL.Clear;

  try
    StrToInt(TxtPesquisa.Text);
    Dm.Tbl_Produto.SQL.Add('Select * from Produto P ' +
                           'inner Join Estoque E on ' +
                           '(P.CodigoProduto = E.CodigoProduto) ' +
                           'Where P.CodigoProduto = ' + TxtPesquisa.Text +
                           ' order by P.CodigoProduto');
  except
    Dm.Tbl_Produto.SQL.Add('Select * from Produto P ' +
                           'inner Join Estoque E on ' +
                           '(P.CodigoProduto = E.CodigoProduto) ' +
                           'Where P.NomeProduto LIKE ' +
                           Chr(39) + '%' + TxtPesquisa.Text + '%' + Chr(39) +
                           ' order by P.NomeProduto');
  end;

  Dm.Tbl_Produto.Prepare;
  Dm.Tbl_Produto.Open;
  GrdProdutos.SetFocus;
end;

procedure TFrmProduto.TxtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F12 then CmdProcurarClick(Self);
end;

end.
