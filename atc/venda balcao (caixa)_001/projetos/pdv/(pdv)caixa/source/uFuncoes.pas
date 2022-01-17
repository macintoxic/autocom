//******************************************************************************
//
//                 UNIT UFUNCOES (-)
//
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           uFuncoes.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: uFuncoes.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:
//
// 1.0.0 01/01/2001 First Version
//
//******************************************************************************

unit uFuncoes;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Controls, Buttons,
    ExtCtrls, forms;

type
    TfrmFuncoes = class(TForm)
        Panel1: TPanel;
        spdFLX: TSpeedButton;
        spdCancCupon: TSpeedButton;
        spdZ: TSpeedButton;
        spdFundo: TSpeedButton;
        spdSangria: TSpeedButton;
        spdConsultaProduto: TSpeedButton;
        spdAbreGaveta: TSpeedButton;
        spdTransferencia: TSpeedButton;
        spdSair: TSpeedButton;
        spdVolta: TSpeedButton;
        procedure spdFundoClick(Sender: TObject);
        procedure spdSangriaClick(Sender: TObject);
        procedure spdVoltaClick(Sender: TObject);
        procedure FormKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure spdSairClick(Sender: TObject);
        procedure spdCancCuponClick(Sender: TObject);
        procedure spdFLXClick(Sender: TObject);
        procedure spdConsultaProdutoClick(Sender: TObject);
        procedure spdZClick(Sender: TObject);
        procedure spdTransferenciaClick(Sender: TObject);
        procedure spdAbreGavetaClick(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    frmFuncoes: TfrmFuncoes;

implementation
uses uRotinas, uFundoCaixa, uSangria, uBuscaProduto, Math, uTransferencia,
    uOrcamento;

{$R *.dfm}

procedure TfrmFuncoes.spdFundoClick(Sender: TObject);
begin
    frmFundocaixa := TfrmFundoCaixa.Create(self);
    frmFundocaixa.ShowModal;
    freeandnil(frmFundocaixa);
end;

procedure TfrmFuncoes.spdSangriaClick(Sender: TObject);
begin
    frmSangria := TfrmSangria.Create(self);
    frmSangria.ShowModal;
    FreeAndNil(frmSangria);
end;

procedure TfrmFuncoes.spdVoltaClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmFuncoes.FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    case key of
        VK_F1: if  spdFLX.Enabled then spdFLX.Click;
        VK_F2: if  spdCancCupon.Enabled then spdCancCupon.Click;
        VK_F3: if  spdZ.Enabled then spdZ.Click;
        VK_F4: if  spdFundo.Enabled then spdFundo.Click;
        VK_F5: if  spdSangria.Enabled then spdSangria.Click;
        VK_F6: if  spdConsultaProduto.Enabled then spdConsultaProduto.Click;
        VK_F7: if  spdAbreGaveta.Enabled then spdAbreGaveta.Click;
        VK_F8: if  spdTransferencia.Enabled then spdTransferencia.Click;
        VK_F12: if  spdSair.Enabled then spdSair.Click;
        VK_ESCAPE: if  spdVolta.Enabled then spdVolta.Click;
    end;
end;

procedure TfrmFuncoes.spdSairClick(Sender: TObject);
begin
    if Application.messagebox('Confirma a saída do módulo?', TITULO_MENSAGEM,
        MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
        PostMessage(frmPDV.Handle, WM_SYSCOMMAND, SC_CLOSE, SC_CLOSE);
        Close;
    end;
end;

procedure TfrmFuncoes.spdCancCuponClick(Sender: TObject);
var
    hand: THandle;
    cancelacupom: FCancelacupom;
    vendaLiquida: FVenda_liquida;
    strAux: string;
begin
    if Application.MessageBox('Confirma o cancelamento da última venda?',
        TITULO_MENSAGEM, MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
        strAux := ExtractFilePath(Application.ExeName) + LeINI('modulos',
            'dll_ECF');
        hand := LoadLibrary(PChar(straux));
        @cancelacupom := GetProcAddress(hand, 'Cancelacupom');
        @vendaLiquida := GetProcAddress(hand, 'Venda_liquida');
        case cancelacupom(StrToInt(leini('terminal', 'ModECF')),
            StrToInt(leini('terminal', 'comECF')),
            '0', vendaLiquida(StrToInt(leini('terminal', 'ModECF')),
            StrToInt(leini('terminal', 'comECF'))))[1] of
            '#':
                Application.MessageBox(Pchar('Ocorreu um erro durante o envio do comando para a impressora'#13 +
                    'Erro: ' + Copy(strAux, 2, Length(straux))),
                        TITULO_MENSAGEM,
                    MB_ICONERROR + MB_OK);
            '@': GravaCancelamentoVenda(leini(TIPO_TERMINAL, 'ultimocupom'));
        end;
        FreeLibrary(hand);
    end;
end;

procedure TfrmFuncoes.spdFLXClick(Sender: TObject);
var
    LX: FLeituraX;
    hand: THandle;
    straux: string;
begin
    if Application.messagebox('Confirma a impressão da leitura X?',
        TITULO_MENSAGEM, MB_YESNO + MB_ICONQUESTION) = IDYES then
    begin
        strAux := ExtractFilePath(Application.ExeName) + LeINI('modulos',
            'dll_ECF');
        hand := LoadLibrary(PChar(straux));
        @LX := GetProcAddress(hand, 'LeituraX');
        strAux := LX(StrToInt(leini('terminal', 'ModECF')),
            StrToInt(leini('terminal', 'comECF')), '0');
        if straux[1] = '#' then
            Application.MessageBox(Pchar('Ocorreu um erro durante o envio do comando para a impressora'#13 +
                'Erro: ' + Copy(strAux, 2, Length(straux))), TITULO_MENSAGEM,
                MB_ICONERROR + MB_OK);
        FreeLibrary(hand);
    end;
end;

procedure TfrmFuncoes.spdConsultaProdutoClick(Sender: TObject);
begin
    frmConsultaProduto := TfrmConsultaProduto.Create(self);
    frmConsultaProduto.Tabela := LeINI(TIPO_TERMINAL, 'tabelapreco');
    frmConsultaProduto.ShowModal;
    FreeAndNil(frmConsultaProduto);
end;

procedure TfrmFuncoes.spdZClick(Sender: TObject);
var
    RZ: FFinalizadia;
    hand: THandle;
    straux: string;
begin
    if
        Application.messagebox('A Redução Z é um procedimento sério e pode deixar'#13
        +
        'o caixa **INOPERANTE** pelo resto do dia. Desejas realmente continuar?',
        TITULO_MENSAGEM, MB_YESNO + MB_ICONWARNING) = IDYES then
        if Application.messagebox('Confirma a emissão da Redução Z?',
            TITULO_MENSAGEM, MB_YESNO + MB_ICONQUESTION) = IDYES then
        begin
            strAux := ExtractFilePath(Application.ExeName) + LeINI('modulos',
                'dll_ECF');
            hand := LoadLibrary(PChar(straux));
            @RZ := GetProcAddress(hand, 'Finalizadia');
            strAux := RZ(StrToInt(leini('terminal', 'ModECF')),
                StrToInt(leini('terminal', 'comECF')));
            if straux[1] = '#' then
                Application.MessageBox(Pchar('Ocorreu um erro durante o envio do comando para a impressora'#13 +
                    'Erro: ' + Copy(strAux, 2, Length(straux))),
                        TITULO_MENSAGEM,
                    MB_ICONERROR + MB_OK);
            FreeLibrary(hand);
        end;
end;

procedure TfrmFuncoes.spdTransferenciaClick(Sender: TObject);
begin
    frmTransferencia := TfrmTransferencia.Create(self);
    frmTransferencia.ShowModal;
    FreeAndNil(frmTransferencia);
end;

procedure TfrmFuncoes.spdAbreGavetaClick(Sender: TObject);
begin
    AbreGaveta;
end;

end.
//******************************************************************************
//*                          End of File uFuncoes.pas
//******************************************************************************
