unit OpcNota;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, Mask, Db, inifiles,
  IBCustomDataSet, IBQuery, IBDatabase, XPMenu;

type
  TfrmOpcNota = class(TForm)
    cmdFechar: TBitBtn;
    cmdOk: TBitBtn;
    chkDataEmissao: TCheckBox;
    chkClienteFornecedor: TCheckBox;
    chkNumeroNota: TCheckBox;
    datDataEmissaoDe: TDateTimePicker;
    datDataEmissaoAte: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    mskClienteFornecedorDe: TMaskEdit;
    mskClienteFornecedorAte: TMaskEdit;
    mskNumNotaDe: TMaskEdit;
    mskNumNotaAte: TMaskEdit;
    optDataEmissao: TRadioButton;
    optClienteFornecedor: TRadioButton;
    optNotaEntrada: TRadioButton;
    optNotaSaida: TRadioButton;
    optNumeroNotaFiscal: TRadioButton;
    optValorNota: TRadioButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    DbAutocom: TIBDatabase;
    IBTransaction1: TIBTransaction;
    rede: TIBQuery;
    tbl_NFEntrada: TIBQuery;
    tbl_NFSaida: TIBQuery;
    XPMenu1: TXPMenu;
    tbl_NFEntradaDATAEMISSAO: TDateTimeField;
    tbl_NFEntradaNUMERONOTA: TIntegerField;
    tbl_NFEntradaNUMEROPEDIDO: TIntegerField;
    tbl_NFEntradaPES_NOME_A: TIBStringField;
    tbl_NFEntradaCONDICAOPAGAMENTO: TIBStringField;
    tbl_NFEntradaTOTALNOTA: TFloatField;
    tbl_NFEntradaCANCELADA: TIBStringField;
    tbl_NFEntradaFATURADO: TIBStringField;
    tbl_NFSaidaDATAEMISSAO: TDateTimeField;
    tbl_NFSaidaNUMERONOTA: TIntegerField;
    tbl_NFSaidaNUMEROPEDIDO: TIntegerField;
    tbl_NFSaidaPES_NOME_A: TIBStringField;
    tbl_NFSaidaCONDICAOPAGAMENTO: TIBStringField;
    tbl_NFSaidaTOTALNOTA: TFloatField;
    tbl_NFSaidaCANCELADA: TIBStringField;
    tbl_NFSaidaFATURADO: TIBStringField;
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure optNotaEntradaClick(Sender: TObject);
    procedure optNotaEntradaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure optNotaSaidaClick(Sender: TObject);
    procedure chkNumeroNotaClick(Sender: TObject);
    procedure mskNumNotaDeExit(Sender: TObject);
    procedure mskNumNotaAteExit(Sender: TObject);
    procedure chkDataEmissaoClick(Sender: TObject);
    procedure chkClienteFornecedorClick(Sender: TObject);
    procedure mskClienteFornecedorDeExit(Sender: TObject);
    procedure mskClienteFornecedorAteExit(Sender: TObject);
    procedure cmdOkClick(Sender: TObject);
    procedure cmdFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    b_Ativo: Boolean;
    s_CodigoLoja: String;
    s_DescricaoLoja: String;
    s_Path: String;

    function AllTrim(s_String: String): String;
    function Enche(s_String: String; s_Caracter: String; i_Lado: Integer; i_Tamanho: Integer): String;
    function MontaFiltro(): Boolean;

    procedure Conecta_DB();
    procedure Desconecta_DB();
    procedure Executa_SQL(obj_IBQuery: TIBQuery; s_SQL: String; b_Open: Boolean = true);
    procedure Limpa_Campos();
    procedure Log(s_String: String);
  end;

var
  frmOpcNota: TfrmOpcNota;

implementation

uses ImpNotaEntrada, ImpNotaSaida;

{$R *.dfm}

procedure TfrmOpcNota.FormActivate(Sender: TObject);
begin
    s_Path := ExtractFilePath(Application.ExeName) + 'dados\';

    Conecta_DB;

    Limpa_Campos;

    optNotaEntrada.SetFocus;
end;

procedure TfrmOpcNota.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    Desconecta_DB;
end;

procedure TfrmOpcNota.optNotaEntradaClick(Sender: TObject);
begin
    chkClienteFornecedor.Caption := 'Fornecedor';
    optClienteFornecedor.Caption := 'Fornecedor';
