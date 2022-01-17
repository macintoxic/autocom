//Sistema: Autocom PLUS
//Módulo: Módulo de venda varejo - check-out
//Responsável pelo projeto: Helder Frederico
//Responsável pela programação: Helder Frederico
//Data da última atualização: 16/12/2002
//Programador da última atualização: Helder Frederico

unit venda;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, DBTables, inifiles, jpeg, Mask, Graphics,
  IBCustomDataSet, IBQuery, IBDatabase, CPort, XPMenu;

const
     max_opc=500; // Máximo de opções existentes no sistema;
     max_opc_teclado=300; // Máximo de opções existentes no sistema para a programação de funções no lay-out do teclado.
     max_desc_sub=1; //Máximo de descontos no subtotal por venda;
     max_acre_sub=1; //Máximo de acrescimos tributado no subtotal por venda
type

//********* DLL para o Impressor Fiscal
tTroca_op      = function (tipo,porta:integer;codigo,fazoq:string):shortstring;
tAbrecupom     = function (tipo,porta:integer;texto:string):shortstring;
tAbreGaveta    = function (tipo,porta:integer):shortstring;
tAcreSub       = function (tipo,porta:integer;val,tipacre:string):shortstring;
tAutentica     = function (tipo,porta:integer;codigo,repete:string):shortstring;
tCancelacupom  = function (tipo,porta:integer;venda,valor:string):shortstring;
tCancItem      = function (tipo,porta:integer;cod,nome,prtot,trib,ind:string):shortstring;
tDescitem      = function (tipo,porta:integer; val:string):shortstring;
tDescSub       = function (tipo,porta:integer; val:string):shortstring;
tFecharCupom   = function (tipo,porta:integer; SegCp,CNFV,l1,l2,l3,l4,l5,l6,l7,l8:string):shortstring;
tFinalizadia   = function (tipo,porta:integer):shortstring;
tInicioDia     = function (tipo,porta:integer; verao,op,modal:string):shortstring;
tLancaitem     = function (tipo,porta:integer; cod, nome, qtde, prunit, prtot, Trib: string):shortstring;
tNotadecupom   = function (tipo,porta:integer; ind,texto:string;abc:boolean):shortstring;
tTextoNF       = function (tipo,porta:integer;texto,valor:string):shortstring;
tTotalizacupom = function (tipo,porta:integer;Moda,valor:string):shortstring;
tLeituraX      = function (tipo,porta:integer;NF:string):shortstring;
tVenda_liquida = function (tipo,porta:integer):shortstring;
tCOO           = function (tipo,porta:integer;tipo_coo:string):shortstring;
tSangria       = function (tipo,porta:integer;modal,valor:string):shortstring;
tFCX           = function (tipo,porta:integer;modal,valor:string):shortstring;
tCheque        = function (tipo,porta:integer;banco,valor,data,favorecido,municipio,cifra,moedas,moedap:string):shortstring;
tContra_vale   = function (tipo,porta:integer;valor:string):shortstring;
Tcnfv          = function (tipo,porta:integer) : shortstring;
tECF_INFO      = function (tipo,porta:integer):shortstring;

//********* DLL para teclado Gertec
Topentec65  = function:integer;stdcall;
Tclosetec65 = function:integer;stdcall;
Tsetdisp    = procedure(onoff:integer);stdcall;
Tdispstr    = procedure(str:pchar);stdcall;
Tgotoxy     = procedure(col,lin:integer);stdcall;
Tbackspace  = procedure;stdcall;
Tformfeed   = procedure;stdcall;

//********* DLL para TEF
ttef_cartao             =function (coo,valor,tipo:string):shortstring;
Ttef_cheque             =function (coo,valor,data,banco,agencia,agencia_dc,cc,cc_dc,num_cheque,num_cheque_dc,cpfcnpj,tipo_cli,tipo:string):shortstring;
Ttef_comprovante        =function (tipo,cupom:string):shortstring;
Ttef_ativo              =function (tipo:string):shortstring;


  TVPDR = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel7: TPanel;
    tela_fechado: TPanel;
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Panel6: TPanel;
    Timer1: TTimer;
    edcodigo: TMaskEdit;
    info: TLabel;
    Label14: TLabel;
    Panel13: TPanel;
    torre: TComPort;
    bal: TComPort;
    XPMenu1: TXPMenu;
    tela_venda: TPanel;
    Label15: TLabel;
    Label18: TLabel;
    Label16: TLabel;
    m: TMemo;
    Panel10: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Visor_subtot: TMaskEdit;
    Panel8: TPanel;
    Label9: TLabel;
    Label10: TLabel;
    Label13: TLabel;
    Visor_desc: TMaskEdit;
    Panel9: TPanel;
    Label5: TLabel;
    Label6: TLabel;
    Visor_tot: TMaskEdit;
    Panel11: TPanel;
    Label7: TLabel;
    Label8: TLabel;
    Visor_qtde: TMaskEdit;
    Panel12: TPanel;
    Label11: TLabel;
    Label12: TLabel;
    Visor_pruni: TMaskEdit;
    procedure FormActivate(Sender: TObject);
    procedure edcodigoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edcodigoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Visor_descChange(Sender: TObject);
    procedure Visor_descEnter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mEnter(Sender: TObject);
    procedure dados_conveniado;
    procedure edcodigoChange(Sender: TObject);
    procedure balRxChar(Sender: TObject; Count: Integer);
  private
    { Private declarations }
  public
    { Public declarations }

////////////////////////////////////////////////////

  v_edcodigo:String; // variavel que armazena o q foi digitado no edcodigo

  vpdvnum:string;// número do terminal.
  vModECF:string;// modelo do ECf.
  vCOMECF:string;// porta de comunicação do ECF.
  vscnr:string;  // define se tem ou não scanner.
  vcomscnr:string;// porta de comunicação do scanner.
  vmodtec:string;// modelo do teclado em uso.
  VLCHQ:string;  // definição do leitor de cheques.
  vbal:string;    //  define se tem ou não balança
  vbalcom:string; // porta de comunicação da balança.
  v_printgrill:string; // define se imprime pedido na cozinha

  v_l1,v_l2,v_l3,v_l4,v_l5,v_l6,v_l7,v_l8:string; // mensagem de cortesia.
  tipo_indicador:string; // tipo de indicador parametrizado no sistema.
  nome_indicador:string;// nome do indicador parametrizado no sistema.
  obriga_indicador:string;// define se obriga ou não o lançamento de indicador na venda
  v_gaveta:string; // define se tem QUAL o tipo de gaveta de valores.
  v_status_da_gaveta:string; // define, de acordo com o tipo de gaveta, o qual é o status de gaveta fecaha.
  v_fechagaveta:string; // define se o sistema obriga ou não o fechamento da gaveta no final da tela venda.

  num_ECF:String; // número do ECF

  V_num_loja:String;// número da loja.

  v_DLL_ECF:array[0..250] of char;

  v_coo:string; // número do cupom
  resposta:string; //resposta da dll sobre o ECF

  numero_de_desc_sub:integer;// total de descontos no subtotal efetuados na venda
  numero_de_acre_sub:integer;// total de acrescomos no subtotal efetuados na venda

  controla_produto:boolean;

///////////////////////////////////////////////////////////
//   Variável de chamada da dll do teclado gertec 65     //
///////////////////////////////////////////////////////////
opentec65:Topentec65;                                    //
closetec65:Tclosetec65;                                  //
setdisp:Tsetdisp;                                        //
dispstR:TdispstR;                                        //
gotoxy:Tgotoxy;                                          //
backspace:Tbackspace;                                    //
formfeed:Tformfeed;                                      //
///////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////
//   Variável de chamada da dll para TEF                 //
///////////////////////////////////////////////////////////
  tef_cheque:ttef_cheque;                                //
  tef_cartao:ttef_cartao;                                //
  tef_comprovante:Ttef_comprovante;                      //
  tef_ativo:Ttef_ativo;                                  //
///////////////////////////////////////////////////////////


    Nome_opc,Aces_opc,ABrv_opc: array[1..max_opc] of string; // opções armazenas no ACFUNC.CAT
    cod_opc: array [1..max_opc] of integer; // opção armazenada no ACFUNC.CAT.
    Existe_consistencia:array [1..max_opc] of boolean;

    dados_cheq_manual:boolean; // verifica se a captura dos dados do cheque foi OK

    Nivel_atual:string; //nível de segurança do operador ativo.
    nome_operador:string;// nome do operador ativo.
    cod_operador:real;   // codigo do operador ativo.

    tecla_code_func: array [0..max_opc_teclado] of integer; // este vetor contem o código da função programada no teclado. cada indice correnponde ao codigo ASCII de cada tecla.
    tecla_name_func: array [0..max_opc_teclado] of string;  // este vetor contém o nome da função programada no teclado. Cada indice correnponde ao codigo ASCII de cada tecla.
    tecla_resu_func: array [0..max_opc_teclado] of string;  // este vetor contém o nome resumido da função programada no teclado. Cada indice correnponde ao codigo ASCII de cada tecla.
    tecla_PPIC_func: array [0..max_opc_teclado] of real;    // este vetor comtém o código PPI fa função PPI programada no teclado. Cada indica correnponde ao código ASCII de cada tecla.

    tipo_saida:integer;

    operador,sair,consulta_plu,reducao_z,verifica_seguranca,fundo_cx,multiplica,finalizadora,valor,v_sangria,lanca_ind,desc_val,desc_per:boolean; // indica qual função está sendo usada quando=TRUE
    acrt_per,acri_per,acrt_val,acri_val,canc_venda,imprimindo_cheq:boolean; // indica qual função está sendo usada quando=TRUE

    LANCA_CONVENIO,CONVENIO_COD,CONVENIO_EMP:BOOLEAN; // FALG DE CONTROLE DE LANCAMENTO DE CONVENIO DO INICIO DA VENDA

    sangria_com_fina:boolean;// quando true, indica que foi selecionada uma finaizadora para realizar a sangria.

    lancou_valor:boolean; // quando true, indica q lançou o valor total do item

    acesso_liberado:integer; //indica se a função foi liberada para uso por um outro operador que tenha acesso a opção bloqueada.

    status_cliente:integer;// armazena o status do cliente após sua consulta. esta variável tem seu valor alterado de acordo com o resultado da pesquisa na consulta de cliente!

    banco_cheq,agencia_cheq,conta_cheq,num_cheq:string; // dados do cheque;
    V_cpfcnpj,V_tipo_cliente:string;

    posecf:array[0..50000] of integer; // variáveis para o cancelamento de item.
    posdb:array[0..50000] of string; // variáveis para o cancelamento de item.
    indice_item:string; // variavel para o cancelamento de item.

    Mensagem_display:array [0..240] of char;
    tecla_digitada:string; // contem a tecla digitada.


    mensagem_tef:string; // mensagem de retorno da dll do tef

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  v_nomefina:string;    // nome da finalizadora                                                                                         //
  v_autfina:real;       // parametro de autenticação -> 0=nao   1-sim                                                                   //
  v_cheqfina:real;      // parametro de impressão de cheque -> 0=não  1=sim                                                             //
  v_trocofina:real;     // parametro de troco -> 0=nao permite  1=permite  2=contra-vale                                                //
  v_funcfina:real;      // parametro de funcao da finalizadora -> 0=sem funcao   1=consulta lista negra  2=venda a prazo    3=convenio  //
  v_diacheqfina:real;   // parametro de dias para cheque pre                                                                            //
  v_datacheqfina:array[1..100] of string;// parametro para data do cheque pre ou parcelamento de cartao de crédito                      //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
  V_TOTAL:Real;   // total da venda
  V_quant_total:real;  // total da venda em quantidade.
  total_da_ultima_venda:real; // total da 'ultima venda;

  tipo_consulta_cliente:integer;// define o tipo de consulta ao cliente 1=lista negra  2=convenio
  codigo_indicador:real;   // código do indicador.
  codigo_conveniado:real;  // código do conveniado.
  codemp_conveniado:real; //código da empresa do conveniado
  codigo_cliente:real;     // código do cliente.
  saldo_cliente:real;      // saldo do cliente.
  cod_n_cad:real;        // cpf/cnpj do cliente.
  NOME_cliente:string;   // nome do cliente.

  coluna_display:integer; // contém a coluna definida para posicionar o cursor do display do teclado
  linha_display:integer; // contém a linha definada para posicionar o cursor do display do teclado

  hndl:integer;
  hndl_tef:integer;

    procedure Caixa_aberto; // redefine a tela para caixa aberto.
    procedure caixa_fechado; // redefine a tela para caixa fechado.
    function Enche(texto,caracter:string;lado,tamanho:integer):string;
    procedure verifica_logo; // verifica a existência de arquivos de logotipos (BMP) - tela de caixa fechado
    procedure verifica_logo2; // verifica a existência de arquivos de logotipos (BMP) - tela de caixa aberto
    procedure chamaACFUNC; // chama as opções do ACfunc.CAT
    Procedure carrega_op; // carrga o operador ativo, gravado no oper.ini.
    procedure configura_arquivos;// abre os arquivos do banco de dados
    procedure fechaarquivos;// fechar os arquivos de banco de dados
    procedure Procura_e_ativa_func(tecla:word;ctrl:Tmaskedit); //procura o a função e executa.
    Procedure Chama_teclado; // Carrega o lay-out do teclado!
    procedure carregaini_par; // carrega parametros do arquivo autocom.INI
    procedure Mask_edcodigo(tipo:integer); // altera a mascara do campo código.
    procedure Message_info(tipo:integer;texto:string);// mostra mensagens para o operador.
    function liberado:boolean; // indica se existe alguma função habilitada.
    procedure mostra_produto(nome,pruni,quant,prtot,tot:string); // mostra na tela o produto.
    function Verifica_liberacao(op:integer;verify:boolean):boolean; // faz a consistência do nível de segurança do operador em relação às opçòes do sistema
    procedure captura_produto(pesado:real);  // captura os dados do produto para lança-lo.
    procedure captura_finalizadora; // captura os dados da finalizadora para a totalização.
    function strtoquant(texto:string):string; // pega uma string e formata para ser apresentado como quantidade.
    function strtovalor(texto:string;dec:integer):string; // pega uma string e formata para ser apresentada como valor.
    procedure termina_venda; // zera as variáveis para o inicio de outra venda.
    procedure consulta_ln;// abre a tela para consulta de cliente;
    procedure convenio;// abre a tela para consulta de cliente;
    procedure grava_convenio; //grava o saldo do conveniado
    procedure grava_produtos_convenio(xx_cliente:string);// grava o saldo de produtos de cada conveniado
    procedure cancela_convenio; // cancela a gravação dos dados do conveniado na tabela ac201
    procedure consulta_tef_cheque; // REALIZA A CONSULTA DE cheques por tef (tecban)
    Function ValidaCPF(campo:string):Integer; // verifica a autenticidade do CPF ou CNPJ
    procedure dados_cheq;// captura os dados sobre o cheque (Banco, numero, agencia e conta)
    function trata_queda_de_energia:boolean; // faz o tratamento para o retorda da venda em caso de queda de energia.
    procedure trava_mouse(tipo:integer); // trava\movimenta a movimentação do mouse
    function Erro_dlg(tipo:integer;msg:string):string; // mostra caixa de dialogo de erro!!
    function strtoformat(texto:string;dec:integer):string; // formata uma string no formato de valores.
    function capt_coo(p1,p2:integer;p3:string):string; // captura o coo do cupom
    procedure imprime_cheq; // rotina para impressão do cheque.
    function ECF_inf(p1,p2:integer):string; // captura informações sobre status de ECF.
    function emite_redu_z:boolean; // emite redução z.
    function emite_leit_x:boolean; // emite leitura X.
    function tira_milhar(m:string):string; // tira o . que separa as casas de milhar.
    function extenso (valor: real): string; // escre um numero por extenso
    function Formata_Virgula(texto:string;tipo:integer):string; // muda o separador decimal para .
    function peso(tipo,porta:string):string; // pega o peso da balança toledo
    function troca_Virgula(texto:string):string; //troca a virgula decimal por ponto.


    procedure tef(tipo:string); // rotina para a chamada do módulo tef (tipo=0 é tecban, tipo=1 é redecard/visanet)
    procedure habilita_dlltef; // carrega a dll do tef;
    procedure desabilita_dlltef; // carrega a dll do tef;
    procedure Finaliza_agentes; // espera finalizar os agentes
    procedure display; // escreve o conteúdo da caixa edição *(edcodigo) na display do teclado
    procedure display_torre(texto:string;func,x,y:integer);// rotina para escrever no display do cliente
    Function EnviaComando_bAL(Texto1:string):shortSTRING; // ENVIA O COMANDO DA BALANÇA E ESPERA A RESPOSTA
    function captura_peso(tipo,porta:string):shortstring; // CAPTURA O PESO DA BALANÇA
    function verifica_quantidade:boolean; // verifica se os produtos não ultrapassam os limites (no caso de venda para conveniado)

    procedure ex_canv(tipo:integer);         // cancela a venda atual ou a ultima venda
    procedure ex_cani(tipo:integer);         // CANCELA um item do cupom fiscal
    procedure ex_ACTP(tipo:integer);         // lanca acrescimo tributado em percentual
    procedure ex_ACTV(tipo:integer);         // lanca acrescimo tributado em valor
    procedure ex_desp(tipo:integer);         // lanca um desconto em percentual
    procedure ex_desv(tipo:integer);         // lanca um desconto em valor
    procedure ex_indc(tipo:integer);         // lanca um indicador no cupom fiscal
    procedure ex_convenio(tipo:integer);     // ABRE o cupom fiscal com o conveniado
    procedure ex_SANG(tipo:integer);         // faz a sangria das finalizadoras
    procedure ex_valR(tipo:integer);         // Permite lançar o valor total do produto para o sistema calcular a quantidade.
    procedure ex_PPI(code:string);           // Lança PPI programado
    procedure ex_GAVT;                       // Abertura de gaveta fora da venda.
    procedure ex_FI(tipo:integer;modal:real);// realiza os recebimentos da venda.
    procedure ex_SBto;                       // Subtotal da venda.
    procedure ex_mult(tipo:integer);         // Altera o valor da quantidade padrão (q é 1)
    procedure ex_lanca_item;                 // Lançamento de item
    procedure ex_FDCX(tipo:integer);         // Lançamento de Fundo de caixa.
    procedure ex_REDZ(tipo:integer);         // Impressão da Redução Z (finaliza o dia fiscal)
    procedure ex_LTRX;                       // Impressão da Leitura X (Abre o dia fiscal)
    procedure ex_CONS(tipo:integer);         // Consulta de produtos na tela
    procedure ex_OPER(tipo,opcao:integer);   // Ativa/desativa operador para a venda.
    procedure ex_CORR(edit:Tmaskedit);       // corrigiar ação ou limpar campo
    procedure ex_SAIR(tipo:integer);         // Saída do módulo;
    function  iniciododia:boolean;           // faz o inicio do dia fiscal
  end;

{*** ECRPT.DLL ***}
  function Encripit(a,b,c,d,e,f:integer):shortstring;external 'ECRPT.dll' index 1;
  function Checksun(primitiva:real):shortstring;external 'ECRPT.dll' index 2;

{*** CTRV.DLL ***}
  function grava_log_venda(tab:integer;campo1:real;campo2,campo3,campo4:string;campo5:real;campo6:string;campo7:Tdate;campo8:TTime;campo9:real;campo10,campo11,campo12,campo13:string;campo14,campo15:real;campo16:real;campo17,campo18,campo19:string;campo20:real):boolean;external 'ctrv.dll' index 1;
  // o paramentro tab pode assumir os seguinte valore: 0=log atual  1=log ultima  2=log geral
  function reorganiza_logs(terminal,loja:string):boolean;external 'ctrv.dll' index 3;
  function flag_venda(tipo:integer):shortstring;external 'ctrv.dll' index 4;
  function status_log_atual(terminal,loja:string):shortstring;external 'ctrv.dll' index 5;
  function cancela_venda_log(tipo:integer;terminal,loja:string):shortstring;external 'ctrv.dll' index 6;
  procedure printgrill;external 'ctrv.dll' index 7;


var
  VPDR: TVPDR;
  path:string;
  digita_valores:boolean; // quando true, indica que será digitado valores, para que o sistema alinhe o edcodigo à direita.

  cod:real;     //buchas//
  teste:string; //  de  //
  OPC:integer;  //canhão//

  perc_depto:string; //percentual de desconto do departamento quando for convenio.

  status_erro:boolean; // indica para o sistema que está em estado de erro.
  vendendo:boolean;    // indica que está dentro de uma venda.
  lancou_item:boolean; // indica que lançou um item.
  sub_total:boolean;   // indica se foi ou não pressionado o Subtotal;

  desc_item:boolean;  // indica se o desconto será sobre um item ou sobre subtotal

  numero_de_itens:real; // total de itens no cupom.
  numero_de_itens_desc:real;// total de itens q podem receber desconto no subtotal.
  ja_lancou_desc_no_item:boolean; // quando em true, indica que já foi dado um desconto no item.

  ED:TMaskEdit;      //bucha de canhão para controle de componentes.

/////////////////////////////////////////////////////////////////////////////////////////
  v_prod:real;     // codigo do produto                                                //
  v_desc:string;   // descricao do produto                                             //
  v_decimais:real; // número de casas decimais                                         //
  v_prunit:real;   // preço unitário do produto                                        //
  v_prtot:real;    // preço total do produto                                           //
  v_trib:string;   // tributação do produto                                            //
  v_trib_code:real;// codigo da tributação do produto                                  //
  v_quant:real;    // quantidade do produto                                            //
  v_depto:real;    // departamento do produto                                          //
  v_un:string;     // unidade de medida do produto                                     //
  v_estoque:real;  // flag de controle para verificar saldo em estoque antes de vender //
/////////////////////////////////////////////////////////////////////////////////////////

  total_recebido:real; // total_recebido das finalizadoras;
  valor_recebido:real; // valor recebido da finalizadora;
  valor_recebido_parcela:array [1..100] of real; // valor recebido da finalizadora em parcelas;
  falta_receber:real;  // valor que ainda falta para totalizar a venda
  parcelas:integer;


  bloqueio_tef:boolean; //esta flag bloqueia o sistema no caso de haver algum comprovante de tef pendente.

///////////////////////////////////////////////////////////
//        Variável de chamada da Dll do ECF              //
///////////////////////////////////////////////////////////
  Abrecupom:tAbrecupom;                                  //
  AbreGaveta:tAbreGaveta;                                //
  AcreSub:tAcreSub;                                      //
  Autentica:tAutentica;                                  //
  Cancelacupom:tCancelacupom;                            //
  CancItem:tCancItem;                                    //
  Descitem:tDescitem;                                    //
  DescSub:tDescSub;                                      //
  FecharCupom:tFecharCupom;                              //
  Finalizadia:tFinalizadia;                              //
  InicioDia:tInicioDia;                                  //
  Lancaitem:tLancaitem;                                  //
  Notadecupom:tNotadecupom;                              //
  TextoNF:tTextoNF;                                      //
  Troca_op:tTroca_op;                                    //
  Totalizacupom:tTotalizacupom;                          //
  LeituraX:tLeituraX;                                    //
  Venda_liquida:tVenda_liquida;                          //
  COO:tCOO;                                              //
  Sangria:tSangria;                                      //
  FCX:tFCX;                                              //
  cheque:tCheque;                                        //
  Contra_vale:tContra_vale;                              //
  ECF_INFO:TECF_INFO;                                    //
  cnfv:Tcnfv;                                            //
///////////////////////////////////////////////////////////


///////////////////////////////////////////////////////////
//        Variável PARA A ROTINA DE BALANÇA              //
///////////////////////////////////////////////////////////
   resp_bal,Comando_bal:String;                          //
   sufix_bal,prefix_bal:string;                          //
   MandouResposta_bal:Boolean;                           //
///////////////////////////////////////////////////////////


implementation

uses saida, conscli, dadosch, dadoscha, cancit, getcpf, tab;

{$R *.DFM}

function TVPDR.Enche(texto,caracter:string;lado,tamanho:integer):string;
begin
     while length(texto)<tamanho do
        begin // lado=1, caracteres a esquerda  -  lado=2, caracteres a direita
           if lado = 1 then texto := caracter + texto else texto := texto + caracter;
        end;
     result:=texto;
end;

procedure TVPDR.Caixa_aberto;
begin
     display_torre('',0,1,1);
     display_torre('Caixa Aberto',1,1,1);
     tela_fechado.visible:=false;
     tela_venda.visible:=true;
     panel11.visible:=true;
     panel9.visible:=true;
     panel10.visible:=true;
     IF VMODECF='99' THEN LABEL13.VISIBLE:=TRUE else label13.visible:=false;
     if v_total<=0 then
        begin
           if consulta_plu=false then
              begin
                 termina_venda;
                 reorganiza_logs(vpdvnum,V_num_loja);
                 cancela_convenio;
              end;
        end
     else
        begin
           visor_pruni.editmask:='999999,99;0; ';
           Mostra_produto('','000','1000','000',floattostrf(v_total,ffnumber,12,2));
        end;
     verifica_logo2;
     edcodigo.enabled:=true;
     edcodigo.setfocus;
end;

procedure TVPDR.caixa_fechado;
begin
     display_torre('',0,1,1);
     display_torre('Caixa Fechado',1,1,1);
     application.processmessages;
     teste:=ECF_INF(strtoint(vmodecf),strtoint(vcomecf));
     try
        strtofloat(v_coo);
     except
        v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
     end;


     v_coo:=inttostr(strtoint(v_coo)+1);
     grava_log_venda(0,0,'0',copy(teste,22,4),'0',0,'98',Date,Time,cod_operador,'0',copy(teste,50,12),copy(teste,26,12),copy(teste,38,12),0,strtofloat(copy(teste,10,6)),strtofloat(copy(teste,16,6)),v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC203) os dados referente a redução Z


     flag_venda(0);
     tela_venda.visible:=false;
     tela_fechado.visible:=true;

     operador:=false;
     consulta_plu:=false;
     reducao_z:=false;
     verifica_seguranca:=false;
     fundo_cx:=false;
     v_sangria:=false;
     multiplica:=false;
     valor:=false;
     lancou_valor:=false;
     lanca_ind:=false;
     sub_total:=false;
     finalizadora:=false;
     acrt_val:=false;
     acri_val:=false;
     desc_val:=false;
     desc_per:=false;
     acrt_per:=false;
     acri_per:=false;
     canc_venda:=false;
     sair:=false;
     vendendo:=false;


     IF vmodtec='2' then // caso existe um teclado gertec 65 instalado no PDV
        begin
           strpcopy(Mensagem_display,'              CAIXA FECHADO             ');
           hndl:=LoadLibrary('TEC65_32.DLL');
           if hndl <> 0 then
              begin
                 @opentec65:=GetProcAddress(hndl, 'OpenTec65'); // inicializa o display do teclado
                 @formfeed:=GetProcAddress(hndl, 'FormFeed'); // limpa o display do teclado
                 @dispstr:=GetProcAddress(hndl, 'DispStr'); // escreve no display do teclado
                 @setdisp:=GetProcAddress(hndl, 'SetDisp'); // ativa o display do teclado
                 if @opentec65 <> nil then opentec65;
                 if @formfeed  <> nil then formfeed;
                 if @setdisp   <> nil then setdisp(1);
                 if @dispstr   <> nil then dispstr(Mensagem_display);
                 if @setdisp   <> nil then setdisp(0);
                 FreeLibrary(hndl);
              end;
        end;


     IF VMODECF='99' THEN LABEL14.VISIBLE:=TRUE else label14.visible:=false;

     grava_convenio;

     verifica_logo;

end;

procedure TVPDR.verifica_logo;
var loja_ini:Tinifile;
begin
     loja_ini:=TIniFile.Create(path+'Autocom.ini');
     if fileexists(loja_ini.readstring('LOJA','LojaLogo',path+'logo.bmp')) then
        begin
           image1.picture.loadfromfile(loja_ini.readstring('LOJA','LojaLogo',path+'logo.bmp'));
        end;
     loja_ini.free;
     application.processmessages;
     tela_fechado.left:=trunc((VPDR.width-tela_fechado.width)/2);
     tela_fechado.top:=64;
end;

procedure TVPDR.verifica_logo2;
begin
//     tbparloja.active:=true;
//     if fileexists(tbparlojaimagem.value) then
//        begin
//           image2.picture.loadfromfile(tbparlojaimagem.value);
//        end;
//     tbparloja.active:=false;
//     application.processmessages;
//     tela_fechado.left:=trunc((VPDR.width-tela_fechado.width)/2);
//     tela_fechado.top:=64;
end;

procedure TVPDR.chamaACFUNC;
var a:integer;
    ini:TIniFile;
begin

     ftabelas.query1.close;
     ftabelas.query1.sql.clear;
     ftabelas.query1.sql.add('select * from pdv_funcoesteclado');
     ftabelas.query1.prepare;
     ftabelas.query1.open;

     ftabelas.query1.first;
     a:=1;
     while not ftabelas.query1.eof do
        begin
           if length(trim(ftabelas.query1.fieldbyname('nome_funcao').asstring))>0 then
              begin
                 nome_opc[a]:=ftabelas.query1.fieldbyname('nome_funcao').asstring;
//               aces_opc[a]:=ini.readstring('FT_'+enche(inttostr(a),'0',1,4),'Acesso','0000000000');
                 cod_opc[a] :=ftabelas.query1.fieldbyname('codigo_funcao').asinteger;
                 ABRV_opc[a]:=ftabelas.query1.fieldbyname('sigla').asstring;
//                 if aces_opc[a]='9999999999' then Existe_consistencia[a]:=false else Existe_consistencia[a]:=true;// 9999999999-> significa que o sistema não deverá realizar a verificação de Nível de segurança nessa opção.
                 Existe_consistencia[a]:=false;
              end;
           ftabelas.query1.next;
           a:=a+1;
        end;
end;


Procedure tVPDR.carrega_op;
var oper:Tinifile;
begin
     oper:=TIniFile.Create(path+'OPER.INI');
     nome_operador:=oper.ReadString('OPER', 'Nome','');
     nivel_atual:=oper.ReadString('OPER', 'Tipo','');
     cod_operador:=oper.ReadFloat('OPER', 'Codigo',0);
     oper.Free;
end;

