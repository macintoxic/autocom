//******************************************************************************
//
//                 UNIT UDMPDV (-)
//
//******************************************************************************
// Project:        M�dulo PDV - ORCAMENTO
// File:           udmPDV.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: udmPDV.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:
//
// 1.0.0 01/01/2001 First Version
//
//******************************************************************************
unit udmPDV;

interface

uses
    SysUtils, Classes, DB, IBDatabase, IBQuery;

type
    TProd = record
        codigo,
        preco,
        DescontoAutomatico,
        descricao: string;
        decimais: Integer;
        ICMS: string;
    end;

type
    TdmORC = class(TDataModule)
        IBDatabase: TIBDatabase;
        IBTransaction: TIBTransaction;
        procedure DataModuleCreate(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
        procedure RunSQL(strQuery: string; var aux: TDataSet; iTipo: Integer =
            1);
            overload;
        procedure RunSQL(strQuery: string); overload;
        procedure Commit;
        function BuscaProduto(strCodigo: string; strTabela: string): TProd;
        function ConsultaVendedor(StrCodigo: string): TDataSet;
        function ConsultaVen_CodigoVendedor(StrCodigo: string): string;
        function ConsultaCodigoVendedor(StrCodigo: string): string;
        function ConsultaCliente(StrCodigo: string): TDataSet;
        function ConsultaPedido(strcodigo: string): TDataSet;
        function ConsultaDetalhePedido(strcodigo: string): TDataSet;
        function CalculaNumeroPedido(strData: string): string;
        procedure InserePedido(dsItens: TDataSet; DATA, NUMEROPEDIDO,
            CLI_CODCLIENTE, CODIGONATUREZAOPERACAO, CODIGOCONDICAOPAGAMENTO,
            VEN_CODVENDEDOR, CODIGOTABELAPRECO,
            OBSERVACAO, CFG_CODCONFIG, DESCONTO, DESCRICAODESCONTO,
            DESPESASACESSORIAS, DESCRICAOACRESCIMO,
            ORIGEMPEDIDO: string);
        procedure EnviaFaturamento(NumeroPedido, CodigoCondicaoPagamento,
            TotalProdutos,
            Observacao, Acrescimo, OBSAcrescimo, Desconto, OBSDesconto: string);
        function CalculaAcrescimo(valor, acrescimo: string): variant;
        function BuscaListaProduto(strTabela: string): TDataSet;
        function BuscaListaVendedores: TDataSet;
        function BuscaListaPedido(strOrigem: string): TDataSet;
        function ConsultaListaCliente: TDataSet;
        function FormasPagamento: string;
        function ConsultaCliCodCliente(strCodigo: string): TDataSet;
        function ConsultaPathImpressora(strCodigo: string): string;
        function ConsultaNomeVendedor(strCodigo: string): string;
        function BuscaTributacao(uf, strCodigo: string): string;
        function BuscaEstado(pessoa:string):string;
    end;

var
    dmORC: TdmORC;

implementation
uses urotinas, Math, StrUtils;
{$R *.dfm}

procedure TdmORC.DataModuleCreate(Sender: TObject);
begin
    IBDatabase.Close;
    IBDatabase.DatabaseName := LeINI('ATCPLUS', 'IP_SERVER') + ':' +
        LeINI('ATCPLUS', 'PATH_DB');
    IBDatabase.Open;
    IBTransaction.Active := True;
end;

{-----------------------------------------------------------------------------
  Procedure: TdmORC.RunSQL
  Autor:    charles
  Data:      18-mar-2003
  Argumentos: strQuery: string; iTipo: Integer
  Retorno:    none

  Executa uma query e retorna um dataset com os dados.
----------------------------------------------------------------------------}

procedure TdmORC.RunSQL(strQuery: string; var aux: TDataSet; iTipo: Integer);
begin
    Log('Executanto query com retorno: ' + strQuery);
    if not Assigned(aux) then
        FreeAndNil(aux);
    aux := TIBQuery.Create(nil);
    with (aux as TIBQuery) do
    begin
        Database := IBDatabase;
        SQL.Text := strQuery;
        Open;
    end;
end;

{-----------------------------------------------------------------------------
  Procedure: TdmORC.ConsultaCliente
  Autor:    charles
  Data:      18-mar-2003
  Argumentos: StrCodigo: string
  Retorno:    TDataSet

  Retorna os dados do cliente
-----------------------------------------------------------------------------}

function TdmORC.ConsultaCliente(StrCodigo: string): TDataSet;
begin
    if StrCodigo = '' then
        StrCodigo := '0';
    dmORC.RunSQL(
        '  SELECT                    ' +
        '  pessoa.PES_APELIDO_A NOME,     ' +
        '  pessoa.PES_NOME_A COMPLETO,     ' +
        '  CODIGOCLIENTE,            ' +
        '  enp_endereco_a ENDERECO,           ' +
        '  ten_descricao_a TIPO_ENDERECO,          ' +
        '  ENP_BAIRRO_A BAIRRO,             ' +
        '  ENP_CIDADE_A CIDADE,             ' +
        '  ENP_ESTADO_A ESTADO,             ' +
        '  ENP_TELEFONE_A FONE,           ' +
        '  ENP_CELULAR_A CEL,            ' +
        '  ENP_FAX_A FAX,           ' +
        '  ENP_CEP_I CEP,                ' +
        '  PES_RG_IE_A RG,                ' +
        '  PES_CPF_CNPJ_A CNPJ, ' +
        '  VEN_CODVENDEDOR, ' +
        '  PESSOA.PES_CODPESSOA ' +
        '  FROM enderecopessoa       ' +
        '  INNER JOIN cliente ON (cliente.pes_codpessoa = enderecopessoa.pes_codpessoa )' +
        '  INNER JOIN tipoendereco ON (tipoendereco.ten_codtipoendereco = enderecopessoa.ten_codtipoendereco)  ' +
        '  INNER JOIN pessoa ON (cliente.pes_codpessoa = pessoa.pes_codpessoa) ' +
        '  WHERE CLIENTE.CODIGOCLIENTE = ' + StrCodigo
        , result);
    log('Consultando cliente : ' + StrCodigo + ' Encontrado? :' +
        IfThen(Result.IsEmpty, 'Sim', 'N�o'))
end;

{-----------------------------------------------------------------------------
  Procedure: TdmORC.ConsultaVendedor
  Autor:    charles
  Data:      18-mar-2003
  Argumentos: StrCodigo: string
  Retorno:    TDataSet

  Retorna os dados do vendedor.
-----------------------------------------------------------------------------}

function TdmORC.ConsultaVendedor(StrCodigo: string): TDataSet;
begin
    if StrCodigo = '' then
        StrCodigo := '0';
    dmORC.RunSQL('select pessoa.pes_nome_a nome, vendedor.codigovendedor, vendedor.ven_codvendedor ' +
        'from vendedor,pessoa  where ' +
        'vendedor.codigovendedor = ' + strcodigo +
        ' and pessoa.pes_codpessoa = vendedor.pes_codpessoa', result);
    log('Consultando Vendedor : ' + StrCodigo + ' Encontrado? :' + IfThen(not
        Result.IsEmpty, 'Sim', 'N�o'))
end;

{-----------------------------------------------------------------------------
  Procedure: TdmORC.ConsultaPedido
  Autor:    charles
  Data:      18-mar-2003
  Argumentos: strcodigo: string
  Retorno:    TDataSet

  Recupera os dados do cabe�alho do pedido.
-----------------------------------------------------------------------------}

function TdmORC.ConsultaPedido(strcodigo: string): TDataSet;
begin
    if StrCodigo = '' then
        StrCodigo := '0';
    dmORC.RunSQL('commit;', Result);
    FreeAndNil(result);
    dmORC.RunSQL('SELECT * FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' + STRCODIGO,
        Result);
end;

{-----------------------------------------------------------------------------
  Procedure: TdmORC.ConsultaDetalhePedido
  Autor:    charles
  Data:      18-mar-2003
  Argumentos: strcodigo: string
  Retorno:    TDataSet

  Recupera os dados do pedido informado.
-----------------------------------------------------------------------------}

function TdmORC.ConsultaDetalhePedido(strcodigo: string): TDataSet;
begin
    if strcodigo = '' then
        strcodigo := '0';
    dmORC.RunSQL('select ' +
        'produtopedidovenda.codigoproduto, ' +
        'produtopedidovenda.CODIGOPRODUTOPEDIDO, ' +
        'produto.nomeproduto, ' +
        'produtopedidovenda.preco,' +
        'produtopedidovenda.quantidade, ' +
        'produtopedidovenda.observacao, ' +
        'produtopedidovenda.impresso, ' +
        'produto.pesobruto, ' +
        'produto.Decimais, ' +
        'produto.pesoliquido, ' +
        'produtopedidovenda.motivo_cancelamento, ' +
        'produtopedidovenda.CANCELADO ' +
        'from produtopedidovenda ' +
        'inner join pedidovenda on (pedidovenda.codigopedidovenda = produtopedidovenda.codigopedidovenda) ' +
        'inner join produto on (produtopedidovenda.codigoproduto = produto.codigoproduto ) ' +
        'where pedidovenda.numeropedido = ' + QuotedStr(strcodigo), Result);
    log('Consultando Pedido : ' + StrCodigo + ' Encontrado? :' +
        IfThen(Result.IsEmpty, 'Sim', 'N�o'))
end;

{-----------------------------------------------------------------------------
  Procedure: dmORC.BuscaProduto
  Author:    charles
  Date:      11-mar-2003
  Arguments: strCodigo, strTabela: string
  Result:    TProd
  Buscao o produto pelo c�digo e tabela de preco informado.
  Caso n�o exista o produto, o campo descri��o do retorno da funcao estar� em
  branco.
-----------------------------------------------------------------------------}

function TdmORC.BuscaProduto(strCodigo: string; strTabela: string): TProd;
var
    auxDataSet: TDataSet;
begin
    //busca o codigo associado.
    if TrimRight(TrimLeft(strcodigo)) = '' then
        strCodigo := '0';

    dmORC.RunSQL('SELECT * FROM PRODUTOASSOCIADO WHERE CODIGOPRODUTOASSOCIADO = '
        + strcodigo, auxDataSet);
    if not auxDataSet.IsEmpty then
        result.codigo := auxDataSet.FieldByName('codigoproduto').Value
    else
        result.codigo := strcodigo;
    FreeAndNil(auxdataset);
    //busca o preco pela tabela de precos.
    dmorc.RunSQL('SELECT * FROM PRODUTOTABELAPRECO ' +
        'WHERE CODIGOTABELAPRECO = ' + QuotedStr(strTabela) +
        ' AND  CODIGOPRODUTO = ' + result.codigo, auxDataSet);
    Result.preco := floattostr(auxDataSet.FieldByName('preco').AsFloat);
    FreeAndNil(auxDataSet);

    //busca o nome do produto e possivel desconto automatico.
    dmORC.RunSQL('SELECT NOMEPRODUTO,NUMMICRO1,DECIMAIS ' +
        'FROM PRODUTO ' +
        'WHERE CODIGOPRODUTO = ' + Result.codigo, auxDataSet);
    Result.DescontoAutomatico :=
        floattostr(auxDataSet.FieldByName('NUMMICRO1').AsFloat);
    Result.descricao := auxDataSet.FieldByName('NOMEPRODUTO').AsString;
    Result.decimais := auxDataSet.FieldByName('decimais').AsInteger;
    log('Consultando Produto : ' + StrCodigo + ' pela tabela de produto: ' +
        strTabela + ' Encontrado ? : ' + IfThen(auxDataSet.IsEmpty, 'N�o',
            'Sim'));
    FreeAndNil(auxDataSet);
end;

{-----------------------------------------------------------------------------
  Procedure: TdmORC.CalculaNumeroPedido
  Autor:    charles
  Data:      18-mar-2003
  Argumentos: strData: string
  Retorno:    string

  Calcula o n�mero do pedido autom�tico.
  Caso n�o consiga calcular, retorna 1;
-----------------------------------------------------------------------------}

function TdmORC.CalculaNumeroPedido(strData: string): string;
var
    auxDataset: TDataSet;
    aux2: TDataSet;
    strAux: string;
    bExiste: Boolean;
    tmp: Integer;
begin
    straux := FormatDateTime('mm/dd/yyyy', strtodate(strData));
    strdata := straux;
    bExiste := True;
    RunSQL('select extract(year from cast(' + QuotedStr(strData) + ' as date))'
        +
        ' || count(codigopedidovenda) + 1 from pedidovenda where ' +
        ' extract(year from data) = extract(year from cast(' + QuotedStr(strData)
            +
        ' as date))', auxDataset);
    tmp := auxDataset.Fields[0].AsInteger;
    while bExiste do
    begin
        aux2 := ConsultaPedido(IntToStr(tmp));
        if not aux2.IsEmpty then
            Inc(tmp)
        else
            bExiste := False;
    end;
    try
        with auxDataset do
        begin
            Result := IntToStr(tmp);
            Free;
        end;
    except
        Result := FormatDateTime('yyyy', strtodate(strdata)) + '1';
    end;
    log('Calculando o n�mero do pedido: ' + strData + '  numero calculado : ' +
        result)
end;

{-----------------------------------------------------------------------------
  Procedure: TdmORC.InserePedido
  Autor:    charles
  Data:      18-mar-2003
  Argumentos: dsItens: TDataSet; DATA, NUMEROPEDIDO, CLI_CODCLIENTE,
              CODIGONATUREZAOPERACAO, CODIGOCONDICAOPAGAMENTO,
              VEN_CODVENDEDOR, CODIGOTABELAPRECO,
              OBSERVACAO, CFG_CODCONFIG,
              DESCONTO, DESCRICAODESCONTO,
              DESPESASACESSORIAS, DESCRICAOACRESCIMO,
              NUMPESSOAS, ORIGEMPEDIDO: String
  Retorno:    None

  Insere ou atualiza os dados do pedido.
-----------------------------------------------------------------------------}

procedure TdmORC.InserePedido(dsItens: TDataSet; DATA,
    NUMEROPEDIDO, CLI_CODCLIENTE, CODIGONATUREZAOPERACAO,
    CODIGOCONDICAOPAGAMENTO, VEN_CODVENDEDOR, CODIGOTABELAPRECO,
    OBSERVACAO, CFG_CODCONFIG, DESCONTO,
    DESCRICAODESCONTO, DESPESASACESSORIAS, DESCRICAOACRESCIMO,
    ORIGEMPEDIDO: string);
var
    totalprodutos,
        totalpedido: real;
    strAux,
        strAuxCodigoPedidoVenda: string;
    auxDataSet: TDataSet;
begin
    totalprodutos := 0;
    log('Inserindo Pedido dados:');
    log(DATA + ',' +
        NUMEROPEDIDO + ',' +
        CLI_CODCLIENTE + ',' +
        CODIGONATUREZAOPERACAO + ',' +
        CODIGOCONDICAOPAGAMENTO + ',' +
        VEN_CODVENDEDOR + ',' +
        CODIGOTABELAPRECO + ',' +
        OBSERVACAO + ',' +
        CFG_CODCONFIG + ',' +
        DESCONTO + ',' +
        DESCRICAODESCONTO + ',' +
        DESPESASACESSORIAS + ',' +
        DESCRICAOACRESCIMO + ',' +
        ORIGEMPEDIDO);

    DESPESASACESSORIAS := StringReplace(DESPESASACESSORIAS, ',', '.', []);
    DESCONTO := StringReplace(DESCONTO, ',', '.', []);

    DecimalSeparator := '.';
    // tem que ser ponto, se nao o Interbase n�o grava os valores com casas decimais corretamente!.

    dsItens.First;
    while not dsItens.Eof do
    begin
        totalprodutos := totalprodutos + dsItens.FieldByName('total').Value;
        dsitens.Next;
    end;
    //testar se o pedido j� existe.
    RunSQL('select * from pedidovenda where numeropedido = ' + NUMEROPEDIDO,
        auxDataSet);

    totalpedido := totalprodutos + StrToFloatdef(DESPESASACESSORIAS, 0) -
        StrToFloatDef(DESCONTO, 0);
    //se n�o existe, insere.
    if auxDataSet.IsEmpty then
        RunSQL(
            'INSERT INTO PEDIDOVENDA ' +
            '( ' +
            '  NUMEROPEDIDO, ' +
            '  DATA, ' +
            '  CLI_CODCLIENTE, ' +
            '  CODIGONATUREZAOPERACAO, ' +
            '  CODIGOCONDICAOPAGAMENTO, ' +
            '  VEN_CODVENDEDOR, ' +
            '  CODIGOTABELAPRECO,  ' +
            '  TOTALPRODUTOS, ' +
            '  TOTALPEDIDO, ' +
            '  OBSERVACAO, ' +
            '  CFG_CODCONFIG, ' +
            '  DESCONTO, ' +
            '  DESCRICAODESCONTO, ' +
            '  DESPESASACESSORIAS, ' +
            '  DESCRICAOACRESCIMO, ' +
            '  ORIGEMPEDIDO, SITUACAO) ' +
            ' VALUES ( ' +
            QuotedStr(NUMEROPEDIDO) + ',' +
            QuotedStr(DATA) + ',' +
            QuotedStr(CLI_CODCLIENTE) + ',' +
            QuotedStr(CODIGONATUREZAOPERACAO) + ',' +
            QuotedStr(CODIGOCONDICAOPAGAMENTO) + ',' +
            QuotedStr(VEN_CODVENDEDOR) + ',' +
            QuotedStr(CODIGOTABELAPRECO) + ',' +
            QuotedStr(FloatToStr(TOTALPRODUTOS)) + ',' +
            QuotedStr(floattostr(TOTALPEDIDO)) + ',' +
            QuotedStr(OBSERVACAO) + ',' +
            QuotedStr(CFG_CODCONFIG) + ',' +
            IfThen(StrToFloat(DESCONTO) = 0, 'NULL', floattostr(StrToFloat(DESCONTO))) + ',' +
            QuotedStr(DESCRICAODESCONTO) + ',' +
            IfThen(StrToFloat(DESPESASACESSORIAS) = 0, 'NULL', floattostr(StrToFloat(DESPESASACESSORIAS))) + ',' +
            QuotedStr(DESCRICAOACRESCIMO) + ',' +
            QuotedStr(ORIGEMPEDIDO) + ', ' + QuotedStr('0') + ')')
    else //sen�o atualiza o cabe�alho.
        RunSQL('UPDATE PEDIDOVENDA SET ' +
            ' NUMEROPEDIDO            = ' + QuotedStr(NUMEROPEDIDO) + ',' +
            ' CLI_CODCLIENTE          = ' + QuotedStr(CLI_CODCLIENTE) + ',' +
            ' CODIGONATUREZAOPERACAO  = ' + QuotedStr(CODIGONATUREZAOPERACAO) +
                ',' +
            ' CODIGOCONDICAOPAGAMENTO = ' + QuotedStr(CODIGOCONDICAOPAGAMENTO) +
                ',' +
            ' VEN_CODVENDEDOR         = ' + QuotedStr(VEN_CODVENDEDOR) + ',' +
            ' CODIGOTABELAPRECO       = ' + QuotedStr(CODIGOTABELAPRECO) + ',' +
            ' TOTALPRODUTOS           = ' + QuotedStr(floattostr(TOTALPRODUTOS))
                + ','
            +
            ' TOTALPEDIDO             = ' + QuotedStr(floattostr(TOTALPEDIDO)) +
                ',' +
            ' OBSERVACAO              = ' + QuotedStr(OBSERVACAO) + ',' +
            ' CFG_CODCONFIG           = ' + QuotedStr(CFG_CODCONFIG) + ',' +
            ' DESCONTO                = ' + IfThen(StrToFloat(DESCONTO) = 0, 'NULL', floattostr(StrToFloat(DESCONTO))) + ',' +
            ' DESCRICAODESCONTO       = ' + QuotedStr(DESCRICAODESCONTO) + ',' +
            ' DESPESASACESSORIAS      = ' + IfThen(StrToFloat(DESPESASACESSORIAS) = 0,  'NULL', floattostr(StrToFloat(DESPESASACESSORIAS))) + ',' +
            ' DESCRICAOACRESCIMO      = ' + QuotedStr(DESCRICAOACRESCIMO) + ',' +
            ' ORIGEMPEDIDO            = ' + QuotedStr(ORIGEMPEDIDO) +
            //' SITUACAO                = ' +   QuotedStr('0') +
            ' WHERE NUMEROPEDIDO = ' + QUOTEDSTR(NUMEROPEDIDO));
    FreeAndNil(auxDataSet);
    //// os itens s�o sempre deletados e inseridos novamente.
    //pega o codigo do pedido a partir do numero do pedido.
    RunSQL('select codigopedidovenda from pedidovenda where numeropedido = ' +
        QuotedStr(NUMEROPEDIDO), auxdataset);
    strAuxCodigoPedidoVenda :=
        auxDataSet.FieldByName('codigopedidovenda').AsString;
    strAux := auxDataSet.FieldByName('codigopedidovenda').AsString;
    FreeAndNil(auxDataSet);
    //apaga todos os itens referentes ao pedido atual , e insere novamente.
    RunSQL('delete from produtopedidovenda where codigopedidovenda = ' +
        strAux);
    //insere os itens do pedido na tabela.
    dsitens.Filtered := False;
    dsitens.last;
    dsitens.First;
    while not dsitens.Eof do
    begin
        RunSQL(' INSERT INTO PRODUTOPEDIDOVENDA ' +
            ' (CODIGOPRODUTO, QUANTIDADE, PRECO, CODIGOPEDIDOVENDA, OBSERVACAO, IMPRESSO, MOTIVO_CANCELAMENTO, CANCELADO) ' +
            ' VALUES (' +
            QuotedStr(FloatToStr(dsItens.FieldByName('CODIGO').AsFloat)) + ',' +
            QuotedStr(FloatToStr(dsItens.FieldByName('QUANTIDADE').AsFloat)) +
            ', ' +
            QuotedStr(FloatToStr(dsItens.FieldByName('VALOR UNITARIO').AsFloat))
            + ', ' +
            strAuxCodigoPedidoVenda + ', ' +
            QuotedStr(dsItens.FieldByName('Observacao').AsString) + ', ' +
            QuotedStr(dsItens.FieldByName('Impresso').AsString) + ', ' +
            QuotedStr(dsItens.FieldByName('Motivocancelamento').AsString) + ', ' +
            QuotedStr(dsItens.FieldByName('situacao').AsString) + ' )');
        dsItens.Next;
    end;
    dsitens.Filtered := True;
    freeandnil(auxDataSet);
    DecimalSeparator := ',';
    RunSQL('commit');
end;

{-----------------------------------------------------------------------------
  Procedure: TdmORC.EnviaFaturamento
  Autor:    charles
  Data:      26-mar-2003
  Argumentos: NumeroPedido, CodigoCondicaoPagamento, TotalProdutos, Observacao,
              Acrescimo, OBSAcrescimo, Desconto, OBSDesconto: string
  Retorno:    None

  Envia o pedido para o faturamento.
-----------------------------------------------------------------------------}

procedure TdmORC.EnviaFaturamento(NumeroPedido, CodigoCondicaoPagamento,
    TotalProdutos, Observacao, Acrescimo, OBSAcrescimo, Desconto,
    OBSDesconto: string);
begin
    Acrescimo := StringReplace(Acrescimo, ',', '.', []);
    Desconto := StringReplace(Desconto, ',', '.', []);
    TotalProdutos := StringReplace(TotalProdutos, ',', '.', []);

    DecimalSeparator := '.';
    RunSQL('update PEDIDOVENDA ' +
        '  set  ' +
        '    CODIGOCONDICAOPAGAMENTO = ' + CodigoCondicaoPagamento + ' , ' +
        '    SITUACAO = ' + QuotedStr('X') + ' , ' +
        '    OBSERVACAO = ' + QuotedStr(OBSERVACAO) + ' , ' +
        '    DESCONTO = ' + QuotedStr(DESCONTO) + ' , ' +
        '    DESPESASACESSORIAS = ' + QuotedStr(Acrescimo) + ' , ' +
        '    DESCRICAODESCONTO = ' + QuotedStr(OBSAcrescimo) + ' , ' +
        '    TOTALPEDIDO      = ' +
            QuotedStr(floattostr(StrToFloat(TotalProdutos) +
        StrToFloatDef(Acrescimo, 0) - StrToFloatDef(Desconto, 0))) + ' , ' +
        '    DESCRICAOACRESCIMO = ' + QuotedStr(OBSDesconto) +
        '  where ' +
        '       NumeroPedido = ' + NumeroPedido);
    DecimalSeparator := ',';
end;

{-----------------------------------------------------------------------------
  Procedure: TdmORC.CalculaAcrescimo
  Autor:    charles
  Data:      26-mar-2003
  Argumentos: valor, acrescimo: string
  Retorno:    string

  Adiciona o acrescimo em % ao valor.
-----------------------------------------------------------------------------}

function TdmORC.CalculaAcrescimo(valor, acrescimo: string): Variant;
var
    auxvalor, auxacr: real;
begin
    auxvalor := StrToFloat(valor);
    auxacr := StrToFloat(acrescimo);
    Result := FormatFloat('0.00', auxvalor * (auxacr / 100));
end;

{-----------------------------------------------------------------------------
  Procedure: TdmORC.RunSQL
  Autor:    charles
  Data:      26-mar-2003
  Argumentos: strQuery: string
  Retorno:    None

  Procedure que executa comandos sql que n�o retornam cursores
-----------------------------------------------------------------------------}

procedure TdmORC.RunSQL(strQuery: string);
var
    aux: TDataSet;
begin
    Log('Executando query sem retorno: ' + strQuery);
    aux := TIBQuery.Create(nil);
    with (aux as TIBQuery) do
    begin
        Database := IBDatabase;
        SQL.Text := strQuery;
        ExecSQL;
        SQL.Clear;
        SQL.Text := 'commit;';
        ExecSQL;
        FreeAndNil(aux);
    end;
end;
{-----------------------------------------------------------------------------
  Procedimento : TdmORC.BuscaListaProduto
  Autr         : charles
  Data         : 20-mai-2003
  Argumentos   : strTabela: string
  Retorno      : TDataSet
-----------------------------------------------------------------------------}

function TdmORC.BuscaListaProduto(strTabela: string): TDataSet;
begin
    RunSQL('SELECT * FROM PRODUTO ' +
        'INNER JOIN PRODUTOTABELAPRECO ON (PRODUTO.CODIGOPRODUTO = PRODUTOTABELAPRECO.CODIGOPRODUTO) ' +
        'WHERE PRODUTOTABELAPRECO.CODIGOTABELAPRECO = ' + strTabela, result);
end;

{-----------------------------------------------------------------------------
  Procedimento : TdmORC.BuscaListaVendedores
  Autr         : charles
  Data         : 20-mai-2003
  Argumentos   : None
  Retorno      : TDataSet
-----------------------------------------------------------------------------}

function TdmORC.BuscaListaVendedores: TDataSet;
begin
    RunSQL('select pessoa.pes_nome_a nome, ' +
        'vendedor.codigovendedor ' +
        'from vendedor ' +
        'inner join pessoa on (pessoa.pes_codpessoa = vendedor.pes_codpessoa)',
        result);
end;

{-----------------------------------------------------------------------------
  Procedimento : TdmORC.BuscaListaPedido
  Autr         : charles
  Data         : 20-mai-2003
  Argumentos   : strOrigem:string
  Retorno      : TDataSet
-----------------------------------------------------------------------------}

function TdmORC.BuscaListaPedido(strOrigem: string): TDataSet;
begin
    RunSQL('select numeropedido Pedido, vendedor.codigovendedor Codigo, pes_nome_a Nome, pedidovenda.situacao from pedidovenda '
        +
        'inner join vendedor on (vendedor.ven_codvendedor = pedidovenda.ven_codvendedor) ' +
        'inner join pessoa  on (vendedor.pes_codpessoa = pessoa.pes_codpessoa) ' +
        'where ' +
        'pedidovenda.origempedido = ' + strOrigem + ' and ' +
        '(pedidovenda.situacao <> ''X'' or pedidovenda.situacao is null) order by numeropedido',
        result);

end;

{-----------------------------------------------------------------------------
  Procedimento : TdmORC.ConsultaListaCliente
  Autr         : charles
  Data         : 20-mai-2003
  Argumentos   : None
  Retorno      : TDataSet
-----------------------------------------------------------------------------}

function TdmORC.ConsultaListaCliente: TDataSet;
begin
    dmORC.RunSQL(
        '  SELECT                    ' +
        '  CODIGOCLIENTE Codigo,            ' +
        '  pessoa.PES_NOME_A Completo' +
        '  FROM enderecopessoa       ' +
        '  INNER JOIN cliente ON (cliente.pes_codpessoa = enderecopessoa.pes_codpessoa) ' +
        '  INNER JOIN tipoendereco ON (tipoendereco.ten_codtipoendereco = enderecopessoa.ten_codtipoendereco)  ' +
        '  INNER JOIN pessoa ON (cliente.pes_codpessoa = pessoa.pes_codpessoa) ' +
        '  ORDER BY pessoa.PES_NOME_A'
        , result);
end;

{-----------------------------------------------------------------------------
  Procedimento : TdmORC.FormasPagamento
  Autr         : charles
  Data         : 20-mai-2003
  Argumentos   : None
  Retorno      : string
-----------------------------------------------------------------------------}

function TdmORC.FormasPagamento: string;
var
    auxDataset: TDataSet;
begin
    RunSQL('SELECT FORMAFATURAMENTO FROM FORMAFATURAMENTO ORDER BY CODIGOFORMAFATURAMENTO ', auxDataset);
    Result := '';
    auxDataset.First;
    while not auxDataset.Eof do
    begin
        Result := Result + auxDataset.Fields[0].AsString + '|';
        auxDataset.Next;
    end;
    Log('Pegando as formas de pagamento :' + Result);
    FreeAndNil(auxDataset);

end;

{-----------------------------------------------------------------------------
  Procedimento : TdmORC.ConsultaVen_CodigoVendedor
  Autr         : charles
  Data         : 20-mai-2003
  Argumentos   : StrCodigo: string
  Retorno      : string
-----------------------------------------------------------------------------}

function TdmORC.ConsultaVen_CodigoVendedor(StrCodigo: string): string;
var
    auxDataSet: TDataSet;
begin
    if StrCodigo = '' then
        StrCodigo := '0';
    dmORC.RunSQL('select pessoa.pes_apelido_a nome, vendedor.codigovendedor, vendedor.ven_codvendedor ' +
        'from vendedor,pessoa  where ' +
        'vendedor.codigovendedor = ' + strcodigo +
        ' and pessoa.pes_codpessoa = vendedor.pes_codpessoa', auxDataSet);
    Result := auxDataSet.FieldByName('ven_codvendedor').AsString;
    FreeAndNil(auxDataSet);
end;

{-----------------------------------------------------------------------------
  Procedimento : TdmORC.ConsultaCodigoVendedor
  Autr         : charles
  Data         : 20-mai-2003
  Argumentos   : StrCodigo: string
  Retorno      : string
-----------------------------------------------------------------------------}

function TdmORC.ConsultaCodigoVendedor(StrCodigo: string): string;
var
    auxDataSet: TDataSet;
begin
    if StrCodigo = '' then
        StrCodigo := '0';
    dmORC.RunSQL('select pessoa.pes_apelido_a nome, vendedor.codigovendedor, vendedor.ven_codvendedor ' +
        'from vendedor,pessoa  where ' +
        'vendedor.ven_codvendedor = ' + strcodigo +
        ' and pessoa.pes_codpessoa = vendedor.pes_codpessoa', auxDataSet);
    Result := auxDataSet.FieldByName('codigovendedor').AsString;
    FreeAndNil(auxDataSet);
end;

{-----------------------------------------------------------------------------
  Procedimento : TdmORC.ConsultaCliCodCliente
  Autr         : charles
  Data         : 20-mai-2003
  Argumentos   : strCodigo: string
  Retorno      : TDataSet
-----------------------------------------------------------------------------}

function TdmORC.ConsultaCliCodCliente(strCodigo: string): TDataSet;
var
    auxdataset: TDataSet;
begin
    RunSQL('SELECT CODIGOCLIENTE FROM CLIENTE WHERE CLI_CODCLIENTE = ' +
        STRCODIGO, auxdataset);
    Result := ConsultaCliente(auxdataset.Fields[0].AsString);
    FreeAndNil(auxdataset);
end;

{-----------------------------------------------------------------------------
  Procedimento : TdmORC.ConsultaPathImpressora
  Autr         : charles
  Data         : 20-mai-2003
  Argumentos   : strCodigo:string
  Retorno      : string
-----------------------------------------------------------------------------}

function TdmORC.ConsultaPathImpressora(strCodigo: string): string;
var
    auxDataSet: TDataSet;
begin
    runsql('SELECT CAMINHOIMPRESSORA FROM IMPRESSORA WHERE CODIGOIMPRESSORA = '
        +
        strCodigo, auxDataSet);
    Result := auxDataSet.Fields[0].AsString;
    FREEANDNIL(auxDataSet);
end;

{-----------------------------------------------------------------------------
  Procedimento : TdmORC.ConsultaNomeVendedor
  Autr         : charles
  Data         : 20-mai-2003
  Argumentos   : strCodigo: string
  Retorno      : string
-----------------------------------------------------------------------------}

function TdmORC.ConsultaNomeVendedor(strCodigo: string): string;
var
    auxdataset: TDataSet;
begin
    runsql('SELECT PES_NOME_A FROM PESSOA ' +
        'INNER JOIN VENDEDOR ON ( VENDEDOR.PES_CODPESSOA = PESSOA.PES_CODPESSOA) ' +
        'WHERE VENDEDOR.VEN_CODVENDEDOR = ' + strCodigo, auxdataset);
    Result := auxdataset.Fields[0].AsString;
    FreeAndNil(auxdataset);
end;

{
  Procedimento : TdmORC.Commit
  Autr         : charles
  Data         : 20-mai-2003
  Argumentos   : None
  Retorno      : None
}
procedure TdmORC.Commit;
begin
    RunSQL('commit');
end;


{
  Procedimento : TdmORC.BuscaTributacao
  Autr         : charles
  Data         : 20-mai-2003
  Argumentos   : uf, strCodigo:String
  Retorno      : string
}
function TdmORC.BuscaTributacao(uf, strCodigo: string): string;
var
    auxdataSet: TDataSet;
begin
    RunSQL('SELECT * FROM ICMSPRODUTO WHERE CODIGOPRODUTO = ' +
        QuotedStr(strCodigo) + ' AND UF = ' + QuotedStr(uf), auxdataSet);
    with auxdataSet do
        Result := FieldByName('tipo').AsString +
            TrimRight(TrimLeft(FieldByName('UF_DESCRICAO').AsString));
    log('BuscaTrib : ' + Result);
    freeandnil(auxdataSet)
end;

function TdmORC.BuscaEstado(pessoa: string): string;
var
   auxdataset:TDataSet;
begin
    // PEGA O ESTADO DO CADASTRO DA PESSOA. sEGUNDO O Helder, sempre o tipo de endere�o 2.
    //Charles - 23/10/2003
    RunSQL('SELECT * FROM ENDERECOPESSOA WHERE PES_CODPESSOA = ' + pessoa +  'AND TEN_CODTIPOENDERECO = 2',auxdataset);
    Result := auxdataset.FieldByName('ENP_ESTADO_A').AsString;
    FreeAndNil(auxdataset);
end;

end.
//******************************************************************************
//*                          End of File udmPDV.pas
//******************************************************************************

