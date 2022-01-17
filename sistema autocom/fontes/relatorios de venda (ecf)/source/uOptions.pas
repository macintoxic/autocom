unit uOptions;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, uGlobal;

type
  TfOptions = class(TForm)
    EdX: TEdit;
    LblX: TLabel;
    LblY: TLabel;
    EdY: TEdit;
    BtnConfirmar: TSpeedButton;
    BtnCliente: TSpeedButton;
    procedure BtnConfirmarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdYKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdXKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FiltroNumerico(Sender: TObject; var Key: Char);
    procedure FormataZeros(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BtnClienteClick(Sender: TObject);
  private
  public
  end;

var
  fOptions: TfOptions;

implementation

uses uConsulta,uMain;

{$R *.dfm}

procedure TfOptions.BtnConfirmarClick(Sender: TObject);
begin
  {Validacao para Faixa Horaria}
  if CurrentButton = fMain.BtnFaixaHoraria then
    begin
      try
        StrToTime(EdX.Text + ':00');
      except
        MessageBox(Handle,'Hora inicial inválida. Verifique!','Erro de Validação',MB_ICONWARNING);
        EdX.SetFocus;
        Exit;
      end;

      try
        StrToTime(EdY.Text + ':59:59');
        Close;
      except
        MessageBox(Handle,'Hora final inválida. Verifique!','Erro de Validação',MB_ICONWARNING);
        EdY.setfocus;
        Exit;
      end;
    end;

  {Validacao para Extrato de convenio}
  if CurrentButton = fMain.BtnExtratoDeConvenios then
    begin
       if IsNull(EdX.Text) or (not IsInteger(EdX.Text)) then
          begin
             MessageBox(Handle,PChar('Digite um valor válido no campo ' + LblX.Caption),'Erro de Validação',MB_ICONWARNING);
             EdX.SetFocus;
             EdX.SelectAll;
             Exit;
          end;
    end;

  {Validacao Numerica Global}
  if IsNull(EdX.Text) or (not IsInteger(EdX.Text)) then
    begin
      MessageBox(Handle,PChar('Digite um valor válido no campo ' + LblX.Caption),'Erro de Validação',MB_ICONWARNING);
      EdX.SetFocus;
      EdX.SelectAll;
      Exit;
    end;
  if IsNull(EdY.Text) or (not IsInteger(EdY.Text)) then
    begin
      MessageBox(Handle,PChar('Digite um valor válido no campo ' + LblY.Caption),'Erro de Validação',MB_ICONWARNING);
      EdY.SetFocus;
      EdY.SelectAll;
      Exit;
    end;
  Close;
end;

procedure TfOptions.FormShow(Sender: TObject);
begin
      LblY.visible := true;
      EdY.visible  := true;
      LblX.visible := true;
      EdX.visible  := true;

  EdX.Text := '000000001';
  EdY.Text := '999999999';
  if CurrentButton = fMain.BtnProdutos then
    begin
      LblX.Caption := 'Produto Inicial';
      LblY.Caption := 'Produto Final';
    end;
  if CurrentButton = fMain.BtnGrupos then
    begin
      LblX.Caption := 'Grupo Inicial';
      LblY.Caption := 'Grupo Final';
    end;
  if CurrentButton = fMain.BtnFaixaHoraria then
    begin
      LblX.Caption := 'Faixa Horária Inicial';
      LblY.Caption := 'Faixa Horária Final';
      EdX.Text := '00';
      EdY.Text := '23';
      EdX.OnExit := nil; {Desativa Formatacao de Zeros}
    end;
  if CurrentButton = fMain.BtnIndicadores then
    begin
      LblX.Caption := UpperCase(Copy(LeINI('TERMINAL','NOMEIND'),1,1)) + LowerCase(Copy(LeINI('TERMINAL','NOMEIND'),2,40)) + ' Inicial';
      LblY.Caption := UpperCase(Copy(LeINI('TERMINAL','NOMEIND'),1,1)) + LowerCase(Copy(LeINI('TERMINAL','NOMEIND'),2,40)) + ' Final';
    end;
  if CurrentButton = fMain.BtnExtratoDeConvenios then
    begin
      LblX.Caption := 'Cliente';
      EdX.Text := '00';
      LblY.visible := false;
      EdY.visible := false;
    end;
  if CurrentButton = fMain.BtnSaldoDeClientes then
    begin
      LblX.Caption := 'Cliente Inicial';
      LblY.Caption := 'Cliente Final';
    end;
end;

procedure TfOptions.EdYKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if Key = VK_RETURN then BtnConfirmar.Click;
end;

procedure TfOptions.EdXKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if Key = VK_RETURN then
        begin
            if edy.visible=true then Perform(WM_NEXTDLGCTL, 0, 0)
            else BtnConfirmar.Click;
        end
end;

procedure TfOptions.FiltroNumerico(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #8, #13, #37, #38, #39, #40]) then Key := #0;
  if CurrentButton = fMain.BtnFaixaHoraria then
end;

procedure TfOptions.FormataZeros(Sender: TObject);
begin
  (Sender as TEdit).Text := FormatFloat('000000000', StrToInt((Sender as TEdit).Text));
end;

procedure TfOptions.FormClose(Sender: TObject; var Action: TCloseAction);
begin
{ Grava Configuracoes no Array                                                 }
{ Obs: O Indice do Array corresponde ao Indice no Relatorio no menu            }
  if CurrentButton = fMain.BtnProdutos then
    begin
      RelOptions[1].X := EdX.Text;
      RelOptions[1].Y := EdY.Text;
    end;
  if CurrentButton = fMain.BtnGrupos then
    begin
      RelOptions[2].X := EdX.Text;
      RelOptions[2].Y := EdY.Text;
    end;
  if CurrentButton = fMain.BtnFaixaHoraria then
    begin
      RelOptions[4].X := EdX.Text;
      RelOptions[4].Y := EdY.Text;
    end;
  if CurrentButton = fMain.BtnIndicadores then
    begin
      RelOptions[6].X := EdX.Text;
      RelOptions[6].Y := EdY.Text;
    end;
  if CurrentButton = fMain.BtnExtratoDeConvenios then
    begin
      RelOptions[7].X := EdX.Text;
      RelOptions[7].Y := EdY.Text;
    end;
  if CurrentButton = fMain.BtnSaldoDeClientes then
    begin
      RelOptions[8].X := EdX.Text;
      RelOptions[8].Y := EdY.Text;
    end;
end;

procedure TfOptions.BtnClienteClick(Sender: TObject);
begin
  ActiveConsulta := Cliente;
  With TfConsulta.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  EDX.Text := IntToStr(fMain.OptionsReturn.ExtCodeReturn);

end;

end.
