//program geraetq;
library geraetq;

uses
  Forms,
  main in 'main.pas' {FrmMain},
  config in 'config.pas' {FrmConfig},
  produto in 'produto.pas' {FrmProduto},
  preco in 'preco.pas' {FrmPreco};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmPreco, FrmPreco);
  Application.Run;
end.
