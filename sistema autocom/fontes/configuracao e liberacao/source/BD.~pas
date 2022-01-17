unit BD;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SUIForm, SUIImagePanel, SUIButton, StdCtrls, SUIEdit,
  SUIMgr, SUIDlg;

type
  TFbd = class(TForm)
    suiForm1: TsuiForm;
    suiImagePanel1: TsuiImagePanel;
    Panel1: TPanel;
    suiButton1: TsuiButton;
    suiButton2: TsuiButton;
    suiButton3: TsuiButton;
    Label1: TLabel;
    Label2: TLabel;
    edip: TsuiEdit;
    edpath: TsuiEdit;
    suiButton4: TsuiButton;
    Btn_procurar: TsuiButton;
    skin: TsuiThemeManager;
    btn_testaconexao: TsuiButton;
    msg: TsuiMessageDialog;
    od: TOpenDialog;
    procedure suiButton1Click(Sender: TObject);
    procedure edipExit(Sender: TObject);
    procedure suiButton4Click(Sender: TObject);
    procedure suiButton3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btn_testaconexaoClick(Sender: TObject);
    procedure suiButton2Click(Sender: TObject);
    procedure Btn_procurarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fbd: TFbd;

implementation

uses snt, dm, cadempresa;

{$R *.dfm}

procedure TFbd.suiButton1Click(Sender: TObject);
begin
     IF Fpliber.Mensagem(msg, 2, 'Deseja realmente sair do utilitário?')=mryes then application.terminate;

end;

procedure TFbd.edipExit(Sender: TObject);
begin
     if uppercase(trim(edip.text))='LOCALHOST' then btn_procurar.enabled:=true else btn_procurar.enabled:=false;
end;

procedure TFbd.suiButton4Click(Sender: TObject);
begin
     edip.text:='LOCALHOST';
     edip.setfocus;
end;

procedure TFbd.suiButton3Click(Sender: TObject);
begin
     close;
end;

procedure TFbd.FormActivate(Sender: TObject);
begin
     Fpliber.Muda_skin(skin);
     application.processmessages;

     edIP.text:=Fpliber.LeINI('ATCPLUS', 'IP_SERVER', extractfilepath(application.exename)+'dados\autocom.ini');
     edpath.text:=Fpliber.LeINI('ATCPLUS', 'PATH_DB', extractfilepath(application.exename)+'dados\autocom.ini');
     edip.setfocus;
end;

procedure TFbd.btn_testaconexaoClick(Sender: TObject);
begin
     fDM.dbautocom.databasename:=edIP.text+':'+edpath.text;

     try
        fDM.dbautocom.connected:=true;
        fDM.ibtransaction1.active:=true;
        fDM.dbautocom.connected:=false;
        fDM.ibtransaction1.active:=false;
        Fpliber.GravaINI('ATCPLUS', 'IP_SERVER', edIP.text, extractfilepath(application.exename)+'dados\autocom.ini');
        Fpliber.GravaINI('ATCPLUS', 'PATH_DB', edpath.text, extractfilepath(application.exename)+'dados\autocom.ini');
        Fpliber.Mensagem(msg, 1, 'Conexão com o Banco de dados OK!');
        suiButton2.enabled:=true;
     except
        Fpliber.Mensagem(msg, 1, 'Não foi possível realizar a conexão com o banco de dados.'+
                            Chr(13)+' Verifique os ítens abaixo:'+
                            chr(13)+'- O Interbase Client não está instalado nesta máquina.'+
                            chr(13)+'- O Interbase Server/Firebird não está ativo na máquina servidor de banco de dados.'+
                            chr(13)+'- O Endereço IP e/ou o caminho do banco de dados estão incorretos.'+
                            chr(13)+'- O banco de dados pode estar corrompido');
        suiButton2.enabled:=false;
     end;
end;

procedure TFbd.suiButton2Click(Sender: TObject);
begin
     Fcadempresa.showmodal;
end;

procedure TFbd.Btn_procurarClick(Sender: TObject);
begin
     if od.execute then
        begin
           edpath.text:=od.filename;
        end;
end;

procedure TFbd.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN:
      begin
          Perform(WM_NEXTDLGCTL,0,0);
      end;
  end;

end;

end.
