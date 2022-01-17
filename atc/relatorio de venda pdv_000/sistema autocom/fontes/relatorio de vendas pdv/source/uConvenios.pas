unit uConvenios;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, ComCtrls, Buttons, uGlobal, StrUtils,
  SUIButton, SUIForm, SUIMgr, SuiThemes, db;

type
  TfConvenios = class(TForm)
    LblDataVendaInicio: TLabel;
    LblDataVendaFim: TLabel;
    LblTerminalCodigo: TLabel;
    LblClienteCodigo: TLabel;
    BtnCliente: TSpeedButton;
    BtnImprimir: TSpeedButton;
    BtnCancelar: TSpeedButton;
    LblTitle: TLabel;
    DtpDataVendaInicio: TDateTimePicker;
    DtpDataVendaFim: TDateTimePicker;
    MskTerminalCodigo: TMaskEdit;
    MskClienteCodigo: TMaskEdit;
    Panel2: TPanel;
    Panel1: TPanel;
    skin: TsuiThemeManager;
    suiForm1: TsuiForm;
    ChkDataVenda: TsuiCheckBox;
    ChkTerminal: TsuiCheckBox;
    ChkCliente: TsuiCheckBox;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnCancelarClick(Sender: TObject);
    procedure suitempChkDataVendaClick(Sender: TObject);
    procedure suitempChkTerminalClick(Sender: TObject);
    procedure suitempChkClienteClick(Sender: TObject);
    procedure BtnClienteClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    ClienteCI: Integer;
  public
  end;

var
  fConvenios: TfConvenios;

implementation

uses uMain, uConsulta, uDm, uWait;

{$R *.dfm}

procedure TfConvenios.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : BtnCancelar.Click;
    VK_RETURN : BtnImprimir.Click;
  end;
end;

procedure TfConvenios.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfConvenios.suitempChkDataVendaClick(Sender: TObject);
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

procedure TfConvenios.suitempChkTerminalClick(Sender: TObject);
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

procedure TfConvenios.suitempChkClienteClick(Sender: TObject);
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

procedure TfConvenios.BtnClienteClick(Sender: TObject);
begin
  ActiveConsulta := Cliente;
  With TfConsulta.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  if OptionsReturn.ExtCodeReturn = 0 then ChkCliente.Checked := False;
  MskClienteCodigo.Text := IntToStr(OptionsReturn.ExtCodeReturn);
  ClienteCI := OptionsReturn.IntCodeReturn;
end;

procedure TfConvenios.BtnImprimirClick(Sender: TObject);
var sql,sql_,v_ncp,v_terminal,v_cliente:string;
    somaQuantidade,SomaValor:real;
