library ctrv;

uses
  Forms,
  ctr in 'ctr.pas' {flogs},
  db_i in 'db_i.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tflogs, flogs); 
end.
