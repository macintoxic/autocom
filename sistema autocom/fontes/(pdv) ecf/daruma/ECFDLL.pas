unit ECFDLL;

interface

uses
 Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, stdctrls,Inifiles,
  CPort,Math, StrUtils;

const
     ESC = chr(27);
     LF  = chr(10);
     CR  = chr(13);
     FF  = chr(255);
type
  Tfdaruma = class(TForm)
    serial: TComPort;
  private
    { Private declarations }
  public
    { Public declarations }
  end;



var
  fdaruma: Tfdaruma;
  func,comando:string;
  retorno,retorno_serial:string;
  CMD:array [0..512] of char;
  daruma:Tinifile;


implementation

uses DateUtils;

{$R *.DFM}

procedure Log(texto:string); // monta o log de comandos e retornos.
var
   LOGfile:textfile;
begin
     AssignFile(LOGfile,extractfilepath(application.exename)+'logs\_daruma'+formatdatetime('yyyymmdd',date)+'.LOG');
     if not fileexists(extractfilepath(application.exename)+'logs\_daruma'+formatdatetime('yyyymmdd',date)+'.LOG') then Rewrite(logfile) else Reset(Logfile);
     Append(logfile);
     Writeln(logfile,datetimetostr(now)+' - '+texto);

     Flush(logfile);
     closefile(logfile);
end;

procedure Enviacomando(p:integer;Comand:Pchar);
VAR i:integer;
    t:Tdatetime;
//    rsp:array [0..512] of char;
    device,rsp:string;
