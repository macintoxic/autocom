unit consprodgrupo_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Grids, DBGrids, Buttons;

type
  Tfconsprodgrupo = class(TForm)
    DBGrid1: TDBGrid;
    Dssubgrupo: TDataSource;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fconsprodgrupo: Tfconsprodgrupo;
  v_auxcodigo: integer;
implementation

uses dtm2_u, fresultprod_u;

{$R *.dfm}

procedure Tfconsprodgrupo.FormActivate(Sender: TObject);
begin
fconsprodgrupo.top:=68;
fconsprodgrupo.left:=8;

Dssubgrupo.dataset:= dtm2.consubgrpo ;
dbgrid1.columns[0].Title.Caption:= '';

dbgrid1.columns[1].Title.Caption:= '';
dbgrid1.Columns[0].Width:= 0;


end;

procedure Tfconsprodgrupo.DBGrid1DblClick(Sender: TObject);
begin
v_auxcodigo := dtm2.consubgrpo.fieldbyname('codigosubgrupoproduto').AsInteger;
dtm2.conprod.Close;
dtm2.conprod.SQL.Clear;
dtm2.conprod.SQL.Add('Select codigoproduto, nomeproduto from produto where codigosubgrupoproduto = '+ inttostr(v_auxcodigo) + '');
dtm2.conprod.Prepare ;
dtm2.conprod.Open;

fresultprod.ShowModal;

end;

procedure Tfconsprodgrupo.SpeedButton1Click(Sender: TObject);
begin
fconsprodgrupo.Close;
end;

end.
