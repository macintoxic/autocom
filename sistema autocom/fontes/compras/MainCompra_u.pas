// Projeto    : AutocomPLUS 4
// Data       : 30/04/2003
// Programador: André Rombaldi - Ciga
// Descricao  : Compras

unit MainCompra_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids, Mask, DB, DBGrids, Buttons, ComCtrls,
  IBCustomDataSet, IniFiles, StrUtils,IBQuery;

type
  TfMainCompra = class(TForm)
    Panel2: TPanel;
    Label6: TLabel;
    LblProd: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label1: TLabel;
    Label29: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label23: TLabel;
    edtForn: TEdit;
    edtCodProd: TEdit;
    edtQuant: TEdit;
    edtUnidade: TEdit;
    edtCodCompra: TEdit;
    edtCodTrans: TEdit;
    mskPrecoTot: TMaskEdit;
    mskValorFrete: TMaskEdit;
    mskValorSeg: TMaskEdit;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    BtnGravar: TBitBtn;
    BtnFechar: TBitBtn;
    BitBtn5: TBitBtn;
    BtnCancelar: TBitBtn;
    spdConsProd: TSpeedButton;
    spdConsTrans: TSpeedButton;
    mskValorICMS: TMaskEdit;
    mskValorIPI: TMaskEdit;
    Label25: TLabel;
    MskPrecoUn: TMaskEdit;
    F1: TLabel;
    BtnInsProd: TBitBtn;
    SpdConsCompra: TSpeedButton;
    DatData: TDateTimePicker;
    TabSheet5: TTabSheet;
    Label26: TLabel;
    DSitensPedido: TDataSource;
    Label3: TLabel;
    memObs: TMemo;
    Label5: TLabel;
    mskOutrasDespesas: TMaskEdit;
    Label17: TLabel;
    edtCodVend: TEdit;
    spdConsVend: TSpeedButton;
    Label18: TLabel;
    Label7: TLabel;
    mskValorComissao: TMaskEdit;
    Label22: TLabel;
    DBGrid1: TDBGrid;
    BitBtn1: TBitBtn;
    Label20: TLabel;
    edtCodPaga: TEdit;
    SpdConsPag: TSpeedButton;
    mskAcrescimo: TMaskEdit;
    Label30: TLabel;
    mskDesconto: TMaskEdit;
    Label10: TLabel;
    Label32: TLabel;
    mskValorTotalNota: TMaskEdit;
    Label9: TLabel;
    Label12: TLabel;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    GroupBox2: TGroupBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    grdStringGrid: TStringGrid;
    Label4: TLabel;
    Button1: TButton;
    procedure BtnFecharClick(Sender: TObject);
    procedure spdConsProdClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure spdConsVendClick(Sender: TObject);
    procedure spdConsTransClick(Sender: TObject);
    procedure edtQuantExit(Sender: TObject);
    procedure edtQuantEnter(Sender: TObject);
    procedure edtCodProdEnter(Sender: TObject);
    procedure edtCodProdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodProdKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodProdExit(Sender: TObject);
    procedure BtnInsProdClick(Sender: TObject);
    procedure SpdConsCompraClick(Sender: TObject);
    procedure BtnGravarClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure SpdConsPagClick(Sender: TObject);
    procedure edtFornKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   path: String;
   v_codproduto, v_codforn, v_precoun, v_quantidade, v_precotot, v_codprodped: real;
   v_produto, v_unidade: string;
   V_novopedido:boolean;
   function CalculaNumeroPedido(strData: string): string; //Calcula nº do Pedido Compra
   function FormataNumero(s_String: String; i_CasasInteiras: Integer = 0; i_CasasDecimais: Integer = 0): String;
   function Filtrar(s_String, s_Filtro: String): String; //tira uma string de outra string
   function FiltraFornecedorgrid: integer; //Filtra a grid, verifica o fornecedor para gerar os pedidos
   function RetResult(SQL: string; Table: TIBQuery; OpenTable: Boolean = True ): String; //retorna o ultimo valor de uam tabela
   procedure Conecta_DB; //conecao com o banco d dados
   procedure Desconecta_DB; //desconecta banco
   procedure Log(texto:string); // monta o log
   procedure LeIni;   //Le o arquivo ini do modulo
   procedure Formata_StringGrid; // Formata a grid de itens do pedido
   procedure Dados_StringGrid; //Manda info para Grig
   procedure Processa_Valores_StringGrid; //Le Valores da grid pra depois gravar
   procedure Retira_Virgula_MaskEdit; //è o q o nome diz
