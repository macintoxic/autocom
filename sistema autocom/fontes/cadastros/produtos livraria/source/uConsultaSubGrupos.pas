unit uConsultaSubGrupos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uModeloConsulta, Buttons, ExtCtrls, Grids, DBGrids, StdCtrls, uGlobal,
  DB, uSqlGlobal, StrUtils;

type
  TfConsultaSubGrupos = class(TfModeloConsulta)
    EdCodigo: TEdit;
    EdNome: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure GrdConsultaDblClick(Sender: TObject);
    procedure GrdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
  private
  public
    CodigoGrupo: String;
    procedure Seleciona; override;
    procedure Refresh; override;
  end;

var
  fConsultaSubGrupos: TfConsultaSubGrupos;

implementation

uses uDm, uMain, uCadastro;

{$R *.dfm}


procedure TfConsultaSubGrupos.FormShow(Sender: TObject);
begin
  inherited;
  EnableFields(False, PanFields);
  Refresh;
end;

procedure TfConsultaSubGrupos.Seleciona;
begin
  ResultConsultaCodigo := DataSetConsulta.Fields[0].AsFloat;
  ResultConsultaNome   := DataSetConsulta.Fields[1].AsString;
  Close;
end;

procedure TfConsultaSubGrupos.GrdConsultaDblClick(Sender: TObject);
begin
  inherited;
  Seleciona;
end;

procedure TfConsultaSubGrupos.GrdConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_RETURN: Seleciona;
  end;
end;

procedure TfConsultaSubGrupos.BtnNovoClick(Sender: TObject);
var
  Ds: TDataSet;
begin
  inherited;
  Editando(True);
  State := InsertSql;
  EnableFields(True, PanFields);
  RunSQL('SELECT MAX(CODIGOSUBGRUPO) FROM SUBGRUPOPRODUTO',Dm.DBAutocom,Ds);
  EdCodigo.Text := IntToStr(Ds.Fields[0].AsInteger+1);
  EdNome.SetFocus;
end;

procedure TfConsultaSubGrupos.BtnEditarClick(Sender: TObject);
begin
  inherited;
  if DataSetConsulta.IsEmpty then Exit;
  Editando(True);
  EnableFields(True,PanFields);
  EdCodigo.Text := DataSetConsulta.FieldByName('CODIGOSUBGRUPO').AsString;
  EdNome.Text := DataSetConsulta.FieldByName('SUBGRUPO').AsString;
  State := UpdateSql;
  EdNome.SetFocus;
end;

procedure TfConsultaSubGrupos.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  if DataSetConsulta.IsEmpty then Exit;
  SqlSubGrupoDelete(DataSetConsulta.FieldByName('CODIGOSUBGRUPOPRODUTO').AsString);
  Refresh;
end;

procedure TfConsultaSubGrupos.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  Editando(False);
  if State = InsertSql then
    SqlSubGrupo(InsertSql, DataSetConsulta.FieldByName('CODIGOSUBGRUPOPRODUTO').AsString, EdCodigo.Text, fcadastro.EdGrupo.Text, EdNome.Text);
  if State = UpdateSql then
    SqlSubGrupo(UpdateSql, DataSetConsulta.FieldByName('CODIGOSUBGRUPOPRODUTO').AsString, EdCodigo.Text, fcadastro.EdGrupo.Text, EdNome.Text);
  EnableFields(False, PanFields);
  RunSQL('SELECT CODIGOGRUPOPRODUTO, GRUPOPRODUTO FROM GRUPOPRODUTO ORDER BY GRUPOPRODUTO', Dm.DBAutocom, DataSetConsulta);
  Refresh;
end;

procedure TfConsultaSubGrupos.Refresh;
begin
  RunSQL('SELECT CODIGOSUBGRUPO ,SUBGRUPO, CODIGOSUBGRUPOPRODUTO, CODIGOGRUPOPRODUTO FROM SUBGRUPOPRODUTO WHERE CODIGOGRUPOPRODUTO = ' + CodigoGrupo + ' ORDER BY SUBGRUPO', Dm.DBAutocom, DataSetConsulta);
  DsConsulta.DataSet := DataSetConsulta;
  GrdConsulta.Columns[0].Width := 64;
  GrdConsulta.Columns[1].Width := 295;
  GrdConsulta.Columns[0].Color := $00EFD3C6;
  GrdConsulta.Columns[0].Title.Caption := 'Código';
  GrdConsulta.Columns[1].Title.Caption := 'Sub-Grupo';
  GrdConsulta.Columns[2].Visible := False;
  GrdConsulta.Columns[3].Visible := False;
  GrdConsulta.Enabled := True;
end;

end.