procedure TVPDR.FormActivate(Sender: TObject);
var loja_ini:Tinifile;
begin
     trava_mouse(1);
     setforegroundwindow(application.handle);
     path:=extractfilepath(application.exename)+'Dados\';
     configura_arquivos;
     carrega_op;
     ChamaACFUNc;
     carregaini_par;
     IF vmodtec='2' then // caso existe um teclado gertec 65 instalado no PDV
        begin
           strpcopy(Mensagem_display,'              AUTOCOM PLUS              ');
           hndl:=LoadLibrary('TEC65_32.DLL');
           if hndl <> 0 then
              begin
                 @opentec65:=GetProcAddress(hndl, 'OpenTec65'); // inicializa o display do teclado
                 @formfeed:=GetProcAddress(hndl, 'FormFeed'); // limpa o display do teclado
                 @dispstr:=GetProcAddress(hndl, 'DispStr'); // escreve no display do teclado
                 @setdisp:=GetProcAddress(hndl, 'SetDisp'); // ativa o display do teclado
                 if @opentec65  <> nil then opentec65;
                 if @setdisp    <> nil then setdisp(1);
                 if @formfeed   <> nil then formfeed;
                 if @dispstr    <> nil then dispstr(Mensagem_display);
                 if @setdisp    <> nil then setdisp(0);
                 FreeLibrary(hndl);
              end;
        end;

     loja_ini:=TIniFile.Create(path+'Autocom.ini');
     VPDR.caption:='AUTOCOM PLUS - '+loja_ini.readstring('LOJA','LojaNome','');
     V_num_loja:=loja_ini.readstring('LOJA','LojaNum','');
     loja_ini.free;

     teste:=ECF_INF(strtoint(vmodecf),strtoint(vcomecf));
     num_ECF:=copy(teste,1,4);
     if copy(teste,5,1)='1' then flag_venda(0); // esta verificação é para ter certeza d q quando o sistema entrar e for necessário abrir o dia, o caixa vai estar na tela de caixa fechado.
     panel6.caption:='ECF: '+num_ECF;
     if trata_queda_de_energia=false then caixa_fechado else caixa_aberto;
     Panel2.caption:=nome_operador;
     Panel3.caption:=datetostr(date);
     Panel4.caption:=copy(timetostr(time),1,5);
     Panel5.caption:='Terminal: '+vpdvnum;
     Panel13.caption:='Loja: '+V_num_loja;

     message_info(1,'CARREGANDO TABELAS'+CHR(13)+'AGUARDE...');
     application.processmessages;

     ftabelas.tbteclado.close;
     ftabelas.tbteclado.sql.clear;
     ftabelas.tbteclado.sql.add('select * from PDV_teclado where terminal='+vpdvnum+' and tipo='+chr(39)+vmodtec+chr(39));
     ftabelas.tbteclado.prepare;
     ftabelas.tbteclado.open;

     ftabelas.tbl_condicaopagamento.close;
     ftabelas.tbl_condicaopagamento.sql.clear;
     ftabelas.tbl_condicaopagamento.sql.add('select * from CONDICAOPAGAMENTO;');
     ftabelas.tbl_condicaopagamento.prepare;
     ftabelas.tbl_condicaopagamento.open;

     ftabelas.tbl_formafaturamento.close;
     ftabelas.tbl_formafaturamento.sql.clear;
     ftabelas.tbl_formafaturamento.sql.add('select * from FORMAFATURAMENTO;');
     ftabelas.tbl_formafaturamento.prepare;
     ftabelas.tbl_formafaturamento.open;

     ftabelas.tbop.close;
     ftabelas.tbop.sql.clear;
     ftabelas.tbop.sql.add('select * from USUARIOSISTEMA');
     ftabelas.tbop.prepare;
     ftabelas.tbop.open;

     ftabelas.tbl_condicaopagamento.last;
     ftabelas.tbop.last;
     ftabelas.tbteclado.last;

     ftabelas.tbl_condicaopagamento.first;
     ftabelas.tbop.first;
     ftabelas.tbteclado.first;

     message_info(1,'');

     habilita_dlltef;
     if hndl_tef<>0 then
        begin
           @tef_ativo:= GetProcAddress(hndl_tef, 'tef_ativo');
           resposta:=tef_ativo('1');
           if copy(resposta,1,1)='1' then
              begin
                 showmessage(copy(resposta,2,length(resposta)));
                 fechaarquivos;
                 close;
              end;

           resposta:=tef_ativo('0');
           if copy(resposta,1,1)='1' then
              begin
                 showmessage(copy(resposta,2,length(resposta)));
                 fechaarquivos;
                 close;
              end;
        end;
     desabilita_dlltef;

     chama_teclado;

     edcodigo.enabled:=true;
     edcodigo.clear;
     edcodigo.setfocus;
end;

procedure TVPDR.configura_arquivos;
var t1,t2:string;
    ini:Tinifile;
begin
     try
        ini:=TIniFile.Create(path+'autocom.INI');
        t1:=ini.readString('ATCPLUS', 'IP_SERVER', ''); // endereço ip do servidor
        t2:=ini.readString('ATCPLUS', 'PATH_DB', '');     // caminho do banco de dados no servidor
     finally
        ini.Free;
     end;

     try
        ftabelas.transacao.active:=false;
        ftabelas.dbautocom.connected:=false;
        ftabelas.dbautocom.databasename:=t1+':'+t2;
        ftabelas.dbautocom.connected:=true;
        ftabelas.transacao.active:=true;
        application.processmessages;
     except

     end;
end;

procedure TVPDR.fechaarquivos;
begin
     ftabelas.transacao.active:=false;
     ftabelas.dbautocom.connected:=false;
end;

procedure TVPDR.Chama_teclado;
var a:integer;
    achou:boolean;
begin
     ftabelas.tbteclado.first;
     achou:=false;
     while not ftabelas.tbteclado.eof do
        begin
           if (strtoint(ftabelas.tbtecladoterminal.value)=strtoint(vpdvnum)) and (ftabelas.tbtecladotipo.value=vmodtec) then
              begin
                 tecla_code_func[ftabelas.tbtecladotecla.value]:=strtoint(ftabelas.tbtecladocodigo_funcao.value);
                 Tecla_resu_func[ftabelas.tbtecladotecla.value]:=ftabelas.tbtecladoabrev.value;
                 tecla_PPIC_func[ftabelas.tbtecladotecla.value]:=ftabelas.tbtecladocodigoproduto.value;
                 for a:=1 to max_opc do
                    begin
                       if cod_opc[a]=tecla_code_func[ftabelas.tbtecladotecla.value] then
                          begin
                             tecla_name_func[ftabelas.tbtecladotecla.value]:=nome_opc[a];
                             break;
                          end;
                    end;
                 achou:=true;
              end;
           ftabelas.tbteclado.next;
        end;

     if achou=false then
        begin
           Erro_dlg(1,'O lay-out do teclado não está configurado. O módulo será abortado!');
           close;
        end;
end;


procedure TVPDR.edcodigoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     v_edcodigo:=edcodigo.text;

     if key=vk_return then
        begin
           if (status_erro=true) then exit;
           try
             if strtofloat(v_edcodigo)=0 then exit;
           except
             if (Length(v_edcodigo)<=0) and (finalizadora=false) then exit;
           end;
           edcodigo.clear;
           edcodigo.enabled:=false;
        end;

     if verifica_seguranca=true then
        begin
           if key=vk_return then
              begin
                 if cod=0 then
                    begin
                       try
                          cod:=strtofloat(enche(trim(v_edcodigo),'0',1,16));
                       except
                          cod:=0;
                       end;
                       if (status_erro=false) then ex_oper(3,opc);
                       exit;
                    end;
                 if teste='' then;
                    begin
                       teste:=v_edcodigo;
                       if (status_erro=false) then ex_oper(3,opc);
                       exit;
                    end;
              end;
        end;

     if operador=true then // verifica se a função Operador está esperando dados.
        begin
           if key=vk_return then
              begin
                 if (status_erro=false) then ex_oper(2,0);
                 exit;
              end;
        end;

     if sair=true then // verifica se a função Sair está esperando dados
        begin
           if key=vk_return then
              begin
                 if status_erro=false then ex_sair(2);
                 exit;
              end;
        end;

     if consulta_plu=true then // verifica se a função Consulta está esperando dados.
        begin
           if key=vk_return then
              begin
                 if (status_erro=false) then ex_cons(2);
                 exit;
              end;
        end;

     if reducao_z=true then // verifica se a função Redução Z está esperando dados.
        begin
           if key=vk_return then
              begin
                 if (status_erro=false) then ex_REDZ(2);
                 exit;
              end;
        end;

     if fundo_cx=true then // verifica se a função Fundo de caixa está esperando dados.
        begin
           if key=vk_return then
              begin
                 teste:=v_edcodigo;
                 teste:=strtovalor(teste,2);
                 v_edcodigo:=teste;
                 if (status_erro=false) then ex_FDCX(2);
                 exit;
              end;
        end;

     if desc_val=true then // verifica se a função de desconto em $ está esperando dados.
        begin
           if key=vk_return then
              begin
                 teste:=v_edcodigo;
                 teste:=strtovalor(teste,2);
                 v_edcodigo:=teste;
                 if (status_erro=false) then ex_desV(2);
                 exit;
              end;
        end;

     if acrt_val=true then // verifica se a função de acrescimo trib. em $ está esperando dados.
        begin
           if key=vk_return then
              begin
                 teste:=v_edcodigo;
                 teste:=strtovalor(teste,2);
                 v_edcodigo:=teste;
                 if (status_erro=false) then ex_ACTV(2);
                 exit;
              end;
        end;

     if desc_per=true then // verifica se a função de desconto em % está esperando dados.
        begin
           if key=vk_return then
              begin
                 teste:=trim(v_edcodigo);
                 v_edcodigo:=enche(teste,' ',1,2);
                 if (status_erro=false) then ex_desp(2);
                 exit;
              end;
        end;

     if acrt_per=true then // verifica se a função de acrescimo trib em % está esperando dados.
        begin
           if key=vk_return then
              begin
                 teste:=trim(v_edcodigo);
                 v_edcodigo:=enche(teste,' ',1,2);
                 if (status_erro=false) then ex_ACTP(2);
                 exit;
              end;
        end;

     if (v_sangria=true) and (sangria_com_fina=true) then // verifica se a função sangria está esperando dados.
        begin
           if key=vk_return then
              begin
                 teste:=v_edcodigo;
                 teste:=strtovalor(teste,2);
                 v_edcodigo:=teste;
                 if (status_erro=false) then ex_sang(3);
                 exit;
              end;
        end;

     if multiplica=true then // verifica se a função multiplicação está esperando dados.
        begin
           if (key=110) or (key=191) then key:=188;
           if key=vk_return then
              begin
                 teste:=v_edcodigo;
                 teste:=strtoquant(teste);
                 v_edcodigo:=teste;
                 if (status_erro=false) then ex_mult(2);
                 exit;
              end;
        end;

     if valor=true then // verifica se a função valor está esperando dados.
        begin
           if (key=110) or (key=191) then key:=188;
           if key=vk_return then
              begin
                 teste:=v_edcodigo;
                 teste:=strtovalor(teste,2);
                 v_edcodigo:=teste;
                 if (status_erro=false) then ex_valr(2);
                 exit;
              end;
        end;

     if lanca_ind=true then // verifica se a função cliente está esperando dados.
        begin
           if key=vk_return then
              begin
                 teste:=trim(v_edcodigo);
                 v_edcodigo:=enche(teste,'0',1,12);
                 if (status_erro=false) then ex_indc(2);
                 exit;
              end;
        end;


     if CONVENIO_COD=true then // verifica se a função convenio está esperando dados do conveniado.
        begin
           if key=vk_return then
              begin
                 teste:=trim(v_edcodigo);
                 try
                    strtofloat(teste);
                 except
                    v_edcodigo:='';
                 end;

                 IF TESTE='' then
                    begin
                       v_edcodigo:='';
                       edcodigo.setfocus;
                    end
                 else
                    begin
                       CODIGO_CONVENIADO:=STRTOFLOAT(enche(teste,'0',1,12));
                       if (status_erro=false) then
                          begin
                             convenio_cod:=false;
                             ex_CONVENIO(2);
                          end;
                       exit;
                    end;
              end;
        end;

     if CONVENIO_EMp=true then // verifica se a função conveniado está esperando dados da empresa.
        begin
           if key=vk_return then
              begin
                 teste:=trim(v_edcodigo);
                 try
                    strtofloat(teste);
                 except
                    v_edcodigo:='';
                 end;

                 IF TESTE='' then
                    begin
                       edcodigo.setfocus;
                    end
                 else
                    begin
                       CODEMP_CONVENIADO:=strtofloat((enche(teste,'0',1,4)));
                       if (status_erro=false) then
                          begin
                             convenio_emp:=false;
                             ex_CONVENIO(3);
                          end;
                       exit;
                    end;
              end;
        end;


     if canc_venda=true then // verifica se a função cancelamento de venda está esperando dados.
        begin
           if key=vk_return then
              begin
                 if (status_erro=false) then ex_CANV(2);
                 exit;
              end;
        end;

     if (finalizadora=true) and (cod>0) then // verifica se a função Finalizadora está esperando dados.
        begin
           if key=vk_return then
              begin
                 teste:=trim(v_edcodigo);
                 if length(teste)>0 then
                    begin
                       teste:=v_edcodigo;
                       teste:=strtovalor(teste,2);
                       while pos(',',teste)>0 do delete(teste,pos(',',teste),1);
                       v_edcodigo:=teste;
                    end
                 else
                    begin
                       if falta_receber>0 then
                          begin
                             teste:=trim(floattostrf(falta_receber,ffnumber,12,2));
                             while pos(',',teste)>0 do delete(teste,pos(',',teste),1);
                             v_edcodigo:=enche(teste,' ',1,12);
                          end
                       else
                          begin
                             v_edcodigo:=visor_subtot.text;
                          end;
                    end;
                 if (status_erro=false) then ex_fi(2,cod);
                 exit;
              end;
        end;

     try
        if strtofloat(trim(v_edcodigo))>0 then
           begin
              if (tela_venda.visible=true) and (liberado=true) and (total_recebido<=0) and (key=vk_return) then
                 begin
                    opc:=0;

                    if vendendo=false then
                       begin
                          grava_convenio;
                          reorganiza_logs(vpdvnum,V_num_loja);
                       end;

                    EX_lanca_item;
                    edcodigo.enabled:=true;
                    edcodigo.setfocus;
                    exit;
                 end;
           end;
     except
        edcodigo.enabled:=true;
        edcodigo.setfocus;
     end;

     if key=vk_back then
        begin
           IF vmodtec='2' then // caso existe um teclado gertec 65 instalado no PDV
              begin
                 hndl:=LoadLibrary('TEC65_32.DLL');
                 if hndl <> 0 then
                    begin
                       @opentec65:=GetProcAddress(hndl, 'OpenTec65'); // inicializa o display do teclado
                       @setdisp:=GetProcAddress(hndl, 'SetDisp'); // ativa o display do teclado
                       @backspace:=GetProcAddress(hndl, 'BackSpace'); // apaga o último caractar e posiciona o cursor uma casa anterior
                       if @opentec65  <> nil then opentec65;
                       if @setdisp    <> nil then setdisp(1);
                       if @backspace  <> nil then
                          begin
                             if coluna_display>0 then
                                begin
                                   backspace;
                                   coluna_display:=coluna_display-1;
                                end;
                          end;
                       if @setdisp    <> nil then setdisp(0);
                       FreeLibrary(hndl);
                    end;
                 exit;
              end;
        end;

     if Sender is TMaskedit then ed:= sender as TMaskedit;
     Procura_e_ativa_func(key,ed);
     edcodigo.enabled:=true;

end;

procedure TVPDR.Procura_e_ativa_func(tecla:word;ctrl:Tmaskedit);
begin
     acesso_liberado:=1;
// A FUNÇÃO ABAIXO COMENTADA ESTÁ RESERVADA PARA O FUTURO.
//     if (tecla_code_func[tecla]=0001) and (vendendo=true) and (liberado=true) and (status_erro=false) then //Acréscimo IOF em Valor
//        begin
//           opc:=tecla_code_func[tecla];
//           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_
//           exit;
//        end;
     if (tecla_code_func[tecla]=0002) and (vendendo=true) and (liberado=true) and (status_erro=false) then //Acréscimo Tributado em Valor
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_ACTV(1);
           exit;
        end;

// A FUNÇÃO ABAIXO COMENTADA ESTÁ RESERVADA PARA O FUTURO.
//     if (tecla_code_func[tecla]=0003) and (vendendo=true) and (liberado=true) and (status_erro=false) then //Acréscimo IOF em percentual
//        begin
//           opc:=tecla_code_func[tecla];
//           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_
//           exit;
//        end;

     if (tecla_code_func[tecla]=0004) and (vendendo=true) and (liberado=true) and (status_erro=false) then //Acréscimo Tributado em percentual
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_ACTP(1);
           exit;
        end;

     if (tecla_code_func[tecla]=0005) and (vendendo=true) and (liberado=true) and (status_erro=false) then //Desconto em valor
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_DESV(1);
           exit;
        end;

     if (tecla_code_func[tecla]=0006) and (vendendo=true) and (liberado=true) and (status_erro=false) then //Desconto em percentual
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_DESP(1);
           exit;
        end;

     if (tecla_code_func[tecla]=0007) and (vendendo=true) and (liberado=true) and (status_erro=false) then //Cancelamento de item
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_CANI(1);
           exit;
        end;

     if (tecla_code_func[tecla]=0008) and (liberado=true) and (status_erro=false) and (tela_venda.visible=true) then //Cancelamento de venda
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_CANV(1);
           exit;
        end;

     if (tecla_code_func[tecla]=0009) and (liberado=true) and (tela_venda.visible=true) and (status_erro=false) and (vendendo=false) then //Fundo de Caixa
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_FDCX(1);
           exit;
        end;

     if (tecla_code_func[tecla]=0010) and (liberado=true) and (tela_venda.visible=true) and (status_erro=false) and (vendendo=false) then //Sangria
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_SANG(1);
        end;

     if (tecla_code_func[tecla]=0011) and (liberado=true) and (status_erro=false) and (vendendo=false) then //Leitura X
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_LTRX;
           exit;
        end;

     if (tecla_code_func[tecla]=0012) and (liberado=true) and (status_erro=false) and (vendendo=false) then //Redução Z
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_REDZ(1);
           exit;
        end;

     if (tecla_code_func[tecla]=0013) then //Corrigir ação
        begin
           edcodigo.clear;
           ex_CORR(ctrl);
           exit;
        end;

     if (tecla_code_func[tecla]=0014) and (liberado=true) and (status_erro=false) and (vendendo=false) then //Operador
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_OPER(1,0);
           exit;
        end;

     if (tecla_code_func[tecla]=0015) and (liberado=true) and (tela_venda.visible=true) and (status_erro=false) and (vendendo=false) then //lanca conveniado
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_convenio(1);
           exit;
        end;

     if (tecla_code_func[tecla]=0016) and (liberado=true) and (tela_venda.visible=true) and (status_erro=false) then //Lança indicador
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_indc(1);
           exit;
        end;

     if (tecla_code_func[tecla]=0017) and (liberado=true) and (tela_venda.visible=true) and (status_erro=false) then //Consulta PLU - somente é executado com o caixa aberto!!
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_CONS(1);
           exit;
        end;

     if (tecla_code_func[tecla]=0018) and (liberado=true) and (status_erro=false) and (vendendo=false) then //SAIR da opção de venda
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_SAIR(1);
           exit;
        end;

     if (tecla_code_func[tecla]=0019) and (status_erro=false) and ((vendendo=true)or(v_sangria=true)) then //Finalizadora 1
        begin
           edcodigo.clear;
           ftabelas.tbl_condicaopagamento.first;
           ftabelas.tbl_condicaopagamento.moveby(tecla_code_func[tecla]-19);//arranjo técnico para encontrar a forma de pagamento
           cod:=ftabelas.tbl_condicaopagamento.fieldbyname('codigocondicaopagamento').value;

           if v_sangria=true then
              begin
                 ex_SANG(2);
                 exit;
              end
           else
              begin
                 opc:=tecla_code_func[tecla];
                 if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_FI(1,cod);
                 exit;
              end;
        end;
     if (tecla_code_func[tecla]=0020) and (status_erro=false) and ((vendendo=true)or(v_sangria=true)) then //Finalizadora 2
        begin
           edcodigo.clear;
           ftabelas.tbl_condicaopagamento.first;
           ftabelas.tbl_condicaopagamento.moveby(tecla_code_func[tecla]-19);//arranjo técnico para encontrar a forma de pagamento
           cod:=ftabelas.tbl_condicaopagamento.fieldbyname('codigocondicaopagamento').value;

           if v_sangria=true then
              begin
                 ex_SANG(2);
                 exit;
              end
           else
              begin
                 opc:=tecla_code_func[tecla];
                 if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_FI(1,cod);
                 exit;
              end;
        end;
     if (tecla_code_func[tecla]=0021) and (status_erro=false) and ((vendendo=true)or(v_sangria=true)) then //Finalizadora 3
        begin
           edcodigo.clear;
           ftabelas.tbl_condicaopagamento.first;
           ftabelas.tbl_condicaopagamento.moveby(tecla_code_func[tecla]-19);//arranjo técnico para encontrar a forma de pagamento
           cod:=ftabelas.tbl_condicaopagamento.fieldbyname('codigocondicaopagamento').value;

           if v_sangria=true then
              begin
                 ex_SANG(2);
                 exit;
              end
           else
              begin
                 opc:=tecla_code_func[tecla];
                 if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_FI(1,cod);
                 exit;
              end;
        end;
     if (tecla_code_func[tecla]=0022) and (status_erro=false) and ((vendendo=true)or(v_sangria=true)) then //Finalizadora 4
        begin
           edcodigo.clear;
           ftabelas.tbl_condicaopagamento.first;
           ftabelas.tbl_condicaopagamento.moveby(tecla_code_func[tecla]-19);//arranjo técnico para encontrar a forma de pagamento
           cod:=ftabelas.tbl_condicaopagamento.fieldbyname('codigocondicaopagamento').value;

           if v_sangria=true then
              begin
                 ex_SANG(2);
                 exit;
              end
           else
              begin
                 opc:=tecla_code_func[tecla];
                 if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_FI(1,cod);
                 exit;
              end;
        end;
     if (tecla_code_func[tecla]=0023) and (status_erro=false) and ((vendendo=true)or(v_sangria=true)) then //Finalizadora 5
        begin
           edcodigo.clear;
           ftabelas.tbl_condicaopagamento.first;
           ftabelas.tbl_condicaopagamento.moveby(tecla_code_func[tecla]-19);//arranjo técnico para encontrar a forma de pagamento
           cod:=ftabelas.tbl_condicaopagamento.fieldbyname('codigocondicaopagamento').value;

           if v_sangria=true then
              begin
                 ex_SANG(2);
                 exit;
              end
           else
              begin
                 opc:=tecla_code_func[tecla];
                 if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_FI(1,cod);
                 exit;
              end;
        end;
     if (tecla_code_func[tecla]=0024) and (status_erro=false) and ((vendendo=true)or(v_sangria=true)) then //Finalizadora 6
        begin
           edcodigo.clear;
           ftabelas.tbl_condicaopagamento.first;
           ftabelas.tbl_condicaopagamento.moveby(tecla_code_func[tecla]-19);//arranjo técnico para encontrar a forma de pagamento
           cod:=ftabelas.tbl_condicaopagamento.fieldbyname('codigocondicaopagamento').value;

           if v_sangria=true then
              begin
                 ex_SANG(2);
                 exit;
              end
           else
              begin
                 opc:=tecla_code_func[tecla];
                 if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_FI(1,cod);
                 exit;
              end;
        end;
     if (tecla_code_func[tecla]=0025) and (status_erro=false) and ((vendendo=true)or(v_sangria=true)) then //Finalizadora 7
        begin
           edcodigo.clear;
           ftabelas.tbl_condicaopagamento.first;
           ftabelas.tbl_condicaopagamento.moveby(tecla_code_func[tecla]-19);//arranjo técnico para encontrar a forma de pagamento
           cod:=ftabelas.tbl_condicaopagamento.fieldbyname('codigocondicaopagamento').value;

           if v_sangria=true then
              begin
                 ex_SANG(2);
                 exit;
              end
           else
              begin
                 opc:=tecla_code_func[tecla];
                 if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_FI(1,cod);
                 exit;
              end;
        end;
     if (tecla_code_func[tecla]=0026) and (status_erro=false) and ((vendendo=true)or(v_sangria=true)) then //Finalizadora 8
        begin
           edcodigo.clear;
           ftabelas.tbl_condicaopagamento.first;
           ftabelas.tbl_condicaopagamento.moveby(tecla_code_func[tecla]-19);//arranjo técnico para encontrar a forma de pagamento
           cod:=ftabelas.tbl_condicaopagamento.fieldbyname('codigocondicaopagamento').value;

           if v_sangria=true then
              begin
                 ex_SANG(2);
                 exit;
              end
           else
              begin
                 opc:=tecla_code_func[tecla];
                 if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_FI(1,cod);
                 exit;
              end;
        end;
     if (tecla_code_func[tecla]=0027) and (status_erro=false) and ((vendendo=true)or(v_sangria=true)) then //Finalizadora 9
        begin
           edcodigo.clear;
           ftabelas.tbl_condicaopagamento.first;
           ftabelas.tbl_condicaopagamento.moveby(tecla_code_func[tecla]-19);//arranjo técnico para encontrar a forma de pagamento
           cod:=ftabelas.tbl_condicaopagamento.fieldbyname('codigocondicaopagamento').value;

           if v_sangria=true then
              begin
                 ex_SANG(2);
                 exit;
              end
           else
              begin
                 opc:=tecla_code_func[tecla];
                 if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_FI(1,cod);
                 exit;
              end;
        end;
     if (tecla_code_func[tecla]=0028) and (status_erro=false) and ((vendendo=true)or(v_sangria=true)) then //Finalizadora 10
        begin
           edcodigo.clear;
           ftabelas.tbl_condicaopagamento.first;
           ftabelas.tbl_condicaopagamento.moveby(tecla_code_func[tecla]-19);//arranjo técnico para encontrar a forma de pagamento
           cod:=ftabelas.tbl_condicaopagamento.fieldbyname('codigocondicaopagamento').value;

           if v_sangria=true then
              begin
                 ex_SANG(2);
                 exit;
              end
           else
              begin
                 opc:=tecla_code_func[tecla];
                 if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_FI(1,cod);
                 exit;
              end;
        end;

     if (tecla_code_func[tecla]=0039) and (tela_venda.visible=true) then //Multiplicação
        begin
           edcodigo.clear;
           if verifica_liberacao(0039,Existe_consistencia[0039])=true then ex_MULT(1);
           exit;
        end;

     if (tecla_code_func[tecla]=0040)  and (tela_venda.visible=true) then //Valor
        begin
           edcodigo.clear;
           if verifica_liberacao(0040,Existe_consistencia[0040])=true then ex_VALR(1);
           exit;
        end;

     if (tecla_code_func[tecla]=0041) and (vendendo=true) and (status_erro=false) and (finalizadora=false) then //SubTotal
        begin
           edcodigo.clear;
           if verifica_liberacao(0041,Existe_consistencia[0041])=true then ex_Sbto;
           exit;
        end;

     if (tecla_code_func[tecla]=0042) and (liberado=true) and (tela_venda.visible=true) and (status_erro=false) and (vendendo=false) then //Abertura de gaveta fora da venda
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_GAVT;
           exit;
        end;

     if (tecla_code_func[tecla]=0043) and (liberado=true) and (status_erro=false) and (finalizadora=false) and (tela_venda.visible=true) then //Lanca PPI
        begin
           edcodigo.clear;
           opc:=tecla_code_func[tecla];
           if verifica_liberacao(opc,Existe_consistencia[opc])=true then ex_PPI(floattostr(tecla_PPIC_func[tecla]));
           exit;
        end;
end;

procedure TVPDR.ex_canv(tipo:integer);
VAR total:string;
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;

     if tipo=1 then
        begin
           if vendendo=true then
              begin
                 linha_display:=1;
                 message_info(1,'CANCELAMENTO DA'+chr(13)+'VENDA ATUAL-CONFIRMA?');
              end
           else
              begin
                 linha_display:=1;
                 message_info(1,'CANCELAMENTO DA'+chr(13)+'ULTIMA VENDA-CONFIRMA?');
              end;
           canc_venda:=true;
           edcodigo.enabled:=true;
           edcodigo.clear;
           Mask_EDCODigo(1);// mascara NORMAL.
           edcodigo.setfocus;
        end;

     if tipo=2 then
        begin
           v_coo:='';
           total:=visor_subtot.text;
           hndl:=LoadLibrary(v_DLL_ECF);
           if hndl <> 0 then
              begin
                 @Cancelacupom:= GetProcAddress(hndl, 'Cancelacupom');
                 if vendendo=true then
                    begin
                       resposta:=Cancelacupom(strtoint(vmodecf),strtoint(vcomecf),'1',tira_milhar(floattostrf(strtofloat(trim(total))/100,ffnumber,12,2)));
                    end
                 else
                    begin
                       v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');// 07/10/2001 - por Helder Frederico - Pega o coo antes de enviar o comando de cancelamento de venda.
                       resposta:=Cancelacupom(strtoint(vmodecf),strtoint(vcomecf),'0',tira_milhar(floattostrf(total_da_ultima_venda,ffnumber,12,2)));
                    end;

                 FreeLibrary(hndl);
              end;
           if copy(resposta,1,1)<>'@' then
              begin
                 message_info(2,resposta);
              end
           else
              begin
                 cancela_convenio; // 07/10/2001  - por Helder Frederico
                 if vendendo=false then
                    begin
                       total:=strtovalor(floattostr(total_da_ultima_venda),2);
                       cancela_venda_log(0,vpdvnum,V_num_loja); // 28/05/2002 - por Helder Frederico: Caso seja o cancelamento da última venda, o sistema confirma o valor cancelado no log
                    end
                 else
                    begin
                       cancela_venda_log(0,vpdvnum,V_num_loja); // 05/06/2002 - por Helder Frederico: Caso seja o cancelamento da venda atual, o sistema cancela a venda no log
                    end;

                 try
                    strtofloat(v_coo);
                 except
                    v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
                 end;

                 grava_log_venda(0,0,'0000','000',total,0,inttostr(opc),Date,Time,cod_operador,'0','0','0','0',0,codigo_indicador,0,v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC203) o cancelamento do venda

                 reorganiza_logs(vpdvnum,V_num_loja);
                 termina_venda;
                 Flag_venda(2);
                 numero_de_itens:=0;
                 numero_de_itens_desc:=0;
              end;

           v_quant:=1;
           v_prtot:=0;
           linha_display:=1;
           canc_venda:=false;
           edcodigo.enabled:=true;
           edcodigo.clear;
           Mask_edcodigo(1);// mascara normal
           edcodigo.setfocus;
        end;
end;

procedure TVPDR.ex_cani;
var produto:real;
    encontrou:boolean;
    quantidade,unitario,total:string;
    acr203,acr2032:textfile;
    v_codigo, v_quantidade,v_valorun,v_valorto,v_trib_mov,v_funcao,v_data, v_hora:string;
    v_operador,v_banco,v_agencia,v_conta,v_numero,v_cliente,v_indicador,v_CPFCNPJ:string;
    v_Ncp,v_terminal,v_ECF,v_P,v_C,v_Loja:string;
    linha:string;
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     edcodigo.clear;
     fci.showmodal;
     if indice_item<>'' then
        begin
           AssignFile(acr203, extractfilepath(application.exename)+'dados\acr203.vnd');
           Reset(acr203);
           While not Eof(acr203) do
              Begin
                 readln(acr203,linha);

                 v_codigo:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_quantidade:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_valorun:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_valorto:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
