//******************************************************************************
//
//                 UNIT UROTINAS (-)
//
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           uRotinas.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: uRotinas.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:
//
// 1.0.0 01/01/2001 First Version
//
//******************************************************************************

unit uRotinas;

interface
uses Controls, Windows, classes, Forms, db, DIALOGS, udmpdv, messages;
//declaração das funcoes da dll de comunicação com ecf.
type
    FLeituraX = function(tipo, porta: integer; NF: string): shortstring;
    FAbrecupom = function(tipo, porta: integer; texto: string): ShortString;
    FInicioDia = function(tipo, porta: integer; verao, op, modal: string):
        shortstring;
    FTextoNF = function(tipo, porta: integer; texto, valor: string):
        shortstring;
    FFecharCupom = function(tipo, porta: integer; SegCp, CNFV, l1, l2, l3, l4,
        l5,
        l6, l7, l8: string): shortstring;
    FFinalizadia = function(tipo, porta: integer): shortstring;
    FECF_INFO = function(tipo, porta: integer): ShortString;
    FLancaitem = function(tipo, porta: integer; cod, nome, qtde, prunit, prtot,
        Trib: string): shortstring;
    FTotalizacupom = function(tipo, porta: integer; Moda, valor: string):
        shortstring;
    FCancelacupom = function(tipo, porta: integer; venda, valor: string):
        shortstring;
    FVenda_liquida = function(tipo, porta: integer): shortstring;
    FDescSub = function(tipo, porta: integer; val: string): shortstring;
    FAcreSub = function(tipo, porta: integer; val, tipacre: string):
        shortstring;
    FCOO = function(tipo, porta: integer; tipo_coo: string): shortstring;
    FAbreGaveta = function(tipo, porta: integer): shortstring;
    FContra_vale = function(tipo, porta: integer; valor: string): shortstring;
    FCheque = function(tipo, porta: integer; banco, valor, data, favorecido,
        municipio, cifra, moedas, moedap: string): shortstring;
    FFCX = function(tipo, porta: integer; modal, valor: string): ShortString;
    FstatusLogAtual = function(terminal, loja: string): ShortString;
    FFlag_venda = function(tipo: integer): ShortString;
    Fcancela_venda_log = function(tipo: integer; terminal, loja: string):
        ShortString;
    FPrintgrill = procedure(Value: Integer; legenda, indicador: string);

procedure GravaINI(strSessao, strChave, strValor: string; strArquivo: string =
    'dados\autocom.ini');
function LeINI(strSessao, strChave: string; strArquivo: string =
    'dados\autocom.ini'): Variant;
procedure Log(texto: string); // monta o log
function CenterText(Text: string; Size: Integer): string;
function RoundUP(Value: Real): real; overload;
function RoundUP(Value: string): real; overload;
procedure LancaCupomFiscal(cdsItems: TDataSet; NumeroPedido, Vendedor, COO, ECF:
    string; janela:HWND = 0);
function AbreGaveta: boolean;
function GavetaAberta: Boolean;
procedure GravaMovimentoExtra(valor: Real; CondicaoPagamento, motivo, ncp:
    string);
procedure GravaCabecalhoCupom(numero_pedido, ncp: string);
procedure GravaDetalheCupom(numero_pedido, ncp: string);
procedure GravaCancelamentoVenda(ncp: string);
procedure GravaFechamentoCupom(CondicaoPagamento, repique, troco,
    contravale, recebido, banco, NumeroCheque,
    agencia, conta, datapre, vendedor, NCP, pedido: string);
function DataMovimento(): TDateTime;

//para implementar depois.
function TrataerroImpressora(strResposta: string; bShow: boolean = true):
    Boolean;
procedure AjustaAcrescimo(v_fechamento, pedido: string;
    funcao: Integer);

const
    TITULO_MENSAGEM = 'Sistema Autocom Plus';
        // Valor usado nas caixas de mensagem
    TIPO_TERMINAL = 'RESTAURANTE';
    //ALTERAR DE ACORDO COM O TERMINAL. VALORES :  RESTAURANTE, DELIVERY

var
    printgrill2: FPrintgrill;
    UltimoCOO, NumeroECf: string;
    handmutex:THandle;

implementation
uses IniFiles, SysUtils, Math, StrUtils;