begin

     device:='COM'+inttostr(p);
     try
        Fdaruma.serial.port:=device;

        retorno_serial:='';
        Fdaruma.serial.open;
        Fdaruma.serial.ClearBuffer(true,true);
        Fdaruma.serial.WriteStr(strpas(comand)+#13);
        t:=time;
        while (time-t)<=strtotime('00:00:10') do // time-out para liberar
           begin
              //application.processmessages;
              Fdaruma.serial.readstr(rsp,255);
              retorno_serial:=retorno_serial+rsp;
              if pos(CR,rsp)>0 then break
           end;
        Fdaruma.serial.close;
        if retorno_serial='' then retorno:='.-SEM RESPOSTA DO ECF' else retorno:='.+'+retorno_serial;
        if copy(retorno_serial,1,2)=':E' then
           begin
              i:=strtoint(copy(retorno_serial,3,2));

              if i= 00 then retorno:='.-IF em modo Manuten??o. Foi ligada sem o Jumper de Opera??o'+'->'+retorno_serial;
              if i= 01 then retorno:='.-Comando dispon?vel somente em modo Manuten??o'+'->'+retorno_serial;
              if i= 02 then retorno:='.-Erro durante a grava??o da Mem?ria Fiscal'+'->'+retorno_serial;
              if i= 03 then retorno:='.-Mem?ria Fiscal esgotada'+'->'+retorno_serial;
              if i= 04 then retorno:='.-Erro no rel?gio interno da IF'+'->'+retorno_serial;
              if i= 05 then retorno:='.-Falha mec?nica na IF'+'->'+retorno_serial;
              if i= 06 then retorno:='.-Erro durante a leitura da Mem?ria Fiscal'+'->'+retorno_serial;
              if i= 10 then retorno:='.-Documento sendo emitido'+'->'+retorno_serial;
              if i= 11 then retorno:='.-Documento n?o foi aberto'+'->'+retorno_serial;
              if i= 12 then retorno:='.-N?o existe documento a cancelar'+'->'+retorno_serial;
              if i= 13 then retorno:='.-D?gito n?o num?rico n?o esperado foi encontrado nos par?metros'+'->'+retorno_serial;
              if i= 14 then retorno:='.-N?o h? mais mem?ria dispon?vel para esta opera??o'+'->'+retorno_serial;
              if i= 15 then retorno:='.-Item a cancelar n?o foi encontrado'+'->'+retorno_serial;
              if i= 16 then retorno:='.-Erro de sintaxe no comando'+'->'+retorno_serial;
              if i= 17 then retorno:='.-?Estouro? de capacidade num?rica (overflow)'+'->'+retorno_serial;
              if i= 18 then retorno:='.-Selecionado totalizador tributado com al?quota de imposto n?o definida'+'->'+retorno_serial;
              if i= 19 then retorno:='.-Mem?ria Fiscal vazia'+'->'+retorno_serial;
              if i= 20 then retorno:='.-N?o existem campos que requerem atualiza??o'+'->'+retorno_serial;
              if i= 21 then retorno:='.-Detectado proximidade do final da bobina de papel'+'->'+retorno_serial;
              if i= 22 then retorno:='.-Cupom de Redu??o Z j? foi emitido. IF inoperante at? 0:00h do pr?ximo dia'+'->'+retorno_serial;
              if i= 23 then retorno:='.-Redu??o Z do per?odo anterior ainda pendente. IF inoperante'+'->'+retorno_serial;
              if i= 24 then retorno:='.-Valor de desconto ou acr?scimo inv?lido (limitado a 100%)'+'->'+retorno_serial;
              if i= 25 then retorno:='.-Caracter inv?lido foi encontrado nos par?metros'+'->'+retorno_serial;
              if i= 27 then retorno:='.-Nenhum perif?rico conectado a interface auxiliar'+'->'+retorno_serial;
              if i= 28 then retorno:='.-Foi encontrado um campo em zero'+'->'+retorno_serial;
              if i= 29 then retorno:='.-Documento anterior n?o foi Cupom Fiscal. N?o pode emitir Cupom Adicional'+'->'+retorno_serial;
              if i= 30 then retorno:='.-Acumulador N?o Fiscal selecionado n?o ? v?lido ou n?o est? dispon?vel'+'->'+retorno_serial;
              if i= 31 then retorno:='.-N?o pode autenticar. Excedeu 4 repeti??es ou n?o ? permitida nesta fase'+'->'+retorno_serial;
              if i= 32 then retorno:='.-Cupom adicional inibido por configura??o'+'->'+retorno_serial;
              if i= 35 then retorno:='.-Rel?gio Interno Inoperante'+'->'+retorno_serial;
              if i= 36 then retorno:='.-Vers?o do firmware gravada na Mem?ria Fiscal n?o ? a esperada'+'->'+retorno_serial;
              if i= 37 then retorno:='.-Al?quota de imposto informada j? est? carregada na mem?ria'+'->'+retorno_serial;
              if i= 38 then retorno:='.-Forma de pagamento selecionada n?o ? v?lida'+'->'+retorno_serial;
              if i= 39 then retorno:='.-Erro na seq??ncia de fechamento do Cupom Fiscal'+'->'+retorno_serial;
              if i= 40 then retorno:='.-IF em Jornada Fiscal. Altera??o da configura??o n?o ? permitida'+'->'+retorno_serial;
              if i= 41 then retorno:='.-Data inv?lida. Data fornecida ? inferior ? ?ltima gravada na Mem?ria Fiscal'+'->'+retorno_serial;
              if i= 42 then retorno:='.-Leitura X inicial ainda n?o foi emitida'+'->'+retorno_serial;
              if i= 43 then retorno:='.-N?o pode emitir Comprovante Vinculado'+'->'+retorno_serial;
              if i= 44 then retorno:='.-Cupom de Or?amento n?o permitido para este estabelecimento'+'->'+retorno_serial;
              if i= 45 then retorno:='.-Campo obrigat?rio em branco'+'->'+retorno_serial;
              if i= 48 then retorno:='.-N?o pode estornar'+'->'+retorno_serial;
              if i= 49 then retorno:='.-Forma de pagamento indicada n?o encontrada'+'->'+retorno_serial;
              if i= 50 then retorno:='.-Fim da bobina de papel'+'->'+retorno_serial;
              if i= 51 then retorno:='.-Nenhum usu?rio cadastrado na MF'+'->'+retorno_serial;
              if i= 52 then retorno:='.-MF n?o instalada ou n?o inicializada'+'->'+retorno_serial;
              if i= 61 then retorno:='.-Queda de energia durante a emiss?o de Cupom Fiscal'+'->'+retorno_serial;
              if i= 76 then retorno:='.-Desconto em ISS n?o permitido (somente para vers?o 1.11 do Estado de Santa Catarina)'+'->'+retorno_serial;
              if i= 77 then retorno:='.-Acr?scimo em IOF inibido'+'->'+retorno_serial;
              if i= 80 then retorno:='.-Perif?rico na interface auxiliar n?o pode ser reconhecido'+'->'+retorno_serial;
              if i= 81 then retorno:='.-Solicitado preenchimento de cheque de banco desconhecido'+'->'+retorno_serial;
              if i= 82 then retorno:='.-Solicitado transmiss?o de mensagem nula pela interface auxiliar'+'->'+retorno_serial;
              if i= 83 then retorno:='.-Extenso do cheque n?o cabe no espa?o dispon?vel'+'->'+retorno_serial;
              if i= 84 then retorno:='.-Erro na comunica??o com a interface auxiliar'+'->'+retorno_serial;
              if i= 85 then retorno:='.-Erro no d?gito verificador durante comunica??o com a PertoCheck'+'->'+retorno_serial;
              if i= 86 then retorno:='.-Falha na carga de geometria de folha de cheque'+'->'+retorno_serial;
              if i= 87 then retorno:='.-Par?metro inv?llido para o campo de data do cheque'+'->'+retorno_serial;
              if i= 90 then retorno:='.-Sequ?ncia de valida??o de n?mero de s?rie inv?lida'+'->'+retorno_serial;
           end;
     except
        retorno:='.-NAO FOI POSSIVEL ABRIR A PORTA SERIAL '+DEVICE;
     end;

end;

function carrega_ini_bancos(banco:string):string;
//var _ncrbancos:Tinifile;
begin
//     _ncrbancos:=TIniFile.Create(extractfilepath(application.exename)+'dados\_ncrbancos.INI');
//     result:=_ncrbancos.ReadString('BANCOS', banco, '60\07\05\10\07\20\');
//     _ncrbancos.Free;
end;

function strtoquant(texto:string):string;
var posi:integer;
    t1,t2:string;
begin
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
//var posi:integer;
//    t1,t2:string;
begin
     result := FloatToStrF(StrToFloat(Texto), ffFixed,18,d);

//meu jovem gafanhoto, as vezes eu fico pensando pq vc faz
//certas coisas... quem sabe um dia eu encontrarei a resposta. 01/09/2003 - charles

//     posi:=pos('.',texto);
//     if posi=0 then posi:=pos(',',texto);
//
//     if posi=0 then
//        begin
//           texto:=texto+',';
//           while length(t2)<d do t2:=t2+'0';
//           texto:=texto+t2;
//        end
//     else
//        begin
//           t1:=copy(texto,1,posi-1);
//           t2:=copy(texto,posi+1,d);
//           while length(t2)<d do t2:=t2+'0';
//           if length(t1)=0 then t1:='0';
//           texto:=t1+','+t2;
//        end;
//     result:=texto;
end;


function Enche(texto,caracter:string;lado,tamanho:integer):string;
begin
     while length(texto)<tamanho do
        begin // lado=1, caracteres a esquerda  -  lado=2, caracteres a direita
           if lado = 1 then texto := caracter + texto else texto := texto + caracter;
        end;
     result:=texto;
end;


procedure espera_ecf(p:integer);
var i:Tdatetime;
begin
     i:=time;
     while (time-i)<=strtotime('00:01:00') do // time-out para liberar
        begin
           comando:=chr(27)+chr(239);
           strpcopy(cmd,comando);
           enviacomando(p,cmd);
           log('Aguardando ECF '+retorno);
           if copy(retorno,1,2)='.+' then break;
        end;
     retorno:='';
end;

function Prepara_Resp(tipo:integer;texto,texto2,continue:string):shortstring; // esta fun??o prepara a string de retorno da DLL para a aplica??o.
var t:string;
    r:string;
begin
     t:=texto;
     texto:='#'+continue+' ECF DARUMA'+chr(13)+' ERRO: '+texto;
     texto2:='@'+texto2;
     if copy(t,1,2)<>'.+' then r:=texto else r:=texto2;
     result:=r;
end;


///////////////////////////////////////////////////////////////////////////////////////////////////////////
//       Declara??es de fun??es de exporta??o da _DARUMA.DLL                                             //
//                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////
function Troca_op(tipo,porta:integer;codigo,fazoq:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  cod  -> C?digo do operador
  fazoq -> 0 = Saida    (nao usa)
           1 = Entrada
=========================================================}
     func:='Troca de operador';
     comando:=func+fazoq;
     log(func+' - Enviado (DARUMA):'+comando);
     retorno:='.+';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
end;

function Abrecupom(tipo,porta:integer;texto:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Abertura de cupom';


     with TIniFile.Create(ExtractFilePath( application.ExeName) +  '_daruma.ini') do
     begin
          DeleteKey('impressora','cnfnv_emissao');
          Free;
     end;
     comando:=ESC+chr(200);
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);
end;

function AbreGaveta(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Abertura de Gaveta';

     comando:=ESC+'p000';
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

end;

function AcreSub(tipo,porta:integer;val,tipacre:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  val -> valor do acrescimo
  tipoacre-> tipo de acrescimo. nao usado
=========================================================}
     func:='Acrescimo no subtotal';


     val:=strtovalor(2,val);
     while pos(',',val)>0 do delete(val,pos(',',val),1);
     while pos('.',val)>0 do delete(val,pos('.',val),1);
     val:=enche(val,'0',1,12);

     comando:=ESC+chr(241)+'3'+val;
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

end;

function Autentica(tipo,porta:integer;codigo,repete:string):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  codigo -> caracteres qq para impress?o
  repete -> 1=envia comando para repitir aut. (nao usado)
            0=Envia comando para aut.
=========================================================}
     func:='Autenticacao';


     comando:=ESC+'Y'+copy(codigo,1,13)+LF;

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);

