unit uDm;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBCustomDataSet, IBQuery, RpDefine,
  RpRave, RpCon, RpConDS, RpBase, RpSystem, uGlobal;

type
  TDm = class(TDataModule)
    dbautocom: TIBDatabase;
    Transaction: TIBTransaction;
    RvConn: TRvProject;
    RvDs: TRvDataSetConnection;
    RvSys: TRvSystem;
    procedure DataModuleCreate(Sender: TObject);
  private
  public
  end;

var
  Dm: TDm;

implementation

{$R *.dfm}

procedure TDm.DataModuleCreate(Sender: TObject);
begin
//  DataBaseAutocom := @dbautocom;
end;

end.
