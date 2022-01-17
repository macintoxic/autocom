unit atcconc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Menus, ExtCtrls, Db, DBTables,inifiles, StdCtrls, filectrl, IBDatabase,
  IBCustomDataSet, IBQuery, Buttons,registry,shellapi, SUIMgr,
  SUIImagePanel, SUIButton, SUIMainMenu, SUIForm, SUIThemes, OnGuard, OgUtil,
  SUIDlg,DateUtils;

const
     max_opc=500; // Máximo de opções existentes no sistema;
     Nome_sistema_cabecalho='AutocomPLUS - Cardápio - Delivery Ligth';

type
  Tfrm_FATCPR = class(TForm)
    mp100: TMenuItem;
    mi101: TMenuItem;
    mi105: TMenuItem;
    mp200: TMenuItem;
    mp300: TMenuItem;
    mi301: TMenuItem;
    mi302: TMenuItem;
    mi303: TMenuItem;
    mi103: TMenuItem;
    mi107: TMenuItem;
    mp800: TMenuItem;
    Sair1: TMenuItem;
    mi109: TMenuItem;
    mi203: TMenuItem;
    mi207: TMenuItem;
    mi801: TMenuItem;
    mi802: TMenuItem;
    mi803: TMenuItem;
    mi804: TMenuItem;
    mi805: TMenuItem;
    tbl_usuario: TIBQuery;
    Dbautocom: TIBDatabase;
    IBTransaction1: TIBTransaction;
    mi110: TMenuItem;
    mi113: TMenuItem;
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
    msg: TsuiMessageDialog;
    procedure mi101Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
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
    function selecionachave(tipo:string):Tkey;
    function Mensagem(componente_msg:TsuiMessageDialog; tipo:integer; texto:string):TModalResult;

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

  dll:array[0..200] of char;
  dll_ini:string;
implementation

uses tela_login, tela_fim;

{$R *.DFM}

Procedure Tfrm_FATCPR.Monta_Menu;
var
   Menu,Menu_1:TMenuItem;
   a,b:integer;
   s_NomeMenu,s_NomeMenu_1,s_NomeArquivo:string;
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
              s_NomeArquivo:=tbl_permissaosistema.fieldbyname('NomeTela').asstring;//Nome do arquivo a ser executado
              if length(trim(s_NomeMenu))>0 then
              begin
                 if (length(trim(s_NomeArquivo))>0) and (fileexists(s_NomeArquivo)=true) then
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
     suiForm1.caption:=Nome_sistema_cabecalho;
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
        for a:=0 to MainMenu1.items.count-1 do MainMenu1.items[a].enabled:=false;
        if pos('.dll',dll_ini)>0 then
        begin
           try
              log('Acesso : '+s_MenuNome+' - '+label1.caption+'|'+label2.caption+'|'+label3.caption);
              Hndl:=LoadLibrary(dll);
              if Hndl <> 0 then FreeLibrary(Hndl);
           except
              Mensagem(msg, 1,'Não foi possível carregar o modulo de '+s_MenuNome+'.');
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

     for a:=0 to MainMenu1.items.count-1 do MainMenu1.items[a].enabled:=false;
     if pos('.dll',dll_ini)>0 then
        begin
           try
              log('Acesso automático: '+dll_ini+' - '+label1.caption+'|'+label2.caption+'|'+label3.caption);
              Hndl:=LoadLibrary(dll);
              if Hndl <> 0 then FreeLibrary(Hndl);
           except
              Mensagem(msg, 1,'Não foi possível auto-carregar o modulo de '+dll_ini+'.');
           end;
        end
     else
        begin
           winexec(dll,SW_Normal);
        end;

     for a:=0 to MainMenu1.items.count-1 do MainMenu1.items[a].enabled:=true;

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
     frm_FATCPR.Top := 0;
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
        if codigo>0 then
           begin
              if strtodate(v_data)<date then
                 begin
                    if Mensagem(msg, 2,'A última data de movimento registrada é de: '+v_data+chr(13)+
                                       'Deseja alterar a data do movimento para a data atual ('+
                                       datetostr(date)+') ?')=mryes then
                       begin
                          v_data:=datetostr(date);
                          operador.writestring('OPER', 'Data',v_data);
                       end;
                 end;
           end;
     finally
        operador.Free;
     end;
     log('Data de movimento do sistema : - '+v_data+'|'+label1.caption+'|'+label2.caption+'|'+label3.caption);
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

     AssignFile(LOGfile,extractfilepath(application.exename)+'logs\autocom'+formatdatetime('yyyymmdd',date)+'.LOG');
     if not fileexists(extractfilepath(application.exename)+'logs\autocom'+formatdatetime('yyyymmdd',date)+'.LOG') then Rewrite(logfile) else Reset(Logfile);
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
        Mensagem(msg,1,'Não foi possível carregar a BDADMIN.DLL. Entre em contato com o Suporte!');
        FatalAppExit(0,dll);
     end;
