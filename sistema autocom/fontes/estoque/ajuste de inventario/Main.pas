unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ComCtrls, StrUtils, IniFiles, IBQuery;

type
  TFrmMain = class(TForm)
    cmdgravar: TBitBtn;
    cmdfechar: TBitBtn;
    LblCodProduto: TLabel;
    MskCodProduto: TMaskEdit;
    CmdProduto: TSpeedButton;
    LblNomeProduto: TLabel;
    Label3: TLabel;
    Label1: TLabel;
    MskEstoqueAtual: TMaskEdit;
    LblEstMin: TLabel;
    MskEstMin: TMaskEdit;
    LblEstMax: TLabel;
    MskEstMax: TMaskEdit;
    lbl_consulta: TLabel;
    procedure cmdfecharClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure CmdProdutoClick(Sender: TObject);
    procedure MskEstoqueAtualExit(Sender: TObject);
    procedure cmdgravarClick(Sender: TObject);
    procedure Rede(S_SQL: String; Tabela: TIBQuery; B_Open: Boolean = True);
    procedure MskCodProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MskCodProdutoEnter(Sender: TObject);
    procedure MskCodProdutoExit(Sender: TObject);
    procedure MskEstoqueAtualKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    procedure Editando(B_Status: Boolean);
    procedure ConectaDB;
    procedure LimpaCampos;
    function AllTrim(s_String: String): String;
    function FormataNumero(s_String: String;
      i_CasasInteiras: Integer = 0;  i_CasasDecimais: Integer = 0): String;
    procedure FormataMedidas(Msk: TMaskEdit);
    function FormataValores(S_Numero: String; I_ChrAntes, I_ChrDepois: Integer): String;
    function FormataPonto(S_Texto: String; I_Tipo: Integer): String;
    function TrocaTexto(s_String, s_Find, s_Replace: String): String;
  end;

var
  FrmMain: TFrmMain;
  Path: String;
  I_CodigoEstoque: Integer;
  S_EstoqueAntigo: String;

implementation

uses Module, Produto;

{$R *.dfm}

function TFrmMain.AllTrim(s_String: String): String;
begin
  while Pos(' ', s_String) > 0 do
    Delete(s_String, Pos(' ', s_String), 1);

  while Pos('', s_String) > 0 do
    Delete(s_String, Pos('', s_String), 1);

  Result := s_String;
end;

procedure TFrmMain.Editando(B_Status: Boolean);
begin
  // Entra modo de Edicao
  if b_Status then  begin
    cmdgravar.enabled := true;
    cmdfechar.Kind := bkCancel;
    cmdfechar.Kind := bkCustom;
    cmdfechar.Caption := '&Cancelar';
    MskCodProduto.ReadOnly :=True;
    MskCodProduto.Color := clSkyBlue;
    CmdProduto.Enabled := False;
  end else begin
  // Sai do modo de Edicao
    LimpaCampos;
    cmdgravar.enabled := False;
    cmdfechar.Kind := bkClose;
    cmdfechar.Caption := '&Fechar';
    MskCodProduto.ReadOnly := False;
    MskCodProduto.Color := clWhite;
    CmdProduto.Enabled := True;
  end;
end;

function TFrmMain.FormataNumero(s_String: String; i_CasasInteiras,
  i_CasasDecimais: Integer): String;
var s_BeforeComma: String;
    s_AfterComma: String;
begin
    s_String := AllTrim(s_String);

    if Pos(',', s_String) > 0 then
    begin
        s_BeforeComma := LeftStr(s_String, Pos(',', s_String) - 1);
        s_AfterComma := RightStr(s_String, Length(s_String) - Pos(',', s_String));
    end
    else
    begin
        s_BeforeComma := s_String;
        s_AfterComma := '';
    end;

    while (Length(s_BeforeComma)) < i_CasasInteiras do
        s_BeforeComma := '0' + s_BeforeComma;

    while (Length(s_AfterComma)) < i_CasasDecimais do
        s_AfterComma := s_AfterComma + '0';

    if i_CasasDecimais > 0 then
        s_String := s_BeforeComma + ',' + s_AfterComma
    else
        s_String := s_BeforeComma;

    Result := s_String;
end;

procedure TFrmMain.cmdfecharClick(Sender: TObject);
begin
  if cmdfechar.Kind = bkClose then
  begin
    Close;
  end else
    Editando(False);
    MskCodProduto.SetFocus;
    MskCodProduto.SelectAll;
end;

procedure TFrmMain.ConectaDB;
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
begin
  //Define Pasta
  Path := Extractfilepath(application.exename)+'dados\';
  //Conecta
  ConectaDB;
  Editando(False);
  SetForegroundWindow(Application.Handle);
  MskCodProduto.SetFocus;
  MskCodProduto.SelectAll;
end;

