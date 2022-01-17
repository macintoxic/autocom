unit uIndicadores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Mask, Buttons, StrUtils, uGlobal, SuiThemes,
  SUIMgr, SUIButton, SUIForm;

type
  TfIndicadores = class(TForm)
    LblDataVendaInicio: TLabel;
    LblDataVendaFim: TLabel;
    LblTerminalCodigo: TLabel;
    LblOrdem: TLabel;
    LblIndicadorCodigo: TLabel;
    BtnIndicador: TSpeedButton;
    LblTitle: TLabel;
    BtnImprimir: TSpeedButton;
    BtnCancelar: TSpeedButton;
    MskIndicadorCodigo: TMaskEdit;
    DtpDataVendaInicio: TDateTimePicker;
    DtpDataVendaFim: TDateTimePicker;
    MskTerminalCodigo: TMaskEdit;
    Panel2: TPanel;
    Panel1: TPanel;
    PanDiv4: TPanel;
    LblOperadorCodigo: TLabel;
    MskOperadorCodigo: TMaskEdit;
    BtnOperador: TSpeedButton;
    Panel3: TPanel;
    suiForm1: TsuiForm;
    ChkIndicador: TsuiCheckBox;
    ChkDataVenda: TsuiCheckBox;
    ChkTerminal: TsuiCheckBox;
    RadCodigo: TsuiRadioButton;
    RadNome: TsuiRadioButton;
    RadQuantidade: TsuiRadioButton;
    RadTotal: TsuiRadioButton;
    RadComissao: TsuiRadioButton;
    ChkOperador: TsuiCheckBox;
    skin: TsuiThemeManager;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnCancelarClick(Sender: TObject);
    procedure suitempChkDataVendaClick(Sender: TObject);
    procedure suitempChkTerminalClick(Sender: TObject);
    procedure suitempChkIndicadorClick(Sender: TObject);
    procedure BtnIndicadorClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure suitempChkOperadorClick(Sender: TObject);
    procedure BtnOperadorClick(Sender: TObject);
  private
    IndicadorCI: Integer; //CodigoInterno;
  public
  end;

var
  fIndicadores: TfIndicadores;

implementation

uses uConsulta, uMain, uDm, DB, uWait;

{$R *.dfm}

procedure TfIndicadores.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : BtnCancelar.Click;
    VK_RETURN : BtnImprimir.Click;
  end;
end;

procedure TfIndicadores.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfIndicadores.suitempChkDataVendaClick(Sender: TObject);
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

procedure TfIndicadores.suitempChkTerminalClick(Sender: TObject);
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

procedure TfIndicadores.suitempChkIndicadorClick(Sender: TObject);
begin
  if ChkIndicador.Checked then
  begin
    MskIndicadorCodigo.Enabled := True;
    LblIndicadorCodigo.Enabled := True;
    BtnIndicador.Enabled := True;
  end
    else
  begin
    MskIndicadorCodigo.Enabled := False;
    LblIndicadorCodigo.Enabled := False;
    BtnIndicador.Enabled := False;
  end;

end;

procedure TfIndicadores.BtnIndicadorClick(Sender: TObject);
begin
  ActiveConsulta := Indicador;
  With TfConsulta.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  if OptionsReturn.ExtCodeReturn = 0 then ChkIndicador.Checked := False;
  MskIndicadorCodigo.Text := IntToStr(OptionsReturn.ExtCodeReturn);
  IndicadorCI := OptionsReturn.IntCodeReturn;
end;

procedure TfIndicadores.BtnImprimirClick(Sender: TObject);
var
  Sql: String;
  SomaQuantidade, SomaValor: Real;
