unit module;

interface

uses
  SysUtils, Classes, DB, IBDatabase, IBCustomDataSet, IBQuery;

type
  TDm = class(TDataModule)
    Tbl_Produto: TIBQuery;
    Tbl_ProdutoCODIGOPRODUTO: TIntegerField;
    Tbl_ProdutoNOMEPRODUTO: TIBStringField;
    Tbl_ProdutoCODIGOESTOQUE: TIntegerField;
    Tbl_ProdutoESTOQUEATUAL: TFloatField;
    Tbl_ProdutoESTOQUEMINIMO: TFloatField;
    Tbl_ProdutoESTOQUEMAXIMO: TFloatField;
    Transaction: TIBTransaction;
    dbautocom: TIBDatabase;
    rede: TIBQuery;
    rede2: TIBQuery;
    Tbl_SubGrupo: TIBQuery;
    Tbl_SubGrupoCODIGOSUBGRUPOPRODUTO: TIntegerField;
    Tbl_SubGrupoCODIGOSUBGRUPO: TIntegerField;
    Tbl_SubGrupoCODIGOGRUPOPRODUTO: TIntegerField;
    Tbl_SubGrupoSUBGRUPO: TIBStringField;
    Tbl_SubGrupoOBSERVACAO: TIBStringField;
    Tbl_Prateleira: TIBQuery;
    Tbl_PrateleiraCODPRATELEIRA: TIntegerField;
    Tbl_PrateleiraCODSECAO: TIntegerField;
    Tbl_PrateleiraCODIGOPRATELEIRA: TIntegerField;
    Tbl_Grupo: TIBQuery;
    Tbl_GrupoCODIGOGRUPOPRODUTO: TIntegerField;
    Tbl_GrupoGRUPOPRODUTO: TIBStringField;
    Tbl_GrupoOBSERVACAO: TIBStringField;
    Tbl_GrupoGERAREQUIPAMENTO: TIBStringField;
    Tbl_GrupoGERARCOMPONENTE: TIBStringField;
    Tbl_GrupoCODIGOIMPRESSORA: TIntegerField;
    Tbl_Secao: TIBQuery;
    Tbl_SecaoCODSECAO: TIntegerField;
    Tbl_SecaoCFG_CODCONFIG: TIntegerField;
    Tbl_SecaoCODIGOSECAO: TIntegerField;
    Tbl_SecaoDESCRICAO: TIBStringField;
    Tbl_Relatorio: TIBQuery;
    Tbl_RelatorioCODIGOPRODUTO: TIntegerField;
    Tbl_RelatorioNOMEPRODUTO: TIBStringField;
    Tbl_RelatorioESTOQUEMAXIMO: TFloatField;
    Tbl_RelatorioESTOQUEMINIMO: TFloatField;
    Tbl_RelatorioESTOQUEATUAL: TFloatField;
    Tbl_RelatorioCODIGOGRUPOPRODUTO: TIntegerField;
    Tbl_RelatorioGRUPOPRODUTO: TIBStringField;
    Tbl_RelatorioCODIGOSUBGRUPOPRODUTO: TIntegerField;
    Tbl_RelatorioSUBGRUPO: TIBStringField;
    Tbl_RelatorioCODIGOSECAO: TIntegerField;
    Tbl_RelatorioDESCRICAO: TIBStringField;
    Tbl_RelatorioCODPRATELEIRA: TIntegerField;
    Tbl_RelatorioCODIGOPRATELEIRA: TIntegerField;
    Tbl_RelatorioCODSECAO: TIntegerField;
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
