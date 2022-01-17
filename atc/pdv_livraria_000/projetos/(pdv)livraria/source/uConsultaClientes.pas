//******************************************************************************
//
//                 UNIT UCONSULTACLIENTES (-)
//
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           uConsultaClientes.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: uConsultaClientes.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:
//
// 1.0.0 01/01/2001 First Version
//
//******************************************************************************

unit uConsultaClientes;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, DB, Grids, DBGrids, StdCtrls, ExtCtrls, uConsultaPadrao;

type
    TfrmConsultaCliente = class(TfrmConsultaPadrao)
        Panel1: TPanel;
        Label6: TLabel;
        edConsulta: TEdit;
        Panel3: TPanel;
        dbgrProdutos: TDBGrid;
        dsClientess: TDataSource;
        procedure FormCreate(Sender: TObject);
        procedure dbgrProdutosDblClick(Sender: TObject);
        procedure edConsultaKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure dbgrProdutosKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure edConsultaChange(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
        dsCliente: TDataSet;
    end;

var
    frmConsultaCliente: TfrmConsultaCliente;

implementation
uses udmPDV;
{$R *.dfm}

procedure TfrmConsultaCliente.FormCreate(Sender: TObject);
begin
    dsCliente := dmORC.ConsultaListaCliente;
    dsClientess.DataSet := dsCliente;
end;

procedure TfrmConsultaCliente.dbgrProdutosDblClick(Sender: TObject);
begin
    Close;
end;

procedure TfrmConsultaCliente.edConsultaKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    if Key = vk_return then
        dbgrProdutos.SetFocus;
end;

procedure TfrmConsultaCliente.dbgrProdutosKeyDown(Sender: TObject; var Key:
    Word;
    Shift: TShiftState);
begin
    if key = vk_return then
        Close;
end;

procedure TfrmConsultaCliente.edConsultaChange(Sender: TObject);
begin
    if StrToFloatDef(edConsulta.Text, -1) = -1 then
        //procura pela descricao
        dsCliente.Locate('COMPLETO', edConsulta.Text, [loPartialKey])
    else
        dsCliente.Locate('CODIGO', edConsulta.Text, [loPartialKey])
end;

end.

//******************************************************************************
//*                          End of File uConsultaClientes.pas
//******************************************************************************