begin
  try
    fWait.Show;
    fWait.Refresh;
    RunSQL('Commit;');

    if IsNull(MskClienteCodigo.Text) then
      begin
        fWait.Close;
        MessageBox(Handle,'É necessário informar um cliente!',Autocom,MB_ICONWARNING);
        Exit;
      end;

    if IsNull(MskTerminalCodigo.Text) then ChkTerminal.Checked := False;

    SQL := ' SELECT DISTINCT P.CODIGOPRODUTO , P.NOMEPRODUTO, pd.datahora ,pd.ncp, pd.terminal, ' +
           ' SUM(PD.QTDE) AS QTDE,' +
           ' SUM((VALORUN * QTDE)  + ACRESCIMO - DESCONTO) AS VALORSOMA,' +
           ' SUM(PD.VALORUN * PD.QTDE) as TOTUNID,'+
           ' SUM(PD.ACRESCIMO) as TOTACRES,'+
           ' SUM(PD.DESCONTO) as TOTDESC '+
           ' FROM PRODUTO P, PDV_DETALHECUPOM PD ' +
           ' WHERE PD.CFG_CODCONFIG = ' + IntToStr(CodigoLoja) +
           ' AND P.CODIGOPRODUTO = PD.CODIGOPRODUTO' +
           ' AND (PD.SITUACAO = 0)' +
           Ifthen(ChkTerminal.Checked,' AND TERMINAL = ' + MskTerminalCodigo.Text) +
           ' AND PD.DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date)) +
           ' GROUP BY P.CODIGOPRODUTO, P.NOMEPRODUTO, pd.datahora,pd.ncp, pd.terminal' +
           ' ORDER BY pd.datahora,P.NOMEPRODUTO';

    SqlRun(SQL,Dm.generico,True,True);

    if not dm.generico.IsEmpty then
       begin
        //Modela dados no Client Data Set
        Dm.CdsExtratoCliente.close;
        Dm.CdsExtratoCliente.filename:=extractfilepath(application.ExeName)+'dados\rextcli.xml';
        if not fileexists(Dm.CdsExtratoCliente.filename) then Dm.CdsExtratoCliente.CreateDataSet;
        Dm.CdsExtratoCliente.Open;
        Dm.CdsExtratoCliente.EmptyDataSet;
        Dm.generico.first;
        somaQuantidade:=0;
        SomaValor:=0;

             SQL_ :=' SELECT terminal,ncp FROM PDV_CabecalhoCUPOM' +
                    ' WHERE CFG_CODCONFIG = ' + IntToStr(CodigoLoja) +
                    ' AND DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date)) +
                    ' AND Cli_codcliente='+inttostr(ClienteCI);

             SqlRun(SQL_,Dm.generico2,True,True);

        while not Dm.generico.Eof do
          begin

            if dm.generico2.Locate('terminal;ncp',VarArrayOf([Dm.generico.FieldByName('TERMINAL').asstring,Dm.generico.FieldByName('NCP').asstring]),[loCaseInsensitive]) then
               begin
                  if Dm.CdsExtratoCliente.locate('data;codigo',VarArrayOf([strtodate(formatdatetime('DD/MM/YYYY',Dm.generico.FieldByName('datahora').value)),Dm.generico.FieldByName('CODIGOPRODUTO').Asinteger]),[loCaseInsensitive]) then
                     begin
                        Dm.CdsExtratoCliente.Edit;
                        Dm.CdsExtratoClienteqtde.Value    := Dm.CdsExtratoClienteqtde.Value+Dm.generico.FieldByName('QTDE').AsFloat;
                        Dm.CdsExtratoClientevalor.Value   := Dm.CdsExtratoClientevalor.Value+Dm.generico.FieldByName('VALORSOMA').AsFloat;
                     end
                  else
                     begin
                        Dm.CdsExtratoCliente.Insert;
                        Dm.CdsExtratoClientedata.Value    := strtodate(formatdatetime('DD/MM/YYYY',Dm.generico.FieldByName('datahora').value));
                        Dm.CdsExtratoClientecodigo.Value  := Dm.generico.FieldByName('CODIGOPRODUTO').Asinteger;
                        Dm.CdsExtratoClienteproduto.Value := Dm.generico.FieldByName('NOMEPRODUTO').AsString;
                        Dm.CdsExtratoClienteqtde.Value    := Dm.generico.FieldByName('QTDE').AsFloat;
                        Dm.CdsExtratoClientevalor.Value   := Dm.generico.FieldByName('VALORSOMA').AsFloat;
                     end;
                  Dm.CdsExtratoCliente.Post;
                  somaQuantidade:=somaQuantidade+Dm.generico.FieldByName('QTDE').AsFloat;
                  SomaValor:=SomaValor+Dm.generico.FieldByName('VALORSOMA').AsFloat;
               end;
            Dm.generico.Next;
            Application.ProcessMessages;
          end;

        SqlRun('select p.pes_nome_a from cliente c,pessoa p '+
               'where c.cli_codcliente='+inttostr(ClienteCI)+
               '  and c.pes_codpessoa=p.pes_codpessoa',Dm.generico,True,True);
        v_cliente:=MskClienteCodigo.text+' - '+Trim(Dm.generico.FieldByName('pes_nome_a').AsString);

        if ChkDataVenda.checked then
           Dm.RvAutocom.SetParam('FiltroDataVenda',datetostr(DtpDataVendaInicio.date)+' até '+datetostr(DtpDataVendaFim.date))
        else
           Dm.RvAutocom.SetParam('FiltroDataVenda','Todo o movimento acumulado');

        if ChkTerminal.checked then
           Dm.RvAutocom.SetParam('FiltroTerminal',MsKTerminalCodigo.text)
        else
           Dm.RvAutocom.SetParam('FiltroTerminal','Todos');

        Dm.RvAutocom.SetParam('FiltroCliente',v_cliente);

        Dm.RvAutocom.SetParam('SomaQuantidade',FormatFloat('0.000',SomaQuantidade));
        Dm.RvAutocom.SetParam('SomaValor',FormatFloat(CurrencyString + '0.00',SomaValor));

        Dm.RvAutocom.ExecuteReport('RExtratoClientes');
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

procedure TfConvenios.FormActivate(Sender: TObject);
var Tipo_skin:string;
begin
     tipo_skin:=LeINI('ATCPLUS', 'skin');
     if (tipo_skin='0') or (tipo_skin='') then skin.uistyle:=WinXP;
     if (tipo_skin='1') then skin.uistyle:=BlueGlass;
     if (tipo_skin='2') then skin.uistyle:=DeepBlue;
     if (tipo_skin='3') then skin.uistyle:=MacOS;
     if (tipo_skin='4') then skin.uistyle:=Protein;
     application.processmessages;

    LblDataVendaInicio.Enabled := True;
    LblDataVendaFim.Enabled := True;
    DtpDataVendaInicio.Enabled := True;
    DtpDataVendaFim.Enabled := True;
    DtpDataVendaInicio.Date := StrToDateDef(LeINI('OPER','DATA','dados\oper.ini'),Date);
    DtpDataVendaFim.Date := StrToDateDef(LeINI('OPER','DATA','dados\oper.ini'),Date);

end;

end.
