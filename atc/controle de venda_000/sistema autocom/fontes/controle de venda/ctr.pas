unit ctr;

interface

uses
  Windows, SysUtils, Classes, Controls, Forms, dialogs,inifiles,
  DBTables, registry, db_i, Db, StdCtrls, IBDatabase, IBCustomDataSet,
  IBQuery, ComCtrls;

type
  Tflogs = class(TForm)
    LogAtual: TIBQuery;
    LogUltimo: TIBQuery;
    Log: TIBQuery;
    DbAutocom: TIBDatabase;
    IBTransaction1: TIBTransaction;
    Label1: TLabel;
    memo1: TRichEdit;
    print: TIBQuery;
  private
  public
    function Enche(texto,caracter:string;lado,tamanho:integer):string;
    function conecta_db:boolean;
    procedure desconecta_db;
    function apaga_cota(texto:string):string;
  end;

var
  flogs: Tflogs;
  path:string;

implementation

{$R *.DFM}
{$D CTRV.DLL}
//******************************************************************************
//******* funções internas da dll
//******************************************************************************

function Tflogs.conecta_db:boolean;
var ini:Tinifile;
    t1,t2:string;
begin
     try
        path:=extractfilepath(application.exename)+'Dados\';
        ini:=TIniFile.Create(path+'autocom.INI');
        t1:=ini.readString('ATCPLUS', 'IP_SERVER', ''); // endereço ip do servidor
        t2:=ini.readString('ATCPLUS', 'PATH_DB', '');     // caminho do banco de dados no servidor
     finally
        ini.Free;
     end;
     try
        flogs.IBTransaction1.active:=false;
        flogs.DbAutocom.connected:=false;
        flogs.DbAutocom.databasename:=t1+':'+t2;
        flogs.DbAutocom.connected:=true;
        flogs.IBTransaction1.active:=true;

        result:=true;
     except
        result:=false;
     end;
end;

procedure Tflogs.desconecta_db;
begin
     flogs.logatual.close;
     flogs.logUltimo.close;
     flogs.log.close;

     flogs.IBTransaction1.active:=false;
     flogs.DBAutocom.connected:=false;
end;

function tflogs.Enche(texto,caracter:string;lado,tamanho:integer):string;
begin
     while length(texto)<tamanho do
        begin // lado=1, caracteres a esquerda  -  lado=2, caracteres a direita
           if lado = 1 then texto := caracter + texto else texto := texto + caracter;
        end;
     result:=texto;
end;

function tflogs.apaga_cota(texto:string):string;
vaR cara:integer;
    texto2:string;
begin
     texto2:='';
       for cara:=1 to length(texto) do
          begin
             if texto[cara]<>chr(39) then texto2:=texto2+texto[cara];
          end;
          result:=texto2;
end;

{*******************************************************************************
|                         funções de exportação da dll                         |
*******************************************************************************}
function Flag_venda(tipo:integer):shortstring;
var
   Reg: textfile;
begin
     if tipo=1 then // indica que está contém venda pendente
        begin
           if fileexists(extractfilepath(application.exename)+'dados\status.vnd') then deletefile(extractfilepath(application.exename)+'dados\status.vnd');
           AssignFile(reg, extractfilepath(application.exename)+'dados\status.vnd');
           Rewrite(REG);
           writeln(reg,'1');
           CloseFile(reg);
           result:='1';
        end;

     if tipo=2 then
        begin
           if fileexists(extractfilepath(application.exename)+'dados\status.vnd') then deletefile(extractfilepath(application.exename)+'dados\status.vnd');
           AssignFile(reg, extractfilepath(application.exename)+'dados\status.vnd');
           Rewrite(REG);
           writeln(reg,'2');
           CloseFile(reg);
           result:='2';
        end;

     if tipo=0 then
        begin
           if fileexists(extractfilepath(application.exename)+'dados\status.vnd') then deletefile(extractfilepath(application.exename)+'dados\status.vnd');
           AssignFile(reg, extractfilepath(application.exename)+'dados\status.vnd');
           Rewrite(REG);
           writeln(reg,'0');
           CloseFile(reg);
           result:='0';
        end;

     if tipo=3 then
        begin
           if fileexists(extractfilepath(application.exename)+'dados\status.vnd') then
              begin
                 AssignFile(reg, extractfilepath(application.exename)+'dados\status.vnd');
                 Reset(REG);
                 readln(reg,result);
                 CloseFile(reg);
              end
           else
              begin
                 result:='0';
              end;
        end;
