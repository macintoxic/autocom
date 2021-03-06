unit Par;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ComCtrls, ExtCtrls, IniFiles, Db, DBTables, Mask, DBIProcs,
  Menus, registry, IBCustomDataSet, IBTable, IBDatabase, IBQuery;
const
     max_opc=500; // M?ximo de op??es existentes no sistema;
     max_opc_teclado=300; // M?ximo de op??es existentes no sistema para a programa??o de fun??es no lay-out do teclado.

type
  TPARAMETRO = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel5: TPanel;
    edPDVN: TEdit;
    edmodECF: TEdit;
    BitBtn6: TBitBtn;
    edcomecf: TComboBox;
    PageControl3: TPageControl;
    TabSheet4: TTabSheet;
    Label10: TLabel;
    mcl1: TEdit;
    mcl2: TEdit;
    mcl3: TEdit;
    mcl4: TEdit;
    mcl5: TEdit;
    mcl6: TEdit;
    mcl7: TEdit;
    mcl8: TEdit;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    Label5: TLabel;
    Label4: TLabel;
    edscnr: TComboBox;
    Panel3: TPanel;
    edcomSCN: TComboBox;
    Label27: TLabel;
    cbtec: TComboBox;
    teclado1: TPanel;
    t1_112: TButton;
    t1_27: TButton;
    t1_113: TButton;
    t1_114: TButton;
    t1_115: TButton;
    t1_116: TButton;
    t1_117: TButton;
    t1_118: TButton;
    t1_119: TButton;
    t1_120: TButton;
    t1_121: TButton;
    t1_122: TButton;
    t1_123: TButton;
    button14: TButton;
    button15: TButton;
    Button16: TButton;
    t1_192: TButton;
    Button18: TButton;
    Button19: TButton;
    Button20: TButton;
    Button21: TButton;
    Button22: TButton;
    Button23: TButton;
    Button24: TButton;
    Button25: TButton;
    t1_187: TButton;
    t1_189: TButton;
    Button28: TButton;
    Button29: TButton;
    Button30: TButton;
    t1_45: TButton;
    t1_36: TButton;
    t1_33: TButton;
    t1_46: TButton;
    t1_35: TButton;
    t1_34: TButton;
    t1_221: TButton;
    t1_219: TButton;
    t1_80: TButton;
    t1_79: TButton;
    t1_73: TButton;
    t1_85: TButton;
    t1_89: TButton;
    t1_84: TButton;
    t1_82: TButton;
    t1_69: TButton;
    t1_87: TButton;
    t1_81: TButton;
    t1_222: TButton;
    t1_186: TButton;
    t1_76: TButton;
    t1_75: TButton;
    t1_74: TButton;
    t1_72: TButton;
    t1_71: TButton;
    t1_70: TButton;
    t1_68: TButton;
    t1_83: TButton;
    t1_65: TButton;
    t1_191: TButton;
    button2: TButton;
    button1: TButton;
    t1_78: TButton;
    t1_77: TButton;
    t1_66: TButton;
    t1_86: TButton;
    t1_67: TButton;
    t1_88: TButton;
    t1_90: TButton;
    Button49: TButton;
    Button71: TButton;
    Button72: TButton;
    Button73: TButton;
    Button74: TButton;
    Button75: TButton;
    Button76: TButton;
    t1_220: TButton;
    Button78: TButton;
    Button79: TButton;
    t1_32: TButton;
    t1_38: TButton;
    t1_37: TButton;
    t1_40: TButton;
    t1_39: TButton;
    b21: TButton;
    t1_111: TButton;
    t1_106: TButton;
    t1_109: TButton;
    button3: TButton;
    button4: TButton;
    button5: TButton;
    button6: TButton;
    button7: TButton;
    button8: TButton;
    t1_107: TButton;
    button9: TButton;
    button10: TButton;
    button11: TButton;
    Button99: TButton;
    button13: TButton;
    button12: TButton;
    lbteclado: TListBox;
    Botao_limpa: TBitBtn;
    edppi: TMaskEdit;
    insertPPI: TBitBtn;
    PageControl2: TPageControl;
    TabSheet5: TTabSheet;
    TabSheet8: TTabSheet;
    Panel7: TPanel;
    Label16: TLabel;
    edtLimFcx: TMaskEdit;
    Panel8: TPanel;
    Label17: TLabel;
    edtLimSangria: TMaskEdit;
    Panel9: TPanel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    edtAcrevft: TMaskEdit;
    edtLimAcrept: TMaskEdit;
    edtAcrepft: TMaskEdit;
    Panel10: TPanel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    edtDescvf: TMaskEdit;
    edtLimdsp: TMaskEdit;
    edtDescpf: TMaskEdit;
    GroupBox2: TGroupBox;
    Label15: TLabel;
    edtModSingular: TEdit;
    Label14: TLabel;
    edtModPlural: TEdit;
    edtCifra: TEdit;
    Label13: TLabel;
    Label12: TLabel;
    edtFavorecido: TEdit;
    edtMunicipio: TEdit;
    Label11: TLabel;
    Panel4: TPanel;
    edlcheq: TComboBox;
    Label7: TLabel;
    TabSheet10: TTabSheet;
    Label9: TLabel;
    edind: TComboBox;
    Panel6: TPanel;
    teclado2: TPanel;
    t2_113: TButton;
    t2_112: TButton;
    t2_114: TButton;
    t2_115: TButton;
    t2_116: TButton;
    t2_117: TButton;
    t2_118: TButton;
    t2_119: TButton;
    t2_120: TButton;
    t2_121: TButton;
    Button38: TButton;
    t2_189: TButton;
    t2_187: TButton;
    bt2_57: TButton;
    bt2_56: TButton;
    bt2_55: TButton;
    t2_80: TButton;
    t2_79: TButton;
    t2_73: TButton;
    t2_85: TButton;
    t2_89: TButton;
    t2_84: TButton;
    t2_82: TButton;
    t2_69: TButton;
    t2_87: TButton;
    t2_81: TButton;
    bt2_54: TButton;
    bt2_53: TButton;
    bt2_52: TButton;
    t2_186: TButton;
    t2_76: TButton;
    t2_75: TButton;
    t2_74: TButton;
    t2_72: TButton;
    t2_71: TButton;
    t2_70: TButton;
    t2_68: TButton;
    t2_83: TButton;
    t2_65: TButton;
    bt2_51: TButton;
    bt2_50: TButton;
    bt2_49: TButton;
    Button80: TButton;
    botao: TButton;
    t2_77: TButton;
    t2_78: TButton;
    t2_66: TButton;
    t2_86: TButton;
    t2_67: TButton;
    t2_88: TButton;
    t2_90: TButton;
    t2_191: TButton;
    t2_220: TButton;
    bt2_48: TButton;
    Button92: TButton;
    t2_27: TButton;
    t2_32: TButton;
    t2_39: TButton;
    t2_37: TButton;
    t2_40: TButton;
    t2_38: TButton;
    Button101: TButton;
    Button102: TButton;
    GroupBox3: TGroupBox;
    Label18: TLabel;
    edpathexp: TEdit;
    Label19: TLabel;
    edpathimpprod: TEdit;
    GroupBox4: TGroupBox;
    bhv: TBitBtn;
    Label21: TLabel;
    edgaveta: TComboBox;
    Panel11: TPanel;
    Label30: TLabel;
    edfechagaveta: TComboBox;
    Panel13: TPanel;
    transacao: TIBTransaction;
    dbautocom: TIBDatabase;
    teclado: TIBTable;
    query: TIBQuery;
    Label6: TLabel;
    cmb_disptorre: TComboBox;
    Label8: TLabel;
    cmb_COMDisptorre: TComboBox;
    Panel12: TPanel;
    Label20: TLabel;
    cmb_obrigaind: TComboBox;
    Panel14: TPanel;
    Label22: TLabel;
    cmb_comgaveta: TComboBox;
    GroupBox1: TGroupBox;
    chk_usaservico: TCheckBox;
    Label26: TLabel;
    txt_valorservico: TMaskEdit;
    Label28: TLabel;
    txt_percentualservico: TMaskEdit;
    Label29: TLabel;
    txt_nptexto: TEdit;
    tecladoCODIGO_FUNCAO: TIBStringField;
    tecladoCFG_CODCONFIG: TIntegerField;
    tecladoTERMINAL: TIBStringField;
    tecladoTIPO: TIBStringField;
    tecladoTECLA: TIntegerField;
    tecladoABREV: TIBStringField;
    tecladoCODIGOPRODUTO: TIntegerField;
    tecladoOID: TIntegerField;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure edPDVNExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtLimFcxExit(Sender: TObject);
    procedure edtLimSangriaExit(Sender: TObject);
    procedure edtAcrevftExit(Sender: TObject);
    procedure edtDescvfExit(Sender: TObject);
    procedure edtLimAcreptExit(Sender: TObject);
    procedure edtAcrepftExit(Sender: TObject);
    procedure edtLimdspExit(Sender: TObject);
    procedure edtDescpfExit(Sender: TObject);
    procedure edtLpzArquivoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure n1Click(Sender: TObject);
    procedure cbtecChange(Sender: TObject);
    procedure t1_27Click(Sender: TObject);
    procedure lbtecladoDblClick(Sender: TObject);
    procedure lbtecladoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbtecladoExit(Sender: TObject);
    procedure Botao_limpaClick(Sender: TObject);
    procedure edppiKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure insertPPIClick(Sender: TObject);
    procedure edppiEnter(Sender: TObject);
    procedure PARsistAfterPost(DataSet: TDataSet);
    procedure TecladoAfterPost(DataSet: TDataSet);
    procedure bhvClick(Sender: TObject);
    procedure TabSheet2Enter(Sender: TObject);
    procedure chk_usaservicoClick(Sender: TObject);
    procedure txt_valorservicoExit(Sender: TObject);
    procedure txt_percentualservicoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

    vpdvnum,vmodecf,vmodtec,vcomecf,vscnr,vCOMSCNR,modo_opera,VLCHQ,tipo_indicador,dll_do_ecf:string;
    vatrbl1,vatrbl2,vatrbl3,vatrbl4,vatrbl5,v_gaveta,v_fechagaveta:string;

    //v_filepath,v_nomeprodimp,v_HV:string;
    v_fileimp,v_fileexp,v_HV:string;


    vcatrbl1,vcatrbl2,vcatrbl3,vcatrbl4,vcatrbl5,vcatrbl6,vcatrbl7,vcatrbl8:string;
    vcl1,vcl2,vcl3,vcl4,vcl5,vcl6,vcl7,vcl8:string;

    v_displaytorre, v_displaytorreCOM, v_Obrigaind, v_COMGaveta, v_usaservico:string;


    Nome_opc,Aces_opc,linha_opc,Tipo_opc,Mod_opc,ABrv_opc: array[1..max_opc] of string; // op??es armazenas no ACFUNC.CAT
    cod_opc: array [1..max_opc] of integer; // op??o armazenada no ACFUNC.CAT.

    tecla_code_func: array [0..max_opc_teclado] of integer; // este vetor contem o c?digo da fun??o programada no teclado. cada indice correnponde ao codigo ASCII de cada tecla.
    tecla_name_func: array [0..max_opc_teclado] of string;  // este vetor cont?m o nome da fun??o programada no teclado. Cada indice correnponde ao codigo ASCII de cada tecla.
    tecla_resu_func: array [0..max_opc_teclado] of string;  // este vetor cont?m o nome resumido da fun??o programada no teclado. Cada indice correnponde ao codigo ASCII de cada tecla.
    tecla_PPIC_func: array [0..max_opc_teclado] of real;    // este vetor comt?m o c?digo PPI fa fun??o PPI programada no teclado. Cada indica correnponde ao c?digo ASCII de cada tecla.

    procedure carregaini;         // Carrega os valores do arquivo RMPAR.INI
    procedure gravaini;           // Grava os valores no arquivo RMPAR.INI
    procedure Atualizacampos;     // armazena os valores das variaveis nos respectivos campos.
    procedure Atualizavariaveis;  // armazena os valores dos campos nas respectivas variaveis.
    function verificaerros:boolean;      // Realiza a consistencia do conteudo dos campos.
    function ModeloECF(indice:integer):string; // retorna o valor do vetor de modelos de ECFs.
    function DLLECF(indice:integer):string; // retorna o nome das dll referente a cada modelo de ECF.
    function Enche(texto,caracter:string;lado,tamanho:integer):string;
    procedure Abrearquivos;    // abre os arquivo de banco de dados
    function retiraNB(texto:string):string;
    function retira(texto,caracter:string):string;
    function mascara_valor(texto:string;tamanho:integer;bit:string):string;
    procedure monta_teclado(painel:string); // monta o lay-out do teclado na tela, de acordo com o tipo de teclado selecionado.
    procedure monta_menu_teclado; // Monta o menu de fun??es program?veis no teclado.
    procedure Marca_opc; // Marca a tecla com a op??o slecionada.
    procedure Descarta_opc; // fecha o listbox com as op??es de configura??o do teclado.
    procedure DesMarca_opc; // DesMarca a tecla com a op??o slecionada.
    procedure grava_teclado; // Grava o lay-out do teclado!
    Procedure Chama_teclado(tipo:string); // Carrega o lay-out do teclado!
    procedure grava_buffer_db(DataSet: TDataSet); // for?a a grava??o do buffer de dados das tabelas para o arquivo f?sico.
    Procedure carrega_op; // carrega o operador ativo no momento
    function  altera_hora(tipo:string):boolean; // altera o rel?gio do sistema em uma hora (+ ou -) pra o horario de ver?o
    procedure chamaACFUNC; // carrega os nomes das fun??es de PDV no autocom.ini

    procedure filtra_campos_tecnicos; // impede a edi??o de alguns campos quando o usu?rio n?o for um t?cnico (n?vel de seguran?a 99)
    Function FormataXcasas(texto:string;casas:integer):string; // Deixa o n?mero com a quantidade especificada de casas
    function trimall(t:string):string;

  end;

  function Checksun(primitiva:real):shortstring;external 'ECRPT.dll' index 2;


