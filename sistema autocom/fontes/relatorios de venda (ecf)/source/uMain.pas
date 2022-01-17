unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, ComCtrls, ToolWin, ImgList, IniFiles,
  uGlobal, DB, SUIMemo, SUIForm, SUIThemes, SUIButton, SUIMgr,midaslib;

type
  TOptionsReturn = record
    IntCodeReturn: Integer;
    ExtCodeReturn: Integer;
    StringReturn: String;
  end;

type
  TKindOfConsulta = (Produto, Operador,  Indicador, Cliente, Grupo);
  FLeituraX = function (tipo,porta:integer;NF:string): ShortString;
  FTextoNF = function (tipo,porta:integer;texto,valor:string): ShortString;
  FFecharCupom  = function (tipo,porta:integer; SegCp,CNFV,l1,l2,l3,l4,l5,l6,l7,l8:string):ShortString;
  FECF_INFO = function (tipo,porta:integer):ShortString;
  TRelatorio = set of (RelProdutos, RelGrupos, RelOperadores, RelFaixaHoraria, RelExtratoDeCheques, RelIndicadores, RelExtratoDeConvenios, RelSaldoDeClientes, RelSangrias);
  TfMain = class(TForm)
    suiForm1: TsuiForm;
    MemoMain: TsuiMemo;
    BtnFechar: TsuiButton;
    BtnVerde: TSpeedButton;
    BtnVermelho: TSpeedButton;
    BtnImprimirRelatorios: TsuiButton;
    BtnGerarRelatorios: TsuiButton;
    PanBottom: TLabel;
    skin: TsuiThemeManager;
    BtnSangrias: TsuiButton;
    BtnSaldoDeClientes: TsuiButton;
    BtnExtratoDeConvenios: TsuiButton;
    BtnIndicadores: TsuiButton;
    BtnExtratoDeCheques: TsuiButton;
    BtnFaixaHoraria: TsuiButton;
    BtnOperadores: TsuiButton;
    BtnGrupos: TsuiButton;
    BtnProdutos: TsuiButton;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnGerarRelatoriosClick(Sender: TObject);
    procedure BtnGeralClick(Sender: TObject);
    procedure BtnImprimirRelatoriosClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure ActivateDatabase;
    function SelectReports: TRelatorio;
    function CreateReport(Rel: TRelatorio): TStringList;
    procedure PrintOnSreen;
    procedure PrintOnPrinter;
    procedure CallOpcoes;
    procedure ArrayHoras;
    function NPessoas(Codigo: Integer): Real;
  public
    FRelatoriosSelecionados: TRelatorio;
    OptionsReturn:TOptionsReturn;
  end;

type
  {Para Armazenar Opcoes}
  TRelOptions = record
    X: String;
    Y: String;
  end;



type
  {Para Armazenar Dados por Faixa Horaria}
  TFaixaHoraria = record
    Clientes: Real;
    Valor:    Real;
  end;

var
  fMain: TfMain;
    S_Terminal: String;
    S_NumeroLoja: String;
    I_CodigoOperador: Integer;
    S_DataFinal: string;
    S_DataInicial: string;
    CurrentButton: TsuiButton;
    Fcx: Real;
    {Variaveis para Impressão Fiscal}
    TextoNF: FTextoNF;
    LeituraX: FLeituraX;
    FecharCupom: FFecharCupom;
    ECF_INFO: FECF_INFO;
    {Variavel para armazar configurações}
    RelOptions: array[1..9] of TRelOptions;
    {Variavel para armazar dados por faixa horaria}
    FaixaHoraria: array[0..23] of TFaixaHoraria;
    ActiveConsulta : TKindOfConsulta;

implementation

uses Module, uConfig, Math, DateUtils, uOptions, uWait;

{$R *.dfm}

                                                               { PROCEDIMENTOS }
{______________________________________________________________________________}
procedure TfMain.ActivateDatabase;
var
  Ds: TDataSet;
begin
  Dm.dbautocom.DatabaseName :=
    LeINI('ATCPLUS','IP_SERVER') + ':' + LeINI('ATCPLUS','PATH_DB');
  Dm.dbautocom.Connected := True;
  Dm.Transaction.Active := True;
  RunSQL('Select * From TipoPessoa',Dm.dbautocom,Ds);
  FreeAndNil(Ds);

end;

procedure TfMain.PrintOnPrinter;
{  procedure   : PrintOnPrinter                                                }
{  autor       : André Faria Gomes                                             }
{  data        : 06/05/2003                                                    }
{  objetivo    : Imprimir                                                      }
var
  EcfHandle: Integer;
  i: Integer;
  DllString: string;
  respostaECF:string;
begin
  PanBottom.Caption := 'Aguarde a Impressão';
  DllString := ExtractFilePath(application.ExeName) + LeINI('modulos','dll_ECF');
  EcfHandle :=LoadLibrary(PChar(DllString));
  @LeituraX := GetProcAddress(EcfHandle,'LeituraX');
  @TextoNF  := GetProcAddress(EcfHandle,'TextoNF');
  @FecharCupom := GetProcAddress(EcfHandle, 'FecharCupom');
  LeituraX(StrToInt(LeINI('TERMINAL','ModECF')), StrToInt(LeINI('TERMINAL','COMECF')),'1');

  for i := 0 to MemoMain.Lines.Count -1 do
  begin
    respostaECF:=TextoNF( StrToInt(leini('terminal','ModECF')),
      StrToInt(leini('terminal','comECF')),
      MemoMain.Lines[i],'0');
    case respostaECF[1] of '#':
        Application.MessageBox( Pchar('Ocorreu um erro durante o envio do comando para a impressora'#13 +
          'Erro: ' + Copy(respostaECF,2,Length(respostaECF))), 'Sistema Autocom Plus', MB_ICONERROR + MB_OK);
    end;

  end;

  respostaECF:=TextoNF( StrToInt(leini('terminal','ModECF')),
      StrToInt(leini('terminal','comECF')),
      '-- Sistema Autocom PLUS --','0');
  case respostaECF[1] of '#':
        Application.MessageBox( Pchar('Ocorreu um erro durante o envio do comando para a impressora'#13 +
          'Erro: ' + Copy(respostaECF,2,Length(respostaECF))), 'Sistema Autocom Plus', MB_ICONERROR + MB_OK);
  end;


  respostaECF:=FecharCupom( StrToInt(leini('terminal','ModECF')), StrToInt(leini('terminal','comECF')),'0','0','','','','','','','','');// todas as linhas de cortesia devem estar vazias
  case respostaECF[1] of '#':
       Application.MessageBox( Pchar('Ocorreu um erro durante o envio do comando para a impressora'#13 +
          'Erro: ' + Copy(respostaECF,2,Length(respostaECF))), 'Sistema Autocom Plus', MB_ICONERROR + MB_OK);
  end;

  PanBottom.Caption := NullAsStringValue;
end;

procedure TfMain.PrintOnSreen;
{  procedure   : PrintOnSreen                                                  }
{  autor       : André Faria Gomes                                             }
{  data        : 06/05/2003                                                    }
{  objetivo    : Imprimir na Tela                                              }
begin
  MemoMain.Lines.Assign(CreateReport(SelectReports));
end;

function TfMain.SelectReports: TRelatorio;
{  procedure   : SelectReports                                                 }
{  autor       : André Faria Gomes                                             }
{  data        : 06/05/2003                                                    }
{  objetivo    : Retornar Relatorios Selecionados para Impressao               }
begin
  Result := [];
  if BtnProdutos.hint = '0'           then Result := Result + [RelProdutos];
  if BtnGrupos.hint = '0'             then Result := Result + [RelGrupos];
  if BtnOperadores.hint = '0'         then Result := Result + [RelOperadores];
  if BtnFaixaHoraria.hint = '0'       then Result := Result + [RelFaixaHoraria];
  if BtnSaldoDeClientes.hint = '0'    then Result := Result + [RelSaldoDeClientes];
  if BtnExtratoDeConvenios.hint = '0' then Result := Result + [RelExtratoDeConvenios];
  if BtnIndicadores.hint = '0'        then Result := Result + [RelIndicadores];
  if BtnExtratoDeConvenios.hint = '0' then Result := Result + [RelExtratoDeConvenios];
  if BtnExtratoDeCheques.hint = '0'   then Result := Result + [RelExtratoDeCheques];
  if BtnSangrias.hint = '0'           then Result := Result + [RelSangrias];
end;

function TfMain.CreateReport(Rel: TRelatorio): TStringList;
{  procedure   : GerarRelatorio                                                }
{  autor       : André Faria Gomes                                             }
{  data        : 06/05/2003                                                    }
{  objetivo    : Gerar Relatórios e Retornar na StringList                     }
var
  Ds,DS2: TDataset;
  DsFinalizadores, DsSangrias, DsCancelados: TDataSet;
  Somatoria1, Somatoria2, Somatoria3, Somatoria4, Somatoria5: Real;
  SomaRecebido,SomaSangria:Real;
  i: Integer;
  v_Quantidade:string;
  v_CAncItem:string;
  v_CancCupom:string;
  v_FCX:string;
  codigoCliente_interno:string;
