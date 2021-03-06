unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPStyleActnCtrls, ActnList, ActnMan, ExtCtrls, Grids, DBGrids,
  IniFiles, DB, StdCtrls, ToolWin, ActnCtrls, ImgList, Mask, DBCtrls, uGlobal;

type
  TfMain = class(TForm)
    ActMan: TActionManager;
    GrdImpressoras: TDBGrid;
    PanCad: TPanel;
    DSourceImpressoras: TDataSource;
    LblNome: TLabel;
    LblEndereco: TLabel;
    ActGravar: TAction;
    ActCancelar: TAction;
    ActFechar: TAction;
    Img: TImageList;
    ActionToolBar1: TActionToolBar;
    ActNovo: TAction;
    TxtNome: TEdit;
    TxtEndereco: TEdit;
    ActExcluir: TAction;
    ActSelectAll: TAction;
    procedure FormActivate(Sender: TObject);
    procedure GrdImpressorasDblClick(Sender: TObject);
    procedure ActFecharExecute(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure ActNovoExecute(Sender: TObject);
    procedure ActGravarExecute(Sender: TObject);
    procedure ActExcluirExecute(Sender: TObject);
    procedure GrdImpressorasKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TxtNomeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TxtEnderecoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ActSelectAllExecute(Sender: TObject);
  private
    procedure ConectaDataBase;
    procedure ActivateFields(EnabledFields: Boolean = True);
    procedure SelectData(CODIGOIMPRESSORA: string);
  public
    DsImpressora: TDataSet;
  end;

var
  fMain: TfMain;
    NewRegister: Boolean;
    CodigoImpressora: ShortString;
implementation

uses uDM;

{$R *.dfm}
{ Responsavel: Andr? Faria Gomes                                               }
{ Objetivo: Ativar e Desativar Campos                                          }
procedure TfMain.ActivateFields(EnabledFields: Boolean);
begin
  if EnabledFields then
  begin
    LblNome.Enabled := True;
    LblEndereco.Enabled := True;
    TxtNome.Enabled := True;
    TxtEndereco.Enabled := True;
    ActGravar.Enabled := True;
    ActExcluir.Enabled := False;
    ActCancelar.Enabled := True;
    ActFechar.Enabled := False;
    ActNovo.Enabled := False;
    GrdImpressoras.Enabled := False;
    TxtNome.SetFocus;
  end
  else
  begin
    TxtNome.Clear;
    TxtEndereco.Clear;
    LblNome.Enabled := False;
    LblEndereco.Enabled := False;
    TxtNome.Enabled := False;
    TxtEndereco.Enabled := False;
    ActGravar.Enabled := False;
    ActCancelar.Enabled := False;
    ActExcluir.Enabled := True;
    ActFechar.Enabled := True;
    ActNovo.Enabled := True;
    GrdImpressoras.Enabled := True;
    GrdImpressoras.SetFocus;
  end;
end;

{ Responsavel: Andr? Faria Gomes                                               }
{ Objetivo: Concectar Banco de Dados                                           }
procedure TfMain.ConectaDataBase;
var
  Ini: TiniFile;
  T1, T2: string;
begin
  {Fecha Base de Dados e Transa??o}
  Dm.Transaction.Active := False;
  Dm.DBAutocom.Connected := False;
  {Pega Dados no Arquivo Ini}
  Ini := TIniFile.Create(ExtractFilePath(Application.ExeName) + 'DADOS\AUTOCOM.INI');
  T1 := Ini.ReadString('ATCPLUS','IP_SERVER','');
  T2 := Ini.ReadString('ATCPLUS','PATH_DB','');
  Ini.Free;
  {Atribui endereco do banco de dados ao componente}
  Dm.DBAutocom.DatabaseName := T1 + ':' + T2;
  {Conecta Base e Abre Transa??o}
  Dm.dbautocom.Connected := True;
  Dm.Transaction.Active := True;
  {Conecta Tabela}
  ActSelectAll.Execute;
end;

procedure TfMain.FormActivate(Sender: TObject);
begin
  {Conecta Banco de Dados}
  ConectaDataBase;
  {Visualiza??o}
  SetForegroundWindow(Application.Handle);
  ActivateFields(False);
end;


procedure TfMain.GrdImpressorasDblClick(Sender: TObject);
begin
  NewRegister := False;
  ActivateFields;
  SelectData(DsImpressora.FieldByName('CODIGOIMPRESSORA').AsString);
end;

procedure TfMain.ActFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TfMain.ActCancelarExecute(Sender: TObject);
begin
  ActivateFields(False);
end;

procedure TfMain.ActNovoExecute(Sender: TObject);
begin
  NewRegister := True;
  ActivateFields;
end;

procedure TfMain.ActGravarExecute(Sender: TObject);
begin
  if MessageBox(Handle,'Deseja Gravar?','Confirma??o',MB_YESNO + MB_ICONQUESTION) = ID_YES then
  begin
    if NewRegister then
      Dm.InsertImpressora('1' ,TxtNome.Text, TxtEndereco.Text)
    else
      Dm.UpdateImpressora(DsImpressora.FieldByName('CODIGOIMPRESSORA').AsString, TxtNome.Text, TxtEndereco.Text);
    ActSelectAll.Execute;
    ActivateFields(False);
  end;
end;


procedure TfMain.SelectData(CODIGOIMPRESSORA: string);
var
  DsAux: TDataSet;
begin
  RunSql('SELECT * FROM IMPRESSORA WHERE CODIGOIMPRESSORA = ' + CODIGOIMPRESSORA,dm.dbautocom,DsAux);
  TxtNome.Text      := DsAux.FieldByName('NOMEIMPRESSORA').AsString;
  TxtEndereco.Text  := DsAux.FieldByName('CAMINHOIMPRESSORA').AsString;
  FreeAndNil(DsAux);
end;

procedure TfMain.ActExcluirExecute(Sender: TObject);
begin
  if MessageBox(Handle,'Deseja Excluir?','Confirma??o',MB_YESNO + MB_ICONQUESTION) = ID_YES then
  begin
    try
      Dm.DeleteImpressora(DsImpressora.FieldByName('CODIGOIMPRESSORA').AsString);
    except
      MessageBox(Handle,'Impossivel Excluir!','Erro',MB_ICONHAND);
    end;
    ActSelectAll.Execute;
  end;
end;

procedure TfMain.GrdImpressorasKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then GrdImpressorasDblClick(Self);
end;

procedure TfMain.TxtNomeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then Perform(WM_NEXTDLGCTL,0,0);
  if Key = VK_ESCAPE then ActCancelar.Execute;
end;

procedure TfMain.TxtEnderecoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then ActGravar.Execute;
  if Key = VK_ESCAPE then ActCancelar.Execute;
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dm.DBAutocom.Close;
end;

procedure TfMain.ActSelectAllExecute(Sender: TObject);
begin
  RunSql('select * from IMPRESSORA',dm.dbautocom,DsImpressora);
  DSourceImpressoras.DataSet := DsImpressora;
end;

end.