var
  PARAMETRO: TPARAMETRO;
  RMPAR: Tinifile;
  path:string;
  nivel_atual,nivel:string; // n?vel do operador ativo.
  butao:Tbutton;

implementation

uses Mod_ecf;

{$R *.DFM}
{$D 'RMPAR'}

function TPARAMETRO.trimall(t:string):string;
begin
     while pos(' ',t)>0 do delete(t,pos(' ',t),1);
     while pos('',t)>0 do delete(t,pos('',t),1);

     result:=t;
end;

Function TPARAMETRO.FormataXcasas(texto:string;casas:integer):string;
Begin
     texto := TrimAll(texto);
     While length(texto) < casas do
           Texto := ' ' + texto;
     Result := texto;
End;

procedure TPARAMETRO.Abrearquivos;
var t1,t2:string;
    ini:Tinifile;
begin
     try
        ini:=TIniFile.Create(path+'autocom.INI');
        t1:=ini.readString('ATCPLUS', 'IP_SERVER', ''); // endere?o ip do servidor
        t2:=ini.readString('ATCPLUS', 'PATH_DB', '');     // caminho do banco de dados no servidor
     finally
        ini.Free;
     end;

     try
        transacao.active:=false;
        dbautocom.connected:=false;
        dbautocom.databasename:=t1+':'+t2;
        dbautocom.connected:=true;
        transacao.active:=true;
        application.processmessages;
        teclado.active:=true;
     except

     end;

