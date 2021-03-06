unit ECFDLL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,Inifiles;

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
  CMD:array [0..512] of char;


implementation

{$R *.DFM}

procedure Enviacomando(p:integer;Comand:Pchar);
begin
// A fun??o Enviacomando ? a respons?vel por enviar os comandos
// para o ECF (de acordo com cada DLL do fabricante do ECF) e capturar
// a resposta do ECF (tbm de acordo com cada DLL do fabricante de ECF),
// armazenando essa resposta da veri?vel RETORNO.
     retorno:='.+';
end;

procedure espera_ecf(p:integer);
var i:Tdatetime;
begin
// Esta fun??o tem como objetivo, segurar a aplica??o enquanto o ECF
// est? ocupado (processando algum comando ou imprimindo algo).
// Isso ? feito enviando um comando de status de ECF (de acordo com cada ECF)
// num loop, s? liberando com o status vier OK ou quando estourar o time-out,
// q no caso ? de 2".
     i:=now;
     while (now-i)<=strtotime('00:02:00') do // time-out para liberar
        begin
           func:='Espera ECF';
           comando:='<comando_de_espera>';
           strpcopy(cmd,comando);
           enviacomando(p,cmd);
           if copy(retorno,1,2)='.+' then exit;
        end;
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

//     _bancos:=TIniFile.Create(extractfilepath(application.exename)+'dados\<nome_do_arquivo_ini>');
//     result:=_bancos.ReadString('BANCOS', banco, '<lay-out_padr?o>');
//     _bancos.Free;

     result:='lay-out de teste!';
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
           texto:=t1+t2;
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

     AssignFile(LOGfile,extractfilepath(application.exename)+'_null.LOG');
     if not fileexists(extractfilepath(application.exename)+'_null.LOG') then Rewrite(logfile) else Reset(Logfile);
     Append(logfile);
     Writeln(logfile,datetimetostr(now)+' - '+texto);
     Flush(logfile);
     closefile(logfile);
end;

function Prepara_Resp(tipo:integer;texto,texto2,continue:string):shortstring; // esta fun?a?o prepara a string de retorno da DLL para a aplica??o.
var t:string;
    r:string;
begin
// A fun??o PREPARA_RESP formata a string de retorno vindo do ECF em um formato
// padr?o para o sistema Autocom.
// Para o AUTOCOM, o caracter @, vindo no in?cio da string, significa que o comando
// foi executado com sucesso e eventualmente pode ser acopanhado de uma resposta ( geralmente
// uma resposta de status.
// o caracter # significa que ocorreu um erro, e sempre ? seguido pela string com o
// c?digo do erro ou a menssagem de erro (dependendo de cada ECF);
// o caracter ! deve ser enviado como resposta quando o ECF n?o realiza certa opera??o.

     t:=texto;
     texto:='#'+continue+' ECF NULL'+chr(13)+' ERRO: '+texto;
     texto2:='@'+texto2;
     if copy(t,1,2)<>'.+' then r:=texto else r:=texto2;
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
     func:='Troca de operador';
     comando:='<Comando_de_troca_de_operador>';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
end;

