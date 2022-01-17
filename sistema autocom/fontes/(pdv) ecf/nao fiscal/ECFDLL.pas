unit ECFDLL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, stdctrls,Inifiles,
  CPort;

type
  TFnf = class(TForm)
    serial: TComPort;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fnf: TFnf;
  func,comando:string;
  retorno:string;
  CMD:array [0..512] of char;
  handle:Thandle;
  v_coo:string; // armazena o contador de ordem de operação (COO)

  v_serial: integer;// porta serial da gaveta de valores (quando a conexão for serial)

implementation
Function GavetaConfigura (pulso,min : integer): integer; stdcall; external 'Ghdl32.dll';
Function DriverGaveta (p,f : integer) :integer; stdcall; external 'Ghdl32.dll';


{$R *.DFM}


procedure Enviacomando(p:integer;Comand:Pchar);
var
   F : TextFile;
   device:string;
begin
     if p=0 then device:='LPT1' else device:='COM'+inttostr(p);
     if device='LPT1' then
        begin
           try
              AssignFile(F,device);
              Rewrite(F);
              Writeln(F,strpas(comand));
              CloseFile(F);
              retorno:='.+';
              sleep(500);
           except
              retorno:='.-';
           end;
        end
     else
        begin
           try
              Fnf.serial.port:=device;
              Fnf.serial.open;
              Fnf.serial.WriteStr(strpas(comand)+chr(10)+chr(13));
              Fnf.serial.close;
              retorno:='.+';
           except
              retorno:='.-';
           end;
        end;
end;

function carrega_ini_bancos(banco:string):string;
var _bancos:Tinifile;
begin
// Nesta função está a chamada do arquivo que está o lay-out de bancos (cheque).
// Este arquivo é do tipo INI e está no seguinte formato: <numero do banco> = <coordenadas>.
// As coordenadas mudarão de acordo com o ECF.
// Utilize a rotina abaixo (comentada) para capturar o lay-out do banco no arquivo ini
// A variável BANCO, dentro desta função é usada como parametro para capturar o codigo do
// banco no arquivo INI.

     _bancos:=TIniFile.Create(extractfilepath(application.exename)+'dados\_nfepson.ini');
     result:=_bancos.ReadString('BANCOS', banco, '000');
     _bancos.Free;
end;

function strtoquant(texto:string):string;
var posi:integer;
    t1,t2:string;
begin
// Está função fomata uma string no formato para quantida, de acordo
// com cada ECF (geralmente o formato é 4 inteiro e 3 decimais, se vai
// ou não ter virgula, vai depender do ECF).

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
// Está função fomata uma string no formato para valor, de acordo
// com cada ECF (geralmente não tem um formato padrão, e se vai
// ou não ter virgula, vai depender do ECF).

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
// Esta função completa uma string (TEXTO) com um determinado caracter (CARACTER) até atingir
// o tamanho desejado (TAMANHO). O lado pode ser definido (LADO).

     while length(texto)<tamanho do
        begin // lado=1, caracteres a esquerda  -  lado=2, caracteres a direita
           if lado = 1 then texto := caracter + texto else texto := texto + caracter;
        end;
     result:=texto;
end;

procedure espera_ecf(p:integer);
//var i:Tdatetime;
var _nfepson:TIniFile;
    conta:integer;
begin
// Esta função tem como objetivo, segurar a aplicação enquanto o ECF
// está ocupado (processando algum comando ou imprimindo algo).
// Isso é necessário somente para ECF que liberam o processamento antes de terminar a
// impressao.
// Isso é feito enviando um comando de status de ECF (de acordo com cada ECF)
// num loop, só liberando com o status vier OK ou quando estourar o time-out,
// q no caso é de 2".

//     i:=now;
//     while (now-i)<=strtotime('00:02:00') do // time-out para liberar
//        begin
//           func:='Espera ECF';
//           comando:'qq comando de status';
//           strpcopy(cmd,comando);
//           enviacomando(p,cmd);
//           if copy(retorno,1,2)='.+' then exit;
//        end;

