//******************************************************************************
//
//                 UNIT UFECHANORMAL (-)
//
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           uFechaNormal.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: uFechaNormal.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:
//
// 1.0.0 01/01/2001 First Version
//
//******************************************************************************

unit uFechaNormal;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Inifiles, ExtCtrls, ComCtrls, StdCtrls, Mask, Buttons, db, Dialogs;

type
    TfrmFechaECF = class(TForm)
        GroupBox1: TGroupBox;
        lblTotalCupom: TLabel;
        gbReceber: TGroupBox;
        lblFalta: TLabel;
        Panel1: TPanel;
        Panel2: TPanel;
        lblFormaFaturamento: TLabel;
        Label9: TLabel;
        mskValor: TMaskEdit;
        lbFormaPagamentos: TTreeView;
        Panel3: TPanel;
        spdVoltar: TSpeedButton;
        pnlModificador: TPanel;
        lblModificador: TLabel;
        mskModificadores: TMaskEdit;
        pnlModificadores: TPanel;
        spdAcrescimoValor: TSpeedButton;
        spdAcrescimoPercentual: TSpeedButton;
        spDescontoValor: TSpeedButton;
        spDescontoPercentual: TSpeedButton;
        spCancelaVenda: TSpeedButton;
        tmrFecha: TTimer;
        tmrGaveta: TTimer;
        procedure lbFormaPagamentosClick(Sender: TObject);
        procedure lbFormaPagamentosChange(Sender: TObject; Node: TTreeNode);
        procedure mskValorKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure FormCreate(Sender: TObject);
        procedure mskValorKeyPress(Sender: TObject; var Key: Char);
        procedure mskValorExit(Sender: TObject);
        procedure FormKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure spdVoltarClick(Sender: TObject);
        procedure spdAcrescimoValorClick(Sender: TObject);
        procedure mskModificadoresKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure lbFormaPagamentosKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure tmrFechaTimer(Sender: TObject);
        procedure tmrGavetaTimer(Sender: TObject);
    private
        { Private declarations }
        FTabelaPreco,
            FPedido,
            FCodigoPedido: string;
        FTotalPedido: Real;
        FVendedor: string;
        FNumPessoas: string;
        FTOtalPedidoVenda: string;
        FCliente: string;
        procedure SetTabelaPreco(Tabela: string);
        procedure SetPedido(NumeroPedido: string);
        procedure Finaliza;
        procedure SetVendedor(const Value: string);
        procedure SetNumPessoas(const Value: string);
        procedure SetTOtalPedidoVenda(const Value: string);
        procedure SetCliente(const Value: string);
        procedure SetTotalPedido(const Value: Real);
    public
        { Public declarations }
        dsFormasPagamento: TDataSet;
        dsItems: ^TDataSet;
        NumeroECF, NumeroCupom: string;
        property TabelaPreco: string read FTabelaPreco write SetTabelaPreco;
        property Pedido: string read FPedido write SetPedido;
        property Vendedor: string read FVendedor write SetVendedor;
        property NumPessoas: string read FNumPessoas write SetNumPessoas;
        property TOtalPedidoVenda: string read FTOtalPedidoVenda write
            SetTOtalPedidoVenda;
        property Cliente: string read FCliente write SetCliente;
        property TotalPedido: Real read FTotalPedido write SetTotalPedido;
    end;

var
    frmFechaECF: TfrmFechaECF;

implementation
uses
    udmPDV, uRotinas, Math, StrUtils, MaskUtils, uDadosCheque,
    uDadosChequeLeitor;

{$R *.dfm}

{-----------------------------------------------------------------------------
  Procedimento : TfrmFechaECF.SetTabelaPreco
  Autr         : charles
  Data         : 20-mai-2003
  Argumentos   : Tabela: string
  Retorno      : None
-----------------------------------------------------------------------------}

procedure TfrmFechaECF.SetTabelaPreco(Tabela: string);
begin
    FTabelaPreco := Tabela;
    dmORC.RunSQL('SELECT C.CONDICAOPAGAMENTO,C.CONDICAOPAGAMENTO || '' - '' ||'
        +
        ' F.FORMAFATURAMENTO , ' +
        ' C.*, F.* FROM FORMAFATURAMENTO F,CONDICAOPAGAMENTO C ' +
        ' WHERE ' +
        ' C.CODIGOFORMAFATURAMENTO = F.CODIGOFORMAFATURAMENTO AND F.CODIGOTABELAPRECO = ' +
        FTabelaPreco, dsFormasPagamento);
    if dsFormasPagamento.IsEmpty then
        dmORC.RunSQL('SELECT C.CONDICAOPAGAMENTO,C.CONDICAOPAGAMENTO || '' - '' ||'
            +
            'F.FORMAFATURAMENTO , ' +
            ' C.*, F.*  FROM FORMAFATURAMENTO F,CONDICAOPAGAMENTO C ' +
            ' WHERE ' +
            ' C.CODIGOFORMAFATURAMENTO = F.CODIGOFORMAFATURAMENTO',
            dsFormasPagamento);
    while not dsformaspagamento.Eof do
    begin
        log('Montanto lista de formas de pagamento:'+dsFormasPagamento.FieldByName('F_1').AsString);
        lbFormaPagamentos.Items.AddObject(lbFormaPagamentos.TopItem,
            dsFormasPagamento.FieldByName('F_1').AsString,
            dsFormasPagamento.GetBookmark);
        dsFormasPagamento.Next;
    end;
    log('Montanto lista de formas de pagamento: CARREGADO OK');
    //forca selecionar o primeiro item da lista.
    lbFormaPagamentos.Select(lbFormaPagamentos.Items[0]);
    lbFormaPagamentosClick(nil);