// esta variavel não é usada aqui                 v_trib:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_funcao:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_data:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_hora:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_operador:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_banco:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_agencia:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_conta:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_numero:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_cliente:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_indicador:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_CPFCNPJ:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_Ncp:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_terminal:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_ECF:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_P:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_C:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 v_Loja:=copy(linha,1,pos('|',linha)-1);
                 delete(linha,1,pos('|',linha));
                 if v_hora=posdb[strtoint(indice_item)] then
                    begin
                       if v_c=chr(39)+'X'+chr(39) then
                          begin
                             linha_display:=1;
                             message_info(2,'PRODUTO JA CANCELADO. NAO PODE'+chr(13)+'SER EXCLUIDO NOVAMENTE');
                             encontrou:=false;
                             break;
                          end
                       else
                          begin
                             encontrou:=true;
                             produto:=strtofloat(v_codigo);
                             while pos(chr(39),v_quantidade)>0 do delete(v_quantidade,pos(chr(39),v_quantidade),1);
                             quantidade:=v_quantidade;

                             while pos(chr(39),v_valorun)>0 do delete(v_valorun,pos(chr(39),v_valorun),1);
                             unitario:=v_valorun;

                             while pos(chr(39),v_valorto)>0 do delete(v_valorto,pos(chr(39),v_valorto),1);
                             total:=v_valorto;
                             break;
                          end;
                    end;
              End;
           CloseFile(acr203);


           if encontrou=true then
              begin
                 try
                    ftabelas.tbl_produtos.close;
                    ftabelas.tbl_produtos.sql.clear;
                    ftabelas.tbl_produtos.sql.add('select * from produto where codigoproduto='+floattostr(produto));
                    ftabelas.tbl_produtos.prepare;
                    ftabelas.tbl_produtos.open;
                    if ftabelas.tbl_produtos.fieldbyname('codigoproduto').value>0 then encontrou:=true else encontrou:=false;
                 except
                    encontrou:=false;
                 end;
                 if encontrou=true then captura_produto(0);
              end;

           if encontrou=true then
              begin
                 v_coo:='';
                 hndl:=LoadLibrary(v_DLL_ECF);
                 if hndl <> 0 then
                    begin
                       @CancItem:=GetProcAddress(hndl, 'CancItem');
                       if @CancItem <> nil then
                          begin
                             resposta:=CancItem(strtoint(vmodecf),strtoint(vcomecf),floattostr(produto),v_desc,floattostrf(strtofloat(tira_milhar(total))/100,ffnumber,12,2),v_trib,inttostr(posecf[strtoint(indice_item)]));
                          end;
                       FreeLibrary(hndl);
                    end;
                 if copy(resposta,1,1)<>'@' then
                    begin
                       message_info(2,resposta);
                    end
                 else
                    begin
                       // vai procurar o item novamente para flega-lo como cancelado
                       AssignFile(acr203, extractfilepath(application.exename)+'dados\acr203.vnd');
                       AssignFile(acr2032, extractfilepath(application.exename)+'dados\acr2032.vnd');
                       Reset(acr203);
                       Rewrite(acr2032);
                       encontrou:=false;
                       While not Eof(acr203) do
                          Begin
                             readln(acr203,linha);

                             v_codigo:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_quantidade:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_valorun:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_valorto:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_trib_mov:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_funcao:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_data:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_hora:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_operador:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_banco:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_agencia:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_conta:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_numero:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_cliente:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_indicador:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_CPFCNPJ:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_Ncp:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_terminal:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_ECF:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_P:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_C:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_Loja:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             if (encontrou=true) and (strtofloat(v_codigo)<>0) and ((v_funcao='05') or (v_funcao='06')) then
                                begin
                                   v_c:=chr(39)+'X'+chr(39);
                                END;
                             encontrou:=false;
                             if v_hora=posdb[strtoint(indice_item)] then
                                begin
                                   v_c:=chr(39)+'X'+chr(39);
                                   encontrou:=true;
                                END;

                             writeln(acr2032,v_codigo+'|'+
                                 v_quantidade+'|'+
                                 v_valorun+'|'+
                                 v_valorto+'|'+
                                 v_trib_mov+'|'+
                                 v_funcao+'|'+
                                 v_data+'|'+
                                 v_hora+'|'+
                                 v_operador+'|'+
                                 v_banco+'|'+
                                 v_agencia+'|'+
                                 v_conta+'|'+
                                 v_numero+'|'+
                                 v_cliente+'|'+
                                 v_indicador+'|'+
                                 v_CPFCNPJ+'|'+
                                 v_Ncp+'|'+
                                 v_terminal+'|'+
                                 v_ECF+'|'+
                                 v_P+'|'+
                                 v_C+'|'+
                                 v_Loja+'|');

                          End;
                       CloseFile(acr203);
                       CloseFile(acr2032);

                       deletefile(extractfilepath(application.exename)+'dados\acr203.vnd');
                       renamefile(extractfilepath(application.exename)+'dados\acr2032.vnd',extractfilepath(application.exename)+'dados\acr203.vnd');
                       deletefile(extractfilepath(application.exename)+'dados\acr2032.vnd');

                       try
                          strtofloat(v_coo);
                       except
                          v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
                       end;
                       grava_log_venda(0,produto,quantidade,unitario,total,0,inttostr(opc),Date,Time,cod_operador,'0','0','0','0',0,codigo_indicador,0,v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC203) o cancelamento do item
                       numero_de_itens:=numero_de_itens-1;
                       numero_de_itens_desc:=numero_de_itens_desc-1;
                       v_total:=v_total-(strtofloat(tira_milhar(total))/100);
                       V_quant_total:=V_quant_total-(strtofloat(tira_milhar(quantidade))/1000);
                       v_quant:=1;
                       v_prtot:=0;
                       visor_pruni.editmask:='999999,99;0; ';
                       Mostra_produto('','000','1000','000',floattostrf(v_total,ffnumber,12,2));
                       linha_display:=1;
                       MESSAge_info(1,'');
                    end;
              end
           else
              begin
                 linha_display:=1;
                 message_info(2,'PRODUTO NAO ENCONTRADO'+chr(13)+'NO CADASTRO');
              end;
        end;
     Mask_edcodigo(1);// mascara normal
     edcodigo.enabled:=true;
     edcodigo.clear;
     edcodigo.setfocus;
end;


procedure TVPDR.ex_ACTV(tipo:integer);
var atual,rateio,percentual,total,limite:real;
    acr203,acr2032:textfile;
    v_codigo, v_quantidade,v_valorun,v_valorto,v_trib,v_funcao,v_data, v_hora:string;
    v_operador,v_banco,v_agencia,v_conta,v_numero,v_cliente,v_indicador,v_CPFCNPJ:string;
    v_Ncp,v_terminal,v_ECF,v_P,v_C,v_Loja:string;
    linha:string;
    autocom:Tinifile;
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     grava_convenio;
     if tipo=1 then
        begin
           if numero_de_acre_sub>=max_acre_sub then
              begin
                 linha_display:=2;
                 message_info(2,'MAXIMO DE ACRESCIMOS:'+inttostr(max_acre_sub));
                 acrt_val:=false;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_EDCODigo(1);// mascara normal
                 edcodigo.setfocus;
                 exit;
              end;


           autocom:=TIniFile.Create(path+'Autocom.INI');
           linha:=autocom.ReadString('TERMINAL', 'acrevfixo', '000');    // acréscimo em valor (fixo/automático)
           autocom.free;
           atual:=strtofloat(copy(trim(linha),1,length(trim(linha))-2)+','+copy(trim(linha),length(trim(linha))-1,2));

           if atual>0 then
              begin
                 v_edcodigo:=floattostr(atual);
                 ex_ACTV(2);
              end
           else
              begin
                 linha_display:=2;
                 message_info(1,'INFORME O VALOR'+chr(13)+'DO ACRESCIMO');
                 acrt_val:=true;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_EDCODigo(3);// mascara para VALOR.
                 edcodigo.setfocus;
              end;
        end;

     if tipo=2 then
        begin
           try
              atual:=(strtofloat(trim(v_edcodigo)))/100;
              rateio:=atual/numero_de_itens;
           except
              linha_display:=1;
              message_info(2,'VALOR'+chr(13)+'INFORMADO INVALIDO');
              acrt_val:=false;
              edcodigo.enabled:=true;
              edcodigo.clear;
              Mask_edcodigo(1);// mascara normal
              edcodigo.setfocus;
              exit;
           end;

           try
              autocom:=TIniFile.Create(path+'Autocom.INI');
              linha:=autocom.ReadString('TERMINAL', 'limacre', '000');    // limite de acrescimo
              autocom.free;
              limite:=(strtofloat(trim(linha)))/100;
              limite:=(v_total*limite)/100;
              limite:=strtofloat(tira_milhar(floattostrf(limite,ffnumber,12,2)));
           except
              linha_display:=2;
              message_info(2,'LIMITE NAO PROGRAMADO');
              desc_per:=false;
              edcodigo.enabled:=true;
              edcodigo.clear;
              Mask_edcodigo(1);// mascara normal
              edcodigo.setfocus;
              exit;
           end;

           if atual>limite then
              begin
                 linha_display:=2;
                 message_info(2,'LIMITE EXCEDIDO');
                 desc_per:=false;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_edcodigo(1);// mascara normal
                 edcodigo.setfocus;
                 exit;
              end;

           v_coo:='';

           edcodigo.enabled:=false;
           hndl:=LoadLibrary(v_DLL_ECF);
           if hndl <> 0 then
              begin
                 @Acresub:=GetProcAddress(hndl, 'AcreSub');
                 if @Acresub <> nil then
                    begin
                       resposta:=Acresub(strtoint(vmodecf),strtoint(vcomecf),floattostrf(atual,ffnumber,12,2),'2'); // tipo de acrescimo=2 pq é tributado
                    end;
                 FreeLibrary(hndl);
              end;

           if copy(resposta,1,1)<>'@' then
              begin
                 message_info(2,resposta);
              end
           else
              begin
                 //a rotina abaixo procura o item para abater o acrescimo de subtotal no log
                 percentuaL:=((atual*100)/v_total)/100;

                 AssignFile(acr203, extractfilepath(application.exename)+'dados\acr203.vnd');
                 AssignFile(acr2032, extractfilepath(application.exename)+'dados\acr2032.vnd');
                 Reset(acr203);
                 Rewrite(acr2032);
                 While not Eof(acr203) do
                    Begin
                       readln(acr203,linha);

                       v_codigo:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_quantidade:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_valorun:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_valorto:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_trib:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_funcao:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_data:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_hora:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_operador:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_banco:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_agencia:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_conta:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_numero:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_cliente:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_indicador:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_CPFCNPJ:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_Ncp:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_terminal:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_ECF:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_P:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_C:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_Loja:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));

                       while pos(chr(39),v_valorto)>0 do delete(v_valorto,pos(chr(39),v_valorto),1);
                       total:=strtofloat(v_valorto)/100;
                       teste:=floattostrf(total+strtofloat(floattostrf((total*percentual),ffnumber,8,2)),ffnumber,12,2);
                       while pos('.',teste)>0 do delete(teste,pos('.',teste),1);
                       while pos(',',teste)>0 do delete(teste,pos(',',teste),1);
                       teste:=enche(trim(teste),'0',1,12);
                       v_valorto:=chr(39)+teste+chr(39);

                       writeln(acr2032,v_codigo+'|'+
                                 v_quantidade+'|'+
                                 v_valorun+'|'+
                                 v_valorto+'|'+
                                 v_trib+'|'+
                                 v_funcao+'|'+
                                 v_data+'|'+
                                 v_hora+'|'+
                                 v_operador+'|'+
                                 v_banco+'|'+
                                 v_agencia+'|'+
                                 v_conta+'|'+
                                 v_numero+'|'+
                                 v_cliente+'|'+
                                 v_indicador+'|'+
                                 v_CPFCNPJ+'|'+
                                 v_Ncp+'|'+
                                 v_terminal+'|'+
                                 v_ECF+'|'+
                                 v_P+'|'+
                                 v_C+'|'+
                                 v_Loja+'|');

                    End;
                 CloseFile(acr203);
                 CloseFile(acr2032);

                 deletefile(extractfilepath(application.exename)+'dados\acr203.vnd');
                 renamefile(extractfilepath(application.exename)+'dados\acr2032.vnd',extractfilepath(application.exename)+'dados\acr203.vnd');
                 deletefile(extractfilepath(application.exename)+'dados\acr2032.vnd');

                 ftabelas.query1.close;
                 ftabelas.query1.sql.clear;
                 ftabelas.query1.sql.add('commit');
                 ftabelas.query1.prepare;
                 ftabelas.query1.execsql;

                 try
                    strtofloat(v_coo);
                 except
                    v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
                 end;
                 grava_log_venda(0,0,'0',floattostrf(rateio,ffnumber,8,2),floattostrf(atual,ffnumber,12,2),0,inttostr(opc),Date,Time,cod_operador,'0','0','0','0',0,codigo_indicador,0,v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC203) o acrescimo tributado
                 Flag_venda(1);
                 v_total:=v_total+atual;
                 v_quant:=1;
                 v_prtot:=0;
                 numero_de_acre_sub:=numero_de_acre_sub+1;
                 visor_pruni.editmask:='999999,99;0; ';
                 Mostra_produto('','000','1000','000',floattostrf(v_total,ffnumber,12,2));
                 edcodigo.enabled:=true;
                 edcodigo.setfocus;
                 linha_display:=1;
                 MESSAge_info(1,'');
              end;
           acrt_val:=false;
           edcodigo.enabled:=true;
           edcodigo.clear;
           Mask_edcodigo(1);// mascara normal
           edcodigo.setfocus;
        end;
end;


procedure TVPDR.ex_ACTP(tipo:integer);
var atual,rateio,total,limite:real;
    acr203,acr2032:textfile;
    v_codigo, v_quantidade,v_valorun,v_valorto,v_trib,v_funcao,v_data, v_hora:string;
    v_operador,v_banco,v_agencia,v_conta,v_numero,v_cliente,v_indicador,v_CPFCNPJ:string;
    v_Ncp,v_terminal,v_ECF,v_P,v_C,v_Loja:string;
    linha:string;
    autocom:Tinifile;
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     grava_convenio;
     if tipo=1 then
        begin
           if numero_de_acre_sub>=max_acre_sub then
              begin
                 linha_display:=2;
                 message_info(2,'MAXIMO DE ACRESCIMOS:'+inttostr(max_acre_sub));
                 acrt_PER:=false;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_EDCODigo(1);// mascara normal
                 edcodigo.setfocus;
                 exit;
              end;

           autocom:=TIniFile.Create(path+'Autocom.INI');
           linha:=autocom.ReadString('TERMINAL', 'acrepfixo', '000');    // acréscimo em porcentagem (fixo/automático)
           autocom.free;
           atual:=strtofloat(copy(trim(linha),1,length(trim(linha))-2)+','+copy(trim(linha),length(trim(linha))-1,2));

           if atual>0 then
              begin
                 v_edcodigo:=floattostr(atual);
                 ex_ACTP(2);
              end
           else
              begin
                 linha_display:=2;
                 message_info(1,'INFORME O PERCENTUAL'+chr(13)+'DO ACRESCIMO');
                 acrT_per:=true;
                 edcodigo.clear;
                 Mask_EDCODigo(5);// mascara para percentual.
                 edcodigo.setfocus;
              end;
        end;

     if tipo=2 then
        begin
           try
              atual:=v_total*((strtofloat(trim(v_edcodigo))))/100;
              rateio:=atual/numero_de_itens;
              atual:=strtofloat(tira_milhar(floattostrf(atual,ffnumber,12,2)));
           except
              linha_display:=1;
              message_info(2,'PERCENTUAL'+chr(13)+'INFORMADO INVALIDO');
              acrT_per:=false;
              edcodigo.enabled:=true;
              edcodigo.clear;
              Mask_edcodigo(1);// mascara normal
              edcodigo.setfocus;
              exit;
           end;

           try
              autocom:=TIniFile.Create(path+'Autocom.INI');
              linha:=autocom.ReadString('TERMINAL', 'limacre', '000');    // limite de acrescimo
              autocom.free;
              limite:=(strtofloat(trim(linha)))/100;
              limite:=(v_total*limite)/100;
              limite:=strtofloat(tira_milhar(floattostrf(limite,ffnumber,12,2)));
           except
              linha_display:=2;
              message_info(2,'LIMITE NAO PROGRAMADO');
              desc_per:=false;
              edcodigo.enabled:=true;
              edcodigo.clear;
              Mask_edcodigo(1);// mascara normal
              edcodigo.setfocus;
              exit;
           end;

           if atual>limite then
              begin
                 linha_display:=2;
                 message_info(2,'LIMITE EXCEDIDO');
                 desc_per:=false;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_edcodigo(1);// mascara normal
                 edcodigo.setfocus;
                 exit;
              end;

           v_coo:='';
           edcodigo.enabled:=false;
           hndl:=LoadLibrary(v_DLL_ECF);
           if hndl <> 0 then
              begin
                 @Acresub:=GetProcAddress(hndl, 'AcreSub');
                 if @Acresub <> nil then
                    begin
                       resposta:=Acresub(strtoint(vmodecf),strtoint(vcomecf),floattostrf(atual,ffnumber,12,2),'2'); // tipo de acrescimo=2 pq é tributado
                    end;
                 FreeLibrary(hndl);
              end;

           if copy(resposta,1,1)<>'@' then
              begin
                 message_info(2,resposta);
              end
           else
              begin
                 //a rotina abaixo procura o item para abater o acrescimo de subtotal no log
                 AssignFile(acr203, extractfilepath(application.exename)+'dados\acr203.vnd');
                 AssignFile(acr2032, extractfilepath(application.exename)+'dados\acr2032.vnd');
                 Reset(acr203);
                 Rewrite(acr2032);
                 While not Eof(acr203) do
                    Begin
                       readln(acr203,linha);

                       v_codigo:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_quantidade:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_valorun:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_valorto:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_trib:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_funcao:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_data:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_hora:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_operador:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_banco:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_agencia:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_conta:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_numero:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_cliente:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_indicador:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_CPFCNPJ:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_Ncp:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_terminal:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_ECF:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_P:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_C:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));
                       v_Loja:=copy(linha,1,pos('|',linha)-1);
                       delete(linha,1,pos('|',linha));

                       while pos(chr(39),v_valorto)>0 do delete(v_valorto,pos(chr(39),v_valorto),1);
                       total:=strtofloat(v_valorto)/100;
                       teste:=floattostrf(total+strtofloat(floattostrf(total*((strtofloat(trim(v_edcodigo)))/100),ffnumber,8,2)),ffnumber,12,2);
                       while pos('.',teste)>0 do delete(teste,pos('.',teste),1);
                       while pos(',',teste)>0 do delete(teste,pos(',',teste),1);
                       teste:=enche(trim(teste),'0',1,12);
                       v_valorto:=chr(39)+teste+chr(39);

                       writeln(acr2032,v_codigo+'|'+
                                 v_quantidade+'|'+
                                 v_valorun+'|'+
                                 v_valorto+'|'+
                                 v_trib+'|'+
                                 v_funcao+'|'+
                                 v_data+'|'+
                                 v_hora+'|'+
                                 v_operador+'|'+
                                 v_banco+'|'+
                                 v_agencia+'|'+
                                 v_conta+'|'+
                                 v_numero+'|'+
                                 v_cliente+'|'+
                                 v_indicador+'|'+
                                 v_CPFCNPJ+'|'+
                                 v_Ncp+'|'+
                                 v_terminal+'|'+
                                 v_ECF+'|'+
                                 v_P+'|'+
                                 v_C+'|'+
                                 v_Loja+'|');

                    End;
                 CloseFile(acr203);
                 CloseFile(acr2032);

                 deletefile(extractfilepath(application.exename)+'dados\acr203.vnd');
                 renamefile(extractfilepath(application.exename)+'dados\acr2032.vnd',extractfilepath(application.exename)+'dados\acr203.vnd');
                 deletefile(extractfilepath(application.exename)+'dados\acr2032.vnd');

                 try
                    strtofloat(v_coo);
                 except
                    v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
                 end;
                 grava_log_venda(0,0,'0',floattostrf(rateio,ffnumber,8,2),floattostrf(atual,ffnumber,12,2),0,inttostr(opc),Date,Time,cod_operador,'0','0','0','0',0,codigo_indicador,0,v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC203) o acrescimo tributado
                 Flag_venda(1);
                 v_total:=v_total+atual;
                 v_quant:=1;
                 v_prtot:=0;
                 numero_de_acre_sub:=numero_de_acre_sub+1;
                 visor_pruni.editmask:='999999,99;0; ';
                 Mostra_produto('','000','1000','000',floattostrf(v_total,ffnumber,12,2));
                 edcodigo.enabled:=true;
                 edcodigo.setfocus;
                 linha_display:=1;
                 MESSAge_info(1,'');
              end;
           acrt_per:=false;
           edcodigo.enabled:=true;
           edcodigo.clear;
           Mask_edcodigo(1);// mascara normal
           edcodigo.setfocus;
        end;
end;

procedure TVPDR.ex_DESP(tipo:integer);
var atual,rateio,total,limite:real;
    acr203,acr2032:textfile;
    v_codigo, v_quantidade,v_valorun,v_valorto,v_trib,v_funcao,v_data, v_hora:string;
    v_operador,v_banco,v_agencia,v_conta,v_numero,v_cliente,v_indicador,v_CPFCNPJ:string;
    v_Ncp,v_terminal,v_ECF,v_P,v_C,v_Loja:string;
    linha:string;
    autocom:Tinifile;
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     if tipo=1 then
        begin
           if sub_total=true then
              begin
                 desc_item:=false;
                 sub_total:=false;
                 if numero_de_desc_sub>=max_desc_sub then
                    begin
                       linha_display:=2;
                       message_info(2,'MAXIMO DE DESCONTOS'+chr(13)+'NO SUBTOTAL:'+inttostr(max_desc_sub));
                       desc_per:=false;
                       edcodigo.enabled:=true;
                       edcodigo.clear;
                       Mask_EDCODigo(1);// mascara normal
                       edcodigo.setfocus;
                       exit;
                    end;
              end
           else
              begin
                 if ja_lancou_desc_no_item=true then
                    begin
                       linha_display:=2;
                       message_info(2,'MAXIMO DE DESCONTOS'+chr(13)+'NO ITEM');
                       desc_per:=false;
                       edcodigo.enabled:=true;
                       edcodigo.clear;
                       Mask_EDCODigo(1);// mascara normal
                       edcodigo.setfocus;
                       exit;
                    end
                 else
                    begin
                       desc_item:=true;
                    end;
              end;


           autocom:=TIniFile.Create(path+'Autocom.INI');
           linha:=autocom.ReadString('TERMINAL', 'descpfixo', '000');    // desconto em porcentagem (fixo/automático)
           autocom.free;
           atual:=(strtofloat(tira_milhar(trim(linha))))/100;

           if atual>0 then
              begin
                 v_edcodigo:=floattostr(atual);
                 ex_desp(2);
              end
           else
              begin
                 linha_display:=2;
                 message_info(1,'INFORME O PERCENTUAL'+chr(13)+'DO DESCONTO');
                 desc_per:=true;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_EDCODigo(5);// mascara para percentual.
                 edcodigo.setfocus;
              end;
        end;

     if tipo=2 then
        begin
           try
              if desc_item=FALSE then
                 begin
                    atual:=strtofloat(floattostrf(v_total*((strtofloat(trim(v_edcodigo)))/100),ffnumber,8,2));
                    rateio:=strtofloat(floattostrf(atual/numero_de_itens_desc,ffnumber,8,2));
                 end
              else
                 begin
                    atual:=strtofloat(floattostrf(v_prtot*((strtofloat(trim(v_edcodigo)))/100),ffnumber,8,2));
                 end;
           except
              linha_display:=2;
              message_info(2,'ERRO: PERCENTUAL'+chr(13)+'INFORMADO INVALIDO');
              desc_per:=false;
              edcodigo.enabled:=true;
              edcodigo.clear;
              Mask_edcodigo(1);// mascara normal
              edcodigo.setfocus;
              exit;
           end;

           IF desc_item=false then
              begin
                 if atual>=v_total then
                    begin
                       linha_display:=2;
                       message_info(2,'ERRO - PERCENTUAL'+chr(13)+'INFORMADO INVALIDO');
                       desc_per:=false;
                       edcodigo.enabled:=true;
                       edcodigo.clear;
                       Mask_edcodigo(1);// mascara normal
                       edcodigo.setfocus;
                       exit;
                    end;
              end
           else
              begin
                 if atual>=v_prtot then
                    begin
                       linha_display:=2;
                       message_info(2,'ERRO - PERCENTUAL'+chr(13)+'INFORMADO INVALIDO');
                       desc_per:=false;
                       edcodigo.enabled:=true;
                       edcodigo.clear;
                       Mask_edcodigo(1);// mascara normal
                       edcodigo.setfocus;
                       exit;
                    end;
              end;

           try
              autocom:=TIniFile.Create(path+'Autocom.INI');
              linha:=autocom.ReadString('TERMINAL', 'limdesc', '000');    // limite de desconto
              autocom.free;
              limite:=(strtofloat(trim(linha)))/100;
              if desc_item=false then
                 begin
                    limite:=(v_total*limite)/100;
                 end
              else
                 begin
                    limite:=(v_prtot*limite)/100;
                 end;
              limite:=strtofloat(tira_milhar(floattostrf(limite,ffnumber,12,2)));
           except
              linha_display:=2;
              message_info(2,'LIMITE NAO PROGRAMADO');
              desc_per:=false;
              edcodigo.enabled:=true;
              edcodigo.clear;
              Mask_edcodigo(1);// mascara normal
              edcodigo.setfocus;
              exit;
           end;

           if atual>limite then
              begin
                 linha_display:=2;
                 message_info(2,'LIMITE EXCEDIDO');
                 desc_per:=false;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_edcodigo(1);// mascara normal
                 edcodigo.setfocus;
                 exit;
              end;

           if desc_item=true then
              begin
                 edcodigo.enabled:=false;
                 v_coo:='';
                 hndl:=LoadLibrary(v_DLL_ECF);
                 if hndl <> 0 then
                    begin
                       @Descitem:=GetProcAddress(hndl, 'Descitem');
                       if @Descitem <> nil then
                          begin
                             resposta:=Descitem(strtoint(vmodecf),strtoint(vcomecf),floattostrf(atual,ffnumber,12,2));
                          end;
                       FreeLibrary(hndl);
                    end;

                 if copy(resposta,1,1)<>'@' then
                    begin
                       message_info(2,resposta);
                    end
                 else
                    begin
                       try
                          strtofloat(v_coo);
                       except
                          v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
                       end;


                       //a rotina abaixo procura o item para abater o desconto no log
                       AssignFile(acr203, extractfilepath(application.exename)+'dados\acr203.vnd');
                       AssignFile(acr2032, extractfilepath(application.exename)+'dados\acr2032.vnd');
                       Reset(acr203);
                       Rewrite(acr2032);
                       While not Eof(acr203) do
                          Begin
                             readln(acr203,linha);

                             v_codigo:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_quantidade:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_valorun:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_valorto:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_trib:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_funcao:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_data:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_hora:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_operador:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_banco:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_agencia:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_conta:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_numero:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_cliente:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_indicador:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_CPFCNPJ:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_Ncp:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_terminal:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_ECF:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_P:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_C:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_Loja:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));

                             if eof(acr203) then
                                begin
                                   while pos(chr(39),v_valorto)>0 do delete(v_valorto,pos(chr(39),v_valorto),1);
                                   total:=strtofloat(v_valorto)/100;
                                   teste:=floattostrf(total-atual,ffnumber,12,2);
                                   while pos('.',teste)>0 do delete(teste,pos('.',teste),1);
                                   while pos(',',teste)>0 do delete(teste,pos(',',teste),1);
                                   teste:=enche(trim(teste),'0',1,12);
                                   v_valorto:=chr(39)+teste+chr(39);
                                end;

                             writeln(acr2032,v_codigo+'|'+
                                 v_quantidade+'|'+
                                 v_valorun+'|'+
                                 v_valorto+'|'+
                                 v_trib+'|'+
                                 v_funcao+'|'+
                                 v_data+'|'+
                                 v_hora+'|'+
                                 v_operador+'|'+
                                 v_banco+'|'+
                                 v_agencia+'|'+
                                 v_conta+'|'+
                                 v_numero+'|'+
                                 v_cliente+'|'+
                                 v_indicador+'|'+
                                 v_CPFCNPJ+'|'+
                                 v_Ncp+'|'+
                                 v_terminal+'|'+
                                 v_ECF+'|'+
                                 v_P+'|'+
                                 v_C+'|'+
                                 v_Loja+'|');

                          End;
                       CloseFile(acr203);
                       CloseFile(acr2032);

                       deletefile(extractfilepath(application.exename)+'dados\acr203.vnd');
                       renamefile(extractfilepath(application.exename)+'dados\acr2032.vnd',extractfilepath(application.exename)+'dados\acr203.vnd');
                       deletefile(extractfilepath(application.exename)+'dados\acr2032.vnd');

                       grava_log_venda(0,v_prod,'0',floattostrf(atual,ffnumber,8,2),floattostrf(atual,ffnumber,12,2),0,inttostr(opc),Date,Time,cod_operador,floattostr(v_depto),'0','0','0',0,codigo_indicador,0,v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC203) o desc. item
                       Flag_venda(1);
                       v_total:=v_total-atual;
                       v_quant:=1;
                       v_prtot:=0;
                       ja_lancou_desc_no_item:=true;
                       visor_pruni.editmask:='999999,99;0; ';
                       if codigo_conveniado<=0 then
                          begin
                             Mostra_produto('','000','1000','000',floattostrf(v_total,ffnumber,12,2)); // somente vai altertar a tela quando não for venda em convenio.
                          end
                       else
                          begin
                             Mostra_produto(visor_desc.text,visor_pruni.text,visor_qtde.text,visor_tot.text,floattostrf(v_total,ffnumber,12,2)); // somente vai altertar a tela quando não for venda em convenio.
                          end;
                       edcodigo.enabled:=true;
                       edcodigo.setfocus;
                       linha_display:=1;
                       MESSAge_info(1,'');
                    end;
              end
           else
              begin
                 edcodigo.enabled:=false;
                 v_coo:='';
                 hndl:=LoadLibrary(v_DLL_ECF);
                 if hndl <> 0 then
                    begin
                       @DescSub:=GetProcAddress(hndl, 'DescSub');
                       if @DescSub <> nil then
                          begin
                             resposta:=DescSub(strtoint(vmodecf),strtoint(vcomecf),floattostrf(atual,ffnumber,12,2));
                          end;
                       FreeLibrary(hndl);
                    end;

                 if copy(resposta,1,1)<>'@' then
                    begin
                       message_info(2,resposta);
                    end
                 else
                    begin
                       try
                          strtofloat(v_coo);
                       except
                          v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
                       end;


                       //a rotina abaixo procura o item para abater o desconto de subtotal no log
                       AssignFile(acr203, extractfilepath(application.exename)+'dados\acr203.vnd');
                       AssignFile(acr2032, extractfilepath(application.exename)+'dados\acr2032.vnd');
                       Reset(acr203);
                       Rewrite(acr2032);
                       While not Eof(acr203) do
                          Begin
                             readln(acr203,linha);

                             v_codigo:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_quantidade:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_valorun:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_valorto:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_trib:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_funcao:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_data:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_hora:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_operador:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_banco:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_agencia:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_conta:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_numero:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_cliente:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_indicador:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_CPFCNPJ:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_Ncp:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_terminal:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_ECF:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_P:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_C:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_Loja:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));

                             while pos(chr(39),v_valorto)>0 do delete(v_valorto,pos(chr(39),v_valorto),1);
                             total:=strtofloat(v_valorto)/100;
                             teste:=floattostrf(total-strtofloat(floattostrf(total*((strtofloat(trim(v_edcodigo)))/100),ffnumber,8,2)),ffnumber,12,2);
                             while pos('.',teste)>0 do delete(teste,pos('.',teste),1);
                             while pos(',',teste)>0 do delete(teste,pos(',',teste),1);
                             teste:=enche(trim(teste),'0',1,12);
                             v_valorto:=chr(39)+teste+chr(39);

                             writeln(acr2032,v_codigo+'|'+
                                 v_quantidade+'|'+
                                 v_valorun+'|'+
                                 v_valorto+'|'+
                                 v_trib+'|'+
                                 v_funcao+'|'+
                                 v_data+'|'+
                                 v_hora+'|'+
                                 v_operador+'|'+
                                 v_banco+'|'+
                                 v_agencia+'|'+
                                 v_conta+'|'+
                                 v_numero+'|'+
                                 v_cliente+'|'+
                                 v_indicador+'|'+
                                 v_CPFCNPJ+'|'+
                                 v_Ncp+'|'+
                                 v_terminal+'|'+
                                 v_ECF+'|'+
                                 v_P+'|'+
                                 v_C+'|'+
                                 v_Loja+'|');

                          End;
                       CloseFile(acr203);
                       CloseFile(acr2032);

                       deletefile(extractfilepath(application.exename)+'dados\acr203.vnd');
                       renamefile(extractfilepath(application.exename)+'dados\acr2032.vnd',extractfilepath(application.exename)+'dados\acr203.vnd');
                       deletefile(extractfilepath(application.exename)+'dados\acr2032.vnd');

                       grava_log_venda(0,0,'0',floattostrf(rateio,ffnumber,8,2),floattostrf(atual,ffnumber,12,2),0,inttostr(opc),Date,Time,cod_operador,'0','0','0','0',0,codigo_indicador,0,v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC200) o desc. subtotal
                       Flag_venda(1);
                       v_total:=v_total-atual;
                       v_quant:=1;
                       v_prtot:=0;
                       numero_de_itens_desc:=0;
                       numero_de_desc_sub:=numero_de_desc_sub+1;
                       visor_pruni.editmask:='999999,99;0; ';
                       Mostra_produto('','000','1000','000',floattostrf(v_total,ffnumber,12,2));
                       edcodigo.enabled:=true;
                       edcodigo.setfocus;
                       linha_display:=1;
                       MESSAge_info(1,'');
                    end;
              end;

           desc_per:=false;
           edcodigo.enabled:=true;
           edcodigo.clear;
           Mask_edcodigo(1);// mascara normal
           edcodigo.setfocus;
        end;
