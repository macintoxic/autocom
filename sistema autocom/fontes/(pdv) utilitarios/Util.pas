unit Util;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, inifiles, ExtCtrls, XPMenu;

type
  Ttef_adm                = function (tipo:string):shortstring;
  Ttef_cheque             = function (coo,valor,data,banco,agencia,agencia_dc,cc,cc_dc,num_cheque,num_cheque_dc,cpfcnpj,tipo_cli,tipo:string):shortstring;
  Ttef_ativo              = function (tipo:string):shortstring;
  Ttef_comprovante        = function (tipo,cupom:string):shortstring;

  tECF_INFO      = function (tipo,porta:integer):shortstring;

  TFutil = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    XPMenu1: TXPMenu;
    procedure FormActivate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure chama_tef_adm(tipo:string);  // chama o modulo do tef de administração
    procedure chama_f1;
    procedure chama_f2;                
    Procedure gravaREG(codigo:real;nome,tipo,sist:string);
    procedure Finaliza_agentes;// altera o semafaro para a finalizacao dos agentes ativos.
  end;

var
  Futil: TFutil;

  prog:array [0..250] of char;
  v_DLL_ECF:array[0..250] of char;

  tef_adm:Ttef_adm;
  tef_ativo:Ttef_ativo;
  tef_cheque:Ttef_cheque;
  tef_comprovante:Ttef_comprovante;


  ECF_INFO:tECF_INFO;

  hand:thandle;
  resp,resposta:string;

  Autocom:Tinifile;

  vModECF:string;// modelo do ECf
  vCOMECF:string;// porta de comunicação do ECF

  v_tef_id,v_tef_coo,v_tef_rede,v_tef_finaliza,v_tef_data,v_tef_hora,v_tef_msg,v_tef_nsu:string;
  path:string;

implementation

{$R *.dfm}

procedure TFutil.Finaliza_agentes;
var num:integer;
    parar:string;
    v_ini:Tinifile;
begin
     // finaliza o aprnet.
     v_ini:=TIniFile.Create(path+'Autocom.ini');
     num:=strtoint(v_ini.readstring('Terminal','PDVNum','0'));
     v_ini.free;
     if num>0 then
        begin
           v_ini:=TIniFile.Create(path+'autocom.ini');
           parar:=v_ini.readstring('APR','Ativo','0');
           v_ini.free;
           if parar<>'9' then
              begin
                 while parar<>'0' do
                    begin
                       v_ini:=TIniFile.Create(path+'autocom.ini');
                       v_ini.writestring('APR','Ativo','9');
                       v_ini.free;
                       sleep(3000);
                       v_ini:=TIniFile.Create(path+'autocom.ini');
                       parar:=v_ini.readstring('APR','Ativo','0');
                       v_ini.free;
                    end;
              end;
        end;

end;

Procedure TFutil.gravaREG(codigo:real;nome,tipo,sist:string);
var operador:Tinifile;
begin
     try
        operador:=TIniFile.Create(path+'OPER.INI');
        operador.writeString('OPER', 'Nome',nome);
        operador.writestring('OPER', 'Tipo',tipo);
        operador.writeFloat('OPER', 'Codigo',codigo);
     finally
        operador.Free;
     end;
end;

procedure TFutil.chama_tef_adm(tipo:string);
begin
     if fileexists(extractfilepath(application.exename)+'dados\comprovante.tef')=true then deletefile(extractfilepath(application.exename)+'dados\comprovante.tef');

     hand:=loadlibrary('atctefdi.dll');
     if hand<>0 then
        begin
           @tef_adm := GetProcAddress(Hand, 'tef_adm');
           if @tef_adm <> nil then
              begin
                 resp:=tef_adm(tipo);
              end;
           freelibrary(hand);
        end;

     if fileexists(path+'comprovante.tef') then
        begin
           label1.caption:=copy(resp,2,length(resp));
           application.processmessages;
        end
     else
        begin
           showmessage(copy(resp,2,length(resp)));
        end;

     if copy(resp,1,1)='2' then
        begin
           hand:=loadlibrary('atctefdi.dll');
           if hand<>0 then
              begin
                 @tef_comprovante := GetProcAddress(Hand, 'tef_comprovante');
                 if @tef_comprovante <> nil then
                    begin
                       resp:=tef_comprovante(tipo,'1'); // este último parametro é um para imprimir a leitura x.
                    end;
                 freelibrary(hand);
              end;
        end;
     label1.caption:='';

end;

