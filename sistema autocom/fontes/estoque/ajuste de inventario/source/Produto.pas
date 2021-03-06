unit Produto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, Buttons, StdCtrls, DB, SUIDBCtrls,
  SUIEdit, SUIForm, SUIMgr;

type
  TFrmProduto = class(TForm)
    Panel1: TPanel;
    CmdProcurar: TSpeedButton;
    Ds_ProdutoS: TDataSource;
    suiForm1: TsuiForm;
    TxtPesquisa: TsuiEdit;
    GrdProdutos: TsuiDBGrid;
    skin: TsuiThemeManager;
    procedure suitempGrdProdutosDblClick(Sender: TObject);
    procedure suitempGrdProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CmdProcurarClick(Sender: TObject);
    procedure suitempTxtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
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

procedure TFrmProduto.suitempGrdProdutosDblClick(Sender: TObject);
begin
  FrmMain.MskCodProduto.Text := Dm.Rede.fieldbyname('CODIGOPRODUTO').AsString;
  Close;
end;

procedure TFrmProduto.suitempGrdProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then suitempGrdProdutosDblClick(Self);
  if Key = VK_Escape then Close;
end;

procedure TFrmProduto.CmdProcurarClick(Sender: TObject);
begin
  Dm.REDE.Close;
  Dm.REDE.SQL.Clear;

  try
    StrToInt(TxtPesquisa.Text);
    Dm.REDE.SQL.Add('Select * from Produto P ' +
                           'Where P.CodigoProduto = ' + TxtPesquisa.Text +
                           ' order by P.CodigoProduto');
  except
    Dm.REDE.SQL.Add('Select * from Produto P ' +
                           'Where P.NomeProduto LIKE ' +
                           Chr(39) + '%' + TxtPesquisa.Text + '%' + Chr(39) +
                           ' order by P.NomeProduto');
  end;

  Dm.REDE.Prepare;
  Dm.REDE.Open;
  GrdProdutos.SetFocus;
end;

procedure TFrmProduto.suitempTxtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F12 then CmdProcurarClick(Self);
end;

procedure TFrmProduto.FormActivate(Sender: TObject);
begin
     skin.uistyle:=FrmMain.skin.uistyle;
     Application.processmessages;
end;

end.
