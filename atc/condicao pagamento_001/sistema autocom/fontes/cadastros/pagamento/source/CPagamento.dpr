program CPagamento;

uses
  Forms,
  Windows,
  uMain in 'uMain.pas' {fMain},
  uDm in 'uDm.pas' {Dm: TDataModule},
  uFaturamento in 'uFaturamento.pas' {fFaturamento},
  uRelatorio in 'uRelatorio.pas' {fRelatorio},
  uTabelaPreco in 'uTabelaPreco.pas' {fTabelaPreco};

{$R *.res}

begin
  Application.Initialize;
  if (ParamCount = 2) and (ParamStr(1) = 'handle') then
    begin
      Application.Title := 'Cadastro de Condi��es de Pagamento';
      Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TDm, Dm);
  Application.Run;
    end
  else
    begin
      Application.MessageBox('Inicie o programa atrav�s do menu!','Sistema Autocom Plus',MB_ICONEXCLAMATION);
      Application.Terminate;
    end;
end.
