unit uConsulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB,  ExtCtrls, Buttons, StdCtrls;

type
  TfConsulta = class(TForm)
    DsConsulta: TDataSource;
    GrdConsulta: TDBGrid;
    PanEdit: TPanel;
    TxtEdit: TEdit;
    LblGrupo: TLabel;
    Panel1: TPanel;
    CmdInserir: TSpeedButton;
    CmdAlterar: TSpeedButton;
    CmdApagar: TSpeedButton;
    CmdGravar: TSpeedButton;
    procedure GrdConsultaDblClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrdConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure actAlterarExecute(Sender: TObject);
    procedure actGravarExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure actInserirExecute(Sender: TObject);
    procedure actApagarExecute(Sender: TObject);
    procedure TxtEditKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CmdInserirClick(Sender: TObject);
    procedure CmdAlterarClick(Sender: TObject);
    procedure CmdApagarClick(Sender: TObject);
    procedure CmdGravarClick(Sender: TObject);
  private
    procedure ColetaDados;
    procedure Editando(Status: Boolean = True);
  public
    { Public declarations }
  end;

var
  fConsulta: TfConsulta;
  B_Update: Boolean;

implementation

uses uMain, uDm;

{$R *.dfm}

procedure TfConsulta.GrdConsultaDblClick(Sender: TObject);
begin
  I_Grupo := Dm.Tbl_GrupoUsuarioSistemaIDGRUPOUSUARIO.AsInteger;
  S_Grupo := Dm.Tbl_GrupoUsuarioSistemaNOMEGRUPO.AsString;
  Close;
end;

procedure TfConsulta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Escape then Close;
end;

procedure TfConsulta.GrdConsultaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then GrdConsultaDblClick(self);
end;

procedure TfConsulta.ColetaDados;
begin

end;

procedure TfConsulta.actAlterarExecute(Sender: TObject);
begin
  B_Update := True;
  TxtEdit.Text := Dm.Tbl_GrupoUsuarioSistemaNOMEGRUPO.AsString;
  CmdInserir.Enabled := False;
  CmdAlterar.Enabled := False;
  CmdApagar.Enabled := False;
  CmdGravar.Enabled := True;
  LblGrupo.Enabled := True;
  TxtEdit.Enabled := True;
  TxtEdit.SetFocus;
end;