// NO CASO DA DLL NÃO FISCAL, ESSE FUNÇÃO ESTÁ SENDO UTILIZADA
// PARA IMPLEMENTAR O COO NO ARQUIVO INI.
     conta:=p;
     if (conta+1)>99999999 then conta:=1 else conta:=conta+1;
     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     _nfepson.writeString('IMPRESSORA', 'COO', enche(inttostr(conta),'0',1,4));
     _nfepson.writeString('IMPRESSORA', 'COOANT', enche(inttostr(p),'0',1,4));
     _nfepson.Free;
end;

procedure Log(texto:string); // monta o log de comandos e retornos.
var LOGfile:textfile;
begin
// A função LOG cria um log (em TXT) no mesmo diretório da DLL
// com os comando enviados para o ECF e os devidos retornos.
// Isso facilita a deporação de algum eventual BUG no sistema. (tomara q isso não ocorra, mas... ^_^ )

     AssignFile(LOGfile,extractfilepath(application.exename)+'_nfepson.LOG');
     if not fileexists(extractfilepath(application.exename)+'_nfepson.LOG') then Rewrite(logfile) else Reset(Logfile);
     Append(logfile);
     Writeln(logfile,datetimetostr(now)+' - '+texto);
     Flush(logfile);
     closefile(logfile);
end;

function Prepara_Resp(tipo:integer;texto,texto2,continue:string):shortstring; // esta funçaão prepara a string de retorno da DLL para a aplicação.
var t:string;
    r:shortstring;
begin
// A função PREPARA_RESP formata a string de retorno vindo do ECF em um formato
// padrão para o sistema Autocom.
// Para o AUTOCOM, o caracter @, vindo no início da string, significa que o comando
// foi executado com sucesso e eventualmente pode ser acopanhado de uma resposta ( geralmente
// uma resposta de status.
// o caracter # significa que ocorreu um erro, e sempre é seguido pela string com o
// código do erro ou a menssagem de erro (dependendo de cada ECF);

     t:=texto;
     texto:='#NF EPSON'+chr(13)+' ERRO: '+texto;
     texto2:='@'+texto2;
     if copy(t,1,2)='.-' then r:=texto;
     if copy(t,1,2)='.+' then r:=texto2;
     if copy(t,1,2)='.=' then r:='!';
     result:=r;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//       Declarações de funções de exportação da DLL                                                     //
//                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////

// OBSERVAÇÔES: 1) Vale lembrar que alguns parametros das funções abaixo
//                 não serão usadas por todos os tipos de ECF, portanto, caso
//                 isso ocorra, simplesmente ignore o valor passado no
//                 parâmetro.
//
//              2) É importante que a string do LOG siga um padrão para todos os
//                 comando, conforme o exemplo em cada uma das funções.
//                 Esse padrão é impressindível pelo fato de que existirão várias
//                 DLL, uma para cada tipo de ECF. Dessa maneira o suporte será
//                 mais fácil, assim como a depuração de eventuais BUGs.


function Troca_op(tipo,porta:integer;codigo,fazoq:string):shortstring;
VAR _nfepson:TIniFile;
    L1,L2,L3,L4,L5:STRING;
    RMpar:Tinifile;
    vpdvnum:string;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  cod  -> Código do operador
  fazoq -> 0 = Saida
           1 = Entrada
=========================================================}
// No ECF Bematech não tem comando para controle de troca de operador.
     func:='Troca de operador';

     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     l1:=_nfepson.readString('CLICHE', 'L1', '');
     l2:=_nfepson.readString('CLICHE', 'L2', '');
     l3:=_nfepson.readString('CLICHE', 'L3', '');
     l4:=_nfepson.readString('CLICHE', 'L4', '');
     l5:=_nfepson.readString('CLICHE', 'L5', '');
     _nfepson.Free;

     comando:=L1;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L2;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L3;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L4;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L5;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='========================================';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     if fazoq='1' then comando:='        ENTRADA DE OPERADOR             ' else comando:='            SAIDA DE OPERADOR           ';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:='========================================';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='    OPERADOR : '+ codigo;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='========================================';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     v_coo:=_nfepson.readString('IMPRESSORA', 'COO', '0001');
     _nfepson.Free;

     RMPAR:=TIniFile.Create(extractfilepath(application.exename)+'dados\autocom.INI');
     vpdvnum:=RMPAR.ReadString('TERMINAL', 'PDVNum', '000');     // Número do PDV
     RMPAR.Free;

     comando:=datetostr(date)+' '+timetostr(time)+' COO:'+V_coo+' Pdv:'+vpdvnum;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);


     comando:='************* Autocom PLUS *************';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
     espera_ecf(strtoint(v_coo));
