library _sweda;


//{$HINTS OFF}
//{$WARNINGS OFF}
uses
  Windows,
  Messages,
  SysUtils,
  Classes,
  Forms,
  Inifiles,
  CPort,
  Math,
  StrUtils;

{$R *.res}

const
     ESC = #$1b;
     ESCP = #$1b#$2e;
     LF  = #10;
     CR  = #13;
     FF  = #255;
     TIME_OUT = 10000;
     DOZE_ZEROS = '000000000000';
     DEZ_ZEROS = '000000000';

var
  func,comando:string;
  retorno,retorno_serial:string;
  Serial:TComPort;

procedure RxChar(Sender: TObject; Count: Integer);
begin

end;

procedure Log(texto:string); // monta o log de comandos e retornos.
var
   LOGfile:textfile;
   straux:string;
begin
    ForceDirectories(extractfilepath(application.exename) + 'logs');
    straux:= extractfilepath(application.exename) +'logs\_sweda_'+ FormatDateTime('yyyymmdd', now) + '.LOG';
    AssignFile(LOGfile, straux);
    if not fileexists(straux) then
        Rewrite(logfile)
          else
              Reset(Logfile);
    Append(logfile);
    Writeln(logfile, datetimetostr(now) + ' - ' + texto);
    Flush(logfile);
    closefile(logfile);
end;

procedure Enviacomando(p:integer;Comand:string);
var
    t:Cardinal;
    rsp:string;
begin
      try
          serial         := TComPort.Create(nil);
          serial.port    :='COM' + inttostr(p);
          retorno_serial :='';
          Serial.BaudRate := br9600;
          Serial.DataBits := dbEight;
          Serial.Timeouts.ReadInterval := 1;
          serial.Open;
          serial.ClearBuffer(true,true);
          Serial.WriteStr(ESCP +  comand+ '}');
          rsp := '';

          log(func+' - Enviado (SWEDA):'+ESCP + comand+ '}');
          t:=GetTickCount();
          while ((GetTickCount()-t)<= TIME_OUT)  do // time-out para liberar
          begin
              serial.readstr(rsp,130);
              retorno_serial:=retorno_serial+rsp;
//              if (Pos('.',rsp)>0) and  (Pos('}',rsp)>0) then // resposta completa.
              if (Pos('.',retorno_serial)>0) and  (Pos('}',retorno_serial)>0) then // resposta completa.
                 break
          end;

          serial.close;
//          if retorno_serial='' then
          if (Pos('.',retorno_serial)<=0) or  (Pos('}',retorno_serial)<=0) then // resposta completa.
             retorno:='.-SEM RESPOSTA DO ECF'
             else
                 begin
                      retorno:=retorno_serial;
                      log(func+' - Recebido (SWEDA):'+retorno)
                 end;
      except
         retorno:=Format('.-NAO FOI POSSIVEL ABRIR A PORTA SERIAL COM %d' , [p]) ;
         log(func+' - (SWEDA):'+retorno+'}');
      end;
      FreeAndNil(serial);
end;

function carrega_ini_bancos(banco:string):string;
//var _ncrbancos:Tinifile;
begin
//     _ncrbancos:=TIniFile.Create(extractfilepath(application.exename)+'dados\_ncrbancos.INI');
//     result:=_ncrbancos.ReadString('BANCOS', banco, '60\07\05\10\07\20\');
//     _ncrbancos.Free;
end;

function strtoquant(texto:string):string;
begin
     Result := formatfloat('0.000',strtofloatdef(Texto,0));
end;


function strtovalor(d:integer;texto:string):string;
begin
     result := FloatToStrF(StrToFloat(Texto), ffFixed,18,d);
end;


function Enche(texto,caracter:string;lado,tamanho:integer):string;
var
   tmp : array[0..1024] of char ;
begin
     Result := '';
     tmp := #0;
      fillchar(tmp,tamanho - Length(Texto),ord(caracter[1]));
           if lado = 1 then
              Result  := tmp + Texto
                    else
                    Result  := Texto + tmp;
end;

procedure espera_ecf(p:integer);
var i:Cardinal;
begin
     i:=GetTickCount();
     while ((GetTickCount()-i)<= TIME_OUT) and (Pos('.+',retorno) = 0) do // time-out para liberar
        begin
           enviacomando(p,'27');
           log('Aguardando ECF '+retorno);
        end;
     retorno:='';
