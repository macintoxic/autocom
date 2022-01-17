unit uGrupos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Mask, Buttons, uGlobal, StrUtils,
  SUIMgr, SUIButton, SUIForm, SuiThemes;

type
  TfGrupos = class(TForm)
    LblDataVendaInicio: TLabel;
    LblDataVendaFim: TLabel;
    LblTerminalCodigo: TLabel;
    LblOrdem: TLabel;
    LblGrupoCodigo: TLabel;
    LblOperadorCodigo: TLabel;
    BtnGrupo: TSpeedButton;
    BtnOperador: TSpeedButton;
    LblTitle: TLabel;
    BtnImprimir: TSpeedButton;
    BtnCancelar: TSpeedButton;
    MskGrupoCodigo: TMaskEdit;
    DtpDataVendaInicio: TDateTimePicker;
    DtpDataVendaFim: TDateTimePicker;
    MskTerminalCodigo: TMaskEdit;
    MskOperadorCodigo: TMaskEdit;
    Panel2: TPanel;
    Panel1: TPanel;
    PanDiv4: TPanel;
    Panel3: TPanel;
    suiForm1: TsuiForm;
    ChkGrupo: TsuiCheckBox;
    ChkDataVenda: TsuiCheckBox;
    ChkTerminal: TsuiCheckBox;
    RadGrupo: TsuiRadioButton;
    RadQuantidade: TsuiRadioButton;
    RadTotal: TsuiRadioButton;
    ChkOperador: TsuiCheckBox;
    skin: TsuiThemeManager;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnCancelarClick(Sender: TObject);
    procedure suitempChkDataVendaClick(Sender: TObject);
    procedure suitempChkTerminalClick(Sender: TObject);
    procedure suitempChkOperadorClick(Sender: TObject);
    procedure suitempChkGrupoClick(Sender: TObject);
    procedure BtnGrupoClick(Sender: TObject);
    procedure BtnOperadorClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
  public
  end;

var
  fGrupos: TfGrupos;

implementation

uses uMain, uConsulta, uDm, uWait;

{$R *.dfm}

procedure TfGrupos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : BtnCancelar.Click;
    VK_RETURN : BtnImprimir.Click;
  end;
end;

procedure TfGrupos.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfGrupos.suitempChkDataVendaClick(Sender: TObject);
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

procedure TfGrupos.suitempChkTerminalClick(Sender: TObject);
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

procedure TfGrupos.suitempChkOperadorClick(Sender: TObject);
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

procedure TfGrupos.suitempChkGrupoClick(Sender: TObject);
begin
  if ChkGrupo.Checked then
  begin
    LblGrupoCodigo.Enabled := True;
    MskGrupoCodigo.Enabled := True;
    BtnGrupo.Enabled := True;
  end
    else
  begin
    LblGrupoCodigo.Enabled := False;
    MskGrupoCodigo.Enabled := False;
    BtnGrupo.Enabled := False;
  end;

end;

procedure TfGrupos.BtnGrupoClick(Sender: TObject);
begin
  ActiveConsulta := Grupo;
  With TfConsulta.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  if OptionsReturn.ExtCodeReturn = 0 then ChkGrupo.Checked := False;
  MskGrupoCodigo.Text := IntToStr(OptionsReturn.ExtCodeReturn);
end;

procedure TfGrupos.BtnOperadorClick(Sender: TObject);
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

