unit tefdisc;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,inifiles;

type

//********* DLL para o Impressor Fiscal
tFecharCupom   = function (tipo,porta:integer; SegCp,CNFV,l1,l2,l3,l4,l5,l6,l7,l8:string):shortstring;
tTextoNF       = function (tipo,porta:integer;texto,valor:string):shortstring;
tLeituraX      = function (tipo,porta:integer;NF:string):shortstring;
Tcnfv          = function (tipo,porta:integer) : shortstring;




  TFTEFDISC = class(TForm)
    memo: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
    Msg_oper:string;
  end;

var
  FTEFDISC: TFTEFDISC;
  arq:Textfile;
  tempo:tdatetime;
  ok:boolean;
  nome_rede:string;
  finalizacao:string;
  retorno:string;
  data:string;
  hora:string;
  nsu:string;
  linha:array[1..10000] of string;
  i:integer;
  path_req:string;  //path de requerimento de transação
  path_resp:string; //path de resposta da transação

  FecharCupom:tFecharCupom;
  TextoNF:tTextoNF;
  LeituraX:tLeituraX;
  cnfv:Tcnfv;
  hndl:thandle;

implementation

uses msg;

{$R *.DFM}

function procura(cmd:string):string;
var a:integer;
    t,p:string;
begin
     result:='';
     for a:=1 to 10000 do
        begin
           if copy(linha[a],1,7)=cmd then
              begin
                 t:=copy(linha[a],11,length(linha[a]));
                 while pos('"',t)>0 do delete(t,pos('"',t),1);
                 if pos('VALOR:',t)>0 then
                    begin
                       if trim(nome_rede)='REDECARD' then
                          begin
//                             O conteúdo do campo valor dos cupons da redecard
//                             nao devem ser alterados,logo R$ 0,01 é impresso como 1
//                             p:=copy(t,8,12);
//                             try
//                                p:=floattostr(strtofloat(p)/100);
//                             except
//                                p:=p;
//                             end;
//                             t:='VALOR: '+P;
                          end
                       else
                          begin
                             if pos(',',t)<=0 then
                                begin
                                   p:=copy(t,8,12);
                                   p:=copy(p,1,length(p)-2)+','+copy(p,length(p)-1,2);
                                   t:='VALOR: '+P;
                                end;
                          end;
                    end;
                 result:=t;
                 break;
              end;
        end;
end;

function Enche(texto,caracter:string;lado,tamanho:integer):string;
begin
     while length(texto)<tamanho do
        begin // lado=1, caracteres a esquerda  -  lado=2, caracteres a direita
           if lado = 1 then texto := caracter + texto else texto := texto + caracter;
        end;
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

     while pos('.',texto)>0 do delete(texto,pos('.',texto),1);
     while pos(',',texto)>0 do delete(texto,pos(',',texto),1);
     result:=texto;
end;

procedure tipo_path(tipo:string);
begin
      if tipo='0' then // significa que a transação é para a bandeira TECBAN
         begin
            path_req:='c:\tef_disc\req\';
            path_resp:='c:\tef_disc\resp\';
         end;
      if tipo='1' then // significa que a transação é para as badeira visanet, amex ou redecard
         begin
            path_req:='C:\tef_dial\req\';
            path_resp:='c:\tef_dial\resp\';
         end;
end;


procedure tef_nao_confirma_venda(id,coo,rede,finalizacao,tipo,valor:string);
var Autocom :TIniFile;
begin
      tipo_path(tipo);
      deletefile(path_req+'intpos.tmp');
         AssignFile(arq,path_req+'intpos.tmp');
         Rewrite(arq);
         writeln(arq,'000-000 = NCN');
         writeln(arq,'001-000 = '+id);
         writeln(arq,'002-000 = '+coo);
         writeln(arq,'010-000 = '+rede);
         writeln(arq,'027-000 = '+finalizacao);
         writeln(arq,'999-999 = 0');
         closefile(arq);
         try
            renamefile(path_req+'intpos.tmp',path_req+'intpos.001');
         except
            showmessage('Não foi possível renomer o arquivo intpos.tmp');
         end;

         ok:=false;
         i:=1;
         tempo:=time;
         while (time-tempo)<=strtotime('00:00:10') do
            begin
               if fileexists(path_resp+'intpos.sts')=true then
                  begin
                     if fileexists(path_resp+'intpos.001') then
                        begin
                           AssignFile(arq,path_resp+'intpos.001');
                           reset(arq);
                           while not eof(arq) do
                              begin
                                 readln(arq,linha[i]);
                                 i:=i+1;
                              end;
                           closefile(arq);
                        end;
                     ok:=true;
                     break;
                  end;
            end;

         if ok=true then
            begin
               application.processmessages;
               nome_rede:=rede;
               finalizacao:=finalizacao;
               try
                  Autocom :=TIniFile.Create(extractfilepath(application.exename)+'atctefdi.ini');
                  nsu:=Autocom.readString('TEF DISCADO', 'nsu'        , '');
                  valor:=Autocom.readString('TEF DISCADO', 'valor'        , '');
               finally
                  Autocom.Free;
               end;

                     try
                        strtofloat(trim(valor));// caso tenha o valor do pagamento, mostra a mensagem com o valor
                        messagedlg('Última transação TEF foi cancelada.'+chr(13)+'Rede: '+nome_rede+chr(13)+'NSU: '+nsu+chr(13)+'Valor: '+valor,mtwarning,[mbok],0);
                     except
                        messagedlg('Última transação TEF foi cancelada.'+chr(13)+'Rede: '+nome_rede+chr(13)+'NSU: '+nsu+chr(13),mtwarning,[mbok],0);
                     end;
            end;

         deletefile(path_resp+'intpos.001');
         deletefile(path_resp+'intpos.sts');

         Autocom:=TIniFile.Create(extractfilepath(application.exename)+'atctefdi.ini');
         Autocom.writeString('TEF DISCADO', 'msgop'      , 'Última transação TEF foi cancelada.'+chr(13)+'Rede: '+nome_rede+chr(13)+'NSU: '+nsu+chr(13)+'Valor: '+valor);
         Autocom.Free;
