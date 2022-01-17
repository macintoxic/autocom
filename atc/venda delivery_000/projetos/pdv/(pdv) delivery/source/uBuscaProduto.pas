//******************************************************************************
// 
//                 UNIT UBUSCAPRODUTO (-)
// 
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           uBuscaProduto.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: uBuscaProduto.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:      
// 
// 1.0.0 01/01/2001 First Version
// 
//******************************************************************************

unit uBuscaProduto;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DBCtrls, ExtCtrls, StdCtrls, db, uConsultaPadrao,
  uPadrao;

type
  TfrmConsultaProduto = class(TfrmConsultaPadrao)
    Panel1: TPanel;
    Label6: TLabel;
    edConsulta: TEdit;
    imgProduto: TImage;
    Panel2: TPanel;
    dbtxtPreco: TDBText;
    Label7: TLabel;
    Panel3: TPanel;
    dbgrProdutos: TDBGrid;
    dsListaProdutos: TDataSource;
    procedure edConsultaChange(Sender: TObject);
    procedure dbgrProdutosDblClick(Sender: TObject);
    procedure edConsultaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgrProdutosKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    FTabela: string;
    procedure SetTabela(const Value: string);
    { Private declarations }
  public
    { Public declarations }
    dsListagemProdutos:TDataSet;
    property Tabela:string read FTabela write SetTabela;
  end;

var
  frmConsultaProduto: TfrmConsultaProduto;

implementation
uses
    udmpdv, Math;
{$R *.dfm}

{ TfrmConsultaProduto }

procedure TfrmConsultaProduto.SetTabela(const Value: string);
begin
       dsListagemProdutos := dmORC.BuscaListaProduto(value);
       dsListaProdutos.DataSet := dsListagemProdutos;
       FTabela := Value;
end;

procedure TfrmConsultaProduto.edConsultaChange(Sender: TObject);
begin
     if StrToFloatDef(edConsulta.Text,-1 ) = -1 then
        //procura pela descricao
        dsListagemProdutos.Locate('NOMEPRODUTO',edConsulta.Text, [loPartialKey])
        else
            dsListagemProdutos.Locate('CODIGOPRODUTO',edConsulta.Text, [loPartialKey])
end;

procedure TfrmConsultaProduto.dbgrProdutosDblClick(Sender: TObject);
begin
     Close;
end;

procedure TfrmConsultaProduto.edConsultaKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     if key = vk_return then
        dbgrProdutos.SetFocus; 
end;

procedure TfrmConsultaProduto.dbgrProdutosKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
     if key = VK_RETURN then
        Close;
end;

end.
 
//******************************************************************************
//*                          End of File uBuscaProduto.pas
//******************************************************************************
