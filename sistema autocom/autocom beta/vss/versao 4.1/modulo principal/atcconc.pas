unit atcconc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, Db, DBTables,inifiles, StdCtrls, filectrl, IBDatabase,
  IBCustomDataSet, IBQuery, Buttons,registry,shellapi, SUIMgr,
  SUIImagePanel, SUIButton, SUIMainMenu, SUIForm, SUIThemes;

const
     max_opc=500; // Máximo de opções existentes no sistema;
     Registro_win_licenca='\Software\Rima Autocom\fcx\Lic'; // path para grava/leitura do status da licença do sistema (data limite) no registro do windows.

type
  Tfrm_FATCPR = class(TForm)
    mp100: TMenuItem;
    mi101: TMenuItem;
    mp500: TMenuItem;
    mi102: TMenuItem;
    mi104: TMenuItem;
    mi105: TMenuItem;
    mp200: TMenuItem;
    mi201: TMenuItem;
    mp400: TMenuItem;
    mi401: TMenuItem;
    mi402: TMenuItem;
    mp300: TMenuItem;
    mi301: TMenuItem;
    mi302: TMenuItem;
    mi303: TMenuItem;
    mi202: TMenuItem;
    mi403: TMenuItem;
    mi103: TMenuItem;
    mi106: TMenuItem;
    mi107: TMenuItem;
    mp600: TMenuItem;
    mp700: TMenuItem;
    mp800: TMenuItem;
    mp900: TMenuItem;
    Sair1: TMenuItem;
    mi108: TMenuItem;
    mi109: TMenuItem;
    mi203: TMenuItem;
    mi204: TMenuItem;
    mi205: TMenuItem;
    mi206: TMenuItem;
    mi207: TMenuItem;
    mi208: TMenuItem;
    mi209: TMenuItem;
    mi304: TMenuItem;
    mi305: TMenuItem;
    mi306: TMenuItem;
    mi307: TMenuItem;
    mi308: TMenuItem;
    mi309: TMenuItem;
    mi404: TMenuItem;
    mi405: TMenuItem;
    mi406: TMenuItem;
    mi407: TMenuItem;
    mi408: TMenuItem;
    mi409: TMenuItem;
    mi501: TMenuItem;
    mi502: TMenuItem;
    mi503: TMenuItem;
    mi504: TMenuItem;
    mi505: TMenuItem;
    mi506: TMenuItem;
    mi507: TMenuItem;
    mi508: TMenuItem;
    mi509: TMenuItem;
    mi601: TMenuItem;
    mi602: TMenuItem;
    mi603: TMenuItem;
    mi604: TMenuItem;
    mi605: TMenuItem;
    mi607: TMenuItem;
    mi608: TMenuItem;
    mi609: TMenuItem;
    mi701: TMenuItem;
    mi702: TMenuItem;
    mi703: TMenuItem;
    mi704: TMenuItem;
    mi705: TMenuItem;
    mi706: TMenuItem;
    mi707: TMenuItem;
    mi708: TMenuItem;
    mi709: TMenuItem;
    mi801: TMenuItem;
    mi802: TMenuItem;
    mi803: TMenuItem;
    mi804: TMenuItem;
    mi805: TMenuItem;
    mi806: TMenuItem;
    mi807: TMenuItem;
    mi808: TMenuItem;
    mi809: TMenuItem;
    mi901: TMenuItem;
    mi902: TMenuItem;
    mi903: TMenuItem;
    mi904: TMenuItem;
    mi905: TMenuItem;
    mi906: TMenuItem;
    mi907: TMenuItem;
    mi908: TMenuItem;
    mi909: TMenuItem;
    mi606: TMenuItem;
    tbl_usuario: TIBQuery;
    Dbautocom: TIBDatabase;
    IBTransaction1: TIBTransaction;
    mi110: TMenuItem;
    mi111: TMenuItem;
    mi112: TMenuItem;
    mi113: TMenuItem;
    mi114: TMenuItem;
    mi115: TMenuItem;
    mi116: TMenuItem;
    mi117: TMenuItem;
    mi118: TMenuItem;
    mi119: TMenuItem;
    mi120: TMenuItem;
    mi210: TMenuItem;
    mi211: TMenuItem;
    mi212: TMenuItem;
    mi213: TMenuItem;
    mi214: TMenuItem;
    mi215: TMenuItem;
    mi216: TMenuItem;
    mi217: TMenuItem;
    mi218: TMenuItem;
    mi219: TMenuItem;
    mi220: TMenuItem;
    mi310: TMenuItem;
    mi311: TMenuItem;
    mi312: TMenuItem;
    mi313: TMenuItem;
    mi314: TMenuItem;
    mi315: TMenuItem;
    mi316: TMenuItem;
    mi317: TMenuItem;
    mi318: TMenuItem;
    mi319: TMenuItem;
    mi320: TMenuItem;
    mi410: TMenuItem;
    mi411: TMenuItem;
    mi412: TMenuItem;
    mi413: TMenuItem;
    mi414: TMenuItem;
    mi415: TMenuItem;
    mi416: TMenuItem;
    mi417: TMenuItem;
    mi418: TMenuItem;
    mi419: TMenuItem;
    mi420: TMenuItem;
    mi510: TMenuItem;
    mi511: TMenuItem;
    mi512: TMenuItem;
    mi513: TMenuItem;
    mi514: TMenuItem;
    mi515: TMenuItem;
    mi516: TMenuItem;
    mi517: TMenuItem;
    mi518: TMenuItem;
    mi519: TMenuItem;
    mi520: TMenuItem;
    mi610: TMenuItem;
    mi611: TMenuItem;
    mi612: TMenuItem;
    mi613: TMenuItem;
    mi614: TMenuItem;
    mi615: TMenuItem;
    mi616: TMenuItem;
    mi617: TMenuItem;
    mi618: TMenuItem;
    mi619: TMenuItem;
    mi620: TMenuItem;
    mi710: TMenuItem;
    mi711: TMenuItem;
    mi712: TMenuItem;
    mi713: TMenuItem;
    mi714: TMenuItem;
    mi715: TMenuItem;
    mi716: TMenuItem;
    mi717: TMenuItem;
    mi718: TMenuItem;
    mi719: TMenuItem;
    mi720: TMenuItem;
    mi810: TMenuItem;
    mi811: TMenuItem;
    mi812: TMenuItem;
    mi813: TMenuItem;
    mi814: TMenuItem;
    mi815: TMenuItem;
    mi816: TMenuItem;
    mi817: TMenuItem;
    mi818: TMenuItem;
    mi819: TMenuItem;
    mi820: TMenuItem;
    mi910: TMenuItem;
    mi911: TMenuItem;
    mi912: TMenuItem;
    mi913: TMenuItem;
    mi914: TMenuItem;
    mi915: TMenuItem;
    mi916: TMenuItem;
    mi917: TMenuItem;
    mi918: TMenuItem;
    mi919: TMenuItem;
    mi920: TMenuItem;
    Image1: TImage;
    rocadeoperador1: TMenuItem;
    Abondanarosistema1: TMenuItem;
    Timer1: TTimer;
    tbl_permissaosistema: TIBQuery;
    tbl_grupopermissaosistema: TIBQuery;
    tbl_PERMISSAO_USUARIO: TIBQuery;
    suiForm1: TsuiForm;
    MainMenu1: TsuiMainMenu;
    BitBtn1: TsuiButton;
    Panel1: TsuiImagePanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    sol: TShape;
    Label4: TLabel;
    Label5: TLabel;
    skin: TsuiThemeManager;
    procedure mi101Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure suitempBitBtn1Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure Abondanarosistema1Click(Sender: TObject);
    procedure rocadeoperador1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }

  public
    { Public declarations }
    nome_oper:string; // nome do operador
    tipo:string; // nivel de segurança do operador
    codigo_oper:real; // código do operador
    Nivel_atual:string; //nível de segurança do operador ativo.

    tipo_saida,tipo_saida_def:integer;// tipo de saida do sistema

    Nome_opc,Aces_opc,linha_opc,Tipo_opc,Mod_opc,ABrv_opc: array[1..max_opc] of string; // opções armazenas no ACFUNC.CAT
    cod_opc: array [1..max_opc] of integer; // opção armazenada no ACFUNC.CAT.
    Dll_Menu:array[100..999] of string;

    acesso_liberado:boolean;

    path:string;

    Procedure gravaREG(codigo:real;nome,tipo,sist:string); // grava no oper.ini os dados do operador
    function Enche(texto,caracter:string;lado,tamanho:integer):string; // completa uma string com um numero x de caracteres
    Procedure carrega_op; // carrega o operador que está no oper.ini
    Function GetMachineName: AnsiString;// captura o nome da máquina
    function UserName : String;// captura o nome do usuário da rede
    procedure Log(texto:string); // monta o log
    Procedure Monta_Menu;//configura o menu de acordo com o operador
    procedure autoexec;// inicia automaticamente o módulo que está configurado no autocom.ini
    procedure carrega_agentes; // carrega programas agente
    procedure acessa_BDA; // acesso ao módulo de banco de dados
    procedure Finaliza_agentes;// finaliza os agente carregados(quando possível)
    function verifica_licenca:boolean; // verifica a licença de uso do sistema
    procedure configura_tela;// configua a jardinagem da tela.
    procedure habilita_scanner;
    procedure desabilita_scanner;
    function abandonar_sistema:boolean; // rotina para sair do sistema
    function LeINI(strSessao, strChave, strArquivo: string): variant;

  end;

  function Checksun(primitiva:real):shortstring;external 'ECRPT.dll' index 2;
  function ChecksunL:shortstring;external 'ECRPT.dll' index 3;
  function gera_senha(texto:string):shortstring;external 'ECRPT.dll' index 4;
  function verifica_senha(texto:string;ind:integer):shortstring;external 'ECRPT.dll' index 5;

  //{*** SCANNER ***}
  Procedure NCRScanOpen(_COM:BYTE;_BaudRate:DWORD; _ByteSize:BYTE; _Parity:BYTE; _StopBits:BYTE);stdcall; external 'NCRScan.dll';
  procedure NCRScanClose;stdcall; external 'NCRScan.dll';