procedure TfGrupos.BtnImprimirClick(Sender: TObject);
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
  if IsNull(MskGrupoCodigo.Text) then ChkGrupo.Checked := False;

  SQL := ' SELECT DISTINCT  GP.GRUPOPRODUTO, SGP.SUBGRUPO, SGP.CODIGOSUBGRUPO, ' +
         ' SUM(PD.QTDE) AS QTDE, SUM((VALORUN * QTDE)  + ACRESCIMO - DESCONTO) AS VALORSOMA, GP.CODIGOGRUPOPRODUTO' +
         ' FROM PRODUTO P, SUBGRUPOPRODUTO SGP, PDV_DETALHECUPOM PD' +
         ' INNER JOIN GRUPOPRODUTO GP ON (SGP.CODIGOGRUPOPRODUTO = GP.CODIGOGRUPOPRODUTO AND SGP.CODIGOSUBGRUPOPRODUTO = P.CODIGOSUBGRUPOPRODUTO AND P.CODIGOPRODUTO = PD.CODIGOPRODUTO)' +
         ' WHERE (PD.SITUACAO IS NULL OR PD.SITUACAO <> 1)' +
         ' AND P.CODIGOSUBGRUPOPRODUTO = SGP.CODIGOSUBGRUPOPRODUTO ' +
         ' AND SGP.CODIGOGRUPOPRODUTO = GP.CODIGOGRUPOPRODUTO ' +
         ' AND PD.CFG_CODCONFIG = ' + IntToStr(CodigoLoja) +
         Ifthen(ChkGrupo.Checked,' AND GP.CODIGOGRUPOPRODUTO = ' + MskGrupoCodigo.Text) +
         Ifthen(ChkTerminal.Checked,' AND PD.TERMINAL = ' + MskTerminalCodigo.Text) +
         Ifthen(ChkOperador.Checked,' AND PD.IDUSUARIO = ' + MskOperadorCodigo.Text) +
         Ifthen(ChkDataVenda.Checked,' AND PD.DATAHORA BETWEEN ' +
         QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' +
         QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +
         ' GROUP BY GP.GRUPOPRODUTO, SGP.SUBGRUPO, GP.CODIGOGRUPOPRODUTO, SGP.CODIGOSUBGRUPO ' +
         IfThen(RadGrupo.Checked,' ORDER BY GP.CODIGOGRUPOPRODUTO, SGP.SUBGRUPO') +
         IfThen(RadQuantidade.Checked,' ORDER BY QTDE, SGP.SUBGRUPO') +
         IfThen(RadTotal.Checked,' ORDER BY VALORSOMA');

  SqlRun(SQL,Dm.QrGrupos,True,True);

  SQL := ' SELECT DISTINCT  GP.GRUPOPRODUTO, GP.CODIGOGRUPOPRODUTO' +
         ' FROM PRODUTO P, SUBGRUPOPRODUTO SGP, PDV_DETALHECUPOM PD' +
         ' INNER JOIN GRUPOPRODUTO GP ON (SGP.CODIGOGRUPOPRODUTO = GP.CODIGOGRUPOPRODUTO AND SGP.CODIGOSUBGRUPOPRODUTO = P.CODIGOSUBGRUPOPRODUTO AND P.CODIGOPRODUTO = PD.CODIGOPRODUTO)' +
         ' WHERE (PD.SITUACAO IS NULL OR PD.SITUACAO <> 1)' +
         ' AND P.CODIGOSUBGRUPOPRODUTO = SGP.CODIGOSUBGRUPOPRODUTO ' +
         ' AND SGP.CODIGOGRUPOPRODUTO = GP.CODIGOGRUPOPRODUTO ' +
         ' AND PD.CFG_CODCONFIG = ' + IntToStr(CodigoLoja) +
         Ifthen(ChkGrupo.Checked,' AND GP.CODIGOGRUPOPRODUTO = ' + MskGrupoCodigo.Text) +
         Ifthen(ChkTerminal.Checked,' AND PD.TERMINAL = ' + QuotedStr(MskTerminalCodigo.Text)) +
         Ifthen(ChkOperador.Checked,' AND PD.IDUSUARIO = ' + MskOperadorCodigo.Text) +
         Ifthen(ChkDataVenda.Checked,' AND PD.DATAHORA BETWEEN ' +
         QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' +
         QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +
         ' GROUP BY GP.GRUPOPRODUTO, GP.CODIGOGRUPOPRODUTO ' +
         IfThen(RadGrupo.Checked,' ORDER BY GP.CODIGOGRUPOPRODUTO, SGP.SUBGRUPO') +
         IfThen(RadQuantidade.Checked,' ORDER BY QTDE, SGP.SUBGRUPO') +
         IfThen(RadTotal.Checked,' ORDER BY VALORSOMA');

  SqlRun(SQL,Dm.QrGrupos2,True,True);

  if not Dm.QrGrupos.IsEmpty then
    begin
      Dm.QrGrupos.First;
      While not Dm.QrGrupos.Eof do
        begin
          SomaQuantidade := SomaQuantidade + Dm.QrGrupos.FieldByName('QTDE').AsFloat;
          SomaValor := SomaValor + Dm.QrGrupos.FieldByName('VALORSOMA').AsFloat;
          Dm.QrGrupos.Next;
          Application.ProcessMessages;
        end;
      fWait.Close;
      Dm.RvAutocom.SetParam('SomaQuantidade',FormatFloat('0.000',SomaQuantidade));
      Dm.RvAutocom.SetParam('SomaValor',FormatFloat(CurrencyString + '0.00',SomaValor));

        if ChkGrupo.checked then
           Dm.RvAutocom.SetParam('FiltroGrupo', MskGrupoCodigo.text)
        else
           Dm.RvAutocom.SetParam('FiltroGrupo', 'Todos');

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

        if RadGrupo.checked      then Dm.RvAutocom.SetParam('FiltroOrdem','Grupo');
        if RadQuantidade.checked then Dm.RvAutocom.SetParam('FiltroOrdem','Quantidade vendida');
        if RadTotal.checked      then Dm.RvAutocom.SetParam('FiltroOrdem','Total líquido vendido');


      Dm.RvAutocom.ExecuteReport('RGrupos');
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


procedure TfGrupos.FormActivate(Sender: TObject);
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
