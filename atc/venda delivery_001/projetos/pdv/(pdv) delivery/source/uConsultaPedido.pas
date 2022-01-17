//******************************************************************************
// 
//                 UNIT UCONSULTAPEDIDO (-)
// 
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           uConsultaPedido.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: uConsultaPedido.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:      
// 
// 1.0.0 01/01/2001 First Version
// 
//******************************************************************************

unit uConsultaPedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, ExtCtrls,uConsultaPadrao;

type
  TfrmConsultaPedido = class(TfrmConsultaPadrao)
    Panel1: TPanel;
    Label6: TLabel;
    edConsulta: TEdit;
    Panel3: TPanel;
    dbgrProdutos: TDBGrid;
    dsPedidos: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure dbgrProdutosDblClick(Sender: TObject);
    procedure dbgrProdutosEnter(Sender: TObject);
    procedure dbgrProdutosExit(Sender: TObject);
    procedure dbgrProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgrProdutosDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    qryPedido:TDataSet;
  end;

var
  frmConsultaPedido: TfrmConsultaPedido;

implementation

uses udmPDV, uRotinas, Math;

{$R *.dfm}

procedure TfrmConsultaPedido.FormCreate(Sender: TObject);
begin
   QryPedido := dmorc.BuscaListaPedido(LeINI(TIPO_TERMINAL,'codigo_origem'));
   dsPedidos.DataSet := qryPedido;
   dbgrProdutos.Columns[dbgrProdutos.Columns.Count - 1].Visible := False;
   dbgrProdutos.Columns[0].Title.Caption := AnsiUppercase(LeINI(TIPO_TERMINAL, 'LEGENDA'));
end;

procedure TfrmConsultaPedido.dbgrProdutosDblClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmConsultaPedido.dbgrProdutosEnter(Sender: TObject);
begin
     KeyPreview := false;
end;

procedure TfrmConsultaPedido.dbgrProdutosExit(Sender: TObject);
begin
     KeyPreview := True;
end;

procedure TfrmConsultaPedido.dbgrProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if key = VK_RETURN then
     Close;
  if key = vk_escape then
  begin
       Self.Tag := 1;
       Close;
  end;
end;

procedure TfrmConsultaPedido.dbgrProdutosDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  if qryPedido.FieldByName('situacao').AsString = 'Z' then
  begin
       dbgrProdutos.Canvas.Brush.Color := clRed;
       dbgrProdutos.Canvas.Font.Color  := clYellow;
  end;
  dbgrProdutos.DefaultDrawColumnCell(Rect, DataCol, Column, State);;
end;

end.

//******************************************************************************
//*                          End of File uConsultaPedido.pas
//******************************************************************************
