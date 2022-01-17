program psnt;

uses
  Forms,
  snt in 'snt.pas' {Fpliber},
  lib in 'lib.pas' {Flibera},
  cadempresa in 'cadempresa.pas' {Fcadempresa},
  BD in 'BD.pas' {Fbd},
  dm in 'dm.pas' {Fdm: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Configuração e Liberação';
  Application.CreateForm(TFpliber, Fpliber);
  Application.CreateForm(TFlibera, Flibera);
  Application.CreateForm(TFcadempresa, Fcadempresa);
  Application.CreateForm(TFbd, Fbd);
  Application.CreateForm(TFdm, Fdm);
  Application.Run;
  Application.Initialize;

end.
