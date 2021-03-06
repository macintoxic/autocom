unit ECFDLL;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, stdctrls,Inifiles;
  
const
   dll = 'ECFAFRAC.DLL';


type

// declara??o das fun??es da dll da afrac
  tAFRAC_AbrirPorta                 = function (sPorta: pchar): Integer;  StdCall;
  tAFRAC_FecharPorta                =function(): integer; StdCall;
  tAFRAC_LeituraX                   =function(): Integer; StdCall;
  tAFRAC_ReducaoZ                   =function (Data: PChar): Integer; StdCall;
  tAFRAC_EmitirLeituraMemoriaFiscal =function (tipo, inicio, final: pchar): Integer; StdCall;
  tAFRAC_LerInformacaoImpressora    =function (CodInformacao: pchar; Retorno: pchar): integer; StdCall;
  tAFRAC_AbrirCupom                 =function (): Integer; StdCall;
  tAFRAC_VenderItem                 =function (Codigo, Descricao, Qtde, Valor_Unitario, Acres_desc, Perc_valor, Valor_acresdesc, Valor_total, Aliquota, Unidade, ForcarImpressaoUmaLinha: pchar): Integer; StdCall;
  tAFRAC_CancelarItem               =function (NumeroItem: pchar): Integer; StdCall;
  tAFRAC_FormaPagamento             =function  (FormaPagamento, Indice, Valor, Msg : pChar): Integer; StdCall;
  tAFRAC_InformarMensagemCupom      =function ( linhademensagem: pChar) : integer; StdCall;
  tAFRAC_InformarOperador           =function (Caixa: pChar) : integer; StdCall;
  tAFRAC_InformarVendedor           =function (vendedor: pChar) : integer; StdCall;

  tAFRAC_RetornarFeatures           =function (Retorno : Pchar) : integer; StdCall;

  tAFRAC_FecharCupom                =function (Vinculado, CupomAdicional: Pchar): Integer; StdCall;
  tAFRAC_AcrescimoDescontoItem      =function ( Acre_Desc, Perc_Valor, Valor : String; Descricao : PChar ):Integer; StdCall;
  tAFRAC_AcrescimoDescontoCupom     =function ( Acre_Desc, Perc_Valor, Valor, Descricao : PChar ):Integer; StdCall;
  tAFRAC_FecharAcrescimoDesconto    =function ( msgDesc, msgAcre, valor : pchar ): Integer; StdCall;
  tAFRAC_CancelarCupom              =function ():integer; StdCall;
  tAFRAC_AbrirVinculado             =function (coo, Formapagto, valor: PChar): Integer; StdCall;
  tAFRAC_ImprimirVinculado          =function (linha1, linha2: PChar):integer; StdCall;
  tAFRAC_FecharVinculado            =function () :integer; StdCall;
  tAFRAC_CancelarVinculado          =function (): integer; StdCall;
  tAFRAC_AbrirNaoFiscalNaoVinculado =function (): Integer; StdCall;
  tAFRAC_RegistrarNaoFiscal         =function (Indice, Valor, Mensagem: PChar):integer; StdCall;
  tAFRAC_CancelarNaoVinculado       =function ():integer; StdCall;
  tAFRAC_AbrirRelatorioGerencial    =function (Indice:PChar): Integer; StdCall;
  tAFRAC_ImprimirRelatorioGerencial =function (Linha:PChar): Integer; StdCall;
  tAFRAC_FecharRelatorioGerencial   =function (): Integer; StdCall;
  tAFRAC_PegarCodigoErro            =function (codigoErro, mensagem, acao_sugerida: pchar): Integer; StdCall;
  tAFRAC_VerificarEstado            =function (Retorno: pchar)  : Integer; StdCall;
  tAFRAC_Autenticar                 =function (linha, msg: pchar) : integer;  StdCall;
  tAFRAC_RepetirAutenticacao        =function (): integer;  StdCall;
  tAFRAC_GravarLeituraX             =function (nomearq: pChar) : integer;  StdCall;
  tAFRAC_GravarLeituraMemoriaFiscal =function (tipo, inicio, final, nomearq: pchar): Integer; StdCall;
  tAFRAC_LerAliquotas               =function  (Retorno: pchar) : Integer; StdCall;
  tAFRAC_LerTodasFormasPagamento    =function ( Retorno: pchar) : Integer; StdCall;
  tAFRAC_LerFormasDePagamento       =function ( indice, descricao: pchar) : Integer; StdCall;
  tAFRAC_LerValorTotalAliquotas     =function ( Retorno: pchar) : Integer; StdCall;
  tAFRAC_LerTotalizadoresNSICMS     =function ( Retorno: pchar) : Integer; StdCall;

  tAFRAC_LerValorTotalizadorNSICMS  =function (indice, descricao, valor: pchar) : Integer; StdCall;
  tAFRAC_LerValorFormaPagamento     =function (indice, descricao, valor: pchar) : Integer; StdCall;

  tAFRAC_ProgramarTributacao        =function (tributacao: pchar) : Integer; StdCall;
  tAFRAC_AjustarRelogio             =function (hora: pchar) : Integer; StdCall;
  tAFRAC_EntrarHorarioVerao         =function : Integer; StdCall;
  tAFRAC_SairHorarioVerao           =function : Integer; StdCall;
  tAFRAC_ChequeImprimir             =function (NumeroBanco, Valor, Favorecido, Cidade, Data, BomPara: Pchar) : Integer; StdCall;
  tAFRAC_AbrirGaveta                =function : Integer; StdCall;
  tAFRAC_VerificarGaveta            =function (estado: pchar): Integer; StdCall;
  tAFRAC_AbrirDia                   =function(Data : pchar): Integer; StdCall;


  TFafrac = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fafrac: TFafrac;
  func,comando:string;
  retorno:string;
  CMD:array [0..512] of char;
  AFRAC:Tinifile;
  COM_Port:array[0..19] of char;
  valor_ecf: array[0..15] of char;
  data_Ecf:array[0..7] of char;
  hndl:thandle;