end;

var
  fMainCompra: TfMainCompra;

implementation

uses Dm_u, BuscaProd_u, uGlobal, BuscaVend_u, BuscaTrans_u, BuscaPedido_u,
   BuscaPag_u;
{$R *.dfm}

procedure TfMainCompra.BtnFecharClick(Sender: TObject);
begin
   Application.Terminate;
end;

function TfMainCompra.RetResult(SQL: string; Table: TIBQuery; OpenTable: Boolean = True):string;
//Derivada do SQLRun, na chamada da funcao deve o campo de ser chamado de retorno
begin
  Table.Close;
  Table.SQL.Clear;
  Table.SQL.Add(SQL);
  Table.Prepare;
     if OpenTable then Table.Open else Table.ExecSQL;
  result:=table.fieldbyname('retorno').AsString;
end;

procedure TfMainCompra.spdConsProdClick(Sender: TObject);
begin
   SQLRun('Select CODIGOPRODUTO, NOMEPRODUTO from PRODUTO order by CODIGOPRODUTO', DM.tblProduto);
   fBuscaProduto.DSProduto.DataSet:=DM.tblProduto;

   fBuscaProduto.Caption := 'Autocom PLUS  -  PRODUTOS';
   fBuscaProduto.ShowModal;
end;

procedure TfMainCompra.FormActivate(Sender: TObject);
begin
   conecta_DB;
   LeIni;
   SqlRun(Dm.DBAutocom);
   Formata_StringGrid;
   DatData.date:=date;
   V_novopedido:=true;
   label12.Caption:='0';
   label12.Visible:=false;
   PageControl1.ActivePage:=TabSheet1;
   tabsheet2.TabVisible:=false;
   tabsheet3.TabVisible:=false;
   tabsheet4.TabVisible:=false;
   tabsheet5.TabVisible:=false;
end;

procedure TfMainCompra.spdConsVendClick(Sender: TObject);
begin
   SQLRun('SELECT * FROM Vendedor INNER JOIN Pessoa ON (VENDEDOR.PES_CODPESSOA = PESSOA.PES_CODPESSOA)', DM.tblVendedor);
   fBuscaVendedor.DSVendedor.DataSet:=DM.tblVendedor;

   fBuscaProduto.Caption := 'Autocom PLUS  -  Vendedor';
   fBuscaProduto.ShowModal;
end;

procedure TfMainCompra.spdConsTransClick(Sender: TObject);
begin
   SQLRun('Select TRP_CODTRANSPORTADORA,PES_NOME_A,TELEFONE1 from TRANSPORTADORA inner join PESSOA on (TRANSPORTADORA.PES_CODPESSOA = PESSOA.PES_CODPESSOA)', DM.tblTransportadora);
   fBuscaTransportadora.DSTransportadora.DataSet:=DM.tblTransportadora;

   fBuscaTransportadora.Caption := 'Autocom PLUS  -  Transportadora';
   fBuscaTransportadora.ShowModal;
end;

procedure TfMainCompra.edtQuantExit(Sender: TObject);
begin
   if (MskPrecoUn.Text<>'') or (MskPrecoUn.Text<>null) then
      mskPrecoTot.text:=floattostr(strtofloat(MskPrecoUn.Text)*strtofloat(edtQuant.Text));
   if edtQuant.text='0' then
   begin
      showmessage('Campo quantidade igual a zero, entre com um produto valido!');
      edtQuant.SetFocus;
   end;