end;

// esta função prepara a string de retorno da DLL para a aplicação.
function Prepara_Resp(tipo:integer;texto,texto2,continue:string):shortstring;
begin
     result:= ifthen( Pos('.+',Texto) > 0 ,
                      '@' + texto2,
                      '#'+continue+' ECF Sweda'+chr(13)+' ERRO: '+Texto);
end;


///////////////////////////////////////////////////////////////////////////////////////////////////////////
//       Declarações de funções de exportação da _SWEDA.DLL                                       //
//                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////
function Troca_op(tipo,porta:integer;codigo,fazoq:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  cod  -> Código do operador
  fazoq -> 0 = Saida    (nao usa)
           1 = Entrada
=========================================================}
     func:='Troca de operador';
     with TIniFile.Create(ExtractFilePath( application.ExeName) +  '_SWEDA.ini') do
     begin
          // Abre o comprovante
          Enviacomando(porta , '19' + ReadString('operador','troca_operador','01') + '       ') ;
          espera_ecf(porta);
          //Lanca a operação em si
          Enviacomando(porta , '07' + ReadString('operador',ifthen(fazoq = '0','saida','entrada'), '02') + DOZE_ZEROS) ;
          espera_ecf(porta);
          Free;
     end;
     //fecha o comprovante
     enviacomando(porta,'12NN');
     result:=Prepara_Resp(tipo,retorno,'','');
end;

function Abrecupom(tipo,porta:integer;texto:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     func:='Abertura de cupom';
     with TIniFile.Create(ExtractFilePath( application.ExeName) +  '_SWEDA.ini') do
     begin
          DeleteKey('impressora','cnfnv_emissao');
          Free;
     end;
     enviacomando(porta,'17' + texto);
     result:=Prepara_Resp(tipo,retorno,'','');
     //espera_ecf(porta);
end;

function AbreGaveta(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     func:='Abertura de Gaveta';
     enviacomando(porta,'21');
     result:=Prepara_Resp(tipo,retorno,'','');
     espera_ecf(porta);
end;

function AcreSub(tipo,porta:integer;val,tipacre:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  val -> valor do acrescimo
  tipoacre-> tipo de acrescimo. nao usado
=========================================================}
     func:='Acrescimo no subtotal';
     val:=FormatFloat('00000000000', StrToFloatdef(strtovalor(2,val),0) * 100);
     enviacomando(porta,'11'+ ifthen(tipacre = '2','51','52') + '0000' +val + 'S' );
     result:=Prepara_Resp(tipo,retorno,'','');
     espera_ecf(porta);
end;

function Autentica(tipo,porta:integer;codigo,repete:string):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  codigo -> caracteres qq para impressão
  repete -> 1=envia comando para repitir aut. (nao usado)
            0=Envia comando para aut.
=========================================================}
     func:='Autenticacao';
     if repete = '0' then
        enviacomando(porta,'200N32AB500001451260S' )
        else
            enviacomando(porta,'26' );
     result:=Prepara_Resp(tipo,retorno,'','');
end;

function Cancelacupom(tipo,porta:integer;venda,valor:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunicação
  Venda -> nao usado.
  Valor -> nao usado
=========================================================}
     func:='Cancela Cupom';
     enviacomando(porta,'05');
     result:=Prepara_Resp(tipo,retorno,'','');
     espera_ecf(porta);
end;

function CancItem(tipo,porta:integer;cod,nome,prtot,trib,ind:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunicação
  cod   -> Código do produto cancelado (nao usado)
  nome  -> descricao do produto cancelado (nao usado)
  prtot -> total do produto cancelado (nao usado)
  trib  -> tributação do produto cancelado (nao usado)
  ind   -> posição do produto no cupom fiscal (opcional)
=========================================================}
     func:='Cancelamento de item';
     enviacomando(porta,'04' + formatfloat('000', strtointdef(ind,0)));
     result:=Prepara_Resp(tipo,retorno,'','');
     espera_ecf(porta);
end;

function Descitem(tipo,porta:integer; val:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunicação
  val   -> Valor do desconto.
=========================================================}
     func:='Desconto no item';
     Enviacomando(porta,'02          ' + formatfloat('0000000000', strtofloatdef(val,0) * 100));
     result:=Prepara_Resp(tipo,retorno,'','');
     espera_ecf(porta);
end;

function DescSub(tipo,porta:integer; val:string):shortstring;
begin
{========================================================
  tipo  -> tipo de ECF
  porta -> porta de comunicação
  val   -> Valor do desconto
=========================================================}
     func:='Desconto no subtotal';
     enviacomando(porta,'03          ' + formatfloat(DOZE_ZEROS, strtofloatdef(val,0) * 100 ) + 'N');
     result:=Prepara_Resp(tipo,retorno,'','');
     espera_ecf(porta);
end;

function FecharCupom(tipo,porta:integer; SegCp,CNFV,l1,l2,l3,l4,l5,l6,l7,l8:string):shortstring;
var
   linhas:string;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  SegCP  -> 0=Não imprime segundo
            1=Imprime segundo cupom
  CNFV   -> 0=Não Comprovante não-fiscal vinculado     (nao usado)
            1=Imprime Comprovante não-fiscal vinculado
  l1..l8 -> Linhas de mensagens de cortesia.
=========================================================}
     linhas := '';
     func   := 'Fechamento de Cupom';

     linhas := IfThen( l1 = '', '', linhas + '0' + l1 );
     linhas := IfThen( l2 = '', '', linhas + '0' + l2 );
     linhas := IfThen( l3 = '', '', linhas + '0' + l3 );
     linhas := IfThen( l4 = '', '', linhas + '0' + l4 );
     linhas := IfThen( l5 = '', '', linhas + '0' + l5 );
     linhas := IfThen( l6 = '', '', linhas + '0' + l6 );
     linhas := IfThen( l7 = '', '', linhas + '0' + l7 );
     linhas := IfThen( l8 = '', '', linhas + '0' + l8 );
     enviacomando(porta,'12S' + IfThen(SegCp = '0','N','S') + linhas);
     result:=Prepara_Resp(tipo,retorno,'','');
     espera_ecf(porta);