end;

procedure tef_confirma_venda(id,coo,rede,finalizacao,tipo:string);
var autocom:Tinifile;
begin
      tipo_path(tipo);
      deletefile(path_req+'intpos.tmp');

         AssignFile(arq,path_req+'intpos.tmp');
         Rewrite(arq);
         writeln(arq,'000-000 = CNF');
         writeln(arq,'001-000 = '+id);
         writeln(arq,'002-000 = '+coo);
         writeln(arq,'010-000 = '+rede);
         writeln(arq,'027-000 = '+finalizacao);
         writeln(arq,'999-999 = 0');
         closefile(arq);

         try
            renamefile(path_req+'intpos.tmp',path_req+'intpos.001');
         except
            showmessage('Não foi possível renomer o arquivo intpos.tmp');
         end;

         ok:=false;
         i:=1;
         tempo:=time;
         while (time-tempo)<=strtotime('00:00:10') do
            begin
               if fileexists(path_resp+'intpos.sts')=true then
                  begin
                     ok:=true;
                     break;
                  end;
            end;

         if ok=true then
            begin
            end;

      deletefile(path_resp+'intpos.001');
      deletefile(path_resp+'intpos.sts');
     try
        Autocom:=TIniFile.Create(extractfilepath(application.exename)+'atctefdi.ini');
        Autocom.writeString('TEF DISCADO', 'id'         , '');
        Autocom.writeString('TEF DISCADO', 'coo'        , '');
        Autocom.writeString('TEF DISCADO', 'valor'      , '');
        Autocom.writeString('TEF DISCADO', 'rede'       , '');
        Autocom.writeString('TEF DISCADO', 'finalizacao', '');
        Autocom.writeString('TEF DISCADO', 'data'       , '');
        Autocom.writeString('TEF DISCADO', 'hora'       , '');
        Autocom.writeString('TEF DISCADO', 'nsu'        , '');
     finally
        Autocom.Free;
     end;

end;

function id_tef(tipo:integer):string;
var tef:tinifile;
    c:real;
begin
     tef:=TIniFile.Create(extractfilepath(application.exename)+'\dados\autocom.INI');
     c:=strtofloat(tef.ReadString('TEF','contador','0'));
     tef.Free;

     if tipo=1 then
        begin
           tef:=TIniFile.Create(extractfilepath(application.exename)+'\dados\autocom.INI');
           tef.writeString('TEF', 'contador', floattostr(c+1));
           tef.Free;
        end;

     result:=floattostr(c);
end;


function abre_comprovante(tipo:string):boolean;
var
   _ok:boolean;
   v_DLL_ECF:array[0..250] of char;
   autocom:Tinifile;
   resposta:string;
   vpdvnum,vModECF,vCOMECF:string;
   id, coo, valor,rede,finalizacao, data,hora, nsu:string;
begin
     try
        Autocom:=TIniFile.Create(extractfilepath(application.exename)+'dados\autocom.INI');
        strpcopy(v_DLL_ECF,Autocom.ReadString('MODULOS', 'dll_ECF', '')); // Nome da Dll para comunicação com o ECF
     finally
        Autocom.Free;
     end;

     try
        Autocom:=TIniFile.Create(extractfilepath(application.exename)+'dados\autocom.INI');
        vpdvnum:=Autocom.ReadString('TERMINAL', 'PDVNum', '000');    // Número do PDV
        vModECF:=Autocom.ReadString('TERMINAL', 'ModECF', '99');     // modelo do ECf
        vCOMECF:=Autocom.ReadString('TERMINAL', 'COMECF', '1');      // porta de comunicação do ECF
     finally
        Autocom.Free;
     end;

     try
        Autocom:=TIniFile.Create(extractfilepath(application.exename)+'atctefdi.ini');
        id          :=Autocom.readString('TEF DISCADO', 'id'         , '');
        coo         :=Autocom.readString('TEF DISCADO', 'coo'        , '');
        valor       :=Autocom.readString('TEF DISCADO', 'valor'      , '');
        rede        :=Autocom.readString('TEF DISCADO', 'rede'       , '');
        finalizacao :=Autocom.readString('TEF DISCADO', 'finalizacao', '');
        data        :=Autocom.readString('TEF DISCADO', 'data'       , '');
        hora        :=Autocom.readString('TEF DISCADO', 'hora'       , '');
        nsu         :=Autocom.readString('TEF DISCADO', 'nsu'        , '');
     finally
        Autocom.Free;
     end;

     _ok:=true;
     while _ok=true do
        begin
           try
              hndl:=LoadLibrary(v_DLL_ECF);
              if tipo='0' then
                 begin
                    @cnfv:= GetProcAddress(hndl, 'cnfv');
                    resposta:=cnfv(strtoint(vmodecf),strtoint(vcomecf));
                 end;

              if tipo='1' then
                 begin
                    @lEITURAX:= GetProcAddress(hndl, 'LeituraX');
                    resposta:=LeituraX(strtoint(vmodecf),strtoint(vcomecf),'1');
                 end;
           finally
              FreeLibrary(hndl);
           end;

           if (copy(resposta,1,1)<>'@') and (copy(resposta,1,1)<>'!') then
              begin
                 if application.messagebox('Impressora não responde. Tentar imprimir novamente ?','Autcom PLUS',mb_yesno)=mryes then
                    begin
                       _ok:=true;
                    end
                 else
                    begin
                       tef_nao_confirma_venda(id,coo,rede,finalizacao,rede,valor);
                       _ok:=false;
                    end;
              end
           else break;
        end;
     result:=_ok;