var
  frm_FATCPR: Tfrm_FATCPR;
  hndl:Thandle;
  a:integer;
  xAtom:Tatom;

  dll,msg:array[0..200] of char;
  dll_ini:string;
implementation

uses tela_login, tela_fim;

{$R *.DFM}

Procedure Tfrm_FATCPR.Monta_Menu;
var
   Menu,Menu_1:TMenuItem;
   a,b:integer;
   s_NomeMenu,s_NomeMenu_1:string;
Begin
//Por: Helder Frederico
//Objetivo: Configurar o lay-out e o acesso ao menu

// Esconde todo o primiro nível do menu

     For a := 0 to (frm_FATCPR.ComponentCount - 1) do
     Begin
        If frm_FATCPR.Components[a] is TMenuItem then
        Begin
           menu_1 := frm_FATCPR.Components[a] as TMenuItem;
           If copy(menu_1.Name,1,2) = 'mp' then
           Begin
                 menu_1.visible:=false;
           End;
        End;
        application.processmessages;
     End;


// Monta a estrutura do menu conforme configuração no banco de dados
     For a := 0 to (frm_FATCPR.ComponentCount - 1) do
     Begin
        If frm_FATCPR.Components[a] is TMenuItem then
        Begin
           menu := frm_FATCPR.Components[a] as TMenuItem;
           If copy(menu.Name,1,2) = 'mi' then
           Begin
              // verifica se existe alguma opção com o id do menu corresondente
              tbl_permissaosistema.close;
              tbl_permissaosistema.sql.clear;
              tbl_permissaosistema.sql.add('select * '+
                                           'from permissaosistema '+
                                           'where idpermissaosistema = '+copy(menu.Name,3,3));
              tbl_permissaosistema.prepare;
              tbl_permissaosistema.open;
              s_NomeMenu:=tbl_permissaosistema.fieldbyname('Permissao').asstring;
              if length(trim(s_NomeMenu))>0 then
              begin
                 menu.Caption :=s_NomeMenu;
                 dll_Menu[StrToInt(copy(menu.Name,3,3))]:= trim(tbl_permissaosistema.fieldbyname('NomeTela').asstring);// este campo contém o nome dos modulos a serem carregados em cada menu

                 // verifica o nível de acesso ao sistema
                 tbl_PERMISSAO_USUARIO.close;
                 tbl_PERMISSAO_USUARIO.sql.clear;
                 tbl_PERMISSAO_USUARIO.sql.add('select * from GRUPOUSUARIO_PERMISSAO WHERE IDGRUPOUSUARIO IN (SELECT IDGRUPOUSUARIO FROM USUARIOSISTEMA WHERE IDUSUARIO='+FLOATTOSTR(codigo_oper)+') AND IDPERMISSAOSISTEMA='+copy(menu.Name,3,3));
                 tbl_PERMISSAO_USUARIO.prepare;
                 tbl_PERMISSAO_USUARIO.open;
                 if (tbl_PERMISSAO_USUARIO.fieldbyname('INSERIR').asstring<>'T') and
                    (tbl_PERMISSAO_USUARIO.fieldbyname('ALTERAR').asstring<>'T') and
                    (tbl_PERMISSAO_USUARIO.fieldbyname('EXCLUIR').asstring<>'T') then
                    begin
                       menu.visible:=false;
                    end
                 else
                    begin

                      // vai verificar se tem ou pode habilitar o primeiro nível do menu
                       For b := 0 to (frm_FATCPR.ComponentCount - 1) do
                          Begin
                             If frm_FATCPR.Components[b] is TMenuItem then
                                Begin
                                   menu_1 := frm_FATCPR.Components[b] as TMenuItem;
                                   If trim(menu_1.Name) = trim('mp'+tbl_permissaosistema.fieldbyname('IDGRUPOPERMISSAO').asstring) then
                                      Begin
                                         if menu_1.visible=false then
                                            begin
                                               // procura o nome do primeiro nível do menu
                                               tbl_grupopermissaosistema.close;
                                               tbl_grupopermissaosistema.sql.clear;
                                               tbl_grupopermissaosistema.sql.add('select * '+
                                                                            'from grupopermissaosistema '+
                                                                            'where idgrupopermissao = '+copy(menu_1.Name,3,3));
                                               tbl_grupopermissaosistema.prepare;
                                               tbl_grupopermissaosistema.open;

                                               s_NomeMenu_1:=tbl_grupopermissaosistema.fieldbyname('NomeGrupo').asstring;
                                               if length(trim(s_NomeMenu_1))>0 then
                                                  begin
                                                     menu_1.visible:=true;
                                                     menu_1.Caption:=s_NomeMenu_1;
                                                     application.processmessages;
                                                  end
                                               else
                                                  begin
                                                     menu_1.visible:=false;
                                                  end;
                                            end;
                                      end;
                                End;
                          End;
                    end;
              end
              else
              begin
                 menu.visible:=false;
              end;
           End;
        End;
     End;
     MainMenu1.MenuAdded;