begin

  Result := TStringList.Create;
  Result.Clear;
  Result.Add('DATA DE REFERENCIA INICIAL: ' + S_DataInicial);
  Result.Add('DATA DE REFERENCIA FINAL  : ' + S_DataFinal);
  Result.add('________________________________________');
  Result.Add('                                        ');
  Result.Add(CenterText(Format('OPERADOR:%.4d - %.23s ',[I_CodigoOperador, Dm.BuscaNomeVendedor(I_CodigoOperador)]),40));
  Result.Add(CenterText('TERMINAL:' + S_Terminal,40));
  Result.add('________________________________________');
  Result.Add('                                        ');
  Result.Add('                                        ');

  {Imprime Relatório de Produtos}
  if RelProdutos in Rel then
    begin
      LogSend('logs\RVECF' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - Produtos Vendidos');

      ZeroMemory(@Somatoria1,SizeOf(Somatoria1));
      ZeroMemory(@Somatoria2,SizeOf(Somatoria2));
      ZeroMemory(@Somatoria3,SizeOf(Somatoria3));
      ZeroMemory(@Somatoria4,SizeOf(Somatoria4));


      RunSQL(' SELECT DISTINCT P.NOMEPRODUTO ,' +
             ' SUM(PD.QTDE) AS QTDE,' +
             ' SUM(PD.VALORUN) AS VALORUN,' +
             ' SUM((VALORUN * QTDE)  + ACRESCIMO - DESCONTO) AS VALORSOMA' +
             ' FROM PRODUTO P, PDV_DETALHECUPOM PD ' +
             ' WHERE P.CODIGOPRODUTO = PD.CODIGOPRODUTO ' +
             ' AND PD.CFG_CODCONFIG = ' + S_NumeroLoja +
             ' AND PD.DATAHORA >= ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) +
             ' AND PD.DATAHORA <= ' + QuotedStr(formatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + ' 23:59:59',Date))) +
             ' AND PD.IDUSUARIO = ' + IntToStr(I_CodigoOperador) +
             ' AND PD.CODIGOPRODUTO >= ' + RelOptions[1].X +
             ' AND PD.CODIGOPRODUTO <= ' + RelOptions[1].Y +
             ' AND PD.TERMINAL = ' + S_Terminal +
             ' AND (PD.SITUACAO IS NULL OR PD.SITUACAO = 0) ' +
             ' GROUP BY PRODUTO.NOMEPRODUTO ' +
             ' ORDER BY PRODUTO.NOMEPRODUTO'
             , Dm.dbautocom, Ds, True);


     Result.add('----------------------------------------');
      Result.Add(CenterText('PRODUTOS VENDIDOS',40));
      if not Ds.IsEmpty then
        begin
          Result.Add('----------------------------------------');
          Result.add(' PRODUTO           QUANTIDADE  VALOR(R$)');
          Result.add('----------------------------------------');
          while not Ds.Eof do
            begin
              Result.Add(Format(' %-17.17s  %9.3f %9f', [Ds.Fields[0].AsString, Ds.Fields[1].AsFloat, Ds.FieldByName('VALORSOMA').AsFloat]));
              Somatoria1 := Somatoria1 + Ds.FieldByName('VALORSOMA').AsFloat;
              Somatoria2 := Somatoria2 + Ds.FieldByName('QTDE').AsFloat;
              Ds.Next;
              Application.ProcessMessages;
            end;
          Result.add('----------------------------------------');
          Result.add(' SOMATORIA DE QTDE : ' + FormatFloat('0.000',Somatoria2));
          Result.add(' SOMATORIA DE VALOR: ' + FormatFloat(CurrencyString + '0.00',Somatoria1));
        end
      else
        begin
          Result.add('----------------------------------------');
          Result.Add(CenterText('NAO HA MOVIMENTO',40));
        end;
      Result.add('________________________________________');
      Result.Add('                                        ');
      Result.Add('                                        ');
      Result.Add('                                        ');
    end;

  {Imprime Relatório de Grupos}
  if RelGrupos  in Rel then
    begin
      LogSend('logs\RVECF' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - Grupo de produtos Vendidos');

      ZeroMemory(@i,SizeOf(i));
      ZeroMemory(@Somatoria1,SizeOf(Somatoria1));
      ZeroMemory(@Somatoria2,SizeOf(Somatoria2));
      ZeroMemory(@Somatoria3,SizeOf(Somatoria3));
      ZeroMemory(@Somatoria4,SizeOf(Somatoria4));

      RunSql(' SELECT DISTINCT  GP.GRUPOPRODUTO, SGP.SUBGRUPO,' +
             ' SUM(PD.QTDE) AS QTDE, SUM((VALORUN * QTDE)  + ACRESCIMO - DESCONTO) AS VALORSOMA, GP.CODIGOGRUPOPRODUTO' +
             ' FROM PRODUTO P, SUBGRUPOPRODUTO SGP, PDV_DETALHECUPOM PD' +
             ' INNER JOIN GRUPOPRODUTO GP ON (SGP.CODIGOGRUPOPRODUTO = GP.CODIGOGRUPOPRODUTO AND SGP.CODIGOSUBGRUPOPRODUTO = P.CODIGOSUBGRUPOPRODUTO AND P.CODIGOPRODUTO = PD.CODIGOPRODUTO)' +
             ' WHERE PD.CFG_CODCONFIG = ' + S_NumeroLoja +
             ' AND PD.TERMINAL = ' + S_Terminal +
             ' AND PD.DATAHORA >= ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) +
             ' AND PD.DATAHORA <= ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + ' 23:59:59',Date))) +
             ' AND PD.IDUSUARIO = ' + IntToStr(I_CodigoOperador) +
             ' AND GP.CODIGOGRUPOPRODUTO BETWEEN ' + RelOptions[2].X + ' AND ' + RelOptions[2].Y +
             ' AND (PD.SITUACAO IS NULL OR PD.SITUACAO = 0) ' +
             ' GROUP BY GP.GRUPOPRODUTO, SGP.SUBGRUPO, GP.CODIGOGRUPOPRODUTO ' +
             ' ORDER BY GP.CODIGOGRUPOPRODUTO, SGP.SUBGRUPO',Dm.dbautocom,Ds, True);

      Result.Add('----------------------------------------');
      Result.Add(CenterText('PRODUTOS VENDIDOS POR GRUPO',40));
      if not Ds.IsEmpty then
        begin
          Result.Add('----------------------------------------');
          Result.add('                 QUANTIDADE    VALOR(R$)');
          Result.add('----------------------------------------');
          ZeroMemory(@i,SizeOf(i));
          Ds.First;
          while not Ds.Eof do
            begin
              if Ds.FieldByName('CODIGOGRUPOPRODUTO').AsInteger <> i then
                begin
                  i := Ds.FieldByName('CODIGOGRUPOPRODUTO').AsInteger;
                  if Ds.RecNo <> 1 then Result.Add('----------------------------------------');
                  Result.Add(CenterText(Ds.FieldByName('GRUPOPRODUTO').AsString,40));
                  Result.Add(Format('   %-14.14s  %8.3f %11f', [Ds.FieldByName('SUBGRUPO').AsString, Ds.FieldByName('QTDE').AsFloat, Ds.FieldByName('VALORSOMA').AsFloat]));
                end
              else
                begin
                  Result.Add(Format('   %-14.14s  %8.3f %11f', [Ds.FieldByName('SUBGRUPO').AsString, Ds.FieldByName('QTDE').AsFloat, Ds.FieldByName('VALORSOMA').AsFloat]));
                end;
              Somatoria1 := Somatoria1 + Ds.FieldByName('VALORSOMA').AsFloat;
              Somatoria2 := Somatoria2 + Ds.FieldByName('QTDE').AsFloat;
              Ds.Next;
            end;
          Result.Add('----------------------------------------');
          Result.Add(' SOMATORIA DE QTDE : ' + FormatFloat('0.000',Somatoria2));
          Result.Add(' SOMATORIA DE VALOR: ' + FormatFloat(CurrencyString + '0.00',Somatoria1));
      end
    else
      begin
        Result.Add('----------------------------------------');
        Result.Add(CenterText('NAO HA MOVIMENTO',40));
      end;
      Result.Add('________________________________________');
      Result.Add('                                        ');
      Result.Add('                                        ');
      Result.Add('                                        ');
    end;

  {Imprime Relatório de Operadores}
  if RelOperadores in Rel then
    begin
      LogSend('logs\RVECF' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - Operadores vendidos');

      ZeroMemory(@Somatoria1,SizeOf(Somatoria1));
      ZeroMemory(@Somatoria2,SizeOf(Somatoria2));
      ZeroMemory(@Somatoria3,SizeOf(Somatoria3));
      ZeroMemory(@Somatoria4,SizeOf(Somatoria4));

    RunSQL('SELECT COUNT(CFG_CODCONFIG) as QUANTIDADE FROM PDV_CABECALHOCUPOM WHERE (SITUACAO <> 1 OR SITUACAO IS NULL) AND IDUSUARIO = ' + IntToStr(I_CodigoOperador) + ' AND DATAHORA >= ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) +  ' AND DATAHORA <= ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + '23:59:59',Date))) +  ' AND TERMINAL = ' + S_Terminal + ' AND CFG_CODCONFIG = ' + S_NumeroLoja ,Dm.dbautocom, Ds, True);
    v_Quantidade:=Ds.FieldByName('QUANTIDADE').AsString;

    RunSQL('SELECT COUNT(CFG_CODCONFIG) AS CANCITEM FROM PDV_DETALHECUPOM   WHERE SITUACAO = 1 AND IDUSUARIO = ' + IntToStr(I_CodigoOperador) + ' AND DATAHORA >= ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) +  ' AND DATAHORA <= ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + '23:59:59',Date))) +  ' AND TERMINAL = ' + S_Terminal + ' AND CFG_CODCONFIG = ' + S_NumeroLoja ,Dm.dbautocom, Ds, True);
    v_CancItem:=Ds.FieldByName('CANCITEM').AsString;

    RunSQL('SELECT COUNT(CFG_CODCONFIG) AS CANCVENDA FROM PDV_CABECALHOCUPOM WHERE SITUACAO = 1 AND IDUSUARIO = ' + IntToStr(I_CodigoOperador) + ' AND DATAHORA >= ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) +  ' AND DATAHORA <= ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + '23:59:59',Date))) +  ' AND TERMINAL = ' + S_Terminal + ' AND CFG_CODCONFIG = ' + S_NumeroLoja ,Dm.dbautocom, Ds, True);
    v_CancCupom:=Ds.FieldByName('CANCVENDA').AsString;

    RunSQL('SELECT SUM(VALOR) as FCX FROM PDV_MOVIMENTOEXTRA WHERE VALOR > 0 AND IDUSUARIO = ' + IntToStr(I_CodigoOperador) + ' AND DATA >= ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) +   ' AND DATA<= ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataFinal,Date))) +  ' AND TERMINAL = ' + S_Terminal + ' AND CFG_CODCONFIG = ' + S_NumeroLoja ,Dm.dbautocom, Ds, True);
    v_FCX:=Ds.FieldByName('FCX').AsString;
    try
       strtofloat(v_FCX);
    except
       v_FCX:='0';
    end;

    RunSQL(' SELECT  U.IDUSUARIO,' +
           ' SUM(PC.VALORCUPOM) AS VALOR,' +
           ' SUM(PC.ACRESCIMO) AS ACRESCIMO,' +
           ' SUM(PC.DESCONTO) AS DESCONTO ' +
           ' FROM PDV_CABECALHOCUPOM PC ' +
           ' INNER JOIN USUARIOSISTEMA U ON (U.IDUSUARIO = PC.IDUSUARIO)' +
           ' WHERE PC.DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + ' 23:59:59',Date))) +
           ' AND PC.IDUSUARIO = ' + IntToStr(I_CodigoOperador) +
           ' AND PC.TERMINAL = ' + S_Terminal +
           ' AND PC.SITUACAO <> 1 ' +
           ' GROUP BY U.IDUSUARIO',Dm.dbautocom, Ds, True);