end;

function TPARAMETRO.Enche(texto,caracter:string;lado,tamanho:integer):string;
begin
     while length(texto)<tamanho do
        begin // lado=1, caracteres a esquerda  -  lado=2, caracteres a direita
           if lado = 1 then texto := caracter + texto else texto := texto + caracter;
        end;
     result:=texto;
end;

function TPARAMETRO.ModeloECF(indice:integer):string;
const
    modelo_ecf: array[0..100] of string=('',
          {reservado para a EPSON NF 01} 'Padr?o EPSON',
          {reservado para a Bematech 02} 'Bematech MP-20 MI / CI',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
          {reservado para a Sweda 10}    '',
          {reservado para a Sweda 11}    '',
          {reservado para a Sweda 12}    '',
          {reservado para a Sweda 13}    '',
          {reservado para a Sweda 14}    '',
          {reservado para a Sweda 15}    '',
          {reservado para a Sweda 16}    '',
          {reservado para a Sweda 17}    '',
          {reservado para a Sweda 18}    '',
          {reservado para a Sweda 19}    '',
          {reservado para a NCR 20}      'NCR - IF-7141 Duas Esta??es v2.00',
          {reservado para a NCR 21}      'NCR - ECF-IF-03-02 Duas Esta??es v2.00',
          {reservado para a NCR 22}      'NCR - ECF-IF-02-01 Uma Esta??o v2.00',
          {reservado para a NCR 23}      'NCR - ECF-IF Duas Esta??es v1.00',
          {reservado para a NCR 24}      '',
          {reservado para a NCR 25}      '',
          {reservado para a NCR 26}      '',
          {reservado para a NCR 27}      '',
          {reservado para a NCR 28}      '',
          {reservado para a NCR 29}      '',
          {reservado para a Bematech 30} 'Bematech - ECF-IF MP-20 FI II',
          {reservado para a Bematech 31} 'Bematech - ECF-IF MP-40 FI II',
          {reservado para a Bematech 32} '',
          {reservado para a Bematech 33} '',
          {reservado para a Bematech 34} '',
          {reservado para a Bematech 35} '',
          {reservado para a Bematech 36} '',
          {reservado para a Bematech 37} '',
          {reservado para a Bematech 38} '',
          {reservado para a Bematech 39} '',
          {reservado para a DLL AFRAC 40}'ECF padr?o AFRAC',
          {reservado para a DLL AFRAC 41}'',
          {reservado para a DLL AFRAC 42}'',
          {reservado para a DLL AFRAC 43}'',
          {reservado para a DLL AFRAC 44}'',
          {reservado para a DLL AFRAC 45}'',
          {reservado para a DLL AFRAC 46}'',
          {reservado para a DLL AFRAC 47}'',
          {reservado para a DLL AFRAC 48}'',
          {reservado para a DLL AFRAC 49}'',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         'Modo demonstra??o',
                                         '');
begin
     result:=modelo_ecf[indice];
end;

function TPARAMETRO.DLLECF(indice:integer):string;
const
    dll_ecf:    array[0..100] of string=('',
          {reservado para a EPSON NF 01} '_nfepson.dll',
          {reservado para a Bematech 02} '_nfepson.dll',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
          {reservado para a Sweda 10}    '',
          {reservado para a Sweda 11}    '',
          {reservado para a Sweda 12}    '',
          {reservado para a Sweda 13}    '',
          {reservado para a Sweda 14}    '',
          {reservado para a Sweda 15}    '',
          {reservado para a Sweda 16}    '',
          {reservado para a Sweda 17}    '',
          {reservado para a Sweda 18}    '',
          {reservado para a Sweda 19}    '',
          {reservado para a NCR 20}      '_ncr.dll',
          {reservado para a NCR 21}      '_ncr.dll',
          {reservado para a NCR 22}      '_ncr.dll',
          {reservado para a NCR 23}      '_ncr1.dll',
          {reservado para a NCR 24}      '',
          {reservado para a NCR 25}      '',
          {reservado para a NCR 26}      '',
          {reservado para a NCR 27}      '',
          {reservado para a NCR 28}      '',
          {reservado para a NCR 29}      '',
          {reservado para a Bematech 30} '_bematech.dll',
          {reservado para a Bematech 31} '_bematech.dll',
          {reservado para a Bematech 32} '',
          {reservado para a Bematech 33} '',
          {reservado para a Bematech 34} '',
          {reservado para a Bematech 35} '',
          {reservado para a Bematech 36} '',
          {reservado para a Bematech 37} '',
          {reservado para a Bematech 38} '',
          {reservado para a Bematech 39} '',
          {reservado para a DLL AFRAC 40}'_afrac.dll',
          {reservado para a Schaulter 41}'',
          {reservado para a Schaulter 42}'',
          {reservado para a Schaulter 43}'',
          {reservado para a Schaulter 44}'',
          {reservado para a Schaulter 45}'',
          {reservado para a Schaulter 46}'',
          {reservado para a Schaulter 47}'',
          {reservado para a Schaulter 48}'',
          {reservado para a Schaulter 49}'',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '',
                                         '_null',
                                         '');
begin
     result:=dll_ecf[indice];
end;


procedure TPARAMETRO.BitBtn2Click(Sender: TObject);
begin
     if application.messagebox('Deseja sair sem gravar as informa??es ?','Par?metros',MB_yesno)=idyes then close;
end;

