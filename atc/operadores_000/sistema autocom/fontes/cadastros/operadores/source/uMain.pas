unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, Buttons, Grids, DBGrids, ExtCtrls, IniFiles,
  DB, StdCtrls, IBQuery, Mask, DBCtrls, JvComponent, JvBalloonHint, uGlobal;

type
  TfMain = class(TForm)
    TrtsMain: TPageControl;
    TabOperadores: TTabSheet;
    TabGrupo: TTabSheet;
    Images: TImageList;
    CmbFechar: TSpeedButton;
    GrdOperadores: TDBGrid;
    PanOperadores: TPanel;
    DsOperadores: TDataSource;
    LblOpCodigo: TLabel;
    LblOpGrupoCodigo: TLabel;
    LblOpusuario: TLabel;
    LblOpSenha: TLabel;
    LblOpNomeCompleto: TLabel;
    LblOpStatus: TLabel;
    TxtOpUsuario: TEdit;
    TxtOpNomeCompleto: TEdit;
    CmbStatus: TComboBox;
    CmdOpGrupo: TSpeedButton;
    CmbOpGravar: TSpeedButton;
    CmbOpCancelar: TSpeedButton;
    CmbOpApagar: TSpeedButton;
    MskOpCodigo: TMaskEdit;
    MskOpCodigoGrupo: TMaskEdit;
    MskSenha: TMaskEdit;
    PanOpTop: TPanel;
    TxtCod: TEdit;
    CmdProcurar: TSpeedButton;
    LblOpSenha2: TLabel;
    MskSenha2: TMaskEdit;
    CmdNovoCadastro: TSpeedButton;
    LblGrupoNome: TLabel;
    LblCAGrupoNome: TLabel;
    LblCAGrupo: TLabel;
    MskCAGrupo: TMaskEdit;
    CmdCAGrupo: TSpeedButton;
    PanPermissao: TPanel;
    GrdPermissao: TDBGrid;
    DsPermissaoSistema: TDataSource;
    PanPermissaoButtons: TPanel;
    CmdCaGravar: TSpeedButton;
    CmdCaCancelar: TSpeedButton;
    PanHide: TPanel;
    JvBalloonHint: TJvBalloonHint;
    procedure actFecharExecute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure GrdOperadoresDblClick(Sender: TObject);
    procedure actGravarOpExecute(Sender: TObject);
    procedure actOpNovoExecute(Sender: TObject);
    procedure aOpGruposExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MskOpCodigoGrupoEnter(Sender: TObject);
    procedure MskOpCodigoGrupoExit(Sender: TObject);
    procedure MskOpCodigoGrupoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MskCAGrupoExit(Sender: TObject);
    procedure actCancelarCaExecute(Sender: TObject);
    procedure TrtsMainChanging(Sender: TObject; var AllowChange: Boolean);
    procedure actGravaCaExecute(Sender: TObject);
    procedure GrdPermissaoDblClick(Sender: TObject);
    procedure TxtCodKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CmbStatusKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure GrdOperadoresKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrdPermissaoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure CmbFecharClick(Sender: TObject);
    procedure CmbOpApagarClick(Sender: TObject);
    procedure CmbOpGravarClick(Sender: TObject);
    procedure CmbOpCancelarClick(Sender: TObject);
    procedure CmdNovoCadastroClick(Sender: TObject);
    procedure CmdOpGrupoClick(Sender: TObject);
    procedure CmdProcurarClick(Sender: TObject);
    procedure CmdCaGravarClick(Sender: TObject);
    procedure CmdCaCancelarClick(Sender: TObject);
    procedure CmdCAGrupoClick(Sender: TObject);
    procedure MskCAGrupoEnter(Sender: TObject);
  private
    procedure ConectaDataBase;
    procedure Editando(Tabela: Integer; StatusEd: Boolean = True);
    procedure ColetaDados(Tabela: Integer);
    procedure SQLOperadores(Operacao: Integer);{1:Insere, 2:Altera, 3:Deleta}
    function ValidaOperadores: Boolean;
    procedure InsertPermisions(Grupo: Integer);
  public
    procedure SqlRun(SQL: string; Table: TIBQuery; OpenTable: Boolean = True);
    procedure EditClear;
    function Criptografar(Password: string): string;
    function Enche(texto,caracter:string;lado,tamanho:integer):string;
    function IsFloat(S: string): Boolean;
  end;