end;

function Finalizadia(tipo,porta:integer):shortstring;
var DatHor:string;
begin
{========================================================
  tipo     -> tipo de ECF
  porta    -> porta de comunicação
=========================================================}
     func:='Reducao Z';
     ShortDateFormat := 'ddmmyy';
     LongTimeFormat := 'hhnnss';
     DatHor:= copy(DateTimeToStr(Now),1,6);//+copy(DateTimeToStr(Now),8,6);
     enviacomando(porta,'14N' + DatHor);
     result:=Prepara_Resp(tipo,retorno,'','');
     sleep(30000); // A sweda não segura o processamento da lx nem da rz.
     with TIniFile.Create(ExtractFilePath( application.ExeName) +  '_SWEDA.ini') do
     begin
          enviacomando(porta,'271');
          espera_ecf(porta);
          writestring('impressora','gti',formatfloat('00000000000000000',StrToFloatDef(Copy(retorno,20,17),0)));
          writestring('impressora','coo_i',FormatFloat('0000',StrToFloatDef(Copy(retorno, 14,4),0)));
          Free;
     end;
end;

function InicioDia(tipo,porta:integer; verao,op,modal:string):shortstring;
var
   strcomm,
   straux :string;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  verao  -> 0=Não está no horário de verão
            1=Está no horário de verão
  op     -> Código do operador ativo
  modal  -> não usado
=========================================================}
     func:='Inicio do dia';

     enviacomando(porta,'13N');
     espera_ecf(porta);
     strcomm := '';
     while Pos('|',modal) > 0 do
     begin
          straux := Copy(modal,1,Pos('|',modal) - 1);
          strcomm := strcomm + Enche(straux,' ',0,15);
          Delete(modal,1,Pos('|',modal));
     end;
     Enviacomando(porta,'39' + ifthen( strcomm='', 'Dinheiro',strcomm));
     result:=Prepara_Resp(tipo,retorno,'','');
end;


function Lancaitem(tipo,porta:integer; cod, nome, qtde, prunit, prtot, Trib: string):shortstring;
var
   d:string;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  cod    -> código do produto
  nome   -> descrição do produto
  qtde   -> quantidade do produto. O primeiro byte indica a casa decimal, pode ser 2 ou 3.
  prunit -> preço unitário do produto
  prtot  -> preço total do produto (nao usado)
  trib   -> tributação do produto
