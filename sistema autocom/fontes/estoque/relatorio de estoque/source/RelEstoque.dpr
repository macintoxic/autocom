program RelEstoque;

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
  if (ParamCount = 2) and (ParamStr(1) = 'handle') then
    begin
       Application.CreateForm(TFrmMain, FrmMain);
       Application.CreateForm(TDm, Dm);
       Application.CreateForm(TFrmRelSaldo, FrmRelSaldo);
       Application.CreateForm(TFrmRelAp, FrmRelAp);
       Application.Run;
    end
  else
    begin
      Application.MessageBox('Inicie o programa através do menu!','Sistema Autocom Plus');
      Application.Terminate;
    end;
end.
