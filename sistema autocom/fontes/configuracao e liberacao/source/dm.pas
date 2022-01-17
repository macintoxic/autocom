unit dm;

interface

uses
  SysUtils, Classes, IBDatabase, DB, IBCustomDataSet, IBQuery;

type
  TFdm = class(TDataModule)
    dbautocom: TIBDatabase;
    IBTransaction1: TIBTransaction;
    query: TIBQuery;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure RunSQL(strQuery: string; IBDatabase: TIBDatabase; abre: Boolean = true);
  end;

var
  Fdm: TFdm;

implementation

{$R *.dfm}
procedure TFdm.RunSQL(strQuery: string; IBDatabase: TIBDatabase; abre: Boolean = true);
begin
     with Query do
     begin
          close;
          Database := IBDatabase;
          SQL.Text := strQuery;
          if abre=true then Open else ExecSQL;
     end;
end;


end.