End;
{-----------------------------------------------------------------------------
  Procedure: LeINI
  Autor:    charles
  Data:      13-abr-2003
  Argumentos: strSessao, strChave, strArquivo: string
  Retorno:    variant
  Le as informações gravadas em qquer arquivo ini.
-----------------------------------------------------------------------------}

function Tfrm_FATCPR.LeINI(strSessao, strChave, strArquivo: string): variant;
begin
    with TIniFile.Create(strArquivo) do
    begin
        Result := ReadString(strSessao, strChave, '');
        Free;
    end;
end;

procedure Tfrm_FATCPR.FormActivate(Sender: TObject);
var m:integer;
    tipo_skin:string;
begin
     tipo_skin:=LeINI('ATCPLUS', 'skin', extractfilepath(application.exename)+'dados\autocom.ini');
     if (tipo_skin='0') or (tipo_skin='') then skin.uistyle:=WinXP;
     if (tipo_skin='1') then skin.uistyle:=BlueGlass;
     if (tipo_skin='2') then skin.uistyle:=DeepBlue;
     if (tipo_skin='3') then skin.uistyle:=MacOS;
     if (tipo_skin='4') then skin.uistyle:=Protein;

     application.processmessages;
     path:=extractfilepath(application.exename)+'Dados\';
     setforegroundwindow(application.handle);
     label5.caption:=Formatdatetime('dddd - dd/mm/yyyy - hh:mm',now);

     if acesso_liberado=true then
        begin
           if verifica_licenca=true then
              begin
                 configura_tela;
                 carrega_op;
                 monta_menu;
                 label1.caption:='OPERADOR DO SISTEMA: '+nome_oper;
                 label2.caption:='ESTAÇÃO DE TRABALHO: '+GetMachineName;
                 label3.caption:='USUÁRIO DA REDE: '+username;
                 log('Acesso ao sistema - '+label1.caption+'|'+label2.caption+'|'+label3.caption);
                 carrega_agentes;
                 desabilita_scanner;
                 habilita_scanner;
                 autoexec;
              end
           else
              begin
                 for m:=0 to MainMenu1.items.count-1 do
                    begin
                       if copy(MainMenu1.items[m].name,1,1)='m' then MainMenu1.items[m].visible:=false;
                    end;
              end;
        end
     else
        begin
           for m:=0 to MainMenu1.items.count-1 do
              begin
                 if copy(MainMenu1.items[m].name,1,1)='m' then MainMenu1.items[m].visible:=false;
              end;
        end;
