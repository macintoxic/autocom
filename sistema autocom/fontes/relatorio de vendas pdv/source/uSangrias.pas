unit uSangrias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, ComCtrls, Buttons, uGlobal, StrUtils,
  SUIMgr, SUIButton, SUIForm, suiThemes;

type
  TfSangrias = class(TForm)
    LblDataVendaInicio: TLabel;
    LblDataVendaFim: TLabel;
    LblTerminalCodigo: TLabel;
    LblOperadorCodigo: TLabel;
    BtnOperador: TSpeedButton;
    LblTitle: TLabel;
    BtnImprimir: TSpeedButton;
    BtnCancelar: TSpeedButton;
    DtpDataVendaInicio: TDateTimePicker;
    DtpDataVendaFim: TDateTimePicker;
    MskTerminalCodigo: TMaskEdit;
    MskOperadorCodigo: TMaskEdit;
    Panel2: TPanel;
    PanDiv4: TPanel;
    suiForm1: TsuiForm;
    ChkDataVenda: TsuiCheckBox;
    ChkTerminal: TsuiCheckBox;
    ChkOperador: TsuiCheckBox;
    skin: TsuiThemeManager;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnCancelarClick(Sender: TObject);
    procedure suitempChkDataVendaClick(Sender: TObject);
    procedure suitempChkTerminalClick(Sender: TObject);
    procedure suitempChkOperadorClick(Sender: TObject);
    procedure BtnOperadorClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
  public
  end;

var
  fSangrias: TfSangrias;

implementation

uses uConsulta, uMain, uDm, uWait;

{$R *.dfm}

procedure TfSangrias.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : BtnCancelar.Click;
    VK_RETURN : BtnImprimir.Click;
  end;
end;

procedure TfSangrias.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfSangrias.suitempChkDataVendaClick(Sender: TObject);
begin
  if ChkDataVenda.Checked then
  begin
    LblDataVendaInicio.Enabled := True;
    LblDataVendaFim.Enabled := True;
    DtpDataVendaInicio.Enabled := True;
    DtpDataVendaFim.Enabled := True;
    DtpDataVendaInicio.Date := StrToDateDef(LeINI('OPER','DATA','dados\oper.ini'),Date);
    DtpDataVendaFim.Date := StrToDateDef(LeINI('OPER','DATA','dados\oper.ini'),Date);
  end
    else
  begin
    LblDataVendaInicio.Enabled := False;
    LblDataVendaFim.Enabled := False;
    DtpDataVendaInicio.Enabled := False;
    DtpDataVendaFim.Enabled := False;
  end;
end;

procedure TfSangrias.suitempChkTerminalClick(Sender: TObject);
begin
  if ChkTerminal.Checked then
  begin
    LblTerminalCodigo.Enabled := True;
    MskTerminalCodigo.Enabled := True;
  end
    else
  begin
    LblTerminalCodigo.Enabled := False;
    MskTerminalCodigo.Enabled := False;
  end;
end;

procedure TfSangrias.suitempChkOperadorClick(Sender: TObject);
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

procedure TfSangrias.BtnOperadorClick(Sender: TObject);
begin
  ActiveConsulta := Operador;
  With TfConsulta.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  if OptionsReturn.ExtCodeReturn = 0 then ChkOperador.Checked := False;
  MskOperadorCodigo.Text := IntToStr(OptionsReturn.ExtCodeReturn);
end;

procedure TfSangrias.BtnImprimirClick(Sender: TObject);
var
  Sql: String;
  SomaQuantidade, SomaValor: Real;
begin
  try
    fWait.Show;
    fWait.Refresh;
    RunSQL('Commit;');
    if IsNull(MskTerminalCodigo.Text) then ChkTerminal.Checked := False;
    if IsNull(MskOperadorCodigo.Text) then ChkOperador.Checked := False;

    SQL := ' SELECT DATA, (VALOR * -1) AS VALOR, DESCRICAO ' +
           ' FROM PDV_MOVIMENTOEXTRA ' +
           ' WHERE CFG_CODCONFIG = ' + IntToStr(CodigoLoja) +
           ' AND VALOR < 0' +
           Ifthen(ChkTerminal.Checked,' AND TERMINAL = ' + MskTerminalCodigo.Text) +
           Ifthen(ChkOperador.Checked,' AND IDUSUARIO = ' + MskOperadorCodigo.Text) +
           Ifthen(ChkDataVenda.Checked,' AND DATA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY',DtpDataVendaFim.Date)));
    SqlRun(SQL,Dm.QrSangrias,True,True);

    if not Dm.QrSangrias.IsEmpty then
      begin
        Dm.QrSangrias.First;
        While not Dm.QrSangrias.Eof do
          begin
            SomaQuantidade := SomaQuantidade + 1;
            SomaValor := SomaValor + Dm.QrSangrias.FieldByName('VALOR').AsFloat;
            Dm.QrSangrias.Next;
            Application.ProcessMessages;
          end;
        fWait.Close;
        Dm.RvAutocom.SetParam('SomaQuantidade',FloatToStr(SomaQuantidade));
        Dm.RvAutocom.SetParam('SomaValor',FormatFloat(CurrencyString + '0.00',SomaValor));

        if ChkDataVenda.checked then
           Dm.RvAutocom.SetParam('FiltroDataVenda',datetostr(DtpDataVendaInicio.date)+' até '+datetostr(DtpDataVendaFim.date))
        else
           Dm.RvAutocom.SetParam('FiltroDataVenda','Todo o movimento acumulado');

        if ChkTerminal.checked then
           Dm.RvAutocom.SetParam('FiltroTerminal',MsKTerminalCodigo.text)
        else
           Dm.RvAutocom.SetParam('FiltroTerminal','Todos');

        if ChkOperador.checked then
           Dm.RvAutocom.SetParam('FiltroOperador',MskOperadorCodigo.text)
        else
           Dm.RvAutocom.SetParam('FiltroOperador','Todos');

        Dm.RvAutocom.ExecuteReport('RSangrias');
      end
    else
      begin
        fWait.Close;
        Application.MessageBox('Não há movimento nas condições selecionadas!', Autocom, MB_ICONEXCLAMATION);
      end;
  finally
    fWait.Close;
end;

end;


procedure TfSangrias.FormActivate(Sender: TObject);
var Tipo_skin:string;
begin
     tipo_skin:=LeINI('ATCPLUS', 'skin');
     if (tipo_skin='0') or (tipo_skin='') then skin.uistyle:=WinXP;
     if (tipo_skin='1') then skin.uistyle:=BlueGlass;
     if (tipo_skin='2') then skin.uistyle:=DeepBlue;
     if (tipo_skin='3') then skin.uistyle:=MacOS;
     if (tipo_skin='4') then skin.uistyle:=Protein;
     application.processmessages;
end;

end.