// declara??o das fun??es da dll da afrac
  AFRAC_AbrirPorta: tAFRAC_AbrirPorta;
  AFRAC_FecharPorta:tAFRAC_FecharPorta;
  AFRAC_LeituraX:tAFRAC_LeituraX;
  AFRAC_ReducaoZ:tAFRAC_ReducaoZ;
  AFRAC_EmitirLeituraMemoriaFiscal:tAFRAC_EmitirLeituraMemoriaFiscal;
  AFRAC_LerInformacaoImpressora:tAFRAC_LerInformacaoImpressora;
  AFRAC_AbrirCupom:tAFRAC_AbrirCupom;
  AFRAC_VenderItem:tAFRAC_VenderItem;
  AFRAC_CancelarItem:tAFRAC_CancelarItem;
  AFRAC_FormaPagamento:tAFRAC_FormaPagamento;
  AFRAC_InformarMensagemCupom:tAFRAC_InformarMensagemCupom;
  AFRAC_InformarOperador:tAFRAC_InformarOperador;
  AFRAC_InformarVendedor:tAFRAC_InformarVendedor;

  AFRAC_RetornarFeatures:tAFRAC_RetornarFeatures;

  AFRAC_FecharCupom:tAFRAC_FecharCupom;
  AFRAC_AcrescimoDescontoItem:tAFRAC_AcrescimoDescontoItem;
  AFRAC_AcrescimoDescontoCupom:tAFRAC_AcrescimoDescontoCupom;
  AFRAC_FecharAcrescimoDesconto:tAFRAC_FecharAcrescimoDesconto;
  AFRAC_CancelarCupom:tAFRAC_CancelarCupom;
  AFRAC_AbrirVinculado:tAFRAC_AbrirVinculado;
  AFRAC_ImprimirVinculado:tAFRAC_ImprimirVinculado;
  AFRAC_FecharVinculado:tAFRAC_FecharVinculado;
  AFRAC_CancelarVinculado:tAFRAC_CancelarVinculado;
  AFRAC_AbrirNaoFiscalNaoVinculado:tAFRAC_AbrirNaoFiscalNaoVinculado;
  AFRAC_RegistrarNaoFiscal:tAFRAC_RegistrarNaoFiscal;
  AFRAC_CancelarNaoVinculado:tAFRAC_CancelarNaoVinculado;
  AFRAC_AbrirRelatorioGerencial:tAFRAC_AbrirRelatorioGerencial;
  AFRAC_ImprimirRelatorioGerencial:tAFRAC_ImprimirRelatorioGerencial;
  AFRAC_FecharRelatorioGerencial:tAFRAC_FecharRelatorioGerencial;
  AFRAC_PegarCodigoErro:tAFRAC_PegarCodigoErro;
  AFRAC_VerificarEstado:tAFRAC_VerificarEstado;
  AFRAC_Autenticar:tAFRAC_Autenticar;
  AFRAC_RepetirAutenticacao:tAFRAC_RepetirAutenticacao;
  AFRAC_GravarLeituraX:tAFRAC_GravarLeituraX;
  AFRAC_GravarLeituraMemoriaFiscal:tAFRAC_GravarLeituraMemoriaFiscal;
  AFRAC_LerAliquotas:tAFRAC_LerAliquotas;
  AFRAC_LerTodasFormasPagamento:tAFRAC_LerTodasFormasPagamento;
  AFRAC_LerFormasDePagamento:tAFRAC_LerFormasDePagamento;
  AFRAC_LerValorTotalAliquotas:tAFRAC_LerValorTotalAliquotas;
  AFRAC_LerTotalizadoresNSICMS:tAFRAC_LerTotalizadoresNSICMS;

  AFRAC_LerValorTotalizadorNSICMS:tAFRAC_LerValorTotalizadorNSICMS;
  AFRAC_LerValorFormaPagamento:tAFRAC_LerValorFormaPagamento;

  AFRAC_ProgramarTributacao:tAFRAC_ProgramarTributacao;
  AFRAC_AjustarRelogio:tAFRAC_AjustarRelogio;
  AFRAC_EntrarHorarioVerao:tAFRAC_EntrarHorarioVerao;
  AFRAC_SairHorarioVerao:tAFRAC_SairHorarioVerao;
  AFRAC_ChequeImprimir:tAFRAC_ChequeImprimir;
  AFRAC_AbrirGaveta:tAFRAC_AbrirGaveta;
  AFRAC_VerificarGaveta:tAFRAC_VerificarGaveta;
  AFRAC_AbrirDia:tAFRAC_AbrirDia;


implementation


{$R *.DFM}

procedure Enviacomando(p:integer;Comand:Pchar);
begin
// n?o usado
end;