end;

procedure TfMainCompra.edtQuantEnter(Sender: TObject);
begin
   if (MskPrecoUn.Text='') or (MskPrecoUn.Text=null) then
   begin
      showmessage('Campo preco unitario vazio, entre com um produto valido!');
      spdConsProdClick(self);
   end;
end;

{------------------------------------------------------------------------------
----------Essa função foi originalmente criada pelo charles--------------------
--------------alteracoes para usar no pedido de compras------------------------
------------------------feitas por André - Ciga--------------------------------
-------------------------------------------------------------------------------}

function TfMainCompra.CalculaNumeroPedido(strData: string): string;
var
   auxDataset :TDataSet;
   strAux     :string;
   tmp        :Integer;
begin
   straux  := FormatDateTime('mm/dd/yyyy',strtodate(strData));
   strdata := straux;
   RunSQL('select extract(year from cast('+ QuotedStr(strData) +' as date)) '+
          '|| count(CODIGOPEDIDOCOMPRA) + 1 from PEDIDOCOMPRA where '+
          'extract(year from data) = extract(year from cast('+ QuotedStr(strData) +' as date))',DM.DBAutocom, auxDataset,0);

   tmp := auxDataset.Fields[0].AsInteger;

   try
      with auxDataset do
      begin
         Result := IntToStr(tmp);
         Free;
      end;
      except
         Result := FormatDateTime('yyyy',strtodate(strdata)) + '1';
      end;
end;

procedure TfMainCompra.edtCodProdEnter(Sender: TObject);
begin
   F1.Caption:='[F1] - Consulta Produtos';
end;

procedure TfMainCompra.edtCodProdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_F1 then SpdConsProdClick(Self);
   if key = VK_RETURN Then Perform(WM_NextDlgCtl,0,0);
end;

procedure TfMainCompra.edtCodProdKeyPress(Sender: TObject; var Key: Char);
begin
   if not ( Key In ['0'..'9','.'] ) then Abort;
end;

procedure TfMainCompra.edtCodProdExit(Sender: TObject);
begin
   F1.Caption:='';
end;

procedure TfMainCompra.Formata_StringGrid;
var i: Integer;
begin

   for i := 0 to grdStringGrid.ColCount do
   begin
      grdStringGrid.Cols[i].Clear;
      grdStringGrid.Rows[i].Clear;
   end;

   grdStringGrid.ColCount := 8;
   grdStringGrid.RowCount := 2;
   grdStringGrid.FixedCols := 1;
   grdStringGrid.FixedRows := 1;
   grdStringGrid.ColWidths[0] := 11;
   grdStringGrid.Cols[0].Text := '';
   // coluna Codigo Produto
   grdStringGrid.ColWidths[1] := 124;
   grdStringGrid.Cols[1].Text := 'Código do Produto:';
   // coluna Produto
   grdStringGrid.ColWidths[2] := 616;
   grdStringGrid.Cols[2].Text := 'Nome do Produto:';
   // coluna Unidade
   grdStringGrid.ColWidths[3] := 94;
   grdStringGrid.Cols[3].Text := 'Unidade:';
   // coluna Quantidade
   grdStringGrid.ColWidths[4] := 78;
   grdStringGrid.Cols[4].Text := 'Quantidade:';
   // coluna Preco Unitario
   grdStringGrid.ColWidths[5] := 78;
   grdStringGrid.Cols[5].Text := 'Preço Unitário Produto:';
   // coluna Preco Total
   grdStringGrid.ColWidths[6] := 78;
   grdStringGrid.Cols[6].Text := 'Preço Total Produto:';
   // coluna Fornecedor
   grdStringGrid.ColWidths[7] := 124;
   grdStringGrid.Cols[7].Text := 'Fornecedor:';
end;


