unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, DB, ComCtrls,
  Mask, IBQuery, IniFiles, StrUtils, JvComponent, JvBalloonHint, ImgList,
  ActnList, XPStyleActnCtrls, ActnMan, uGlobal, ToolWin, ActnCtrls;

type
  TfMain = class(TForm)
    DSourceGrid: TDataSource;
    ActMain: TActionManager;
    ActNovo: TAction;
    ActPesquisar: TAction;
    ActFechar: TAction;
    ActCancelar: TAction;
    ActSalvar: TAction;
    ActExcluir: TAction;
    ActRelatorio: TAction;
    ImgMain: TImageList;
    JvBalloonHint: TJvBalloonHint;
    PanMain: TPanel;
    GrdMain: TDBGrid;
    LblCodigo: TLabel;
    MskCod: TMaskEdit;
    LblFaturamento: TLabel;
    MskFaturamento: TMaskEdit;
    CmdContato: TSpeedButton;
    LblNomeFormaPagamento: TLabel;
    LblNomee: TLabel;
    MskNome: TMaskEdit;
    lblNParcela: TLabel;
    MskNParcelas: TMaskEdit;
    Lbl1Parcela: TLabel;
    Msk1Parcela: TMaskEdit;
    LblInterParcelas: TLabel;
    MskInterParc: TMaskEdit;
    LblAutenticar: TLabel;
    CmbAutenticar: TComboBox;
    LblFinaceiro: TLabel;
    CmbFinaceiro: TComboBox;
    Label1: TLabel;
    CmbFuncaoEspecial: TComboBox;
    LblImpCheque: TLabel;
    CmbImpCheque: TComboBox;
    LblVenda: TLabel;
    CmbVenda: TComboBox;
    LblTroco: TLabel;
    cmbTipoTroco: TComboBox;
    LblSomarSaldo: TLabel;
    CmbSomarSaldo: TComboBox;
    BtnSalvar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    BtnRelatorio: TSpeedButton;
    BtnCancelar: TSpeedButton;
    BtnFechar: TSpeedButton;
    SelectAll: TAction;
    PanTop: TPanel;
    Panel1: TPanel;
    EdMain: TEdit;
    ActMenu: TActionToolBar;
    ActOrdemAlfabetica: TAction;
    ActOrdemNumerica: TAction;
    ActOrdem: TAction;
    procedure GrdMainDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CmdContatoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MskCodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GrdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MskComissaoKeyPress(Sender: TObject; var Key: Char);
    procedure MskFaturamentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure MskFaturamentoEnter(Sender: TObject);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure ActNovoExecute(Sender: TObject);
    procedure ActSalvarExecute(Sender: TObject);
    procedure ActExcluirExecute(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure ActFecharExecute(Sender: TObject);
    procedure EdMainEnter(Sender: TObject);
    procedure EdMainExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GrdMainEnter(Sender: TObject);
    procedure GrdMainExit(Sender: TObject);
    procedure SelectAllExecute(Sender: TObject);
    procedure ActRelatorioExecute(Sender: TObject);
    procedure ActOrdemExecute(Sender: TObject);
    procedure ActOrdemNumericaExecute(Sender: TObject);
    procedure ActOrdemAlfabeticaExecute(Sender: TObject);
    procedure MskFaturamentoExit(Sender: TObject);
  private
    Ordem: String;
  public
    DsGrid: TDataSet;
    procedure LoadData;
    procedure Editando(Status: Boolean);
  end;

var
  fMain: TfMain;
  Patch: string; //Endereco da Aplica??o
  S_Status: string; //Update ou Insert
  S_CodigoVendedor: string; //Codigo Interno
  S_CodigoSupervisor, S_CodigoGerente, S_CodigoAgente: string; //C?digos Internos
implementation

uses uDm, uFaturamento, uRelatorio;

{$R *.dfm}

procedure TfMain.LoadData;
var
  DsLoad: TDataSet;
begin
  RunSql('SELECT * FROM CONDICAOPAGAMENTO WHERE CODIGOCONDICAOPAGAMENTO = ' + DsGrid.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString, dm.dbautocom,DsLoad);
  MskCod.Text := DsLoad.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString;
  MskNome.Text :=DsLoad.FieldByName('CONDICAOPAGAMENTO').AsString;
  MskNParcelas.Text := DsLoad.FieldByName('NUMEROPARCELAS').AsString;
  Msk1Parcela.Text := DsLoad.FieldByName('PRIMEIRAPARCELA').AsString;
  MskFaturamento.Text := DsLoad.FieldByName('CODIGOFORMAFATURAMENTO').AsString;
  MskInterParc.Text := DsLoad.FieldByName('INTERVALOPARCELAS').AsString;
  if (DsLoad.FieldByName('ATIVOFINANCEIRO').AsString = 'T') then
    CmbFinaceiro.ItemIndex := 0 else CmbFinaceiro.ItemIndex := 1;
  if (DsLoad.FieldByName('ATIVOVENDA').AsString = 'T') then
    CmbVenda.ItemIndex := 0 else CmbVenda.ItemIndex := 1;
  if (DsLoad.FieldByName('IMPRESSAOCHEQUE').AsString = 'T') then
    CmbImpCheque.ItemIndex := 0 else CmbImpCheque.ItemIndex := 1;
  if (DsLoad.FieldByName('SOMASALDO').AsString = 'T') then
    CmbSomarSaldo.ItemIndex := 0 else CmbSomarSaldo.ItemIndex := 1;
  if (DsLoad.FieldByName('AUTENTICA').AsString = 'T') then
    CmbAutenticar.ItemIndex := 0 else CmbAutenticar.ItemIndex := 1;
  if DsLoad.FieldByName('FUNCAOESPECIAL').IsNull then
    CmbFuncaoEspecial.ItemIndex := 0
  else
    CmbFuncaoEspecial.ItemIndex := DsLoad.FieldByName('FUNCAOESPECIAL').AsInteger;
  if DsLoad.FieldByName('TIPOTROCO').IsNull then
    cmbTipoTroco.ItemIndex := 0
  else
    cmbTipoTroco.ItemIndex := DsLoad.FieldByName('TIPOTROCO').AsInteger;
  if not DsLoad.FieldByName('CODIGOFORMAFATURAMENTO').IsNull then
    begin
      RunSQL('Select * from FORMAFATURAMENTO WHERE CODIGOFORMAFATURAMENTO = ' + DsLoad.FieldByName('CODIGOFORMAFATURAMENTO').AsString,dm.dbautocom,DsLoad);
      LblNomeFormaPagamento.Caption := DsLoad.FieldByName('FORMAFATURAMENTO').AsString;
    end;
  FreeAndNil(DsLoad);
end;


procedure TfMain.Editando(Status: Boolean);
//Procedimento que antecede edicao de dados
begin
  if Status then
    begin
      ActPesquisar.Enabled := False;
      ActNovo.Enabled := False;
      GrdMain.Enabled := False;
      GrdMain.Repaint;
      ActExcluir.Enabled := True;
      ActSalvar.Enabled := True;
      ActRelatorio.enabled := false;
      ActFechar.Enabled := False;
      ActCancelar.Enabled := True;
      EdMain.Clear;
      EdMain.Enabled := False;
      EnableFields(True,PanMain);
      EnableFields(False,PanTop);
    end
  else
    begin
      // Sai do modo de Edicao
      ActPesquisar.Enabled := True;
      ActNovo.Enabled := True;
      EdMain.Enabled := True;
      ActPesquisar.Enabled := True;
      ActNovo.Enabled := True;
      GrdMain.Enabled := True;
      GrdMain.Repaint;
      ActExcluir.Enabled := False;
      ActSalvar.Enabled := False;
      ActRelatorio.Enabled := True;
      ActFechar.Enabled := True;
      ActCancelar.Enabled := false;
      EnableFields(False,PanMain);
      EnableFields(True,PanTop);
      EdMain.SetFocus;
      SelectAll.Execute;
    end;
end;

procedure TfMain.GrdMainDblClick(Sender: TObject);
begin
  if DsGrid.IsEmpty then Exit;
  Editando(True);
  LoadData;
  MskCod.SetFocus;
  S_Status := 'Update';
end;

procedure TfMain.FormActivate(Sender: TObject);
begin
  Dm.dbautocom.DatabaseName := LeINI('ATCPLUS','IP_SERVER') + ':' + LeINI('ATCPLUS','PATH_DB');
  Dm.dbautocom.Connected := True;
  Dm.Transaction.Active := True;
  Editando(False);
  EdMain.SetFocus;
  ActOrdemNumerica.Execute;
end;

procedure TfMain.CmdContatoClick(Sender: TObject);
begin
  with TfFaturamento.Create(Self) do
    begin
      ShowModal;
      MskFaturamento.Text := ResultCodigo;
      LblNomeFormaPagamento.Caption := ResultNome;
      Free;
    end;
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dm.dbautocom.Close;
end;

procedure TfMain.MskCodKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then CmdContatoClick(Self);
  if (Key = VK_Return) and (MskCod.Text = '') then CmdContatoClick(Self)
  else Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfMain.EdMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  Codigo: String;  
begin
  if Key = VK_RETURN then
    begin
      if IsInteger(TrimAll(EdMain.Text)) then
        begin
          RunSql('SELECT CODIGOCONDICAOPAGAMENTO, CONDICAOPAGAMENTO FROM CONDICAOPAGAMENTO WHERE CODIGOCONDICAOPAGAMENTO = ' + Trim(EdMain.Text) + ' ORDER BY CODIGOCONDICAOPAGAMENTO', dm.dbautocom,DsGrid);
          GrdMainDblClick(Self);
        end;
      if DsGrid.IsEmpty then
        if MessageBox(Handle,'C?digo n?o encontrado, deseja cadastra-lo?!',Autocom,MB_ICONQUESTION+MB_YESNO) = ID_YES then
          begin
            Codigo := EdMain.Text;
            Editando(True);
            MskCod.Text := Codigo;
          end
        else
          SelectAll.Execute;
    end;
end;

procedure TfMain.GrdMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_UP then
    if DsGrid.RecNo = 1 then Perform(WM_NEXTDLGCTL, 1, 0);
  if Key = VK_RETURN then GrdMainDblClick(Self);
end;

procedure TfMain.MskComissaoKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #46 then key := #44;
end;                  

procedure TfMain.MskFaturamentoKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_F1 then CmdContatoClick(Self);
end;

procedure TfMain.MskFaturamentoEnter(Sender: TObject);
begin
  JvBalloonHint.ActivateHint(MskFaturamento, MskFaturamento.Hint);
end;

procedure TfMain.ActPesquisarExecute(Sender: TObject);
begin
  if Length(EdMain.Text) > 0 then
    begin
      if IsInteger(EdMain.Text) then
        RunSql('SELECT CODIGOCONDICAOPAGAMENTO, CONDICAOPAGAMENTO FROM CONDICAOPAGAMENTO WHERE CODIGOCONDICAOPAGAMENTO = ' + Trim(EdMain.Text) + Ordem,dm.dbautocom,DsGrid)
      else
        RunSql('SELECT CODIGOCONDICAOPAGAMENTO, CONDICAOPAGAMENTO FROM CONDICAOPAGAMENTO WHERE CONDICAOPAGAMENTO LIKE ' + Chr(39) + '%' + Trim(EdMain.Text) + '%' + Chr(39) +' order by CODIGOCONDICAOPAGAMENTO ' + Ordem, dm.dbautocom,DsGrid);
      end
    else
      RunSql('SELECT CODIGOCONDICAOPAGAMENTO, CONDICAOPAGAMENTO FROM CONDICAOPAGAMENTO' + Ordem, dm.dbautocom,DsGrid);
  DSourceGrid.DataSet := DsGrid;      
end;

procedure TfMain.ActNovoExecute(Sender: TObject);
begin
  MskCod.Clear;
  MskCod.Clear;
  LblNomeFormaPagamento.Caption := NullAsStringValue;
  Editando(True);
  S_Status := 'Insert';
  MskCod.SetFocus;
  ActExcluir.Enabled := False;
end;

procedure TfMain.ActSalvarExecute(Sender: TObject);
var
  DsAux: TDataSet;
begin
  IsEditNull('Forma Faturamento',MskFaturamento);
  MskFaturamentoExit(MskFaturamento);

  if MessageDlg('Deseja Salvar?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      if CmbFuncaoEspecial.ItemIndex = -1 then CmbFuncaoEspecial.ItemIndex := 0;
      if cmbTipoTroco.ItemIndex = -1 then cmbTipoTroco.ItemIndex := 0;
      RunSql('Select CODIGOCONDICAOPAGAMENTO from CONDICAOPAGAMENTO where CODIGOCONDICAOPAGAMENTO = ' + IfThen(ISNull(MskCod.Text),'9999999999',MskCod.Text),dm.dbautocom,DsAux);
      if not DsAux.IsEmpty then
        begin
          try
            RunSql('Update CondicaoPagamento set ' +
              'CONDICAOPAGAMENTO = ' + Chr(39) + MskNome.Text + Chr(39) + ', ' +
              'CODIGOFORMAFATURAMENTO = ' + MskFaturamento.Text + ', ' +
              'NUMEROPARCELAS = ' + MskNParcelas.Text + ', ' +
              'PRIMEIRAPARCELA = ' + Msk1Parcela.Text + ', ' +
              'INTERVALOPARCELAS = ' + MskInterParc.Text + ', ' +
              'AUTENTICA = ' + QuotedStr(IfThen(CmbAutenticar.ItemIndex = 0,'T','F')) + ', ' +
              'IMPRESSAOCHEQUE = ' + QuotedStr(IfThen(CmbImpCheque.ItemIndex = 0,'T','F')) + ', ' +
              'TIPOTROCO = ' + IntToStr(cmbTipoTroco.ItemIndex) + ', ' +
              'FUNCAOESPECIAL = ' + IntToStr(CmbFuncaoEspecial.ItemIndex) + ', '
                +
              'ATIVOVENDA = ' + QuotedStr(IfThen(CmbVenda.ItemIndex = 0,'T','F')) + ', ' +
              'ATIVOFINANCEIRO = ' + QuotedStr(IfThen(CmbFinaceiro.ItemIndex = 0,'T','F')) + ', ' +
              'SOMASALDO = ' + QuotedStr(IfThen(CmbSomarSaldo.ItemIndex = 0,'T','F')) +
              ' WHERE CODIGOCONDICAOPAGAMENTO  = ' + MskCod.Text,dm.dbautocom);
            Editando(False);
          except
            MessageDlg('Est? Pessoa j? est? Cadastrada!', mtWarning, [mbok], 0);
          end;
        end
      else
        begin
          try
            RunSql('INSERT INTO CONDICAOPAGAMENTO (' +
              IfThen(IsNull(MskCod.Text),'','CODIGOCONDICAOPAGAMENTO, ') +
              'CONDICAOPAGAMENTO, CODIGOFORMAFATURAMENTO, NUMEROPARCELAS, ' +
              'PRIMEIRAPARCELA, INTERVALOPARCELAS, AUTENTICA, IMPRESSAOCHEQUE, ' +
              'TIPOTROCO, FUNCAOESPECIAL, ATIVOVENDA, ATIVOFINANCEIRO, SOMASALDO) ' +
              'VALUES (' +
              IfThen(IsNull(MskCod.Text),'',MskCod.Text + ', ') +
              Chr(39) + MskNome.Text + Chr(39) + ', ' +
              MskFaturamento.Text + ', ' +
              MskNParcelas.Text + ', ' +
              Msk1Parcela.Text + ', ' +
              MskInterParc.Text + ', ' +
              QuotedStr(IfThen(CmbAutenticar.ItemIndex = 0,'T','F')) + ', ' +
              QuotedStr(IfThen(CmbImpCheque.ItemIndex = 0,'T','F')) + ', ' +
              IntToStr(cmbTipoTroco.ItemIndex) + ', ' +
              IntToStr(CmbFuncaoEspecial.ItemIndex) + ', ' +
              QuotedStr(IfThen(CmbVenda.ItemIndex = 0,'T','F')) + ', ' +
              QuotedStr(IfThen(CmbFinaceiro.ItemIndex = 0,'T','F')) + ', ' +
              QuotedStr(IfThen(CmbSomarSaldo.ItemIndex = 0,'T','F')) + ')',dm.dbautocom);
            Editando(False);
          except
            MessageDlg('Est? Condic?o de Pagamento j? existe ou o C?digo ? Inv?lido!', mtWarning, [mbok], 0);
          end;
        end;
    end;
end;

procedure TfMain.ActExcluirExecute(Sender: TObject);
begin
  if MessageDlg('Deseja excluir este registro?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    begin
      try
        RunSql('Delete From CONDICAOPAGAMENTO Where CODIGOCONDICAOPAGAMENTO = ' + MskCod.Text,dm.dbautocom);
        Editando(False);
      except
        MessageDlg('Imposs?vel Excluir', mtError, [mbok], 0);
      end;
    end;
end;

procedure TfMain.ActCancelarExecute(Sender: TObject);
begin
  Editando(False);
end;

procedure TfMain.ActFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TfMain.EdMainEnter(Sender: TObject);
begin
  JvBalloonHint.ActivateHint(EdMain,EdMain.Hint);
end;

procedure TfMain.EdMainExit(Sender: TObject);
begin
  JvBalloonHint.CancelHint;
end;

procedure TfMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
    Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfMain.GrdMainEnter(Sender: TObject);
begin
  KeyPreview := False;
end;

procedure TfMain.GrdMainExit(Sender: TObject);
begin
  KeyPreview := True;
end;

procedure TfMain.SelectAllExecute(Sender: TObject);
begin
  RunSQL('SELECT CODIGOCONDICAOPAGAMENTO, CONDICAOPAGAMENTO FROM CONDICAOPAGAMENTO ' + Ordem,dm.dbautocom,DsGrid);
  DSourceGrid.DataSet := DsGrid;
end;

procedure TfMain.ActRelatorioExecute(Sender: TObject);
begin
  with TfRelatorio.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
end;

procedure TfMain.ActOrdemExecute(Sender: TObject);
begin
  Refresh;
end;

procedure TfMain.ActOrdemNumericaExecute(Sender: TObject);
begin
  Ordem := ' ORDER BY CODIGOCONDICAOPAGAMENTO ';
  SelectAll.Execute;
end;

procedure TfMain.ActOrdemAlfabeticaExecute(Sender: TObject);
begin
  Ordem := ' ORDER BY CONDICAOPAGAMENTO ';
  SelectAll.Execute;
end;

procedure TfMain.MskFaturamentoExit(Sender: TObject);
var
  DsAux: TDataSet;
begin
  if IsNull(MskFaturamento.Text) then
    begin
      LblNomeFormaPagamento.Caption := NullAsStringValue;
      Exit;
    end;
  RunSql('select formafaturamento from formafaturamento where codigoformafaturamento = ' + MskFaturamento.Text, dm.dbautocom,DsAux);
  if DsAux.IsEmpty then
    begin
      Application.MessageBox('C?digo Inv?lido, Verifique',Autocom);
      MskFaturamento.SetFocus;

      Abort;
    end
  else
    begin
      LblNomeFormaPagamento.Caption := DsAux.FieldByName('formafaturamento').AsString;
    end;
  FreeAndNil(DsAux);
end;

end.

