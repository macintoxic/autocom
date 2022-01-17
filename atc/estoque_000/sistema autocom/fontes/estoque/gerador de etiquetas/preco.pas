unit preco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids;

type
  TFrmPreco = class(TForm)
    GrdProdutos: TDBGrid;
    Ds_Preco: TDataSource;
    procedure GrdProdutosDblClick(Sender: TObject);
    procedure GrdProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPreco: TFrmPreco;

implementation

uses main;

{$R *.dfm}

procedure TFrmPreco.GrdProdutosDblClick(Sender: TObject);
begin
  FrmMain.MskTabelaPreco.Text := FrmMain.Tbl_PrecoCODIGOTABELAPRECO.AsString;
  FrmMain.MskTabelaPrecoExit(Self);
  Close;
end;

procedure TFrmPreco.GrdProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_Return then GrdProdutosDblClick(Self);
  if Key = Vk_Escape then Close;
end;

end.
