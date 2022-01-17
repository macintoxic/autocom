unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, XPMenu, StdCtrls, StrUtils, Mask, Buttons, ExtCtrls, IBQuery,
  IBDatabase, DB, IBCustomDataSet, Inifiles, SUIButton, SUIListBox, SUIForm,
  SUIMgr, SuiThemes;

type
  TFrmMain = class(TForm)
    PanTop: TPanel;
    MskQuantidade: TMaskEdit;
    LblQuantidade: TLabel;
    LblCod: TLabel;
    MskCodProduto: TMaskEdit;
    Rede: TIBQuery;
    DBAutocom: TIBDatabase;
    Transaction: TIBTransaction;
    Tbl_Produto: TIBQuery;
    LblObs: TLabel;
    MskObs: TMaskEdit;
    Label1: TLabel;
    MskTabelaPreco: TMaskEdit;
    CmdPreco: TSpeedButton;
    CmdProduto: TSpeedButton;
    LblPreco: TLabel;
    Tbl_ProdutoC: TIBQuery;
    Tbl_ProdutoCCODIGOPRODUTO: TIntegerField;
    Tbl_ProdutoCNOMEPRODUTO: TIBStringField;
    Tbl_Preco: TIBQuery;
    Tbl_PrecoCODIGOPRODUTOTABELAPRECO: TIntegerField;
    Tbl_PrecoCODIGOPRODUTO: TIntegerField;
    Tbl_PrecoPRECO: TFloatField;
    Tbl_PrecoCODIGOTABELAPRECO: TIntegerField;
    Tbl_PrecoCODIGOTABELAPRECO1: TIntegerField;
    Tbl_PrecoCODIGOTABELA: TIntegerField;
    Tbl_PrecoTABELAPRECO: TIBStringField;
    Tbl_PrecoDATA: TDateTimeField;
    Tbl_PrecoCFG_CODCONFIG: TIntegerField;
    PanDesc: TPanel;
    LblDescProduto: TLabel;
    Label2: TLabel;
    edlote: TMaskEdit;
    suiForm1: TsuiForm;
    ListKinds: TsuiListBox;
    CmdConfig: TsuiButton;
    CmdPrint: TsuiButton;
    Skin: TsuiThemeManager;
    suiButton1: TsuiButton;
    procedure MskCodProdutoExit(Sender: TObject);
    procedure MskCodProdutoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CmdConfigClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure MskCodProdutoClick(Sender: TObject);
    procedure MskQuantidadeClick(Sender: TObject);
    procedure CmdPrintClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CmdProdutoClick(Sender: TObject);
    procedure CmdPrecoClick(Sender: TObject);
    procedure MskTabelaPrecoClick(Sender: TObject);
    procedure MskTabelaPrecoExit(Sender: TObject);
    procedure MskTabelaPrecoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MskCodProdutoEnter(Sender: TObject);
    procedure suiButton1Click(Sender: TObject);
    procedure edloteClick(Sender: TObject);
  private
    procedure Etiqueta1;
    procedure Etiqueta2;
    procedure Etiqueta3;
  public
    function AllTrim(s_String: String): String;
    procedure SqlRun (SQL: String; Table: TIBQuery; OpenTable: Boolean = True);
    procedure ConectaDB;
    function FormataNumero(s_String: String;
      i_CasasInteiras: Integer = 0;  i_CasasDecimais: Integer = 0): String;
    function Imprime: Boolean;
    function EAN13DV(Codigo: String): Boolean;
  end;

var
  FrmMain: TFrmMain;
  Path: String;
  S_Impressora: String;
  S_Porta: String;
  max: integer;
  SOH, STX, ACK, LF, CR, XON, XOFF, NAK, ESC: String;
  aF : TextFile;
  a,b,c,d,e,f,g,h:string;
  z : integer;
  prod1,prod2,cod,valor,obs:string;
  codean: boolean;


implementation

uses config, produto, preco;

{$R *.dfm}

{ TFrmMain }

function TFrmMain.AllTrim(s_String: String): String;
begin
  while Pos(' ', s_String) > 0 do
    Delete(s_String, Pos(' ', s_String), 1);

  while Pos('', s_String) > 0 do
    Delete(s_String, Pos('', s_String), 1);

  Result := s_String;
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

