unit uTabelaPreco;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Grids, DBGrids, Buttons, ExtCtrls, uGlobal;

type
  TfTabelaPreco = class(TForm)
    PanBaixo: TPanel;
    cmd_inserir: TSpeedButton;
    cmd_Alterar: TSpeedButton;
    cmd_excluir: TSpeedButton;
    grd_grupo: TDBGrid;
    PanEdit: TPanel;
    cmd_ok: TSpeedButton;
    txt_codsecao: TEdit;
    txt_nomesecao: TEdit;
    DSourcePreco: TDataSource;
    procedure cmd_inserirClick(Sender: TObject);
    procedure cmd_AlterarClick(Sender: TObject);
    procedure cmd_excluirClick(Sender: TObject);
    procedure cmd_okClick(Sender: TObject);
    procedure grd_grupoDblClick(Sender: TObject);
    procedure grd_grupoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure txt_nomesecaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure grd_grupoEnter(Sender: TObject);
    procedure grd_grupoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    DsPreco: TDataSet;
    procedure SelectAllPreco;
  public
    ResultCodigo, ResultNome: String;
  end;

var
  fTabelaPreco: TfTabelaPreco;
  Processo: String;

implementation

uses uMain, uDm, uFaturamento;

{$R *.dfm}

procedure TfTabelaPreco.cmd_inserirClick(Sender: TObject);
var
  DsData: TDataSet;
begin
  Processo := 'Inserir';
  //Visualização
  PanEdit.Visible := True;
  PanBaixo.Visible := False;
  grd_grupo.Enabled :=False;

  //Adiciona Código à nova Seção
  RunSql('select max(CODIGOTABELA) from TABELAPRECO',dm.dbautocom,DsData);
  txt_codsecao.Text := FloatToStr(DsData.Fields[0].AsFloat + 1);
  txt_nomesecao.SetFocus;
  FreeAndNil(DsData);  
end;

procedure TfTabelaPreco.cmd_AlterarClick(Sender: TObject);
begin
  if DsPreco.IsEmpty then Exit;
  Processo := 'Alterar';
  PanEdit.Visible := True;
  PanBaixo.Visible := False;
  grd_grupo.Enabled :=False;
  //Coleta Dados para Campos Edit
  txt_codsecao.text := DsPreco.FieldByName('CODIGOTABELA').AsString;
  txt_nomesecao.Text := DsPreco.FieldByName('TABELAPRECO').AsString;
  txt_nomesecao.SetFocus;
end;

procedure TfTabelaPreco.cmd_excluirClick(Sender: TObject);
begin
  if DsPreco.IsEmpty then Exit;
  if MessageDlg('Tem Certeza que Deseja excluir ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      RunSQL('Delete from TABELAPRECO Where CODIGOTABELA = ' +  DsPreco.FieldByName('CODIGOTABELA').AsString,dm.dbautocom);
      SelectAllPreco;
    except
      MessageDlg('Impossível excluir este Registro!',mtInformation, [mbOk], 0);
    end;
  end;
end;

procedure TfTabelaPreco.cmd_okClick(Sender: TObject);
begin
  if Processo = 'Alterar' then
    begin
      RunSql(' UPDATE TABELAPRECO SET TABELAPRECO = '+ QuotedStr(txt_nomesecao.Text) +
             ' WHERE CODIGOTABELA = ' + txt_codsecao.Text,dm.dbautocom);
      SelectAllPreco;
    end;

  if Processo = 'Inserir' then
    begin
      RunSql('Insert into TABELAPRECO ' +
             '(CODIGOTABELA, TABELAPRECO, DATA, CFG_CODCONFIG) values (' +
             txt_codsecao.Text + ',' + QuotedStr(Txt_nomesecao.Text) + ', ' +
             QuotedStr(FormatDateTime('mm/dd/yyyy',Date)) +  ', 1)',dm.dbautocom);
      SelectAllPreco;
    end;

  //Ajusta Visualização
  txt_codsecao.Text := '';
  txt_nomesecao.Text := '';
  PanEdit.Visible := False;
  PanBaixo.Visible := True;
  grd_grupo.Enabled :=True;
  grd_grupo.SetFocus;
end;

procedure TfTabelaPreco.grd_grupoDblClick(Sender: TObject);
begin
  ResultCodigo := DsPreco.FieldByName('CODIGOTABELA').AsString;
  ResultNome := DsPreco.FieldByName('TABELAPRECO').AsString;
  Close;
end;

procedure TfTabelaPreco.grd_grupoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then grd_grupoDblClick(Self);
  if Key = VK_Escape then close;
  if Key = VK_DOWN then
    if DsPreco.RecNo = DsPreco.RecordCount then Perform(WM_NEXTDLGCTL,0,0);
end;

procedure TfTabelaPreco.txt_nomesecaoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = Vk_Return then cmd_okClick(Self);
end;

procedure TfTabelaPreco.grd_grupoEnter(Sender: TObject);
begin
  KeyPreview := False;
end;

procedure TfTabelaPreco.grd_grupoExit(Sender: TObject);
begin
  KeyPreview := True;
end;

procedure TfTabelaPreco.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DOWN) or (Key = VK_RETURN) or (Key = VK_RIGHT) then
    Perform(WM_NEXTDLGCTL, 0, 0);
  if (Key = VK_LEFT) or (Key = VK_UP) then
    Perform(WM_NEXTDLGCTL, 1, 0);
end;

procedure TfTabelaPreco.SelectAllPreco;
begin
  RunSql('SELECT * FROM TABELAPRECO ORDER BY TABELAPRECO',dm.dbautocom,DsPreco);
  DSourcePreco.DataSet := DsPreco;
end;

procedure TfTabelaPreco.FormShow(Sender: TObject);
begin
  SelectAllPreco;
end;

end.
