program CCFOP;

uses
  Forms, Windows,
  uMain in 'uMain.pas' {fMain},
  uDm in 'uDm.pas' {Dm: TDataModule},
  uRelatorio in 'uRelatorio.pas' {fRelatorio};

{$R *.res}

begin
  Application.Initialize;
  if (ParamCount = 2) and (ParamStr(1) = 'handle') then
    begin
      Application.Title := 'C�digo Fiscal de Opera��es';
      Application.CreateForm(TfMain, fMain);
      Application.CreateForm(TDm, Dm);
      Application.Run;
    end
  else
    begin
      Application.MessageBox('Inicie o programa atrav�s do menu!','Sistema Autocom Plus',MB_ICONSTOP);
      Application.Terminate;
    end;
end.
