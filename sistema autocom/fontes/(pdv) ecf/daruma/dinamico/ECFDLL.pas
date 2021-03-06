unit ECFDLL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, stdctrls,Inifiles;

const
    DLLECF='fs345_32.dll';

type
// declara??o das fun??es da dll da daruma
TDAR_AbreSerial   =function (conf:string): Integer;stdcall;
TDAR_Envia        =function (buf:string;Size:integer;wait:char): Integer;stdcall;
TDAR_Resposta     =function (dest: PChar; maxlen: Integer ): Integer;stdcall;
TDAR_Erro         =function (): Integer;stdcall;TDAR_LeStatus     =function (wait:char): Integer;stdcall;TDAR_FechaSerial  =function (wait:char): Integer;stdcall;//Comandos Fiscais//Estas fun??es est?o apresentadas na ordem em que se encontram os comandos no manual da impressora, facilitando assim a sua compreens?o
TDAR_AbreCupomFiscal    =function (wait:char): Integer;stdcall;TDAR_Desc2Lin13Dig      =function (St:string;Cod:string;D_a:char;Porc:string;Preco:string;Quant:string;Unid:string;Desc:string;wait:char):Integer;stdcall;
TDAR_CancelaItem        =function (NumItem:string;wait:char):Integer;stdcall;
TDAR_Subtotal           =function (wait:char):Integer;stdcall;
TDAR_Totaliza           =function (D_a:char;Val:string;wait:char): Integer;stdcall;
TDAR_DescFormPag        =function (Tipo:char;Val:string;Text:string;wait:char): Integer;stdcall;
TDAR_IdentConsum        =function (Text:string;wait:char): Integer;stdcall;
TDAR_FechaCupom         =function (Text:string;wait:char): Integer;stdcall;
TDAR_CupomAdicional     =function (wait:char):Integer;stdcall;
TDAR_CancelaDoc         =function (wait:char):Integer;stdcall;
TDAR_AbreCNFV           =function (Id:char;Tipo:char;Coo:string;Val:string;wait:char):Integer;stdcall;
TDAR_AbreX              =function (wait:char):Integer;stdcall;
TDAR_LinhaX             =function (Text:string;wait:char):Integer;stdcall;
TDAR_FechaX             =function (wait:char):Integer;stdcall;
TDAR_AbreCNFNV          =function (Id:char;D_a:char;Desc:string;Val:string;Text:string;wait:char):Integer;stdcall;
TDAR_LeituraX           =function (wait:char): Integer;stdcall;
TDAR_ImpHora            =function (wait:char):Integer;stdcall;
TDAR_LeMF               =function (opt:char;Inic:string;Fim:string;wait:char):Integer;stdcall;
TDAR_ReducaoZ           =function (DatHor:string;wait:char): Integer;stdcall;

//Comandos de LeituraTDAR_LeModelo          =function (wait:char):Integer;stdcall;TDAR_LeDataMF          =function (wait:char):Integer;stdcall;
TDAR_LeConfig          =function (wait:char):Integer;stdcall;
TDAR_LeMensPer         =function (wait:char):Integer;stdcall;
TDAR_LeEstadoDoc       =function (wait:char):Integer;stdcall;
TDAR_LeRegsFiscais     =function (wait:char):Integer;stdcall;
TDAR_LeRegsNaoFiscais  =function (wait:char):Integer;stdcall;
TDAR_Autentica         =function (Ident:string;wait:char):Integer;stdcall;
TDAR_Guilhotina        =function ():Integer;stdcall;
TDAR_AbreGaveta        =function ():Integer;stdcall;
TDAR_LeIdent           =function (wait:char):Integer;stdcall;


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
  daruma:Tinifile;
  hdl:Thandle;

