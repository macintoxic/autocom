unit Module;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBQuery, IBDatabase, IBSQLMonitor;

type
  TDm = class(TDataModule)
    Transaction: TIBTransaction;
    DBAutocom: TIBDatabase;
    Tbl_TabelaPreco: TIBQuery;
    Tbl_TabelaPrecoCODIGOTABELAPRECO: TIntegerField;
    Tbl_TabelaPrecoTABELAPRECO: TIBStringField;
    Tbl_TabelaPrecoCODIGOTABELA: TIntegerField;
    Tbl_Impressoras: TIBQuery;
    Rede: TIBQuery;
    pt: TIBQuery;
    procedure IBSQLMonitor1SQL(EventText: String; EventTime: TDateTime);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dm: TDm;

implementation
uses Autocom;
{$R *.dfm}

procedure TDm.IBSQLMonitor1SQL(EventText: String; EventTime: TDateTime);
begin
     Log('smt.log',EventText);
end;

end.
