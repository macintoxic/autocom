unit BuscaVend_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DB, Grids, DBGrids;

type
  TfBuscaVendedor = class(TForm)
    grdVendedor: TDBGrid;
    DSVendedor: TDataSource;
    Panel1: TPanel;
    CmdProcurar: TSpeedButton;
    TxtPesquisa: TEdit;
    procedure grdVendedorDblClick(Sender: TObject);
    procedure grdVendedorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TxtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CmdProcurarClick(Sender: TObject);
  private
    { Private declarations }
  public
    path:string;
    { Public declarations }
  end;

var
  fBuscaVendedor: TfBuscaVendedor;

implementation

uses MainCompra_u, Dm_u, uGlobal;

{$R *.dfm}

procedure TfBuscaVendedor.grdVendedorDblClick(Sender: TObject);
begin
  FMainCompra.edtCodVend.Text := Dm.tblVendedor.fieldbyname('CodigoVendedor').AsString;

//  Busca o codiga da pessoa na tabela d pessoa e retorna nome da pessoa!
//  FMainCompra.Label18.Caption := Dm.tblVendedor('NomeVendedor').AsString;

  FMainCompra.MskValorcomissao.Text := Floattostr(Dm.tblVendedor.fieldbyname('Comissao').Value);
  Close;
end;

procedure TfBuscaVendedor.grdVendedorKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if Key = VK_Return then GrdVendedorDblClick(Self);
   if Key = VK_Escape then Close;
end;

procedure TfBuscaVendedor.TxtPesquisaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if Key = VK_F12 then CmdProcurarClick(Self);
end;

procedure TfBuscaVendedor.CmdProcurarClick(Sender: TObject);
begin
   Dm.TblVendedor.close;
   Dm.TblVendedor.SQL.Clear;
   try
      StrToInt(TxtPesquisa.Text);
      Dm.TblVendedor.SQL.Add('Select V.CodigoVendedor, V.Pes_CodPessoa, V.Comissao from Vendedor V ' +
                             'Where V.CodigoVendedor = ' + TxtPesquisa.Text + 'order by V.CodigoVendedor');
   except
      Dm.TblVendedor.SQL.Add('Select V.CodigoVendedor, V.Pes_CodPessoa, V.Comissao from Vendedor V ' +
                             'Where V.CodigoVendedor LIKE ' + Chr(39) + '%' + TxtPesquisa.Text + '% ' + Chr(39) +
                             'order by V.CodigoVendedor');
   end;
   Dm.TblVendedor.Prepare;
   Dm.TblVendedor.Open;
   GrdVendedor.SetFocus;
end;

end.
