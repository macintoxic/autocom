program atconc;

uses
  Forms,
  atcconc in 'atcconc.pas' {frm_FATCPR},
  tela_login in 'tela_login.pas' {frm_login},
  tela_fim in 'tela_fim.pas' {ffim};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := 'Sistema Autocom';
  Application.CreateForm(Tfrm_FATCPR, frm_FATCPR);
  Application.CreateForm(Tfrm_login, frm_login);
  Application.CreateForm(Tffim, ffim);
  Application.Run;
end.