function carrega_ini_bancos(banco:string):string;
var _AFRACbancos:Tinifile;
begin
     _AFRACbancos:=TIniFile.Create(extractfilepath(application.exename)+'dados\_AFRACbancos.INI');
     result:=_AFRACbancos.ReadString('BANCOS', banco, '60\07\05\10\07\20\');
     _AFRACbancos.Free;
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
     texto:=t1+'.'+t2;
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
           texto:=texto+'.';
           while length(t2)<d do t2:=t2+'0';
           texto:=texto+t2;
        end
     else
        begin
           t1:=copy(texto,1,posi-1);
           t2:=copy(texto,posi+1,d);
           while length(t2)<d do t2:=t2+'0';
           if length(t1)=0 then t1:='0';
           texto:=t1+'.'+t2;
        end;

     texto:=trim(texto);
     while length(texto)<10 do texto:='0'+texto;
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

procedure Log(texto:string); // monta o log de comandos e retornos.
var LOGfile:textfile;
begin
     AssignFile(LOGfile,extractfilepath(application.exename)+'_afrac.LOG');
     if not fileexists(extractfilepath(application.exename)+'_afrac.LOG') then Rewrite(logfile) else Reset(Logfile);
     Append(logfile);
     Writeln(logfile,datetimetostr(now)+' - '+texto);
     Flush(logfile);
     closefile(logfile);
end;

procedure espera_ecf(p:integer);
begin
//n?o utilizado
end;


function Prepara_Resp(tipo:integer;texto,texto2,continue:string):shortstring; // esta fun??o prepara a string de retorno da DLL para a aplica??o.
var c,m,a:string;
    coderr: array [0..5] of char;
    msg: array [0..80] of char;
    acsug : array [0..6] of char;
    hand:Thandle;
begin
     if strtoint(texto)=0 then
        begin
           retorno:='@'+texto2;
        end
     else
        begin
           hand:=LoadLibrary(DLL);
           @AFRAC_PegarCodigoErro:=GetProcAddress(Hand, 'AFRAC_PegarCodigoErro');
           if AFRAC_PegarCodigoErro(coderr,msg,acsug)=0 then //pega a mensagem de erro
              begin
                 c:=coderr;
                 m:=msg;
                 a:=acsug;
                 retorno:='#'+' ECF AFRAC'+chr(13)+' ERRO: '+c+' - '+m+' - '+a;
              end
           else
              begin
                 retorno:='#'+' ECF AFRAC'+chr(13)+' ERRO DLL: ECF NAO DETECTADO';
              end;
           FreeLibrary(Hand);
        end;
     result:=retorno;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//       Declara??es de fun??es de exporta??o da _afrac.DLL                                              //
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

     strpcopy(com_port,'COM'+inttostr(porta));

     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='Troca de operador';
     comando:=codigo;
     strpcopy(cmd,comando);
     log(func+' - Enviado (AFRAC):'+func+' :'+comando);

     @AFRAC_InformarOperador:=GetProcAddress(Hndl, 'AFRAC_InformarOperador');
     result:=Prepara_Resp(tipo,inttostr(AFRAC_InformarOperador(cmd)),'','');

     log(func+' - Recebido (AFRAC):'+retorno);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);

end;

function Abrecupom(tipo,porta:integer;texto:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));

     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);


     func:='Abertura de cupom';

     @AFRAC_AbrirCupom:=GetProcAddress(Hndl, 'AFRAC_AbrirCupom');
     result:=Prepara_Resp(tipo,inttostr(AFRAC_AbrirCupom),'','');

     log(func+' - Enviado (AFRAC):'+func);
     log(func+' - Recebido (AFRAC):'+retorno);


     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function AbreGaveta(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));

     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);


     func:='Abertura de Gaveta';

     @AFRAC_AbrirGaveta:=GetProcAddress(Hndl, 'AFRAC_AbrirGaveta');
     result:=Prepara_Resp(tipo,inttostr(AFRAC_AbrirGaveta),'','');

     log(func+' - Enviado (AFRAC):'+func);
     log(func+' - Recebido (AFRAC):'+retorno);
     espera_ecf(porta);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function AcreSub(tipo,porta:integer;val,tipacre:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  val -> valor do acrescimo
  tipoacre-> tipo de acrescimo. nao usado
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);


     func:='Acrescimo no subtotal';

     val:=strtovalor(2,val);

     strpcopy(valor_ecf,val);

     @AFRAC_AcrescimoDescontoCupom:=GetProcAddress(Hndl, 'AFRAC_AcrescimoDescontoCupom');
     result:=Prepara_Resp(tipo,inttostr(AFRAC_AcrescimoDescontoCupom('0','0',valor_ecf,'')),'','');


     log(func+' - Enviado (AFRAC):'+func+' :'+val);
     log(func+' - Recebido (AFRAC):'+retorno);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
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
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='Autenticacao';

     if repete='1'  then
        begin
           @AFRAC_RepetirAutenticacao:=GetProcAddress(Hndl, 'AFRAC_RepetirAutenticacao');
           result:=Prepara_Resp(tipo,inttostr(AFRAC_RepetirAutenticacao()),'','');

           log(func+' - Enviado (AFRAC):'+func);
           log(func+' - Recebido (AFRAC):'+retorno);
        end
     else
        begin
           comando:=codigo;
           strpcopy(cmd,comando);

           @AFRAC_Autenticar:=GetProcAddress(Hndl, 'AFRAC_Autenticar');
           result:=Prepara_Resp(tipo,inttostr(AFRAC_Autenticar('2', cmd)),'','');

           log(func+' - Enviado (AFRAC):'+func+' :'+comando);
           log(func+' - Recebido (AFRAC):'+retorno);
        end;

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);

