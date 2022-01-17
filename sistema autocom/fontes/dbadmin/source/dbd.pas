unit dbd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,inifiles;

type
  TFbd = class(TForm)
    Label7: TLabel;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fbd: TFbd;

implementation

{$R *.dfm}

procedure TFbd.FormActivate(Sender: TObject);
var ini:Tinifile;
begin
     button1.setfocus;
     try
        ini:=TIniFile.Create(extractfilepath(application.exename)+'dados\autocom.INI');
        edit1.text:=ini.readString('ATCPLUS', 'IP_SERVER', ''); // endereço ip do servidor
        edit2.text:=ini.readString('ATCPLUS', 'PATH_DB', '');     // caminho do banco de dados no servidor
        if strtoint(ini.readString('TERMINAL', 'PDVNUM', '0'))=0 then button2.caption:='Fechar Terminal' else button2.caption:='Desligar Terminal';
     finally
        ini.Free;
     end;
end;

procedure TFbd.Button1Click(Sender: TObject);
var ini:Tinifile;
begin
     try
        ini:=TIniFile.Create(extractfilepath(application.exename)+'dados\autocom.INI');
        ini.writeString('ATCPLUS', 'IP_SERVER', trim(edit1.text)); // endereço ip do servidor
        ini.writeString('ATCPLUS', 'PATH_DB', trim(edit2.text));     // caminho do banco de dados no servidor
     finally
        ini.Free;
     end;
     close;
end;

procedure TFbd.Button2Click(Sender: TObject);
begin
     if pos('Desligar',Button2.caption)>0 then
        begin
           ExitWindowsEx(EWX_SHUTDOWN,0);// sai do windows!!
           close;
        end
     else
        begin
           close;
        end;
end;

end.