//           ' AND PC.NCP NOT IN ( ' +

//           ' SELECT PC.NCP FROM PDV_FECHAMENTOCUPOM PF, PDV_CABECALHOCUPOM PC ' +
//           ' WHERE PC.TERMINAL = PF.TERMINAL ' +
//           ' AND PC.NCP = PF.NCP ' +
//           ' AND PC.CFG_CODCONFIG = PF.CFG_CODCONFIG ' +
//           ' AND SUBSTRING(PC.DATAHORA FROM 1 FOR 8) = SUBSTRING(PF.DATAHORA FROM 1 FOR 8) ' +
//           ' AND PF.CODIGOCONDICAOPAGAMENTO IN (SELECT CODIGOCONDICAOPAGAMENTO FROM CONDICAOPAGAMENTO WHERE SOMASALDO = ' + QuotedStr('F') + ')'  +

//           ') GROUP BY U.IDUSUARIO',Dm.dbautocom, Ds, True);
      Result.Add('----------------------------------------');
      Result.Add(CenterText('OPERADOR',40));
      Result.Add('----------------------------------------');
      if not Ds.IsEmpty then
        begin
//          while not Ds.Eof do
//            begin
              Result.Add(' OPERADOR.............: ' + Ds.FieldByName('IDUSUARIO').AsString);
              Result.Add(' QUANTIDADE DE VENDAS.: ' + v_Quantidade);
              Result.Add(' VALOR VENDIDO........: ' + CurrencyString + FormatCurr('0.00',Ds.FieldByName('VALOR').AsFloat));
              Result.Add(' CANCELAMENTO DE ITEM.: ' + v_CancItem);
              Result.Add(' CANCELAMENTO DE VENDA: ' + v_CancCupom);
              Result.Add(' ACRESCIMO............: ' + CurrencyString + FormatCurr('0.00',Ds.FieldByName('ACRESCIMO').AsFloat));
              Result.Add(' DESCONTO.............: ' + CurrencyString + FormatCurr('0.00',Ds.FieldByName('DESCONTO').AsFloat));
              Result.Add(' (a)FUNDO DE CAIXA....: '+ CurrencyString + FormatCurr('0.00',strtofloat(v_FCX)));
              //FCX - Varivel usada para calculo do saldo final no evento onCalc do ClientDataSet
              Fcx := strtofloat(v_FCX);
//              Ds.Next;
              Application.ProcessMessages;