procedure TPARAMETRO.carregaini;
begin
     RMPAR:=TIniFile.Create(path+'Autocom.INI');

     vpdvnum:=RMPAR.ReadString('TERMINAL', 'PDVNum', '000');     // N?mero do PDV
     vmodecf:=RMPAR.ReadString('TERMINAL', 'ModECF', '0');       // Modelo do ECF
     vmodtec:=RMPAR.ReadString('TERMINAL','ModTec','1');         // Modelo do teclado
     vCOMECF:=RMPAR.ReadString('TERMINAL', 'COMECF', '1');       // Porta serial do ECF. 0 significa LPT1
     vSCNR:=RMPAR.ReadString('TERMINAL', 'SCNR', '0');           // Utiliza scanner serial ?
     vCOMSCNR:=RMPAR.ReadString('TERMINAL', 'COMSCNR', '2');     // Porta de comunica??o do Scanner serial
     vcl1:=RMPAR.ReadString('CORTESIA', 'MCLinha1', '');            // Linha 1 da mensagem de cortesia
     vcl2:=RMPAR.ReadString('CORTESIA', 'MCLinha2', '');            // Linha 2 da mensagem de cortesia
     vcl3:=RMPAR.ReadString('CORTESIA', 'MCLinha3', '');            // Linha 3 da mensagem de cortesia
     vcl4:=RMPAR.ReadString('CORTESIA', 'MCLinha4', '');            // Linha 4 da mensagem de cortesia
     vcl5:=RMPAR.ReadString('CORTESIA', 'MCLinha5', '');            // Linha 5 da mensagem de cortesia
     vcl6:=RMPAR.ReadString('CORTESIA', 'MCLinha6', '');            // Linha 6 da mensagem de cortesia
     vcl7:=RMPAR.ReadString('CORTESIA', 'MCLinha7', '');            // Linha 7 da mensagem de cortesia
     vcl8:=RMPAR.ReadString('CORTESIA', 'MCLinha8', '');            // Linha 8 da mensagem de cortesia

     VLCHQ:=RMPAR.ReadString('TERMINAL', 'LCHQ', '0');             // dEFINI??O DE leitor de cheques.
     tipo_indicador:=RMPAR.REadString('TERMINAL','TIPIND','0');    // tipo de indicador
     v_fileimp:=RMPAR.REadString('ATCPLUS','IMP_DADOS','');
     v_fileexp:=RMPAR.REadString('ATCPLUS','EXP_DADOS','');
     v_HV:=RMPAR.ReadString('TERMINAL', 'HV', '0');            // Flag de hor?rio de ver?o 0=n?o  1=sim
     v_gaveta:=RMPAR.ReadString('TERMINAL', 'GAVETA','0');     // defini??o da gaveta de valores
     v_fechagaveta:=RMPAR.readstring('TERMINAL','OFGAVETA','0'); // flag que indica se o sistema obriga fechar a gaveta de valores no final da venda

     // pasta geral
     edtmodsingular.text:=RMPAR.readString('TERMINAL', 'moedasing', ''); // nome da moeda no singular
     edtmodplural.text:=RMPAR.readString('TERMINAL', 'Moedaplur', '');   // nome da moeda no plural;
     edtCifra.text:=RMPAR.readString('TERMINAL', 'cifra', '');           // cifra da moeda;
     edtFavorecido.text:=RMPAR.readString('TERMINAL', 'favorecido', ''); // nome do favorecido do cheque
     edtMunicipio.text:=RMPAR.readString('TERMINAL', 'municipio', '');   // municipio de onde est? sendo emitido o cheque


     //pasta limites.
     edtLimFcx.text:=mascara_valor((RMPAR.readString('TERMINAL', 'limitefcx', '000')),12,' ');
     edtLimSangria.text:=mascara_valor((RMPAR.readString('TERMINAL', 'limitesng', '000')),12,' ');
     edtLimdsp.text:=mascara_valor((RMPAR.readString('TERMINAL', 'Limdesc', '0000')),4,' ');
     edtDescpf.text:=mascara_valor((RMPAR.readString('TERMINAL', 'descpfixo', '0000')),4,' ');
     edtDescvf.text:=mascara_valor((RMPAR.readString('TERMINAL', 'descvfixo', '0000')),12,' ');
     edtLimAcrept.text:=mascara_valor((RMPAR.readString('TERMINAL', 'Limacre', '0000')),4,' ');
     edtAcrevft.text:=mascara_valor((RMPAR.readString('TERMINAL', 'acrevfixo', '0000')),12,' ');
     edtAcrepft.text:=mascara_valor((RMPAR.readString('TERMINAL', 'acrepfixo', '0000')),4,' ');

     txt_percentualservico.text:=mascara_valor((RMPAR.readString('TERMINAL', 'servico_per', '0000')),4,' '); // percentual do servico
     txt_valorservico.text:=mascara_valor((RMPAR.readString('TERMINAL', 'servico_val', '0000')),12,' '); // valor do servico
     txt_nptexto.text:=RMPAR.readString('TERMINAL', 'nptexto', 'pagarei por esta nota promissoria o valor de:');   // texto da nota promissoria

     v_displaytorre:=RMPAR.readString('TERMINAL', 'Disptorre', '0'); // define se existe display cliente
     v_displaytorreCOM:=RMPAR.readString('TERMINAL', 'COMDisptorre', '1'); // defina a porta de comunicacao do display cliente
     v_Obrigaind:=RMPAR.readString('TERMINAL', 'OBRIND', '0'); // define se ? obrigado lancar o vendedor na venda
     v_COMGaveta:=RMPAR.readString('TERMINAL', 'COMDGaveta', '0');  // define a porta de comunica?ao da gaveta de valores
     v_usaservico:=RMPAR.readString('TERMINAL', 'usa_servico', '0'); // define se usa servico ou nao


     RMPAR.Free;
     if length(trim(v_fileexp))=0 then v_fileexp:=extractfilepath(application.exename);
end;

procedure TPARAMETRO.gravaini;
begin
     RMPAR:=TIniFile.Create(path+'autocom.INI');

     RMPAR.WriteString('TERMINAL', 'PDVNum', vpdvnum);        // N?mero do PDV
     RMPAR.WriteString('TERMINAL', 'ModECF', vmodecf);        // Modelo do ECF
     RMPAR.WriteString('TERMINAL', 'ModTec', vmodtec);        // Modelo do teclado
     RMPAR.WriteString('TERMINAL', 'COMECF', vCOMECF);        // Porta serial do ECF. 0 significa LPT1
     RMPAR.WriteString('TERMINAL', 'SCNR', vSCNR);            // Utiliza scanner serial ?
     RMPAR.WriteString('TERMINAL', 'COMSCNR', vCOMSCNR);      // Porta de comunica??o do Scanner serial
     RMPAR.WriteString('CORTESIA', 'MCLinha1', vcl1);            // Linha 1 da mensagem de cortesia
     RMPAR.WriteString('CORTESIA', 'MCLinha2', vcl2);            // Linha 2 da mensagem de cortesia
     RMPAR.WriteString('CORTESIA', 'MCLinha3', vcl3);            // Linha 3 da mensagem de cortesia
     RMPAR.WriteString('CORTESIA', 'MCLinha4', vcl4);            // Linha 4 da mensagem de cortesia
     RMPAR.WriteString('CORTESIA', 'MCLinha5', vcl5);            // Linha 5 da mensagem de cortesia
     RMPAR.WriteString('CORTESIA', 'MCLinha6', vcl6);            // Linha 6 da mensagem de cortesia
     RMPAR.WriteString('CORTESIA', 'MCLinha7', vcl7);            // Linha 7 da mensagem de cortesia
     RMPAR.WriteString('CORTESIA', 'MCLinha8', vcl8);            // Linha 8 da mensagem de cortesia

     RMPAR.WriteString('TERMINAL', 'LCHQ', VLCHQ);           // dEFINI??O DE leitor de cheques.
     RMPAR.WriteString('TERMINAL', 'TIPIND',tipo_indicador);  // tipo de indicador
     RMPAR.WriteString('TERMINAL', 'NOMEIND',edind.text);     // Nome do indicador
     RMPAR.WriteString('ATCPLUS', 'EXP_DADOS', v_fileexp); // CAMINHO PARA EXPORTA??O DE ARQUIVOS
     RMPAR.WriteString('ATCPLUS', 'IMP_DADOS', v_fileimp);  //caminho e o nome do arquivo de importa??o do cadastro de produtos
     //RMPAR.WriteString('TERMINAL', 'NomeclieImp', v_nomeclieimp); // caminho e nome do arquivo de importa??o do cadastro de clientes
     RMPAR.WriteString('TERMINAL', 'GAVETA',v_gaveta);       // defini??o da gaveta de valores
     RMPAR.writestring('TERMINAL','OFGAVETA',v_fechagaveta); // flag que indica se o sistema obriga fechar a gaveta de valores no final da venda

     RMPAR.WriteString('TERMINAL', 'HV', v_HV);            // Flag de hor?rio de ver?o 0=n?o  1=sim

     RMPAR.WriteString('MODULOS', 'dll_ECF', dll_do_ecf);  // Nome da dll do ECF


     // pasta geral
     RMPAR.WriteString('TERMINAL', 'moedasing', edtmodsingular.text); // nome da moeda no singular
     RMPAR.WriteString('TERMINAL', 'Moedaplur', edtmodplural.text);   // nome da moeda no plural;
     RMPAR.WriteString('TERMINAL', 'cifra', edtCifra.text);           // cifra da moeda;
     RMPAR.WriteString('TERMINAL', 'favorecido', edtFavorecido.text); // nome do favorecido do cheque
     RMPAR.WriteString('TERMINAL', 'municipio',edtMunicipio.text);   // municipio de onde est? sendo emitido o cheque

     //pasta limites.
     RMPAR.WriteString('TERMINAL', 'limitefcx', edtLimFcx.text);
     RMPAR.WriteString('TERMINAL', 'limitesng', edtLimSangria.text);
     RMPAR.WriteString('TERMINAL', 'Limdesc', edtLimdsp.text);
     RMPAR.WriteString('TERMINAL', 'descpfixo', edtDescpf.text);
     RMPAR.WriteString('TERMINAL', 'descvfixo', edtDescvf.text);
     RMPAR.WriteString('TERMINAL', 'Limacre', edtLimAcrept.text);
     RMPAR.WriteString('TERMINAL', 'acrevfixo', edtAcrevft.text);
     RMPAR.WriteString('TERMINAL', 'acrepfixo', edtAcrepft.text);

     RMPAR.writeString('TERMINAL', 'servico_per', txt_percentualservico.text); // percentual do servico
     RMPAR.writeString('TERMINAL', 'servico_val', txt_valorservico.text); // valor do servico
     RMPAR.writeString('TERMINAL', 'nptexto', txt_nptexto.text);   // texto da nota promissoria

     RMPAR.readString('TERMINAL', 'Disptorre', v_displaytorre); // define se existe display cliente
     RMPAR.readString('TERMINAL', 'COMDisptorre', v_displaytorreCOM); // defina a porta de comunicacao do display cliente
     RMPAR.readString('TERMINAL', 'OBRIND', v_Obrigaind); // define se ? obrigado lancar o vendedor na venda
     RMPAR.readString('TERMINAL', 'COMDGaveta', v_COMGaveta);  // define a porta de comunica?ao da gaveta de valores
     RMPAR.readString('TERMINAL', 'usa_servico', v_usaservico); // define se usa servico ou nao

     RMPAR.Free;
