unit uHoras;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Mask, Buttons, StrUtils, uGlobal, DB,
  SUIMgr, SUIButton, SUIComboBox, SUIForm, Suithemes;

type
  {Para Armazenar Dados do Relatório de Faixa Horaria}
  TFaixaHoraria = record
    Clientes: Integer;
    Valor:    Real;
  end;

type
  TfHoras = class(TForm)
    LblFaixaHorariaInicio: TLabel;
    LblFaixaHorariaFim: TLabel;
    LblDataVendaInicio: TLabel;
    LblDataVendaFim: TLabel;
    LblTerminalCodigo: TLabel;
    LblOperadorCodigo: TLabel;
    BtnOperador: TSpeedButton;
    BtnImprimir: TSpeedButton;
    BtnCancelar: TSpeedButton;
    LblTitle: TLabel;
    DtpDataVendaInicio: TDateTimePicker;
    DtpDataVendaFim: TDateTimePicker;
    MskTerminalCodigo: TMaskEdit;
    MskOperadorCodigo: TMaskEdit;
    Panel2: TPanel;
    Panel1: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    suiForm1: TsuiForm;
    CmbFaixaHorariaInicio: TsuiComboBox;
    CmbFaixaHorariaFim: TsuiComboBox;
    ChkTerminal: TsuiCheckBox;
    ChkOperador: TsuiCheckBox;
    skin: TsuiThemeManager;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnCancelarClick(Sender: TObject);
    procedure suitempChkTerminalClick(Sender: TObject);
    procedure suitempChkOperadorClick(Sender: TObject);
    procedure BtnOperadorClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    function NPessoas(Hora: String): Integer;
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
  public
  end;

var
  fHoras: TfHoras;
    FaixaHoraria: array[0..23] of TFaixaHoraria;

implementation

uses uMain, uConsulta, uDm, uWait;

{$R *.dfm}

procedure TfHoras.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : BtnCancelar.Click;
    VK_RETURN : BtnImprimir.Click;
  end;
end;

procedure TfHoras.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfHoras.suitempChkTerminalClick(Sender: TObject);
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

procedure TfHoras.suitempChkOperadorClick(Sender: TObject);
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

procedure TfHoras.BtnOperadorClick(Sender: TObject);
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

procedure TfHoras.BtnImprimirClick(Sender: TObject);
var
  Sql: String;
  i: integer;
  SomaQuantidade, SomaValor: Real;
  Ds: TDataSet;  
