unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, XPStyleActnCtrls, ActnMan, JvComponent, JvBalloonHint,
  ImgList, DB, Grids, DBGrids, StdCtrls, Mask, ExtCtrls, Buttons, uGlobal,
  ToolWin, ActnCtrls, StrUtils;

type
  TfMain = class(TForm)
    BtnSalvar: TSpeedButton;
    BtnExcluir: TSpeedButton;
    BtnRelatorio: TSpeedButton;
    BtnCancelar: TSpeedButton;
    BtnFechar: TSpeedButton;
    PanMain: TPanel;
    lbl_codigo: TLabel;
    lbl_descfull: TLabel;
    lbl_icms: TLabel;
    lbl_ipi: TLabel;
    lbl_est: TLabel;
    lbl_movfin: TLabel;
    lbl_desc: TLabel;
    lbl_iss: TLabel;
    EdCodigo: TMaskEdit;
    EdDescricaoResuimida: TEdit;
    CmbICMS: TComboBox;
    CmbIPI: TComboBox;
    CmbMovFin: TComboBox;
    CmbEstoque: TComboBox;
    EdDescricaoCompleta: TEdit;
    CmbISS: TComboBox;
    PanTop: TPanel;
    GrdMain: TDBGrid;
    DSourceGrid: TDataSource;
    ImgMain: TImageList;
    JvBalloonHint: TJvBalloonHint;
    ActMain: TActionManager;
    ActNovo: TAction;
    ActPesquisar: TAction;
    ActFechar: TAction;
    ActCancelar: TAction;
    ActSalvar: TAction;
    ActExcluir: TAction;
    ActRelatorio: TAction;
    ActSelectAll: TAction;
    Panel1: TPanel;
    EdMain: TEdit;
    ActMenu: TActionToolBar;
    ActOrdemNumerica: TAction;
    ActOrdemAlpha: TAction;
    ActOrdem: TAction;
    procedure PanMainDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure ActNovoExecute(Sender: TObject);
    procedure ActSelectAllExecute(Sender: TObject);
    procedure ActFecharExecute(Sender: TObject);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure ActOrdemExecute(Sender: TObject);
    procedure ActOrdemNumericaExecute(Sender: TObject);
    procedure ActOrdemAlphaExecute(Sender: TObject);
    procedure EdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GrdMainKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure GrdMainDblClick(Sender: TObject);
    procedure ActRelatorioExecute(Sender: TObject);
    procedure ActSalvarExecute(Sender: TObject);
  private
    Ordem: String;
    procedure Editando(Status: Boolean; New: Boolean = False);
    procedure LoadData;
  public
    DsGrid: TDataSet;
  end;

var
  fMain: TfMain;

implementation

uses uDm, uRelatorio;

{$R *.dfm}

{ TfMain }

procedure TfMain.Editando(Status: Boolean; New: Boolean = False);
begin
  if Status then
    begin
      EnableFields(True,PanMain);
      ActSalvar.Enabled := True;
      ActExcluir.Enabled := True;
      ActRelatorio.Enabled := False;
      ActCancelar.Enabled := True;
      ActFechar.Enabled := False;
      GrdMain.Enabled := False;
      GrdMain.Repaint;
      EnableFields(False,PanTop);
      if not New then LoadData;
      EdCodigo.SetFocus;
    end
  else
    begin
      EnableFields(False,PanMain);
      ActSalvar.Enabled := False;
      ActExcluir.Enabled := False;
      ActRelatorio.Enabled := True;
      ActCancelar.Enabled := False;
      ActFechar.Enabled := True;
      GrdMain.Enabled := True;
      GrdMain.Repaint;
      EnableFields(True,PanTop);
      ActSelectAll.Execute;
    end;
end;

procedure TfMain.PanMainDblClick(Sender: TObject);
begin
  Editando(True);
end;

procedure TfMain.FormActivate(Sender: TObject);
begin
  ForceDirectories(ExtractFilePath(Application.ExeName) + '\logs');
  LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log','Abrindo cadastro de CFOP.');
  Dm.dbautocom.DatabaseName := LeINI('ATCPLUS','IP_SERVER') + ':' + LeINI('ATCPLUS','PATH_DB');
  Dm.dbautocom.Connected := True;
  Dm.Transaction.Active := True;
  LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log','Banco de dados conectado.');
  ActOrdemNumerica.Execute;
  Editando(False);  
end;

procedure TfMain.ActCancelarExecute(Sender: TObject);
begin
  Editando(False);
