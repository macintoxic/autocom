unit pessoa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls;

type
  TFrmPessoa = class(TForm)
    PanPesquisa: TPanel;
    CmdProcurar: TSpeedButton;
    TxtPesquisa: TEdit;
    GrdPessoa: TDBGrid;
    DsPessoa: TDataSource;
    procedure GrdPessoaDblClick(Sender: TObject);
    procedure CmdProcurarClick(Sender: TObject);
    procedure TxtPesquisaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrdPessoaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPessoa: TFrmPessoa;

implementation

uses dm_u, financeiro_u, uglobal;

{$R *.dfm}

procedure TFrmPessoa.GrdPessoaDblClick(Sender: TObject);
begin
  if (Origem = 'Movimentacao') then
    begin
       FrmFinanceiro.EdMovimentacao.Text:= dm.Consulta.fieldbyname('codigo').asstring;
       FrmFinanceiro.lblfornec.Caption := dm.Consulta.fieldbyname('nome').asstring;
       Origem:='';
    end;
  if (Origem1 = 'Fornecedores') and (achou = true) then
    begin
       FrmFinanceiro.EDfornec.text:=dm.consulta.fieldbyname('CodigoF').asstring;
       FrmFinanceiro.lblfornec.caption:= dm.consulta.fieldbyname('nome').asstring;
       codpessoa:= dm.consulta.fieldbyname('codp').asstring;
       dm.Consulta.FieldByName('codp').Visible:= false;
       achou:= false;
    end;
  if (Origem = 'Moeda') then
     begin
        FrmFinanceiro.EDcodmoeda.Text:=dm.consulta.fieldbyname('Codigo').asstring;
        FrmFinanceiro.EDindimoeda.text:=dm.Consulta.fieldbyname('Prefixo').asstring;
        FrmFinanceiro.lblnomemoeda.Caption:= dm.Consulta.fieldbyname('Nome').asstring;
        Origem:='';
     end;
  if (Origem1 = 'Cliente') and (achou = true) then
    begin
       FrmFinanceiro.EDfornec.text:=dm.consulta.fieldbyname('Codigo').asstring;
       FrmFinanceiro.lblfornec.caption:= dm.consulta.fieldbyname('nome').asstring;
       Dm.Consulta.Fields[1].Visible := True;
       Dm.Consulta.Fields[2].Visible := True;
       Dm.Consulta.Fields[3].Visible := True;
       Dm.Consulta.Fields[5].Visible := True;
       achou:= false;
    end;
  Close;
end;

procedure TFrmPessoa.CmdProcurarClick(Sender: TObject);
var
  aux: integer;
begin
   if (Origem = 'Movimentacao') then
    begin
       if isinteger(txtpesquisa.text) then
          begin
            aux:= StrToInt(Txtpesquisa.Text);
            sqlrun('Select codigoconjunto as codigo, nome from conjuntos where codigoconjunto = '+ IntToStr(aux), dm.consulta);
          end
       else
          sqlrun('Select codigoconjunto as codigo, nome from conjuntos where nome LIKE '+ Chr(39) + '%'
               + TxtPesquisa.Text + '%' + Chr(39), dm.Consulta);

       GrdPessoa.SetFocus;
    end;



end;

procedure TFrmPessoa.TxtPesquisaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_F12 then CmdProcurarClick(Self);
end;

procedure TFrmPessoa.GrdPessoaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = Vk_Return then GrdPessoaDblClick(Self);
  if Key = Vk_Escape then Close;
end;

end.
