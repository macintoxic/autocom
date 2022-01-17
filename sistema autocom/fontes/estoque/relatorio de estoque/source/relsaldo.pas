unit relsaldo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, StdCtrls, Inifiles;

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
    QRLabel9: TQRLabel;
    QRDBText7: TQRDBText;
    QRLabel10: TQRLabel;
    QRDBText8: TQRDBText;
    DescRel: TQRLabel;
    QRLabel12: TQRLabel;
    QRDBText10: TQRDBText;
    QRLabel13: TQRLabel;
    procedure DescRelPrint(sender: TObject; var Value: String);
    procedure QRLabel12Print(sender: TObject; var Value: String);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QRDBText10Print(sender: TObject; var Value: String);
    procedure QrRelBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRLabel13Print(sender: TObject; var Value: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelSaldo: TFrmRelSaldo;
  soma_total:real;

implementation

uses module, main;

{$R *.dfm}

procedure TFrmRelSaldo.DescRelPrint(sender: TObject; var Value: String);
var
  S_Descricao: String;
begin
  S_Descricao := 'TODOS OS PRODUTOS';
  if Trim(FrmMain.S_Where1) <> '' then S_Descricao := S_Descricao +  ', DA SEÇÃO ' + Dm.Tbl_RelatorioDESCRICAO.AsString ;
  if Trim(FrmMain.S_Where2) <> '' then S_Descricao := S_Descricao +  ', DA PRATELEIRA ' + Dm.Tbl_RelatorioCODIGOPRATELEIRA.AsString;
  if Trim(FrmMain.S_Where3) <> '' then S_Descricao := S_Descricao +  ', DO GRUPO ' + Dm.Tbl_RelatorioGRUPOPRODUTO.AsString;
  if Trim(FrmMain.S_Where4) <> '' then S_Descricao := S_Descricao +  ', DO SUB-GRUPO ' + Dm.Tbl_RelatorioSUBGRUPO.AsString;
  Value := S_Descricao;
end;

procedure TFrmRelSaldo.QRLabel12Print(sender: TObject; var Value: String);
Var ini:Tinifile;
begin
     if (Dm.Tbl_RelatorioUsual.asstring='1') then
        begin
           ini := TIniFile.Create(Path + 'Autocom.ini');
           value := Ini.Readstring('ESTOQUE','NomeTipoLote','');
           Ini.Free;
        end
     else value:='';
end;

procedure TFrmRelSaldo.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     if (Dm.Tbl_RelatorioUsual.asstring='1') and (Dm.Tbl_RelatorioLote.asstring='')  then PrintBand:=false;
     if (Dm.Tbl_RelatorioUsual.asstring='1') and (Dm.Tbl_RelatorioLote.asstring<>'') then PrintBand:=true;
     if PrintBand=true then
        begin
           soma_total:=soma_total+Dm.Tbl_RelatorioEstoqueatual.asfloat;
        end;
end;

procedure TFrmRelSaldo.QRDBText10Print(sender: TObject; var Value: String);
begin
     if (Dm.Tbl_RelatorioUsual.asstring<>'1') then value:='';

end;

procedure TFrmRelSaldo.QrRelBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
     soma_total:=0;
end;

procedure TFrmRelSaldo.QRLabel13Print(sender: TObject; var Value: String);
begin
     Value:='Total de produtos: '+floattostr(soma_total);
end;

end.
