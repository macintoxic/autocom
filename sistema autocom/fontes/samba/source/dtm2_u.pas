unit dtm2_u;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBCustomDataSet, IBQuery;

type
  TDtm2 = class(TDataModule)
    vendedores: TIBQuery;
    DbAutocom: TIBDatabase;
    IBTransaction1: TIBTransaction;
    produtos: TIBQuery;
    consubgrpo: TIBQuery;
    conprod: TIBQuery;
    Tbl_Impressoras: TIBQuery;
    Rede: TIBQuery;
    pt: TIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dtm2: TDtm2;

implementation

{$R *.dfm}

end.
