unit cadempresa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, SUIForm, SUIImagePanel, SUIButton, SUIMgr, SUIDlg,
  StdCtrls, SUIEdit;

type
  TFcadempresa = class(TForm)
    suiForm1: TsuiForm;
    suiImagePanel1: TsuiImagePanel;
    Panel1: TPanel;
    suiButton1: TsuiButton;
    suiButton2: TsuiButton;
    suiButton3: TsuiButton;
    skin: TsuiThemeManager;
    msg: TsuiMessageDialog;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    edrazaosocial: TsuiEdit;
    ednomefantasia: TsuiEdit;
    edcnpj: TsuiEdit;
    suiButton4: TsuiButton;
    procedure suiButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure suiButton3Click(Sender: TObject);
    procedure suiButton4Click(Sender: TObject);
    procedure suiButton2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    procedure gravapessoa1;
  public
    { Public declarations }
    procedure procurapessoa1;
  end;

var
  Fcadempresa: TFcadempresa;

implementation

uses snt, dm, lib;

{$R *.dfm}

procedure TFcadempresa.suiButton1Click(Sender: TObject);
begin
     IF Fpliber.Mensagem(msg, 2, 'Deseja realmente sair do utilitário?')=mryes then application.terminate;

end;

procedure TFcadempresa.FormActivate(Sender: TObject);
begin
     Fpliber.Muda_skin(skin);
     application.processmessages;
     procurapessoa1;
end;

procedure TFcadempresa.suiButton3Click(Sender: TObject);
begin
     close;
end;

procedure TFcadempresa.suiButton4Click(Sender: TObject);
begin
     try
        if Fpliber.IsEditNull(label1.caption,edrazaosocial)=true then
           begin
              edrazaosocial.SetFocus;
              edrazaosocial.SelectAll;
              exit;
           end;

        if Fpliber.IsEditNull(label2.caption,ednomefantasia)=true then
           begin
              ednomefantasia.SetFocus;
              ednomefantasia.SelectAll;
              exit;
           end;

        if not Fpliber.ValidaCnpj(edcnpj.Text) then
           begin
              Fpliber.Mensagem(msg, 1, 'CNPJ inválido. VErifique!');
              edcnpj.SetFocus;
              edcnpj.SelectAll;
              exit;
           end;
        gravapessoa1;
        suibutton2.Enabled:=true;
        suibutton2.setfocus;
        Fpliber.cnpj_empresa:=edcnpj.text;
     except
        suibutton2.Enabled:=false;
     end;
end;

procedure TFcadempresa.procurapessoa1;
begin
     fDM.dbautocom.databasename:=Fpliber.LeINI('ATCPLUS', 'IP_SERVER', extractfilepath(application.exename)+'dados\autocom.ini')+':'+
                                 Fpliber.LeINI('ATCPLUS', 'PATH_DB', extractfilepath(application.exename)+'dados\autocom.ini');
     fDM.dbautocom.connected:=true;
     fDM.ibtransaction1.active:=true;

     fDM.RunSql('SELECT PES_NOME_A, PES_APELIDO_A, PES_CPF_CNPJ_A FROM PESSOA Where PES_CODPESSOA = 1',Fdm.dbautocom);

     edrazaosocial.text:=trim(fdm.query.fieldbyname('PES_NOME_A').asstring);
     ednomefantasia.text:=trim(fdm.query.fieldbyname('PES_APELIDO_A').asstring);
     edcnpj.text:=trim(fdm.query.fieldbyname('PES_CPF_CNPJ_A').asstring);
     Fpliber.cnpj_empresa:=trim(fdm.query.fieldbyname('PES_CPF_CNPJ_A').asstring);

     fDM.ibtransaction1.active:=false;
     fDM.dbautocom.connected:=false;
end;

procedure TFcadempresa.gravapessoa1;
begin
     fDM.dbautocom.databasename:=Fpliber.LeINI('ATCPLUS', 'IP_SERVER', extractfilepath(application.exename)+'dados\autocom.ini')+':'+
                                 Fpliber.LeINI('ATCPLUS', 'PATH_DB', extractfilepath(application.exename)+'dados\autocom.ini');
     fDM.dbautocom.connected:=true;
     fDM.ibtransaction1.active:=true;

     fDM.RunSql('UPDATE PESSOA set '+
            'PES_NOME_A     ='+quotedstr(edrazaosocial.text)+','+
            'PES_APELIDO_A  ='+quotedstr(ednomefantasia.text)+','+
            'PES_CPF_CNPJ_A ='+quotedstr(edcnpj.text)+' '+
            'Where PES_CODPESSOA = 1',Fdm.dbautocom,false);

     fDM.RunSql('Commit',Fdm.dbautocom,false);

     fDM.ibtransaction1.active:=false;
     fDM.dbautocom.connected:=false;

     Fpliber.Mensagem(msg, 1, 'Dados gravados com sucesso!');
end;


procedure TFcadempresa.suiButton2Click(Sender: TObject);
begin
     Flibera.showmodal;
end;

procedure TFcadempresa.FormKeyDown(Sender: TObject; var Key: Word;
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
