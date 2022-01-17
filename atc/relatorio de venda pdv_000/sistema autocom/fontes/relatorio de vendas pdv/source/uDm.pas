unit uDm;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBCustomDataSet, IBQuery, RpBase,
  RpSystem, RpCon, RpConDS, RpDefine, RpRave, DBClient, uGlobal, Provider;

type
  TDm = class(TDataModule)
    DBAutocom: TIBDatabase;
    Transaction: TIBTransaction;
    QrProdutos: TIBQuery;
    QrIndicadores: TIBQuery;
    QrGrupos: TIBQuery;
    QrCheques: TIBQuery;
    QrSangrias: TIBQuery;
    RvAutocom: TRvProject;
    RvProdutos: TRvDataSetConnection;
    RvSystem: TRvSystem;
    RvIndicadores: TRvDataSetConnection;
    RvGrupos: TRvDataSetConnection;
    RvCheques: TRvDataSetConnection;
    RvHoras: TRvDataSetConnection;
    RvSangrias: TRvDataSetConnection;
    CdsHoras: TClientDataSet;
    CdsHorasHora: TStringField;
    CdsHorasClientes: TIntegerField;
    CdsHorasValor: TFloatField;
    QrProdutosCODIGOPRODUTO: TIntegerField;
    QrProdutosNOMEPRODUTO: TIBStringField;
    QrProdutosQTDE: TFloatField;
    QrProdutosVALORSOMA: TFloatField;
    QrSangriasDATA: TDateTimeField;
    QrSangriasVALOR: TFloatField;
    QrSangriasDESCRICAO: TIBStringField;
    QrChequesOID: TIntegerField;
    QrChequesDATAHORA: TDateTimeField;
    QrChequesCFG_CODCONFIG: TIntegerField;
    QrChequesCLI_CODCLIENTE: TIntegerField;
    QrChequesVEN_CODVENDEDOR: TIntegerField;
    QrChequesIDUSUARIO: TIntegerField;
    QrChequesCODIGOCONDICAOPAGAMENTO: TIntegerField;
    QrChequesTERMINAL: TIBStringField;
    QrChequesNCP: TIBStringField;
    QrChequesREPIQUE: TFloatField;
    QrChequesCONTRAVALE: TFloatField;
    QrChequesTROCO: TFloatField;
    QrChequesVALORRECEBIDO: TFloatField;
    QrChequesBANCO: TIBStringField;
    QrChequesNUMEROCHEQUE: TIBStringField;
    QrChequesAGENCIA: TIBStringField;
    QrChequesCONTA: TIBStringField;
    QrChequesDATAPRE: TIBStringField;
    QrChequesPES_CPF_CNPJ_A: TIBStringField;
    RvOperadores: TRvDataSetConnection;
    QrOperadores: TIBQuery;
    QrOperadoresIDUSUARIO: TIntegerField;
    QrOperadoresNOMEUSUARIO: TIBStringField;
    QrOperadoresQUANTIDADE: TIntegerField;
    QrOperadoresVALOR: TFloatField;
    QrOperadoresCANCITEM: TIntegerField;
    QrOperadoresCANCVENDA: TIntegerField;
    n: TIntegerField;
    QrOperadoresVALORACRESCIMO: TFloatField;
    QrOperadoresQTDEDESCONTO: TIntegerField;
    QrOperadoresVALORDESCONTO: TFloatField;
    QrOperadoresFCXQTDE: TIntegerField;
    QrOperadoresFCXVALOR: TFloatField;
    RvOperadoresF: TRvDataSetConnection;
    CdsOperadoresF: TClientDataSet;
    CdsOperadoresFCodigoCondicaoPagamento: TFloatField;
    CdsOperadoresFCondicaoPagamento: TStringField;
    CdsOperadoresFSangriaQtde: TFloatField;
    CdsOperadoresFSangriaValor: TFloatField;
    CdsOperadoresFFinalizadoraQtde: TFloatField;
    CdsOperadoresFFinalizadoraValor: TFloatField;
    CdsOperadoresFRepique: TFloatField;
    CdsOperadoresFContraVale: TFloatField;
    CdsOperadoresFSaldoFinal: TFloatField;
    CdsOperadoresFSomaSaldo: TBooleanField;
    CdsOperadoresFIdUsuario: TFloatField;
    CdsOperadoresFSomaSaldoSimbolo: TStringField;
    CdsOperadoresFFcx: TFloatField;
    CdsOperadoresFFinalizadoraValorL: TFloatField;
    CdsOperadoresFTroco: TFloatField;
    QrIndicadoresPES_NOME_A: TIBStringField;
    QrIndicadoresVALOR: TFloatField;
    QrIndicadoresREPIQUE: TFloatField;
    QrIndicadoresCONTRAVALE: TFloatField;
    QrIndicadoresTROCO: TFloatField;
    QrIndicadoresQTDE: TIntegerField;
    QrIndicadoresNPESSOAS: TIntegerField;
    QrIndicadoresCOMISSAO: TFloatField;
    QrIndicadoresCODIGOVENDEDOR: TIntegerField;
    QrIndicadoresVALORL: TFloatField;
    QrIndicadoresCOMISSAOL: TFloatField;
    QrGruposGRUPOPRODUTO: TIBStringField;
    QrGruposSUBGRUPO: TIBStringField;
    QrGruposQTDE: TFloatField;
    QrGruposVALORSOMA: TFloatField;
    QrGruposCODIGOGRUPOPRODUTO: TIntegerField;
    QrGrupos2: TIBQuery;
    RvGrupos2: TRvDataSetConnection;
    QrGrupos2GRUPOPRODUTO: TIBStringField;
    QrGrupos2CODIGOGRUPOPRODUTO: TIntegerField;
    QrGruposCODIGOSUBGRUPO: TIntegerField;
    generico: TIBQuery;
    QrProdutosTOTUNID: TFloatField;
    QrProdutosTOTACRES: TFloatField;
    QrProdutosTOTDESC: TFloatField;
    QROperadorcancelados: TIBQuery;
    QROperadorcanceladosDATAHORA: TDateTimeField;
    QROperadorcanceladosPES_NOME_A: TIBStringField;
    QROperadorcanceladosNOMEPRODUTO: TIBStringField;
    QROperadorcanceladosMOTIVO_CANCELAMENTO: TIBStringField;
    QROperadorcanceladosNUMEROPEDIDO: TIntegerField;
    QROperadorcanceladosQTDE: TFloatField;
    RVOperadorCancelados: TRvDataSetConnection;
    Rvextratocliente: TRvDataSetConnection;
    CDSeXTRATOcliente: TClientDataSet;
    CDSeXTRATOclientedata: TDateField;
    CDSeXTRATOclientecodigo: TIntegerField;
    CDSeXTRATOclienteproduto: TStringField;
    CDSeXTRATOclienteqtde: TFloatField;
    CDSeXTRATOclientevalor: TFloatField;
    generico2: TIBQuery;
    procedure QrIndicadoresCalcFields(DataSet: TDataSet);
    procedure CdsOperadoresFCalcFields(DataSet: TDataSet);
    procedure DataModuleCreate(Sender: TObject);
  private
  public
  end;