procedure TFrmMain.MskCodProdutoExit(Sender: TObject);
var ini:Tinifile;
begin
  if Trim(MskCodProduto.Text) = '' then MskCodProduto.Text := '0';
  if StrToFloat(MskCodProduto.Text) = 0 then
  begin
    LblDescProduto.Caption := '';
    exit;
  end;

  if StrToFloat(MskCodProduto.Text) <> 0  then
  begin
    SqlRun('SELECT * FROM PRODUTOASSOCIADO WHERE ' +
           'CODIGOPRODUTOASSOCIADO = ' + Trim(MskCodProduto.text),Rede);
    if Rede.IsEmpty then
    begin
      SqlRun('SELECT * FROM PRODUTO WHERE CODIGOPRODUTO = ' +
             Trim(MskCodProduto.text),tbl_produto)
    end else
    begin
      SqlRun('SELECT * FROM PRODUTO WHERE CODIGOPRODUTO = ' +
              Rede.FieldByName('CODIGOPRODUTO').AsString,tbl_produto)
    end;
  end;
  if tbl_produto.IsEmpty then
  begin
    Application.MessageBox('Código Inválido, Verifique!', 'Autocom PLUS');
    MskCodProduto.SetFocus;
    MskCodProduto.Clear;
    MskCodProduto.SelectAll;
  end else
  begin
    if tbl_produto.FieldByName('USUAL').AsString='1' then
       begin
          Label2.Visible:=true;
          Edlote.Visible:=True;
          Ini:=Tinifile.create(path+'autocom.ini');
          Label2.caption:=ini.readstring('ESTOQUE','NomeTipoLote','');
          if Label2.caption='' then ini.writestring('ESTOQUE','NomeTipoLote','Lote');
          ini.free;
       end;
    MskCodProduto.Text := tbl_produto.FieldByName('CODIGOPRODUTO').AsString;
    LblDescProduto.Caption := tbl_produto.FieldByName('NOMEPRODUTO').AsString;
    MskCodProduto.Text := FormataNumero(AllTrim(MskCodProduto.Text), 13);
    Cod := MskCodProduto.Text;
    Prod1 := Trim(tbl_produto.FieldByName('NOMEPRODUTO').AsString);
    Prod2:='';
    //Divide Nome do Produto em Duas Variaveis
    if length(prod1)>31 then
    begin
      Prod2 := Copy(Prod1,32,32);
      Prod1 := Copy(Prod1,1,31);
    end;
    codean := EAN13DV(cod);

    //Filtra tabela de Preços
    Tbl_Preco.Close;
    Tbl_Preco.Params[0].Value := MskCodProduto.Text;
    Tbl_Preco.Open;
  end;
end;

procedure TFrmMain.MskCodProdutoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_Return then Perform(WM_NEXTDLGCTL,0,0);
  if Key = Vk_F1 then CmdProdutoClick(Self);  
end;

procedure TFrmMain.CmdConfigClick(Sender: TObject);
begin
  Application.CreateForm(TFrmConfig, FrmConfig);
  FrmConfig.ShowModal;
  FrmConfig.Destroy;
end;

procedure TFrmMain.SqlRun(SQL: String; Table: TIBQuery; OpenTable: Boolean);
begin
  Table.Close;
  Table.SQL.Clear;
  Table.SQL.Add(SQL);
  Table.Prepare;
  if OpenTable then Table.Open else Table.ExecSQL;
end;

procedure TFrmMain.FormActivate(Sender: TObject);
var tipo_skin:string;
begin
  ini:=Tinifile.create(extractfilepath(application.exename)+'dados\autocom.ini');
  tipo_skin:=ini.readstring('ATCPLUS', 'skin','0');
  ini.free;
  if (tipo_skin='0') or (tipo_skin='') then skin.uistyle:=WinXP;
  if (tipo_skin='1') then skin.uistyle:=BlueGlass;
  if (tipo_skin='2') then skin.uistyle:=DeepBlue;
  if (tipo_skin='3') then skin.uistyle:=MacOS;
  if (tipo_skin='4') then skin.uistyle:=Protein;
  application.processmessages;


  Path := Extractfilepath(Application.ExeName) + 'dados\';

  //Conecta Banco de Dados
  ConectaDB;
  SetForegroundWindow(Application.Handle);

  //Resgata Tipo da Impressora do Ini
  Ini := Tinifile.Create(ExtractFilePath(Application.ExeName)+'dados\autocom.ini');
  S_Impressora := Copy(Ini.ReadString('CODEBAR','PRINTER','01'),1,2);
  S_Porta := Ini.ReadString('CODEBAR','PORTA','COM1');
  Ini.Free;

  SOH := chr(1);
  STX := chr(2);
  ACK := chr(6);
  LF := chr(10);
  CR := chr(13);
  XON := chr(17);
  XOFF := chr(19);
  NAK := chr(21);
  ESC := chr(27);
