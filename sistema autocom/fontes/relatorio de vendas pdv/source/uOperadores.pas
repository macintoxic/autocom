unit uOperadores;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, StrUtils, Mask, ComCtrls, Buttons, uGlobal, DB,
  SUIButton, SUIForm, SUIMgr, SuiThemes, midaslib;

type
  TfOperadores = class(TForm)
    LblDataVendaInicio: TLabel;
    LblDataVendaFim: TLabel;
    LblTerminalCodigo: TLabel;
    LblOperadorCodigo: TLabel;
    BtnOperador: TSpeedButton;
    LblOperadorNome: TLabel;
    LblTitle: TLabel;
    BtnImprimir: TSpeedButton;
    BtnCancelar: TSpeedButton;
    DtpDataVendaInicio: TDateTimePicker;
    DtpDataVendaFim: TDateTimePicker;
    MskTerminalCodigo: TMaskEdit;
    MskOperadorCodigo: TMaskEdit;
    Panel2: TPanel;
    Panel1: TPanel;
    Panel3: TPanel;
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
  fOperadores: TfOperadores;

implementation

uses uConsulta, uMain, uDm, uWait;

{$R *.dfm}

procedure TfOperadores.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : BtnCancelar.Click;
    VK_RETURN : BtnImprimir.Click;
  end;
end;

procedure TfOperadores.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfOperadores.suitempChkDataVendaClick(Sender: TObject);
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

procedure TfOperadores.suitempChkTerminalClick(Sender: TObject);
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

procedure TfOperadores.suitempChkOperadorClick(Sender: TObject);
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

procedure TfOperadores.BtnOperadorClick(Sender: TObject);
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

procedure TfOperadores.BtnImprimirClick(Sender: TObject);
var
  Sql, SqlSangrias, SqlFinalizadoras, modal_somasaldo,NCP_invalidos: String;
  SomaQuantidade, SomaRepique, SomaContravale,  SomaValor: Real;
  DsSangrias, DsFinalizadores: TDataSet;
