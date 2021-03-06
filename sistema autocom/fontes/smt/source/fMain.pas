unit fMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SyncObjs, StdCtrls, Buttons, Inifiles, StrUtils,  ExtCtrls, ComCtrls,
  ActnList, XPStyleActnCtrls, ActnMan, ToolWin, ActnCtrls, IBQuery, Math,
  ImgList, AppEvnts, UGlobal;

type
  TProduto = Record
    Codigo       : ShortString;
    Quantidade   : ShortString;
    Preco        : Real;
    Obs          : string;
  end;

type
  TProcesso = (SmtSkip, SmtMesa, SmtVendedor, SmtGarcom, SmtProduto, SmtQuantidade, SmtObservacao, SmtGrava, SmtFecha, SmtNumeroPessoas, SmtAcrescimo, SmtDesconto);
  TFrmMain = class(TForm)
    AM: TActionManager;
    ActConfig: TAction;
    ActAuditoria: TAction;
    Img: TImageList;
    ActionToolBar1: TActionToolBar;
    Back: TImage;
    ApplicationEvents: TApplicationEvents;
    StatusBarMain: TStatusBar;
    procedure FormActivate(Sender: TObject);
    procedure ActConfigExecute(Sender: TObject);
    procedure ApplicationEventsException(Sender: TObject; E: Exception);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure ConectaDataBase;
    procedure ThreadConstructor;
  public
  end;

  TMicro = class(TThread)
  private
    Politica: Boolean;
    Net: TIBQuery;
    Rede: TIBQuery;
    Codigo: Integer; // codigo do micro terminal
    Processo: TProcesso;
    Mesa: ShortString;
    Vendedor, Ven_CodVendedor: ShortString;
    Produtos: array[0..200] of TProduto;
    CodigoProdutos: Integer;
    KeyCaractere: ShortString;
    KeyTexto: ShortString;
    NPessoas: ShortString;
    TotalAcrescimo: ShortString;
    TotalDesconto: ShortString;
    S_NomeProduto: ShortString;
    S_NomeDoGarcom: ShortString;
    TimerTerminal: TTimer;
    Impressora: ShortString;
    PorcentagemAcrescimo, PorcentagemDesconto: Real;
    procedure EntraMesa(ClearVar: Boolean = True; Comentar: Boolean = True);
    procedure EntraGarcom(ClearVar: Boolean = True);
    procedure EntraProduto(ClearArrayLine: Boolean = True;
      Reset: Boolean = False; Comentar: Boolean = True);
    procedure EntraQuantidade(ClearVar: Boolean = True);
    procedure EntraObs(ClearVar: Boolean = True);
    procedure EntraNPessoas(ClearVar: Boolean = True);
    procedure EntraAcrescimo(ExibePadrao: Boolean = True);
    procedure EntraDesconto(ExibePadrao: Boolean = True);
    procedure GetVendedorName;
    procedure GetProdutoName;
    procedure NextProduto;
    procedure FechaPedido;
    procedure GravaPedido;
    procedure GravaProdutoPedido;
    procedure VerificaPedido;
    procedure VerificaGarcom;
    procedure ConfirmaGravacao;
    procedure ConfirmaFechamento;
    procedure PoliticaDePreco;
    procedure Imprimir(QtdeProdutos: Integer);
    procedure GetProdutos;
    procedure printgrill(pedido:integer;nome_pedido,nome_vendedor:string);
  protected
    procedure SkipKeys;
    procedure GetKeys;
    procedure ThreadTimer(Sender: TObject);
    procedure Execute; override;
    constructor Create (CreateSuspended: Boolean);
  end;

var
  FrmMain: TFrmMain;
    I_TermNumber, I_NumeroTerminais: Integer;
    Patch: string;
    S_NomeVendedor, S_NomePedido: string;
    I_CodigoTabelaPreco, I_LimitePedidoMinimo,
      I_LimitePedidoMaximo, I_Delivery: integer;
    B_Obs: Boolean;
    B_UsaServico: Boolean;
    I_PoliticaPreco: Integer;
    I_PrintGrill: Integer;

  function  ConfigLpt(Endereco, Timeout: Word): Boolean; stdcall;
  procedure Dll_Echo(Terminal: Byte; Dado: Char); stdcall;
  procedure Dll_Display(Terminal: Byte; Dado: string); stdcall;
  function  Dll_Get(Terminal: Byte): Char; stdcall;
  function  Dll_Status(Terminal: Byte): Byte; stdcall;
  function  Dll_Print(Terminal: Byte; Dado: Char): Byte; stdcall;
  function  Dll_Serial(Terminal: Byte; Dado: Char): Byte; stdcall;
  procedure Dll_Aciona(Terminal, Dado: Byte); stdcall;
  procedure Dll_Clear(Terminal: Byte); stdcall;
  procedure Dll_PosCur(Terminal, Lin, Col: Byte); stdcall;
  function  Dll_Acesso(Cmd: string): Integer; stdcall;

implementation

uses Module, DB, fConfig;
{$R *.DFM}

  function  ConfigLpt; external 'WTechLpt.dll';
  procedure Dll_Echo; external 'WTechLpt.dll';
  procedure Dll_Display; external 'WTechLpt.dll';
  function  Dll_Get; external 'WTechLpt.dll';
  function  Dll_Status; external 'WTechLpt.dll';
  function  Dll_Print; external 'WTechLpt.dll';
  function  Dll_Serial; external 'WTechLpt.dll';
  procedure Dll_Aciona; external 'WTechLpt.dll';
  procedure Dll_Clear; external 'WTechLpt.dll';
  procedure Dll_PosCur; external 'WTechLpt.dll';
  function  Dll_Acesso; external 'WTechLpt.dll';
                                                                    {  FrmMain |
|                                                                              |
|                                  Procedimentos                               |
|______________________________________________________________________________}
procedure TFrmMain.ConectaDataBase;
var
  Ini: TiniFile;
  T1, T2: string;
begin
  {Fecha Base de Dados e Transa??o}
  Dm.Transaction.Active := False;
  Dm.DBAutocom.Connected := False;

  {Pega Dados no Arquivo Ini}
  Ini := TIniFile.Create(Patch + 'AUTOCOM.INI');
  T1 := Ini.ReadString('ATCPLUS','IP_SERVER','');
  T2 := Ini.ReadString('ATCPLUS','PATH_DB','');
  S_NomeVendedor := Ini.ReadString('SMT','NOMEVENDEDOR','');
  S_NomePedido := Ini.ReadString('SMT','NOMEPEDIDO','');
  I_NumeroTerminais := StrToInt(Ini.ReadString('SMT','NUMEROTERMINAIS',''));
  StatusBarMain.Panels[0].Text := 'Terminais Ativos: ' + IntToStr(I_NumeroTerminais);I_LimitePedidoMinimo := StrToInt(Ini.ReadString('SMT','LIMITEPEDIDOMINIMO',''));
  if LeINI('SMT','USA_SERVICO') = 1 then
    B_UsaServico := True
  else
    B_UsaServico := False;

  I_LimitePedidoMaximo := StrToInt(Ini.ReadString('SMT','LIMITEPEDIDOMAXIMO',''));
  I_CodigoTabelaPreco := StrToInt(Ini.ReadString('SMT','CODIGOTABELAPRECO',''));
  I_Delivery := StrToInt(Ini.ReadString('SMT','DELIVERY',''));
  I_PoliticaPreco := StrToInt(Ini.ReadString('SMT','POLITICAPRECO',''));
  I_PrintGrill := StrToInt(Ini.ReadString('SMT','PRINTGRILL',''));
  if (Ini.ReadString('SMT','OBSERVACAO','')) = '1' then
    B_Obs := True
  else
    B_Obs := False;
  Ini.Free;

  {Atribui endereco do banco de dados ao componente}
  Dm.DBAutocom.DatabaseName := T1 + ':' + T2;

  {Conecta Base e Abre Transa??o}
  try
    Dm.dbautocom.Connected := True;
    Dm.Transaction.Active := True;
    {Conecta Tabela}
    Dm.Tbl_TabelaPreco.Open;
    Dm.Tbl_TabelaPreco.Close;
  except
    ActConfig.Execute;
    Close;
  end;

  {Cria Threads}
  I_TermNumber := -1;
  ThreadConstructor;
end;