end;

function Cancelacupom(tipo,porta:integer;venda,valor:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  Venda -> nao usado.
  Valor -> nao usado
=========================================================}
     func:='Cancela Cupom';
     comando:=ESC+chr(206);
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);
end;

function CancItem(tipo,porta:integer;cod,nome,prtot,trib,ind:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  cod   -> C?digo do produto cancelado (nao usado)
  nome  -> descricao do produto cancelado (nao usado)
  prtot -> total do produto cancelado (nao usado)
  trib  -> tributa??o do produto cancelado (nao usado)
  ind   -> posi??o do produto no cupom fiscal (nao usado)
=========================================================}
     func:='Cancelamento de item';


     comando:=ESC+chr(205)+enche(ind,'0',1,3);
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
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


//     val:=strtovalor(2,val);
//     while pos(',',val)>0 do delete(val,pos(',',val),1);
//     while pos('.',val)>0 do delete(val,pos('.',val),1);

     comando:='0';
//     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
//     enviacomando(porta,cmd);
     RETORNO:='.-Comando invalido neste ECF';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
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
     val:=enche(val,'0',1,12);

     comando:=ESC+chr(241)+'1'+Val;
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

end;

function FecharCupom(tipo,porta:integer; SegCp,CNFV,l1,l2,l3,l4,l5,l6,l7,l8:string):shortstring;
var teste:string;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  SegCP  -> 0=N?o imprime segundo
            1=Imprime segundo cupom
  CNFV   -> 0=N?o Comprovante n?o-fiscal vinculado     (nao usado)
            1=Imprime Comprovante n?o-fiscal vinculado
  l1..l8 -> Linhas de mensagens de cortesia.