end;



procedure printgrill(pedido,terminal:integer;nome_pedido,nome_vendedor:string);
var
   a:integer;
   v_codigo, v_quantidade, v_desc, v_obs:string;
   grill:TextFile;
begin
{Objetivo: Realizar a impressão dos produtos em impressoras remotas para produção
Esta função deve ser usadas nos módulos de venda direta, tal como a tela de venda
check-out                                                                       }

     flogs.conecta_db;

     flogs.print.close;
     flogs.print.sql.clear;
     flogs.print.sql.add('select codigoimpressora,caminhoimpressora from impressora order by codigoimpressora;');
     flogs.print.prepare;
     flogs.print.open;

     if flogs.print.IsEmpty=false then
        begin
           flogs.print.first;
           while not flogs.print.eof do
              begin
                 flogs.log.close;
                 flogs.log.sql.clear;
                 flogs.log.sql.add('select pdvdc.codigoproduto, pdvdc.qtde, prod.nomeproduto, pdvcc.NCP '+
                             'from pdv_detalhecupom pdvdc, pdv_cabecalhocupom pdvcc, produto prod , subgrupoproduto sg, grupoproduto g '+
                             'where pdvdc.codigoproduto=prod.codigoproduto '+
                             ' and (pdvdc.situacao<>'+chr(39)+'X'+chr(39)+' or pdvdc.situacao is null)'+
                             ' and pdvdc.cfg_codconfig=pdvcc.cfg_codconfig'+
                             ' and pdvdc.=pdvcc.cfg_codconfig'+
                             ' and pdvdc.cli_codcliente=pdvcc.cli_codcliente'+
                             ' and pdvdc.ven_codvendedor=pdvcc.ven_codvendedor'+
                             ' and pdvdc.idusuario=pdvcc.idusuario'+
                             ' and pdvdc.datahora=pdvcc.datahora'+
                             ' and pdvcc.ncp='+quotedstr(flogs.Enche(inttostr(pedido),'0',1,10))+
                             ' and pdvcc.terminal='+quotedstr(flogs.Enche(inttostr(terminal),'0',1,4))+
                             ' and prod.codigosubgrupoproduto=sg.codigosubgrupoproduto'+
                             ' and sg.codigogrupoproduto=g.codigogrupoproduto'+
                             ' and g.codigoimpressora='+flogs.print.fieldbyname('codigoimpressora').asstring);
                 flogs.log.prepare;
                 flogs.log.open;

                 if flogs.log.IsEmpty=false then
                    begin
                       flogs.logatual.close;
                       flogs.logatual.sql.clear;
                       flogs.logatual.sql.add('select p.pes_nome_a '+
                             'from pessoa p, vendedor v,pedidovenda pv '+
                             'where pv.ven_codvendedor=v.ven_codvendedor '+
                             ' and v.pes_codpessoa=p.pes_codpessoa '+
                             ' and pv.numeropedido='+inttostr(pedido));
                       flogs.logatual.prepare;
                       flogs.logatual.open;

                       flogs.memo1.lines.clear;
                       flogs.memo1.lines.add('******************************');
                       flogs.memo1.lines.add('  '+nome_pedido+' : '+inttostr(pedido));
                       flogs.memo1.lines.add('******************************');
                       flogs.memo1.lines.add('  '+nome_vendedor+' : '+flogs.logatual.fieldbyname('pes_nome_a').asstring);
                       flogs.memo1.lines.add('******************************');
                       flogs.memo1.lines.add('Hora: '+timetostr(time));

                       flogs.log.first;
                       While not flogs.log.eof do
                          Begin
                             v_codigo:=flogs.log.fieldbyname('codigoproduto').asstring;
                             v_quantidade:=flogs.log.fieldbyname('quantidade').asstring;
                             v_desc:=flogs.log.fieldbyname('nomeproduto').asstring;
                             v_obs:=trim(flogs.log.fieldbyname('observacao').asstring);

                             flogs.memo1.lines.add(copy(v_quantidade,1,4)+'.'+copy(v_quantidade,5,3)+' ['+v_desc+']');
                             if length(v_obs)>0 then
                                begin
                                   flogs.memo1.lines.add(v_obs);
                                end;
                             flogs.log.next;
                          End;
                       flogs.memo1.lines.add('-- Sistema Autocom --');
                       flogs.memo1.lines.add(chr(10)+chr(13));
                       flogs.memo1.lines.add(chr(10)+chr(13));
                       flogs.memo1.lines.add(chr(10)+chr(13));
                       flogs.memo1.lines.add(chr(10)+chr(13));

                       AssignFile(grill, trim(flogs.print.fieldbyname('caminhoimpressora').asstring));
                       rewrite(grill);
                       for a:=0 to flogs.Memo1.Lines.count-1 do
                          begin
                             writeln(grill,flogs.Memo1.Lines[a]);
                          end;
                       closefile(grill);
                    end;
                 flogs.print.next;
              end;
        end;

     flogs.desconecta_db;
