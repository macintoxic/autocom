program NotaFiscal;

uses
  Forms,
  Nota in 'Nota.pas' {frmNota},
  Tabelas in 'Tabelas.pas' {frmTabelas},
  Listagem in 'Listagem.pas' {frmListagem};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmNota, frmNota);
  Application.CreateForm(TfrmTabelas, frmTabelas);
  Application.CreateForm(TfrmListagem, frmListagem);
  Application.Run;
end.