end;

procedure TFrmMain.ConectaDB;
var
  Ini: Tinifile;
  T1, T2: String;
begin
   //Abre componentes basicos de banco de dados
   Transaction.Active := False;
   DBAutocom.Connected := False;
   ini := TIniFile.Create(Path + 'Autocom.ini');
   T1 := Ini.Readstring('ATCPLUS','IP_SERVER','');
   T2 := Ini.Readstring('ATCPLUS','PATH_DB','');
   Ini.Free;

   dbautocom.DatabaseName := T1 + ':' + T2;
   //Conecta Banco de Dados
   DBAutocom.connected:=true;
   Transaction.active:=true;
end;

procedure TFrmMain.MskCodProdutoClick(Sender: TObject);
begin
  MskCodProduto.SelectAll;
end;

procedure TFrmMain.MskQuantidadeClick(Sender: TObject);
begin
  MskQuantidade.SelectAll;
end;

procedure TFrmMain.CmdPrintClick(Sender: TObject);
begin
  //Validação
  if (Trim(MskCodProduto.Text) = '') or (StrToFloat(MskCodProduto.Text) = 0) then
  begin
    Application.MessageBox('Por favor, digite um código válido!','Erro de Validação');
    MskCodProduto.SetFocus;
    MskCodProduto.SelectAll;
    exit;
  end;

  if (Trim(MskQuantidade.Text) = '') or (StrToFloat(MskQuantidade.Text) = 0) then
  begin
    Application.MessageBox('Por favor, digite uma quantidade válida!','Erro de Validação');
    MskQuantidade.SetFocus;
    MskQuantidade.SelectAll;
    exit;
  end;

  //Verifica se Nada Foi Selecionado na Lista de Etiquetas
  if not ListKinds.Selected[0] then
  begin
    if not ListKinds.Selected[1] then
    begin
      if not ListKinds.Selected[2] then
      begin
        Application.MessageBox('Por Favor, Selecione um item na Lista de Etiquetas','Erro de Validação');
        ListKinds.SetFocus;
        exit;
      end;
    end;
  end;

  max := StrToInt(MskQuantidade.Text);
  //Chama Funcao de Impressao
  if Copy(ListKinds.Items[ListKinds.ItemIndex],1,2) = '01' then Etiqueta1;
  if Copy(ListKinds.Items[ListKinds.ItemIndex],1,2) = '02' then Etiqueta2;
  if Copy(ListKinds.Items[ListKinds.ItemIndex],1,2) = '03' then Etiqueta3;
end;

procedure TFrmMain.Etiqueta1;
begin
  if S_Impressora='01' then
  begin
    for z := 1 to max do
    begin
      a:='N'+chr(13)+chr(10);
      b:='R0,0'+chr(13)+chr(10);
      c:='A150,10,0,4,1,1,N,"'+Prod1+'"'+chr(13)+chr(10);
      d:='A150,50,0,4,1,1,N,"'+Prod2+'"'+chr(13)+chr(10);
      if codean=true then
      begin
        e:='B150,110,0,E30,2,1,80,B,"'+cod+'"'+chr(13)+chr(10);
      end
        else
      begin
        e:='B170,160,0,1,2,1,40,B,"'+cod+'"'+chr(13)+chr(10);
      end;
        f:='A370,110,0,4,2,2,N,"'+valor+'"'+chr(13)+chr(10);
        g:='P1'+chr(13)+chr(10);
        if imprime=false then exit;
    end;
  end;

  if S_Impressora='02' then
  begin
    for z:=1 to max do
    begin
      a:='130000001100000'+Prod1+CR;
      b:='130004000900000'+Prod2+CR;
      if codean=true then
      begin
        c:='1E0004000800160C'+cod+CR;
      end
        else
      begin
        c:='1F000500180016'+cod+CR;
      end;
      b:='130004000900000'+valor+CR;
      if imprime=false then exit;
    end;
  end;
