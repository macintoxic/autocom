unit getcpf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Mask, ExtCtrls, DB, DBTables, XPMenu;

type
  TFgetcpf = class(TForm)
    Panel1: TPanel;
    edcli: TMaskEdit;
    Label5: TLabel;
    TBCONV: TTable;
    TBCONVCodigo: TFloatField;
    TBCONVSaldo: TStringField;
    TBCONVData: TDateField;
    TBCONVHora: TTimeField;
    TBCONVOperador: TFloatField;
    XPMenu1: TXPMenu;
    procedure FormActivate(Sender: TObject);
    procedure edcliKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edcliEnter(Sender: TObject);
    procedure edcliChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure procura_cliente(cod:string);
    procedure trava_mouse(tipo:integer);
  end;

var
  Fgetcpf: TFgetcpf;
  cap,men:array[0..200] of char;

implementation

uses venda;

{$R *.DFM}

procedure TFgetcpf.FormActivate(Sender: TObject);
begin
     Fgetcpf.top:=287;
     Fgetcpf.left:=437;
     Fgetcpf.height:=262;
     Fgetcpf.width:=353;
     trava_mouse(1);
     cap:='AUTOCOM PLUS';
     edCLi.setfocus;
end;

procedure TFgetcpf.edcliKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=vk_escape then
        begin
           VPDR.V_tipo_cliente:='';
           VPDR.V_cpfcnpj:='';
           close;
        end;

     if key=vk_return then
        begin
           procura_cliente(edcli.text);

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
                       @VPDR.backspace:=GetProcAddress(VPDR.hndl, 'BackSpace'); // apaga o ?ltimo caractar e posiciona o cursor uma casa anterior
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

procedure TFgetcpf.procura_cliente(cod:string);
var num:integer;
begin
     cod:=trim(cod);
     num:=VPDR.ValidaCPF(cod);
     if num=0 then
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
           messagedlg('CPF/CNPJ do cliente est? inv?lido. Verifique!',mtinformation,[mbok],0);
           edcli.setfocus;
        end
     else
        begin
           VPDR.V_tipo_cliente:=inttostr(num);
           VPDR.V_cpfcnpj:=cod;
           close;
        end;

end;

procedure TFgetcpf.trava_mouse(tipo:integer);
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

procedure TFgetcpf.FormClose(Sender: TObject; var Action: TCloseAction);
begin
     trava_mouse(2);
end;

procedure TFgetcpf.edcliEnter(Sender: TObject);
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
                 strpcopy(VPDR.Mensagem_display,'INFORME O CPF/CNPJ DO CLIENTE');
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                 FreeLibrary(VPDR.hndl);
              end;
        end;
end;

procedure TFgetcpf.edcliChange(Sender: TObject);
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

end.