end;

procedure TfrmOpcNota.optNotaEntradaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if Key = VK_RETURN then
        Perform(WM_NEXTDLGCTL, 0, 0);
end;

procedure TfrmOpcNota.optNotaSaidaClick(Sender: TObject);
begin
    chkClienteFornecedor.Caption := 'Cliente';
    optClienteFornecedor.Caption := 'Cliente';
end;

procedure TfrmOpcNota.chkNumeroNotaClick(Sender: TObject);
begin
    if chkNumeroNota.Checked then
    begin
        Label2.Enabled := true;
        mskNumNotaDe.Text := Enche(AllTrim(mskNumNotaDe.Text), '0', 1, 8);
        mskNumNotaDe.Enabled := true;
        Label3.Enabled := true;
        mskNumNotaAte.Text := Enche(AllTrim(mskNumNotaAte.Text), '0', 1, 8);
        mskNumNotaAte.Enabled := true;
        mskNumNotaDe.SetFocus;
    end
    else
    begin
        Label2.Enabled := false;
        mskNumNotaDe.Clear;
        mskNumNotaDe.Enabled := false;
        Label3.Enabled := false;
        mskNumNotaAte.Clear;
        mskNumNotaAte.Enabled := false;
    end;
end;

procedure TfrmOpcNota.mskNumNotaDeExit(Sender: TObject);
begin
    mskNumNotaDe.Text := Enche(AllTrim(mskNumNotaDe.Text), '0', 1, 8);
end;

procedure TfrmOpcNota.mskNumNotaAteExit(Sender: TObject);
begin
    mskNumNotaAte.Text := Enche(AllTrim(mskNumNotaAte.Text), '0', 1, 8);
end;

procedure TfrmOpcNota.chkDataEmissaoClick(Sender: TObject);
begin
    if chkDataEmissao.Checked then
    begin
        Label4.Enabled := true;
        datDataEmissaoDe.Enabled := true;
        Label5.Enabled := true;
        datDataEmissaoAte.Enabled := true;
        datDataEmissaoDe.SetFocus;
    end
    else
    begin
        Label4.Enabled := false;
        datDataEmissaoDe.Enabled := false;
        Label5.Enabled := false;
        datDataEmissaoAte.Enabled := false;
    end;
end;

procedure TfrmOpcNota.chkClienteFornecedorClick(Sender: TObject);
begin
    if chkClienteFornecedor.Checked then
    begin
        Label6.Enabled := true;
        mskClienteFornecedorDe.Text := Enche(AllTrim(mskClienteFornecedorDe.Text), '0', 1, 13);
        mskClienteFornecedorDe.Enabled := true;
        Label7.Enabled := true;
        mskClienteFornecedorAte.Text := Enche(AllTrim(mskClienteFornecedorAte.Text), '0', 1, 13);
        mskClienteFornecedorAte.Enabled := true;
        mskClienteFornecedorDe.SetFocus;
    end
    else
    begin
        Label6.Enabled := false;
        mskClienteFornecedorDe.Clear;
        mskClienteFornecedorDe.Enabled := false;
        Label7.Enabled := false;
        mskClienteFornecedorAte.Clear;
        mskClienteFornecedorAte.Enabled := false;
    end;
end;

procedure TfrmOpcNota.mskClienteFornecedorDeExit(Sender: TObject);
begin
    mskClienteFornecedorDe.Text := Enche(AllTrim(mskClienteFornecedorDe.Text), '0', 1, 13);
end;

procedure TfrmOpcNota.mskClienteFornecedorAteExit(Sender: TObject);
begin
    mskClienteFornecedorAte.Text := Enche(AllTrim(mskClienteFornecedorAte.Text), '0', 1, 13);
end;

procedure TfrmOpcNota.cmdOkClick(Sender: TObject);
begin
    Executa_SQL(frmOpcNota.rede, 'Commit', false);

    if MontaFiltro then
    begin
        if optNotaEntrada.Checked then
            frmImpNotaEntrada.QrNota.Preview
        else
            frmImpNotaSaida.QRNota.Preview;
    end
    else
        Application.MessageBox('Não existem notas emitidas nessas condições.', 'Autocom PLUS', 16);
end;

