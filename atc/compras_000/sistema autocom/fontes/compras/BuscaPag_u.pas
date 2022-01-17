unit BuscaPag_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, DB;

type
  TfBuscaPagam = class(TForm)
    grdPagam: TDBGrid;
    Panel1: TPanel;
    CmdProcurar: TSpeedButton;
    F12: TLabel;
    TxtPesquisa: TEdit;
    DSPagam: TDataSource;
    procedure grdPagamDblClick(Sender: TObject);
    procedure grdPagamKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CmdProcurarClick(Sender: TObject);
    procedure TxtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure TxtPesquisaEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fBuscaPagam: TfBuscaPagam;

implementation

uses MainCompra_u, Dm_u;

{$R *.dfm}

procedure TfBuscaPagam.grdPagamDblClick(Sender: TObject);
begin
   FMainCompra.edtCodPaga.Text := Dm.tblCondicaoPagamCODIGOCONDICAOPAGAMENTO.AsString;
   FMainCompra.Label26.Caption := Dm.tblCondicaoPagamCONDICAOPAGAMENTO.AsString;

end;

procedure TfBuscaPagam.grdPagamKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_Return then GrdPagamDblClick(Self);
   if Key = VK_Escape then Close;
end;

procedure TfBuscaPagam.CmdProcurarClick(Sender: TObject);
begin
   Dm.tblCondicaoPagam.close;
   Dm.tblCondicaoPagam.SQL.Clear;
   if TxtPesquisa.text='' then
      Dm.tblCondicaoPagam.SQL.Add('SELECT codigocondicaopagamento, condicaopagamento FROM condicaopagamento'+
                                  ' ORDER BY codigoproduto')
   else
   begin
      try
         StrToInt(TxtPesquisa.Text);
         Dm.tblCondicaoPagam.SQL.Add('SELECT codigocondicaopagamento, condicaopagamento FROM condicaopagamento'+
                               ' WHERE codigocondicaopagamento=' + TxtPesquisa.Text +
                               ' ORDER BY codigocondicaopagamento');
      except
         Dm.tblCondicaoPagam.SQL.Add('SELECT codigocondicaopagamento, condicaopagamento FROM condicaopagamento' +
                               ' WHERE codigocondicaopagamento LIKE ' + Chr(39) + '%' + TxtPesquisa.Text + '%' + Chr(39) +
                               ' ORDER BY codigocondicaopagamento');
      end;
   end;
   Dm.tblCondicaoPagam.Prepare;
   Dm.tblCondicaoPagam.Open;
   grdPagam.SetFocus;
end;

procedure TfBuscaPagam.TxtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (Key = VK_F12) or (Key = VK_Return) then CmdProcurarClick(Self);
end;

procedure TfBuscaPagam.TxtPesquisaEnter(Sender: TObject);
begin
   f12.Visible:=True;
end;

end.