=========================================================}
     teste:='';
     func:='Fechamento de Cupom';


     if (l8<>'') or (l7<>'') or (l6<>'') or (l5<>'') or
        (l4<>'') or (l3<>'') or (l2<>'') or (l1<>'') then
        begin
           if l8<>'' then teste:=l8+CR+LF+teste;
           if l7<>'' then teste:=l7+CR+LF+teste;
           if l6<>'' then teste:=l6+CR+LF+teste;
           if l5<>'' then teste:=l5+CR+LF+teste;
           if l4<>'' then teste:=l4+CR+LF+teste;
           if l3<>'' then teste:=l3+CR+LF+teste;
           if l2<>'' then teste:=l2+CR+LF+teste;
           if l1<>'' then teste:=l1+CR+LF+teste;
           comando:=ESC+chr(243)+Teste+FF;
        end
     else
        begin
           comando:=ESC+chr(212);
        end;
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando+teste);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

end;

function Finalizadia(tipo,porta:integer):shortstring;
var DatHor:string;
begin
{========================================================
  tipo     -> tipo de ECF
  porta    -> porta de comunica??o
=========================================================}
     func:='Reducao Z';


     ShortDateFormat := 'ddmmyy';
     LongTimeFormat := 'hhnnss';
     DatHor:= copy(DateTimeToStr(Now),1,6)+copy(DateTimeToStr(Now),8,6);

     comando:=ESC+chr(208)+DatHor;
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
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
  modal  -> n?o usado
