//******************************************************************************
//
//                 UNIT UQRFECHAMENTO (-)
//
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           uQrFechamento.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: uQrFechamento.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:
//
// 1.0.0 01/01/2001 First Version
//
//******************************************************************************

unit uQrFechamento;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
    StdCtrls, ExtCtrls, Forms, QuickRpt, QRCtrls, DB;

type
    TqrFechamento = class(TQuickRep)
        QRBand1: TQRBand;
        QRSysData1: TQRSysData;
        QRSysData2: TQRSysData;
        QRLabel1: TQRLabel;
        QRLabel2: TQRLabel;
        QRLabel3: TQRLabel;
        QRLabel4: TQRLabel;
        QRLabel5: TQRLabel;
        QRLabel6: TQRLabel;
        QRLabel7: TQRLabel;
        QRLabel8: TQRLabel;
        QRLabel9: TQRLabel;
        QRBand2: TQRBand;
        qrdbProduto: TQRDBText;
        qrdbDescricao: TQRDBText;
        qrdbQuantidade: TQRDBText;
        qrdbUnitario: TQRDBText;
        qrdbTotal: TQRDBText;
        QRBand3: TQRBand;
        QRLabel10: TQRLabel;
        qrPedido: TQRLabel;
        qrCliente: TQRLabel;
        qrIndicador: TQRLabel;
        QRLabel11: TQRLabel;
        procedure QRLabel4Print(sender: TObject; var Value: string);
        procedure QRLabel2Print(sender: TObject; var Value: string);
        procedure qrdbTotalPrint(sender: TObject; var Value: string);
        procedure QRLabel11Print(sender: TObject; var Value: string);
        procedure QuickRepBeforePrint(Sender: TCustomQuickRep;
            var PrintReport: Boolean);
        procedure QuickRepPreview(Sender: TObject);
    private
        FItems: Pointer;
        totalProdutos: Real;
        procedure SetItems(const Value: Pointer);

    public
        property Items: Pointer read FItems write SetItems;
    end;

var
    qrFechamento: TqrFechamento;

implementation
uses uRotinas, udmPDV;
{$R *.DFM}

{ TqrFechamento }

{ TqrFechamento }

{ TqrFechamento }

procedure TqrFechamento.SetItems(const Value: Pointer);
var
    i: Integer;
begin
    FItems := Value;
    TDataSet(FItems^).First;
    for i := 0 to qrFechamento.QRBand2.ControlCount - 1 do
        (qrFechamento.QRBand2.Controls[i] as TQRDBText).DataSet :=
            TDataSet(FItems^);
end;

procedure TqrFechamento.QRLabel4Print(sender: TObject; var Value: string);
begin
    Value := LeINI(TIPO_TERMINAL, 'indicador');
end;

procedure TqrFechamento.QRLabel2Print(sender: TObject; var Value: string);
begin
    Value := LeINI('Terminal', 'nomeind');
end;

procedure TqrFechamento.qrdbTotalPrint(sender: TObject; var Value: string);
begin
    totalProdutos := totalProdutos + StrToFloat(Value);
end;

procedure TqrFechamento.QRLabel11Print(sender: TObject; var Value: string);
begin
    Value := CurrencyString + FloatToStr(totalProdutos);
end;

procedure TqrFechamento.QuickRepBeforePrint(Sender: TCustomQuickRep;
    var PrintReport: Boolean);
begin
    totalProdutos := 0;
end;

procedure TqrFechamento.QuickRepPreview(Sender: TObject);
begin
    totalProdutos := 0;
end;

end.

//******************************************************************************
//*                          End of File uQrFechamento.pas
//******************************************************************************
