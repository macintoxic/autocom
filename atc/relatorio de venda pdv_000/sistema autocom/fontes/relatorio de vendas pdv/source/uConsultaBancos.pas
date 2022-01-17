unit uConsultaBancos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, SUIListBox, SUIForm, SUIMgr, SuiThemes,uGlobal;

type
  TfConsultaBancos = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    suiForm1: TsuiForm;
    ListBancos: TsuiListBox;
    skin: TsuiThemeManager;
    procedure SpeedButton1Click(Sender: TObject);
    procedure suitempListBancosDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
  public
  end;

var
  fConsultaBancos: TfConsultaBancos;

implementation

{$R *.dfm}

procedure TfConsultaBancos.SpeedButton1Click(Sender: TObject);
begin
  Close;
end;

procedure TfConsultaBancos.suitempListBancosDblClick(Sender: TObject);
begin
  Close;
end;

procedure TfConsultaBancos.FormActivate(Sender: TObject);
var Tipo_skin:string;
begin
     tipo_skin:=LeINI('ATCPLUS', 'skin');
     if (tipo_skin='0') or (tipo_skin='') then skin.uistyle:=WinXP;
     if (tipo_skin='1') then skin.uistyle:=BlueGlass;
     if (tipo_skin='2') then skin.uistyle:=DeepBlue;
     if (tipo_skin='3') then skin.uistyle:=MacOS;
     if (tipo_skin='4') then skin.uistyle:=Protein;
     application.processmessages;

end;

end.