procedure TfMainCompra.BtnInsProdClick(Sender: TObject);
begin
   //Joga valores dos campos para variaveis e depois jogar na grid
   if edtCodCompra.Text='' then
   begin
      edtCodCompra.Text:=CalculaNumeroPedido(formatdatetime('dd/mm/yyyy',DatData.Date));
      v_novopedido:=true;
   end
   else v_novopedido:=false;
   if grdStringGrid.ColCount>=2 then
      if (edtForn.Text=grdStringGrid.Cells[7, 1]) or (grdStringGrid.Cells[7, 1]='') then
      begin
         v_codproduto := strtofloat(edtCodProd.Text);
         v_produto:= LblProd.caption;
         v_unidade:= edtUnidade.Text;
         v_codforn:= strtofloat(edtForn.Text);
         v_precoun:= strtofloat(MskPrecoUn.Text);
         v_quantidade:=strtofloat(edtQuant.Text);
         v_precotot:= strtofloat(mskPrecoTot.Text);
         Dados_StringGrid;
      end
      else showmessage('O forn deste prod é diferente do forn inicial, op inv!');
   edtCodProd.SetFocus;
   label12.Caption:=inttostr(strtoint(label12.Caption)+1);
   label12.Visible:=true;
end;

procedure TfMainCompra.conecta_DB; //conecao com o banco d dados
var ini:Tinifile;
    t1,t2:string;
begin
   // desativa e fecha conexao
   DM.IBTransaction.active:=false;
   DM.DBAutocom.connected:=false;
   // le arquivo ini do modulo
   path:=extractfilepath(application.exename)+'dados\';
   ini:=TIniFile.Create(path+'Autocom.ini');
   t1:=ini.readstring('ATCPLUS','IP_SERVER','10.1.2.244');
   t2:=ini.readstring('ATCPLUS','PATH_DB','d:\autocom_beta_teste\dados\autocom_novo.gdb');
   ini.free;
   // Manda pro caminho da aplicacao com  as var T1 e T2
   DM.DBAutocom.databasename:=t1+':'+t2;
   // Ativa e abre aconexao
   DM.DBAutocom.connected:=true;
   DM.IBTransaction.active:=true;
end;

procedure TfMainCompra.desconecta_DB; //desconecta bd
begin
   Dm.IBTransaction.active:=false;
   Dm.DBAutocom.connected:=false;
end;

procedure TfMainCompra.Log(texto:string); // monta o log
var
   LOGfile:textfile;
begin
   // A função LOG cria um log (em TXT) no mesmo diretório do programa com os modulos acessados.
   // Isso facilita a depuração de algum eventual BUG no sistema. (tomara q isso não ocorra, mas... ^_^ )
   AssignFile(LOGfile,extractfilepath(application.exename)+'autocom.LOG');
   if not fileexists(extractfilepath(application.exename)+'autocom.LOG') then Rewrite(logfile) else Reset(Logfile);
   Append(logfile);
   Writeln(logfile,datetimetostr(now)+' - '+texto);
   Flush(logfile);
   closefile(logfile);
end;

procedure TfMainCompra.LeIni;   //Le o arquivo ini do modulo
//var ini:Tinifile;
begin
//indica o caminho do diretorico dos dados
   path:=extractfilepath(application.exename)+'dados\';
//arquivo ini do modulo
//ini:=TIniFile.Create(path+'Autocom.ini');
end;


procedure TfMainCompra.SpdConsCompraClick(Sender: TObject);
begin
   SQLRun('Select A.NUMEROPEDIDO, A.DATA, A.TOTALPRODUTOS, A.TOTALPEDIDO, A.SITUACAO, A.APROVADO from PEDIDOCOMPRA A order by A.NUMEROPEDIDO', DM.tblPedidoCompra);
   fBuscaPedido.DSPedido.DataSet:=DM.tblPedidoCompra;
   fBuscaPedido.Caption := 'Autocom PLUS  -  PEDIDOS';
   fBuscaPedido.ShowModal;
end;