end;


procedure TFrmMain.Etiqueta2;
begin
  if S_Impressora='01' then
  begin
    obs := MskObs.text;
    for z:=1 to max do
    begin
      a:='N'+chr(13)+chr(10);
      b:='R0,0'+chr(13)+chr(10);
      c:='A150,10,0,4,1,1,N,"'+Prod1+'"'+chr(13)+chr(10);
      d:='A150,50,0,4,1,1,N,"'+Prod2+'"'+chr(13)+chr(10);

      if codean=true then
      begin
        e:='B150,110,0,E30,2,1,80,B,"'+cod+'"'+chr(13)+chr(10);
      end
        else
      begin
        e:='B170,160,0,1,2,1,40,B,"'+cod+'"'+chr(13)+chr(10);
      end;

      f:='A370,100,0,4,1,1,N,"'+obs+'"'+chr(13)+chr(10);
      g:='A420,150,0,4,1,1,N,"'+valor+'"'+chr(13)+chr(10);
      h:='P1'+chr(13)+chr(10);
      if imprime=false then exit;
    end;
  end;
end;


procedure TFrmMain.Etiqueta3;
begin
  if S_Impressora='01' then
  begin
    for z:=1 to max do
    begin
      a:='N'+chr(13)+chr(10);
      b:='R0,0'+chr(13)+chr(10);
      c:='A18,0,0,2,1,1,N,"'+copy(Prod1,1,20)+'"'+chr(13)+chr(10)+'A298,0,0,2,1,1,N,"'+copy(Prod1,1,20)+'"'+chr(13)+chr(10)+'A578,0,0,2,1,1,N,"'+copy(Prod1,1,20)+'"'+chr(13)+chr(10);
      if codean=true then
      begin
        e:='B28,50,0,E30,2,1,80,B,"'+cod+'"'+chr(13)+chr(10)+'B316,50,0,E30,2,1,80,B,"'+cod+'"'+chr(13)+chr(10)+'B605,50,0,E30,2,1,80,B,"'+cod+'"'+chr(13)+chr(10);
      end
        else
      begin
        e:='B18,50,0,1,2,1,60,B,"'+cod+'"'+chr(13)+chr(10)+'B298,50,0,1,2,1,60,B,"'+cod+'"'+chr(13)+chr(10)+'B578,50,0,1,2,1,60,B,"'+cod+'"'+chr(13)+chr(10);
      end;
      g:='P1'+chr(13)+chr(10);
      if imprime=false then exit;
    end;
  end;

  if S_Impressora='02' then
  begin
    for z:=1 to max do
    begin
      a:=STX+'L'+CR+'D11'+cr;
      b:='H11'+CR; // temperatura da cabeça de impressão
      if codean=true then
      begin
        c:='1F4204000100018'+cod+CR;
        d:='1F4204000100158'+cod+CR;
        e:='1F4204000100306'+cod+CR;
      end
        else
      begin
        c:='1E1104000050012B'+cod+CR;
        d:='1E1104000050152B'+cod+CR;
        e:='1E1104000050294B'+cod+CR;
      end;
      f:='121100000700010'+copy(prod1,1,20)+CR+'121100000700150'+copy(prod1,1,20)+CR+'121100000700295'+copy(prod1,1,20)+CR;
      h:='E'+CR;
      if imprime=false then exit;
    end;
  end;
end;


function TFrmMain.Imprime: Boolean;
begin
  try
     AssignFile(aF,S_Porta);
     Rewrite(aF);
     if length(trim(a))>0 then Writeln(aF,a);
     if length(trim(b))>0 then Writeln(aF,b);
     if length(trim(c))>0 then Writeln(aF,c);
     if length(trim(d))>0 then Writeln(aF,d);
     if length(trim(e))>0 then Writeln(aF,e);
     if length(trim(f))>0 then Writeln(aF,f);
     if length(trim(g))>0 then Writeln(aF,g);
     if length(trim(h))>0 then Writeln(aF,h);
     CloseFile(aF);
     Result := True;
   except
     showmessage('Porta de comunicação inválida');
     result:=false;
   end;
   try
     AssignFile(aF,extractfilepath(application.exename)+'codebar.atc');
     Rewrite(aF);
     if length(trim(a))>0 then Writeln(aF,a);
     if length(trim(b))>0 then Writeln(aF,b);
     if length(trim(c))>0 then Writeln(aF,c);
     if length(trim(d))>0 then Writeln(aF,d);
     if length(trim(e))>0 then Writeln(aF,e);
     if length(trim(f))>0 then Writeln(aF,f);
     if length(trim(g))>0 then Writeln(aF,g);
     if length(trim(h))>0 then Writeln(aF,h);
     CloseFile(aF);
  except
  end;