//            end;
          Result.Add('                                        ');
        end
      else
        begin
          Result.Add(CenterText('NAO HA MOVIMENTO',40));
        end;

      ZeroMemory(@Somatoria1,SizeOf(Somatoria1));
      ZeroMemory(@Somatoria2,SizeOf(Somatoria2));
      ZeroMemory(@Somatoria3,SizeOf(Somatoria3));
      ZeroMemory(@Somatoria4,SizeOf(Somatoria4));

      RunSQL(
             ' SELECT DISTINCT ' +
             ' PF.CODIGOCONDICAOPAGAMENTO, ' +
             ' CP.CONDICAOPAGAMENTO, ' +
             ' CP.SOMASALDO, ' +
             ' SUM(PF.VALORRECEBIDO) AS VALOR, ' +
             ' COUNT(PF.CFG_CODCONFIG) AS QTDE, ' +
             ' SUM(PF.CONTRAVALE) AS CONTRAVALE, ' +
             ' SUM(PF.TROCO) AS TROCO, ' +
             ' SUM(PF.REPIQUE) AS REPIQUE ' +
             ' FROM PDV_CABECALHOCUPOM PC, PDV_FECHAMENTOCUPOM PF ' +
             ' RIGHT JOIN ' +
             ' CONDICAOPAGAMENTO CP ' +
             ' ON (PF.CODIGOCONDICAOPAGAMENTO = CP.CODIGOCONDICAOPAGAMENTO) ' +
             ' WHERE PF.DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + ' 23:59:59',Date))) +
             ' AND PF.TERMINAL = ' + S_Terminal +
             ' AND PC.TERMINAL = PF.TERMINAL ' +
             ' AND PC.NCP = PF.NCP ' +
             ' AND SUBSTRING(PC.DATAHORA FROM 1 FOR 8) = SUBSTRING(PF.DATAHORA FROM 1 FOR 8) ' +
             ' AND PC.SITUACAO <> 1 ' +
             ' AND PF.IDUSUARIO = ' + IntToStr(I_CodigoOperador) +
             ' AND PC.IDUSUARIO = ' + IntToStr(I_CodigoOperador) +
             ' AND PF.CFG_CODCONFIG = ' + S_NumeroLoja +
             ' AND PC.CFG_CODCONFIG = ' + S_NumeroLoja +
             ' GROUP BY  PF.CODIGOCONDICAOPAGAMENTO, CP.CONDICAOPAGAMENTO, CP.SOMASALDO' +
             ' ORDER BY CP.CODIGOCONDICAOPAGAMENTO', Dm.dbautocom, DsFinalizadores, True);

      RunSQL(
             ' SELECT DISTINCT ' +
             ' CP.CODIGOCONDICAOPAGAMENTO, ' +
             ' CP.CONDICAOPAGAMENTO, ' +
             ' SUM(PE.VALOR * -1) AS VALOR, ' +
             ' COUNT(PE.VALOR) AS QTDE ' +
             ' FROM PDV_MOVIMENTOEXTRA PE INNER JOIN CONDICAOPAGAMENTO CP ON (PE.CODIGOCONDICAOPAGAMENTO = CP.CODIGOCONDICAOPAGAMENTO)  ' +
             ' WHERE VALOR < 0 ' +
             ' AND PE.DATA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + ' 23:59:59',Date))) +
             ' AND PE.IDUSUARIO = ' + IntToStr(I_CodigoOperador) +
             ' AND PE.TERMINAL = ' + S_Terminal +
             ' AND PE.CFG_CODCONFIG = ' + S_NumeroLoja +
             ' GROUP BY CP.CODIGOCONDICAOPAGAMENTO, CP.CONDICAOPAGAMENTO ' +
             ' ORDER BY CP.CODIGOCONDICAOPAGAMENTO '
             ,Dm.dbautocom,DsSangrias, True);

      { Modelagem do ClientDataSet com os Valores no Total }
      Dm.CdsOperadoresF.close;
      Dm.CdsOperadoresF.FileName:=extractfilepath(application.exename)+'\dados\reloper.xml';
      if not fileexists(Dm.CdsOperadoresF.FileName) then
         Dm.CdsOperadoresF.CreateDataSet;
      Dm.CdsOperadoresF.Open;
      if not (DsFinalizadores.IsEmpty and DsSangrias.IsEmpty) then
        begin
          Dm.CdsOperadoresF.EmptyDataSet;
          DsFinalizadores.First;
          DsSangrias.First;
          while not DsFinalizadores.Eof do
            begin
              Dm.CdsOperadoresF.Insert;
              Dm.CdsOperadoresFCodigoCondicaoPagamento.Value := DsFinalizadores.FieldByName('CODIGOCONDICAOPAGAMENTO').AsFloat;
              Dm.CdsOperadoresFCondicaoPagamento.Value       := DsFinalizadores.FieldByName('CONDICAOPAGAMENTO').AsString;
              Dm.CdsOperadoresFFinalizadoraQtde.Value        := DsFinalizadores.FieldByName('QTDE').AsFloat;
              Dm.CdsOperadoresFFinalizadoraValor.Value       := DsFinalizadores.FieldByName('VALOR').AsFloat;
              Dm.CdsOperadoresFRepique.Value                 := DsFinalizadores.FieldByName('REPIQUE').AsFloat;
              Dm.CdsOperadoresFContraVale.Value              := DsFinalizadores.FieldByName('CONTRAVALE').AsFloat;
              Dm.CdsOperadoresFTroco.Value                   := DsFinalizadores.FieldByName('TROCO').AsFloat;
              if DsFinalizadores.FieldByName('SOMASALDO').AsString = 'T' then
              Dm.CdsOperadoresFSomaSaldo.Value               := True else
              Dm.CdsOperadoresFSomaSaldo.Value               := False;
              Dm.CdsOperadoresF.Post;
              DsFinalizadores.Next;
              Application.ProcessMessages;
            end;
          while not DsSangrias.Eof do
            begin
              if Dm.CdsOperadoresF.FindKey([DsSangrias.FieldByName('CODIGOCONDICAOPAGAMENTO').Value]) then
                begin
                  Dm.CdsOperadoresF.Edit;
                  Dm.CdsOperadoresFSangriaQtde.Value  := DsSangrias.FieldByName('QTDE').AsFloat;
                  Dm.CdsOperadoresFSangriaValor.Value := DsSangrias.FieldByName('VALOR').AsFloat;
                  DsSangrias.Next;
                  Application.ProcessMessages;
                end
              else
                begin
                  Dm.CdsOperadoresF.Insert;
                  Dm.CdsOperadoresFCodigoCondicaoPagamento.Value := DsSangrias.FieldByName('CODIGOCONDICAOPAGAMENTO').AsFloat;
                  Dm.CdsOperadoresFCondicaoPagamento.Value := DsSangrias.FieldByName('CONDICAOPAGAMENTO').AsString;
                  Dm.CdsOperadoresFSangriaQtde.Value  := DsSangrias.FieldByName('QTDE').AsFloat;
                  Dm.CdsOperadoresFSangriaValor.Value := DsSangrias.FieldByName('VALOR').AsFloat;
                  DsSangrias.Next;
                  Application.ProcessMessages;
                end;
            end;

          if not Dm.CdsOperadoresF.IsEmpty then
            begin
              //Imprime Relatorio de Recebidos e Sangrias
              Result.Add('----------------------------------------');
              Result.Add(CenterText('RECEBIDOS E SANGRIAS',40));
              Result.Add('----------------------------------------');
              Result.add('                  QTDE       VALOR(R$)  ');
              Result.Add('----------------------------------------');

              SomaRecebido:=0;
              SomaSangria:=0;

              Dm.CdsOperadoresF.First;
              while not Dm.CdsOperadoresF.Eof do
                begin
                  Result.Add('');
                  Result.Add(CenterText(' ' + Dm.CdsOperadoresFCondicaoPagamento.AsString + ' ',40,'.'));
                  Result.Add(Format(' %-16s %-9.0f  %-11f',['Recebido', Dm.CdsOperadoresFFinalizadoraQtde.AsFloat, Dm.CdsOperadoresFFinalizadoraValorL.AsFloat]));
                  Result.Add(Format(' %-16s %-9.0f  %-11f',['Sangria', Dm.CdsOperadoresFSangriaQtde.AsFloat, Dm.CdsOperadoresFSangriaValor.AsFloat]));

                  SomaRecebido:=SomaRecebido+Dm.CdsOperadoresFFinalizadoraValorL.AsFloat;
                  SomaSangria:=SomaSangria+Dm.CdsOperadoresFSangriaValor.AsFloat;

                  Dm.CdsOperadoresF.Next;
                end;
              Result.Add('----------------------------------------');
              Result.add(' (b)RECEBIDOS........: ' + CurrencyString + Format('%0.2f',[SomaRecebido]));
              Result.add(' (c)SANGRIAS.........: ' + CurrencyString + Format('%0.2f',[SomaSangria]));
              Result.Add('');
              Result.Add('');


              // Soma Saldo Final
              Result.Add('----------------------------------------');
              Result.Add(CenterText('SALDO FINAL',40));
              Result.Add('----------------------------------------');
              Result.add(' CONDICAO             (a+b-c)VALOR(R$)  ');
              Result.Add('----------------------------------------');
              Somatoria1 := 0; Somatoria2 := 0;
              Somatoria3 := 0; Somatoria4 := 0;
              Somatoria5 := 0;
              Dm.CdsOperadoresF.First;
              while not Dm.CdsOperadoresF.Eof do
                begin
                  if Dm.CdsOperadoresFSomaSaldo.AsBoolean = True then
                    begin
                      Result.Add(Format(' %-20s %15.2f  ',[Dm.CdsOperadoresFCondicaoPagamento.AsString, Dm.CdsOperadoresFSaldoFinal.AsFloat]));
                      Somatoria2 := Somatoria2 + Dm.CdsOperadoresFContraVale.AsFloat; // Soma o valor total de contra-vale
                      Somatoria4 := Somatoria4 + Dm.CdsOperadoresFTroco.AsFloat;      // soma o valor total de troco
                      Somatoria3 := Somatoria3 + Dm.CdsOperadoresFSaldoFinal.AsFloat; // soma o valor liquido em caixa
                      Somatoria5 := Somatoria5 + Dm.CdsOperadoresFRepique.Value;      // soma o valor TOTAL  de repique
                    end;
                  Dm.CdsOperadoresF.Next;
                  Application.ProcessMessages;
                end;
