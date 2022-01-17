unit dbtab;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Db, DBTables,STDCTRLS,BDE, IBDatabase,inifiles;

type
  Ttab = class(TForm)
    transacao: TIBTransaction;
    dbautocom: TIBDatabase;
  private
    { Private declarations }
  public
    { Public declarations }
    function path_tabelas:boolean; // define os databasename das tabelas.
  end;

var
  tab: Ttab;

implementation

uses DBA;

{$R *.DFM}


function Ttab.path_tabelas:boolean;
var t1,t2:string;
    ini:Tinifile;
begin
     try
        ini:=TIniFile.Create(extractfilepath(application.exename)+'dados\autocom.INI');
        t1:=ini.readString('ATCPLUS', 'IP_SERVER', ''); // endereço ip do servidor
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
        result:=true;
        transacao.active:=false;
        dbautocom.connected:=false;
     except
        result:=false;
     end;
end;

end.
