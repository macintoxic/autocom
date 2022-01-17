program RPDV;

uses
  Forms,
  Windows,
  uMain in 'uMain.pas' {fMain},
  uProdutos in 'uProdutos.pas' {fProdutos},
  uGrupos in 'uGrupos.pas' {fGrupos},
  uOperadores in 'uOperadores.pas' {fOperadores},
  uCheques in 'uCheques.pas' {fCheques},
  uConvenios in 'uConvenios.pas' {fConvenios},
  uHoras in 'uHoras.pas' {fHoras},
  uSaldoClientes in 'uSaldoClientes.pas' {fSaldoClientes},
  uSangrias in 'uSangrias.pas' {fSangrias},
  uIndicadores in 'uIndicadores.pas' {fIndicadores},
  uConsulta in 'uConsulta.pas' {fConsulta},
  uDm in 'uDm.pas' {Dm: TDataModule},
  uWait in 'uWait.pas' {fWait},
  uConsultaBancos in 'uConsultaBancos.pas' {fConsultaBancos};

{$R *.res}

begin

  Application.Initialize;
  if (ParamCount = 2) and (ParamStr(1) = 'handle') then
    begin
      Application.Title := 'Relatórios de Venda';
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TfWait, fWait);
  Application.CreateForm(TfConsultaBancos, fConsultaBancos);
  Application.Run;
    end
  else
    begin
      Application.MessageBox('Inicie o programa através do menu!','Sistema Autocom Plus',MB_ICONSTOP);
      Application.Terminate;
    end;
end.
