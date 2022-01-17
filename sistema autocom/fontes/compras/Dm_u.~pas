unit Dm_u;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBCustomDataSet, IBQuery, ExtCtrls;

type
  TDM = class(TDataModule)
    DBAutocom: TIBDatabase;
    IBTransaction: TIBTransaction;
    tblPedidoCompra: TIBQuery;
    tblProduto: TIBQuery;
    tblProdutoPedidoCompra: TIBQuery;
    tblFornecedor: TIBQuery;
    tblProdutoFornecedor: TIBQuery;
    tblProdutoFornecedorFRN_CODFORNECEDOR: TIntegerField;
    tblProdutoFornecedorCODIGOPRODUTO: TIntegerField;
    tblProdutoFornecedorPRECO: TFloatField;
    tblProdutoFornecedorUNIDADEFORNECEDOR: TIBStringField;
    tblFornecedorFRN_CODFORNECEDOR: TIntegerField;
    tblFornecedorCODIGOFORNECEDOR: TIntegerField;
    tblFornecedorPES_CODPESSOA: TIntegerField;
    tblFornecedorCON_CODCONTA: TIntegerField;
    tblFornecedorCODIGONATUREZAOPERACAO: TIntegerField;
    tblFornecedorEMPREITEIRA: TIBStringField;
    tblFornecedorOBSERVACAO: TIBStringField;
    tblFornecedorCFG_CODCONFIG: TIntegerField;
    tblFornecedorCLIENTE: TIBStringField;
    tblProdutoPedidoCompraCODIGOPRODUTOPEDIDOCOMPRA: TIntegerField;
    tblProdutoPedidoCompraQUANTIDADE: TFloatField;
    tblProdutoPedidoCompraENTREGUE: TFloatField;
    tblProdutoPedidoCompraCANCELADO: TFloatField;
    tblProdutoPedidoCompraPRECO: TFloatField;
    tblProdutoPedidoCompraALIQUOTAIPI: TFloatField;
    tblProdutoPedidoCompraALIQUOTAICMS: TFloatField;
    tblProdutoPedidoCompraCODIGOPRODUTO: TIntegerField;
    tblProdutoPedidoCompraCODIGOPEDIDOCOMPRA: TIntegerField;
    tblProdutoPedidoCompraFATORCONVERSAO: TFloatField;
    tblProdutoPedidoCompraLARGURA: TFloatField;
    tblProdutoPedidoCompraALTURA: TFloatField;
    tblProdutoPedidoCompraMETROQUADRADO: TFloatField;
    tblProdutoPedidoCompraUNIDADE: TIBStringField;
    tblProdutoPedidoCompraCOMPLEMENTO: TIBStringField;
    tblProdutoPedidoCompraKIT: TIntegerField;
    tblVendedor: TIBQuery;
    tblVendedorCODIGOVENDEDOR: TIntegerField;
    tblVendedorPES_CODPESSOA: TIntegerField;
    tblVendedorCOMISSAO: TFloatField;
    tblTransportadora: TIBQuery;
    tblProdutoCODIGOPRODUTO: TIntegerField;
    tblProdutoNOMEPRODUTO: TIBStringField;
    tblRede: TIBQuery;
    tblPedidoCompraDATA: TDateTimeField;
    tblPedidoCompraNUMEROPEDIDO: TIntegerField;
    tblPedidoCompraSITUACAO: TIBStringField;
    tblPedidoCompraTOTALPEDIDO: TFloatField;
    tblPedidoCompraTOTALPRODUTOS: TFloatField;
    tblPedidoCompraAPROVADO: TIBStringField;
    Timer: TTimer;
    tblCondicaoPagam: TIBQuery;
    tblCondicaoPagamCODIGOCONDICAOPAGAMENTO: TIntegerField;
    tblCondicaoPagamCONDICAOPAGAMENTO: TIBStringField;
    procedure TimerTimer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

uses MainCompra_u;

{$R *.dfm}

procedure TDM.TimerTimer(Sender: TObject);
begin
   FMainCompra.DatData.Date:=Date;
end;

end.
