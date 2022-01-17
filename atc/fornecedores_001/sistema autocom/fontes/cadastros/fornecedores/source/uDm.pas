unit uDm;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBCustomDataSet, IBQuery, RpDefine,
  RpRave, RpCon, RpConDS, RpBase, RpSystem;

type
  TDm = class(TDataModule)
    dbautocom: TIBDatabase;
    Transaction: TIBTransaction;
    QrRelatorio: TIBQuery;
    RvConn: TRvProject;
    RvDs: TRvDataSetConnection;
    RvSys: TRvSystem;
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