end;

procedure TPARAMETRO.BitBtn1Click(Sender: TObject);
begin
     if application.messagebox('Confirma a grava??o dos dados ?','Par?metros',MB_yesno)=idyes then
        begin
           if verificaerros=true then
              begin
                 Atualizavariaveis;
                 gravaini;
                 Grava_teclado;

                 query.close;
                 query.sql.clear;
                 query.sql.add('commit');
                 query.prepare;
                 query.execsql;

                 close;
              end;
        end;
end;

procedure TPARAMETRO.FormActivate(Sender: TObject);
var a:integer;
begin
     setforegroundwindow(application.handle);
     path:=extractfilepath(application.exename)+'Dados\';
     abrearquivos;
     carregaini;
     Atualizacampos;
     chamaACFUNC;
     monta_menu_teclado;
     chama_teclado(vmodtec);
     carrega_op;
     filtra_campos_tecnicos;
     for a:=0 to cbtec.items.count-1 do
        begin
           if copy(cbtec.items[a],1,1)=vmodtec then
              begin
                 cbtec.text:=cbtec.items[a];
                 monta_teclado('teclado'+vmodtec);
                 break;
              end;
        end;
end;

procedure TPARAMETRO.Atualizacampos;
begin
     edpdvn.text:=vpdvnum;
     edmodecf.text:=modeloecf(strtoint(vmodecf));
     if vcomECF<>'0' then edcomecf.text:='COM'+vCOMECF else edcomecf.text:='LPT1';
     if vSCNR='0' then edscnr.text:='N?O' else edscnr.text:='SIM';
     edcomSCN.text:='COM'+vCOMSCNR;

     if VLCHQ='0'    then edlcheq.text:='N?O'  else edlcheq.text:='SIM';
     if v_gaveta='0' then edgaveta.text:='NEHUMA';
     if v_gaveta='1' then edgaveta.text:='GERBO';
     if v_gaveta='2' then edgaveta.text:='MENNO';

     if v_fechagaveta='0' then edfechagaveta.text:='N?O' else edfechagaveta.text:='SIM';

     edind.style:=csDropDown;
     edind.text:=edind.items[strtoint(tipo_indicador)];

     mcl1.text:=vcl1;
     mcl2.text:=vcl2;
     mcl3.text:=vcl3;
     mcl4.text:=vcl4;
     mcl5.text:=vcl5;
     mcl6.text:=vcl6;
     mcl7.text:=vcl7;
     mcl8.text:=vcl8;

     edpathexp.text:=v_fileexp;
     edpathimpprod.text:=v_fileimp;

     cmb_COMDispTorre.text:='COM'+v_displaytorreCOM;
     if v_displaytorre='0' then cmb_DispTorre.text:='N?O' else cmb_DispTorre.text:='SIM';
     if v_COMGaveta<>'0' then cmb_COMgaveta.text:='COM'+v_COMGaveta else cmb_COMgaveta.text:='ECF';
     if v_Obrigaind='0' then cmb_obrigaind.text:='N?O' else cmb_obrigaind.text:='SIM';

     if v_usaservico='0' then
        begin
           chk_usaservico.checked:=false;
           txt_valorservico.enabled:=false;
           txt_percentualservico.enabled:=false;
           label26.enabled:=false;
           label28.enabled:=false;
        end
     else
        begin
           chk_usaservico.checked:=true;
           txt_valorservico.enabled:=true;
           txt_percentualservico.enabled:=true;
           label26.enabled:=true;
           label28.enabled:=true;
        end;

     if v_HV='0' then bhv.caption:='Entrar em hor?rio de ver?o' else bhv.caption:='Sair do hor?rio de ver?o';

end;

procedure TPARAMETRO.Atualizavariaveis;
var a:integer;
begin
     vpdvnum:=edpdvn.text;
     for a:=1 to 100 do
        begin
           if modeloecf(a)=edmodecf.text then
              begin
                 vmodecf:=inttostr(a);
                 dll_do_ecf:=dllecf(a);
                 break;
              end;
        end;

     if edcomecf.text<>'LPT1' then vCOMECF:=copy(edcomecf.text,4,2) else vcomecf:='0';
     if edscnr.text='SIM' then vSCNR:='1' else vSCNR:='0';
     vCOMSCNR:=copy(edcomSCN.text,4,2);

     if edlcheq.text='SIM' then VLCHQ:='1' else VLCHQ:='0';

     if edgaveta.text='NENHUMA' then v_gaveta:='0';
     if edgaveta.text='GERBO'   then v_gaveta:='1';
     if edgaveta.text='MENNO'   then v_gaveta:='2';

     if edfechagaveta.text='SIM' then v_fechagaveta:='1' else v_fechagaveta:='0';

     for a:=1 to 100 do
        begin
           if edind.items[a]=edind.text then
              begin
                 tipo_indicador:=inttostr(a);
                 break;
              end;
        end;

     v_displaytorreCOM:=copy(cmb_COMDispTorre.text,4,2);
     if cmb_DispTorre.text='N?O' then v_displaytorre:='0' else v_displaytorre:='1';
     if cmb_COMgaveta.text<>'ECF' then v_COMGaveta:=copy(cmb_COMgaveta.text,4,2) else v_COMGaveta:='0';
     if cmb_obrigaind.text='N?O' then v_Obrigaind:='0' else v_Obrigaind:='1';
     if chk_usaservico.checked=false then v_usaservico:='0' else v_usaservico:='1';

     vcl1:=mcl1.text;
     vcl2:=mcl2.text;
     vcl3:=mcl3.text;
     vcl4:=mcl4.text;
     vcl5:=mcl5.text;
     vcl6:=mcl6.text;
     vcl7:=mcl7.text;
     vcl8:=mcl8.text;

     v_fileexp:=edpathexp.text;
     v_fileimp:=edpathimpprod.text;

end;