end;


//************** FUNCÕES DE EXPORTAÇÃO ***********************

function tef_cartao(coo,valor,tipo:string):shortstring;
var autocom:Tinifile;
    id:string;
begin

try
      tipo_path(tipo);
      id:=id_tef(1);
     deletefile(path_req+'intpos.tmp');
     deletefile(path_resp+'intpos.001');
     deletefile(path_resp+'intpos.sts');

         AssignFile(arq,path_req+'intpos.tmp');
         Rewrite(arq);
         writeln(arq,'000-000 = CRT');
         writeln(arq,'001-000 = '+id);
         writeln(arq,'002-000 = '+coo);
         writeln(arq,'003-000 = '+strtovalor(2,valor));
         writeln(arq,'999-999 = 0');
         closefile(arq);

         renamefile(path_req+'intpos.tmp',path_req+'intpos.001');

         ok:=false;
         tempo:=time;
         while (time-tempo)<=strtotime('00:00:10') do
            begin
               if fileexists(path_resp+'intpos.sts')=true then
                  begin
                     ok:=true;
                     break;
                  end;
            end;

         if ok=true then
            begin
               while not fileexists(path_resp+'intpos.001') do ok:=ok; // espera que o arquivo de status seja criado
               AssignFile(arq,path_resp+'intpos.001');
               reset(arq);
               while not eof(arq) do
                  begin
                     readln(arq,linha[i]);
                     i:=i+1;
                  end;
               closefile(arq);
               if trim(procura('009-000'))='0' then
                  begin
                     nome_rede:=procura('010-000');
                     finalizacao:=procura('027-000');
                     data:=procura('022-000');
                     hora:=procura('023-000');
                     nsu:=procura('012-000');
                     if strtoint(procura('028-000'))>0 then
                        begin
                           AssignFile(arq,extractfilepath(application.exename)+'dados\comprovante.tef');
                           rewrite(arq);
                           for i:=1 to strtoint(procura('028-000')) do
                               begin
                                  writeln(arq,procura('029-'+enche(inttostr(i),'0',1,3)));
                               end;
                           closefile(arq);
                        end;
                     retorno:='2'+procura('030-000'); // retorno=2 significa que foi tudo ok!
                  end
               else
                  begin
                     retorno:='1'+procura('030-000'); // retorno=1 significa que a transação foi negada ou cancelada
                  end;
            end
         else
            begin
               retorno:='1O GERENCIADOR PADRAO NAO ESTA ATIVO'; // retorno=0 significa que o Gerenciador TEF não está ativo
            end;


     Autocom:=TIniFile.Create(extractfilepath(application.exename)+'atctefdi.ini');
     Autocom.writeString('TEF DISCADO', 'id'         , id);
     Autocom.writeString('TEF DISCADO', 'coo'        , coo);
     Autocom.writeString('TEF DISCADO', 'valor'      , valor);
     Autocom.writeString('TEF DISCADO', 'rede'       , nome_rede);
     Autocom.writeString('TEF DISCADO', 'finalizacao', finalizacao);
     Autocom.writeString('TEF DISCADO', 'data'       , data);
     Autocom.writeString('TEF DISCADO', 'hora'       , hora);
     Autocom.writeString('TEF DISCADO', 'nsu'        , nsu);
     Autocom.writeString('TEF DISCADO', 'msgop'      , procura('030-000'));
     Autocom.writeString('TEF DISCADO', 'tipo_rede'  , tipo);
     Autocom.writeString('TEF DISCADO', 'parcelas'  , procura('018-000')); //número de parcelas
     try
        if strtoint(procura('018-000'))>0 then
           begin
              for i:=1 to strtoint(procura('018-000')) do
                 begin
                    Autocom.writeString('TEF DISCADO', 'datapar'+enche(inttostr(i),'0',1,3),procura('019-'+enche(inttostr(i),'0',1,3))); // date de vencimento das parcelas
                    Autocom.writeString('TEF DISCADO', 'valorpar'+enche(inttostr(i),'0',1,3),procura('020-'+enche(inttostr(i),'0',1,3))); // valor das parcelas
                    Autocom.writeString('TEF DISCADO', 'nsupar'+enche(inttostr(i),'0',1,3),procura('021-'+enche(inttostr(i),'0',1,3))); // nsu das parcelas
                 end;
           end;
     except
       //
     end;

     Autocom.Free;

     if not fileexists(extractfilepath(application.exename)+'dados\comprovante.tef') then
        begin
           deletefile(path_resp+'intpos.001');
           deletefile(path_resp+'intpos.sts');
        end;

     result:=retorno;