procedure TFrmMain.CmdProdutoClick(Sender: TObject);
begin

  //Seleciona Todos os Itens da Tabela de Produtos
  Dm.Tbl_Produto.Close;
  Dm.Tbl_Produto.SQL.Clear;
  Dm.Tbl_Produto.SQL.Add('Select * from Produto P ' +
                         'inner Join Estoque E on ' +
                         '(P.CodigoProduto = E.CodigoProduto) ' +
                         'order by P.NomeProduto');
  Dm.Tbl_Produto.Prepare;
  Dm.Tbl_Produto.Open;

  //Abre Formulario
  Application.CreateForm(TFrmProduto, FrmProduto);
  FrmProduto.ShowModal;
  FrmProduto.Destroy;
  //Formatacao
  FormataMedidas(MskEstoqueAtual);
  MskEstoqueAtual.EditMask := '99999,999;1; ';
  S_EstoqueAntigo := MskEstoqueAtual.Text;
  FormataMedidas(MskEstMax);
  FormataMedidas(MskEstMin);
  FormataMedidas(MskEstoqueAtual);
  MskCodProduto.Text := FormataNumero(AllTrim(MskCodProduto.Text), 13);
end;

procedure TFrmMain.LimpaCampos;
begin
  MskCodProduto.Clear;
  MskEstoqueAtual.Clear;
  MskEstMin.Clear;
  MskEstMax.Clear;
  LblNomeProduto.Caption := '';
end;

procedure TFrmMain.FormataMedidas(Msk: TMaskEdit);
var
  S_Valor, S_Numero : String;
  I_Antes, I_Depois : Integer;
begin
    Msk.EditMask := '99999,999;1; ';
    S_Numero := Msk.Text;
    Msk.EditMask := '99999,999;0; ';
    Msk.Text := FormataValores(S_Numero,5,3);
    I_Antes := 5;
    I_Depois := 3;

  If StrToFloat(FormataPonto(Msk.text,I_Depois)) = 0 then
  Msk.text := FormataValores(S_Valor,I_Antes,I_Depois);
end;

function TFrmMain.FormataPonto(S_Texto: String; I_Tipo: Integer): String;
Var
  I_Ponto: Integer;
Begin
  try
    if I_Tipo = 2 then S_Texto := FloatToStr(StrToFloat(S_Texto)/100);
    if I_Tipo = 3 then S_Texto := FloatToStr(StrToFloat(S_Texto)/1000);
  except
    S_Texto:='0';
  end;

  I_Ponto := Pos('.',S_Texto);
  if I_Ponto>0 then begin
    delete(S_Texto,I_Ponto,1);
    insert(',',S_Texto,I_Ponto);
  end;
    Result := S_Texto;
end;

function TFrmMain.FormataValores(S_Numero: String; I_ChrAntes,
  I_ChrDepois: Integer): String;
Var
  I_Virgula: Integer;
  S_Antes, S_Depois, s_Temp: String;
Begin
  I_Virgula := Pos(',', S_Numero);
  If I_Virgula > 0 then begin
    S_Antes := AllTrim(copy(S_Numero,1,I_Virgula-1));
    S_Depois := AllTrim(copy(S_Numero,I_Virgula+1,I_ChrDepois));
  End Else Begin
    S_Antes := AllTrim(S_Numero);
    S_Depois := '';
  End;
  While length(S_Depois) < I_ChrDepois do
    S_Depois := S_Depois + '0';
   s_Temp := '0';
   While (length(S_Antes) > 1) and (s_Temp = '0') do begin
     s_Temp := copy(S_Antes,1,1);
     If s_Temp = '0' then delete(S_Antes,1,1);
   End;
   If length(S_Antes) = 0 then S_Antes := '0';
   S_Numero := S_Antes + S_Depois;
   While length(S_Numero) < (I_ChrAntes + I_ChrDepois) do S_Numero := ' ' + S_Numero;
   Result := S_Numero;
end;

procedure TFrmMain.MskEstoqueAtualExit(Sender: TObject);
begin
  FormataMedidas(MskEstoqueAtual);
end;

procedure TFrmMain.cmdgravarClick(Sender: TObject);
begin

  MskEstoqueAtual.EditMask := '99999,999;1; ';

  if AllTrim(S_EstoqueAntigo) = AllTrim(MskEstoqueAtual.Text) then
  begin
    Editando(False);
    MskCodProduto.SetFocus;
    exit;
  end;

  if MessageDlg('Confirma a Altera??o do Estoque Atual de ' +
                AllTrim(S_EstoqueAntigo) +
                ' para ' +
                AllTrim(MskEstoqueAtual.Text) +
                '?', mtConfirmation, [mbYes, mbNo],0) = MrYes then
  begin
    Rede('Update Estoque Set ' +
         'ESTOQUEATUAL = ' + TrocaTexto(MskEstoqueAtual.Text,',','.') +
         ' Where CodigoEstoque = ' + IntToStr(I_CodigoEstoque), Dm.Rede, True);
    Dm.Transaction.CommitRetaining;
    Editando(False);
    MskCodProduto.SetFocus;
  end;
