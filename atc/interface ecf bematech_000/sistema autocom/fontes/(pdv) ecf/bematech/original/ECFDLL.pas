unit ECFDLL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, stdctrls,Inifiles;

const
   ECFBEMATECH='Mp20fi32.dll';

type
  TForm1 = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;
///////////////////////////////////////////////////////////////////////////////////////////////////////////
//       Declarações de funções externas (DLLs                                                           //
//                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////

// Mp20fi32.dll -> Bematech
  TIniPortaStr=function (Porta: PChar):integer; stdcall;
  TFormataTX=function (BUFFER: PChar):integer; stdcall;
  TFechaPorta=function : integer; stdcall;
  TStatus_Mp20FI=function (var Ret:integer;var ACK:integer;var ST1:integer;var ST2:Integer):integer; stdcall;
  TLe_Variaveis=function (Retorno_var:string):integer; stdcall;


var
  Form1: TForm1;
  func,comando:string;
  retorno:string;
  CMD:array [0..512] of char;
  handle:Thandle;
  _ini:TIniFile;
  ignora_resposta:string; // esta variável tem a finalidade de controlar a espera de uma
                           // resposta do ecf antes de mandar outro comando

// bematech
  IniPortaStr:TIniPortaStr;
  FormataTX:TFormataTX;
  FechaPorta:TFechaPorta;
  Status_Mp20FI:TStatus_Mp20FI;
  Le_Variaveis:TLe_Variaveis;


implementation

{$R *.DFM}


procedure Enviacomando(p:integer;Comand:Pchar);
var
   funcdll: array [1..4] of integer;  // armazena o status da função.
   Ret: integer;   //Variavel que pega retorno da Função
   ACK: integer;   //Variavel que pega o ACK
   ST1: integer;   //Variavel que pega o ST1
   ST2: integer;   //Variavel que pega o ST2
   Retorno_var:string; //Variavel que Guarda o Retorno de Info
begin
     funcdll[1]:=1;funcdll[2]:=1;funcdll[3]:=1;

     Handle := LoadLibrary(ECFBematech);
     if Handle <> 0 then
        begin
           @IniPortaStr := GetProcAddress(Handle, 'IniPortaStr');
           @FormataTX:= GetProcAddress(Handle, 'FormataTX');
           @FechaPorta:= GetProcAddress(Handle, 'FechaPorta');
           @Status_Mp20FI:= GetProcAddress(Handle, 'Status_Mp20FI');
           @Le_Variaveis:= getProcAddress(Handle, 'Le_Variaveis');

           try
              funcdll[1]:=IniPortaStr(Pchar('COM'+inttostr(p))); // tenta abrir a porta serial.
           except
              retorno:='.-P002'; // caso não consiga, será retornado erro e sairá da função
              FreeLibrary(Handle);
              exit;
           end;

           if funcdll[1]=1 then // 1 significa que q a porta foi iniciada com sucesso
              begin
                 try
                    funcdll[2]:=FormataTX(comand);   // Envia o comando para o ECF
                 except
                    retorno:='.-P002'; // caso não consiga, será retornado erro e sairá da função
                    FreeLibrary(Handle);
                    exit;
                 end;
              end;

           Ret:=0;ACK:=0;ST1:=0;ST2:=0;
           for ACK:=0 to 3000 do  Retorno_var:=Retorno_var+' ';

           if funcdll[2]=0 then
              begin
                 try
                    Status_Mp20FI(Ret,ACK,ST1,ST2);      // Lê o retorno do ECF
                 except
                    retorno:='.-P002'; // caso não consiga, será retornado erro e sairá da função
                    FreeLibrary(Handle);
                    exit;
                 end;
              end;

           if (funcdll[2]=0) then
              begin
                 if ignora_resposta='0' then
                    begin
                       try
                          Le_Variaveis(Retorno_var);      // Lê o retorno do ECF
                       except
                          retorno:='.-P002'; // caso não consiga, será retornado erro e sairá da função
                          FreeLibrary(Handle);
                          exit;
                       end;

                       retorno:='.+'+trim(Retorno_var);

                       if ST1>0 then
                          begin
                          //Tratamento do ST1
                             if (ST1>=128) then retorno:='.-ST1:128-Fim de papel';
                             if (ST1>=64)  and (ST1<=127) then retorno:='.-ST1:64-Pouco papel';
                             if (ST1>=32)  and (ST1<=63) then retorno:='.-ST1:32-Erro no Relógio';
                             if (ST1>=16)  and (ST1<=31) then retorno:='.-ST1:16-Impressora em erro';
                             if (ST1>=8)   and (ST1<=15) then retorno:='.-ST1:8-Primeiro dado não foi ESC';
                             if (ST1>=4)   and (ST1<=7) then retorno:='.-ST1:4-CMD inexistente';
                             if (ST1>=2)   and (ST1<=3) then retorno:='.-ST1:2-Cupom Aberto';
                             if (ST1=1) then retorno:='.-ST1:1-Número CMD inválido';

                             if st2>0 then retorno:=retorno+chr(13);
                          end;

                       if st2>0 then
                          begin
                          //Tratamento do ST2
                             if st1=0 then retorno:='';
                             if (ST2>=128) then retorno:='.-ST2:128-Tipo parâmetro inválido';
                             if (ST2>=64)  and (ST2<=127) then retorno:=retorno+'.-ST2:64-Memória fiscal lotada';
                             if (ST2>=32)  and (ST2<=63) then retorno:=retorno+'.-ST2:32-Erro na RAM';
                             if (ST2>=16)  and (ST2<=31) then retorno:=retorno+'.-ST2:16-Alíquota não programada';
                             if (ST2>=8)   and (ST2<=15) then retorno:=retorno+'.-ST2:8-Capacidade de aliquotas lotada';
                             if (ST2>=4)   and (ST2<=7) then retorno:=retorno+'.-ST2:4-Cancelamento não permitido';
                             if (ST2>=2)   and (ST2<=3) then retorno:=retorno+'.-ST2:2-CGC/IE não programado';
                             if (ST2=1) then retorno:=retorno+'.-ST2:1-Comando não executado';
                          end;
                    end
                 else retorno:='.+0';
              end;


           if funcdll[1]=1 then FechaPorta;// fecha a porta serial.
        end;
     FreeLibrary(Handle);
