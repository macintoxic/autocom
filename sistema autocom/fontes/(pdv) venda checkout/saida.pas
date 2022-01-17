unit saida;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, XPMenu;

type
  TFsai = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    XPMenu1: TXPMenu;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure trava_mouse(tipo:integer);
  end;

var
  Fsai: TFsai;

implementation

uses venda;

{$R *.DFM}

procedure TFsai.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
     if key='0' then close;
     if key='1' then
        begin
           VPDR.tipo_saida:=1;
           close;
        end;
     if key='2' then
        begin
           VPDR.tipo_saida:=2;
           close;
        end;
     edit1.clear;
end;

procedure TFsai.FormActivate(Sender: TObject);
begin
     trava_mouse(1);
     edit1.text:='';
     IF (VPDR.vmodtec='2') then // caso existe um teclado gertec 65 instalado no PDV
        begin                                              // e o sistema permita digitar algum dado.
           VPDR.hndl:=LoadLibrary('TEC65_32.DLL');
           if VPDR.hndl <> 0 then
              begin
                 @VPDR.opentec65:=GetProcAddress(VPDR.hndl, 'OpenTec65'); // inicializa o display do teclado
                 @VPDR.dispstr:=GetProcAddress(VPDR.hndl, 'DispStr'); // escreve no display do teclado
                 @VPDR.gotoxy:=GetProcAddress(VPDR.hndl, 'GoToXY');
                 @VPDR.setdisp:=GetProcAddress(VPDR.hndl, 'SetDisp'); // ativa o display do teclado
                 if @VPDR.opentec65  <> nil then VPDR.opentec65;
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(1);
                 if @VPDR.gotoxy     <> nil then VPDR.gotoxy(1,1);
                 strpcopy(VPDR.Mensagem_display,'0-Cancela    1-Volta ao menu principal   ');
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 if @VPDR.gotoxy     <> nil then VPDR.gotoxy(2,1);
                 strpcopy(VPDR.Mensagem_display,'             2-Desliga');
                 if @VPDR.dispstr    <> nil then VPDR.dispstr(VPDR.Mensagem_display);
                 if @VPDR.setdisp    <> nil then VPDR.setdisp(0);
                 FreeLibrary(VPDR.hndl);
              end;
        end;
end;

procedure TFsai.trava_mouse(tipo:integer);
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

procedure TFsai.FormClose(Sender: TObject; var Action: TCloseAction);
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