function Abrecupom(tipo,porta:integer;texto:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Abertura de cupom';
     comando:='<Comando_de_abertura_de_cupom>';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
end;

function AbreGaveta(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Abertura de Gaveta';
     comando:='<comando_para_abertura_de_gaveta>';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
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

     val:=strtovalor(2,val);
     while pos(',',val)>0 do delete(val,pos(',',val),1);
     while pos('.',val)>0 do delete(val,pos('.',val),1);

     comando:='comando_de_acrescimo_no_subtotal';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
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
     func:='Autenticacao';
     comando:='Comando_de_autentica??o';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
end;

function Cancelacupom(tipo,porta:integer;venda,valor:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  Venda -> 1=envia comando para cencelamento dentro da venda.
           0=envia comando para cancelamento fora da venda.
  Valor -> Valor da venda
=========================================================}
     func:='Cancela Cupom';

     valor:=strtovalor(2,valor);
     while pos(',',valor)>0 do delete(valor,pos(',',valor),1);
     while pos('.',valor)>0 do delete(valor,pos('.',valor),1);

     if venda='0' then comando:='Comando_de_cancelamento_da_venda_atual';
     if venda='1' then comando:='Comando_de_cancelamento_da_venda_anterior';

     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
end;

function CancItem(tipo,porta:integer;cod,nome,prtot,trib,ind:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  cod   -> C?digo do produto cancelado
  nome  -> descricao do produto cancelado
  prtot -> total do produto cancelado
  trib  -> tributa??o do produto cancelado
  ind   -> posi??o do produto no cupom fiscal
=========================================================}
     func:='Cancelamento de item';
     while copy(prtot,1,1)='0' do delete(prtot,1,1);
     nome:=copy(nome,1,20);

     comando:='comando_de_cancelamento_de_item';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
end;

function Descitem(tipo,porta:integer; val:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  val   -> Valor do desconto.
=========================================================}
     func:='Desconto no item';

     val:=strtovalor(2,val);
     while pos(',',val)>0 do delete(val,pos(',',val),1);
     while pos('.',val)>0 do delete(val,pos('.',val),1);

     comando:='Comando_de_desconto_no_item';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
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

     val:=strtovalor(2,val);
     while pos(',',val)>0 do delete(val,pos(',',val),1);
     while pos('.',val)>0 do delete(val,pos('.',val),1);

     comando:='Comando_de_DESConto_no_subtotal';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
end;

function FecharCupom(tipo,porta:integer; SegCp,CNFV,l1,l2,l3,l4,l5,l6,l7,l8:string):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  SegCP  -> 0=N?o imprime segundo
            1=Imprime segundo cupom
  CNFV   -> 0=N?o Comprovante n?o-fiscal vinculado
            1=Imprime Comprovante n?o-fiscal vinculado
  l1..l8 -> Linhas de mensagens de cortesia.
=========================================================}
     func:='Fechamento de Cupom';
     comando:='comando_de_fechamento_de_cupom';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
end;

function Finalizadia(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo     -> tipo de ECF
  porta    -> porta de comunica??o
=========================================================}
     func:='Reducao Z';
     comando:='Comando_para_encerrar_o_dia';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
end;

function InicioDia(tipo,porta:integer; verao,op,modal:string):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  verao  -> 0=N?o est? no hor?rio de ver?o
            1=Est? no hor?rio de ver?o
  op     -> C?digo do operador ativo
  modal  -> modalidades de pagamentos, separadas por '|'
=========================================================}
     func:='Inicio do dia';
     comando:='Comando_para_abrir_o_dia';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
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
  prtot  -> pre?o total do produto
  trib   -> tributa??o do produto
=========================================================}
     func:='Lanca item';
     d:=copy(qtde,1,1);
     delete(qtde,1,1);
     qtde:=strtoquant(trim(qtde));

     if d='2' then prunit:=floattostr(strtofloat(trim(prunit))/100);
     if d='3' then prunit:=floattostr(strtofloat(trim(prunit))/1000);
     prunit:=strtovalor(strtoint(d),trim(prunit));

     prtot:=strtovalor(2,prtot);
     while pos(',',prtot)>0 do delete(prtot,pos(',',prtot),1);
     while pos('.',prtot)>0 do delete(prtot,pos('.',prtot),1);

     nome:=copy(nome,1,20);

     comando:='Comando_para_lan?ar_item';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
end;

function Notadecupom(tipo,porta:integer; ind,texto:string;abc:string):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  ind    -> indicador a ser impresso no cupom
  texto  -> texto a ser impresso no cupom
  abc    -> indica se deve ou n?o abrir o cupom fiscal
=========================================================}
     func:='Nota de Cupom';
     comando:='Comando_para_nota_de_cupom';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
