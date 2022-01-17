unit uCheques;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Mask, Buttons, uGlobal, StrUtils, SuiThemes,
  SUIMgr, SUIButton, SUIForm;

type
  TfCheques = class(TForm)
    LblDataVendaInicio: TLabel;
    LblDataVendaFim: TLabel;
    LblTerminalCodigo: TLabel;
    LblOrdem: TLabel;
    BtnImprimir: TSpeedButton;
    BtnCancelar: TSpeedButton;
    LblTitle: TLabel;
    LblCPF: TLabel;
    MskCPF: TMaskEdit;
    DtpDataVendaInicio: TDateTimePicker;
    DtpDataVendaFim: TDateTimePicker;
    MskTerminalCodigo: TMaskEdit;
    PanDiv4: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    LblBancoCodigo: TLabel;
    MskBanco: TMaskEdit;
    BtnBanco: TSpeedButton;
    suiForm1: TsuiForm;
    ChkCPF: TsuiCheckBox;
    ChkDataVenda: TsuiCheckBox;
    ChkTerminal: TsuiCheckBox;
    RadCPF: TsuiRadioButton;
    RaData: TsuiRadioButton;
    RadNumero: TsuiRadioButton;
    RadValor: TsuiRadioButton;
    ChkBanco: TsuiCheckBox;
    skin: TsuiThemeManager;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnCancelarClick(Sender: TObject);
    procedure suitempChkDataVendaClick(Sender: TObject);
    procedure suitempChkTerminalClick(Sender: TObject);
    procedure suitempChkCPFClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure suitempChkBancoClick(Sender: TObject);
    procedure BtnBancoClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
  public
  end;

var
  fCheques: TfCheques;

implementation

uses uDm, uMain, uWait, uConsultaBancos;

{$R *.dfm}

procedure TfCheques.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : BtnCancelar.Click;
    VK_RETURN : BtnImprimir.Click;
  end;
end;

procedure TfCheques.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfCheques.suitempChkDataVendaClick(Sender: TObject);
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

procedure TfCheques.suitempChkTerminalClick(Sender: TObject);
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

procedure TfCheques.suitempChkCPFClick(Sender: TObject);
begin
  if ChkCPF.Checked then
    begin
      LblCPF.Enabled := True;
      MskCPF.Enabled := True;
    end
  else
    begin
      LblCPF.Enabled := False;
      MskCPF.Enabled := False;
    end;
end;

procedure TfCheques.BtnImprimirClick(Sender: TObject);
var
  Sql,banco: String;
  SomaQuantidade, SomaValor: Real;