end;


procedure TVPDR.ex_DESV(tipo:integer);
var atual,total,rateio,percentual,limite:real;
    acr203,acr2032:textfile;
    v_codigo, v_quantidade,v_valorun,v_valorto,v_trib,v_funcao,v_data, v_hora:string;
    v_operador,v_banco,v_agencia,v_conta,v_numero,v_cliente,v_indicador,v_CPFCNPJ:string;
    v_Ncp,v_terminal,v_ECF,v_P,v_C,v_Loja:string;
    linha:string;
    autocom:Tinifile;
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     if tipo=1 then
        begin
           if sub_total=true then
              begin
                 desc_item:=false;
                 sub_total:=false;
                 if numero_de_desc_sub>=max_desc_sub then
                    begin
                       linha_display:=2;
                       message_info(2,'MAXIMO DE DESCONTOS'+chr(13)+'NO SUBTOTAL:'+inttostr(max_desc_sub));
                       desc_val:=false;
                       edcodigo.enabled:=true;
                       edcodigo.clear;
                       Mask_EDCODigo(1);// mascara normal
                       edcodigo.setfocus;
                       exit;
                    end;
              end
           else
              begin
                 if ja_lancou_desc_no_item=true then
                    begin
                       linha_display:=2;
                       message_info(2,'MAXIMO DE DESCONTOS NO ITEM');
                       desc_per:=false;
                       edcodigo.enabled:=true;
                       edcodigo.clear;
                       Mask_EDCODigo(1);// mascara normal
                       edcodigo.setfocus;
                       exit;
                    end
                 else
                    begin
                       desc_item:=true;
                    end;
              end;


           autocom:=TIniFile.Create(path+'Autocom.INI');
           linha:=autocom.ReadString('TERMINAL', 'descvfixo', '000');    // desconto em valor (fixo/automático)
           autocom.free;
           atual:=strtofloat(copy(trim(linha),1,length(trim(linha))-2)+','+copy(trim(linha),length(trim(linha))-1,2));

           if atual>0 then
              begin
                 v_edcodigo:=floattostr(atual);
                 ex_desv(2);
              end
           else
              begin
                 linha_display:=2;
                 message_info(1,'INFORME O VALOR'+chr(13)+'DO DESCONTO');
                 desc_val:=true;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_EDCODigo(3);// mascara para VALOR.
                 edcodigo.setfocus;
              end;
        end;

     if tipo=2 then
        begin
           try
              atual:=strtofloat(floattostrf((strtofloat(trim(v_edcodigo)))/100,ffnumber,8,2));
              if desc_item=false then rateio:=strtofloat(floattostrf(atual/numero_de_itens_desc,ffnumber,8,2));
           except
              linha_display:=1;
              message_info(2,'ERRO : VALOR'+chr(13)+'INFORMADO INVALIDO');
              desc_val:=false;
              edcodigo.enabled:=true;
              edcodigo.clear;
              Mask_edcodigo(1);// mascara normal
              edcodigo.setfocus;
              exit;
           end;

           if desc_item=false then
              begin
                 if atual>=v_total then
                    begin
                       linha_display:=2;
                       message_info(2,'ERRO - VALOR'+chr(13)+'INFORMADO INVALIDO');
                       desc_per:=false;
                       edcodigo.enabled:=true;
                       edcodigo.clear;
                       Mask_edcodigo(1);// mascara normal
                       edcodigo.setfocus;
                       exit;
                    end;
              end
           else
              begin
                 if atual>=v_prtot then
                    begin
                       linha_display:=2;
                       message_info(2,'ERRO - VALOR'+chr(13)+'INFORMADO INVALIDO');
                       desc_per:=false;
                       edcodigo.enabled:=true;
                       edcodigo.clear;
                       Mask_edcodigo(1);// mascara normal
                       edcodigo.setfocus;
                       exit;
                    end;
              end;



           try
              autocom:=TIniFile.Create(path+'Autocom.INI');
              linha:=autocom.ReadString('TERMINAL', 'limdesc', '000');    // limite de desconto
              autocom.free;
              limite:=(strtofloat(trim(linha)))/100;
              if desc_item=false then
                 begin
                    limite:=strtofloat(tira_milhar(floattostrf(((v_total*limite)/100),ffnumber,8,2)));
                 end
              else
                 begin
                    limite:=strtofloat(tira_milhar(floattostrf(((v_prtot*limite)/100),ffnumber,8,2)));
                 end;
              limite:=strtofloat(tira_milhar(floattostrf(limite,ffnumber,12,2)));
           except
              linha_display:=2;
              message_info(2,'O LIMITE DE DESCONTO'+chr(13)+'ESTA INVALIDO');
              desc_per:=false;
              edcodigo.enabled:=true;
              edcodigo.clear;
              Mask_edcodigo(1);// mascara normal
              edcodigo.setfocus;
              exit;
           end;



           if atual>limite then
              begin
                 linha_display:=2;
                 message_info(2,'LIMITE EXCEDIDO');
                 desc_per:=false;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_edcodigo(1);// mascara normal
                 edcodigo.setfocus;
                 exit;
              end;

           if desc_item=true then
              begin
                 edcodigo.enabled:=false;
                 v_coo:='';
                 hndl:=LoadLibrary(v_DLL_ECF);
                 if hndl <> 0 then
                    begin
                       @Descitem:=GetProcAddress(hndl, 'Descitem');
                       if @Descitem <> nil then
                          begin
                             resposta:=Descitem(strtoint(vmodecf),strtoint(vcomecf),floattostrf(atual,ffnumber,12,2));
                          end;
                       FreeLibrary(hndl);
                    end;

                 if copy(resposta,1,1)<>'@' then
                    begin
                       message_info(2,resposta);
                    end
                 else
                    begin
                       try
                          strtofloat(v_coo);
                       except
                          v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
                       end;

                       //a rotina abaixo procura o item para abater o desconto no log
                       AssignFile(acr203, extractfilepath(application.exename)+'dados\acr203.vnd');
                       AssignFile(acr2032, extractfilepath(application.exename)+'dados\acr2032.vnd');
                       Reset(acr203);
                       Rewrite(acr2032);
                       While not Eof(acr203) do
                          Begin
                             readln(acr203,linha);

                             v_codigo:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_quantidade:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_valorun:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_valorto:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_trib:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_funcao:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_data:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_hora:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_operador:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_banco:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_agencia:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_conta:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_numero:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_cliente:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_indicador:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_CPFCNPJ:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_Ncp:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_terminal:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_ECF:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_P:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_C:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_Loja:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));

                             if eof(acr203) then
                                begin
                                   while pos(chr(39),v_valorto)>0 do delete(v_valorto,pos(chr(39),v_valorto),1);
                                   total:=strtofloat(v_valorto)/100;
                                   teste:=floattostrf(total-atual,ffnumber,12,2);
                                   while pos('.',teste)>0 do delete(teste,pos('.',teste),1);
                                   while pos(',',teste)>0 do delete(teste,pos(',',teste),1);
                                   teste:=enche(trim(teste),'0',1,12);
                                   v_valorto:=chr(39)+teste+chr(39);
                                end;

                             writeln(acr2032,v_codigo+'|'+
                                 v_quantidade+'|'+
                                 v_valorun+'|'+
                                 v_valorto+'|'+
                                 v_trib+'|'+
                                 v_funcao+'|'+
                                 v_data+'|'+
                                 v_hora+'|'+
                                 v_operador+'|'+
                                 v_banco+'|'+
                                 v_agencia+'|'+
                                 v_conta+'|'+
                                 v_numero+'|'+
                                 v_cliente+'|'+
                                 v_indicador+'|'+
                                 v_CPFCNPJ+'|'+
                                 v_Ncp+'|'+
                                 v_terminal+'|'+
                                 v_ECF+'|'+
                                 v_P+'|'+
                                 v_C+'|'+
                                 v_Loja+'|');

                          End;
                       CloseFile(acr203);
                       CloseFile(acr2032);

                       deletefile(extractfilepath(application.exename)+'dados\acr203.vnd');
                       renamefile(extractfilepath(application.exename)+'dados\acr2032.vnd',extractfilepath(application.exename)+'dados\acr203.vnd');
                       deletefile(extractfilepath(application.exename)+'dados\acr2032.vnd');

                       grava_log_venda(0,v_prod,'0',floattostrf(atual,ffnumber,8,2),floattostrf(atual,ffnumber,12,2),0,inttostr(opc),Date,Time,cod_operador,floattostr(v_depto),'0','0','0',0,codigo_indicador,0,v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC200) o desc. item
                       Flag_venda(1);
                       v_total:=v_total-atual;
                       v_quant:=1;
                       v_prtot:=0;
                       ja_lancou_desc_no_item:=true;
                       visor_pruni.editmask:='999999,99;0; ';
                       Mostra_produto('','000','1000','000',floattostrf(v_total,ffnumber,12,2));
                       edcodigo.enabled:=true;
                       edcodigo.setfocus;
                       linha_display:=1;
                       MESSAge_info(1,'');
                    end;
              end
           else
              begin
                 edcodigo.enabled:=false;
                 v_coo:='';
                 hndl:=LoadLibrary(v_DLL_ECF);
                 if hndl <> 0 then
                    begin
                       @Descsub:=GetProcAddress(hndl, 'DescSub');
                       if @Descsub <> nil then
                          begin
                             resposta:=Descsub(strtoint(vmodecf),strtoint(vcomecf),floattostrf(atual,ffnumber,12,2));
                          end;
                       FreeLibrary(hndl);
                    end;

                 if copy(resposta,1,1)<>'@' then
                    begin
                       MESSAge_info(2,resposta);
                    end
                 else
                    begin
                       try
                          strtofloat(v_coo);
                       except
                          v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
                       end;

                       //a rotina abaixo procura o item para abater o desconto de subtotal no log
                       percentuaL:=((atual*100)/v_total)/100;
                       AssignFile(acr203, extractfilepath(application.exename)+'dados\acr203.vnd');
                       AssignFile(acr2032, extractfilepath(application.exename)+'dados\acr2032.vnd');
                       Reset(acr203);
                       Rewrite(acr2032);
                       While not Eof(acr203) do
                          Begin
                             readln(acr203,linha);

                             v_codigo:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_quantidade:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_valorun:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_valorto:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_trib:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_funcao:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_data:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_hora:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_operador:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_banco:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_agencia:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_conta:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_numero:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_cliente:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_indicador:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_CPFCNPJ:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_Ncp:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_terminal:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_ECF:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_P:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_C:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));
                             v_Loja:=copy(linha,1,pos('|',linha)-1);
                             delete(linha,1,pos('|',linha));

                             while pos(chr(39),v_valorto)>0 do delete(v_valorto,pos(chr(39),v_valorto),1);
                             total:=strtofloat(v_valorto)/100;
                             teste:=floattostrf(total-strtofloat(floattostrf((total*percentual),ffnumber,8,2)),ffnumber,12,2);
                             while pos('.',teste)>0 do delete(teste,pos('.',teste),1);
                             while pos(',',teste)>0 do delete(teste,pos(',',teste),1);
                             teste:=enche(trim(teste),'0',1,12);
                             v_valorto:=chr(39)+teste+chr(39);

                             writeln(acr2032,v_codigo+'|'+
                                 v_quantidade+'|'+
                                 v_valorun+'|'+
                                 v_valorto+'|'+
                                 v_trib+'|'+
                                 v_funcao+'|'+
                                 v_data+'|'+
                                 v_hora+'|'+
                                 v_operador+'|'+
                                 v_banco+'|'+
                                 v_agencia+'|'+
                                 v_conta+'|'+
                                 v_numero+'|'+
                                 v_cliente+'|'+
                                 v_indicador+'|'+
                                 v_CPFCNPJ+'|'+
                                 v_Ncp+'|'+
                                 v_terminal+'|'+
                                 v_ECF+'|'+
                                 v_P+'|'+
                                 v_C+'|'+
                                 v_Loja+'|');

                          End;
                       CloseFile(acr203);
                       CloseFile(acr2032);

                       deletefile(extractfilepath(application.exename)+'dados\acr203.vnd');
                       renamefile(extractfilepath(application.exename)+'dados\acr2032.vnd',extractfilepath(application.exename)+'dados\acr203.vnd');
                       deletefile(extractfilepath(application.exename)+'dados\acr2032.vnd');

                       grava_log_venda(0,0,'0',floattostrf(rateio,ffnumber,8,2),floattostrf(atual,ffnumber,12,2),0,inttostr(opc),Date,Time,cod_operador,'0','0','0','0',0,codigo_indicador,0,v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC200) o desc. subtot.
                       Flag_venda(1);
                       v_total:=v_total-atual;
                       v_quant:=1;
                       v_prtot:=0;
                       numero_de_itens_desc:=0;
                       numero_de_desc_sub:=numero_de_desc_sub+1;
                       visor_pruni.editmask:='999999,99;0; ';
                       Mostra_produto('','000','1000','000',floattostrf(v_total,ffnumber,12,2));
                       edcodigo.enabled:=true;
                       edcodigo.setfocus;
                       linha_display:=1;
                       MESSAge_info(1,'');
                    end;
              end;
           desc_val:=false;
           edcodigo.enabled:=true;
           edcodigo.setfocus;
           edcodigo.clear;
           Mask_edcodigo(1);// mascara normal
           edcodigo.setfocus;
        end;
end;


procedure TVPDR.ex_INDC(tipo:integer);
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     if tipo=1 then
        begin
           linha_display:=2;
           message_info(1,nome_indicador+chr(13)+'INFORME O CODIGO');
           lanca_ind:=true;
           edcodigo.enabled:=true;
           edcodigo.clear;
           Mask_EDCODigo(1);// NORMAL.
           edcodigo.setfocus;
        end;

     if tipo=2 then
        begin
           teste:=trim(v_edcodigo);
           try
              strtofloat(teste);
           except
              linha_display:=2;
              message_info(2,'CODIGO DO '+nome_indicador+' INVALIDO');
              valor:=false;
              edcodigo.enabled:=true;
              edcodigo.clear;
              Mask_edcodigo(1);// mascara normal
              edcodigo.setfocus;
              exit;
           end;

           ftabelas.tbl_vendedores.close;
           ftabelas.tbl_vendedores.sql.clear;
           ftabelas.tbl_vendedores.sql.add('select v.ven_codvendedor,v.codigovendedor,p.pes_nome_a from VENDEDOR v,PESSOA p where v.pes_codpessoa=p.pes_codpessoa and v.codigovendedor='+teste);
           ftabelas.tbl_vendedores.prepare;
           ftabelas.tbl_vendedores.open;

           if ftabelas.tbl_vendedores.isempty=true then
              begin
                 linha_display:=2;
                 message_info(2,'CODIGO DO '+nome_indicador+' INVALIDO');
                 valor:=false;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_edcodigo(1);// mascara normal
                 edcodigo.setfocus;
                 exit;
              end;

           hndl:=LoadLibrary(v_DLL_ECF);
           if hndl <> 0 then
              begin
                 @Notadecupom:=GetProcAddress(hndl, 'Notadecupom');
                 if @Notadecupom <> nil then
                    begin
                       if vendendo=true  then resposta:=Notadecupom(strtoint(vmodecf),strtoint(vcomecf),tipo_indicador,nome_indicador+': '+teste,false);
                       if vendendo=false then
                          begin
                             grava_convenio;
                             reorganiza_logs(vpdvnum,V_num_loja);
                             resposta:=Notadecupom(strtoint(vmodecf),strtoint(vcomecf),tipo_indicador,nome_indicador+': '+teste,true);
                          end;
                    end;
                 FreeLibrary(hndl);
              end;

           if (copy(resposta,1,1)<>'@') and (copy(resposta,1,1)<>'!') then
              begin
                 message_info(2,resposta);
              end
           else
              begin
                 if vendendo=false then
                    begin
                       vendendo:=true;
                       Flag_venda(1);
                    end;
              end;

           label15.caption:=nome_indicador+': '+teste+chr(13)+ftabelas.tbl_vendedores.fieldbyname('pes_nome_a').value;

           codigo_indicador:=ftabelas.tbl_vendedores.fieldbyname('ven_codvendedor').value;

           Flag_venda(1);
           visor_pruni.editmask:='999999,99;0; ';
           Mostra_produto('','000','0000','000',visor_subtot.text);
           edcodigo.enabled:=true;
           edcodigo.setfocus;
           linha_display:=1;
           MESSAge_info(1,'');
           lanca_ind:=false;
           edcodigo.clear;
           Mask_edcodigo(1);// mascara normal
           edcodigo.setfocus;
        end;
end;

procedure TVPDR.ex_convenio(tipo:integer);
var autocom:Tinifile;
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     if vendendo=false then grava_convenio;

     if tipo=1 then
        begin
           linha_display:=1;
           message_info(1,'INFORME O CODIGO'+CHR(13)+'DO CONVENIADO');
           CONVENIO_COD:=TRUE;
           edcodigo.enabled:=true;
           edcodigo.clear;
           Mask_EDCODigo(1);// mascara normal.
           edcodigo.setfocus;
        end;

     if tipo=2 then
        begin
           linha_display:=1;
           message_info(1,'INFORME O CODIGO DA'+CHR(13)+'EMPRESA DO CONVENIADO');
           CONVENIO_EMP:=TRUE;
           edcodigo.enabled:=true;
           edcodigo.clear;
           Mask_EDCODigo(1);// mascara normal.
           edcodigo.setfocus;
        end;

     if tipo=3 then
        begin
           LANCA_convenio:=true;
           tipo_consulta_cliente:=1; //verificar se está cadastrado e se o status é OK
           Fconscli.showmodal;
           setforegroundwindow(application.handle);
           if status_cliente<2 then
              begin
                 message_info(2,'CONVENIADO NÃO LIBERADO');
                 lanca_convenio:=false;
                 codigo_conveniado:=0;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_edcodigo(1);// mascara normal
                 edcodigo.setfocus;
              end
           else
              begin
                 hndl:=LoadLibrary(v_DLL_ECF);
                 if hndl <> 0 then
                    begin
                       @Notadecupom:=GetProcAddress(hndl, 'Notadecupom');
                       if @Notadecupom <> nil then
                          begin
                             resposta:=Notadecupom(strtoint(vmodecf),strtoint(vcomecf),'00','CONVENIADO: '+floattostr(codigo_conveniado),true);
                             resposta:=Notadecupom(strtoint(vmodecf),strtoint(vcomecf),'00',NOME_cliente,false);
                          end;
                       FreeLibrary(hndl);
                    end;

                 if (copy(resposta,1,1)<>'@') and (copy(resposta,1,1)<>'!') then
                    begin
                       message_info(2,resposta);
                    end
                 else
                    begin
                       vendendo:=true;

                       grava_convenio;
                       reorganiza_logs(vpdvnum,V_num_loja);

                       Flag_venda(1);
                    end;
                 label18.caption:='CONVENIADO: '+floattostr(CODIGO_CONVENIADO)+' EMPRESA: '+floattostr(CODEMP_CONVENIADO)+chr(13)+NOME_cliente;
                 Flag_venda(1);

                 if controla_produto=true then
                    begin
                       try
                          Autocom:=TIniFile.Create(path+'autocom.INI');
                          Autocom.writeString('CONVENIO', 'codigo', floattostr(codigo_conveniado));
                          Autocom.writeString('CONVENIO', 'empresa', floattostr(codemp_conveniado));
                          Autocom.writeString('CONVENIO', 'saldo', '0');
                          Autocom.writeString('CONVENIO', 'data', '');
                          Autocom.writeString('CONVENIO', 'hora', '');
                          Autocom.writeString('CONVENIO', 'operador', '');
                       finally
                          Autocom.Free;
                       end;
                    end;

                 visor_pruni.editmask:='999999,99;0; ';
                 Mostra_produto('','000','0000','000',visor_subtot.text);
                 edcodigo.enabled:=true;
                 edcodigo.setfocus;
                 linha_display:=1;
                 MESSAge_info(1,'');
                 LANCA_CONVENIO:=false;
                 edcodigo.clear;
                 Mask_edcodigo(1);// mascara normal
                 edcodigo.setfocus;
              end;
        end;
end;

procedure TVPDR.ex_SANG(tipo:integer);
var f:boolean;
    autocom:Tinifile;
    limite:real;
    linha:string;
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
         begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     grava_convenio;
     if tipo=1 then
        begin
           linha_display:=1;
           message_info(1,'SELECIONE UMA MODALIDADE'+CHR(13)+'DE PAGAMENTO');
           v_SANGRIA:=TRUE;
           edcodigo.enabled:=true;
           edcodigo.clear;
           Mask_EDCODigo(1);// mascara normal.
           edcodigo.setfocus;
           if v_gaveta<>'0' then //se tiver gaveta
              begin
                 hndl:=LoadLibrary(v_DLL_ECF);
                 if hndl <> 0 then
                    begin
                       @AbreGaveta:=GetProcAddress(hndl, 'AbreGaveta');
                       resposta:=AbreGaveta(strtoint(vmodecf),strtoint(vcomecf));
                       FreeLibrary(hndl);
                    end;
              end;
        end;

     if tipo=2 then
        begin
           Mask_EDCODigo(3);// mascara para VALOR.

           ftabelas.query1.close;
           ftabelas.query1.sql.clear;
           ftabelas.query1.sql.add('select * from CONDICAOPAGAMENTO where codigocondicaopagamento='+floattostr(cod));
           ftabelas.query1.prepare;
           ftabelas.query1.open;

           if ftabelas.query1.isempty=true then f:=false else f:=true;

           if f=true then
              begin

                 captura_finalizadora;

                 if status_erro=true then
                    begin
                       if total_recebido=0 then v_sangria:=false;
                       edcodigo.enabled:=true;
                       edcodigo.clear;
                       Mask_edcodigo(1);// mascara normal
                       edcodigo.setfocus;
                       cod:=0;
                       exit;
                    end;
                 linha_display:=2;
                 message_info(1,v_nomefina+' - SANGRIA'+chr(13)+'INFORME O VALOR');
                 sangria_com_fina:=true;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_EDCODigo(3);// mascara para VALOR.
                 edcodigo.setfocus;
              end
           else
              begin
                 linha_display:=1;
                 message_info(2,'FINALIZADORA NAO CADASTRADA');
                 cod:=0;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 edcodigo.setfocus;
              end;
        end;

     if tipo=3 then
        begin
           try
              autocom:=TIniFile.Create(path+'Autocom.INI');
              linha:=autocom.ReadString('TERMINAL', 'limitesng', '000');    // limite de sangria
              autocom.free;
              limite:=(strtofloat(trim(linha)))/100;
           except
              linha_display:=1;
              message_info(2,'NAO EXISTE LIMITE PARAMETRIZADO');
              v_sangria:=false;
              sangria_com_fina:=false;
              edcodigo.enabled:=true;
              edcodigo.clear;
              Mask_edcodigo(1);// mascara normal
              edcodigo.setfocus;
              EXIT;
           end;

           try
              valor_recebido:=strtofloat(trim(v_edcodigo))/100;
              valor_recebido:=strtofloat(tira_milhar(floattostrf(valor_recebido,ffnumber,12,2)));
           except
              linha_display:=1;
              message_info(2,'VALOR INFORMADO INVALIDO');
              if total_recebido=0 then finalizadora:=false;
              v_sangria:=false;
              edcodigo.enabled:=true;
              edcodigo.clear;
              Mask_edcodigo(1);// mascara normal
              edcodigo.setfocus;
              cod:=0;
              exit;
           end;

           if valor_recebido<=limite then
              begin
                 v_coo:='';
                 hndl:=LoadLibrary(v_DLL_ECF);
                 if hndl <> 0 then
                    begin
                       @Sangria:=GetProcAddress(hndl, 'Sangria');
                       if @Sangria <> nil then
                          begin
                             resposta:=Sangria(strtoint(vmodecf),strtoint(vcomecf),floattostr(cod),floattostr(valor_recebido));
                          end;
                       FreeLibrary(hndl);
                    end;
                 if copy(resposta,1,1)<>'@' then
                    begin
                       message_info(2,resposta);
                    end
                 else
                    begin
                       try
                          strtofloat(v_coo);
                       except
                          v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
                       end;
                       grava_log_venda(2,cod,'0','0',enche(trim(v_edcodigo),'0',1,12),0,enche(inttostr(opc),'0',1,2),Date,Time,cod_operador,'0','0','0','0',0,0,0,v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC200) o lançamento da sangria.
                       edcodigo.enabled:=true;
                       linha_display:=1;
                       message_info(1,'');
                       edcodigo.clear;
                       Mask_edcodigo(1);// mascara normal
                       ex_GAVT;
                    end;
                 Mostra_produto('','000','1000','000','000');
                 edcodigo.enabled:=true;
                 edcodigo.setfocus;
                 cod:=0;
                 v_sangria:=false;
              end
           else
              begin
                 linha_display:=1;
                 message_info(2,'LIMITE EXCEDIDO!');
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 edcodigo.setfocus;
              end;
        end;
end;

procedure TVPDR.ex_valR(tipo:integer);
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     if tipo=1 then
        begin
           linha_display:=2;
           message_info(1,'INFORME O VALOR');
           Valor:=true;
           edcodigo.enabled:=true;
           edcodigo.clear;
           Mask_EDCODigo(3);// mascara para valor.
           edcodigo.setfocus;
        end;

     if tipo=2 then
        begin
           try
              teste:=trim(v_edcodigo);
              while pos(',',teste)>0 do delete(teste,pos(',',teste),1);
              while pos('.',teste)>0 do delete(teste,pos('.',teste),1);
              v_prtot:=strtofloat(teste);
           except
              linha_display:=1;
              message_info(2,'VALOR INFORMADO'+chr(13)+'INVALIDO');
              valor:=false;
              lancou_valor:=false;
              edcodigo.enabled:=true;
              edcodigo.clear;
              Mask_edcodigo(1);// mascara normal
              edcodigo.setfocus;
              exit;
           end;
           if v_prtot<(1/100) then
              begin
                 linha_display:=1;
                 message_info(2,'VALOR INFORMADO'+chr(13)+'INVALIDO');
                 valor:=false;
                 lancou_valor:=false;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_edcodigo(1);// mascara normal
                 edcodigo.setfocus;
                 exit;
              end;

           v_prtot:=v_prtot/100;
           Mostra_produto('','000','1000',floattostrf(v_prtot,ffnumber,12,2),visor_subtot.text);
           lancou_valor:=true;
           edcodigo.enabled:=true;
           edcodigo.setfocus;
           linha_display:=1;
           MESSAge_info(1,'');
           valor:=false;
           edcodigo.clear;
           Mask_edcodigo(1);// mascara normal
           edcodigo.setfocus;
        end;
end;


procedure TVPDR.ex_PPI(code:string);
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     v_edcodigo:=code;
     ex_lanca_item;
end;

procedure TVPDR.ex_GAVT;
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     grava_convenio;
     linha_display:=1;
     message_info(1,'ABERTURA DE GAVETA');
     refresh;
     edcodigo.enabled:=false;

     if v_gaveta<>'0' then //se tiver gaveta
        begin
           hndl:=LoadLibrary(v_DLL_ECF);
           if hndl <> 0 then
              begin
                 @AbreGaveta:=GetProcAddress(hndl, 'AbreGaveta');
                 resposta:=AbreGaveta(strtoint(vmodecf),strtoint(vcomecf));
                 FreeLibrary(hndl);
              end;
           if copy(resposta,1,1)<>'@' then
              begin
                 message_info(2,resposta);
              end
           else
              begin
                 reorganiza_logs(vpdvnum,V_num_loja);
                 if v_fechagaveta<>'0' then // se obriga a fechar a gaveta
                    begin
                       if v_gaveta='1' then v_status_da_gaveta:='1'; // gaveta gerbo vai vir com o status=1 para gaveta ABERTA
                       if v_gaveta='2' then v_status_da_gaveta:='0'; // gaveta menno vai vir com o status=0 para gaveta ABERTA

                       while copy(ECF_INF(strtoint(vmodecf),strtoint(vcomecf)),8,1)=v_status_da_gaveta do
                          begin
                             message_info(1,'FECHAR A'+CHR(13)+'GAVETA');
                             edcodigo.clear;
                             refresh;
                          end;
                    end;
              end;
        end;

     Mostra_produto('','000','1000','000','000');
     edcodigo.enabled:=true;
     edcodigo.setfocus;
     linha_display:=1;
     message_info(1,'');
end;

