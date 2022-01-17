program geraetq;

uses
  Forms,
  main in 'main.pas' {FrmMain},
  config in 'config.pas' {FrmConfig},
  produto in 'produto.pas' {FrmProduto},
  preco in 'preco.pas' {FrmPreco};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Gerador de etiquetas de código de barras';
  if (ParamCount = 2) and (ParamStr(1) = 'handle') then
    begin
       Application.CreateForm(TFrmMain, FrmMain);
       Application.CreateForm(TFrmPreco, FrmPreco);
       Application.Run;
    end
  else
    begin
      Application.MessageBox('Inicie o programa através do menu!','Sistema Autocom Plus');
      Application.Terminate;
    end;

end.
