unit uConsulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, uGlobal,SuiThemes,
  SUIMgr, SUIEdit, SUIDBCtrls, SUIForm;
                                                                         
type
  TfConsulta = class(TForm)
    PanSearch: TPanel;
    BtnSearch: TSpeedButton;
    DsConsulta: TDataSource;
    suiForm1: TsuiForm;
    GrdConsulta: TsuiDBGrid;
    EdSearch: TsuiEdit;
    skin: TsuiThemeManager;
    procedure FormShow(Sender: TObject);
    procedure suitempGrdConsultaDblClick(Sender: TObject);
    procedure BtnSearchClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
  public
  end;

var
  fConsulta: TfConsulta;

implementation

uses uMain, uDm;

{$R *.dfm}

procedure TfConsulta.FormShow(Sender: TObject);
begin
  ZeroMemory(@OptionsReturn, SizeOf(OptionsReturn));
  case ActiveConsulta of
    Produto:
      begin
        SQLRun('SELECT CODIGOPRODUTO AS CODIGO, NOMEPRODUTO AS NOME FROM PRODUTO ORDER BY CODIGOPRODUTO',Dm.generico);
      end;
    Operador:
      begin
        SQLRun('SELECT IDUSUARIO AS CODIGO, NOMEUSUARIO AS NOME FROM USUARIOSISTEMA order by IDUSUARIO',Dm.generico);
      end;
    Indicador:
      begin
        SQLRun('SELECT CODIGOVENDEDOR AS CODIGO, PES_NOME_A AS NOME, VEN_CODVENDEDOR FROM vendedor v inner join pessoa p on (v.pes_codpessoa = p.pes_codpessoa) order by v.codigovendedor',Dm.generico);
      end;
    Cliente:
      begin
        SQLRun('SELECT CODIGOCLIENTE AS CODIGO, PES_NOME_A AS NOME, CLI_CODCLIENTE  FROM cliente c inner join pessoa p on (c.pes_codpessoa = p.pes_codpessoa) order by c.codigocliente',Dm.generico);
      end;
    Grupo:
      begin
        SQLRun('SELECT CODIGOGRUPOPRODUTO AS CODIGO, GRUPOPRODUTO AS NOME FROM GrupoProduto order by codigogrupoproduto',Dm.generico);
      end;
  end;
  DsConsulta.DataSet :=  Dm.generico;
  GrdConsulta.DataSource := DsConsulta;
  application.ProcessMessages;
  {Aplica cor a primeira coluna da grade de dados}
  GrdConsulta.Columns.Items[0].Color := $00efd3c6;
  GrdConsulta.Columns.Items[0].Width := 64;
  GrdConsulta.Columns.Items[1].Width := 300;
  if GrdConsulta.Columns.Count >= 3 then GrdConsulta.Columns.Items[2].Visible := False;
end;

procedure TfConsulta.suitempGrdConsultaDblClick(Sender: TObject);
begin
  case ActiveConsulta of
    Produto:
      begin
        OptionsReturn.ExtCodeReturn := Dm.generico.FieldByName('CODIGO').AsInteger;
        OptionsReturn.StringReturn  := Dm.generico.FieldByName('NOME').AsString;
      end;
    Operador:
      begin
        OptionsReturn.ExtCodeReturn := Dm.generico.FieldByName('CODIGO').AsInteger;
        OptionsReturn.StringReturn  := Dm.generico.FieldByName('NOME').AsString;
      end;
    Indicador:
      begin
        OptionsReturn.IntCodeReturn := Dm.generico.FieldByName('VEN_CODVENDEDOR').AsInteger;
        OptionsReturn.ExtCodeReturn := Dm.generico.FieldByName('CODIGO').AsInteger;
        OptionsReturn.StringReturn  := Dm.generico.FieldByName('NOME').AsString;
      end;
    Cliente:
      begin
        OptionsReturn.IntCodeReturn := Dm.generico.FieldByName('CLI_CODCLIENTE').AsInteger;
        OptionsReturn.ExtCodeReturn := Dm.generico.FieldByName('CODIGO').AsInteger;
        OptionsReturn.StringReturn  := Dm.generico.FieldByName('NOME').AsString;
      end;
    Grupo:
      begin
        OptionsReturn.ExtCodeReturn := Dm.generico.FieldByName('CODIGO').AsInteger;
        OptionsReturn.StringReturn  := Dm.generico.FieldByName('NOME').AsString;
      end;
  end;
  Close;
end;

procedure TfConsulta.BtnSearchClick(Sender: TObject);
var
  DsFastQuery: TDataSet;