end;

procedure TfrmFechaECF.lbFormaPagamentosClick(Sender: TObject);
begin
    // Somente para receber o foco.
end;

{
  Procedure: TfrmFechaFaturamento.SetPedido
  Autor:    charles
  Data:      21-mar-2003
  Argumentos: NumeroPedido: string
  Retorno:    None

  Quando eu passo número do pedido para o form, já realizo as consultas para
  colocar os dados nos componentes do form.
}

procedure TfrmFechaECF.SetPedido(NumeroPedido: string);
var
    auxdataset: TDataSet;
    pesoLiquido,
        PesoBruto: Real;
begin
    pesoLiquido := 0;
    PesoBruto := 0;
    FPedido := NumeroPedido;
    auxdataset := dmORC.ConsultaPedido(NumeroPedido);

    lblTotalCupom.Caption := CurrencyString + formatfloat('0.00',
        auxdataset.FieldByName('totalpedido').Asfloat);
    lblFalta.Caption := CurrencyString + formatfloat('0.00',
        auxdataset.FieldByName('totalpedido').Asfloat);
    FCodigoPedido := auxdataset.FieldByName('codigopedidovenda').AsString;
    TotalPedido := auxdataset.FieldByName('TotalPedido').Asfloat;
    Vendedor := auxdataset.FieldByName('ven_codvendedor').AsString;
    TOtalPedidoVenda := auxdataset.FieldByName('TotalPedido').AsString;
    Cliente := auxdataset.FieldByName('Cli_codcliente').AsString;
    NumPessoas := auxdataset.FieldByName('NumPessoas').AsString;
    FreeAndNil(auxdataset);

    auxdataset := dmORC.ConsultaDetalhePedido(NumeroPedido);
    while not auxdataset.Eof do
    begin
        pesoLiquido := pesoLiquido +
            auxdataset.FieldByName('pesoliquido').Asfloat;
        PesoBruto := PesoBruto + auxdataset.FieldByName('pesoliquido').Asfloat;
        auxdataset.Next;
    end;
    freeandnil(auxdataset);
end;

procedure TfrmFechaECF.lbFormaPagamentosChange(Sender: TObject;
    Node: TTreeNode);
begin
    lblFormaFaturamento.Caption := Node.Text;
    dsFormasPagamento.GotoBookmark(Node.Data);
end;

procedure TfrmFechaECF.mskValorKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
var
    straux: string;
    TotalizaCupom: FTotalizacupom;
    COO: FCOO;
    HAND: THandle;
    auxDataSet: TDataSet;
begin
    case key of
        VK_ESCAPE: mskvalor.Text := '0' + DecimalSeparator + '00';
        VK_RETURN:
            begin
                if StrToFloat(mskValor.text) = 0 then
                    mskValor.Text := FloatToStrF(TotalPedido,ffFixed, 18,2);
                        //PChar(@lblFalta.Caption[Length(CurrencyString) + 1]);
                if StrToFloat(mskValor.text) > 0 then
                    if Application.messagebox(pchar('Confirma o lancamento de '
                        +
                        CurrencyString + mskValor.Text + ' ?'), TITULO_MENSAGEM,
                            MB_YESNO +
                        MB_ICONQUESTION) = idyes then
                        if mskValor.Tag = 0 then // controla pelo tag se deve finalizar ou iniciar a totalizacao
                        begin
                            if leini('terminal', 'gaveta') = 1 then
                                AbreGaveta;
                            spdAcrescimoValor.Enabled := False;
                            spdAcrescimoPercentual.Enabled := False;
                            spDescontoValor.Enabled := False;
                            spDescontoPercentual.Enabled := False;
                            strAux := ExtractFilePath(Application.ExeName) +
                                LeINI('modulos',
                                'dll_ECF');
                            hand := LoadLibrary(PChar(straux));
                            @TotalizaCupom := GetProcAddress(hand,'Totalizacupom');

                            @COO := GetProcAddress(hand, 'COO');

                            straux := TotalizaCupom(StrToInt(leini('terminal',
                                'ModECF')),
                                StrToInt(leini('terminal', 'comECF')),
                                '00',
                                floattostr(StrToFloat(TOtalPedidoVenda)));

                            NumeroCupom := Copy(COO(StrToInt(leini('terminal',
                                'ModECF')),
                                StrToInt(leini('terminal', 'comECF')), '1'), 2,
                                    6);

                            //correção - Estava gravando o codigo do cliente = ao codigo do vendedor.
                            //28/04/2003 - Charles
                            Log('grava_log_pagamento : (' +
                                dsFormasPagamento.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString
                                + ' ' +
                                ',0 ,' +
                                Cliente + ', ' +
                                Vendedor + ', ' +
                                dsFormasPagamento.FieldByName('CODIGOFORMAFATURAMENTO').AsString
                                + ', ' +
                                PChar(@lblFalta.Caption[Length(CurrencyString) +
                                    1]) + ', ' +
                                '00000000' + ', ' +
                                mskValor.Text + ', ' + '0' + ', ' + '0' + ', ' +
                                    '0' + ', ' +
                                '0)'
                                );

                            FreeLibrary(HAND);
                            FreeAndNil(auxDataSet);
                            mskValor.Tag := 1;
                            Finaliza;
                            mskValor.Clear;
                        end
                        else
                            Finaliza;
            end;

    end;

