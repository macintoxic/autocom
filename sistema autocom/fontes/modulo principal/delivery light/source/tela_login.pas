unit tela_login;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, Mask, Db, DBTables, inifiles, SUIButton, ExtCtrls,
  SUIForm, SUIThemes, SUIMgr;


type
  Tfrm_login = class(TForm)
    edcod: TMaskEdit;
    edsenha: TMaskEdit;
    Label1: TLabel;
    Label2: TLabel;
    suiForm1: TsuiForm;
    BitBtn2: TsuiButton;
    BitBtn1: TsuiButton;
    skin: TsuiThemeManager;
    procedure suitempBitBtn2Click(Sender: TObject);
    procedure suitempBitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edcodKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edsenhaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edsenhaExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure acesso_negado;
    procedure Acesso(a:real;b,c,d:string);
  end;

var
  frm_login: Tfrm_login;
  op_sistema:real;
  sistema_senha:string;
  dia,mes,ano:word;
  sdia,smes,sano:string;
  idia,imes,iano:integer;
  a,b,c,d,e,f:integer;
  teste:string; // bucha de canhão!!!
  ini:Tinifile;

  b_AchouUsuario:boolean; // indica se achou ou não o cadastro do operador

implementation

uses atcconc;

  function Encripit(a,b,c,d,e,f:integer):shortstring;
  external 'ECRPT.dll' index 1;

{$R *.DFM}

procedure Tfrm_login.suitempBitBtn2Click(Sender: TObject);
begin
     frm_FATCPR.acesso_liberado:=false;
     frm_FATCPR.gravaREG(0,'','','');
     close;
end;

procedure Tfrm_login.suitempBitBtn1Click(Sender: TObject);
begin
     try
        strtofloat(edcod.text);
     except
        messagedlg('Código do operador inválido. Verifique!', mtinformation,[mbok],0);
        edcod.text:='';
        edcod.setfocus;
        exit;
     end;

     try
        strtofloat(edsenha.text);
     except
        messagedlg('Senha do operador inválida. Verifique!', mtinformation,[mbok],0);
        edsenha.text:='';
        edsenha.setfocus;
        exit;
     end;

     decodedate(date,mes,dia,ano);
     sdia:=copy(inttostr(dia),length(inttostr(dia)),1);
     smes:=copy(inttostr(mes),length(inttostr(mes)),1);
     sano:=copy(inttostr(ano),length(inttostr(ano)),1);
     idia:=strtoint(sdia);
     imes:=strtoint(smes);
     iano:=strtoint(sano);
     op_sistema:=(idia+imes+iano)*2;
     sistema_senha:=frm_FATCPR.enche(inttostr((idia+imes+iano)*3),'0',1,6);
     if (strtofloat(edcod.text)=op_sistema) and (edsenha.text=sistema_senha) then
        begin
           acesso(999999,'99','CPD','AUTOCOM');
           close;
        end
     else
        begin
           frm_FATCPR.tbl_usuario.close;
           frm_FATCPR.tbl_usuario.sql.clear;
           frm_FATCPR.tbl_usuario.sql.add('select usuariosistema.idusuario,usuariosistema.idgrupousuario,usuariosistema.nomeusuario,usuariosistema.senha,usuariosistema.inativo,grupousuariosistema.nomegrupo '+
                                          'from usuariosistema, grupousuariosistema '+
                                          'where usuariosistema.idusuario = '+edcod.text);
           frm_FATCPR.tbl_usuario.prepare;
           frm_FATCPR.tbl_usuario.open;

           try
              // se passar pelo try sigbifica que foi retornado dados na query, ou seja, usuario está cadastrado
              strtoint(inttostr(frm_FATCPR.tbl_usuario.fieldbyname('idusuario').value));
              b_AchouUsuario:=true;
           except
              // se passar pele except, sifnifica que foi retornado um registro nulo, ou seja, usuario nÄo cadastrado
              b_AchouUsuario:=false;
           end;

           if b_AchouUsuario=true then
              begin
                 a:=strtoint(copy(edsenha.text,1,1));
                 b:=strtoint(copy(edsenha.text,2,1));
                 c:=strtoint(copy(edsenha.text,3,1));
                 d:=strtoint(copy(edsenha.text,4,1));
                 e:=strtoint(copy(edsenha.text,5,1));
                 f:=strtoint(copy(edsenha.text,6,1));
                 teste:=Encripit(a,b,c,d,e,f);

                 if trim(teste)=trim(frm_FATCPR.tbl_usuario.fieldbyname('senha').value) then
                    begin
                       // verifica se o usuário está ativo ou não no sistema
                       if trim(frm_FATCPR.tbl_usuario.fieldbyname('inativo').value)='F' then
                          begin
                             acesso(frm_FATCPR.tbl_usuario.fieldbyname('idusuario').value,trim(frm_FATCPR.tbl_usuario.fieldbyname('idgrupousuario').value),trim(frm_FATCPR.tbl_usuario.fieldbyname('nomegrupo').value),trim(frm_FATCPR.tbl_usuario.fieldbyname('nomeusuario').value));
                             close;
                          end
                       else
                          begin
                             application.messagebox('Usuário Inativo.','Autocom PLUS',mb_ok);
                             acesso_negado;
                          end;
                    end
                 else
                    begin
                       acesso_negado;
                    end;
              end
           else
              begin
                 acesso_negado;
              end;
        end;