var
  fMain: TfMain;
  Patch: string;
  B_NewOperadorador: Boolean; {True: Insert | False: Update}
  I_Grupo: Integer; {Codigo do Grupo - Usado no Form Consulta Também}
  S_Grupo: string; {Nome do Grupo - Usado no Form Consulta Também}

implementation

uses Math, uConsulta, Types, uDm;

  function Encripit(a, b, c, d, e, f: Integer): ShortString;
  external 'ECRPT.dll' index 1;

{$R *.dfm}

{------------------------------------------------------------------------------|
|                                   Procedimentos                              |
|------------------------------------------------------------------------------}

procedure TfMain.ConectaDataBase;
var
  Ini: TiniFile;
  T1, T2: string;
begin
  {Fecha Base de Dados e Transação}
  Dm.Transaction.Active := False;
  Dm.DBAutocom.Connected := False;
  {Pega Dados no Arquivo Ini}
  Ini := TIniFile.Create(Patch + 'autocom.ini');
  T1 := Ini.ReadString('ATCPLUS','IP_SERVER','');
  T2 := Ini.ReadString('ATCPLUS','PATH_DB','');
  Ini.Free;
  {Atribui endereco do banco de dados ao componente}
  Dm.DBAutocom.DatabaseName := T1 + ':' + T2;
  {Conecta Base e Abre Transação}
  Dm.dbautocom.Connected := True;
  Dm.Transaction.Active := True;
  {Conecta Tabela}
  SqlRun(' SELECT * FROM USUARIOSISTEMA ', Dm.Tbl_UsuarioSistema);
end;

procedure TfMain.ColetaDados(Tabela: Integer);
begin
  if Tabela = 1 then
  {Coleta Dados da Tabela UsuarioSistema}
  begin
    Editando(1);
    B_NewOperadorador := False;
    MskOpCodigo.Text := Dm.Tbl_UsuarioSistemaIDUSUARIO.AsString;
    MskOpCodigoGrupo.Text := Dm.Tbl_UsuarioSistemaIDGRUPOUSUARIO.AsString;
    TxtOpUsuario.Text := Dm.Tbl_UsuarioSistemaNOMEUSUARIO.AsString;
    TxtOpNomeCompleto.Text := Dm.Tbl_UsuarioSistemaNOMECOMPLETO.AsString;

    {Atribiu valor ao ComboBox}
    if Dm.Tbl_UsuarioSistemaINATIVO.AsString = 'T' then
      CmbStatus.ItemIndex := 1
    else
      CmbStatus.ItemIndex := 0;
  end;

  {Pega Nome do Grupo}
  SqlRun(' SELECT NOMEGRUPO FROM GRUPOUSUARIOSISTEMA ' +
         ' WHERE IDGRUPOUSUARIO = ' +
          MskOpCodigoGrupo.Text
          , Dm.Rede);
  LblGrupoNome.Caption := Dm.Rede.Fields[0].AsString;

end;

procedure TfMain.Editando(Tabela: Integer; StatusEd: Boolean);
begin

  if (Tabela = 1) and (StatusEd = True) then
  begin
    PanOperadores.Visible := True;
    CmbFechar.Enabled := False;
    if B_NewOperadorador then CmbOpApagar.Enabled := False
      else CmbOpApagar.Enabled := True;
    CmbOpGravar.Enabled := True;
    CmbOpCancelar.Enabled := True;
    PanHide.Visible := True;
    MskOpCodigoGrupo.SetFocus;
    GrdOperadores.Enabled := False;
    TxtCod.Enabled := False;
    CmdProcurar.Enabled := False;
    CmdNovoCadastro.Enabled := False;
  end;

  if (Tabela = 1) and (StatusEd = False) then
  begin
    PanOperadores.Visible := False;
    CmbFechar.Enabled := True;
    CmbOpApagar.Enabled := False;
    CmbOpGravar.Enabled := False;
    CmbOpCancelar.Enabled := False;
    PanHide.Visible := False;
    GrdOperadores.Enabled := True;
    TxtCod.Enabled := True;
    CmdProcurar.Enabled := True;
    CmdNovoCadastro.Enabled := True;
    SqlRun('SELECT * FROM USUARIOSISTEMA', Dm.Tbl_UsuarioSistema);
  end;

  if (Tabela = 2) and (StatusEd = True) then
  begin
    InsertPermisions(I_Grupo);
    Dm.Tbl_PermissaoSistema.Close;
    Dm.Tbl_PermissaoSistema.Params[0].Value := I_Grupo;
    Dm.Tbl_PermissaoSistema.Open;
    CmdCaCancelar.Enabled := True;
    CmdCaGravar.Enabled := True;
    LblCAGrupo.Enabled := False;
    MskCAGrupo.Enabled := False;
    CmdCAGrupo.Enabled := False;
    PanHide.Visible := True;
    GrdPermissao.Visible := True;
  end;

  if (Tabela = 2) and (StatusEd = False) then
  begin
    Dm.Tbl_PermissaoSistema.Close;
    CmdCaCancelar.Enabled := False;
    CmdCaGravar.Enabled := False;
    LblCAGrupo.Enabled := True;
    MskCAGrupo.Enabled := True;
    CmdCAGrupo.Enabled := True;
    PanHide.Visible := False;
    MskCAGrupo.Clear;
    ZeroMemory(@I_Grupo, SizeOf(I_Grupo));
    GrdPermissao.Visible := False;
    LblCAGrupoNome.Caption := 'Grupo';
    LblCAGrupoNome.Enabled := False;
  end;