end;

{
  Procedimento : TfrmFechaECF.FormCreate
  Autor        : charles
  Data         : 23-mai-2003
  Argumentos   : Sender: TObject
  Retorno      : None
}

procedure TfrmFechaECF.FormCreate(Sender: TObject);
var
    TotalizaCupom: FTotalizacupom;
    hand: THandle;
    strAux: string;
begin
    mskValor.Text := formatfloat('0.00', StrToFloatdef(mskValor.Text, 0));
    strAux := ExtractFilePath(Application.ExeName) + LeINI('modulos','dll_ECF');

    hand := LoadLibrary(PChar(straux));
    @TotalizaCupom := GetProcAddress(hand, 'Totalizacupom');
    mskValor.Text := '0,00';
    if straux[1] = '#' then
        Application.MessageBox(Pchar('Ocorreu um erro durante o envio do comando para a impressora'#13 +
            'Erro: ' + PChar(@Straux[2])), TITULO_MENSAGEM, MB_ICONERROR +
                MB_OK);
    @TotalizaCupom := nil;
    FreeLibrary(hand)
end;

{
  Procedimento : TfrmFechaECF.mskValorKeyPress
  Autor        : charles
  Data         : 23-mai-2003
  Argumentos   : Sender: TObject; var Key: Char
  Retorno      : None
}

