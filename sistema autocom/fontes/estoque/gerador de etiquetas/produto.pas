unit produto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, XPMenu;

type
  TFrmProduto = class(TForm)
    Panel1: TPanel;
    CmdProcurar: TSpeedButton;
    TxtPesquisa: TEdit;
    GrdProdutos: TDBGrid;
    Ds_ProdutoS: TDataSource;
    XPMenu: TXPMenu;
    procedure CmdProcurarClick(Sender: TObject);
    procedure GrdProdutosDblClick(Sender: TObject);
    procedure TxtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrdProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmProduto: TFrmProduto;

implementation

uses config, main;

{$R *.dfm}

procedure TFrmProduto.CmdProcurarClick(Sender: TObject);
begin
  try
  StrToFloat(TxtPesquisa.Text);
  FrmMain.SqlRun('SELECT * FROM PRODUTOASSOCIADO WHERE ' +
                 'CODIGOPRODUTOASSOCIADO = ' + Trim(TxtPesquisa.text),FrmMain.Rede);
  if FrmMain.Rede.IsEmpty then
  begin
    FrmMain.SqlRun('SELECT * FROM PRODUTO WHERE CODIGOPRODUTO = ' +
                   Trim(TxtPesquisa.text),FrmMain.tbl_produtoC)
  end
    else
  begin
    FrmMain.SqlRun('SELECT * FROM PRODUTO WHERE CODIGOPRODUTO = ' +
                   FrmMain.Rede.FieldByName('CODIGOPRODUTO').AsString,FrmMain.tbl_produtoC)
  end;
  except
    FrmMain.SqlRun('SELECT * FROM PRODUTO WHERE NOMEPRODUTO LIKE ' +
                   Chr(39) + '%' + TxtPesquisa.Text + '%' + Chr(39)
                   ,FrmMain.tbl_produtoC)
  end;
  GrdProdutos.SetFocus;
end;

procedure TFrmProduto.GrdProdutosDblClick(Sender: TObject);
begin
  //Filtra tabela de Pre?os
  FrmMain.Tbl_Preco.Close;
  FrmMain.Tbl_Preco.Params[0].Value := FrmMain.Tbl_ProdutoCCODIGOPRODUTO.Value;
  FrmMain.Tbl_Preco.Open;
  //Atribui Valores
  FrmMain.MskCodProduto.Text := FrmMain.Tbl_ProdutoCCODIGOPRODUTO.AsString;
  FrmMain.MskCodProdutoExit(Self);
  Close;
end;

procedure TFrmProduto.TxtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F12 then CmdProcurarClick(Self);
end;

procedure TFrmProduto.GrdProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_Return then GrdProdutosDblClick(Self);
  if Key = Vk_Escape then Close;
end;

end.
