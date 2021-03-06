unit Module;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBQuery, IBDatabase;

type
  TDm = class(TDataModule)
    Tbl_Produto: TIBQuery;
    Transaction: TIBTransaction;
    dbautocom: TIBDatabase;
    Tbl_ProdutoCODIGOPRODUTO: TIntegerField;
    Tbl_ProdutoCODIGOESTOQUE: TIntegerField;
    Tbl_ProdutoESTOQUEATUAL: TFloatField;
    Tbl_ProdutoESTOQUEMINIMO: TFloatField;
    Tbl_ProdutoESTOQUEMAXIMO: TFloatField;
    Tbl_ProdutoNOMEPRODUTO: TIBStringField;
    Rede: TIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dm: TDm;

implementation

{$R *.dfm}

end.