=========================================================}
     func:='Inicio do dia';

     comando:=ESC+chr(207);
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
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
  prtot  -> pre?o total do produto (nao usado)
  trib   -> tributa??o do produto
=========================================================}
     func:='Lanca item';


     d:=copy(qtde,1,1);
     delete(qtde,1,1);

     qtde:= strtoquant(trim(qtde));
     if strtofloat(trim(qtde))=1 then
        qtde:='1';

//     while pos(',',prunit)>0 do delete(prunit,pos(',',prunit),1);

     while pos('.',prunit)>0 do
           delete(prunit,pos('.',prunit),1);

     if length(qtde)<5 then
        qtde:=enche(qtde,'0',1,5)
          else
          qtde:=copy(qtde,1,5);

     if (trib='T1') then trib:='TA';
     if (trib='T2') then trib:='TB';
     if (trib='T3') then trib:='TC';
     if (trib='T4') then trib:='TD';
     if (trib='T5') then trib:='TE';
     if (trib='T6') then trib:='TF';
     if (trib='T7') then trib:='TG';
     if (trib='T8') then trib:='TH';
     if (trib='T9') then trib:='TI';
     if (trib='T10') then trib:='TJ';
     if (trib='T11') then trib:='TK';
     if (trib='T12') then trib:='TL';
     if (trib='T13') then trib:='TM';
     if (trib='T14') then trib:='TN';
     if (trib='T15') then trib:='TO';
     if (pos('I',trib)>0) then trib:='I ';
     if (pos('F',trib)>0) then trib:='F ';
     if (pos('N',trib)>0) then trib:='N ';

     prunit:=strtovalor(strtoint(d),trim(prunit));
     while pos(',',prunit)>0 do delete(prunit,pos(',',prunit),1);
     while pos('.',prunit)>0 do delete(prunit,pos('.',prunit),1);

     if length(prunit)<9 then prunit:=enche(prunit,'0',1,9) else prunit:=copy(prunit,1,9);

     nome:=copy(nome,1,30);
     cod:=enche(cod,'0',1,13);

     comando:=ESC+chr(215)+trib+Cod+'000'+'0'+'0000'+prunit+qtde+'UN'+nome+FF;
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
end;

function Notadecupom(tipo,porta:integer; ind,texto:string;abc:boolean):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  ind    -> indicador a ser impresso no cupom   (n?o usado)
  texto  -> texto a ser impresso no cupom
=========================================================}
     func:='Nota de Cupom';

//     if abc=true then
//        begin
//           comando:='10';
//           strpcopy(cmd,comando);
//           log(func+' - Enviado (NCR):'+comando);
//           enviacomando(porta,cmd);
//           log(func+' - Recebido (NCR):'+retorno);
//           try
//              ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
//              ncr.writeString('CONTROLE', 'coo', '');
//              ncr.writeString('CONTROLE', '_coo', '');
//           finally
//              ncr.Free;
//           end;
//        end;
     comando:='0';
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     RETORNO:='.=';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

end;

function TextoNF(tipo,porta:integer;texto,valor:string):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  texto  -> Texto a ser impresso.
  valor  -> Valor para CNFNV. Nos demais casos enviar nulo (NCR)
=========================================================}
     func:='Texto nao fiscal';

     comando:=ESC+chr(213)+Texto+LF;
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando+texto);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);

end;

function Totalizacupom(tipo,porta:integer;Moda,valor:string):shortstring;
var modalidade:string;
    emissaoNvinc:integer;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  Moda   -> C?digo da modalidade de pagamento
  valor  -> Valor recebido da modalidade de pagamento