except
      on e:exception do
         begin
            showmessage('ERRO na DLL:'+e.Message);
         end;
end;

end;


function tef_adm(tipo:string):shortstring;
var autocom:Tinifile;
    COO,valor,id:string;
begin
     tipo_path(tipo);
     id:=id_tef(1);
     if fileexists(path_req+'intpos.tmp')  then deletefile(path_req+'intpos.tmp');
     if fileexists(path_resp+'intpos.001') then deletefile(path_resp+'intpos.001');
     if fileexists(path_resp+'intpos.sts') then deletefile(path_resp+'intpos.sts');

     AssignFile(arq,path_req+'intpos.tmp');
     Rewrite(arq);
     writeln(arq,'000-000 = ADM');
     writeln(arq,'001-000 = '+id);
     writeln(arq,'999-999 = 0');
     closefile(arq);
     renamefile(path_req+'intpos.tmp',path_req+'intpos.001');


         ok:=false;
         tempo:=time;
         while (time-tempo)<=strtotime('00:00:07') do
            begin
               if fileexists(path_resp+'intpos.sts')=true then
                  begin
                     ok:=true;
                     break;
                  end;
            end;

         if ok=true then
            begin
               while not fileexists(path_resp+'intpos.001') do ok:=ok; // espera que o arquivo de status seja criado
               AssignFile(arq,path_resp+'intpos.001');
               reset(arq);
               while not eof(arq) do
                  begin
                     readln(arq,linha[i]);
                     i:=i+1;
                  end;
               closefile(arq);
               if trim(procura('009-000'))='0' then
                  begin
                     nome_rede:=procura('010-000');
                     finalizacao:=procura('027-000');
                     data:=procura('022-000');
                     hora:=procura('023-000');
                     nsu:=procura('012-000');
                     valor:=procura('003-000');
                     try
                        valor:=floattostr((strtofloat(valor)/100));
                     except
                        valor:='';
                     end;

                     if strtoint(procura('028-000'))>0 then
                        begin
                           AssignFile(arq,extractfilepath(application.exename)+'dados\comprovante.tef');
                           rewrite(arq);
                           for i:=1 to strtoint(procura('028-000')) do
                               begin
                                  writeln(arq,procura('029-'+enche(inttostr(i),'0',1,3)));
                               end;
                           closefile(arq);
                        end;
                     retorno:='2'+procura('030-000'); // retorno=2 significa que foi tudo ok!
                  end
               else
                  begin
                     retorno:='1'+procura('030-000'); // retorno=1 significa que a transação foi negada
                  end;
            end
         else
            begin
               retorno:='1O GERENCIADOR PADRAO NAO ESTA ATIVO'; // retorno=0 significa que o Gerenciador TEF não está ativo
            end;

     if not fileexists(extractfilepath(application.exename)+'dados\comprovante.tef') then
        begin
           deletefile(path_resp+'intpos.001');
           deletefile(path_resp+'intpos.sts');
        end;

     if copy(retorno,1,1)='2' then
        begin
           Autocom:=TIniFile.Create(extractfilepath(application.exename)+'atctefdi.ini');
           Autocom.writeString('TEF DISCADO', 'id'         , id);
           Autocom.writeString('TEF DISCADO', 'coo'        , coo);
           Autocom.writeString('TEF DISCADO', 'valor'      , valor);
           Autocom.writeString('TEF DISCADO', 'rede'       , nome_rede);
           Autocom.writeString('TEF DISCADO', 'finalizacao', finalizacao);
           Autocom.writeString('TEF DISCADO', 'data'       , data);
           Autocom.writeString('TEF DISCADO', 'hora'       , hora);
           Autocom.writeString('TEF DISCADO', 'nsu'        , nsu);
           Autocom.writeString('TEF DISCADO', 'msgop'      , procura('030-000'));
           Autocom.writeString('TEF DISCADO', 'tipo_rede'  , tipo);
           Autocom.Free;
        end;

      result:=retorno;
end;

function tef_ativo(tipo:string):shortstring;
var v_DLL_ECF:array[0..250] of char;
    autocom:Tinifile;
    vpdvnum,vModECF,vCOMECF:string;
    id, coo, valor,rede,finalizacao, data,hora, nsu,resposta:string;