procedure TVPDR.ex_FI(tipo:integer;modal:real);
var troco:string;
    modulo_tef:string;
    valor_ecf:real;
    tenta,n:integer;
    tenta_ok,lanca_repique:boolean;
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     if tipo=1 then
        begin
           if v_total>=(1/100) then // verifica se o total é maior que zero, usando precisao de 0,01.
              begin
                 if ftabelas.TBL_condicaopagamento.locate('codigocondicaopagamento',cod,[locaseinsensitive]) then
                    begin
                       captura_finalizadora;
                       banco_cheq:='0';
                       agencia_cheq:='0';
                       conta_cheq:='0';
                       num_cheq:='0';
                       if v_funcfina=1 then consulta_ln;
                       if v_funcfina=2 then convenio;


                       if status_erro=true then
                          begin
                             if total_recebido=0 then finalizadora:=false;
                             edcodigo.enabled:=true;
                             edcodigo.clear;
                             Mask_edcodigo(1);// mascara normal
                             edcodigo.setfocus;
                             cod:=0;
                             exit;
                          end;
                       linha_display:=2;
                       message_info(1,v_nomefina+chr(13)+'INFORME O VALOR');
                       finalizadora:=true;
                       edcodigo.enabled:=true;
                       edcodigo.clear;
                       Mask_EDCODigo(3);// mascara para VALOR.
                       edcodigo.setfocus;
                    end
                 else
                    begin
                       linha_display:=1;
                       message_info(2,'FINALIZADORA NAO CADASTRADA');
                       cod:=0;
                    end;
              end;
        end;

     if tipo=2 then
        begin
           if CONTROLA_PRODUTO=TRUE then
              BEGIN
                 if verifica_quantidade=false then
                    begin
                       if total_recebido=0 then finalizadora:=false;
                       edcodigo.enabled:=true;
                       edcodigo.clear;
                       Mask_edcodigo(1);// mascara normal
                       edcodigo.setfocus;
                       cod:=0;
                       exit;
                    end
                 else controla_produto:=false;
              END;

           try
              valor_recebido:=strtofloat(trim(v_edcodigo))/100;
              valor_recebido:=strtofloat(tira_milhar(floattostrf(valor_recebido,ffnumber,12,2)));

              v_total:=strtofloat(tira_milhar(floattostrf(v_total,ffnumber,12,2)));

              if valor_recebido>v_total then
                 begin
                    If (Application.MessageBox(pchar('Confirma o valor informado ?'+chr(13)+chr(13)+floattostrf(valor_recebido,ffcurrency,12,2)),'Autocom PLUS',36) = mryes) then
                       begin

                       end
                    else
                       begin
                          linha_display:=1;
                          message_info(2,'CANCELADO PELO OPERADOR (TECLE CORR.)');
                          if total_recebido=0 then finalizadora:=false;
                          edcodigo.enabled:=true;
                          edcodigo.clear;
                          Mask_edcodigo(1);// mascara normal
                          edcodigo.setfocus;
                          cod:=0;
                          exit;
                       end;
                 end;
              total_recebido:=(total_recebido+valor_recebido);
              teste:=tira_milhar(floattostrf(total_recebido,ffnumber,12,2));
              total_recebido:=strtofloat(teste);

              if falta_receber<(1/100) then falta_receber:=v_total;

              parcelas:=1; // número de parcelas
              valor_recebido_parcela[1]:=valor_recebido; //valor de cada parcela
              for n:=1 to 100 do v_datacheqfina[n]:='';

           except
              linha_display:=1;
              message_info(2,'VALOR INFORMADO INVALIDO');
              if total_recebido=0 then finalizadora:=false;
              edcodigo.enabled:=true;
              edcodigo.clear;
              Mask_edcodigo(1);// mascara normal
              edcodigo.setfocus;
              cod:=0;
              exit;
           end;

           if (v_trocofina=0) and ((valor_recebido-falta_receber)>(1/100)) then
              begin
                 linha_display:=1;
                 message_info(2,'VALOR INFORMADO EXCEDIDO'+CHR(13)+'NAO PODE HAVER TROCO');
                 total_recebido:=total_recebido-valor_recebido;
                 if total_recebido=0 then finalizadora:=false;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_edcodigo(1);// mascara normal
                 edcodigo.setfocus;
                 cod:=0;
                 exit;
              end;

/////////////////////////  *** funcoes tef *** inicio
           modulo_tef:='';
           if (v_funcfina=3) or (v_funcfina=4) or (v_funcfina=5) then
              begin
                 if v_funcfina=3 then
                    begin
                       dados_cheq;
                       consulta_tef_cheque;
                    end
                 else
                    begin
                       if v_funcfina=4 then modulo_tef:='1';
                       if v_funcfina=5 then modulo_tef:='0';
                       tef(modulo_tef);
                    end;
                 if status_erro=true then
                    begin
                       if total_recebido=0 then
                          begin
                             finalizadora:=false;
                          end
                       else
                          begin
                             total_recebido:=(total_recebido-valor_recebido);
                          end;
                       edcodigo.enabled:=true;
                       edcodigo.clear;
                       Mask_edcodigo(1);// mascara normal
                       edcodigo.setfocus;
                       cod:=0;
                       mensagem_tef:='';
                       exit;
                    end;
              end;
/////////////////////////  *** funcoes tef *** fim

           mostra_produto(v_nomefina+': '+floattostrf((strtofloat(trim(v_edcodigo))/100),ffnumber,12,2),'000','1000','000',visor_subtot.text);
           display_torre('',0,1,1);
           display_torre(v_nomefina+': ',1,1,1);
           display_torre(floattostrf((strtofloat(trim(v_edcodigo))/100),ffcurrency,12,2),1,1,2);
           edcodigo.enabled:=false;

           if  falta_receber=v_total then
              begin
                 tenta:=0;
                 tenta_ok:=false;
                 while tenta_ok=false do
                    begin
                       valor_ecf:=v_total;
                       if tenta=1 then valor_ecf:=valor_ecf-0.01;
                       if tenta=2 then valor_ecf:=valor_ecf+0.01;
                       hndl:=LoadLibrary(v_DLL_ECF);
                       if hndl <> 0 then
                          begin
                             @Totalizacupom:=GetProcAddress(hndl, 'Totalizacupom');
                             resposta:=Totalizacupom(strtoint(vmodecf),strtoint(vcomecf),'00',floattostr(valor_ecf));
                             FreeLibrary(hndl);
                          end;
                       if copy(resposta,1,1)<>'@' then
                          begin
                             tenta:=tenta+1;
                             if tenta>=2 then
                                begin
                                   message_info(2,resposta);
                                   edcodigo.enabled:=true;
                                   edcodigo.setfocus;
                                   exit;
                                end;
                          end
                       else
                          begin
                             if valor_recebido=v_total then valor_recebido:=valor_ecf;
                             v_total:=valor_ecf;
                             falta_receber:=valor_ecf;
                             tenta_ok:=true;
                          end;
                    end;
              end;



           application.processmessages;
           if v_gaveta<>'0' then // se tiver gaveta
              begin
                 hndl:=LoadLibrary(v_DLL_ECF);
                 if hndl <> 0 then
                    begin
                       @AbreGaveta:=GetProcAddress(hndl, 'AbreGaveta');
                       resposta:=AbreGaveta(strtoint(vmodecf),strtoint(vcomecf));
                       FreeLibrary(hndl);
                    end;
              end;


           v_coo:='';
           hndl:=LoadLibrary(v_DLL_ECF);
           if hndl <> 0 then
              begin
                 @Totalizacupom:=GetProcAddress(hndl, 'Totalizacupom');
                 if @Totalizacupom <> nil then
                    begin
                       resposta:=Totalizacupom(strtoint(vmodecf),strtoint(vcomecf),floattostr(cod),floattostr(valor_recebido));
                    end;
                 FreeLibrary(hndl);
              end;

           if copy(resposta,1,1)<>'@' then
              begin
                 message_info(2,resposta);
              end
           else
              begin
                 if v_cheqfina=1 then
                    begin
                       dados_cheq;
                       imprime_cheq;
                       while imprimindo_cheq=true do application.processmessages;
                    end;

                 if (total_recebido-v_total)>=(1/100) then
                    begin
                       teste:=tira_milhar(FLOAttostr((total_recebido-v_total)));
                       troco:=tira_milhar(floattostrf(strtofloat(teste),ffnumber,12,2));
                    end
                 else troco:='0,00';
                 mostra_produto('','000','1000','000',visor_subtot.text);
                 label16.caption:='TROCO: '+troco;
                 display_torre('',0,1,1);
                 display_torre('TROCO: ',1,1,1);
                 display_torre(troco,1,1,2);

                 try
                    strtofloat(v_coo);
                 except
                    v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
                 end;

                 if (v_trocofina=3) and ((valor_recebido-falta_receber)>(1/100)) then // dia 08/08/2002 - por Helder Frederico: Pergunta por repique
                    begin
                       If (Application.MessageBox('Lançar troco como repique?','Autocom PLUS',36) = mryes) then
                          begin
                             lanca_repique:=true;
                          end
                       else
                          begin
                             lanca_repique:=false;
                          end;
                    end;

                 n:=1;
                 while n<=parcelas do
                    begin
                       if lanca_repique=true then
                          begin
                             grava_log_venda(0,cod,enche(trim(strtovalor(troco,2)),'0',1,7),v_datacheqfina[n],enche(trim(strtovalor(floattostr(valor_recebido_parcela[n]),2)),'0',1,12),1,enche(inttostr(opc),'0',1,2),Date,Time,cod_operador,banco_cheq,agencia_cheq,conta_cheq,num_cheq,codigo_cliente,codigo_indicador,cod_n_cad,v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC203) o lançamento da finalizadora com repique.
                          end
                       else
                          begin
                             grava_log_venda(0,cod,enche(trim(strtovalor(troco,2)),'0',1,7),v_datacheqfina[n],enche(trim(strtovalor(floattostr(valor_recebido_parcela[n]),2)),'0',1,12),0,enche(inttostr(opc),'0',1,2),Date,Time,cod_operador,banco_cheq,agencia_cheq,conta_cheq,num_cheq,codigo_cliente,0,cod_n_cad,v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC203) o lançamento da finalizadora com troco.
                          end;

                       n:=n+1;
                    end;


                 edcodigo.enabled:=true;
                 if v_autfina=1 then
                    begin
                       linha_display:=1;
                       message_info(1,'INSIRA O DOCUMENTO'+CHR(13)+'PARA AUTENTICAR');
                       hndl:=LoadLibrary(v_DLL_ECF);
                       if hndl <> 0 then
                          begin
                             @Autentica:= GetProcAddress(hndl, 'Autentica');
                             if @Autentica <> nil then
                                begin
                                   resposta:=Autentica(strtoint(vmodecf),strtoint(vcomecf),v_nomefina,'0');
                                end;
                             FreeLibrary(hndl);
                          end;
                       if (copy(resposta,1,1)<>'@') and (copy(resposta,1,1)<>'!') then
                          begin
                             message_info(2,resposta);
                          end;
                    end;
                 linha_display:=1;
                 message_info(1,'');
                 if strtofloat(tira_milhar(floattostrf(total_recebido,ffnumber,12,2)))>=strtofloat(tira_milhar(floattostrf(v_total,ffnumber,12,2))) then
                    begin
                       edcodigo.enabled:=false;

                       mostra_produto('','000','1000','000',visor_subtot.text);
                       label16.caption:='TROCO: '+troco;
                       application.processmessages;
                       v_coo:='';
                       hndl:=LoadLibrary(v_DLL_ECF);

                       if v_printgrill='1' then printgrill; //imprime pedido na cozinha

                       if hndl <> 0 then
                          begin
                             @FecharCupom:=GetProcAddress(hndl, 'FecharCupom');
                             if @FecharCupom <> nil then
                                begin
                                   resposta:=FecharCupom(strtoint(vmodecf),strtoint(vcomecf),'0','0',v_l1,v_l2,v_l3,v_l4,v_l5,v_l6,v_l7,v_l8);
                                end;
                             FreeLibrary(hndl);
                          end;

                       if copy(resposta,1,1)<>'@' then
                          begin
                             message_info(2,resposta);
                          end
                       else
                          begin
                             message_info(1,mensagem_tef+chr(13)+'CORTE O CUPOM');
                             application.processmessages;
                             teste:=ECF_INF(strtoint(vmodecf),strtoint(vcomecf));
                             try
                                strtofloat(v_coo);
                             except
                                v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
                             end;
                             grava_log_venda(0,0,floattostrf(V_quant_total,ffnumber,7,3),copy(teste,22,4),FLOAttostrf((v_total),ffnumber,12,2),1,'99',Date,Time,cod_operador,'0',copy(teste,50,12),copy(teste,26,12),copy(teste,38,12),0,strtofloat(copy(teste,10,6)),strtofloat(copy(teste,16,6)),v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC203) o fechamento do cupom

                             if (v_trocofina=2) and ((total_recebido-v_total)>=(1/100))then
                                begin
                                   linha_display:=1;
                                   message_info(1,'IMPRIMINDO CONTRA-VALE'+CHR(13)+'AGUARDE...');
                                   hndl:=LoadLibrary(v_DLL_ECF);
                                   if hndl <> 0 then
                                      begin
                                         @Contra_vale:= GetProcAddress(hndl, 'Contra_vale');
                                         if @Contra_vale <> nil then
                                            begin
                                               if vendendo=true then resposta:=Contra_vale(strtoint(vmodecf),strtoint(vcomecf),troco+'|'+v_nomefina);
                                            end;
                                         FreeLibrary(hndl);
                                      end;
                                   if copy(resposta,1,1)<>'@' then
                                      begin
                                         message_info(2,resposta);
                                      end;
                                end;

                             if (v_funcfina=2) and (codigo_conveniado>0) then
                                begin
                                   dados_conveniado;
                                end;

//**********************************  TEF Discado - Inicio
                             if modulo_tef<>'' then
                                begin
                                   habilita_dlltef;
                                   message_info(1,mensagem_tef+chr(13)+'Imprimindo comprovante...');
                                   if hndl_tef<>0 then
                                      begin
                                         @tef_comprovante:= GetProcAddress(hndl_tef, 'tef_comprovante');
                                         resposta:=tef_comprovante(modulo_tef,'0');
                                      end;
                                   if copy(resposta,1,1)='0' then message_info(2,'ERRO DE COMUNICACAO');
                                   if copy(resposta,1,1)='1' then message_info(2,copy(resposta,1,length(resposta)));

                                   if hndl_tef<>0 then
                                      begin
                                         @tef_ativo:= GetProcAddress(hndl_tef, 'tef_ativo');
                                         resposta:=tef_ativo(modulo_tef);
                                      end;
                                   desabilita_dlltef;
                                end;
//**********************************  TEF Discado - fim

                             total_da_ultima_venda:=v_total;
                             Flag_venda(2);
                             if v_gaveta<>'0' then // se tiver gaveta
                                begin
                                   if v_fechagaveta<>'0' then // se obriga a fechar a gaveta
                                      begin
                                         if v_gaveta='1' then v_status_da_gaveta:='1'; // gaveta gerbo vai vir com o status=1 para gaveta fechada
                                         if v_gaveta='2' then v_status_da_gaveta:='0'; // gaveta ameno vai vir com o status=0 para geveta fechada

                                         while copy(ECF_INF(strtoint(vmodecf),strtoint(vcomecf)),8,1)=v_status_da_gaveta do
                                            begin
                                               mostra_produto('','000','1000','000',visor_subtot.text);
                                               label16.caption:='TROCO: '+troco;
                                               message_info(1,'FECHAR A'+CHR(13)+'GAVETA');
                                               edcodigo.clear;
                                               refresh;
                                            end;
                                         mostra_produto('','000','1000','000',visor_subtot.text);
                                      end;
                                end;
                             termina_venda;
                          end;
                       edcodigo.enabled:=true;
                    end
                 else
                    begin
                       falta_receber:=V_total-total_recebido;
                       falta_receber:=strtofloat(tira_milhar(floattostrf(falta_receber,ffnumber,12,2)));
                       mostra_produto('A RECEBER: '+FLOAttostrf((falta_receber),ffnumber,12,2),'000','1000','000',visor_subtot.text);
                       display_torre('',0,1,1);
                       display_torre('A RECEBER: ',1,1,1);
                       display_torre(FLOAttostrf((falta_receber),ffcurrency,12,2),1,1,2);
                    end;
              end;
           message_info(1,'');
           edcodigo.enabled:=true;
           edcodigo.clear;
           Mask_edcodigo(1);// mascara normal
           edcodigo.setfocus;
           cod:=0;

        end;
end;

procedure TVPDR.ex_SBto;
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     sub_total:=true;
     if falta_receber<=0 then
        begin
           Mostra_produto('TOTAL DA VENDA: '+floattostrF(v_total,ffnumber,12,2),'000','1000','000',visor_subtot.text);
           display_torre('',0,1,1);
           display_torre('TOTAL DA VENDA: ',1,1,1);
           display_torre(floattostrF(v_total,ffcurrency,12,2),1,1,2);
        end
     else
        begin
           mostra_produto('A RECEBER: '+FLOAttostrf((falta_receber),ffnumber,12,2),'000','1000','000',visor_subtot.text);
           display_torre('',0,1,1);
           display_torre('A RECEBER: ',1,1,1);
           display_torre(FLOAttostrf((falta_receber),ffcurrency,12,2),1,1,2);
        end;
end;

procedure TVPDR.ex_mult(tipo:integer);
var res_bal:string;
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     if tipo=1 then
        begin
           if vbal='0' then
              begin
                 linha_display:=2;
                 message_info(1,'INFORME A QUANTIDADE');
                 Multiplica:=true;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_EDCODigo(4);// mascara quantidade.
                 edcodigo.setfocus;
              end
           else
              begin
                 linha_display:=2;
                 message_info(1,'COLOQUE O PESO NA BALANÇA');
                 Multiplica:=true;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_EDCODigo(4);// mascara quantidade.
                 edcodigo.setfocus;

                 res_bal:=peso(vbal,vbalcom);
                 try
                    if strtoint(res_bal)<=0 then
                       begin
                          v_edcodigo:='0000';
                       end
                    else
                       begin
                          v_edcodigo:=strtoquant(res_bal);
                          ex_mult(2);
                          exit;
                       end;
                 except
                    v_edcodigo:='0000';
                 end;

                 if v_edcodigo='0000' then message_info(1,'INFORME A QUANTIDADE');
              end;
        end;

     if tipo=2 then
        begin
           try
              v_quant:=strtofloat(v_edcodigo);
           except
              linha_display:=1;
              message_info(2,'QUANTIDADE INFORMADA'+chr(13)+'INVALIDA');
              multiplica:=false;
              edcodigo.enabled:=true;
              edcodigo.clear;
              Mask_edcodigo(1);// mascara normal
              edcodigo.setfocus;
              exit;
           end;
           if v_quant<=(1/1000) then
              begin
                 linha_display:=1;
                 message_info(2,'QUANTIDADE INFORMADA'+chr(13)+'INVALIDA');
                 multiplica:=false;
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 Mask_edcodigo(1);// mascara normal
                 edcodigo.setfocus;
                 exit;
              end;

           v_quant:=v_quant/1000;
           Mostra_produto('','000',floattostrf(v_quant,ffnumber,7,3),'000',visor_subtot.text);
           edcodigo.enabled:=true;
           linha_display:=1;
           MESSAge_info(1,'');
           multiplica:=false;
           lancou_valor:=false;
           edcodigo.clear;
           Mask_edcodigo(1);// mascara normal
           edcodigo.setfocus;
        end;
end;

procedure TVPDR.ex_lanca_item;
var produto,produto_bal,atual,bal_total:real;
    ap:boolean;
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;

     if (obriga_indicador='1') and (codigo_indicador<=0) then
        begin
           message_info(2,'FAVOR INFORMAR O '+NOME_INDICADOR+CHR(13)+'ANTES DE INICIAR A VENDA');
           EXIT;
        end;


     produto:=strtofloat(enche(trim(v_edcodigo),'0',1,13));
     edcodigo.clear;

     produto_bal:=0;// código do produto de balança (etiqueta)
     if (copy(floattostr(produto),1,1)='2') and (length(floattostr(produto))=13) then // quando o código EAN tiver 13 dígitos e iniciar com o digito 2,
        begin                                                                         // significa que é uma etiqueta de um produto pesado
           produto_bal:=strtofloat(copy(floattostr(produto),2,4)); //captura o codigo do produto na etiqueta
           try
              ftabelas.tbl_produtos.close;
              ftabelas.tbl_produtos.sql.clear;
              ftabelas.tbl_produtos.sql.add('select * from produto where codigoproduto='+floattostr(produto_bal));
              ftabelas.tbl_produtos.prepare;
              ftabelas.tbl_produtos.open;
              if ftabelas.tbl_produtos.fieldbyname('codigoproduto').value>0 then ap:=true else ap:=false;
           except
              ap:=false;
           end;

           if ap=true then
              begin
                 bal_total:=strtofloat(copy(floattostr(produto),6,7))/100; // pega o valor total do produto
                 produto:=produto_bal;
              end
           else
              begin
                 produto_bal:=0;
                 bal_total:=0;
              end;
        end;

     if produto_bal=0 then // significa que o código digito é um codigo normal ou o código com bandeira 2 (etiqueta de balança) não existe!!
        begin

           try// verifica a associação do codigo do produto
              ftabelas.tbl_produtoassociado.close;
              ftabelas.tbl_produtoassociado.sql.clear;
              ftabelas.tbl_produtoassociado.sql.add('select * from produtoassociado where codigoprodutoassociado='+floattostr(produto));
              ftabelas.tbl_produtoassociado.prepare;
              ftabelas.tbl_produtoassociado.open;
              if ftabelas.tbl_produtoassociado.isempty=false then produto:=ftabelas.tbl_produtoassociado.fieldbyname('codigoproduto').value;
           except
              ap:=false;
           end;

           try
              ftabelas.tbl_produtos.close;
              ftabelas.tbl_produtos.sql.clear;
              ftabelas.tbl_produtos.sql.add('select * from produto where codigoproduto='+floattostr(produto));
              ftabelas.tbl_produtos.prepare;
              ftabelas.tbl_produtos.open;
              if ftabelas.tbl_produtos.isempty=false then ap:=true else ap:=false;
           except
              ap:=false;
           end;

        end;

     if ap=true then
           begin
              captura_produto(bal_total);
              application.processmessages;
              if status_erro=false then
                 begin
                    if vendendo=false then
                       begin
                          grava_convenio;
                          reorganiza_logs(vpdvnum,V_num_loja);
                          edcodigo.enabled:=false;
                          hndl:=LoadLibrary(v_DLL_ECF);
                             if hndl <> 0 then
                                begin
                                   @abrecupom:=GetProcAddress(hndl, 'Abrecupom');
                                   resposta:=abrecupom(strtoint(vmodecf),strtoint(vcomecf),'');
                                   FreeLibrary(hndl);
                                end;
                          Flag_venda(1);
                          v_coo:='';
                          edcodigo.enabled:=true;
                       end;

                    v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
                    linha_display:=1;
                    if (frac(v_quant)<>0) and (v_un='UN') then message_info(2,'QUANTIDADE INVALIDA'+CHR(13)+'PRODUTO UNITARIO');

//                    if v_estoque=1 then
//                       begin
//                          ftabelas.acr400.close;
//                          ftabelas.acr400.sql.clear;
//                          ftabelas.acr400.sql.add('select * from acr400 where usc='+chr(39)+'X'+chr(39)+' and loja='+V_num_loja);
//                          ftabelas.acr400.prepare;
//                          ftabelas.acr400.open;
//                          if ftabelas.acr400.locate('produto',produto,[loCaseInsensitive])=true then
//                             begin
//                                IF v_quant>ftabelas.ACR400.fieldbyname('saldof').value then message_info(2,'PRODUTO SEM SALDO EM ESTOQUE'+CHR(13)+'SALDO ATUAL:'+FLOATTOSTR(ftabelas.ACR400.FIELDBYNAME('saldof').value));
//                             end
//                          else
//                             begin
//                                message_info(2,'PRODUTO SEM ENTRADA NO ESTOQUE'+CHR(13)+'VENDA NÃO PERMITIDA');
//                             end;
//                       end;

                    if status_erro=false then
                       begin
                          hndl:=LoadLibrary(v_DLL_ECF);
                          if hndl <> 0 then
                             begin
                                @Lancaitem:= GetProcAddress(hndl, 'Lancaitem');
                                resposta:=Lancaitem(strtoint(vmodecf),strtoint(vcomecf),floattostr(v_prod), v_desc, floattostr(v_decimais)+tira_milhar(floattostrf(v_quant,ffnumber,7,3)), floattostr(v_prunit), tira_milhar(floattostr(v_prtot)),v_trib);
                                FreeLibrary(hndl);
                             end;

                          if copy(resposta,1,1)<>'@' then
                             begin
                                linha_display:=1;
                                message_info(2,resposta);
                                visor_pruni.editmask:='999999,99;0; ';
                                Mostra_produto('','000','1000','000',visor_subtot.text);
                                edcodigo.SelectAll;
                                v_quant:=1;
                                lancou_valor:=false;
                                exit;
                             end;

                          v_total:=v_total+v_prtot;
                          V_quant_total:=V_quant_total+v_quant;

                          lancou_item:=true;
                          ja_lancou_desc_no_item:=false;
                          sub_total:=false;
                          try
                             strtofloat(v_coo);
                          except
                             v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
                          end;
                          grava_log_venda(0,v_prod,floattostrf(v_quant,ffnumber,7,3),floattostrf(v_prunit,ffnumber,12,2),floattostrf(v_prtot,ffnumber,12,2),v_trib_code,'00',Date,Time,cod_operador,floattostr(v_depto),'0','0','0',0,codigo_indicador,0,v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC203) o lançamento do item
                          Flag_venda(1);
                          Mostra_produto(v_desc,floattostr(v_prunit),floattostrf(v_quant,ffnumber,7,3),floattostrf(v_prtot,ffnumber,12,2),floattostrF(v_total,ffnumber,12,2));
                          display_torre('',0,1,1);
                          display_torre(floattostrf(v_quant,ffnumber,7,3)+' X '+floattostrf(v_prunit,ffcurrency,8,2),1,1,1);
                          display_torre(copy(v_desc,1,20),1,1,2);

                          numero_de_itens:=numero_de_itens+1;
                          numero_de_itens_desc:=numero_de_itens_desc+1;
                          v_quant:=1;
                          lancou_valor:=false;
                          vendendo:=true; //quando consegue abrir o cupom fiscal, o sistema vai flegar que já iniciou uma venda.
                       end;
                 end;
           end
        else
           begin
              visor_pruni.editmask:='999999,99;0; ';
              Mostra_produto('','000','1000','000',visor_subtot.text);
              linha_display:=1;
              message_info(2,'PRODUTO NAO CADASTRADO');
              exit;
           end;


     if (codigo_conveniado>0) and (status_erro=false) then // quando tem conveniado lancado na venda, é verificado se o departamento
        begin                    // do produto vendido tem algum desconto especial para convenio.
           atual:=(strtofloat(tira_milhar(trim(perc_depto))))/100;
           if atual>0 then //se tiver desconto para convenio, é dado o desconto no item vendido
              begin
                 v_edcodigo:=floattostr(atual);
                 desc_item:=true;//avisa para o sistema que vai ter desconto no item
                 opc:=6;
                 ex_desp(2);
              end
        end;
     edcodigo.setfocus;
end;

procedure TVPDR.ex_FDCX(tipo:integer);
var limite,atual:real;
    autocom:Tinifile;
    linha:string;
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     grava_convenio;
     if tipo=1 then
        begin
           linha_display:=2;
           message_info(1,'INFORME O VALOR');
           fundo_cx:=true;
           edcodigo.enabled:=true;
           edcodigo.clear;
           Mask_EDCODigo(3);// mascara para VALOR.
           edcodigo.setfocus;
           if v_gaveta<>'0' then //se tiver gaveta
              begin
                 hndl:=LoadLibrary(v_DLL_ECF);
                 if hndl <> 0 then
                    begin
                       @AbreGaveta:=GetProcAddress(hndl, 'AbreGaveta');
                       resposta:=AbreGaveta(strtoint(vmodecf),strtoint(vcomecf));
                       FreeLibrary(hndl);
                    end;
              end;
        end;

     if tipo=2 then
        begin
           try
              autocom:=TIniFile.Create(path+'Autocom.INI');
              linha:=autocom.ReadString('TERMINAL', 'limitefcx', '000');    // limite de fundo de caixa
              autocom.free;
              limite:=(strtofloat(trim(linha)))/100;
           except
              linha_display:=1;
              message_info(2,'NAO EXISTE LIMITE PARAMETRIZADO');
              fundo_cx:=false;
              edcodigo.enabled:=true;
              edcodigo.clear;
              Mask_edcodigo(1);// mascara normal
              edcodigo.setfocus;
              EXIT;
           end;
           try
              atual:=(strtofloat(trim(v_edcodigo)))/100;
           except
              linha_display:=1;
              message_info(2,'VALOR INFORMADO INVALIDO');
              fundo_cx:=false;
              edcodigo.clear;
              edcodigo.enabled:=true;
              Mask_edcodigo(1);// mascara normal
              edcodigo.setfocus;
              exit;
           end;
           if atual<=limite then
              begin
                 linha_display:=1;
                 message_info(1,'FUNDO DE CAIXA'+chr(13)+'AGUARDE...');
                 edcodigo.enabled:=false;
                 v_coo:='';
                 hndl:=LoadLibrary(v_DLL_ECF);
                 if hndl <> 0 then
                    begin
                       @FCX:=GetProcAddress(hndl, 'FCX');
                       if @FCX <> nil then
                          begin
                             resposta:=FCX(strtoint(vmodecf),strtoint(vcomecf),'01',floattostr(atual));
                          end;
                       FreeLibrary(hndl);
                    end;
                 if copy(resposta,1,1)<>'@' then
                    begin
                       message_info(2,resposta);
                    end
                 else
                    begin
                       reorganiza_logs(vpdvnum,V_num_loja);
                       try
                          strtofloat(v_coo);
                       except
                          v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
                       end;
                       grava_log_venda(2,1,'0','0',floattostrf(atual,ffnumber,12,2),0,inttostr(opc),Date,Time,cod_operador,'0','0','0','0',0,0,0,v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC200) o fundo de caixa
                       edcodigo.enabled:=true;
                       edcodigo.setfocus;
                       linha_display:=1;
                       MESSAge_info(1,'');
                       ex_GAVT;
                    end;
              end
           else
              begin
                 linha_display:=1;
                 message_info(2,'LIMITE EXCEDIDO!');
              end;
           Mostra_produto('','000','1000','000','000');
           fundo_cx:=false;
           edcodigo.enabled:=true;
           edcodigo.clear;
           Mask_edcodigo(1);// mascara normal
           edcodigo.setfocus;
        end;
end;

procedure TVPDR.ex_REDZ(tipo:integer);
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     grava_convenio;
     if tipo=1 then
        begin
           messagedlg('ATENÇÃO!!!'+chr(13)+chr(13)+'Você está realizando a REDUÇÃO Z.'+chr(13)+'Este procedimento poderá impedir as vendas pelo restando do dia.'+chr(13)+chr(13)+'VERIFIQUE ANTES SE ESTA OPERAÇÃO É REALMENTE NECESSÁRIA!!!',mtinformation,[mbok],0);
           linha_display:=1;
           message_info(1,'CONFIRMA A REDUCAO Z ?');
           Reducao_z:=true;
           edcodigo.enabled:=true;
           edcodigo.clear;
           Mask_EDCODigo(1);// mascara para NORMAL.
           edcodigo.setfocus;
        end;

     if tipo=2 then
        begin
           if (emite_redu_z=true) then
              begin
                 reorganiza_logs(vpdvnum,V_num_loja);
                 caixa_fechado;
              end;
           edcodigo.enabled:=true;
           edcodigo.setfocus;
           reducao_z:=false;
           linha_display:=1;
           message_info(1,'');
        end;

     Mostra_produto('','000','1000','000','000');
end;

procedure TVPDR.ex_LTRX;
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     grava_convenio;
     if emite_leit_x=true then
        begin
           reorganiza_logs(vpdvnum,V_num_loja);
           linha_display:=1;
           message_info(1,'');
        end;
     Mostra_produto('','000','1000','000','000');
     edcodigo.enabled:=true;
     edcodigo.setfocus;
end;

procedure TVPDR.ex_CONS(tipo:integer);
var p:string;
    ap:boolean;