end;

function Abrecupom(tipo,porta:integer;texto:string):shortstring;
VAR _nfepson:TIniFile;
    L1,L2,L3,L4,L5:STRING;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     func:='Abertura de cupom';

     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     l1:=_nfepson.readString('CLICHE', 'L1', '');
     l2:=_nfepson.readString('CLICHE', 'L2', '');
     l3:=_nfepson.readString('CLICHE', 'L3', '');
     l4:=_nfepson.readString('CLICHE', 'L4', '');
     l5:=_nfepson.readString('CLICHE', 'L5', '');
     _nfepson.Free;

     comando:=L1;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L2;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L3;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L4;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L5;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=datetostr(date)+' '+timetostr(time);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     L1:=_nfepson.readString('IMPRESSORA', 'COO', '0001');
     _nfepson.Free;

     comando:='****************************************';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='              C U P O M : '+L1;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='****************************************';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
end;

function AbreGaveta(tipo,porta:integer):shortstring;
var x:integer;
    RMPAR:Tinifile;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     func:='Abertura de Gaveta';
     RETORNO:='.+';
     // tipo=01  -> Impressora padrão Epson
     // tipo=02  -> Impressora bematech
     // tipo=03  -> Impressora paralela Não fiscal

     if tipo=01 then comando:=CHR(27)+chr(112)+chr(48)+chr(50)+chr(250);
     if tipo=02 then comando:=chr(27)+chr(118)+chr(100);

     if tipo=03 then
        begin
           RMPAR:=TIniFile.Create(extractfilepath(application.exename)+'dados\AUTOCOM.INI');
           v_serial:=strtoint(RMPAR.ReadString('TERMINAL', 'COMGAVETA', '4')); // porta seral da gaveta
           RMPAR.Free;
           DriverGaveta (v_serial, 1); // inicializa da gaveta serial
           GavetaConfigura (150,3500 );
           DriverGaveta (v_serial,2); // abre gaveta
           x:=0;
           while x < 2000 do x:=x +1;
           result:=Prepara_Resp(tipo,'.+','','');
           log(func+'  - OK');
           sleep(2000);
        end
     else
        begin
           strpcopy(cmd,comando);
           enviacomando(porta,cmd);

           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' '+retorno);
           sleep(2000);
        end;
end;

function AcreSub(tipo,porta:integer;val,tipacre:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  val -> valor do acrescimo
  tipoacre-> tipo de acrescimo.
=========================================================}
     func:='Acrescimo no subtotal';

     val:=strtovalor(2,val);

     comando:='Acrescimo no Subtotal :'+ val ;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
end;

function Autentica(tipo,porta:integer;codigo,repete:string):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  codigo -> caracteres qq para impressão
  repete -> 1=envia comando para repitir aut.
            0=Envia comando para aut.
=========================================================}
     func:='Autenticacao';

     retorno:='.+';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
end;

function Cancelacupom(tipo,porta:integer;venda,valor:string):shortstring;
var _nfepson:TIniFile;
    RMpar:Tinifile;
    vpdvnum:string;

begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunicação
  Venda -> não usado
  Valor -> Valor da Venda
=========================================================}

     func:='Cancela Cupom';
     valor:=strtovalor(2,valor);

     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='          CANCELAMENTO DE CUPOM       ';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='    VALOR : '+valor;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     v_coo:=_nfepson.readString('IMPRESSORA', 'COO', '0001');
     _nfepson.Free;

     RMPAR:=TIniFile.Create(extractfilepath(application.exename)+'dados\autocom.INI');
     vpdvnum:=RMPAR.ReadString('TERMINAL', 'PDVNum', '000');     // Número do PDV
     RMPAR.Free;

     comando:=datetostr(date)+' '+timetostr(time)+' COO:'+V_coo+' Pdv:'+vpdvnum;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='************* Autocom PLUS *************';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);


     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
     espera_ecf(strtoint(v_coo));
