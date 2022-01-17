unit config;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, XPMenu, IniFiles, SUIComboBox, SUIButton,
  ExtCtrls, SUIForm, SUIMgr;

type
  TFrmConfig = class(TForm)
    LblImpressora: TLabel;
    Label1: TLabel;
    suiForm1: TsuiForm;
    BitBtn1: TsuiButton;
    CmbPorta: TsuiComboBox;
    CmbImpressora: TsuiComboBox;
    Skin: TsuiThemeManager;
    procedure suitempBitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    function SearchString(S_Nome: String): String;
  public
    { Public declarations }
  end;

var
  FrmConfig: TFrmConfig;
  Ini : TIniFile;

implementation

uses main;

{$R *.dfm}

procedure TFrmConfig.suitempBitBtn1Click(Sender: TObject);
begin
  Ini := Tinifile.Create(ExtractFilePath(Application.ExeName)+'dados\autocom.ini');
  Ini.WriteString('CODEBAR','PRINTER',Copy(CmbImpressora.Text,1,2));
  S_Impressora := Copy(CmbImpressora.Text,1,2);
  Ini.WriteString('CODEBAR','PORTA',CmbPorta.Text);
  S_Porta := CmbPorta.Text;
  Ini.free;
end;

procedure TFrmConfig.FormShow(Sender: TObject);
begin
  Ini := Tinifile.Create(ExtractFilePath(Application.ExeName)+'dados\autocom.ini');
  CmbImpressora.Text := SearchString(Ini.ReadString('CODEBAR','PRINTER','01'));
  S_Impressora := Copy(Ini.ReadString('CODEBAR','PRINTER','01'),1,2);
  CmbPorta.Text := Ini.ReadString('CODEBAR','PORTA','COM1');
  S_Porta := Ini.ReadString('CODEBAR','PORTA','COM1');
  Ini.Free;
end;

function TFrmConfig.SearchString(S_Nome: String): String;
var
  i: integer;
  S_Texto: String;
begin
  for i := 0 to CmbImpressora.items.count do
  begin
    if copy(CmbImpressora.Items[i],1,2)= S_Nome then
    begin
      S_Texto := CmbImpressora.Items[i];
      Break;
    end;
  end;
  Result := S_Texto;
end;

procedure TFrmConfig.FormActivate(Sender: TObject);
begin
     skin.uistyle:=FrmMain.skin.uistyle;
     application.ProcessMessages;
end;

end.