end;

procedure Tfrm_FATCPR.mi101Click(Sender: TObject);
var
   Menu:TMenuItem;
   s_MenuNome:string;
begin
     menu:= sender as TMenuItem;
     tbl_permissaosistema.close;
     tbl_permissaosistema.sql.clear;
     tbl_permissaosistema.sql.add('select * '+
                                  'from permissaosistema '+
                                  'where idpermissaosistema = '+copy(menu.Name,3,3));
     tbl_permissaosistema.prepare;
     tbl_permissaosistema.open;
     s_MenuNome:=tbl_permissaosistema.fieldbyname('Permissao').asstring;
     dll_ini:=trim(tbl_permissaosistema.fieldbyname('NomeTela').asstring);

     if dll_ini<>'' then
     begin
        strpcopy(dll,dll_ini);
        strpcopy(msg,'Não foi possível carregar o modulo de '+s_MenuNome+'.');

        for a:=0 to MainMenu1.items.count-1 do MainMenu1.items[a].enabled:=false;
        if pos('.dll',dll_ini)>0 then
        begin
           try
              log('Acesso : '+s_MenuNome+' - '+label1.caption+'|'+label2.caption+'|'+label3.caption);
              Hndl:=LoadLibrary(dll);
              if Hndl <> 0 then FreeLibrary(Hndl);
           except
              application.messagebox(msg,'Sistema Autocom', mb_ok);
           end;
        end
        else
        begin
           if pos('.exe',dll_ini)>0 then
              begin
                 strpcopy(dll,dll_ini+' handle '+inttostr(application.handle));
                 winexec(dll,SW_Normal);
              end
           else
              begin
                 winexec(dll,SW_Normal);
              end;
        end;
     end;
     for a:=0 to MainMenu1.items.count-1 do MainMenu1.items[a].enabled:=true;
