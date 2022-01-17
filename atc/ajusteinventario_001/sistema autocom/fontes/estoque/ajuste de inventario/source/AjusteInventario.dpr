program AjusteInventario;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  Produto in 'Produto.pas' {FrmProduto},
  Module in 'Module.pas' {Dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Ajuste de inventário';
  if (ParamCount = 2) and (ParamStr(1) = 'handle') then
    begin
       Application.CreateForm(TFrmMain, FrmMain);
       Application.CreateForm(TDm, Dm);
       Application.Run;
    end
  else
    begin
      Application.MessageBox('Inicie o programa através do menu!','Sistema Autocom Plus');
      Application.Terminate;
    end;
end.