begin
     if  bloqueio_tef=true then // caso exista um comprovante TEF pendente, a opção será abortada
        begin
           messagedlg('Opção não permitida. Existe um compravante TEF não impresso',mterror,[mbok],0);
           messagedlg('Utilize a opção UTILITARIOS para realizar a reimpressão do comprovante',mtinformation,[mbok],0);
           exit;
        end;
     if tipo=1 then
        begin
           linha_display:=1;
           message_info(1,'CONSULTA PRODUTO');
           panel11.visible:=false;
           panel9.visible:=false;
           panel10.visible:=false;
           refresh;
           edcodigo.clear;
           Mask_EDCODigo(1);// mascara para NORMAL.
           Consulta_plu:=true;
        end;

     if tipo=2 then
        begin
           v_edcodigo:=trim(v_edcodigo);
           v_edcodigo:=enche(v_edcodigo,'0',1,13);

           p:=floattostr(strtofloat(v_edcodigo));

           try
              ftabelas.tbl_produtoassociado.close;
              ftabelas.tbl_produtoassociado.sql.clear;
              ftabelas.tbl_produtoassociado.sql.add('select * from produtoassociado where codigoprodutoassociado='+p);
              ftabelas.tbl_produtoassociado.prepare;
              ftabelas.tbl_produtoassociado.open;
              if ftabelas.tbl_produtoassociado.fieldbyname('codigoprodutoassociado').value>0 then p:=floattostr(ftabelas.tbl_produtoassociado.fieldbyname('codigo').value);
           except
              ap:=false;
           end;

           try
              ftabelas.tbl_produtos.close;
              ftabelas.tbl_produtos.sql.clear;
              ftabelas.tbl_produtos.sql.add('select * from produto where codigoproduto='+p);
              ftabelas.tbl_produtos.prepare;
              ftabelas.tbl_produtos.open;
              if ftabelas.tbl_produtos.fieldbyname('codigoproduto').value>0 then ap:=true else ap:=false;
           except
              ap:=false;
           end;

           if ap=true then
              begin
                 ftabelas.tbl_tabelapreco.close;
                 ftabelas.tbl_tabelapreco.sql.clear;
                 ftabelas.tbl_tabelapreco.sql.add('select preco from produtotabelapreco where codigoproduto='+floattostr(ftabelas.tbl_produtos.fieldbyname('codigoproduto').value)+' and codigotabelapreco=7'); // por enquanto deixa fixo
                 ftabelas.tbl_tabelapreco.prepare;                                                                                                            // mas depois tem que pegar
                 ftabelas.tbl_tabelapreco.open;                                                                                                               // na tabela de configuracao

                 if ftabelas.tbl_tabelapreco.isempty=false then
                    begin
                       Mostra_produto(ftabelas.tbl_produtos.fieldbyname('NOMEproduto').value,ftabelas.tbl_tabelapreco.fieldbyname('preco').value,'0000','000','000');
                       edcodigo.enabled:=true;
                       edcodigo.clear;
                       edcodigo.setfocus;
                    end
                 else
                    begin
                       Mostra_produto('','000','1000','000','000');
                       linha_display:=1;
                       message_info(2,'PRODUTO SEM PRECO UNITARIO');
                       edcodigo.enabled:=true;
                       edcodigo.clear;
                       edcodigo.setfocus;
                       edcodigo.SelectAll;
                    end;
              end
           else
              begin
                 Mostra_produto('','000','1000','000','000');
                 linha_display:=1;
                 message_info(2,'PRODUTO NAO CADASTRADO');
                 edcodigo.enabled:=true;
                 edcodigo.clear;
                 edcodigo.setfocus;
                 edcodigo.SelectAll;
              end;
        end;
end;

procedure TVPDR.ex_OPER(tipo,opcao:integer);
var a,b,c,d,e,f:integer;
    status_dia:string;
    testa_condicao:boolean;
begin
     if tipo=1 then
        begin
           linha_display:=2;
           message_info(1,'OPERADOR '+chr(13)+' DIGITE A SENHA');
           refresh;
           edcodigo.clear;
           Mask_EDCODigo(2);// mascara para senha.
           Operador:=true;
        end;

     if tipo=2 then
        begin
           if ftabelas.tbop.locate('idusuario',cod_operador,[locaseinsensitive])=true then
              begin
                 v_edcodigo:=trim(v_edcodigo);
                 v_edcodigo:=enche(v_edcodigo,'0',1,6);
                 a:=strtoint(copy(v_edcodigo,1,1));
                 b:=strtoint(copy(v_edcodigo,2,1));
                 c:=strtoint(copy(v_edcodigo,3,1));
                 d:=strtoint(copy(v_edcodigo,4,1));
                 e:=strtoint(copy(v_edcodigo,5,1));
                 f:=strtoint(copy(v_edcodigo,6,1));
                 teste:=Encripit(a,b,c,d,e,f);
                 if copy(teste,1,length(trim(ftabelas.tbop.fieldbyname('senha').value)))=trim(ftabelas.tbop.fieldbyname('senha').value) then
                    begin
                       message_info(1,'AGUARDE...');
                       if tela_fechado.visible=true then
                          begin
                             status_dia:=ECF_INF(strtoint(vmodecf),strtoint(vcomecf));
                             if copy(status_dia,6,1)='1' then
                                begin
                                   if copy(status_dia,5,1)='0' then testa_condicao:=true;
                                   if copy(status_dia,5,1)='1' then testa_condicao:=iniciododia;
                                   if copy(status_dia,5,1)='3' then
                                      begin
                                         testa_condicao:=emite_redu_z;
                                         if testa_condicao=true then iniciododia;
                                      end;
                                   if copy(status_dia,5,1)='2' then
                                      begin
                                         testa_condicao:=false;
                                         linha_display:=1;
                                         message_info(2,'DIA ENCERRADO!');
                                         edcodigo.clear;
                                         edcodigo.SelectAll;
                                      end;
                                end
                             else
                                begin
                                   message_info(2,'Impressora sem papel!');
                                   testa_condicao:=false;
                                end;

                             if testa_condicao=true then
                                begin
                                   message_info(1,'AGUARDE...');
                                   hndl:=LoadLibrary(v_DLL_ECF);
                                   if hndl <> 0 then
                                      begin
                                         @troca_op:= GetProcAddress(hndl, 'Troca_op');
                                         if @troca_op <> nil then
                                            begin
                                               resposta:=troca_op(strtoint(vmodecf),strtoint(vcomecf),floattostr(cod_operador),'1');
                                            end;
                                         FreeLibrary(hndl);
                                      end;
                                   if (copy(resposta,1,1)<>'@') and (copy(resposta,1,1)<>'!') then
                                      begin
                                         message_info(2,resposta);
                                      end
                                   else
                                      begin
                                         caixa_aberto;
                                         reorganiza_logs(vpdvnum,V_num_loja);
                                      end;
                                   linha_display:=1;
                                   MESSAGE_info(1,'');
                                   edcodigo.enabled:=true;
                                   edcodigo.clear;
                                   Mask_edcodigo(1); // Mascara normal
                                   edcodigo.setfocus;
                                end;
                             Operador:=false;
                             exit;
                          end;

                       if tela_FECHADO.visible=FALSE then
                          begin
                             message_info(1,'AGUARDE...');
                             hndl:=LoadLibrary(v_DLL_ECF);
                             if hndl <> 0 then
                                begin
                                   @troca_op:= GetProcAddress(hndl, 'Troca_op');
                                   if @troca_op <> nil then
                                      begin
                                         resposta:=troca_op(strtoint(vmodecf),strtoint(vcomecf),'0000','0');
                                      end;
                                   FreeLibrary(hndl);
                                end;
                             if (copy(resposta,1,1)<>'@') and (copy(resposta,1,1)<>'!') then
                                begin
                                   message_info(2,resposta);
                                end
                             else
                                begin
                                   grava_convenio;
                                   caixa_fechado;
                                   reorganiza_logs(vpdvnum,V_num_loja);
                                end;
                             linha_display:=1;
                             message_info(1,'');
                             edcodigo.enabled:=true;
                             edcodigo.clear;
                             Mask_edcodigo(1); // Mascara normal
                             edcodigo.setfocus;
                             Operador:=false;
                          end;
                    end
                 else
                    begin
                       linha_display:=1;
                       message_info(2,'OPERADOR - SENHA INVALIDA');
                       edcodigo.clear;
                       edcodigo.SelectAll;
                    end;
              end;
         end;

     if tipo=3 then
        begin
           if cod=0 then
              begin
                 linha_display:=2;
                 message_info(1,'OPERADOR '+chr(13)+' DIGITE O CODIGO');
                 edcodigo.enabled:=true;
                 edcodigo.setfocus;
                 edcodigo.clear;
                 exit;
              end;
           if teste='' then
              begin
                 linha_display:=2;
                 message_info(1,'OPERADOR '+chr(13)+' DIGITE A SENHA');
                 edcodigo.enabled:=true;
                 edcodigo.setfocus;
                 edcodigo.clear;
                 Mask_edcodigo(2); // Mascara senha
                 exit;
              end;
           if ftabelas.tbop.locate('idusuario',cod,[locaseinsensitive])=true then
              begin
                 teste:=trim(teste);
                 teste:=enche(teste,'0',1,6);
                 a:=strtoint(copy(teste,1,1));
                 b:=strtoint(copy(teste,2,1));
                 c:=strtoint(copy(teste,3,1));
                 d:=strtoint(copy(teste,4,1));
                 e:=strtoint(copy(teste,5,1));
                 f:=strtoint(copy(teste,6,1));
                 teste:=Encripit(a,b,c,d,e,f);
                 if copy(teste,1,length(trim(ftabelas.tbop.fieldbyname('senha').value)))=trim(ftabelas.tbop.fieldbyname('senha').value) then
                    begin
                       if copy(Aces_opc[opcao],strtoint(ftabelas.tbop.fieldbyname('ns').value),1)='0' then
                          begin
                             linha_display:=1;
                             message_info(2,'ACESSO NEGADO');
                             acesso_liberado:=0;
                             v_edcodigo:='0';
                          end
                       else
                          begin
                             linha_display:=1;
                             message_info(1,'');
                             acesso_liberado:=2;
                             edcodigo.clear;
                          end;
                    end
                 else
                    begin
                       linha_display:=1;
                       message_info(2,'OPERADOR INVALIDO');
                       acesso_liberado:=0;
                       v_edcodigo:='0';
                    end;
              end
           else
              begin
                 linha_display:=1;
                 message_info(2,'OPERADOR INVALIDO');
                 acesso_liberado:=0;
                 v_edcodigo:='0';
              end;
           Mask_edcodigo(1); // Mascara normal
           edcodigo.enabled:=true;
           edcodigo.setfocus;
           edcodigo.clear;
           edcodigo.selectall;
        end;
end;

procedure TVPDR.ex_CORR(edit:Tmaskedit);
begin
     if Copy(edit.name,1,2)='ed' then
        begin
           edcodigo.enabled:=true;
           teste:=edit.text;
           if length(trim(teste))>0 then
              begin
                 edit.clear;
                 Mask_edcodigo(1); // Mascara normal
                 if operador=true           then
                    begin
                       if (status_erro=false) then ex_OPER(1,0);
                       exit;
                    end;

                 if sair=true               then
                    begin
                       if (status_erro=false) then ex_sair(1);
                       exit;
                    end;

                 if consulta_plu=true       then
                    begin
                       if (status_erro=false) then ex_Cons(1);
                       exit;
                    end;

                 if verifica_seguranca=true then
                    begin
                       cod:=0;
                       teste:='';
                       if (status_erro=false) then ex_oper(3,opc);
                       exit;
                    end;

                 if fundo_cx=true           then
                    begin
                       if (status_erro=false) then ex_FDCX(1);
                       exit;
                    end;

                 if desc_val=true           then
                    begin
                       if (status_erro=false) then ex_desv(1);
                       exit;
                    end;

                 if acrt_val=true           then
                    begin
                       if (status_erro=false) then ex_ACTV(1);
                       exit;
                    end;

                 if desc_per=true           then
                    begin
                       if (status_erro=false) then ex_desp(1);
                       exit;
                    end;

                 if acrt_per=true           then
                    begin
                       if (status_erro=false) then ex_ACTP(1);
                       exit;
                    end;

                 if (v_sangria=true) and (sangria_com_fina=true) then
                    begin
                       if (status_erro=false) then ex_sang(1);
                       exit;
                    end;

                 if multiplica=true         then
                    begin
                       if (status_erro=false) then ex_mult(1);
                       exit;
                    end;

                 if valor=true              then
                    begin
                       if (status_erro=false) then ex_valr(1);
                       exit;
                    end;

                 if lanca_ind=true          then
                    begin
                       if (status_erro=false) then ex_indc(1);
                       exit;
                    end;

                 if finalizadora=true       then
                    begin
                       if (status_erro=false) then ex_fi(1,cod);
                       exit;
                    end;

                 if canc_venda=true         then
                    begin
                       if (status_erro=false) then ex_canv(1);
                       exit;
                    end;

                 if lanca_convenio=true     then
                    begin
                       if (status_erro=false) then ex_convenio(3);
                       exit;
                    end;
                 if convenio_cod=true       then
                    begin
                       if (status_erro=false) then ex_convenio(1);
                       exit;
                    end;
                 if convenio_emp=true       then
                    begin
                       if (status_erro=false) then ex_convenio(2);
                       exit;
                    end;


              end;

           if length(trim(teste))<=0 then
              begin
                 mask_edcodigo(1);
                 linha_display:=1;
                 message_info(1,'');
                 edit.visible:=false;
                 edcodigo.visible:=true;
                 edcodigo.enabled:=true;
                 edcodigo.setfocus;
                 v_quant:=1;
                 v_prtot:=0;
                 if tela_fechado.visible=true then
                    begin
                       IF vmodtec='2' then // caso existe um teclado gertec 65 instalado no PDV
                          begin
                             strpcopy(Mensagem_display,'              CAIXA FECHADO             ');
                             hndl:=LoadLibrary('TEC65_32.DLL');
                             if hndl <> 0 then
                                begin
                                   @opentec65:=GetProcAddress(hndl, 'OpenTec65'); // inicializa o display do teclado
                                   @formfeed:=GetProcAddress(hndl, 'FormFeed'); // limpa o display do teclado
                                   @dispstr:=GetProcAddress(hndl, 'DispStr'); // escreve no display do teclado
                                   @setdisp:=GetProcAddress(hndl, 'SetDisp'); // ativa o display do teclado
                                   opentec65;
                                   formfeed;
                                   setdisp(1);
                                   dispstr(Mensagem_display);
                                   setdisp(0);
                                   FreeLibrary(hndl);
                                end;
                          end;
                    end
                 else
                    begin
                       visor_pruni.editmask:='999999,99;0; ';
                       v_decimais:=2;
                       Mostra_produto('','000','1000','000',visor_subtot.text);
                    end;

                 if operador=true           then operador:=false;
                 if consulta_plu=true       then
                    begin
                       caixa_aberto;
                       consulta_plu:=false;
                    end;
                 if reducao_z=true          then reducao_z:=false;
                 if verifica_seguranca=true then verifica_seguranca:=false;
                 if fundo_cx=true           then fundo_cx:=false;
                 if v_sangria=true          then
                    begin
                       v_sangria:=false;
                       sangria_com_fina:=false;
                    end;
                 if multiplica=true         then multiplica:=false;
                 if valor=true              then
                    begin
                       valor:=false;
                       lancou_valor:=false;
                    end;
                 if lanca_ind=true          then lanca_ind:=false;
                 if sub_total=true          then sub_total:=false;
                 if finalizadora=true       then finalizadora:=false;
                 if acrt_val=true           then acrt_val:=false;
                 if acri_val=true           then acri_val:=false;
                 if desc_val=true           then desc_val:=false;
                 if desc_per=true           then desc_per:=false;
                 if acrt_per=true           then acrt_per:=false;
                 if acri_per=true           then acri_per:=false;
                 if canc_venda=true         then canc_venda:=false;
                 if sair=true               then sair:=false;
                 if imprimindo_cheq=true    then imprimindo_cheq:=false;
                 if (lanca_convenio=true)   then lanca_convenio:=false;
                 if (convenio_cod=true)     then convenio_cod:=false;
                 if (convenio_emp=true)     then convenio_emp:=false;
              end;
        end;
end;


procedure TVPDR.ex_SAIR(tipo:integer);
var a,b,c,d,e,f:integer;
begin
     grava_convenio;
     if tipo=1 then
        begin
           if tela_fechado.visible=true then
              begin
                 linha_display:=2;
                 message_info(1,'SAIDA DA VENDA - DIGITE'+chr(13)+'A SENHA DO OPERADOR');
                 refresh;
                 edcodigo.clear;
                 Mask_EDCODigo(2);// mascara para senha.
                 sair:=true;
              end;
        end;

     if tipo=2 then
        begin
           if ftabelas.tbop.locate('idusuario',cod_operador,[locaseinsensitive])=true then
              begin
                 v_edcodigo:=trim(v_edcodigo);
                 v_edcodigo:=enche(v_edcodigo,'0',1,6);
                 a:=strtoint(copy(v_edcodigo,1,1));
                 b:=strtoint(copy(v_edcodigo,2,1));
                 c:=strtoint(copy(v_edcodigo,3,1));
                 d:=strtoint(copy(v_edcodigo,4,1));
                 e:=strtoint(copy(v_edcodigo,5,1));
                 f:=strtoint(copy(v_edcodigo,6,1));
                 teste:=Encripit(a,b,c,d,e,f);
                 if copy(teste,1,length(trim(ftabelas.tbop.fieldbyname('senha').value)))=trim(ftabelas.tbop.fieldbyname('senha').value) then
                    begin
                       edcodigo.clear;
                       Fsai.showmodal;
                       if tipo_saida=0 then
                          begin
                             sair:=false;
                             edcodigo.enabled:=true;
                             edcodigo.clear;
                             edcodigo.setfocus;
                             Mask_EDCODigo(1);// mascara para normal.
                             message_info(1,'');
                          end;
                       if tipo_saida=1 then
                          begin
                             fechaarquivos;
                             close;
                          end;
                       if tipo_saida=2 then
                          begin
                             fechaarquivos;
                             Finaliza_agentes;
                             ExitWindowsEx(EWX_SHUTDOWN,0);// sai do windows!!
                             close;
                          end;
                    end
                 else
                    begin
                       linha_display:=1;
                       message_info(2,'OPERADOR - SENHA INVALIDA');
                       edcodigo.clear;
                       edcodigo.SelectAll;
                    end;
              end;
        end;
end;


procedure TVPDR.Finaliza_agentes;
var num:integer;
    parar:string;
    v_ini:Tinifile;
begin
     // finaliza o aprnet.
     v_ini:=TIniFile.Create(path+'Autocom.ini');
     num:=strtoint(v_ini.readstring('Terminal','PDVNum','0'));
     v_ini.free;
     if num>0 then
        begin
           parar:='9';
           v_ini:=TIniFile.Create(path+'autocom.ini');
           v_ini.writestring('APR','Ativo','9');
           v_ini.free;
           while parar<>'0' do
              begin
                 sleep(1000);
                 v_ini:=TIniFile.Create(path+'autocom.ini');
                 parar:=v_ini.readstring('APR','Ativo','0');
                 v_ini.free;
              end;
        end;

end;

procedure TVPDR.carregaini_par;
var autocom:Tinifile;
begin
     autocom:=TIniFile.Create(path+'Autocom.INI');
     vpdvnum:=autocom.ReadString('TERMINAL', 'PDVNum', '000');    // Número do PDV
     vModECF:=autocom.ReadString('TERMINAL', 'ModECF', '99');     // modelo do ECf
     vCOMECF:=autocom.ReadString('TERMINAL', 'COMECF', '1');      // porta de comunicação do ECF
     vscnr:=autocom.ReadString('TERMINAL','SCNR','0');            // Indica se tem ou não um scanner parametrizado.
     vcomscnr:=autocom.READString('TERMINAL','COMSCNR','0');      // porta de comunicação do Scanner
     vmodtec:=autocom.readstring('TERMINAL','ModTec','1');        // Tipo de teclado em uso
     VLCHQ:=autocom.ReadString('TERMINAL', 'LCHQ', '0');          // dEFINIÇÃO DE leitor de cheques.
     Vbal:=autocom.ReadString('TERMINAL', 'BAL', '0');            // dEFINIÇÃO DE balança conectada.
     Vbalcom:=autocom.ReadString('TERMINAL', 'BALCOM', '1');      // porta de comunicação da balança conectada.
     tipo_indicador:=autocom.REadString('TERMINAL','TIPIND','0'); // tipo de indicador
     nome_indicador:=autocom.readstring('TERMINAL','NOMEIND','');// nome do indicador parametrizado no sistema
     obriga_indicador:=autocom.readstring('TERMINAL','OBRIND','0');// obriga laçar o indicador no incio da venda
     v_gaveta:=autocom.readstring('TERMINAL','GAVETA','0');       // definição para a gaveta de valores
     v_fechagaveta:=autocom.readstring('TERMINAL','OFGAVETA','0');// define se o sistema obriga ou não a fechar a gaveta
     strpcopy(v_DLL_ECF,Autocom.ReadString('MODULOS', 'dll_ECF', '')); // Nome da Dll para comunicação com o ECF
     v_printgrill:=autocom.readstring('TERMINAL','printgrill','0');       // Define se imprime pedido na cozinha  0=não   1=sim

     v_l1:=autocom.readstring('CORTESIA','MCLinha1','');          // linha de mesagem de cortesia 1
     v_l2:=autocom.readstring('CORTESIA','MCLinha2','');          // linha de mesagem de cortesia 2
     v_l3:=autocom.readstring('CORTESIA','MCLinha3','');          // linha de mesagem de cortesia 3
     v_l4:=autocom.readstring('CORTESIA','MCLinha4','');          // linha de mesagem de cortesia 4
     v_l5:=autocom.readstring('CORTESIA','MCLinha5','');          // linha de mesagem de cortesia 5
     v_l6:=autocom.readstring('CORTESIA','MCLinha6','');          // linha de mesagem de cortesia 6
     v_l7:=autocom.readstring('CORTESIA','MCLinha7','');          // linha de mesagem de cortesia 7
     v_l8:=autocom.readstring('CORTESIA','MCLinha8','');          // linha de mesagem de cortesia 8

     Autocom.Free;
end;

procedure TVPDR.Timer1Timer(Sender: TObject);
begin
     Timer1.enabled:=false;
     Panel2.caption:=nome_operador;
     Panel3.caption:=datetostr(date);
     Panel4.caption:=copy(timetostr(time),1,5);
     Panel5.caption:='Terminal: '+vpdvnum;
     Panel13.caption:='Loja: '+V_num_loja;

     Timer1.enabled:=true;
end;

procedure TVPDR.Mask_edcodigo(tipo:integer);
begin
     if tipo=1 then// normal
        begin
           edcodigo.editmask:='';
           edcodigo.Maxlength:=0;
           edcodigo.PasswordChar:=#0;
           digita_valores:=false;
        end;
     if tipo=2 then// senha
        begin
           edcodigo.editmask:='999999;0; ';
           edcodigo.Maxlength:=6;
           edcodigo.PasswordChar:='*';
           digita_valores:=false;
        end;
     if tipo=3 then// valores
        begin
//           edcodigo.editmask:='9999999999,99;0; ';
//           edcodigo.Maxlength:=12;
           edcodigo.editmask:='';
           edcodigo.Maxlength:=8;
           edcodigo.PasswordChar:=#0;
           digita_valores:=true;
        end;
     if tipo=4 then// quantidades
        begin
           edcodigo.editmask:='';
           edcodigo.Maxlength:=8;
           edcodigo.PasswordChar:=#0;
           digita_valores:=false;
        end;
     if tipo=5 then// percentuais
        begin
           edcodigo.editmask:='99;0; ';
           edcodigo.Maxlength:=2;
           edcodigo.PasswordChar:=#0;
           digita_valores:=false;
        end;
     edcodigo.selectall;
end;


procedure TVPDR.Message_info(tipo:integer;texto:string);
begin
     if tipo=1 then
        begin
           info.font.color:=clNavy;
           info.font.size:=15;
           status_erro:=false;
        end;

     if tipo=2 then
        begin
           info.font.color:=clmaroon;
           info.font.size:=10;
           status_erro:=true;
        end;
     info.caption:=texto;

     IF (vmodtec='2') and (length(texto)>0) then // caso existe um teclado gertec 65 instalado no PDV e exista algo para ser displayado!!
        begin
           hndl:=LoadLibrary('TEC65_32.DLL');
           if hndl <> 0 then
              begin
                 @opentec65:=GetProcAddress(hndl, 'OpenTec65'); // inicializa o display do teclado
                 @dispstr:=GetProcAddress(hndl, 'DispStr'); // escreve no display do teclado
                 @formfeed:=GetProcAddress(hndl, 'FormFeed'); // limpa o display do teclado
                 @gotoxy:=GetProcAddress(hndl, 'GoToXY');
                 @setdisp:=GetProcAddress(hndl, 'SetDisp'); // ativa o display do teclado
                 opentec65;
                 setdisp(1);
                 formfeed;
                 gotoxy(1,1);
                 while pos(chr(13),texto)>0 do
                    begin
                       teste:=' ';
                       insert(teste,texto,pos(chr(13),texto));
                       delete(texto,pos(chr(13),texto),1);
                    end;
                 strpcopy(Mensagem_display,texto);
                 dispstr(Mensagem_display);
                 gotoxy(linha_display,1);
                 setdisp(0);
                 FreeLibrary(hndl);
              end;
        end;
     refresh;
     edcodigo.enabled:=true;
     edcodigo.clear;
     edcodigo.setfocus;
end;

function TVPDR.liberado:boolean;
var ok:boolean;
begin
     ok:=true;
     if ((operador=true)           and (ok=true)) then ok:=false;
     if ((consulta_plu=true)       and (ok=true)) then ok:=false;
     if ((reducao_z=true)          and (ok=true)) then ok:=false;
     if ((verifica_seguranca=true) and (ok=true)) then ok:=false;
     if ((fundo_cx=true)           and (ok=true)) then ok:=false;
     if ((v_sangria=true)          and (ok=true)) then ok:=false;
     if ((multiplica=true)         and (ok=true)) then ok:=false;
     if ((valor=true)              and (ok=true)) then ok:=false;
     if ((finalizadora=true)       and (ok=true)) then ok:=false;
     if ((lanca_ind=true)          and (ok=true)) then ok:=false;
     if ((desc_val=true)           and (ok=true)) then ok:=false;
     if ((desc_per=true)           and (ok=true)) then ok:=false;
     if ((acrt_val=true)           and (ok=true)) then ok:=false;
     if ((acrt_per=true)           and (ok=true)) then ok:=false;
     if ((acri_val=true)           and (ok=true)) then ok:=false;
     if ((acri_per=true)           and (ok=true)) then ok:=false;
     if ((canc_venda=true)         and (ok=true)) then ok:=false;
     if ((imprimindo_cheq=true)    and (ok=true)) then ok:=false;
     if ((lanca_convenio=true)     and (ok=true)) then ok:=false;
     if ((convenio_cod=true)       and (ok=true)) then ok:=false;
     if ((convenio_emp=true)       and (ok=true)) then ok:=false;

     result:=ok;
end;

procedure TVPDR.mostra_produto(nome,pruni,quant,prtot,tot:string);
begin
     if visor_desc.visible=true   then visor_desc.text:=nome;

     pruni:=strtovalor(pruni,strtoint(floattostr(v_decimais)));
     while pos(',',pruni)>0 do delete(pruni,pos(',',pruni),1);
     while pos('.',pruni)>0 do delete(pruni,pos('.',pruni),1);
     if visor_pruni.visible=true  then visor_pruni.text:=enche(trim(pruni),' ',1,8);

     while pos(',',quant)>0 do delete(quant,pos(',',quant),1);
     while pos('.',quant)>0 do delete(quant,pos('.',quant),1);
     if visor_qtde.visible=true   then visor_qtde.text:=enche(quant,' ',1,7);

     while pos(',',prtot)>0 do delete(prtot,pos(',',prtot),1);
     while pos('.',prtot)>0 do delete(prtot,pos('.',prtot),1);
     if visor_tot.visible=true    then visor_tot.text:=enche(prtot,' ',1,12);

     while pos(',',tot)>0 do delete(tot,pos(',',tot),1);
     while pos('.',tot)>0 do delete(tot,pos('.',tot),1);
     if visor_subtot.visible=true then visor_subtot.text:=enche(tot,' ',1,12);

     IF vmodtec='2' then // caso existe um teclado gertec 65 instalado no PDV
        begin
           hndl:=LoadLibrary('TEC65_32.DLL');
           if hndl <> 0 then
              begin
                 @opentec65:=GetProcAddress(hndl, 'OpenTec65'); // inicializa o display do teclado
                 @formfeed:=GetProcAddress(hndl, 'FormFeed'); // limpa o display do teclado
                 @dispstr:=GetProcAddress(hndl, 'DispStr'); // escreve no display do teclado
                 @gotoxy:=GetProcAddress(hndl, 'GoToXY');
                 @setdisp:=GetProcAddress(hndl, 'SetDisp'); // ativa o display do teclado
                 opentec65;
                 setdisp(1);
                 formfeed;
                 gotoxy(1,1);
                 strpcopy(Mensagem_display,nome);
                 dispstr(Mensagem_display);
                 if sub_total=false then
                    begin
                       gotoxy(2,1);
                       if Consulta_plu=false then // se for consulta de produto, não aparece a quantidade
                          begin
                             strpcopy(Mensagem_display,strtoformat(visor_qtde.text,3)+' X ');
                             dispstr(Mensagem_display);
                          end;
                       strpcopy(Mensagem_display,strtoformat(visor_pruni.text,strtoint(floattostr(v_decimais))));
                       dispstr(Mensagem_display);
                       if Consulta_plu=false then // se for consulta de produto, não aparece o subtotal do produto
                          begin
                             strpcopy(Mensagem_display,' = '+strtoformat(visor_tot.text,2));
                             dispstr(Mensagem_display);
                          end;
                    end;
                 gotoxy(1,1);
                 setdisp(0);
                 FreeLibrary(hndl);
              end;
        end;
end;

procedure TVPDR.FormShow(Sender: TObject);
begin
     VPDR.Top := 0;
     VPDR.Left := 0;
     VPDR.Width := 800;
     VPDR.Height := 600;
end;

function TVPDR.Verifica_liberacao(op:integer;verify:boolean):boolean;
begin
     if verify=true then
        begin
           if copy(Aces_opc[op],strtoint(nivel_atual),1)='0' then
              begin
                 edcodigo.clear;
                 verifica_seguranca:=true;
                 cod:=0;
                 teste:='';
                 if (status_erro=false) then ex_oper(3,op);
                 while acesso_liberado=1 do
                    begin
                       application.processmessages;
                       if acesso_liberado=0 then result:=false;
                       if acesso_liberado=2 then
                          begin
                             result:=true;
                             verifica_seguranca:=false;
                          end;
                    end;
              end
           else
              begin
                 result:=true;
              end;
        end
     else
        begin
           result:=true;
        end;
end;

procedure TVPDR.edcodigoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if (status_erro=true) then edcodigo.clear;
     if ((key=188) or (key=190) or (key=110) or ((key>=48)and(key<=57)) or ((key>=96)and(key<=105)) or (key=13)) and (status_erro=false) then exit else edcodigo.clear;
end;

procedure TVPDR.captura_produto(pesado:real);
var posi:integer;
    precisao:real;
