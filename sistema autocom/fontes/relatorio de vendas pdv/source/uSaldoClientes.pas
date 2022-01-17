unit uSaldoClientes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, Buttons, uGlobal;

type
  TfSaldoClientes = class(TForm)
    LblClienteCodigo: TLabel;
    LblEmpresasConv: TLabel;
    LblEmpresasFim: TLabel;
    LblOperadorCodigo: TLabel;
    BtnCliente: TSpeedButton;
    BtnOperador: TSpeedButton;
    LblTitle: TLabel;
    BtnImprimir: TSpeedButton;
    BtnCancelar: TSpeedButton;
    ChkCliente: TCheckBox;
    MskClienteCodigo: TMaskEdit;
    ChkEmpresaConv: TCheckBox;
    MskEmpresasConvInicio: TMaskEdit;
    MskEmpresasConvFim: TMaskEdit;
    ChkOperador: TCheckBox;
    MskOperadorCodigo: TMaskEdit;
    Panel2: TPanel;
    Panel1: TPanel;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnCancelarClick(Sender: TObject);
    procedure ChkOperadorClick(Sender: TObject);
    procedure ChkClienteClick(Sender: TObject);
    procedure BtnClienteClick(Sender: TObject);
    procedure BtnOperadorClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
  private
    ClienteCI: Integer;
  public
  end;

var
  fSaldoClientes: TfSaldoClientes;

implementation

uses uConsulta, uMain, uDm, uWait;

{$R *.dfm}

procedure TfSaldoClientes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : BtnCancelar.Click;
    VK_RETURN : BtnImprimir.Click;
  end;
end;

procedure TfSaldoClientes.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfSaldoClientes.ChkOperadorClick(Sender: TObject);
begin
  if ChkOperador.Checked then
  begin
    MskOperadorCodigo.Enabled := True;
    LblOperadorCodigo.Enabled := True;
    BtnOperador.Enabled := True;
  end
    else
  begin
    MskOperadorCodigo.Enabled := False;
    LblOperadorCodigo.Enabled := False;
    BtnOperador.Enabled := False;
  end;

end;

procedure TfSaldoClientes.ChkClienteClick(Sender: TObject);
begin
  if ChkCliente.Checked then
  begin
    LblClienteCodigo.Enabled := True;
    MskClienteCodigo.Enabled := True;
    BtnCliente.Enabled := True;
  end
    else
  begin
    LblClienteCodigo.Enabled := False;
    MskClienteCodigo.Enabled := False;
    BtnCliente.Enabled := False;
  end;

end;

procedure TfSaldoClientes.BtnClienteClick(Sender: TObject);
begin
  ActiveConsulta := Cliente;
  With TfConsulta.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
end;

procedure TfSaldoClientes.BtnOperadorClick(Sender: TObject);
begin
  ActiveConsulta := Operador;
  With TfConsulta.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  if OptionsReturn.ExtCodeReturn = 0 then ChkOperador.Checked := False;
  MskClienteCodigo.Text := IntToStr(OptionsReturn.ExtCodeReturn);
  ClienteCI := OptionsReturn.IntCodeReturn;
end;

procedure TfSaldoClientes.BtnImprimirClick(Sender: TObject);
begin
  try
    fWait.Show;
    fWait.Refresh;
    RunSQL('Commit;');
  finally
    fWait.Close;
  end;
    
end;

end.
