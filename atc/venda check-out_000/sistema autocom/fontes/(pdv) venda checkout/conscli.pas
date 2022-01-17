unit conscli;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ExtCtrls, DB, DBTables, inifiles, XPMenu;

type
  TFconscli = class(TForm)
    Panel1: TPanel;
    edcli: TMaskEdit;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Timer1: TTimer;
    XPMenu1: TXPMenu;
    procedure FormActivate(Sender: TObject);
    procedure edcliKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Enter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edcliEnter(Sender: TObject);
    procedure edcliChange(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure procura_cliente(Tipo:integer;cod,E:string);
    procedure verifica_ln;
    procedure verifica_saldo(codigo_cliente:real);
    procedure trava_mouse(tipo:integer);
  end;

var
  Fconscli: TFconscli;
  tip:integer;
  cap,men:array[0..200] of char;

implementation

uses venda, tab;

{$R *.DFM}

procedure TFconscli.FormActivate(Sender: TObject);
begin
     Fconscli.top:=287;
     Fconscli.left:=437;
     Fconscli.height:=262;
     Fconscli.width:=353;
     trava_mouse(1);
     panel1.visible:=false;
     cap:='AUTOCOM PLUS';
     timer1.enabled:=false;
     if VPDR.codigo_conveniado>0 then
        begin
           panel2.visible:=false;
           label5.caption:='Consultando conveniado.'+chr(13)+'Aguarde...';
           application.processmessages;
           procura_cliente(3,floattostr(VPDR.codigo_conveniado),floattostr(VPDR.codemp_conveniado));
           timer1.enabled:=true; // este timer está sendo habilitado para dar um "tempinho" na tela de consulta para aparecer as legendas, depois fecha o formulario
        end
     else
        begin
           panel2.visible:=true;
           label5.caption:=VPDR.v_nomefina;
           label2.font.color:=clblack;
           label3.font.color:=clblack;
           edit1.setfocus;
        end;
end;

procedure TFconscli.edcliKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=vk_escape then
        begin
           panel1.visible:=false;
           label2.font.color:=clblack;
           label3.font.color:=clblack;
           edit1.clear;
           edit1.setfocus;
        end;

     if key=vk_return then
        begin
           procura_cliente(tip,edcli.text,'0');
        end;

     if key=vk_back then
        begin
           IF VPDR.vmodtec='2' then // caso existe um teclado gertec 65 instalado no PDV
              begin
                 VPDR.hndl:=LoadLibrary('TEC65_32.DLL');
                 if VPDR.hndl <> 0 then
                    begin
                       @VPDR.opentec65:=GetProcAddress(VPDR.hndl, 'OpenTec65'); // inicializa o display do teclado
                       @VPDR.setdisp:=GetProcAddress(VPDR.hndl, 'SetDisp'); // ativa o display do teclado
                       @VPDR.backspace:=GetProcAddress(VPDR.hndl, 'BackSpace'); // apaga o último caractar e posiciona o cursor uma casa anterior
                       if @VPDR.opentec65  <> nil then VPDR.opentec65;
                       if @VPDR.setdisp    <> nil then VPDR.setdisp(1);
                       if @VPDR.backspace  <> nil then
                          begin
                             if VPDR.coluna_display>0 then
                                begin
                                   VPDR.backspace;
                                   VPDR.coluna_display:=VPDR.coluna_display-1;
                                end;
                          end;
                       if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                       FreeLibrary(VPDR.hndl);
                    end;
                 exit;
              end;
        end;
end;

procedure TFconscli.procura_cliente(Tipo:integer;cod,e:string);
var num,emp:real;
    c:boolean;
    autocom:Tinifile;
begin
     IF TIPo=1 then
        begin
           try
              num:=strtofloat(VPDR.enche(trim(cod),'0',1,16));
           except
              IF (VPDR.vmodtec='2') then // caso existe um teclado gertec 65 instalado no PDV
                 begin                                              // e o sistema permita digitar algum dado.
                    VPDR.hndl:=LoadLibrary('TEC65_32.DLL');
                    if VPDR.hndl <> 0 then
                       begin
                          @VPDR.opentec65:=GetProcAddress(VPDR.hndl, 'OpenTec65'); // inicializa o display do teclado
                          @VPDR.dispstr:=GetProcAddress(VPDR.hndl, 'DispStr'); // escreve no display do teclado
                          @VPDR.gotoxy:=GetProcAddress(VPDR.hndl, 'GoToXY');
                          @VPDR.setdisp:=GetProcAddress(VPDR.hndl, 'SetDisp'); // ativa o display do teclado
                          @VPDR.formfeed:=Getprocaddress(VPDR.hndl,'FormFeed');
                          if @VPDR.opentec65  <> nil then VPDR.opentec65;
                          if @VPDR.setdisp    <> nil then VPDR.setdisp(1);
                          if @VPDR.formfeed   <> nil then VPDR.formfeed;
                          if @VPDR.gotoxy     <> nil then VPDR.gotoxy(1,1);
                          strpcopy(VPDR.Mensagem_display,'     CODIGO DO CLIENTE ESTA INVALIDO.   ');
                          if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                          if @VPDR.gotoxy     <> nil then VPDR.gotoxy(2,1);
                          strpcopy(VPDR.Mensagem_display,'VERIFIQUE!             PRESSIONE [ENTER]');
                          if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                          if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                          FreeLibrary(VPDR.hndl);
                       end;
                 end;
              messagedlg('CODIGO DO CLIENTE ESTÁ INVÁLIDO. VERIFIQUE!',mtinformation,[mbok],0);
              VPDR.codigo_cliente:=0;
              edcli.setfocus;
              exit;
           end;

           ftabelas.query1.close;
           ftabelas.query1.sql.clear;
           ftabelas.query1.sql.add('select * from acr106 where codigo='+floattostr(num));
           ftabelas.query1.prepare;
           ftabelas.query1.open;
           try
              if ftabelas.query1.fields[0].value>0 then c:=true else c:=false;
           except
              c:=false;
           end;
           if c=true then
              begin
                 VPDR.codigo_cliente:=ftabelas.query1.fieldbyname('codigo').value; // codigo
                 VPDR.cod_n_cad:=ftabelas.query1.fieldbyname('cpfcnpj').value; // cpf/cnpj
                 if VPDR.tipo_consulta_cliente=1 then verifica_ln;
                 if VPDR.tipo_consulta_cliente=2 then verifica_saldo(num);
              end
           else
              begin
                 strpcopy(men,'Cliente não cadastrado.');
                 IF (VPDR.vmodtec='2') then // caso existe um teclado gertec 65 instalado no PDV
                    begin                                              // e o sistema permita digitar algum dado.
                       VPDR.hndl:=LoadLibrary('TEC65_32.DLL');
                       if VPDR.hndl <> 0 then
                          begin
                             @VPDR.opentec65:=GetProcAddress(VPDR.hndl, 'OpenTec65'); // inicializa o display do teclado
                             @VPDR.dispstr:=GetProcAddress(VPDR.hndl, 'DispStr'); // escreve no display do teclado
                             @VPDR.gotoxy:=GetProcAddress(VPDR.hndl, 'GoToXY');
                             @VPDR.setdisp:=GetProcAddress(VPDR.hndl, 'SetDisp'); // ativa o display do teclado
                             @VPDR.formfeed:=Getprocaddress(VPDR.hndl,'FormFeed');
                             if @VPDR.opentec65  <> nil then VPDR.opentec65;
                             if @VPDR.setdisp    <> nil then VPDR.setdisp(1);
                             if @VPDR.formfeed   <> nil then VPDR.formfeed;
                             if @VPDR.gotoxy     <> nil then VPDR.gotoxy(1,1);
                             strpcopy(VPDR.Mensagem_display,'CLIENTE NAO CADASTRADO.');
                             if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                             if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                             FreeLibrary(VPDR.hndl);
                          end;
                    end;
                 application.messagebox(men,cap,MB_OK);
                 VPDR.status_cliente:=1;
              end;
           Fconscli.close;
        end;

     IF TIPo=2 then
        begin
           cod:=trim(cod);
           if VPDR.ValidaCPF(cod)=0 then
              begin
                 IF (VPDR.vmodtec='2') then // caso existe um teclado gertec 65 instalado no PDV
                    begin                                              // e o sistema permita digitar algum dado.
                       VPDR.hndl:=LoadLibrary('TEC65_32.DLL');
                          if VPDR.hndl <> 0 then
                             begin
                                @VPDR.opentec65:=GetProcAddress(VPDR.hndl, 'OpenTec65'); // inicializa o display do teclado
                                @VPDR.dispstr:=GetProcAddress(VPDR.hndl, 'DispStr'); // escreve no display do teclado
                                @VPDR.gotoxy:=GetProcAddress(VPDR.hndl, 'GoToXY');
                                @VPDR.setdisp:=GetProcAddress(VPDR.hndl, 'SetDisp'); // ativa o display do teclado
                                @VPDR.formfeed:=Getprocaddress(VPDR.hndl,'FormFeed');
                                if @VPDR.opentec65  <> nil then VPDR.opentec65;
                                if @VPDR.setdisp    <> nil then VPDR.setdisp(1);
                                if @VPDR.formfeed   <> nil then VPDR.formfeed;
                                if @VPDR.gotoxy     <> nil then VPDR.gotoxy(1,1);
                                strpcopy(VPDR.Mensagem_display,'   CPF/CNPJ DO CLIENTE ESTA INVALIDO.   ');
                                if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                                if @VPDR.gotoxy     <> nil then VPDR.gotoxy(2,1);
                                strpcopy(VPDR.Mensagem_display,'VERIFIQUE!             PRESSIONE [ENTER]');
                                if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                                if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                                FreeLibrary(VPDR.hndl);
                             end;
                    end;
                 messagedlg('CPF/CNPJ do cliente está inválido. Verifique!',mtinformation,[mbok],0);
                 VPDR.codigo_cliente:=0;
                 edcli.setfocus;
                 exit;
              end;

           ftabelas.query1.close;
           ftabelas.query1.sql.clear;
           ftabelas.query1.sql.add('select * from acr106 where CPFCNPJ='+cod);
           ftabelas.query1.prepare;
           ftabelas.query1.open;
           try
              if ftabelas.query1.fields[0].value>0 then c:=true else c:=false;
           except
              c:=false;
           end;
           if c=true then
              begin
                 VPDR.codigo_cliente:=ftabelas.query1.fields[0].value;// codigo
                 VPDR.cod_n_cad:=ftabelas.query1.fields[14].value;// cpg/cnpj
                 if VPDR.tipo_consulta_cliente=1 then verifica_ln;
                 if VPDR.tipo_consulta_cliente=2 then verifica_saldo(ftabelas.query1.fields[0].value);
              end
           else
              begin
                 IF (VPDR.vmodtec='2') then // caso existe um teclado gertec 65 instalado no PDV
                    begin                                              // e o sistema permita digitar algum dado.
                       VPDR.hndl:=LoadLibrary('TEC65_32.DLL');
                          if VPDR.hndl <> 0 then
                             begin
                                @VPDR.opentec65:=GetProcAddress(VPDR.hndl, 'OpenTec65'); // inicializa o display do teclado
                                @VPDR.dispstr:=GetProcAddress(VPDR.hndl, 'DispStr'); // escreve no display do teclado
                                @VPDR.gotoxy:=GetProcAddress(VPDR.hndl, 'GoToXY');
                                @VPDR.setdisp:=GetProcAddress(VPDR.hndl, 'SetDisp'); // ativa o display do teclado
                                @VPDR.formfeed:=Getprocaddress(VPDR.hndl,'FormFeed');
                                if @VPDR.opentec65  <> nil then VPDR.opentec65;
                                if @VPDR.setdisp    <> nil then VPDR.setdisp(1);
                                if @VPDR.formfeed   <> nil then VPDR.formfeed;
                                if @VPDR.gotoxy     <> nil then VPDR.gotoxy(1,1);
                                strpcopy(VPDR.Mensagem_display,'CLIENTE NAO CADASTRADO.');
                                if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                                if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                                FreeLibrary(VPDR.hndl);
                             end;
                    end;
                 strpcopy(men,'Cliente não cadastrado.');
                 application.messagebox(men,cap,MB_OK);
                 VPDR.status_cliente:=1;
              end;
           Fconscli.close;
        end;

     IF TIPo=3 then
        begin
           try
              num:=strtofloat(VPDR.enche(trim(cod),'0',1,16));
              emp:=strtofloat(VPDR.enche(trim(e),'0',1,4));
           except
              IF (VPDR.vmodtec='2') then // caso existe um teclado gertec 65 instalado no PDV
                 begin                                              // e o sistema permita digitar algum dado.
                    VPDR.hndl:=LoadLibrary('TEC65_32.DLL');
                    if VPDR.hndl <> 0 then
                       begin
                          @VPDR.opentec65:=GetProcAddress(VPDR.hndl, 'OpenTec65'); // inicializa o display do teclado
                          @VPDR.dispstr:=GetProcAddress(VPDR.hndl, 'DispStr'); // escreve no display do teclado
                          @VPDR.gotoxy:=GetProcAddress(VPDR.hndl, 'GoToXY');
                          @VPDR.setdisp:=GetProcAddress(VPDR.hndl, 'SetDisp'); // ativa o display do teclado
                          @VPDR.formfeed:=Getprocaddress(VPDR.hndl,'FormFeed');
                          if @VPDR.opentec65  <> nil then VPDR.opentec65;
                          if @VPDR.setdisp    <> nil then VPDR.setdisp(1);
                          if @VPDR.formfeed   <> nil then VPDR.formfeed;
                          if @VPDR.gotoxy     <> nil then VPDR.gotoxy(1,1);
                          strpcopy(VPDR.Mensagem_display,'     CODIGO DO CONVENIADO ESTA INVALIDO.   ');
                          if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                          if @VPDR.gotoxy     <> nil then VPDR.gotoxy(2,1);
                          strpcopy(VPDR.Mensagem_display,'VERIFIQUE!             PRESSIONE [ENTER]');
                          if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                          if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                          FreeLibrary(VPDR.hndl);
                       end;
                 end;
              messagedlg('CODIGO DO CONVENIADO ESTÁ INVÁLIDO. VERIFIQUE!',mtinformation,[mbok],0);
              VPDR.codigo_cONVENIADO:=0;
              VPDR.codEMP_cONVENIADO:=0;
              edcli.setfocus;
              Fconscli.close;
              exit;
           end;

           ftabelas.query1.close;
           ftabelas.query1.sql.clear;
           ftabelas.query1.sql.add('select * from acr106 where codigo='+floattostr(num)+' and empresa='+floattostr(EMP));
           ftabelas.query1.prepare;
           ftabelas.query1.open;
           try
              if ftabelas.query1.fieldbyname('codigo').value>0 then c:=true else c:=false;
           except
              c:=false;
           end;
           if c=true then
              begin
                 if trim(ftabelas.query1.fieldbyname('controla_produtos').value)='1' then
                    begin
                       vpdr.controla_produto:=true;
                       Autocom:=TIniFile.Create(path+'Autocom.INI');
                       Autocom.writeString('CONVENIO', 'verifica_prod', 'S');
                       Autocom.Free;
                    end
                 else
                    begin
                       vpdr.controla_produto:=false;
                       Autocom:=TIniFile.Create(path+'Autocom.INI');
                       Autocom.writeString('CONVENIO', 'verifica_prod', '');
                       Autocom.Free;
                    end;

                 try
                    VPDR.codigo_cliente:=ftabelas.query1.fieldbyname('codigo').value; // codigo
                 except
                    VPDR.codigo_cliente:=0;
                 end;
                 try
                    VPDR.cod_n_cad:=ftabelas.query1.fieldbyname('cpfcnpj').value; // cpf/cnpj
                 except
                    VPDR.cod_n_cad:=0;
                 end;

                 if VPDR.tipo_consulta_cliente=1 then verifica_ln;
                 if VPDR.tipo_consulta_cliente=2 then verifica_saldo(num);
              end
           else
              begin
                 strpcopy(men,'Cliente não cadastrado.');
                 IF (VPDR.vmodtec='2') then // caso existe um teclado gertec 65 instalado no PDV
                    begin                                              // e o sistema permita digitar algum dado.
                       VPDR.hndl:=LoadLibrary('TEC65_32.DLL');
                       if VPDR.hndl <> 0 then
                          begin
                             @VPDR.opentec65:=GetProcAddress(VPDR.hndl, 'OpenTec65'); // inicializa o display do teclado
                             @VPDR.dispstr:=GetProcAddress(VPDR.hndl, 'DispStr'); // escreve no display do teclado
                             @VPDR.gotoxy:=GetProcAddress(VPDR.hndl, 'GoToXY');
                             @VPDR.setdisp:=GetProcAddress(VPDR.hndl, 'SetDisp'); // ativa o display do teclado
                             @VPDR.formfeed:=Getprocaddress(VPDR.hndl,'FormFeed');
                             if @VPDR.opentec65  <> nil then VPDR.opentec65;
                             if @VPDR.setdisp    <> nil then VPDR.setdisp(1);
                             if @VPDR.formfeed   <> nil then VPDR.formfeed;
                             if @VPDR.gotoxy     <> nil then VPDR.gotoxy(1,1);
                             strpcopy(VPDR.Mensagem_display,'CLIENTE NAO CADASTRADO.');
                             if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                             if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                             FreeLibrary(VPDR.hndl);
                          end;
                    end;
                 application.messagebox(men,cap,MB_OK);
                 VPDR.status_cliente:=1;
              end;
           Fconscli.close;
        end;

end;

procedure TFconscli.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
     if key='0' then
        begin
           VPDR.status_cliente:=0;
           Fconscli.close;
        end;
     if key='1' then
        begin
           tip:=1;
           label2.font.color:=clred;
           panel1.visible:=true;
           edcli.clear;
           edcli.setfocus;
        end;
     if key='2' then
        begin
           tip:=2;
           label3.font.color:=clred;
           panel1.visible:=true;
           edcli.clear;
           edcli.setfocus;
        end;
     edit1.clear;
end;

procedure TFconscli.verifica_ln;
begin
     if ftabelas.query1.fieldbyname('status').value='OK' then // status
        begin
           label5.caption:='Consultando conveniado.'+chr(13)+'OK';
           Application.ProcessMessages;
           VPDR.status_cliente:=2;
           VPDR.NOME_cliente:=ftabelas.query1.fields[2].value; // nome
        end
     else
        begin
           IF (VPDR.vmodtec='2') then // caso existe um teclado gertec 65 instalado no PDV
              begin                                              // e o sistema permita digitar algum dado.
                 VPDR.hndl:=LoadLibrary('TEC65_32.DLL');
                    if VPDR.hndl <> 0 then
                       begin
                          @VPDR.opentec65:=GetProcAddress(VPDR.hndl, 'OpenTec65'); // inicializa o display do teclado
                          @VPDR.dispstr:=GetProcAddress(VPDR.hndl, 'DispStr'); // escreve no display do teclado
                          @VPDR.gotoxy:=GetProcAddress(VPDR.hndl, 'GoToXY');
                          @VPDR.setdisp:=GetProcAddress(VPDR.hndl, 'SetDisp'); // ativa o display do teclado
                          @VPDR.formfeed:=Getprocaddress(VPDR.hndl,'FormFeed');
                          VPDR.opentec65;
                          VPDR.setdisp(1);
                          VPDR.formfeed;
                          VPDR.gotoxy(1,1);
                          strpcopy(men,'Cliente '+ftabelas.query1.fields[10].value);
                          VPDR.dispstr(VPDR.Mensagem_display);
                          VPDR.setdisp(0);
                          FreeLibrary(VPDR.hndl);
                       end;
              end;
           strpcopy(men,'Cliente '+ftabelas.query1.fieldbyname('status').value);
           application.messagebox(men,cap,MB_YESNO);
           VPDR.status_cliente:=1;
        end;
end;

procedure TFconscli.verifica_saldo(codigo_cliente:real);
var c:boolean;
begin
     ftabelas.query2.close;
     ftabelas.query2.sql.clear;
     ftabelas.query2.sql.add('select * from acr201 where codigo='+floattostr(codigo_cliente));
     ftabelas.query2.prepare;
     ftabelas.query2.open;
     try
        if ftabelas.query2.fields[0].value>0 then c:=true else c:=false;
     except
        c:=false;
     end;

     if c=true then
        begin
           try
              VPDR.saldo_cliente:=ftabelas.query2.fieldbyname('SALDO').value;
              c:=true;
           except
              c:=false;
           end;
        end;

     if c=false then
        begin
           ftabelas.query2.close;
           ftabelas.query2.sql.clear;
//           VPDR.query2.sql.add('select * from acr106 where codigo='+floattostr(VPDR.codigo_conveniado)+' and empresa='+floattostr(VPDR.codemp_conveniado));
           ftabelas.query2.sql.add('select * from acr106 where codigo='+floattostr(codigo_cliente));
           ftabelas.query2.prepare;
           ftabelas.query2.open;
           try
              VPDR.saldo_cliente:=ftabelas.query2.fieldbyname('Lim_credit').value;
           except
              messagedlg('Não é possível concluir a transação pois'+chr(13)+'não foi estipulado um limite de crédito para o cliente.'+chr(13)+'Verifique o cadastro deste cliente!',mtinformation,[mbok],0);
              VPDR.status_cliente:=1;
              exit;
           end;
        end;

     if VPDR.Saldo_cliente>=VPDR.v_total then
        begin
           VPDR.status_cliente:=2;
        end
     else
        begin
           IF (VPDR.vmodtec='2') then // caso existe um teclado gertec 65 instalado no PDV
              begin                                              // e o sistema permita digitar algum dado.
                 VPDR.hndl:=LoadLibrary('TEC65_32.DLL');
                    if VPDR.hndl <> 0 then
                       begin
                          @VPDR.opentec65:=GetProcAddress(VPDR.hndl, 'OpenTec65'); // inicializa o display do teclado
                          @VPDR.dispstr:=GetProcAddress(VPDR.hndl, 'DispStr'); // escreve no display do teclado
                          @VPDR.gotoxy:=GetProcAddress(VPDR.hndl, 'GoToXY');
                          @VPDR.setdisp:=GetProcAddress(VPDR.hndl, 'SetDisp'); // ativa o display do teclado
                          @VPDR.formfeed:=Getprocaddress(VPDR.hndl,'FormFeed');
                          VPDR.opentec65;
                          VPDR.setdisp(1);
                          VPDR.formfeed;
                          VPDR.gotoxy(1,1);
                          strpcopy(VPDR.Mensagem_display,'SALDO ESGOTADO. '+'Saldo Atual:'+copy(floattostr(VPDR.saldo_cliente),1,length(floattostr(VPDR.saldo_cliente))-3)+copy(floattostr(VPDR.saldo_cliente),length(floattostr(VPDR.saldo_cliente))-2,2));
                          VPDR.dispstr(VPDR.Mensagem_display);
                          VPDR.setdisp(0);
                          FreeLibrary(VPDR.hndl);
                       end;
              end;
           strpcopy(men,'Saldo esgotado.'+chr(13)+chr(13)+'Saldo Atual:'+copy(floattostr(VPDR.saldo_cliente),1,length(floattostr(VPDR.saldo_cliente))-3)+copy(floattostr(VPDR.saldo_cliente),length(floattostr(VPDR.saldo_cliente))-2,2));
           application.messagebox(men,cap,MB_OK);
           VPDR.status_cliente:=1;
        end;
end;


procedure TFconscli.Edit1Enter(Sender: TObject);
begin
     EDIT1.CLEAR;
     IF (VPDR.vmodtec='2') then // caso existe um teclado gertec 65 instalado no PDV
        begin                                              // e o sistema permita digitar algum dado.
           VPDR.hndl:=LoadLibrary('TEC65_32.DLL');
           if VPDR.hndl <> 0 then
              begin
                 @VPDR.opentec65:=GetProcAddress(VPDR.hndl, 'OpenTec65'); // inicializa o display do teclado
                 @VPDR.dispstr:=GetProcAddress(VPDR.hndl, 'DispStr'); // escreve no display do teclado
                 @VPDR.gotoxy:=GetProcAddress(VPDR.hndl, 'GoToXY');
                 @VPDR.setdisp:=GetProcAddress(VPDR.hndl, 'SetDisp'); // ativa o display do teclado
                 @VPDR.formfeed:=Getprocaddress(VPDR.hndl,'FormFeed');
                 if @VPDR.opentec65  <> nil then VPDR.opentec65;
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(1);
                 if @VPDR.formfeed   <> nil then VPDR.formfeed;
                 if @VPDR.gotoxy     <> nil then VPDR.gotoxy(1,1);
                 strpcopy(VPDR.Mensagem_display,'SELECIONE O TIPO DE CONSULTA AO CLIENTE');
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 if @VPDR.gotoxy     <> nil then VPDR.gotoxy(2,1);
                 strpcopy(VPDR.Mensagem_display,'0-CANCELA      1-CODIGO      2-CPF/CNPJ');
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                 FreeLibrary(VPDR.hndl);
              end;
        end;
end;

procedure TFconscli.trava_mouse(tipo:integer);
var R: TRect;
begin
     if tipo=1 then
        begin
           screen.cursor:=-1;
           { Pega o retângulo da área cliente do form }
           R:=GetClientRect;
           {Converte as coordenadas do form em coordenadas da tela }
           R.TopLeft.x:=R.TopLeft.x+30;
           R.TopLeft.y:=R.TopLeft.y+30;
           R.BottomRight.x:=R.BottomRight.x-30;
           R.BottomRight.y:=R.BottomRight.y-30;
           R.TopLeft:= ClientToScreen(R.TopLeft);
           R.BottomRight:= ClientToScreen(R.BottomRight);
           { Limita a região de movimentação do mouse }
           ClipCursor(@R);
        end;

     if tipo=2 then
        begin
           { Libera a movimentação }
           ClipCursor(nil);
        end;
end;

procedure TFconscli.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     trava_mouse(2);
end;

procedure TFconscli.edcliEnter(Sender: TObject);
begin
     IF (VPDR.vmodtec='2') then // caso existe um teclado gertec 65 instalado no PDV
        begin                                              // e o sistema permita digitar algum dado.
           VPDR.hndl:=LoadLibrary('TEC65_32.DLL');
           if VPDR.hndl <> 0 then
              begin
                 @VPDR.opentec65:=GetProcAddress(VPDR.hndl, 'OpenTec65'); // inicializa o display do teclado
                 @VPDR.dispstr:=GetProcAddress(VPDR.hndl, 'DispStr'); // escreve no display do teclado
                 @VPDR.gotoxy:=GetProcAddress(VPDR.hndl, 'GoToXY');
                 @VPDR.setdisp:=GetProcAddress(VPDR.hndl, 'SetDisp'); // ativa o display do teclado
                 @VPDR.formfeed:=Getprocaddress(VPDR.hndl,'FormFeed');
                 if @VPDR.opentec65  <> nil then VPDR.opentec65;
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(1);
                 if @VPDR.formfeed   <> nil then VPDR.formfeed;
                 if @VPDR.gotoxy     <> nil then VPDR.gotoxy(1,1);
                 IF TIP=1 THEN strpcopy(VPDR.Mensagem_display,'INFORME O CODIGO DO CLIENTE');
                 IF TIP=2 THEN strpcopy(VPDR.Mensagem_display,'INFORME O CPF/CNPJ DO CLIENTE');
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                 FreeLibrary(VPDR.hndl);
              end;
        end;
end;

procedure TFconscli.edcliChange(Sender: TObject);
begin
     IF (VPDR.vmodtec='2') then // caso existe um teclado gertec 65 instalado no PDV
        begin
           VPDR.hndl:=LoadLibrary('TEC65_32.DLL');
           if VPDR.hndl <> 0 then
              begin
                 @VPDR.opentec65:=GetProcAddress(VPDR.hndl, 'OpenTec65'); // inicializa o display do teclado
                 @VPDR.dispstr:=GetProcAddress(VPDR.hndl, 'DispStr'); // escreve no display do teclado
                 @VPDR.gotoxy:=GetProcAddress(VPDR.hndl, 'GoToXY');
                 @VPDR.setdisp:=GetProcAddress(VPDR.hndl, 'SetDisp'); // ativa o display do teclado
                 if @VPDR.opentec65  <> nil then VPDR.opentec65;
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(1);
                 VPDR.coluna_display:=1;
                 if @VPDR.gotoxy     <> nil then VPDR.gotoxy(2,VPDR.coluna_display);
                 strpcopy(VPDR.Mensagem_display,VPDR.enche(edcli.text,' ',2,40-VPDR.coluna_display));
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                 FreeLibrary(VPDR.hndl);
              end;
        end;
end;

procedure TFconscli.Timer1Timer(Sender: TObject);
begin
     close;
end;

end.
