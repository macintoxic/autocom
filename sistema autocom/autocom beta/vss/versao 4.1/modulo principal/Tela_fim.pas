unit Tela_fim;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons,inifiles, SUIButton, ExtCtrls, SUIForm, SUIMgr, SUIThemes;

type
  Tffim = class(TForm)
    suiForm1: TsuiForm;
    RadioButton1: TsuiRadioButton;
    RadioButton2: TsuiRadioButton;
    BitBtn2: TsuiButton;
    BitBtn1: TsuiButton;
    skin: TsuiThemeManager;
    procedure suitempBitBtn1Click(Sender: TObject);
    procedure suitempBitBtn2Click(Sender: TObject);
    procedure suitempRadioButton1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ffim: Tffim;

implementation

uses atcconc;


{$R *.DFM}

procedure Tffim.suitempBitBtn1Click(Sender: TObject);
begin
     try
        if radiobutton1.checked then frm_FATCPR.tipo_saida:=1;
        if radiobutton2.checked then frm_FATCPR.tipo_saida:=2;
     finally
        ffim.close;
     end;
end;

procedure Tffim.suitempBitBtn2Click(Sender: TObject);
begin
     frm_FATCPR.tipo_saida:=0;
     ffim.close;
end;

procedure Tffim.suitempRadioButton1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=vk_return then bitbtn1.setfocus;
end;

procedure Tffim.FormActivate(Sender: TObject);
var
    v_ini:Tinifile;
    tipo_skin:string;
begin
     tipo_skin:=frm_FATCPR.LeINI('ATCPLUS', 'skin', extractfilepath(application.exename)+'dados\autocom.ini');
     if (tipo_skin='0') or (tipo_skin='') then skin.uistyle:=WinXP;
     if (tipo_skin='1') then skin.uistyle:=BlueGlass;
     if (tipo_skin='2') then skin.uistyle:=DeepBlue;
     if (tipo_skin='3') then skin.uistyle:=MacOS;
     if (tipo_skin='4') then skin.uistyle:=Protein;
     application.processmessages;

     v_ini:=TIniFile.Create(frm_FATCPR.path+'autocom.ini');
     frm_FATCPR.tipo_saida_def:=strtoint(v_ini.readstring('TERMINAL','Tiposaida','1'));
     v_ini.free;
     if frm_FATCPR.tipo_saida_def=1 then radiobutton1.checked:=true;
     if frm_FATCPR.tipo_saida_def=2 then radiobutton2.checked:=true;
     if frm_FATCPR.tipo_saida_def=3 then radiobutton1.visible:=false else radiobutton1.visible:=true;
     if frm_FATCPR.tipo_saida_def=4 then radiobutton2.visible:=false else radiobutton2.visible:=true;

     if (radiobutton1.visible=true) and (radiobutton2.visible=false) then radiobutton1.checked:=true;
     if (radiobutton1.visible=false) and (radiobutton2.visible=true) then radiobutton2.checked:=true;

     if (radiobutton1.checked) and (radiobutton1.visible=true) then radiobutton1.setfocus;
     if (radiobutton2.checked) and (radiobutton2.visible=true) then radiobutton2.setfocus;
end;

end.
