unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponent, JvBalloonHint, ImgList, uGlobal, ActnList, XPStyleActnCtrls,
  ActnMan, DB, Grids, DBGrids, ComCtrls, StdCtrls, Mask, ExtCtrls, Buttons, StrUtils,
  ToolWin, ActnCtrls;

type
  TLoadData = set of (Forncedor, Pessoa, Endereco);
  TfMain = class(TForm)
    BtnRelatorio: TSpeedButton;
    BtnFechar: TSpeedButton;
    PanCod: TPanel;
    GrdPessoa: TDBGrid;
    DSourceGrid: TDataSource;
    ActMain: TActionManager;
    ActNovo: TAction;
    ActPesquisar: TAction;
    ActFechar: TAction;
    ActRelatorio: TAction;
    ActSelectAll: TAction;
    ImgMain: TImageList;
    JvBalloonHint: TJvBalloonHint;
    ActOrdemNumerica: TAction;
    ActOrdem: TAction;
    ActOrdemAlfabetica: TAction;
    PanEdMain: TPanel;
    EdMain: TEdit;
    ActionToolBar1: TActionToolBar;
    procedure ActFecharExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure ActSelectAllExecute(Sender: TObject);
    procedure EdMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure ActNovoExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrdPessoaEnter(Sender: TObject);
    procedure GrdPessoaExit(Sender: TObject);
    procedure GrdPessoaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrdPessoaDblClick(Sender: TObject);
    procedure ActOrdemAlfabeticaExecute(Sender: TObject);
    procedure ActOrdemNumericaExecute(Sender: TObject);
    procedure ActOrdemExecute(Sender: TObject);
    procedure ActRelatorioExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    Ordem: String;
    procedure Editar(Cod: Real);
  public
    DsGrid: TDataSet;
  end;

var
  fMain: TfMain;
  
implementation

uses uDm, DateUtils, uConsultaPessoa, uRelatorio, uCadastro;

{$R *.dfm}

procedure TfMain.ActFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TfMain.FormActivate(Sender: TObject);
begin
  Ordem := ' ORDER BY PES_NOME_A ';
  LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + 'Carregando Cadastro de Pessoas...');
  Dm.dbautocom.Close;
  Dm.dbautocom.DatabaseName := LeINI('ATCPLUS','IP_SERVER') + ':' + LeINI('ATCPLUS','PATH_DB');
  Dm.dbautocom.Open;
  Dm.Transaction.Active := True;
  LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + 'Banco de Dados Aberto...');
  //Carrega Dados no Grid
  ActSelectAll.Execute;
end;

procedure TfMain.ActSelectAllExecute(Sender: TObject);
begin
  RunSql('SELECT PES_CODPESSOA, PES_NOME_A FROM PESSOA ' + Ordem,dm.dbautocom, DsGrid);
  DSourceGrid.DataSet := DsGrid;
end;

procedure TfMain.EdMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
      begin
        if IsFloat(EdMain.Text) then
          begin
          RunSql('SELECT PES_CODPESSOA, PES_NOME_A FROM PESSOA WHERE PES_CODPESSOA = ' + EdMain.Text + Ordem,dm.dbautocom,DsGrid);
          if not DsGrid.IsEmpty then
              Editar(DsGrid.FieldByName('PES_CODPESSOA').AsFloat)
          else
            begin
              if Application.MessageBox('Código não encontrado, deseja cadastra-lo?',Autocom,MB_YESNO) = ID_YES then
                Editar(StrToFloat(EdMain.Text));
            end;
        end
      else
          ActPesquisar.Execute;
      end;
    VK_DOWN: Perform(WM_NEXTDLGCTL,0,0);
  end;
end;


procedure TfMain.ActPesquisarExecute(Sender: TObject);
begin
  if IsFloat(EdMain.Text) then
    begin
      RunSql('SELECT PES_CODPESSOA, PES_NOME_A FROM PESSOA WHERE PES_CODPESSOA = ' + EdMain.Text + Ordem,dm.dbautocom,DsGrid);
    end
  else
    begin
      RunSql('SELECT PES_CODPESSOA, PES_NOME_A FROM PESSOA WHERE PES_NOME_A LIKE ' + QuotedStr('%'+EdMain.Text+'%') + Ordem,dm.dbautocom,DsGrid);
    end;
    DSourceGrid.DataSet := DsGrid;
end;

procedure TfMain.ActNovoExecute(Sender: TObject);
begin
  Editar(0);
end;

procedure TfMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key of
    VK_RETURN: Perform(WM_NEXTDLGCTL,0,0);
    VK_F5: ActSelectAll.Execute;
  end;
end;

procedure TfMain.GrdPessoaEnter(Sender: TObject);
begin
   KeyPreview := False;
end;

procedure TfMain.GrdPessoaExit(Sender: TObject);
begin
  KeyPreview := True;
end;

procedure TfMain.GrdPessoaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_UP: if DsGrid.RecNo = 1 then Perform(WM_NEXTDLGCTL,1,0);
    VK_RETURN: Editar(DsGrid.FieldByName('PES_CODPESSOA').AsFloat);
  end;
end;

procedure TfMain.Editar(Cod: Real);
begin
  with TfCadastro.Create(Self) do
    begin
      Codigo := Cod;
      ShowModal;
      Free;
    end;
  ActSelectAll.Execute;
end;

procedure TfMain.GrdPessoaDblClick(Sender: TObject);
begin
  Editar(DsGrid.FieldByName('PES_CODPESSOA').AsFloat);
end;

procedure TfMain.ActOrdemAlfabeticaExecute(Sender: TObject);
begin
  Ordem := ' ORDER BY PES_NOME_A ';
  ActSelectAll.Execute;
end;

procedure TfMain.ActOrdemNumericaExecute(Sender: TObject);
begin
  Ordem := ' ORDER BY PES_CODPESSOA ';
  ActSelectAll.Execute;
end;

procedure TfMain.ActOrdemExecute(Sender: TObject);
begin
  Refresh;
end;

procedure TfMain.ActRelatorioExecute(Sender: TObject);
begin
  with TfRelatorio.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + 'Cadastro de Pessoas Fechado!');
end;

end.