function TPARAMETRO.verificaerros:boolean;
var a:integer;
begin
     try
        strtoint(edpdvn.text);
     except
        messagedlg('O n?mero do PDV est? incorreto.',mtinformation,[mbok],0);
        result:=false;
        Pagecontrol1.ActivePageIndex:=1;
        edpdvn.setfocus;
        exit;
     end;

     if strtoint(edpdvn.text)<=0 then
     begin
        messagedlg('O n?mero do PDV est? incorreto.',mtinformation,[mbok],0);
        result:=false;
        Pagecontrol1.ActivePageIndex:=1;
        edpdvn.setfocus;
        exit;
     end;

     for a:=1 to 100 do
        begin
           if modeloecf(a)=edmodecf.text then
              begin
                 vmodecf:=inttostr(a);
                 result:=true;
                 break;
              end;
        end;
     if a>=100 then
        begin
           messagedlg('O modelo de ECF est? incorreto.',mtinformation,[mbok],0);
           result:=false;
           Pagecontrol1.ActivePageIndex:=1;   
           edmodecf.setfocus;
           exit;
        end;

     if edmodecf.text='' then
        begin
           messagedlg('O modelo de ECF est? incorreto.',mtinformation,[mbok],0);
           result:=false;
           Pagecontrol1.ActivePageIndex:=1;   
           edmodecf.setfocus;
           exit;
        end;

     if edcomecf.text='' then
        begin
           messagedlg('A porta de comunica??o informada do ECF est? incorreta.',mtinformation,[mbok],0);
           result:=false;
           Pagecontrol1.ActivePageIndex:=1;   
           edcomecf.setfocus;
           exit;
        end;

     if (edscnr.text<>'N?O') and (edscnr.text<>'SIM') then
        begin
           messagedlg('A defini??o do scanner serial est? incorreta.',mtinformation,[mbok],0);
           result:=false;
           Pagecontrol1.ActivePageIndex:=3;   
           edscnr.setfocus;
           exit;
        end;

     if (edcomSCN.text='')  then
        begin
           messagedlg('A porta de comunica??o informada do scanner est? incorreta.',mtinformation,[mbok],0);
           result:=false;
           Pagecontrol1.ActivePageIndex:=3;   
           edcomSCN.setfocus;
           exit;
        end;

     if (edlcheq.text<>'N?O') and (edlcheq.text<>'SIM') then
        begin
           messagedlg('A defini??o do leitor de cheques est? incorreta.',mtinformation,[mbok],0);
           result:=false;
           Pagecontrol1.ActivePageIndex:=3;   
           edlcheq.setfocus;
           exit;
        end;

     if copy(edpathexp.text,length(edpathexp.text),1)<>'\' then
        begin
           messagedlg('O caminho de exporta??o deve terminar com barra (\).',mtinformation,[mbok],0);
           result:=false;
           Pagecontrol1.ActivePageIndex:=0;
           Pagecontrol2.ActivePageIndex:=0;
           edpathexp.setfocus;
           exit;
        end;

     result:=true;
end;

procedure TPARAMETRO.BitBtn6Click(Sender: TObject);
begin
     ModECF.Showmodal;
end;

procedure TPARAMETRO.edPDVNExit(Sender: TObject);
begin
     edpdvn.text:=enche(edpdvn.text,'0',1,3);
end;

function TPARAMETRO.retira(texto,caracter:string):string;
begin
     while pos(caracter,texto)>0 do
        begin
           delete(texto,pos(caracter,texto),1);
        end;
     result:=texto;
end;

function TPARAMETRO.retiraNB(texto:string):string;
begin
     while pos('',texto)>0 do
        begin
           delete(texto,pos('',texto),1);
        end;
     while pos(' ',texto)>0 do
        begin
           delete(texto,pos(' ',texto),1);
        end;
     result:=texto;
end;


procedure TPARAMETRO.FormClose(Sender: TObject; var Action: TCloseAction);
begin
        teclado.active:=true;
        transacao.active:=false;
        dbautocom.connected:=false;
end;

procedure TPARAMETRO.edtLimFcxExit(Sender: TObject);
begin
     If trim(edtlimfcx.text) = '' then
        edtlimfcx.text := '         000'
     Else
         edtlimfcx.text:=PARAMETRO.mascara_valor(edtlimfcx.text,12,' ');
end;

procedure TPARAMETRO.edtLimSangriaExit(Sender: TObject);
begin
     If trim(edtlimsangria.text) = '' then
        edtlimsangria.text := '         000'
     Else
         edtlimsangria.text:=PARAMETRO.mascara_valor(edtlimsangria.text,12,' ');
end;

procedure TPARAMETRO.edtAcrevftExit(Sender: TObject);
begin
     If trim(edtAcrevft.text) = '' then
        edtAcrevft.text := '         000'
     Else
         edtAcrevft.text:=PARAMETRO.mascara_valor(edtAcrevft.text,12,' ');
//     if edtAcrevft.text<>'        000' then edtLimAcrevT.text:='        000';
end;

procedure TPARAMETRO.edtDescvfExit(Sender: TObject);
begin
     If trim(edtDescvf.text) = '' then
        edtDescvf.text := '         000'
     Else
         edtDescvf.text:=PARAMETRO.mascara_valor(edtDescvf.text,12,' ');
//     if edtDescvf.text<>'         000' then edtLimdsv.text:='         000';
end;

procedure TPARAMETRO.edtLimAcreptExit(Sender: TObject);
begin
     If trim(edtLimAcrept.text) = '' then
        edtLimAcrept.text := ' 000'
     Else
         edtLimAcrept.text:=PARAMETRO.mascara_valor(edtLimAcrept.text,4,'0');
     //if edtLimAcrept.text<>'0000' then edtAcrepft.text:='0000';
end;

procedure TPARAMETRO.edtAcrepftExit(Sender: TObject);
begin
     If trim(edtAcrepft.text) = '' then
        edtAcrepft.text := ' 000'
     Else
         edtAcrepft.text:=PARAMETRO.mascara_valor(edtAcrepft.text,4,'0');
    // if edtAcrepft.text<>'0000' then edtLimAcrept.text:='0000';
end;

procedure TPARAMETRO.edtLimdspExit(Sender: TObject);
begin
     If trim(edtLimdsp.text) = '' then
        edtLimdsp.text := ' 000'
     Else
         edtLimdsp.text:=PARAMETRO.mascara_valor(edtLimdsp.text,4,'0');
     //if edtLimdsp.text<>'0000' then edtDescpf.text:='0000';
end;

procedure TPARAMETRO.edtDescpfExit(Sender: TObject);
begin
     If trim(edtDescpf.text) = '' then
        edtDescpf.text := ' 000'
     Else
         edtDescpf.text:=PARAMETRO.mascara_valor(edtDescpf.text,4,'0');
     //if edtDescpf.text<>'0000' then edtLimdsp.text:='0000';
end;

procedure TPARAMETRO.edtLpzArquivoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//     if key=VK_UP Then Perform(WM_NextDlgCtl,1,0);
//     if key=VK_DOWN Then Perform(WM_NextDlgCtl,0,0);
     if key=VK_RETURN Then Perform(WM_NextDlgCtl,0,0);
end;

function TPARAMETRO.mascara_valor(texto:string;tamanho:integer;bit:string):string;
begin
     texto:=retiranb(texto);
     try
        strtofloat(texto);
     except
        texto:='000';
     end;
     if length(texto)=1 then texto:='00'+texto;
     if length(texto)=2 then texto:='0'+texto;
     result:=enche(texto,' ',1,tamanho);
end;

procedure TPARAMETRO.n1Click(Sender: TObject);
var teste:Tcheckbox;
begin
     teste:=sender as TCheckbox;
     nivel:=copy(teste.name,2,2);
end;

procedure TPARAMETRO.cbtecChange(Sender: TObject);
begin
     vmodtec:=copy(cbtec.text,1,1);
     Chama_teclado(vmodtec);
     monta_teclado('teclado'+vmodtec);
end;

procedure TPARAMETRO.monta_teclado(painel:string);
var b,a:integer;
    c:Tpanel;
    d:Tbutton;