end;

function Cancelacupom(tipo,porta:integer;venda,valor:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  Venda -> 1=envia comando para cencelamento dentro da venda. (AFRAC)
           0=envia comando para cancelamento fora da venda.
  Valor -> Valor da venda (AFRAC)
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='Cancela Cupom';

     @AFRAC_CancelarCupom:=GetProcAddress(Hndl, 'AFRAC_CancelarCupom');
     result:=Prepara_Resp(tipo,inttostr(AFRAC_CancelarCupom),'','');

     log(func+' - Enviado (AFRAC): '+func+' - '+venda);
     log(func+' - Recebido (AFRAC): '+retorno);
     espera_ecf(porta);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;


function CancItem(tipo,porta:integer;cod,nome,prtot,trib,ind:string):shortstring;
var indicador:array[0..5] of char;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  cod   -> C?digo do produto cancelado (AFRAC)
  nome  -> descricao do produto cancelado (AFRAC)
  prtot -> total do produto cancelado (AFRAC)
  trib  -> tributa??o do produto cancelado (AFRAC)
  ind   -> posi??o do produto no cupom fiscal
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='Cancelamento de item';
     strpcopy(indicador,ind);

     @AFRAC_CancelarItem:=GetProcAddress(Hndl, 'AFRAC_CancelarItem');
     result:=Prepara_Resp(tipo,inttostr(AFRAC_CancelarItem(indicador)),'','');

     log(func+' - Enviado (AFRAC):'+func+' - '+ind);
     log(func+' - Recebido (AFRAC):'+retorno);
     espera_ecf(porta);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function Descitem(tipo,porta:integer; val:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  val   -> Valor do desconto.
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='Desconto no item';

     val:=strtovalor(2,val);

     strpcopy(valor_ecf,val);

     @AFRAC_AcrescimoDescontoItem:=GetProcAddress(Hndl, 'AFRAC_AcrescimoDescontoItem');
     result:=Prepara_Resp(tipo,inttostr(AFRAC_AcrescimoDescontoItem('1','1',valor_ecf,'')),'','');

     log(func+' - Enviado (AFRAC):'+func+' - '+val);
     log(func+' - Recebido (AFRAC):'+retorno);
     espera_ecf(porta);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function DescSub(tipo,porta:integer; val:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  val   -> Valor do desconto
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='Desconto no subtotal';

     val:=strtovalor(2,val);

     strpcopy(valor_ecf,val);

     @AFRAC_AcrescimoDescontoCupom:=GetProcAddress(Hndl, 'AFRAC_AcrescimoDescontoCupom');
     result:=Prepara_Resp(tipo,inttostr(AFRAC_AcrescimoDescontoCupom('1','1',valor_ecf,'Desconto no subtotal')),'','');

     log(func+' - Enviado (AFRAC):'+func+' - '+val);
     log(func+' - Recebido (AFRAC):'+retorno);
     espera_ecf(porta);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function FecharCupom(tipo,porta:integer; SegCp,CNFV,l1,l2,l3,l4,l5,l6,l7,l8:string):shortstring;
var l01,l02,l03,l04,l05,l06,l07,l08:array[0..47] of char;
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
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='Fechamento de Cupom';
     strpcopy(l01,l1);
     strpcopy(l02,l2);
     strpcopy(l03,l3);
     strpcopy(l04,l4);
     strpcopy(l05,l5);
     strpcopy(l06,l6);
     strpcopy(l07,l7);
     strpcopy(l08,l8);

     @AFRAC_InformarMensagemCupom:=GetProcAddress(Hndl, 'AFRAC_InformarMensagemCupom');
     AFRAC_InformarMensagemCupom(l01);
     AFRAC_InformarMensagemCupom(l02);
     AFRAC_InformarMensagemCupom(l03);
     AFRAC_InformarMensagemCupom(l04);
     AFRAC_InformarMensagemCupom(l05);
     AFRAC_InformarMensagemCupom(l06);
     AFRAC_InformarMensagemCupom(l07);
     AFRAC_InformarMensagemCupom(l08);

     log(func+' - Enviado (AFRAC):'+func);
     log(func+' - Recebido (AFRAC):'+retorno);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function Finalizadia(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo     -> tipo de ECF
  porta    -> porta de comunica??o
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     strpcopy(data_ecf,formatdatetime('ddmmyyyy',date));

     func:='Reducao Z';
     @AFRAC_ReducaoZ:=GetProcAddress(Hndl, 'AFRAC_ReducaoZ');
     result:=Prepara_Resp(tipo,inttostr(AFRAC_ReducaoZ(data_Ecf)),'','');

     log(func+' - Enviado (AFRAC):'+func+'-'+formatdatetime('ddmmyyyy',date));
     log(func+' - Recebido (AFRAC):'+retorno);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
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

     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);


     if verao='0' then
        begin
           func:='Sair de hor?rio de ver?o';
           @AFRAC_SairHorarioVerao:=GetProcAddress(Hndl, 'AFRAC_SairHorarioVerao');
           retorno:=inttostr(AFRAC_SairHorarioVerao());
           log(func+' - Enviado (AFRAC):'+func);
           log(func+' - Recebido (AFRAC):'+retorno);
        end;
     if verao='1' then
        begin
           func:='Entrar em hor?rio de ver?o';
           @AFRAC_EntrarHorarioVerao:=GetProcAddress(Hndl, 'AFRAC_EntrarHorarioVerao');
           retorno:=inttostr(AFRAC_EntrarHorarioVerao());
           log(func+' - Enviado (AFRAC):'+func);
           log(func+' - Recebido (AFRAC):'+retorno);
        end;


     strpcopy(data_ecf,formatdatetime('ddmmyyyy',date));

     func:='Inicio do dia';
     @AFRAC_AbrirDia:=GetProcAddress(Hndl, 'AFRAC_AbrirDia');
     result:=Prepara_Resp(tipo,inttostr(AFRAC_AbrirDia(data_ecf)),'','');

     log(func+' - Enviado (AFRAC):'+func+'-'+formatdatetime('ddmmyyyy',date));
     log(func+' - Recebido (AFRAC):'+retorno);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function Lancaitem(tipo,porta:integer; cod, nome, qtde, prunit, prtot, Trib: string):shortstring;
var d:string;
    codigo:array[0..19] of char;
    descricao:array[0..199] of char;
    quantidade:array[0..15] of char;
    valor_unitario:array[0..15] of char;
    valor_total:array[0..15] of char;
    tributacao:array[0..4] of char;
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
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='Lanca item';
     d:=copy(qtde,1,1);
     delete(qtde,1,1);

     qtde:=strtovalor(3,qtde);

     if strtofloat(trim(qtde))=1 then qtde:='1';

     prunit:=strtovalor(strtoint(d),trim(prunit));

     prtot:=strtovalor(2,prtot);

     nome:=copy(nome,1,20);

     if (trib='T1') then trib:='MT01';
     if (trib='T2') then trib:='MT02';
     if (trib='T3') then trib:='MT03';
     if (trib='T4') then trib:='MT04';
     if (trib='T5') then trib:='MT05';
     if (trib='T6') then trib:='MT06';
     if (trib='T7') then trib:='MT07';
     if (trib='T8') then trib:='MT08';
     if (trib='T9') then trib:='MT09';
     if (trib='T10') then trib:='MT10';
     if (trib='T11') then trib:='MT11';
     if (trib='T12') then trib:='MT12';
     if (trib='T13') then trib:='MT13';
     if (trib='T14') then trib:='MT14';
     if (trib='T15') then trib:='MT15';
     if (trib='S1') then trib:='ST01';
     if (trib='S2') then trib:='ST02';
     if (trib='S3') then trib:='ST03';
     if (trib='S4') then trib:='ST04';
     if (trib='S5') then trib:='ST05';
     if (trib='S6') then trib:='ST06';
     if (trib='S7') then trib:='ST07';
     if (trib='S8') then trib:='ST08';
     if (trib='S9') then trib:='ST09';
     if (trib='S10') then trib:='ST10';
     if (trib='S11') then trib:='ST11';
     if (trib='S12') then trib:='ST12';
     if (trib='S13') then trib:='ST13';
     if (trib='S14') then trib:='ST14';
     if (trib='S15') then trib:='ST15';
     if (pos('I',trib)>0) then trib:='MI01';
     if (pos('F',trib)>0) then trib:='MF01';
     if (pos('N',trib)>0) then trib:='MN01';

     strpcopy(codigo,cod);
     strpcopy(descricao,nome);
     strpcopy(quantidade,qtde);
     strpcopy(valor_unitario,prunit);
     strpcopy(valor_total,prtot);
     strpcopy(tributacao,trib);

     @Afrac_VenderItem:=GetProcAddress(Hndl, 'AFRAC_VenderItem');
     result:=Prepara_Resp(tipo,inttostr(Afrac_VenderItem(codigo,descricao,quantidade,valor_unitario,'1','1','00000000000.00',valor_total,tributacao,'','0')),'','');

     log(func+' - Enviado (AFRAC):'+func+' - '+cod+','+nome+','+qtde+','+prunit+','+'1'+','+'1'+','+'00000000000.00'+','+prtot+','+trib+','+''+','+'0');
     log(func+' - Recebido (AFRAC):'+retorno);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function Notadecupom(tipo,porta:integer; ind,texto:string;abc:boolean):shortstring;
var vendedor:array[0..39] of char;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  ind    -> indicador a ser impresso no cupom   (n?o usado)
  texto  -> texto a ser impresso no cupom
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='Nota de Cupom';

     if abc=true then
        begin
           comando:='10';
           log(func+' - Enviado (AFRAC):'+comando);
           enviacomando(porta,cmd);
           log(func+' - Recebido (AFRAC):'+retorno);
        end;

     strpcopy(vendedor,texto);

     @AFRAC_InformarVendedor:=GetProcAddress(Hndl, 'AFRAC_InformarVendedor');
     result:=Prepara_Resp(tipo,inttostr(AFRAC_InformarVendedor(vendedor)),'','');

     log(func+' - Enviado (AFRAC):'+comando);
     log(func+' - Recebido (AFRAC):'+retorno);
     espera_ecf(porta);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function TextoNF(tipo,porta:integer;texto,valor:string):shortstring;
var linha:array[0..159] of char;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  texto  -> Texto a ser impresso.
  valor  -> Valor para CNFNV. Nos demais casos enviar nulo (AFRAC)
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     strpcopy(linha,texto);
     func:='Texto nao fiscal';
     @AFRAC_ImprimirRelatorioGerencial:=GetProcAddress(Hndl, 'AFRAC_ImprimirRelatorioGerencial');
     result:=Prepara_Resp(tipo,inttostr(AFRAC_ImprimirRelatorioGerencial(linha)),'','');

     log(func+' - Enviado (AFRAC):'+func+' - '+texto);
     log(func+' - Recebido (AFRAC):'+retorno);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function Totalizacupom(tipo,porta:integer;Moda,valor:string):shortstring;
var indice:array[0..1] of char;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunica??o
  Moda   -> C?digo da modalidade de pagamento
  valor  -> Valor recebido da modalidade de pagamento
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='Totaliza Cupom';
     moda:=enche(moda,'0',1,2);

     valor:=strtovalor(2,valor);

     strpcopy(indice,moda);
     strpcopy(valor_Ecf,valor);

     if moda<>'00' then
        begin
           @AFRAC_FormaPagamento:=GetProcAddress(Hndl, 'AFRAC_FormaPagamento');
           result:=Prepara_Resp(tipo,inttostr(AFRAC_FormaPagamento('',indice,valor_ecf,'')),'','');
           log(func+' - Enviado (AFRAC):'+func);
           log(func+' - Recebido (AFRAC):'+retorno);
        end
     else
        begin
           result:='.+';
        end;
     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);

end;

function LeituraX(tipo,porta:integer;NF:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  NF   -> 0=Imprime somente Leitura X
          1=Imprime leitura x e espera texto n?o fiscal
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));

     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='Leitura X';
     @Afrac_LeituraX:=GetProcAddress(Hndl, 'AFRAC_LeituraX');
     log(func+' - Enviado (AFRAC):'+func);
     retorno:=inttostr(Afrac_LeituraX);
     log(func+' - Recebido (AFRAC):'+retorno);
     result:=Prepara_Resp(tipo,retorno,'','');


     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function Venda_liquida(tipo,porta:integer):shortstring;
var ret:array[0..300] of char;
    r:string;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='Venda Liquida';
     @AFRAC_LerInformacaoImpressora:=GetProcAddress(Hndl, 'AFRAC_LerInformacaoImpressora');
     retorno:=inttostr(AFRAC_LerInformacaoImpressora('001',ret));

     r:=ret;
     while pos('.',r)>0 do delete(r,pos('.',r),1);
     r:=copy(r,3,12);
     result:=Prepara_Resp(tipo,retorno,r,'');
     log(func+' - Enviado (AFRAC):'+func+' - '+r);
     log(func+' - Recebido (AFRAC):'+retorno);
     espera_ecf(porta);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function COO(tipo,porta:integer;tipo_coo:string):shortstring;
var ret:array[0..300] of char;
    v_coo:string;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  tipo_coo -> 0 = ultimo emitido
              1 = atual
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='COO';
     @AFRAC_LerInformacaoImpressora:=GetProcAddress(Hndl, 'AFRAC_LerInformacaoImpressora');
     retorno:=inttostr(AFRAC_LerInformacaoImpressora('023',ret));
     v_coo:=ret;

     result:=Prepara_Resp(tipo,retorno,v_coo,'');
     log(func+' - Enviado (AFRAC): '+func);
     log(func+' - Recebido (AFRAC):'+v_coo);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function Sangria(tipo,porta:integer;modal,valor:string):shortstring;
var t:array[0..29] of char;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  modal -> C?digo da modalidade de pagamento.
  valor -> Valor da Sangria.
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='Sangria - Abrir comprovante n?o fiscal n?o vinculado';
     @AFRAC_AbrirNaoFiscalNaoVinculado:=GetProcAddress(Hndl, 'AFRAC_AbrirNaoFiscalNaoVinculado');
     retorno:=inttostr(AFRAC_AbrirNaoFiscalNaoVinculado);

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Enviado (AFRAC): '+func);
     log(func+' - Recebido (AFRAC):'+retorno);

     valor:=strtovalor(2,trim(valor));
     strpcopy(valor_ecf,valor);
     strpcopy(t,'Sangria: Finalizadora: '+modal);

     func:='Sangria - Registrar n?o fiscal';
     @AFRAC_RegistrarNaoFiscal:=GetProcAddress(Hndl, 'AFRAC_RegistrarNaoFiscal');
     retorno:=inttostr(AFRAC_RegistrarNaoFiscal('02',valor_ecf,t));

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Enviado (AFRAC): '+func);
     log(func+' - Recebido (AFRAC):'+retorno);

     func:='Sangria - Fechar Vinculado';
     @AFRAC_FecharVinculado:=GetProcAddress(Hndl, 'AFRAC_FecharVinculado');
     retorno:=inttostr(AFRAC_FecharVinculado);

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Enviado (AFRAC): '+func);
     log(func+' - Recebido (AFRAC):'+retorno);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function FCX(tipo,porta:integer;modal,valor:string):shortstring;
var t:array[0..29] of char;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  modal -> C?digo da modalidade de pagamento.
  valor -> Valor do fundo de caixa.
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='Fundo de caixa - Abrir comprovante n?o fiscal n?o vinculado';
     @AFRAC_AbrirNaoFiscalNaoVinculado:=GetProcAddress(Hndl, 'AFRAC_AbrirNaoFiscalNaoVinculado');
     retorno:=inttostr(AFRAC_AbrirNaoFiscalNaoVinculado);

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Enviado (AFRAC): '+func);
     log(func+' - Recebido (AFRAC):'+retorno);

     valor:=strtovalor(2,trim(valor));
     strpcopy(valor_ecf,valor);
     strpcopy(t,'Sangria: Finalizadora: '+modal);

     func:='Fundo de caixa - Registrar n?o fiscal';
     @AFRAC_RegistrarNaoFiscal:=GetProcAddress(Hndl, 'AFRAC_RegistrarNaoFiscal');
     retorno:=inttostr(AFRAC_RegistrarNaoFiscal('01',valor_ecf,t));

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Enviado (AFRAC): '+func);
     log(func+' - Recebido (AFRAC):'+retorno);

     func:='Fundo de caixa - Fechar Vinculado';
     @AFRAC_FecharVinculado:=GetProcAddress(Hndl, 'AFRAC_FecharVinculado');
     retorno:=inttostr(AFRAC_FecharVinculado);

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Enviado (AFRAC): '+func);
     log(func+' - Recebido (AFRAC):'+retorno);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function Cheque(tipo,porta:integer;banco,valor,data,favorecido,municipio,cifra,moedas,moedap:string):shortstring;
var obs:string;
    dia,mes,ano:word;
    modelo: array [1..10] of integer; //modelos que tem impress?o de cheques
    ok:boolean;
    a:integer;
    ms,mp:array[0..19] of char;

    ebanco:array[0..2] of char;
    efavorecido:array[0..79] of char;
    emunicipio:array[0..29] of char;
    edata:array[0..7] of char;
    eobs:array[0..119] of char;
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
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='Impress?o de cheque - Programa moeda';

     strpcopy(ms,moedas);
     strpcopy(mp,moedap);

//     retorno:=inttostr(AFRAC_ChequeProgramarMoeda(ms,mp));
//     result:=Prepara_Resp(tipo,retorno,'','');
//     log(func+' - Enviado (AFRAC): '+func);
//     log(func+' - Recebido (AFRAC):'+retorno);


     Obs:=copy(favorecido,pos('|',favorecido)+1,length(favorecido));
     delete(favorecido,pos('|',favorecido),length(favorecido));
     valor:=strtovalor(2,valor);

     decodedate(strtodate(data),ano,mes,dia);
     if length(inttostr(ano))=2 then data:=enche(inttostr(dia),'0',1,2)+enche(inttostr(mes),'0',1,2)+enche(inttostr(ano),'0',1,2);
     if length(inttostr(ano))=4 then data:=enche(inttostr(dia),'0',1,2)+enche(inttostr(mes),'0',1,2)+enche(copy(inttostr(ano),3,2),'0',1,2);


     strpcopy(valor_ecf,valor);
     strpcopy(ebanco,banco);
     strpcopy(efavorecido,favorecido);
     strpcopy(emunicipio,municipio);
     strpcopy(edata,data);
     strpcopy(eobs,obs);

     func:='Impress?o de cheque - Impress?o';
     @AFRAC_ChequeImprimir:=GetProcAddress(Hndl, 'AFRAC_ChequeImprimir');
     retorno:=inttostr(AFRAC_ChequeImprimir(ebanco,valor_ecf,efavorecido,emunicipio,edata,eobs));

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Enviado (AFRAC): '+func);
     log(func+' - Recebido (AFRAC):'+retorno);

//     func:='Fundo de caixa - Expulsar o cheque da impressora';
//     retorno:=inttostr(AFRAC_ChequeExpulsar);
//     result:=Prepara_Resp(tipo,retorno,'','');
//     log(func+' - Enviado (AFRAC): '+func);
//     log(func+' - Recebido (AFRAC):'+retorno);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;


function Contra_vale(tipo,porta:integer;valor:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
  valor -> Valor do contra-vale.
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='Contra-vale - Abrir comprovante n?o fiscal n?o vinculado';
     @AFRAC_AbrirNaoFiscalNaoVinculado:=GetProcAddress(Hndl, 'AFRAC_AbrirNaoFiscalNaoVinculado');
     retorno:=inttostr(AFRAC_AbrirNaoFiscalNaoVinculado);

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Enviado (AFRAC): '+func);
     log(func+' - Recebido (AFRAC):'+retorno);

     valor:=copy(valor,1,pos('|',valor)-1);

     strpcopy(valor_ecf,valor);

     func:='Contra-vale - Registrar n?o fiscal';
     @AFRAC_RegistrarNaoFiscal:=GetProcAddress(Hndl, 'AFRAC_RegistrarNaoFiscal');
     retorno:=inttostr(AFRAC_RegistrarNaoFiscal('03',valor_ecf,'CONTRA-VALE'));

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Enviado (AFRAC): '+func);
     log(func+' - Recebido (AFRAC):'+retorno);

     func:='Contra-vale - Fechar Vinculado';
     @AFRAC_FecharVinculado:=GetProcAddress(Hndl, 'AFRAC_FecharVinculado');
     retorno:=inttostr(AFRAC_FecharVinculado);

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Enviado (AFRAC): '+func);
     log(func+' - Recebido (AFRAC):'+retorno);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function cnfv(tipo,porta:integer) : shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}

     strpcopy(com_port,'COM'+inttostr(porta));
     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='CNFV - Abrir comprovante n?o fiscal vinculado';
     @AFRAC_AbrirVinculado:=GetProcAddress(Hndl, 'AFRAC_AbrirVinculado');
     retorno:=inttostr(AFRAC_AbrirVinculado('9999','TEF TESTE','00000000000000.00'));

     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Enviado (AFRAC): '+func);
     log(func+' - Recebido (AFRAC):'+retorno);

     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);