function TfMainCompra.FormataNumero(s_String: String; i_CasasInteiras: Integer = 0;
   i_CasasDecimais: Integer = 0): String;
var
   s_BeforeComma: String;
   s_AfterComma: String;
begin
   s_String := TrimAll(s_String);
   if Pos(',', s_String) > 0 then
   begin
      s_BeforeComma := LeftStr(s_String, Pos(',', s_String) - 1);
      s_AfterComma := RightStr(s_String, Length(s_String) - Pos(',', s_String));
   end
   else
   begin
      s_BeforeComma := s_String;
      s_AfterComma := '';
   end;

   while (Length(s_BeforeComma)) < i_CasasInteiras do
      s_BeforeComma := '0' + s_BeforeComma;

   while (Length(s_AfterComma)) < i_CasasDecimais do
      s_AfterComma := s_AfterComma + '0';

   if i_CasasDecimais > 0 then
      s_String := s_BeforeComma + ',' + s_AfterComma
   else
      s_String := s_BeforeComma;

   Result := s_String;
end;

procedure TfMainCompra.Dados_StringGrid; //Preenche grid com os valores
begin
   // Codigo do Produto - Col = 1
   grdStringGrid.Cells[1, grdStringGrid.RowCount-1]:= floattostr(v_codproduto);
   // Nome do Produto - Col = 2
   grdStringGrid.Cells[2, grdStringGrid.RowCount-1]:= v_produto;
   // Unidade - Col =3
   grdStringGrid.Cells[3, grdStringGrid.RowCount-1]:= v_unidade;
   // Quantidade - Col = 4
   grdStringGrid.Cells[4, grdStringGrid.RowCount-1]:= floattostr(v_quantidade);
   // Preço Unitario Produto - Col = 5
   grdStringGrid.Cells[5, grdStringGrid.RowCount-1]:= TrimAll(Filtrar(floattostr(v_precoun), 'R$'));
   // Preço Total Produto - Col = 6
   grdStringGrid.Cells[6, grdStringGrid.RowCount-1]:= TrimAll(Filtrar(floattostr(v_precotot), 'R$'));
   // Fornecedor - Col = 7
   grdStringGrid.Cells[7, grdStringGrid.RowCount-1]:= floattostr(v_codforn);
   // Processa os valores do StringGrid e atualiza os resultados nos MaskEdits
   Retira_Virgula_MaskEdit;
   // Adiciona uma linha em branco no StringGrid
   grdStringGrid.RowCount := (grdStringGrid.RowCount + 1);

   edtCodProd.Clear;
   LblProd.Caption:='';
   edtForn.Clear;
   MskPrecoUn.Clear;
   edtUnidade.Clear;
   edtQuant.Clear;
   MskPrecoTot.Clear;
   edtcodProd.SetFocus;
end;

function TfMainCompra.Filtrar(s_String, s_Filtro: String): String;
begin
    while Pos(s_Filtro, s_String) > 0 do
        Delete(s_String, Pos(s_Filtro, s_String), Length(s_Filtro));
    Result := s_String;
end;

procedure TfMainCompra.Processa_Valores_StringGrid;
var
   i: Longint;
   db_ValorTotalProdutos: Double;