// declara??o das fun??es da dll da daruma
DAR_AbreSerial:TDAR_AbreSerial;
DAR_Envia:TDAR_Envia;
DAR_Resposta:TDAR_Resposta;
DAR_Erro:TDAR_Erro;DAR_LeStatus:TDAR_LeStatus;DAR_FechaSerial:TDAR_FechaSerial;//Comandos Fiscais//Estas fun??es est?o apresentadas na ordem em que se encontram os comandos no manual da impressora, facilitando assim a sua compreens?o
DAR_AbreCupomFiscal:TDAR_AbreCupomFiscal;DAR_Desc2Lin13Dig:TDAR_Desc2Lin13Dig;
DAR_CancelaItem:TDAR_CancelaItem;
DAR_Subtotal:TDAR_Subtotal;
DAR_Totaliza:TDAR_Totaliza;
DAR_DescFormPag:TDAR_DescFormPag;
DAR_IdentConsum:TDAR_IdentConsum;
DAR_FechaCupom:TDAR_FechaCupom;
DAR_CupomAdicional:TDAR_CupomAdicional;
DAR_CancelaDoc:TDAR_CancelaDoc;
DAR_AbreCNFV:TDAR_AbreCNFV;
DAR_AbreX:TDAR_AbreX;
DAR_LinhaX:TDAR_LinhaX;
DAR_FechaX:TDAR_FechaX;
DAR_AbreCNFNV:TDAR_AbreCNFNV;
DAR_LeituraX:TDAR_LeituraX;
DAR_ImpHora:TDAR_ImpHora;
DAR_LeMF:TDAR_LeMF;
DAR_ReducaoZ:TDAR_ReducaoZ;

//Comandos de LeituraDAR_LeModelo:TDAR_LeModelo;DAR_LeDataMF:TDAR_LeDataMF;
DAR_LeConfig:TDAR_LeConfig;
DAR_LeMensPer:TDAR_LeMensPer;
DAR_LeEstadoDoc:TDAR_LeEstadoDoc;
DAR_LeRegsFiscais:TDAR_LeRegsFiscais;
DAR_LeRegsNaoFiscais:TDAR_LeRegsNaoFiscais;
DAR_Autentica:TDAR_Autentica;
DAR_Guilhotina:TDAR_Guilhotina;
DAR_AbreGaveta:TDAR_AbreGaveta;
DAR_LeIdent:TDAR_LeIdent;

implementation

{$R *.DFM}

procedure Log(texto:string); // monta o log de comandos e retornos.
var LOGfile:textfile;
begin
     AssignFile(LOGfile,extractfilepath(application.exename)+'logs\_daruma.LOG');
     if not fileexists(extractfilepath(application.exename)+'logs\_daruma.LOG') then Rewrite(logfile) else Reset(Logfile);
     Append(logfile);
     Writeln(logfile,datetimetostr(now)+' - '+texto);
     Flush(logfile);
     closefile(logfile);
end;

procedure Enviacomando(p:integer;Comand:Pchar);
VAR i:integer;
//    rsp:array [0..512] of char;
     hndl:Thandle;