end;

procedure TfMain.SqlRun(SQL: string; Table: TIBQuery; OpenTable: Boolean);
begin
  Table.Close;
  Table.SQL.Clear;
  Table.SQL.Add(SQL);
  Table.Prepare;
  if OpenTable then Table.Open else Table.ExecSQL;
end;

procedure TfMain.SQLOperadores(Operacao: Integer);
{1:Inserir, 2:Alterar, 3:Deletar}
var S_CmbStatus: string;
begin
  {Atribiu Valor do ComboBox a String}
  if CmbStatus.ItemIndex = 0 then
    S_CmbStatus := 'F'
  else
    S_CmbStatus := 'T';

  {Inclusão na Tabela de Operadores}
  if Operacao = 1 then
  begin
    SqlRun('INSERT INTO USUARIOSISTEMA (IDGRUPOUSUARIO, ' +
           ' NOMEUSUARIO, SENHA, NOMECOMPLETO, INATIVO) VALUES (' +
           MskOpCodigoGrupo.Text + ', ' +
           QuotedStr(TxtOpUsuario.Text) + ', ' +
           QuotedStr(Criptografar(Enche((Trim(MskSenha.Text)),'0',1,6))) + ', ' +
           QuotedStr(TxtOpNomeCompleto.Text) + ', ' +
           QuotedStr(S_CmbStatus) + '); '
           , Dm.Rede, False);
    Dm.Transaction.CommitRetaining;
    Dm.Tbl_UsuarioSistema.Close;
    Dm.Tbl_UsuarioSistema.Open;
    Editando(1, False);
  end;

  {Alteração na Tabela de Operadores}
  if Operacao = 2 then
  begin
    SqlRun(' UPDATE USUARIOSISTEMA SET ' +
           ' IDGRUPOUSUARIO = ' + MskOpCodigoGrupo.Text + ', ' +
           ' NOMEUSUARIO = ' + QuotedStr(TxtOpUsuario.Text) + ', ' +
           ' SENHA = ' + QuotedStr(Criptografar(Enche((Trim(MskSenha.Text)),'0',1,6))) + ', ' +
           ' NOMECOMPLETO = ' + QuotedStr(TxtOpNomeCompleto.Text) + ', ' +
           ' INATIVO = ' + QuotedStr(S_CmbStatus) +
           ' WHERE IDUSUARIO = ' + MskOpCodigo.Text + ';'
           , Dm.Rede, False);
    Dm.Transaction.CommitRetaining;
    Dm.Tbl_UsuarioSistema.Close;
    Dm.Tbl_UsuarioSistema.Open;
    Editando(1, False);
  end;

  {Exclusão na Tabela de Operadores}
  if Operacao = 3 then
  begin
    try
      SqlRun(' DELETE FROM USUARIOSISTEMA WHERE IDUSUARIO = ' +
             MskOpCodigo.Text + ';'
             , Dm.Rede, False);
      Dm.Transaction.CommitRetaining;
      Dm.Tbl_UsuarioSistema.Close;
      Dm.Tbl_UsuarioSistema.Open;
      Editando(1, False);
    except
      Application.MessageBox('Impossível Excluir!','Autocom PLUS', MB_OK +
        MB_ICONHAND);
    end;
  end;