begin
     v_prod:=ftabelas.tbl_produtos.fieldbyname('codigoproduto').value;
     v_desc:=ftabelas.tbl_produtos.fieldbyname('nomeproduto').value;
     v_decimais:=ftabelas.tbl_produtos.fieldbyname('decimais').value;
     v_depto:=ftabelas.tbl_produtos.fieldbyname('codigosubgrupoproduto').value;
     V_UN:=trim(ftabelas.tbl_produtos.fieldbyname('unidade').value);
     v_estoque:=1; // por enquanto fica fixo 1, apagar depois todos os controles v_estoque


     ftabelas.tbl_tabelapreco.close;
     ftabelas.tbl_tabelapreco.sql.clear;
     ftabelas.tbl_tabelapreco.sql.add('select p.preco from produtotabelapreco p,configuracoespdv c where p.codigoproduto='+floattostr(v_prod)+' and p.codigotabelapreco=c.CODIGOTABELAPRECOPDV'); // por enquanto deixa fixo
     ftabelas.tbl_tabelapreco.prepare;
     ftabelas.tbl_tabelapreco.open;

     try
        if ftabelas.tbl_tabelapreco.fieldbyname('preco').value<=0 then
           begin
              linha_display:=1;
              message_info(2,'Produto sem preco unitario');
              visor_pruni.editmask:='999999,99;0; ';
              Mostra_produto('','000','1000','000',visor_subtot.text);
              edcodigo.SelectAll;
              v_quant:=1;
              lancou_valor:=false;
              exit;
           end;
     except
        linha_display:=1;
        message_info(2,'Produto sem preco unitario');
        visor_pruni.editmask:='999999,99;0; ';
        Mostra_produto('','000','1000','000',visor_subtot.text);
        v_quant:=1;
        lancou_valor:=false;
        exit;
     end;
     if v_decimais=2 then visor_pruni.editmask:='999999,99;0; ';
     if v_decimais=3 then visor_pruni.editmask:='99999,999;0; ';
     v_prunit:=ftabelas.tbl_tabelapreco.fieldbyname('preco').value;

     if pesado>0 then
        begin
           lancou_valor:=true;
           v_prtot:=pesado;
        end;

     if lancou_valor=false then
        begin
           v_prtot:=v_prunit*v_quant;
           v_prtot:=strtofloat(tira_milhar(floattostrf(v_prtot,ffnumber,12,2)));
        end
     else
        begin
           v_quant:=v_prtot/v_prunit;
           v_quant:=strtofloat(tira_milhar(floattostrf(v_quant,ffnumber,7,3)));
           precisao:=abs(((v_prunit*v_quant))-v_prtot);
           while precisao>=(1/100) do
              begin
                 v_quant:=(v_quant+(1/1000));
                 precisao:=abs(((v_prunit*v_quant))-v_prtot);
              end;
        end;

     teste:=floattostr(v_prtot);
     posi:=pos(',',teste);
     if posi>0 then
        begin
           if length(copy(teste,posi+1,3))=3 then teste:=copy(teste,1,posi+2);
           v_prtot:=strtofloat(teste);
        end;


     perc_depto:=ftabelas.tbl_produtos.fieldbyname('nummicro1').asstring;

     v_trib_code:=16; // por enquanto deixar fixo em isento, mas depois alterar
     v_trib:='I'
//           if v_trib_code<=15 then v_trib:=trim(acr100.fields[1].value)+floattostr(v_trib_code) else v_trib:=trim(acr100.fields[1].value);
//           end
//        else
//           begin
//              message_info(2,'TAXA NAO CADASTRADA');
//           end;


end;


procedure TVPDR.captura_finalizadora;
begin
     v_nomefina:=ftabelas.tbl_condicaopagamento.fieldbyNaMe('condicaopagamento').asstring;
     if ftabelas.tbl_condicaopagamento.fieldbyname('autentica').asstring='T'        then v_autfina:=1  else v_autfina:=0;
     if ftabelas.tbl_condicaopagamento.fieldbyname('impressaocheque').asstring='T'  then v_cheqfina:=1 else v_cheqfina:=0;
     v_trocofina:=strtofloat(ftabelas.tbl_condicaopagamento.fieldbyname('tipotroco').asstring);
     v_funcfina:=ftabelas.tbl_condicaopagamento.fieldbyname('funcaoespecial').value;
     v_diacheqfina:=ftabelas.tbl_condicaopagamento.fieldbyname('intervaloparcelas').value;
     v_datacheqfina[1]:=''; // não usa mais a data direto, somente o número de dias
                            // dia 17/02/2003 - Helder Frederico
end;

function TVPDR.strtoquant(texto:string):string;
var tam,posi:integer;
    t1,t2:string;
begin
     tam:=length(texto);
     posi:=pos('.',texto);
     if posi=0 then posi:=pos(',',texto);

     if posi=0 then
        begin
           if tam=1 then texto:='   '+texto+'000';
           if tam=2 then texto:='  '+texto+'000';
           if tam=3 then texto:=' '+texto+'000';
           if tam=4 then texto:=texto+'000';
        end
     else
        begin
           t1:=copy(texto,1,posi-1);
           t2:=copy(texto,posi+1,3);
           while length(t2)<3 do t2:=t2+'0';
           if length(t1)=0 then t1:='0';
           while length(t1)<4 do t1:=' '+t1;
           texto:=t1+t2;
        end;

     while pos(',',texto)>0 do delete(texto,pos(',',texto),1);
     while pos('.',texto)>0 do delete(texto,pos('.',texto),1);
     result:=texto;
end;


function TVPDR.strtovalor(texto:string;dec:integer):string;
var tam,posi:integer;
    t1,t2:string;
begin
     tam:=length(texto);
     posi:=pos('.',texto);
     if posi=0 then posi:=pos(',',texto);

     if posi=0 then
        begin
           if dec=2 then
              begin
                 if tam=1 then texto:='     '+texto+'00';
                 if tam=2 then texto:='    '+texto+'00';
                 if tam=3 then texto:='   '+texto+'00';
                 if tam=4 then texto:='  '+texto+'00';
                 if tam=5 then texto:=' '+texto+'00';
                 if tam=6 then texto:=texto+'00';
              end;
           if dec=3 then
              begin
                 if tam=1 then texto:='    '+texto+'000';
                 if tam=2 then texto:='   '+texto+'000';
                 if tam=3 then texto:='  '+texto+'000';
                 if tam=4 then texto:=' '+texto+'000';
                 if tam=5 then texto:=texto+'000';
              end;
        end
     else
        begin
           t1:=copy(texto,1,posi-1);
           t2:=copy(texto,posi+1,2);
           while length(t2)<dec do t2:=t2+'0';
           if length(t1)=0 then t1:='0';
           while length(t1)<6 do t1:=' '+t1;
           texto:=t1+t2;
        end;

     while pos(',',texto)>0 do delete(texto,pos(',',texto),1);
     while pos('.',texto)>0 do delete(texto,pos('.',texto),1);
     result:=texto;
end;


procedure TVPDR.Visor_descChange(Sender: TObject);
begin
     visor_desc.color:=clSkyBlue;
     visor_desc.font.color:=clBlack;

     if sub_total=true then
        begin
           visor_desc.color:=clblack;
           visor_desc.font.color:=clred;
           visor_pruni.editmask:='999999,99;0; ';
        end;

     if finalizadora=true then
        begin
           visor_desc.color:=clblue;
           visor_desc.font.color:=clyellow;
           visor_pruni.editmask:='999999,99;0; ';
        end;
end;

procedure TVPDR.Termina_venda;
begin
     display_torre('',0,1,1);
     display_torre('Caixa Aberto',1,1,1);
     cod:=0;
     teste:='';
     OPC:=0;
     perc_depto:='0';
     vendendo:=false;
     lancou_item:=false;
     sub_total:=false;
     finalizadora:=false;
     lanca_convenio:=false;
     convenio_cod:=false;
     convenio_emp:=false;
     ja_lancou_desc_no_item:=false;
     V_TOTAL:=0;
     V_quant_total:=0;
     v_prod:=0;
     v_desc:='';
     v_prunit:=0;
     v_trib:='';
     v_quant:=1;
     v_prtot:=0;
     v_depto:=0;
     v_decimais:=2;
     v_un:='UN';
     numero_de_acre_sub:=0;
     numero_de_desc_sub:=0;
     total_recebido:=0;
     valor_recebido:=0;
     falta_receber:=0;
     banco_cheq:='0';
     agencia_cheq:='0';
     conta_cheq:='0';
     num_cheq:='0';
     codigo_indicador:=0;
     codigo_cliente:=0;
     saldo_cliente:=0;
     numero_de_itens:=0;
     numero_de_itens_desc:=0;
     edcodigo.enabled:=true;
     visor_pruni.editmask:='999999,99;0; ';
     mostra_produto('','000','1000','000','000');
     label15.caption:='';
     label16.caption:='';
     label18.caption:='';
     message_info(1,'');
     codigo_conveniado:=0;
     codemp_conveniado:=0;
     mensagem_tef:='';
     visor_desc.color:=clSkyBlue;
     visor_desc.font.color:=clBlack;

     //caso tenha algum cupom aberto
     hndl:=LoadLibrary(v_DLL_ECF);
     if hndl <> 0 then
        begin
           @FecharCupom:=GetProcAddress(hndl, 'FecharCupom');
           if @FecharCupom <> nil then
              begin
                 resposta:=FecharCupom(strtoint(vmodecf),strtoint(vcomecf),'0','0','','','','','','','','');
              end;
              FreeLibrary(hndl);
        end;
end;


Function TVPDR.ValidaCPF(campo:string):Integer;
var k, j, i, h, dig1, inteiro, resto, digito, total, valida :integer;
    interm, cpf, cgc1, cgc2 :String;
begin
     while length(campo)<16 do campo:='0'+campo;
     if campo='00000000000000' then
     begin
          ValidaCPF:=0;
          Exit;
     end;
     Valida:=1;
     k:=0;
     if copy(campo,K+3,3)='000' then // somei 2 = k+3
     begin
          for j:=1 to 2 do
          begin
               dig1:=StrToInt(copy(campo,k+j+14,1));
               total:=0;
               cpf:=copy(campo,5+j,9);
               for i:=2 to 10 do
               begin
                    interm:=copy(cpf,11-i,1);
                    total:=total+ (StrToint(interm)*i);
               end;
               inteiro:=total div 11;
               resto:=total - (inteiro * 11);
               digito:=11-resto;
               if digito>9 then digito:=0;
               if dig1<>digito then
               begin
                    for h:=1 to 2 do
                    begin
                         Valida:=2;
                         total:=0;
                         cgc1:=copy(campo,k+3,h+3);
                         cgc2:=copy(campo,k+h+6,8);
                         for i:=2 to h+4 do
                         begin
                              interm:=copy(cgc1,h+5-i,1);
                              total:=total+(strToint(interm)*i);
                         end;
                         for i:=2 to 9 do
                         begin
                              interm:=copy(cgc2,k+10-i,1);
                              total:=total+(strToint(interm)*i);
                         end;
                         inteiro:= total div 11;
                         resto:=total - (inteiro * 11);
                         digito:=11 - resto;
                         if digito >9 Then digito:=0;
                         if dig1 <> digito then Valida:=0;
                    end;
               end
          end;
     end
     else
     begin
          Valida:=2;
          for j:=1 to 2 do
          begin
               total:=0;
               cgc1:=copy(campo,3,j+3);
               cgc2:=copy(campo,j+6,8);
               for i:=2 to j+4 do
               begin
                    interm:=copy(cgc1,j+5-i,1);
                    total:=total+(Strtoint(interm) * i);
               end;
               for i:=2 to 9 do
               begin
                    interm:=copy(cgc2,10-i,1);
                    total:=total+(Strtoint(interm) * i);
               end;
               inteiro:= total div 11;
               resto := total - (inteiro * 11);
               digito:= 11 - resto;
               if digito>9 then digito:=0;
               if StrtoInt(copy(campo,j+14,1))<>digito then Valida:=0;
          end;
     end;
     result:=valida;
end;

procedure TVPDR.tef(tipo:string);
var r,p,data_inicial:string;
    tef_ini:Tinifile;
    conta_par:integer;
    valor_parcela:real;
begin
     habilita_dlltef;
     message_info(1,'Aguarde...');
     if hndl_tef<>0 then
        begin
           @tef_cartao := GetProcAddress(hndl_tef, 'tef_cartao');
           r:=tef_cartao(v_coo,floattostr(valor_recebido),tipo);
        end;
     desabilita_dlltef;
     mensagem_tef:=copy(r,2,length(r));
     if copy(r,1,1)<>'2' then
        begin
           message_info(2,mensagem_tef);
           messagedlg(mensagem_tef,mtinformation,[mbok],0);
        end
     else
        begin
           tef_ini:=tinifile.create(extractfilepath(application.exename)+'atctefdi.ini');
           p:=tef_ini.readstring('TEF DISCADO','parcelas','0');
           try
              strtoint(p);
           except
              p:='1';
           end;
           parcelas:=strtoint(p);
           if strtoint(p)>1 then
              begin
                 valor_parcela:=valor_recebido/strtoint(p);
                 data_inicial:=datetostr(date);
                 conta_par:=1;
                 while conta_par<=strtoint(p) do
                    begin
                       v_datacheqfina[conta_par]:=formatdatetime('ddmmyyyy',strtodate(data_inicial)+30);
                       valor_recebido_parcela[conta_par]:=valor_parcela;
                       data_inicial:=datetostr(strtodate(data_inicial)+30);
                       conta_par:=conta_par+1;
                    end;
              end;
           tef_ini.free;
           message_info(1,mensagem_tef);
        end;

end;

procedure TVPDR.habilita_dlltef;
begin
     hndl_tef:=loadlibrary('atctefdi.dll');
end;

procedure TVPDR.desabilita_dlltef;
begin
     freelibrary(hndl_tef);
end;

procedure TVPDR.consulta_ln;
begin
     tipo_consulta_cliente:=1;
     Fconscli.showmodal;
     setforegroundwindow(application.handle);
     if status_cliente=0 then message_info(2,'CONSULTA CANCELADA');
     IF status_cliente=1 then message_info(2,'TRANSACAO NAO AUTORIZADA');
end;


procedure TVPDR.consulta_tef_cheque;
var r:string;
    banco,agenc,agenc_dc,cc,cc_dc,num_ch,num_ch_dc,data:string;
begin
     fgetcpf.showmodal;
     if V_cpfcnpj='' then
        begin
           message_info(2,'OPERACAO CANCELADA'+CHR(13)+'PELO OPERADOR');
           exit;
        end;

     if V_tipo_cliente='1' then V_tipo_cliente:='F';
     if V_tipo_cliente='2' then V_tipo_cliente:='J';

     banco:=banco_cheq;
     if pos('-',agencia_cheq)>0 then agenc:=copy(agencia_cheq,1,pos('-',agencia_cheq)-1)     else agenc:=floattostr(strtofloat(agencia_cheq));
     if pos('-',agencia_cheq)>0 then agenc_dc:=copy(agencia_cheq,pos('-',agencia_cheq)+1,10) else agenc_dc:='';
     if pos('-',conta_cheq)>0   then cc:=copy(conta_cheq,1,pos('-',conta_cheq)-1)            else cc:=conta_cheq;
     if pos('-',conta_cheq)>0   then cc_dc:=copy(conta_cheq,pos('-',conta_cheq)+1,10)        else cc_dc:='';
     if pos('-',num_cheq)>0     then num_ch:=copy(num_cheq,1,pos('-',num_cheq)-1)            else num_ch:=num_cheq;
     if pos('-',num_cheq)>0     then num_ch_dc:=copy(num_cheq,pos('-',num_cheq)+1,10)        else num_ch_dc:='';
     data:=datetostr(date);

     while pos('/',data)>0 do delete(data,pos('/',data),1);
     habilita_dlltef;
     if hndl_tef<>0 then
        begin
           @tef_cheque := GetProcAddress(Hndl_tef, 'tef_cheque');
           if @tef_cheque <> nil then
              begin
                 r:=tef_cheque(v_coo,floattostr(valor_recebido),data,banco,agenc,agenc_dc,cc,cc_dc,num_ch,num_ch_dc,V_cpfcnpj,V_tipo_cliente,'0');
              end;
        end;
     desabilita_dlltef;

     setforegroundwindow(application.handle);
     mensagem_tef:=copy(r,2,length(r));
     if copy(r,1,1)='1' then message_info(2,mensagem_tef);
     if copy(r,1,1)='2' then message_info(1,mensagem_tef);
     messagedlg(mensagem_tef,mtinformation,[mbok],0);
end;


procedure TVPDR.convenio;
var autocom:Tinifile;
begin
     tipo_consulta_cliente:=2;
     saldo_cliente:=0;
     Fconscli.showmodal;
     setforegroundwindow(application.handle);
     if status_cliente=0 then message_info(2,'CONSULTA CANCELADA');
     IF status_cliente=1 then message_info(2,'TRANSACAO NAO AUTORIZADA');
     if status_cliente=2 then
        begin
           saldo_cliente:=saldo_cliente-v_total;
           try
              try
                 Autocom:=TIniFile.Create(path+'autocom.INI');
                 if codigo_conveniado>0 then Autocom.writeString('CONVENIO', 'codigo', floattostr(codigo_conveniado)) else Autocom.writeString('CONVENIO', 'codigo', floattostr(codigo_cliente));
                 Autocom.writeString('CONVENIO', 'empresa', floattostr(codemp_conveniado));
                 teste:=FLOAttostrf((saldo_cliente),ffnumber,12,2);
                 while pos(',',teste)>0 do delete(teste,POs(',',teste),1);
                 while pos('.',teste)>0 do delete(teste,POs('.',teste),1);
                 Autocom.writeString('CONVENIO', 'saldo', enche(teste,'0',1,12));
                 Autocom.writeString('CONVENIO', 'data', datetostr(date));
                 Autocom.writeString('CONVENIO', 'hora', timetostr(time));
                 Autocom.writeString('CONVENIO', 'operador', floattostr(cod_operador));
              finally
                 Autocom.Free;
              end;
           except
              message_info(2,'ERRO DE PROCESSAMENTO.');
           end;

        end;
end;


procedure TVPDR.grava_convenio;
var autocom:Tinifile;
    co:boolean;
    txt,val:string;
    cod:real;
begin
// toda esta funcao deve ser implemtada na dll de controle de venda e retirada daki
     Autocom:=TIniFile.Create(path+'Autocom.INI');
     try
        cod:=strtofloat(Autocom.readString('CONVENIO', 'codigo', '0'));
     except
        cod:=0;
     end;
     if (cod>0) and (strtofloat(Autocom.readstring('CONVENIO', 'saldo', '0'))>0) then
        begin
           ftabelas.querylog.close;
           ftabelas.querylog.sql.clear;
           ftabelas.querylog.sql.add('select * from conv_saldocliente where cli_codcliente='+Autocom.readString('CONVENIO', 'codigo', '0'));
           ftabelas.querylog.prepare;
           ftabelas.querylog.open;
           try
              if ftabelas.querylog.fields[0].value>0 then co:=true else co:=false;
           except
              co:=false;
           end;

           val:=formata_virgula(Autocom.readstring('CONVENIO', 'saldo', '0'),2);

              if co=true then
                 begin
                    txt:='update conv_saldocliente set saldo='+val+','+
                                            'data='+chr(39)+formatdatetime('mm/dd/yyyy',strtodate(Autocom.readString('CONVENIO', 'data', '')))+chr(39)+','+
                                            'hora='+chr(39)+Autocom.readString('CONVENIO', 'hora', '')+chr(39)+','+
                                            'idusuario='+Autocom.readString('CONVENIO', 'operador', '0')+','+
                                            'codigoconvenio='+Autocom.readString('CONVENIO', 'empresa', '0')+' '+
                                            'where cli_codcliente='+Autocom.readString('CONVENIO', 'codigo', '0');
                 end
              else
                 begin
                    txt:='insert into conv_saldocliente (cli_codcliente,codigoconvenio,saldo,data,hora,idusuario) values '+
                                            '('+Autocom.readString('CONVENIO', 'codigo', '0')+
                                            ','+Autocom.readString('CONVENIO', 'empresa', '0')+
                                            ','+val+
                                            ','+chr(39)+formatdatetime('mm/dd/yyyy',strtodate(Autocom.readString('CONVENIO', 'data', '')))+chr(39)+
                                            ','+chr(39)+Autocom.readString('CONVENIO', 'hora', '')+chr(39)+
                                            ','+Autocom.readString('CONVENIO', 'operador', '0')+
                                            ')';

                  end;
              ftabelas.query1.close;
              ftabelas.query1.sql.clear;
              ftabelas.query1.sql.add(txt);
              ftabelas.query1.prepare;
              ftabelas.query1.execsql;
        end;
     Autocom.Free;


     Autocom:=TIniFile.Create(path+'Autocom.INI');
     if (strtofloat(Autocom.readString('CONVENIO', 'codigo', '0'))>0) then
        begin
           if (Autocom.readString('CONVENIO', 'verifica_prod', '')='S') then grava_produtos_convenio(Autocom.readString('CONVENIO', 'codigo', '0'));
           Autocom.writeString('CONVENIO', 'codigo', '0');
           Autocom.writeString('CONVENIO', 'empresa', '0');
           Autocom.writeString('CONVENIO', 'saldo', '0');
           Autocom.writeString('CONVENIO', 'data', '');
           Autocom.writeString('CONVENIO', 'hora', '');
           Autocom.writeString('CONVENIO', 'operador', '');
           Autocom.writeString('CONVENIO', 'verifica_prod', '');
        end;
     Autocom.Free;

     ftabelas.query1.close;
     ftabelas.query1.sql.clear;
     ftabelas.query1.sql.add('commit');
     ftabelas.query1.prepare;
     ftabelas.query1.execsql;

end;

procedure TVPDR.grava_produtos_convenio(xx_cliente:string);
var atual,b:integer;
    produto,quantidade:string;
    acr203:textfile;
    v_codigo, v_quantidade,v_valorun,v_valorto,v_trib,v_funcao,v_data, v_hora:string;
    v_operador,v_banco,v_agencia,v_conta,v_numero,v_cliente,v_indicador,v_CPFCNPJ:string;
    v_Ncp,v_terminal,v_ECF,v_P,v_C,v_Loja:string;
    linha,txt:string;
    co:boolean;
begin

     // parei aki!!
     atual:=0;
     if not fileexists(extractfilepath(application.exename)+'dados\acr203.vnd') then exit;
     try
     AssignFile(acr203, extractfilepath(application.exename)+'dados\acr203.vnd');
     Reset(acr203);
     While not Eof(acr203) do
        begin

           message_info(1,'AGUARDE...');

           readln(acr203,linha);

           v_codigo:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_quantidade:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_valorun:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_valorto:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_trib:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_funcao:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_data:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_hora:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_operador:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_banco:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_agencia:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_conta:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_numero:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_cliente:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_indicador:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_CPFCNPJ:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_Ncp:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_terminal:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_ECF:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_P:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_C:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_Loja:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));

           if (v_funcao=chr(39)+'00'+chr(39)) and (V_C<>chr(39)+'X'+chr(39)) then
              begin
                 while pos(chr(39),v_codigo)>0 do delete(v_codigo,pos(chr(39),v_codigo),1);
                 produto:=v_codigo;
                 while pos(chr(39),v_quantidade)>0 do delete(v_quantidade,pos(chr(39),v_quantidade),1);
                 quantidade:=v_quantidade;
                 quantidade:=floattostr(strtofloat(quantidade)/1000);

                 if strtofloat(xx_cliente)>0 then
                    begin
                       ftabelas.querylog.close;
                       ftabelas.querylog.sql.clear;
                       ftabelas.querylog.sql.add('select * from acr204 where codigo='+xx_cliente+' and produto='+v_codigo);
                       ftabelas.querylog.prepare;
                       ftabelas.querylog.open;
                       try
                          if ftabelas.querylog.fields[0].value>0 then co:=true else co:=false;
                       except
                          co:=false;
                       end;

                       if co=true then
                          begin
                             quantidade:=floattostr(strtofloat(quantidade)+ftabelas.querylog.fieldbyname('saldo').value);
                             txt:='update acr204 set saldo='+TROCA_virgula(quantidade)+' '+
                                            'where codigo='+xx_cliente+' '+
                                            'and produto='+v_codigo;
                          end
                       else
                          begin
                             txt:='insert into acr204(codigo,produto,saldo) values '+
                                            '('+xx_cliente+
                                            ','+v_codigo+
                                            ','+troca_virgula(quantidade)+')';
                          end;
                       ftabelas.query1.close;
                       ftabelas.query1.sql.clear;
                       ftabelas.query1.sql.add(txt);
                       ftabelas.query1.prepare;
                       ftabelas.query1.execsql;

                       ftabelas.query1.close;
                       ftabelas.query1.sql.clear;
                       ftabelas.query1.sql.add('commit');
                       ftabelas.query1.prepare;
                       ftabelas.query1.execsql;
                    end;
              end;
        end;
     finally
        closefile(acr203);
     end;
           message_info(1,'');

end;


procedure TVPDR.cancela_convenio;
var autocom:Tinifile;
begin
     try
        Autocom:=TIniFile.Create(path+'Autocom.INI');
        Autocom.writeString('CONVENIO', 'codigo', '0');
        Autocom.writeString('CONVENIO', 'empresa', '0');
        Autocom.writeString('CONVENIO', 'saldo', '0');
        Autocom.writeString('CONVENIO', 'data', '');
        Autocom.writeString('CONVENIO', 'hora', '');
        Autocom.writeString('CONVENIO', 'operador', '');
        Autocom.writeString('CONVENIO', 'verifica_prod', '');
     finally
        Autocom.Free;
     end;
end;

function TVPDR.Formata_Virgula(texto:string;tipo:integer):string;
Var
virgula: integer;
Begin
     try
        if tipo=2 then texto:=floattostr(strtofloat(texto)/100);
        if tipo=3 then texto:=floattostr(strtofloat(texto)/1000);
     except
        texto:='0';
     end;

     virgula := Pos(',',texto);
     if virgula>0 then
        begin
           delete(texto,virgula,1);
           insert('.',texto,virgula);
        end;

     result:=texto;
End;


function TVPDR.troca_Virgula(texto:string):string;
Var
virgula: integer;
Begin
     virgula := Pos(',',texto);
     if virgula>0 then
        begin
           delete(texto,virgula,1);
           insert('.',texto,virgula);
        end;

     result:=texto;
End;


procedure TVPDR.dados_cheq;
begin
     if banco_cheq='0' then
        begin
           if VLCHQ='0' then Fdadosch.showmodal;
           if VLCHQ='1' then
              begin
                 Fdadoscha.showmodal;
                 if dados_cheq_manual=true then Fdadosch.showmodal;
              end;
        end;
end;

function TVPDR.trata_queda_de_energia:boolean;
var
   estado,ret:string;
   valor_ECF:real;
   subtotalizou:boolean; // indica se o cupom para na totalizaçao ou não
begin
     estado:=flag_venda(3); // verifica a flag gravada

     if estado='0' then
       begin
           teste:=ECF_INF(strtoint(vmodecf),strtoint(vcomecf));
           if copy(teste,9,1)='1' then // cupom aberto
              begin
                 hndl:=LoadLibrary(v_DLL_ECF);
                 if hndl <> 0 then
                    begin
                       @Cancelacupom:= GetProcAddress(hndl, 'Cancelacupom');
                       resposta:=Cancelacupom(strtoint(vmodecf),strtoint(vcomecf),'1','0');
                       FreeLibrary(hndl);
                    end;
              end;
           result:=false;
           exit;
        end;

     if estado='1' then
        begin
           ret:=status_log_atual(vpdvnum,V_num_loja);
           v_total:=0;
           V_quant_total:=0;
           if ret<>'.0/0/0/0/' then
              begin
                 termina_venda;
                 delete(ret,1,1);

                 v_total:=strtofloat(copy(ret,1,pos('/',ret)-1));
                 delete(ret,1,pos('/',ret));

                 V_quant_total:=strtofloat(copy(ret,1,pos('/',ret)-1));
                 delete(ret,1,pos('/',ret));

                 total_recebido:=strtofloat(copy(ret,1,pos('/',ret)-1));
                 delete(ret,1,pos('/',ret));

                 falta_receber:=strtofloat(copy(ret,1,pos('/',ret)-1));
                 delete(ret,1,pos('/',ret));

                 if total_recebido>0 then subtotalizou:=true else subtotalizou:=false;

                 vendendo:=true;
                 Flag_venda(1);
                 hndl:=LoadLibrary(v_DLL_ECF);
                 if hndl <> 0 then
                    begin
                       @Venda_liquida:= GetProcAddress(hndl, 'Venda_liquida');
                       if @Venda_liquida <> nil then
                          begin
                             resposta:=Venda_liquida(strtoint(vmodecf),strtoint(vcomecf));
                          end;
                       FreeLibrary(hndl);
                    end;
                 if copy(resposta,1,1)<>'@' then
                    begin
                       result:=false;
                       message_info(2,resposta);
                    end
                 else
                    begin
                       valor_ECF:=(strtofloat(copy(resposta,2,12))/100);
                       if valor_ecf=v_total then
                          begin
                             if falta_receber>=(1/100) then
                                begin
                                   vendendo:=true;
                                   v_coo:='';
                                   result:=true;
                                end
                             else
                                begin
                                   v_coo:='';
                                   hndl:=LoadLibrary(v_DLL_ECF);
                                   if hndl <> 0 then
                                      begin
                                         @FecharCupom:=GetProcAddress(hndl, 'FecharCupom');
                                         resposta:=FecharCupom(strtoint(vmodecf),strtoint(vcomecf),'0','0',v_l1,v_l2,v_l3,v_l4,v_l5,v_l6,v_l7,v_l8);
                                      end;
                                   if copy(resposta,1,1)='@' then
                                      begin
                                         try
                                            strtofloat(v_coo);
                                         except
                                            v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
                                         end;
                                         grava_log_venda(0,0,floattostrf(V_quant_total,ffnumber,7,3),'0',FLOAttostrf((v_total),ffnumber,12,2),0,'99',Date,Time,cod_operador,'0','0','0','0',0,0,0,v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC203) o fechamento do cupom
                                         total_da_ultima_venda:=v_total;
                                         termina_venda;
                                         grava_convenio;
                                         reorganiza_logs(vpdvnum,V_num_loja);
                                         Flag_venda(2);
                                         vendendo:=false;
                                         result:=true;
                                      end;
                                end;
                          end
                       else
                          begin
                             if copy(ECF_INF(strtoint(vmodecf),strtoint(vcomecf)),5,1)='3' then
                                begin
                                   vendendo:=true;
                                   result:=true;
                                end
                             else
                                begin
                                   if subtotalizou=true then
                                      begin
                                         hndl:=LoadLibrary(v_DLL_ECF);
                                         if hndl <> 0 then
                                            begin
                                               @FecharCupom:=GetProcAddress(hndl, 'FecharCupom');
                                               resposta:=FecharCupom(strtoint(vmodecf),strtoint(vcomecf),'0','0',v_l1,v_l2,v_l3,v_l4,v_l5,v_l6,v_l7,v_l8);
                                            end;
                                         if copy(resposta,1,1)='@' then
                                            begin
                                               try
                                                  strtofloat(v_coo);
                                               except
                                                  v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
                                               end;
                                               grava_log_venda(0,0,floattostrf(V_quant_total,ffnumber,7,3),'0',FLOAttostrf((v_total),ffnumber,12,2),0,'99',Date,Time,cod_operador,'0','0','0','0',0,0,0,v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC203) o fechamento do cupom
                                               total_da_ultima_venda:=v_total;
                                               grava_convenio;
                                               reorganiza_logs(vpdvnum,V_num_loja);
                                               Flag_venda(2);
                                            end;
                                      end;
                                   ex_canv(2);// se os valores não baterem, cancela a venda.
                                   result:=false;
                                end;
                          end;
                    end;
              end
           else
              begin
                 ex_canv(2);// se os valores não baterem, cancela a venda.
                 result:=false;
              end;
           exit;
        end;

     if estado='2' then
        begin
           result:=true;
           termina_venda;
           v_total:=0;
           V_quant_total:=0;
           teste:=ECF_INF(strtoint(vmodecf),strtoint(vcomecf));
           if copy(teste,length(teste),1)='1' then
              begin
                 hndl:=LoadLibrary(v_DLL_ECF);
                 if hndl <> 0 then
                    begin
                       @Cancelacupom:= GetProcAddress(hndl, 'Cancelacupom');
                       resposta:=Cancelacupom(strtoint(vmodecf),strtoint(vcomecf),'1','0');
                       FreeLibrary(hndl);
                    end;
              end;
           exit;
        end;
