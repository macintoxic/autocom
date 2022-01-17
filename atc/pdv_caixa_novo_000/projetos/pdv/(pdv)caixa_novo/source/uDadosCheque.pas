unit uDadosCheque;

interface

uses
    Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
    StdCtrls, ExtCtrls, Mask, Buttons;

type
    TfrmDadosCheque = class(TForm)
        Panel2: TPanel;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        bitOk: TBitBtn;
        mskBanco: TMaskEdit;
        mskAgencia: TMaskEdit;
        mskConta: TMaskEdit;
        mskNumero: TMaskEdit;
        mskContaDigito: TMaskEdit;
        mskAgenciaDigito: TMaskEdit;
        mskNumeroDigito: TMaskEdit;
        Label6: TLabel;
        Label7: TLabel;
        Label8: TLabel;
        lblPre: TLabel;
        mskDataCheque: TMaskEdit;
        procedure FormKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure mskNumeroExit(Sender: TObject);
        procedure mskNumeroDigitoExit(Sender: TObject);
        procedure mskBancoExit(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure bitOkClick(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
        strTotalPedido: string;
    end;

var
    frmDadosCheque: TfrmDadosCheque;

implementation
uses
    uRotinas;
{$R *.DFM}

procedure TfrmDadosCheque.FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    if Tag = 1 then
    begin
        if key = VK_UP then
            Perform(WM_NextDlgCtl, 1, 0);
        if key = VK_DOWN then
            Perform(WM_NextDlgCtl, 0, 0);
        if key = VK_RETURN then
            Perform(WM_NextDlgCtl, 0, 0);
    end;
end;

procedure TfrmDadosCheque.mskNumeroExit(Sender: TObject);
begin
    (Sender as TCustomEdit).Text := FormatFloat('0000000000',
        StrToFloatdef((Sender
        as TCustomEdit).Text, 0));
end;

procedure TfrmDadosCheque.mskNumeroDigitoExit(Sender: TObject);
begin
    (Sender as TCustomEdit).Text := FormatFloat('00', StrToFloatdef((Sender as
        TCustomEdit).Text, 0));
end;

procedure TfrmDadosCheque.mskBancoExit(Sender: TObject);
begin
    mskBanco.Text := FormatFloat('000', StrToFloatdef(mskBanco.Text, 0));
    if StrToFloatdef(mskBanco.Text, 0) = 0 then
    begin
        //Application.MessageBox('É necessário informar o BANCO.', TITULO_MENSAGEM,MB_OK + MB_ICONINFORMATION);
        mskBanco.SetFocus;
    end;
end;

procedure TfrmDadosCheque.FormShow(Sender: TObject);
begin
    Tag := 1;
end;

procedure TfrmDadosCheque.bitOkClick(Sender: TObject);
var
    Cheque: FCheque;
    hand: THandle;
    strAux: string;
begin
    strAux := ExtractFilePath(Application.ExeName) + LeINI('modulos',
        'dll_ECF');
    hand := LoadLibrary(PChar(straux));
    @Cheque := GetProcAddress(hand, 'Cheque');
    straux := Cheque(StrToInt(leini('terminal', 'ModECF')),
        StrToInt(leini('terminal', 'comECF')),
        mskBanco.Text,
        strTotalPedido,
        mskDataCheque.Text,
        LeINI('terminal', 'favorecido'),
        leini('terminal', 'municipio'),
        CurrencyString,
        LeINI('terminal', 'Moedasing'),
        LeINI('terminal', 'Moedaplur'));
    if straux[1] = '#' then
        Application.MessageBox(Pchar('Ocorreu um erro durante o envio do comando para a impressora'#13 +
            'Erro: ' + Copy(strAux, 2, Length(straux))), TITULO_MENSAGEM,
                MB_ICONERROR
            + MB_OK);
    FreeLibrary(hand);
    Close;
end;

end.