begin
  try
    fWait.Show;
    fWait.Refresh;
    RunSQL('Commit;');
    if IsNull(MskOperadorCodigo.Text) then
      begin
        fWait.Close;
        MessageBox(Handle,'É necessário informar um operador!',Autocom,MB_ICONWARNING);
        Exit;
      end;
    
    if IsNull(MskTerminalCodigo.Text) then ChkTerminal.Checked := False;

    // a rotina abaixo separa as formas de pagamento que permitem a soma do saldo no caixa
    modal_somasaldo := '0';
    SQL := 'SELECT CODIGOCONDICAOPAGAMENTO FROM CONDICAOPAGAMENTO WHERE SOMASALDO = ' + QuotedStr('F');
    SqlRun(SQL,Dm.generico,True,True);
    if not Dm.generico.IsEmpty then
      begin
        Dm.generico.First;
        While not Dm.generico.Eof do
          begin
            modal_somasaldo := modal_somasaldo+','+Dm.generico.FieldByName('CODIGOCONDICAOPAGAMENTO').Asstring;
            Dm.generico.Next;
            Application.ProcessMessages;
          end;
      end;

    NCP_invalidos := '0';
{
    SQL :=' SELECT PC.NCP FROM PDV_FECHAMENTOCUPOM PF, PDV_CABECALHOCUPOM PC ' +
           ' WHERE PC.CFG_CODCONFIG = ' + IntToStr(CodigoLoja) +
           ' AND PC.SITUACAO <> 1 ' +
           Ifthen(ChkTerminal.Checked,' AND PC.TERMINAL = ' + MskTerminalCodigo.Text) +
           ' AND PC.IDUSUARIO = ' + MskOperadorCodigo.Text +
           Ifthen(ChkDataVenda.Checked,' AND PC.DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +
          ' and PF.TERMINAL = PC.TERMINAL ' +
          ' AND PF.NCP = PC.NCP ' +
          ' AND PF.CFG_CODCONFIG = PC.CFG_CODCONFIG ' +
          ' AND SUBSTRING(PF.DATAHORA FROM 1 FOR 8) = SUBSTRING(PC.DATAHORA FROM 1 FOR 8) ' +
          ' AND PF.CODIGOCONDICAOPAGAMENTO IN ('+modal_somasaldo+')';
}

    SQL :=' SELECT PF.NCP FROM PDV_FECHAMENTOCUPOM PF' +
           ' WHERE PF.CFG_CODCONFIG = ' + IntToStr(CodigoLoja) +
           Ifthen(ChkTerminal.Checked,' AND PF.TERMINAL = ' + MskTerminalCodigo.Text) +
           ' AND PF.IDUSUARIO = ' + MskOperadorCodigo.Text +
           Ifthen(ChkDataVenda.Checked,' AND PF.DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +
          ' AND PF.CODIGOCONDICAOPAGAMENTO IN ('+modal_somasaldo+')';


    SqlRun(SQL,Dm.generico,True,True);
    if not Dm.QrOperadores.IsEmpty then
      begin
        Dm.generico.First;
        While not Dm.generico.Eof do
          begin
            NCP_invalidos := ncp_invalidos+','+Dm.generico.FieldByName('NCP').Asstring;
            Dm.generico.Next;
            Application.ProcessMessages;
          end;
      end;

    SQL := ' SELECT  U.IDUSUARIO, U.NOMEUSUARIO, ' +
           ' (SELECT COUNT(CFG_CODCONFIG) FROM PDV_CABECALHOCUPOM WHERE (SITUACAO <> 1 OR SITUACAO IS NULL) ' + ' AND IDUSUARIO = ' + MskOperadorCodigo.Text   + Ifthen(ChkDataVenda.Checked,' AND DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +  Ifthen(ChkTerminal.Checked,' AND TERMINAL = ' + MskTerminalCodigo.Text) + ' AND CFG_CODCONFIG = ' + IntToStr(CodigoLoja) + ') AS QUANTIDADE,'+
//           ' SUM(PC.VALORCUPOM) AS VALOR,' +
           ' SUM(PC.VALORCUPOM - PC.DESCONTO + PC.ACRESCIMO) AS VALOR,' +
           ' (SELECT COUNT(CFG_CODCONFIG) FROM PDV_DETALHECUPOM WHERE SITUACAO = 1 ' + ' AND IDUSUARIO = ' + MskOperadorCodigo.Text   + Ifthen(ChkDataVenda.Checked,' AND DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +  Ifthen(ChkTerminal.Checked,' AND TERMINAL = ' + MskTerminalCodigo.Text) + ' AND CFG_CODCONFIG = ' + IntToStr(CodigoLoja) + ')  AS CANCITEM,' +
           ' (SELECT COUNT(CFG_CODCONFIG) FROM PDV_CABECALHOCUPOM WHERE SITUACAO = 1 '  + ' AND IDUSUARIO = ' + MskOperadorCodigo.Text   + Ifthen(ChkDataVenda.Checked,' AND DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +  Ifthen(ChkTerminal.Checked,' AND TERMINAL = ' + MskTerminalCodigo.Text) + ' AND CFG_CODCONFIG = ' + IntToStr(CodigoLoja) + ')  AS CANCVENDA,' +
           ' (SELECT COUNT(ACRESCIMO) FROM PDV_CABECALHOCUPOM WHERE ACRESCIMO > 0  AND CFG_CODCONFIG =  1 ' + Ifthen(ChkDataVenda.Checked,' AND DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) + ' AND IDUSUARIO = ' + MskOperadorCodigo.Text + Ifthen(ChkTerminal.Checked,' AND TERMINAL = '  + MskTerminalCodigo.Text) + ' ) AS QTDEACRESCIMO, ' +
           ' (SELECT SUM(ACRESCIMO) FROM PDV_CABECALHOCUPOM WHERE ACRESCIMO > 0  AND CFG_CODCONFIG =  1 ' + Ifthen(ChkDataVenda.Checked,' AND DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +  ' AND IDUSUARIO = ' + MskOperadorCodigo.Text + Ifthen(ChkTerminal.Checked,' AND TERMINAL = ' + MskTerminalCodigo.Text) + ') AS VALORACRESCIMO, ' +
           ' (SELECT COUNT(DESCONTO) FROM PDV_CABECALHOCUPOM WHERE DESCONTO > 0  AND CFG_CODCONFIG =  1 ' + Ifthen(ChkDataVenda.Checked,' AND DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) + ' AND IDUSUARIO = ' + MskOperadorCodigo.Text + Ifthen(ChkTerminal.Checked,' AND TERMINAL = '  + MskTerminalCodigo.Text) + ' ) AS QTDEDESCONTO, ' +
           ' (SELECT SUM(DESCONTO) FROM PDV_CABECALHOCUPOM WHERE DESCONTO > 0  AND CFG_CODCONFIG =  1 ' + Ifthen(ChkDataVenda.Checked,' AND DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +  ' AND IDUSUARIO = ' + MskOperadorCodigo.Text + Ifthen(ChkTerminal.Checked,' AND TERMINAL = ' + MskTerminalCodigo.Text) + ') AS VALORDESCONTO, ' +
           ' (SELECT COUNT(VALOR) FROM PDV_MOVIMENTOEXTRA WHERE VALOR > 0  AND CFG_CODCONFIG =  1 ' + Ifthen(ChkDataVenda.Checked,' AND DATA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY',DtpDataVendaFim.Date))) + ' AND IDUSUARIO = ' + MskOperadorCodigo.Text + Ifthen(ChkTerminal.Checked,' AND TERMINAL = '  + MskTerminalCodigo.Text) + ' ) AS FCXQTDE, ' +
           ' (SELECT SUM(VALOR) FROM PDV_MOVIMENTOEXTRA WHERE VALOR > 0  AND CFG_CODCONFIG =  1 ' + Ifthen(ChkDataVenda.Checked,' AND DATA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY ',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY',DtpDataVendaFim.Date))) +  ' AND IDUSUARIO = ' + MskOperadorCodigo.Text + Ifthen(ChkTerminal.Checked,' AND TERMINAL = ' + MskTerminalCodigo.Text) + ') AS FCXVALOR ' +
           ' FROM PDV_CABECALHOCUPOM PC' +
           ' INNER JOIN USUARIOSISTEMA U ON (U.IDUSUARIO = PC.IDUSUARIO) ' +
           ' WHERE PC.CFG_CODCONFIG = ' + IntToStr(CodigoLoja) +
           ' AND PC.SITUACAO <> 1 ' +
           Ifthen(ChkTerminal.Checked,' AND PC.TERMINAL = ' + MskTerminalCodigo.Text) +
           ' AND PC.IDUSUARIO = ' + MskOperadorCodigo.Text +
           Ifthen(ChkDataVenda.Checked,' AND PC.DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +
           ' AND PC.NCP NOT IN ('+NCP_invalidos+')' +
           ' GROUP BY U.IDUSUARIO, U.NOMEUSUARIO' +
           ' ORDER BY U.IDUSUARIO';
    SqlRun(SQL,Dm.QrOperadores,True,True);


    //Valor total de vendas (bruto)
    if not Dm.QrOperadores.IsEmpty then
      begin
         SomaQuantidade := Dm.QrOperadores.FieldByName('QUANTIDADE').value;
         SomaValor := Dm.QrOperadores.FieldByName('VALOR').AsFloat;

        SqlFinalizadoras := ' SELECT DISTINCT ' +
                            ' PF.CODIGOCONDICAOPAGAMENTO, ' +
                            ' CP.CONDICAOPAGAMENTO, ' +
                            ' CP.SOMASALDO, ' +
                            ' SUM(PF.VALORRECEBIDO) AS VALOR, ' +
                            ' COUNT(PF.CFG_CODCONFIG) AS QTDE, ' +
                            ' SUM(PF.CONTRAVALE) AS CONTRAVALE, ' +
                            ' SUM(PF.TROCO) AS TROCO, ' +
                            ' SUM(PF.REPIQUE) AS REPIQUE ' +
                            ' FROM PDV_CABECALHOCUPOM PC, PDV_FECHAMENTOCUPOM PF ' +
                            ' RIGHT JOIN ' +
                            ' CONDICAOPAGAMENTO CP ' +
                            ' ON (PF.CODIGOCONDICAOPAGAMENTO = CP.CODIGOCONDICAOPAGAMENTO) ' +
                            ' WHERE PF.CFG_CODCONFIG = ' + IntToStr(CodigoLoja) + 'AND PC.CFG_CODCONFIG = ' + IntToStr(CodigoLoja) +
                            Ifthen(ChkTerminal.Checked,' AND PF.TERMINAL = ' + MskTerminalCodigo.Text) +
                            Ifthen(ChkTerminal.Checked,' AND PC.TERMINAL = ' + MskTerminalCodigo.Text) +
                            ' AND PF.IDUSUARIO = ' + MskOperadorCodigo.Text +
                            Ifthen(ChkDataVenda.Checked,' AND PF.DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +
                            Ifthen(ChkDataVenda.Checked,' AND PC.DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +
                            ' AND PC.TERMINAL = PF.TERMINAL ' +
                            ' AND PC.NCP = PF.NCP ' +
                            ' AND SUBSTRING(PC.DATAHORA FROM 1 FOR 8) = SUBSTRING(PF.DATAHORA FROM 1 FOR 8) ' +
                            ' AND PC.SITUACAO <> 1 ' +
                            ' GROUP BY  PF.CODIGOCONDICAOPAGAMENTO, CP.CONDICAOPAGAMENTO, CP.SOMASALDO' +
                            ' ORDER BY CP.CONDICAOPAGAMENTO';

        SqlSangrias := ' SELECT DISTINCT ' +
                       ' CP.CODIGOCONDICAOPAGAMENTO, ' +
                       ' CP.CONDICAOPAGAMENTO, ' +
                       ' SUM(PE.VALOR * -1) AS VALOR, ' +
                       ' COUNT(PE.VALOR) AS QTDE ' +
                       ' FROM PDV_MOVIMENTOEXTRA PE RIGHT JOIN CONDICAOPAGAMENTO CP ON (PE.CODIGOCONDICAOPAGAMENTO = CP.CODIGOCONDICAOPAGAMENTO)  ' +
                       ' WHERE VALOR < 0 ' +
                       Ifthen(ChkTerminal.Checked,' AND PE.TERMINAL = ' + MskTerminalCodigo.Text) +
                       ' AND PE.IDUSUARIO = ' + MskOperadorCodigo.Text +
                       Ifthen(ChkDataVenda.Checked,' AND PE.DATA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY',DtpDataVendaFim.Date))) +
                       ' AND PE.CFG_CODCONFIG = ' + IntToStr(CodigoLoja) +
                       ' GROUP BY CP.CODIGOCONDICAOPAGAMENTO, CP.CONDICAOPAGAMENTO ' +
                       ' ORDER BY CP.CONDICAOPAGAMENTO ';

        RunSQL(SqlSangrias,DsSangrias,True);
        RunSQL(SqlFinalizadoras,DsFinalizadores,True);
        ZeroMemory(@SomaValor,SizeOf(SomaValor));
        ZeroMemory(@SomaRepique,SizeOf(SomaRepique));
        ZeroMemory(@SomaContravale,SizeOf(SomaContravale));


        //Modela dados no Client Data Set
        Dm.CdsOperadoresF.close;
        Dm.CdsOperadoresF.filename:=extractfilepath(application.ExeName)+'dados\reloper.xml';
        if not fileexists(Dm.CdsOperadoresF.filename) then Dm.CdsOperadoresF.CreateDataSet;
        Dm.CdsOperadoresF.Open;
        Dm.CdsOperadoresF.EmptyDataSet;
        Dsfinalizadores.first;
        while not DsFinalizadores.Eof do
          begin
            Dm.CdsOperadoresF.Insert;
            Dm.CdsOperadoresFCodigoCondicaoPagamento.Value := DsFinalizadores.FieldByName('CODIGOCONDICAOPAGAMENTO').AsFloat;
            Dm.CdsOperadoresFCondicaoPagamento.Value       := DsFinalizadores.FieldByName('CONDICAOPAGAMENTO').AsString;
            Dm.CdsOperadoresFFinalizadoraQtde.Value        := DsFinalizadores.FieldByName('QTDE').AsFloat;
            Dm.CdsOperadoresFFinalizadoraValor.Value       := DsFinalizadores.FieldByName('VALOR').AsFloat;
            Dm.CdsOperadoresFRepique.Value                 := DsFinalizadores.FieldByName('REPIQUE').AsFloat;
            Dm.CdsOperadoresFContraVale.Value              := DsFinalizadores.FieldByName('CONTRAVALE').AsFloat;
            Dm.CdsOperadoresFTroco.Value                   := DsFinalizadores.FieldByName('TROCO').AsFloat;
            if DsFinalizadores.FieldByName('SOMASALDO').AsString = 'T' then
              Dm.CdsOperadoresFSomaSaldo.AsBoolean := True else
              Dm.CdsOperadoresFSomaSaldo.AsBoolean := False;
            Dm.CdsOperadoresF.Post;
            DsFinalizadores.Next;
            Application.ProcessMessages;
          end;

        while not DsSangrias.Eof do
          begin
            if Dm.CdsOperadoresF.FindKey([DsSangrias.FieldByName('CODIGOCONDICAOPAGAMENTO').Value]) then
              begin
                Dm.CdsOperadoresF.Edit;
                Dm.CdsOperadoresFSangriaQtde.Value  := DsSangrias.FieldByName('QTDE').AsFloat;
                Dm.CdsOperadoresFSangriaValor.Value := DsSangrias.FieldByName('VALOR').AsFloat;
              end
            else
              begin
                Dm.CdsOperadoresF.Insert;
                Dm.CdsOperadoresFCodigoCondicaoPagamento.Value := DsSangrias.FieldByName('CODIGOCONDICAOPAGAMENTO').AsFloat;
                Dm.CdsOperadoresFCondicaoPagamento.Value := DsSangrias.FieldByName('CONDICAOPAGAMENTO').AsString;
                Dm.CdsOperadoresFSangriaQtde.Value  := DsSangrias.FieldByName('QTDE').AsFloat;
                Dm.CdsOperadoresFSangriaValor.Value := DsSangrias.FieldByName('VALOR').AsFloat;
                Application.ProcessMessages;
              end;
            DsSangrias.Next;
          end;

        Dm.CdsOperadoresF.First;
        while not Dm.CdsOperadoresF.Eof do
          begin
            if Dm.CdsOperadoresFSomaSaldo.AsBoolean = True then
              begin
                SomaContravale := SomaContravale + Dm.CdsOperadoresFContraVale.AsFloat;
                SomaValor := (SomaValor) + (Dm.CdsOperadoresFSaldoFinal.AsFloat);
              end;
            Dm.CdsOperadoresF.Next;
            Application.ProcessMessages;
          end;

        SomaValor := SomaValor - SomaContravale;
        fWait.Close;
        Dm.RvAutocom.SetParam('SomaContravale',FormatFloat(CurrencyString + '0.00',SomaContravale));
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

        Dm.RvAutocom.SetParam('Indicador',Leini('TERMINAL','NOMEIND')+':');

        //Verifica Cancelados
        SQLRun(' SELECT DT.DATAHORA,PE.PES_NOME_A,PRD.NOMEPRODUTO,DT.MOTIVO_CANCELAMENTO,DT.NUMEROPEDIDO,dt.QTDE' +
               ' FROM PDV_DETALHECUPOM DT,VENDEDOR VND,PRODUTO PRD,PESSOA PE' +
               ' WHERE PRD.CODIGOPRODUTO=DT.CODIGOPRODUTO' +
               Ifthen(ChkTerminal.Checked,' AND DT.TERMINAL = ' + MskTerminalCodigo.Text) +
               ' AND DT.IDUSUARIO = ' + MskOperadorCodigo.Text +
               Ifthen(ChkDataVenda.Checked,' AND DT.DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +
               ' AND DT.CFG_CODCONFIG = ' + IntToStr(CodigoLoja) +
               ' AND VND.VEN_CODVENDEDOR=DT.VEN_CODVENDEDOR' +
               ' AND PE.PES_CODPESSOA=VND.PES_CODPESSOA' +
               ' AND SITUACAO=1' +
               ' ORDER BY DT.DATAHORA',dm.QROperadorcancelados,true,TRUE);
        if not dm.QROperadorcancelados.IsEmpty then
            Dm.RvAutocom.SetParam('Cancelados','Produtos cancelados')
        else
            Dm.RvAutocom.SetParam('Cancelados','');


        Dm.RvAutocom.ExecuteReport('ROperadores');
        FreeAndNil(DsSangrias);
        FreeAndNil(DsFinalizadores);
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


procedure TfOperadores.FormActivate(Sender: TObject);
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