end;

function CancItem(tipo,porta:integer;cod,nome,prtot,trib,ind:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunicação
  cod   -> Codigo do Prod
  nome  -> Nome do Produto
  prtot -> Valor total
  trib  -> não usado
  ind   -> nao Usado
=========================================================}
     func:='Cancelamento de item';

     comando:='Item Cancelado : '+strtovalor(2,prtot);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=enche(cod,' ',1,13)+' '+nome;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=' ';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);


     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
end;

function Descitem(tipo,porta:integer; val:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunicação
  val   -> Valor do desconto.
=========================================================}
     func:='Desconto no item';

     val:=strtovalor(2,val);

     comando:='Desconto Item : '+val;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);


     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
end;

function DescSub(tipo,porta:integer; val:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunicação
  val   -> Valor do desconto
=========================================================}
     func:='Desconto no subtotal';

     val:=strtovalor(2,val);
     comando:='Desconto Subtotal : '+val;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=' ';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
end;

function FecharCupom(tipo,porta:integer; SegCp,CNFV,l1,l2,l3,l4,l5,l6,l7,l8:string):shortstring;
var _nfepson:TIniFile;
    RMpar:Tinifile;
    vpdvnum:string;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  SegCP  -> não usado
  CNFV   -> não usado
  l1..l8 -> Linhas de mensagens de cortesia.
=========================================================}
     func:='Fechamento de Cupom';

     if ((trim(l1)='') and (trim(l2)='') and (trim(l3)='') and (trim(l4)='') and (trim(l5)='') and (trim(l6)='') and (trim(l7)='') and (trim(l8)='')) then
        begin
           retorno:='.+';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+':todas as linhas da mensagems de cortesias estão vazias '+retorno);
           exit;
        end;

     if trim(l1)<>'' then
        begin
           comando:=l1;
           strpcopy(cmd,comando);
           enviacomando(porta,cmd);
        end;
     if trim(l2)<>'' then
        begin
           comando:=l2;
           strpcopy(cmd,comando);
           enviacomando(porta,cmd);
        end;
     if trim(l3)<>'' then
        begin
           comando:=l3;
           strpcopy(cmd,comando);
           enviacomando(porta,cmd);
        end;
     if trim(l4)<>'' then
        begin
           comando:=l4;
           strpcopy(cmd,comando);
           enviacomando(porta,cmd);
        end;
     if trim(l5)<>'' then
        begin
           comando:=l5;
           strpcopy(cmd,comando);
           enviacomando(porta,cmd);
        end;
     if trim(l6)<>'' then
        begin
           comando:=l6;
           strpcopy(cmd,comando);
           enviacomando(porta,cmd);
        end;
     if trim(l7)<>'' then
        begin
           comando:=l7;
           strpcopy(cmd,comando);
           enviacomando(porta,cmd);
        end;
     if trim(l8)<>'' then
        begin
           comando:=l8;
           strpcopy(cmd,comando);
           enviacomando(porta,cmd);
        end;

     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     v_coo:=_nfepson.readString('IMPRESSORA', 'COO', '0001');
     _nfepson.Free;

     RMPAR:=TIniFile.Create(extractfilepath(application.exename)+'dados\AUTOCOM.INI');
     vpdvnum:=RMPAR.ReadString('TERMINAL', 'PDVNum', '0000');     // Número do PDV
     RMPAR.Free;

     comando:=datetostr(date)+' '+timetostr(time)+' COO:'+V_coo+' Pdv:'+vpdvnum;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='************* Autocom PLUS *************';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
     espera_ecf(strtoint(v_coo));
end;

function Finalizadia(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo     -> tipo de ECF
  porta    -> porta de comunicação
=========================================================}
     func:='Reducao Z';

     retorno:='.+';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
end;

function InicioDia(tipo,porta:integer; verao,op,modal:string):shortstring;
var
   m:array [1..10] of string;
   a:integer;
   _nfepson:Tinifile;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  verao  -> Nao Usado
  op     -> não usado
  modal  -> modalidades de pagamento
