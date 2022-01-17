//******************************************************************************
//
//                 UNIT UDADOSRESTAURANTE (-)
//
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           uDadosRestaurante.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: uDadosRestaurante.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:
//
// 1.0.0 01/01/2001 First Version
//
//******************************************************************************

unit uDadosRestaurante;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    db, uPadrao, StdCtrls, Buttons, Mask, ExtCtrls;

type
    TfrmDadosRestaurante = class(TfrmPadrao)
        Panel1: TPanel;
        Label1: TLabel;
        Label2: TLabel;
        mskPessoas: TMaskEdit;
        mskTaxaServico: TMaskEdit;
        bitConfirma: TBitBtn;
        bitCancela: TBitBtn;
        procedure mskTaxaServicoKeyPress(Sender: TObject; var Key: Char);
        procedure FormCreate(Sender: TObject);
        procedure mskTaxaServicoExit(Sender: TObject);
        procedure bitConfirmaClick(Sender: TObject);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure bitCancelaClick(Sender: TObject);
        procedure mskPessoasExit(Sender: TObject);
        procedure FormKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
    private
        FNumeroPedido: string;
        procedure SetNumeroPedido(const Value: string);
        { Private declarations }
    public
        { Public declarations }
        property NumeroPedido: string read FNumeroPedido write SetNumeroPedido;
    end;

var
    frmDadosRestaurante: TfrmDadosRestaurante;

implementation
uses uRotinas, udmPDV, Math, StrUtils;
{$R *.dfm}

procedure TfrmDadosRestaurante.mskTaxaServicoKeyPress(Sender: TObject;
    var Key: Char);
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

procedure TfrmDadosRestaurante.FormCreate(Sender: TObject);
begin
    if strtointdef(LeINI('terminal', 'servico_val'), 0) > 0 then
    begin
        label2.Caption := 'Taxa de serviço (' + CurrencyString + '):';
        mskTaxaServico.Text := FormatFloat('0.00', LeINI('terminal',
            'servico_val')
            / 100);
    end
    else
    begin
        label2.Caption := 'Taxa de serviço (%):';
        mskTaxaServico.Text := FormatFloat('0.00', LeINI('terminal',
            'servico_per')
            / 100);
    end;
end;

procedure TfrmDadosRestaurante.mskTaxaServicoExit(Sender: TObject);
begin
    //Formata a quantidade.
    (Sender as TCustomEdit).Text := FormatFloat('0.00', StrToFloatDef((Sender as
        TCustomEdit).Text, 0));
end;

procedure TfrmDadosRestaurante.bitConfirmaClick(Sender: TObject);
var
    auxdataset: TDataSet;
    bAtuData: Boolean;
begin
    auxdataset := dmORC.ConsultaPedido(NumeroPedido);
    if StrToIntDef(mskPessoas.Text, 0) > 0 then
    begin
        bAtuData := not (auxdataset.FieldByName('situacao').AsString = 'Z');
        if StrToIntDef(LeINI('TERMINAL', 'servico_per'), 0) > 0 then
            mskTaxaServico.Text :=
                dmORC.CalculaAcrescimo(auxDataset.FieldByName('TOTALPRODUTOS').AsString,
                mskTaxaServico.Text);
        FreeAndNil(auxDataset);
        dmorc.RunSQL('UPDATE PEDIDOVENDA SET ' +
            IfThen(bAtuData, 'DATA               = ' +
            quotedstr(FormatDateTime('mm/dd/yyyy hh:nn:ss', now)) + ', ', '') +
            'DESPESASACESSORIAS = ' + StringReplace(mskTaxaServico.Text, ',',
                '.', [])
            + ', ' +
            'NUMPESSOAS         = ' + mskPessoas.Text + ', ' +
            'SITUACAO           = ' + QuotedStr('Z') +
            'WHERE NUMEROPEDIDO = ' + NumeroPedido);
        dmorc.Commit;
        Close;
    end
    else
    begin
        Application.MessageBox('Quantidade de pessoas inválida.',
            TITULO_MENSAGEM,
            MB_OK + MB_ICONERROR);
        mskPessoas.SetFocus;
    end;
end;

procedure TfrmDadosRestaurante.FormCloseQuery(Sender: TObject;
    var CanClose: Boolean);
begin
    if Self.Tag = 1 then
        ModalResult := mrCancel
    else
        ModalResult := mrOk;
end;

procedure TfrmDadosRestaurante.bitCancelaClick(Sender: TObject);
begin
    Self.Tag := 1;
    Close;
end;

procedure TfrmDadosRestaurante.mskPessoasExit(Sender: TObject);
begin
    (Sender as TMaskEdit).Text := FormatFloat('0000', StrToFloatDef((Sender as
        TMaskEdit).Text, 0));
end;

procedure TfrmDadosRestaurante.SetNumeroPedido(const Value: string);
var
    auxDataset: TDataSet;
begin
    FNumeroPedido := Value;
    auxDataset := dmORC.ConsultaPedido(Value);
    if auxDataset.FieldByName('NUMPESSOAS').AsInteger > 0 then
        mskPessoas.Text := auxDataset.FieldByName('NUMPESSOAS').AsString
    else
        mskPessoas.Text := '1';
    FreeAndNil(auxdataset);
end;

procedure TfrmDadosRestaurante.FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    if key = vk_escape then
        self.Tag := 1;
    inherited;
end;

end.
//******************************************************************************
//*                          End of File uDadosRestaurante.pas
//******************************************************************************
