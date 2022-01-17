unit lib;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OnGuard, OgUtil, SUIButton, SUIEdit, ExtCtrls, SUIForm,
  SUIImagePanel, SUIMgr, SUIDlg, registry;

type
  TFlibera = class(TForm)
    Label2: TLabel;
    suiForm1: TsuiForm;
    Edit2: TsuiEdit;
    Edit3: TsuiEdit;
    Button2: TsuiButton;
    suiImagePanel1: TsuiImagePanel;
    Panel1: TPanel;
    suiButton1: TsuiButton;
    suiButton2: TsuiButton;
    suiButton3: TsuiButton;
    skin: TsuiThemeManager;
    msg: TsuiMessageDialog;
    edchaveLib: TsuiEdit;
    Label1: TLabel;
    suiButton4: TsuiButton;
    Labelcnpj: TLabel;
    procedure suitempButton2Click(Sender: TObject);
    procedure suiButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure suiButton3Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure suiButton4Click(Sender: TObject);
    procedure suiButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Flibera: TFlibera;

implementation

uses snt, cadempresa, dm;

{$R *.dfm}

procedure TFlibera.suitempButton2Click(Sender: TObject);
var
  HashValue : Longint;
  Codigo : TCode;
begin
  HashValue := StringHashElf(Fpliber.cnpj_empresa+edit2.text+datetostr(date));
  InitSpecialCode(Fpliber.selecionachave, HashValue, date-1, Codigo);
  Edit3.Text := BufferToHex(Codigo, SizeOf(Codigo));
  edchavelib.setfocus;
end;

procedure TFlibera.suiButton1Click(Sender: TObject);
begin
     IF Fpliber.Mensagem(msg, 2, 'Deseja realmente sair do utilitário?')=mryes then application.terminate;

end;

procedure TFlibera.FormActivate(Sender: TObject);
begin
     Fpliber.Muda_skin(skin);
     application.processmessages;
                  
     if (ParamCount = 2) and (ParamStr(1) = 'handle') then
        begin
           suiButton3.Visible:=false;
           Fcadempresa.procurapessoa1;
        end;
     LabelCNPJ.caption:='CNPJ da empresa:' + Fpliber.cnpj_empresa;
end;

procedure TFlibera.suiButton3Click(Sender: TObject);
begin
     close;
end;

procedure TFlibera.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN:
      begin
         Perform(WM_NEXTDLGCTL,0,0);
      end;
  end;

end;

procedure TFlibera.suiButton4Click(Sender: TObject);
const
     Registro_win_licenca='\Software\AutocomPLUS\'; // path para grava/leitura do status da licença do sistema (data limite) no registro do windows.
var
   Reg: TRegistry;
   codigo: TCode;
begin
     HexToBuffer(edchaveLib.Text, Codigo, SizeOf(Codigo));
     if not IsSpecialCodeValid(Fpliber.selecionachave, Codigo) then
        begin
           Fpliber.Mensagem(msg, 1, 'Chave de liberação inválida. Verifique!');
        end
     else
        begin
           if IsSpecialCodeExpired(Fpliber.selecionachave, Codigo) then
              begin
                 Fpliber.Mensagem(msg, 1, 'Chave de liberação expirada. Verifique!');
              end
           else
              begin
                 Reg:=TRegistry.Create;
                 Reg.RootKey:=HKEY_LOCAL_MACHINE;
                 if Reg.OpenKey(Registro_win_licenca+extractfilepath(application.exename),true) then
                    begin
                       Reg.WriteString('Licenca',edchavelib.text);
                       Reg.WriteString('IDCL',Fpliber.chave_usada);
                    end;
                 Reg.Free;
                 Fpliber.Mensagem(msg, 1, 'Chave de liberação gravada!');
                 suibutton2.enabled:=true;
                 suibutton2.setfocus;
              end;
        end;
end;



procedure TFlibera.suiButton2Click(Sender: TObject);
begin
     application.terminate;
end;

end.
