unit relsaldo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, StdCtrls;

type
  TFrmRelSaldo = class(TForm)
    QrRel: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel2: TQRLabel;
    QRBand3: TQRBand;
    QRLabel23: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRLabel7: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel20: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel3: TQRLabel;
    QRDBText4: TQRDBText;
    QRDBText6: TQRDBText;
    QRLabel8: TQRLabel;
    QRDBText5: TQRDBText;
    QRLabel11: TQRLabel;
    QRDBText9: TQRDBText;
    QRBand4: TQRBand;
    QRSysData3: TQRSysData;
    QRLabel9: TQRLabel;
    QRDBText7: TQRDBText;
    QRLabel10: TQRLabel;
    QRDBText8: TQRDBText;
    DescRel: TQRLabel;
    procedure DescRelPrint(sender: TObject; var Value: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelSaldo: TFrmRelSaldo;

implementation

uses module, main;

{$R *.dfm}

procedure TFrmRelSaldo.DescRelPrint(sender: TObject; var Value: String);
var
  S_Descricao: String;
begin
  S_Descricao := 'RELATÓRIO REFERENTE A TODOS OS PRODUTOS';
  if Trim(S_Where1) <> '' then S_Descricao := S_Descricao +  ', DA SEÇÃO ' + Dm.Tbl_RelatorioDESCRICAO.AsString ;
  if Trim(S_Where2) <> '' then S_Descricao := S_Descricao +  ', DA PRATELEIRA ' + Dm.Tbl_RelatorioCODIGOPRATELEIRA.AsString;
  if Trim(S_Where3) <> '' then S_Descricao := S_Descricao +  ', DO GRUPO ' + Dm.Tbl_RelatorioGRUPOPRODUTO.AsString;
  if Trim(S_Where4) <> '' then S_Descricao := S_Descricao +  ', DO SUB-GRUPO ' + Dm.Tbl_RelatorioSUBGRUPO.AsString;
  Value := S_Descricao;
end;

end.
