unit uDm;

interface

uses
  SysUtils, Classes, DB, IBCustomDataSet, IBQuery, IBDatabase, IBUpdateSQL;

type
  TDm = class(TDataModule)
    Tbl_UsuarioSistema: TIBQuery;
    DBAutocom: TIBDatabase;
    Transaction: TIBTransaction;
    Rede: TIBQuery;
    Tbl_UsuarioSistemaIDUSUARIO: TIntegerField;
    Tbl_UsuarioSistemaIDGRUPOUSUARIO: TIntegerField;
    Tbl_UsuarioSistemaNOMEUSUARIO: TIBStringField;
    Tbl_UsuarioSistemaSENHA: TIBStringField;
    Tbl_UsuarioSistemaNOMECOMPLETO: TIBStringField;
    Tbl_UsuarioSistemaINATIVO: TIBStringField;
    Tbl_UsuarioSistemaSTATUS: TStringField;
    Tbl_GrupoUsuarioSistema: TIBQuery;
    Tbl_GrupoUsuarioSistemaIDGRUPOUSUARIO: TIntegerField;
    Tbl_GrupoUsuarioSistemaNOMEGRUPO: TIBStringField;
    Tbl_GrupoUsuarioSistemaADMINISTRADOR: TIBStringField;
    Tbl_GrupoUsuarioSistemaINATIVO: TIBStringField;
    Tbl_GrupoUsuarioSistemaSTATUS: TStringField;
    Tbl_PermissaoSistema: TIBQuery;
    Tbl_PermissaoSistemaIDGRUPOPERMISSAO: TIntegerField;
    Tbl_PermissaoSistemaNOMEGRUPO: TIBStringField;
    Tbl_PermissaoSistemaIDPERMISSAOSISTEMA: TIntegerField;
    Tbl_PermissaoSistemaPERMISSAO: TIBStringField;
    Tbl_PermissaoSistemaIDGRUPOUSUARIO: TIntegerField;
    Tbl_PermissaoSistemaNOMEGRUPO1: TIBStringField;
    Tbl_PermissaoSistemaINSERIR: TIBStringField;
    Tbl_PermissaoSistemaALTERAR: TIBStringField;
    Tbl_PermissaoSistemaEXCLUIR: TIBStringField;
    Tbl_Permissao: TIBQuery;
    Tbl_PermissaoIDPERMISSAOSISTEMA: TIntegerField;
    Tbl_PermissaoIDGRUPOPERMISSAO: TIntegerField;
    Tbl_PermissaoPERMISSAO: TIBStringField;
    Tbl_PermissaoCADASTRO: TIBStringField;
    Tbl_PermissaoNOMETELA: TIBStringField;
    Tbl_PermissaoORDEM: TIntegerField;
    Net: TIBQuery;
    Tbl_PermissaoSistemaSTATUS: TStringField;
    procedure Tbl_UsuarioSistemaCalcFields(DataSet: TDataSet);
    procedure Tbl_GrupoUsuarioSistemaCalcFields(DataSet: TDataSet);
    procedure Tbl_PermissaoSistemaCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Dm: TDm;

implementation

{$R *.dfm}

procedure TDm.Tbl_UsuarioSistemaCalcFields(DataSet: TDataSet);
begin
  if Dm.Tbl_UsuarioSistemaINATIVO.Value = 'T' then
    Dm.Tbl_UsuarioSistemaSTATUS.Value := 'Inativo'
  else
    Dm.Tbl_UsuarioSistemaSTATUS.Value := 'Ativo'
end;

procedure TDm.Tbl_GrupoUsuarioSistemaCalcFields(DataSet: TDataSet);
begin
  if Dm.Tbl_GrupoUsuarioSistemaINATIVO.Value = 'T' then
    Dm.Tbl_GrupoUsuarioSistemaSTATUS.Value := 'Inativo'
  else
    Dm.Tbl_GrupoUsuarioSistemaSTATUS.Value := 'Ativo'
end;

procedure TDm.Tbl_PermissaoSistemaCalcFields(DataSet: TDataSet);
begin
  if Dm.Tbl_PermissaoSistemaINSERIR.Value = 'T' then
    Dm.Tbl_PermissaoSistemaSTATUS.Value := 'Autorizado'
  else
    Dm.Tbl_PermissaoSistemaSTATUS.Value := 'Não autorizado'
end;

end.
