unit dadoscha;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, Buttons, ExtCtrls, XPMenu;

type
  TFdadoscha = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    Label9: TLabel;
    BitBtn1: TBitBtn;
    MaskEdit1: TMaskEdit;
    MaskEdit8: TMaskEdit;
    XPMenu1: TXPMenu;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure MaskEdit8KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MaskEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MaskEdit8Enter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure trava_mouse(tipo:integer);
    procedure grava;
    procedure filtra_dados;
    procedure data_pre;
  end;

var
  Fdadoscha: TFdadoscha;
  vbanco,vnum_cheq,vagencia,vconta:string;

implementation

uses venda;

{$R *.DFM}

procedure TFdadoscha.FormActivate(Sender: TObject);
begin
     fdadoscha.top:=287;
     fdadoscha.left:=437;
     fdadoscha.height:=262;
     fdadoscha.width:=353;
     trava_mouse(1);
     maskedit1.clear;
     maskedit8.clear;
     label9.visible:=false;
     maskedit8.visible:=false;
     bitbtn1.visible:=false;
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
                 strpcopy(VPDR.Mensagem_display,'             DADOS DO CHEQUE            ');
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 strpcopy(VPDR.Mensagem_display,'PASSE O CHEQUE NO LEITOR');
                 if @VPDR.gotoxy     <> nil then VPDR.gotoxy(2,1);
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                 FreeLibrary(VPDR.hndl);
              end;
        end;


     maskedit1.setfocus;
end;

procedure TFdadoscha.BitBtn1Click(Sender: TObject);
begin
     if length(trim(maskedit1.text))>0 then
        begin
           if maskedit8.visible=true then
              begin
                 try
                    strtodate(maskedit8.text);
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
                                strpcopy(VPDR.Mensagem_display,'             DADOS DO CHEQUE            ');
                                if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                                strpcopy(VPDR.Mensagem_display,'DATA DO CHEQUE-PRE INVALIDA. VERIFIQUE');
                                if @VPDR.gotoxy     <> nil then VPDR.gotoxy(2,1);
                                if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                                if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                                FreeLibrary(VPDR.hndl);
                             end;
                       end;
                    messagedlg('Data do cheque-pré inválida. Verifique!',mtinformation,[mbok],0);
                    maskedit8.setfocus;
                    exit;
                 end;
              end;
           grava;
           VPDR.dados_cheq_manual:=false;
           close;
        end
     else
        begin
           VPDR.dados_cheq_manual:=true;
           close;
        end;
end;

procedure Tfdadoscha.grava;
var teste:string;
begin
     VPDR.banco_cheq:=VPDR.enche(trim(vbanco),'0',1,3);
     VPDR.num_cheq:=VPDR.enche(trim(vnum_cheq),'0',1,10);
     VPDR.agencia_cheq:=VPDR.enche(trim(vagencia),'0',1,10);
     VPDR.conta_cheq:=VPDR.enche(trim(vconta),'0',1,10);

     if maskedit8.visible=true then
        begin
           teste:=maskedit8.text;
           while pos('/',teste)>0 do delete(teste,pos('/',teste),1);
           VPDR.v_datacheqfina[1]:=teste;
        end
     else
        begin
           VPDR.v_datacheqfina[1]:='';
        end;
end;

procedure TFdadoscha.MaskEdit8KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=vk_return then bitbtn1.setfocus;
end;

procedure Tfdadoscha.trava_mouse(tipo:integer);
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

procedure TFdadoscha.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     trava_mouse(2);
end;

procedure TFdadoscha.MaskEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=vk_return then filtra_dados;
     if key=vk_escape then
        begin
           VPDR.dados_cheq_manual:=true;
           close;
        end;
end;