=========================================================}
     func:='Inicio do dia - HV';
     for a:=1 to 10 do
        begin
           if length(modal)>0 then
              begin
                 m[a]:=copy(modal,1,pos('|',modal)-1);
                 delete(modal,1,pos('|',modal));
                 if length(m[a])<16 then m[a]:=enche(m[a],' ',2,16) else m[a]:=copy(m[a],1,16);
              end;
        end;

     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     _nfepson.writeString('FINALIZADORAS', '01', m[1]);
     _nfepson.writeString('FINALIZADORAS', '02', m[2]);
     _nfepson.writeString('FINALIZADORAS', '03', m[3]);
     _nfepson.writeString('FINALIZADORAS', '04', m[4]);
     _nfepson.writeString('FINALIZADORAS', '05', m[5]);
     _nfepson.writeString('FINALIZADORAS', '06', m[6]);
     _nfepson.writeString('FINALIZADORAS', '07', m[7]);
     _nfepson.writeString('FINALIZADORAS', '08', m[8]);
     _nfepson.writeString('FINALIZADORAS', '09', m[9]);
     _nfepson.writeString('FINALIZADORAS', '10', m[10]);
     _nfepson.Free;

     retorno:='.+';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
end;

function Lancaitem(tipo,porta:integer; cod, nome, qtde, prunit, prtot, Trib: string):shortstring;
var d:string;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  cod    -> código do produto
  nome   -> descrição do produto
  qtde   -> quantidade do produto. O primeiro byte indica a casa decimal, pode ser 2 ou 3.
  prunit -> preço unitário do produto
  prtot  -> Preco total
  trib   -> tributação do produto
=========================================================}
     func:='Lanca item';
     d:=copy(qtde,1,1);
     delete(qtde,1,1);
     if length(cod)<13  then cod:=enche(cod,'0',1,13)   else cod:=copy(cod,1,13);
     qtde:=strtoquant(trim(qtde));

     if length(qtde)<7 then qtde:=enche(qtde,'0',1,7) else qtde:=copy(qtde,1,7);
     if length(trib)<2 then trib:=enche(trib,'0',1,2) else trib:=copy(trib,1,2);

     prunit:=strtovalor(strtoint(d),prunit);
     prtot:=strtovalor(2,prtot);
     if length(prunit)<8 then prunit:=enche(prunit,'0',1,8) else prunit:=copy(prunit,1,8);

     comando:='['+cod+']'+nome;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=qtde+'  x  '+prunit+'    =  '+prtot;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
end;

function Notadecupom(tipo,porta:integer; ind,texto:string;abc:boolean):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  ind    -> nao usado
  texto  -> texto a ser impresso no cupom
=========================================================}
     func:='Nota de Cupom';

     if abc=true then
        begin
           Abrecupom(tipo,porta,'');
        end;

     comando:=texto;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
end;

function TextoNF(tipo,porta:integer;texto,valor:string):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  texto  -> Texto a ser impresso.
  valor  -> não usado
=========================================================}
     func:='Texto nao fiscal';

     comando:=texto;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
end;

function Totalizacupom(tipo,porta:integer;Moda,valor:string):shortstring;
var _nfepson:tinifile;
   desc:string;
   val,tot:real;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  Moda   -> Código da modalidade de pagamento
  valor  -> Valor recebido da modalidade de pagamento