end;


procedure espera_ecf(p:integer);
//var i:Tdatetime;
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

     _bancos:=TIniFile.Create(extractfilepath(application.exename)+'dados\_bematechbancos.ini');
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

procedure Log(texto:string); // monta o log de comandos e retornos.
var LOGfile:textfile;
begin
// A função LOG cria um log (em TXT) no mesmo diretório da DLL
// com os comando enviados para o ECF e os devidos retornos.
// Isso facilita a deporação de algum eventual BUG no sistema. (tomara q isso não ocorra, mas... ^_^ )

     AssignFile(LOGfile,extractfilepath(application.exename)+'_BEMATECH.LOG');
     if not fileexists(extractfilepath(application.exename)+'_BEMATECH.LOG') then Rewrite(logfile) else Reset(Logfile);
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
     texto:='#ECF BEMATECH'+chr(13)+' ERRO: '+texto;
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
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  cod  -> Código do operador
  fazoq -> 0 = Saida
           1 = Entrada
=========================================================}
     ignora_resposta:='0';
// No ECF Bematech não tem comando para controle de troca de operador.
     func:='Troca de operador';
     comando:='<Comando_de_troca_de_operador>';
     strpcopy(cmd,comando);
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
  porta-> porta de comunicação
=========================================================}
     ignora_resposta:='0';
     func:='Abertura de cupom';
     comando:=chr(27)+'|00|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);
end;

function AbreGaveta(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     ignora_resposta:='0';
     func:='Abertura de Gaveta';
     comando:=chr(27)+'|22|255|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);
end;

function AcreSub(tipo,porta:integer;val,tipacre:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  val -> valor do acrescimo
  tipoacre-> tipo de acrescimo.
=========================================================}
     ignora_resposta:='0';
     func:='Acrescimo no subtotal';

     val:=strtovalor(2,val);
     while pos(',',val)>0 do delete(val,pos(',',val),1);
     while pos('.',val)>0 do delete(val,pos('.',val),1);

     comando:=chr(27)+'|32|a|'+val+'|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);
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
// Ainda não esté implementado.
     ignora_resposta:='0';
     func:='Autenticacao';
     comando:='Comando_de_autenticacao';
     strpcopy(cmd,comando);
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
  porta -> porta de comunicação
  Venda -> não usado
  Valor -> não usado
=========================================================}
     ignora_resposta:='0';
     func:='Cancela Cupom';
     comando:=chr(27)+'|14|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);
