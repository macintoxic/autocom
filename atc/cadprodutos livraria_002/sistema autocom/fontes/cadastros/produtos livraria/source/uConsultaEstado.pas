unit uConsultaEstado;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, uGlobal;

type
  TfConsultaEstado = class(TForm)
    GrdConsulta: TDBGrid;
    DsEstados: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure GrdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrdConsultaDblClick(Sender: TObject);
  private
    procedure Seleciona;
  public
    DataSetEstados: TDataSet;
  end;

var
  fConsultaEstado: TfConsultaEstado;

implementation

uses uDm, uMain, uCadastro;

{$R *.dfm}

procedure TfConsultaEstado.FormShow(Sender: TObject);
begin
  RunSql('SELECT * FROM ESTADO',Dm.DBAutocom,DataSetEstados);
  DsEstados.DataSet := DataSetEstados;
  GrdConsulta.Columns[0].Visible := False;
  GrdConsulta.Columns[1].Color := $00EFD3C6;
  GrdConsulta.Columns[1].Width := 64;
  GrdConsulta.Columns[2].Width := 295;
  GrdConsulta.Columns[1].Title.Caption := 'Sigla';
  GrdConsulta.Columns[2].Title.Caption := 'Nome';
end;

procedure TfConsultaEstado.GrdConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then Seleciona;
end;

procedure TfConsultaEstado.Seleciona;
var
  DsAux: TDataSet;
begin
  RunSQL('SELECT UF FROM ICMSPRODUTO WHERE UF = ' + QuotedStr(DataSetEstados.FieldByName('CODIGOESTADO').AsString) + ' AND CODIGOPRODUTO = ' + fCadastro.EdCodigo.Text,Dm.DBAutocom,DsAux);
  if DsAux.IsEmpty then
    begin
      fCadastro.StrAux := DataSetEstados.FieldByName('CODIGOESTADO').AsString;
      Close;
    end
  else
    Application.MessageBox('Já existe uma alíquota cadastrada para este Estado.',Autocom,MB_ICONWARNING);

end;

procedure TfConsultaEstado.GrdConsultaDblClick(Sender: TObject);
begin
  Seleciona;
end;

end.