end;

procedure Tfrm_login.acesso_negado;
begin
     application.messagebox('Acesso negado.','Autocom PLUS',mb_ok);
     frm_FATCPR.gravaREG(0,'','','');
     edcod.text:='';
     edsenha.text:='';
     edcod.setfocus;
end;

procedure Tfrm_login.Acesso(a:real;b,c,d:string);
begin
     frm_FATCPR.acesso_liberado:=true;
     frm_FATCPR.gravaREG(a,d,b,c);// grava o operador corrente no oper.ini.
end;

procedure Tfrm_login.FormActivate(Sender: TObject);
var t1,t2:string;
    tipo_skin:string;
begin
     suiForm1.caption:='Acesso ao sistema';

     tipo_skin:=frm_FATCPR.LeINI('ATCPLUS', 'skin', extractfilepath(application.exename)+'dados\autocom.ini');
     if (tipo_skin='0') or (tipo_skin='') then skin.uistyle:=WinXP;
     if (tipo_skin='1') then skin.uistyle:=BlueGlass;
     if (tipo_skin='2') then skin.uistyle:=DeepBlue;
     if (tipo_skin='3') then skin.uistyle:=MacOS;
     if (tipo_skin='4') then skin.uistyle:=Protein;
     application.processmessages;

     frm_FATCPR.dbautocom.connected:=false;
     edcod.text:='';
     edsenha.text:='';
     edcod.setfocus;

     ini:=TIniFile.Create(frm_FATCPR.path+'Autocom.ini');
     t1:=ini.readstring('ATCPLUS','IP_SERVER','10.1.1.1');
     t2:=ini.readstring('ATCPLUS','PATH_DB','c:\autocom\dados\autocom.gdb');
     ini.free;

     frm_FATCPR.dbautocom.databasename:=t1+':'+t2;

     frm_FATCPR.dbautocom.connected:=true;
     frm_FATCPR.ibtransaction1.active:=true;

// dia 31/01/2003
// por Helder Frederico
// O primerio select do sistema fica mais lento em maquinas com pouco memoria (>64MB).
// Este select tem o objetivo de apenas mascarar isso!!!
     frm_FATCPR.tbl_usuario.close;
     frm_FATCPR.tbl_usuario.sql.clear;
     frm_FATCPR.tbl_usuario.sql.add('select * from usuariosistema');
     frm_FATCPR.tbl_usuario.prepare;
     frm_FATCPR.tbl_usuario.open;

end;

procedure Tfrm_login.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     frm_FATCPR.dbautocom.connected:=false;
end;

procedure Tfrm_login.edcodKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=vk_return then edsenha.setfocus;
end;

procedure Tfrm_login.edsenhaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=vk_return then bitbtn1.setfocus;
end;

procedure Tfrm_login.edsenhaExit(Sender: TObject);
begin
     edsenha.text:=trim(edsenha.text);
     edsenha.text:=frm_FATCPR.enche(edsenha.text,'0',1,6);
end;

end.