//              Somatoria3 := Somatoria3 - Somatoria2;
              Result.Add('----------------------------------------');
              Result.add(' SALDO DE CAIXA........: ' + CurrencyString + Format('%0.2f',[Somatoria3]));
              Result.Add('');
              Result.Add('----------------------------------------');
              Result.Add(CenterText('OUTRAS TOTALIZACOES',40));
              Result.add(' TROCO.................: ' + CurrencyString + Format('%0.2f',[Somatoria4]));
              Result.add(' REPIQUE...............: ' + CurrencyString + Format('%0.2f',[Somatoria5]));
              Result.add(' CONTRA-VALE...........: ' + CurrencyString + Format('%0.2f',[Somatoria2]));
            end;
      end;

      // Lista de ítens cancelados
          //Verifica Cancelados
          RunSQL(
             ' SELECT DT.DATAHORA,PE.PES_NOME_A,PRD.NOMEPRODUTO,DT.MOTIVO_CANCELAMENTO,DT.NUMEROPEDIDO,dt.QTDE' +
             ' FROM PDV_DETALHECUPOM DT,VENDEDOR VND,PRODUTO PRD,PESSOA PE' +
             ' WHERE PRD.CODIGOPRODUTO=DT.CODIGOPRODUTO' +
             ' AND DT.DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + ' 23:59:59',Date))) +
             ' AND DT.IDUSUARIO = ' + IntToStr(I_CodigoOperador) +
             ' AND DT.TERMINAL = ' + S_Terminal +
             ' AND DT.CFG_CODCONFIG = ' + S_NumeroLoja +
             ' AND VND.VEN_CODVENDEDOR=DT.VEN_CODVENDEDOR' +
             ' AND PE.PES_CODPESSOA=VND.PES_CODPESSOA' +
             ' AND SITUACAO=1' +
             ' ORDER BY DT.DATAHORA'
             ,Dm.dbautocom,DsCancelados, True);

      DsCancelados.first;
      if not DsCancelados.IsEmpty then
         begin
            Result.Add('----------------------------------------');
            Result.Add(CenterText('PRODUTOS CANCELADOS',40));
            Result.Add('----------------------------------------');
              while not DsCancelados.eof do
                 begin
                    Result.add('DATA: '+DSCANCELADOS.fieldbyname('DataHora').AsString);
                    Result.add(UpperCase(LeINI('TERMINAL','NOMEIND'))+': '+trim(DSCANCELADOS.fieldbyname('PES_NOME_A').AsString));
                    Result.add('PRODUTO: '+trim(DSCANCELADOS.fieldbyname('nOMEPRODUTO').AsString));
                    result.add('QUANTIDADE: '+Format('%0.2f',[DSCANCELADOS.fieldbyname('qtde').ASFLOAT])+
                         '  PEDIDO:'+DSCANCELADOS.fieldbyname('NUMEROPedido').asstring);
                    Result.add('MOTIVO: '+copy(DSCANCELADOS.fieldbyname('MOTIVO_CANCELAMENTO').asstring,1,32));
                    if length(trim(copy(DSCANCELADOS.fieldbyname('MOTIVO_CANCELAMENTO').asstring,33,33)))>0 then
                       Result.add('       '+copy(DSCANCELADOS.fieldbyname('MOTIVO_CANCELAMENTO').asstring,33,33));
                    if length(trim(copy(DSCANCELADOS.fieldbyname('MOTIVO_CANCELAMENTO').asstring,66,33)))>0 then
                       Result.add('       '+copy(DSCANCELADOS.fieldbyname('MOTIVO_CANCELAMENTO').asstring,66,33));
                    Result.Add('----------------------------------------');
                    DsCancelados.next;
                 end;
         end;
      Result.Add('________________________________________');
      Result.Add('                                        ');
      Result.Add('                                        ');
      Result.Add('                                        ');
    end;

  {Imprime Relatório de Faixa Horária}
  if RelFaixaHoraria in Rel then
    begin

      LogSend('logs\RVECF' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - Faixa Horaria');

      ZeroMemory(@Somatoria1,SizeOf(Somatoria1));
      ZeroMemory(@Somatoria2,SizeOf(Somatoria2));
      ZeroMemory(@Somatoria3,SizeOf(Somatoria3));
      ZeroMemory(@Somatoria4,SizeOf(Somatoria4));

      ArrayHoras;

      ZeroMemory(@i,SizeOf(i));

      for i := 0  to 23 do
        begin
          Somatoria1 := Somatoria1 + FaixaHoraria[i].Clientes;
          Somatoria2 := Somatoria2 + FaixaHoraria[i].Valor;
        end;

      Result.Add('----------------------------------------');
      Result.Add(CenterText('FAIXA HORARIA',40));
      Result.Add('----------------------------------------');
      Result.add(' HORARIO      CLIENTES       VALOR      ');
      Result.Add('----------------------------------------');

      ZeroMemory(@i,SizeOf(i));

      for i := 0  to 23 do
        begin
          if FaixaHoraria[i].Valor <> 0 then
             BEGIN
//            Result.Add(' ' + FormatFloat('00',i) + ':00        ' + Format('%-10.f',[FaixaHoraria[i].Clientes])  + '     ' + CurrencyString + FormatFloat('0.00',FaixaHoraria[i].Valor));
                Result.Add(' ' + FormatFloat('00',i) + ':00        ' + FormatFloat('0000',FaixaHoraria[i].Clientes)  + '     ' + CurrencyString + FormatFloat('0.00',FaixaHoraria[i].Valor));
             end;
        end;
      Result.add('----------------------------------------');
      try
         Somatoria4 := Somatoria2 / Somatoria1;
      except
        Somatoria4 := 0;
      end;
      Result.add(' CLIENTES ATENDIDOS : ' + FloatToStr(Somatoria1));
      Result.add(' SOMATORIA VALOR    : ' + CurrencyString + FormatFloat('0.00',Somatoria2));
      Result.add(' TIQUET MEDIO       : ' + CurrencyString + FormatFloat('0.00',Somatoria4));
      Result.add('________________________________________');
      Result.Add('                                        ');
      Result.Add('                                        ');
      Result.Add('                                        ');
    end;


  {Imprime Relatório de Extrato de Cheques}
  if RelExtratoDeCheques in Rel then
    begin

      LogSend('logs\RVECF' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - Extrato de cheques');

      ZeroMemory(@Somatoria1,SizeOf(Somatoria1));
      ZeroMemory(@Somatoria2,SizeOf(Somatoria2));
      ZeroMemory(@Somatoria3,SizeOf(Somatoria3));
      ZeroMemory(@Somatoria4,SizeOf(Somatoria4));

      RunSQL(
             ' SELECT *  ' +
             ' FROM PDV_CABECALHOCUPOM PC, PDV_FECHAMENTOCUPOM PF' +
             ' WHERE PF.CFG_CODCONFIG = ' + S_NumeroLoja +
             ' AND PF.DATAHORA >= ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) +
             ' AND PF.DATAHORA <= ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + ' 23:59:59',Date))) +
             ' AND PF.IDUSUARIO = ' + IntToStr(I_CodigoOperador) +
             ' AND PF.TERMINAL = ' + S_Terminal +
             ' AND PC.TERMINAL = PF.TERMINAL ' +
             ' AND PC.NCP = PF.NCP ' +
             ' AND SUBSTRING(PC.DATAHORA FROM 1 FOR 8) = SUBSTRING(PF.DATAHORA FROM 1 FOR 8) ' +
             ' AND (NOT BANCO IS NULL) ' +
             ' ORDER BY DATAHORA, VALORRECEBIDO',Dm.dbautocom,Ds, True);
      Result.Add('----------------------------------------');
      Result.Add(CenterText('EXTRATO DE CHEQUES',40));
      while not Ds.Eof do
        begin
          Result.Add('----------------------------------------');
          Result.Add(' DATA...........: ' + Ds.FieldByName('DATAHORA').AsString);
          Result.Add(' TERMINAL.......: ' + Ds.FieldByName('TERMINAL').AsString);
          Result.Add(' BANCO..........: ' + Ds.FieldByName('BANCO').AsString);
          Result.Add(' AGENCIA........: ' + Ds.FieldByName('AGENCIA').AsString);
          Result.Add(' CONTA..........: ' + Ds.FieldByName('CONTA').AsString);
          Result.Add(' VALOR..........: ' + CurrencyString + FormatFloat('0.00',Ds.FieldByName('VALORRECEBIDO').AsFloat));
          if Ds.FieldByName('DATAPRE').AsString <> '0' then
           Result.Add(' PRE-DATADO.....: ' + Ds.FieldByName('DATAPRE').AsString);
          Result.Add(' CUMPOM FISCAL..: ' + Ds.FieldByName('NCP').AsString);
          Ds.Next;
          Application.ProcessMessages;
        end;
      if Ds.IsEmpty then
        begin
          Result.Add('----------------------------------------');
          Result.Add(CenterText('NAO HA MOVIMENTO',40));
        end;
      Result.add('________________________________________');
      Result.Add('                                        ');
      Result.Add('                                        ');
      Result.Add('                                        ');
    end;

  {Imprime Relatório de Indicadores}
  if RelIndicadores in Rel then
    begin
      LogSend('logs\RVECF' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - Indicadores');

      ZeroMemory(@Somatoria1,SizeOf(Somatoria1));
      ZeroMemory(@Somatoria2,SizeOf(Somatoria2));
      ZeroMemory(@Somatoria3,SizeOf(Somatoria3));
      ZeroMemory(@Somatoria4,SizeOf(Somatoria4));

      RunSQL(
             ' SELECT DISTINCT  P.PES_NOME_A,' +
             ' SUM(PF.VALORRECEBIDO) AS VALOR,' +
             ' SUM(PF.REPIQUE) AS REPIQUE,' +
             ' SUM(PF.CONTRAVALE) AS CONTRAVALE,' +
             ' SUM(PF.TROCO) AS TROCO,' +
             ' V.COMISSAO,' +

             ' (SELECT SUM(NUMEROCLIENTES) FROM PDV_CABECALHOCUPOM' +
             ' WHERE CFG_CODCONFIG = ' + S_NumeroLoja +
             ' AND PF.TERMINAL = ' + S_Terminal +
             ' AND DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + ' 23:59:59',Date))) +
             ' AND VEN_CODVENDEDOR = V.VEN_CODVENDEDOR' +
             ' AND IDUSUARIO = ' + IntToStr(I_CodigoOperador) +
             ' AND (SITUACAO = 0)) AS NPESSOAS, ' +


             ' V.VEN_CODVENDEDOR AS VENDEDOR' +
             ' FROM PDV_CABECALHOCUPOM PC, PDV_FECHAMENTOCUPOM PF, PESSOA P, VENDEDOR V' +
             ' WHERE V.PES_CODPESSOA = P.PES_CODPESSOA ' +
             ' AND V.VEN_CODVENDEDOR = PF.VEN_CODVENDEDOR ' +

             ' AND PC.TERMINAL = PF.TERMINAL ' +
             ' AND PC.NCP = PF.NCP ' +
             ' AND SUBSTRING(PC.DATAHORA FROM 1 FOR 8) = SUBSTRING(PF.DATAHORA FROM 1 FOR 8) ' +
             ' AND PC.SITUACAO <> 1 ' +
             ' AND PF.CFG_CODCONFIG = ' + S_NumeroLoja +
             ' AND PC.CFG_CODCONFIG = ' + S_NumeroLoja +

             ' AND PF.DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + ' 23:59:59',Date))) +
             ' AND PC.DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + ' 23:59:59',Date))) +
             ' AND PF.IDUSUARIO = ' + IntToStr(I_CodigoOperador) +
             ' AND PC.IDUSUARIO = ' + IntToStr(I_CodigoOperador) +
             ' AND V.VEN_CODVENDEDOR BETWEEN ' + RelOptions[6].X + ' AND ' + RelOptions[6].Y +
             ' AND PF.TERMINAL = ' + S_Terminal +
             ' AND PC.TERMINAL = ' + S_Terminal +
             ' AND PF.CODIGOCONDICAOPAGAMENTO NOT IN (SELECT CODIGOCONDICAOPAGAMENTO FROM CONDICAOPAGAMENTO WHERE SOMASALDO = ' + QuotedStr('F') + ')' +
             ' GROUP BY P.PES_NOME_A, V.COMISSAO, V.VEN_CODVENDEDOR ' +
             ' ORDER BY P.PES_NOME_A',Dm.dbautocom,Ds, True);
      Result.Add('----------------------------------------');
      Result.Add(CenterText('VENDAS POR ' + UpperCase(LeINI('TERMINAL','NOMEIND')) ,40));
      Result.Add('----------------------------------------');
      if not Ds.IsEmpty then
        begin
          while not Ds.Eof do
            begin
              Result.Add(CenterText(Ds.FieldByName('PES_NOME_A').AsString,40));
              Result.Add(' CLIENTES ATENDIDOS : ' + FloatToStr(Ds.FieldByName('NPESSOAS').AsFloat));
              Result.Add(' VALOR              : ' + FormatCurr(CurrencyString + '0.00',Ds.FieldByName('VALOR').AsFloat - (Ds.FieldByName('REPIQUE').AsFloat + Ds.FieldByName('CONTRAVALE').AsFloat + Ds.FieldByName('TROCO').AsFloat)));
              Result.Add(' COMISSÃO           : ' + FormatCurr(CurrencyString + '0.00',(Ds.FieldByName('VALOR').AsFloat - (Ds.FieldByName('REPIQUE').AsFloat + Ds.FieldByName('CONTRAVALE').AsFloat + Ds.FieldByName('TROCO').AsFloat)) * (Ds.FieldByName('COMISSAO').AsFloat / 100)));
              Result.Add(' REPIQUE            : ' + FormatCurr(CurrencyString + '0.00',Ds.FieldByName('REPIQUE').AsFloat));
              Result.Add('');
              {Quantidade} Somatoria1 := Somatoria1 + Ds.FieldByName('NPESSOAS').AsFloat;
              {Vendas    } Somatoria2 := (Somatoria2) + (Ds.FieldByName('VALOR').AsFloat - Ds.FieldByName('REPIQUE').AsFloat - Ds.FieldByName('CONTRAVALE').AsFloat - Ds.FieldByName('TROCO').AsFloat);
              {Comissão  } Somatoria3 := Somatoria3 + ((Ds.FieldByName('VALOR').AsFloat - Ds.FieldByName('REPIQUE').AsFloat - Ds.FieldByName('CONTRAVALE').AsFloat - Ds.FieldByName('TROCO').AsFloat) * (Ds.FieldByName('COMISSAO').AsFloat / 100));
              {Repique   } Somatoria4 := Somatoria4 + Ds.FieldByName('REPIQUE').AsFloat;
              Ds.Next;
            end;
          Result.add('----------------------------------------');
          Result.Add(CenterText('SOMATORIAS',40));
          Result.add('----------------------------------------');
          Result.add(' CLIENTES ATENDIDOS : ' + FloatToStr(Somatoria1));
          Result.add(' VENDAS             : ' + FormatCurr(CurrencyString + '0.00',Somatoria2));
          Result.add(' COMISSAO           : ' + FormatCurr(CurrencyString + '0.00',Somatoria3));
          Result.add(' REPIQUE            : ' + FormatCurr(CurrencyString + '0.00',Somatoria4));
        end
      else
        begin
          Result.Add(CenterText('NAO HA MOVIMENTO',40));
        end;
      Result.add('________________________________________');
      Result.Add('                                        ');
      Result.Add('                                        ');
      Result.Add('                                        ');
    end;

  {Imprime Relatório de Extrato de Convenios}
  if RelExtratoDeConvenios in Rel then
    begin

      LogSend('logs\RVECF' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - Extrato de Convenio');

      ZeroMemory(@Somatoria1,SizeOf(Somatoria1));
      ZeroMemory(@Somatoria2,SizeOf(Somatoria2));
      ZeroMemory(@Somatoria3,SizeOf(Somatoria3));
      ZeroMemory(@Somatoria4,SizeOf(Somatoria4));

      RunSql(' SELECT DISTINCT P.CODIGOPRODUTO , P.NOMEPRODUTO, pd.datahora ,pd.ncp, pd.terminal, ' +
           ' SUM(PD.QTDE) AS QTDE,' +
           ' SUM((VALORUN * QTDE)  + ACRESCIMO - DESCONTO) AS VALORSOMA,' +
           ' SUM(PD.VALORUN * PD.QTDE) as TOTUNID,'+
           ' SUM(PD.ACRESCIMO) as TOTACRES,'+
           ' SUM(PD.DESCONTO) as TOTDESC '+
           ' FROM PRODUTO P, PDV_DETALHECUPOM PD ' +
           ' WHERE PD.CFG_CODCONFIG = ' + S_NumeroLoja +
           ' AND P.CODIGOPRODUTO = PD.CODIGOPRODUTO' +
           ' AND (PD.SITUACAO = 0)' +
           ' AND PD.DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + ' 23:59:59',Date))) +
           ' GROUP BY P.CODIGOPRODUTO, P.NOMEPRODUTO, pd.datahora,pd.ncp, pd.terminal' +
           ' ORDER BY pd.datahora,P.NOMEPRODUTO',Dm.dbautocom,Ds, True);


      if not DS.IsEmpty then
         begin
           //Modela dados no Client Data Set
           Dm.CdsExtratoCliente.close;
           Dm.CdsExtratoCliente.filename:=extractfilepath(application.ExeName)+'dados\rextcli.xml';
           if not fileexists(Dm.CdsExtratoCliente.filename) then Dm.CdsExtratoCliente.CreateDataSet;
           Dm.CdsExtratoCliente.Open;
           Dm.CdsExtratoCliente.EmptyDataSet;
           DS.first;

           RunSql('select cli_codcliente from cliente '+
               'where codigocliente='+RelOptions[7].X,Dm.dbautocom,DS2,True);

           codigoCliente_interno:=ds2.FieldByName('cli_codcliente').asstring;

           RunSQL(' SELECT terminal,ncp FROM PDV_CabecalhoCUPOM' +
                  ' WHERE CFG_CODCONFIG = ' + S_NumeroLoja +
                  ' AND DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + ' 23:59:59',Date))) +
                  ' AND Cli_codcliente='+codigoCliente_interno ,Dm.dbautocom,DS2,True);

           while not DS.Eof do
             begin
                if Ds2.Locate('terminal;ncp',VarArrayOf([ds.FieldByName('TERMINAL').asstring,ds.FieldByName('NCP').asstring]),[loCaseInsensitive]) then
                   begin
                     if Dm.CdsExtratoCliente.locate('data;codigo',VarArrayOf([strtodate(formatdatetime('DD/MM/YYYY',ds.FieldByName('datahora').value)),ds.FieldByName('CODIGOPRODUTO').Asinteger]),[loCaseInsensitive]) then
                        begin
                           Dm.CdsExtratoCliente.Edit;
                           Dm.CdsExtratoClienteqtde.Value    := Dm.CdsExtratoClienteqtde.Value+ds.FieldByName('QTDE').AsFloat;
                           Dm.CdsExtratoClientevalor.Value   := Dm.CdsExtratoClientevalor.Value+ds.FieldByName('VALORSOMA').AsFloat;
                        end
                     else
                        begin
                           Dm.CdsExtratoCliente.Insert;
                           Dm.CdsExtratoClientedata.Value    := strtodate(formatdatetime('DD/MM/YYYY',ds.FieldByName('datahora').value));
                           Dm.CdsExtratoClientecodigo.Value  := ds.FieldByName('CODIGOPRODUTO').Asinteger;
                           Dm.CdsExtratoClienteproduto.Value := ds.FieldByName('NOMEPRODUTO').AsString;
                           Dm.CdsExtratoClienteqtde.Value    := ds.FieldByName('QTDE').AsFloat;
                           Dm.CdsExtratoClientevalor.Value   := ds.FieldByName('VALORSOMA').AsFloat;
                        end;
                     Dm.CdsExtratoCliente.Post;
                     Somatoria1:=Somatoria1+ds.FieldByName('QTDE').AsFloat;
                     Somatoria2:=Somatoria2+ds.FieldByName('VALORSOMA').AsFloat;
                   end;
                ds.Next;
                Application.ProcessMessages;
             end;

           RunSql('select p.pes_nome_a from cliente c,pessoa p '+
               'where c.cli_codcliente='+codigoCliente_interno+
               '  and c.pes_codpessoa=p.pes_codpessoa',Dm.dbautocom,DS,True);

           Result.Add(CenterText('EXTRATO DE CONVENIO',40));
           Result.Add('Cliente: '+Trim(Ds.FieldByName('pes_nome_a').AsString));
           Result.Add('----------------------------------------');
           Result.add('DATA       PRODUTO                      ');
           Result.add(' QUANTIDADE         VALOR               ');
           Result.add('----------------------------------------');
           Dm.CdsExtratoCliente.FIrst;
           while not Dm.CdsExtratoCliente.eof do
              begin
                 Result.add(Formatdatetime('dd/mm/yyyy',Dm.CdsExtratoClientedata.Value)+' '+
                       copy(Dm.CdsExtratoClienteproduto.Value,1,29));
                 Result.add(' '+FloatToStrf(Dm.CdsExtratoClienteqtde.Value,ffnumber,12,3)+'       '+
                           FormatCurr(CurrencyString + '0.00',Dm.CdsExtratoClientevalor.Value));
                 Dm.CdsExtratoCliente.next;
              end;
           Result.add('----------------------------------------');
           Result.Add(CenterText('SOMATORIAS',40));
           Result.add('----------------------------------------');
           Result.add('Quantidade: '+FloatToStrF(Somatoria1,ffnumber,12,3));
           Result.add('Valor: '+FormatCurr(CurrencyString + '0.00',Somatoria2));
         end
      else
         begin
            Result.Add(CenterText('NAO HA MOVIMENTO',40));
         end;
      Result.add('________________________________________');
      Result.Add('                                        ');
      Result.Add('                                        ');
      Result.Add('                                        ');
    end;

  {Imprime Relatório de Saldo de Clientes}
  if RelSaldoDeClientes in Rel then
    begin
      LogSend('logs\RVECF' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - Saldo de Clientes');

      ZeroMemory(@Somatoria1,SizeOf(Somatoria1));
      ZeroMemory(@Somatoria2,SizeOf(Somatoria2));
      ZeroMemory(@Somatoria3,SizeOf(Somatoria3));
      ZeroMemory(@Somatoria4,SizeOf(Somatoria4));

      Result.Add('----------------------------------------');
      Result.Add(CenterText('SALDO DE CLIENTES',40));
      Result.Add('----------------------------------------');
      Result.add(' CONVENIO      CLIENTE            SALDO ');
      Result.add('________________________________________');
      Result.Add('                                        ');
      Result.Add('                                        ');
      Result.Add('                                        ');
    end;

  {Imprime Relatório de Sangrias}
  if RelSangrias in Rel then
    begin
      LogSend('logs\RVECF' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - Extrato de Sangrias');

      ZeroMemory(@Somatoria1,SizeOf(Somatoria1));
      ZeroMemory(@Somatoria2,SizeOf(Somatoria2));
      ZeroMemory(@Somatoria3,SizeOf(Somatoria3));
      ZeroMemory(@Somatoria4,SizeOf(Somatoria4));

      RunSQL(
             ' SELECT DATA, (VALOR * -1) AS VALOR, DESCRICAO ' +
             ' FROM PDV_MOVIMENTOEXTRA ' +
             ' WHERE CFG_CODCONFIG = ' + S_NumeroLoja +
             ' AND DATA >= ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date))) +
             ' AND DATA <= ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + ' 23:59:59',Date))) +
             ' AND IDUSUARIO = ' + IntToStr(I_CodigoOperador) +
             ' AND TERMINAL = ' + S_Terminal +
             ' AND VALOR < 0 ' +
             ' ORDER BY DATA, VALOR',Dm.dbautocom, Ds, True);
      Result.Add('----------------------------------------');
      Result.Add(CenterText('SANGRIAS',40));
      if not Ds.IsEmpty then
        begin
          Result.Add('----------------------------------------');
          Result.add(' DATA                          VALOR(R$)');
          Result.add(' DESCRICAO                              ');
          Result.add('----------------------------------------');
          Somatoria1 := 0; Somatoria2 := 0;
          while not Ds.Eof do
            begin
              Result.Add(Format(' %-15.15s         %12s',[Ds.FieldByName('DATA').AsString, FormatCurr('0.00',Ds.FieldByName('VALOR').AsFloat)]));
              if not Ds.FieldByName('DESCRICAO').IsNull then
                Result.Add(' ' + Ds.FieldByName('DESCRICAO').AsString);
                Somatoria1  := Somatoria1  + Ds.FieldByName('Valor').AsFloat;
                Somatoria2 := Somatoria2 + 1;
                Ds.Next;
                Application.ProcessMessages;
            end;
          Result.add('----------------------------------------');
          Result.add(' QUANTIDADE : ' + FloatToStr(Somatoria2));
          Result.add(' SOMATORIA  : ' + CurrencyString + FormatCurr('0.00',Somatoria1));
        end
      else
        begin
          Result.Add('----------------------------------------');
          Result.Add(CenterText('NAO HA MOVIMENTO',40));
        end;
      Result.add('________________________________________');
      Result.Add('                                        ');
      Result.Add('                                        ');
      Result.Add('                                        ');
    end;
    FreeAndNil(Ds);
    FreeAndNil(Ds2);
    FreeAndNil(DsFinalizadores);
    FreeAndNil(DsSangrias);
end;

procedure TfMain.CallOpcoes;
begin
  if (CurrentButton = BtnProdutos) or
     (CurrentButton = BtnGrupos) or
     (CurrentButton = BtnFaixaHoraria) or
     (CurrentButton = BtnIndicadores) or
     (CurrentButton = BtnSaldoDeClientes) or
     (CurrentButton = BtnExtratoDeConvenios) then
    with tfOptions.Create(Self) do
      begin
        ShowModal;
        Free;
      end;
end;

procedure TfMain.ArrayHoras;
var
  DsHoras: TDataSet;
  i: Integer;
begin
  RunSQL(
         ' SELECT DISTINCT DATAHORA, SUM((VALORUN * QTDE)  + ACRESCIMO - DESCONTO) ' +
         ' FROM PDV_DETALHECUPOM ' +
         ' WHERE CFG_CODCONFIG = ' + S_NumeroLoja +
         ' AND TERMINAL = ' + S_Terminal +
         ' AND DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date)) + ' ' + FormatDateTime('hh:mm:ss', StrToDateTimeDef(RelOptions[4].X,StrToDateTime('00:00:00')))) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',StrToDateTimeDef(S_DataFinal + ' 23:59:59',Date)) + ' ' + FormatDateTime('hh:mm:ss', StrToDateTimeDef(RelOptions[4].y,StrToDateTime('23:59:59')))) +
         ' AND IDUSUARIO = ' + IntToStr(I_CodigoOperador) +
         ' AND SITUACAO = 0 ' +
         ' GROUP BY DATAHORA ' +
         ' ORDER BY DATAHORA', Dm.dbautocom, DsHoras, True);
  ZeroMemory(@FaixaHoraria,SizeOf(FaixaHoraria));
  DsHoras.First;
  while not DsHoras.Eof do
    begin
      case StrToInt(FormatDateTime('hh',DsHoras.Fields[0].AsDateTime)) of
        00:
          begin
            FaixaHoraria[0].Valor := FaixaHoraria[0].Valor + DsHoras.Fields[1].AsFloat;
          end;
        01:
          begin
            FaixaHoraria[1].Valor := FaixaHoraria[1].Valor + DsHoras.Fields[1].AsFloat;
          end;
        02:
          begin
            FaixaHoraria[2].Valor := FaixaHoraria[2].Valor + DsHoras.Fields[1].AsFloat;
          end;
        03:
          begin
            FaixaHoraria[3].Valor :=    FaixaHoraria[3].Valor + DsHoras.Fields[1].AsFloat;
          end;
        04:
          begin
            FaixaHoraria[4].Valor :=    FaixaHoraria[4].Valor + DsHoras.Fields[1].AsFloat;
          end;
        05:
          begin
            FaixaHoraria[5].Valor :=    FaixaHoraria[5].Valor + DsHoras.Fields[1].AsFloat;
          end;
        06:
          begin
            FaixaHoraria[6].Valor :=    FaixaHoraria[6].Valor + DsHoras.Fields[1].AsFloat;
          end;
        07:
          begin
            FaixaHoraria[7].Valor :=    FaixaHoraria[7].Valor + DsHoras.Fields[1].AsFloat;
          end;
        08:
          begin
            FaixaHoraria[8].Valor :=    FaixaHoraria[8].Valor + DsHoras.Fields[1].AsFloat;
          end;
        09:
          begin
            FaixaHoraria[9].Valor :=    FaixaHoraria[9].Valor + DsHoras.Fields[1].AsFloat;
          end;
        10:
          begin
            FaixaHoraria[10].Valor :=    FaixaHoraria[10].Valor + DsHoras.Fields[1].AsFloat;
          end;
        11:
          begin
            FaixaHoraria[11].Valor :=    FaixaHoraria[11].Valor + DsHoras.Fields[1].AsFloat;
          end;
        12:
          begin
            FaixaHoraria[12].Valor :=    FaixaHoraria[12].Valor + DsHoras.Fields[1].AsFloat;
          end;
        13:
          begin
            FaixaHoraria[13].Valor :=    FaixaHoraria[13].Valor + DsHoras.Fields[1].AsFloat;
          end;
        14:
          begin
            FaixaHoraria[14].Valor :=    FaixaHoraria[14].Valor + DsHoras.Fields[1].AsFloat;
          end;
        15:
          begin
            FaixaHoraria[15].Valor :=    FaixaHoraria[15].Valor + DsHoras.Fields[1].AsFloat;
          end;
        16:
          begin
            FaixaHoraria[16].Valor :=    FaixaHoraria[16].Valor + DsHoras.Fields[1].AsFloat;
          end;
        17:
          begin
            FaixaHoraria[17].Valor :=    FaixaHoraria[17].Valor + DsHoras.Fields[1].AsFloat;
          end;
        18:
          begin
            FaixaHoraria[18].Valor :=    FaixaHoraria[18].Valor + DsHoras.Fields[1].AsFloat;
          end;
        19:
          begin
            FaixaHoraria[19].Valor :=    FaixaHoraria[19].Valor + DsHoras.Fields[1].AsFloat;
          end;
        20:
          begin
            FaixaHoraria[20].Valor :=    FaixaHoraria[20].Valor + DsHoras.Fields[1].AsFloat;
          end;
        21:
          begin
            FaixaHoraria[21].Valor :=    FaixaHoraria[21].Valor + DsHoras.Fields[1].AsFloat;
          end;
        22:
          begin
            FaixaHoraria[22].Valor :=    FaixaHoraria[22].Valor + DsHoras.Fields[1].AsFloat;
          end;
        23:
          begin
            FaixaHoraria[23].Valor :=    FaixaHoraria[23].Valor + DsHoras.Fields[1].AsFloat;
          end;
      end;
      DsHoras.Next;
    end;
  //Grava Quantidade de Clientes
  for i := 0 to 23 do
    begin
      FaixaHoraria[i].Clientes := NPessoas(i);
    end;
  FreeAndNil(DsHoras);
end;

function TfMain.NPessoas(Codigo: Integer): Real;
var
  Ds: TDataSet;
  v_sql:String;
begin
  v_sql:=' SELECT SUM(NUMEROCLIENTES) FROM PDV_CABECALHOCUPOM WHERE CFG_CODCONFIG = ' + S_NumeroLoja +
         ' AND TERMINAL = ' + S_Terminal +

         ' AND SUBSTRING(DATAHORA FROM 13 FOR 8) BETWEEN ' + QuotedStr(IntToStr(Codigo) + ':00:00') + ' and ' + QuotedStr(IntToStr(Codigo) + ':59:59') +
         ' AND CAST(DATAHORA AS DATE) BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataInicial,Date)) + ' 00:00:00') + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY',StrToDateTimeDef(S_DataFinal,Date)) +  ' 23:59:59') +
         ' AND IDUSUARIO = ' + IntToStr(I_CodigoOperador) +
         ' AND (SITUACAO <> 1) ';
  RunSQL(v_sql,Dm.dbautocom,Ds, True);

  Result := Ds.Fields[0].AsFloat;
end;
                                                                     { EVENTOS }
{______________________________________________________________________________}


procedure TfMain.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = VK_F1) and (BtnGerarRelatorios.Enabled) then BtnGerarRelatorios.Click;
  if (Key = VK_F2) and (BtnImprimirRelatorios.Enabled) then BtnImprimirRelatorios.Click;
  if (Key = VK_ESCAPE) then Close;
end;

procedure TfMain.FormShow(Sender: TObject);
begin
  {Insere nome do indicador definido no parametro}
  BtnIndicadores.Caption := '6 - ' + UpperCase(Copy(LeINI('TERMINAL','NOMEINDP'),1,1)) + LowerCase(Copy(LeINI('TERMINAL','NOMEINDP'),2,40));
  {Desativa todos os Relatórios}
  FRelatoriosSelecionados := [];
  BtnProdutos.Glyph := BtnVermelho.Glyph;
  BtnGrupos.Glyph := BtnVermelho.Glyph;
  BtnOperadores.Glyph := BtnVermelho.Glyph;
  BtnFaixaHoraria.Glyph := BtnVermelho.Glyph;
  BtnExtratoDeCheques.Glyph := BtnVermelho.Glyph;
  BtnIndicadores.Glyph := BtnVermelho.Glyph;
  BtnExtratoDeConvenios.Glyph := BtnVermelho.Glyph;
  BtnSaldoDeClientes.Glyph := BtnVermelho.Glyph;
  BtnSangrias.Glyph := BtnVermelho.Glyph;

end;

procedure TfMain.FormActivate(Sender: TObject);
var tipo_skin:string;
begin
     tipo_skin:=LeINI('ATCPLUS', 'skin', extractfilepath(application.exename)+'dados\autocom.ini');
     if (tipo_skin='0') or (tipo_skin='') then skin.uistyle:=WinXP;
     if (tipo_skin='1') then skin.uistyle:=BlueGlass;
     if (tipo_skin='2') then skin.uistyle:=DeepBlue;
     if (tipo_skin='3') then skin.uistyle:=MacOS;
     if (tipo_skin='4') then skin.uistyle:=Protein;

     application.processmessages;

  BtnProdutos.hint := '1';
  BtnGrupos.hint := '1';
  BtnOperadores.hint := '1';
  BtnFaixaHoraria.hint := '1';
  BtnExtratoDeCheques.hint := '1';
  BtnIndicadores.hint := '1';
  BtnExtratoDeConvenios.hint := '1';
  BtnSaldoDeClientes.hint := '1';
  BtnSangrias.hint := '1';

  ActivateDatabase;

  {Atribui valores as variavéis Globais}
  S_Terminal := LeINI('TERMINAL','PDVNum');
  S_NumeroLoja := LeINI('LOJA','LojaNum');
  RunSQL('Commit;',Dm.dbautocom);

end;

procedure TfMain.BtnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfMain.BtnGerarRelatoriosClick(Sender: TObject);
begin
      with TfConfig.Create(Self) do
        begin
          ShowModal;
          Free;
        end;
      try
        fWait.Show;
        fWait.Refresh;
        RunSQL('Commit;',Dm.dbautocom);
        PrintOnSreen;
        BtnImprimirRelatorios.Enabled := True;
      finally
        fWait.Close;
      end;
end;

procedure TfMain.BtnGeralClick(Sender: TObject);
begin
  if (Sender as TsuiButton).hint = '0' then
    begin
      (Sender as TsuiButton).Glyph := BtnVermelho.Glyph;
      (Sender as TsuiButton).hint := '1';
    end
  else
    begin
      (Sender as TsuiButton).Glyph := BtnVerde.Glyph;
      (Sender as TsuiButton).hint := '0';
      application.processmessages;
      CurrentButton := (Sender as TsuiButton);
      CallOpcoes;
    end;
  if SelectReports = [] then BtnGerarRelatorios.Enabled := False else BtnGerarRelatorios.Enabled := True;
end;

procedure TfMain.FormKeyPress(Sender: TObject; var Key: Char);
begin
  {Controle dos Relatórios Ativos e Inativos}
  if Key = '1' then CurrentButton := BtnProdutos;
  if Key = '2' then CurrentButton := BtnGrupos;
  if Key = '3' then CurrentButton := BtnOperadores;
  if Key = '4' then CurrentButton := BtnFaixaHoraria;
  if Key = '5' then CurrentButton := BtnExtratoDeCheques;
  if Key = '6' then CurrentButton := BtnIndicadores;
  if Key = '7' then CurrentButton := BtnExtratoDeConvenios;
//  if Key = '8' then CurrentButton := BtnSaldoDeClientes;
  if Key = '9' then CurrentButton := BtnSangrias;

//  if Key in ['1'..'9'] then
  if Key in ['1'..'7','9'] then
    begin
      if CurrentButton.hint = '0' then
        begin
          CurrentButton.Glyph := BtnVermelho.Glyph;
          CurrentButton.hint := '1';
        end
      else
        begin
          CurrentButton.Glyph := BtnVerde.Glyph;
          CurrentButton.hint := '0';
          CallOpcoes;
        end;
    end;
  if SelectReports = [] then BtnGerarRelatorios.Enabled := False else BtnGerarRelatorios.Enabled := True;
end;


procedure TfMain.BtnImprimirRelatoriosClick(Sender: TObject);
begin
  if MessageBox(Handle, 'Deseja imprimir os Relatórios?', Autocom, MB_ICONQUESTION + MB_YESNO) = ID_YES then
    begin
      BtnImprimirRelatorios.enabled:=false;
      PrintOnPrinter;
      BtnImprimirRelatorios.enabled:=true;
    end;
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dm.dbautocom.Close;
end;

end.