end;

procedure Tfrm_FATCPR.autoexec;
var
   Menu:TMenuItem;
   ini:TIniFile;
begin
     ini:=TIniFile.Create(path+'Autocom.ini');
     dll_ini:=ini.readstring('MODULOS','dll_autoexec','');
     ini.free;

     if dll_ini='' then exit;
     strpcopy(dll,dll_ini);
     strpcopy(msg,'Não foi possível auto-carregar o modulo '+dll_ini+'.');

     for a:=0 to MainMenu1.items.count-1 do MainMenu1.items[a].enabled:=false;
     if pos('.dll',dll_ini)>0 then
        begin
           try
              log('Acesso automático: '+dll_ini+' - '+label1.caption+'|'+label2.caption+'|'+label3.caption);
              Hndl:=LoadLibrary(dll);
              if Hndl <> 0 then FreeLibrary(Hndl);
           except
              application.messagebox(msg,'Sistema Autocom', mb_ok);
           end;
        end
     else
        begin
           winexec(dll,SW_Normal);
        end;

     for a:=0 to MainMenu1.items.count-1 do MainMenu1.items[a].enabled:=true;

end;

procedure Tfrm_FATCPR.FormCreate(Sender: TObject);
begin
//     {Procura na tabela para verificar se o programa já está rodando}
//     if GlobalFindAtom('RET') = 0 then
//        begin
//          {zero significa não encontrar}
//          xAtom := GlobalAddAtom('RET')
//        end
//     else
//        begin
//          {Se o programa já estiver rodando, então para de executar}
//          Halt;
//        end;
end;

procedure Tfrm_FATCPR.FormDestroy(Sender: TObject);
begin
     {Remove o item da tabela, de modo que a aplicação possa ser executada novamente}
     GlobalDeleteAtom(xAtom);
end;

procedure Tfrm_FATCPR.FormShow(Sender: TObject);
var i:Tinifile;
begin

     path:=extractfilepath(application.exename)+'Dados\';
     try
        try
           i:=TIniFile.Create(path+'Autocom.INI'); // dia 20/08/2002 - Helder Frederico: Se o carrega_db for 1, então chama o Interbase Server, caso contrário, não chama.
           if i.readstring('ATCPLUS','Carrega_DB','0')='1' then
              begin
                 if fileexists('C:\Arquivos de programas\Borland\InterBase\bin\ibguard.exe') then winexec('C:\Arquivos de programas\Borland\InterBase\bin\ibguard.exe',SW_MINIMIZE);
              end;
           i.free;
        except
           setforegroundwindow(application.handle);
        end;
     finally
        setforegroundwindow(application.handle);
     end;
     sleep(1000);
     acessa_BDA;
     frm_login.showmodal;
     frm_FATCPR.Width := 800;
     frm_FATCPR.Height := 600;
