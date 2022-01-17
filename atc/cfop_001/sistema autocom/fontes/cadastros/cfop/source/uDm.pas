unit uDm;

interface

uses
  SysUtils, Classes, DB, IBDatabase, RpRave, RpBase, RpSystem, RpDefine,
  RpCon, RpConDS, IBCustomDataSet, DBClient;

type
  TDm = class(TDataModule)
    RvDs: TRvDataSetConnection;
    RvSys: TRvSystem;
    Rave: TRvProject;
    Transaction: TIBTransaction;
    DBAutocom: TIBDatabase;
    CdsCFOP: TClientDataSet;
    CdsCFOPCODIGONATUREZAOPERACAO: TIntegerField;
    CdsCFOPNATUREZAOPERACAO: TIBStringField;
    CdsCFOPDESCRICAO: TIBStringField;
    CdsCFOPTRIBUTAICMS: TIBStringField;
    CdsCFOPTRIBUTAIPI: TIBStringField;
    CdsCFOPTRIBUTAISS: TIBStringField;
    CdsCFOPMOVIMENTACONTAS: TIBStringField;
    CdsCFOPMOVIMENTAESTOQUE: TIBStringField;
  private
  public
  end;

var
  Dm: TDm;

implementation

{$R *.dfm}



end.
