//program RelFat;
library RelFat;

uses
  Forms,
  OpcNota in 'OpcNota.pas' {frmOpcNota},
  ImpNotaEntrada in 'ImpNotaEntrada.pas' {frmImpNotaEntrada},
  ImpNotaSaida in 'ImpNotaSaida.pas' {frmImpNotaSaida};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmOpcNota, frmOpcNota);
  Application.CreateForm(TfrmImpNotaEntrada, frmImpNotaEntrada);
  Application.CreateForm(TfrmImpNotaSaida, frmImpNotaSaida);
  Application.Run;
end.