end;

function CancItem(tipo,porta:integer;cod,nome,prtot,trib,ind:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunicação
  cod   -> não usado
  nome  -> não usado
  prtot -> não usado
  trib  -> não usado
  ind   -> posição do produto no cupom fiscal
=========================================================}
     ignora_resposta:='0';
     func:='Cancelamento de item';

     comando:=chr(27)+'|31|'+enche(ind,'0',1,4)+'|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);
end;

function Descitem(tipo,porta:integer; val:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunicação
  val   -> Valor do desconto.
=========================================================}
//Não é usado desconto no item na Bematech
     ignora_resposta:='0';
     func:='Desconto no item';

     val:=strtovalor(2,val);
     while pos(',',val)>0 do delete(val,pos(',',val),1);
     while pos('.',val)>0 do delete(val,pos('.',val),1);

     comando:='Comando_de_desconto_no_item';
     strpcopy(cmd,comando);
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
  porta -> porta de comunicação
  val   -> Valor do desconto
=========================================================}
     ignora_resposta:='0';
     func:='Desconto no subtotal';

     val:=strtovalor(2,val);
     while pos(',',val)>0 do delete(val,pos(',',val),1);
     while pos('.',val)>0 do delete(val,pos('.',val),1);


     comando:=chr(27)+'|32|d|'+val+'|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);


     espera_ecf(porta);
end;

function FecharCupom(tipo,porta:integer; SegCp,CNFV,l1,l2,l3,l4,l5,l6,l7,l8:string):shortstring;
var teste:string;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  SegCP  -> não usado
  CNFV   -> não usado
  l1..l8 -> Linhas de mensagens de cortesia.
=========================================================}
     ignora_resposta:='0';
     func:='Fechamento de Cupom';
     _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
     teste:=_ini.readString('controle','indicador', '');
     _ini.Free;

     if teste<>'' then
        begin
           l8:=l7;
           l7:=l6;
           l6:=l5;
           l5:=l4;
           l4:=l3;
           l3:=l2;
           l2:=l1;
           l1:=teste;
        end;
     teste:=' |';
     if l8<>'' then teste:=l8+'|'+chr(13)+chr(10);
     if l7<>'' then teste:=l7+'|'+chr(13)+chr(10)+teste;
     if l6<>'' then teste:=l6+'|'+chr(13)+chr(10)+teste;
     if l5<>'' then teste:=l5+'|'+chr(13)+chr(10)+teste;
     if l4<>'' then teste:=l4+'|'+chr(13)+chr(10)+teste;
     if l3<>'' then teste:=l3+'|'+chr(13)+chr(10)+teste;
     if l2<>'' then teste:=l2+'|'+chr(13)+chr(10)+teste;
     if l1<>'' then teste:=l1+'|'+chr(13)+chr(10)+teste;
     comando:=chr(27)+'|34|'+teste+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     if pos('.-ST',retorno)>0 then // se retornar erro, significa que pode ser relatório gerencial ou um comprovante não-fiscal vinculado
        begin
           _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
           _ini.writeString('controle','ignora_resposta', '0');
           _ini.Free;

           comando:=chr(27)+'|21|'+chr(27);
           strpcopy(cmd,comando);
           log(func+' - Enviado (BEMATECH):'+comando);
           enviacomando(porta,cmd);
        end;
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);

     comando:=chr(27)+'|34|'+teste+chr(27);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
     _ini.writeString('Contadores', 'gt_final', copy(retorno,228,12));
     if _ini.readString('Contadores', 'gt_incial', '')='' then
        begin
           _ini.writeString('Contadores', 'gt_inicial', copy(retorno,228,12));
        end;
     _ini.Free;


     _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
     _ini.writeString('controle','indicador', '');
     _ini.Free;

end;

function Finalizadia(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo     -> tipo de ECF
  porta    -> porta de comunicação
=========================================================}
     ignora_resposta:='0';
     func:='Reducao Z';
     comando:=chr(27)+'|05|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);
end;

function InicioDia(tipo,porta:integer; verao,op,modal:string):shortstring;
var
   m:array [1..10] of string;
   a:integer;
   teste:string;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  verao  -> 0=Não está no horário de verão
            1=Está no horário de verão
  op     -> não usado
  modal  -> modalidades de pagameto para serem programadas, divididas por pipe. São no máximo 10