end;

function ECF_INFO(tipo,porta:integer):shortstring;
var c,d,e,f,g,h,i,j,k,l,m,n:string;
    resp_ecf:array[0..300] of char;
    gav:array [0..1] of char;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     strpcopy(com_port,'COM'+inttostr(porta));

     hndl:=LoadLibrary(DLL);
     @AFRAC_AbrirPorta:=GetProcAddress(Hndl, 'AFRAC_AbrirPorta');
     AFRAC_AbrirPorta(com_port);

     func:='ECF INFO - numero do ECF';
     @AFRAC_LerInformacaoImpressora:=GetProcAddress(Hndl, 'AFRAC_LerInformacaoImpressora');
     retorno:=inttostr(AFRAC_LerInformacaoImpressora('015',resp_ecf));
     log(func+' - Enviado (AFRAC): '+func);
     d:=resp_ecf;
     log(func+' - Recebido (AFRAC):'+retorno+' - '+d);
     d:=copy(d,2,4);

     func:='ECF INFO - Situa??o do dia';
     @AFRAC_VerificarEstado:=GetProcAddress(Hndl, 'AFRAC_VerificarEstado');
     retorno:=inttostr(AFRAC_VerificarEstado(gav));
     log(func+' - Enviado (AFRAC): '+func);
     c:=gav;
     log(func+' - Recebido (AFRAC):'+retorno+' - '+c);
     c:=copy(c,1,1);
     if c='A' then c:='0';
     if c='P' then c:='1';
     if (c<>'A') and (c<>'P') then c:='2';
     e:='1';
     f:='1';

     func:='ECF INFO - Situa??o da Gaveta';
     @AFRAC_VerificarGaveta:=GetProcAddress(Hndl, 'AFRAC_VerificarGaveta');
     retorno:=inttostr(AFRAC_VerificarGaveta(gav));
     log(func+' - Enviado (AFRAC): '+func);
     g:=gav;
     log(func+' - Recebido (AFRAC):'+retorno+' - '+g);
     g:=copy(g,1,1);
     if g='A' then g:='1';
     if g='F' then g:='0';
     h:='0';
     i:='000000';

     func:='ECF INFO - Coo final';
     @AFRAC_LerInformacaoImpressora:=GetProcAddress(Hndl, 'AFRAC_LerInformacaoImpressora');
     retorno:=inttostr(AFRAC_LerInformacaoImpressora('023',resp_ecf));
     log(func+' - Enviado (AFRAC): '+func);
     j:=resp_ecf;
     log(func+' - Recebido (AFRAC):'+retorno+' - '+j);

     func:='ECF INFO - Numero de redu??es';
     @AFRAC_LerInformacaoImpressora:=GetProcAddress(Hndl, 'AFRAC_LerInformacaoImpressora');
     retorno:=inttostr(AFRAC_LerInformacaoImpressora('013',resp_ecf));
     log(func+' - Enviado (AFRAC): '+func);
     k:=resp_ecf;
     log(func+' - Recebido (AFRAC):'+retorno+' - '+k);
     k:=copy(k,2,4);

     l:='000000000000';

     func:='ECF INFO - Gt final';
     @AFRAC_LerInformacaoImpressora:=GetProcAddress(Hndl, 'AFRAC_LerInformacaoImpressora');
     retorno:=inttostr(AFRAC_LerInformacaoImpressora('007',resp_ecf));
     log(func+' - Enviado (AFRAC): '+func);
     m:=resp_ecf;
     log(func+' - Recebido (AFRAC):'+retorno+' - '+m);
     m:=copy(m,3,13);
     delete(m,pos('.',m),1);

     func:='ECF INFO - N?mero de S?rie';
     @AFRAC_LerInformacaoImpressora:=GetProcAddress(Hndl, 'AFRAC_LerInformacaoImpressora');
     retorno:=inttostr(AFRAC_LerInformacaoImpressora('002',resp_ecf));
     n:=resp_ecf;
     log(func+' - Recebido (AFRAC):'+retorno+' - '+n);


     result:=Prepara_Resp(tipo,retorno,d+c+e+f+g+h+i+j+k+l+m+n,'');
     log(func+' - Enviado (AFRAC): ECF_INFO');
     log(func+' - Recebido (AFRAC):'+d+c+e+f+g+h+i+j+k+l+m+n);


     @AFRAC_FecharPorta:=GetProcAddress(Hndl, 'AFRAC_FecharPorta');
     AFRAC_FecharPorta;
     FreeLibrary(Hndl);

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
var ano,mes,dia:word;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='LEITURA DA MEM?RIA FISCAL POR DATA';

end;

function LMFR(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='LEITURA DA MEM?RIA FISCAL POR REDU??O';

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
    LMMM index 27,
    cnfv index 28;
end.