end;

function TextoNF(tipo,porta:integer;texto,valor:string):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  texto  -> Texto a ser impresso.
  valor  -> Valor para CNFNV. Nos demais casos enviar nulo
=========================================================}
     func:='Texto nao fiscal';
     comando:='Comando_para_texto_n?o_fiscal';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
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

     if moda='00' then comando:='comando_para_iniciar_totaliza??o_do_cupom';
     if moda<>'00' then comando:='comando_para_totaliar_o_cupom';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
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
     comando:='Comando_para_leitura_x';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
end;

function Venda_liquida(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Venda Liquida';
     comando:='comando_para_capturar_a_venda_liquida';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     retorno:='.+000000000000'; //somente para efeito de teste!!
     result:=Prepara_Resp(tipo,retorno,copy(retorno,3,12),'');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
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
     comando:='comando_para_capturar_coo';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     c:='9999';
     if tipo_coo='1' then c:=inttostr(strtoint(c)+1);
     result:=Prepara_Resp(tipo,retorno,c,'');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
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
     comando:='Comando_para_sangria';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     log(func+' - Recebido (NULL):'+Prepara_Resp(tipo,retorno,'',''));
     espera_ecf(porta);
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
     comando:='comando_para_fundo_de_caixa';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     log(func+' - Recebido (NULL):'+Prepara_Resp(tipo,retorno,'',''));
     espera_ecf(porta);
end;

function Cheque(tipo,porta:integer;banco,valor,data,favorecido,municipio,cifra,moedas,moedap:string):shortstring;
var obs:string;
    dia,mes,ano:word;
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
     func:='Cheque';
     Obs:=copy(favorecido,pos('|',favorecido)+1,length(favorecido));
     delete(favorecido,pos('|',favorecido),length(favorecido));
     valor:=strtovalor(2,valor);
     while pos(',',valor)>0 do delete(valor,pos(',',valor),1);
     while pos('.',valor)>0 do delete(valor,pos('.',valor),1);

     decodedate(strtodate(data),ano,mes,dia);
     if length(inttostr(ano))=2 then data:=inttostr(dia)+inttostr(mes)+inttostr(ano);
     if length(inttostr(ano))=4 then data:=inttostr(dia)+inttostr(mes)+copy(inttostr(ano),3,2);

     comando:='Comando_para_imprimir_cheque'+carrega_ini_bancos(trim(banco))+valor+'\'+favorecido+'\'+municipio+'\'+data+'\'+enche(obs,' ',1,60);
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
end;

function Contra_vale(tipo,porta:integer;valor:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  valor -> Valor do contra-vale.
=========================================================}
     func:='Contra-vale';
     comando:='Comando_para_contra-vale';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
     espera_ecf(porta);
end;

function cnfv(tipo,porta:integer) : shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Abertura de CNFV';
     comando:='Comando_para_abertura_de_cnfv';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
     espera_ecf(porta);
end;

function ECF_INFO(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='ECF INFO';
     comando:='Comando_para_captura_de_status_do_ECF';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'0666011000000019999999999000000000000999999999999NS123456789','');
     log(func+' - Recebido (NULL):'+retorno+'0666011000000019999999999000000000000999999999999NS123456789');
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
     // byte 16: ? o coo final (j)
     // byte 22: ? o numero de reducoes (k)
     // byte 26: ? o gt inicial (l)
     // byte 38: ? o gt final (m)
     // byte 50: ? o ns do ecf (n)

end;


function LMFD(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='LEITURA DA MEM?RIA FISCAL POR DATA';
     comando:='Comando_para_leitura_da_memoria_fiscal_por_data';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
end;

function LMFR(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='LEITURA DA MEM?RIA FISCAL POR REDU??O';
     comando:='Comando_para_leitura_da_memoria_fiscal_por_reducao';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NULL):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NULL):'+retorno);
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
     log(func+' - Executado (NULL):');


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
    LMMM index 27;
end.
