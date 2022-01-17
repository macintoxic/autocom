unit uProdutos;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, Mask, Buttons, StrUtils, uGlobal, suiThemes,
  SUIMgr, SUIButton, SUIForm;

type
  TfProdutos = class(TForm)
    LblDataVendaInicio: TLabel;
    LblDataVendaFim: TLabel;
    LblTerminalCodigo: TLabel;
    LblOrdem: TLabel;
    LblProdutoCodigo: TLabel;
    LblOperadorCodigo: TLabel;
    BtnProduto: TSpeedButton;
    BtnOperador: TSpeedButton;
    LblTitle: TLabel;
    BtnImprimir: TSpeedButton;
    BtnCancelar: TSpeedButton;
    MskProdutoCodigo: TMaskEdit;
    DtpDataVendaInicio: TDateTimePicker;
    DtpDataVendaFim: TDateTimePicker;
    MskTerminalCodigo: TMaskEdit;
    MskOperadorCodigo: TMaskEdit;
    Panel2: TPanel;
    Panel1: TPanel;
    PanDiv4: TPanel;
    Panel3: TPanel;
    suiForm1: TsuiForm;
    ChkProdutos: TsuiCheckBox;
    ChkDataVenda: TsuiCheckBox;
    ChkTerminal: TsuiCheckBox;
    RadCodigo: TsuiRadioButton;
    RadDescricao: TsuiRadioButton;
    RadQuantidade: TsuiRadioButton;
    RadTotal: TsuiRadioButton;
    ChkOperador: TsuiCheckBox;
    skin: TsuiThemeManager;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnCancelarClick(Sender: TObject);
    procedure suitempChkProdutosClick(Sender: TObject);
    procedure suitempChkDataVendaClick(Sender: TObject);
    procedure suitempChkTerminalClick(Sender: TObject);
    procedure suitempChkOperadorClick(Sender: TObject);
    procedure BtnProdutoClick(Sender: TObject);
    procedure BtnOperadorClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
  public
  end;

var
  fProdutos: TfProdutos;

implementation

uses uConsulta, uMain, uDm, uWait;

{$R *.dfm}

procedure TfProdutos.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE : BtnCancelar.Click;
    VK_RETURN : BtnImprimir.Click;
  end;
end;

procedure TfProdutos.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfProdutos.suitempChkProdutosClick(Sender: TObject);
begin
  if ChkProdutos.Checked then
  begin
    LblProdutoCodigo.Enabled := True;
    MskProdutoCodigo.Enabled := True;
    BtnProduto.Enabled := True;
  end
    else
  begin
    LblProdutoCodigo.Enabled := False;
    MskProdutoCodigo.Enabled := False;
    BtnProduto.Enabled := False;
  end;
end;

procedure TfProdutos.suitempChkDataVendaClick(Sender: TObject);
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

procedure TfProdutos.suitempChkTerminalClick(Sender: TObject);
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

procedure TfProdutos.suitempChkOperadorClick(Sender: TObject);
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

procedure TfProdutos.BtnProdutoClick(Sender: TObject);
begin
  ActiveConsulta := Produto;
  With TfConsulta.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  if OptionsReturn.ExtCodeReturn = 0 then ChkProdutos.Checked := False;
  MskProdutoCodigo.Text := IntToStr(OptionsReturn.ExtCodeReturn);
end;

procedure TfProdutos.BtnOperadorClick(Sender: TObject);
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

procedure TfProdutos.BtnImprimirClick(Sender: TObject);
var
  Sql: String;
  SomaQuantidade, SomaValor, SomaAcrescimo,SomaDesconto,SomaTotalUnid: Real;