var
  Dm: TDm;

implementation

uses Variants;

{$R *.dfm}

procedure TDm.QrIndicadoresCalcFields(DataSet: TDataSet);
begin
  QrIndicadoresVALORL.Value := QrIndicadoresVALOR.Value - QrIndicadoresTROCO.Value - QrIndicadoresREPIQUE.Value - QrIndicadoresCONTRAVALE.Value;
  QrIndicadoresCOMISSAOL.Value := QrIndicadoresVALORL.Value * (QrIndicadoresCOMISSAO.Value/100);
end;

procedure TDm.CdsOperadoresFCalcFields(DataSet: TDataSet);
begin
  Dm.CdsOperadoresFFinalizadoraValorL.Value := Dm.CdsOperadoresFFinalizadoraValor.AsFloat - Dm.CdsOperadoresFContraVale.AsFloat - Dm.CdsOperadoresFTroco.AsFloat;

    if Dm.CdsOperadoresFCodigoCondicaoPagamento.AsFloat = 1 then
      begin
        Dm.CdsOperadoresFSaldoFinal.Value :=
          (Dm.CdsOperadoresFFinalizadoraValor.AsFloat + Dm.QrOperadoresFCXVALOR.AsFloat) -
          (Dm.CdsOperadoresFSangriaValor.AsFloat + Dm.CdsOperadoresFTroco.AsFloat)
      end
    else
      begin
        Dm.CdsOperadoresFSaldoFinal.Value := Dm.CdsOperadoresFFinalizadoraValorL.AsFloat - Dm.CdsOperadoresFSangriaValor.AsFloat;
      end;

  if Dm.CdsOperadoresFSomaSaldo.Value then
    begin
      Dm.CdsOperadoresFSomaSaldoSimbolo.Value := '+';
    end
  else
    begin
      Dm.CdsOperadoresFSomaSaldoSimbolo.Value := NullAsStringValue;
    end;
end;

procedure TDm.DataModuleCreate(Sender: TObject);
begin
  DataBaseAutocom := @DBAutocom;
end;

end.
