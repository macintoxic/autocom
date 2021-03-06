unit ECFDLL;

interface

uses
  SysUtils,Forms,inifiles;

// declara??o das fun??es da dll da ncr
  function SendCmd(cmd:string;Rsp:pchar;rsplen:longint):longint;stdcall;
  external 'ecfdll32' name '_IF_SendCmd@12';
  function SetCommPort(porta:integer):longint;stdcall;
  external 'ecfdll32' name '_IF_SetCommPort@4';



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
  ncr:Tinifile;

implementation

{$R *.DFM}

procedure Enviacomando(p:integer;Comand:Pchar);
VAR i:integer;
    rsp:array [0..512] of char;
begin
     i:=SetCommPort(P);
     if i=0 then
        begin
           i:=SendCmd(strpas(comand),rsp,250);
           if i=32 then retorno:='.-RESERVADO PARA O FUTURO';
           if i=33 then retorno:='.-HORA / DATA NAO INICIALIZADAS';
           if i=34 then retorno:='.-FIM DO PAPEL';
           if i=35 then retorno:='.-INICIALIZACAO IMCOMPLETA';
           if i=36 then retorno:='.-NUMEROS NAO PERMITIDOS NESTE CAMPO';
           if i=37 then retorno:='.-FUNCAO NAO PERMITIDA SEM INICIO DE OPERACAO FISCAL';
           if i=38 then retorno:='.-VALOR DA VENDA MAIOR QUE O PERMITIDO';
           if i=39 then retorno:='.-TIME-OUT NA COMUNICACAO COM O IMPRESSOR';
           if i=40 then retorno:='.-IMPRESSAO ABORTADA PELO USUARIO';
           if i=41 then retorno:='.-MEMORIA FISCAL ESGOTADA';
           if i=42 then retorno:='.-NAO HA REDUCOES NO INTERVALO PEDIDO';
           if i=43 then retorno:='.-TAMANHO MAXIMO DO VALOR INVALIDO';
           if i=44 then retorno:='.-DSR DESABILITADO NA TRANSMISSAO DO IMPRESSOR';
           if i=45 then retorno:='.-SEM PAPEL NA AUTENTICACAO';
           if i=46 then retorno:='.-DSR DESABILITADO NA TRANMISSAO PARA O PC';
           if i=47 then retorno:='.-DATA MAIOR QUE A DA MEMORIA FISCAL';
           if i=48 then retorno:='.-CARACTER INVALIDO NA TABELA DE TRIBUTACOES RESERVADAS';
           if i=49 then retorno:='.-TABELA DE TOTALIZADORES RESERVADOS NAO INICIALIZADA';
           if i=50 then retorno:='.-TABELA DE TRIBUTACOES VALIDAS NAO INICIALIZADAS';
           if i=51 then retorno:='.-FUNCAO NAO PERMITIDA APOS O INICIO DO DIA';
           if i=52 then retorno:='.-CONSTANTES NAO INICIALIZADAS';
           if i=53 then retorno:='.-CNPJ, I.E. E I.M. NAO INICIALIZADOS';
           if i=54 then retorno:='.-IDENTIFICACAO DA MOEDA NAO INICIALIZADA';
           if i=55 then retorno:='.-NUMERO DE DIGITOS DO VALOR NAO INICIALIZADOS';
           if i=56 then retorno:='.-TABELA DE ALIQUOTAS NAO INICIALIZADA';
           if i=57 then retorno:='.-NAO E PERMITIDO O REINICIO DO DIA APOS A REDUCAO Z';
           if i=58 then retorno:='.-PAGAMENTO EXCEDEU O TOTAL DA VENDA';
           if i=59 then retorno:='.-FUNCAO NAO PERMITIDA SEM FORMA DE PAGAMENTO';
           if i=60 then retorno:='.-QUEDA DE ENERGIA DURANTE A EXECUCAO DO COMANDO';
           if i=61 then retorno:='.+'+strpas(rsp);
           if i=62 then retorno:='.-IMPRESSORA NAO INICIALIZADA';
           if i=63 then retorno:='.-CHEQUE N?O IMPRESSO NESTE MODELO';
           if i=64 then retorno:='.-RESERVADO PARA O FUTURO';
           if i=65 then retorno:='.-FUNCAO NAO PERMITIDA APOS TOTALIZACAO';
           if i=66 then retorno:='.-DESCONTO SEM VENDA OU NAO PERMITIDO NESTA CONDICAO';
           if i=67 then retorno:='.-VALOR DO DESCONTO DE ITEM MAIOR OU IGUAL AO VALOR DO ITEM';
           if i=68 then retorno:='.-CANCELAMENTO SEM VENDA OU NAO PERMITIDO NESTE CONDICAO';
           if i=69 then retorno:='.-VALOR DO CANCELAMENTO DIFERENTE DO VALOR APURADO';
           if i=70 then retorno:='.-MAIS DE UM DESCONTO APLICADO. VENDA NAO PODE SER CANCELA';
           if i=71 then retorno:='.-CANCELAMENTO DE DESCONTO SEM DESCONTO APLICADO';
           if i=72 then retorno:='.-TOTAL DA OPERACAO IGUAL A ZERO';
           if i=73 then retorno:='.-VALOR DO DESCONTO EM SUBTOTAL MAIOR OU IGUAL AO VALOR DA VENDA';
           if i=74 then retorno:='.-VENDA DE PRODUTO COM VALOR IGUAL A ZERO';
           if i=75 then retorno:='.-VALOR TOTAL INFORMADO DIFERENTE DE VALOR APURADO';
           if i=76 then retorno:='.-NAO SAO PERMITIDOS MAIS COMENTARIOS';
           if i=77 then retorno:='.-FUNCAO NAO PERMITIDA SEM INICIO DE OPERACAO FISCAL OU NAO-FISCAL';
           if i=78 then retorno:='.-NAO EXISTE CUPOM PARA AUTENTICAR';
           if i=79 then retorno:='.-FUNCAO NAO PERMITIDA SEM TOTALIZACAO';
           if i=80 then retorno:='.-MEMORIA FISCAL NAO DISPONIVEL';
           if i=81 then retorno:='.-MENSAGEM INVALIDA';
           if i=82 then retorno:='.-EQUIPAMENTO NECESSITA INTERVENCAO TECNICA';
           if i=83 then retorno:='.-NAO EXISTE MAS ESPACO PARA ESTA ALTERACAO NA EPROM';
           if i=84 then retorno:='.-FUNCAO NAO PERMITIDA SEM STATUS DE INTERVENCAO';
           if i=85 then retorno:='.-CAMPO NUMERICO INVALIDO';
           if i=86 then retorno:='.-FUNCAO INEXISTENTE';
           if i=87 then retorno:='.-FUNCAO NAO PERMITIDA SEM INICIO DO DIA';
           if i=88 then retorno:='.-HORA / DATA INVALIDA';
           if i=89 then retorno:='.-FUNCAO NAO PERMITIDA DURANTE OPERACAO FISCAL NAO-FISCAL';
           if i=90 then retorno:='.-FUNCAO NAO PERMITIDA COM STATUS DE INTERVENCAO';
           if i=91 then retorno:='.-DESCRICAO DOS TOTALIZADORES DOS COMPROVANTES NAO-FISCAIS NAO INICIALIZADOS';
           if i=92 then retorno:='.-NECESSITA REDUCAO Z';
           if i=93 then retorno:='.-PALAVRA DE USO EXCLUSIVO DO FIRMWARE FISCAL';
           if i=94 then retorno:='.-SITUACAO TRIBUTARIA INVALIDA';
           if i=95 then retorno:='.-VALOR TOTAL DO ITEM DIFERENTE DO APURADO';
           if i=96 then retorno:='.-NECESSITA TOTALIZAR TRANSACAO';
           if i=-1 then
              begin
                 if length(strpas(rsp))<1 then retorno:='.-'+strpas(rsp) else retorno:='.+'+strpas(rsp);
              end;
           if i=-2 then retorno:='.-IMPRESSORA NAO RESPONDE porta '+inttostr(p);
           if i=0  then retorno:='.+'+strpas(RSP);
        end
     else
        begin
           retorno:='.-Erro na abertura da porta de comunica??o. COM'+inttostr(p);
        end;