end;


Procedure Tfrm_FATCPR.gravaREG(codigo:real;nome,tipo,sist:string);
var operador:Tinifile;
    v_data:string;
begin
     try
        operador:=TIniFile.Create(path+'OPER.INI');
        operador.writeString('OPER', 'Nome',nome);
        operador.writestring('OPER', 'Tipo',tipo);
        operador.writeFloat('OPER', 'Codigo',codigo);

        v_data:=operador.readstring('OPER', 'Data',datetostr(date));
        log('Data de movimento do sistema : - '+v_data+'|'+label1.caption+'|'+label2.caption+'|'+label3.caption);
        if codigo>0 then
           begin
              if strtodate(v_data)<date then
                 begin
                    strpcopy(msg,'A Data de movimento é menor que a data corrente.'+chr(13)+chr(13)+'Deseja alterar a data de movimento de '+v_data+' para '+datetostr(date)+'?');
                    if application.messagebox(msg,'Sistema Autocom', mb_yesno)=mryes then
                       begin
                          operador.writestring('OPER', 'Data',datetostr(date));
                          log('Alteração da data de movimento pelo operador '+nome+'. Nova Data: - '+datetostr(date)+'|'+label1.caption+'|'+label2.caption+'|'+label3.caption);
                       end
                    else
                       begin
                          log('Data de movimento: - '+v_data+'|'+label1.caption+'|'+label2.caption+'|'+label3.caption);
                       end;
                 end
              else
                 begin
                    operador.writestring('OPER', 'Data',v_data);
                    log('Data de movimento: - '+v_data+'|'+label1.caption+'|'+label2.caption+'|'+label3.caption);
                 end;
           end;
     finally
        operador.Free;
     end;
end;



function Tfrm_FATCPR.Enche(texto,caracter:string;lado,tamanho:integer):string;
begin
     while length(texto)<tamanho do
        begin // lado=1, caracteres a esquerda  -  lado=2, caracteres a direita
           if lado = 1 then texto := caracter + texto else texto := texto + caracter;
        end;
     result:=texto;
end;


procedure Tfrm_FATCPR.Log(texto:string); // monta o log
var LOGfile:textfile;
begin
// A função LOG cria um log (em TXT) no mesmo diretório do programa
// com os modulos acessados.
// Isso facilita a depuração de algum eventual BUG no sistema. (tomara q isso não ocorra, mas... ^_^ )

     AssignFile(LOGfile,extractfilepath(application.exename)+'autocom.LOG');
     if not fileexists(extractfilepath(application.exename)+'autocom.LOG') then Rewrite(logfile) else Reset(Logfile);
     Append(logfile);
     Writeln(logfile,datetimetostr(now)+' - '+texto);
     Flush(logfile);
     closefile(logfile);
end;

procedure Tfrm_FATCPR.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     gravaREG(0,'','','ret');
     log('Fim da utilização do sistema - '+label1.caption+'|'+label2.caption+'|'+label3.caption);
     desabilita_scanner;
     finaliza_agentes;
end;

Procedure Tfrm_FATCPR.carrega_op;
var oper:Tinifile;
begin
     try
        oper:=TIniFile.Create(path+'OPER.INI');
        nome_oper:=oper.ReadString('OPER', 'Nome','');
        nivel_atual:=oper.ReadString('OPER', 'Tipo','01');
        codigo_oper:=strtofloat(oper.ReadString('OPER', 'Codigo','0'));
     finally
        oper.Free;
     end;
end;

Function Tfrm_FATCPR.GetMachineName: AnsiString;
Var
   nTam: Cardinal;
Begin
     nTam := 256;
     SetLength( Result, nTam );
     GetComputerName( PChar( Result ), nTam );
     SetLength( Result, nTam );
End;

function Tfrm_FATCPR.UserName : String;
var
   lpBuffer : Array[0..20] of Char;
   nSize : dWord;
   Achou : boolean;
   erro : dWord;
begin
     nSize := 120;
     Achou := GetUserName(lpBuffer,nSize);
     if (Achou) then
        begin
           result := lpBuffer;
        end
     else
        begin
           Erro :=GetLastError();
           result :=IntToStr(Erro);
        end;
end;