begin
   db_ValorTotalProdutos := 0;
   for i := 1 to (grdStringGrid.RowCount - 2) do
   begin
      v_codproduto := strtofloat(grdStringGrid.Cells[1, i]);
      v_unidade    := grdStringGrid.Cells[3, i];
      v_quantidade := strtofloat(grdStringGrid.Cells[4, i]);
      v_precoun    := strtofloat(grdStringGrid.Cells[5, i]);
      v_precotot   := strtofloat(grdStringGrid.Cells[6, i]);
      v_codforn    := strtofloat(grdStringGrid.Cells[7, i]);
      if (TrimAll(floattostr(v_quantidade))<>'') and (TrimAll(floattostr(v_precoun))<>'') then
      begin
         db_ValorTotalProdutos := db_ValorTotalProdutos + (v_quantidade * v_precoun);
      end;

      SqlRun('Select * from PRODUTOFORNECEDOR where CODIGOPRODUTO=' +floattostr(v_codproduto), DM.tblRede);

      SqlRun('Update PRODUTOFORNECEDOR set '+
             'FRN_CODFORNECEDOR='+floattostr(v_codForn)+', '+
             'PRECO='+floattostr(v_PrecoUn)+', '+
             'DATAPRECO='+chr(39)+FormatDateTime('mm/dd/yyyy',datData.Date)+chr(39)+', '+
             'UNIDADEFORNECEDOR='+chr(39)+v_Unidade+chr(39)+', '+
             'CODIGOPRODUTO='+floattostr(v_codproduto)+' '+
             'where CODIGOPRODUTO='+floattostr(v_codproduto),dm.tblRede);
   end;

   // mskValorTotalProdutos.Text := FormataNumero(FloatToStr(db_ValorTotalProdutos), 10, 2);
end;

procedure TfmainCompra.Retira_Virgula_MaskEdit;
var
   i: Integer;
   MaskEdit: TMaskEdit;
   s_EditMask, s_NewEditMask, s_Name, s_Valor: String;
begin
   for i := 0 to (fMainCompra.ComponentCount - 1) do
   begin
      if fMainCompra.Components[i] is TMaskEdit then
      begin
         MaskEdit := fMainCompra.Components[i] as TMaskEdit;
         s_Name := MaskEdit.Name;
         s_Valor := MaskEdit.Text;
         s_EditMask := MaskEdit.EditMask;
         s_NewEditMask := LeftStr(s_EditMask, Pos(';', s_EditMask)) + '1; ';
         MaskEdit.EditMask := s_NewEditMask;
         if Pos(',', s_Valor) > 0 then
            MaskEdit.Text := s_Valor;
         MaskEdit.EditMask := s_EditMask;
      end;
   end;
end;

procedure TfMainCompra.BtnGravarClick(Sender: TObject);
var
   vl_codpedido:string;
   vl_countpedido:string;
begin
   if v_novopedido=true then
   begin
      SQLRun('Insert into PEDIDOCOMPRA (NUMEROPEDIDO, DATA, CFG_CODCONFIG, FRN_CODFORNECEDOR, CODIGONATUREZAOPERACAO, CODIGOCONDICAOPAGAMENTO) values ('+edtCodCompra.text+
          ','+chr(39)+formatdatetime('mm/dd/yyyy',datdata.Date)+chr(39)+
          ',1,'+chr(39)+grdStringGrid.Cells[7, 1]+chr(39)+',112001,'+chr(39)+ EdtCodPaga.text+chr(39)+')',dm.tblPedidoCompra);
      Processa_Valores_StringGrid;
      vl_codpedido:=RetResult('select max(codigopedidocompra) as retorno from pedidocompra',dm.tblRede);
      SQLRun('Insert into PRODUTOPEDIDOCOMPRA (CODIGOPEDIDOCOMPRA, CODIGOPRODUTO, UNIDADE, QUANTIDADE, PRECO) values ('+chr(39)+vl_codpedido+chr(39)+
             ',' +floattostr(v_codproduto)+
             ',' +chr(39)+v_unidade+chr(39)+
             ',' +floattostr(v_quantidade)+
             ',' +floattostr(v_precotot)+
             ')' ,DM.tblprodutopedidocompra);
      vl_countpedido:=RetResult('select count(codigopedidocompra) as retorno from produtopedidocompra where codigopedidocompra='+chr(39)+vl_codpedido+chr(39),dm.tblRede);
      SQLRun('insert into pedidocompra (TOTALPRODUTOS) values ('+chr(39)+vl_codpedido+chr(39)+')',dm.tblPedidoCompra)

