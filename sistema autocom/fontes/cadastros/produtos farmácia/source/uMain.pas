unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvComponent, JvBalloonHint, ImgList, ActnList, XPStyleActnCtrls,
  ActnMan, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, uGlobal, DB;

type
  TfMain = class(TForm)
    PanCod: TPanel;
    BtnPesquisar: TSpeedButton;
    BtnNovo: TSpeedButton;
    EdMain: TEdit;
    GrdMain: TDBGrid;
    BtnRelatorio: TSpeedButton;
    BtnFechar: TSpeedButton;
    ActMain: TActionManager;
    ActNovo: TAction;
    ActPesquisar: TAction;
    ActFechar: TAction;
    ActRelatorio: TAction;
    ImgMain: TImageList;
    DsMain: TDataSource;
    ActEditar: TAction;
    BtnSelectAll: TSpeedButton;
    ActSelectAll: TAction;
    JvBalloonHint: TJvBalloonHint;
    procedure FormActivate(Sender: TObject);
    procedure ActEditarExecute(Sender: TObject);
    procedure ActFecharExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActNovoExecute(Sender: TObject);
    procedure GrdMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnSelectAllClick(Sender: TObject);
    procedure ActSelectAllExecute(Sender: TObject);
    procedure EdMainEnter(Sender: TObject);
    procedure EdMainExit(Sender: TObject);
    procedure ActPesquisarExecute(Sender: TObject);
    procedure ActRelatorioExecute(Sender: TObject);
  private
  public
  end;

var
  fMain: TfMain;
    ResultConsultaCodigo: real;
    ResultConsultaNome: string;
    IntAux: Integer;

implementation

uses uDm, uCadastro, uRelatorio;

{$R *.dfm}

procedure TfMain.ActEditarExecute(Sender: TObject);
begin
  fCadastro.Estado := dsEdit;
  fCadastro.ShowModal;
  Dm.QrProduto.Close;
  Dm.QrProduto.Open;
end;

procedure TfMain.ActFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  LogSend('logs\CADPROD' + FormatDateTime('yyyymmdd',Now)+'.log','Cadastro de Produtos Fechado!');
  Dm.DBAutocom.Close;
end;

procedure TfMain.FormActivate(Sender: TObject);
begin
  ForceDirectories(ExtractFilePath(Application.ExeName) + '\logs');
  LogSend('logs\CADPROD' + FormatDateTime('yyyymmdd',Now)+'.log','Abrindo cadastro de produtos.');
  Dm.dbautocom.DatabaseName := LeINI('ATCPLUS','IP_SERVER') + ':' + LeINI('ATCPLUS','PATH_DB');
  Dm.dbautocom.Connected := True;
  Dm.Transaction.Active := True;
  LogSend('logs\CADPROD' + FormatDateTime('yyyymmdd',Now)+'.log','Banco de dados conectado.');
  Dm.QrProduto.Open;
end;


procedure TfMain.ActNovoExecute(Sender: TObject);
begin
  ZeroMemory(@IntAux,SizeOf(IntAux));
  fCadastro.Estado := dsInsert;
  fCadastro.ShowModal;
  Dm.QrProduto.Close;
  Dm.QrProduto.Open;
end;

procedure TfMain.GrdMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_RETURN: ActEditar.Execute;
  end;
end;