end;

procedure TVPDR.Visor_descEnter(Sender: TObject);
begin
     edcodigo.enabled:=true;
     edcodigo.setfocus;
end;

procedure TVPDR.trava_mouse(tipo:integer);
var R: TRect;
begin
     if tipo=1 then
        begin
           { Pega o retângulo da área cliente do form }
           screen.cursor:=-1;
           R:=GetClientRect;
           {Converte as coordenadas do form em coordenadas da tela }
           R.TopLeft := ClientToScreen(R.TopLeft);
           R.BottomRight := ClientToScreen(R.TopLeft);
           { Limita a região de movimentação do mouse }
           ClipCursor(@R);
        end;

     if tipo=2 then
        begin
           { Libera a movimentação }
           ClipCursor(nil);
        end;
end;

procedure TVPDR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     fechaarquivos;
     trava_mouse(2);
     IF vmodtec='2' then // caso existe um teclado gertec 65 instalado no PDV
        begin
           strpcopy(Mensagem_display,'        R I M A    A U T O C O M        ');
           hndl:=LoadLibrary('TEC65_32.DLL');
           if hndl <> 0 then
              begin
                 @opentec65:=GetProcAddress(hndl, 'OpenTec65'); // inicializa o display do teclado
                 @CLOSEtec65:=GetProcAddress(hndl, 'CloseTec65'); // finaliza comunicação com o teclado
                 @formfeed:=GetProcAddress(hndl, 'FormFeed'); // limpa o display do teclado
                 @dispstr:=GetProcAddress(hndl, 'DispStr'); // escreve no display do teclado
                 @setdisp:=GetProcAddress(hndl, 'SetDisp'); // ativa o display do teclado
                 if @opentec65 <> nil then opentec65;
                 if @formfeed  <> nil then formfeed;
                 if @setdisp   <> nil then setdisp(1);
                 if @dispstr   <> nil then dispstr(Mensagem_display);
                 if @setdisp   <> nil then setdisp(0);
                 if @closetec65 <> nil then closetec65;
                 FreeLibrary(hndl);
              end;
        end;
end;

function TVPDR.Erro_dlg(tipo:integer;msg:string):string;
var m:array [0..250] of char;
begin
     strpcopy(m,msg);
     if tipo=1 then
        begin
           application.messagebox(m,'AUTOCOM PLUS',MB_OK);
           result:='OK';
        end;

     if tipo=2 then
        begin
           if application.messagebox(m,'AUTOCOM PLUS',MB_YESNO)=mryes then result:='SIM' else result:='NÃO';
        end;
     setforegroundWindow(application.handle);
end;

function TVPDR.strtoformat(texto:string;dec:integer):string;
var babaloo:string;
    factor,a:integer;
begin
     if dec=0 then factor:=1;
     if dec=1 then factor:=10;
     if dec=2 then factor:=100;
     if dec=3 then factor:=1000;
     try
        babaloo:=floattostr(strtofloat(texto)/factor)
     except
        babaloo:=texto;
     end;
     if pos('.',babaloo)>0 then
        begin
           insert(',',babaloo,pos('.',babaloo));
           delete(babaloo,pos('.',babaloo),1);
        end;

     if pos(',',babaloo)>0 then
        begin
           for a:=length(copy(babaloo,pos(',',babaloo),dec+1)) to dec do babaloo:=babaloo+'0';
        end
     else
        begin
           babaloo:=babaloo+',';
           for a:=length(copy(babaloo,pos(',',babaloo),dec+1)) to dec do babaloo:=babaloo+'0';
        end;

     while pos('.',babaloo)>0 do delete(babaloo,pos('.',babaloo),1);

     result:=babaloo;

end;

function TVPDR.capt_coo(p1,p2:integer;p3:string):string;
begin
     hndl:=LoadLibrary(v_DLL_ECF);
     if hndl <> 0 then
        begin
           @COO:= GetProcAddress(hndl, 'COO');
           if @COO <> nil then
              begin
                 resposta:=COO(p1,p2,p3);
              end;
           FreeLibrary(hndl);
        end;
     if copy(resposta,1,1)<>'@' then
        begin
           result:='0000000000';
           message_info(2,resposta);
        end
     else
        begin
           result:=tira_milhar(floattostr(strtofloat(copy(resposta,2,length(resposta)))));
        end;

end;

procedure TVPDR.imprime_cheq;
var conta:integer;
    autocom:Tinifile;
begin
     edcodigo.clear;
     edcodigo.refresh;

     conta:=0;
     while copy(ECF_INF(strtoint(vmodecf),strtoint(vcomecf)),7,1)='0' do
        begin
           message_info(1,'COLOQUE O CHEQUE');
           application.processmessages;
           if conta>=10000 then break;
           conta:=conta+1;
        end;

     imprimindo_cheq:=true;
     refresh;
     edcodigo.enabled:=true;
     edcodigo.setfocus;
     message_info(1,'IMPRIMINDO O CHEQUE...'+CHR(13)+'AGUARDE!');
     refresh;

     autocom:=TIniFile.Create(path+'Autocom.INI');
     hndl:=LoadLibrary(v_DLL_ECF);
     if hndl <> 0 then
        begin
           @cheque:= GetProcAddress(hndl, 'Cheque');
           resposta:=cheque(strtoint(vmodecf),strtoint(vcomecf),banco_cheq,floattostr(valor_recebido),datetostr(date),autocom.ReadString('TERMINAL', 'favorecido', '')+'|'+v_datacheqfina[1],autocom.ReadString('TERMINAL', 'municipio', ''),autocom.ReadString('TERMINAL', 'cifra', ''),autocom.ReadString('TERMINAL', 'moedasing', ''),autocom.ReadString('TERMINAL', 'moedaplur', ''));
           FreeLibrary(hndl);
        end;
     autocom.free;
     if copy(resposta,1,1)<>'@' then
        begin
           message_info(2,resposta);
        end
     else
        begin
           imprimindo_cheq:=false;
        end;
end;


function TVPDR.ECF_inf(p1,p2:integer):string;
begin
     hndl:=LoadLibrary(v_DLL_ECF);
     if hndl <> 0 then
        begin
           @ECF_INFO:=GetProcAddress(hndl, 'ECF_INFO');
           if @ECF_INFO <> nil then
              begin
                 resposta:=ECF_INFO(p1,p2);
              end;
           FreeLibrary(hndl);
        end;

     if (copy(resposta,1,1)<>'@') and (copy(resposta,1,1)<>'!') then
        begin
           Erro_dlg(1,resposta+chr(13)+'Impressora fiscal não detectada. O módulo será abortado!');
           fechaarquivos; //dia 27/08/2002 - por Helder Frederico: Fecha a conexão com o banco de dados antes de sair do programa.
           close;
        end
     else
        begin
           result:=copy(resposta,2,length(resposta));
        end;

end;

function TVPDR.emite_leit_x:boolean;
begin
     message_info(1,'LEITURA X'+chr(13)+'AGUARDE...');
     refresh;
     edcodigo.enabled:=false;

     hndl:=LoadLibrary(v_DLL_ECF);
     if hndl <> 0 then
        begin
           @lEITURAX:= GetProcAddress(hndl, 'LeituraX');
           if @Leiturax <> nil then
              begin
                 resposta:=LeituraX(strtoint(vmodecf),strtoint(vcomecf),'0');
              end;
           FreeLibrary(hndl);
        end;
     if (copy(resposta,1,1)<>'@') and (copy(resposta,1,1)<>'!') then
        begin
           message_info(2,resposta);
           result:=false;
        end
     else
        begin
           result:=true;
        end;
end;

function TVPDR.emite_redu_z:boolean;
begin
     message_info(1,'REDUCAO Z'+chr(13)+'AGUARDE...');
     refresh;
     edcodigo.enabled:=false;


     application.processmessages;
     teste:=ECF_INF(strtoint(vmodecf),strtoint(vcomecf));
     try
        strtofloat(v_coo);
     except
        v_coo:=capt_coo(strtoint(vmodecf),strtoint(vcomecf),'1');
     end;
     v_coo:=inttostr(strtoint(v_coo)+1);
     grava_log_venda(0,0,'0',copy(teste,22,4),'0',0,'98',Date,Time,cod_operador,'0',copy(teste,50,12),copy(teste,26,12),copy(teste,38,12),0,strtofloat(copy(teste,10,6)),strtofloat(copy(teste,16,6)),v_coo,num_ecf,vpdvnum,strtofloat(V_num_loja)); // grava no log (AC203) os dados referente a redução Z


     hndl:=LoadLibrary(v_DLL_ECF);
     if hndl <> 0 then
        begin
           @Finalizadia:= GetProcAddress(hndl, 'Finalizadia');
           if @Finalizadia <> nil then
              begin
                 resposta:=Finalizadia(strtoint(vmodecf),strtoint(vcomecf));
              end;
           FreeLibrary(hndl);
        end;
     if (copy(resposta,1,1)<>'@') and (copy(resposta,1,1)<>'!') then
        begin
           message_info(2,resposta);
           result:=false;
        end
     else
        begin
           result:=true;
        end;
end;


function TVPDR.iniciododia:boolean;
var m: array [1..10] of string;
    a: integer;
begin
     message_info(1,'ABRINDO O CAIXA'+chr(13)+'AGUARDE...');
     refresh;
     edcodigo.enabled:=false;

     for a:=1 to 10 do m[a]:='';

     if ftabelas.tbl_formafaturamento.isempty=true then
        begin
           message_info(2,'É necessário cadastrar as formas de pagamento.');
           result:=false;
        end
     else
        begin
           a:=1;
           ftabelas.tbl_formafaturamento.first;
           while not ftabelas.tbl_formafaturamento.eof do
              begin
                 if ftabelas.tbl_formafaturamento.fieldbyname('codigoformafaturamento').value<=10 then
                    begin
                       m[a]:=FTABELAS.tbl_formafaturamento.fieldbyname('formafaturamento').value+'|';
                       a:=a+1;
                    end;
                 ftabelas.tbl_formafaturamento.next;
              end;

           hndl:=LoadLibrary(v_DLL_ECF);
           if hndl <> 0 then
              begin
                 @iniciodia:= GetProcAddress(hndl, 'InicioDia');
                 if @iniciodia <> nil then
                    begin
                       resposta:=InicioDia(strtoint(vmodecf),strtoint(vcomecf),'0','0',m[1]+m[2]+m[3]+m[4]+m[5]+m[6]+m[7]+m[8]+m[9]+m[10]);
                    end;
                 FreeLibrary(hndl);
              end;
           if copy(resposta,1,1)<>'@' then
              begin
                 message_info(2,resposta);
                 result:=false;
              end
           else
              begin
                 result:=true;
              end;
        end;
end;

function TVPDR.tira_milhar(m:string):string;
begin
     while pos('.',m)>0 do delete(m,pos('.',m),1);
     result:=m;
end;


procedure TVPDR.mEnter(Sender: TObject);
begin
     edcodigo.setfocus;
end;


procedure TVPDR.dados_conveniado;
var texto:string;
    t,u:array[1..7] of string;
    v_conv:aRRAY [1..20] of string; // vator para as linhas de comprovante de convenio

    a:integer;
    autocom:Tinifile;
begin
     message_info(1,'Aguarde... Imprimindo'+chr(13)+'nota promissoria');
     texto:=extenso(v_total);
     for a:=1 to 4 do
        begin
           t[a]:=copy(texto,1,40);
           delete(texto,1,40);
        end;

     autocom:=TIniFile.Create(path+'Autocom.INI');
     texto:='Eu, '+trim(NOME_cliente)+', '+autocom.ReadString('TERMINAL', 'nptexto', '')+' :'+'referente a aquisicao de produtos na loja '+autocom.ReadString('LOJA', 'LojaNome', '');
     autocom.free;
     for a:=1 to 7 do
        begin
           u[a]:=copy(texto,1,40);
           delete(texto,1,40);
        end;



     v_conv[1]:='            NOTA PROMISSORIA            ';
     v_conv[2]:='';
     v_conv[3]:=u[1];
     v_conv[4]:=u[2];
     v_conv[5]:=u[3];
     v_conv[6]:=u[4];
     v_conv[7]:=u[5];
     v_conv[8]:=u[6];
     v_conv[9]:=u[7];
     v_conv[10]:=floattostrf(v_total,ffcurrency,12,2);
     v_conv[11]:=t[1];
     v_conv[12]:=t[2];
     v_conv[13]:=t[3];
     v_conv[14]:=t[4];
     v_conv[15]:='                                      ';
     v_conv[16]:='    ';
     v_conv[17]:='Ass.:-----------------------------------';
     v_conv[18]:='Nome....: '+NOME_cliente;
     v_conv[19]:='Codigo..: '+floattostr(codigo_conveniado);
     v_conv[20]:='Empresa.: '+floattostr(codemp_conveniado);

     hndl:=LoadLibrary(v_DLL_ECF);
     if hndl <> 0 then
        begin
           cnfv:=GetProcAddress(hndl, 'cnfv');
           if @cnfv <> nil then
              begin
                 resposta:=cnfv(strtoint(vmodecf),strtoint(vcomecf));
              end;
           FreeLibrary(hndl);
        end;

     for a:=1 to 17 do
        begin
           hndl:=LoadLibrary(v_DLL_ECF);
           if hndl <> 0 then
              begin
                 TextoNF:=GetProcAddress(hndl, 'TextoNF');
                 if @TextoNF <> nil then
                    begin
                       resposta:=TextoNF(strtoint(vmodecf),strtoint(vcomecf),v_conv[a],'');
                    end;
                 FreeLibrary(hndl);
              end;
        end;

     hndl:=LoadLibrary(v_DLL_ECF);
     if hndl <> 0 then
        begin
           FecharCupom:=GetProcAddress(hndl, 'FecharCupom');
           if @FecharCupom <> nil then
              begin
                 resposta:=FecharCupom(strtoint(vmodecf),strtoint(vcomecf),'0','0','','','','','','','','');
              end;
           FreeLibrary(hndl);
        end;
end;


// inicio da rotina de impressão de extenso por um numero
function TVPDR.extenso(valor: real): string;
var
   Centavos, Centena, Milhar, Milhao, Texto: string;
const
     Unidades: array[1..9] of string = ('Um', 'Dois', 'Tres','Quatro', 'Cinco', 'Seis', 'Sete','Oito', 'Nove');
     Dez: array[1..9] of string = ('Onze', 'Doze', 'Treze','Quatorze','Quinze','Dezesseis', 'Dezessete','Dezoito','Dezenove');
     Dezenas: array[1..9] of string = ('Dez', 'Vinte', 'Trinta','Quarenta','Cinquenta', 'Sessenta','Setenta','Oitenta', 'Noventa');
     Centenas: array[1..9] of string = ('Cento', 'Duzentos','Trezentos','Quatrocentos','Quinhentos','Seiscentos','Setecentos', 'Oitocentos','Novecentos');

function ifs(Expressao: Boolean; CasoVerdadeiro, CasoFalso:String): String;
begin
     if Expressao then Result:=CasoVerdadeiro  else Result:=CasoFalso;
end;

function MiniExtenso (trio: string): string;
var
   Unidade, Dezena, Centena: string;
begin
     Unidade:='';
     Dezena:='';
     Centena:='';
     if (trio[2]='1') and (trio[3]<>'0') then
        begin
           Unidade:=Dez[strtoint(trio[3])];
           Dezena:='';
        end
     else
        begin
           if trio[2]<>'0' then Dezena:=Dezenas[strtoint(trio[2])];
           if trio[3]<>'0' then Unidade:=Unidades[strtoint(trio[3])];
        end;

     if (trio[1]='1') and (Unidade='') and (Dezena='') then
        begin
           Centena:='cem';
        end
     else
        begin
           if trio[1]<>'0' then Centena:=Centenas[strtoint(trio[1])]  else Centena:='';
        end;
     Result:= Centena + ifs((Centena<>'') and ((Dezena<>'') or (Unidade<>'')), ' e ', '') + Dezena + ifs((Dezena<>'') and (Unidade<>''),' e ', '') +Unidade;
end;

begin
     if (valor>999999.99) or (valor<=0) then
        begin
//           msg:='O valor está fora do intervalo permitido.';
//           msg:=msg+'O número deve ser maior ou igual a zero e menor que 999.999,99.';
//           msg:=msg+' Se não for corrigido o número não será escrito por extenso.';
//           showmessage(msg);
           Result:='';
           exit;
        end;
     Texto:=formatfloat('000000.00',valor);
     Milhar:=MiniExtenso(Copy(Texto,1,3));
     Centena:=MiniExtenso(Copy(Texto,4,3));
     Centavos:=MiniExtenso('0'+Copy(Texto,8,2));
     Result:=Milhar;
     if Milhar<>'' then
     if copy(texto,4,3)='000' then Result:=Result+' Mil Reais' else Result:=Result+' Mil, ';

     if (((copy(texto,4,2)='00') and (Milhar<>'') and (copy(texto,6,1)<>'0')) or (centavos='')) and (Centena<>'') then Result:=Result+' e';
     if (Milhar+Centena <>'') then Result:=Result+Centena;
     if (Milhar='') and (copy(texto,4,3)='001') then
        begin
           Result:=Result+' Real'
        end
     else
        begin
           if (copy(texto,4,3)<>'000') then Result:=Result+' Reais';
        end;

     if Centavos='' then
        begin
           Result:=Result+'.';
           Exit;
        end
     else
        begin
           if Milhar+Centena='' then Result:=Centavos else Result:=Result+', e '+Centavos;
           if (copy(texto,8,2)='01') and (Centavos<>'') then Result:=Result+' Centavo.' else Result:=Result+' Centavos.';
        end;
end;
// fim da rotina de impressão de extenso por um numero


function TVPDR.peso(tipo,porta:string):string;
var ps:string;
begin
//     ps:=captura_peso(tipo,porta);
     ps:='0,000';
     try
        ps:=floattostrf(strtofloat(ps)/1000,ffnumber,8,3);
     except
        ps:='0,000';
     end;
end;



procedure TVPDR.display;
var
   mascara_senha:string;
begin
     IF (vmodtec='2') then // caso existe um teclado gertec 65 instalado no PDV
        begin
           hndl:=LoadLibrary('TEC65_32.DLL');
           if hndl <> 0 then
              begin
                 @opentec65:=GetProcAddress(hndl, 'OpenTec65'); // inicializa o display do teclado
                 @dispstr:=GetProcAddress(hndl, 'DispStr'); // escreve no display do teclado
                 @gotoxy:=GetProcAddress(hndl, 'GoToXY');
                 @setdisp:=GetProcAddress(hndl, 'SetDisp'); // ativa o display do teclado
                 opentec65;
                 setdisp(1);
                 if (Consulta_plu=true) or (linha_display=2) then coluna_display:=1 else coluna_display:=length(info.caption)+1; // essa consistência é feita para que, quando
                                                                                                          //o sistema estiver na tela de consulta produto
                                                                                                     //o cursor volte para a posição 1,1 do display,
                                                                                                          //igual na venda de produtos, caso contrário, o
                                                                                                          //sistema vai levar em conta o descritivo "Consulta produto"
                                                                                                          //para calcular a coluna inical do display, cortando o descritivo
                                                                                                          //do produto.
                 gotoxy(linha_display,coluna_display);
                 if pos('SENHA',info.caption)>0 then // quando for necessário digitar a senha, o programa mascara
                    begin
                       while length(v_edcodigo)>length(mascara_senha) do mascara_senha:=mascara_senha+'*';
                       while length(v_edcodigo)<length(mascara_senha) do mascara_senha:='*';
                       strpcopy(Mensagem_display,mascara_senha);
                    end
                 else
                    begin
                       if Consulta_plu=true then strpcopy(Mensagem_display,enche(visor_desc.text,' ',2,40-coluna_display)) else strpcopy(Mensagem_display,enche(v_edcodigo,' ',2,40-coluna_display));
                    end;

                 if tela_venda.visible=true then
                    begin
                       if sub_total=false then dispstr(Mensagem_display);
                    end
                 else
                    begin
                       if (length(info.caption)>0) then dispstr(Mensagem_display);
                    end;

                 setdisp(0);
                 FreeLibrary(hndl);
              end;
        end;
end;

procedure TVPDR.edcodigoChange(Sender: TObject);
begin
     display;
end;

procedure TVPDR.display_torre(texto:string;func,x,y:integer);
var ini_torre:Tinifile;
    porta_torre:string;
    aceita_torre:string;
    device:string;
begin
     ini_torre:=TIniFile.Create(path+'Autocom.ini');
     porta_torre:=ini_torre.readstring('TERMINAL','COMdisptorre','1');
     aceita_torre:=ini_torre.readstring('TERMINAL','Disptorre','0');
     ini_torre.free;
     if aceita_torre='1' then
        begin
           if func=0 then // limpa display;
              begin
                 device:='COM'+porta_torre;
                 torre.port:=device;
                 torre.open;
                 torre.WriteStr(chr(12));
                 torre.close;

              end;
           if func=1 then // escreve no display
              begin
                 device:='COM'+porta_torre;
                 torre.port:=device;
                 torre.open;
                 torre.WriteStr(chr(09)+chr(x)+chr(y));
                 torre.WriteStr(texto);
                 torre.close;

              end;
        end;
end;



procedure TVPDR.balRxChar(Sender: TObject; Count: Integer);
VAR TEST:STRING;
begin
     BAL.ReadStr(test,count);
     if MandouResposta_bAL Then Exit;
     if test<>sufix_bAL then
        begin
           resp_bAL:=resp_bAL+test;
           MandouResposta_bAL:=false;
           exit;
        end
     else MandouResposta_bAL:=True; // Se veio o SUFIXO então é o fim da resposta
end;

function TVPDR.captura_peso(tipo,porta:string):shortstring;
VAR resposta_bAL:string;
begin
    if tipo='1' then// fillizola/toledo
       begin
          Comando_bAL:=Chr(5);
          bal.baudrate:=br2400;
          bal.databits:=dbEight;
          bal.port:='COM'+porta;
          bal.parity.bits:=prNone;
          bal.stopbits:=sbOneStopBit;
          sufix_bAL:=chr(3);
          prefix_bAL:=chr(2);
       end;


    if tipo='2' then // magellan
       begin
          Comando_bAL:='W';
          bal.baudrate:=br9600;
          bal.databits:=dbseven;
          bal.port:='COM'+porta;
          bal.parity.bits:=prEven;
          bal.stopbits:=sbOneStopBit;
          sufix_bAL:=chr(13);
          prefix_bAL:=chr(2);
       end;

    try
       bal.open;
       resposta_bAL:=enviacomando_bAL(COMANDO_bAL);
    finally
       bal.close;
    end;
    result:=resposta_bAL;
end;


Function TVPDR.EnviaComando_bAL(Texto1:string):shortSTRING;
var
    Present: TDateTime;
    Hour, Min, Minuto, SEc, Segundo,MSec,Valor1,Valor2: Word;
    tempo:integer;
begin
     Tempo:=5;   // Caso não existe assume TimeOUt=10 segundos
     MandouResposta_bAL:=False;    // Inicializa as variáveis de memória
     try
        bal.WriteStr(texto1);
     except
        result:='0000';
        resp_bAL:='';
        EXIT;
     end;
     Present:= Now;                              // Zera o relógio para contar o timeout de recepção
     DecodeTime(Present, Hour, Min, Sec, MSec);  // Captura a hora atual
     while not MandouResposta_bAL do // fica aguardando uma resposta da balança
        begin
          application.processmessages;
          Present:= Now;
          application.processmessages;
          DecodeTime(Present, Hour, Minuto, Segundo, MSec);// Captura nova hora
          application.processmessages;
          Valor1:=(Minuto*60)+Segundo;
          application.processmessages;
          Valor2:=(Min*60)+sec;
          application.processmessages;
          if (Valor1-Valor2>Tempo) Then // Verifica se estourou o timeout de recepção
             begin
               MandouResposta_bAL:=True;
               result:='0000';
               resp_bAL:='';
               EXIT;
             end;
          application.processmessages;
        end;

     if (comando_bAL='W') then
        begin
           COMANDO_bAL:=copy(resp_bAL,2,length(resp_bAL)-1);
           if copy(resp_bAL,2,length(resp_bAL)-1)='?B' then COMANDO_bAL:='0000';//'sobrecarga';
           if copy(resp_bAL,2,length(resp_bAL)-1)='?A' then COMANDO_bAL:='0000';//instabilidade';
           if copy(resp_bAL,2,length(resp_bAL)-1)='?D' then COMANDO_bAL:='0000';//peso neganivo';
           if copy(resp_bAL,2,length(resp_bAL)-1)='?C' then COMANDO_bAL:='0000';//sobre carga + instabilidade';
        end;
     if (comando_bAL=chr(5)) then
        begin
           COMANDO_bAL:=copy(resp_bAL,2,length(resp_bAL)-1);
           if copy(resp_bAL,2,length(resp_bAL)-1)='SSSSS' then COMANDO_bAL:='0000';
           if copy(resp_bAL,2,length(resp_bAL)-1)='IIIII' then COMANDO_bAL:='0000';
           if copy(resp_bAL,2,length(resp_bAL)-1)='NNNNN' then COMANDO_bAL:='0000';
        end;

     resp_bal:='';
     result:=COMANDO_bAL;
end;


function TVPDR.verifica_quantidade:boolean;
var xx_codigo:array [0..10000] of string;
    xx_quantidade:array [0..10000] of real;
    xx_a:integer;

    acr203:textfile;
    v_codigo, v_quantidade,v_valorun,v_valorto,v_trib,v_funcao,v_data, v_hora:string;
    v_operador,v_banco,v_agencia,v_conta,v_numero,v_cliente,v_indicador,v_CPFCNPJ:string;
    v_Ncp,v_terminal,v_ECF,v_P,v_C,v_Loja:string;
    linha,nome_do_produto:string;

    quant_giro,saldo:real;
begin
     for xx_a:=0 to 10000 do
        begin
           xx_codigo[xx_a]:='';
           xx_quantidade[xx_a]:=0;
        end;

     AssignFile(acr203, extractfilepath(application.exename)+'dados\acr203.vnd');
     Reset(acr203);
     While not Eof(acr203) do
        Begin
           readln(acr203,linha);
           v_codigo:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_quantidade:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_valorun:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_valorto:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_trib:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_funcao:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_data:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_hora:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_operador:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_banco:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_agencia:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_conta:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_numero:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_cliente:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_indicador:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_CPFCNPJ:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_Ncp:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_terminal:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_ECF:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_P:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_C:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));
           v_Loja:=copy(linha,1,pos('|',linha)-1);
           delete(linha,1,pos('|',linha));

           while pos(chr(39),v_funcao)>0 do delete(v_funcao,pos(chr(39),v_funcao),1);
           while pos(chr(39),v_c)>0 do delete(v_c,pos(chr(39),v_c),1);
           while pos(chr(39),v_quantidade)>0 do delete(v_quantidade,pos(chr(39),v_quantidade),1);
           while pos(chr(39),v_codigo)>0 do delete(v_codigo,pos(chr(39),v_codigo),1);

           if (v_funcao='00') and (v_c<>'X') then
              begin
                 for xx_a:=0 to 10000 do
                    begin
                       if xx_codigo[xx_a]='' then
                          begin
                             xx_codigo[xx_a]:=v_codigo;
                             xx_quantidade[xx_a]:=strtofloat(v_quantidade)/1000;
                             break;
                          end
                       else
                          begin
                             if xx_codigo[xx_a]=v_codigo then
                                begin
                                   xx_quantidade[xx_a]:=xx_quantidade[xx_a]+(strtofloat(v_quantidade)/1000);
                                   break;
                                end;
                          end;
                    end;
              end;
        End;
     CloseFile(acr203);
     for xx_a:=0 to 10000 do
        begin
           if xx_codigo[xx_a]<>'' then
              begin
                 ftabelas.query1.close;
                 ftabelas.query1.sql.clear;
                 ftabelas.query1.sql.add('select descricao,giro from acr102 where codigo='+xx_codigo[xx_a]);
                 ftabelas.query1.prepare;
                 ftabelas.query1.open;
                 nome_do_produto:=ftabelas.query1.fieldbyname('descricao').value;
                 try
                    quant_giro:=ftabelas.query1.fieldbyname('giro').value;
                 except
                    quant_giro:=0;
                 end;

                 if xx_quantidade[xx_a]>quant_giro then // verifica se a quantidade comprada é maior do que estipulado  no cadastro
                    begin
                       linha_display:=1;
                       messagedlg('A QUANTIDADE DO PRODUTO '+XX_CODIGO[XX_A]+' - ['+TRIM(nome_do_produto)+'] EXCEDEU O LIMITE DE '+floatTOstr(QUANT_GIRO)+'.'+CHR(13)+'SERA NECESSARIO CANCELAR ALGUNS ITENS DESTA VENDA!',mtinformation,[mbok],0);
                       message_info(2,'PRODUTO EXCEDEU O LIMITE DE QUANTIDADE');
                       result:=false;
                    end
                 ELSE // se não for maior, vai comparar com o historico de compras do cliente
                    begin
                       ftabelas.query1.close;
                       ftabelas.query1.sql.clear;
                       ftabelas.query1.sql.add('select * from acr204 where codigo='+floattostr(codigo_conveniado)+' and produto='+xx_codigo[xx_a]);
                       ftabelas.query1.prepare;
                       ftabelas.query1.open;

                       try
                          saldo:=ftabelas.query1.fieldbyname('saldo').value;
                       except
                          saldo:=0;
                       end;

                       if (xx_quantidade[xx_a]+saldo)>quant_giro then
                          begin
                             linha_display:=1;
                             messagedlg('A QUANTIDADE DO PRODUTO '+XX_CODIGO[XX_A]+' - ['+TRIM(nome_do_produto)+'], EXCEDEU A QUANTIDADE LIMITE DE '+floatTOstr(QUANT_GIRO)+'.'+CHR(13)+'SERA NECESSARIO CANCELAR ALGUNS ITENS DESTA VENDA!'+chr(13)+'SALDO ATUAL DO PRODUTO ADQUIRIDO: '+FLOATTOSTR(saldo)+chr(13)+'QUANTIDADE ADQUIRIDA DO PRODUTO NESTA VENDA: '+FLOATTOSTR(xx_quantidade[xx_a]),mtinformation,[mbok],0);
                             message_info(2,'PRODUTO EXCEDEU O LIMITE DE QUANTIDADE');
                             result:=false;
                          end
                       ELSE
                          begin
                             result:=true;
                          end;
                    end;
              end;
        end;

end;

end.
