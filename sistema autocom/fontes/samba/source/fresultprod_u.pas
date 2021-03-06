unit fresultprod_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Grids, DBGrids, Buttons;

type
  Tfresultprod = class(TForm)
    DBGrid1: TDBGrid;
    dsprod: TDataSource;
    SpeedButton2: TSpeedButton;
    SpeedButton1: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fresultprod: Tfresultprod;

implementation

uses dtm2_u, pedido, consprodgrupo_u, Unit1;

{$R *.dfm}

procedure Tfresultprod.FormActivate(Sender: TObject);
begin
  fresultprod.top:=68;
  fresultprod.left:=8;
  dsprod.DataSet := dtm2.conprod ;
  dbgrid1.Columns[0].Width:= 0;
end;

procedure Tfresultprod.DBGrid1DblClick(Sender: TObject);
begin
  if dtm2.conprod.fieldbyname('codigoproduto').IsNull then
     begin
       close;
       abort;
     end;
  v_produto:= dtm2.conprod.fieldbyname('codigoproduto').AsInteger;
  fpedido.e2produto.text:= dtm2.conprod.fieldbyname('codigoproduto').AsString;
  Fpedido.procura_produto;
  fresultprod.close;
  fconsprodgrupo.close;
  fconsprod.close;
  fpedido.e1qtde.setfocus;
end;

procedure Tfresultprod.FormCreate(Sender: TObject);
begin
  dbgrid1.Columns[0].Width:= 40;
end;

procedure Tfresultprod.SpeedButton1Click(Sender: TObject);
begin
fresultprod.Close;
end;

end.
