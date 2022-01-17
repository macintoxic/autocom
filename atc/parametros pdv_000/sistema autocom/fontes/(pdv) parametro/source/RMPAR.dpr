Library RMPAR;

uses
  Forms,
  windows,
  Par in 'Par.pas' {PARAMETRO},
  Mod_ecf in 'Mod_ecf.pas' {ModECF};

{$R *.RES}
var
  ExtendedStyle : Integer;

begin
  Application.Initialize;
  ExtendedStyle := GetWindowLong(Application.Handle, gwl_ExStyle);// isso evita que o programa
  SetWindowLong(Application.Handle, gwl_ExStyle, ExtendedStyle or // apareça na barra de tarefas.
    ws_Ex_ToolWindow and not ws_Ex_AppWindow);                    //
  Application.CreateForm(TPARAMETRO, PARAMETRO);
  Application.CreateForm(TModECF, ModECF);
  Application.Run;
end.