=========================================================}
     func:='Lanca item';
     d:=copy(qtde,1,1);
     delete(qtde,1,1);
     //qtde:= strtoquant(trim(qtde));
     qtde := FormatFloat('0000000', StrToFloatDef(qtde,0) * 1000);


//     if strtofloat(trim(qtde))=1 then
//        qtde:='1';
//     while pos('.',prunit)>0 do
//           delete(prunit,pos('.',prunit),1);
//     if length(qtde)<5 then
//        qtde:=enche(qtde,'0',1,5)
//          else
//          qtde:=copy(qtde,1,5);

     trib := IfThen( trib[1] in ['I','F','N'], trib[1] + '  ', trib);
     trib := ifthen(trib[1] = 'T', 'T' + formatfloat('00',StrToFloatDef(Copy(trib,2,2),0)),trib);

     //prunit:= strtovalor(strtoint(d),trim(prunit));
//     while pos(',',prunit)>0 do delete(prunit,pos(',',prunit),1);
//     while pos('.',prunit)>0 do delete(prunit,pos('.',prunit),1);
     prunit := FormatFloat(DEZ_ZEROS,StrToFloatDef(prunit,0) * ifthen(d = '2',100,1000));
     nome:=enche(copy(nome,1,24),' ',1,24);

     cod:=enche(cod,'0',1,13);

     comando:='01' + cod + qtde + prunit +
                   formatfloat(DOZE_ZEROS, StrToFloat(prunit) * (StrToFloat(qtde) / 1000)) + nome  +trib;
     log('Valor total : ->' + formatfloat(DOZE_ZEROS, StrToFloat(prunit)  * (StrToFloat(qtde) /1000)));
     enviacomando(porta,comando);
     result:=Prepara_Resp(tipo,retorno,'','');
end;

function Notadecupom(tipo,porta:integer; ind,texto:string;abc:boolean):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  ind    -> indicador a ser impresso no cupom   (não usado)
  texto  -> texto a ser impresso no cupom
=========================================================}
     func:='Nota de Cupom';

//     if abc=true then
//        begin
//           comando:='10';
//
//           log(func+' - Enviado (NCR):'+comando);
//           enviacomando(porta,cmd);
//           log(func+' - Recebido (NCR):'+retorno);
//           try
//              ncr:=TIniFile.Create(extractfilepath(application.exename)+'_ncr.INI');
//              ncr.writeString('CONTROLE', 'coo', '');
//              ncr.writeString('CONTROLE', '_coo', '');
//           finally
//              ncr.Free;
//           end;
//        end;
     comando:='0';

     enviacomando(porta,comando);
     RETORNO:='.=';
     result:=Prepara_Resp(tipo,retorno,'','');

     espera_ecf(porta);
end;

function TextoNF(tipo,porta:integer;texto,valor:string):shortstring;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  texto  -> Texto a ser impresso.
  valor  -> Valor para CNFNV. Nos demais casos enviar nulo (NCR)
=========================================================}
     func:='Texto nao fiscal';
     comando:='08' + Texto;
     log(func+' - Enviado (SWEDA):'+comando+texto);
     enviacomando(porta,comando);
     result:=Prepara_Resp(tipo,retorno,'','');
end;

function Totalizacupom(tipo,porta:integer;Moda,valor:string):shortstring;
var modalidade:string;
    emissaoNvinc:integer;