=========================================================}
     func:='Totaliza Cupom';
     cmd := #0;


     comando:=ESC+chr(239);
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     //gravando os totalizadores para
     //uso posterior
     Enviacomando(porta,CMD);
     //     espera_ecf(porta);
     log(func+' - Recebido (DARUMA):'+retorno);
     moda:=enche(moda,'0',1,2);
     modalidade := ifthen(moda <> '00', chr(Ord(strtoint(moda)) + 64), '00'); // fazendo a mesma coisa, mas de um jeito mais bunito - Charles.
                                                             // Helder, Helder meu pequeno gafanhoto.
                                                             // As vezes precisamos parar, pensar e abrir uma
                                                             // tuba?na.
     valor:=strtovalor(2,valor);
     valor:=formatfloat('000000000000',StrToFloat(valor) * 100);

     with TIniFile.Create(ExtractFilePath( application.ExeName) +  '_daruma.ini') do
     begin
          WriteString('modalidade',modalidade,valor);
          WriteString('impressora', 'COO', Copy(retorno, 11, 6));
          emissaoNvinc:=ReadInteger('impressora','cnfnv_emissao',0 );
          DeleteKey('impressora','cnfnv_emissao');
          Free;
     end;

     if emissaoNvinc = 1 then
     begin
           comando:=#27#241+'0'+'000000000000';
           if moda<>'00' then
              comando:= #27#242+modalidade+Valor+ #$ff;
           strpcopy(cmd,comando);
           log(func+' - Enviado (DARUMA):'+comando);
           enviacomando(porta,cmd);
           result:=Prepara_Resp(tipo,ifthen(moda='00','.+', retorno),'','');
           log(func+' - Recebido (DARUMA):'+retorno);
           with TIniFile.Create(ExtractFilePath( application.ExeName) +  '_daruma.ini') do
           begin
                WriteInteger('impressora','cnfnv_emissao',2);
                Free;
           end;
     end
         else if (emissaoNvinc = 2) {or  (emissaoNvinc = 0)} then
         begin
              Result := '@';
         end
             else
                 begin
                     comando:=#27#241+'0'+'000000000000';
                     if moda<>'00' then
                        comando:= #27#242+modalidade+Valor+ #$ff;
                     strpcopy(cmd,comando);
                     log(func+' - Enviado (DARUMA):'+comando);
                     enviacomando(porta,cmd);
                     result:=Prepara_Resp(tipo,ifthen(moda='00','.+', retorno),'','');
                     log(func+' - Recebido (DARUMA):'+retorno);
                 end;
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
     if NF='0' then comando:=ESC+chr(207);
     if NF='1' then comando:=ESC+chr(211);
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando+' tipo:'+nf);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);
end;

function Venda_liquida(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Venda Liquida';

     comando:='0';
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     retorno:='.+000000000000';
     result:=Prepara_Resp(tipo,retorno,copy(retorno,3,12),'');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

end;

function COO(tipo,porta:integer;tipo_coo:string):shortstring;
var c:string;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  tipo_coo -> 0 = ultimo emitido (nao usado)
              1 = atual (nao usado)
=========================================================}
     func:='COO';

     comando:=ESC+chr(244);
     strpcopy(cmd,comando);

     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     c:=copy(retorno,12,6);

     result:=Prepara_Resp(tipo,retorno,c,'');
     log(func+' - Recebido (DARUMA):'+retorno+c);

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
     with TIniFile.Create(extractfilepath(Application.exename) + '_daruma.ini') do
     begin
          comando:=ESC+chr(217)+ReadString('impressora','sangria','A')+'1'+'000000000000'+formatfloat('000000000000',StrToFloat(Valor))+'Sangria - Finalizadora : '+ modal + FF;
          Free;
     end;
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     if Result[1] = '@' then
        with TIniFile.Create(ExtractFilePath(Application.ExeName) + '_daruma.ini') do
        begin
             WriteInteger('impressora','cnfnv_emissao',1);
             Free;
        end;
     log(func+' - Recebido (DARUMA):'+retorno);
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
     with TIniFile.Create(extractfilepath(Application.exename) + '_daruma.ini') do
     begin
          comando:=ESC+chr(217)+ReadString('impressora','fcx', 'B') +'1'+'000000000000'+formatfloat('000000000000',StrToFloat(Valor))+'Fundo de Caixa - Finalizadora : '+modal + FF;
          Free;
     end;
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);
end;

function Cheque(tipo,porta:integer;banco,valor,data,favorecido,municipio,cifra,moedas,moedap:string):shortstring;
var// obs:string;
    //dia,mes,ano:word;
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