begin
  try
    fWait.Show;
    fWait.Refresh;
    RunSQL('Commit;');
    if IsNull(MskTerminalCodigo.Text) then ChkTerminal.Checked := False;
    if IsNull(MskOperadorCodigo.Text) then ChkOperador.Checked := False;
    DtpDataVendaInicio.Time := StrToTime(CmbFaixaHorariaInicio.Text + ':00');
    DtpDataVendaFim.Time    := StrToTime(CmbFaixaHorariaFim.Text + ':59');

    SQL := ' SELECT DISTINCT DATAHORA, SUM((VALORUN * QTDE) - DESCONTO + ACRESCIMO) ' +
           ' FROM PDV_DETALHECUPOM ' +
           ' WHERE CFG_CODCONFIG = ' + IntToStr(CodigoLoja) +
           ' AND (SITUACAO IS NULL OR SITUACAO <> 1)' +
           Ifthen(ChkTerminal.Checked,' AND TERMINAL = ' + MskTerminalCodigo.Text) +
           Ifthen(ChkOperador.Checked,' AND IDUSUARIO = ' + MskOperadorCodigo.Text) +
           ' AND SUBSTRING(DATAHORA FROM 13 FOR 8) BETWEEN ' + QuotedStr(CmbFaixaHorariaInicio.Text + ':00') + ' and ' + QuotedStr(CmbFaixaHorariaFim.Text + ':59') +
           ' AND DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date)) +
           ' GROUP BY DATAHORA';
    RunSQL(SQL,Ds,True);
    ZeroMemory(@FaixaHoraria,SizeOf(FaixaHoraria));

    if not Ds.IsEmpty then
      begin
        // Distribui dados no array de record
        while not Ds.Eof do
          begin
            ZeroMemory(@i,SizeOf(i));
            i := StrToInt(FormatDateTime('hh',Ds.Fields[0].AsDateTime));
            FaixaHoraria[i].Valor := FaixaHoraria[i].Valor + Ds.Fields[1].AsFloat;
            Ds.Next;
            Application.ProcessMessages;
          end;

        ZeroMemory(@i,SizeOf(i));
        Ds.First;
        for i := 0 to 23 do
          begin
            FaixaHoraria[i].Clientes := NPessoas(IntToStr(i));
          end;


        ZeroMemory(@i,SizeOf(i));
        ZeroMemory(@SomaValor,SizeOf(SomaValor));
        ZeroMemory(@SomaQuantidade,SizeOf(SomaQuantidade));

        Dm.CdsHoras.close;
        Dm.CdsHoras.filename:=extractfilepath(application.ExeName)+'dados\relfh.xml';
        if not fileexists(Dm.CdsHoras.filename) then Dm.CdsHoras.CreateDataSet;
        Dm.CdsHoras.Open;
        Dm.CdsHoras.EmptyDataSet;
        //Insere Dados Personalizados no Client Data Set
        for i := 0 to 23 do
          begin
            if FaixaHoraria[i].Valor <> 0 then
            begin
              Dm.CdsHoras.Insert;
              Dm.CdsHorasHora.Value     := Format('%0.2d',[i]) + ':00';
              Dm.CdsHorasClientes.Value := FaixaHoraria[i].Clientes;
              Dm.CdsHorasValor.Value    := FaixaHoraria[i].Valor;
              Dm.CdsHoras.Post;
              SomaQuantidade := SomaQuantidade + FaixaHoraria[i].Clientes;
              SomaValor := SomaValor + FaixaHoraria[i].Valor;
            end;
          end;
        fWait.Close;
        Dm.RvAutocom.SetParam('SomaQuantidade',FloatToStr(SomaQuantidade));
        Dm.RvAutocom.SetParam('SomaValor',FormatFloat(CurrencyString + '0.00',SomaValor));
        Dm.RvAutocom.SetParam('TM',FormatFloat(CurrencyString + '0.00',(SomaValor / SomaQuantidade)));

        Dm.RvAutocom.SetParam('FiltroHora', CmbFaixaHorariaInicio.text+' até '+CmbFaixaHorariaFim.text);

        Dm.RvAutocom.SetParam('FiltroDataVenda',datetostr(DtpDataVendaInicio.date)+' até '+datetostr(DtpDataVendaFim.date));

        if ChkTerminal.checked then
           Dm.RvAutocom.SetParam('FiltroTerminal',MsKTerminalCodigo.text)
        else
           Dm.RvAutocom.SetParam('FiltroTerminal','Todos');

        if ChkOperador.checked then
           Dm.RvAutocom.SetParam('FiltroOperador',MskOperadorCodigo.text)
        else
           Dm.RvAutocom.SetParam('FiltroOperador','Todos');



        Dm.RvAutocom.ExecuteReport('RHoras');
      end
    else
      begin
        fWait.Close;
        Application.MessageBox('Năo há movimento nas condiçőes selecionadas!', Autocom, MB_ICONEXCLAMATION);
      end;
  finally
    fWait.Close;
  end;

end;


function TfHoras.NPessoas(Hora: String): Integer;
var
  Ds: TDataSet;
  comp_sql:string;
begin

  if (strtoint(hora)>=0) and (strtoint(hora)<=9) then comp_sql:='13' else comp_sql:='13';
  comp_sql:='12';
  RunSQL(' SELECT SUM(NUMEROCLIENTES) FROM PDV_CABECALHOCUPOM WHERE CFG_CODCONFIG = ' + IntToStr(CodigoLoja) +
         Ifthen(ChkTerminal.Checked,' AND TERMINAL = ' + QuotedStr(MskTerminalCodigo.Text)) +
         Ifthen(ChkOperador.Checked,' AND IDUSUARIO = ' + MskOperadorCodigo.Text) +
         ' AND SUBSTRING(DATAHORA FROM '+comp_sql+' FOR 8) BETWEEN ' + QuotedStr(Hora + ':00:00') + ' and ' + QuotedStr(Hora + ':59:59') +
         ' AND DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY',DtpDataVendaInicio.Date) + ' 00:00:00') + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY',DtpDataVendaFim.Date) + ' 23:59:59') +
         ' AND (SITUACAO IS NULL OR SITUACAO = 0) ',Ds,True);
  Result := Ds.Fields[0].AsInteger;
  FreeAndNil(Ds);
end;

procedure TfHoras.FormShow(Sender: TObject);
begin
    DtpDataVendaInicio.Date := StrToDateDef(LeINI('OPER','DATA','dados\oper.ini'),Date);
    DtpDataVendaFim.Date := StrToDateDef(LeINI('OPER','DATA','dados\oper.ini'),Date);
end;

procedure TfHoras.FormActivate(Sender: TObject);
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
