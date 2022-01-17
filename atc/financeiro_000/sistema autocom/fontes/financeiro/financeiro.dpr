//library financeiro;
program financeiro;

uses
  Forms,
  financeiro_u in 'financeiro_u.pas' {FrmFinanceiro},
  dm_u in 'dm_u.pas' {Dm: TDataModule},
  pessoa in 'pessoa.pas' {FrmPessoa},
  grupo in 'grupo.pas' {frmgrupo};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmFinanceiro, FrmFinanceiro);
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(Tfrmgrupo, frmgrupo);
  Application.Run;
end.