begin
      tipo_path(tipo);
      id:=id_tef(1);
      deletefile(path_req+'intpos.tmp');
      if (fileexists(path_resp+'intpos.001')=true) then
         begin
            try
               try
                  Autocom:=TIniFile.Create(extractfilepath(application.exename)+'dados\autocom.INI');
                  strpcopy(v_DLL_ECF,Autocom.ReadString('MODULOS', 'dll_ECF', '')); // Nome da Dll para comunicação com o ECF
               finally
                  Autocom.Free;
               end;

               try
                  Autocom:=TIniFile.Create(extractfilepath(application.exename)+'dados\autocom.INI');
                  vpdvnum:=Autocom.ReadString('TERMINAL', 'PDVNum', '000');    // Número do PDV
                  vModECF:=Autocom.ReadString('TERMINAL', 'ModECF', '99');     // modelo do ECf
                  vCOMECF:=Autocom.ReadString('TERMINAL', 'COMECF', '1');      // porta de comunicação do ECF
               finally
                  Autocom.Free;
               end;

               try
                  Autocom:=TIniFile.Create(extractfilepath(application.exename)+'atctefdi.ini');
                  id          :=Autocom.readString('TEF DISCADO', 'id'         , '');
                  coo         :=Autocom.readString('TEF DISCADO', 'coo'        , '');
                  valor       :=Autocom.readString('TEF DISCADO', 'valor'      , '');
                  rede        :=Autocom.readString('TEF DISCADO', 'rede'       , '');
                  finalizacao :=Autocom.readString('TEF DISCADO', 'finalizacao', '');
                  data        :=Autocom.readString('TEF DISCADO', 'data'       , '');
                  hora        :=Autocom.readString('TEF DISCADO', 'hora'       , '');
                  nsu         :=Autocom.readString('TEF DISCADO', 'nsu'        , '');
               finally
                  Autocom.Free;
               end;


               hndl:=LoadLibrary(v_DLL_ECF);
               @FecharCupom:=GetProcAddress(hndl, 'FecharCupom');
               FecharCupom(strtoint(vmodecf),strtoint(vcomecf),'0','0','','','','','','','','');
               FreeLibrary(hndl);

               if id<>'' then
                  begin
                     tef_nao_confirma_venda(id,coo,rede,finalizacao,rede,valor);
                     retorno:='1Verifique a impressao do ultimo comprovante TEF'; // retorno=1 significa que existe pendencia tef!
                  end;
            finally
               deletefile(path_resp+'intpos.001');
               deletefile(path_resp+'intpos.sts');
               deletefile(extractfilepath(application.exename)+'dados\comprovante.tef');

               Autocom:=TIniFile.Create(extractfilepath(application.exename)+'atctefdi.ini');
               Autocom.writeString('TEF DISCADO', 'id'         , '');
               Autocom.writeString('TEF DISCADO', 'coo'        , '');
               Autocom.writeString('TEF DISCADO', 'valor'      , '');
               Autocom.writeString('TEF DISCADO', 'rede'       , '');
               Autocom.writeString('TEF DISCADO', 'finalizacao', '');
               Autocom.writeString('TEF DISCADO', 'data'       , '');
               Autocom.writeString('TEF DISCADO', 'hora'       , '');
               Autocom.writeString('TEF DISCADO', 'nsu'        , '');
               Autocom.writeString('TEF DISCADO', 'msgop'      , '');
               Autocom.writeString('TEF DISCADO', 'tipo_rede'  , '');
               Autocom.Free;

            end;
            result:=retorno;
         end;

end;

function tef_cheque(coo,valor,data,banco,agencia,agencia_dc,cc,cc_dc,num_cheque,num_cheque_dc,cpfcnpj,tipo_cli,tipo:string):shortstring;
var id:string;
    autocom:Tinifile;
begin
try
      tipo_path(tipo);

      id:=id_tef(1);
      deletefile(path_resp+'intpos.001');
      deletefile(path_resp+'intpos.sts');

         AssignFile(arq,path_req+'intpos.tmp');
         Rewrite(arq);
         writeln(arq,'000-000 = CHQ');
         writeln(arq,'001-000 = '+id);
         writeln(arq,'002-000 = '+coo);
         writeln(arq,'003-000 = '+strtovalor(2,valor));
         writeln(arq,'006-000 = '+tipo_cli);
         writeln(arq,'007-000 = '+cpfcnpj);
         writeln(arq,'008-000 = '+data);
         writeln(arq,'033-000 = '+banco);
         writeln(arq,'034-000 = '+agencia);
         writeln(arq,'035-000 = '+agencia_dc);
         writeln(arq,'036-000 = '+cc);
         writeln(arq,'037-000 = '+cc_dc);
         writeln(arq,'038-000 = '+num_cheque);
         writeln(arq,'039-000 = '+num_cheque_dc);
         writeln(arq,'999-999 = 0');
         closefile(arq);

         try
            renamefile(path_req+'intpos.tmp',path_req+'intpos.001');
         except
            showmessage('Não foi possível renomer o arquivo intpos.tmp');
         end;

         ok:=false;
         tempo:=time;
         while (time-tempo)<=strtotime('00:00:10') do
            begin
               if fileexists(path_resp+'intpos.sts')=true then
                  begin
                     ok:=true;
                     break;
                  end;
            end;

         if ok=true then
            begin
               while not fileexists(path_resp+'intpos.001') do ok:=ok; // espera que o arquivo de status seja criado
               AssignFile(arq,path_resp+'intpos.001');
               reset(arq);
               while not eof(arq) do
                  begin
                     readln(arq,linha[i]);
                     i:=i+1;
                  end;
               closefile(arq);
               if (trim(procura('009-000'))='0') or (trim(procura('009-000'))='P1') then
                  begin
                     nome_rede:=procura('010-000');
                     finalizacao:=procura('027-000');
                     data:=procura('022-000');
                     hora:=procura('023-000');
                     nsu:=procura('012-000');
                     if strtoint(procura('028-000'))>0 then
                        begin
                           AssignFile(arq,extractfilepath(application.exename)+'dados\comprovante.tef');
                           rewrite(arq);
                           for i:=1 to strtoint(procura('028-000')) do
                               begin
                                  writeln(arq,procura('029-'+enche(inttostr(i),'0',1,3)));
                               end;
                           closefile(arq);
                        end;
                     retorno:='2'+procura('030-000'); // retorno=2 significa que foi tudo ok!
                  end
               else
                  begin
                     nome_rede:=procura('010-000');
                     finalizacao:=procura('027-000');
                     data:=procura('022-000');
                     hora:=procura('023-000');
                     nsu:=procura('012-000');
                     retorno:='1'+trim(procura('030-000')); // retorno=1 significa que a transação foi negada
                  end;
            end
         else
            begin
               retorno:='1O GERENCIADOR PADRAO NAO ESTA ATIVO'; // retorno=0 significa que o Gerenciador TEF não está ativo
            end;

     Autocom:=TIniFile.Create(extractfilepath(application.exename)+'atctefdi.ini');
     Autocom.writeString('TEF DISCADO', 'id'         , id);
     Autocom.writeString('TEF DISCADO', 'coo'        , coo);
     Autocom.writeString('TEF DISCADO', 'valor'      , valor);
     Autocom.writeString('TEF DISCADO', 'rede'       , nome_rede);
     Autocom.writeString('TEF DISCADO', 'finalizacao', finalizacao);
     Autocom.writeString('TEF DISCADO', 'data'       , data);
     Autocom.writeString('TEF DISCADO', 'hora'       , hora);
     Autocom.writeString('TEF DISCADO', 'nsu'        , nsu);
     Autocom.writeString('TEF DISCADO', 'msgop'      , procura('030-000'));
     Autocom.writeString('TEF DISCADO', 'tipo_rede'  , '0');
     Autocom.Free;

      if copy(retorno,1,1)='1' then tef_nao_confirma_venda(id,coo,nome_rede,finalizacao,tipo,valor) else tef_confirma_venda(id,coo,nome_rede,finalizacao,tipo);

      result:=retorno;
