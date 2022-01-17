program SMT;

uses
  Forms,
  fMain in 'fMain.pas' {FrmMain},
  Module in 'Module.pas' {Dm: TDataModule},
  fConfig in 'fConfig.pas' {FrmConfig},
  fConsulta in 'fConsulta.pas' {FrmConsulta};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'SMT - Servidor de Micro-Terminais';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TDm, Dm);
  Application.Run;
end.
