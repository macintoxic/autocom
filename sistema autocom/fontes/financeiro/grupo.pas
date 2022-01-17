unit grupo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DB, StdCtrls, Buttons, Mask, StrUtils;

type
  Tfrmgrupo = class(TForm)
    grd_grupo: TDBGrid;
    Ds_Grupo: TDataSource;
    PanBaixo: TPanel;
    cmd_inserir: TSpeedButton;
    cmd_Alterar: TSpeedButton;
    cmd_excluir: TSpeedButton;
    PanEdit: TPanel;
    cmd_ok: TSpeedButton;
    txt_codsecao: TEdit;
    txt_nomesecao: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    cmborigem: TComboBox;
    Label3: TLabel;
    procedure grd_grupoDblClick(Sender: TObject);
    procedure grd_grupoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmd_inserirClick(Sender: TObject);
    procedure cmd_AlterarClick(Sender: TObject);
    procedure cmd_excluirClick(Sender: TObject);
    procedure cmd_okClick(Sender: TObject);
    procedure txt_nomesecaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure txt_codsecaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MskImpressoraKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure cmborigemDropDown(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Seleciona;
  end;

var
  frmgrupo: Tfrmgrupo;
  Processo: String;

implementation

uses dm_u, financeiro_u, uglobal;

{$R *.dfm}

procedure Tfrmgrupo.Seleciona;
begin
  FrmFinanceiro.EdMovimentacao.Text:= dm.Consulta.Fields[0].asstring;
  FrmFinanceiro.lblmovimentacao.Caption:= dm.consulta.Fields[1].AsString;
  //TipoOrigem:= dm.Consulta.Fields[2].AsString; 


end;

procedure Tfrmgrupo.grd_grupoDblClick(Sender: TObject);
begin
  Seleciona;

  close;
end;

procedure Tfrmgrupo.grd_grupoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_Return then grd_grupoDblClick(Self);
  if Key = VK_Escape then close;
end;

procedure Tfrmgrupo.cmd_inserirClick(Sender: TObject);
begin
  Processo := 'Inserir';
  //Visualização
  PanEdit.Visible := True;
  Height := 410;
  PanBaixo.Visible := False;
  grd_grupo.Enabled :=False;
  txt_nomesecao.SetFocus;

  //Adiciona Código à nova Seção
  sqlrun('select max(CODIGOCONJUNTO) from CONJUNTOS', dm.portadores);
  txt_codsecao.Text := IntToStr(dm.portadores.fields[0].AsInteger + 1);
end;

procedure Tfrmgrupo.cmd_AlterarClick(Sender: TObject);
begin
  Processo := 'Alterar';
  PanEdit.Visible := True;
  Height := 410;
  PanBaixo.Visible := False;
  grd_grupo.Enabled :=False;
  //Coleta Dados para Campos Edit
  txt_codsecao.text := dm.consulta.fields[0].AsString;
  txt_nomesecao.Text := dm.consulta.fields[1].AsString;
  txt_nomesecao.SetFocus;
end;

procedure Tfrmgrupo.cmd_excluirClick(Sender: TObject);
var
  S_CodSecao: String;
begin
logsend(filename,'Excluindo dados na tabela conjunto');
  S_CodSecao := dm.consulta.fields[0].asstring;
  if MessageDlg('Tem certeza que deseja excluir?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
  begin
    try
      sqlrun('delete from CONJUNTOS where CODIGOCONJUNTO = ' +  S_CodSecao, dm.Aux);
    except
      MessageDlg('Impossível excluir!', mtWarning, [mbOk], 0);

    end;
  end;

end;

procedure Tfrmgrupo.cmd_okClick(Sender: TObject);

begin

  if Processo = 'Alterar' then
    begin
       //Grava Novos Dados na Tabela
       logsend(filename,'Alterando dados na tabela conjunto');
      sqlrun('Select * from tipoorigem where tor_descricao_a = ' + QuotedStr(cmborigem.Text)  ,dm.portadores);
      Sqlrun('Update conjuntos set NOME = '
        + QuotedStr(ifthen(isnull(txt_nomesecao.text),'null',txt_nomesecao.Text))
        + ', DATACONJUNTO = '
        + QuotedStr(formatdatetime('mm/dd/yyyy',now))
        + ', TOR_CODTIPOORIGEM = '
        + dm.portadores.Fields[0].AsString
        + ', CNJ_CODORIGEM_I = Null'
        + ', CFG_CODCONFIG = 1'
        + ' where CODIGOCONJUNTO = '
        + quotedStr(txt_codsecao.Text), dm.Inclusao);
    end;

  if Processo = 'Inserir' then begin
    // Insere novos dados na Tabela
    logsend(filename,'Inserindo dados na tabela conjunto');
    sqlrun('Select * from tipoorigem where tor_descricao_a = ' + QuotedStr(cmborigem.Text)  ,dm.portadores);
    sqlrun('Insert into Conjuntos (CODIGOCONJUNTO, NOME, TCJ_CODTIPOCONJUNTO, DATACONJUNTO, TOR_CODTIPOORIGEM, '
      + 'CNJ_CODORIGEM_I, CFG_CODCONFIG, TOTAL) values ('
      + quotedStr(txt_codsecao.Text) + ', '
      + QuotedStr(ifthen(isnull(txt_nomesecao.text),'null',txt_nomesecao.Text)) + ', '
      + 'null, '
      + QuotedStr(formatdatetime('mm/dd/yyyy',now)) + ', '
      + dm.portadores.Fields[0].AsString + ', '
      + 'null, '
      + '1, '
      + 'null'
      + ')', dm.inclusao);
   sqlrun('commit', dm.Inclusao);
  end;

  //Ajusta Visualização
  Height := 375;
  txt_codsecao.Text := '';
  txt_nomesecao.Text := '';
  PanEdit.Visible := False;
  PanBaixo.Visible := True;
  grd_grupo.Enabled :=True;
  grd_grupo.SetFocus;
end;

procedure Tfrmgrupo.txt_nomesecaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = Vk_Return then Perform(WM_NEXTDLGCTL,0,0);
end;

procedure Tfrmgrupo.FormShow(Sender: TObject);
begin
  {Tabelas.tbl_grupoproduto.Close;
  Tabelas.tbl_grupoproduto.Open;}
end;

procedure Tfrmgrupo.txt_codsecaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = Vk_Return then Perform(WM_NEXTDLGCTL,0,0);
end;

procedure Tfrmgrupo.MskImpressoraKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then Perform(WM_NEXTDLGCTL,0,0);
end;

procedure Tfrmgrupo.cmborigemDropDown(Sender: TObject);
begin
   cmborigem.Items.Clear;
   sqlrun('Select * from tipoorigem', dm.aux);
   while not dm.aux.eof do
      begin
         cmborigem.Items.Add(dm.aux.fields[1].asstring);
         dm.aux.next;
      end;
   
end;

end.