//{tipo para a NCR 20} -> 'NCR - IF-7141 Duas Esta??es v2.00'
//{tipo para a NCR 21} -> 'NCR - IF-7140 Duas Esta??es v2.00'
//{tipo para a NCR 22} -> 'NCR - IF-7140 Uma Esta??o v2.00'

     modelo[1]:=20;
     modelo[2]:=21;

     ok:=false;
     for a:=1 to 2 do
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

//           Obs:=copy(favorecido,pos('|',favorecido)+1,length(favorecido));
//           delete(favorecido,pos('|',favorecido),length(favorecido));
//           valor:=strtovalor(2,valor);
//           while pos(',',valor)>0 do delete(valor,pos(',',valor),1);
//           while pos('.',valor)>0 do delete(valor,pos('.',valor),1);
//
//           decodedate(strtodate(data),ano,mes,dia);
//           if length(inttostr(ano))=2 then data:=enche(inttostr(dia),'0',1,2)+enche(inttostr(mes),'0',1,2)+enche(inttostr(ano),'0',1,2);
//           if length(inttostr(ano))=4 then data:=enche(inttostr(dia),'0',1,2)+enche(inttostr(mes),'0',1,2)+enche(copy(inttostr(ano),3,2),'0',1,2);
//
//           if tipo=20 then
//              begin
//                 comando:='27'+carrega_ini_bancos(trim(banco))+valor+'\'+favorecido+'\'+municipio+'\'+data+'\'+enche(obs,' ',1,60);
//              end
//           else
//              begin
//                 comando:='2080\74\'+valor+'\'+favorecido+'\'+municipio+'\'+data+'\'+enche(obs,' ',1,60);
//              end;
//
//           strpcopy(cmd,comando);
//           log(func+' - Enviado (NCR):'+comando);
//           enviacomando(porta,cmd);
//           result:=Prepara_Resp(tipo,retorno,'','');
//           log(func+' - Recebido (NCR):'+retorno);

        end
     else
        begin
           result:=Prepara_Resp(tipo,'.+','','');
           log(func+' - Executado:'+retorno);
        end;
end;

function Contra_vale(tipo,porta:integer;valor:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  valor -> Valor do contra-vale.
=========================================================}
     func:='Contra-vale';

     comando:=ESC+chr(217)+'C'+'1'+'00000000000'+Valor+'CONTRA - VALE : ';
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

end;

function cnfv(tipo,porta:integer) : shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Abertura de CNFV';
     with tinifile.Create(ExtractFilePath( application.ExeName) + '_daruma.ini') do
     begin
          comando:=ESC+chr(219)+Readstring('impressora','comprovante','') + Readstring('impressora','vinculado','')+
                       Readstring('impressora','coo','')+
                       Readstring('modalidade',Readstring('impressora','vinculado',''),'0')+ FF;
          Free;
     end;
     //comando:=ESC+chr(217)+'C'+'1'+'00000000000'+'RECEBIMENTO';
     log(func+' - Enviado (DARUMA):'+comando);
     strpcopy(cmd,comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);
end;