=========================================================}
     ignora_resposta:='0';
     func:='Inicio do dia - HV';

     comando:=chr(27)+'|35|17|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     log(func+' - Recebido (BEMATECH):'+retorno);
     teste:=copy(retorno,3,1);

     if ((verao='0') and (teste<>'0')) or ((verao='1') and (teste='0')) then
        begin
           comando:=chr(27)+'|18|'+chr(27);
           strpcopy(cmd,comando);
           log(func+' - Enviado (BEMATECH):'+comando);
           enviacomando(porta,cmd);
           log(func+' - Recebido (BEMATECH):'+retorno);
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

     for a:=1 to 10 do
        begin
           if length(m[a])>0 then
              begin
                 func:='Inicio do dia - Programa finalizadoras';
                 comando:=chr(27)+'|71|'+m[a]+'|'+chr(27);
                 strpcopy(cmd,comando);
                 log(func+' - Enviado (BEMATECH):'+comando);
                 enviacomando(porta,cmd);
                 log(func+' - Recebido (BEMATECH):'+retorno);

                 _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
                 _ini.writeString('Finalizadoras', 'm'+inttostr(a), m[a]);
                 _ini.Free;
              end;
        end;

     func:='Inicio do dia - Leitura X';
     comando:=chr(27)+'|06|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
     _ini.writeString('Contadores', 'gt_final', '');
     _ini.writeString('Contadores', 'gt_inicial', '');
     _ini.writeString('Contadores', 'coo_final', '');
     _ini.writeString('Contadores', 'coo_inicial', '');
     _ini.Free;
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
  prtot  -> não usado
  trib   -> tributação do produto
=========================================================}
     ignora_resposta:='0';
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


     if d='2' then comando:=chr(27)+'|09|'+cod+'|'+nome+'|'+trib+'|'+qtde+'|'+prunit+'|'+'0000|'+chr(27);
     if d='3' then comando:=chr(27)+'|56|'+cod+'|'+nome+'|'+trib+'|'+qtde+'|'+prunit+'|'+'0000|'+chr(27);

     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
end;

function Notadecupom(tipo,porta:integer; ind,texto:string;abc:boolean):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  ind    -> indicador a ser impresso no cupom
  texto  -> texto a ser impresso no cupom
=========================================================}
     ignora_resposta:='0';
     func:='Nota de Cupom';

     if abc=true then
        begin
           comando:=chr(27)+'|00|'+chr(27);
           strpcopy(cmd,comando);
           log(func+' - Enviado (BEMATECH):'+comando);
           enviacomando(porta,cmd);
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
        end;

     comando:='<Comando_de_nota_de_cupom>';
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);

     retorno:='.=';

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
     _ini.writeString('controle','indicador', texto);
     _ini.Free;

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);
end;

function TextoNF(tipo,porta:integer;texto,valor:string):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  texto  -> Texto a ser impresso.
  valor  -> <>''.: é comprovante não fiscal vinculado
=========================================================}
try
     func:='Texto nao fiscal';
     _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
     ignora_resposta:=_ini.readstring('controle','ignora_resposta','0');
     _ini.Free;
     if strtoint(ignora_resposta)>5 then ignora_resposta:='0' else ignora_resposta:=inttostr(strtoint(ignora_resposta)+1);// vai fazer com que a dll nao espere a resposta do ECF
     _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
     _ini.writeString('controle','ignora_resposta', ignora_resposta);
     _ini.Free;
     try
        if strtoint(valor)>0 then valor:='1' else valor:='0';
     except
        valor:='0' ;
     end;

     if valor='1' then
        begin
           comando:=chr(27)+'|67|'+texto+chr(10)+chr(13)+'|'+chr(27);
           strpcopy(cmd,comando);
           enviacomando(porta,cmd);
        end
     else
//     if copy(retorno,1,2)='.-' then
        begin
           comando:=chr(27)+'|20|'+texto+chr(10)+chr(13)+'|'+chr(27); //relatorio gerencial
           strpcopy(cmd,comando);
           enviacomando(porta,cmd);
        end;

     log(func+' - Enviado (BEMATECH):'+comando);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);
except
      on e:exception do
         begin
            showmessage(e.message);
         end;
end;
end;

