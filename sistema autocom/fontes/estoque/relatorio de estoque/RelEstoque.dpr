//program RelEstoque;
library RelEstoque;

uses
  Forms,
  main in 'main.pas' {FrmMain},
  module in 'module.pas' {Dm: TDataModule},
  relsaldo in 'relsaldo.pas' {FrmRelSaldo},
  consulta in 'consulta.pas' {FrmConsulta},
  relap in 'relap.pas' {FrmRelAp};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TFrmRelSaldo, FrmRelSaldo);
  Application.CreateForm(TFrmRelAp, FrmRelAp);
  Application.Run;
end.
