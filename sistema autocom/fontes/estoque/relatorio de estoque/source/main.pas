unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, IniFiles, Buttons, Mask, XPMenu, SUIButton,
  SUIImagePanel, SUIGroupBox, SUIForm, SUIMgr, SUIThemes;

type
  TFrmMain = class(TForm)
    LblTitle: TLabel;
    PanFiltroSaldo: TPanel;
    LblFDe: TLabel;
    TxtFAte: TLabel;
    PanSecao: TPanel;
    CmdSecao: TSpeedButton;
    LblSecaoNome: TLabel;
    LblSecao: TLabel;
    PanGrupo: TPanel;
    CmdGrupo: TSpeedButton;
    LblGrupoNome: TLabel;
    LblGrupo: TLabel;
    MskSecao: TMaskEdit;
    MskGrupo: TMaskEdit;
    LblPrateleira: TLabel;
    MskPrateleira: TMaskEdit;
    CmdPrateleira: TSpeedButton;
    LblPrateleiraNome: TLabel;
    LblSubGrupo: TLabel;
    MskSubGrupo: TMaskEdit;
    CmdSubGrupo: TSpeedButton;
    LblSubGrupoNome: TLabel;
    MskDe: TMaskEdit;
    MskAte: TMaskEdit;
    CmdClearGrupo: TSpeedButton;
    CmdClearSubGrupo: TSpeedButton;
    CmdClearSecao: TSpeedButton;
    CmdClearPrateleira: TSpeedButton;
    PanFiltroLote: TPanel;
    MskLote: TMaskEdit;
    suiForm1: TsuiForm;
    GrpOrganizar: TsuiGroupBox;
    RadNomeProduto: TsuiRadioButton;
    RadQuantEstoque: TsuiRadioButton;
    RadCodProduto: TsuiRadioButton;
    GrpTipo: TsuiGroupBox;
    RadSaldoEstoque: TsuiRadioButton;
    RadApuracaoEstoque: TsuiRadioButton;
    ChkFiltroSaldo: TsuiCheckBox;
    CmbImprimir: TsuiButton;
    CmbCancelar: TsuiButton;
    chkSecao: TsuiCheckBox;
    ChkGrupo: TsuiCheckBox;
    ChkLote: TsuiCheckBox;
    LblConsulta: TLabel;
    skin: TsuiThemeManager;
    procedure suitempChkFiltroSaldoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure suitempCmbImprimirClick(Sender: TObject);
    procedure CmdSecaoClick(Sender: TObject);
    procedure CmdPrateleiraClick(Sender: TObject);
    procedure CmdGrupoClick(Sender: TObject);
    procedure CmdSubGrupoClick(Sender: TObject);
    procedure suitempchkSecaoClick(Sender: TObject);
    procedure suitempChkGrupoClick(Sender: TObject);
    procedure MskSecaoEnter(Sender: TObject);
    procedure MskPrateleiraEnter(Sender: TObject);
    procedure MskGrupoEnter(Sender: TObject);
    procedure MskSubGrupoEnter(Sender: TObject);
    procedure MskSecaoExit(Sender: TObject);
    procedure MskPrateleiraExit(Sender: TObject);
    procedure MskGrupoExit(Sender: TObject);
    procedure MskSubGrupoExit(Sender: TObject);
    procedure MskSecaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MskPrateleiraKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MskGrupoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MskSubGrupoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure suitempRadSaldoEstoqueKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MskDeEnter(Sender: TObject);
    procedure MskAteClick(Sender: TObject);
    procedure MskDeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CmdClearSecaoClick(Sender: TObject);
    procedure CmdClearPrateleiraClick(Sender: TObject);
    procedure CmdClearGrupoClick(Sender: TObject);
    procedure CmdClearSubGrupoClick(Sender: TObject);
    procedure ChkLoteClick(Sender: TObject);
    procedure CmbCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    S_Where0, S_Where1, S_Where2, S_Where3, S_Where4, S_Where5 : String;
    Procedure ConectaDb;
    Procedure ConectaTables;
  end;

var
  FrmMain: TFrmMain;
  Path: String;
  S_DataSource: String;
  I_CodSecao, I_CodSubGrupo, I_CodPrateleira: Integer;
  //Para Formatacao do Select
  S_Campos: String;
  S_Order: String;
  S_SQLFinal: String;
