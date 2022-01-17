program CPessoas;

uses
  Forms,
  Windows,
  uMain in 'uMain.pas' {fMain},
  uDm in 'uDm.pas' {Dm: TDataModule},
  uConsultaPessoa in 'uConsultaPessoa.pas' {fConsultaPessoa},
  uRelatorio in 'uRelatorio.pas' {fRelatorio},
  uCadastro in 'uCadastro.pas' {fCadastro};

{$R *.res}

begin
  Application.Initialize;
  if (ParamCount = 2) and (ParamStr(1) = 'handle') then
    begin
      Application.Title := 'Pessoas';
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TfCadastro, fCadastro);
  Application.Run;
    end
  else
    begin
      Application.MessageBox('Inicie o programa através do menu!','Sistema Autocom Plus',MB_ICONSTOP);
      Application.Terminate;
    end;
end.
