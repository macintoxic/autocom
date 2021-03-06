unit tab;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, IBCustomDataSet, IBDatabase, IBQuery;

type
  Tftabelas = class(TForm)
    tbl_vendedores: TIBQuery;
    tbl_condicaopagamento: TIBQuery;
    DbAutocom: TIBDatabase;
    Transacao: TIBTransaction;
    tbop: TIBQuery;
    tbl_produtos: TIBQuery;
    tbl_produtoassociado: TIBQuery;
    acr400: TIBQuery;
    tbteclado: TIBQuery;
    querylog: TIBQuery;
    Query2: TIBQuery;
    Query1: TIBQuery;
    tbtecladoCODIGO_FUNCAO: TIBStringField;
    tbtecladoCFG_CODCONFIG: TIntegerField;
    tbtecladoTERMINAL: TIBStringField;
    tbtecladoTIPO: TIBStringField;
    tbtecladoTECLA: TIntegerField;
    tbtecladoABREV: TIBStringField;
    tbtecladoCODIGOPRODUTO: TIntegerField;
    tbtecladoOID: TIntegerField;
    tbl_Formafaturamento: TIBQuery;
    tbl_tabelapreco: TIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ftabelas: Tftabelas;

implementation

{$R *.dfm}

end.
