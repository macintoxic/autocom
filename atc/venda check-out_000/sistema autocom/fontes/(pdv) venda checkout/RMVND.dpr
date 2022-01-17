library RMVND;

uses
  Forms,
  windows,
  venda in 'venda.pas' {VPDR},
  saida in 'saida.pas' {Fsai},
  conscli in 'conscli.pas' {Fconscli},
  dadosch in 'dadosch.pas' {fdadosch},
  dadoscha in 'dadoscha.pas' {Fdadoscha},
  cancit in 'cancit.pas' {Fci},
  getcpf in 'getcpf.pas' {Fgetcpf},
  tab in 'tab.pas' {ftabelas};

{$R *.RES}
begin
  Application.Initialize;
  Application.CreateForm(TVPDR, VPDR);
  Application.CreateForm(TFsai, Fsai);
  Application.CreateForm(TFconscli, Fconscli);
  Application.CreateForm(Tfdadosch, fdadosch);
  Application.CreateForm(TFdadoscha, Fdadoscha);
  Application.CreateForm(TFci, Fci);
  Application.CreateForm(TFgetcpf, Fgetcpf);
  Application.CreateForm(Tftabelas, ftabelas);
  Application.Run;
end.






