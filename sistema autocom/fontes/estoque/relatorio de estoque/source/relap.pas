unit relap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QRCtrls, QuickRpt, ExtCtrls, Inifiles;

type
  TFrmRelAp = class(TForm)
    QrRel: TQuickRep;
    QRBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRSysData1: TQRSysData;
    QRSysData2: TQRSysData;
    QRLabel2: TQRLabel;
    DescRel: TQRLabel;
    QRBand3: TQRBand;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText8: TQRDBText;
    QRBand4: TQRBand;
    QRLabel4: TQRLabel;
    QRLabel5: TQRLabel;
    QRLabel10: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel6: TQRLabel;
    QRLabel7: TQRLabel;
    QRDBText3: TQRDBText;
    QRLabel8: TQRLabel;
    procedure QRLabel7Print(sender: TObject; var Value: String);
    procedure DescRelPrint(sender: TObject; var Value: String);
    procedure QRBand3BeforePrint(Sender: TQRCustomBand;
      var PrintBand: Boolean);
    procedure QrRelBeforePrint(Sender: TCustomQuickRep;
      var PrintReport: Boolean);
    procedure QRLabel8Print(sender: TObject; var Value: String);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRelAp: TFrmRelAp;
  soma_total:real;

implementation

uses main, module;

{$R *.dfm}

procedure TFrmRelAp.QRLabel7Print(sender: TObject; var Value: String);
var ini:Tinifile;
begin
  ini := TIniFile.Create(Path + 'Autocom.ini');
  value := Ini.Readstring('ESTOQUE','NomeTipoLote','');
  Ini.Free;

end;

procedure TFrmRelAp.DescRelPrint(sender: TObject; var Value: String);
var
  S_Descricao: String;
begin
  S_Descricao := 'TODOS OS PRODUTOS';
  if Trim(FrmMain.S_Where1) <> '' then S_Descricao := S_Descricao +  ', DA SE??O ' + Dm.Tbl_RelatorioDESCRICAO.AsString ;
  if Trim(FrmMain.S_Where2) <> '' then S_Descricao := S_Descricao +  ', DA PRATELEIRA ' + Dm.Tbl_RelatorioCODIGOPRATELEIRA.AsString;
  if Trim(FrmMain.S_Where3) <> '' then S_Descricao := S_Descricao +  ', DO GRUPO ' + Dm.Tbl_RelatorioGRUPOPRODUTO.AsString;
  if Trim(FrmMain.S_Where4) <> '' then S_Descricao := S_Descricao +  ', DO SUB-GRUPO ' + Dm.Tbl_RelatorioSUBGRUPO.AsString;
  Value := S_Descricao;
end;

procedure TFrmRelAp.QRBand3BeforePrint(Sender: TQRCustomBand;
  var PrintBand: Boolean);
begin
     if (Dm.Tbl_RelatorioUsual.asstring='1') and (Dm.Tbl_RelatorioLote.asstring='')  then PrintBand:=false;
     if (Dm.Tbl_RelatorioUsual.asstring='1') and (Dm.Tbl_RelatorioLote.asstring<>'') then PrintBand:=true;
     if PrintBand=true then
        begin
           soma_total:=soma_total+Dm.Tbl_RelatorioEstoqueatual.asfloat;
        end;
end;

procedure TFrmRelAp.QrRelBeforePrint(Sender: TCustomQuickRep;
  var PrintReport: Boolean);
begin
     soma_total:=0;
end;

procedure TFrmRelAp.QRLabel8Print(sender: TObject; var Value: String);
begin
     Value:='Total de produtos: '+floattostr(soma_total);
end;

end.
