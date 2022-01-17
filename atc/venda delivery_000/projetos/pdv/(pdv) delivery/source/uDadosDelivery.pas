//******************************************************************************
// 
//                 UNIT UDADOSDELIVERY (-)
// 
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           uDadosDelivery.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: uDadosDelivery.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:      
// 
// 1.0.0 01/01/2001 First Version
// 
//******************************************************************************

unit uDadosDelivery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ExtCtrls, db;

type
  TfrmDadosDelivery = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    btnConfirma: TBitBtn;
    memObs: TMemo;
    mskTaxaServico: TEdit;
    procedure btnConfirmaClick(Sender: TObject);
    procedure mskTaxaServicoKeyPress(Sender: TObject; var Key: Char);
    procedure mskTaxaServicoExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure memObsExit(Sender: TObject);
    procedure memObsEnter(Sender: TObject);
  private
    FNumeroPedido: string;
    procedure SetNumeroPedido(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    property NumeroPedido:string read FNumeroPedido write SetNumeroPedido;
  end;

var
  frmDadosDelivery: TfrmDadosDelivery;

implementation
uses uRotinas, udmPdv;
{$R *.dfm}

procedure TfrmDadosDelivery.btnConfirmaClick(Sender: TObject);
var auxDataset:TDataSet;
begin
     dmorc.Commit;
     dmORC.RunSQL('SELECT *  FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' + NumeroPedido, auxDataset);
     if (StrToIntDef(LeINI(TIPO_TERMINAL,'servico_per'), 0) > 0) and (strtofloatdef(LeINI(TIPO_TERMINAL,'usa_servico'),0) = 1) then
         mskTaxaServico.Text := dmORC.CalculaAcrescimo(auxDataset.FieldByName('TOTALPEDIDO').AsString ,mskTaxaServico.Text);
     freeAndNil(auxDataset);
     dmorc.RunSQL(StringReplace( 'UPDATE PEDIDOVENDA SET '+
                   'DESPESASACESSORIAS = ' + mskTaxaServico.Text , ',','.', []) + ', ' +
                   'OBSERVACAO         = ' + QuotedStr(memObs.Text) +
                   'WHERE NUMEROPEDIDO = ' + QuotedStr(NumeroPedido)
                   );
     dmORC.Commit;
     Close;
end;

procedure TfrmDadosDelivery.mskTaxaServicoKeyPress(Sender: TObject;
  var Key: Char);
begin
     //prefiro fazer o controle dessa forma. Charles.
     if key = '.' then
        key := ',';
     if not (key in ['0'..'9',#8,DecimalSeparator]) then
        key := #0;
     if (key = DecimalSeparator) and (Pos(DecimalSeparator,(Sender as TCustomEdit).Text) > 0) and
        (Length((Sender as TCustomEdit).Text) <> Length((Sender as TCustomEdit).SelText)) then
        key := #0;
end;

procedure TfrmDadosDelivery.mskTaxaServicoExit(Sender: TObject);
begin
     //Formata a quantidade.
     (Sender as TCustomEdit).Text := FormatFloat('0.00',StrToFloatDef((Sender as TCustomEdit).Text,0));
end;

procedure TfrmDadosDelivery.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case key of
          VK_RETURN,VK_DOWN: Perform(WM_NEXTDLGCTL,0,0);
          VK_UP: Perform(WM_NEXTDLGCTL,1,0);
     end;
end;

procedure TfrmDadosDelivery.FormCreate(Sender: TObject);
begin
     if LeINI('terminal','servico_val') > 0 then
     begin
           label2.Caption := 'Taxa de serviço (' + CurrencyString +'):';
           mskTaxaServico.Text := FormatFloat('0.00', StrToFloatDef(LeINI(tipo_terminal,'servico_val'),0) / 100);
     end
        else
        begin
           label2.Caption := 'Taxa de serviço (%):';
           mskTaxaServico.Text := FormatFloat('0.00', StrToFloatDef(LeINI(tipo_terminal,'servico_per'),0) /100);
        end;
end;

procedure TfrmDadosDelivery.memObsExit(Sender: TObject);
begin
//     KeyPreview := True;
end;

procedure TfrmDadosDelivery.memObsEnter(Sender: TObject);
begin
//     KeyPreview :=False;
end;

procedure TfrmDadosDelivery.SetNumeroPedido(const Value: string);
var auxdataset:TDataSet;
begin
     FNumeroPedido := Value;
     auxdataset := dmORC.ConsultaPedido(Value);
     if auxdataset.FieldByName('DESPESASACESSORIAS').AsFloat > 0 THEN
     begin
        if strtointdef(LeINI(tipo_terminal,'servico_per'),0) > 0 then
           mskTaxaServico.Text := Formatfloat('0.00',auxdataset.FieldByName('TOTALPRODUTOS').AsFloat / auxdataset.FieldByName('DESPESASACESSORIAS').AsFloat)
           else
               mskTaxaServico.Text := Formatfloat('0.00',auxdataset.FieldByName('DESPESASACESSORIAS').AsFloat);
     end;
     memObs.Text := auxdataset.FieldByName('OBSERVACAO').Text;
     freeandnil(auxdataset);
end;

end.

//******************************************************************************
//*                          End of File uDadosDelivery.pas
//******************************************************************************