begin
{========================================================
  tipo   -> tipo de ECF
  porta  -> porta de comunicação
  Moda   -> Código da modalidade de pagamento
  valor  -> Valor recebido da modalidade de pagamento
=========================================================}
     func:='Totaliza Cupom';

     //gravando os totalizadores para
     //uso posterior
     if moda = '00' then
     begin
        Enviacomando(porta,'10');
        Result := Prepara_Resp(tipo,ifthen(moda='00','.+', retorno),'','');
     end
        else
        begin
             moda:=enche(moda,'0',1,2);
             //     modalidade := ifthen(moda <> '00', chr(Ord(strtoint(moda)) + 64), '00'); // fazendo a mesma coisa, mas de um jeito mais bunito - Charles.
                                                                     // Helder, Helder meu pequeno gafanhoto.
                                                                     // As vezes precisamos parar, pensar e abrir uma
                                                                     // tubaína.

             //+ formatfloat('00', StrToFloatDef(moda,0)) + FormatFloat(DOZE_ZEROS,StrToFloatDef(valor,0) * 100)

             valor:=formatfloat(DOZE_ZEROS,StrToFloat(strtovalor(2,valor)) * 100);

             with TIniFile.Create(ExtractFilePath( application.ExeName) +  '_SWEDA.ini') do
             begin
                  Enviacomando(porta,'271');
                  WriteString('modalidade',Moda,valor);
                  WriteString('impressora', 'COO', Copy(retorno, 14,4));
                  emissaoNvinc:=ReadInteger('impressora','cnfnv_emissao',0 );
                  DeleteKey('impressora','cnfnv_emissao');
                  Free;
             end;

             if emissaoNvinc = 1 then
             begin
                   if moda<>'00' then
                      comando:= '10'+modalidade+Valor;

                   enviacomando(porta,comando);
                   result:=Prepara_Resp(tipo,ifthen(moda='00','.+', retorno),'','');

                   with TIniFile.Create(ExtractFilePath( application.ExeName) +  '_SWEDA.ini') do
                   begin
                        WriteInteger('impressora','cnfnv_emissao',2);
                        Free;
                   end;
             end
                 else if (emissaoNvinc = 2) {or  (emissaoNvinc = 0)} then
                 begin
                      Result := '@';
                 end
                     else
                         begin
                             comando:='10';
                             if moda<>'00' then
                                comando:= '10'+moda+Valor;
                             enviacomando(porta,comando);
                             result:=Prepara_Resp(tipo,ifthen(moda='00','.+', retorno),'','');
                         end;
     end;
end;

function LeituraX(tipo,porta:integer;NF:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  NF   -> 0=Imprime somente Leitura X
          1=Imprime leitura x e espera texto não fiscal
=========================================================}
     func:='Leitura X';
     comando := '13' + IfThen(NF = '0' , 'N', 'S');
     enviacomando(porta,comando);
     result:=Prepara_Resp(tipo,retorno,'','');
     espera_ecf(porta);
end;

function Venda_liquida(tipo,porta:integer):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     func:='Venda Liquida';

     comando:='28';

     enviacomando(porta,comando);
     result:=Prepara_Resp(tipo,retorno,copy(retorno,22,12),'');

     espera_ecf(porta);
end;

function COO(tipo,porta:integer;tipo_coo:string):shortstring;
var c:string;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  tipo_coo -> 0 = ultimo emitido (nao usado)
              1 = atual (nao usado)
=========================================================}
     func:='COO';
     enviacomando(porta,'271');
     c := FormatFloat('0000',StrToFloatdef(Copy(retorno, 14,4),0));

     Result := Prepara_Resp(tipo,retorno,c,'');
     log(func+' - Recebido (SWEDA):'+retorno+c);
end;

function Sangria(tipo,porta:integer;modal,valor:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  modal -> Código da modalidade de pagamento.
  valor -> Valor da Sangria.
=========================================================}
     func:='Sangria';

     with TIniFile.Create(extractfilepath(Application.exename) + '_SWEDA.ini') do
     begin
          // abre o comprovante não fiscal não vinculado
          comando := '19' + ReadString('sangria','titulo','03') + '       ';
          enviacomando(porta,comando);
          result:=Prepara_Resp(tipo,retorno,'','');
          Free;
     end;

     if Result[1] = '@' then
        with TIniFile.Create(ExtractFilePath(Application.ExeName) + '_SWEDA.ini') do
        begin
             //lança a sangria.
             WriteInteger('impressora','cnfnv_emissao',1);
             comando := '07' + ReadString('sangria','acumulador','02') + formatfloat(DOZE_ZEROS, StrToFloatDef(valor,0));
             enviacomando(porta,comando);
             result:=Prepara_Resp(tipo,retorno,'','');
             //fecha o cupom.
             enviacomando(porta,'12NN');
             result:=Prepara_Resp(tipo,retorno,'','');
             Free;
        end;

     espera_ecf(porta);
end;