begin
     i:=strtoint(strpas(comand));
     if i = -1 then
        begin
           hndl := LoadLibrary(DLLECF);
           @DAR_erro := GetProcAddress(hndl, 'DAR_Erro');
           if @DAR_erro=nil then log('Nao achou DAR_Erro');
           i:= DAR_erro;
           freelibrary(hndl);

           i:= i - 536870912; // Esse numero ? obrigatorio, esta na documentacao da DARUMA

           if i=01 then retorno:='.-Sring de configura??o de porta inv?lida';
           if i=02 then retorno:='.-Tentativa de envio sem abertura da porta serial';
           if i=03 then retorno:='.-Fila de entrada cheia: as respostas do ECF n?o foram lidas e os buffers est?o cheios (leia com DAR_Resposta)';
           if i=04 then retorno:='.-N?o houve resposta do ECF';
           if i=16 then retorno:='.-Problema no par?metro DA (Desconto/Acr?scimo). Deve ser ?0? ou ?1? (decimal 48 ou 49)';
           if i=17 then retorno:='.-Situa??o Tribut?ria inv?lida. Deve ser da forma ?TA? ou ?ta? (al?quotas A a P), ?F?, ?I? ou ?N?';
           if i=18 then retorno:='.-D?gito inv?lido numa string (provavelmente um caracter alfa onde n?o ? aceito)';
           if i=19 then retorno:='.-Caracter alfanum?rico inv?lido, provavelmente tem um caracter de controle onde n?o ? aceito';
           if i=20 then retorno:='.-Erro de formato em campo percentual, provavelmente caracter n?o num?rico na string';
           if i=21 then retorno:='.-Erro de formato no campo pre?o. Este campo deve conter apenas d?gitos. A v?rgula ? impl?cita.';
           if i=22 then retorno:='.-Erro no campo de quantidade, provavelmente caracter alfa na string, diferente de v?rgula';
           if i=23 then retorno:='.-Erro no campo descri??o (provavelmente um caracter de controle no campo)';
           if i=24 then retorno:='.-Erro no campo Unidade (provavelmente um caracter de controle no campo)';
           if i=25 then retorno:='.-Erro no campo C?digo (provavelmente um caracter de controle no campo)';
           if i=26 then retorno:='.-Erro no campo C?digo (provavelmente um caracter de controle no campo)';
           if i=27 then retorno:='.-Tipo de desconto inv?lido: deve ser ?0? (48 ou $30) a ?5? (53 ou $35)';
           if i=28 then retorno:='.-Erro de tipo: Em DAR_PersonaMens tipo deve ser ?O? ou ?P?. Em DAR_CriaCNF tipo deve ser ?V?, ?+? ou ?-?. Em DAR_CriaCNF e DAR_DescFormPag, tipo deve ser ?A? a ?P?.';
           if i=29 then retorno:='.-Erro em campo de texto (provavelmente um caracter de controle no campo)';
           if i=30 then retorno:='.-Erro de al?quota (deve ser ?A? a ?P?)';
           if i=31 then retorno:='.-Erro de COO (provavelmente contem caracter alfa na string)';
           if i=32 then retorno:='.-Erro de op??o de leitura de MF (deve ser ?0? a ?7?)';
           if i=33 then retorno:='.-Data inv?lida';
           if i=34 then retorno:='.-Erro de formato (n?o usado)';
           if i=35 then retorno:='.-Em DAR_Retrans, erro de n?mero de mensagem (deve ser ?0? a ?9? ? 48 a 57)';
           if i=36 then retorno:='.-Erro de al?quota em DAR_CargaAliquota (deve obedecer ?s regras de valores percentuais)';
           if i=37 then retorno:='.-Em DAR_PersonaMens, erro no campo CNT que deve ser alfanum?rico';
           if i=38 then retorno:='.-Erro no tipo de imposto em DAR_CargaAliquota (deve ser ?S? ou ?I?)';
           if i=39 then retorno:='.-Erro num dos par?metros de zeramento na DAR_Intervencao (deve ser caracter alfa)';
           if i=40 then retorno:='.-N?mero de ECF inv?lido em DAR_Intervencao (provavelmente cont?m caracteres alfa)';
           if i=41 then retorno:='.-Erro de canal em DAR_ChqCanal (deve ser ?0? ou ?1?';
           if i=42 then retorno:='.-Erro de comando ao mecanismo em DAR_ConfigOki  - os comandos v?lidos s?o ?L?, ?M?, ?T? e ?C?';
           if i=43 then retorno:='.-Erro de par?metro em comando ao mecanismo em DAR_ConfigOki';
           if i=44 then retorno:='.-Erro de identifica??o de bloco em DAR_LeBlocoMF ? os d?gitos devem ser hexadecimais (0-9, A-F)';
           if i=45 then retorno:='.-Na fun??o DAR_LeInfoUser, erro na string num?rica que identifica o usu?rio (deve ser ?00? a ?50?';
           if i=46 then retorno:='.-Erro na sigla do estado na carga de al?quotas na FS420 ? pode conter espa?os ou caracteres de controle';
           if i=47 then retorno:='.-Erro no campo Natureza do transporte (FS420): deve ser "RODOVIARIO", "FERROVIARIO" ou "AQUAVIARIO"';
           if i=48 then retorno:='.-Erro na abertura do Arquivo texto (FS420)';
           if i=49 then retorno:='.-Erro na abertura do Arquivo bin?rio (FS420)';
           if i=50 then retorno:='.-Erro na aloca??o de espa?o na mem?ria do PC para tratamento do arquivo (FS420)';
           if i=51 then retorno:='.-Resposta inv?lida durante a carga da flash da FS420';
           if i=52 then retorno:='.-Erro de escrita na flash (FS420)';
           if i=53 then retorno:='.-Erro desconhecido inv?lida durante a carga da flash da FS420';
           if i=54 then retorno:='.-Erro de estouro de tentativas inv?lida durante a carga da flash da FS420';
           if i=55 then retorno:='.-Erro de leitura do arquivo (FS420)';
           if i=56 then retorno:='.-Erro de escrita no arquivo (FS420)';
           if i=57 then retorno:='.-Mesa inv?lida (FS318)';
           if i=58 then retorno:='.-Totalizador inv?lido';
           if i=59 then retorno:='.-Meio de pagamento inv?lido';
           if i=60 then retorno:='.-N?mero de decimais inv?lido';
        end
     else
        begin
           retorno:='.+';
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
var posi:integer;
    t1,t2:string;
