//******************************************************************************
// 
//                 UNIT UBUSCAVENDEDOR (-)
// 
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           uBuscaVendedor.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: uBuscaVendedor.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:      
// 
// 1.0.0 01/01/2001 First Version
// 
//******************************************************************************

unit uBuscaVendedor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, ExtCtrls, uconsultapadrao;

type
  TfrmBuscaVendedor = class(TfrmConsultaPadrao)
    Label1: TLabel;
    Panel1: TPanel;
    Label6: TLabel;
    edConsulta: TEdit;
    Panel3: TPanel;
    dbgrProdutos: TDBGrid;
    dsListaVendedores: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure edConsultaChange(Sender: TObject);
    procedure edConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgrProdutosDblClick(Sender: TObject);
    procedure dbgrProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    auxdataset:TDataSet;
  end;

var
  frmBuscaVendedor: TfrmBuscaVendedor;

implementation
uses udmPDV;
{$R *.dfm}

procedure TfrmBuscaVendedor.FormCreate(Sender: TObject);
begin
   auxdataset :=  dmORC.BuscaListaVendedores;
   dsListaVendedores.DataSet := auxdataset;
end;

procedure TfrmBuscaVendedor.edConsultaChange(Sender: TObject);
begin
     if StrToFloatDef(edConsulta.Text,-1 ) = -1 then
        //procura pela descricao
        auxdataset.Locate('NOME',edConsulta.Text, [loPartialKey])
        else
            auxdataset.Locate('CODIGOVENDEDOR',edConsulta.Text, [loPartialKey])
end;

procedure TfrmBuscaVendedor.edConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     if key = vk_return then
        dbgrProdutos.SetFocus;
end;

procedure TfrmBuscaVendedor.dbgrProdutosDblClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmBuscaVendedor.dbgrProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     if key = VK_RETURN then
        Close;
end;

procedure TfrmBuscaVendedor.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key = VK_ESCAPE then
      Close;
end;

end.
 
//******************************************************************************
//*                          End of File uBuscaVendedor.pas
//******************************************************************************
