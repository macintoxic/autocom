unit uConsultaSecao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uModeloConsulta, DB, Buttons, ExtCtrls, Grids, DBGrids, uGlobal, uSqlGlobal,
  StdCtrls;

type
  TfConsultaSecao = class(TfModeloConsulta)
    Label1: TLabel;
    EdCodigo: TEdit;
    EdNome: TEdit;
    Label2: TLabel;
    procedure BtnNovoClick(Sender: TObject); 
    procedure BtnEditarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GrdConsultaDblClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure GrdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
    procedure Refresh;
    procedure Seleciona;
  end;

var
  fConsultaSecao: TfConsultaSecao;

implementation

uses uDm, uMain;

{$R *.dfm}

procedure TfConsultaSecao.BtnNovoClick(Sender: TObject);
var
  Ds: TDataSet;
begin
  inherited;
  Editando(True);
  State := InsertSql;
  EnableFields(True, PanFields);
  RunSQL('SELECT MAX(CODIGOSECAO) FROM SECAO',Dm.DBAutocom,Ds);
  EdCodigo.Text := IntToStr(Ds.Fields[0].AsInteger+1);
  FreeAndNil(Ds);
  EdNome.SetFocus;
end;

procedure TfConsultaSecao.BtnEditarClick(Sender: TObject);
begin
  inherited;
  if DataSetConsulta.IsEmpty then Exit;
  Editando(True);
  EnableFields(True,PanFields);
  EdCodigo.Text := DataSetConsulta.FieldByName('CODIGOSECAO').AsString;
  EdNome.Text := DataSetConsulta.FieldByName('DESCRICAO').AsString;
  State := UpdateSql;
  EdNome.SetFocus;
end;
procedure TfConsultaSecao.Refresh;
begin
  RunSQL('SELECT CODIGOSECAO, DESCRICAO, CODSECAO FROM SECAO ORDER BY DESCRICAO', Dm.DBAutocom, DataSetConsulta);
  DsConsulta.DataSet := DataSetConsulta;
  GrdConsulta.Columns[0].Width := 64;
  GrdConsulta.Columns[1].Width := 295;
  GrdConsulta.Columns[0].Color := $00EFD3C6;
  GrdConsulta.Columns[0].Title.Caption := 'Código';
  GrdConsulta.Columns[1].Title.Caption := 'Tipo';
  GrdConsulta.Columns[2].Visible := False;
  GrdConsulta.Enabled := True;
end;

procedure TfConsultaSecao.FormShow(Sender: TObject);
begin
  inherited;
  EnableFields(False, PanFields);
  Refresh;
end;

procedure TfConsultaSecao.Seleciona;
begin
  ResultConsultaCodigo := DataSetConsulta.Fields[0].AsFloat;
  ResultConsultaNome   := DataSetConsulta.Fields[1].AsString;
  Close;
end;

procedure TfConsultaSecao.GrdConsultaDblClick(Sender: TObject);
begin
  inherited;
  Seleciona;
end;

procedure TfConsultaSecao.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  Editando(False);
  if State = InsertSql then
    SqlSecao(InsertSql, DataSetConsulta.FieldByName('CODSECAO').AsString, EdCodigo.Text, EdNome.Text, LeINI('Loja','LojaNum'));
  if State = UpdateSql then
    SqlSecao(UpdateSql, DataSetConsulta.FieldByName('CODSECAO').AsString, EdCodigo.Text, EdNome.Text, LeINI('Loja','LojaNum'));
  EnableFields(False, PanFields);
  Refresh;
end;

procedure TfConsultaSecao.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  if DataSetConsulta.IsEmpty then Exit;
  SqlSecaoDelete(DataSetConsulta.FieldByName('CODSECAO').AsString);
  Refresh;
end;

procedure TfConsultaSecao.GrdConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN: Seleciona;
  end;
end;

end.
