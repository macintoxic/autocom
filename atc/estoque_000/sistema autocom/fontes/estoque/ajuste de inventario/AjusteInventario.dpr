library AjusteInventario;
//program AjusteInventario;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  Produto in 'Produto.pas' {FrmProduto},
  Module in 'Module.pas' {Dm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TDm, Dm);
  Application.Run;
end.
