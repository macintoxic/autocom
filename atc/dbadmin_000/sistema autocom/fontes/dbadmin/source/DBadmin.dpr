library DBadmin;

uses
  Forms,
  DBA in 'DBA.pas' {FBDA},
  dbtab in 'dbtab.pas' {tab},
  dbd in 'dbd.pas' {Fbd};

{$R *.RES}
{$D ' DBADMIN'}

begin
  Application.Initialize;
  Application.CreateForm(TFBDA, FBDA);
  Application.CreateForm(Ttab, tab);
  Application.CreateForm(TFbd, Fbd);
  Application.Run;
end.
