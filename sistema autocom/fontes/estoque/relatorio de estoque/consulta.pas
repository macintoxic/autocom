unit consulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DB;

type
  TFrmConsulta = class(TForm)
    GrdConsulta: TDBGrid;
    DataSource: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure GrdConsultaDblClick(Sender: TObject);
    procedure GrdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmConsulta: TFrmConsulta;

implementation

uses module, main;

{$R *.dfm}

procedure TFrmConsulta.FormShow(Sender: TObject);
begin
  if S_DataSource = 'Tbl_Grupo' then DataSource.DataSet := Dm.Tbl_Grupo;
  if S_DataSource = 'Tbl_SubGrupo' then DataSource.DataSet := Dm.tbl_subgrupo;
  if S_DataSource = 'Tbl_Prateleira' then DataSource.DataSet := Dm.Tbl_Prateleira;
  if S_DataSource = 'Tbl_Secao' then DataSource.DataSet := Dm.Tbl_Secao;
end;

procedure TFrmConsulta.GrdConsultaDblClick(Sender: TObject);
begin

  if S_DataSource = 'Tbl_Secao' then
  begin
    I_CodSecao := Dm.Tbl_SecaoCODSECAO.AsInteger;
    FrmMain.MskSecao.Text := Dm.Tbl_SecaoCODIGOSECAO.AsString;
    FrmMain.LblSecaoNome.Caption := Dm.Tbl_SecaoDESCRICAO.AsString;
    Dm.Tbl_Prateleira.Close;
    Dm.Tbl_Prateleira.Params[0].Value := Dm.Tbl_SecaoCODSECAO.Value;
    Close;
  end;

  if S_DataSource = 'Tbl_Grupo' then
  begin
    FrmMain.MskGrupo.Text := Dm.Tbl_GrupoCODIGOGRUPOPRODUTO.AsString;
    FrmMain.LblGrupoNome.Caption := Dm.Tbl_GrupoGRUPOPRODUTO.AsString;
    Dm.Tbl_SubGrupo.Close;
    Dm.Tbl_SubGrupo.Params[0].Value := Dm.Tbl_GrupoCODIGOGRUPOPRODUTO.Value;
    Close;
  end;

  if S_DataSource = 'Tbl_SubGrupo' then
  begin
    I_CodSubGrupo := Dm.Tbl_SubGrupoCODIGOSUBGRUPOPRODUTO.AsInteger;
    FrmMain.MskSubGrupo.Text := Dm.Tbl_SubGrupoCODIGOSUBGRUPO.AsString;
    FrmMain.LblSubGrupoNome.Caption := Dm.Tbl_SubGrupoSUBGRUPO.AsString;
    Close;
  end;

  if S_DataSource = 'Tbl_Prateleira' then
  begin
    I_CodPrateleira := Dm.Tbl_PrateleiraCODPRATELEIRA.AsInteger;
    FrmMain.MskPrateleira.Text := Dm.Tbl_PrateleiraCODIGOPRATELEIRA.AsString;
    FrmMain.LblPrateleiraNome.Caption := 'PRATELEIRA ' + Dm.Tbl_PrateleiraCODIGOPRATELEIRA.AsString;
    Close;
  end;

end;

procedure TFrmConsulta.GrdConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then GrdConsultaDblClick(Self);
  if Key = VK_Escape then Close;
end;

end.
