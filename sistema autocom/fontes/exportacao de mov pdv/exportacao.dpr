library exportacao;
//program exportacao;

uses
  Forms,
  teste_u in 'teste_u.pas' {Form1},
  uGlobal in 'uGlobal.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