procedure Tfrm_FATCPR.carrega_agentes;
var v_ini,v_ini2:tinifile;
begin

     try
        if winexec('C:\Arquivos de programas\ORL\VNC\winvnc.exe',SW_MINIMIZE)>=31 then
           begin
              sol.visible:=true;
           end
        else
           begin
              sol.visible:=faLSE;
           end;
     except
        setforegroundwindow(application.handle);
        sol.visible:=false;
     end;

     try
        try
           winexec('C:\tef_dial\tef_dial.exe',SW_MINIMIZE);
        except
           setforegroundwindow(application.handle);
        end;
     finally
        setforegroundwindow(application.handle);
     end;

     try
        try
           winexec('C:\Tef_Disc\tef_disc.exe',SW_MINIMIZE);
        except
           setforegroundwindow(application.handle);
        end;
     finally
        setforegroundwindow(application.handle);
     end;

     setforegroundwindow(application.handle);
end;


procedure Tfrm_FATCPR.Finaliza_agentes;
begin

end;

procedure Tfrm_FATCPR.acessa_BDA;
vAR TESTE:tHANDLE;
begin
     try
        strPcopy(dll,'DBadmin.dll');
        teste := LoadLibrary(dll);
        FreeLibrary(teste);
     except
        strPcopy(dll,'Não foi possível carregar a BDADMIN.DLL. Entre em contato com o Suporte!');
        FatalAppExit(0,dll);
     end;
end;


function Tfrm_FATCPR.verifica_licenca:boolean;
var
   Reg: TRegistry;
   senha,ret,l:string;
   a,dia:integer;
   ok:boolean;
begin
     Reg:=TRegistry.Create;
     Reg.RootKey:=HKEY_LOCAL_MACHINE;
     if Reg.OpenKey(Registro_win_licenca,False) then
        begin
           senha:=Reg.ReadString('Licenca');
        end;
     Reg.Free;

     for a:=1 to 9 do
        begin
           ret:=verifica_senha(senha,a);
           try
              strtodate(ret);
              L:=ret;
              break;
           except
              L:=ret;
           end;
        end;

     try
        strtodate(L);
        ok:=true;
     except
        for a:=0 to MainMenu1.items.count-1 do MainMenu1.items[a].visible:=false;
        strPcopy(dll,'Este sistema não está liberado!');
        setforegroundwindow(application.handle);
        Application.messagebox(dll,'Sistema Autocom',mb_ok);
        result:=false;
        BitBtn1.visible:=true;
        ok:=false;
     end;

     if ok=true then
        begin
           if date<strtodate(L) then
              begin
                 Reg:=TRegistry.Create;
                 Reg.RootKey:=HKEY_LOCAL_MACHINE;
                 if Reg.OpenKey(Registro_win_licenca,False) then
                    begin
                       ret:=Reg.ReadString('007');
                    end;
                 Reg.Free;

                 if ret='JFK' then
                    begin
                       for a:=0 to MainMenu1.items.count-1 do MainMenu1.items[a].visible:=false;
                       strPcopy(dll,'A licença deste sistema expirou! O sistema está incapacitado de operar.');
                       setforegroundwindow(application.handle);
                       Application.messagebox(dll,'Sistema Autocom',mb_ok);
                       BitBtn1.visible:=true;
                       result:=false;
                    end
                 else
                    begin
                       BitBtn1.visible:=false;
                       result:=true;
                    end;
              end
           else
              begin

                 // grava a trava da lincença
                 Reg:=TRegistry.Create;
                 Reg.RootKey:=HKEY_LOCAL_MACHINE;
                 if Reg.OpenKey(Registro_win_licenca,False) then
                    begin
                       Reg.WriteString('007','JFK');
                    end;
                 Reg.Free;

                 if date-strtodate(L)<7 then
                    begin
                       if date-strtodate(L)=0 then dia:=7;
                       if date-strtodate(L)=1 then dia:=6;
                       if date-strtodate(L)=2 then dia:=5;
                       if date-strtodate(L)=3 then dia:=4;
                       if date-strtodate(L)=4 then dia:=3;
                       if date-strtodate(L)=5 then dia:=2;
                       if date-strtodate(L)=6 then dia:=1;
                       strPcopy(dll,'A licença deste sistema expirou! Regularize a situação o mais breve possível'+chr(13)+'O sistema funcionará normalmente por mais '+inttostr(dia)+' dia(s).');
                       setforegroundwindow(application.handle);
                       Application.messagebox(dll,'Sistema Autocom',mb_ok);
                       BitBtn1.visible:=true;
                       result:=true;
                    end
                 else
                    begin
                       for a:=0 to MainMenu1.items.count-1 do MainMenu1.items[a].visible:=false;
                       strPcopy(dll,'A licença deste sistema expirou! O sistema está incapacitado de operar.');
                       setforegroundwindow(application.handle);
                       Application.messagebox(dll,'Sistema Autocom',mb_ok);
                       BitBtn1.visible:=true;
                       result:=false;
                    end;
              end;
        end;