function Totalizacupom(tipo,porta:integer;Moda,valor:string):shortstring;
var mod_str:string;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  Moda   -> Código da modalidade de pagamento
  valor  -> Valor recebido da modalidade de pagamento
=========================================================}
     ignora_resposta:='0';
     func:='Totaliza Cupom';
     moda:=enche(moda,'0',1,2);

     valor:=strtovalor(2,valor);
     while pos(',',valor)>0 do delete(valor,pos(',',valor),1);
     while pos('.',valor)>0 do delete(valor,pos('.',valor),1);

     if length(valor)<14 then valor:=enche(valor,'0',1,14) else valor:=copy(valor,1,14);

     if moda<>'00' then
        begin
           comando:=chr(27)+'|72|'+moda+'|'+valor+'|'+chr(27);
           strpcopy(cmd,comando);
           log(func+' - Enviado (BEMATECH):'+comando);
           enviacomando(porta,cmd);
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);

           _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
           mod_str:=_ini.readstring('Finalizadoras','m'+inttostr(strtoint(moda)),'');
           _ini.writeString('TEF', 'molidade', mod_str);
           _ini.Free;
        end
     else
        begin
           comando:=chr(27)+'|32|D|0000|'+chr(27);
           strpcopy(cmd,comando);
           log(func+' - Enviado (BEMATECH):'+comando);
           enviacomando(porta,cmd);
           if pos('.-ST2:1',retorno)>0 then
              begin
                 if pos('.-ST1',retorno)<=0 then retorno:='.+';
              end;
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
           espera_ecf(porta);
        end;
end;

function LeituraX(tipo,porta:integer;NF:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  NF   -> 0=Imprime somente Leitura X
          1=Imprime leitura x e espera texto não fiscal
=========================================================}
     ignora_resposta:='0';
     func:='Leitura X';
     if nf='0' then
        begin
           comando:=chr(27)+'|06|'+chr(27);
           strpcopy(cmd,comando);
           log(func+' - Enviado (BEMATECH):'+comando);
           enviacomando(porta,cmd);
        end
     else
        begin
           log(func+' - Enviado (BEMATECH): Relatorio Gerencial');
           retorno:='.+';
           _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
           _ini.writeString('controle','ignora_resposta', '0');
           _ini.Free;

        end;
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);
end;

function Venda_liquida(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     ignora_resposta:='0';
     func:='Venda Liquida';
     comando:=chr(27)+'|29|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,copy(retorno,5,12),'');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);
end;

function COO(tipo,porta:integer;tipo_coo:string):shortstring;
var c:string;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  tipo_coo -> 0 = ultimo emitido
              1 = atual
=========================================================}
     ignora_resposta:='0';
     func:='COO';
     comando:=chr(27)+'|30|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
//     if tipo_coo='1' then c:=inttostr(strtoint(c)+1);
//     result:=Prepara_Resp(tipo,retorno,c,'');
     if Copy(retorno,1,2)='.-' then
        begin
           _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
           _ini.readString('Contadores', 'coo_final', c);
           if _ini.readString('Contadores', 'coo_finnal', '')='' then
              begin
                 _ini.writeString('Contadores', 'coo_inicial', c);
              end;
           _ini.Free;
           if c='' then c:='0';
        end
     else
        begin
           c:=copy(retorno,3,6);
        end;

     result:=Prepara_Resp(tipo,'.+',c,'');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
     _ini.writeString('Contadores', 'coo_final', c);
     if _ini.readString('Contadores', 'coo_inicial', '')='' then
        begin
           _ini.writeString('Contadores', 'coo_inicial', c);
        end;
     _ini.Free;
end;

function Sangria(tipo,porta:integer;modal,valor:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  modal -> Código da modalidade de pagamento.
  valor -> Valor da Sangria.
=========================================================}
     ignora_resposta:='0';
     func:='Sangria';
     valor:=strtovalor(2,trim(valor));
     while pos(',',valor)>0 do delete(valor,pos(',',valor),1);
     while pos('.',valor)>0 do delete(valor,pos('.',valor),1);
     if length(valor)<14 then valor:=enche(valor,'0',1,14) else valor:=copy(valor,1,14);

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
     modal:=_ini.readString('Finalizadoras', 'm'+inttostr(strtoint(modal)),'');
     _ini.Free;

     comando:=chr(27)+'|25|SA|'+valor+'|'+modal+'|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);
end;