end;

procedure TFrmMain.Rede(S_SQL: String; Tabela: TIBQuery; B_Open: Boolean);
begin
  Tabela.Close;
  Tabela.SQL.Clear;
  Tabela.SQL.Add(S_SQL);
  Tabela.Prepare;
  if B_Open
  then Tabela.Open
  else Tabela.ExecSQL;
end;

function TFrmMain.TrocaTexto(s_String, s_Find, s_Replace: String): String;
var i_Count: Integer;
    s_Aux, s_Left, s_Right: String;
begin
  i_Count := 0;
  while i_Count < Length(s_String) do begin
    s_Aux := MidStr(s_String, i_Count, Length(s_Find));
    if s_Find = s_Aux then begin
      s_Left := LeftStr(s_String, Pos(s_Find, s_String) - 1);
      s_Right := RightStr(s_String, Length(s_String) - Pos(s_Find, s_String));
      s_String :=  s_Left + s_Replace + s_Right;
      i_Count := i_Count + Length(s_Replace);
    end else
      i_Count := i_Count + Length(s_Find);
    end;
    Result := s_String;
end;

procedure TFrmMain.MskCodProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
  begin
  if (Key = VK_F1) and (MskCodProduto.ReadOnly = False) then CmdProdutoClick(Self);
  if Key = VK_Return then
  begin
   if MskCodProduto.Text <> '' then
     Perform(WM_NEXTDLGCTL,0,0)
   else
     CmdProdutoClick(Self);
  end;
end;

procedure TFrmMain.MskCodProdutoEnter(Sender: TObject);
begin
  MskCodProduto.SelectAll;
  if MskCodProduto.ReadOnly = False then lbl_consulta.Visible := True;
end;

procedure TFrmMain.MskCodProdutoExit(Sender: TObject);
begin
  lbl_consulta.Visible := False;
  if (MskCodProduto.ReadOnly = False) and (MskCodProduto.Text <> '')
    and (StrToInt(MskCodProduto.Text) <> 0) then
  begin
    Rede('SELECT * FROM PRODUTOASSOCIADO WHERE ' +
           'CODIGOPRODUTOASSOCIADO = ' + Trim(MskCodProduto.text),Dm.Rede);
    if Dm.Rede.IsEmpty then
    begin
      Rede('Select * from Produto P ' +
             'inner Join Estoque E on ' +
             '(P.CodigoProduto = E.CodigoProduto) ' +
             'Where P.CodigoProduto = ' + Trim(MskCodProduto.text) +
             ' order by P.CodigoProduto',Dm.Tbl_Produto);
    end else begin
      Rede('Select * from Produto P ' +
             'inner Join Estoque E on ' +
             '(P.CodigoProduto = E.CodigoProduto) ' +
             'Where P.CodigoProduto = ' +
             Dm.Rede.FieldByName('CODIGOPRODUTO').AsString +
             ' order by P.CodigoProduto',Dm.Tbl_Produto);
    end;
    if not Dm.Tbl_Produto.IsEmpty then
    begin
      Editando(True);
      //Resgata Dados
      MskCodProduto.Text := Dm.Tbl_ProdutoCODIGOPRODUTO.AsString;
      LblNomeProduto.Caption := Dm.Tbl_ProdutoNOMEPRODUTO.AsString;
      I_CodigoEstoque := Dm.Tbl_ProdutoCODIGOESTOQUE.AsInteger;
      MskEstoqueAtual.Text := Dm.Tbl_ProdutoESTOQUEATUAL.AsString;
      MskEstMin.Text := Dm.Tbl_ProdutoESTOQUEMINIMO.AsString;
      MskEstMax.Text := Dm.Tbl_ProdutoESTOQUEMAXIMO.AsString;
      //Formatacao
      FormataMedidas(MskEstoqueAtual);
      MskEstoqueAtual.EditMask := '99999,999;1; ';
      S_EstoqueAntigo := MskEstoqueAtual.Text;
      FormataMedidas(MskEstMax);
      FormataMedidas(MskEstMin);
      FormataMedidas(MskEstoqueAtual);
      MskCodProduto.Text := FormataNumero(AllTrim(MskCodProduto.Text), 13);
    end else
    begin
      MessageDlg('C?digo Inv?lido!',mtWarning,[mbOk],0);
      MskCodProduto.Clear;
      MskCodProduto.SetFocus;
      MskCodProduto.SelectAll;
    end;
  end;
end;

procedure TFrmMain.MskEstoqueAtualKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  //N?o Modificar Usado por V?rios Objetos
  if Key = VK_Return then Perform(WM_NEXTDLGCTL,0,0)
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dm.dbautocom.Close;
end;

end.