except
      on e:exception do
         begin
            showmessage(e.Message);
         end;
end;
end;

function tef_cancelamento(coo,valor,rede,data,hora,tipo:string):shortstring;
var autocom:Tinifile;
    id:string;
begin

      tipo_path(tipo);
      id:=id_tef(1);
     deletefile(path_req+'intpos.tmp');
     deletefile(path_resp+'intpos.001');
     deletefile(path_resp+'intpos.sts');

         AssignFile(arq,path_req+'intpos.tmp');
         Rewrite(arq);
         writeln(arq,'000-000 = CNC');
         writeln(arq,'001-000 = '+id);
         writeln(arq,'002-000 = '+coo);
         writeln(arq,'003-000 = '+strtovalor(2,valor));
         writeln(arq,'010-000 = '+rede);
         writeln(arq,'022-000 = '+data);
         writeln(arq,'023-000 = '+hora);
         writeln(arq,'999-999 = 0');
         closefile(arq);

         try
            renamefile(path_req+'intpos.tmp',path_req+'intpos.001');
         except
            showmessage('Não foi possível renomer o arquivo intpos.tmp');
         end;

         ok:=false;
         tempo:=time;
         while (time-tempo)<=strtotime('00:00:10') do
            begin
               if fileexists(path_resp+'intpos.sts')=true then
                  begin
                     ok:=true;
                     break;
                  end;
            end;

         if ok=true then
            begin
               while not fileexists(path_resp+'intpos.001') do ok:=ok; // espera que o arquivo de status seja criado
               AssignFile(arq,path_resp+'intpos.001');
               reset(arq);
               while not eof(arq) do
                  begin
                     readln(arq,linha[i]);
                     i:=i+1;
                  end;
               closefile(arq);

               if trim(procura('009-000'))='0' then
                  begin
                     nome_rede:=procura('010-000');
                     finalizacao:=procura('027-000');
                     data:=procura('022-000');
                     hora:=procura('023-000');
                     nsu:=procura('012-000');
                     if strtoint(procura('028-000'))>0 then
                        begin
                           AssignFile(arq,extractfilepath(application.exename)+'dados\comprovante.tef');
                           rewrite(arq);
                           for i:=1 to strtoint(procura('028-000')) do
                               begin
                                  writeln(arq,procura('029-'+enche(inttostr(i),'0',1,3)));
                               end;
                           closefile(arq);
                        end;
                     retorno:='2'+procura('030-000'); // retorno=2 significa que foi tudo ok!
                  end
               else
                  begin
                     nome_rede:=procura('010-000');
                     finalizacao:=procura('027-000');
                     data:=procura('022-000');
                     hora:=procura('023-000');
                     nsu:=procura('012-000');
                     if strtoint(procura('028-000'))>0 then
                        begin
                           AssignFile(arq,extractfilepath(application.exename)+'dados\comprovante.tef');
                           rewrite(arq);
                           for i:=1 to strtoint(procura('028-000')) do
                               begin
                                  writeln(arq,procura('029-'+enche(inttostr(i),'0',1,3)));
                               end;
                           closefile(arq);
                        end;
                     retorno:='1'+trim(procura('030-000')); // retorno=1 significa que a transação foi negada
                  end;
            end
         else
            begin
               retorno:='1O GERENCIADOR PADRAO NAO ESTA ATIVO'; // retorno=0 significa que o Gerenciador TEF não está ativo
            end;

     if not fileexists(extractfilepath(application.exename)+'dados\comprovante.tef') then
        begin
           deletefile(path_resp+'intpos.001');
           deletefile(path_resp+'intpos.sts');
        end;

     Autocom:=TIniFile.Create(extractfilepath(application.exename)+'atctefdi.ini');
     Autocom.writeString('TEF DISCADO', 'id'         , id);
     Autocom.writeString('TEF DISCADO', 'coo'        , coo);
     Autocom.writeString('TEF DISCADO', 'valor'      , valor);
     Autocom.writeString('TEF DISCADO', 'rede'       , nome_rede);
     Autocom.writeString('TEF DISCADO', 'finalizacao', finalizacao);
     Autocom.writeString('TEF DISCADO', 'data'       , data);
     Autocom.writeString('TEF DISCADO', 'hora'       , hora);
     Autocom.writeString('TEF DISCADO', 'nsu'        , nsu);
     Autocom.WriteString('TEF DISCADO', 'msgop'      , procura('030-000'));
     Autocom.writeString('TEF DISCADO', 'tipo_rede'  , tipo);
     Autocom.Free;

     if copy(retorno,1,1)='1' then tef_nao_confirma_venda(id,coo,nome_rede,finalizacao,tipo,valor);

     result:=retorno;