implementation

uses module, consulta, relsaldo, relap;

{$R *.dfm}

procedure TFrmMain.suitempChkFiltroSaldoClick(Sender: TObject);
begin
  if ChkFiltroSaldo.Checked then
    PanFiltroSaldo.Visible := True
  else
    PanFiltroSaldo.Visible := False;
end;

procedure TFrmMain.ConectaDb;
var
  ini: Tinifile;
  T1, T2: string;
begin

   //Abre componentes basicos de banco de dados
   Dm.Transaction.Active := False;
   Dm.DBAutocom.Connected := False;
   ini := TIniFile.Create(Path + 'Autocom.ini');
   T1 := Ini.Readstring('ATCPLUS','IP_SERVER','');
   T2 := Ini.Readstring('ATCPLUS','PATH_DB','');
   Ini.Free;

   Dm.dbautocom.DatabaseName := T1 + ':' + T2;
   //Conecta Banco de Dados
   Dm.DBAutocom.connected:=true;
   Dm.Transaction.active:=true;

   //abre tabelas
   Dm.Tbl_Produto.Open;
end;

procedure TFrmMain.FormActivate(Sender: TObject);
var ini:Tinifile;
    tipo_skin:string;
begin
  //Define Pasta
  Path := Extractfilepath(application.exename)+'dados\';

  ini:=Tinifile.create(extractfilepath(application.exename)+'dados\autocom.ini');
  tipo_skin:=ini.readstring('ATCPLUS', 'skin','0');
  ini.free;
  if (tipo_skin='0') or (tipo_skin='') then skin.uistyle:=WinXP;
  if (tipo_skin='1') then skin.uistyle:=BlueGlass;
  if (tipo_skin='2') then skin.uistyle:=DeepBlue;
  if (tipo_skin='3') then skin.uistyle:=MacOS;
  if (tipo_skin='4') then skin.uistyle:=Protein;
  application.processmessages;

  ini := TIniFile.Create(Path + 'Autocom.ini');
  CHKLote.caption := Ini.Readstring('ESTOQUE','NomeTipoLote','');
  if CHKLote.caption='' then
     begin
        Ini.Writestring('ESTOQUE','NomeTipoLote','Lote');
        CHKLote.caption:='Lote';
     end;
  CHKLote.caption:='Filtrar por '+CHKLote.caption;   
  Ini.Free;


  //Conecta
  ConectaDB;
  SetForegroundWindow(Application.Handle);
end;

procedure TFrmMain.suitempCmbImprimirClick(Sender: TObject);
begin

  S_Where0 := ' ';
  S_Where1 := ' ';
  S_Where2 := ' ';
  S_Where3 := ' ';
  S_Where4 := ' ';
  S_Where5 := ' ';

  if ChkFiltroSaldo.Checked then begin
    if (Trim(MskDe.Text) = '') and (Trim(MskAte.Text) = '') then ChkFiltroSaldo.Checked := False;
    if (Trim(MskDe.Text) = '') and (Trim(MskAte.Text) <> '') then MskDe.Text := '0';
    if (Trim(MskDe.Text) <> '') and (Trim(MskAte.Text) = '') then MskAte.Text := '999999999999999';
  end;

   S_Campos :='SELECT P.CODIGOPRODUTO, P.NOMEPRODUTO, E.ESTOQUEMAXIMO, ' +
              'E.ESTOQUEMINIMO, E.ESTOQUEATUAL, GP.CODIGOGRUPOPRODUTO, ' +
              'GP.GRUPOPRODUTO, SP.CODIGOSUBGRUPOPRODUTO, SP.SUBGRUPO, ' +
              'S.CODIGOSECAO, S.DESCRICAO, PP.CODPRATELEIRA, ' +
              'PP.CODIGOPRATELEIRA, PP.CODSECAO, E.LOTE, P.Usual FROM PRODUTO P, ESTOQUE E, ' +
              'GRUPOPRODUTO GP, SUBGRUPOPRODUTO SP, SECAO S, PRATELEIRA PP ' +
              'WHERE P.CODIGOPRODUTO = E.CODIGOPRODUTO ';

//Referente-Painel-Ordem--------------------------------------------------
  if RadCodProduto.Checked then S_Order := ' ORDER BY P.CODIGOPRODUTO';
  if RadNomeProduto.Checked then S_Order := ' ORDER BY P.NOMEPRODUTO';
  if RadQuantEstoque.Checked then S_Order := ' ORDER BY E.ESTOQUEATUAL';

