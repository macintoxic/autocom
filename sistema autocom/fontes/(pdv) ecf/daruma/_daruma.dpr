library _daruma;

uses
  Forms,
  ECFDLL in 'ECFDLL.pas' {fdaruma};

{$R *.RES}


begin
  Application.Initialize;
  Application.CreateForm(TFdaruma, Fdaruma);

end.