procedure TFutil.chama_f1;
begin
     hand:=loadlibrary('atctefdi.dll');
     if hand<>0 then
        begin
           @tef_ativo:= GetProcAddress(hand, 'tef_ativo');
           resp:=tef_ativo('1');
           freelibrary(hand);
        end;
     if copy(resp,1,1)='1' then
        begin
           showmessage(copy(resp,2,length(resp)));
           exit;
        end;

     Futil.keypreview:=false;
     bitbtn8.enabled:=false;
     label1.caption:='';
     application.processmessages;
     chama_tef_adm('1');

     sleep(1000);
     setforegroundwindow(application.handle);
     bitbtn8.enabled:=true;
     Futil.keypreview:=true;
end;

procedure TFutil.chama_f2;
begin
     hand:=loadlibrary('atctefdi.dll');
     if hand<>0 then
        begin
           @tef_ativo:= GetProcAddress(hand, 'tef_ativo');
           resp:=tef_ativo('0');
           freelibrary(hand);
        end;
     if copy(resp,1,1)='1' then
        begin
           showmessage(copy(resp,2,length(resp)));
           exit;
        end;

     Futil.keypreview:=false;
     bitbtn7.enabled:=false;
     label1.caption:='';
     application.processmessages;
     chama_tef_adm('0');

     sleep(1000);
     setforegroundwindow(application.handle);
     bitbtn7.enabled:=true;
     Futil.keypreview:=true;
end;

procedure TFutil.FormActivate(Sender: TObject);
var oper:TIniFile;
    nivel_atual:string;
begin
     Futil.Top := 0;
     Futil.Left := 0;
     Futil.Width := Screen.Width;
     Futil.Height := Screen.Height;

     path:=extractfilepath(application.exename)+'Dados\';

     oper:=TIniFile.Create(path+'oper.INI');
     Nivel_atual:=oper.ReadString('OPER', 'Tipo', '99');     // modelo do ECf
     oper.Free;

//     if Nivel_atual='99' then
//        begin
           bitbtn3.visible:=true;
           bitbtn4.visible:=true;
           bitbtn5.visible:=true;
           bitbtn6.visible:=true;
//        end
//     else
//        begin
//           bitbtn3.visible:=false;
//           bitbtn4.visible:=false;
//           bitbtn5.visible:=false;
//           bitbtn6.visible:=false;
//        end;

     Autocom:=TIniFile.Create(path+'autocom.INI');
     strpcopy(v_DLL_ECF,Autocom.ReadString('MODULOS', 'dll_ECF', '')); // Nome da Dll para comunicação com o ECF
     Autocom.Free;

     Autocom:=TIniFile.Create(path+'autocom.INI');
     vModECF:=Autocom.ReadString('TERMINAL', 'ModECF', '99');     // modelo do ECf
     vCOMECF:=Autocom.ReadString('TERMINAL', 'COMECF', '1');      // porta de comunicação do ECF
     Autocom.Free;
     label1.caption:='';
end;

procedure TFutil.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=vk_f1 then chama_f1;
     if key=vk_f2 then chama_f2;
end;

procedure TFutil.BitBtn2Click(Sender: TObject);
begin
     if application.messagebox('Confirma o restart do terminal?','AUTOCOM - UTILITÁRIOS',mb_yesno)=mryes then
        begin
           gravaREG(0,'','','fcx');
           finaliza_agentes;
           ExitWindowsEx(EWX_REBOOT,0);// restarta o windows!!
        end;
end;

procedure TFutil.BitBtn3Click(Sender: TObject);
begin
     if application.messagebox('Confirma o término da aplicação?','AUTOCOM - UTILITÁRIOS',mb_yesno)=mryes then
        begin
           gravaREG(0,'','','fcx');
           finaliza_agentes;
           APPLICATION.terminate;
        end;
end;

procedure TFutil.BitBtn4Click(Sender: TObject);
begin
     strpcopy(prog,'C:\Windows\Explorer.exe');
     winexec(prog,SW_normal);
end;

procedure TFutil.BitBtn5Click(Sender: TObject);
begin
     strpcopy(prog,'C:\Windows\control.exe');
     winexec(prog,SW_normal);
end;

procedure TFutil.BitBtn6Click(Sender: TObject);
begin
     strpcopy(prog,'C:\WINDOWS\COMMAND.COM');
     winexec(prog,SW_normal);
end;

procedure TFutil.BitBtn1Click(Sender: TObject);
begin
     close;
end;

procedure TFutil.BitBtn8Click(Sender: TObject);
begin
     chama_f1;
end;

procedure TFutil.BitBtn7Click(Sender: TObject);
begin
     chama_f2;
end;

end.