procedure TfMain.EdMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  DsAux: TDataSet;
begin
  case Key of
    VK_RETURN:
      begin
        if IsNull(EdMain.Text) then Exit;
        ZeroMemory(@IntAux,SizeOf(IntAux));
        if (IsInteger(EdMain.Text)) and (not IsNull(EdMain.Text)) then
          begin
            RunSQL('SELECT CODIGOPRODUTO FROM PRODUTOASSOCIADO WHERE CODIGOPRODUTOASSOCIADO = ' + EdMain.Text, Dm.DBAutocom, DsAux);
            if not DsAux.IsEmpty then
              IntAux := DsAux.Fields[0].AsInteger
            else
              begin
                RunSQL('SELECT CODIGOPRODUTO FROM PRODUTO WHERE CODIGOPRODUTO = ' + EdMain.Text, Dm.DBAutocom, DsAux);
                if not DsAux.IsEmpty then
                  IntAux := DsAux.Fields[0].AsInteger
                else
                  if Application.MessageBox(Pchar('O Produto de código ' + EdMain.Text + ' ainda não exite, deseja cadastra-lo?'),Autocom,MB_ICONQUESTION + MB_YESNO) = ID_YES then
                    begin
                      IntAux := StrToInt(EdMain.Text);
                      fCadastro.Estado := dsInsert;
                      fCadastro.ShowModal;
                    end;
              end;
          end
        else
          begin
            SqlRun('SELECT CODIGOPRODUTO, NOMEPRODUTO FROM PRODUTO WHERE NOMEPRODUTO LIKE ' + QuotedStr('%' + EdMain.Text + '%') + ' ORDER BY NOMEPRODUTO',Dm.QrProduto);
            Exit;
          end;
        if not DsAux.IsEmpty then
        begin
          SqlRun('SELECT CODIGOPRODUTO, NOMEPRODUTO FROM PRODUTO WHERE CODIGOPRODUTO = ' + IntToStr(IntAux) + ' ORDER BY NOMEPRODUTO',Dm.QrProduto);
          ActEditar.Execute;
        end;
        EdMain.Clear;
        ActSelectAll.Execute;
      end;
  end;
end;

procedure TfMain.BtnSelectAllClick(Sender: TObject);
begin
  ActSelectAll.Execute;
end;

procedure TfMain.ActSelectAllExecute(Sender: TObject);
begin
  SqlRun('SELECT CODIGOPRODUTO, NOMEPRODUTO FROM PRODUTO ORDER BY CODIGOPRODUTO',Dm.QrProduto);
end;

procedure TfMain.EdMainEnter(Sender: TObject);
begin
  JvBalloonHint.ActivateHint(EdMain,EdMain.Hint);
end;

procedure TfMain.EdMainExit(Sender: TObject);
begin
  JvBalloonHint.CancelHint;
end;

procedure TfMain.ActPesquisarExecute(Sender: TObject);
var
  DsAux: TDataSet;
begin
  if (IsInteger(EdMain.Text)) and (not IsNull(EdMain.Text)) then
    begin
      RunSQL('SELECT CODIGOPRODUTO FROM PRODUTOASSOCIADO WHERE CODIGOPRODUTOASSOCIADO = ' + EdMain.Text, Dm.DBAutocom, DsAux);
      if not DsAux.IsEmpty then
        IntAux := DsAux.Fields[0].AsInteger
      else
        begin
          RunSQL('SELECT CODIGOPRODUTO FROM PRODUTO WHERE CODIGOPRODUTO = ' + EdMain.Text, Dm.DBAutocom, DsAux);
          if not DsAux.IsEmpty then
            IntAux := DsAux.Fields[0].AsInteger
        end;
    end
  else
    begin
      SqlRun('SELECT CODIGOPRODUTO, NOMEPRODUTO FROM PRODUTO WHERE NOMEPRODUTO LIKE ' + QuotedStr('%' + EdMain.Text + '%') + ' ORDER BY NOMEPRODUTO',Dm.QrProduto);
      Exit;
    end;
  if not DsAux.IsEmpty then
  begin
    SqlRun('SELECT CODIGOPRODUTO, NOMEPRODUTO FROM PRODUTO WHERE CODIGOPRODUTO = ' + IntToStr(IntAux) + ' ORDER BY NOMEPRODUTO',Dm.QrProduto);
  end;
  EdMain.Clear;
end;
procedure TfMain.ActRelatorioExecute(Sender: TObject);
begin
  with TfRelatorio.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
end;

end.