function ECF_INFO(tipo,porta:integer):shortstring;
var c,d,e,f,g,h,i,j,k,l,m,n:string;
    s: string;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
{
      func:='ECF INFO';
      d:='0001';
      c:='0';
      e:='1';
      f:='1';
      g:='0';
      h:='0';
      i:='0001';
      j:='9999';
      k:='9999';
      l:='000000000001';
      m:='999999999999';
      n:='12345678';
      retorno:='.+';
      result:=Prepara_Resp(tipo,retorno,d+c+e+f+g+h+i+j+k+l+m+n,'');
      log(func+' - Recebido ECF_INFO (DARUMA):'+retorno+' ->'+d+c+e+f+g+h+i+j+k+l+m+n);
}

     func:='ECF INFO 1';

     comando:=ESC+chr(236);
     strpcopy(cmd,comando);

     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);

     s:=copy(retorno,3,length(retorno));

     n:=copy(s,3,8);  // numero de serie
     log(func+' - Recebido (DARUMA):'+retorno+' ->'+n);
     s:='';

     if copy(retorno,1,2)<>'.-' then // se vier um '.-' , significa q ocorreu problema!!
        begin
           func:='ECF INFO 2';

           comando:=ESC+chr(239);
           strpcopy(cmd,comando);

           log(func+' - Enviado (DARUMA):'+comando);
           enviacomando(porta,cmd);

           s:=copy(retorno,3,length(retorno));

           d:=copy(s,4,4); //numero do ECF
           h:=copy(s,8,1); //status de cupom fiscal aberto
           m:=copy(s,43,18); //GT Final
           m:=copy(m,7,12);

           if h<>'1' then h:='0';
           log(func+' - Recebido (DARUMA):'+retorno+' ->'+d+h+m);
           s:='';

           if copy(retorno,1,2)<>'.-' then // se vier um '.-' , significa q ocorreu problema!!
              begin
                 func:='ECF INFO 3';

                 comando:=ESC+chr(240);
                 strpcopy(cmd,comando);

                 log(func+' - Enviado (DARUMA):'+comando);
                 enviacomando(porta,cmd);

                 s:=copy(retorno,3,length(retorno));

                 l:=copy(s,4,18); //gt inicial
                 l:=copy(l,7,12);

                 log(func+' - Recebido (DARUMA):'+retorno+' ->'+l);
                 s:='';

                 if copy(retorno,1,2)<>'.-' then // se vier um '.-' , significa q ocorreu problema!!
                    begin
                       func:='ECF INFO 4';

                       comando:=ESC+chr(244);
                       strpcopy(cmd,comando);

                       log(func+' - Enviado (DARUMA):'+comando);
                       enviacomando(porta,cmd);
                       s:=copy(retorno,3,length(retorno));

                       i:=copy(s,4,6);//coo inicial
                       j:=copy(s,10,6); //coo final
                       k:=copy(s,42,4); // numero de reducoes

                       log(func+' - Recebido (DARUMA):'+retorno+' ->'+i+j+k);
                       s:='';

                       if copy(retorno,1,2)<>'.-' then // se vier um '.-' , significa q ocorreu problema!!
                          begin
                             func:='ECF INFO 5';

                             c:='0'; // situacao do dia
                             e:='1'; // status de papel
                             f:='1'; // status de documento
                             g:='0'; // status de gaveta
                             RETORNO:='.+';

                             log(func+' - Recebido (DARUMA):'+retorno+' ->'+c+e+f+g);
                             result:=Prepara_Resp(tipo,retorno,d+c+e+f+g+h+i+j+k+l+m+n,'');
                             log(func+' - Recebido ECF_INFO (DARUMA):'+retorno+' ->'+d+c+e+f+g+h+i+j+k+l+m+n);

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
                          end
                       else
                          begin
                             result:=Prepara_Resp(tipo,retorno,'','');
                          end;
                    end
                 else
                    begin
                       result:=Prepara_Resp(tipo,retorno,'','');
                    end;
              end
           else
              begin
                 result:=Prepara_Resp(tipo,retorno,'','');
              end;
        end
     else
        begin
           result:=Prepara_Resp(tipo,retorno,'','');
        end;


end;

function LMFD(tipo,porta:integer;inicio,fim:string):shortstring;
var ano,mes,dia:word;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}

     func:='LEITURA DA MEM?RIA FISCAL POR DATA';


     decodedate(strtodate(inicio),ano,mes,dia);
     if length(inttostr(ano))=2 then inicio:=inttostr(dia)+inttostr(mes)+inttostr(ano);
     if length(inttostr(ano))=4 then inicio:=inttostr(dia)+inttostr(mes)+copy(inttostr(ano),3,2);

     decodedate(strtodate(fim),ano,mes,dia);
     if length(inttostr(ano))=2 then fim:=inttostr(dia)+inttostr(mes)+inttostr(ano);
     if length(inttostr(ano))=4 then fim:=inttostr(dia)+inttostr(mes)+copy(inttostr(ano),3,2);


     comando:=ESC+chr(209)+'x'+Inicio+Fim;
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);

end;

function LMFR(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}

     func:='LEITURA DA MEM?RIA FISCAL POR REDU??O';


     comando:='0';
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     retorno:='.+';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);

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
     result:=Prepara_Resp(tipo,'.-Fun??o ainda n?o implementada','','');
     log(func+' - Executado (DARUMA):');
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


initialization
begin

end;


end.