procedure TfrmOpcNota.cmdFecharClick(Sender: TObject);
begin
    Close;
end;

{*******************************************************************************
                                    Funcoes
*******************************************************************************}

{ Funcao que retira espacos em branco a esquerda e a direita }
function TfrmOpcNota.AllTrim(s_String: String): String;
begin
     while Pos(' ', s_String) > 0 do
        Delete(s_String, Pos(' ', s_String), 1);

     while Pos('', s_String) > 0 do
        Delete(s_String, Pos('', s_String), 1);

     Result := s_String;
end;

{ Funcao que preenche uma string com a quantidade de caracteres desejados, tanto
a esquerda quanto a direita.

  i_Lado = 1 -> caracteres a esqueda
  i_Lado = 2 -> caracteres a direita }
function TfrmOpcNota.Enche(s_String: String; s_Caracter: String; i_Lado: Integer; i_Tamanho: Integer): String;
begin
    while Length(s_String) < i_Tamanho do
    begin
        if i_Lado = 1 then
            s_String := s_Caracter + s_String
        else
            s_String := s_String + s_Caracter;
    end;

    Result := s_String;
end;

function TfrmOpcNota.MontaFiltro: Boolean;
var s_Coment: String;
    s_Filter: String;
    s_OrderBy: String;
    s_SQL: String;
