library PDVutil;

uses
  Forms,
  Util in 'Util.pas' {Futil};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TFutil, Futil);
  Application.Run;
end.