end;

procedure TfMain.EditClear;
var I: Integer;
begin
  {Limpa todos os Campos derivados de TCustomEdit}
  for I := 0 to FMain.ComponentCount-1 do
    if (Components[i] is TCustomEdit) then
      (Components[i] as TCustomEdit).Clear;
  LblGrupoNome.Caption := '';
end;

procedure TfMain.InsertPermisions(Grupo: Integer);
var I_OID: Integer;
begin
  Dm.Tbl_Permissao.Open;
  Dm.Tbl_Permissao.First;
  while not Dm.Tbl_Permissao.Eof do
  begin
    {Verifica se já existe Permissao para Determinada Secao do Autocom}
    SqlRun(' SELECT * FROM GRUPOUSUARIO_PERMISSAO WHERE ' +
           ' IDGRUPOUSUARIO = ' + IntToStr(Grupo) +
           ' AND IDPERMISSAOSISTEMA = ' +
           Dm.Tbl_PermissaoIDPERMISSAOSISTEMA.AsString, Dm.Rede);
    if Dm.Rede.IsEmpty then
    begin
    {Se não houver insere valor false no banco para esta secao}
    {Pega Ultimo Valor do Campo OID}
      SqlRun('SELECT MAX(OID) + 1 FROM GRUPOUSUARIO_PERMISSAO', Dm.Rede);
    {Rotina SQL de Inclusão}
      if Dm.Rede.IsEmpty then
      begin
        I_OID := 1;
      end
        else
      begin
        I_OID := Dm.Rede.Fields[0].AsInteger;
        SqlRun('INSERT INTO GRUPOUSUARIO_PERMISSAO ' +
               '(IDGRUPOUSUARIO, IDPERMISSAOSISTEMA, INSERIR, ' +
               'ALTERAR, EXCLUIR, OID) VALUES ( ' +
               IntToStr(I_Grupo) + ', ' +
               Dm.Tbl_PermissaoIDPERMISSAOSISTEMA.AsString + ', ' +
               QuotedStr('F') + ', ' +
               QuotedStr('F') + ', ' +
               QuotedStr('F') + ', ' +
               IntToStr(I_OID) + ');', Dm.Net);
      end;
    end;
    Dm.Tbl_Permissao.Next;
  end;
  Dm.Transaction.CommitRetaining;
end;


{------------------------------------------------------------------------------|
|                                      Funções                                 |
|------------------------------------------------------------------------------}

function TfMain.Criptografar(Password: String): String;
var a,b,c,d,e,f: Integer;
begin
  a := StrToInt(Copy(Password,1,1));
  b := StrToInt(Copy(Password,2,1));
  c := StrToInt(Copy(Password,3,1));
  d := StrToInt(Copy(Password,4,1));
  e := StrToInt(Copy(Password,5,1));
  f := StrToInt(Copy(Password,6,1));
  Result := Encripit(a,b,c,d,e,f);
end;

function TfMain.IsFloat(S: string): Boolean;
var
  f: extended;
begin
  Result := TextToFloat(PChar(S), f, fvExtended);
end; 