procedure TFrmMain.ThreadConstructor;
var i: Integer;
begin
  for i := 0 to I_NumeroTerminais do
    TMicro.Create(False);
end;

                                                                    {  FrmMain |
|                                                                              |
|                                    Eventos                                   |
|______________________________________________________________________________}
procedure TFrmMain.FormActivate(Sender: TObject);
begin
  {Configura??o}
  ConfigLpt($378, 500);
  {Define o diret?rio do aplicativo}
  Patch := Extractfilepath(Application.ExeName) + 'dados\';
  ForceDirectories(ExtractFilePath(Application.ExeName) + '\logs');
  {Conecta Banco de Dados}
  ConectaDataBase;
  {Visualiza??o}
  SetForegroundWindow(Application.Handle);
end;

procedure TFrmMain.ActConfigExecute(Sender: TObject);
begin
  with TFrmConfig.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
end;
                                                                     {  Thread |
|                                                                              |
|                                  Procedimentos                               |
|______________________________________________________________________________}
constructor TMicro.Create(CreateSuspended: Boolean);
var
  Ini: TiniFile;
begin
  inherited;
  {Passa C?digo do Terminal para a Thread}
  Codigo := I_TermNumber; Inc(I_TermNumber);

  {Cria Timer para chamar fun??o de Teclado}
  TimerTerminal := TTimer.Create(Application);
  Priority := tpTimeCritical;
  TimerTerminal.OnTimer := ThreadTimer;
  TimerTerminal.Interval := 100;

  {Cria Querys}
  Net := TIBQuery.Create(Application);
  Net.Transaction := Dm.Transaction;
  Net.Database := Dm.DBAutocom;
  Rede := TIBQuery.Create(Application);
  Rede.Transaction := Dm.Transaction;
  Rede.Database := Dm.DBAutocom;

  {Limpa Tela do MicroTerminal}
  Dll_Clear(Codigo);
  Dll_Display(Codigo,CenterText('Sistema Autocom Plus - SMT',40));
  Dll_PosCur(Codigo,1,0);;
  Dll_Display(Codigo,CenterText('Aguarde...',40));

  {Cria Pasta de Logs}
  ForceDirectories(ExtractFilePath(Application.ExeName) + '\logs\MT' + IntToStr(Codigo));
  LogSend('logs\MT' + IntToStr(Codigo)+'\' + FormatDateTime('YYYYMMDD',Date) + ' SMT.LOG','Criando Thread...');

  {Pega Impressora no Ini}
  Ini := TIniFile.Create(Patch + 'AUTOCOM.INI');
  Impressora := Ini.ReadString('PRINTERS','PRINTER' + IntToStr(Codigo),'');
  Ini.Free;
  {Fecha Variavel de Politica}
  Politica := False;
end;

procedure TMicro.Execute;
begin
  EntraMesa;
  inherited;
end;

procedure TMicro.GetKeys;
begin
  KeyTexto := ''; {Limpa Variavel}
  KeyCaractere := Dll_Get(Codigo);
  if KeyCaractere <> Chr(0) then
  begin
    while KeyCaractere <> Chr(0) do
    begin
      SkipKeys;
      KeyTexto := KeyTexto + KeyCaractere;
      KeyCaractere := Dll_Get(Codigo);
    end;
    Dll_Display(Codigo, KeyTexto);
  end;
end;

procedure TMicro.SkipKeys;
begin
                                                                          {SKIP}
{                                                                              }
  if Processo = SmtSkip then
  begin
    KeyCaractere := '';
  end;
                                                                          {MESA}
{                                                                              }

  if Processo = SmtMesa then
  begin
    {Enter}
    if (KeyCaractere = #13) or (KeyCaractere = #127) then
    begin
      {Se for um n?mero passa para gar?om caso contrario zera variavel e volta}
      if (IsFloat(Mesa)) and (StrToFloat(Mesa) >= I_LimitePedidoMinimo)
        and (StrToFloat(Mesa) <= I_LimitePedidoMaximo) then
        begin
          RunSQL('Commit;',Dm.DBAutocom);
          Dm.Transaction.Active := True;
          {Faz Select na Tabela PEDIDOVENDA}
          SqlRun('SELECT SITUACAO, ORIGEMPEDIDO FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' + Mesa
                  , Net);
          {Se o campo Situacao estiver com x na tabela PEDIDOVENDA, acesso negado!}
          if (Net.FieldByName('SITUACAO').AsString <> 'X') then

            if (Net.FieldByName('ORIGEMPEDIDO').AsString <> IntToStr(I_Delivery))
              and (Net.FieldByName('ORIGEMPEDIDO').AsString <> '0')
              and (Net.FieldByName('ORIGEMPEDIDO').AsString <> '') then
            begin
              {Mostra mensagem de Acesso Negado}
              Dll_Clear(Codigo);
              Dll_Display(Codigo,CenterText('Acesso Negado!',40));
              Sleep(750);
              Dll_Clear(Codigo);
              EntraMesa(True);
            end
            else
            begin
              if (KeyCaractere = #13) then
              begin
                 if (Net.FieldByName('SITUACAO').AsString = 'Z') then
                 begin
                    {Situacao Z significa que o pedido inicio o fechamento}
                    {por Helder Frederico - dia 09/08/2003}
                    Dll_Clear(Codigo);
                    Dll_Display(Codigo,CenterText('ATENCAO: '+S_NomePedido+' iniciou o fechamento!',40));
                    Sleep(3000);
                 end;
                 VerificaGarcom;
              end;
              if (KeyCaractere = #127) then
                VerificaPedido;
            end
          else
          begin
            {Mostra mensagem de Acesso Negado}
            Dll_Clear(Codigo);
            Dll_Display(Codigo,CenterText('Acesso Negado!',40));
            Sleep(750);
            Dll_Clear(Codigo);
            EntraMesa(True);
          end;
       end
      else
      begin
        {Exibe Mensagem de C?digo Inv?lido}
        Dll_Clear(Codigo);
        Dll_Display(Codigo, CenterText('Erro -  A ' + S_NomePedido +
                                       ' deve estar entre',40));
        Dll_PosCur(Codigo,1,0);
        Dll_Display(Codigo, CenterText(IntToStr(I_LimitePedidoMinimo) +
          ' e ' + IntToStr(I_LimitePedidoMaximo),40));
        Sleep(750);
        Dll_Clear(Codigo);
        EntraMesa(True);
      end;
    end;
    {Backspace}
    if KeyCaractere = #8 then
    begin
      TotalAcrescimo := '0';
      EntraMesa(True); {Desfaz entra novamente}
      Application.ProcessMessages;
    end;
    {Limita caracteres}
    if Length(Mesa) >= 10 then KeyCaractere := '';
    {Bloqueio de Caracteres Alpha}
    if not (KeyCaractere[1]  in ['0'..'9']) then KeyCaractere := ''
    else
      {Registra Caractere na Variavel}
      Mesa := Mesa + KeyCaractere;
  end;
                                                                      {VENDEDOR}
{                                                                              }

  if Processo = SmtGarcom then
  begin
    {Enter}
    if KeyCaractere = #13 then
    begin
      {Se for um n?mero passa para gar?om caso contrario zera variavel e volta}
      if IsFloat(Vendedor) then
        {Mostra nome do Vendedor na Tela}
        GetVendedorName
      else
      begin
        EntraMesa(False,False); {Entra mesa com variavel na tela}
        EntraGarcom(True); {Entra garcom}
      end;
    end;
    {Backspace}
    if KeyCaractere = #8 then
    begin
        EntraMesa(False,False); {Entra mesa com variavel na tela}
        EntraGarcom(True);
        Application.ProcessMessages; {Entra garcom}
    end;
    {Limita C?digo a 10 caracteres}
    if Length(Vendedor) >= 10 then KeyCaractere := '';
    {Bloqueio de Caracteres Alpha}
    if not (KeyCaractere[1]  in ['0'..'9']) then KeyCaractere := ''
    else
      Vendedor := Vendedor + KeyCaractere;
  end;
                                                                       {PRODUTO}
{                                                                              }

  if Processo = SmtProduto then
  begin
    {Enter}
    if KeyCaractere = #13 then
    begin
      {Valida C?digo Digitado}
      if IsFloat(Produtos[CodigoProdutos].Codigo) then
      begin
        GetProdutoName;
      end
      else
        EntraProduto;
    end;
    {Backspace}
    if KeyCaractere = #8 then
    begin
        EntraProduto; {Apaga e entra novamente}
        Application.ProcessMessages;
    end;
    if KeyCaractere = #127 {Delete} then
    begin
        if CodigoProdutos > 1 then ConfirmaGravacao;
    end;
    {Limita C?digo a 13 caracteres}
    if Length(Produtos[CodigoProdutos].Codigo) >= 13 then KeyCaractere := '';
    {Bloqueio de Caracteres Alpha}
    if not (KeyCaractere[1]  in ['0'..'9']) then KeyCaractere := ''
    else
      {Registra Caractere na Variavel}
      Produtos[CodigoProdutos].Codigo := Produtos[CodigoProdutos].Codigo
        + KeyCaractere;
  end;
                                                                    {QUANTIDADE}
{                                                                              }

  if Processo = SmtQuantidade then
  begin
    {Enter}
    if KeyCaractere = #13 then
    begin
      if not IsNull(Produtos[CodigoProdutos].Quantidade) then
      begin
        PoliticaDePreco;
        {A Boolean B_Obs recebe valor de um arquivo Ini que determina}
        {se have?a ou n?o observacao}
        if B_Obs then
        begin
          EntraObs;
        end
        else
          NextProduto;
      end
      else
      begin
        EntraProduto(False,False,False);
        GetProdutoName;
      end;
    end;
    {Backspace}
    if KeyCaractere = #8 then
    begin
        EntraProduto(False,False,False);
        GetProdutoName;
        Application.ProcessMessages;
    end;
    {Limita caracteres}
    if Length(Produtos[CodigoProdutos].Quantidade) >= 12 then KeyCaractere := '';
    {Proibe mais de uma virgula}
    if KeyCaractere = '.' then KeyCaractere := ',';
    if KeyCaractere = ',' then
    begin
      if Pos(',',Produtos[CodigoProdutos].Quantidade) <> 0 then KeyCaractere := '' else KeyCaractere := ','; 
      if Length(Produtos[CodigoProdutos].Quantidade) < 1 then KeyCaractere := '';
      if Produtos[CodigoProdutos].Quantidade = NullAsStringValue then KeyCaractere := '0,';
    end;
    {Bloqueio de Caracteres Alpha}
    if not (KeyCaractere[1]  in ['0'..'9',',']) then KeyCaractere := ''
    else
      {Registra Caractere na Variavel}
      Produtos[CodigoProdutos].Quantidade :=
        Produtos[CodigoProdutos].Quantidade + KeyCaractere;
  end;

                                                                    {OBSERVACAO}
{                                                                              }

  if Processo = SmtObservacao then
  begin
    {Enter}
    if KeyCaractere = #13 then NextProduto;
    {Backspace}
    if KeyCaractere = #8 then
    begin
      EntraObs;
      Application.ProcessMessages;
    end;
    {Limita caracteres}
    if Length(Produtos[CodigoProdutos].Obs) >= 20 then KeyCaractere := '';
    {Bloqueio de Caracteres Especiais}
    if (KeyCaractere = #0) or (KeyCaractere = #127) or(KeyCaractere = #13) or (KeyCaractere = #127) then
      KeyCaractere := ''
    else
      {Registra Caractere na Variavel}
      Produtos[CodigoProdutos].Obs := Produtos[CodigoProdutos].Obs +
        KeyCaractere;
  end;
                                                                  {GRAVA PEDIDO}
{                                                                              }

  if Processo = SmtGrava then
  begin
    {Sim}
    if KeyCaractere = 'S' then GravaPedido;
    {Nao}
    if KeyCaractere = 'N' then
      begin
        EntraMesa;
        ZeroMemory(@Produtos,SizeOf(Produtos));
        CodigoProdutos := 1;
      end;
    {Bloqueio de Caracteres}
    KeyCaractere := '';
  end;
                                                                  {FECHA PEDIDO}
{                                                                              }

  if Processo = SmtFecha then
  begin
    {Sim}
    if KeyCaractere = 'S' then FechaPedido;
    {Nao}
    if KeyCaractere = 'N' then EntraMesa;
    {Bloqueio de Caracteres}
      KeyCaractere := '';
  end;
                                                                          {SKIP}
{                                                                              }

  if Processo = SmtNumeroPessoas then
  begin
    {Enter}
    if KeyCaractere = #13 then
    begin
      {Se for um n?mero passa para gar?om caso contrario zera variavel e volta}
      if IsFloat(NPessoas) then
        {Confirma N de Pessoas pergunta se usa servico caso verdadeira variavel}
        if B_UsaServico then EntraAcrescimo else ConfirmaFechamento //FechaPedido
      else
        EntraNPessoas; {Entra mesa com variavel na tela}
    end;
    {Backspace}
    if KeyCaractere = #8 then
      begin
        EntraNPessoas;
        Application.ProcessMessages;
      end;
    {Bloqueio de Caracteres Alpha e Limita Valor a 10 caracteres}
    if Length(NPessoas) >= 10 then KeyCaractere := '';
    if (KeyCaractere <> '1') and (KeyCaractere <> '2') and
       (KeyCaractere <> '3') and (KeyCaractere <> '4') and
       (KeyCaractere <> '5') and (KeyCaractere <> '6') and
       (KeyCaractere <> '7') and (KeyCaractere <> '8') and
       (KeyCaractere <> '9') and (KeyCaractere <> '0')
        then KeyCaractere := ''
    else
      NPessoas := NPessoas + KeyCaractere;
  end;
                                                                     {ACRESCIMO}
{                                                                              }

  if Processo = SmtAcrescimo then
  begin
    {Enter}
    if KeyCaractere = #13 then
    begin
      {Se for um n?mero passa para gar?om caso contrario zera variavel e volta}
      if TotalAcrescimo <> NullAsStringValue then
        {Se for um numero valido fecha pedido}
        EntraDesconto
      else
        EntraAcrescimo;
    end;
    {Backspace}
    if KeyCaractere = #8 then
      begin
        EntraAcrescimo(False);
        Application.ProcessMessages;
      end;

    {Proibe mais de uma virgula}
    if KeyCaractere = '.' then KeyCaractere := ',';
    if KeyCaractere = ',' then
    begin
      if Pos(',',TotalAcrescimo) <> 0 then KeyCaractere := '' else KeyCaractere := ',';
      if Length(TotalAcrescimo) < 1 then KeyCaractere := '';
      if TotalAcrescimo = NullAsStringValue then KeyCaractere := '0,';
    end;
    if not (KeyCaractere[1]  in ['0'..'9',',']) then KeyCaractere := ''
    else
      TotalAcrescimo := TotalAcrescimo + KeyCaractere;
  end;
                                                                      {DESCONTO}
{                                                                              }

  if Processo = SmtDesconto then
  begin
    {Enter}
    if KeyCaractere = #13 then
    begin
      {Se for um n?mero passa para gar?om caso contrario zera variavel e volta}
      if TotalDesconto <> NullAsStringValue then
        {Se for um numero valido fecha pedido}
        ConfirmaFechamento
      else
        EntraDesconto;
    end;
    {Backspace}
    if KeyCaractere = #8 then
      begin
        EntraDesconto(False);
        Application.ProcessMessages;
      end;

    {Proibe mais de uma virgula}
    if KeyCaractere = '.' then KeyCaractere := ',';
    if KeyCaractere = ',' then
    begin
      if Pos(',',TotalDesconto) <> 0 then KeyCaractere := '' else KeyCaractere := ',';
      if Length(TotalDesconto) < 1 then KeyCaractere := '';
      if TotalDesconto = NullAsStringValue then KeyCaractere := '0,';
    end;
    if not (KeyCaractere[1]  in ['0'..'9',',']) then KeyCaractere := ''
    else
      TotalDesconto := TotalDesconto + KeyCaractere;
  end;

end;

procedure TMicro.EntraMesa(ClearVar: Boolean; Comentar: Boolean);
begin
  Dll_Clear(Codigo);
  Processo := SmtMesa;
  if Comentar then
  begin
  {Se Comentar for Verdadeiro exibe comandos na Tela}
    Dll_PosCur(Codigo,1,0);
    Dll_Display(Codigo,'[Enter]Abre '  + S_NomePedido +
      ' [Fecha]Fecha ' + S_NomePedido);
  end;
  Dll_PosCur(Codigo,0,0);
  if ClearVar then ZeroMemory(@Mesa, SizeOf(Mesa));
  Dll_Display(Codigo, S_NomePedido + ':');
  if not ClearVar then Dll_Display(Codigo, Mesa);
end;

procedure TMicro.EntraGarcom(ClearVar: Boolean);
begin
  {Exibe comandos na Tela}
  Dll_PosCur(Codigo,1,0);
  Dll_Display(Codigo,'[Enter]Confirmar                        ' + S_NomePedido);
  {Imprime Vendedor na Tela}
  Dll_PosCur(Codigo, 0, 20); {Posiciona Cursor}
  if ClearVar then ZeroMemory(@Vendedor, SizeOf(Vendedor)); {Lima variavel}
  Processo := SmtGarcom; {Altera Processo}
  Dll_Display(Codigo, S_NomeVendedor + ':' + Vendedor); {Mostra na Tela}
end;

procedure TMicro.GetVendedorName;
begin
  {Pega Nome do Garcom}
  SqlRun(' SELECT P.PES_NOME_A, V.VEN_CODVENDEDOR ' +
         ' FROM VENDEDOR V ' +
         ' INNER JOIN PESSOA P ON (P.PES_CODPESSOA = V.PES_CODPESSOA) ' +
         ' WHERE V.CODIGOVENDEDOR = ' + Vendedor + ';'
         , Rede);
   if Rede.IsEmpty then
   begin
     Processo := SmtSkip; {Bloqueia Teclado}
     Dll_PosCur(Codigo, 1, 0);
     {Limpa Segunda Linha}
     Dll_Clear(Codigo);
     Dll_Display(Codigo, CenterText('Codigo Invalido',40));
     Sleep(750);
     Dll_Clear(Codigo);
     EntraMesa(False,False);
     EntraGarcom(True);
   end else
   begin
     Processo := SmtSkip; {Bloqueia Teclado}
     Ven_CodVendedor := Rede.Fields[1].AsString;
     S_NomeDoGarcom := Rede.Fields[0].AsString; {esta variavel ? usada na impressao}
     Dll_Clear(Codigo);
     Dll_Display(Codigo, CenterText(S_NomeDoGarcom,40));
     Sleep(750);
     Processo := SmtProduto;
     EntraProduto(True,False,True);
   end;
   Application.ProcessMessages;
end;

procedure TMicro.GetProdutoName;
begin
  {Procura na Tabela de Codigo Associado}
  SqlRun(' SELECT CODIGOPRODUTO FROM PRODUTOASSOCIADO WHERE ' +
         ' CODIGOPRODUTOASSOCIADO = ' +
         Produtos[CodigoProdutos].Codigo
         , Rede);

  if not Rede.IsEmpty then Produtos[CodigoProdutos].Codigo := Rede.Fields[0].AsString;

    {Pega Nome do Produto}
    SqlRun(' SELECT P.NOMEPRODUTO ' +
           ' FROM PRODUTO P ' +
           ' WHERE P.CODIGOPRODUTO = ' +
           Produtos[CodigoProdutos].Codigo + ';'
           , Rede);

   {Se ? encontrar nada exibe mensagem de erro}
   if Rede.IsEmpty then
   begin
     Processo := SmtSkip; {Bloqueia Teclado}
     Dll_Clear(Codigo);
     Dll_Display(Codigo, CenterText('Codigo Invalido',40));
     Sleep(750); {Para Processamento por 1s para que a mensagem possa ser lida}
     Dll_Clear(Codigo);
     EntraProduto(True,False,False);
   end else
   begin
     //Procura Preco do Produto
     SqlRun('SELECT PRECO FROM PRODUTOTABELAPRECO WHERE CODIGOPRODUTO = ' +
            Produtos[CodigoProdutos].Codigo +
            ' AND CODIGOTABELAPRECO = ' + IntToStr(I_CodigoTabelaPreco) + ';'
            , Net);
     if not Net.IsEmpty then
       Produtos[CodigoProdutos].Preco := Net.Fields[0].AsFloat
       else
     begin
       Processo := SmtSkip; {Bloqueia Teclado}
       Dll_Clear(Codigo);
       Dll_Display(Codigo, 'Erro - Este produto nao pode ser vendido');
       Dll_PosCur(Codigo,1,0);
       Dll_Display(Codigo, CenterText('pois nao ha preco cadastrado para ele',40));
       Sleep(1500); {Para Processamento por 1s para que a mensagem possa ser lida}
       Dll_Clear(Codigo);
       EntraProduto(True,False,False);
       Exit;
     end;

     Processo := SmtSkip; {Bloqueia Teclado}
     S_NomeProduto := Copy(Rede.Fields[0].AsString,0,40);
     Dll_Clear(Codigo);
     EntraProduto(False,False,False);
     Dll_PosCur(Codigo, 1, 0);
     Dll_Display(Codigo, S_NomeProduto);
     Processo := SmtQuantidade;
     EntraQuantidade;
     Application.ProcessMessages;
   end;
end;

procedure TMicro.EntraProduto(ClearArrayLine: Boolean;
  Reset: Boolean; Comentar: Boolean);
begin
  Dll_Clear(Codigo);
  if CodigoProdutos < 1 then
  begin
    CodigoProdutos := 1;
  end;
  if ClearArrayLine then
  begin
    if CodigoProdutos < 0 then Exit;
    Produtos[CodigoProdutos].Codigo := '';
  end;
  if Reset then
  begin
    {Reinicia Array desdo codigo 1}
    CodigoProdutos := 1;
  end;
  if Comentar then
  begin
    {Exibe comandos na Tela}
    Dll_PosCur(Codigo,1,0);
    if CodigoProdutos > 1 then
      Dll_Display(Codigo,'[Enter]Lanca Prod. [Grava]Gravar ' + S_NomePedido)
    else
      Dll_Display(Codigo,'[Enter]Lanca Produto')
  end;
  Processo := SmtProduto;
  Dll_PosCur(Codigo,0,0);
  Dll_Display(Codigo, 'Produto:' + Produtos[CodigoProdutos].Codigo);
end;

procedure TMicro.EntraQuantidade(ClearVar: Boolean);
begin
  Dll_PosCur(Codigo, 0, 22);
  if ClearVar then Produtos[CodigoProdutos].Quantidade := '';
  Processo := SmtQuantidade;
  Dll_Display(Codigo, 'Qtde:' + Produtos[CodigoProdutos].Quantidade);
end;

procedure TMicro.EntraObs(ClearVar: Boolean);
begin
  Dll_Clear(Codigo);
  Dll_PosCur(Codigo, 1,0);
  Dll_Display(Codigo, S_NomeProduto);
  Dll_PosCur(Codigo, 0, 0);
  if ClearVar then Produtos[CodigoProdutos].Obs := NullAsStringValue;
  Processo := SmtObservacao;
  Dll_Display(Codigo, 'Observacao:' + Produtos[CodigoProdutos].Obs);
end;

procedure TMicro.NextProduto;
begin
  CodigoProdutos := CodigoProdutos + 1;
  EntraProduto;
end;

procedure TMicro.GravaPedido;
var
  S_CodigoNaturezaOperacao, S_CodigoCondicaoPagamento,
    S_CliCodCliente: ShortString;
  I_CodRecord: Integer;
  TotalProdutos: Real;
begin
  Processo := SmtSkip;
  Dll_Clear(Codigo);
  Dll_Display(Codigo, CenterText('Gravando Pedido...',40));
  Sleep(750);

  SqlRun('Commit;',Net,False);

  {Pega Dados necessarios para insert e guarda nas variaveis}
  SqlRun('SELECT CODIGONATUREZAOPERACAO FROM NATUREZAOPERACAO',Net);
  S_CodigoNaturezaOperacao :=  Net.Fields[0].AsString;

  SqlRun('SELECT CODIGOCONDICAOPAGAMENTO FROM CONDICAOPAGAMENTO',Net);
  S_CodigoCondicaoPagamento := Net.Fields[0].AsString;

  S_CliCodCliente := '1'; {Codigo Padr?o de Cliente Passante}

  {Verifica se o pedido j? existe e se j? est? fechado}
  SqlRun('SELECT SITUACAO, TOTALPRODUTOS FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' + Mesa, Net);

   {Total do Preco dos Produtos}
   I_CodRecord := CodigoProdutos - 1;
   TotalProdutos := Net.Fields[1].AsFloat;
   while I_CodRecord <> 0 do
   begin
     {Soma Toal de Produtos}
     TotalProdutos := TotalProdutos + (Produtos[I_CodRecord].Preco * StrToFloat(Produtos[I_CodRecord].Quantidade));
     I_CodRecord   := I_CodRecord - 1
   end;

    if (Net.IsEmpty) then
    {Insert na Tabela de PedidoVenda}
    begin
      SqlRun('INSERT INTO PEDIDOVENDA '+
             '( '+
             '  NUMEROPEDIDO, '+
             '  DATA, '+
             '  CODIGONATUREZAOPERACAO, '+
             '  CODIGOCONDICAOPAGAMENTO, '+
             '  VEN_CODVENDEDOR, '+
             '  CODIGOTABELAPRECO,  '+
             '  CLI_CODCLIENTE,  '+
             '  TOTALPRODUTOS,  '+
             '  CFG_CODCONFIG,  '+
             '  ORIGEMPEDIDO )' +//, NUMPESSOAS) '+
             ' VALUES ( '+
             QuotedStr(Mesa) + ',' +
             QuotedStr(FormatDateTime('MM/DD/YYYY hh:nn:ss',now))+ ',' +
             QuotedStr(S_CodigoNaturezaOperacao)+ ',' +
             QuotedStr(S_CodigoCondicaoPagamento)+ ',' +
             QuotedStr(Ven_CodVendedor)+ ',' +
             QuotedStr(IntToStr(I_CodigoTabelaPreco))+ ',' +
             QuotedStr(S_CliCodCliente)+ ',' +
             QuotedStr(StringReplace(FloatToStr(TotalProdutos),',','.',[])) + ',' +
             QuotedStr('1')+ ',' +
             QuotedStr(IntToStr(I_Delivery)) + {',' +
             {QuotedStr(NPessoas) +} ')', Rede);
      Dm.Transaction.CommitRetaining;
    end
    else
    begin
     SqlRun( 'UPDATE PEDIDOVENDA SET ' +
             //' NUMPESSOAS         = '  +  QuotedStr(FloatToStr(StrToFloatDef(NPessoas,0))) + ' ,' +
             ' TOTALPRODUTOS      = ' + (StringReplace(FloatToStr(TotalProdutos),',','.',[]))  +
             ' WHERE NUMEROPEDIDO = ' + QuotedStr(Mesa), Rede);
     Dm.Transaction.CommitRetaining;
    end;
  {Insert na Tabela ProdutoPedidoVenda}
  Application.ProcessMessages;
  GravaProdutoPedido;
end;

procedure TMicro.GravaProdutoPedido;
var
  i:integer;
begin

  SqlRun('SELECT CODIGOPEDIDOVENDA FROM  PEDIDOVENDA WHERE NUMEROPEDIDO = ' +
         Mesa, Net);
  for  i := 1 to CodigoProdutos-1 do
  begin
    Application.ProcessMessages;
    SqlRun(' INSERT INTO PRODUTOPEDIDOVENDA '+
           ' (CODIGOPRODUTO, QUANTIDADE, PRECO, CODIGOPEDIDOVENDA, OBSERVACAO, CANCELADO) '+
           ' VALUES (' +
           QuotedStr(Produtos[i].Codigo) + ',' +
           QuotedStr(StringReplace(Produtos[i].Quantidade,',','.',[]))+ ', ' +
           QuotedStr(StringReplace(FloatToStr(Produtos[i].Preco),',','.',[])) + ', ' +
           Net.Fields[0].AsString +', '+
           QuotedStr(Produtos[i].Obs) +',0 )', Rede);
  end;
    Dm.Transaction.CommitRetaining;

  {Verifica Valor da variavel chama funcao ou nao}
  if I_PrintGrill = 1 then
  begin
       LogSend('logs\MT' + IntToStr(Codigo)+'\' + FormatDateTime('YYYYMMDD',Date) + ' SMT.LOG','***** PRINT GRILL ------  Mesa : ' + Mesa + ' NomePedido : ' + S_NomePedido + ' NomeVendedor: ' +S_NomeVendedor);
       PrintGrill(StrToInt(Mesa),S_NomePedido, S_NomeVendedor);
  end;

  {Mostra Mesagem no Display}
  Dll_Clear(Codigo);
  Dll_Display(Codigo, CenterText('Pedido Gravado',40));
  Sleep(300);
  {Reinicia}
  CodigoProdutos := 1;
  EntraMesa;
end;

procedure TMicro.EntraNPessoas(ClearVar: Boolean);
begin
  {Pergunta n?mero de pessoas na Mesa}
  Dll_Clear(Codigo);
  Processo := SmtNumeroPessoas;
  {Comentarios}
  Dll_PosCur(Codigo,1,0);
  Dll_Display(Codigo,'[Enter]Confirma');
  Dll_PosCur(Codigo,0,0);
  if ClearVar then ZeroMemory(@NPessoas, SizeOf(NPessoas));
  Dll_Display(Codigo, 'Pessoas:' + NPessoas);
end;

procedure TMicro.EntraAcrescimo(ExibePadrao: Boolean);
begin
  Dll_Clear(Codigo);
  Processo := SmtAcrescimo;
  {Comentarios}
  Dll_PosCur(Codigo,1,0);
  Dll_Display(Codigo,'[Enter]Confirma');
  Dll_PosCur(Codigo,0,0);

  if ExibePadrao then
    begin
      TotalAcrescimo := FormatFloat('0.00',StrToFloat(PChar(string(LeINI('SMT','Acrescimo')))+1));
    end
  else
    begin
      ZeroMemory(@TotalAcrescimo,SizeOf(TotalAcrescimo));
    end;
  Dll_Display(Codigo, 'Acrescimo (' + Copy(LeINI('SMT','Acrescimo'),1,1) + '):' + TotalAcrescimo);
end;

procedure TMicro.EntraDesconto(ExibePadrao: Boolean);
begin
  Dll_Clear(Codigo);
  Processo := SmtDesconto;
  {Comentarios}
  Dll_PosCur(Codigo,1,0);
  Dll_Display(Codigo,'[Enter]Confirma');
  Dll_PosCur(Codigo,0,0);

  if ExibePadrao then
    begin
      TotalDesconto := FormatFloat('0.00',StrToFloat(PChar(string(LeINI('SMT','Desconto')))+1));
    end
  else
    begin
      ZeroMemory(@TotalDesconto,SizeOf(TotalDesconto));
    end;
  Dll_Display(Codigo, 'Desconto (' + Copy(LeINI('SMT','Desconto'),1,1) + '):' + TotalDesconto);
end;

procedure TMicro.FechaPedido;
var
  R_TotalProdutos: Real;
  R_TotalPedido: Real;
begin
  Processo := SmtSkip;
  Dll_Clear(Codigo);
  Dll_Display(Codigo, CenterText('Fechando Pedido...',40));

  {Pega Somatoria dos produtos}
  SqlRun('Commit;',Net,False);
  SqlRun(' select sum(preco * quantidade) from produtopedidovenda ppv ' +
         ' inner join pedidovenda pv on(pv.codigopedidovenda = ppv.codigopedidovenda) ' +
         ' where ppv.cancelado<>1 and pv.numeropedido = ' + Mesa, Net);

  R_TotalProdutos :=  Net.Fields[0].AsFloat;

    if B_UsaServico then
      begin
        if (Copy(LeINI('SMT','DESCONTO'),1,1) = '%') then
          begin
            PorcentagemDesconto := StrToFloatDef(TotalDesconto,0);
            TotalDesconto := FloatToStr(R_TotalProdutos * (StrToFloatDef(TotalDesconto,1)) / 100);
          end;
        if (Copy(LeINI('SMT','ACRESCIMO'),1,1) = '%') then
          begin
            PorcentagemAcrescimo := StrToFloatDef(TotalAcrescimo,0);
            TotalAcrescimo := FloatToStr((R_TotalProdutos * (StrToFloatDef(TotalAcrescimo,1)) / 100));
          end;
      end
    else
      begin
        TotalAcrescimo := '0';
        TotalDesconto := '0';
      end;

    R_TotalPedido := R_TotalProdutos - StrToFloatDef(TotalDesconto,0) + StrToFloatDef(TotalAcrescimo,0);

    {Update na Tabela}
    SqlRun( ' UPDATE PEDIDOVENDA ' +
            ' SET '+
            ' SITUACAO = ' + QuotedStr('Z') + ' , ' +
            ' NUMPESSOAS = ' + QuotedStr(FloatToStr(StrToFloatDef(NPessoas,0))) + ' , ' +
            ' DESPESASACESSORIAS = ' + QuotedStr(IfThen(B_UsaServico,StringReplace(TotalAcrescimo,',','.',[]),'0.00')) + ' , ' +
            ' DESCONTO = ' + QuotedStr(IfThen(B_UsaServico,StringReplace(TotalDesconto,',','.',[]),'0.00')) + ' , ' +
            ' TOTALPEDIDO = ' + QuotedStr(StringReplace(FloatToStr(R_TotalPedido),',','.', [])) + ' , ' +
            ' TOTALPRODUTOS = ' + QuotedStr(StringReplace(FloatToStr(R_TotalProdutos),',','.', [])) +
            ' WHERE ' +
            ' NumeroPedido = ' + Mesa
            , Rede);

    LogSend('logs\MT' + IntToStr(Codigo)+'\' + FormatDateTime('YYYYMMDD',Date) + ' SMT.LOG',
            'Gravando o fechamento do pedido->'+
            ' UPDATE PEDIDOVENDA ' +
            ' SET '+
            ' SITUACAO = ' + QuotedStr('Z') + ' , ' +
            ' NUMPESSOAS = ' + QuotedStr(FloatToStr(StrToFloatDef(NPessoas,0))) + ' , ' +
            ' DESPESASACESSORIAS = ' + QuotedStr(IfThen(B_UsaServico,StringReplace(TotalAcrescimo,',','.',[]),'0.00')) + ' , ' +
            ' DESCONTO = ' + QuotedStr(IfThen(B_UsaServico,StringReplace(TotalDesconto,',','.',[]),'0.00')) + ' , ' +
            ' TOTALPEDIDO = ' + QuotedStr(StringReplace(FloatToStr(R_TotalPedido),',','.', [])) + ' , ' +
            ' TOTALPRODUTOS = ' + QuotedStr(StringReplace(FloatToStr(R_TotalProdutos),',','.', [])) +
            ' WHERE ' +
            ' NumeroPedido = ' + Mesa);

    Dm.Transaction.CommitRetaining;
    LogSend('logs\MT' + IntToStr(Codigo)+'\' + FormatDateTime('YYYYMMDD',Date) + ' SMT.LOG','Pedido ' + Mesa + ' Fechado!');
    {Imprime}
    GetProdutos;
    if CodigoProdutos < 1 then
    begin
      {Reinicia}
      CodigoProdutos := 1;
      EntraMesa;
      Dll_Clear(Codigo);
      Dll_Display(Codigo, CenterText('Erro - Este pedido ainda nao foi aberto!',40));
      Sleep(300);
    end;
    Dll_Clear(Codigo);
    Dll_Display(Codigo, CenterText('Imprimindo...',40));
    Imprimir(CodigoProdutos);

    Dm.Transaction.CommitRetaining;
    Dm.Transaction.Active := True;
    Application.ProcessMessages;
    {Mostra Mensagem de Pedido Fechado}
    Dll_Clear(Codigo);
    Dll_Display(Codigo, CenterText('Pedido Fechado',40));
    Sleep(200);
  {Reinicia}
  CodigoProdutos := 1;
  EntraMesa;
end;

procedure TMicro.VerificaPedido;
begin
  SqlRun('SELECT NUMEROPEDIDO FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' + Mesa,Net);
    if not Net.IsEmpty then
       EntraNPessoas(True)
    else
    begin
      Dll_Clear(Codigo);
      Dll_Display(Codigo, 'Este pedido ainda nao foi aberto');
      Sleep(1000);
      EntraMesa;
    end;
end;

procedure TMicro.VerificaGarcom;
begin
  SqlRun('SELECT NUMEROPEDIDO FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' + Mesa,Net);
  if not Net.IsEmpty then
  begin
    SqlRun('SELECT VEN_CODVENDEDOR FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' + Mesa,Net);
    Ven_CodVendedor := Net.Fields[0].AsString;
    SqlRun('SELECT CODIGOVENDEDOR FROM VENDEDOR WHERE VEN_CODVENDEDOR = ' + Ven_CodVendedor,Net);
    Vendedor := Net.Fields[0].AsString;
    EntraGarcom(False);
    GetVendedorName;
  end
  else
  begin
    EntraGarcom;
  end;
end;

procedure TMicro.ConfirmaGravacao;
begin
  Processo := SmtSkip;
  Dll_Clear(Codigo);
  Dll_PosCur(Codigo,1,0);
  Dll_Display(Codigo, '[S]Sim              [N]Nao');
  Dll_PosCur(Codigo,0,0);
  Dll_Display(Codigo,'Confirma Gravacao do Pedido?:');
  Processo := SmtGrava;
end;

procedure TMicro.ConfirmaFechamento;
begin
  Processo := SmtSkip;
  Dll_Clear(Codigo);
  Dll_PosCur(Codigo,1,0);
  Dll_Display(Codigo, '[S]Sim              [N]Nao');
  Dll_PosCur(Codigo,0,0);
  Dll_Display(Codigo,'Confirma o Fechamento do Pedido?:');
  Processo := SmtFecha;
end;

procedure TMicro.PoliticaDePreco;
var
  Preco: Real;
begin
  if Politica and (Produtos[CodigoProdutos].Quantidade <> '0,5') then Politica := False;
  if Politica and (Produtos[CodigoProdutos].Quantidade = '0,5') then
    begin
      case I_PoliticaPreco of
        0: //Normal
          Exit;
        1: //Menor Preco
        begin
          Preco := Min(Produtos[CodigoProdutos-1].Preco,
            Produtos[CodigoProdutos].Preco);
          Produtos[CodigoProdutos-1].Preco := Preco;
          Produtos[CodigoProdutos].Preco := Preco;
        end;
        2: //Maior Preco
        begin
          Preco := Max(Produtos[CodigoProdutos-1].Preco,
            Produtos[CodigoProdutos].Preco);
          Produtos[CodigoProdutos-1].Preco := Preco;
          Produtos[CodigoProdutos].Preco := Preco;
        end;
        3:  //M?dia de Pre?os
        begin
          Preco := Mean([Produtos[CodigoProdutos-1].Preco,
            Produtos[CodigoProdutos].Preco]);
          Produtos[CodigoProdutos-1].Preco := Preco;
          Produtos[CodigoProdutos].Preco := Preco;
        end;
      end;
        Politica := False;
        exit;
    end
  else
    if (Produtos[CodigoProdutos].Quantidade = '0,5') and (not Politica) then Politica := True;
end;

procedure TMicro.Imprimir(QtdeProdutos: Integer);
var
   cupom: TStrings;
   TotalPedido, TotalProdutos :Real;
   i :Integer;
   txtFile: TextFile;
   PrinterPatch: ShortString;
   Ordem: Integer;
   TotalPessoa: Real;
begin
    SqlRun('Commit;',Net,False);
   {Pega Endereco da Impressoara do Banco de Dados}
   SqlRun('SELECT CAMINHOIMPRESSORA FROM IMPRESSORA WHERE CODIGOIMPRESSORA = ' +
     LeIni('PRINTERS','PRINTER' +  IntToStr(Codigo)), Dm.Tbl_Impressoras);

   PrinterPatch := Dm.Tbl_Impressoras.Fields[0].AsString;
   LogSend('logs\MT' + IntToStr(Codigo)+'\' + FormatDateTime('YYYYMMDD',Date) + ' SMT.LOG','Caminho da impressora : ' + Dm.Tbl_Impressoras.Fields[0].AsString + ' - Terminal ' + IntToStr(codigo));
   {Faz Consulta no Pedido para Gravar Dados}
   SqlRun('SELECT * FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' + IntToStr(StrToIntDef( Mesa,0)), Dm.Tbl_Impressoras);

   TotalPedido := Dm.Tbl_Impressoras.FieldByName('TOTALPEDIDO').AsFloat;
   TotalProdutos := 0;
   //   TotalProdutos := Dm.Tbl_Impressoras.FieldByName('TOTALPRODUTOS').AsFloat;


   TotalAcrescimo := FloatToStr(Dm.Tbl_Impressoras.FieldByName('DESPESASACESSORIAS').AsFloat);
   TotalDesconto := FloatToStr(Dm.Tbl_Impressoras.FieldByName('DESCONTO').AsFloat);
   LogSend('logs\MT' + IntToStr(Codigo)+'\' + FormatDateTime('YYYYMMDD',Date) + ' SMT.LOG',Format('Valor do pedido %2.2f . Despesas acessorias %s . Terminal %d',[totalpedido,TotalAcrescimo, codigo]));
   {Rotina para Impressao em Impressora Windows 40 Colunas}
   cupom := TStringList.Create;
   cupom.Add('----------------------------------------');
   cupom.Add(CenterText(Format('DATA: %s HORA: %s ', [DateToStr(now),TimeToStr(now)]),40));//Agora imprime a data
   cupom.Add('Micro terminal: '+IntToStr(Codigo));
   cupom.Add('----------------------------------------');
   cupom.Add(CenterText(S_NomePedido +' ' + Mesa,40));
   cupom.Add('----------------------------------------');
   cupom.Add('ITEM         CODIGO            DESCRICAO');
   cupom.Add('QUANTIDADE x VALOR UNIT.     VALOR ('+ CurrencyString + ')');
   cupom.Add('----------------------------------------');

   Ordem := 1; {Variavel de ordem dos produtos na Nota}
   while QtdeProdutos <> 0 do
   begin
    SqlRun(' SELECT P.NOMEPRODUTO FROM PRODUTO P WHERE P.CODIGOPRODUTO = ' +
           Produtos[QtdeProdutos].Codigo, Rede);

     cupom.Add(Format('%0.3d %s %s ',
     [Ordem, FormatFloat('0000000000000', StrToFloat(Produtos[QtdeProdutos].Codigo)),
     (Rede.Fields[0].AsString)]));

     cupom.Add(Format('%3.3fx%11.2f = ' + CurrencyString + '%16.2f',
     [ StrToFloat(Produtos[QtdeProdutos].Quantidade), Produtos[QtdeProdutos].Preco,
     (Produtos[QtdeProdutos].Preco * StrToFloat(Produtos[QtdeProdutos].Quantidade))]));
     Ordem := Ordem + 1;
     TotalProdutos := TotalProdutos + (Produtos[QtdeProdutos].Preco * StrToFloatDef(Produtos[QtdeProdutos].Quantidade,1));
     QtdeProdutos := QtdeProdutos - 1;
   end;
     //Acerto para ficar = ao dos prolixos. - 27/05/2003 - Charles
     cupom.Add('----------------------------------------');

       cupom.Add( Format(ifthen(B_UsaServico,'SUBTOTAL','TOTAL   ') + '     = %3s %20.2f ', [CurrencyString, TotalProdutos]));
       if B_UsaServico then
       begin
            if (Copy(LeINI('SMT','DESCONTO'),1,1) = '%') then
              cupom.Add(Format('DESCONTO (%0.2f%1s) = %3s %14.2f%', [PorcentagemDesconto, '%', CurrencyString, StrToFloat(TotalDesconto)]))
            else
              cupom.Add(Format('DESCONTO     = %3s %20.2f%', [CurrencyString, StrToFloat(TotalDesconto)]));

            if (Copy(LeINI('SMT','ACRESCIMO'),1,1) = '%') then
              cupom.Add(Format('ACRESCIMO (%0.2f%1s) = %3s %14.2f%', [PorcentagemAcrescimo, '%', CurrencyString, StrToFloat(TotalAcrescimo)]))
            else
              cupom.Add(Format('ACRESCIMO    = %3s %20.2f%', [CurrencyString, StrToFloat(TotalAcrescimo)]));
            cupom.Add(Format('TOTAL        = %3s %20.2f ', [CurrencyString, TotalPedido]));

       end;
      //Pega C?digo do Vendedor
         SqlRun(' SELECT V.CODIGOVENDEDOR ' +
                ' FROM PEDIDOVENDA PV ' +
                ' INNER JOIN VENDEDOR V ON (V.VEN_CODVENDEDOR = PV.VEN_CODVENDEDOR) ' +
                ' WHERE PV.NUMEROPEDIDO = ' + Mesa + ';'
                 , Rede);
         Vendedor := Rede.Fields[0].AsString;

         SqlRun(' SELECT P.PES_NOME_A, V.VEN_CODVENDEDOR ' +
                ' FROM VENDEDOR V ' +
                ' INNER JOIN PESSOA P ON (P.PES_CODPESSOA = V.PES_CODPESSOA) ' +
                ' WHERE V.CODIGOVENDEDOR = ' + Vendedor + ';'
                 , Rede);

      Vendedor := Rede.Fields[0].AsString + ' - '+Rede.Fields[1].AsString;

       cupom.Add('----------------------------------------');
       cupom.Add(UpperCase(S_NomeVendedor + ' ' + Vendedor));

      {Divide Total por Pessoa}
       if StrToFloat(NPessoas) > 1 then
       begin
        TotalPessoa := TotalPedido / StrToInt(NPessoas);
        cupom.add(format('TOTAL POR PESSOA (%2d) ' + CurrencyString + '%15.2f',[ StrToInt(NPessoas) , TotalPessoa ]));
        LogSend('logs\MT' + IntToStr(Codigo)+'\' + FormatDateTime('YYYYMMDD',Date) + ' SMT.LOG',Format('>Total por pessoa (%d) %2.2f',[StrToInt(NPessoas),TotalPedido]));
       end;

     cupom.Add('----- Sistema Autocom Plus - SMT ------');


     try
        AssignFile(txtFile,PrinterPatch);
        Rewrite(txtFile);

        {Alinha Colunas (40 Carateres)}
        for i := 0 to cupom.Count - 1 do
          cupom.Strings[i] := WrapText(cupom.Strings[i],40);

        {Escreve}
        for i := 0 to cupom.Count - 1 do
         Writeln(txtfile,cupom.Strings[i]);

        {Adiciona Mensagem de Cortesia Linha configuradas no Ini}
        with TIniFile.Create(Patch + 'AUTOCOM.INI') do
        begin
           ReadSectionValues('CORTESIA', cupom);
           Free;
        end;

        {Adiciona Quebras de Linha configuradas no Ini}
        for i := 0 to StrToIntDef(LeIni('PRINTERS','QUEBRADELINHA'),1) do
          Cupom.Add(#13);

        for i := 0 to cupom.Count - 1 do
         Writeln(txtfile,Copy(cupom.Strings[i],Pos('=',cupom.Strings[i])+1,40));
        closefile(txtFile);
     except
        on e:exception do
           begin
              LogSend('logs\MT' + IntToStr(Codigo)+'\' + FormatDateTime('YYYYMMDD',Date) + ' SMT.LOG','Erro na impressao do fechamento - '+S_NomePedido +' ' + Mesa);
              LogSend('logs\MT' + IntToStr(Codigo)+'\' + FormatDateTime('YYYYMMDD',Date) + ' SMT.LOG','Erro:'+e.message);
              Dll_Clear(Codigo);
              Dll_Display(Codigo, CenterText('Erro na impressao do fechamento:'+e.message,40));
              Sleep(500);
           end;
     end;

  FreeAndNil(cupom);
end;

procedure TMicro.GetProdutos;
{Pega Produtos Vendidos da Tabela e Joga no Array}
begin
  SqlRun('SELECT CODIGOPEDIDOVENDA FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' + Mesa ,Net);
  if Net.IsEmpty then Exit;
  SqlRun('SELECT CODIGOPRODUTO, QUANTIDADE, PRECO, OBSERVACAO ' +
         ' FROM PRODUTOPEDIDOVENDA WHERE CODIGOPEDIDOVENDA = ' + Net.Fields[0].AsString +
         ' AND CANCELADO <> 1'
         , Rede);
  CodigoProdutos := 1;
  while not Rede.Eof do
  begin
    Application.ProcessMessages;
    Produtos[CodigoProdutos].Codigo := Rede.FieldByName('CODIGOPRODUTO').AsString;
    Produtos[CodigoProdutos].Quantidade := Rede.FieldByName('QUANTIDADE').AsString;
    Produtos[CodigoProdutos].Preco := Rede.FieldByName('PRECO').AsFloat;
    Produtos[CodigoProdutos].Obs := Rede.FieldByName('OBSERVACAO').AsString;
    CodigoProdutos := CodigoProdutos + 1;
    Rede.Next;
  end;
  CodigoProdutos := CodigoProdutos - 1;
end;

procedure Tmicro.printgrill(pedido:integer;nome_pedido,nome_vendedor:string);
var
   a:integer;
   v_codigo, v_quantidade, v_desc, v_obs:string;
   grill:TextFile;
   cupom:Tstrings;
begin
{Objetivo: Realizar a impress?o dos produtos em impressoras remotas para produ??o
Esta fun??o deve ser usadas nos m?dulos de venda que realizam pedidos de venda  ,
tais como: Venda Pedido, Micro Terminais e Comandas eletr?nicas                 }
     LogSend('logs\MT' + IntToStr(Codigo)+'\' + FormatDateTime('YYYYMMDD',Date) + ' SMT.LOG','Iniciando printgrill do pedido '+inttostr(pedido));

     SqlRun('Commit;',dm.Rede,False);

     SqlRun('select codigoimpressora,caminhoimpressora,NOMEIMPRESSORA from impressora order by codigoimpressora;', Dm.Tbl_Impressoras);

     try
        if Dm.Tbl_Impressoras.IsEmpty=false then
           begin
              Dm.Tbl_Impressoras.first;
              while not Dm.Tbl_Impressoras.eof do
                 begin
                    SqlRun('select ppv.codigoproduto, ppv.quantidade, ppv.observacao, prod.nomeproduto, ppv.codigopedidovenda '+
                             'from produtopedidovenda ppv, produto prod ,pedidovenda pv, subgrupoproduto sg, grupoproduto g '+
                             'where ppv.codigoproduto=prod.codigoproduto '+
                             ' and (ppv.impresso<>'+chr(39)+'X'+chr(39)+' or ppv.impresso is null)'+
                             ' and (ppv.cancelado<>'+'1'+' or ppv.cancelado is null)'+
                             ' and ppv.codigopedidovenda=pv.codigopedidovenda'+
                             ' and pv.numeropedido='+inttostr(pedido)+
                             ' and prod.codigosubgrupoproduto=sg.codigosubgrupoproduto'+
                             ' and sg.codigogrupoproduto=g.codigogrupoproduto'+
                             ' and g.codigoimpressora='+Dm.Tbl_Impressoras.fieldbyname('codigoimpressora').asstring +
                             ' ORDER BY ppv.codigoprodutopedido ', Dm.pt);
                    if Dm.pt.IsEmpty=false then
                       begin
                          Dll_Clear(Codigo);
                          Dll_Display(Codigo, CenterText('Realizando Print Grill: '+trim(Dm.Tbl_Impressoras.fieldbyname('NOMEIMPRESSORA').asstring),40));
                          LogSend('logs\MT' + IntToStr(Codigo)+'\' + FormatDateTime('YYYYMMDD',Date) + ' SMT.LOG','Realizando Print Grill: '+trim(Dm.Tbl_Impressoras.fieldbyname('NOMEIMPRESSORA').asstring));
                          sleep(100);

                          SQLRun('select p.pes_nome_a '+
                             'from pessoa p, vendedor v,pedidovenda pv '+
                             'where pv.ven_codvendedor=v.ven_codvendedor '+
                             ' and v.pes_codpessoa=p.pes_codpessoa '+
                             ' and pv.numeropedido='+inttostr(pedido),dm.Rede);

                          cupom := TStringList.Create;
                          cupom.add('******************************');
                          cupom.add('  '+nome_pedido+' : '+inttostr(pedido));
                          cupom.add('******************************');
                          cupom.add('  '+nome_vendedor+' : '+DM.Rede.fieldbyname('pes_nome_a').asstring);
                          cupom.add('******************************');
                          cupom.add('Data: '+datetostr(date));
                          cupom.add('Hora: '+timetostr(time));

                          Dm.pt.first;
                          While not Dm.pt.eof do
                             Begin
                                v_codigo:=Dm.pt.fieldbyname('codigoproduto').asstring;
                                v_quantidade:=Dm.pt.fieldbyname('quantidade').asstring;
                                v_desc:=Dm.pt.fieldbyname('nomeproduto').asstring;
                                v_obs:=trim(Dm.pt.fieldbyname('observacao').asstring);

                                cupom.add(copy(v_quantidade,1,4)+'.'+copy(v_quantidade,5,3)+' ['+v_desc+']');
                                if length(v_obs)>0 then
                                   begin
                                      cupom.add(v_obs);
                                   end;
                                sqlrun('update produtopedidovenda set impresso='+chr(39)+'X'+chr(39)+
                                ' where codigoproduto='+v_codigo+
                                ' and codigopedidovenda='+Dm.pt.fieldbyname('codigopedidovenda').asstring,dm.rede,false);

                                dm.pt.next;
                             End;
                          cupom.add('Area de impressao: '+trim(Dm.Tbl_Impressoras.fieldbyname('NOMEIMPRESSORA').asstring));
                          cupom.add('Terminal: Micro-terminal '+inttostr(codigo));
                          cupom.add('-- Sistema Autocom --');
                          cupom.add(chr(10)+chr(13));
                          cupom.add(chr(10)+chr(13));
                          cupom.add(chr(10)+chr(13));
                          cupom.add(chr(10)+chr(13));

                          AssignFile(grill, trim(Dm.Tbl_Impressoras.fieldbyname('caminhoimpressora').asstring));
                          rewrite(grill);
                          for a:=0 to cupom.count-1 do
                             begin
                                writeln(grill,cupom.Strings[a]);
                             end;
                          closefile(grill);
                          FreeAndNil(cupom);
                       end;
                    Dm.Tbl_Impressoras.next;
                 end;
           end;

        SqlRun('Commit;',dm.rede,False);
        LogSend('logs\MT' + IntToStr(Codigo)+'\' + FormatDateTime('YYYYMMDD',Date) + ' SMT.LOG','Printgrill do pedido '+inttostr(pedido)+' OK!!!');

     except
        on e:exception do
           begin
              SqlRun('commit',dm.rede,False);
              Dll_Clear(Codigo);
              Dll_Display(Codigo, CenterText('Erro de impressao na Print Grill: '+trim(Dm.Tbl_Impressoras.fieldbyname('NOMEIMPRESSORA').asstring),40));
              LogSend('logs\MT' + IntToStr(Codigo)+'\' + FormatDateTime('YYYYMMDD',Date) + ' SMT.LOG','Printgrill do pedido '+inttostr(pedido)+' com ERRO:'+e.message);
              sleep(3000);
           end;
     end;
end;

                                                                     {  Thread |
|                                                                              |
|                                    Eventos                                   |
|______________________________________________________________________________}

procedure TMicro.ThreadTimer(Sender: TObject);
begin
  {Pega Teclas Pressionadas no Micro-Terminal e Registra em Variavel}
  GetKeys;
end;


procedure TFrmMain.ApplicationEventsException(Sender: TObject; E: Exception);
var
   i:Integer;
begin
     if Pos('DEADLOCK',uppercase(e.Message)) > 0 THEN
     begin
        for i :=  1 to I_NumeroTerminais do
           begin
              Dll_Display(i,S_NomePedido + ' em uso em outro terminal!');
              LogSend('logs\MT' + IntToStr(i)+'\' + FormatDateTime('YYYYMMDD',Date) + ' SMT.LOG',E.Message);
           end;
     end
        else
        begin
              for i :=  1 to I_NumeroTerminais do
                begin
                   Dll_Display(i,' Erro. Pressione [LIMPA].');
                   LogSend('logs\MT' + IntToStr(i)+'\' + FormatDateTime('YYYYMMDD',Date) + ' SMT.LOG','Geral:'+E.Message);
                end;
        end;
end;



procedure TFrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
var
   i: integer;
begin
  for i := 1 to I_NumeroTerminais do
    begin
      Dll_Clear(i);
      Dll_Display(i,CenterText('Sistema Autocom Plus - SMT',40));
      Dll_PosCur(i,1,0);;
      Dll_Display(i,CenterText('Servidor desligado',40));
    end;
end;



initialization
begin
end;

finalization
begin
end;

end.
