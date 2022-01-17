library _nfepson;

uses
  Forms,
  ECFDLL in 'ECFDLL.pas' {Fnf};

{$R *.RES}
{$D '_nfepson.dll - Controle de comandos para ECFs Nao fiscal Epson}


begin
  Application.Initialize;
  Application.CreateForm(TFnf, Fnf);

end.