begin
  try
    fWait.Show;
    fWait.Refresh;
    RunSQL('Commit;');
    if IsNull(MskTerminalCodigo.Text) then ChkTerminal.Checked := False;
    if IsNull(MskCPF.Text) then ChkCPF.Checked := False;
    if IsNull(MskBanco.Text) then ChkBanco.Checked := False;

    try
       banco:=IntToStr(StrToInt(MskBanco.Text));
    except
       banco:='0';
    end;

    SQL := ' SELECT DISTINCT PF.*, P.PES_CPF_CNPJ_A' +
           ' FROM PDV_CABECALHOCUPOM PC, PDV_FECHAMENTOCUPOM PF, CLIENTE C,' +
           ' PESSOA P WHERE C.CLI_CODCLIENTE = PF.CLI_CODCLIENTE ' +
           ' AND C.PES_CODPESSOA =  P.PES_CODPESSOA' +
           ' AND PF.CFG_CODCONFIG = 1' +
           ' AND PC.TERMINAL = PF.TERMINAL ' +
           ' AND PC.NCP = PF.NCP ' +
           ' AND SUBSTRING(PC.DATAHORA FROM 1 FOR 8) = SUBSTRING(PF.DATAHORA FROM 1 FOR 8) ' +
           ' AND (PF.BANCO IS NOT NULL AND PF.BANCO <> 0)' +
           Ifthen(ChkBanco.Checked,' AND PF.BANCO = ' + banco) +
           Ifthen(ChkTerminal.Checked,' AND PF.TERMINAL = ' + MskTerminalCodigo.Text) +
           Ifthen(ChkCPF.Checked,' AND P.PES_CPF_CNPJ_A = ' + QuotedStr(MskCPF.Text)) +
           Ifthen(ChkDataVenda.Checked,' AND PF.DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +
           IfThen(RadCPF.Checked,' ORDER BY P.PES_CPF_CNPJ_A') +
           IfThen(RaData.Checked,' ORDER BY PF.DATAHORA') +
           IfThen(RadNumero.Checked,' ORDER BY PF.NUMEROCHEQUE') +
           IfThen(RadValor.Checked,' ORDER BY PF.VALORRECEBIDO');

    SqlRun(SQL,Dm.QrCheques,True,True);

    if not Dm.QrCheques.IsEmpty then
      begin
        Dm.QrCheques.First;
        While not Dm.QrCheques.Eof do
          begin
            SomaQuantidade := SomaQuantidade + 1;
            SomaValor := SomaValor + Dm.QrCheques.FieldByName('VALORRECEBIDO').AsFloat;
            Dm.QrCheques.Next;
            Application.ProcessMessages;
          end;
        fWait.Close;
        Dm.RvAutocom.SetParam('SomaQuantidade',FormatFloat('0.000',SomaQuantidade));
        Dm.RvAutocom.SetParam('SomaValor',FormatFloat(CurrencyString + '0.00',SomaValor));

        if ChkCPF.checked then
           Dm.RvAutocom.SetParam('FiltroCPFCNPJ', MskCPF.text)
        else
           Dm.RvAutocom.SetParam('FiltroCPFCNPJ', 'Todos');

        if ChkDataVenda.checked then
           Dm.RvAutocom.SetParam('FiltroDataVenda',datetostr(DtpDataVendaInicio.date)+' até '+datetostr(DtpDataVendaFim.date))
        else
           Dm.RvAutocom.SetParam('FiltroDataVenda','Todo o movimento acumulado');

        if ChkTerminal.checked then
           Dm.RvAutocom.SetParam('FiltroTerminal',MsKTerminalCodigo.text)
        else
           Dm.RvAutocom.SetParam('FiltroTerminal','Todos');

        if ChkBanco.checked then
           Dm.RvAutocom.SetParam('FiltroBanco',MskBanco.text)
        else
           Dm.RvAutocom.SetParam('FiltroBanco','Todos');

        if RadCPF.checked    then Dm.RvAutocom.SetParam('FiltroOrdem','CPF / CNPJ');
        if RadValor.checked  then Dm.RvAutocom.SetParam('FiltroOrdem','Valor do Cheque');
        if RadNumero.checked then Dm.RvAutocom.SetParam('FiltroOrdem','Número do Cheque');
        if Radata.checked    then Dm.RvAutocom.SetParam('FiltroOrdem','Data de venda');

        Dm.RvAutocom.ExecuteReport('RCheques');
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


procedure TfCheques.suitempChkBancoClick(Sender: TObject);
begin
  if ChkBanco.Checked then
  begin
    LblBancoCodigo.Enabled := True;
    MskBanco.Enabled := True;
    BtnBanco.Enabled := True;
  end
    else
  begin
    LblBancoCodigo.Enabled := False;
    MskBanco.Enabled := False;
    BtnBanco.Enabled := False;
  end;
end;

procedure TfCheques.BtnBancoClick(Sender: TObject);
begin
  with TfConsultaBancos.Create(Self) do
    begin
      ShowModal;
      MskBanco.Text := Copy(ListBancos.Items.Strings[ListBancos.ItemIndex],0,3);
      Free;
    end;
end;

procedure TfCheques.FormActivate(Sender: TObject);
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