end;

procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DBAutocom.Close;
end;

procedure TFrmMain.CmdProdutoClick(Sender: TObject);
begin
  SqlRun('SELECT * FROM PRODUTO ORDER BY CODIGOPRODUTO',Tbl_ProdutoC);
  Application.CreateForm(TFrmProduto, FrmProduto);
  FrmProduto.ShowModal;
  FrmProduto.Destroy;
  MskCodProduto.SetFocus;
end;

procedure TFrmMain.CmdPrecoClick(Sender: TObject);
begin
  if (Trim(MskCodProduto.Text) = '') or (StrToFloat(MskCodProduto.Text) = 0) then
  begin
    Application.MessageBox('Selecione um produto primeiro!','Erro de Validação');
    MskCodProduto.SetFocus;
    MskCodProduto.SelectAll;
    exit;
  end;

  Tbl_Preco.Close;
  Tbl_Preco.Params[0].Value := MskCodProduto.Text;
  Tbl_Preco.Open;

  Application.CreateForm(TFrmPreco, FrmPreco);
  FrmPreco.ShowModal;
  FrmPreco.Destroy;
end;

procedure TFrmMain.MskTabelaPrecoClick(Sender: TObject);
begin
  MskTabelaPreco.SelectAll;
end;

procedure TFrmMain.MskTabelaPrecoExit(Sender: TObject);
begin
  if Trim(MskTabelaPreco.Text) = '' then MskTabelaPreco.Text := '0';
  if StrToFloat(MskTabelaPreco.Text) = 0 then
  begin
    exit;
  end;

  SqlRun('select * from produtotabelapreco ptp inner join tabelapreco tp on' +
         '(ptp.codigotabelapreco = tp.codigotabelapreco) where ' +
         'ptp.codigoproduto = ' + MskCodProduto.Text +
         ' and ptp.codigotabelapreco = ' +
          MskTabelaPreco.Text, FrmMain.Rede);

  if Rede.IsEmpty then begin
    Application.MessageBox('Código Inválido','Erro de Validação',MB_ICONHAND);
    MskTabelaPreco.Clear;
    MskTabelaPreco.SetFocus;
  end
    else
  begin
    LblPreco.Caption := FloatToStrF(FrmMain.Rede.FieldByName('PRECO').AsFloat,ffcurrency,12,2);
    Valor := FloatToStrF(FrmMain.Rede.FieldByName('PRECO').AsFloat,ffcurrency,12,2);
  end;
end;

function TFrmMain.EAN13DV(Codigo: String): Boolean;
var
   i: integer;
   Valor: integer;
begin
  if not Length(Codigo) in [12, 13] then
  begin
    result:=false;
    showmessage('false');
  end
    else
  begin
    Valor := 0;
    for i := 1 to 12 do
    case i mod 2 of
      0: Valor := Valor + StrToInt(Codigo[i]) * 3;
      1: Valor := Valor + StrToInt(Codigo[i]);
    end;
      Valor := (((Valor div 10) + 1) * 10) - Valor;
      if Valor = 10 then Valor := 0;
      if Valor in [0..9] then
      begin
        if inttostr(valor)=copy(codigo,Length(Codigo),1) then result:=true else result:=false;
      end;
    end;
end;

procedure TFrmMain.MskTabelaPrecoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_Return then Perform(WM_NEXTDLGCTL,0,0);
  if Key = Vk_F1 then CmdPrecoClick(Self);  
end;

procedure TFrmMain.MskCodProdutoEnter(Sender: TObject);
begin
     Label2.Visible:=false;
     Edlote.Visible:=false;
end;

procedure TFrmMain.suiButton1Click(Sender: TObject);
begin
     close;
end;

procedure TFrmMain.edloteClick(Sender: TObject);
begin
     edlote.selectall;
end;

end.
