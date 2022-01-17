unit uConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ComCtrls, StdCtrls, uGlobal;

type
  TfConfig = class(TForm)
    BtnConfirmar: TSpeedButton;
    LblDataInicial: TLabel;
    LblDataFinal: TLabel;
    EdOperador: TEdit;
    LblOperador: TLabel;
    DateInicial: TDateTimePicker;
    DateFinal: TDateTimePicker;
    procedure BtnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure EdOperadorKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
  public
  end;

var
  fConfig: TfConfig;

implementation

uses Math, uMain, Module;

{$R *.dfm}

procedure TfConfig.BtnConfirmarClick(Sender: TObject);
begin
  S_DataInicial := FormatDateTime('DD/MM/YYYY',DateInicial.Date);
  S_DataFinal := FormatDateTime('DD/MM/YYYY',DateFinal.Date);
  if (not IsInteger(EdOperador.Text)) or (Dm.BuscaNomeVendedor(StrToInt(EdOperador.Text)) = NullAsStringValue) then
    begin
      MessageBox(Handle,'O código do operador é inválido, Verifique!','Erro de Validação',MB_ICONERROR);
      EdOperador.SetFocus;
      EdOperador.SelectAll;
    end
  else
    begin
      I_CodigoOperador := StrToInt(EdOperador.Text);
      Close;
    end;    
end;

procedure TfConfig.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfConfig.EdOperadorKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then BtnConfirmar.Click;
end;

procedure TfConfig.FormShow(Sender: TObject);
begin
  DateInicial.DateTime := StrToDateDef(LeINI('OPER','DATA','dados\oper.ini'),Date);
  DateFinal.DateTime := StrToDateDef(LeINI('OPER','DATA','dados\oper.ini'),Date);
  EdOperador.Text := IntToStr(StrToIntDef(LeINI('OPER','Codigo',ExtractFilePath(Application.ExeName) + 'dados\oper.ini'),0));
end;

end.