begin
     for b:=0 to PARAMETRO.componentcount-1 do
        begin
           if (PARAMETRO.components[b] is Tpanel) then
              begin
                 c:=PARAMETRO.components[b] as TPanel;
                 if c.name=painel then
                    begin
                       c.visible:=true;
                       c.refresh;
                       for a:=0 to PARAMETRO.componentcount-1 do
                          begin
                             if (PARAMETRO.components[a] is Tbutton) then
                                begin
                                   d:=PARAMETRO.components[a] as Tbutton;
                                   if copy(d.name,1,1)='t' then
                                      begin
                                         d.caption:=tecla_resu_func[strtoint(copy(d.name,4,3))];
                                         d.refresh;
                                      end;
                                end;
                          end;
                    end
                 else
                    begin
                       if copy(c.name,1,length(c.name)-1)='teclado' then c.visible:=false;
                    end;
              end;
        end;
end;

procedure TPARAMETRO.monta_menu_teclado;
var
   I : integer;
begin
     lbteclado.Items.Clear;
     for i:=1 to max_opc do
        begin
             if length(retiranb(NOME_OPC[i]))>0 then
                begin
                   lbteclado.sorted:=false;
                   lbteclado.Items.Add(NOME_OPC[i]);
                   lbteclado.sorted:=true;
                end;
        end;
end;

procedure TPARAMETRO.Marca_opc;
var b,i:integer;
    botao:Tbutton;
begin
     for b:=0 to PARAMETRO.componentcount-1 do
        begin
           if (PARAMETRO.components[b] is Tbutton) then
              begin
                 botao:=PARAMETRO.components[b] as Tbutton;
                 if (botao.font.color=clblue) and (copy(botao.name,1,2)='t'+vmodtec) then
                    begin
                       if (lbteclado.items[lbteclado.itemindex]='Produto direto') and (edppi.visible=false) then
                          begin
                             edppi.visible:=true;
                             insertppi.visible:=true;
                             Pagecontrol1.ActivePageIndex:=2;
                             edppi.setfocus;
                             exit;
                          end;

                       if pos(' (EM USO)',lbteclado.items[lbteclado.itemindex])<=0 then
                          begin
                             try
                                for i:=0 to max_opc do
                                   begin
                                      if NOME_OPC[i]=lbteclado.items[lbteclado.itemindex] then
                                         begin
                                            Tecla_code_func[strtoint(copy(botao.name,4,length(botao.name)))]:=cod_opc[i];
                                            Tecla_name_func[strtoint(copy(botao.name,4,length(botao.name)))]:=nome_opc[i];
                                            Tecla_resu_func[strtoint(copy(botao.name,4,length(botao.name)))]:=ABRV_opc[i];
                                            if edppi.visible=true then Tecla_PPIC_func[strtoint(copy(botao.name,4,length(botao.name)))]:=strtofloat(edppi.text) else Tecla_PPIC_func[strtoint(copy(botao.name,4,length(botao.name)))]:=0;
                                            break;
                                         end;
                                   end;
                                botao.caption:=Tecla_resu_func[strtoint(copy(botao.name,4,length(botao.name)))];
                                lbteclado.sorted:=false;
                                if Tecla_PPIC_func[strtoint(copy(botao.name,4,length(botao.name)))]<=0 then lbteclado.items[lbteclado.itemindex]:=' (EM USO)'+lbteclado.items[lbteclado.itemindex];
                                lbteclado.sorted:=true;
                             except;
                                botao.caption:=botao.caption;
                             end;
                             descarta_opc;
                             exit;
                          end;
                    end;
              end;
        end;
end;

procedure TPARAMETRO.DesMarca_opc;
var b,i:integer;
    botao:Tbutton;
begin
     for b:=0 to PARAMETRO.componentcount-1 do
        begin
           if (PARAMETRO.components[b] is Tbutton) then
              begin
                 botao:=PARAMETRO.components[b] as Tbutton;
                 if (botao.font.color=clblue) and (copy(botao.name,1,2)='t'+vmodtec) then
                    begin
                       for i:=0 to lbteclado.items.count-1 do
                          begin
                             if pos(Tecla_name_func[strtoint(copy(botao.name,4,length(botao.name)))],lbteclado.items[i])>0 then
                                begin
                                   lbteclado.sorted:=false;
                                   if Tecla_PPIC_func[strtoint(copy(botao.name,4,length(botao.name)))]<=0 then lbteclado.items[i]:=copy(lbteclado.items[i],10,length(lbteclado.items[i]));
                                   lbteclado.sorted:=true;
                                   Tecla_code_func[strtoint(copy(botao.name,4,length(botao.name)))]:=0;
                                   Tecla_name_func[strtoint(copy(botao.name,4,length(botao.name)))]:='';
                                   Tecla_resu_func[strtoint(copy(botao.name,4,length(botao.name)))]:='';
                                   Tecla_PPIC_func[strtoint(copy(botao.name,4,length(botao.name)))]:=0;
                                   botao.caption:='';
                                   descarta_opc;
                                   exit;
                                end;
                          end;
                    end;
              end;
        end;
end;

procedure TPARAMETRO.Descarta_opc;
var b:integer;
    botao:Tbutton;
begin
     for b:=0 to PARAMETRO.componentcount-1 do
        begin
           if (PARAMETRO.components[b] is Tbutton) then
              begin
                 botao:=PARAMETRO.components[b] as Tbutton;
                 if (botao.font.color=clblue) and (copy(botao.name,1,2)='t'+vmodtec) then
                    begin
                       botao.font.color:=clred;
                       if butao.caption='?' then butao.caption:='';
                       Pagecontrol1.ActivePageIndex:=2;
                       botao.setfocus;
                       break;
                    end;
              end;
        end;
     lbteclado.visible:=false;
     botao_limpa.visible:=false;
     edppi.text:='';
     edppi.visible:=false;
     insertppi.visible:=false;
end;

procedure TPARAMETRO.t1_27Click(Sender: TObject);
begin
     butao:=sender as Tbutton;
     butao.font.color:=clblue;
     if length(retiranb(butao.caption))>0 then
        begin
           botao_limpa.visible:=true;
           botao_limpa.setfocus;
        end
     else
        begin
           butao.caption:='?';
           lbteclado.visible:=true;
           lbteclado.setfocus;
        end;
end;

procedure TPARAMETRO.lbtecladoDblClick(Sender: TObject);
begin
     marca_opc;
end;

procedure TPARAMETRO.lbtecladoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=vk_return then marca_opc;
end;

procedure TPARAMETRO.lbtecladoExit(Sender: TObject);
begin
     if edppi.visible=false then Descarta_opc;
end;

procedure TPARAMETRO.Botao_limpaClick(Sender: TObject);
begin
     desmarca_opc;
end;

procedure TPARAMETRO.grava_teclado;
var a:integer;
begin
     teclado.active:=false;

     query.close;
     query.sql.clear;
     query.sql.add('delete from PDV_teclado where terminal='+chr(39)+edpdvn.text+chr(39)+' and tipo='+chr(39)+vmodtec+chr(39));
     query.prepare;
     query.execsql;

     query.close;
     query.sql.clear;
     query.sql.add('commit');
     query.prepare;
     query.execsql;

     teclado.active:=true;
     for a:=0 to max_opc_teclado do
        begin
           if (length(retiranb(Tecla_name_func[a]))>0) and (tecla_code_func[a]>0) then
              begin
                 teclado.append;
                 tecladoterminal.value:=edpdvn.text;
                 tecladotipo.value:=vmodtec;
                 tecladotecla.value:=a;
                 tecladocodigo_funcao.value:=enche(inttostr(tecla_code_func[a]),'0',1,4);
                 tecladoAbrev.value:=Tecla_resu_func[a];
                 if strtoint(floattostr(tecla_PPIC_func[a]))<>0 then tecladocodigoproduto.value:=strtoint(floattostr(tecla_PPIC_func[a]));
                 tecladocfg_codconfig.value:=1;

                 teclado.post;
              end;
        end;