end;


function Tfrm_FATCPR.verifica_licenca:boolean;
const
     Registro_win_licenca='\Software\AutocomPLUS\'; // path para grava/leitura do status da licença do sistema (data limite) no registro do windows.
var
   Reg: TRegistry;
   codigo: TCode;
   Chave_liberacao,id_chave:string;
   data_exp:Tdatetime;
   dia:word;
begin
     Reg:=TRegistry.Create;
     Reg.RootKey:=HKEY_LOCAL_MACHINE;
     if Reg.OpenKey(Registro_win_licenca+extractfilepath(application.exename),true) then
        begin
           Chave_liberacao:=Reg.ReadString('Licenca');
           id_chave:=Reg.ReadString('IDCL');
        end;
     Reg.Free;

     HexToBuffer(Chave_liberacao, Codigo, SizeOf(Codigo));
     if not IsSpecialCodeValid(selecionachave(id_chave), Codigo) then
        begin
           Mensagem(msg, 1, 'Este sistema não está liberado!');
           setforegroundwindow(application.handle);
           result:=false;
           BitBtn1.visible:=true;
        end
     else
        begin
           if IsSpecialCodeExpired(selecionachave(id_chave), Codigo) then
              begin
                 Mensagem(msg, 1, 'A licença deste sistema expirou! O sistema está incapacitado de operar.');
                 setforegroundwindow(application.handle);
                 BitBtn1.visible:=true;
                 result:=false;
              end
           else
              begin
                 data_exp:=GetExpirationDate(selecionachave(id_chave),Codigo);
                 if (data_exp-date<7) {or ((data_exp-date>0))} then
                    begin

                       Mensagem(msg, 1, 'A licença deste sistema está expirando! Regularize a situação o mais breve possível.'+
                                                 chr(13)+'O sistema funcionará normalmente por mais '+
                                                 inttostr(DaysBetween(date,data_exp))+' dia(s).');
                       setforegroundwindow(application.handle);
                       BitBtn1.visible:=true;
                       result:=true;
                    end
                 else
                    begin
                       BitBtn1.visible:=false;
                       result:=true;
                    end;
              end;
        end;
end;

procedure Tfrm_FATCPR.suitempBitBtn1Click(Sender: TObject);
var teste:thandle;
begin
     try
        strpcopy(dll,extractfilepath(application.exename)+'psnt.exe handle '+inttostr(application.handle));
        winexec(dll,SW_Normal);
     except
        setforegroundwindow(application.handle);
     end;
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

     frm_FATCPR.caption:=Nome_sistema_cabecalho+' - '+v_ini.readstring('LOJA','LojaNome','')+' - Loja: '+v_ini.readstring('LOJA','LojaNum','');
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
     ShellExecute(Handle,'open','http://www.autocomplus.com.br', '', '',SW_SHOW);
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


