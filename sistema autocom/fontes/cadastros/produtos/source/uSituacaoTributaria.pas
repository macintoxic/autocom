unit uSituacaoTributaria;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uModeloConsulta, DB, Buttons, ExtCtrls, Grids, DBGrids, StdCtrls,
  uGlobal, uSqlGlobal;
type
  TfSituacaoTributaria = class(TfModeloConsulta)
    EdCodigo: TEdit;
    Label1: TLabel;
    EdNome: TEdit;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure GrdConsultaDblClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure GrdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private  
  public
    procedure Refresh;
    procedure Seleciona;
  end;

var
  fSituacaoTributaria: TfSituacaoTributaria;

implementation

uses uCadastro, uDm, uMain;

{$R *.dfm}

{ TfSituacaoTributaria }

procedure TfSituacaoTributaria.Refresh;
begin
  RunSQL('SELECT CODIGOSITUACAOTRIBUTARIA ,SITUACAOTRIBUTARIA FROM SITUACAOTRIBUTARIA ORDER BY SITUACAOTRIBUTARIA', Dm.DBAutocom, DataSetConsulta);
  DsConsulta.DataSet := DataSetConsulta;
  GrdConsulta.Columns[0].Width := 64;
  GrdConsulta.Columns[1].Width := 295;
  GrdConsulta.Columns[0].Color := $00EFD3C6;
  GrdConsulta.Columns[0].Title.Caption := 'Código';
  GrdConsulta.Columns[1].Title.Caption := 'Situação Tributária';
  GrdConsulta.Enabled := True;
end;

procedure TfSituacaoTributaria.FormShow(Sender: TObject);
begin
  inherited;
  EnableFields(False, PanFields);
  Refresh;
end;

procedure TfSituacaoTributaria.Seleciona;
begin
  ResultConsultaCodigo := DataSetConsulta.Fields[0].AsFloat;
  ResultConsultaNome   := DataSetConsulta.Fields[1].AsString;
  Close;
end;

procedure TfSituacaoTributaria.GrdConsultaDblClick(Sender: TObject);
begin
  inherited;
  Seleciona;
end;

procedure TfSituacaoTributaria.BtnNovoClick(Sender: TObject);
var
  Ds: TDataSet;
begin
  inherited;
  Editando(True);
  State := InsertSql;
  EnableFields(True, PanFields);
  RunSQL('SELECT MAX(CODIGOSITUACAOTRIBUTARIA) FROM SITUACAOTRIBUTARIA',Dm.DBAutocom,Ds);
  EdCodigo.Text := IntToStr(Ds.Fields[0].AsInteger+1);
  EdNome.SetFocus;
end;

procedure TfSituacaoTributaria.BtnEditarClick(Sender: TObject);
begin
  inherited;
  if DataSetConsulta.IsEmpty then Exit;
  Editando(True);
  EnableFields(True,PanFields);
  EdCodigo.Text := DataSetConsulta.FieldByName('CODIGOSITUACAOTRIBUTARIA').AsString;
  EdNome.Text := DataSetConsulta.FieldByName('SITUACAOTRIBUTARIA').AsString;
  State := UpdateSql;
  EdNome.SetFocus;
end;

procedure TfSituacaoTributaria.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  if DataSetConsulta.IsEmpty then Exit;
  SqlSituacaoTributariaDelete(DataSetConsulta.FieldByName('CODIGOSITUACAOTRIBUTARIA').AsString);
  Refresh;
end;

procedure TfSituacaoTributaria.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  Editando(False);
  if State = InsertSql then
    SqlSituacaoTributaria(InsertSql, EdCodigo.Text, EdNome.Text);
  if State = UpdateSql then
    SqlSituacaoTributaria(UpdateSql, EdCodigo.Text, EdNome.Text);
  EnableFields(False, PanFields);
  Refresh;
end;

procedure TfSituacaoTributaria.GrdConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_RETURN: Seleciona;
  end;
end;

end.