end;

procedure TPARAMETRO.Chama_teclado(tipo:string);
var a,b:integer;
begin
     teclado.first;
     while not teclado.eof do
        begin
           if (tecladoterminal.value=edpdvn.text) and (tecladotipo.value=tipo) then
              begin
                 tecla_code_func[tecladotecla.value]:=strtoint(tecladocodigo_funcao.value);
                 Tecla_resu_func[tecladotecla.value]:=tecladoabrev.value;
                 tecla_PPIC_func[tecladotecla.value]:=tecladocodigoproduto.value;
                 for a:=1 to max_opc do
                    begin
                       if cod_opc[a]=tecla_code_func[tecladotecla.value] then
                          begin
                             tecla_name_func[tecladotecla.value]:=nome_opc[a];
                             for b:=0 to lbteclado.items.count-1 do
                                begin
                                   if lbteclado.items[b]=tecla_name_func[tecladotecla.value] then
                                      begin
                                         lbteclado.sorted:=false;
                                         if tecla_PPIC_func[tecladotecla.value]<=0 then lbteclado.items[b]:=' (EM USO)'+lbteclado.items[b];
                                         lbteclado.sorted:=true;
                                         break;
                                      end;
                                end;
                             break;
                          end;
                    end;
              end;
           teclado.next;
        end;
end;
procedure TPARAMETRO.edppiKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=vk_return then
        begin
           insertppi.setfocus;
        end;
end;

procedure TPARAMETRO.insertPPIClick(Sender: TObject);
begin
     if application.messagebox('Confirma o PPI ?','Par?metros',MB_yesno)=idyes then
        begin
           try
              strtofloat(edppi.text);
           except
              messagedlg('C?digo inv?lido',mtinformation,[mbok],0);
              edppi.setfocus;
              exit;
           end;
           if strtofloat(edppi.text)<=0 then
              begin
                 messagedlg('C?digo inv?lido',mtinformation,[mbok],0);
                 edppi.setfocus;
                 exit;
              end;
           teclado1.enabled:=true;
           marca_opc;
        end
     else
        begin
           teclado1.enabled:=true;
           descarta_opc;
        end;
end;

procedure TPARAMETRO.edppiEnter(Sender: TObject);
begin
     teclado1.enabled:=false;
end;

procedure TPARAMETRO.grava_buffer_db(DataSet: TDataSet);
var tabela:TTable;
begin
     tabela:=dataset as Ttable;
     DBISaveChanges(tabela.handle);
end;

procedure TPARAMETRO.PARsistAfterPost(DataSet: TDataSet);
begin
     grava_buffer_db(dataset);
end;

procedure TPARAMETRO.TecladoAfterPost(DataSet: TDataSet);
begin
     grava_buffer_db(dataset);
end;

Procedure tPARAMETRO.carrega_op;
var oper:Tinifile;
begin
     oper:=TIniFile.Create(path+'OPER.INI');
     nivel_atual:=oper.ReadString('OPER', 'Tipo','');
     oper.Free;
end;


procedure Tparametro.filtra_campos_tecnicos;
begin
{
     if nivel_atual<>'99' then
        begin
           edpdvn.readonly:=true;
           edpdvn.color:=clyellow;
           edmodecf.readonly:=true;
           edmodecf.color:=clyellow;
           bitbtn6.enabled:=false;
        end
     else
        begin
           edpdvn.readonly:=false;
           edpdvn.color:=clwindow;
           edmodecf.readonly:=false;
           edmodecf.color:=clwindow;
           bitbtn6.enabled:=true;
        end;
}
end;

function Tparametro.altera_hora(tipo:string):boolean;
var
  DataHora: TSystemTime;
  Hora: TDateTime;
  H, M, S, Mil: word;
begin
     GetSystemTime(DataHora);
     hora:=SystemTimeToDateTime(DataHora);
     DecodeTime(Hora, H, M, S, Mil);
     if tipo='-' then h:=h-1;
     if tipo='+' then h:=h+1;
     hora:=EncodeTime(H, M, S, Mil);
     DateTimeToSystemTime(hora,DataHora);
     result:=SetSystemTime(DataHora);
end;

procedure TPARAMETRO.bhvClick(Sender: TObject);
begin
     if bhv.caption='Entrar em hor?rio de ver?o' then
        begin
           if altera_hora('+')=true then
              begin
                 v_hv:='1';
                 application.messagebox('O sistema entrou em hor?rio de ver?o!','AUTOCOM PLUS',mb_ok);
                 bhv.caption:='Sair do hor?rio de ver?o';
              end
           else
              begin
                 application.messagebox('Ocorreu um problema e n?o foi poss?vel alterar a hora do sistema!','AUTOCOM PLUS',mb_ok);
              end;
        end
     else
        begin
           if altera_hora('-')=true then
              begin
                 v_hv:='0';
                 application.messagebox('O sistema saiu do hor?rio de ver?o!','AUTOCOM PLUS',mb_ok);
                 bhv.caption:='Entrar em hor?rio de ver?o';
              end
           else
              begin
                 application.messagebox('Ocorreu um problema e n?o foi poss?vel alterar a hora do sistema!','AUTOCOM PLUS',mb_ok);
              end;
        end;
end;

procedure TPARAMETRO.TabSheet2Enter(Sender: TObject);
begin
     If edPDVN.Color = clyellow then
        Begin
             edcomecf.SetFocus;
             edcomecf.SelectAll;
        End;
end;


procedure TPARAMETRO.chamaACFUNC;
var a:integer;
begin
     query.close;
     query.sql.clear;
     query.sql.add('select * from pdv_funcoesteclado');
     query.prepare;
     query.open;

     query.first;
     a:=1;
     while not query.eof do
        begin
           if length(trim(query.fieldbyname('nome_funcao').asstring))>0 then
              begin
                 nome_opc[a]:=query.fieldbyname('nome_funcao').asstring;
//               aces_opc[a]:=ini.readstring('FT_'+enche(inttostr(a),'0',1,4),'Acesso','0000000000');
                 cod_opc[a] :=query.fieldbyname('codigo_funcao').asinteger;
                 ABRV_opc[a]:=query.fieldbyname('sigla').asstring;
              end;
           query.next;
           a:=a+1;
        end;
end;

procedure TPARAMETRO.chk_usaservicoClick(Sender: TObject);
begin
     if chk_usaservico.checked=true then
        begin
           txt_valorservico.enabled:=true;
           txt_percentualservico.enabled:=true;
           label26.enabled:=true;
           label28.enabled:=true;
        end
     else
        begin
           txt_valorservico.enabled:=false;
           txt_percentualservico.enabled:=false;
           label26.enabled:=false;
           label28.enabled:=false;
        end;
end;

procedure TPARAMETRO.txt_valorservicoExit(Sender: TObject);
begin
     If trim(txt_valorservico.text) = '' then
        txt_valorservico.text := '         000'
     Else
         txt_valorservico.text:=PARAMETRO.mascara_valor(txt_valorservico.text,12,' ');

     if strtofloat(trim(txt_valorservico.text))>0 then txt_percentualservico.text := ' 000';
end;

procedure TPARAMETRO.txt_percentualservicoExit(Sender: TObject);
begin
     If trim(txt_percentualservico.text) = '' then
        txt_percentualservico.text := ' 000'
     Else
         txt_percentualservico.text:=PARAMETRO.mascara_valor(txt_percentualservico.text,4,'0');

     if strtofloat(trim(txt_percentualservico.text))>0 then txt_valorservico.text := '         000';
end;

end.
