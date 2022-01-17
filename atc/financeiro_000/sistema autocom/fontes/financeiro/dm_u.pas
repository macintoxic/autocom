unit dm_u;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBQuery, IBDatabase;

type
  TDm = class(TDataModule)
    DBAutocom: TIBDatabase;
    Trans: TIBTransaction;
    portadores: TIBQuery;
    Consulta: TIBQuery;
    principal: TIBQuery;
    Inclusao: TIBQuery;
    Aux: TIBQuery;
    
   
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