begin
  try
    fWait.Show;
    fWait.Refresh;

    SomaQuantidade:=0;
    SomaValor:=0;
    SomaAcrescimo:=0;
    SomaDesconto:=0;

    RunSQL('Commit;');
    if IsNull(MskTerminalCodigo.Text) then ChkTerminal.Checked := False;
    if IsNull(MskOperadorCodigo.Text) then ChkOperador.Checked := False;
    if IsNull(MskProdutoCodigo.Text) then ChkProdutos.Checked := False;

    SQL := ' SELECT DISTINCT P.CODIGOPRODUTO , P.NOMEPRODUTO,' +
           ' SUM(PD.QTDE) AS QTDE,' +
           ' SUM((VALORUN * QTDE)  + ACRESCIMO - DESCONTO) AS VALORSOMA,' +
           ' SUM(PD.VALORUN * PD.QTDE) as TOTUNID,'+
           ' SUM(PD.ACRESCIMO) as TOTACRES,'+
           ' SUM(PD.DESCONTO) as TOTDESC '+
           ' FROM PRODUTO P, PDV_DETALHECUPOM PD ' +
           ' WHERE PD.CFG_CODCONFIG = ' + IntToStr(CodigoLoja) +
           ' AND P.CODIGOPRODUTO = PD.CODIGOPRODUTO' +
           ' AND (PD.SITUACAO = 0)' +
           Ifthen(ChkProdutos.Checked,' AND P.CODIGOPRODUTO = ' + MskProdutoCodigo.Text) +
           Ifthen(ChkTerminal.Checked,' AND PD.TERMINAL = ' + QuotedStr(MskTerminalCodigo.Text)) +
           Ifthen(ChkOperador.Checked,' AND PD.IDUSUARIO = ' + MskOperadorCodigo.Text) +
           Ifthen(ChkDataVenda.Checked,' AND PD.DATAHORA BETWEEN ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaInicio.Date)) + ' AND ' + QuotedStr(FormatDateTime('MM/DD/YYYY HH:MM:SS',DtpDataVendaFim.Date))) +
           ' GROUP BY P.CODIGOPRODUTO, P.NOMEPRODUTO' +
           IfThen(RadCodigo.Checked,' ORDER BY P.CODIGOPRODUTO') +
           IfThen(RadDescricao.Checked,' ORDER BY P.NOMEPRODUTO') +
           IfThen(RadQuantidade.Checked,' ORDER BY QTDE') +
           IfThen(RadTotal.Checked,' ORDER BY VALORSOMA');
    SqlRun(SQL,Dm.QrProdutos,True,True);

    if not Dm.QrProdutos.IsEmpty then
      begin
        Dm.QrProdutos.First;
        While not Dm.QrProdutos.Eof do
          begin
            SomaQuantidade := SomaQuantidade + Dm.QrProdutos.FieldByName('QTDE').AsFloat;
            SomaValor      := SomaValor      + Dm.QrProdutos.FieldByName('VALORSOMA').AsFloat;
            SomaAcrescimo  := SomaAcrescimo  + Dm.QrProdutos.FieldByName('TOTACRES').AsFloat;
            SomaDesconto   := SomaDesconto   + Dm.QrProdutos.FieldByName('TOTDESC').AsFloat;
            SomaTotalUnid  := SomaTotalUnid  + Dm.QrProdutos.FieldByName('TOTUNID').AsFloat;
            Dm.QrProdutos.Next;
            Application.ProcessMessages;
          end;
        fWait.Close;
        Dm.RvAutocom.SetParam('SomaQuantidade',FormatFloat('0.000',SomaQuantidade));
        Dm.RvAutocom.SetParam('SomaValor',FormatFloat(CurrencyString + '0.00',SomaValor));
        Dm.RvAutocom.SetParam('SomaAcrescimo',FormatFloat(CurrencyString + '0.00',SomaAcrescimo));
        Dm.RvAutocom.SetParam('SomaTotalUnid',FormatFloat(CurrencyString + '0.00',SomaTotalUnid));
        Dm.RvAutocom.SetParam('SomaDesconto',FormatFloat(CurrencyString + '0.00',SomaDesconto));

        if ChkProdutos.checked then
           Dm.RvAutocom.SetParam('FiltroProduto', MskProdutoCodigo.text)
        else
           Dm.RvAutocom.SetParam('FiltroProduto', 'Todos');

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
        if RadDescricao.checked  then Dm.RvAutocom.SetParam('FiltroOrdem','Descrição do Produto');
        if RadTotal.checked      then Dm.RvAutocom.SetParam('FiltroOrdem','Total líquido vendido');

        Dm.RvAutocom.ExecuteReport('RProdutos');
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

procedure TfProdutos.FormActivate(Sender: TObject);
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
