//library RVECF;
program RVECF;

uses
  Forms,
  Windows,
  uGlobal,
  uMain in 'uMain.pas' {fMain},
  Module in 'Module.pas' {Dm: TDataModule},
  uConfig in 'uConfig.pas' {fConfig},
  uOptions in 'uOptions.pas' {fOptions},
  uWait in 'uWait.pas' {fWait},
  uConsulta in 'uConsulta.pas' {fConsulta};

{$R *.res}

begin
  Application.Initialize;
  if (ParamCount = 2) and (ParamStr(1) = 'handle') then
    begin
      Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TfWait, fWait);
  Application.Run;
    end
  else
    begin
      Application.MessageBox('Inicie o programa através do menu!','Sistema Autocom Plus',MB_ICONSTOP);
      Application.Terminate;
    end;

end.