//verifica c a compra requer transportadora, caso haja grava na tbl
      if edtCodTrans.Text<>'' then
      sqlrun('insert into pedidocompra (trp_codtransportadora,frete,seguro) values ('+edtCodTrans.Text+','+
             +mskValorFrete.Text+','+mskValorSeg+')',dm.tblTransportadora);
   end
   //else
   //   SQLRun('Update
end;

Function TfMainCompra.FiltraFornecedorgrid:integer;
var
   v,i,j,cont: integer;
   vt_Forn: array of array of string;
   v_auxforn:string;
begin
   SetLength(vt_Forn,1,grdStringGrid.RowCount - 1);
   cont:=0;
   v:=1;

   for i:=0 to (grdStringGrid.RowCount - 1) do
      begin vt_Forn[0,i]:= grdStringGrid.Cells[7, i+1]; showmessage('Valor:'+vt_Forn[0,i]); end;

   for i:=0 to (grdStringGrid.RowCount - 1) do
   begin
      v_auxforn:=grdStringGrid.Cells[7, i+1];
      for j:=0  to (grdStringGrid.RowCount - 1) do
      begin
         if (v=1) and  (v_auxforn=vt_forn[0,j]) then
         begin
            vt_forn[0,j]:=''; vt_forn[0,j]:=v_auxforn; v:=0;
         end
         else if (v=0) and (v_auxforn=vt_forn[0,j]) then
            vt_forn[0,j]:='';
   //showmessage('Valor:'+vt_Forn[0,i]);
   //else if (v=0) and (v_auxforn<>vt_forn[0,j]) then
   //else if (v=1) and (v_auxforn<>vt_forn[0,j])then
      end;
      v:=0;
   end;

   for i:=0 to (grdStringGrid.RowCount - 1) do
   if vt_Forn[0,i]<>'' then
   begin
      cont:=cont+1;
//      showmessage('Valor:'+vt_Forn[0,i]);
   end;

   {and (vt_Forn[0,i]<>grdStringGrid.Cells[7, i+1]) then
         begin
            v:=1;
            vt_Forn[0,i]:= grdStringGrid.Cells[7, i+1];

            exit;
         end
      else if (v_auxforn=grdStringGrid.Cells[7, j+1]) or (grdStringGrid.Cells[7, j+1]='') then
            v:=0
      end;
      if v=1 then
      begin
         vt_Forn[0,i]:= grdStringGrid.Cells[7, i+1];
         cont:=cont+1;
      end;
      v:=1;
   end; }

   //for i := Low(vt_Forn) to High(vt_Forn) do
    // for j := Low(vt_Forn[i]) to High(vt_Forn[i]) do
     //   showmessage('Valor:'+vt_Forn[i,j]);
   Result:=cont;
end;

procedure TfMainCompra.BitBtn5Click(Sender: TObject);
begin
   FiltraFornecedorgrid;
end;

procedure TfMainCompra.SpdConsPagClick(Sender: TObject);
begin
   SQLRun('select CODIGOCONDICAOPAGAMENTO, CONDICAOPAGAMENTO from CONDICAOPAGAMENTO', DM.tblCondicaoPagam);
   fBuscaPagam.DSpagam.DataSet:=DM.tblCondicaoPagam;
   fBuscaPagam.Caption := 'Autocom PLUS  -  CONDICOES DE PAGAMENTO';
   fBuscaPagam.ShowModal;
end;

procedure TfMainCompra.edtFornKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if key=VK_RETURN Then Perform(WM_NextDlgCtl,0,0);
end;

procedure TfMainCompra.Button1Click(Sender: TObject);
begin
   if messagedlg('Deseja cotar licitação para o pedido?',mtinformation,[mbyes,mbno,mbcancel],0)=mryes then
   begin
      PageControl1.ActivePage:=TabSheet2;
      TabSheet2.Enabled:=True;
      tabsheet2.TabVisible:=True;
   end
   else
   begin
      PageControl1.ActivePage:=TabSheet3;
      TabSheet3.Enabled:=True;
      TabSheet3.TabVisible:=True;
   end;
end;

end.