function Tfrm_FATCPR.selecionachave(tipo:string):Tkey;
const
  Key00 : TKey = ($E8,$B5,$DF,$7F,$F7,$01,$C6,$4A,$24,$08,$02,$DC,$B0,$78,$CC,$43);
  Key01 : TKey = ($13,$F3,$1C,$32,$9F,$40,$C9,$A1,$AA,$6E,$66,$30,$F4,$E4,$33,$BD);
  Key02 : TKey = ($B3,$9E,$C6,$3F,$7E,$7E,$A6,$DA,$43,$1C,$C6,$AD,$95,$F9,$AB,$23);
  Key03 : TKey = ($B3,$9E,$C6,$3F,$7E,$7E,$A6,$DA,$43,$1C,$C6,$AD,$95,$F9,$AB,$23);
  Key04 : TKey = ($D5,$61,$4D,$7B,$D9,$59,$E1,$D0,$81,$67,$24,$A4,$24,$A1,$2A,$5E);
  Key05 : TKey = ($90,$07,$B2,$D6,$10,$E0,$A7,$1B,$81,$74,$15,$12,$FE,$42,$EF,$99);
  Key06 : TKey = ($4A,$18,$4F,$AF,$F4,$25,$CE,$89,$1D,$64,$16,$12,$DF,$1A,$E5,$CD);
  Key07 : TKey = ($99,$5D,$1A,$60,$DD,$4D,$A6,$49,$B8,$2A,$19,$51,$88,$22,$FB,$0D);
  Key08 : TKey = ($1B,$8D,$5E,$42,$21,$ED,$FE,$96,$F8,$19,$4C,$17,$99,$76,$96,$EF);
  Key09 : TKey = ($B3,$F8,$F2,$45,$AD,$B8,$DA,$B9,$16,$60,$A9,$0D,$49,$08,$3C,$3C);
  Key10 : TKey = ($BD,$B4,$2A,$40,$61,$67,$1A,$40,$14,$49,$AE,$5F,$9D,$A5,$3B,$3F);
  Key11 : TKey = ($C6,$C5,$F3,$8A,$BE,$3E,$1E,$DC,$D6,$76,$9B,$6C,$2D,$44,$7D,$D7);
  Key12 : TKey = ($75,$2D,$1D,$6F,$E1,$E1,$0B,$2A,$27,$7D,$FF,$20,$60,$EA,$79,$66);
  Key13 : TKey = ($BC,$78,$DB,$E1,$F2,$0C,$A6,$BC,$00,$AE,$21,$3E,$77,$87,$7B,$CF);
  Key14 : TKey = ($8F,$B7,$6C,$B2,$57,$52,$C9,$44,$40,$83,$2E,$5E,$7F,$CC,$2E,$05);
  Key15 : TKey = ($40,$E0,$9C,$4B,$1C,$30,$FD,$F5,$C1,$38,$05,$8B,$31,$DA,$08,$16);
  Key16 : TKey = ($2D,$5B,$AE,$EF,$3A,$71,$77,$9C,$3E,$02,$25,$8F,$39,$80,$07,$78);
  Key17 : TKey = ($F5,$B7,$AA,$34,$6B,$9D,$3A,$DF,$3B,$1A,$55,$67,$79,$03,$25,$89);
  Key18 : TKey = ($DD,$ED,$1B,$4E,$67,$18,$E6,$D3,$D2,$76,$15,$45,$80,$18,$87,$4C);
  Key19 : TKey = ($6E,$94,$DE,$3D,$D0,$03,$94,$FC,$D3,$27,$24,$68,$D1,$7C,$74,$49);
  Key20 : TKey = ($EF,$BD,$F4,$64,$66,$8E,$AB,$F0,$10,$EB,$A0,$0F,$88,$AD,$FA,$DB);
  Key21 : TKey = ($90,$06,$EF,$09,$68,$49,$65,$98,$F1,$DB,$91,$AA,$29,$5D,$E3,$89);
  Key22 : TKey = ($7C,$8B,$37,$85,$5C,$24,$A3,$37,$F0,$A4,$32,$99,$32,$44,$98,$D5);
  Key23 : TKey = ($A8,$99,$DF,$1E,$44,$51,$CD,$81,$F8,$06,$27,$74,$6D,$BC,$4B,$2E);
var
   vetor:string;
begin
     vetor:=tipo;
     if tipo='' then vetor:=copy(formatdatetime('hh:nn:ss',time),1,2); // tipo vazio significa q é para gerar a chave de acordo com a hora

     if vetor ='00' then result:=key00;
     if vetor ='01' then result:=key01;
     if vetor ='02' then result:=key02;
     if vetor ='03' then result:=key03;
     if vetor ='04' then result:=key04;
     if vetor ='05' then result:=key05;
     if vetor ='06' then result:=key06;
     if vetor ='07' then result:=key07;
     if vetor ='08' then result:=key08;
     if vetor ='09' then result:=key09;
     if vetor ='10' then result:=key10;
     if vetor ='11' then result:=key11;
     if vetor ='12' then result:=key12;
     if vetor ='13' then result:=key13;
     if vetor ='14' then result:=key14;
     if vetor ='15' then result:=key15;
     if vetor ='16' then result:=key16;
     if vetor ='17' then result:=key17;
     if vetor ='18' then result:=key18;
     if vetor ='19' then result:=key19;
     if vetor ='20' then result:=key20;
     if vetor ='21' then result:=key21;
     if vetor ='22' then result:=key22;
     if vetor ='23' then result:=key23;
end;

function Tfrm_FATCPR.Mensagem(componente_msg:TsuiMessageDialog; tipo:integer; texto:string):TModalResult;
begin
     if tipo=1 then // informacao
        begin
           componente_msg.Button1caption:='OK';
           componente_msg.Button1ModalResult:=mrOK;
           componente_msg.ButtonCount:=1;
           componente_msg.Icontype:=suiInformation;
        end;
     if tipo=2 then // pergunta
        begin
           componente_msg.Button1caption:='SIM';
           componente_msg.Button1ModalResult:=mrYES;
           componente_msg.Button2caption:='NÃO';
           componente_msg.Button2ModalResult:=mrNO;
           componente_msg.ButtonCount:=2;
           componente_msg.Icontype:=suiHelp;
        end;
     componente_msg.text:=texto;
     componente_msg.uistyle:=skin.uistyle;
     result:=componente_msg.ShowModal;
end;

end.