function FCX(tipo,porta:integer;modal,valor:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  modal -> Código da modalidade de pagamento.
  valor -> Valor do fundo de caixa.
=========================================================}
     with TIniFile.Create(extractfilepath(Application.exename) + '_SWEDA.ini') do
     begin
          // abre o comprovante não fiscal não vinculado
          comando := '19' + ReadString('FCX','titulo','02') + '       ';
          enviacomando(porta,comando);
          result:=Prepara_Resp(tipo,retorno,'','');
          Free;
     end;

     if Result[1] = '@' then
        with TIniFile.Create(ExtractFilePath(Application.ExeName) + '_SWEDA.ini') do
        begin
             //lança a sangria.
             WriteInteger('impressora','cnfnv_emissao',1);
             comando := '07' + ReadString('FCX','acumulador','02') + formatfloat(DOZE_ZEROS, StrToFloatDef(valor,0));
             enviacomando(porta,comando);
             result:=Prepara_Resp(tipo,retorno,'','');


             comando := '1001' +  valor;
             enviacomando(porta,comando);
             result:=Prepara_Resp(tipo,retorno,'','');


             //fecha o cupom.
             enviacomando(porta,'12NN');
             result:=Prepara_Resp(tipo,retorno,'','');
             Free;
        end;

     espera_ecf(porta);
end;

function Cheque(tipo,porta:integer;banco,valor,data,favorecido,municipio,cifra,moedas,moedap:string):shortstring;
var// obs:string;
    //dia,mes,ano:word;
    modelo: array [1..10] of integer; //modelos que tem impressão de cheques
    ok:boolean;
    a:integer;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
  banco -> Número do Banco
  valor -> Valor do cheque
  data  -> Data do cheque
  favorecido -> Favorecido do cheque. depois do pipe |, vem a observacao para o cheque;
  municipio  -> municipio do cheque
  cifra  -> Cifra di cheque
  moedas -> nome da moeda no singular
  moedap -> nome da meoda no plural
=========================================================}

//{tipo para a NCR 20} -> 'NCR - IF-7141 Duas Estações v2.00'
//{tipo para a NCR 21} -> 'NCR - IF-7140 Duas Estações v2.00'
//{tipo para a NCR 22} -> 'NCR - IF-7140 Uma Estação v2.00'

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

//           Obs:=copy(favorecido,pos('|',favorecido)+1,length(favorecido));
//           delete(favorecido,pos('|',favorecido),length(favorecido));
//           valor:=strtovalor(2,valor);
//           while pos(',',valor)>0 do delete(valor,pos(',',valor),1);
//           while pos('.',valor)>0 do delete(valor,pos('.',valor),1);
//
//           decodedate(strtodate(data),ano,mes,dia);
//           if length(inttostr(ano))=2 then data:=enche(inttostr(dia),'0',1,2)+enche(inttostr(mes),'0',1,2)+enche(inttostr(ano),'0',1,2);
//           if length(inttostr(ano))=4 then data:=enche(inttostr(dia),'0',1,2)+enche(inttostr(mes),'0',1,2)+enche(copy(inttostr(ano),3,2),'0',1,2);
//
//           if tipo=20 then
//              begin
//                 comando:='27'+carrega_ini_bancos(trim(banco))+valor+'\'+favorecido+'\'+municipio+'\'+data+'\'+enche(obs,' ',1,60);
//              end
//           else
//              begin
//                 comando:='2080\74\'+valor+'\'+favorecido+'\'+municipio+'\'+data+'\'+enche(obs,' ',1,60);
//              end;
//
//
//           log(func+' - Enviado (NCR):'+comando);
//           enviacomando(porta,cmd);
//           result:=Prepara_Resp(tipo,retorno,'','');
//           log(func+' - Recebido (NCR):'+retorno);

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
  porta-> porta de comunicação
  valor -> Valor do contra-vale.
=========================================================}
     func:='Contra-vale';

     comando:=ESC+chr(217)+'C'+'1'+DOZE_ZEROS+Valor+'CONTRA - VALE : ';

     enviacomando(porta,comando);
     result:=Prepara_Resp(tipo,retorno,'','');

     espera_ecf(porta);
end;

function cnfv(tipo,porta:integer) : shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     func:='Abertura de CNFV';
     with tinifile.Create(ExtractFilePath( application.ExeName) + '_SWEDA.ini') do
     begin
          comando:= '19'+Readstring('impressora','coo','') +
                    Readstring('impressora','comprovante','') +
                    Readstring('impressora','vinculado','')+
                    Readstring('impressora','coo','')+
                    Readstring('modalidade',Readstring('impressora','vinculado',''),'0');
          Free;
     end;
     enviacomando(porta,comando);
     Result := Prepara_Resp(tipo,retorno,'','');

     espera_ecf(porta);