function FCX(tipo,porta:integer;modal,valor:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  modal -> Código da modalidade de pagamento.
  valor -> Valor do fundo de caixa.
=========================================================}
     ignora_resposta:='0';
     func:='Fundo de Caixa';
     valor:=strtovalor(2,trim(valor));
     while pos(',',valor)>0 do delete(valor,pos(',',valor),1);
     while pos('.',valor)>0 do delete(valor,pos('.',valor),1);
     if length(valor)<14 then valor:=enche(valor,'0',1,14) else valor:=copy(valor,1,14);

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
     modal:=_ini.readString('Finalizadoras', 'm'+inttostr(strtoint(modal)),'');
     _ini.Free;

     comando:=chr(27)+'|25|SU|'+valor+'|'+modal+'|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
     espera_ecf(porta);
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

     ignora_resposta:='0';

     for a:=1 to 10 do modelo[a]:=0;

     modelo[1]:=31; {tipo para a NCR 31 -> 'Bematech - MP-40 FI II'}

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

           decodedate(strtodate(data),ano,mes,dia);
           data:=enche(inttostr(dia),'0',1,2);
           if mes=01 then data:=data+'|JANEIRO   |';
           if mes=02 then data:=data+'|FEVEREIRO |';
           if mes=03 then data:=data+'|MARCO     |';
           if mes=04 then data:=data+'|ABRIL     |';
           if mes=05 then data:=data+'|MAIO      |';
           if mes=06 then data:=data+'|JUNHO     |';
           if mes=07 then data:=data+'|JULHO     |';
           if mes=08 then data:=data+'|AGOSTO    |';
           if mes=09 then data:=data+'|SETEMBRO  |';
           if mes=10 then data:=data+'|OUTUBRO   |';
           if mes=11 then data:=data+'|NOVEMBRO  |';
           if mes=12 then data:=data+'|DEZEMBRO  |';
           if length(inttostr(ano))=4 then data:=data+inttostr(ano);
           if length(inttostr(ano))=2 then
              begin
                 if (ano>=0)  and (ano<=30) then data:=DATA+'|20'+inttostr(ano);
                 if (ano>=31) and (ano<=99) then data:=DATA+'|19'+inttostr(ano);
              end;

           comando:=chr(27)+'|57|'+valor+'|'+favorecido+'|'+municipio+'|'+data+carrega_ini_bancos(trim(banco))+enche(obs,' ',1,120)+'|'+chr(27);
           strpcopy(cmd,comando);
           log(func+' - Enviado (BEMATECH):'+comando);
           enviacomando(porta,cmd);
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (BEMATECH):'+retorno);
        end
     else
        begin
           retorno:='.+';
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Executado:'+retorno);
        end;
end;

function Contra_vale(tipo,porta:integer;valor:string):shortstring;
var texto:string;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  valor -> Valor do contra-vale até o pipe |, depois do pipe, é a descrição da forma de pagamento .
=========================================================}
     ignora_resposta:='0';
     func:='Contra-vale';

     texto:=copy(valor,pos('|',valor)+1,16);
     valor:=copy(valor,1,pos('|',valor)-1);
     texto:=enche(texto,' ',2,16);
     texto:=copy(texto,1,1)+LowerCase(copy(texto,2,16));

     comando:=Chr(27)+'|66|'+texto+'|'+Chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     log(func+' - Recebido (BEMATECH):'+retorno);

     comando:=Chr(27)+'|67|Contra - vale: '+strtovalor(2,valor)+'|'+Chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     log(func+' - Recebido (BEMATECH):'+retorno);

     comando:=chr(27)+'|21|'+chr(27); // fechar o cupom
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     log(func+' - Recebido (BEMATECH):'+retorno);


     result:=Prepara_Resp(tipo,retorno,'','');
     espera_ecf(porta);
end;

function cnfv(tipo,porta:integer) : shortstring;
var mod_str:string;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     ignora_resposta:='0';
     func:='Abertura de CNFV';

     _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
     mod_str:=_ini.readString('TEF', 'molidade', '');
     _ini.Free;

     comando:=chr(27)+'|66|'+mod_str+'|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     log(func+' - Recebido (NCR):'+retorno);
     result:=Prepara_Resp(tipo,retorno,'','');
     espera_ecf(porta);
end;

