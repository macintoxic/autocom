//******************************************************************************
//
//                 UNIT UFUNDOCAIXA (-)
//
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           uFundoCaixa.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: uFundoCaixa.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:
//
// 1.0.0 01/01/2001 First Version
//
//******************************************************************************

unit uFundoCaixa;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, Buttons, StdCtrls, Mask, ExtCtrls;

type
    TfrmFundoCaixa = class(TForm)
        Panel1: TPanel;
        Panel2: TPanel;
        Label8: TLabel;
        Label9: TLabel;
        mskValor: TMaskEdit;
        spdVolta: TSpeedButton;
        spdConfirma: TSpeedButton;
        procedure mskValorKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure spdConfirmaClick(Sender: TObject);
        procedure FormKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure mskValorKeyPress(Sender: TObject; var Key: Char);
        procedure mskValorEnter(Sender: TObject);
        procedure spdVoltaClick(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    frmFundoCaixa: TfrmFundoCaixa;

implementation
uses
    uRotinas;
{$R *.dfm}

procedure TfrmFundoCaixa.mskValorKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    if key = vk_return then
        spdConfirma.Click;
    if key = VK_ESCAPE then
        spdVolta.click;
end;

procedure TfrmFundoCaixa.spdConfirmaClick(Sender: TObject);
var
    FundoCaixa: FFCX;
    COO: FCOO;
    strAux: string;
    hand: THandle;
    i: Integer;
begin
    if StrToFloatDef(mskValor.Text, 0) > (StrToFloat(LeINI('terminal',
        'limitefcx')) / 100) then
        Application.MessageBox('Limite de fundo de caixa ultrapassado.',
            TITULO_MENSAGEM, MB_OK + MB_ICONERROR)
    else
    begin
        strAux := LeINI('modulos', 'dll_ECF');
        hand := LoadLibrary(PChar(straux));
        @FundoCaixa := GetProcAddress(hand, 'FCX');
        if Assigned(FundoCaixa) then
        begin
            case Application.MessageBox(Pchar('Confirma a entrada de ' +
                CurrencyString
                + mskValor.text + ' no caixa?'),
                TITULO_MENSAGEM, MB_OK + MB_YESNOCANCEL + MB_ICONQUESTION) of
                idyes:
                    begin
                        straux := fundocaixa(strtoint(leini('terminal',
                            'ModECF')),
                            strtoint(leini('terminal', 'comECF')),
                            '1',
                            mskValor.Text);
                        if straux[1] = '#' then
                            Application.MessageBox(Pchar('Ocorreu um erro durante o envio do comando para a impressora'#13 +
                                'Erro: ' + Copy(strAux, 2, Length(straux))),
                                    TITULO_MENSAGEM,
                                MB_ICONERROR + MB_OK)
                        else
                        begin
                            @COO := GetProcAddress(hand, 'COO');

                            straux := COO(StrToInt(leini('terminal', 'ModECF')),
                                StrToInt(leini('terminal', 'comECF')), '1');
                            i := 0;
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

                            GravaMovimentoExtra(StrToFloat(mskValor.Text), '1',
                                '', strAux);
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

procedure TfrmFundoCaixa.FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    if Key = VK_RETURN then
        mskValor.Text := FormatFloat('0.00', StrToFloatDef(mskValor.Text, 0));
end;

procedure TfrmFundoCaixa.mskValorKeyPress(Sender: TObject; var Key: Char);
begin
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

procedure TfrmFundoCaixa.mskValorEnter(Sender: TObject);
begin
    mskValor.SelectAll;
end;

procedure TfrmFundoCaixa.spdVoltaClick(Sender: TObject);
begin
    Close;
end;

end.

//******************************************************************************
//*                          End of File uFundoCaixa.pas
//******************************************************************************