end;

function ECF_INFO(tipo,porta:integer):shortstring;
var
   ecf,
   dia,
   papel,
   doc_presente,
   gaveta,
   cupom_fiscal,
   coo_i,
   coo_f,
   reducoes,
   gt_i,
   gt_f,
   serie:string;
begin
     func:='ECF INFO 1';

     enviacomando(porta,'271');

     if not (Pos('.-',retorno) > 0) then
     begin
         reducoes := formatfloat('0000',StrToFloatDef(Copy(retorno,41,4),0));
         ecf      := FormatFloat('0000',StrToFloatdef(Copy(retorno, 4,3),0));
         gt_f     := formatfloat('00000000000000000',StrToFloat(Copy(retorno,20,17)));
         coo_f    := FormatFloat('0000',StrToFloatdef(Copy(retorno, 14,4),0));



         enviacomando(porta,'273');
         serie    := FormatFloat('0000000000000',StrToFloat(Copy(retorno, 13,9)));

         enviacomando(porta,'28');

         cupom_fiscal := IfThen( (Pos('VENDAS',retorno) > 0) and (retorno[10] = 'P'),'1','0');

         case retorno[123] of
             'S' : dia := '1';
             'N' : dia := '0';
             'F' : dia := '3';
         end;

         enviacomando(porta,'23');

         doc_presente :=ifthen( (retorno[4] = '0') or (retorno[3] = '0'), '1', '0');
         papel        := ifthen( retorno[5] = '0', '1', '0');



         with TIniFile.Create(ExtractFilePath( application.ExeName) +  '_SWEDA.ini') do
         begin
              espera_ecf(porta);
              gt_i:=  ReadString('impressora','gti',DOZE_ZEROS + '00000');
              coo_i := ReadString('impressora','coo_i','0000');

              Result :=Prepara_Resp(tipo,retorno_serial, ecf + dia + papel + doc_presente + gaveta + coo_i + coo_f +
                     reducoes + gt_i + gt_f,'');
              Free;
         end;
     end
        else
            Result:=Prepara_Resp(tipo,retorno_serial,retorno,'');

end;

function LMFD(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     func:='LEITURA DA MEMÓRIA FISCAL POR DATA';
     enviacomando(porta, '16'+FormatDateTime('ddmmyy', strtodate(inicio))+FormatDateTime('ddmmyy', strtodate(fim)));
     result:=Prepara_Resp(tipo,retorno,'','');
end;

function LMFR(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}
     func:='LEITURA DA MEMÓRIA FISCAL POR REDUÇÃO';
     enviacomando(porta,'15' + FormatFloat('0000',strtofloatdef(inicio,0)) + FormatFloat('0000',strtofloatdef(fim,9999)));
     retorno:='.+';
     result:=Prepara_Resp(tipo,retorno,'','');
end;

function LMMM(tipo,porta:integer;inicio,fim:string):shortstring;
begin
{========================================================
  tipo -> tipo de ECF
  porta-> porta de comunicação
=========================================================}

// Nesta função será executada a aplicação do fabricante para
// realizar a captura da memória fiscal por meio magnético
// (disquete). Esse aplicativo vai mudar de acordo com cada
// ECF, pois cada fabricante tem o seu.
     func:='LEITURA DA MEMÓRIA FISCAL POR MEIO Magnético';
     result:=Prepara_Resp(tipo,'.-Função ainda não implementada','','');
     log(func+' - Executado (SWEDA):');
end;



// funções exportadas.
exports
    Troca_op   index 1,
    Abrecupom  index 2,
    AbreGaveta index 3,
    AcreSub    index 4,
    Autentica  index 5,
    Cancelacupom index 6,
    CancItem   index 7,
    Descitem   index 8,
    Descsub    index 9,
    Fecharcupom index 10,
    Finalizadia index 11,
    InicioDia   index 12,
    Lancaitem   index 13,
    Notadecupom index 14,
    TextoNF     index 15,
    TotalizaCupom index 16,
    LeituraX index 17,
    venda_liquida index 18,
    COO index 19,
    sangria index 20,
    fcx index 21,
    Cheque index 22,
    Contra_vale index 23,
    ECF_INFO index 24,
    LMFD index 25,
    LMFR index 26,
    LMMM index 27,
    cnfv index 28;
begin

end.
