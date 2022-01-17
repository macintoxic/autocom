unit dadosch;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Mask, Buttons, XPMenu;

type
  Tfdadosch = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    BitBtn1: TBitBtn;
    MaskEdit1: TMaskEdit;
    MaskEdit3: TMaskEdit;
    MaskEdit4: TMaskEdit;
    MaskEdit2: TMaskEdit;
    MaskEdit5: TMaskEdit;
    MaskEdit6: TMaskEdit;
    MaskEdit7: TMaskEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    MaskEdit8: TMaskEdit;
    XPMenu1: TXPMenu;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure MaskEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure MaskEdit1Enter(Sender: TObject);
    procedure MaskEdit2Enter(Sender: TObject);
    procedure MaskEdit3Enter(Sender: TObject);
    procedure MaskEdit4Enter(Sender: TObject);
    procedure MaskEdit8Enter(Sender: TObject);
    procedure MaskEdit1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure grava;
    procedure trava_mouse(tipo:integer);
  end;

var
  fdadosch: Tfdadosch;

implementation

uses venda;

{$R *.DFM}

procedure Tfdadosch.FormActivate(Sender: TObject);
begin
     fdadosch.top:=287;
     fdadosch.left:=437;
     fdadosch.height:=262;
     fdadosch.width:=353;
     trava_mouse(1);
     maskedit1.clear;
     maskedit2.clear;
     maskedit3.clear;
     maskedit4.clear;
     maskedit5.clear;
     maskedit6.clear;
     maskedit7.clear;
     maskedit8.clear;
     label9.visible:=false;
     maskedit8.visible:=false;
     maskedit1.setfocus;
     if VPDR.v_diacheqfina>0 then
        begin
           label9.visible:=true;
           maskedit8.visible:=true;
           maskedit8.text:=datetostr(date+VPDR.v_diacheqfina);
           exit;
        end;
     try
        strtodate(VPDR.v_datacheqfina[1]);
     except
        label9.visible:=false;
        maskedit8.visible:=false;
        exit;
     end;
     label9.visible:=true;
     maskedit8.visible:=true;
     maskedit8.text:=VPDR.v_datacheqfina[1];
end;

procedure Tfdadosch.BitBtn1Click(Sender: TObject);
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
                                strpcopy(VPDR.Mensagem_display,'DATA DO CHEQUE-PRE INVALIDA. VERIFIQUE!');
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
           close;
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
                       strpcopy(VPDR.Mensagem_display,'             DADOS DO CHEQUE            ');
                       if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                       strpcopy(VPDR.Mensagem_display,'DEVE-SE INFORMAR O CODIGO DO BANCO.');
                       if @VPDR.gotoxy     <> nil then VPDR.gotoxy(2,1);
                       if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                       if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                       FreeLibrary(VPDR.hndl);
                    end;
              end;
           messagedlg('É necessário informar o BANCO.',mtinformation,[mbok],0);
           maskedit1.clear;
           maskedit1.setfocus;
        end;
end;

procedure Tfdadosch.grava;
var teste:string;
begin
     VPDR.banco_cheq:=VPDR.enche(trim(maskedit1.text),'0',1,3);
     VPDR.num_cheq:=VPDR.enche(trim(maskedit2.text),'0',1,10);
     VPDR.agencia_cheq:=VPDR.enche(trim(maskedit3.text),'0',1,10);
     VPDR.conta_cheq:=VPDR.enche(trim(maskedit4.text),'0',1,10);

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

     if length(trim(maskedit7.text))>0 then
        begin
           VPDR.num_cheq:=VPDR.num_cheq+'-'+VPDR.enche(trim(maskedit7.text),'0',1,2);
        end;
     if length(trim(maskedit6.text))>0 then
        begin
           VPDR.agencia_cheq:=VPDR.agencia_cheq+'-'+VPDR.enche(trim(maskedit6.text),'0',1,2);
        end;
     if length(trim(maskedit5.text))>0 then
        begin
           VPDR.conta_cheq:=VPDR.conta_cheq+'-'+VPDR.enche(trim(maskedit5.text),'0',1,2);
        end;
end;

procedure Tfdadosch.MaskEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=VK_UP Then Perform(WM_NextDlgCtl,1,0);
     if key=VK_DOWN Then Perform(WM_NextDlgCtl,0,0);
     if key=VK_RETURN Then Perform(WM_NextDlgCtl,0,0);
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

procedure Tfdadosch.trava_mouse(tipo:integer);
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


procedure Tfdadosch.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     trava_mouse(2);
end;

procedure Tfdadosch.MaskEdit1Enter(Sender: TObject);
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
                 strpcopy(VPDR.Mensagem_display,'INFORME O CODIGO DO BANCO:');
                 if @VPDR.gotoxy     <> nil then VPDR.gotoxy(2,1);
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                 FreeLibrary(VPDR.hndl);
              end;
        end;
end;

procedure Tfdadosch.MaskEdit2Enter(Sender: TObject);
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
                 strpcopy(VPDR.Mensagem_display,'INFORME O NUMERO DO CHEQUE:');
                 if @VPDR.gotoxy     <> nil then VPDR.gotoxy(2,1);
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                 FreeLibrary(VPDR.hndl);
              end;
        end;

end;

procedure Tfdadosch.MaskEdit3Enter(Sender: TObject);
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
                 strpcopy(VPDR.Mensagem_display,'INFORME A AGENCIA:');
                 if @VPDR.gotoxy     <> nil then VPDR.gotoxy(2,1);
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                 FreeLibrary(VPDR.hndl);
              end;
        end;

end;

procedure Tfdadosch.MaskEdit4Enter(Sender: TObject);
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
                 strpcopy(VPDR.Mensagem_display,'INFORME O NUMERO DA CONTA:');
                 if @VPDR.gotoxy     <> nil then VPDR.gotoxy(2,1);
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                 FreeLibrary(VPDR.hndl);
              end;
        end;

end;

procedure Tfdadosch.MaskEdit8Enter(Sender: TObject);
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

procedure Tfdadosch.MaskEdit1Change(Sender: TObject);
var e:Tmaskedit;
begin
     e:=sender as Tmaskedit;
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
                 VPDR.coluna_display:=30;
                 if @VPDR.gotoxy     <> nil then VPDR.gotoxy(2,VPDR.coluna_display);
                 strpcopy(VPDR.Mensagem_display,VPDR.enche(e.text,' ',2,40-VPDR.coluna_display));
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                 FreeLibrary(VPDR.hndl);
              end;
        end;
end;

end.
