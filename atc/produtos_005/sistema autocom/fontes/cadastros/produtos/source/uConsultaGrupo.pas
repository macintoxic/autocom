unit uConsultaGrupo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uModeloConsulta, DB, Buttons, ExtCtrls, Grids, DBGrids, StdCtrls,
  uGlobal, uSqlGlobal, StrUtils;

type
  TfConsultaGrupo = class(TfModeloConsulta)
    EdCodigo: TEdit;
    Label1: TLabel;
    EdNome: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    EdImpressora: TEdit;
    BtnConsultaSubGrupo: TSpeedButton;
    procedure FormShow(Sender: TObject);
    procedure GrdConsultaDblClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure GrdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
    procedure Seleciona; override;
    procedure Refresh; override;
  end;

var
  fConsultaGrupo: TfConsultaGrupo;

implementation

uses uDm, uMain;

{$R *.dfm}

procedure TfConsultaGrupo.FormShow(Sender: TObject);
begin
  inherited;
  Refresh;
  EnableFields(False, PanFields);
end;

procedure TfConsultaGrupo.Seleciona;
begin
  ResultConsultaCodigo := DataSetConsulta.Fields[0].AsFloat;
  ResultConsultaNome   := DataSetConsulta.Fields[1].AsString;
  Close;
end;

procedure TfConsultaGrupo.GrdConsultaDblClick(Sender: TObject);
begin
  inherited;
  Seleciona;
end;

procedure TfConsultaGrupo.BtnNovoClick(Sender: TObject);
var
  Ds: TDataSet;
begin
  inherited;
  Editando(True);
  State := InsertSql;
  EnableFields(True, PanFields);
  RunSQL('SELECT MAX(CODIGOGRUPOPRODUTO) FROM GRUPOPRODUTO',Dm.DBAutocom,Ds);
  EdCodigo.Text := IntToStr(Ds.Fields[0].AsInteger+1);
  EdNome.SetFocus;
end;


procedure TfConsultaGrupo.BtnSalvarClick(Sender: TObject);
begin
  inherited;
  Editando(False);
  if State = InsertSql then
    SqlGrupo(InsertSql, EdCodigo.Text, EdNome.Text, IfThen((not IsNull(EdImpressora.Text)) and (IsInteger(EdImpressora.Text)),EdImpressora.Text,'NULL'));
  if State = UpdateSql then
    SqlGrupo(UpdateSql, EdCodigo.Text, EdNome.Text, IfThen((not IsNull(EdImpressora.Text)) and (IsInteger(EdImpressora.Text)),EdImpressora.Text,'NULL'));
  EnableFields(False, PanFields);
  RunSQL('SELECT CODIGOGRUPOPRODUTO, GRUPOPRODUTO FROM GRUPOPRODUTO ORDER BY GRUPOPRODUTO', Dm.DBAutocom, DataSetConsulta);
  Refresh;
end;

procedure TfConsultaGrupo.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  SqlGrupoDelete(DataSetConsulta.FieldByName('CODIGOGRUPOPRODUTO').AsString);
  Refresh;
end;

procedure TfConsultaGrupo.Refresh;
begin
  RunSQL('SELECT CODIGOGRUPOPRODUTO, GRUPOPRODUTO, CODIGOIMPRESSORA FROM GRUPOPRODUTO ORDER BY GRUPOPRODUTO', Dm.DBAutocom, DataSetConsulta);
  DsConsulta.DataSet := DataSetConsulta;
  GrdConsulta.Columns[0].Width := 64;
  GrdConsulta.Columns[1].Width := 295;
  GrdConsulta.Columns[0].Color := $00EFD3C6;
  GrdConsulta.Columns[0].Title.Caption := 'Código';
  GrdConsulta.Columns[1].Title.Caption := 'Grupo';
  GrdConsulta.Columns[2].Visible := False;
  GrdConsulta.Enabled := True;
end;

procedure TfConsultaGrupo.BtnEditarClick(Sender: TObject);
begin
  inherited;
  Editando(True);
  EnableFields(True,PanFields);
  EdCodigo.Text := DataSetConsulta.FieldByName('CODIGOGRUPOPRODUTO').AsString;
  EdNome.Text := DataSetConsulta.FieldByName('GRUPOPRODUTO').AsString;
  EdImpressora.Text := DataSetConsulta.FieldByName('CODIGOIMPRESSORA').AsString;
  State := UpdateSql;
  EdNome.SetFocus;
end;

procedure TfConsultaGrupo.GrdConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_RETURN: Seleciona;
  end;
end;

end.