procedure TfConsulta.actGravarExecute(Sender: TObject);
begin
  {Validacao}
  if Trim(TxtEdit.Text) = '' then
  begin
    Application.MessageBox('O campo nome não pode ficar em branco'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    Exit;
  end;

  {Gravacao}
  if B_Update then
  begin
    FMain.SqlRun(' UPDATE GRUPOUSUARIOSISTEMA SET ' +
                   ' NOMEGRUPO = ' + QuotedStr(TxtEdit.Text) +
                   ' WHERE IDGRUPOUSUARIO = ' +
                   Dm.Tbl_GrupoUsuarioSistemaIDGRUPOUSUARIO.AsString
                   , Dm.Rede, False);
  end;

  if not B_Update then
  begin
    FMain.SqlRun(' INSERT INTO GRUPOUSUARIOSISTEMA (NOMEGRUPO) VALUES (' +
                   QuotedStr(TxtEdit.Text) + ');'
                   , Dm.Rede, False);
  end;
  Dm.Transaction.CommitRetaining;
  Dm.Tbl_GrupoUsuarioSistema.Close;
  Dm.Tbl_GrupoUsuarioSistema.Open;
  Editando(False);
end;

procedure TfConsulta.FormShow(Sender: TObject);
begin
  Editando(False);
end;

procedure TfConsulta.Editando(Status: Boolean);
begin
  if Status then
  begin
    CmdInserir.Enabled := False;
    CmdAlterar.Enabled := False;
    CmdApagar.Enabled := False;
    CmdGravar.Enabled := True;
    LblGrupo.Enabled := True;
    TxtEdit.Enabled := True;
    GrdConsulta.Enabled := False;
    TxtEdit.SetFocus;
  end
    else
  begin
    CmdInserir.Enabled := True;
    CmdAlterar.Enabled := True;
    CmdApagar.Enabled := True;
    CmdGravar.Enabled := False;
    LblGrupo.Enabled := False;
    TxtEdit.Clear;
    TxtEdit.Enabled := False;
    GrdConsulta.Enabled := True;
  end
end;

procedure TfConsulta.actInserirExecute(Sender: TObject);
begin
  B_Update := False;
  Editando;
end;

procedure TfConsulta.actApagarExecute(Sender: TObject);
begin
  if (Application.MessageBox('Deseja Excluir?', 'Autocom PLUS', MB_YESNO +
    MB_ICONQUESTION)) = IDYES then
  begin
    try
      FMain.SqlRun('DELETE FROM GRUPOUSUARIOSISTEMA WHERE IDGRUPOUSUARIO = ' +
                     Dm.Tbl_GrupoUsuarioSistemaIDGRUPOUSUARIO.AsString + ';'
                     , Dm.Rede, False);
    except
      Application.MessageBox('Impossível Excluir este Grupo!'
                             ,'Autocom PLUS',MB_ICONEXCLAMATION);
    end;
    Dm.Transaction.CommitRetaining;
    Dm.Tbl_GrupoUsuarioSistema.Close;
    Dm.Tbl_GrupoUsuarioSistema.Open;
  end;
end;

procedure TfConsulta.TxtEditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_Return then CmdGravarClick(Self);
end;

procedure TfConsulta.CmdInserirClick(Sender: TObject);
begin
  B_Update := False;
  Editando;
end;

procedure TfConsulta.CmdAlterarClick(Sender: TObject);
begin
  B_Update := True;
  TxtEdit.Text := Dm.Tbl_GrupoUsuarioSistemaNOMEGRUPO.AsString;
  CmdInserir.Enabled := False;
  CmdAlterar.Enabled := False;
  CmdApagar.Enabled := False;
  CmdGravar.Enabled := True;
  LblGrupo.Enabled := True;
  TxtEdit.Enabled := True;
  TxtEdit.SetFocus;
end;

procedure TfConsulta.CmdApagarClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja Excluir?', 'Autocom PLUS', MB_YESNO +
    MB_ICONQUESTION)) = IDYES then
  begin
    try
      FMain.SqlRun('DELETE FROM GRUPOUSUARIOSISTEMA WHERE IDGRUPOUSUARIO = ' +
                     Dm.Tbl_GrupoUsuarioSistemaIDGRUPOUSUARIO.AsString + ';'
                     , Dm.Rede, False);
    except
      Application.MessageBox('Impossível Excluir este Grupo!'
                             ,'Autocom PLUS',MB_ICONEXCLAMATION);
    end;
    Dm.Transaction.CommitRetaining;
    Dm.Tbl_GrupoUsuarioSistema.Close;
    Dm.Tbl_GrupoUsuarioSistema.Open;
  end;
end;

procedure TfConsulta.CmdGravarClick(Sender: TObject);
begin
  {Validacao}
  if Trim(TxtEdit.Text) = '' then
  begin
    Application.MessageBox('O campo nome não pode ficar em branco'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    Exit;
  end;

  {Gravacao}
  if B_Update then
  begin
    FMain.SqlRun(' UPDATE GRUPOUSUARIOSISTEMA SET ' +
                   ' NOMEGRUPO = ' + QuotedStr(TxtEdit.Text) +
                   ' WHERE IDGRUPOUSUARIO = ' +
                   Dm.Tbl_GrupoUsuarioSistemaIDGRUPOUSUARIO.AsString
                   , Dm.Rede, False);
  end;

  if not B_Update then
  begin
    FMain.SqlRun(' INSERT INTO GRUPOUSUARIOSISTEMA (NOMEGRUPO) VALUES (' +
                   QuotedStr(TxtEdit.Text) + ');'
                   , Dm.Rede, False);
  end;
  Dm.Transaction.CommitRetaining;
  Dm.Tbl_GrupoUsuarioSistema.Close;
  Dm.Tbl_GrupoUsuarioSistema.Open;
  Editando(False);

end;

end.
