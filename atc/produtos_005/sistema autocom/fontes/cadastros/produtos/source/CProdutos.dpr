program CProdutos;

uses
  Forms,
  Windows,
  uMain in 'uMain.pas' {fMain},
  uDm in 'uDm.pas' {Dm: TDataModule},
  uCadastro in 'uCadastro.pas' {fCadastro},
  uModeloConsulta in 'uModeloConsulta.pas' {fModeloConsulta},
  uConsultaSubGrupos in 'uConsultaSubGrupos.pas' {fConsultaSubGrupos},
  uConsultaGrupo in 'uConsultaGrupo.pas' {fConsultaGrupo},
  uConsultaTipo in 'uConsultaTipo.pas' {fConsultaTipo},
  uSqlGlobal in 'uSqlGlobal.pas',
  uSituacaoTributaria in 'uSituacaoTributaria.pas' {fSituacaoTributaria},
  uConsultaClassificacaoFiscal in 'uConsultaClassificacaoFiscal.pas' {fConsultaClassificacaoFiscal},
  uConsultaSecao in 'uConsultaSecao.pas' {fConsultaSecao},
  uConsultaPrateleira in 'uConsultaPrateleira.pas' {fConsultaPrateleira},
  uConsultaEstado in 'uConsultaEstado.pas' {fConsultaEstado},
  uConsultaPreco in 'uConsultaPreco.pas' {fConsultaPreco},
  uRelatorio in 'uRelatorio.pas' {fRelatorio};

{$R *.res}

begin
  Application.Initialize;
  if (ParamCount = 2) and (ParamStr(1) = 'handle') then
    begin
      Application.Title := 'Produtos';
  Application.CreateForm(TfMain, fMain);
  Application.CreateForm(TDm, Dm);
  Application.CreateForm(TfCadastro, fCadastro);
  Application.CreateForm(TfRelatorio, fRelatorio);
  Application.Run;
    end
  else
    begin
      Application.MessageBox('Inicie o programa através do menu!','Sistema Autocom Plus',MB_ICONSTOP);
      Application.Terminate;
    end;
end.