=========================================================}
     func:='Totaliza Cupom';
     moda:=enche(moda,'0',1,2);

     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     desc:=_nfepson.readString('FINALIZADORAS', moda, moda);
     _nfepson.Free;

     valor:=strtovalor(2,valor);

     if moda<>'00' then
        begin
           comando:=enche(desc,' ',2,20)+'R$ '+enche(valor,' ',1,16);
           strpcopy(cmd,comando);
           enviacomando(porta,cmd);

           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' '+retorno);

           _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
           val:=strtofloat(_nfepson.readString('FINALIZADORAS', 'valor_recebido', '0'));
           tot:=strtofloat(_nfepson.readString('FINALIZADORAS', 'valor_total', '0'));
           _nfepson.Free;

           val:=val+strtofloat(valor);

           if (val-tot)>=0.01 then
              begin
                 comando:='T R O C O          R$ '+enche(strtovalor(2,floattostr((val-tot))),' ',1,16);
                 strpcopy(cmd,comando);
                 enviacomando(porta,cmd);
                 _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
                 _nfepson.writeString('FINALIZADORAS', 'valor_recebido', '0');
                 _nfepson.writeString('FINALIZADORAS', 'valor_total', '0');
                 _nfepson.Free;
              end
           else
              begin
                 _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
                 _nfepson.writeString('FINALIZADORAS', 'valor_recebido', floattostr(val));
                 _nfepson.Free;
              end;
        end
     else
        begin
           comando:='T O T A L          R$ '+enche(valor,' ',1,16);
           strpcopy(cmd,comando);
           enviacomando(porta,cmd);

           _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
           _nfepson.writeString('FINALIZADORAS', 'valor_total', valor);
           _nfepson.writeString('FINALIZADORAS', 'valor_recebido', '0');
           _nfepson.Free;

           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' '+retorno);
        end;
end;

function LeituraX(tipo,porta:integer;NF:string):shortstring;
var _nfepson:TInifile;
    L1,L2,L3,L4,L5:STRING;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  NF   -> 0=Imprime somente Leitura X
          1=Imprime leitura x e espera texto não fiscal
=========================================================}
     func:='Leitura X';

     If nf='1' then
        begin
          _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
          l1:=_nfepson.readString('CLICHE', 'L1', '');
          l2:=_nfepson.readString('CLICHE', 'L2', '');
          l3:=_nfepson.readString('CLICHE', 'L3', '');
          l4:=_nfepson.readString('CLICHE', 'L4', '');
          l5:=_nfepson.readString('CLICHE', 'L5', '');
          _nfepson.Free;

          comando:=L1;
          strpcopy(cmd,comando);
          enviacomando(porta,cmd);

          comando:=L2;
          strpcopy(cmd,comando);
          enviacomando(porta,cmd);

          comando:=L3;
          strpcopy(cmd,comando);
          enviacomando(porta,cmd);

          comando:=L4;
          strpcopy(cmd,comando);
          enviacomando(porta,cmd);

          comando:=L5;
          strpcopy(cmd,comando);
          enviacomando(porta,cmd);
        end;
     retorno:='.+';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
end;

function Venda_liquida(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     func:='Venda Liquida';
     retorno:='.+';
     result:=Prepara_Resp(tipo,retorno,'000000000000','');
     log(func+' '+retorno);
end;

function COO(tipo,porta:integer;tipo_coo:string):shortstring;
var _nfepson:TIniFile;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  tipo_coo -> 0 = ultimo emitido
              1 = atual
=========================================================}
     func:='COO';

     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     if tipo_coo='1' then v_coo:=_nfepson.readstring('IMPRESSORA','COO','0001') else v_coo:=_nfepson.readString('IMPRESSORA', 'COOANT', '0001');
     _nfepson.Free;

     retorno:='.+'+v_coo;
     result:=Prepara_Resp(tipo,retorno,v_coo,'');
     log(func+' '+retorno);
end;

function Sangria(tipo,porta:integer;modal,valor:string):shortstring;
VAR _nfepson:TIniFile;
    L1,L2,L3,L4,L5:STRING;
    desc:string;
    RMpar:Tinifile;
    vpdvnum:string;

begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  modal -> Código da modalidade de pagamento.
  valor -> Valor da Sangria.
=========================================================}
     func:='Sangria';
     valor:=strtovalor(2,trim(valor));
     modal:=enche(modal,'0',1,2);

     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     l1:=_nfepson.readString('CLICHE', 'L1', '');
     l2:=_nfepson.readString('CLICHE', 'L2', '');
     l3:=_nfepson.readString('CLICHE', 'L3', '');
     l4:=_nfepson.readString('CLICHE', 'L4', '');
     l5:=_nfepson.readString('CLICHE', 'L5', '');
     _nfepson.Free;

     comando:=L1;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L2;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L3;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L4;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L5;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);


     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     desc:=_nfepson.readString('FINALIZADORAS', modal, modal);
     _nfepson.Free;


     comando:='========================================';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='             SANGRIA                   ';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);


     comando:=enche(desc,' ',2,20)+'R$ '+enche(valor,' ',1,16);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='========================================';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     v_coo:=_nfepson.readString('IMPRESSORA', 'COO', '0001');
     _nfepson.Free;

     RMPAR:=TIniFile.Create(extractfilepath(application.exename)+'dados\autocom.INI');
     vpdvnum:=RMPAR.ReadString('TERMINAL', 'PDVNum', '000');     // Número do PDV
     RMPAR.Free;

     comando:=datetostr(date)+' '+timetostr(time)+' COO:'+V_coo+' Pdv:'+vpdvnum;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='************* Autocom PLUS *************';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
     espera_ecf(strtoint(v_coo));
