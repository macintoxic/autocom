
program MainCompra;

uses
  Forms,
  MainCompra_u in 'MainCompra_u.pas' {fMainCompra},
  Dm_u in 'Dm_u.pas' {DM: TDataModule},
  BuscaProd_u in 'BuscaProd_u.pas' {fBuscaProduto},
  uGlobal in 'uGlobal.pas' {Unit de funcoes},
  BuscaVend_u in 'BuscaVend_u.pas' {fBuscaVendedor},
  BuscaTrans_u in 'BuscaTrans_u.pas' {fBuscaTransportadora},
  BuscaPedido_u in 'BuscaPedido_u.pas' {fBuscaPedido},
  BuscaPag_u in 'BuscaPag_u.pas' {fBuscaPagam};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfMainCompra, fMainCompra);
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfBuscaProduto, fBuscaProduto);
  Application.CreateForm(TfBuscaVendedor, fBuscaVendedor);
  Application.CreateForm(TfBuscaTransportadora, fBuscaTransportadora);
  Application.CreateForm(TfBuscaPedido, fBuscaPedido);
  Application.CreateForm(TfBuscaPagam, fBuscaPagam);
  Application.Run;
end.