end;


function tef_verifica_resposta:shortstring;
var
    autocom:Tinifile;
    id, coo, valor,rede,finalizacao, data,hora, nsu,tipo_rede:string;
begin
     try
        Autocom:=TIniFile.Create(extractfilepath(application.exename)+'atctefdi.ini');
        id          :=Autocom.readString('TEF DISCADO', 'id'         , '');
        coo         :=Autocom.readString('TEF DISCADO', 'coo'        , '');
        valor       :=Autocom.readString('TEF DISCADO', 'valor'      , '');
        rede        :=Autocom.readString('TEF DISCADO', 'rede'       , '');
        finalizacao :=Autocom.readString('TEF DISCADO', 'finalizacao', '');
        data        :=Autocom.readString('TEF DISCADO', 'data'       , '');
        hora        :=Autocom.readString('TEF DISCADO', 'hora'       , '');
        nsu         :=Autocom.readString('TEF DISCADO', 'nsu'        , '');
        tipo_rede   :=Autocom.readString('TEF DISCADO', 'tipo_rede'  , '0');
     finally
        Autocom.Free;
     end;

     tipo_path(tipo_rede);

      try
         if (fileexists(extractfilepath(application.exename)+'dados\comprovante.tef')=true) and ((fileexists(path_resp+'intpos.001')=true)) then
            begin
               try
                  deletefile(path_resp+'intpos.001');
                  deletefile(path_resp+'intpos.sts');
                  tef_confirma_venda(id,coo,rede,finalizacao,tipo_rede);
                  retorno:='2'; // retorno=2 significa que existe pendencia tef!
               finally
                  deletefile(path_resp+'intpos.001');
                  deletefile(path_resp+'intpos.sts');
                  deletefile(extractfilepath(application.exename)+'dados\comprovante.tef');
               end;
            end
         else
            begin
               if (fileexists(path_resp+'intpos.001')=true) then
                  begin
                     try
                        deletefile(path_resp+'intpos.001');
                        deletefile(path_resp+'intpos.sts');
                        tef_nao_confirma_venda(id,coo,rede,finalizacao,tipo_rede,valor);
                        retorno:='1'; // retorno=2 significa que existe pendencia tef!
                     finally
                        deletefile(path_resp+'intpos.001');
                        deletefile(path_resp+'intpos.sts');
                        deletefile(extractfilepath(application.exename)+'dados\comprovante.tef');
                     end;
                  end
               else retorno:='1'; // retorno=1 significa que não existe pendencias de tef
            end;
      except
         retorno:='0'; // retorno=0 significa que deu erro
      end;
      result:=retorno;
end;


function tef_comprovante(tipo,cupom:string):shortstring;
var l,conta_cupom,h:integer;
    tipo_cupom:string;
    _ok,_deuerro:boolean;
    autocom:Tinifile;
    id, coo, valor,rede,finalizacao, data,hora, nsu,resposta:string;
    v_DLL_ECF:array[0..250] of char;
    vpdvnum,vModECF,vCOMECF:string;
