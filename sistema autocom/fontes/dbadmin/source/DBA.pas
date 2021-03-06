unit DBA;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, jpeg;

type
  TFBDA = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Image1: TImage;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    path:string;
  end;

var
  FBDA: TFBDA;

implementation

uses dbtab, dbd;

{$R *.DFM}

procedure TFBDA.FormActivate(Sender: TObject);
begin
     path:=extractfilepath(application.exename)+'Dados\';
     screen.cursor:=crhourglass;
     application.processmessages;

     label1.caption:='Definindo localização da base de dados... ';
     application.processmessages;
     while tab.path_tabelas=false do
        begin
           fbd.showmodal;
        end;
     refresh;

     screen.cursor:=crdefault;
     close;
end;

end.