function ECF_INFO(tipo,porta:integer):shortstring;
var c,d,e,f,g,h,i,j,k,l,m,n:string;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
//try
     ignora_resposta:='0';
     _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
     _ini.writeString('controle','ignora_resposta', '0');
     _ini.Free;

     func:='ECF INFO';
     comando:=chr(27)+'|35|14|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     c:=copy(retorno,3,4);

     comando:=chr(27)+'|35|27|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     d:=copy(retorno,3,6);
     comando:=chr(27)+'|35|26|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     e:=copy(retorno,3,6);
     comando:=chr(27)+'|35|23|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     f:=copy(retorno,3,6);
     comando:=chr(27)+'|62|55|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     g:=copy(retorno,585,6);

     e:=copy(e,1,2)+'/'+copy(e,3,2)+'/'+copy(e,5,2);
     f:=copy(f,1,2)+'/'+copy(f,3,2)+'/'+copy(f,5,2);
     g:=copy(g,1,2)+'/'+copy(g,3,2)+'/'+copy(g,5,2);

     if d='000000'  then
        begin
           try
              if strtodate(e)<strtodate(f) then d:='1';// se a data da ultima reducao for menor que a data da impressora

              if strtodate(e)=strtodate(f) then // se a data da ultima reducao for IGUAL a data da impressora
                 begin
                    if strtodate(g)<strtodate(f) then // se a data do ultimo movimento for menor que a data da impressora
                       begin
                          d:='1';
                       end
                    else
                       begin
                          d:='2';
                       end;
                 end;
           except
              d:='1';
           end;
        end
     else
        begin
           d:='0';
        end;

     e:='1';
     f:='1';

     comando:=chr(27)+'|23|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     g:=copy(retorno,3,3);
     if g='000' then g:='1';
     if g='255' then g:='0';

     comando:=chr(27)+'|35|17|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);

     h:='0'; //por enquanto está fixo pq não tenho como testar.


     _ini:=TIniFile.Create(extractfilepath(application.exename)+'_bematech.ini');
     l:=_ini.readString('Contadores', 'gt_incial', '');
     m:=_ini.readString('Contadores', 'gt_final', '');
     i:=_ini.readString('Contadores', 'coo_incial', '');
     j:=_ini.readString('Contadores', 'coo_final', '');
     _ini.Free;
     l:=enche(l,'0',1,12);
     m:=enche(m,'0',1,12);
     i:=enche(i,'0',1,6);
     j:=enche(j,'0',1,6);

     k:='0000';

     comando:=chr(27)+'|35|00|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     n:=copy(retorno,3,15);

     result:=Prepara_Resp(tipo,retorno,c+d+e+f+g+h+i+j+k+l+m+n,'');
     log(func+' - Recebido (BEMATECH):'+retorno+' ->'+c+d+e+f+g+h+i+j+k+l+m+n);
    // byte 1: os 4 primeiros são o número do ECF
    // byte 5: é a situação do dia: 0 - Dia aberto
    //                              1 - Abrir o dia
    //                              2 - Dia encerrado
    //                              3 - Encerrar o dia
    // byte 6: é o status de papel presente (bobina) - 0=não tem   1=tem
    // byte 7: é o status documento presente (cheque e autenticação)
    // byte 8: é o status de gaveta aberta (0=não 1=sim)
    // byte 9: é o status de cupom fiscal aberto (0=não 1=sim)

     // byte 10: é o coo inicial (i)
     // byte 16: é o coo final  (j)
     // byte 22: é o numero de reducoes (k)
     // byte 26: é o gt inicial (l)
     // byte 38: é o gt final (m)
     // byte 50: é o ns do ecf (n)

//except
//   on e:exception do showmessage(e.message);
//end;

end;

function LMFD(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     ignora_resposta:='0';
     func:='LEITURA DA MEMÓRIA FISCAL POR DATA';
     comando:=chr(27)+'|08|'+inicio+'|'+fim+'|I|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
end;

function LMFR(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     ignora_resposta:='0';
     func:='LEITURA DA MEMÓRIA FISCAL POR REDUÇÃO';
     comando:=chr(27)+'|08|00|'+inicio+'|00|'+fim+'|I|'+chr(27);
     strpcopy(cmd,comando);
     log(func+' - Enviado (BEMATECH):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (BEMATECH):'+retorno);
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
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Executado (BEMATECH):');
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
    cnfv index 28;
end.