begin
    Result := true;

    s_Filter := '';
    s_OrderBy := '';

    if optNumeroNotaFiscal.Checked then
        s_OrderBy := ' ORDER BY 2';

    if optDataEmissao.Checked then
        s_OrderBy := ' ORDER BY 1';

    if optClienteFornecedor.Checked then
        s_OrderBy := ' ORDER BY 4';

    if optValorNota.Checked then
        s_OrderBy := ' ORDER BY 6';

    if optNotaEntrada.Checked then
    begin
        frmImpNotaEntrada.QRLabel2.Caption := 'NOTAS DE ENTRADA';
        frmImpNotaEntrada.QRLabel7.Caption := 'Fornecedor';

        if chkNumeroNota.Checked then
        begin
            s_Coment := s_Coment + '    Nota Fiscal: da ' + mskNumNotaDe.Text + ' até a ' + mskNumNotaAte.Text;
            s_Filter := s_Filter + ' AND (NotaFiscalEntrada.NUMERONOTA >= ' + mskNumNotaDe.Text + ' AND NotaFiscalEntrada.NUMERONOTA <= ' + mskNumNotaAte.Text + ')';
        end
        else
        begin
            s_Coment := s_Coment + '    Notas Fiscais: Todas';
        end;

        if chkDataEmissao.Checked then
        begin
            s_Coment := s_Coment + '    Data: de ' + FormatDateTime('dd/mm/yyyy', datDataEmissaoDe.Date) + ' até ' + FormatDateTime('dd/mm/yyyy', datDataEmissaoAte.Date);
            s_Filter := s_Filter + ' AND (NotaFiscalEntrada.DATAEMISSAO >= ' + chr(39) + FormatDateTime('mm/dd/yyyy', datDataEmissaoDe.Date) + chr(39) + ' AND NotaFiscalEntrada.DATAEMISSAO <= ' + chr(39) + FormatDateTime('mm/dd/yyyy', datDataEmissaoAte.Date) + chr(39) + ')';
        end
        else
        begin
            s_Coment := s_Coment + '    Datas: Todas';
        end;

        if chkClienteFornecedor.Checked then
        begin
            s_Coment := s_Coment + '    Fornecedor: do ' + mskClienteFornecedorDe.Text + ' até o ' + mskClienteFornecedorAte.Text;
            s_Filter := s_Filter + ' AND (NotaFiscalEntrada.FRNCODFORNECEDOR >= ' + '(SELECT FRN_CODFORNECEDOR FROM Fornecedor WHERE CODIGOFORNECEDOR = ' + mskClienteFornecedorDe.Text + ')' + ' AND NotaFiscalEntrada.FRNCODFORNECEDOR <= ' + '(SELECT FRN_CODFORNECEDOR FROM Fornecedor WHERE CODIGOFORNECEDOR = ' + mskClienteFornecedorAte.Text + ')' + ')';
        end
        else
        begin
            s_Coment := s_Coment + '    Fornecedores: Todos'
        end;

        s_SQL := 'SELECT NotaFiscalEntrada.DATAEMISSAO, ' +
                        'NotaFiscalEntrada.NUMERONOTA, ' +
                        'PedidoCompra.NUMEROPEDIDO, ' +
                        'Pessoa.PES_NOME_A, ' +
                        'CondicaoPagamento.CONDICAOPAGAMENTO, ' +
                        'NotaFiscalEntrada.TOTALNOTA, ' +
                        'NotaFiscalEntrada.CANCELADA, ' +
                        'NotaFiscalEntrada.FATURADO ' +
                 'FROM Pessoa, Fornecedor, CondicaoPagamento, NotaFiscalEntrada LEFT JOIN PedidoCompra ON NotaFiscalEntrada.CODIGOPEDIDOCOMPRA = PedidoCompra.CODIGOPEDIDOCOMPRA ' +
                 'WHERE Fornecedor.FRN_CODFORNECEDOR = NotaFiscalEntrada.FRN_CODFORNECEDOR ' +
                 'AND Pessoa.PES_CODPESSOA = Fornecedor.PES_CODPESSOA ' +
                 'AND CondicaoPagamento.CODIGOCONDICAOPAGAMENTO = NotaFiscalEntrada.CODIGOCONDICAOPAGAMENTO' + s_Filter + s_OrderBy;

        Executa_SQL(frmOpcNota.tbl_NFEntrada, s_SQL);

        frmImpNotaEntrada.QrLabel3.Caption := s_Coment;

        if frmOpcNota.tbl_NFEntrada.RecordCount <= 0 then
            Result := false
        else
            frmOpcNota.Log('Geração de relatório de notas fiscais emitidas');
    end
    else
    begin
        frmImpNotaSaida.QRLabel2.Caption := 'NOTAS DE SAÍDA';
        frmImpNotaSaida.QRLabel7.Caption := 'Cliente';

        if chkNumeroNota.Checked then
        begin
            s_Coment := s_Coment + '    Nota Fiscal: da ' + mskNumNotaDe.Text + ' até a ' + mskNumNotaAte.Text;
            s_Filter := s_Filter + ' AND (NotaFiscalSaida.NUMERONOTA >= ' + mskNumNotaDe.Text + ' AND NotaFiscalSaida.NUMERONOTA <= ' + mskNumNotaAte.Text + ')';
        end
        else
        begin
            s_Coment := s_Coment + '    Notas Fiscais: Todas';
        end;

        if chkDataEmissao.Checked then
        begin
            s_Coment := s_Coment + '    Data: de ' + FormatDateTime('dd/mm/yyyy', datDataEmissaoDe.Date) + ' até ' + FormatDateTime('dd/mm/yyyy', datDataEmissaoAte.Date);
            s_Filter := s_Filter + ' AND (NotaFiscalSaida.DATAEMISSAO >= ' + chr(39) + FormatDateTime('mm/dd/yyyy', datDataEmissaoDe.Date) + chr(39) + ' AND NotaFiscalSaida.DATAEMISSAO <= ' + chr(39) + FormatDateTime('mm/dd/yyyy', datDataEmissaoAte.Date) + chr(39) + ')';
        end
        else
        begin
            s_Coment := s_Coment + '    Datas: Todas';
        end;

        if chkClienteFornecedor.Checked then
        begin
            s_Coment := s_Coment + '    Cliente: do ' + mskClienteFornecedorDe.Text + ' até o ' + mskClienteFornecedorAte.Text;
            s_Filter := s_Filter + ' AND (NotaFiscalSaida.CLI_CODCLIENTE >= ' + '(SELECT CLI_CODCLIENTE FROM Cliente WHERE CODIGOCLIENTE = ' + mskClienteFornecedorDe.Text + ')' + ' AND NotaFiscalSaida.CLI_CODCLIENTE <= ' + '(SELECT CLI_CODCLIENTE FROM Cliente WHERE CODIGOCLIENTE = ' + mskClienteFornecedorAte.Text + ')' +')';
        end
        else
        begin
            s_Coment := s_Coment + '    Clientes: Todos';
        end;

        s_SQL := 'SELECT NotaFiscalSaida.DATAEMISSAO, ' +
                        'NotaFiscalSaida.NUMERONOTA, ' +
                        'PedidoVenda.NUMEROPEDIDO, ' +
                        'Pessoa.PES_NOME_A, ' +
                        'CondicaoPagamento.CONDICAOPAGAMENTO, ' +
                        'NotaFiscalSaida.TOTALNOTA, ' +
                        'NotaFiscalSaida.CANCELADA, ' +
                        'NotaFiscalSaida.FATURADO ' +
                 'FROM Pessoa, Cliente, CondicaoPagamento, NotaFiscalSaida LEFT JOIN PedidoVenda ON NotaFiscalSaida.CODIGOPEDIDOVENDA = PedidoVenda.CODIGOPEDIDOVENDA ' +
                 'WHERE Cliente.CLI_CODCLIENTE = NotaFiscalSaida.CLI_CODCLIENTE ' +
                 'AND Pessoa.PES_CODPESSOA = Cliente.PES_CODPESSOA ' +
                 'AND CondicaoPagamento.CODIGOCONDICAOPAGAMENTO = NotaFiscalSaida.CODIGOCONDICAOPAGAMENTO' + s_Filter + s_OrderBy;

        Executa_SQL(frmOpcNota.tbl_NFSaida, s_SQL);

        frmImpNotaSaida.QrLabel3.Caption := s_Coment;

        if frmOpcNota.tbl_NFSaida.RecordCount <= 0 then
            Result := false
        else
            frmOpcNota.Log('Geração de relatório de notas fiscais emitidas');
    end;