begin
  try
    fWait.Show;
    fWait.Refresh;
    RunSQL('Commit;');
    if IsNull(MskTerminalCodigo.Text) then ChkTerminal.Checked := False;
    if IsNull(MskIndicadorCodigo.Text) then ChkIndicador.Checked := False;
    if IsNull(MskOperadorCodigo.Text) then ChkOperador.Checked := False;

    SQL := ' SELECT DISTINCT P.PES_NOME_A,' +
           ' SUM(PF.VALORRECEBIDO) AS VALOR,' +
           ' SUM(PF.REPIQUE) AS REPIQUE,' +
           ' SUM(PF.CONTRAVALE) AS CONTRAVALE,' +
           ' SUM(PF.TROCO) AS TROCO,' +
           ' COUNT(PF.VALORRECEBIDO) AS QTDE, ' +

           ' (SELECT SUM(NUMEROCLIENTES) FROM PDV_CABECALHOCUPOM' +
           ' WHERE CFG_CODCONFIG = ' + IntToStr(CodigoLoja) +
           Ifthen(ChkTerminal.Checked,' AND TERMINAL = ' + MskTerminalCodigo.Text) +
           Ifthen(ChkOperador.Checked,' AND PC.IDUSUARIO = ' + MskOperadorCodigo.Text) +
           Ifthen(ChkDataVenda.Checked,' AND DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +
           ' AND VEN_CODVENDEDOR = V.VEN_CODVENDEDOR' +
           ' AND SITUACAO = 0) AS NPESSOAS, ' +
           ' V.COMISSAO,' +
           ' V.CODIGOVENDEDOR' +
           ' FROM PDV_CABECALHOCUPOM PC, PDV_FECHAMENTOCUPOM PF, PESSOA P, VENDEDOR V' +
           ' WHERE VENDEDOR.PES_CODPESSOA = PESSOA.PES_CODPESSOA ' +
           ' AND V.VEN_CODVENDEDOR = PF.VEN_CODVENDEDOR ' +
           ' AND PF.CFG_CODCONFIG = ' + IntToStr(CodigoLoja) +
           ' AND PC.TERMINAL = PF.TERMINAL ' +
           ' AND PC.IDUSUARIO = PF.IDUSUARIO ' +
           ' AND PC.NCP = PF.NCP ' +
           ' AND PC.SITUACAO = 0 ' +
           ' AND SUBSTRING(PC.DATAHORA FROM 1 FOR 8) = SUBSTRING(PF.DATAHORA FROM 1 FOR 8) ' +
           Ifthen(ChkIndicador.Checked,' AND V.VEN_CODVENDEDOR = ' + IntToStr(IndicadorCI)) +
           Ifthen(ChkOperador.Checked,' AND PC.IDUSUARIO = ' + MskOperadorCodigo.Text) +
           Ifthen(ChkOperador.Checked,' AND PF.IDUSUARIO = ' + MskOperadorCodigo.Text) +
           Ifthen(ChkTerminal.Checked,' AND PF.TERMINAL = ' + MskTerminalCodigo.Text) +
           Ifthen(ChkDataVenda.Checked,' AND PF.DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +
           ' AND PF.CODIGOCONDICAOPAGAMENTO NOT IN (SELECT CODIGOCONDICAOPAGAMENTO FROM CONDICAOPAGAMENTO WHERE SOMASALDO = ' + QuotedStr('F') + ')' +
           ' GROUP BY P.PES_NOME_A, V.COMISSAO, V.CODIGOVENDEDOR' +
           IfThen(RadCodigo.Checked,' ORDER BY V.CODIGOVENDEDOR') +
           IfThen(RadNome.Checked,' ORDER BY P.PES_NOME_A') +
           IfThen(RadComissao.Checked,' ORDER BY V.COMISSAO') +
           IfThen(RadQuantidade.Checked,' ORDER BY QTDE') +
           IfThen(RadTotal.Checked,' ORDER BY PF.VALORRECEBIDO');
    SqlRun(SQL,Dm.QrIndicadores,True,True);

    if not Dm.QrIndicadores.IsEmpty then
      begin
        Dm.QrIndicadores.First;
        While not Dm.QrIndicadores.Eof do
          begin
            SomaQuantidade := SomaQuantidade + Dm.QrIndicadoresNPESSOAS.AsFloat;
            SomaValor := SomaValor + Dm.QrIndicadoresVALORL.AsFloat;
            Dm.QrIndicadores.Next;
            Application.ProcessMessages;
          end;
        fWait.Close;
        Dm.RvAutocom.SetParam('SomaQuantidade',FloatToStr(SomaQuantidade));
        Dm.RvAutocom.SetParam('SomaValor',FormatFloat(CurrencyString + '0.00',SomaValor));
        Dm.RvAutocom.SetParam('Indicador',Vendedor);

        if ChkIndicador.checked then
           Dm.RvAutocom.SetParam('FiltroIndicador', MskIndicadorCodigo.text)
        else
           Dm.RvAutocom.SetParam('FiltroIndicador', 'Todos');

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

        if RadCodigo.checked     then Dm.RvAutocom.SetParam('FiltroOrdem','Código do produto');
        if RadQuantidade.checked then Dm.RvAutocom.SetParam('FiltroOrdem','Quantidade vendida');
        if RadNome.checked       then Dm.RvAutocom.SetParam('FiltroOrdem','Nome');
        if RadTotal.checked      then Dm.RvAutocom.SetParam('FiltroOrdem','Total vendido');
        if RadComissao.checked   then Dm.RvAutocom.SetParam('FiltroOrdem','Total de Comissão');


        Dm.RvAutocom.ExecuteReport('RIndicadores');
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


procedure TfIndicadores.FormActivate(Sender: TObject);
var Tipo_skin:string;
begin
     tipo_skin:=LeINI('ATCPLUS', 'skin');
     if (tipo_skin='0') or (tipo_skin='') then skin.uistyle:=WinXP;
     if (tipo_skin='1') then skin.uistyle:=BlueGlass;
     if (tipo_skin='2') then skin.uistyle:=DeepBlue;
     if (tipo_skin='3') then skin.uistyle:=MacOS;
     if (tipo_skin='4') then skin.uistyle:=Protein;
     application.processmessages;

  ChkIndicador.Caption := Vendedor;
  LblTitle.Caption := Vendedor;
  Caption := Vendedor;
end;

procedure TfIndicadores.suitempChkOperadorClick(Sender: TObject);
begin
  if ChkOperador.Checked then
  begin
    LblOperadorCodigo.Enabled := True;
    MskOperadorCodigo.Enabled := True;
    BtnOperador.Enabled := True;
  end
    else
  begin
    LblOperadorCodigo.Enabled := False;
    MskOperadorCodigo.Enabled := False;
    BtnOperador.Enabled := False;
  end;
end;

procedure TfIndicadores.BtnOperadorClick(Sender: TObject);
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

end.