end;


procedure Tfrm_FATCPR.suitempBitBtn1Click(Sender: TObject);
var teste:thandle;
begin
     try
        strPcopy(dll,'DLATCM.dll');
        teste := LoadLibrary(dll);
        FreeLibrary(teste);
     except
        strPcopy(dll,'Não foi possível carregar a DLATCM.dll . Entre em contato com o Suporte!');
     end;
     abandonar_sistema;
end;


procedure Tfrm_FATCPR.configura_tela;
var v_ini:Tinifile;
begin
     v_ini:=TIniFile.Create(path+'Autocom.ini');
     if fileexists(path+'logo.bmp') then
        begin
           image1.picture.loadfromfile(path+'logo.bmp');
        end
     else
        begin
           if fileexists(v_ini.readstring('LOJA','LojaLogo',path+'logo.bmp')) then
              begin
                 image1.picture.loadfromfile(v_ini.readstring('LOJA','LojaLogo',path+'logo.bmp'));
              end;
        end;

     frm_FATCPR.caption:='Sistema Autocom - '+v_ini.readstring('LOJA','LojaNome','')+' - Loja: '+v_ini.readstring('LOJA','LojaNum','');
     v_ini.free;
end;

procedure Tfrm_FATCPR.habilita_scanner;
var m:array[0..250] of char;
    p:byte;
    v_ini:Tinifile;
    vscnr,vcomscnr:string;
begin
     v_ini:=TIniFile.Create(path+'Autocom.INI');
     vscnr:=v_ini.ReadString('TERMINAL','SCNR','0');            // Indica se tem ou não um scanner parametrizado.
     vcomscnr:=v_ini.READString('TERMINAL','COMSCNR','0');      // porta de comunicação do Scanner
     v_ini.Free;

     if vscnr='1' then
        begin
           try
              p:=strtoint(vcomscnr);
              NCRScanOpen(p,9600,8,0,2);
           except
              strpcopy(m,'Não foi possível configurar a porta de comunicação do scanner: '+vcomscnr);
              application.messagebox(m,'Sistema AUTOCOM',MB_OK);
              Exit;
           end;
        end;
end;

procedure Tfrm_FATCPR.desabilita_scanner;
begin
     NCRScanClose;
end;

procedure Tfrm_FATCPR.Label4Click(Sender: TObject);
begin
     ShellExecute(Handle,'open','http://www.rimaautocom.com.br', '', '',SW_SHOW);
end;

procedure Tfrm_FATCPR.Abondanarosistema1Click(Sender: TObject);
begin
     close;
end;

procedure Tfrm_FATCPR.rocadeoperador1Click(Sender: TObject);
var m:integer;
begin
     frm_login.showmodal;
     if acesso_liberado=true then
        begin
           configura_tela;
           carrega_op;
           monta_menu;
           label1.caption:='OPERADOR DO SISTEMA: '+nome_oper;
           label2.caption:='ESTAÇÃO DE TRABALHO: '+GetMachineName;
           label3.caption:='USUÁRIO DA REDE: '+username;
           log('Acesso ao sistema - '+label1.caption+'|'+label2.caption+'|'+label3.caption);
           carrega_agentes;
           habilita_scanner;
           autoexec;
        end
     else
        begin
           for m:=0 to MainMenu1.items.count-1 do
              begin
                 if copy(MainMenu1.items[m].caption,1,1)='m' then MainMenu1.items[m].visible:=false;
              end;
        end;
end;

function Tfrm_FATCPR.abandonar_sistema:boolean;
begin
     result:=false;
     ffim.showmodal;
     if tipo_saida=2 then
        begin
           result:=true;
        end;
     if tipo_saida=1 then
        begin
           Finaliza_agentes;
           result:=true;
           ExitWindowsEx(EWX_SHUTDOWN,0);// sai do windows!!
        end;
end;

procedure Tfrm_FATCPR.Timer1Timer(Sender: TObject);
begin
     label5.caption:=Formatdatetime('dddd - dd/mm/yyyy - hh:mm',now);
end;

procedure Tfrm_FATCPR.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
     CanClose:=abandonar_sistema;
end;

end.
