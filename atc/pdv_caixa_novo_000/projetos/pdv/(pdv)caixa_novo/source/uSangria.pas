//******************************************************************************
//
//                 UNIT USANGRIA (-)
//
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           uSangria.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: uSangria.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:
//
// 1.0.0 01/01/2001 First Version
//
//******************************************************************************

unit uSangria;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Buttons, StdCtrls, Mask, ComCtrls, ExtCtrls, db;

type
    TfrmSangria = class(TForm)
        Panel1: TPanel;
        lbFormaPagamentos: TTreeView;
        Panel2: TPanel;
        lblNome: TLabel;
        Label9: TLabel;
        Label2: TLabel;
        mskValor: TMaskEdit;
        edMotivo: TEdit;
        spdVoltar: TSpeedButton;
        spdConfirma: TSpeedButton;
        procedure spdVoltarClick(Sender: TObject);
        procedure mskValorKeyPress(Sender: TObject; var Key: Char);
        procedure mskValorExit(Sender: TObject);
        procedure FormShow(Sender: TObject);
        procedure FormClose(Sender: TObject; var Action: TCloseAction);
        procedure lbFormaPagamentosClick(Sender: TObject);
        procedure lbFormaPagamentosEnter(Sender: TObject);
        procedure lbFormaPagamentosExit(Sender: TObject);
        procedure FormKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure spdConfirmaClick(Sender: TObject);
        procedure lbFormaPagamentosKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure edMotivoKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
    private
        { Private declarations }
    public
        { Public declarations }
        dsFormasPagamento: TDataSet;
    end;

var
    frmSangria: TfrmSangria;

implementation
uses
    udmPDV, uRotinas, Math;
{$R *.dfm}

procedure TfrmSangria.spdVoltarClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmSangria.mskValorKeyPress(Sender: TObject; var Key: Char);
begin
    //prefiro fazer o controle dessa forma. Charles.
    if key = '.' then
        key := ',';
    if not (key in ['0'..'9', #8, DecimalSeparator]) then
        key := #0;
    if (key = DecimalSeparator) and (Pos(DecimalSeparator, (Sender as
        TCustomEdit).Text) > 0) and
        (Length((Sender as TCustomEdit).Text) <> Length((Sender as
        TCustomEdit).SelText)) then
        key := #0;
end;

procedure TfrmSangria.mskValorExit(Sender: TObject);
begin
    (Sender as TMaskEdit).Text := FormatFloat('0.00', StrToFloatDef((Sender as
        TMaskEdit).Text, 0));
end;

procedure TfrmSangria.FormShow(Sender: TObject);
begin
    dmORC.RunSQL('SELECT F.FORMAFATURAMENTO || '' - '' ||' +
        ' C.CONDICAOPAGAMENTO,F.FORMAFATURAMENTO , ' +
        ' C.*, F.CODIGOTABELAPRECO FROM FORMAFATURAMENTO F,CONDICAOPAGAMENTO C ' +
        ' WHERE ' +
        ' C.CODIGOFORMAFATURAMENTO = F.CODIGOFORMAFATURAMENTO',
            dsFormasPagamento);
    while not dsformaspagamento.Eof do
    begin
        lbFormaPagamentos.Items.AddObject(lbFormaPagamentos.TopItem,
            dsFormasPagamento.FieldByName('F_1').AsString,
            dsFormasPagamento.GetBookmark);
        dsFormasPagamento.Next;
    end;
    //forca selecionar o primeiro item da lista.
    lbFormaPagamentos.Select(lbFormaPagamentos.Items[0]);
    lbFormaPagamentosClick(nil);
end;

procedure TfrmSangria.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    FreeAndNil(dsFormasPagamento);
end;

procedure TfrmSangria.lbFormaPagamentosClick(Sender: TObject);
begin
    dsFormasPagamento.GotoBookmark(lbFormaPagamentos.Selected.Data);
    lblNome.Caption := dsFormasPagamento.FieldByName('F_1').AsString;
end;

procedure TfrmSangria.lbFormaPagamentosEnter(Sender: TObject);
begin
    KeyPreview := False;
end;

procedure TfrmSangria.lbFormaPagamentosExit(Sender: TObject);
begin
    KeyPreview := True;
end;

procedure TfrmSangria.FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    case key of
        VK_RETURN:
            begin
                Perform(WM_NEXTDLGCTL, 0, 0);
            end;
        VK_DOWN: Perform(WM_NEXTDLGCTL, 0, 0);
        VK_UP: Perform(WM_NEXTDLGCTL, 1, 0);
        VK_ESCAPE: spdVoltar.Click;
    end;
end;

procedure TfrmSangria.spdConfirmaClick(Sender: TObject);
var
    sangria: FFCX;
    COO: FCOO;
    strAux: string;
    hand: THandle;
    i: Integer;
begin
    i := 0;
    if StrToFloatDef(mskValor.Text, 0) > (StrToFloat(LeINI('terminal',
        'limitesng')) / 100) then
        Application.MessageBox('Limite de sangria ultrapassado.',
            TITULO_MENSAGEM,
            MB_OK + MB_ICONERROR)
    else
    begin
        strAux := LeINI('modulos', 'dll_ECF');
        hand := LoadLibrary(PChar(straux));
        @Sangria := GetProcAddress(hand, 'Sangria');
        if Assigned(Sangria) then
        begin
            case Application.MessageBox(Pchar('Confirma a saída de ' +
                CurrencyString
                + mskValor.text + ' do caixa?'),
                TITULO_MENSAGEM, MB_OK + MB_YESNOCANCEL + MB_ICONQUESTION) of
                idyes:
                    begin
                        straux := Sangria(strtoint(leini('terminal', 'ModECF')),
                            strtoint(leini('terminal', 'comECF')),
                            '1',
                            mskValor.Text);
                        if TrataerroImpressora(straux) then
                        begin
                            straux := ' ';
                            @COO := GetProcAddress(hand, 'COO');

                            while straux[1] <> '@' do
                            begin
                                // corrigido para tentar algumas vezes antes de sair por erro.
                                strAux := COO(StrToInt(leini('terminal',
                                    'ModECF')),
                                    StrToInt(leini('terminal', 'comECF')), '1');
                                Inc(i);
                                if i > 2 then
                                begin
                                    TrataerroImpressora(strAux);
                                    Exit;
                                end;
                            end;
                            straux := Copy(straux, 2, 6);
                            GravaMovimentoExtra(StrToFloat(mskValor.Text) * -1,
                                dsFormasPagamento.FieldByName('CODIGOCONDICAOPAGAMENTO').AsString,
                                edMotivo.Text, straux);
                            AbreGaveta;
                        end;
                        FreeLibrary(hand);
                        Close;
                    end;
                idno:
                    begin
                        FreeLibrary(hand);
                        Close;
                    end;
            end;
        end
        else
            FreeLibrary(hand);
    end;
end;

procedure TfrmSangria.lbFormaPagamentosKeyDown(Sender: TObject;
    var Key: Word; Shift: TShiftState);
begin
    if key = vk_return then
        mskValor.SetFocus;
end;

procedure TfrmSangria.edMotivoKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    if key = VK_RETURN then
    begin
        mskValor.OnExit(mskValor);
        spdConfirma.Click;
    end;
end;

end.

//******************************************************************************
//*                          End of File uSangria.pas
//******************************************************************************