end;

function FCX(tipo,porta:integer;modal,valor:string):shortstring;
var _nfepson:TInifile;
    L1,L2,L3,L4,L5:STRING;
    desc:string;
    RMpar:Tinifile;
    vpdvnum:string;

begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  modal -> Código da modalidade de pagamento.
  valor -> Valor do fundo de caixa.
=========================================================}
     func:='Fundo de Caixa';
     valor:=strtovalor(2,trim(valor));
     modal:=enche(modal,'0',1,2);


     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     l1:=_nfepson.readString('CLICHE', 'L1', '');
     l2:=_nfepson.readString('CLICHE', 'L2', '');
     l3:=_nfepson.readString('CLICHE', 'L3', '');
     l4:=_nfepson.readString('CLICHE', 'L4', '');
     l5:=_nfepson.readString('CLICHE', 'L5', '');
     _nfepson.Free;

     comando:=L1;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L2;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L3;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L4;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L5;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);


     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     desc:=_nfepson.readString('FINALIZADORAS', modal, modal);
     _nfepson.Free;

     comando:='========================================';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='       FUNDO DE CAIXA                   ';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);


     comando:=enche(desc,' ',2,20)+'R$ '+enche(valor,' ',1,16);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='========================================';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     v_coo:=_nfepson.readString('IMPRESSORA', 'COO', '0001');
     _nfepson.Free;

     RMPAR:=TIniFile.Create(extractfilepath(application.exename)+'dados\autocom.INI');
     vpdvnum:=RMPAR.ReadString('TERMINAL', 'PDVNum', '000');     // Número do PDV
     RMPAR.Free;

     comando:=datetostr(date)+' '+timetostr(time)+' COO:'+V_coo+' Pdv:'+vpdvnum;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='************* Autocom PLUS *************';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
     espera_ecf(strtoint(v_coo));
end;


function Cheque(tipo,porta:integer;banco,valor,data,favorecido,municipio,cifra,moedas,moedap:string):shortstring;
var obs:string;
    dia,mes,ano:word;
    modelo: array [1..10] of integer; //modelos que tem impressão de cheques
    ok:boolean;
    a:integer;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  banco -> Número do Banco
  valor -> Valor do cheque
  data  -> Data do cheque
  favorecido -> Favorecido do cheque. depois do pipe |, vem a observacao para o cheque;
  municipio  -> municipio do cheque
  cifra  -> Cifra di cheque
  moedas -> nome da moeda no singular
  moedap -> nome da meoda no plural
=========================================================}
     RETORNO:='.+';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
end;

function Contra_vale(tipo,porta:integer;valor:string):shortstring;
var texto:string;
   _nfepson:TInifile;
    L1,L2,L3,L4,L5:STRING;
    desc:string;
   RMpar:Tinifile;
    vpdvnum:string;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  valor -> Valor do contra-vale até o pipe |, depois do pipe, é a descrição da forma de pagamento .