end;

function carrega_ini_bancos(banco:string):string;
var _ncrbancos:Tinifile;
begin
     _ncrbancos:=TIniFile.Create(extractfilepath(application.exename)+'dados\_ncrbancos.INI');
     result:=_ncrbancos.ReadString('BANCOS', banco, '60\07\05\10\07\20\');
     _ncrbancos.Free;
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

procedure Log(texto:string); // monta o log de comandos e retornos.
var LOGfile:textfile;
begin
     AssignFile(LOGfile,extractfilepath(application.exename)+'_ncr.LOG');
     if not fileexists(extractfilepath(application.exename)+'_ncr.LOG') then Rewrite(logfile) else Reset(Logfile);
     Append(logfile);
     Writeln(logfile,datetimetostr(now)+' - '+texto);
     Flush(logfile);
     closefile(logfile);
end;

procedure espera_ecf(p:integer);
var i:Tdatetime;
begin
     i:=time;
     while (time-i)<=strtotime('00:03:00') do // time-out para liberar
        begin
           comando:='30';
           strpcopy(cmd,comando);
           enviacomando(p,cmd);
           if copy(retorno,1,2)='.+' then break;
        end;
     retorno:='';
end;


function Prepara_Resp(tipo:integer;texto,texto2,continue:string):shortstring; // esta fun??o prepara a string de retorno da DLL para a aplica??o.
var t:string;
    r:string;
begin
     t:=texto;
     texto:='#'+continue+' ECF NCR'+chr(13)+' ERRO: '+texto;
     texto2:='@'+texto2;
     if copy(t,1,2)<>'.+' then r:=texto else r:=texto2;
     result:=r;
end;

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//       Declara??es de fun??es de exporta??o da _nCR.DLL                                               //
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
     comando:='07'+codigo;
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
     espera_ecf(porta);
     try
        ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
        ncr.writeString('CONTROLE', 'coo', '');
        ncr.writeString('CONTROLE', '_coo', '');
     finally
        ncr.Free;
     end;
end;

function Abrecupom(tipo,porta:integer;texto:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Abertura de cupom';
     comando:='10';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
     espera_ecf(porta);
     try
        ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
        ncr.writeString('CONTROLE', 'coo', '');
        ncr.writeString('CONTROLE', '_coo', '');
     finally
        ncr.Free;
     end;

end;

function AbreGaveta(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Abertura de Gaveta';
     comando:='21';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
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

     comando:='24'+val;
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
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

//{tipo para a NCR 20} -> 'NCR - IF-7141 Duas Esta??es v2.00'
//{tipo para a NCR 21} -> 'NCR - IF-7140 Duas Esta??es v2.00'
//{tipo para a NCR 22} -> 'NCR - IF-7140 Uma Esta??o v2.00'

     if tipo=22  then
        begin
           comando:='05'+COPY(codigo,1,8); //N?o permite a segunda linha para modelo de 1 esta??o
        end
     else
        begin
           comando:='05 \'+COPY(codigo,1,40);
        end;

     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
end;

function Cancelacupom(tipo,porta:integer;venda,valor:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  Venda -> 1=envia comando para cencelamento dentro da venda. (NCR)
           0=envia comando para cancelamento fora da venda.
  Valor -> Valor da venda (NCR)
=========================================================}
     func:='Cancela Cupom';

     valor:=strtovalor(2,valor);
     while pos(',',valor)>0 do delete(valor,pos(',',valor),1);
     while pos('.',valor)>0 do delete(valor,pos('.',valor),1);

     if venda='0' then comando:='02'+valor;
     if venda='1' then comando:='18';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
     espera_ecf(porta);

     if venda='0' then
        begin
           try
              ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
              ncr.writeString('CONTROLE', 'coo', '');
              ncr.writeString('CONTROLE', '_coo', '');
           finally
              ncr.Free;
           end;
        end;
end;

function CancItem(tipo,porta:integer;cod,nome,prtot,trib,ind:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunica??o
  cod   -> C?digo do produto cancelado (NCR)
  nome  -> descricao do produto cancelado (NCR)
  prtot -> total do produto cancelado (NCR)
  trib  -> tributa??o do produto cancelado (NCR)
  ind   -> posi??o do produto no cupom fiscal (nao usado)
=========================================================}
     func:='Cancelamento de item';
     while copy(prtot,1,1)='0' do delete(prtot,1,1);
     nome:=copy(nome,1,20);

     comando:='22'+cod+'\'+nome+'\'+prtot+'\'+trim(trib);
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
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

     comando:='12'+val;
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
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

     comando:='13'+val;
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
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
     func:='Fechamento de Cupom';
     if l8<>'' then teste:='\'+l8+teste;
     if l7<>'' then teste:='\'+l7+teste;
     if l6<>'' then teste:='\'+l6+teste;
     if l5<>'' then teste:='\'+l5+teste;
     if l4<>'' then teste:='\'+l4+teste;
     if l3<>'' then teste:='\'+l3+teste;
     if l2<>'' then teste:='\'+l2+teste;
     if l1<>'' then teste:='\'+l1+teste;
     comando:='19'+segcp+teste;
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
     espera_ecf(porta);
end;

function Finalizadia(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo     -> tipo de ECF
  porta    -> porta de comunica??o
=========================================================}
     func:='Reducao Z';
     comando:='090';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
     espera_ecf(porta);
     try
        ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
        ncr.writeString('CONTROLE', 'coo', '');
        ncr.writeString('CONTROLE', '_coo', '');
     finally
        ncr.Free;
     end;
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
     comando:='01'+verao+'\'+op+'\0';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
     espera_ecf(porta);
     try
        ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
        ncr.writeString('CONTROLE', 'coo', '');
        ncr.writeString('CONTROLE', '_coo', '');
     finally
        ncr.Free;
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
  prtot  -> pre?o total do produto
  trib   -> tributa??o do produto
=========================================================}
     func:='Lanca item';
     d:=copy(qtde,1,1);
     delete(qtde,1,1);

     qtde:=strtoquant(trim(qtde));

     if strtofloat(trim(qtde))=1 then qtde:='1';

     prunit:=strtovalor(strtoint(d),trim(prunit));

     prtot:=strtovalor(2,prtot);
     while pos(',',prtot)>0 do delete(prtot,pos(',',prtot),1);
     while pos('.',prtot)>0 do delete(prtot,pos('.',prtot),1);

     nome:=copy(nome,1,20);

     comando:='11'+cod+'\'+nome+'\'+qtde+'\'+prunit+'\'+prtot+'\'+trim(trib);
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
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

     if abc=true then
        begin
           comando:='10';
           strpcopy(cmd,comando);
           log(func+' - Enviado (NCR):'+comando);
           enviacomando(porta,cmd);
           log(func+' - Recebido (NCR):'+retorno);
           try
              ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
              ncr.writeString('CONTROLE', 'coo', '');
              ncr.writeString('CONTROLE', '_coo', '');
           finally
              ncr.Free;
           end;
        end;
     comando:='03'+texto;
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
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
     comando:='08'+texto;
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
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

     if moda='00' then comando:='14'+valor;
     if moda<>'00' then comando:='25'+moda+'\'+valor;
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
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
     comando:='70'+NF;
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
     espera_ecf(porta);
     try
        ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
        ncr.writeString('CONTROLE', 'coo', '');
        ncr.writeString('CONTROLE', '_coo', '');
     finally
        ncr.Free;
     end;
end;

function Venda_liquida(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Venda Liquida';
     comando:='30';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,copy(retorno,15,12),'');
     log(func+' - Recebido (NCR):'+retorno);
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
     comando:='38';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);

     try
        ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
        c:=ncr.ReadString('CONTROLE', 'coo', '');
     finally
        ncr.Free;
     end;

     if c='' then
        begin
           try
              ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
              c:=ncr.ReadString('CONTROLE', '_coo', '');
           finally
              ncr.Free;
           end;
        end;

     if c='' then
        begin
           enviacomando(porta,cmd);
           c:=copy(retorno,20,6);
           //     if tipo_coo='1' then c:=inttostr(strtoint(c)+1);
           // por Helder Frederico - 20/09/2001
           //  Retirei a condi??o de atual ou ?ltimo emitido, pois no ECF
           // NCR, utilizando o comando 38, j? retorna o coo do cupom de venda
           // atual, diferente dos outros ECf que retornam somente o ?ltimo q foi emitido.
           if c='' then
             begin
                try
                   ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
                   c:=ncr.ReadString('CONTROLE', '_coo', '0');
                finally
                   ncr.Free;
                end;
                if (strtoint(c)+1)=1000 then c:='1' else c:=inttostr(strtoint(c)+1);
                c:=formatdatetime('yymmdd',date)+enche(c,'0',1,4);
                try
                   ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
                   ncr.writeString('CONTROLE', '_coo', c);
                finally
                   ncr.Free;
                end;
                result:=Prepara_Resp(tipo,'.+',c,'');
                log(func+' - Recebido (NCR):'+'.+ini_ok ['+c+']');
             end
           else
              begin
                 try
                    ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
                    ncr.writeString('CONTROLE', 'coo', c);
                 finally
                    ncr.Free;
                 end;
                 result:=Prepara_Resp(tipo,retorno,c,'');
                 log(func+' - Recebido (NCR):'+retorno);
              end;
        end
     else
        begin
           result:=Prepara_Resp(tipo,'.+',c,'');
           log(func+' - Recebido (NCR):'+'.+ini_ok ['+c+']');
        end;
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
     comando:='04X1';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     log(func+' - Recebido (NCR):'+Prepara_Resp(tipo,retorno,'',''));

     espera_ecf(porta);
     comando:='190\Sangria - Finalizadora : '+modal+strtovalor(2,trim(valor));
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
     espera_ecf(porta);
     try
        ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
        ncr.writeString('CONTROLE', 'coo', '');
        ncr.writeString('CONTROLE', '_coo', '');
     finally
        ncr.Free;
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
     comando:='04X2';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     log(func+' - Recebido (NCR):'+Prepara_Resp(tipo,retorno,'',''));

     espera_ecf(porta);
     comando:='190\Fundo de Caixa: '+strtovalor(2,trim(valor));
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
     espera_ecf(porta);
     try
        ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
        ncr.writeString('CONTROLE', 'coo', '');
        ncr.writeString('CONTROLE', '_coo', '');
     finally
        ncr.Free;
     end;
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
           Obs:=copy(favorecido,pos('|',favorecido)+1,length(favorecido));
           delete(favorecido,pos('|',favorecido),length(favorecido));
           valor:=strtovalor(2,valor);
           while pos(',',valor)>0 do delete(valor,pos(',',valor),1);
           while pos('.',valor)>0 do delete(valor,pos('.',valor),1);

           decodedate(strtodate(data),ano,mes,dia);
           if length(inttostr(ano))=2 then data:=enche(inttostr(dia),'0',1,2)+enche(inttostr(mes),'0',1,2)+enche(inttostr(ano),'0',1,2);
           if length(inttostr(ano))=4 then data:=enche(inttostr(dia),'0',1,2)+enche(inttostr(mes),'0',1,2)+enche(copy(inttostr(ano),3,2),'0',1,2);

           if tipo=20 then
              begin
                 comando:='27'+carrega_ini_bancos(trim(banco))+valor+'\'+favorecido+'\'+municipio+'\'+data+'\'+enche(obs,' ',1,60);
              end
           else
              begin
                 comando:='2080\74\'+valor+'\'+favorecido+'\'+municipio+'\'+data+'\'+enche(obs,' ',1,60);
              end;

           strpcopy(cmd,comando);
           log(func+' - Enviado (NCR):'+comando);
           enviacomando(porta,cmd);
           result:=Prepara_Resp(tipo,retorno,'','');
           log(func+' - Recebido (NCR):'+retorno);
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
     comando:='04X3';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     log(func+' - Recebido (NCR):'+retorno);

     valor:=copy(valor,1,pos('|',valor)-1);

     espera_ecf(porta);
     comando:='190\Conta-vale: '+strtovalor(2,trim(valor));
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
     espera_ecf(porta);
     try
        ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
        ncr.writeString('CONTROLE', 'coo', '');
        ncr.writeString('CONTROLE', '_coo', '');
     finally
        ncr.Free;
     end;
end;

function cnfv(tipo,porta:integer) : shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='Abertura de CNFV';
     comando:='04X0';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
     espera_ecf(porta);
end;

function ECF_INFO(tipo,porta:integer):shortstring;
var c,d,e,f,g,h,i,j,k,l,m,n:string;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='ECF INFO';
     comando:='31';
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     if (copy(retorno,6,1)='1')and(copy(retorno,9,1)='0') then c:='0';
     if (copy(retorno,9,1)='1') then c:='3';
     if (copy(retorno,6,1)='0')and(copy(retorno,9,1)='0') then c:='1';
     e:=copy(retorno,12,1);
     f:=copy(retorno,11,1);
     g:=copy(retorno,5,1);
     h:=copy(retorno,7,1);
     log(func+' - Recebido (NCR):'+retorno+' ->'+e+f+g+h);

     if copy(retorno,1,2)<>'.-' then // se vier um '.-' , significa q ocorreu problema!!
        begin
           func:='ECF INFO';
           comando:='37';
           strpcopy(cmd,comando);
           log(func+' - Enviado (NCR):'+comando);
           enviacomando(porta,cmd);
           d:=retorno;
           delete(d,1,pos('\',d));
           d:=copy(d,1,pos('\',d)-1);
           d:=enche(d,'0',1,4);
           log(func+' - Recebido (NCR):'+retorno+' ->'+d);
           if copy(retorno,1,2)<>'.-' then // se vier um '.-' , significa q ocorreu problema!!
              begin
                 func:='ECF INFO';
                 comando:='38';
                 strpcopy(cmd,comando);
                 log(func+' - Enviado (NCR):'+comando);
                 enviacomando(porta,cmd);
                 i:=copy(retorno,72,6);
                 j:=copy(retorno,20,6);
                 l:=copy(retorno,59,12);
                 m:=copy(retorno,7,12);
                 log(func+' - Recebido (NCR):'+retorno+' ->'+i+j+l+m);
                 if copy(retorno,1,2)<>'.-' then // se vier um '.-' , significa q ocorreu problema!!
                    begin
                       func:='ECF INFO';
                       comando:='39';
                       strpcopy(cmd,comando);
                       log(func+' - Enviado (NCR):'+comando);
                       enviacomando(porta,cmd);
                       k:=copy(retorno,3,4);
                       log(func+' - Recebido (NCR):'+retorno+' ->'+k);
                       if copy(retorno,1,2)<>'.-' then // se vier um '.-' , significa q ocorreu problema!!
                          begin
                             func:='ECF INFO';
                             comando:='45';
                             strpcopy(cmd,comando);
                             log(func+' - Enviado (NCR):'+comando);
                             enviacomando(porta,cmd);
                             n:=copy(retorno,3,11);
                             log(func+' - Recebido (NCR):'+retorno+' ->'+n);
                             result:=Prepara_Resp(tipo,retorno,d+c+e+f+g+h+i+j+k+l+m+n,'');
                             log(func+' - Recebido ECF_INFO (NCR):'+retorno+' ->'+d+c+e+f+g+h+i+j+k+l+m+n);
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


     comando:='67'+inicio+'\'+fim;
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
end;

function LMFR(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunica??o
=========================================================}
     func:='LEITURA DA MEM?RIA FISCAL POR REDU??O';

     comando:='66'+copy(inicio,1,4)+'\'+copy(fim,1,4);
     strpcopy(cmd,comando);
     log(func+' - Enviado (NCR):'+comando);
     enviacomando(porta,cmd);
     result:=Prepara_Resp(tipo,retorno,'','');
     log(func+' - Recebido (NCR):'+retorno);
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