procedure TFdadoscha.filtra_dados;
var teste:string;
begin
     teste:=maskedit1.text;
     if pos('?',teste)>0 then
        begin
           if messagedlg('Erro na leitura do cheque.'+chr(13)+'Tentar novamente ?',mtinformation,[mbyes, mbno],0)=mryes then
              begin
                 maskedit1.clear;
                 maskedit1.setfocus;
                 exit;
              end
           else
              begin
                 VPDR.dados_cheq_manual:=true;
                 close;
              end;
        end;
     if (length(teste)=34) then
        begin
           vbanco:=copy(teste,2,3);
           vnum_cheq:=copy(teste,14,6);
           vagencia:=copy(teste,5,4);
           vconta:=copy(teste,24,9);

           try
              strtofloat(vbanco);
           except
              if messagedlg('Erro na leitura do cheque (banco).'+chr(13)+'Tentar novamente ?',mtinformation,[mbyes, mbno],0)=mryes then
                 begin
                    maskedit1.clear;
                    maskedit1.setfocus;
                    exit;
                 end
              else
                 begin
                    VPDR.dados_cheq_manual:=true;
                    close;
                 end;
           end;


           try
              strtofloat(vnum_cheq);
           except
              if messagedlg('Erro na leitura do cheque (numero do cheque).'+chr(13)+'Tentar novamente ?',mtinformation,[mbyes, mbno],0)=mryes then
                 begin
                    maskedit1.clear;
                    maskedit1.setfocus;
                    exit;
                 end
              else
                 begin
                    VPDR.dados_cheq_manual:=true;
                    close;
                 end;
           end;


           try
              strtofloat(vagencia);
           except
              if messagedlg('Erro na leitura do cheque (agencia).'+chr(13)+'Tentar novamente ?',mtinformation,[mbyes, mbno],0)=mryes then
                 begin
                    maskedit1.clear;
                    maskedit1.setfocus;
                    exit;
                 end
              else
                 begin
                    VPDR.dados_cheq_manual:=true;
                    close;
                 end;
           end;

           try
              strtofloat(vconta);
           except
              if messagedlg('Erro na leitura do cheque (conta).'+chr(13)+'Tentar novamente ?',mtinformation,[mbyes, mbno],0)=mryes then
                 begin
                    maskedit1.clear;
                    maskedit1.setfocus;
                    exit;
                 end
              else
                 begin
                    VPDR.dados_cheq_manual:=true;
                    close;
                 end;
           end;


           data_pre;
           if label9.visible=false then // se não for cheque pre-datado
              begin
                 grava;
                 VPDR.dados_cheq_manual:=false;
                 close;
              end;

        end
     else
        begin
           if messagedlg('Erro na leitura do cheque.'+chr(13)+'Tentar novamente ?',mtinformation,[mbyes, mbno],0)=mryes then
              begin
                 maskedit1.clear;
                 maskedit1.setfocus;
                 exit;
              end
           else
              begin
                 VPDR.dados_cheq_manual:=true;
                 close;
              end;
        end;

end;

procedure TFdadoscha.data_pre;
begin
     if VPDR.v_diacheqfina>0 then
        begin
           label9.visible:=true;
           maskedit8.visible:=true;
           bitbtn1.visible:=true;
           maskedit8.text:=datetostr(date+VPDR.v_diacheqfina);
           maskedit8.setfocus;
           exit;
        end;
     try
        strtodate(VPDR.v_datacheqfina[1]);
     except
        label9.visible:=false;
        maskedit8.visible:=false;
        bitbtn1.visible:=false;
        exit;
     end;
     label9.visible:=true;
     maskedit8.visible:=true;
     bitbtn1.visible:=true;
     maskedit8.text:=VPDR.v_datacheqfina[1];
     maskedit8.setfocus;
end;

procedure TFdadoscha.MaskEdit8Enter(Sender: TObject);
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
                 strpcopy(VPDR.Mensagem_display,'             DADOS DO CHEQUE            ');
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 strpcopy(VPDR.Mensagem_display,'DATA PARA PRE-DATADO:'+MASKEDIT8.TEXT);
                 if @VPDR.gotoxy     <> nil then VPDR.gotoxy(2,1);
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                 FreeLibrary(VPDR.hndl);
              end;
        end;
end;

end.
