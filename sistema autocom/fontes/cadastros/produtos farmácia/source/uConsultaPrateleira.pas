unit uConsultaPrateleira;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uModeloConsulta, DB, Buttons, ExtCtrls, Grids, DBGrids, uGlobal, uSqlGlobal,
  StdCtrls, Mask;

type
  TfConsultaPrateleira = class(TfModeloConsulta)
    Label1: TLabel;
    EdCodigo: TEdit;
    Label2: TLabel;
    EdNome: TMaskEdit;
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GrdConsultaDblClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure EdNomeKeyPress(Sender: TObject; var Key: Char);
    procedure BtnExcluirClick(Sender: TObject);
    procedure GrdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
    CodigoSecao: String;
    procedure Seleciona; override;
    procedure Refresh; override;
  end;

var
  fConsultaPrateleira: TfConsultaPrateleira;

implementation

uses uDm, uMain, uCadastro;

{$R *.dfm}

procedure TfConsultaPrateleira.BtnNovoClick(Sender: TObject);
begin
  inherited;
  Editando(True);
  State := InsertSql;
  EnableFields(True, PanFields);
  EdNome.SetFocus;
end;

procedure TfConsultaPrateleira.BtnEditarClick(Sender: TObject);
begin
  inherited;
  if DataSetConsulta.IsEmpty then Exit;
  Editando(True);
  EnableFields(True,PanFields);
  EdCodigo.Text := DataSetConsulta.FieldByName('CODPRATELEIRA').AsString;
  EdNome.Text := DataSetConsulta.FieldByName('CODIGOPRATELEIRA').AsString;
  State := UpdateSql;
  EdNome.SetFocus;
end;

procedure TfConsultaPrateleira.FormShow(Sender: TObject);
begin
  inherited;
  EnableFields(False, PanFields);
  Refresh;
end;

procedure TfConsultaPrateleira.Seleciona;
begin
  ResultConsultaCodigo := DataSetConsulta.Fields[0].AsFloat;
  ResultConsultaNome   := DataSetConsulta.Fields[0].AsString;
  Close;
end;

procedure TfConsultaPrateleira.GrdConsultaDblClick(Sender: TObject);
begin
  inherited;
  Seleciona;
end;

procedure TfConsultaPrateleira.BtnSalvarClick(Sender: TObject);
var
  DataSetAux: TDataSet;
  CodSecao: string;
begin
  inherited;
  CodSecao := KeyLookUp('CODIGOSECAO','CODSECAO','SECAO', CodigoSecao, Dm.DBAutocom);
  RunSQL('SELECT CODIGOPRATELEIRA FROM PRATELEIRA WHERE CODIGOPRATELEIRA = ' + EdNome.Text + ' AND CODSECAO = ' + CodSecao,Dm.DBAutocom,DataSetAux);
  if not DataSetAux.IsEmpty then
    begin
      Application.MessageBox('Esta prateleia j? est? cadastrada!',Autocom,MB_ICONWARNING);
      EdNome.SetFocus;
      EdNome.SelectAll;
      FreeAndNil(DataSetAux);
      Abort;
    end;
  FreeAndNil(DataSetAux);
  Editando(False);
  if State = InsertSql then
    SqlPrateleira(InsertSql, CodSecao, EdCodigo.Text, EdNome.Text);
  if State = UpdateSql then
    SqlPrateleira(UpdateSql, CodSecao, EdCodigo.Text, EdNome.Text);
  EnableFields(False, PanFields);
  Refresh;
end;

procedure TfConsultaPrateleira.Refresh;
begin
  RunSQL('SELECT CODIGOPRATELEIRA, CODPRATELEIRA, CODSECAO FROM PRATELEIRA WHERE CODSECAO = ' +  KeyLookUp('CODIGOSECAO','CODSECAO','SECAO', CodigoSecao, Dm.DBAutocom) + ' ORDER BY CODIGOPRATELEIRA', Dm.DBAutocom, DataSetConsulta);
  DsConsulta.DataSet := DataSetConsulta;
  GrdConsulta.Columns[0].Width := 359;
  GrdConsulta.Columns[0].Color := $00EFD3C6;
  GrdConsulta.Columns[0].Title.Caption := 'Prateleira';
  GrdConsulta.Columns[1].Visible := False;
  GrdConsulta.Columns[2].Visible := False;
  GrdConsulta.Enabled := True;
end;

procedure TfConsultaPrateleira.EdNomeKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not (Key in ['0'..'9',#8,#13]) then Key := #0;
end;

procedure TfConsultaPrateleira.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  if DataSetConsulta.IsEmpty then Exit;
  SqlPrateleiraDelete(DataSetConsulta.FieldByName('CODPRATELEIRA').AsString);
  Refresh;
end;

procedure TfConsultaPrateleira.GrdConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN: Seleciona;
  end;
end;

end.
