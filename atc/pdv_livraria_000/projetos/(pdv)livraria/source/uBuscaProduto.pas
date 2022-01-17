//******************************************************************************
//
//                 UNIT UBUSCAPRODUTO (-)
//
//******************************************************************************
// Project:        M�dulo PDV - ORCAMENTO
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
    uPadrao, Buttons, math, STRUTILS, ComCtrls;

type
    TfrmConsultaProduto = class(TfrmConsultaPadrao)
        Panel1: TPanel;
        edConsulta: TEdit;
        Panel2: TPanel;
        dbtxtPreco: TDBText;
        Label7: TLabel;
        Panel3: TPanel;
        dbgrProdutos: TDBGrid;
        dsListaProdutos: TDataSource;
    SpeedButton1: TSpeedButton;
    Panel4: TPanel;
    DBText1: TDBText;
    Label1: TLabel;
    Panel5: TPanel;
    DBText2: TDBText;
    Label2: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    DBMemo3: TDBMemo;
    Label3: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
        procedure dbgrProdutosDblClick(Sender: TObject);
        procedure edConsultaKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure dbgrProdutosKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    private
        FTabela: string;
        procedure SetTabela(const Value: string);
        { Private declarations }
    public
        { Public declarations }
        dsListagemProdutos: TDataSet;
        property Tabela: string read FTabela write SetTabela;
    end;

var
    frmConsultaProduto: TfrmConsultaProduto;

implementation
uses
    udmpdv;
{$R *.dfm}

{ TfrmConsultaProduto }

procedure TfrmConsultaProduto.SetTabela(const Value: string);
begin
//    dsListagemProdutos := dmORC.BuscaListaProduto(value);
//    dsListaProdutos.DataSet := dsListagemProdutos;
    FTabela := Value;
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

    if key = VK_F12 then
       SpeedButton1.Click;

end;

procedure TfrmConsultaProduto.dbgrProdutosKeyDown(Sender: TObject;
    var Key: Word; Shift: TShiftState);
begin
    if key = VK_RETURN then
        Close;
end;

procedure TfrmConsultaProduto.SpeedButton1Click(Sender: TObject);
begin
     label3.visible:=true;
     application.processmessages;
  inherited;
    dmorc.RunSQL('SELECT p.*,s.desCRIcao as secao,pr.codigoprateleira as prateleira,pt.preco ' +
      'FROM PRODUTO P,Estoque E, prateleira pr,secao s,PRODUTOTABELAPRECO PT ' +
      'where e.codigoproduto=p.codigoproduto'+
      '  and pr.codprateleira=e.codprateleira'+
      '  and pr.codsecao=s.codsecao'+
      '  and e.lote='+quotedstr('0')+
      '  and P.CODIGOPRODUTO = Pt.CODIGOPRODUTO'+
      '  and Pt.CODIGOTABELAPRECO = ' + Tabela +' and p.' +
      ifthen( StrToFloatDef(edConsulta.Text,-1) = -1, ifthen(radiobutton1.checked=true,'nomeproduto','abreviatura'), 'codigoproduto') + ' like '
      + QuotedStr(edconsulta.text + '%')+
      ' order by p.nomeproduto'
      , dsListagemProdutos);
    dsListaProdutos.DataSet := dsListagemProdutos;
      label3.visible:=false;
end;

end.

//******************************************************************************
//*                          End of File uBuscaProduto.pas
//******************************************************************************
