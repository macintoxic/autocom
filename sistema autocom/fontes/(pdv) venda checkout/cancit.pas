unit cancit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Db, DBTables,dbiprocs, XPMenu;

type
  TFci = class(TForm)
    Panel1: TPanel;
    ListBox1: TListBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    XPMenu1: TXPMenu;
    procedure FormActivate(Sender: TObject);
    procedure ListBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure trava_mouse(tipo:integer);
    procedure carrega_lista;
    procedure apaga_item;
  end;

var
  Fci: TFci;

implementation

uses venda, tab;

{$R *.DFM}

procedure TFci.FormActivate(Sender: TObject);
begin
     fci.top:=146;
     fci.left:=0;
     fci.height:=313;
     fci.width:=screen.width;
     trava_mouse(1);
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
                 strpcopy(VPDR.Mensagem_display,'Utilize as setas para selecionar o item');
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 if @VPDR.gotoxy     <> nil then VPDR.gotoxy(2,1);
                 strpcopy(VPDR.Mensagem_display,'[ENTER]-CANCELA O ITEM       [CORR]-SAIR');
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                 FreeLibrary(VPDR.hndl);
              end;
        end;
     carrega_lista;
     listbox1.setfocus;
end;

procedure Tfci.carrega_lista;
var atual,b:integer;
    produto,quantidade,unitario,total,desc:string;
    acr203:textfile;
    v_codigo, v_quantidade,v_valorun,v_valorto,v_trib,v_funcao,v_data, v_hora:string;
    v_operador,v_banco,v_agencia,v_conta,v_numero,v_cliente,v_indicador,v_CPFCNPJ:string;
    v_Ncp,v_terminal,v_ECF,v_P,v_C,v_Loja:string;
    linha:string;
begin
     listbox1.items.clear;
     atual:=0;
     if not fileexists(extractfilepath(application.exename)+'dados\acr203.vnd') then exit;
     AssignFile(acr203, extractfilepath(application.exename)+'dados\acr203.vnd');
     Reset(acr203);
     While not Eof(acr203) do
        begin
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

           if v_funcao=chr(39)+'00'+chr(39) then
              begin
                 while pos(chr(39),v_codigo)>0 do delete(v_codigo,pos(chr(39),v_codigo),1);
                 produto:=v_codigo;

                 while pos(chr(39),v_quantidade)>0 do delete(v_quantidade,pos(chr(39),v_quantidade),1);
                 quantidade:=v_quantidade;

                 while pos(chr(39),v_valorun)>0 do delete(v_valorun,pos(chr(39),v_valorun),1);
                 unitario:=v_valorun;

                 while pos(chr(39),v_valorto)>0 do delete(v_valorto,pos(chr(39),v_valorto),1);
                 total:=v_valorto;

                 ftabelas.query2.close;
                 ftabelas.query2.sql.clear;
                 ftabelas.query2.sql.add('select * from produto where codigoproduto='+produto);
                 ftabelas.query2.prepare;
                 ftabelas.query2.open;

                 desc:=VPDR.enche(copy(ftabelas.query2.fieldbyname('nomeproduto').value,1,30),' ',1,30);
                 b:=strtoint(floattostr(ftabelas.query2.fieldbyname('decimais').value));

                 unitario:=VPDR.enche(VPDR.strtoformat(unitario,b),' ',1,8);
                 quantidade:=VPDR.enche(VPDR.strtoformat(quantidade,3),' ',1,7);
                 total:=VPDR.enche(VPDR.strtoformat(total,2),' ',1,11);


                 while pos(chr(39),v_c)>0 do delete(v_c,pos(chr(39),v_c),1);
                 listbox1.items.add(Trim(v_c)+'['+produto+']'+desc+':'+quantidade+' x '+unitario+' = '+total);
                 VPDR.posdb[atual]:=v_hora;
                 VPDR.posecf[atual]:=atual+1;
                 atual:=atual+1;
              end;
        end;
     closefile(acr203);
end;

procedure Tfci.apaga_item;
begin
     VPDR.indice_item:=inttostr(listbox1.itemindex);
     close;
end;

procedure Tfci.trava_mouse(tipo:integer);
var R: TRect;
begin
     if tipo=1 then
        begin
           screen.cursor:=-1;
           { Pega o ret?ngulo da ?rea cliente do form }
           R:=GetClientRect;
           {Converte as coordenadas do form em coordenadas da tela }
           R.TopLeft.x:=R.TopLeft.x+30;
           R.TopLeft.y:=R.TopLeft.y+30;
           R.BottomRight.x:=R.BottomRight.x-30;
           R.BottomRight.y:=R.BottomRight.y-30;
           R.TopLeft:= ClientToScreen(R.TopLeft);
           R.BottomRight:= ClientToScreen(R.BottomRight);
           { Limita a regi?o de movimenta??o do mouse }
           ClipCursor(@R);
        end;

     if tipo=2 then
        begin
           { Libera a movimenta??o }
           ClipCursor(nil);
        end;
end;


procedure TFci.ListBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=vk_escape then
        begin
           VPDR.indice_item:='';
           close;
        end;
     if (key=vk_return) and (listbox1.itemindex>=0) then apaga_item;
end;

procedure TFci.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     IF (VPDR.vmodtec='2') then // caso existe um teclado gertec 65 instalado no PDV
        begin                                              // e o sistema permita digitar algum dado.
           VPDR.hndl:=LoadLibrary('TEC65_32.DLL');
           if VPDR.hndl <> 0 then
              begin
                 @VPDR.opentec65:=GetProcAddress(VPDR.hndl, 'OpenTec65'); // inicializa o display do teclado
                 @VPDR.formfeed:=GetProcAddress(VPDR.hndl, 'FormFeed'); // escreve no display do teclado
                 @VPDR.gotoxy:=GetProcAddress(VPDR.hndl, 'GoToXY');
                 @VPDR.setdisp:=GetProcAddress(VPDR.hndl, 'SetDisp'); // ativa o display do teclado
                 if @VPDR.opentec65  <> nil then VPDR.opentec65;
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(1);
                 if @VPDR.gotoxy     <> nil then VPDR.gotoxy(1,1);
                 if @VPDR.formfeed   <> nil then VPDR.formfeed;
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                 FreeLibrary(VPDR.hndl);
              end;
        end;
end;

end.