begin
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
           t2:=copy(texto,posi+1,d);
           while length(t2)<d do t2:=t2+'0';
           if length(t1)=0 then t1:='0';
           texto:=t1+','+t2;
        end;
     result:=texto;
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
//var i:Tdatetime;
begin
//     i:=time;
//     while (time-i)<=strtotime('00:03:00') do // time-out para liberar
//        begin
//           comando:='30';
//           strpcopy(cmd,comando);
//           enviacomando(p,cmd);
//           if copy(retorno,1,2)='.+' then break;
//        end;
//     retorno:='';
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
//       Declara??es de fun??es de exporta??o da _DARUMA.DLL                                               //
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
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     comando:=func+fazoq;
     log(func+' - Enviado (DARUMA):'+comando);
     result:=Prepara_Resp(tipo,'.+','','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);
     DAR_FechaSerial('1');
end;

function Abrecupom(tipo,porta:integer;texto:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Abertura de cupom';

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreCupomFiscal := GetProcAddress(Hdl, 'DAR_AbreCupomFiscal');
     comando:=inttostr(DAR_AbreCupomFiscal('1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);

end;

function AbreGaveta(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Abertura de Gaveta';

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     Hdl := LoadLibrary(DLLECF);
     @DAR_Abregaveta := GetProcAddress(Hdl, 'DAR_Abregaveta');
     comando:=inttostr(DAR_Abregaveta);
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);

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

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);


     val:=strtovalor(2,val);
//     while pos(',',val)>0 do delete(val,pos(',',val),1);
//     while pos('.',val)>0 do delete(val,pos('.',val),1);

     Hdl := LoadLibrary(DLLECF);
     @DAR_Totaliza := GetProcAddress(Hdl, 'DAR_Totaliza');
     comando:=inttostr(DAR_Totaliza('3',Val,'1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);
     DAR_FechaSerial('1');
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

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);


     Hdl := LoadLibrary(DLLECF);
     @DAR_Autentica := GetProcAddress(Hdl, 'DAR_Autentica');
     comando:=INTTOSTR(DAR_Autentica(copy(codigo,1,13),'1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);

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

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     Hdl := LoadLibrary(DLLECF);
     @DAR_CancelaDoc := GetProcAddress(Hdl, 'DAR_CancelaDoc');
     comando:=inttostr(DAR_CancelaDoc('1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
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

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     Hdl := LoadLibrary(DLLECF);
     @DAR_CancelaItem := GetProcAddress(Hdl, 'DAR_CancelaItem');
     comando:=inttostr(DAR_CancelaItem(ind,'1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
end;

function Descitem(tipo,porta:integer; val:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  val   -> Valor do desconto.
=========================================================}
     func:='Desconto no item';

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

//     val:=strtovalor(2,val);
//     while pos(',',val)>0 do delete(val,pos(',',val),1);
//     while pos('.',val)>0 do delete(val,pos('.',val),1);

     comando:='0';
//     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     RETORNO:='.-Comando invalido';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
end;

function DescSub(tipo,porta:integer; val:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  val   -> Valor do desconto
=========================================================}
     func:='Desconto no subtotal';

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     val:=strtovalor(2,val);
//     while pos(',',val)>0 do delete(val,pos(',',val),1);
//     while pos('.',val)>0 do delete(val,pos('.',val),1);

     Hdl := LoadLibrary(DLLECF);
     @DAR_Totaliza := GetProcAddress(Hdl, 'DAR_Totaliza');
     comando:=inttostr(DAR_Totaliza('1',Val,'1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
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

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     if l8<>'' then teste:=chr(10)+l8+teste;
     if l7<>'' then teste:=chr(10)+l7+teste;
     if l6<>'' then teste:=chr(10)+l6+teste;
     if l5<>'' then teste:=chr(10)+l5+teste;
     if l4<>'' then teste:=chr(10)+l4+teste;
     if l3<>'' then teste:=chr(10)+l3+teste;
     if l2<>'' then teste:=chr(10)+l2+teste;
     if l1<>'' then teste:=l1+teste;

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaCupom := GetProcAddress(Hdl, 'DAR_FechaCupom');
     comando:=inttostr(DAR_FechaCupom(Teste,'1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
end;

function Finalizadia(tipo,porta:integer):shortstring;
var DatHor:string;
begin
{========================================================
  tipo     -> tipo de ECF
  porta    -> porta de comunica??o
=========================================================}
     func:='Reducao Z';

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     ShortDateFormat := 'ddmmyy';
     LongTimeFormat := 'hhnnss';
     DatHor:= copy(DateTimeToStr(Now),1,6)+copy(DateTimeToStr(Now),8,6);

     Hdl := LoadLibrary(DLLECF);
     @DAR_ReducaoZ := GetProcAddress(Hdl, 'DAR_ReducaoZ');
     comando:=INTTOSTR(DAR_ReducaoZ(DatHor,'1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
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

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     Hdl := LoadLibrary(DLLECF);
     @DAR_LeituraX := GetProcAddress(Hdl, 'DAR_LeituraX');
     comando:=inttostr(DAR_LeituraX('1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
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

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     d:=copy(qtde,1,1);
     delete(qtde,1,1);

     qtde:=strtoquant(trim(qtde));
     if strtofloat(trim(qtde))=1 then qtde:='1';
     while pos(',',prunit)>0 do delete(prunit,pos(',',prunit),1);
     while pos('.',prunit)>0 do delete(prunit,pos('.',prunit),1);
     if length(qtde)<5 then qtde:=enche(qtde,'0',1,5) else qtde:=copy(qtde,1,5);

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

     Hdl := LoadLibrary(DLLECF);
     @DAR_Desc2Lin13Dig := GetProcAddress(Hdl, 'DAR_Desc2Lin13Dig');
     comando:=INTtostr(DAR_Desc2Lin13Dig(trib,Cod,'0','0',prunit,qtde,'UN',nome,'1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
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

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     if abc=true then
        begin
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
        end;
     comando:='0';
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     RETORNO:='.=';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
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

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     Hdl := LoadLibrary(DLLECF);
     @DAR_LinhaX := GetProcAddress(Hdl, 'DAR_LinhaX');
     comando:=inttostr(DAR_LinhaX(Texto,'1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
end;

function Totalizacupom(tipo,porta:integer;Moda,valor:string):shortstring;
var modalidade:char;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  Moda   -> C?digo da modalidade de pagamento
  valor  -> Valor recebido da modalidade de pagamento
=========================================================}
     func:='Totaliza Cupom';

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     moda:=enche(moda,'0',1,2);

     if moda='01' then modalidade:='A';
     if moda='02' then modalidade:='B';
     if moda='03' then modalidade:='C';
     if moda='04' then modalidade:='D';
     if moda='05' then modalidade:='E';
     if moda='06' then modalidade:='F';
     if moda='07' then modalidade:='G';
     if moda='08' then modalidade:='H';
     if moda='09' then modalidade:='I';
     if moda='10' then modalidade:='J';

     valor:=strtovalor(2,valor);
     while pos(',',valor)>0 do delete(valor,pos(',',valor),1);
     while pos('.',valor)>0 do delete(valor,pos('.',valor),1);
     if length(valor)<12 then valor:=enche(valor,'0',1,12);

     Hdl := LoadLibrary(DLLECF);
     @DAR_Totaliza := GetProcAddress(Hdl, 'DAR_Totaliza');
     @DAR_DescFormPag := GetProcAddress(Hdl, 'DAR_DescFormPag');
     if moda='00' then comando:=inttostr(DAR_Totaliza('0','0','1'));
     if moda<>'00' then comando:=inttostr(DAR_DescFormPag(modalidade,Valor,'','1'));
     freelibrary(hdl);


     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
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

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     Hdl := LoadLibrary(DLLECF);
     @DAR_LeituraX := GetProcAddress(Hdl, 'DAR_LeituraX');
     comando:=INTTOSTR(DAR_LeituraX('1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
end;

function Venda_liquida(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Venda Liquida';

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     comando:='0';
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     retorno:='.+000000000000';
     result:=Prepara_Resp(tipo,retorno,copy(retorno,3,12),'');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
end;

function COO(tipo,porta:integer;tipo_coo:string):shortstring;
var c:string;
   s: array[0..999] of Char;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  tipo_coo -> 0 = ultimo emitido (nao usado)
              1 = atual (nao usado)
=========================================================}
     func:='COO';

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     Hdl := LoadLibrary(DLLECF);
     @DAR_LeRegsNaoFiscais := GetProcAddress(Hdl, 'DAR_LeRegsNaoFiscais');
     comando:=inttostr(DAR_LeRegsNaoFiscais('1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);

     if comando<>'-1' then
        begin
           DAR_Resposta(s,999);
           c:=copy(s,10,6);
           result:=Prepara_Resp(tipo,'.+',c,'');
           log(func+' - Recebido (DARUMA):'+'.+'+c);

        end;
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
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

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreCNFNV := GetProcAddress(Hdl, 'DAR_AbreCNFNV');
     comando:=inttostr(DAR_AbreCNFNV('A','0','0',Valor,'Sangria - Finalizadora : '+modal,'1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
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

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreCNFNV := GetProcAddress(Hdl, 'DAR_AbreCNFNV');
     comando:=inttostr(DAR_AbreCNFNV('B','0','0',Valor,'Fundo de Caixa - Finalizadora : '+modal,'1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
end;

function Cheque(tipo,porta:integer;banco,valor,data,favorecido,municipio,cifra,moedas,moedap:string):shortstring;
var obs:string;
    dia,mes,ano:word;
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
//           DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
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
//           DAR_FechaSerial('1');
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

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreCNFNV := GetProcAddress(Hdl, 'DAR_AbreCNFNV');
     comando:=inttostr(DAR_AbreCNFNV('C','0','0',Valor,'CONTRA - VALE : ','1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
end;

function cnfv(tipo,porta:integer) : shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Abertura de CNFV';

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreCNFNV := GetProcAddress(Hdl, 'DAR_AbreCNFNV');
     comando:=inttostr(DAR_AbreCNFNV('C','0','0','0','RECEBIMENTO','1'));
     freelibrary(hdl);

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);
     espera_ecf(porta);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
end;

function ECF_INFO(tipo,porta:integer):shortstring;
var c,d,e,f,g,h,i,j,k,l,m,n:string;
    s: array[0..999] of Char;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='ECF INFO 1';

     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');

{=========================================================}

     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     @DAR_LeIdent := GetProcAddress(Hdl, 'DAR_LeIdent');
     @DAR_LeEstadoDoc := GetProcAddress(Hdl, 'DAR_LeEstadoDoc');
     @DAR_LeRegsFiscais := GetProcAddress(Hdl, 'DAR_LeRegsFiscais');
     @DAR_LeRegsNaoFiscais := GetProcAddress(Hdl, 'DAR_LeRegsNaoFiscais');
     @DAR_Resposta := GetProcAddress(Hdl, 'DAR_Resposta');
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');

     comando:=inttostr(DAR_LeIdent('1'));

     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     DAR_Resposta(s,999);

     n:=copy(s,1,8);  // numero de serie
     log(func+' - Recebido (DARUMA):'+retorno+' ->'+n);
     s:='';
     if copy(retorno,1,2)<>'.-' then // se vier um '.-' , significa q ocorreu problema!!
        begin
           func:='ECF INFO 2';

           comando:=inttostr(DAR_LeEstadoDoc('1'));

           strpcopy(cmd,comando);
           log(func+' - Enviado (DARUMA):'+comando);
           enviacomando(porta,cmd);
           DAR_Resposta(s,999);

           d:=copy(s,4,4); //numero do ECF
           h:=copy(s,8,1); //status de cupom fiscal aberto
           m:=copy(s,43,18); //GT Final
           m:=copy(m,7,12);
           if h<>'1' then h:='0';
           log(func+' - Recebido (DARUMA):'+retorno+' ->'+d+h+m);
           if copy(retorno,1,2)<>'.-' then // se vier um '.-' , significa q ocorreu problema!!
              begin
                 func:='ECF INFO 3';

                 comando:=inttostr(DAR_LeRegsFiscais('1'));

                 strpcopy(cmd,comando);
                 log(func+' - Enviado (DARUMA):'+comando);
                 enviacomando(porta,cmd);
                 DAR_Resposta(s,999);

                 l:=copy(s,4,18); //gt inicial
                 l:=copy(l,7,12);

                 log(func+' - Recebido (DARUMA):'+retorno+' ->'+l);
                 if copy(retorno,1,2)<>'.-' then // se vier um '.-' , significa q ocorreu problema!!
                    begin
                       func:='ECF INFO 4';

                       comando:=inttostr(DAR_LeRegsNaoFiscais('1'));

                       strpcopy(cmd,comando);
                       log(func+' - Enviado (DARUMA):'+comando);
                       enviacomando(porta,cmd);
                       DAR_Resposta(s,999);

                       i:=copy(s,4,6);//coo inicial
                       j:=copy(s,10,6); //coo final
                       k:=copy(s,42,4); // numero de reducoes

                       log(func+' - Recebido (DARUMA):'+retorno+' ->'+i+j+k);
                       if copy(retorno,1,2)<>'.-' then // se vier um '.-' , significa q ocorreu problema!!
                          begin
                             func:='ECF INFO 5';

                             c:='0'; // situacao do dia
                             e:='1'; // status de papel
                             f:='1'; // status de documento
                             g:='0'; // status de gaveta
                             retorno:='.+';
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

     DAR_FechaSerial('1');
     freelibrary(hdl);
end;

function LMFD(tipo,porta:integer;inicio,fim:string):shortstring;
var ano,mes,dia:word;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='LEITURA DA MEM?RIA FISCAL POR DATA';
     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     decodedate(strtodate(inicio),ano,mes,dia);
     if length(inttostr(ano))=2 then inicio:=inttostr(dia)+inttostr(mes)+inttostr(ano);
     if length(inttostr(ano))=4 then inicio:=inttostr(dia)+inttostr(mes)+copy(inttostr(ano),3,2);

     decodedate(strtodate(fim),ano,mes,dia);
     if length(inttostr(ano))=2 then fim:=inttostr(dia)+inttostr(mes)+inttostr(ano);
     if length(inttostr(ano))=4 then fim:=inttostr(dia)+inttostr(mes)+copy(inttostr(ano),3,2);


     comando:=inttostr(DAR_LeMF('6',Inicio,Fim,'1'));
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
end;

function LMFR(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='LEITURA DA MEM?RIA FISCAL POR REDU??O';
     Hdl := LoadLibrary(DLLECF);
     @DAR_AbreSerial := GetProcAddress(Hdl, 'DAR_AbreSerial');
     DAR_AbreSerial('COM'+inttostr(porta)+':9600,n,8,1');
     freelibrary(hdl);

     comando:='0';
     strpcopy(cmd,comando);
     log(func+' - Enviado (DARUMA):'+comando);
     enviacomando(porta,cmd);
     retorno:='.+';
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (DARUMA):'+retorno);

     Hdl := LoadLibrary(DLLECF);
     @DAR_FechaSerial := GetProcAddress(Hdl, 'DAR_FechaSerial');
     DAR_FechaSerial('1');
     freelibrary(hdl);
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
end.
