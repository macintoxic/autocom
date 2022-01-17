unit Module;

interface

uses
  SysUtils, Classes, DB, IBDatabase, IBCustomDataSet, IBQuery, uGlobal,
  DBClient, IBDatabaseInfo, IBSQLMonitor, IBServices;

type
  TDm = class(TDataModule)
    Transaction: TIBTransaction;
    dbautocom: TIBDatabase;
    Net: TIBQuery;
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
    CDSeXTRATOcliente: TClientDataSet;
    CDSeXTRATOclientedata: TDateField;
    CDSeXTRATOclientecodigo: TIntegerField;
    CDSeXTRATOclienteproduto: TStringField;
    CDSeXTRATOclienteqtde: TFloatField;
    CDSeXTRATOclientevalor: TFloatField;
    procedure CdsOperadoresFCalcFields(DataSet: TDataSet);
  private
  public
    function BuscaNomeVendedor(IDUSUARIO: Integer): String;
  end;

var
  Dm: TDm;

implementation

uses Variants, uMain;

{$R *.dfm}

{ TDm }

function TDm.BuscaNomeVendedor(IDUSUARIO: Integer): String;
var
  DsConsulta: TDataSet;
begin
  RunSQL('SELECT * FROM USUARIOSISTEMA WHERE IDUSUARIO = ' + IntToStr(IDUSUARIO), dbautocom, DsConsulta);
  if DsConsulta.IsEmpty then
    Result := NullAsStringValue
  else
    Result := DsConsulta.FieldByName('NOMEUSUARIO').AsString;
  FreeAndNil(DsConsulta);
end;

procedure TDm.CdsOperadoresFCalcFields(DataSet: TDataSet);
begin
// dia 07/07/2003 - por Helder Frederico : Retirei a linha abaixo pq o valor da
//                                         Finalizadora tem q ser o valor RECEBIDO
//  Dm.CdsOperadoresFFinalizadoraValorL.Value := Dm.CdsOperadoresFFinalizadoraValor.AsFloat - Dm.CdsOperadoresFContraVale.AsFloat - Dm.CdsOperadoresFTroco.AsFloat;
  Dm.CdsOperadoresFFinalizadoraValorL.Value := Dm.CdsOperadoresFFinalizadoraValor.AsFloat;

  //Equaciona Saldo Final
  if Dm.CdsOperadoresFCodigoCondicaoPagamento.Value = 1 then
    begin
      //No Caso de Dinheiro - Codigo 1 - A equação é diferente
      Dm.CdsOperadoresFSaldoFinal.Value :=
        (Dm.CdsOperadoresFFinalizadoraValor.AsFloat + Fcx) -
        (Dm.CdsOperadoresFSangriaValor.AsFloat + Dm.CdsOperadoresFContraVale.AsFloat + Dm.CdsOperadoresFTroco.AsFloat);
    end
  else
    begin
      Dm.CdsOperadoresFSaldoFinal.Value := Dm.CdsOperadoresFFinalizadoraValorL.AsFloat -
      (Dm.CdsOperadoresFSangriaValor.AsFloat + Dm.CdsOperadoresFContraVale.AsFloat + Dm.CdsOperadoresFTroco.AsFloat);
    end;

  //Verifica Campo Soma Saldo
  if Dm.CdsOperadoresFSomaSaldo.Value = True then
      Dm.CdsOperadoresFSomaSaldoSimbolo.Value := '+'
  else
      Dm.CdsOperadoresFSomaSaldoSimbolo.Value := NullAsStringValue;

end;

end.