=========================================================}
     func:='Contra-vale';

     texto:=copy(valor,pos('|',valor)+1,16);
     valor:=copy(valor,1,pos('|',valor)-1);
     texto:=enche(texto,' ',2,16);
     texto:=copy(texto,1,1)+LowerCase(copy(texto,2,16));

     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     l1:=_nfepson.readString('CLICHE', 'L1', '');
     l2:=_nfepson.readString('CLICHE', 'L2', '');
     l3:=_nfepson.readString('CLICHE', 'L3', '');
     l4:=_nfepson.readString('CLICHE', 'L4', '');
     l5:=_nfepson.readString('CLICHE', 'L5', '');
     desc:=_nfepson.readString('Contravale', 'texto', '');
     _nfepson.Free;

     comando:=L1;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L2;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L3;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L4;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=L5;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='========================================';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='              CONTRA VALE               ';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=TEXTO+': '+STRTOVALOR(2,valor);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=desc;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='========================================';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     _nfepson:=TIniFile.Create(extractfilepath(application.exename)+'_nfepson.ini');
     v_coo:=_nfepson.readString('IMPRESSORA', 'COO', '0001');
     _nfepson.Free;

     RMPAR:=TIniFile.Create(extractfilepath(application.exename)+'dados\autocom.INI');
     vpdvnum:=RMPAR.ReadString('TERMINAL', 'PDVNum', '000');     // Número do PDV
     RMPAR.Free;

     comando:=datetostr(date)+' '+timetostr(time)+' COO:'+V_coo+' Pdv:'+vpdvnum;
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='************* Autocom PLUS *************';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     comando:=CHR(10);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     result:=Prepara_Resp(tipo,retorno,'','');
     espera_ecf(strtoint(v_coo));
end;

function cnfv(tipo,porta:integer) : shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     func:='Abertura de CNFV';
     comando:='========================================';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='         COMPROVANTE TEF                ';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     comando:='========================================';
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
     espera_ecf(porta);
end;


function ECF_INFO(tipo,porta:integer):shortstring;
var c,d,e,f,g,h,i,j,k,l,m,n:string;
    fu,uff:integer;
    RMPAR:Tinifile;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     func:='ECF INFO';
     c:='0001';
     d:='0';
     e:='1';
     f:='1';
     if tipo=3 then // impressora nf paralela
        begin
           try
              RMPAR:=TIniFile.Create(extractfilepath(application.exename)+'dados\AUTOCOM.INI');
              v_serial:=strtoint(RMPAR.ReadString('TERMINAL', 'COMGAVETA', '4')); // porta serial da gaveta
              RMPAR.Free;

              DriverGaveta (v_serial, 1); // inicializa da gaveta serial
              for uff:=0 to 100 do
                 begin
                    FU:=DriverGaveta (v_serial, 3); // verifica estado da gaveta serial
                    IF FU = 2 then g:='0' else g:='1'; // 0=aberta   1= fechada (Menno é 0 aberta  e 1 é fechada)
                    if g='0' then break;
                 end;
           except
              g:='0';
           end;
        end
     else g:='0';

     h:='0';
     i:='000000';
     j:='999999';
     k:='9999';
     l:='000000000000';
     m:='999999999999';
     n:='NS1234567890.';

     retorno:='.+';
     result:=Prepara_Resp(tipo,retorno,c+d+e+f+g+h+i+j+k+l+m+n,'');
     log(func+' '+retorno+' ->'+c+d+e+f+g+h+i+j+k+l+m+n);
    // byte 1: os 4 primeiros são o número do ECF
    // byte 5: é a situação do dia: 0 - Dia aberto
    //                              1 - Abrir o dia
    //                              2 - Dia encerrado
    //                              3 - Encerrar o dia
    // byte 6: é o status de papel presente (bobina) - 0=não tem   1=tem
    // byte 7: é o status documento presente (cheque e autenticação)
    // byte 8: é o status de gaveta aberta (0=não 1=sim)
    // byte 9: é o status de cupom aberto (0=não 1=sim)
end;

function LMFD(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     func:='LEITURA DA MEMÓRIA FISCAL POR DATA';

     RETORNO:='.+';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
end;

function LMFR(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     func:='LEITURA DA MEMÓRIA FISCAL POR REDUÇÃO';

     RETORNO:='.+';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
end;

function LMMM(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}

// Nesta função será executada a aplicação do fabricante para
// realizar a captura da memória fiscal por meio magnético
// (disquete). Esse aplicativo vai mudar de acordo com cada
// ECF, pois cada fabricante tem o seu.
     func:='LEITURA DA MEMÓRIA FISCAL POR MEIO Magnético';
     retorno:='.+';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' '+retorno);
end;


// funções exportadas.
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
    CNFV INDEX 28;
end.