begin
  case ActiveConsulta of
    Produto:
      begin
        if IsFloat(EdSearch.Text) then
          begin
            DsFastQuery := TDataSet.Create(Self);
            RunSQL('SELECT * FROM PRODUTOASSOCIADO WHERE CODIGOPRODUTOASSOCIADO = ' + EdSearch.text,DsFastQuery);
            if DsFastQuery.IsEmpty then
                SQLRun('SELECT CODIGOPRODUTO AS CODIGO, NOMEPRODUTO AS NOME FROM PRODUTO WHERE CODIGOPRODUTO = ' + EdSearch.text,Dm.generico)
            else
                SQLRun('SELECT CODIGOPRODUTO AS CODIGO, NOMEPRODUTO AS NOME FROM PRODUTO WHERE CODIGOPRODUTO = ' + DsFastQuery.FieldByName('CODIGOPRODUTO').AsString ,Dm.generico);
            FreeAndNil(DsFastQuery);
          end
        else
          SQLRun('SELECT CODIGOPRODUTO AS CODIGO, NOMEPRODUTO AS NOME FROM PRODUTO WHERE NOMEPRODUTO LIKE' + QuotedStr('%' + EdSearch.Text + '%'),Dm.generico);
      end;
    Operador:
      begin
        if IsFloat(EdSearch.Text) then
          SQLRun('SELECT IDUSUARIO AS CODIGO, NOMEUSUARIO AS NOME FROM USUARIOSISTEMA WHERE IDUSUARIO = ' + EdSearch.Text ,Dm.generico)
        else
          SQLRun('SELECT IDUSUARIO AS CODIGO, NOMEUSUARIO AS NOME FROM USUARIOSISTEMA WHERE NOMEUSUARIO LIKE ' + QuotedStr('%' + EdSearch.Text + '%'),Dm.generico);
      end;
    Indicador:
      begin
        if IsFloat(EdSearch.Text) then
          SQLRun('SELECT CODIGOVENDEDOR AS CODIGO, PES_NOME_A AS NOME, VEN_CODVENDEDOR FROM vendedor V inner join pessoa p on (v.pes_codpessoa = p.pes_codpessoa) where v.codigovendedor = ' + EdSearch.Text,Dm.generico)
        else
          SQLRun('SELECT CODIGOVENDEDOR AS CODIGO, PES_NOME_A AS NOME, VEN_CODVENDEDOR FROM vendedor V inner join pessoa p on (v.pes_codpessoa = p.pes_codpessoa) where p.pes_nome_a like ' + QuotedStr('%' + EdSearch.Text + '%'),Dm.generico);
      end;
    Cliente:
      begin
        if IsFloat(EdSearch.Text) then
          SQLRun('SELECT CODIGOCLIENTE AS CODIGO, PES_NOME_A AS NOME, CLI_CODCLIENTE from cliente c inner join pessoa p on (c.pes_codpessoa = p.pes_codpessoa) where c.codigocliente = ' + EdSearch.Text,Dm.generico)
        else
          SQLRun('SELECT CODIGOCLIENTE AS CODIGO, PES_NOME_A AS NOME, CLI_CODCLIENTE from cliente c inner join pessoa p on (c.pes_codpessoa = p.pes_codpessoa) where p.pes_nome_a like '  + QuotedStr('%' + EdSearch.Text + '%'),Dm.generico);
      end;
    Grupo:
      begin
        if IsFloat(EdSearch.Text) then
          SQLRun('SELECT CODIGOGRUPOPRODUTO AS CODIGO, GRUPOPRODUTO AS NOME from GrupoProduto where codigogrupoproduto = ' + EdSearch.Text,Dm.generico)
        else
          SQLRun('SELECT CODIGOGRUPOPRODUTO AS CODIGO, GRUPOPRODUTO AS NOME from GrupoProduto where grupoproduto like ' + QuotedStr('%' + EdSearch.Text + '%'),Dm.generico);
      end;
  end;
  if GrdConsulta.Columns.Count >= 3 then GrdConsulta.Columns.Items[2].Visible := False;
  FreeAndNil(DsFastQuery);
end;

procedure TfConsulta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_ESCAPE: Close;
    VK_F12: if ActiveControl = EdSearch then BtnSearch.Click;
    VK_RETURN: if ActiveControl = GrdConsulta then suitempGrdConsultaDblClick(Self) else BtnSearch.Click;
  end;
end;

procedure TfConsulta.FormActivate(Sender: TObject);
var Tipo_skin:string;
begin
     tipo_skin:=LeINI('ATCPLUS', 'skin');
     if (tipo_skin='0') or (tipo_skin='') then skin.uistyle:=WinXP;
     if (tipo_skin='1') then skin.uistyle:=BlueGlass;
     if (tipo_skin='2') then skin.uistyle:=DeepBlue;
     if (tipo_skin='3') then skin.uistyle:=MacOS;
     if (tipo_skin='4') then skin.uistyle:=Protein;
     application.processmessages;

end;

end.