procedure TfrmFechaECF.mskValorKeyPress(Sender: TObject; var Key: Char);
begin
    //prefiro fazer o controle dessa forma. Charles.
    if key = '.' then
        key := ',';
    if not (key in ['0'..'9', #8, DecimalSeparator]) then
        key := #0;
    if (key = DecimalSeparator) and (Pos(DecimalSeparator, (Sender as
        TCustomEdit).Text) > 0) and
        (Length((Sender as TCustomEdit).Text) <> Length((Sender as
        TCustomEdit).SelText)) then
        key := #0;
end;

{
  Procedimento : TfrmFechaECF.mskValorExit
  Autor        : charles
  Data         : 23-mai-2003
  Argumentos   : Sender: TObject
  Retorno      : None
}

procedure TfrmFechaECF.mskValorExit(Sender: TObject);
begin
    (Sender as TCustomEdit).Text := formatfloat('0.00', StrToFloatDef((Sender as
        TCustomEdit).Text, 0));
end;

{
  Procedure: TfrmFechaECF.Finaliza
  Autor:    charles
  Data:      19-mai-2003
  Argumentos: None
  Retorno:    None
}

procedure TfrmFechaECF.Finaliza;
var
    auxPedido: TDataSet;
    TotalizaCupom: FTotalizacupom;
    LeituraX: FLeituraX;
    TextoNF: FTextoNF;
    Contra_vale: FContra_vale;
    cnfv: FVenda_liquida;
    FecharCupom: FFecharCupom;
    COO: FCOO;
    vendaLiquida: FVenda_liquida;
    hand: THandle;
    strAux: string;
    comprovante: TStringList;
    i: Integer;
    banco, agencia, conta, numero_cheque, data_pre: string;
begin

    banco := '0';
    agencia := '0';
    conta := '0';
    numero_cheque := '0';
    data_pre := '0';
    mskValor.Text := formatfloat('0.00', StrToFloat(mskValor.Text));
    strAux := ExtractFilePath(Application.ExeName) + LeINI('modulos',
        'dll_ECF');
    hand := LoadLibrary(PChar(straux));
    @TotalizaCupom := GetProcAddress(hand, 'Totalizacupom');
    @FecharCupom := GetProcAddress(hand, 'FecharCupom');
    @LeituraX := GetProcAddress(hand, 'LeituraX');
    @TextoNF := GetProcAddress(hand, 'TextoNF');
    @COO := GetProcAddress(hand, 'COO');
    @Contra_vale := GetProcAddress(hand, 'Contra_vale');
    @vendaLiquida := GetProcAddress(hand, 'Venda_liquida');
    @cnfv := GetProcAddress(hand, 'cnfv');

    if dsFormasPagamento.FieldByName('impressaocheque').AsString = 'T' then
    begin
        if LeINI('terminal', 'LCHQ') = 0 then
        begin
            frmdadoscheque := tfrmdadoscheque.Create(self);
            frmDadosCheque.strTotalPedido := FloatToStr(TotalPedido);
            frmDadosCheque.lblPre.Visible :=
                (dsFormasPagamento.FieldByName('primeiraparcela').AsFloat > 0);
            frmDadosCheque.mskDataCheque.Visible :=
                frmDadosCheque.lblPre.Visible;
            frmDadosCheque.mskDataCheque.Text := DateToStr(now +
                dsFormasPagamento.FieldByName('primeiraparcela').AsFloat);
            frmDadosCheque.ShowModal;
            with frmDadosCheque do
            begin
                banco := mskBanco.Text;
                agencia := mskAgencia.Text + mskAgenciaDigito.Text;
                conta := mskConta.Text + mskContaDigito.Text;
                numero_cheque := mskNumero.Text + mskNumeroDigito.Text;
                data_pre := mskDataCheque.Text;
            end;
            freeandnil(frmDadosCheque);
        end
        else
        begin
            frmChequeLeitor := TfrmChequeLeitor.Create(Self);
            frmChequeLeitor.strTotalPedido := FloatToStr(TotalPedido);
            frmChequeLeitor.mskDataCheque.Text := DateToStr(now +
                dsFormasPagamento.FieldByName('primeiraparcela').AsFloat);
            frmChequeLeitor.ShowModal;
            banco := IntToStr(frmChequeLeitor.banco);
            agencia := IntToStr(frmChequeLeitor.agencia);
            conta := IntToStr(frmChequeLeitor.conta);
            numero_cheque := IntToStr(frmChequeLeitor.cheque);
            data_pre := FormatDateTime('mm/dd/yyyy',
                strtodate(frmChequeLeitor.mskDataCheque.Text));
            FreeAndNil(frmChequeLeitor);
        end;
    end;

    if ( StrToFloat(floattostrf(TotalPedido,ffFixed,18,2)) - StrToFloat(mskValor.Text) < 0) and
        (dsFormasPagamento.FieldByName('TIPOTROCO').AsInteger = 0) then
    begin
        Application.messagebox('Esta finalizadora não permite troco.'#13'Por favor informe o valor EXATO da operação.', TITULO_MENSAGEM, MB_OK + MB_ICONINFORMATION);

        mskValor.Text := FloatToStrF(TotalPedido,ffFixed,18,2);
        Exit;
    end;

    //envia a totalizacao para o ecf
    straux := TotalizaCupom(StrToInt(leini('terminal', 'ModECF')),
        StrToInt(leini('terminal', 'comECF')),
        dsFormasPagamento.FieldByName('codigoformafaturamento').AsString,
        mskValor.Text);


    if TrataerroImpressora(strAux) then // retorna true quando nao tem erro
    begin
        TotalPedido := StrToFloat(floattostrf(TotalPedido, ffFixed, 18, 2)) -
            StrToFloat(mskValor.Text);

        if (TotalPedido > 0) then
        begin
            GravaFechamentoCupom(dsFormasPagamento.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString,
                '0', '0', '0', StringReplace(mskValor.Text, ',', '.', []),
                    banco,
                numero_cheque, agencia, conta, data_pre, Vendedor,
                    LeINI(TIPO_TERMINAL,
                'ultimocupom'));

        end
        else if (TotalPedido <= 0) then
        begin
            mskValor.Enabled := False;
            if leini('terminal', 'ofgaveta') = 1 then
            begin
                tmrGaveta.Enabled := True;
                tmrFecha.Enabled := True;
            end
            else
                tmrFecha.Enabled := True;
            straux := FecharCupom(StrToInt(leini('terminal', 'ModECF')),
                StrToInt(leini('terminal', 'comECF')),
                '0', '1',
                LeINI('cortesia', 'MCLinha1'),
                LeINI('cortesia', 'MCLinha2'),
                LeINI('cortesia', 'MCLinha3'),
                LeINI('cortesia', 'MCLinha4'),
                LeINI('cortesia', 'MCLinha5'),
                LeINI('cortesia', 'MCLinha6'),
                LeINI('cortesia', 'MCLinha7'),
                LeINI('cortesia', 'MCLinha8'));


            if straux[1] = '#' then //verifica se tem erro
                Application.MessageBox(Pchar('Ocorreu um erro durante o envio do comando para a impressora'#13 +
                    'Erro: ' + PChar(@Straux[2])), TITULO_MENSAGEM, MB_ICONERROR
                        + MB_OK)
            else if (TotalPedido <= 0) or (gbReceber.Caption = 'TROCO') then
            begin
                if StrToIntDef(leini(TIPO_TERMINAL, 'ComprovantePagamento'), 0)= 1 then
                begin
                    strAux := cnfv(StrToInt(leini('terminal', 'ModECF')), StrToInt(leini('terminal', 'comECF')));
                    Log('Abertura do comprovante não fiscal: ' + strAux);
                    if TrataerroImpressora(strAux) then
                    begin
                        Log('Lançando linhas nao fiscais');
                        // existe um erro nesse bloco!!!
                        comprovante := TStringList.Create;
                        comprovante.Add('-------------------------');
                        comprovante.Add('COMPROVANTE DE FECHAMENTO');
                        comprovante.Add('-------------------------');
                        comprovante.Add('DATA    : ' + DateToStr(NOW) +
                            ' HORA : ' +  TimeToStr(Now));
                        comprovante.Add('MESA    : ' + Pedido);
                        comprovante.Add('OPERADOR: ' + LeINI('OPER', 'CODIGO', 'dados\oper.ini')
                        + ' ' + LeINI('OPER', 'NOME', 'dados\oper.ini'));
                        comprovante.Add('GARCOM  : ' +
                            dmORC.ConsultaVen_CodigoVendedor(Vendedor) + ' ' +
                            dmORC.ConsultaNomeVendedor(Vendedor));
                        comprovante.Add('CUPOM   : ' + NumeroCupom);
                        comprovante.Add('TOTAL   : ' + CurrencyString +
                            formatfloat('0.00',
                            StrToFloat(TOtalPedidoVenda)));
                        comprovante.Add('PESSOAS : ' + formatfloat('000',
                            StrToFloat(NumPessoas)));
                        comprovante.Add('---' + TITULO_MENSAGEM + '---');
                        sleep(3000);
                        for i := 0 to comprovante.Count - 1 do
                            TextoNF(StrToInt(leini('terminal', 'ModECF')),
                                StrToInt(leini('terminal', 'comECF')),
                                    comprovante.Strings[i],
                                '0');
                        Log('Fechamento do comprovante não fiscal');
                        FecharCupom(StrToInt(leini('terminal', 'ModECF')),
                            StrToInt(leini('terminal', 'comECF')),
                            '0', '1',
                            LeINI('cortesia', 'MCLinha1'),
                            LeINI('cortesia', 'MCLinha2'),
                            LeINI('cortesia', 'MCLinha3'),
                            LeINI('cortesia', 'MCLinha4'),
                            LeINI('cortesia', 'MCLinha5'),
                            LeINI('cortesia', 'MCLinha6'),
                            LeINI('cortesia', 'MCLinha7'),
                            LeINI('cortesia', 'MCLinha8'));
                        FreeAndNil(comprovante);
                    end;
                end;

                    Log('Fechamento do cupom. Total do pedido -> ' +
                        FloatToStr(TotalPedido) + ' Tipo Troco -> ' +
                        dsFormasPagamento.FieldByName('TIPOTROCO').AsString);

                    Log('Forma de pagmento: '+dsFormasPagamento.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString+' TROCO:'+dsFormasPagamento.FieldByName('TIPOTROCO').AsString);
                    case dsFormasPagamento.FieldByName('TIPOTROCO').AsInteger of
                        0: //não permite
                            begin
                                DecimalSeparator := '.';
                                GravaFechamentoCupom(
                                    dsFormasPagamento.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString,
                                    '0',
                                    '0',
                                    '0',
                                    StringReplace(mskValor.Text, ',', '.', []),
                                    banco, numero_cheque, agencia, conta,
                                        data_pre,
                                    Vendedor,
                                    LeINI(TIPO_TERMINAL, 'ultimocupom'));
                                DecimalSeparator := ',';
                            end;
                        1:
                            begin //permite troco
                                DecimalSeparator := '.';
                                GravaFechamentoCupom(
                                    dsFormasPagamento.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString,
                                    '0',
                                    floattostr(TotalPedido * -1),
                                    '0',
                                    StringReplace(mskValor.Text, ',', '.', []),
                                    banco, numero_cheque, agencia, conta,
                                        data_pre,
                                    Vendedor,
                                    LeINI(TIPO_TERMINAL, 'ultimocupom'));
                                DecimalSeparator := ',';
                            end;
                        2:
                            begin //contravale
                                DecimalSeparator := '.';
                                if TotalPedido < 0 then
                                begin
                                    DecimalSeparator := '.';
                                    strAux :=
                                        Contra_vale(StrToInt(leini('terminal',
                                        'ModECF')),
                                        StrToInt(leini('terminal', 'comECF')),
                                            FLOATTOSTR(TotalPedido
                                        *
                                        -1) + '|' +
                                        dsFormasPagamento.FieldByName('FORMAFATURAMENTO').AsString);
                                    if TrataerroImpressora(straux) then
                                    begin
                                        straux :=
                                            Contra_vale(StrToInt(leini('terminal',
                                            'ModECF')),
                                            StrToInt(leini('terminal',
                                                'comECF')),
                                            FLOATTOSTR(TotalPedido
                                            * -1) + '|' +
                                            dsFormasPagamento.FieldByName('FORMAFATURAMENTO').AsString);
                                        i := 0;
                                        while straux[1] <> '@' do
                                        begin
                                            // corrigido para tentar algumas vezes antes de sair por erro.
                                            strAux :=
                                                Contra_vale(StrToInt(leini('terminal',
                                                'ModECF')),
                                                    StrToInt(leini('terminal',
                                                    'comECF')),
                                                FLOATTOSTR(TotalPedido * -1) +
                                                    '|' +
                                                dsFormasPagamento.FieldByName('FORMAFATURAMENTO').AsString);
                                            Inc(i);
                                            if i > 2 then
                                            begin
                                                TrataerroImpressora(strAux);
                                                Exit;
                                            end;
                                        end;
                                        GravaFechamentoCupom(
                                            dsFormasPagamento.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString,
                                            '0',
                                            '0',
                                            floattostr(TotalPedido * -1),
                                            StringReplace(mskValor.Text, ',',
                                                '.', []),
                                            banco, numero_cheque, agencia,
                                                conta, data_pre,
                                            Vendedor,
                                            LeINI(TIPO_TERMINAL,
                                                'ultimocupom'));
                                    end;
                                end
                                else
                                    GravaFechamentoCupom(
                                        dsFormasPagamento.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString,
                                        '0',
                                        '0',
                                        '0',
                                        StringReplace(mskValor.Text, ',', '.',
                                            []),
                                        banco, numero_cheque, agencia, conta,
                                            data_pre,
                                        Vendedor,
                                        LeINI(TIPO_TERMINAL, 'ultimocupom'));
                                DecimalSeparator := ',';

                            end;
                        3:
                            begin //pergunta por repique
                                DecimalSeparator := '.';
                                if TotalPedido < 0 then
                                begin
                                    if
                                        Application.MessageBox('Deseja lançar o troco como repique?',
                                        TITULO_MENSAGEM, MB_YESNO +
                                            MB_ICONQUESTION) = IDYES then
                                    begin
                                        GravaFechamentoCupom(
                                            dsFormasPagamento.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString,
                                            floattostr(TotalPedido * -1),
                                            '0',
                                            '0',
                                            StringReplace(mskValor.Text, ',',
                                                '.', []),
                                            banco, numero_cheque, agencia,
                                                conta, data_pre,
                                            Vendedor,
                                            LeINI(TIPO_TERMINAL,
                                                'ultimocupom'));
                                    end
                                    else
                                    begin
                                        GravaFechamentoCupom(
                                            dsFormasPagamento.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString,
                                            '0',
                                            floattostr(TotalPedido * -1),
                                            '0',
                                            StringReplace(mskValor.Text, ',',
                                                '.', []),
                                            banco, numero_cheque, agencia,
                                                conta, data_pre,
                                            Vendedor,
                                            LeINI(TIPO_TERMINAL,
                                                'ultimocupom'));
                                    end;
                                end
                                else
                                begin
                                    GravaFechamentoCupom(
                                        dsFormasPagamento.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString,
                                        '0',
                                        '0',
                                        '0',
                                        StringReplace(mskValor.Text, ',', '.',
                                            []),
                                        banco, numero_cheque, agencia, conta,
                                            data_pre,
                                        Vendedor,
                                        LeINI(TIPO_TERMINAL, 'ultimocupom'));
                                end;
                                DecimalSeparator := ',';
                            end;
                    end;
            end;


            tmrFecha.Enabled := True;
            if strtointdef(LeINI(TIPO_TERMINAL, 'armazena_orc'), 0) = 0 then
            begin
                auxPedido := dmORC.ConsultaPedido(Pedido);
                dmORC.RunSQL('DELETE FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' +
                    Pedido);
                dmORC.RunSQL('delete from produtopedidovenda where codigopedidovenda = '
                    + auxPedido.FieldByName('CODIGOPEDIDOVENDA').AsString);
                dmORC.Commit;
                FreeAndNil(auxpedido);
            end
            else  //13/06/2003 - Por Helder Frederico: Rotina para que o campo situcao marque que o pedido foi recebido (faturado)
            begin
                auxPedido := dmORC.ConsultaPedido(Pedido);
                dmORC.RunSQL('update PEDIDOVENDA set situacao='+quotedstr('X')+
                             ' where NUMEROPEDIDO = ' + Pedido);
                dmORC.Commit;
                FreeAndNil(auxpedido);
            end;
        end
        else
            lblFalta.Caption := CurrencyString + FloatToStrF(TotalPedido,
                ffFixed, 18, 2);
    end;
    mskValor.SelectAll;
end;

procedure TfrmFechaECF.FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    case key of
        VK_RETURN:
            begin
                Perform(WM_NEXTDLGCTL, 0, 0);
            end;
        VK_DOWN:
            begin
                if not (ActiveControl is TTreeView) then
                    Perform(WM_NEXTDLGCTL, 0, 0);
            end;
        VK_UP:
            begin
                if not (ActiveControl is TTreeView) then
                    Perform(WM_NEXTDLGCTL, 1, 0);
            end;

        VK_F1:
            begin
                if spdAcrescimoValor.Enabled then
                    spdAcrescimoValor.Click;
            end;

        VK_F2:
            begin
                if spdAcrescimoPercentual.Enabled then
                    spdAcrescimoPercentual.Click;
            end;

        VK_F3:
            begin
                if spDescontoValor.Enabled then
                    spDescontoValor.Click;
            end;
        VK_F4:
            begin
                if spDescontoPercentual.Enabled then
                    spDescontoPercentual.Click;
            end;
        VK_F5:
            begin
                if spCancelaVenda.Enabled then
                    spCancelaVenda.Click;
            end;
        VK_ESCAPE: spdVoltar.Click
    end;
end;

procedure TfrmFechaECF.spdVoltarClick(Sender: TObject);
begin
    if lbFormaPagamentos.Enabled then
        lbFormaPagamentos.SetFocus;
    mskValor.Text := '0' + DecimalSeparator + '00';
end;

procedure TfrmFechaECF.spdAcrescimoValorClick(Sender: TObject);
var
    key: Word;
begin
    key := VK_RETURN;
    mskModificadores.Tag := (Sender as TComponent).Tag;
    lblModificador.Caption := Copy((Sender as TSpeedButton).Caption, 7, 50);
    if mskModificadores.Tag <> 5 then
    begin
        pnlModificador.Show;
        if mskModificadores.Enabled then
            mskModificadores.SetFocus;
    end
    else
        mskModificadores.OnKeyDown(nil, key, []);
end;

procedure TfrmFechaECF.mskModificadoresKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
var
    AcreSub: FAcreSub;
    DescSub: FDescSub;
    Cancelacupom: FCancelacupom;
    vendaLiquida: FVenda_liquida;
    hand: THandle;
    auxResposta: Integer;
    straux: string;
    i: Integer;
begin
    auxResposta := 0;
    if key = vk_escape then
        pnlModificador.Hide
    else if key = VK_RETURN then
    begin
        mskModificadores.OnExit(Sender);
        strAux := ExtractFilePath(Application.ExeName) + LeINI('modulos',
            'dll_ECF');
        hand := LoadLibrary(PChar(straux));
        @vendaLiquida := GetProcAddress(hand, 'Venda_liquida');
        if mskModificadores.Tag = 5 then //cancelamento
        begin
            if Application.MessageBox('Confirma o cancelamento da venda?',
                TITULO_MENSAGEM, MB_YESNO + MB_ICONQUESTION) = idyes then
            begin
                @Cancelacupom := GetProcAddress(hand, 'Cancelacupom');
                if TrataerroImpressora(Cancelacupom(StrToInt(leini('terminal',
                    'ModECF')),
                    StrToInt(leini('terminal', 'comECF')),
                    '0',
                    vendaLiquida(StrToInt(leini('terminal', 'ModECF')),
                    StrToInt(leini('terminal', 'comECF'))))) then
                    GravaCancelamentoVenda(LeINI(TIPO_TERMINAL, 'ultimocupom'));
                FreeLibrary(hand);
                Close;
            end;
        end
        else if (mskModificadores.Tag = 2) or (mskModificadores.Tag = 4) then
            auxResposta :=
                Application.MessageBox(pchar('Confirma o lançamento do ' +
                lblModificador.Caption + ' no valor de ' + mskModificadores.Text
                    +
                ' %?'),
                TITULO_MENSAGEM, MB_YESNO + MB_ICONQUESTION)
        else
            auxResposta :=
                Application.MessageBox(pchar('Confirma o lançamento do ' +
                lblModificador.Caption + ' no valor de ' + CurrencyString +
                mskModificadores.Text + ' ?'), TITULO_MENSAGEM, MB_YESNO +
                MB_ICONQUESTION);

        if auxResposta = idyes then
        begin
            // é necessário calcular o valor do acréscimo e depois
            // ratear entre os itens vendidos. Tanto para o acréscimo  quanto para o
            // desconto.
            case mskModificadores.Tag of
                1:
                    begin
                        @AcreSub := GetProcAddress(hand, 'AcreSub');
                        straux := AcreSub(StrToInt(leini('terminal', 'ModECF')),
                            StrToInt(leini('terminal', 'comECF')),
                            mskModificadores.Text, '2');
                        if straux[1] = '#' then
                            Application.MessageBox(pchar('Ocorreu um erro durante o envio do comando para a impressora.'#13 +
                                'Erro: ' + pchar(@Straux[2])), TITULO_MENSAGEM,
                                    MB_OK +
                                MB_ICONERROR)
                        else
                        begin
                            AjustaAcrescimo(mskModificadores.Text, pedido,
                                mskModificadores.Tag);
                            lblTotalCupom.Caption := CurrencyString +
                                floattostrF(StrToFloatDef(PChar(@lblTotalCupom.Caption[Length(CurrencyString) +
                                    1]), 0) + StrToFloatDef(mskModificadores.Text,
                                    0),
                                    fffixed, 18, 2);
                            lblFalta.Caption := CurrencyString +
                                floattostrF(StrToFloatDef(PChar(@lblFalta.Caption[Length(CurrencyString) + 1]),
                                    0) + StrToFloatDef(mskModificadores.Text, 0),
                                    ffFixed, 18, 2);
                            TotalPedido := TotalPedido +
                                StrToFloat(mskModificadores.Text);
                            spdAcrescimoValor.Enabled := False;
                            spdAcrescimoPercentual.Enabled := False;
                            pnlModificador.Hide;
                        end;
                    end;
                2:
                    begin
                        @AcreSub := GetProcAddress(hand, 'AcreSub');
                        straux := AcreSub(StrToInt(leini('terminal', 'ModECF')),
                            StrToInt(leini('terminal', 'comECF')),
                            formatfloat('0.00', (TotalPedido *
                            StrToFloat(mskModificadores.Text)) / 100), '2');
                        if straux[1] = '#' then
                            Application.MessageBox(pchar('Ocorreu um erro durante o envio do comando para a impressora.'#13 +
                                'Erro: ' + pchar(@Straux[2])), TITULO_MENSAGEM,
                                    MB_OK +
                                MB_ICONERROR)
                        else
                        begin
                            AjustaAcrescimo(mskModificadores.Text, pedido,
                                mskModificadores.Tag);
                            TotalPedido := TotalPedido +
                                dmORC.CalculaAcrescimo(PChar(@lblTotalCupom.Caption[Length(CurrencyString) + 1]), mskModificadores.Text);
                            lblTotalCupom.Caption := CurrencyString +
                                FloatToStrF(TotalPedido,
                                ffFixed, 18, 2);
                            lblFalta.Caption := lblTotalCupom.Caption;
                            spdAcrescimoValor.Enabled := False;
                            spdAcrescimoPercentual.Enabled := False;
                            pnlModificador.Hide;
                        end;
                    end;
                3:
                    begin
                        @DescSub := GetProcAddress(hand, 'DescSub');
                        straux := DescSub(StrToInt(leini('terminal', 'ModECF')),
                            StrToInt(leini('terminal', 'comECF')),
                            mskModificadores.Text);
                        if straux[1] = '#' then
                            Application.MessageBox(pchar('Ocorreu um erro durante o envio do comando para a impressora.'#13 +
                                'Erro: ' + pchar(@Straux[2])), TITULO_MENSAGEM,
                                    MB_OK +
                                MB_ICONERROR)
                        else
                        begin
                            AjustaAcrescimo(mskModificadores.text, pedido,
                                mskModificadores.Tag);
                            lblTotalCupom.Caption := CurrencyString +
                                floattostrF(StrToFloatDef(PChar(@lblTotalCupom.Caption[Length(CurrencyString) +
                                    1]), 0) - StrToFloatDef(mskModificadores.Text,
                                    0),
                                    fffixed, 18, 2);
                            lblFalta.Caption := CurrencyString +
                                floattostrF(StrToFloatDef(PChar(@lblFalta.Caption[Length(CurrencyString) + 1]),
                                    0) - StrToFloatDef(mskModificadores.Text, 0),
                                    ffFixed, 18, 2);
                            TotalPedido := TotalPedido -
                                StrToFloat(floattostrF(StrToFloatDef(PChar(@lblFalta.Caption[Length(CurrencyString) + 1]), 0) - StrToFloatDef(mskModificadores.Text,
                                    0), ffFixed,
                                18, 2));
                            spDescontoValor.Enabled := False;
                            spDescontoPercentual.Enabled := False;
                            pnlModificador.Hide;
                        end;
                    end;
                4:
                    begin
                        @DescSub := GetProcAddress(hand, 'DescSub');
                        straux := DescSub(StrToInt(leini('terminal', 'ModECF')),
                            StrToInt(leini('terminal', 'comECF')),
                            dmORC.CalculaAcrescimo(floattostr(TotalPedido),
                            mskModificadores.Text));
                        if straux[1] = '#' then
                            Application.MessageBox(pchar('Ocorreu um erro durante o envio do comando para a impressora.'#13 +
                                'Erro: ' + pchar(@Straux[2])), TITULO_MENSAGEM,
                                    MB_OK +
                                MB_ICONERROR)
                        else
                        begin
                            AjustaAcrescimo(mskModificadores.Text, pedido,
                                mskModificadores.Tag);
                            spDescontoValor.Enabled := False;
                            spDescontoPercentual.Enabled := False;
                            TotalPedido := TotalPedido -
                                dmORC.CalculaAcrescimo(FloatToStr(TotalPedido),
                                mskModificadores.Text);
                            lblTotalCupom.Caption := currencystring +
                                FloatToStrF(TotalPedido,
                                ffFixed, 18, 2);
                            lblFalta.Caption := lblTotalCupom.Caption;
                            pnlModificador.Hide;
                        end;

                    end;
            end;
            straux := vendaLiquida(StrToInt(leini('terminal', 'ModECF')),
                StrToInt(leini('terminal', 'comECF')));
            i := 0;
            while straux[1] <> '@' do
            begin
                // corrigido para tentar algumas vezes antes de sair por erro.
                strAux := vendaLiquida(StrToInt(leini('terminal', 'ModECF')),
                    StrToInt(leini('terminal', 'comECF')));
                Inc(i);
                if i > 2 then
                begin
                    TrataerroImpressora(strAux);
                    Exit;
                end;
            end;
            TotalPedido := StrToFloat(Copy(straux, 2, Length(straux))) / 100;
            FreeLibrary(hand);
        end;
    end;
end;

procedure TfrmFechaECF.lbFormaPagamentosKeyDown(Sender: TObject;
    var Key: Word; Shift: TShiftState);
begin
    if key = VK_RETURN then
        if mskValor.Enabled then
            mskValor.SetFocus;
end;

procedure TfrmFechaECF.tmrFechaTimer(Sender: TObject);
begin
    Close;
end;

procedure TfrmFechaECF.tmrGavetaTimer(Sender: TObject);
begin
    //verificar se o cara fechou a gaveta.
    if leini('terminal', 'ofgaveta') = 1 then
    begin
        if GavetaAberta then
        begin
            tmrGaveta.Enabled := False;
            Application.MessageBox('Favor fechar a gaveta antes de continuar.',
                TITULO_MENSAGEM, MB_OK + MB_ICONWARNING);
            tmrGaveta.Enabled := true;
            tmrFecha.Enabled := True;
        end;
    end
    else
        tmrFecha.Enabled := True;
end;

procedure TfrmFechaECF.SetVendedor(const Value: string);
begin
    FVendedor := Value;
end;

procedure TfrmFechaECF.SetNumPessoas(const Value: string);
begin
    FNumPessoas := Value;
end;

procedure TfrmFechaECF.SetTOtalPedidoVenda(const Value: string);
begin
    FTOtalPedidoVenda := Value;
end;

procedure TfrmFechaECF.SetCliente(const Value: string);
begin
    FCliente := Value;
end;

procedure TfrmFechaECF.SetTotalPedido(const Value: Real);
begin
    FTotalPedido := Value;
    if TotalPedido > 0 then
    begin
        gbReceber.Caption := 'FALTA';
        lblFalta.Caption := FloatToStrF(FTotalPedido, ffCurrency, 18, 2);
    end
    else
    begin
        gbReceber.Caption := 'TROCO';
        lblFalta.Caption := FloatToStrF(FTotalPedido * -1, ffCurrency, 18, 2);
    end;
    Application.ProcessMessages();
end;

end.
//******************************************************************************
//*                          End of File uFechaNormal.pas
//******************************************************************************

