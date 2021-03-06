unit ECFDLL;

interface

uses
  Windows, Messages, SysUtils, Classes, Forms, stdctrls,Inifiles;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//       Declara??es de fun??es externas (DLLs                                                           //
//                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////

// --------- Declara??o das Fun??es da nova DLL BEMAFI32.DLL --------- //

   Function Bematech_FI_NumeroSerie(NumeroSerie: String): Integer; StdCall;
    External 'BEMAFI32.DLL';

   Function Bematech_FI_SubTotal(SubTotal: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_NumeroCupom(NumeroCupom: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_AbrePortaSerial:Integer; StdCall;
   External 'BEMAFI32.DLL' Name 'Bematech_FI_IniciaPorta';

   Function Bematech_FI_LeituraX:Integer; StdCall;
   External 'BEMAFI32.DLL' Name 'Bematech_FI_LeituraX';

   Function Bematech_FI_LeituraXSerial: Integer; StdCall;
   External 'BEMAFI32.DLL' Name 'Bematech_FI_LeituraXSerial';

   Function Bematech_FI_AbreCupom(CGC_CPF: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_VendeItem(Codigo: String; Descricao: String; Aliquota: String; TipoQuantidade: String; Quantidade: String; CasasDecimais: Integer; ValorUnitario: String; TipoDesconto: String; Desconto: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_CancelaItemAnterior: Integer; StdCall;
   External 'BEMAFI32.DLL' Name 'Bematech_FI_CancelaItemAnterior';

   Function Bematech_FI_CancelaItemGenerico(NumeroItem: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_CancelaCupom: Integer; StdCall;
   External 'BEMAFI32.DLL' Name 'Bematech_FI_CancelaCupom';

   Function Bematech_FI_FechaCupomResumido(FormaPagamento: String; Mensagem: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_ReducaoZ(Data: String; Hora: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_FechaCupom(FormaPagamento: String; DescontoAcrescimo: String; TipoDescontoAcrescimo: String; ValorAcrescimoDesconto: String; ValorPago: String; Mensagem: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_VendeItemDepartamento(Codigo: String; Descricao: String; Aliquota: String; ValorUnitario: String; Quantidade: String; Acrescimo: String; Desconto: String; IndiceDepartamento: String; UnidadeMedida: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_AumentaDescricaoItem(Descricao: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_UsaUnidadeMedida(UnidadeMedida: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_ProgramaAliquota(Aliquota: String; ICMS_ISS: Integer): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_ProgramaHorarioVerao: Integer; StdCall;
   External 'BEMAFI32.DLL' Name 'Bematech_FI_ProgramaHorarioVerao';

   Function Bematech_FI_NomeiaTotalizadorNaoSujeitoIcms(Indice: Integer; Totalizador: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_ProgramaArredondamento:Integer; StdCall;
   External 'BEMAFI32.DLL' Name 'Bematech_FI_ProgramaArredondamento';

   Function Bematech_FI_ProgramaTruncamento:Integer; StdCall;
   External 'BEMAFI32.DLL' Name 'Bematech_FI_ProgramaTruncamento';

   Function Bematech_FI_RelatorioGerencial(Texto: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_FechaRelatorioGerencial:Integer; StdCall;
   External 'BEMAFI32.DLL' Name 'Bematech_FI_FechaRelatorioGerencial';

   Function Bematech_FI_RecebimentoNaoFiscal(IndiceTotalizador: String; Valor: String; FormaPagamento: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_AbreComprovanteNaoFiscalVinculado(FormaPagamento: String; Valor: String; NumeroCupom: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_UsaComprovanteNaoFiscalVinculado(Texto: String): Integer; StdCall;
   External 'BEMAFI32.DLL'

   Function Bematech_FI_FechaComprovanteNaoFiscalVinculado:Integer; StdCall;
   External 'BEMAFI32.DLL' Name 'Bematech_FI_FechaComprovanteNaoFiscalVinculado';

   Function Bematech_FI_Sangria(Valor: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_Suprimento(Valor: String; FormaPagamento: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_LeituraMemoriaFiscalData(DataInicial: String; DataFinal: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_LeituraMemoriaFiscalReducao(ReducaoInicial: String; ReducaoFinal: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_LeituraMemoriaFiscalSerialData(DataInicial: String; DataFinal: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_LeituraMemoriaFiscalSerialReducao(ReducaoInicial: String; ReducaoFinal: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_CGC_IE(CGC: String; IE: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_GrandeTotal(GrandeTotal: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_Cancelamentos(ValorCancelamentos: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_Descontos(ValorDescontos: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_NumeroOperacoesNaoFiscais(NumeroOperacoes: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_NumeroCuponsCancelados(NumeroCancelamentos: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_NumeroReducoes(NumeroReducoes: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_NumeroSubstituicoesProprietario(NumeroSubstituicoes: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_NumeroCaixa(NumeroCaixa: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_NumeroLoja(NumeroLoja: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_FlagsFiscais(Var Flag: Integer): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_ValorPagoUltimoCupom(ValorCupom: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_DataHoraImpressora(Data: String; Hora: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_ContadoresTotalizadoresNaoFiscais(Contadores: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_VerificaTotalizadoresNaoFiscais(Totalizadores: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_DataHoraReducao(Data: String; Hora: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_DataMovimento(Data: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_VerificaTruncamento(Flag: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_Acrescimos(ValorAcrescimos: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_VerificaAliquotasIss(Flag: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_VerificaFormasPagamento(Formas: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_VerificaRecebimentoNaoFiscal(Recebimentos: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_VerificaTotalizadoresParciais(Totalizadores: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_RetornoAliquotas(Aliquotas: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_VerificaEstadoImpressora(Var ACK: Integer; Var ST1: Integer; Var ST2: Integer): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_DadosUltimaReducao(DadosReducao: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_MonitoramentoPapel(Var Linhas: Integer): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_Autenticacao:Integer; StdCall;
   External 'BEMAFI32.DLL' Name 'Bematech_FI_Autenticacao';

   Function Bematech_FI_AcionaGaveta:Integer; StdCall;
   External 'BEMAFI32.DLL' Name 'Bematech_FI_AcionaGaveta';

   Function Bematech_FI_VerificaEstadoGaveta(Var EstadoGaveta: Integer): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_CancelaImpressaoCheque:Integer; StdCall;
   External 'BEMAFI32.DLL' Name 'Bematech_FI_CancelaImpressaoCheque';

   Function Bematech_FI_VerificaStatusCheque(Var StatusCheque: Integer): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_ImprimeCheque(Banco: String; Valor: String; Favorecido: String; Cidade: String; Data: String; Mensagem: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_IncluiCidadeFavorecido(Cidade: String; Favorecido: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_RetornoImpressora(Var ACK: Integer; Var ST1: Integer; Var ST2: Integer): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_FechaPortaSerial:Integer; StdCall;
   External 'BEMAFI32.DLL' Name 'Bematech_FI_FechaPortaSerial';

   Function Bematech_FI_IniciaFechamentoCupom(AcrescimoDesconto: String; TipoAcrescimoDesconto: String; ValorAcrescimoDesconto: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_EfetuaFormaPagamento(FormaPagamento: String; ValorFormaPagamento: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_TerminaFechamentoCupom(Mensagem: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_MapaResumo:Integer; StdCall;
   External 'BEMAFI32.DLL' Name 'Bematech_FI_MapaResumo';

   Function Bematech_FI_ProgramaMoedaSingular(MoedaSingular: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

   Function Bematech_FI_ProgramaMoedaPlural(MoedaPlural: String): Integer; StdCall;
   External 'BEMAFI32.DLL';

type
  TForm1 = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  func,comando:string;
  retorno:string;
  _ini:Tinifile;

implementation



{$R *.DFM}

procedure Enviacomando(p:integer;Comand:Pchar);
begin
// Esta fun??o tem como objetivo enviar os comandos para o ECF
// atravez de um comando de envio da dll do fabricante do ECF.
// No caso da bematech, este fun?o ?o ser? utilizada, pois est?
// sendo utilizada a DLL de alto n?vel, onde ela mesmo envia o comando
// necess?rio.
end;


procedure espera_ecf(p:integer);
//var i:Tdatetime;
begin
// Esta fun??o tem como objetivo, segurar a aplica??o enquanto o ECF
// est? ocupado (processando algum comando ou imprimindo algo).
// Isso ? necess?rio somente para ECF que liberam o processamento antes de terminar a
// impressao.
// Isso ? feito enviando um comando de status de ECF (de acordo com cada ECF)
// num loop, s? liberando com o status vier OK ou quando estourar o time-out,
// q no caso ? de 2".

//     i:=now;
//     while (now-i)<=strtotime('00:02:00') do // time-out para liberar
//        begin
//           func:='Espera ECF';
//           comando:'qq comando de status';
//           strpcopy(cmd,comando);
//           enviacomando(p,cmd);
//           if copy(retorno,1,2)='.+' then exit;
//        end;
end;


function carrega_ini_bancos(banco:string):string;
var _bancos:Tinifile;
begin
// Nesta fun??o est? a chamada do arquivo que est? o lay-out de bancos (cheque).
// Este arquivo ? do tipo INI e est? no seguinte formato: <numero do banco> = <coordenadas>.
// As coordenadas mudar?o de acordo com o ECF.
// Utilize a rotina abaixo (comentada) para capturar o lay-out do banco no arquivo ini
// A vari?vel BANCO, dentro desta fun??o ? usada como parametro para capturar o codigo do
// banco no arquivo INI.

     _bancos:=TIniFile.Create(extractfilepath(application.exename)+'dados\_bematechbancos.ini');
     result:=_bancos.ReadString('BANCOS', banco, '000');
     _bancos.Free;
end;

function strtoquant(texto:string):string;
var posi:integer;
    t1,t2:string;
begin
// Est? fun??o fomata uma string no formato para quantida, de acordo
// com cada ECF (geralmente o formato ? 4 inteiro e 3 decimais, se vai
// ou n?o ter virgula, vai depender do ECF).

     posi:=pos('.',texto);
     if posi=0 then posi:=pos(',',texto);

     if posi=0 then texto:=floattostr(strtofloat(texto)/1000);

     t1:=copy(texto,1,posi-1);
     t2:=copy(texto,posi+1,3);
     while length(t2)<3 do t2:=t2+'0';
     if length(t1)=0 then t1:='0';
     texto:=t1+','+t2;
     result:=texto;
end;


function strtovalor(d:integer;texto:string):string;
var posi:integer;
    t1,t2:string;
begin
// Est? fun??o fomata uma string no formato para valor, de acordo
// com cada ECF (geralmente n?o tem um formato padr?o, e se vai
// ou n?o ter virgula, vai depender do ECF).

     posi:=pos('.',texto);
     if posi=0 then posi:=pos(',',texto);

     if posi=0 then
        begin
           texto:=texto+',';
           while length(t2)<d do t2:=t2+'0';
           texto:=texto+t2;
        end
     else
        begin
           t1:=copy(texto,1,posi-1);
           t2:=copy(texto,posi+1,2);
           while length(t2)<d do t2:=t2+'0';
           if length(t1)=0 then t1:='0';
           texto:=t1+','+t2;
        end;
     result:=texto;
end;


function Enche(texto,caracter:string;lado,tamanho:integer):string;
begin
// Esta fun??o completa uma string (TEXTO) com um determinado caracter (CARACTER) at? atingir
// o tamanho desejado (TAMANHO). O lado pode ser definido (LADO).

     while length(texto)<tamanho do
        begin // lado=1, caracteres a esquerda  -  lado=2, caracteres a direita
           if lado = 1 then texto := caracter + texto else texto := texto + caracter;
        end;
     result:=texto;
end;

procedure Log(texto:string); // monta o log de comandos e retornos.
var LOGfile:textfile;
begin
// A fun??o LOG cria um log (em TXT) no mesmo diret?rio da DLL
// com os comando enviados para o ECF e os devidos retornos.
// Isso facilita a depora??o de algum eventual BUG no sistema. (tomara q isso n?o ocorra, mas... ^_^ )

     AssignFile(LOGfile,extractfilepath(application.exename)+'_BEMATECH.LOG');
     if not fileexists(extractfilepath(application.exename)+'_BEMATECH.LOG') then Rewrite(logfile) else Reset(Logfile);
     Append(logfile);
     Writeln(logfile,datetimetostr(now)+' - '+texto);
     Flush(logfile);
     closefile(logfile);
end;

function Prepara_Resp(tipo:integer;texto,texto2,continue:string):shortstring; // esta fun?a?o prepara a string de retorno da DLL para a aplica??o.
var t:string;
    r:shortstring;
begin
// A fun??o PREPARA_RESP formata a string de retorno vindo do ECF em um formato
// padr?o para o sistema Autocom.
// Para o AUTOCOM, o caracter @, vindo no in?cio da string, significa que o comando
// foi executado com sucesso e eventualmente pode ser acopanhado de uma resposta ( geralmente
// uma resposta de status.
// o caracter # significa que ocorreu um erro, e sempre ? seguido pela string com o
// c?digo do erro ou a menssagem de erro (dependendo de cada ECF);

     t:=texto;
     texto:='#ECF BEMATECH'+chr(13)+' ERRO: '+texto;
     texto2:='@'+texto2;
     if copy(t,1,2)='.-' then r:=texto;
     if copy(t,1,2)='.+' then r:=texto2;
     if copy(t,1,2)='.=' then r:='!';
     result:=r;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//       Declara??es de fun??es de exporta??o da DLL                                                     //
//                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////

// OBSERVA??ES: 1) Vale lembrar que alguns parametros das fun??es abaixo
//                 n?o ser?o usadas por todos os tipos de ECF, portanto, caso
//                 isso ocorra, simplesmente ignore o valor passado no
//                 par?metro.
//
//              2) ? importante que a string do LOG siga um padr?o para todos os
//                 comando, conforme o exemplo em cada uma das fun??es.
//                 Esse padr?o ? impressind?vel pelo fato de que existir?o v?rias
//                 DLL, uma para cada tipo de ECF. Dessa maneira o suporte ser?
//                 mais f?cil, assim como a depura??o de eventuais BUGs.


function Troca_op(tipo,porta:integer;codigo,fazoq:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  cod  -> C?digo do operador
  fazoq -> 0 = Saida
           1 = Entrada
=========================================================}
// No ECF Bematech n?o tem comando para controle de troca de operador.
     func:='Troca de operador';
     comando:='<Comando_de_troca_de_operador>';
     log(func+' - Enviado (BEMATECH):'+comando);
//     enviacomando(porta,cmd);
     retorno:='.=';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);
end;

function Abrecupom(tipo,porta:integer;texto:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Abertura de cupom';
     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_AbreCupom(texto));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;
        end;
end;

function AbreGaveta(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Abertura de Gaveta';
     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_AcionaGaveta);
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;
        end;
end;

function AcreSub(tipo,porta:integer;val,tipacre:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  val -> valor do acrescimo
  tipoacre-> tipo de acrescimo.
=========================================================}
     func:='Acrescimo no subtotal';
     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);

           val:=strtovalor(2,val);
           while pos(',',val)>0 do delete(val,pos(',',val),1);
           while pos('.',val)>0 do delete(val,pos('.',val),1);

           retorno:=inttostr(Bematech_FI_IniciaFechamentoCupom('A','$',val));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;
        end;
end;

function Autentica(tipo,porta:integer;codigo,repete:string):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  codigo -> caracteres qq para impress?o
  repete -> 1=envia comando para repitir aut.
            0=Envia comando para aut.
=========================================================}
// Ainda n?o est? implementado.
     func:='Autenticacao';
     comando:='Comando_de_autenticacao';
     log(func+' - Enviado (BEMATECH):'+comando);
//     enviacomando(porta,cmd);
     retorno:='.=';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
end;

function Cancelacupom(tipo,porta:integer;venda,valor:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  Venda -> n?o usado
  Valor -> n?o usado
=========================================================}
     func:='Cancela Cupom';
     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_CancelaCupom);
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;
        end;
end;

function CancItem(tipo,porta:integer;cod,nome,prtot,trib,ind:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  cod   -> n?o usado
  nome  -> n?o usado
  prtot -> n?o usado
  trib  -> n?o usado
  ind   -> posi??o do produto no cupom fiscal
=========================================================}
     func:='Cancelamento de item';

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_CancelaItemGenerico(enche(ind,'0',1,3)));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;
        end;
end;

function Descitem(tipo,porta:integer; val:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  val   -> Valor do desconto.
=========================================================}
//N?o ? usado desconto no item na Bematech
     func:='Desconto no item';

     val:=strtovalor(2,val);
     while pos(',',val)>0 do delete(val,pos(',',val),1);
     while pos('.',val)>0 do delete(val,pos('.',val),1);

     comando:='Comando_de_desconto_no_item';
     log(func+' - Enviado (BEMATECH):'+comando);
//     enviacomando(porta,cmd);
     retorno:='.-Desconto de item inexistente';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);
end;

function DescSub(tipo,porta:integer; val:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  val   -> Valor do desconto
=========================================================}
     func:='Desconto no subtotal';

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);

           val:=strtovalor(2,val);
           while pos(',',val)>0 do delete(val,pos(',',val),1);
           while pos('.',val)>0 do delete(val,pos('.',val),1);

           retorno:=inttostr(Bematech_FI_IniciaFechamentoCupom('D','$',val));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;
        end;
end;

function FecharCupom(tipo,porta:integer; SegCp,CNFV,l1,l2,l3,l4,l5,l6,l7,l8:string):shortstring;
var gt:string;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  SegCP  -> n?o usado
  CNFV   -> n?o usado
  l1..l8 -> Linhas de mensagens de cortesia.
=========================================================}
     func:='Fechamento de Cupom';

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           if l8<>'' then l8:=enche(l8,' ',1,60);
           if l7<>'' then l7:=enche(l7,' ',1,60);
           if l6<>'' then l6:=enche(l6,' ',1,60);
           if l5<>'' then l5:=enche(l5,' ',1,60);
           if l4<>'' then l4:=enche(l4,' ',1,60);
           if l3<>'' then l3:=enche(l3,' ',1,60);
           if l2<>'' then l2:=enche(l2,' ',1,60);
           if l1<>'' then l1:=enche(l1,' ',1,60);
           retorno:=inttostr(Bematech_FI_TerminaFechamentoCupom(l1+l2+l3+l4+l5+l6+l7+l8));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           if retorno='.-' then
              begin
                 retorno:=inttostr(Bematech_FI_FechaRelatorioGerencial);
                 if retorno='1' then retorno:='.+' else retorno:='.-';
              end;

           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;

           _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini'); // vai gravar no ini da dll o coo final.
           if _ini.readString('RIMA','gt_inicial', '')='' then
              begin
                 if Bematech_FI_AbrePortaSerial=1 then
                    begin
                       log(func+' - Enviado (BEMATECH):'+func);
                       retorno:=inttostr(Bematech_FI_GrandeTotal(gt));
                       Bematech_FI_FechaPortaSerial;
                       _ini.writeString('RIMA','gt_inicial', gt)
                    end;
              end;
           _ini.Free;            
        end;
end;

function Finalizadia(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo     -> tipo de ECF
  porta    -> porta de comunica??o
=========================================================}
     func:='Reducao Z';

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_ReducaoZ(datetostr(date),timetostr(time)));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;
        end;
end;

function InicioDia(tipo,porta:integer; verao,op,modal:string):shortstring;
var
   m:array [1..10] of string;
   a,teste:integer;
   resp:string;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  verao  -> 0=N?o est? no hor?rio de ver?o
            1=Est? no hor?rio de ver?o
  op     -> n?o usado
  modal  -> modalidades de pagameto para serem programadas, divididas po pipe. S?o no m?ximo 10
=========================================================}
     func:='Inicio do dia - HV';

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;

     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_FlagsFiscais(teste));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;
        end;

     resp:='0';
     while teste>0 do
        begin
           if teste>=128 then teste:=teste-128;
           if teste>=32 then  teste:=teste-32;
           if teste>=8 then teste:=teste-8;
           if teste>=4 then
              begin
                 teste:=teste-4;
                 resp:='1'
              end;
           if teste>=2 then teste:=teste-2;
           if teste>=1 then teste:=teste-1;
        end;

     if ((verao='1') and (resp<>'0')) or ((verao='0') and (resp='1')) then
        begin
           if Bematech_FI_AbrePortaSerial=1 then
              begin
                 log(func+' - Enviado (BEMATECH):'+func);
                 retorno:=inttostr(Bematech_FI_ProgramaHorarioVerao);
                 if retorno='1' then retorno:='.+' else retorno:='.-';
                 result:=Prepara_Resp(tipo,retorno,'','');
                 log(func+' - Recebido (BEMATECH):'+retorno);
                 espera_ecf(porta);
                 Bematech_FI_FechaPortaSerial;
              end;
        end;

     for a:=1 to 10 do
        begin
           if length(modal)>0 then
              begin
                 m[a]:=copy(modal,1,pos('|',modal)-1);
                 delete(modal,1,pos('|',modal));
                 if length(m[a])<16 then m[a]:=enche(m[a],' ',2,16) else m[a]:=copy(m[a],1,16);
              end;
        end;

     func:='Inicio do dia - Programa finalizadoras';
     for a:=1 to 10 do
        begin
           if length(m[a])>0 then
              begin
                 if Bematech_FI_AbrePortaSerial=1 then
                    begin
                       log(func+' - Enviado (BEMATECH):'+func);
                       retorno:=inttostr(Bematech_FI_NomeiaTotalizadorNaoSujeitoIcms(a,m[a]));
                       if retorno='1' then retorno:='.+' else retorno:='.-';
                       result:=Prepara_Resp(tipo,retorno,'','');
                       log(func+' - Recebido (BEMATECH):'+retorno);
                       espera_ecf(porta);
                       Bematech_FI_FechaPortaSerial;
                    end;
              end;
        end;

     func:='Inicio do dia - Leitura X';
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_LeituraX);
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;

           _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini'); // vai gravar no ini da dll o coo final.
           _ini.writeString('RIMA','coo_inicial', '');
           _ini.writeString('RIMA','gt_inicial', '');
           _ini.Free;
        end;
end;

function Lancaitem(tipo,porta:integer; cod, nome, qtde, prunit, prtot, Trib: string):shortstring;
var d:string;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  cod    -> c?digo do produto
  nome   -> descri??o do produto
  qtde   -> quantidade do produto. O primeiro byte indica a casa decimal, pode ser 2 ou 3.
  prunit -> pre?o unit?rio do produto
  prtot  -> n?o usado
  trib   -> tributa??o do produto
=========================================================}
     func:='Lanca item';
     d:=copy(qtde,1,1);
     delete(qtde,1,1);
     if length(cod)<13  then cod:=enche(cod,'0',1,13)   else cod:=copy(cod,1,13);
     if length(nome)<29 then nome:=enche(nome,' ',2,29) else nome:=copy(nome,1,29);
     qtde:=strtoquant(trim(qtde));
     while pos(',',qtde)>0 do delete(qtde,pos(',',qtde),1);
     while pos('.',qtde)>0 do delete(qtde,pos('.',qtde),1);

     if length(qtde)<7 then qtde:=enche(qtde,'0',1,7) else qtde:=copy(qtde,1,7);
     if (trib='T1') then trib:='01';
     if (trib='T2') then trib:='02';
     if (trib='T3') then trib:='03';
     if (trib='T4') then trib:='04';
     if (trib='T5') then trib:='05';
     if (trib='T6') then trib:='06';
     if (trib='T7') then trib:='07';
     if (trib='T8') then trib:='08';
     if (trib='T9') then trib:='09';
     if (trib='T10') then trib:='10';
     if (trib='T11') then trib:='11';
     if (trib='T12') then trib:='12';
     if (trib='T13') then trib:='13';
     if (trib='T14') then trib:='14';
     if (trib='T15') then trib:='15';
     if (pos('I',trib)>0) then trib:='II';
     if (pos('F',trib)>0) then trib:='FF';
     if (pos('N',trib)>0) then trib:='NN';
     if length(trib)<2 then trib:=enche(trib,'0',1,2) else trib:=copy(trib,1,2);

     prunit:=strtovalor(2,prunit);
     while pos(',',prunit)>0 do delete(prunit,pos(',',prunit),1);
     while pos('.',prunit)>0 do delete(prunit,pos('.',prunit),1);

     if length(prunit)<8 then prunit:=enche(prunit,'0',1,8) else prunit:=copy(prunit,1,8);

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_VendeItem(cod,nome,trib,'F',qtde,strtoint(d),prunit,'%','0000'));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;
        end;
end;

function Notadecupom(tipo,porta:integer; ind,texto:string;abc:boolean):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  ind    -> indicador a ser impresso no cupom
  texto  -> texto a ser impresso no cupom
=========================================================}
     func:='Nota de Cupom';

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if abc=true then
        begin
           if Bematech_FI_AbrePortaSerial=1 then
              begin
                 log(func+' - Enviado (BEMATECH):'+func);
                 retorno:=inttostr(Bematech_FI_AbreCupom(texto));
                 if retorno='1' then retorno:='.+' else retorno:='.-';
                 log(func+' - Recebido (BEMATECH):'+retorno);
                 espera_ecf(porta);
                 Bematech_FI_FechaPortaSerial;
              end;
        end;

     comando:='<Comando_de_nota_de_cupom>';
     log(func+' - Enviado (BEMATECH):'+comando);

     retorno:='.=';

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);
end;

function TextoNF(tipo,porta:integer;texto,valor:string):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  texto  -> Texto a ser impresso.
  valor  -> n?o usado
=========================================================}
     func:='Texto nao fiscal';

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_RelatorioGerencial(texto));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;
        end;
end;

function Totalizacupom(tipo,porta:integer;Moda,valor:string):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  Moda   -> C?digo da modalidade de pagamento
  valor  -> Valor recebido da modalidade de pagamento
=========================================================}
     func:='Totaliza Cupom';
     moda:=enche(moda,'0',1,2);

     valor:=strtovalor(2,valor);
     while pos(',',valor)>0 do delete(valor,pos(',',valor),1);
     while pos('.',valor)>0 do delete(valor,pos('.',valor),1);

     if length(valor)<14 then valor:=enche(valor,'0',1,14) else valor:=copy(valor,1,14);

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;

     if moda<>'00' then
        begin
           if Bematech_FI_AbrePortaSerial=1 then
              begin
                 log(func+' - Enviado (BEMATECH):'+func);
                 retorno:=inttostr(Bematech_FI_EfetuaFormaPagamento(moda,valor));
                 if retorno='1' then retorno:='.+' else retorno:='.-';
                 result:=Prepara_Resp(tipo,retorno,'','');
                 log(func+' - Recebido (BEMATECH):'+retorno);
                 espera_ecf(porta);
                 Bematech_FI_FechaPortaSerial;
              end;
        end
     else
        begin
           if Bematech_FI_AbrePortaSerial=1 then
              begin
                 log(func+' - Enviado (BEMATECH):'+func);
                 retorno:=inttostr(Bematech_FI_IniciaFechamentoCupom('D','%','0000'));
                 retorno:='.+';
                 result:=Prepara_Resp(tipo,retorno,'','');
                 log(func+' - Recebido (BEMATECH):'+retorno);
                 espera_ecf(porta);
                 Bematech_FI_FechaPortaSerial;
              end;
        end;
end;

function LeituraX(tipo,porta:integer;NF:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  NF   -> 0=Imprime somente Leitura X
          1=Imprime leitura x e espera texto n?o fiscal
=========================================================}
     func:='Leitura X';
     if nf='0' then
        begin
           _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
           _ini.writeString('Sistema','porta', inttostr(porta));
           _ini.Free;
           if Bematech_FI_AbrePortaSerial=1 then
              begin
                 log(func+' - Enviado (BEMATECH):'+func);
                 retorno:=inttostr(Bematech_FI_LeituraX);
                 if retorno='1' then retorno:='.+' else retorno:='.-';
                 Bematech_FI_FechaPortaSerial;
              end;
        end
     else
        begin
           log(func+' - Enviado (BEMATECH): Relatorio Gerencial');
           retorno:='.+';
        end;
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);
end;

function Venda_liquida(tipo,porta:integer):shortstring;
var liq:string;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Venda Liquida';

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_SubTotal(liq));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,copy(liq,3,12),'');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;
        end;
end;

function COO(tipo,porta:integer;tipo_coo:string):shortstring;
var c:string;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  tipo_coo -> 0 = ultimo emitido
              1 = atual
=========================================================}
     func:='COO';

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_NumeroCupom(c));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           if tipo_coo='1' then c:=inttostr(strtoint(c)+1);
           result:=Prepara_Resp(tipo,retorno,c,'');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;

           _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini'); // vai gravar no ini da dll o coo final.
           _ini.writeString('RIMA','coo_final', c);
           if _ini.readstring('RIMA','coo_inicial','')='' then _ini.writestring('RIMA','coo_inicial',c);

           _ini.Free;
        end;
end;

function Sangria(tipo,porta:integer;modal,valor:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  modal -> C?digo da modalidade de pagamento.
  valor -> Valor da Sangria.
=========================================================}
     func:='Sangria';
     valor:=strtovalor(2,trim(valor));
     while pos(',',valor)>0 do delete(valor,pos(',',valor),1);
     while pos('.',valor)>0 do delete(valor,pos('.',valor),1);
     if length(valor)<14 then valor:=enche(valor,'0',1,14) else valor:=copy(valor,1,14);


     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_Sangria(valor));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;
        end;
end;

function FCX(tipo,porta:integer;modal,valor:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  modal -> C?digo da modalidade de pagamento.
  valor -> Valor do fundo de caixa.
=========================================================}
     func:='Fundo de Caixa';
     valor:=strtovalor(2,trim(valor));
     while pos(',',valor)>0 do delete(valor,pos(',',valor),1);
     while pos('.',valor)>0 do delete(valor,pos('.',valor),1);
     if length(valor)<14 then valor:=enche(valor,'0',1,14) else valor:=copy(valor,1,14);


     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_Suprimento(valor,modal));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;
        end;
end;

function Cheque(tipo,porta:integer;banco,valor,data,favorecido,municipio,cifra,moedas,moedap:string):shortstring;
var obs:string;
    modelo: array [1..10] of integer; //modelos que tem impress?o de cheques
    ok:boolean;
    a:integer;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  banco -> N?mero do Banco
  valor -> Valor do cheque
  data  -> Data do cheque
  favorecido -> Favorecido do cheque. depois do pipe |, vem a observacao para o cheque;
  municipio  -> municipio do cheque
  cifra  -> Cifra di cheque
  moedas -> nome da moeda no singular
  moedap -> nome da meoda no plural
=========================================================}

//{tipo para o ECF  30} -> 'Bematech - MP-20 FI II uma Esta??es'

     for a:=1 to 10 do modelo[a]:=0;

     ok:=false;
     for a:=1 to 10 do
        begin
           if modelo[a]=tipo then
              begin
                 ok:=true;
                 break;
              end;
        end;

     if ok=true then
        begin
           func:='Cheque';
           Obs:=copy(favorecido,pos('|',favorecido)+1,length(favorecido));
           delete(favorecido,pos('|',favorecido),length(favorecido));

           valor:=strtovalor(2,valor);
           while pos(',',valor)>0 do delete(valor,pos(',',valor),1);
           while pos('.',valor)>0 do delete(valor,pos('.',valor),1);
           if length(valor)>=14 then valor:=copy(valor,1,14) else valor:=enche(valor,'0',1,14);
           if length(favorecido)>=45 then favorecido:=copy(favorecido,1,45) else favorecido:=enche(favorecido,' ',2,45);
           if length(municipio)>=27 then municipio:=copy(municipio,1,27) else municipio:=enche(municipio,' ',2,27);

           _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
           _ini.writeString('Sistema','porta', inttostr(porta));
           _ini.Free;
           if Bematech_FI_AbrePortaSerial=1 then
              begin
                 log(func+' - Enviado (BEMATECH):'+func);
                 retorno:=inttostr(Bematech_FI_ProgramaMoedaSingular(moedas));
                 if retorno='1' then retorno:='.+' else retorno:='.-';
                 log(func+' - Recebido (BEMATECH):'+retorno);
                 Bematech_FI_FechaPortaSerial;
              end;
           if Bematech_FI_AbrePortaSerial=1 then
              begin
                 log(func+' - Enviado (BEMATECH):'+func);
                 retorno:=inttostr(Bematech_FI_ProgramaMoedaPlural(moedap));
                 if retorno='1' then retorno:='.+' else retorno:='.-';
                 log(func+' - Recebido (BEMATECH):'+retorno);
                 Bematech_FI_FechaPortaSerial;
              end;
           if Bematech_FI_AbrePortaSerial=1 then
              begin
                 log(func+' - Enviado (BEMATECH):'+func);
                 retorno:=inttostr(Bematech_FI_ImprimeCheque(banco,valor,favorecido,municipio,datetostr(date),obs));
                 if retorno='1' then retorno:='.+' else retorno:='.-';
                 result:=Prepara_Resp(tipo,retorno,'','');
                 log(func+' - Recebido (BEMATECH):'+retorno);
                 espera_ecf(porta);
                 Bematech_FI_FechaPortaSerial;
              end;
        end
     else
        begin
           retorno:='.+';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Executado:'+retorno);
        end;
end;

function Contra_vale(tipo,porta:integer;valor:string):shortstring;
var texto,c:string;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  valor -> Valor do contra-vale at? o pipe |, depois do pipe, ? a descri??o da forma de pagamento .
=========================================================}
     func:='Contra-vale';

     texto:=copy(valor,pos('|',valor)+1,16);
     valor:=copy(valor,1,pos('|',valor)-1);
     texto:=enche(texto,' ',2,16);
     texto:=copy(texto,1,1)+LowerCase(copy(texto,2,16));


      _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
      _ini.writeString('Sistema','porta', inttostr(porta));
      _ini.Free;
      if Bematech_FI_AbrePortaSerial=1 then
         begin
            Bematech_FI_NumeroCupom(c);
            c:=inttostr(strtoint(c)-1);
            log(func+' - Enviado (BEMATECH):'+func);
            retorno:=inttostr(Bematech_FI_AbreComprovanteNaoFiscalVinculado(texto,strtovalor(2,valor),c));
            if retorno='1' then
               begin
                  log(func+' - Recebido (BEMATECH):'+retorno);
                  retorno:=inttostr(Bematech_FI_UsaComprovanteNaoFiscalVinculado('Contra - Vale'));
                  if retorno='1' then
                     begin
                        retorno:=inttostr(Bematech_FI_FechaComprovanteNaoFiscalVinculado);
                     end;
               end;
            if retorno='1' then retorno:='.+' else retorno:='.-';
            result:=Prepara_Resp(tipo,retorno,'','');
            log(func+' - Recebido (BEMATECH):'+retorno);
            espera_ecf(porta);
            Bematech_FI_FechaPortaSerial;
         end;

end;

function cnfv(tipo,porta:integer) : shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Abertura de CNFV';
     retorno:=inttostr(Bematech_FI_AbreComprovanteNaoFiscalVinculado('TEF','',''));
     if retorno='1' then retorno:='.+' else retorno:='.-';
     log(func+' - Recebido (NCR):'+retorno);
     result:=Prepara_Resp(tipo,retorno,'','');
     espera_ecf(porta);
end;

function ECF_INFO(tipo,porta:integer):shortstring;
var c,d,e,f,g,h,i,j,k,l,m,n:string;
    t:integer;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='ECF INFO';

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', 'COM'+inttostr(porta));
     _ini.Free;

     t:=Bematech_FI_AbrePortaSerial;
     if t=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_NumeroCaixa(c));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           log(func+' - Recebido (BEMATECH):'+retorno);

           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_DataHoraImpressora(d,e));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           log(func+' - Recebido (BEMATECH):'+retorno);

           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_DataHoraReducao(e,f));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           log(func+' - Recebido (BEMATECH):'+retorno);

           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_DataMovimento(f));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           log(func+' - Recebido (BEMATECH):'+retorno);

           Bematech_FI_FechaPortaSerial;

           d:=copy(d,1,2)+'/'+copy(d,3,2)+'/'+copy(d,5,2);
           e:=copy(e,1,2)+'/'+copy(e,3,2)+'/'+copy(e,5,2);
           f:=copy(f,1,2)+'/'+copy(f,3,2)+'/'+copy(f,5,2);

           if d='00/00/00' then
              begin
                 if strtodate(e)<strtodate(d) then // se a data da ultima reducao for menor que a data da impressora
                    begin
                       d:='1';
                    end;
                 if strtodate(e)=strtodate(d) then // se a data da ultima reducao for IGUAL a data da impressora
                    begin
                       if strtodate(f)<strtodate(d) then // se a data do ultimo movimento for menor que a data da impressora
                          begin
                             d:='1';
                          end
                       else
                          begin
                             d:='2';
                          end;
                    end;
              end
           else
              begin
                 d:='0';
              end;

           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_MonitoramentoPapel(t));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           log(func+' - Recebido (BEMATECH):'+retorno);
           if t<=100 then e:='1' else e:='0';

           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_VerificaStatusCheque(t));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           log(func+' - Recebido (BEMATECH):'+retorno);
           if (t=2) or (t=3) then f:='1' else f:='0';

           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_VerificaEstadoGaveta(t));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           log(func+' - Recebido (BEMATECH):'+retorno);
           if t=1 then g:='1' else g:='0';

           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_FlagsFiscais(t));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);

           h:='0';
           while t>0 do
              begin
                 if t>=128 then t:=t-128;
                 if t>=32 then  t:=t-32;
                 if t>=8 then t:=t-8;
                 if t>=4 then t:=t-4;
                 if t>=2 then t:=t-2;
                 if t>=1 then t:=t-1;
                    begin
                       t:=t-1;
                       h:='1'
                    end;
              end;

           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_NumeroSerie(n));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);

           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_NumeroReducoes(k));
           k:=enche(k,'0',1,6);
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);

           _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini'); // vai gravar no ini da dll o coo final.
           i:=_ini.readString('RIMA','coo_inicial', '0');
           j:=_ini.readString('RIMA','coo_final', '0');
           _ini.Free;
           i:=enche(i,'0',1,6);
           j:=enche(j,'0',1,6);

           _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini'); // vai gravar no ini da dll o coo final.
           l:=_ini.readString('RIMA','gt_inicial', '0');
           l:=copy(l,7,12);
           l:=enche(l,'0',1,12);
           _ini.Free;

           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_GrandeTotal(m));
           m:=copy(m,7,12);
           m:=enche(m,'0',1,12);
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);

           result:=Prepara_Resp(tipo,retorno,c+d+e+f+g+h+i+j+k+l+m+n,'');
           log(func+' - Recebido (BEMATECH):'+retorno+' ->'+c+d+e+f+g+h+i+j+k+l+m+n);

     // byte 1: os 4 primeiros s?o o n?mero do ECF (d)
     // byte 5: ? a situa??o do dia: 0 - Dia aberto   (c)
     //                              1 - Abrir o dia
     //                              2 - Dia encerrado
     //                              3 - Encerrar o dia
     // byte 6: ? o status de papel presente (bobina) - 0=n?o tem   1=tem (e)
     // byte 7: ? o status documento presente (cheque e autentica??o) (f)
     // byte 8: ? o status de gaveta aberta (0=n?o 1=sim) (g)
     // byte 9: ? o status de cupom fiscal aberto  (0=n?o   1=sim) (h)

     // byte 10: ? o coo inicial (i)
     // byte 16: ? o coo final  (j)
     // byte 22: ? o numero de reducoes (k)
     // byte 26: ? o gt inicial (l)
     // byte 38: ? o gt final (m)
     // byte 50: ? o ns do ecf (n)

        end
     else
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           result:=Prepara_Resp(tipo,'.-','','');
           log(func+' - Recebido (BEMATECH):'+retorno);
        end;
end;

function LMFD(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='LEITURA DA MEM?RIA FISCAL POR DATA';

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_LeituraMemoriaFiscalData(inicio,fim));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;
        end;
end;

function LMFR(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='LEITURA DA MEM?RIA FISCAL POR REDU??O';

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'BemaFI32.ini');
     _ini.writeString('Sistema','porta', inttostr(porta));
     _ini.Free;
     if Bematech_FI_AbrePortaSerial=1 then
        begin
           log(func+' - Enviado (BEMATECH):'+func);
           retorno:=inttostr(Bematech_FI_LeituraMemoriaFiscalReducao(inicio,fim));
           if retorno='1' then retorno:='.+' else retorno:='.-';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
           Bematech_FI_FechaPortaSerial;
        end;
end;

function LMMM(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}

// Nesta fun??o ser? executada a aplica??o do fabricante para
// realizar a captura da mem?ria fiscal por meio magn?tico
// (disquete). Esse aplicativo vai mudar de acordo com cada
// ECF, pois cada fabricante tem o seu.
     func:='LEITURA DA MEM?RIA FISCAL POR MEIO Magn?tico';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Executado (BEMATECH):');
end;


// fun??es exportadas.
exports
    Troca_op index 1,
    Abrecupom index 2,
    AbreGaveta index 3,
    AcreSub index 4,
    Autentica index 5,
    Cancelacupom index 6,
    CancItem index 7,
    Descitem index 8,
    Descsub index 9,
    Fecharcupom index 10,
    Finalizadia index 11,
    InicioDia index 12,
    Lancaitem index 13,
    Notadecupom index 14,
    TextoNF index 15,
    TotalizaCupom index 16,
    LeituraX index 17,
    venda_liquida index 18,
    coo index 19,
    sangria index 20,
    fcx index 21,
    Cheque index 22,
    Contra_vale index 23,
    ecf_info index 24,
    LMFD index 25,
    LMFR index 26,
    LMMM index 27,
    cnfv index 28;
end.
