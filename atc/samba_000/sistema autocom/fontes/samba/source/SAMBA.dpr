program SAMBA;

uses
  Forms,
  cme in 'cme.pas' {fcomand},
  conta in 'conta.pas' {Fconta},
  pedido in 'pedido.pas' {Fpedido},
  Unit1 in 'Unit1.pas' {Fconsprod},
  dtm2_u in 'dtm2_u.pas' {Dtm2: TDataModule},
  consprodgrupo_u in 'consprodgrupo_u.pas' {fconsprodgrupo},
  fresultprod_u in 'fresultprod_u.pas' {fresultprod},
  Autocom in 'Autocom.pas',
  fobs_u in 'fobs_u.pas' {fobs};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'SAMBA - Sistema de Atendimento Móvel by Autocom';
  Application.CreateForm(Tfcomand, fcomand);
  Application.CreateForm(TFconta, Fconta);
  Application.CreateForm(TFpedido, Fpedido);
  Application.CreateForm(TFconsprod, Fconsprod);
  Application.CreateForm(TDtm2, Dtm2);
  Application.CreateForm(Tfconsprodgrupo, fconsprodgrupo);
  Application.CreateForm(Tfresultprod, fresultprod);
  Application.CreateForm(Tfobs, fobs);
  Application.Run;
end.