{-----------------------------------------------------------------------------
  Procedure: GravaINI
  Autor:    charles
  Data:      13-abr-2003
  Argumentos: strSessao, strChave, strValor, strArquivo: string
  Retorno:    None
  Grava informações em qquer arquivo ini.
-----------------------------------------------------------------------------}

procedure GravaINI(strSessao, strChave, strValor,
    strArquivo: string);
begin
    with TIniFile.Create(strarquivo) do
    begin
        WriteString(strSessao, strChave, strValor);
        Free;
    end;
end;

{-----------------------------------------------------------------------------
  Procedure: LeINI
  Autor:    charles
  Data:      13-abr-2003
  Argumentos: strSessao, strChave, strArquivo: string
  Retorno:    variant
  Le as informações gravadas em qquer arquivo ini.
-----------------------------------------------------------------------------}

function LeINI(strSessao, strChave, strArquivo: string): variant;
begin
    with TIniFile.Create(strArquivo) do
    begin
        Result := ReadString(strSessao, strChave, '');
        Free;
    end;
end;

{-----------------------------------------------------------------------------
  Procedure: Log
  Autor:    charles
  Data:      13-abr-2003
  Argumentos: texto:string
  Retorno:    None
  Monta o log da dll. (proteção contra Heldere's)
-----------------------------------------------------------------------------}
procedure Log(texto: string);
var
    LOGfile: textfile;
begin
    // Agora sim grava na pasta logs -  Charles 23/10/2003
    ForceDirectories(extractfilepath(application.exename) + 'logs');
    AssignFile(LOGfile, extractfilepath(application.exename) +'logs\' + TIPO_TERMINAL +
        '_'
        + FormatDateTime('yyyymmdd', now) + '.LOG');
    if not fileexists(extractfilepath(application.exename) + 'logs\' + TIPO_TERMINAL + '_'
        +
        FormatDateTime('yyyymmdd', now) + '.LOG') then
        Rewrite(logfile)
    else
        Reset(Logfile);
    Append(logfile);
    Writeln(logfile, datetimetostr(now) + ' - ' + texto);
    Flush(logfile);
    closefile(logfile);
end;

{-----------------------------------------------------------------------------
  Procedure: CenterText
  Autor:    charles
  Data:      04-abr-2003
  Argumentos: Text:string;Size:Integer
  Retorno:    string
  Centraliza uma string;
-----------------------------------------------------------------------------}
function CenterText(Text: string; Size: Integer): string;
var
    i: Integer;
begin
    for i := 0 to (Size - Length(Text)) div 2 do
        Text := ' ' + Text;
    Result := Text;
end;

{-----------------------------------------------------------------------------
  Procedure: RoundUP
  Autor:    charles
  Data:      19-mai-2003
  Argumentos: Value:Real
  Retorno:    real
-----------------------------------------------------------------------------}

function RoundUP(Value: Real): real; overload;
begin
    result := Value + 0.005;
end;

{-----------------------------------------------------------------------------
  Procedure: RoundUP
  Autor:    charles
  Data:      19-mai-2003
  Argumentos: Value:string
  Retorno:    real
-----------------------------------------------------------------------------}
function RoundUP(Value: string): real; overload;
begin
    Result := StrToFloat(value);
end;

{-----------------------------------------------------------------------------
  Procedure: LancaCupomFiscal
  Autor:    charles
  Data:      04-abr-2003
  Argumentos: cdsItems:Pointer;NumeroPedido,Vendedor, COO,ECF:string
  Retorno:    None
  Alias para  a função gravalog venda.
-----------------------------------------------------------------------------}
procedure LancaCupomFiscal(cdsItems: Tdataset; NumeroPedido, Vendedor, COO, ECF:
    string; janela:HWND = 0);
var
    hand: THandle;
    AbreCupom: FAbrecupom;
    COO_cupom: FCOO;
    ECF_INFO:FECF_INFO;
    Cancelacupom:FCancelacupom;
    Lancaitem: FLancaitem;
    strAux: string;
    auxdataset: TDataSet;
    bCabecalhoCupom: Boolean;
    i: Integer;
begin
    log('Lanca cupom fiscal');
    strAux := ExtractFilePath(Application.ExeName) + LeINI('modulos',
        'dll_ECF');
    hand := LoadLibrary(PChar(straux));
    @AbreCupom := GetProcAddress(hand, 'Abrecupom');
    @Lancaitem := GetProcAddress(hand, 'Lancaitem');
    @COO_cupom := GetProcAddress(hand, 'COO');
    @ECF_INFO  := GetProcAddress(hand, 'ECF_INFO');


    straux := ECF_INFO(StrToInt(leini('terminal', 'ModECF')),
        StrToInt(leini('terminal', 'comECF')));

    if trataerroimpressora(strAux,False) then
    begin
         if  strAux[6] <> '0' then
         begin
                Application.MessageBox( 'É necessário reiniciar o sistema para realizar operação de início de dia.',
                                        TITULO_MENSAGEM, MB_OK +  MB_ICONERROR);
                PostMessage(janela, WM_SYSCOMMAND, SC_CLOSE, SC_CLOSE);
                Exit;
         end;
    end;

    if strAux[10] = '1' then  //VERIFICA SE O CUPOM ESTÁ ABERTO.
    begin
         Log('Cupom Aberto. Cancelando');
         @Cancelacupom := GetProcAddress(hand, 'Cancelacupom');
         straux := Cancelacupom(StrToInt(leini('terminal', 'ModECF')),
                   StrToInt(leini('terminal', 'comECF')),
                   '1',LeINI(TIPO_TERMINAL,'valorultimocupom'));
         Log('Cancelamento de cupom : ' + strAux);
         GravaCancelamentoVenda(LeINI(TIPO_TERMINAL,'ultimocupom'));
    end;

    straux := AbreCupom(StrToInt(leini('terminal', 'ModECF')),
        StrToInt(leini('terminal', 'comECF')), '');
    bCabecalhoCupom := trataerroimpressora(straux, False);

    log('Abertura do cupom ' + strAux);
    cdsItems.First;
    log('QTD de itens deste cupom : ' + IntToStr(cdsItems.RecordCount));

    straux := COO_cupom(StrToInt(leini('terminal', 'ModECF')),
        StrToInt(leini('terminal', 'comECF')), '1');
    i := 0;
    while straux[1] <> '@' do
    begin
        // corrigido para tentar algumas vezes antes de sair por erro.
        strAux := COO_cupom(StrToInt(leini('terminal', 'ModECF')),
            StrToInt(leini('terminal', 'comECF')), '1');
        Inc(i);
        if i > 2 then
        begin
            TrataerroImpressora(strAux);
            Exit;
        end;
    end;
    straux := Copy(straux, 2, 6);
    auxdataset := dmORC.ConsultaPedido(NumeroPedido);
    GravaINI(TIPO_TERMINAL, 'ultimocupom', strAux);
    GravaINI(TIPO_TERMINAL, 'valorultimocupom',
        auxdataset.FieldByName('totalpedido').AsString);
    if bCabecalhoCupom then
        GravaCabecalhoCupom(NumeroPedido, strAux);
    while not cdsItems.Eof do
    begin
        Log('Lancando item codigo : ' +
            cdsItems.FieldByName('CODIGO').AsString);
        if cdsItems.FieldByName('situacao').AsInteger = 0 then
            Lancaitem(StrToInt(leini('terminal', 'ModECF')),
                StrToInt(leini('terminal', 'comECF')),
                cdsItems.FieldByName('CODIGO').AsString,
                cdsItems.FieldByName('DESCRICAO').AsString, (
                cdsItems.FieldByName('CasasDecimais').AsString + format('%4.' +
                cdsItems.FieldByName('CasasDecimais').AsString + 'f',
                [cdsItems.FieldByName('QUANTIDADE').AsFloat])),
                { DONE -oCharles -cAcerto. : Casas decimais vindo da tabela. }
                cdsItems.FieldByName('Valor Unitario').AsString,
                cdsItems.FieldByName('TOTAL').AsString,
                dmORC.BuscaTributacao(dmorc.BuscaEstado(leini('Loja','Lojanum')),
                cdsItems.FieldByName('CODIGO').AsString));
        { DONE : Não esquecer de arrumar a tributação. Por enquanto está chumbada. }
        cdsItems.Next;
    end;
    gravadetalhecupom(NumeroPedido, straux);
    // Faltava lançar Item de servico no cupom fiscal - 25/04/2003 - Charles
    if auxdataset.FieldByName('DespesasAcessorias').AsFloat > 0 then
    begin
        Lancaitem(StrToInt(leini('terminal', 'ModECF')),
            StrToInt(leini('terminal', 'comECF')),
            '99999999999',
            'Taxa de Servico',
            '21.00', { DONE -oCharles -cAcerto. : Casas decimais vindo da tabela. }
            auxdataset.FieldByName('DespesasAcessorias').AsString,
            auxdataset.FieldByName('DespesasAcessorias').AsString, 'I  ');
        // servico é isento.
    end;
    FreeLibrary(hand);
end;

{-----------------------------------------------------------------------------
  Procedure: AbreGaveta
  Autor:    charles
  Data:      08-abr-2003
  Argumentos: None
  Retorno:    boolean
  Abre a gaveta e retorna se obteve sucesso ou não.
-----------------------------------------------------------------------------}

function AbreGaveta: boolean;
var
    hand: THandle;
    AbrirGaveta: FAbreGaveta;
    straux: string;
begin
    straux := ExtractFilePath(Application.ExeName) + LeINI('modulos',
        'dll_gaveta');
    hand := LoadLibrary(PChar(straux));
    @AbrirGaveta := GetProcAddress(hand, 'AbreGaveta');
    Result := (AbrirGaveta(StrToInt(leini('terminal', 'ModECF')),
        StrToInt(leini('terminal', 'comECF')))[1] = '@');
    FreeLibrary(hand);
end;

{-----------------------------------------------------------------------------
  Procedure: GavetaAberta
  Autor:    charles
  Data:      08-abr-2003
  Argumentos: None
  Retorno:    boolean
  verifica o estado da gaveta
  true : gaveta aberta.
  false : gaveta fechada.
-----------------------------------------------------------------------------}
function GavetaAberta: boolean;
var
    hand: THandle;
    ECFInfo: FECF_INFO;
    straux: string;
begin
    straux := ExtractFilePath(Application.ExeName) + LeINI('modulos',
        'dll_gaveta');
    hand := LoadLibrary(PChar(straux));
    @ECFInfo := GetProcAddress(hand, 'ECF_INFO');
    Result := (ECFInfo(StrToInt(leini('terminal', 'ModECF')),
        StrToInt(leini('terminal', 'comECF')))[9] = '1');
    FreeLibrary(hand);
end;

{-----------------------------------------------------------------------------
  Procedure: TrataerroImpressora
  Autor:    charles
  Data:      19-mai-2003
  Argumentos: strResposta:string;bShow:boolean = true
  Retorno:    boolean
-----------------------------------------------------------------------------}
function TrataerroImpressora(strResposta: string; bShow: boolean = true):
    boolean;
begin
    log(ifthen(strResposta[1] = '@', 'ECF OK -> ' + strResposta,
        'ECF -> ERRO: '));
    result := strResposta[1] = '@';
    if bShow and (not result) then
        Application.MessageBox(pchar('Ocorreu um erro durante o envio do comando para a impressora. '#10#13 +
            'Erro:' + strResposta), TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
end;

{-----------------------------------------------------------------------------
  Procedure: GravaCabecalhoCupom
  Autor:    charles
  Data:      19-mai-2003
  Argumentos: numero_pedido, ncp:string
  Retorno:    None
-----------------------------------------------------------------------------}
procedure GravaCabecalhoCupom(numero_pedido, ncp: string);
var
    auxDataset: TDataSet;
begin
    auxDataset := dmORC.ConsultaPedido(numero_pedido);
    DecimalSeparator := '.';
    with auxDataset do
        dmorc.RunSQL('INSERT INTO PDV_cabecalhocupom ' +
            '(SITUACAO, CFG_CODCONFIG, ' +
            '  CLI_CODCLIENTE, ' +
            '  VEN_CODVENDEDOR, ' +
            '  IDUSUARIO, ' +
            '  DATAHORA, TERMINAL, ECF, NCP, VALORCUPOM, ACRESCIMO, NUMEROCLIENTES, DESCONTO ) ' +
            'VALUES ' +
            '(0, 1,1,' +
            FieldByName('ven_codvendedor').AsString + ', ' +
            IntToStr(LeINI('oper', 'codigo', 'dados\oper.ini')) + ', ' +
            quotedstr(FormatDateTime('mm/dd/yyyy hh:nn:ss', DataMovimento)) +
                ', ' +
            IntToStr(leini('terminal', 'PDVNum')) + ', ' +
            NumeroECf + ', ' +
            ncp + ', ' +
            FieldByName('totalpedido').AsString + ', ' {+
            FieldByName('despesasacessorias').AsString}+ '0, ' +
            //gravando sempre 'zero' nas despesas acessorias.
            FieldByName('numpessoas').AsString + ',0 )');
    DecimalSeparator := ',';
    FreeAndNil(auxDataset);
end;

{-----------------------------------------------------------------------------
  Procedure: GravaDetalheCupom
  Autor:    charles
  Data:      19-mai-2003
  Argumentos: numero_pedido, ncp:string
  Retorno:    None
-----------------------------------------------------------------------------}
procedure GravaDetalheCupom(numero_pedido, ncp: string);
var
    auxdataset, auxPedido: TDataSet;
    desconto, acrescimo, qtdItems: real;

begin
    qtdItems := 0;
    auxPedido := dmORC.ConsultaPedido(numero_pedido);
    acrescimo := auxPedido.FieldByName('despesasacessorias').AsFloat;
    desconto := auxPedido.FieldByName('desconto').AsFloat;

    auxdataset := dmORC.ConsultaDetalhePedido(numero_pedido);
    auxdataset.Last;
    auxdataset.First;

    while not auxdataset.Eof do
    begin
        qtdItems := qtdItems + auxdataset.FieldByName('quantidade').AsFloat;
        auxdataset.Next;
    end;
    auxdataset.First;

    DecimalSeparator := '.';
    with auxdataset do
    begin
        while not Eof do
        begin
            dmORC.RunSQL('INSERT INTO PDV_DETALHECUPOM ' +
                '( SITUACAO, CFG_CODCONFIG, CLI_CODCLIENTE, VEN_CODVENDEDOR, ' +
                'IDUSUARIO, DATAHORA, NCP, TERMINAL, CODIGOPRODUTO,' +
                'SEQ, VALORUN, QTDE,motivo_cancelamento, DESCONTO, ACRESCIMO,SITUACAO) ' +
                'VALUES ' +
                '(0, 1,1, ' +
                auxPedido.FieldByName('VEN_CODVENDEDOR').AsString + ', ' +
                inttostr(LeINI('OPER', 'CODIGO', 'dados\oper.ini')) + ', ' +
                QuotedStr(FormatDateTime('mm/dd/yyyy hh:nn:ss', dataMovimento)) +
                    ', ' +
                ncp + ', ' +
                IntToStr(leini('terminal', 'PDVNum')) + ', ' +
                FieldByName('codigoPRODUTO').AsString + ', ' +
                FieldByName('codigoprodutopedido').AsString + ', ' +
                floattostr(FieldByName('preco').AsFloat) + ', ' +
                FieldByName('quantidade').AsString + ', ' +
                QuotedStr(FieldByName('motivo_cancelamento').AsString) + ', ' +
                '0, ' +
                '0, ' +
                FieldByName('cancelado').AsString + ') '
                );
            Next;
        end;
    end;

    if desconto > 0 then
        ajustaacrescimo(floattostr(desconto), numero_pedido, 3);

    if acrescimo > 0 then
        ajustaacrescimo(floattostr(acrescimo), numero_pedido, 1);

    freeandnil(auxdataset);
    freeandnil(auxPedido);
    DecimalSeparator := ',';
end;

{-----------------------------------------------------------------------------
  Procedure: GravaFechamentoCupom
  Autor:    charles
  Data:      19-mai-2003
  Argumentos: CondicaoPagamento, repique, troco, contravale, recebido, banco,
              NumeroCheque, agencia, conta, datapre, vendedor, NCP:string
  Retorno:    None
-----------------------------------------------------------------------------}

procedure GravaFechamentoCupom(CondicaoPagamento, repique, troco,
    contravale, recebido, banco, NumeroCheque,
    agencia, conta, datapre, vendedor, NCP, pedido: string);
var
   sql_txt:string;
begin
    DecimalSeparator := '.';
    sql_txt:='INSERT INTO PDV_FECHAMENTOCUPOM  ' +
        '(TERMINAL, NCP, DATAHORA, CFG_CODCONFIG, CLI_CODCLIENTE, VEN_CODVENDEDOR,  ' +
        ' IDUSUARIO, CODIGOCONDICAOPAGAMENTO , REPIQUE, CONTRAVALE, TROCO, ' +
        ' VALORRECEBIDO, BANCO, NUMEROCHEQUE, AGENCIA, CONTA, DATAPRE, oid, NUMEROPEDIDO)' +
        ' VALUES ' +
        '(' +
        IntToStr(leini('terminal', 'PDVNum')) + ', ' +
        NCP + ', ' +
        QuotedStr(FormatDateTime('mm/dd/yyyy hh:nn:ss', datamovimento)) + ', ' +
        '1' + ', ' +
        '1' + ', ' +
        vendedor + ', ' +
        inttostr(LeINI('OPER', 'CODIGO', 'dados\oper.ini')) + ', ' +
        CondicaoPagamento + ', ' +
        ifthen(StrToFloat(repique) = 0, 'NULL', repique) + ', ' +
        ifthen(StrToFloat(contravale) = 0, 'NULL', contravale) + ', ' +
        ifthen(StrToFloat(troco) = 0, 'NULL', troco) + ', ' +
        ifthen(StrToFloat(recebido) = 0, 'NULL', recebido) + ', ' +
        ifthen(StrToFloat(banco) = 0, 'NULL', banco) + ', ' +
        ifthen(StrToFloat(NumeroCheque) = 0, 'NULL', numerocheque) + ', ' +
        ifthen(StrToFloat(agencia) = 0, 'NULL', agencia) + ', ' +
        ifthen(StrToFloat(conta) = 0, 'NULL', conta) + ', ' +
        QuotedStr(datapre) + ',1, '+ pedido + ') ';
    dmorc.RunSQL(sql_txt);

    log('Fechamento cupom:' + sql_txt);

    DecimalSeparator := ',';
end;

{-----------------------------------------------------------------------------
  Procedure: GravaMovimentoExtra
  Autor:    charles
  Data:      19-mai-2003
  Argumentos: valor:Real; CondicaoPagamento, motivo, ncp:string
  Retorno:    None
-----------------------------------------------------------------------------}

procedure GravaMovimentoExtra(valor: Real; CondicaoPagamento, motivo, ncp:
    string);
begin
    DecimalSeparator := '.';
    dmorc.RunSQL('INSERT INTO PDV_MOVIMENTOEXTRA ' +
        '(CFG_CODCONFIG, DATA, HORA, TERMINAL, IDUSUARIO, ' +
        'CODIGOCONDICAOPAGAMENTO, VALOR, DESCRICAO, NCP) ' +
        'VALUES (' +
        '1, ' +
        QuotedStr(FormatDateTime('mm/dd/yyyy', datamovimento)) + ', ' +
        QuotedStr(FormatDateTime('hh:nn:ss', GetTime)) + ', ' +
        IntToStr(leini('terminal', 'PDVNum')) + ', ' +
        inttostr(LeINI('OPER', 'CODIGO', 'dados\oper.ini')) + ', ' +
        CondicaoPagamento + ', ' +
        FloatToStr(valor) + ', ' +
        ifthen(trim(motivo) = '', 'NULL', quotedstr(motivo)) + ', ' +
        ncp + ')'
        );
    DecimalSeparator := ',';
end;

{-----------------------------------------------------------------------------
  Procedure: GravaCancelamentoVenda
  Autor:    charles
  Data:      19-mai-2003
  Argumentos: ncp:string
  Retorno:    None
-----------------------------------------------------------------------------}

procedure GravaCancelamentoVenda(ncp: string);
begin
    //NÃO ESQUECER DE SEMPRE VERIFICAR AS DATAS COM BETWEEN
    // CANCELA O CABECALHO CUPOM. 21/06/2003 - CHARLES
    Log('Gravando cancelamento do cupom numero : ' + ncp);
    dmorc.RunSQL('UPDATE PDV_CABECALHOCUPOM SET ' +
        'SITUACAO = 1 ' +
        'WHERE ' +
        'NCP = ' + NCP + ' AND ' +
        'TERMINAL = ' + IntToStr(leini('terminal', 'pdvnum')) + ' AND ' +
        'CFG_CODCONFIG = 1' + ' AND ' +
        'ECF = ' + IntToStr(strtoint(NumeroECf)) + ' AND DATAHORA BETWEEN ' +
        quotedstr(FormatDateTime('mm/dd/yyyy', datamovimento)) + ' AND ' +
        QuotedStr(FormatDateTime('mm/dd/yyyy 23:59', datamovimento))
        );
    // CANCELA OS ITEMS DO CUPOM.
    dmorc.RunSQL('UPDATE PDV_DETALHECUPOM SET ' +
        'SITUACAO = 1 ' +
        'WHERE ' +
        'CFG_CODCONFIG = 1 AND ' +
        'TERMINAL =' + IntToStr(leini('terminal', 'pdvnum')) + ' AND ' +
        'NCP = ' + NCP + ' AND DATAHORA BETWEEN ' +
        quotedstr(FormatDateTime('mm/dd/yyyy', datamovimento)) + ' AND ' +
        QuotedStr(FormatDateTime('mm/dd/yyyy 23:59', datamovimento))
        );
    DMORC.commit;
end;

{-----------------------------------------------------------------------------
  Procedure: DataMovimento
  Autor:    charles
  Data:      19-mai-2003
  Argumentos:
  Retorno:    TDateTime
-----------------------------------------------------------------------------}

function DataMovimento(): TDateTime;
begin
    if StrToIntDef(LeINI(TIPO_TERMINAL, 'tot_mov'), 0) = 0 then
        Result := now
    else
        Result := StrToDate(leini('oper', 'data', 'dados\oper.ini')) + GetTime;

end;

procedure AjustaAcrescimo(v_fechamento, pedido: string;
    funcao: Integer);
var
    auxDataSet: TDataSet;
    auxAcrescimo, auxDesconto, auxQtdItens: real;
begin
    //funcao acrescimo 1 valor
    //funcao acrescimo 2 percentual.
    //funcao desconto  3 valor
    //funcao desconto  4 percentual.
    auxAcrescimo := 0;
    auxDesconto := 0;
    auxDataSet := dmORC.ConsultaPedido(pedido);
    case funcao of
        1: auxAcrescimo := StrToFloatDef(v_fechamento, 0);
        2: auxAcrescimo := auxDataSet.FieldByName('totalprodutos').AsFloat *
            (StrToFloatDef(v_fechamento, 0) / 100);
        3: auxDesconto := StrToFloatDef(v_fechamento, 0);
        4: auxDesconto := auxDataSet.FieldByName('totalprodutos').AsFloat *
            (StrToFloatDef(v_fechamento, 0) / 100);
    end;
    FreeAndNil(auxDataSet);
    DecimalSeparator := '.';
    //informa quanto houve de acréscimo no cupom
    dmORC.RunSQL('UPDATE PDV_CABECALHOCUPOM SET ' +
        'ACRESCIMO = ACRESCIMO + ' + FloatToStr(auxAcrescimo) + ' , ' +
        'DESCONTO  = DESCONTO + ' + FloatToStr(auxDesconto) + ' ' +
        'WHERE (datahora between  ' + QuotedStr(FormatDateTime('mm/dd/yyyy',
        DataMovimento)) +
        ' and ' + QuotedStr(FormatDateTime('mm/dd/yyyy', DataMovimento) +
            ' 23:59')
        +
        ' and ' +
        'cfg_codconfig = 1 and terminal = ' + leini('terminal', 'pdvnum') +
        ' and ncp = ' + LeINI(TIPO_TERMINAL, 'ultimocupom') +
        ' and situacao <> 1)');

    //conta quantos items nao cancelados há no pedido.
    dmORC.RunSQL('SELECT SUM(QTDE) FROM PDV_DETALHECUPOM ' +
        'WHERE (datahora between  ' + QuotedStr(FormatDateTime('mm/dd/yyyy',
        DataMovimento)) +
        ' and ' + QuotedStr(FormatDateTime('mm/dd/yyyy', DataMovimento) +
            ' 23:59')
        +
        ' and ' +
        'cfg_codconfig = 1 and terminal = ' + leini('terminal', 'pdvnum') +
        ' and ncp = ' + LeINI(TIPO_TERMINAL, 'ultimocupom') +
        ' and situacao <> 1)', auxDataSet);
    auxQtdItens := auxDataSet.Fields[0].AsFloat;
    FreeAndNil(auxDataSet);
    //realiza o rateio entre os items.
    dmORC.RunSQL('UPDATE PDV_DETALHECUPOM SET ' +
        'acrescimo = acrescimo + (' + quotedstr(FloatToStr(auxAcrescimo /
        auxQtdItens)) + ')*QTDE ' +
        //'desconto = desconto   - ('+ quotedstr(FloatToStr( (auxDesconto  / auxQtdItens)) )+ ')*QTDE ' +
        'WHERE (datahora between  ' + QuotedStr(FormatDateTime('mm/dd/yyyy',
        DataMovimento)) +
        ' and ' + QuotedStr(FormatDateTime('mm/dd/yyyy', DataMovimento) +
            ' 23:59')
        +
        ' and ' +
        'cfg_codconfig = 1 and terminal = ' + leini('terminal', 'pdvnum') +
        ' and ncp = ' + LeINI(TIPO_TERMINAL, 'ultimocupom') +
        ' and situacao <> 1)');
    //Propaga pelos itens.
    dmORC.RunSQL('UPDATE PDV_DETALHECUPOM SET ' +
        //'acrescimo = acrescimo + ('+ quotedstr(FloatToStr( auxAcrescimo / auxQtdItens))+ ')*QTDE, ' +
        'desconto = desconto   - (' + quotedstr(FloatToStr((auxDesconto /
        auxQtdItens))) + ')*QTDE ' +
        'WHERE (datahora between  ' + QuotedStr(FormatDateTime('mm/dd/yyyy',
        DataMovimento)) +
        ' AND ' + QuotedStr(FormatDateTime('mm/dd/yyyy', DataMovimento) +
            ' 23:59')
        +
        ' AND ' +
        'cfg_codconfig = 1 and terminal = ' + leini('terminal', 'pdvnum') +
        ' and ncp = ' + LeINI(TIPO_TERMINAL, 'ultimocupom') +
        ' AND  situacao <> 1  AND (VALORUN - DESCONTO) > 0 )');

    auxDataSet := dmorc.ConsultaPedido(Pedido);
    auxAcrescimo := auxDataSet.FieldByName('TOTALPEDIDO').AsFloat;
    FreeAndNil(auxDataSet);
    dmORC.RunSQL('SELECT SUM( (QTDE * VALORUN) + ACRESCIMO - DESCONTO) AS TOTAL FROM PDV_DETALHECUPOM ' +
        'WHERE (datahora between  ' + QuotedStr(FormatDateTime('mm/dd/yyyy',
        DataMovimento)) +
        ' and ' + QuotedStr(FormatDateTime('mm/dd/yyyy', DataMovimento) +
            ' 23:59')
        +
        ' and ' +
        'cfg_codconfig = 1 and terminal = ' + leini('terminal', 'pdvnum') +
        ' and ncp = ' + LeINI(TIPO_TERMINAL, 'ultimocupom') +
        ' and situacao <> 1)', auxDataSet
        );
    auxdesconto := auxDataSet.FieldByName('total').AsFloat; //total já rateado
    FreeAndNil(auxDataSet);
    //ainda falta para bater com o total do pedido.

    Log('rateio -> ' + FloatToStrF(auxAcrescimo - auxdesconto, ffFixed, 18, 2));

    if auxAcrescimo > auxdesconto then
    begin
        //selecionar o maior item e adicionar

    end
    else {// passou do total do pedido} if auxAcrescimo < auxdesconto then
    begin

    end;
    DecimalSeparator := ',';
end;

var
    controle_venda: THandle;
initialization
    begin
        log('Inicializando uUotinas');
//        log('Carregando dll de controle de venda');
//        controle_venda := LoadLibrary(PChar(ExtractFilePath(Application.exename)
//            +
//            'ctrv.dll'));
//        log('Carregando funcao reorganiza logs');
//        if StrToIntDef(leini('terminal', 'printgrill'), 0) = 1 then
//        begin
//            log('Print gril configurada. Carregando função.');
//            @printgrill2 := GetProcAddress(controle_venda, 'printgrill2');
//            if @printgrill2 = nil then
//                log('Erro ao carregar print grill.')
//            else
//                log('Sucesso ao carregar print grill.')
//        end;
        log('Inicializando uRotinas ok.');
    end;

finalization
    begin
        log('Finalizando uRotinas');
        FreeLibrary(controle_venda);
        ReleaseMutex(handmutex);
        log('Liberando mutex.');
    end;
end.
//******************************************************************************
//*                          End of File uRotinas.pas
//******************************************************************************

