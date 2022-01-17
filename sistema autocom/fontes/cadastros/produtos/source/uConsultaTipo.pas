unit uConsultaTipo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uModeloConsulta, DB, Buttons, ExtCtrls, Grids, DBGrids, uGlobal, uSqlGlobal,
  StdCtrls;

type
  TfConsultaTipo = class(TfModeloConsulta)
    EdNome: TEdit;
    Label2: TLabel;
    EdCodigo: TEdit;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure GrdConsultaDblClick(Sender: TObject);
    procedure GrdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
  private 
  public
    procedure Seleciona;
    procedure Refresh;
  end;

var
  fConsultaTipo: TfConsultaTipo;

implementation

uses uDm, uMain;

{$R *.dfm}

procedure TfConsultaTipo.FormShow(Sender: TObject);
begin
  inherited;
  EnableFields(False, PanFields);
  Refresh;
end;

procedure TfConsultaTipo.Seleciona;
begin
  ResultConsultaCodigo := DataSetConsulta.Fields[0].AsFloat;
  ResultConsultaNome   := DataSetConsulta.Fields[1].AsString;
  Close;
end;

procedure TfConsultaTipo.GrdConsultaDblClick(Sender: TObject);
begin
  inherited;
  Seleciona;
end;

procedure TfConsultaTipo.GrdConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case key of
    VK_RETURN: Seleciona;
  end;
end;

procedure TfConsultaTipo.Refresh;
begin
  RunSQL('SELECT CODIGOTIPOPRODUTO , DESCRICAO, CODTIPOPRODUTO FROM TIPOPRODUTO ORDER BY DESCRICAO', Dm.DBAutocom, DataSetConsulta);
  DsConsulta.DataSet := DataSetConsulta;
  GrdConsulta.Columns[0].Width := 64;
  GrdConsulta.Columns[1].Width := 295;
  GrdConsulta.Columns[0].Color := $00EFD3C6;
  GrdConsulta.Columns[0].Title.Caption := 'Código';
  GrdConsulta.Columns[1].Title.Caption := 'Tipo';
  GrdConsulta.Columns[2].Visible := False;
  GrdConsulta.Enabled := True;
end;

procedure TfConsultaTipo.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  Editando(False);
  if State = InsertSql then
    SqlTipo(InsertSql, DataSetConsulta.FieldByName('CODTIPOPRODUTO').AsString, EdCodigo.Text, EdNome.Text);
  if State = UpdateSql then
    SqlTipo(UpdateSql, DataSetConsulta.FieldByName('CODTIPOPRODUTO').AsString, EdCodigo.Text, EdNome.Text);
  EnableFields(False, PanFields);
  RunSQL('SELECT CODIGOGRUPOPRODUTO, GRUPOPRODUTO FROM GRUPOPRODUTO ORDER BY GRUPOPRODUTO', Dm.DBAutocom, DataSetConsulta);
  Refresh;
end;

procedure TfConsultaTipo.BtnEditarClick(Sender: TObject);
begin
  inherited;
  if DataSetConsulta.IsEmpty then Exit;
  Editando(True);
  EnableFields(True,PanFields);
  EdCodigo.Text := DataSetConsulta.FieldByName('CODIGOTIPOPRODUTO').AsString;
  EdNome.Text := DataSetConsulta.FieldByName('DESCRICAO').AsString;
  State := UpdateSql;
  EdCodigo.SetFocus;
end;

procedure TfConsultaTipo.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  if DataSetConsulta.IsEmpty then Exit;
  SqlTipoDelete(DataSetConsulta.FieldByName('CODTIPOPRODUTO').AsString);
  Refresh;
end;

procedure TfConsultaTipo.BtnNovoClick(Sender: TObject);
var
  Ds: TDataSet;
begin
  inherited;
  Editando(True);
  State := InsertSql;
  EnableFields(True, PanFields);
  RunSQL('SELECT MAX(CODIGOTIPOPRODUTO) FROM TIPOPRODUTO',Dm.DBAutocom,Ds);
  EdCodigo.Text := IntToStr(Ds.Fields[0].AsInteger+1);
  EdCodigo.SetFocus;
end;

end.
