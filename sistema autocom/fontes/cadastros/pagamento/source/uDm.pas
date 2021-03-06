unit uDm;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBQuery, IBDatabase, uGlobal,
  RpRave, RpBase, RpSystem, RpDefine, RpCon, RpConDS, DBClient;

type
  TDm = class(TDataModule)
    Transaction: TIBTransaction;
    dbautocom: TIBDatabase;
    RvDs: TRvDataSetConnection;
    RvSys: TRvSystem;
    Rave: TRvProject;
    CdsCP: TClientDataSet;
    CdsCPCODIGOCONDICAOPAGAMENTO: TIntegerField;
    CdsCPCONDICAOPAGAMENTO: TIBStringField;
    CdsCPCODIGOFORMAFATURAMENTO: TIntegerField;
    CdsCPNUMEROPARCELAS: TIntegerField;
    CdsCPPRIMEIRAPARCELA: TIntegerField;
    CdsCPINTERVALOPARCELAS: TIntegerField;
    CdsCPAUTENTICA: TIBStringField;
    CdsCPIMPRESSAOCHEQUE: TIBStringField;
    CdsCPFUNCAOESPECIAL: TStringField;
    CdsCPATIVOVENDA: TIBStringField;
    CdsCPATIVOFINANCEIRO: TIBStringField;
    CdsCPSOMASALDO: TIBStringField;
    CdsCPFORMAFATURAMENTO: TIBStringField;
    CdsCPTIPOTROCO: TStringField;
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