//Referente-ao-Filtro-por-Quantidde---------------------------------------
  if ChkFiltroSaldo.Checked then
  begin
    S_Where0 := ' AND E.ESTOQUEATUAL > ' + MskDe.Text +
                ' AND E.ESTOQUEATUAL < ' + MskAte.Text ;
  end;


//Referente-ao-Filtro-por-Secao-------------------------------------------
  if chkSecao.Checked then
  begin
    S_Where1 := ' AND S.CODSECAO = ' + IntToStr(I_CodSecao);
    if (MskPrateleira.Text <> '') and (StrToInt(MskPrateleira.Text) <> 0) then
      S_Where2 := ' AND PP.CODPRATELEIRA = ' + IntToStr(I_CodPrateleira);
  end;

//Referente-ao-Filtro-por-Grupo-------------------------------------------
  if ChkGrupo.Checked then
  begin
    S_Where3 := ' AND GP.CODIGOGRUPOPRODUTO = ' + MskGrupo.Text;
    if (MskSubGrupo.Text <> '') and (StrToInt(MskSubGrupo.Text) <> 0) then
      S_Where4 := ' AND SP.CODIGOSUBGRUPOPRODUTO = ' + IntToStr(I_CodSubGrupo);
  end;

//Referente-ao-Filtro-por-Lote---------------------------------------
  if ChkLote.Checked then
  begin
    S_Where5 := ' AND E.Lote = ' + MskLote.Text;
  end;


  S_SQLFinal := S_Campos + S_Where0 + S_Where1 + S_Where2 + S_Where3 + S_Where4 + S_Where5 + S_Order;

  Dm.Tbl_Relatorio.Close;
  Dm.Tbl_Relatorio.SQL.Clear;
  Dm.Tbl_Relatorio.SQL.Add(S_SQLFinal);
  Dm.Tbl_Relatorio.Prepare;
  Dm.Tbl_Relatorio.Open;
  if RadSaldoEstoque.Checked then FrmRelSaldo.QrRel.Preview;
  if RadApuracaoEstoque.Checked then FrmRelAp.QrRel.Preview;

end;

procedure TFrmMain.CmdSecaoClick(Sender: TObject);
begin
  S_DataSource := 'Tbl_Secao';
  Dm.Tbl_Secao.Open;
  Application.CreateForm(TFrmConsulta, FrmConsulta);
  FrmConsulta.ShowModal;
  FrmConsulta.Destroy;
end;

procedure TFrmMain.CmdPrateleiraClick(Sender: TObject);
begin
  if Trim(MskSecao.Text) <> '' then
  begin
    S_DataSource := 'Tbl_Prateleira';
    Dm.Tbl_Prateleira.Open;
    Application.CreateForm(TFrmConsulta, FrmConsulta);
    FrmConsulta.ShowModal;
    FrmConsulta.Destroy
  end else begin
    MessageDlg('Antes é necessario selecionar uma Seção!',mtWarning,[mbok],0);
    MskSecao.SetFocus;
  end;
end;

procedure TFrmMain.CmdGrupoClick(Sender: TObject);
begin
  S_DataSource := 'Tbl_Grupo';
  Dm.Tbl_Grupo.Open;
  Application.CreateForm(TFrmConsulta, FrmConsulta);
  FrmConsulta.ShowModal;
  FrmConsulta.Destroy;
end;

procedure TFrmMain.CmdSubGrupoClick(Sender: TObject);
begin
  if Trim(MskGrupo.Text) <> '' then
  begin
    S_DataSource := 'Tbl_SubGrupo';
    Dm.Tbl_SubGrupo.Open;
    Application.CreateForm(TFrmConsulta, FrmConsulta);
    FrmConsulta.ShowModal;
    FrmConsulta.Destroy;
  end else begin
    MessageDlg('Antes é necessario selecionar um Grupo!',mtWarning,[mbok],0);
    MskGrupo.SetFocus;
  end;
end;

procedure TFrmMain.ConectaTables;
begin
  Dm.Tbl_Produto.Open;
  Dm.Tbl_Grupo.Open;
end;

