unit uConsultaPreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uModeloConsulta, DB, Buttons, ExtCtrls, Grids, DBGrids, StdCtrls,
  uSqlGlobal, uGlobal;

type
  TfConsultaPreco = class(TfModeloConsulta)
    Label1: TLabel;
    EdCodigo: TEdit;
    Label2: TLabel;
    EdNome: TEdit;
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GrdConsultaDblClick(Sender: TObject);
    procedure GrdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
    procedure Seleciona; override;
    procedure Refresh; override; 
  end;

var
  fConsultaPreco: TfConsultaPreco;

implementation

uses uDm, uMain, uCadastro;

{$R *.dfm}

{ TfConsultaPreco }

procedure TfConsultaPreco.Seleciona;
begin
  ResultConsultaCodigo := DataSetConsulta.Fields[0].AsFloat;
  ResultConsultaNome   := DataSetConsulta.Fields[1].AsString;
  Close;
end;

procedure TfConsultaPreco.BtnEditarClick(Sender: TObject);
begin
  inherited;
  if DataSetConsulta.IsEmpty then Exit;
  Editando(True);
  EnableFields(True,PanFields);
  EdCodigo.Text := DataSetConsulta.FieldByName('CODIGOTABELA').AsString;
  EdNome.Text := DataSetConsulta.FieldByName('TABELAPRECO').AsString;
  State := UpdateSql;
  EdNome.SetFocus;
end;

procedure TfConsultaPreco.BtnNovoClick(Sender: TObject);
var
  Ds: TDataSet;
begin
  inherited;
  Editando(True);
  State := InsertSql;
  EnableFields(True, PanFields);
  RunSQL('SELECT MAX(CODIGOTABELA) FROM TABELAPRECO',Dm.DBAutocom,Ds);
  EdCodigo.Text := IntToStr(Ds.Fields[0].AsInteger+1);
  FreeAndNil(Ds);
  EdNome.SetFocus
end;

procedure TfConsultaPreco.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  if DataSetConsulta.IsEmpty then Exit;
  SqlTabelaPrecoDelete(DataSetConsulta.FieldByName('CODIGOTABELAPRECO').AsString);
  Refresh;
end;

procedure TfConsultaPreco.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  Editando(False);
  if State = InsertSql then
    SqlTabelaPreco(InsertSql, DataSetConsulta.FieldByName('CODIGOTABELAPRECO').AsString, EdCodigo.Text, EdNome.Text);
  if State = UpdateSql then
    SqlTabelaPreco(UpdateSql, DataSetConsulta.FieldByName('CODIGOTABELAPRECO').AsString, EdCodigo.Text, EdNome.Text);
  EnableFields(False, PanFields);
  Refresh;
end;

procedure TfConsultaPreco.Refresh;
begin
  RunSQL('SELECT CODIGOTABELA, TABELAPRECO, CODIGOTABELAPRECO FROM TABELAPRECO ORDER BY TABELAPRECO', Dm.DBAutocom, DataSetConsulta);
  DsConsulta.DataSet := DataSetConsulta;
  GrdConsulta.Columns[0].Width := 64;
  GrdConsulta.Columns[1].Width := 295;
  GrdConsulta.Columns[0].Color := $00EFD3C6;
  GrdConsulta.Columns[0].Title.Caption := 'C?digo';
  GrdConsulta.Columns[1].Title.Caption := 'Tabela';
  GrdConsulta.Columns[2].Visible := False;
  GrdConsulta.Enabled := True;
end;

procedure TfConsultaPreco.FormShow(Sender: TObject);
begin
  inherited;
  EnableFields(False, PanFields);
  Refresh;
end;

procedure TfConsultaPreco.GrdConsultaDblClick(Sender: TObject);
begin
  inherited;
  Seleciona;
end;

procedure TfConsultaPreco.GrdConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case Key of
    VK_RETURN: Seleciona;
  end;
end;

end.