end;


procedure printgrill2(pedido:integer;nome_pedido,nome_vendedor:string);
var
   a:integer;
   v_codigo, v_quantidade, v_desc, v_obs:string;
   grill:TextFile;
begin
{Objetivo: Realizar a impressão dos produtos em impressoras remotas para produção
Esta função deve ser usadas nos módulos de venda que realizam pedidos de venda  ,
tais como: Venda Pedido, Micro Terminais e Comandas eletrônicas                 }

     flogs.conecta_db;

     flogs.logAtual.close;
     flogs.logAtual.sql.clear;
     flogs.logAtual.sql.add('commit');
     flogs.logAtual.prepare;
     flogs.logAtual.execsql;

     flogs.IBTransaction1.active:=true;

     flogs.print.close;
     flogs.print.sql.clear;
     flogs.print.sql.add('select codigoimpressora,caminhoimpressora,NOMEIMPRESSORA from impressora order by codigoimpressora;');
     flogs.print.prepare;
     flogs.print.open;

     try

     if flogs.print.IsEmpty=false then
        begin
           flogs.print.first;
           while not flogs.print.eof do
              begin
                 flogs.log.close;
                 flogs.log.sql.clear;
                 flogs.log.sql.add('select ppv.codigoproduto, ppv.quantidade, ppv.observacao, prod.nomeproduto, ppv.codigopedidovenda '+
                             'from produtopedidovenda ppv, produto prod ,pedidovenda pv, subgrupoproduto sg, grupoproduto g '+
                             'where ppv.codigoproduto=prod.codigoproduto '+
                             ' and (ppv.impresso<>'+chr(39)+'X'+chr(39)+' or ppv.impresso is null)'+
                             ' and (ppv.cancelado<>'+'1'+' or ppv.cancelado is null)'+
                             ' and ppv.codigopedidovenda=pv.codigopedidovenda'+
                             ' and pv.numeropedido='+inttostr(pedido)+
                             ' and prod.codigosubgrupoproduto=sg.codigosubgrupoproduto'+
                             ' and sg.codigogrupoproduto=g.codigogrupoproduto'+
                             ' and g.codigoimpressora='+flogs.print.fieldbyname('codigoimpressora').asstring +
                             ' ORDER BY ppv.codigoprodutopedido ');
                 flogs.log.prepare;
                 flogs.log.open;

                 if flogs.log.IsEmpty=false then
                    begin
                       flogs.logatual.close;
                       flogs.logatual.sql.clear;
                       flogs.logatual.sql.add('select p.pes_nome_a '+
                             'from pessoa p, vendedor v,pedidovenda pv '+
                             'where pv.ven_codvendedor=v.ven_codvendedor '+
                             ' and v.pes_codpessoa=p.pes_codpessoa '+
                             ' and pv.numeropedido='+inttostr(pedido));
                       flogs.logatual.prepare;
                       flogs.logatual.open;

                       flogs.memo1.lines.clear;
                       flogs.memo1.lines.add('******************************');
                       flogs.memo1.lines.add('  '+nome_pedido+' : '+inttostr(pedido));
                       flogs.memo1.lines.add('******************************');
                       flogs.memo1.lines.add('  '+nome_vendedor+' : '+flogs.logatual.fieldbyname('pes_nome_a').asstring);
                       flogs.memo1.lines.add('******************************');
                       flogs.memo1.lines.add('Hora: '+timetostr(time));

                       flogs.log.first;
                       While not flogs.log.eof do
                          Begin
                             v_codigo:=flogs.log.fieldbyname('codigoproduto').asstring;
                             v_quantidade:=flogs.log.fieldbyname('quantidade').asstring;
                             v_desc:=flogs.log.fieldbyname('nomeproduto').asstring;
                             v_obs:=trim(flogs.log.fieldbyname('observacao').asstring);

                             flogs.memo1.lines.add(copy(v_quantidade,1,4)+'.'+copy(v_quantidade,5,3)+' ['+v_desc+']');
                             if length(v_obs)>0 then
                                begin
                                   flogs.memo1.lines.add(v_obs);
                                end;
                             flogs.logAtual.close;
                             flogs.logAtual.sql.clear;
                             flogs.logAtual.sql.add('update produtopedidovenda set impresso='+chr(39)+'X'+chr(39)+
                             ' where codigoproduto='+v_codigo+
                             ' and codigopedidovenda='+flogs.log.fieldbyname('codigopedidovenda').asstring);
                             flogs.logAtual.prepare;
                             flogs.logAtual.execsql;

                             flogs.log.next;
                          End;
                       flogs.memo1.lines.add('Area de impressao: '+trim(flogs.print.fieldbyname('NOMEIMPRESSORA').asstring));
                       flogs.memo1.lines.add('-- Sistema Autocom --');
                       flogs.memo1.lines.add(chr(10)+chr(13));
                       flogs.memo1.lines.add(chr(10)+chr(13));
                       flogs.memo1.lines.add(chr(10)+chr(13));
                       flogs.memo1.lines.add(chr(10)+chr(13));

                       AssignFile(grill, trim(flogs.print.fieldbyname('caminhoimpressora').asstring));
                       rewrite(grill);
                       for a:=0 to flogs.Memo1.Lines.count-1 do
                          begin
                             writeln(grill,flogs.Memo1.Lines[a]);
                          end;
                       closefile(grill);

                    end;
                 flogs.print.next;
              end;
        end;

        flogs.logAtual.close;
        flogs.logAtual.sql.clear;
        flogs.logAtual.sql.add('commit');
        flogs.logAtual.prepare;
        flogs.logAtual.execsql;
     except
        flogs.logAtual.close;
        flogs.logAtual.sql.clear;
        flogs.logAtual.sql.add('rollback');
        flogs.logAtual.prepare;
        flogs.logAtual.execsql;
     end;
     flogs.desconecta_db;
end;




exports
       flag_venda index 1,
       printgrill index 2,
       printgrill2 index 3;
end.