end;

procedure TfMain.ActNovoExecute(Sender: TObject);
var
  DsMax: TDataset;
begin
  Editando(True,True);
  RunSql('SELECT MAX(CODIGONATUREZAOPERACAO) FROM NATUREZAOPERACAO',Dm.DBAutocom,DsMax);
  EdCodigo.Text := IntToStr(DsMax.Fields[0].AsInteger + 1);
  FreeAndNil(DsMax);
end;

procedure TfMain.ActSelectAllExecute(Sender: TObject);
begin
  RunSql('SELECT CODIGONATUREZAOPERACAO, NATUREZAOPERACAO FROM NATUREZAOPERACAO ' + Ordem,Dm.DBAutocom,DsGrid);;
  DSourceGrid.DataSet := DsGrid;
end;

procedure TfMain.ActFecharExecute(Sender: TObject);
begin
  LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log','Cadastro de CFOP Fechado.');
  Close;
end;

procedure TfMain.ActPesquisarExecute(Sender: TObject);
begin
  if IsFloat(EdMain.Text) then
    begin
      RunSql('SELECT CODIGONATUREZAOPERACAO, NATUREZAOPERACAO FROM NATUREZAOPERACAO WHERE CODIGONATUREZAOPERACAO = ' + EdMain.Text + Ordem,Dm.DBAutocom,DsGrid);;
    end
  else
    begin
      RunSql('SELECT CODIGONATUREZAOPERACAO, NATUREZAOPERACAO FROM NATUREZAOPERACAO WHERE NATUREZAOPERACAO LIKE ' + QuotedStr('%' + EdMain.Text + '%') + Ordem,Dm.DBAutocom,DsGrid);;
    end;

  //Se nada for encontrado
  If DsGrid.IsEmpty then
    begin
      Application.MessageBox('Nada foi encontrado!',Autocom,MB_ICONWARNING);
      ActSelectAll.Execute;
      EdMain.SelectAll;
    end
  else
    DSourceGrid.DataSet := DsGrid;
end;

procedure TfMain.ActOrdemExecute(Sender: TObject);
begin
  Refresh;
end;

procedure TfMain.ActOrdemNumericaExecute(Sender: TObject);
begin
  if Ordem <> ' ORDER BY CODIGONATUREZAOPERACAO ' then
    begin
      Ordem := ' ORDER BY CODIGONATUREZAOPERACAO ';
      ActSelectAll.Execute;
    end;
end;

procedure TfMain.ActOrdemAlphaExecute(Sender: TObject);
begin
  if Ordem <> ' ORDER BY NATUREZAOPERACAO ' then
    begin
      Ordem := ' ORDER BY NATUREZAOPERACAO ';
      ActSelectAll.Execute;
    end;
end;

procedure TfMain.EdMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
      VK_RETURN:
        begin
          if IsFloat(EdMain.Text) then
            begin
              RunSql('SELECT CODIGONATUREZAOPERACAO, NATUREZAOPERACAO FROM NATUREZAOPERACAO WHERE CODIGONATUREZAOPERACAO = ' + EdMain.Text + Ordem,Dm.DBAutocom,DsGrid);
              if DsGrid.IsEmpty then
                begin
                  if Application.MessageBox('Código não econtrado, deseja cadastra-lo?',Autocom,MB_YESNO) = ID_YES then
                    begin
                      Editando(True,True);
                      EdCodigo.Text := EdMain.Text;
                      EdMain.Clear;
                    end;
                end
              else
                Editando(True);
            end
          else
            ActPesquisar.Execute;
        end;
  end;
end;

procedure TfMain.LoadData;
var
  DsLoad: TDataSet;
begin
  RunSql('SELECT * FROM NATUREZAOPERACAO WHERE CODIGONATUREZAOPERACAO = ' + DsGrid.FieldByName('CODIGONATUREZAOPERACAO').AsString,Dm.DBAutocom,DsLoad);
  EdCodigo.Text := DsLoad.FieldByName('CODIGONATUREZAOPERACAO').AsString;
  EdDescricaoResuimida.Text := DsLoad.FieldByName('NATUREZAOPERACAO').AsString;
  EdDescricaoCompleta.Text := DsLoad.FieldByName('DESCRICAO').AsString;
  if (DsLoad.FieldByName('TRIBUTAICMS').AsString = 'T') then CmbICMS.ItemIndex := 0 else CmbICMS.ItemIndex := 1;
  if (DsLoad.FieldByName('TRIBUTAIPI').AsString = 'T') then CmbIPI.ItemIndex := 0 else CmbIPI.ItemIndex := 1;
  if (DsLoad.FieldByName('TRIBUTAISS').AsString = 'T') then CmbISS.ItemIndex := 0 else CmbISS.ItemIndex := 1;
  if (DsLoad.FieldByName('MOVIMENTACONTAS').AsString = 'T') then CmbMovFin.ItemIndex := 0 else CmbMovFin.ItemIndex := 1;
  if (DsLoad.FieldByName('MOVIMENTAESTOQUE').AsString = 'T') then CmbEstoque.ItemIndex := 0 else CmbEstoque.ItemIndex := 1;