procedure TFrmMain.suitempchkSecaoClick(Sender: TObject);
begin
  if chkSecao.Checked then
  begin
    PanSecao.Visible := True;
  end
  else
  begin
    PanSecao.Visible := False;
    MskSecao.Clear;
    MskPrateleira.Clear;
    LblSecaoNome.Caption := '';
    LblPrateleiraNome.Caption := '';
  end;
end;

procedure TFrmMain.suitempChkGrupoClick(Sender: TObject);
begin

  if ChkGrupo.Checked then
  begin
    PanGrupo.Visible := True;
  end
  else
  begin
    PanGrupo.Visible := False;
    MskGrupo.Clear;
    MskSubGrupo.Clear;
    LblGrupoNome.Caption := '';
    LblSubGrupoNome.Caption := '';
  end;
end;
procedure TFrmMain.MskSecaoEnter(Sender: TObject);
begin
  LblConsulta.Caption := '[F1] Consulta Seção';
end;

procedure TFrmMain.MskPrateleiraEnter(Sender: TObject);
begin
  LblConsulta.Caption := '[F1] Consulta Prateleira';
end;

procedure TFrmMain.MskGrupoEnter(Sender: TObject);
begin
  LblConsulta.Caption := '[F1] Consulta Grupo';
end;

procedure TFrmMain.MskSubGrupoEnter(Sender: TObject);
begin
  LblConsulta.Caption := '[F1] Consulta Sub-grupo';
end;

procedure TFrmMain.MskSecaoExit(Sender: TObject);
begin
  LblConsulta.Caption := '';
end;

procedure TFrmMain.MskPrateleiraExit(Sender: TObject);
begin
  LblConsulta.Caption := '';
end;

procedure TFrmMain.MskGrupoExit(Sender: TObject);
begin
  LblConsulta.Caption := '';
end;

procedure TFrmMain.MskSubGrupoExit(Sender: TObject);
begin
  LblConsulta.Caption := '';
end;

procedure TFrmMain.MskSecaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_F1 then CmdSecaoClick(Self);
  if Key = Vk_Return then Perform(WM_NEXTDLGCTL,0,0);
  if Key = Vk_Delete then CmdClearSecaoClick(Self);
end;

procedure TFrmMain.MskPrateleiraKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_F1 then CmdPrateleiraClick(Self);
  if Key = Vk_Return then Perform(WM_NEXTDLGCTL,0,0);
  if Key = Vk_Delete then CmdClearPrateleiraClick(Self);
end;

procedure TFrmMain.MskGrupoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_F1 then CmdGrupoClick(Self);
  if Key = Vk_Return then Perform(WM_NEXTDLGCTL,0,0);
  if Key = Vk_Delete then CmdClearGrupoClick(Self);
end;

procedure TFrmMain.MskSubGrupoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_F1 then CmdSubGrupoClick(Self);
  if Key = Vk_Return then Perform(WM_NEXTDLGCTL,0,0);
  if Key = Vk_Delete then CmdClearSubGrupoClick(Self);
end;

procedure TFrmMain.suitempRadSaldoEstoqueKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_Return then Perform(WM_NEXTDLGCTL,0,0);
end;

procedure TFrmMain.MskDeEnter(Sender: TObject);
begin
  MskDe.SetFocus;
  MskDe.SelectAll;
end;

procedure TFrmMain.MskAteClick(Sender: TObject);
begin
  MskAte.SelectAll;
end;

procedure TFrmMain.MskDeClick(Sender: TObject);
begin
  MskDe.SelectAll;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dm.dbautocom.Close;
end;

procedure TFrmMain.CmdClearSecaoClick(Sender: TObject);
begin
  MskSecao.Clear;
end;

procedure TFrmMain.CmdClearPrateleiraClick(Sender: TObject);
begin
  MskPrateleira.Clear;
end;

procedure TFrmMain.CmdClearGrupoClick(Sender: TObject);
begin
  MskGrupo.Clear;
end;

procedure TFrmMain.CmdClearSubGrupoClick(Sender: TObject);
begin
  MskSubGrupo.Clear;
end;

procedure TFrmMain.ChkLoteClick(Sender: TObject);
begin
  if ChkLote.Checked then
    PanFiltroLote.Visible := True
  else
    PanFiltroLote.Visible := False;
end;

procedure TFrmMain.CmbCancelarClick(Sender: TObject);
begin
     close;
end;

end.


