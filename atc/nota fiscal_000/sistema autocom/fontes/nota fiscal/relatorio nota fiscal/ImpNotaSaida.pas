unit ImpNotaSaida;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, QuickRpt, QRCtrls, StdCtrls;

type
  TfrmImpNotaSaida = class(TForm)
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    QRBand3: TQRBand;
    QRBand4: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText3: TQRDBText;
    QRDBText4: TQRDBText;
    QRDBText5: TQRDBText;
    QRDBText6: TQRDBText;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRLabel8: TQRLabel;
    QRLabel9: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel11: TQRLabel;
    QRLabel12: TQRLabel;
    QRLabel13: TQRLabel;
    QRLabel14: TQRLabel;
    QRLabel15: TQRLabel;
    QRLabel16: TQRLabel;
    QRLabel17: TQRLabel;
    QRLabel18: TQRLabel;
    QRLabel19: TQRLabel;
    QRLabel20: TQRLabel;
    QRLabel21: TQRLabel;
    QRLabel22: TQRLabel;
    QRLabel23: TQRLabel;
    QRLabel24: TQRLabel;
    QRNota: TQuickRep;
    QRShape1: TQRShape;
    QRShape2: TQRShape;
    QRShape3: TQRShape;
    QRShape4: TQRShape;
    QRShape5: TQRShape;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    procedure QRBand2BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText2Print(Sender: TObject; var Value: String);
    procedure QRDBText3Print(Sender: TObject; var Value: String);
    procedure QRDBText6Print(Sender: TObject; var Value: String);
    procedure QRNotaBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
    db_ValorCanc: Real;
    db_ValorEmit: Real;
    db_ValorFatu: Real;
    db_QtdeCanc: Real;
    db_QtdeEmit: Real;
    db_QtdeFatu: Real;
  end;

var
  frmImpNotaSaida: TfrmImpNotaSaida;

implementation

uses OpcNota;

{$R *.dfm}

procedure TfrmImpNotaSaida.QRDBText2Print(Sender: TObject; var Value: String);
begin
    Value := frmOpcNota.Enche(frmOpcNota.AllTrim(Value), '0', 1, 8);
end;

procedure TfrmImpNotaSaida.QRDBText3Print(Sender: TObject; var Value: String);
begin
    if (frmOpcNota.AllTrim(Value) = '') or (StrToFloat(frmOpcNota.AllTrim(Value)) <= 0) then
        Value := '-----------------------'
    else
        Value := frmOpcNota.Enche(frmOpcNota.AllTrim(Value), '0', 1, 13);
end;

procedure TfrmImpNotaSaida.QRDBText6Print(Sender: TObject; var Value: String);
begin
    if frmOpcNota.tbl_NFEntrada.FieldByName('CANCELADA').AsString = 'T' then
    begin
        db_QtdeCanc := db_QtdeCanc + 1;
        db_ValorCanc := db_ValorCanc + StrToFloat(Value);
    end
    else
    begin
        if frmOpcNota.tbl_NFEntrada.FieldByName('FATURADO').AsString = 'T' then
        begin
            db_QtdeFatu := db_QtdeFatu + 1;
            db_ValorFatu := db_ValorFatu + StrToFloat(Value);
        end
        else
        begin
            db_QtdeEmit := db_QtdeEmit + 1;
            db_ValorEmit := db_ValorEmit + StrToFloat(Value);
        end;
    end;

    Value := FloatToStrF(StrToFloat(Value), ffnumber, 12, 2);
end;

procedure TfrmImpNotaSaida.QRBand2BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    if frmOpcNota.tbl_NFEntrada.FieldByName('CANCELADA').AsString = 'T' then
    begin
        QRDbText1.Font.Color := clRed;
        QRDbText2.Font.Color := clRed;
        QRDbText3.Font.Color := clRed;
        QRDbText4.Font.Color := clRed;
        QRDbText5.Font.Color := clRed;
        QRDbText6.Font.Color := clRed;
    end
    else
    begin
        if frmOpcNota.tbl_NFEntrada.FieldByName('FATURADO').AsString = 'T' then
        begin
            QRDbText1.Font.Color := clGreen;
            QRDbText2.Font.Color := clGreen;
            QRDbText3.Font.Color := clGreen;
            QRDbText4.Font.Color := clGreen;
            QRDbText5.Font.Color := clGreen;
            QRDbText6.Font.Color := clGreen;
        end
        else
        begin
            QRDbText1.Font.Color := clWindowText;
            QRDbText2.Font.Color := clWindowText;
            QRDbText3.Font.Color := clWindowText;
            QRDbText4.Font.Color := clWindowText;
            QRDbText5.Font.Color := clWindowText;
            QRDbText6.Font.Color := clWindowText;
        end;
    end;
end;

procedure TfrmImpNotaSaida.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
    QRLabel10.Caption := 'Quantidade de Notas Emitidas......: ' + frmOpcNota.Enche(FloatToStr(db_QtdeEmit), '0', 1, Length(FloatToStr(db_QtdeCanc + db_QtdeEmit + db_QtdeFatu)));
    QRLabel13.Caption := 'Quantidade de Notas Canceladas: ' + frmOpcNota.Enche(FloatToStr(db_QtdeCanc), '0', 1, Length(FloatToStr(db_QtdeCanc + db_QtdeEmit + db_QtdeFatu)));
    QRLabel16.Caption := 'Quantidade de Notas Faturadas...: ' + frmOpcNota.Enche(FloatToStr(db_QtdeFatu), '0', 1, Length(FloatToStr(db_QtdeCanc + db_QtdeEmit + db_QtdeFatu)));
    QRLabel19.Caption := 'Quantidade Total de Notas.............: ' + FloatToStr(db_QtdeCanc + db_QtdeEmit + db_QtdeFatu);

    QRLabel21.Alignment := taLeftJustify;
    QRLabel21.Caption := FloatToStrF((db_ValorCanc + db_ValorEmit + db_ValorFatu), ffnumber, 12, 2);
    QRLabel21.Alignment := taRightJustify;

    QRLabel12.Caption := FloatToStrF(db_ValorEmit, ffnumber, 12, 2);
    QRLabel12.Left := QRLabel21.Left;
    QRLabel12.Width := QRLabel21.Width;

    QRLabel15.Caption := FloatToStrF(db_ValorCanc, ffnumber, 12, 2);
    QRLabel15.Left := QRLabel21.Left;
    QRLabel15.Width := QRLabel21.Width;

    QRLabel18.Caption := FloatToStrF(db_ValorFatu, ffnumber, 12, 2);
    QRLabel18.Left := QRLabel21.Left;
    QRLabel18.Width := QRLabel21.Width;
end;

procedure TfrmImpNotaSaida.QRNotaBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
    db_ValorCanc := 0;
    db_ValorEmit := 0;
    db_ValorFatu := 0;
    db_QtdeCanc := 0;
    db_QtdeEmit := 0;
    db_QtdeFatu := 0;
end;

end.