end;

procedure TfMain.GrdMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case key of
    VK_RETURN: Editando(True);
  end;
end;

procedure TfMain.GrdMainDblClick(Sender: TObject);
begin
  Editando(True);
end;

procedure TfMain.ActRelatorioExecute(Sender: TObject);
begin
  with TfRelatorio.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
end;

procedure TfMain.ActSalvarExecute(Sender: TObject);
var
  DsSave: TDataSet;
begin
  IsEditNull('Descrição Resumida',EdDescricaoResuimida);
  IsEditNull('Descrição Completa',EdDescricaoCompleta);
  RunSql('SELECT CODIGONATUREZAOPERACAO FROM NATUREZAOPERACAO WHERE CODIGONATUREZAOPERACAO = ' + EdCodigo.Text,Dm.DBAutocom,DsSave);
  if DsSave.IsEmpty then
    begin
      //Insert
      try
        RunSql('INSERT INTO NATUREZAOPERACAO ' +
        '(CODIGONATUREZAOPERACAO, CODIGOTIPOBASEICMS, CODIGOTIPOBASEIPI, NATUREZAOPERACAO, DESCRICAO, TRIBUTAICMS, ' +
        ' TRIBUTAIPI, TRIBUTAISS, MOVIMENTACONTAS, MOVIMENTAESTOQUE) VALUES (' +
        EdCodigo.Text + ', ' +
        '1, 1, ' + //Estes valores são default, porque este dois campos são not null...
        QuotedStr(EdDescricaoResuimida.Text) + ', ' +
        QuotedStr(EdDescricaoCompleta.Text) + ', ' +
        QuotedStr(IfThen(CmbICMS.ItemIndex = 0, 'T','F')) + ', ' +
        QuotedStr(IfThen(CmbIPI.ItemIndex = 0, 'T','F')) + ', ' +
        QuotedStr(IfThen(CmbISS.ItemIndex = 0, 'T','F')) + ', ' +
        QuotedStr(IfThen(CmbMovFin.ItemIndex = 0, 'T','F')) + ', ' +
        QuotedStr(IfThen(CmbEstoque.ItemIndex = 0, 'T','F')) + ');',Dm.DBAutocom);
      except
        Application.MessageBox('Ocorreu um erro na tentativa de Salvar!',Autocom,MB_ICONERROR);
      end;
    Editando(False);
    end
  else
    begin
      //Update
      try
        RunSql(' UPDATE NATUREZAOPERACAO SET' +
               ' NATUREZAOPERACAO = ' + QuotedStr(EdDescricaoResuimida.Text) + ', ' +
               ' DESCRICAO = ' + QuotedStr(EdDescricaoCompleta.Text) + ', ' +
               ' TRIBUTAICMS = ' + QuotedStr(IfThen(CmbICMS.ItemIndex = 0, 'T','F')) + ', ' +
               ' TRIBUTAIPI = ' + QuotedStr(IfThen(CmbIPI.ItemIndex = 0, 'T','F')) + ', ' +
               ' TRIBUTAISS = ' + QuotedStr(IfThen(CmbISS.ItemIndex = 0, 'T','F')) + ', ' +
               ' MOVIMENTACONTAS = ' + QuotedStr(IfThen(CmbMovFin.ItemIndex = 0, 'T','F')) + ', ' +
               ' MOVIMENTAESTOQUE = ' + QuotedStr(IfThen(CmbEstoque.ItemIndex = 0, 'T','F')) +
               ' WHERE CODIGONATUREZAOPERACAO  =  ' + EdCodigo.Text,Dm.DBAutocom);
      except
        Application.MessageBox('Ocorreu um erro na tentativa de Salvar!',Autocom,MB_ICONERROR);
      end;
    Editando(False);
    end;
  FreeAndNil(DsSave);
end;


end.