end;

{*******************************************************************************
                                    Procedimentos
*******************************************************************************}

procedure TfrmOpcNota.Conecta_DB;
var Ini: TIniFile;
    s_T1: String;
    s_T2: String;
begin
    IBTransaction1.Active := false;
    DbAutocom.connected := false;

    Ini := TIniFile.Create(s_Path + 'Autocom.ini');
    s_T1 := Ini.ReadString('ATCPLUS', 'IP_SERVER', '');
    s_T2 := Ini.ReadString('ATCPLUS', 'PATH_DB', '');
    Ini.Free;

    DbAutocom.DatabaseName := s_T1 + ':' + s_T2;

    DBAutocom.Connected := true;
    IBTransaction1.Active := true;
end;

procedure TfrmOpcNota.Desconecta_DB;
begin
    IBTransaction1.Active := false;
    DBAutocom.Connected := false;
end;

procedure TfrmOpcNota.Executa_SQL(obj_IBQuery: TIBQuery; s_SQL: String;
  b_Open: Boolean);
begin
    obj_IBQuery.Close;
    obj_IBQuery.SQL.Clear;
    obj_IBQuery.SQL.Add(s_SQL);
    obj_IBQuery.Prepare;

    if b_Open then
        obj_IBQuery.Open
    else
        obj_IBQuery.ExecSQL;
end;

procedure TfrmOpcNota.Limpa_Campos;
begin
    optNotaEntrada.Checked := true;

    chkNumeroNota.Checked := false;
    Label2.Enabled := false;
    mskNumNotaDe.Clear;
    Label3.Enabled := false;
    mskNumNotaAte.Clear;

    chkDataEmissao.Checked := false;
    Label4.Enabled := false;
    datDataEmissaoDe.Date := Date;
    Label5.Enabled := false;
    datDataEmissaoAte.Date := Date;

    chkClienteFornecedor.Checked := false;
    Label6.Enabled := false;
    mskClienteFornecedorDe.Clear;
    Label7.Enabled := false;
    mskClienteFornecedorAte.Clear;

    optNumeroNotaFiscal.Checked := true;
end;

{ Procedure que gera o log
  A procedure TfrmOpcNota.Log cria um log, em formato TXT, no mesmo diretorio do
  programa com os modulos acessados.
  Isso facilita a depuracao de algum eventual BUG no sistema. }
procedure TfrmOpcNota.Log(s_String: String);
var LogFile: TextFile;
begin
    AssignFile(LogFile, ExtractFilePath(Application.ExeName) + 'Autocom.log');

    if not FileExists(ExtractFilePath(Application.ExeName) + 'Autocom.log') then
        Rewrite(LogFile)
    else
        Reset(LogFile);

    Append(LogFile);
    Writeln(LogFile, DateTimeToStr(now) + ' - ' + s_String);
    Flush(LogFile);
    CloseFile(LogFile);
end;

end.