function TfMain.ValidaOperadores: Boolean;
begin
  Result := False;
  {Valida Codigo do Grupo}
  if (Trim(MskOpCodigoGrupo.Text) = '') or
    (StrToInt(MskOpCodigoGrupo.Text) = 0) then
  begin
    Application.MessageBox('Código do Grupo Inválido'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    MskOpCodigoGrupo.Clear;
    MskOpCodigo.SetFocus;
    Exit;
  end;

  {Valida Usuario}
  if (Trim(TxtOpUsuario.Text) = '') then
  begin
    Application.MessageBox('Úsuario inválido, Verifique!'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    TxtOpUsuario.Clear;
    TxtOpUsuario.SetFocus;
    Exit;
  end;

  {Valida Codigo do Senha}
  if (Trim(MskSenha.Text) = '') then
  begin
    Application.MessageBox('Senha inválida, Verifique!'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    MskSenha.Clear;
    MskSenha.SetFocus;
    MskSenha.SelectAll;
    Exit;
  end;
  if (Trim(MskSenha.Text) <> Trim(MskSenha2.Text)) then
  begin
    Application.MessageBox('O Campo senha deve ser igual ao campo ' +
                           'confirmação de senha, Verifique!'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    MskSenha.Clear;
    MskSenha.SetFocus;
    MskSenha.SelectAll;
    Exit;
  end;
  if Trim(MskSenha.Text) = '' then
  begin
    Application.MessageBox('O campo senha não pode ficar em branco!'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    MskSenha.Clear;
    MskSenha.SetFocus;
    MskSenha.SelectAll;
    Exit;
  end;
  Result := True;
end;





{------------------------------------------------------------------------------|
|                                       Eventos                                |
|------------------------------------------------------------------------------}

procedure TfMain.actFecharExecute(Sender: TObject);
begin
  Close;
end;

procedure TfMain.FormActivate(Sender: TObject);
begin
  {Define o diretório do aplicativo}
  Patch := Extractfilepath(Application.ExeName) + 'dados\';
  {Conecta Banco de Dados}
  ConectaDataBase;
  {Visualização}
  SetForegroundWindow(Application.Handle);
end;

procedure TfMain.GrdOperadoresDblClick(Sender: TObject);
begin
  {Coleta dados na Tabela UsuarioSistema}
  ColetaDados(1);
end;

procedure TfMain.actGravarOpExecute(Sender: TObject);
begin
  if not ValidaOperadores then Exit;
  if (Application.MessageBox('Deseja Gravar?', 'Autocom PLUS', MB_YESNO +
    MB_ICONQUESTION)) = IDYES then
  begin
    if B_NewOperadorador then SQLOperadores(1) else SQLOperadores(2);
  end;
end;
procedure TfMain.actOpNovoExecute(Sender: TObject);
begin
  {Gera Código do Novo Operador}
  B_NewOperadorador := True;
  EditClear;
  Editando(1);
end;

procedure TfMain.aOpGruposExecute(Sender: TObject);
begin
 Dm.Tbl_GrupoUsuarioSistema.Open;
  Application.CreateForm(TfConsulta, FConsulta);
  FConsulta.ShowModal;
  FConsulta.Destroy;
  MskOpCodigoGrupo.Text := IntToStr(I_Grupo);
  LblGrupoNome.Caption := S_Grupo;
  TxtOpUsuario.SetFocus;
end;

procedure TfMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then Perform(WM_NEXTDLGCTL,0,0);
end;

procedure TfMain.MskOpCodigoGrupoEnter(Sender: TObject);
begin
  JvBalloonHint.ActivateHint(MskOpCodigo, MskOpCodigo.Hint);
end;

procedure TfMain.MskOpCodigoGrupoExit(Sender: TObject);
begin
  {Insere nome no Lbl}
  if Trim(MskOpCodigoGrupo.Text) <> '' then
  begin
    SqlRun(' SELECT NOMEGRUPO FROM GRUPOUSUARIOSISTEMA ' +
           ' WHERE IDGRUPOUSUARIO = ' +
            MskOpCodigoGrupo.Text
            , Dm.Rede);
    if not Dm.Rede.IsEmpty then
      LblGrupoNome.Caption := Dm.Rede.Fields[0].AsString
    else
    begin
      Application.MessageBox('Código Inválido, Verifique!'
                             ,'Autocom PLUS',
                             MB_ICONEXCLAMATION);
      LblGrupoNome.Caption := 'Código Inválido';
      MskOpCodigoGrupo.SelectAll;
      MskOpCodigoGrupo.SetFocus;
    end;
  end;
end;

procedure TfMain.MskOpCodigoGrupoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F1 then CmdOpGrupo.Click;
end;

procedure TfMain.MskCAGrupoExit(Sender: TObject);
begin
  JvBalloonHint.CancelHint;
  {Insere nome no Lbl}
  if Trim(MskCAGrupo.Text) <> '' then
  begin
    SqlRun(' SELECT NOMEGRUPO FROM GRUPOUSUARIOSISTEMA ' +
           ' WHERE IDGRUPOUSUARIO = ' +
            MskCAGrupo.Text
            , Dm.Rede);
    if not Dm.Rede.IsEmpty then
    begin
      I_Grupo := StrToInt(MskCAGrupo.Text);
      LblCAGrupoNome.Enabled := True;
      LblCAGrupoNome.Caption := Dm.Rede.Fields[0].AsString;
      Editando(2);
    end
      else
    begin
      LblCAGrupoNome.Enabled := False;
      LblCAGrupoNome.Caption := 'Código Inválido';
      MskCAGrupo.Clear;
      MskCAGrupo.SetFocus;
      MskCAGrupo.SelectAll;
    end;
  end;
end;

procedure TfMain.actCancelarCaExecute(Sender: TObject);
begin
    Dm.Transaction.RollbackRetaining;
    Editando(2,False);
end;

procedure TfMain.TrtsMainChanging(Sender: TObject;
  var AllowChange: Boolean);
begin
{  Se a Tabela de Permissao estiver Aberta ou se o Painel de                   |
|  Edicao de Operadores estiver Visivel                                        }
  if (PanOperadores.Visible = True) or (Dm.Tbl_PermissaoSistema.Active) then
  begin
    AllowChange := False;
  end;
end;


procedure TfMain.actGravaCaExecute(Sender: TObject);
begin
  Dm.Transaction.CommitRetaining;
  Editando(2,False);
  MskCAGrupo.SetFocus;
end;

procedure TfMain.GrdPermissaoDblClick(Sender: TObject);
var
  S_Inserir : string;
  Book: TBookmarkStr;
begin
    Book := Dm.Tbl_PermissaoSistema.Bookmark;
    if Dm.Tbl_PermissaoSistemaINSERIR.Value = 'T' then
      S_Inserir := 'F'
    else
      S_Inserir := 'T';
    {Grava na Tabela}
    SqlRun('UPDATE GRUPOUSUARIO_PERMISSAO SET ' +
            ' INSERIR = ' + QuotedStr(S_Inserir) + ', ' +
            ' ALTERAR = ' + QuotedStr(S_Inserir) + ', ' +
            ' EXCLUIR = ' + QuotedStr(S_Inserir) +
            ' WHERE IDPERMISSAOSISTEMA = ' +
            Dm.Tbl_PermissaoSistemaIDPERMISSAOSISTEMA.AsString +
            ' AND IDGRUPOUSUARIO = ' +
            Dm.Tbl_PermissaoSistemaIDGRUPOUSUARIO.AsString +
            ';', Dm.Rede, False);
    Dm.Tbl_PermissaoSistema.Close;
    Dm.Tbl_PermissaoSistema.Open;
    Dm.Tbl_PermissaoSistema.Bookmark := Book;
end;                           

function TfMain.Enche(texto, caracter: string; lado,
  tamanho: integer): string;
begin
  while length(texto)<tamanho do
  begin // lado=1, caracteres a esquerda  -  lado=2, caracteres a direita
    if lado = 1 then
      texto := caracter + texto
      else texto := texto + caracter; end;
    Result := Texto;
end;

procedure TfMain.TxtCodKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F12 then CmdProcurarClick(Self);
  if Key = VK_Return then
  begin
    if IsFloat(TxtCod.Text) then
    begin
      SqlRun('SELECT * FROM USUARIOSISTEMA WHERE IDUSUARIO = ' + TxtCod.Text
             , Dm.Tbl_UsuarioSistema);
      TxtCod.Clear;
      if not Dm.Tbl_UsuarioSistema.IsEmpty then
        GrdOperadoresDblClick(Self)
      else
      begin
        SqlRun('SELECT * FROM USUARIOSISTEMA', Dm.Tbl_UsuarioSistema);
        if Application.MessageBox('Usuário Inexistente, deseja cadastrar um ' +
                                  'novo usuário?','Autocom PLUS'
                                  , MB_YESNO + MB_ICONQUESTION) = id_yes then
          CmdNovoCadastroClick(Self)
        else
          TxtCod.Clear;
          TxtCod.SetFocus;
      end;
    end
      else
    begin
      TxtCod.Clear;
      TxtCod.SetFocus;
    end;
  end;
end;

procedure TfMain.CmbStatusKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then CmbOpGravarClick(Self);
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dm.DBAutocom.Close;
end;

procedure TfMain.GrdOperadoresKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then GrdOperadoresDblClick(Self);
end;



procedure TfMain.GrdPermissaoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_SPACE then GrdPermissaoDblClick(Self);
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  TrtsMain.TabIndex := 0;
  TxtCod.SetFocus;
  Editando(1, False);
end;

procedure TfMain.CmbFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfMain.CmbOpApagarClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja Excluir?', 'Autocom PLUS', MB_YESNO +
    MB_ICONQUESTION)) = IDYES then
  begin
    SQLOperadores(3);
  end;
end;

procedure TfMain.CmbOpGravarClick(Sender: TObject);
begin
  if not ValidaOperadores then Exit;
  if (Application.MessageBox('Deseja Gravar?', 'Autocom PLUS', MB_YESNO +
    MB_ICONQUESTION)) = IDYES then
  begin
    if B_NewOperadorador then SQLOperadores(1) else SQLOperadores(2);
  end;
end;

procedure TfMain.CmbOpCancelarClick(Sender: TObject);
begin
  if TrtsMain.TabIndex = 0 then
  begin
    Editando(1, False);
    SqlRun(' SELECT * FROM USUARIOSISTEMA ', Dm.Tbl_UsuarioSistema);
  end;
end;

procedure TfMain.CmdNovoCadastroClick(Sender: TObject);
begin
  {Gera Código do Novo Operador}
  B_NewOperadorador := True;
  EditClear;
  Editando(1);
end;

procedure TfMain.CmdOpGrupoClick(Sender: TObject);
begin
  Dm.Tbl_GrupoUsuarioSistema.Open;
  Application.CreateForm(TFConsulta, FConsulta);
  FConsulta.ShowModal;
  FConsulta.Destroy;
  MskOpCodigoGrupo.Text := IntToStr(I_Grupo);
  LblGrupoNome.Caption := S_Grupo;
  TxtOpUsuario.SetFocus;
end;

procedure TfMain.CmdProcurarClick(Sender: TObject);
begin
{Pesquisa na Tabela de Operadores}
    if IsFloat(TxtCod.Text) then
    begin
      {Em caso de valor é Númerico}
      SqlRun(' SELECT * FROM USUARIOSISTEMA WHERE IDUSUARIO = ' + TxtCod.Text
             , Dm.Tbl_UsuarioSistema);
    end
      else
    begin
      {Em caso de valor é Alpha}
      SqlRun(' SELECT * FROM USUARIOSISTEMA WHERE NOMEUSUARIO LIKE ' +
             QuotedStr('%' + TxtCod.Text + '%')
             , Dm.Tbl_UsuarioSistema);
    end;
    if Dm.Tbl_UsuarioSistema.IsEmpty then
    begin
      Application.MessageBox('Nada Encontrado!','Autocom PLUS'
                             ,MB_ICONEXCLAMATION);
      SqlRun(' SELECT * FROM USUARIOSISTEMA ', Dm.Tbl_UsuarioSistema);
    end;

end;

procedure TfMain.CmdCaGravarClick(Sender: TObject);
begin
  if (Application.MessageBox('Deseja Gravar?', 'Autocom PLUS', MB_YESNO +
    MB_ICONQUESTION)) = IDYES then
  begin
    Dm.Transaction.CommitRetaining;
    Editando(2,False);
    MskCAGrupo.SetFocus;
  end;
end;

procedure TfMain.CmdCaCancelarClick(Sender: TObject);
begin
  Dm.Transaction.RollbackRetaining;
  Editando(2,False);
end;

procedure TfMain.CmdCAGrupoClick(Sender: TObject);
begin
  {Limpa Variaveis}
  ZeroMemory(@S_Grupo,SizeOf(S_Grupo));
  ZeroMemory(@I_Grupo,SizeOf(I_Grupo));
  {Abre Tabela}
  Dm.Tbl_GrupoUsuarioSistema.Open;
  {Cria e Destroi Form}
  Application.CreateForm(TFConsulta, FConsulta);
  FConsulta.ShowModal;
  FConsulta.Destroy;
  {Atribui Valores}
  if I_Grupo = 0 then Exit;
  if not (VarIsNull(I_Grupo)) then
  begin
    MskCAGrupo.Text := IntToStr(I_Grupo);
    LblCAGrupoNome.Enabled := True;
    LblCAGrupoNome.Caption := S_Grupo;
    Editando(2);
  end; 
end;

procedure TfMain.MskCAGrupoEnter(Sender: TObject);
begin
  JvBalloonHint.ActivateHint(MskCAGrupo,MskCAGrupo.Hint);
end;

end.
