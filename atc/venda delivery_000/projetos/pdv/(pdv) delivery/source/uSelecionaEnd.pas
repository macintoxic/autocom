//******************************************************************************
// 
//                 UNIT USELECIONAEND (-)
// 
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           uSelecionaEnd.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: uSelecionaEnd.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:      
// 
// 1.0.0 01/01/2001 First Version
// 
//******************************************************************************

unit uSelecionaEnd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, db, Buttons,  QuickRpt, QRCtrls;

type
  TfrmEnderecos = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    lblCliente: TLabel;
    gbFaturamento: TGroupBox;
    Label3: TLabel;
    cbFaturamento: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    lblEndereco: TLabel;
    lblBairro: TLabel;
    lblCep: TLabel;
    lblESTADO: TLabel;
    lblFone: TLabel;
    lblCel: TLabel;
    lblFax: TLabel;
    SpeedButton2: TSpeedButton;
    gbCobranca: TGroupBox;
    Label2: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    lblEnderecoCobranca: TLabel;
    lblBairroCobranca: TLabel;
    lblCEPCObranca: TLabel;
    lblEstadoCobranca: TLabel;
    lblFoneCobranca: TLabel;
    lblCelCobranca: TLabel;
    lblFaxCobranca: TLabel;
    SpeedButton3: TSpeedButton;
    cbCobranca: TComboBox;
    gbEntrega: TGroupBox;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    lblEnderecoEntrega: TLabel;
    lblBairroEntrega: TLabel;
    lblCEPEntrega: TLabel;
    lblUEstadoEntrega: TLabel;
    lblFoneEntrega: TLabel;
    lblCelEntrega: TLabel;
    lblFAXEntrega: TLabel;
    SpeedButton5: TSpeedButton;
    cbEntrega: TComboBox;
    spImprime: TSpeedButton;
    procedure cbFaturamentoChange(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure spImprimeClick(Sender: TObject);
  private
    FPedido: string;
    auxDataSet:TDataSet;

    procedure SetPedido(const Value: string);
    procedure AjustaEnd(gbGrupo:TGroupBox; auxDataSet:TDataSet);
    procedure AjustaBands(band: TQRChildBand;auxDataSet: TDataSet;TipoEndereco:String);
    { Private declarations }
  public
    { Public declarations }
    dsFormaPagamento:^TDataSet;
    property Pedido:string read FPedido write SetPedido;
  end;

var
  frmEnderecos: TfrmEnderecos;

implementation
uses udmPDV, Math, uAutorizaFaturamento, uRotinas;
{$R *.dfm}

{ TfrmEnderecos }

procedure TfrmEnderecos.SetPedido(const Value: string);
var
   strAux:string;
   i:Integer;
begin
     auxDataSet :=  dmORC.ConsultaPedido(Value);
     strAux := auxDataSet.FieldByName('cli_codcliente').AsString;
     FreeAndNil(auxdataset);
     auxdataset := dmORC.ConsultaCliente(strAux);
     auxDataSet.First;
     lblCliente.Caption := auxDataSet.FieldByName('NOME').AsString;
     while not auxDataSet.Eof do
     begin
          for i := 0 to ComponentCount - 1  do
             if Components[i] is TComboBox then
                  (Components[i] as TComboBox).Items.Add(auxDataSet.FieldByName('TIPO_ENDERECO').AsString);
          auxDataSet.Next;
     end;
     FPedido := Value;
end;

procedure TfrmEnderecos.cbFaturamentoChange(Sender: TObject);
var i :Integer;
begin
     if auxDataSet.Locate('TIPO_ENDERECO',(Sender as TComboBox).Text,[]) then
        AjustaEnd(((Sender as TComboBox).Parent as TGroupBox),auxDataSet)
        else
             with ((Sender as TComboBox).Parent as TGroupBox) do
             begin
                  for i := 0 to ControlCount - 1 do
                  begin
                       if (Controls[i] is TLabel) and (Controls[i].Tag <> -1) then
                          (Controls[i] as TLabel).Caption := ' - ';
                       if Controls[i] is TComboBox then
                          (Controls[i] as TComboBox).Text := ' ';
                  end;
             end;
end;

procedure TfrmEnderecos.AjustaEnd(gbGrupo: TGroupBox; auxDataSet:TDataSet);
var
   i, j:Integer;
begin
     for i := 0 to gbGrupo.ControlCount - 1 do
          for j := 0 to auxDataSet.FieldCount - 1 do
          if Pos(UpperCase(auxDataSet.Fields[j].FieldName),uppercase(gbGrupo.Controls[i].Name)) > 0 then
             (gbGrupo.Controls[i] as TLabel).Caption := auxDataSet.Fields[j].AsString;
end;

procedure TfrmEnderecos.SpeedButton2Click(Sender: TObject);
var
   i:Integer;
begin
     with ((Sender as TSpeedButton).Parent as TGroupBox) do
     begin
          for i := 0 to ControlCount - 1 do
          begin
               if (Controls[i] is TLabel) and (Controls[i].Tag <> -1) then
                  (Controls[i] as TLabel).Caption := ' - ';
               if Controls[i] is TComboBox then
                  (Controls[i] as TComboBox).Text := ' ';
          end;
     end;
end;

procedure TfrmEnderecos.spImprimeClick(Sender: TObject);
begin
     spImprime.Enabled := False;
      if cbFaturamento.Text = '' then
      begin
         Application.MessageBox('Selecione o endereço de faturamento.', TITULO_MENSAGEM, MB_OK + MB_ICONEXCLAMATION);
         cbFaturamento.SetFocus;
         spImprime.Enabled := True;
      end
      else
      begin
            qrAutorizacao := TqrAutorizacao.Create(self);
            AjustaBands(qrAutorizacao.qrChildFaturamento,auxDataSet, cbFaturamento.Text);

            if (cbCobranca.Text = '') or (cbCobranca.Text = cbFaturamento.Text) then
               qrAutorizacao.qrCobranca.Enabled := False;

            if (cbEntrega.Text = '') or (cbEntrega.Text = cbCobranca.Text) or
               (cbEntrega.Text = cbFaturamento.Text) then
               qrAutorizacao.qrentrega.Enabled := False;

            AjustaBands(qrAutorizacao.qrCobranca,auxDataSet,cbCobranca.Text);
            AjustaBands(qrAutorizacao.qrEntrega,auxDataSet,cbFaturamento.Text);
            qrAutorizacao.dsFormaPagamento := @dsFormaPagamento^;
            qrAutorizacao.Pedido := Pedido;
            Self.Hide;
            qrAutorizacao.PreviewModal;
            FreeAndNil(qrAutorizacao);
            Close;
      end;
end;

procedure TfrmEnderecos.AjustaBands(band: TQRChildBand;
  auxDataSet: TDataSet;TipoEndereco:String);
var
   i, j:Integer;
begin
     auxDataSet.Locate('TIPO_ENDERECO', TipoEndereco, []);
     for i := 0 to band.ControlCount - 1 do
          for j := 0 to auxDataSet.FieldCount - 1 do
          if Pos(UpperCase(auxDataSet.Fields[j].FieldName),uppercase(band.Controls[i].Name)) > 0 then
             (band.Controls[i] as TQRLabel).Caption := auxDataSet.Fields[j].AsString;
end;

end.
 
//******************************************************************************
//*                          End of File uSelecionaEnd.pas
//******************************************************************************