begin
try
     if not fileexists(extractfilepath(application.exename)+'dados\comprovante.tef') then
        begin
           result:='3'; // não existe comprovante para a impressão
           exit;
        end;

     try
        Autocom:=TIniFile.Create(extractfilepath(application.exename)+'dados\autocom.INI');
        strpcopy(v_DLL_ECF,Autocom.ReadString('MODULOS', 'dll_ECF', '')); // Nome da Dll para comunicação com o ECF
     finally
        Autocom.Free;
     end;


     try
        Autocom:=TIniFile.Create(extractfilepath(application.exename)+'dados\autocom.INI');
        vpdvnum:=Autocom.ReadString('TERMINAL', 'PDVNum', '000');    // Número do PDV
        vModECF:=Autocom.ReadString('TERMINAL', 'ModECF', '99');     // modelo do ECf
        vCOMECF:=Autocom.ReadString('TERMINAL', 'COMECF', '1');      // porta de comunicação do ECF
     finally
        Autocom.Free;
     end;

     // este fechamento de cupom server para encerrar algum comprovante
     // que pode estar aberto, eventualmente por causa de algum erro (queda de energia por exemplo...)
     hndl:=LoadLibrary(v_DLL_ECF);
     @FecharCupom:=GetProcAddress(hndl, 'FecharCupom');
     FecharCupom(strtoint(vmodecf),strtoint(vcomecf),'0','0','','','','','','','','');
     FreeLibrary(hndl);

     //inicia contador de vias do cupom
     conta_cupom:=1;

     tipo_cupom:=cupom;

     if cupom<>'0' then h:=0 else h:=1; // h vai indicar para a dll do ecf que 0 é para imprimir linha em um cupom nao fiscal vinculado,
                                        // pois existem ECF que tem comando diferentes para linhas e relatorio gerencial e CNFV

     if abre_comprovante(tipo_cupom)=true then // abre cupom
        begin            //loop para impressão das 2 vias do comprovante
           while conta_cupom<=2 do
              begin
                 sleep(1500);
                 //captura as linhas para o comprovante
                 FTEFDISC.memo.clear;
                 FTEFDISC.memo.lines.loadfromfile(extractfilepath(application.exename)+'dados\comprovante.tef');

                 //impressão das linhas do comprovante.
                 for l:=0 to FTEFDISC.memo.lines.count-1 do
                    begin
                       _ok:=true;
                       _deuerro:=false;
                       try
                          hndl:=LoadLibrary(v_DLL_ECF);
                          if hndl>0 then
                             begin
                                @TextoNF:= GetProcAddress(hndl, 'TextoNF');
                                resposta:=TextoNF(strtoint(vmodecf),strtoint(vcomecf),FTEFDISC.memo.lines[l],inttostr(h));
                                FreeLibrary(hndl);
                             end;
                       except
                          resposta:='';
                       end;
                       // verifica se ocorreu algum erro
                       if (copy(resposta,1,1)<>'@') and (copy(resposta,1,1)<>'!') then
                          begin
                             if application.messagebox('Impressora não responde. Tentar novamente ?','Autcom PLUS',mb_yesno)=mryes then
                                begin
                                  _deuerro:=true;
                                  hndl:=LoadLibrary(v_DLL_ECF);
                                  @FecharCupom:=GetProcAddress(hndl, 'FecharCupom');
                                  FecharCupom(strtoint(vmodecf),strtoint(vcomecf),'0','0','','','','','','','','');
                                  FreeLibrary(hndl);
                                  conta_cupom:=1;
                                  h:=0;
                                  if abre_comprovante('1')=false then //abre leitura x com relatório gerencial
                                     begin
                                        tipo_cupom:='1';
                                        cupom:='1';
                                        result:='1';// retorno = 1 siginifica q o cupom não foi impresso.
                                        _ok:=false;
                                     end;
                                  break;
                                end
                             else
                                begin
                                   result:='1';
                                   _ok:=false;
                                   break;
                                end;
                          end;
                    end;

                 // se deu erro, fecha o cupom
                 if _ok=false then
                    begin
                       tef_nao_confirma_venda(id,coo,rede,finalizacao,tipo,valor);
                       result:='1'; // retorno = 1 siginifica q o cupom não foi impresso.
                       hndl:=LoadLibrary(v_DLL_ECF);
                       @FecharCupom:=GetProcAddress(hndl, 'FecharCupom');
                       FecharCupom(strtoint(vmodecf),strtoint(vcomecf),'0','0','','','','','','','','');
                       FreeLibrary(hndl);
                       break;
                    end
                 else
                    begin
                       if _deuerro=false then
                          begin
                             if conta_cupom>0 then
                                begin
                                   if conta_cupom<2 then
                                      begin
//                                         if cupom<>'0' then h:=0 else h:=1; // h vai indicar para a dll do ecf que 0 é para imprimir linha em um cupom nao fiscal vinculado,
                                                                            // pois existem ECF que tem comando diferentes para linhas e relatorio gerencial e CNFV
                                         for l:=0 to 10 do
                                            begin
                                               hndl:=LoadLibrary(v_DLL_ECF);
                                               if hndl>0 then
                                                  begin
                                                     @TextoNF:= GetProcAddress(hndl, 'TextoNF');
                                                     resposta:=TextoNF(strtoint(vmodecf),strtoint(vcomecf),' ',inttostr(h));
                                                     FreeLibrary(hndl);
                                                  end;
                                            end;
                                      end
                                   else
                                      begin
                                         result:='2';
                                         tef_confirma_venda(id,coo,rede,finalizacao,tipo);
                                         hndl:=LoadLibrary(v_DLL_ECF);
                                         @FecharCupom:=GetProcAddress(hndl, 'FecharCupom');
                                         FecharCupom(strtoint(vmodecf),strtoint(vcomecf),'0','0','','','','','','','','');
                                         FreeLibrary(hndl);
                                      end;
                                end;
                             conta_cupom:=conta_cupom+1;
                          end;
                    end;
              end;
        end
     else
        begin
           result:='1';// retorno = 1 siginifica q o cupom não foi impresso.
           tef_nao_confirma_venda(id,coo,rede,finalizacao,tipo,valor);
        end;

     if  fileexists(extractfilepath(application.exename)+'dados\comprovante.tef') then
        begin
           deletefile(extractfilepath(application.exename)+'dados\comprovante.tef');
        end;
except
   on e:exception do
      begin
         showmessage(e.message);
      end;
end;


end;



// funções exportadas.
exports
       tef_cartao index 1,
       tef_adm index 2,
       tef_cheque index 3,
       tef_comprovante index 4,
       tef_cancelamento index 5,
       tef_verifica_resposta index 6,
       tef_ativo index 7;
end.
