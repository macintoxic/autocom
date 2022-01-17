unit preco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, SUIDBCtrls, ExtCtrls, SUIForm, SUIMgr;

type
  TFrmPreco = class(TForm)
    Ds_Preco: TDataSource;
    suiForm1: TsuiForm;
    GrdProdutos: TsuiDBGrid;
    Skin: TsuiThemeManager;
    procedure suitempGrdProdutosDblClick(Sender: TObject);
    procedure suitempGrdProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
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

procedure TFrmPreco.suitempGrdProdutosDblClick(Sender: TObject);
begin
  FrmMain.MskTabelaPreco.Text := FrmMain.Tbl_PrecoCODIGOTABELAPRECO.AsString;
  FrmMain.MskTabelaPrecoExit(Self);
  Close;
end;

procedure TFrmPreco.suitempGrdProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_Return then suitempGrdProdutosDblClick(Self);
  if Key = Vk_Escape then Close;
end;

procedure TFrmPreco.FormActivate(Sender: TObject);
begin
     skin.uistyle:=FrmMain.skin.uistyle;
     application.ProcessMessages;

end;

end.
