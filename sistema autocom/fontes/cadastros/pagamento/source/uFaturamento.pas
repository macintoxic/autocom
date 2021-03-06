unit uFaturamento;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, uGlobal,
  JvComponent, JvBalloonHint;

type
  TfFaturamento = class(TForm)
    PanPesquisa: TPanel;
    BtnProcurar: TSpeedButton;
    EdPesquisa: TEdit;
    GrdMain: TDBGrid;
    DSourceFaturamento: TDataSource;
    PanEdit: TPanel;
    CmdOk: TSpeedButton;
    TxtCodigo: TEdit;
    TxtNome: TEdit;
    PanBtn: TPanel;
    cmd_inserir: TSpeedButton;
    cmd_Alterar: TSpeedButton;
    cmd_excluir: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    TxtTabela: TEdit;
    CmdTabela: TSpeedButton;
    JvBalloonHint: TJvBalloonHint;
    BtnSelectAll: TSpeedButton;
    procedure GrdMainDblClick(Sender: TObject);
    procedure BtnProcurarClick(Sender: TObject);
    procedure EdPesquisaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GrdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmd_AlterarClick(Sender: TObject);
    procedure CmdOkClick(Sender: TObject);
    procedure cmd_inserirClick(Sender: TObject);
    procedure CmdTabelaClick(Sender: TObject);
    procedure TxtTabelaKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TxtCodigoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cmd_excluirClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure GrdMainExit(Sender: TObject);
    procedure GrdMainEnter(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure TxtTabelaEnter(Sender: TObject);
    procedure TxtTabelaExit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnSelectAllClick(Sender: TObject);
  private
    DsFaturamento: TDataSet;
    procedure SelectAllFaturamento;
  public
    ResultCodigo, ResultNome: String;
  end;

var
  fFaturamento: TfFaturamento;
  S_FormaStatus: String;

implementation

uses uDm, uMain, uTabelaPreco;

{$R *.dfm}

procedure TfFaturamento.GrdMainDblClick(Sender: TObject);
begin
  ResultCodigo := DsFaturamento.FieldByName('CODIGOFORMAFATURAMENTO').AsString;
  ResultNome := DsFaturamento.FieldByName('FORMAFATURAMENTO').AsString;
  Close;
end;

procedure TfFaturamento.BtnProcurarClick(Sender: TObject);
begin
  if IsFloat(EdPesquisa.Text) then
    RunSql('select ff.*, tp.tabelapreco from formafaturamento ff left join tabelapreco tp on (ff.codigotabelapreco = tp.codigotabelapreco) Where CODIGOFORMAFATURAMENTO = ' + EdPesquisa.Text, dm.dbautocom,DsFaturamento)
  else
    RunSql('select ff.*, tp.tabelapreco from formafaturamento ff left join tabelapreco tp on (ff.codigotabelapreco = tp.codigotabelapreco)  Where FORMAFATURAMENTO LIKE ' + QuotedStr('%' + EdPesquisa.Text + '%'), dm.dbautocom,DsFaturamento);
  DSourceFaturamento.DataSet := DsFaturamento;
  GrdMain.SetFocus;
end;

procedure TfFaturamento.EdPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F12 then BtnProcurar.Click;
end;

procedure TfFaturamento.GrdMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_Return then GrdMainDblClick(Self);
  if Key = Vk_Escape then Close;
  if Key = VK_DOWN then
    if DsFaturamento.RecNo = DsFaturamento.RecordCount then Perform(WM_NEXTDLGCTL,0,0);
end;

procedure TfFaturamento.cmd_AlterarClick(Sender: TObject);
var
  DsAux: TDataSet;
begin

  if DsFaturamento.IsEmpty then Exit;

  PanPesquisa.Visible := False;
  PanBtn.Visible := False;
  PanEdit.Visible := True;

  S_FormaStatus := 'Update';

  //Recolhe Dados
  TxtCodigo.Text := DsFaturamento.FieldByName('CODIGOFORMAFATURAMENTO').AsString;
  TxtNome.Text := DsFaturamento.FieldByName('FORMAFATURAMENTO').AsString;
  if not DsFaturamento.FieldByName('CODIGOTABELAPRECO').IsNull then
    begin
      RunSql('Select CODIGOTABELA from TABELAPRECO WHERE CODIGOTABELAPRECO = ' + DsFaturamento.FieldByName('CODIGOTABELAPRECO').AsString,dm.dbautocom,DsAux);
      TxtTabela.Text := DsAux.Fields[0].AsString;
    end
  else
    TxtTabela.Clear;
  TxtTabela.SetFocus;
  FreeAndNil(DsAux);
end;

procedure TfFaturamento.CmdOkClick(Sender: TObject);
var
  Codigo: string;
  DsAux: TDataSet;
begin
  IsEditNull('Nome',TxtNome);

  TxtTabelaExit(TxtTabela);
  if IsNull(TxtTabela.Text) then
    Codigo := 'NULL'
  else
    begin
      RunSql('SELECT CODIGOTABELAPRECO FROM TABELAPRECO WHERE CODIGOTABELA = ' + TxtTabela.Text, dm.dbautocom,DsAux);
      Codigo := DsAux.Fields[0].AsString;
      if IsNull(Codigo) then Codigo := 'Null';
    end;

  PanPesquisa.Visible := True;
  PanBtn.Visible := True;
  PanEdit.Visible := False;

  if S_FormaStatus = 'Insert' then
    begin
      RunSql('INSERT INTO FORMAFATURAMENTO ' +
                   '(CODIGOFORMAFATURAMENTO, FORMAFATURAMENTO, CODIGOTABELAPRECO)' +
                    'VALUES (' +
                    TxtCodigo.Text + ', ' +
                    Chr(39) + TxtNome.Text + Chr(39) + ', ' +
                    Codigo + ')',dm.dbautocom);
    end;

  if S_FormaStatus = 'Update' then
    begin
      RunSql('UPDATE FORMAFATURAMENTO SET ' +
                   'FORMAFATURAMENTO = ' + Chr(39) + TxtNome.Text + Chr(39) +', ' +
                   'CODIGOTABELAPRECO = ' + Codigo +
                   ' WHERE CODIGOFORMAFATURAMENTO = ' + TxtCodigo.Text,dm.dbautocom);
    end;
  FreeAndNil(DsAux);
  SelectAllFaturamento;
end;

procedure TfFaturamento.cmd_inserirClick(Sender: TObject);
var
  DsAux: TDataSet;
begin

  PanPesquisa.Visible := False;
  PanBtn.Visible := False;
  PanEdit.Visible := True;

  S_FormaStatus := 'Insert';

  //Recolhe Dados
  RunSql('Select Max(CODIGOFORMAFATURAMENTO) FROM FORMAFATURAMENTO',dm.dbautocom,DsAux);
  TxtCodigo.Text := IntToStr(DsAux.Fields[0].AsInteger + 1);
  
  TxtNome.Text := '';
  TxtTabela.Text := '';
  TxtNome.SetFocus;
  FreeAndNil(DsAux);
end;


procedure TfFaturamento.CmdTabelaClick(Sender: TObject);
begin
  with TFTabelaPreco.Create(Self) do
    begin
      ShowModal;
      TxtTabela.Text := ResultCodigo;
      Free;
    end;
end;

procedure TfFaturamento.TxtTabelaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then CmdTabelaClick(Self);
end;

procedure TfFaturamento.TxtCodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then CmdOk.Click;
end;

procedure TfFaturamento.cmd_excluirClick(Sender: TObject);
begin
  if DsFaturamento.IsEmpty then Exit;
  if MessageDlg('Tem Certeza que Deseja excluir ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    try
      RunSql('Delete from FORMAFATURAMENTO Where CODIGOFORMAFATURAMENTO = ' + DsFaturamento.FieldByName('CODIGOFORMAFATURAMENTO').AsString,dm.dbautocom);
      SelectAllFaturamento;
    except
      MessageDlg('Imposs?vel Deletar este Registro!', mtError, [mbYes], 0)
    end;
end;

procedure TfFaturamento.SpeedButton1Click(Sender: TObject);
begin
  TxtTabela.Text := '';
end;

procedure TfFaturamento.GrdMainExit(Sender: TObject);
begin
  KeyPreview := True;
end;

procedure TfFaturamento.GrdMainEnter(Sender: TObject);
begin
  KeyPreview := False;
end;

procedure TfFaturamento.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_DOWN) or (Key = VK_RETURN) or (Key = VK_RIGHT) then
    Perform(WM_NEXTDLGCTL, 0, 0);
  if (Key = VK_LEFT) or (Key = VK_UP) then
    Perform(WM_NEXTDLGCTL, 1, 0);
  if Key = VK_F5 then SelectAllFaturamento;
end;

procedure TfFaturamento.TxtTabelaEnter(Sender: TObject);
begin
  JvBalloonHint.ActivateHint(TxtTabela,TxtTabela.Hint);
end;

procedure TfFaturamento.TxtTabelaExit(Sender: TObject);
var
  DsAux: TDataSet;
begin
  JvBalloonHint.CancelHint;
  if ISNull(TxtTabela.Text) then exit;
  RunSQL('SELECT CODIGOTABELA FROM TABELAPRECO WHERE CODIGOTABELA = ' + TxtTabela.Text,dm.dbautocom,DsAux);
  if DsAux.IsEmpty then
    begin
      Application.MessageBox('C?digo Inv?lido, Verifique',Autocom,MB_ICONWARNING);
      TxtTabela.SetFocus;
      Abort;  
    end;
  FreeAndNil(DsAux);
end;

procedure TfFaturamento.SelectAllFaturamento;
begin
  RunSQL('select ff.*, tp.tabelapreco from formafaturamento ff left join tabelapreco tp on (ff.codigotabelapreco = tp.codigotabelapreco) order by formafaturamento',dm.dbautocom,DsFaturamento);
  DSourceFaturamento.DataSet := DsFaturamento;
end;

procedure TfFaturamento.FormShow(Sender: TObject);
begin
  SelectAllFaturamento;
end;

procedure TfFaturamento.BtnSelectAllClick(Sender: TObject);
begin
   SelectAllFaturamento;
end;

end.
