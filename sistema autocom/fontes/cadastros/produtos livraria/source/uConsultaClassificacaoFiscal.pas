unit uConsultaClassificacaoFiscal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uModeloConsulta, DB, Buttons, ExtCtrls, Grids, DBGrids, StdCtrls,
  uGlobal, uSqlGlobal;

type
  TfConsultaClassificacaoFiscal = class(TfModeloConsulta)
    Label1: TLabel;
    EdCodigo: TEdit;
    EdNome: TEdit;
    Label2: TLabel;
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure GrdConsultaDblClick(Sender: TObject);
    procedure BtnSalvarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure GrdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
    procedure Refresh; override;
    procedure Seleciona; override;
  end;

var
  fConsultaClassificacaoFiscal: TfConsultaClassificacaoFiscal;

implementation

uses uDm, uMain;

{$R *.dfm}

procedure TfConsultaClassificacaoFiscal.BtnNovoClick(Sender: TObject);
var
  Ds: TDataSet;
begin
  inherited;
  Editando(True);
  State := InsertSql;
  EnableFields(True, PanFields);
  RunSQL('SELECT MAX(CODIGOCLASSIFICACAOFISCAL) FROM CLASSIFICACAOFISCAL',Dm.DBAutocom,Ds);
  EdCodigo.Text := IntToStr(Ds.Fields[0].AsInteger+1);
  EdCodigo.SetFocus;
end;

procedure TfConsultaClassificacaoFiscal.BtnEditarClick(Sender: TObject);
begin
  inherited;
  if DataSetConsulta.IsEmpty then Exit;
  State := UpdateSql;
  Editando(True);
  EnableFields(True,PanFields);
  EdCodigo.Text := DataSetConsulta.FieldByName('CODIGOCLASSIFICACAOFISCAL').AsString;
  EdNome.Text := DataSetConsulta.FieldByName('CLASSIFICACAOFISCAL').AsString;
  EdCodigo.SetFocus;
end;

procedure TfConsultaClassificacaoFiscal.BtnExcluirClick(Sender: TObject);
begin
  inherited;
  if DataSetConsulta.IsEmpty then Exit;
  SqlClassificaoFiscaDelete(DataSetConsulta.FieldByName('CODIGOCLASSIFICACAOFISCAL').AsString);
  Refresh;
end;

procedure TfConsultaClassificacaoFiscal.Refresh;
begin
  RunSQL('SELECT CODIGOCLASSIFICACAOFISCAL, CLASSIFICACAOFISCAL FROM CLASSIFICACAOFISCAL ORDER BY CLASSIFICACAOFISCAL', Dm.DBAutocom, DataSetConsulta);
  DsConsulta.DataSet := DataSetConsulta;
  GrdConsulta.Columns[0].Width := 64;
  GrdConsulta.Columns[1].Width := 295;
  GrdConsulta.Columns[0].Color := $00EFD3C6;
  GrdConsulta.Columns[0].Title.Caption := 'Código';
  GrdConsulta.Columns[1].Title.Caption := 'Classificação Fiscal';
  GrdConsulta.Enabled := True;
end;

procedure TfConsultaClassificacaoFiscal.Seleciona;
begin
  ResultConsultaCodigo := DataSetConsulta.Fields[0].AsFloat;
  ResultConsultaNome   := DataSetConsulta.Fields[1].AsString;
  Close;
end;

procedure TfConsultaClassificacaoFiscal.GrdConsultaDblClick(
  Sender: TObject);
begin
  inherited;
  Seleciona;
end;

procedure TfConsultaClassificacaoFiscal.BtnSalvarClick(Sender: TObject);
begin
   inherited;
  Editando(False);
  if State = InsertSql then
    SqlClassificaoFiscal(InsertSql, EdCodigo.Text, EdNome.Text);
  if State = UpdateSql then
    SqlClassificaoFiscal(UpdateSql, EdCodigo.Text, EdNome.Text);
  EnableFields(False, PanFields);
  Refresh;
end;

procedure TfConsultaClassificacaoFiscal.FormShow(Sender: TObject);
begin
  inherited;
  Refresh;
  EnableFields(False, PanFields);
end;

procedure TfConsultaClassificacaoFiscal.GrdConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  case key of
    VK_RETURN: Seleciona;
  end;
end;

end.
