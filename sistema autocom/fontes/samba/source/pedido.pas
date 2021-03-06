unit pedido;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, DBCtrls, DB, IBDatabase, Grids,
  DBGrids, Math;

type
  TProduto = Record
    Codigo       : String;
    Quantidade   : shortstring;
    Preco        : Real;
    Obs          : string;
  end;

type
  TFpedido = class(TForm)
    Panel1: TPanel;
    btnsete: TBitBtn;
    btnoito: TBitBtn;
    btnnove: TBitBtn;
    btnseis: TBitBtn;
    btncinco: TBitBtn;
    btnquatro: TBitBtn;
    btntres: TBitBtn;
    btndois: TBitBtn;
    btnHum: TBitBtn;
    btnzero: TBitBtn;
    SpeedButton1: TSpeedButton;
    GroupBox1: TGroupBox;
    E1mesa: TEdit;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    e1qtde: TEdit;
    e2produto: TEdit;
    procproduto: TBitBtn;
    SpeedButton2: TSpeedButton;
    btnvirgula: TBitBtn;
    btnlimpa: TBitBtn;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    e2garcom: TEdit;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    GroupBox5: TGroupBox;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure procprodutoClick(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure btnzeroClick(Sender: TObject);
    procedure btnHumClick(Sender: TObject);
    procedure btndoisClick(Sender: TObject);
    procedure btntresClick(Sender: TObject);
    procedure btnquatroClick(Sender: TObject);
    procedure btncincoClick(Sender: TObject);
    procedure btnseisClick(Sender: TObject);
    procedure btnseteClick(Sender: TObject);
    procedure btnoitoClick(Sender: TObject);
    procedure btnnoveClick(Sender: TObject);
    procedure btnvirgulaClick(Sender: TObject);
    procedure btnlimpaClick(Sender: TObject);
    procedure local1;
    procedure local3;
    procedure local4;
    procedure procura_mesa;
    procedure Inclui_produto;
    procedure procura_produto;
    procedure proximo_produto;
    procedure grava_pedido;
    procedure grava_produto_pedido;
    procedure politica_preco;
    procedure E1mesaExit(Sender: TObject);
    procedure e2produtoExit(Sender: TObject);
    procedure e1qtdeExit(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
    procedure printgrill(pedido:integer;nome_pedido,nome_vendedor:string);
  public
    { Public declarations }
  end;

var
  Fpedido: TFpedido;
  produtos: array[0..50] of TProduto;
  CodigoProdutos: Integer;
  v_mesa: integer;
  v_garcom: integer;
  v_produto: Real;
  v_qtde: real;
  v_produtopreco: real;
  v_obs, preco :String;
  local: String;
  or_botao: String;
  S_codigoassociado: String;



implementation

uses Unit1, dtm2_u, cme, autocom, fobs_u, conta;

{$R *.dfm}

procedure TFpedido.SpeedButton1Click(Sender: TObject);
begin
  close;

end;

procedure TFpedido.FormActivate(Sender: TObject);
begin
     fpedido.top:=0;
     fpedido.left:=0;
     fpedido.width:=247;
     fpedido.height:=297;
     e1mesa.text:='';
     e2produto.Text:='';
     label1.caption:='';
     e1qtde.Text :='';
     edit1.Text:='';
     e1mesa.SetFocus;
     speedbutton2.Enabled:=false;
     SpeedButton3.Enabled:=false;
     groupbox1.Caption := S_NomePedido;
     groupbox2.caption := S_NomeVendedor;
end;

procedure TFpedido.procprodutoClick(Sender: TObject);
begin
  origem:= 1;
  SqlRun('Select codigogrupoproduto, grupoproduto from grupoproduto', dtm2.produtos);
  fconsprod.ShowModal;
end;

procedure TFpedido.SpeedButton2Click(Sender: TObject);
begin
  consorigem:='Consulta';
  fconta.GroupBox1.Visible:=false;
  fconta.groupbox2.Visible:= false;
  fconta.SpeedButton4.Visible:= false;
  codigo:=false;
  fconta.SpeedButton3.Visible:=false;
  fconta.RichEdit1.Visible :=true;
  fconta.panel1.Visible:=false;
  fconta.RichEdit1.Lines.Add('********Autocom Plus - Samba*******');
  fconta.ShowModal;

  //showmessage('Mesa:' + e1mesa.Text + #13 + 'garcom:'+ IntToStr(v_garcom)+ #13 + 'produto:'+ IntToStr(v_produto) + #13 + 'quantidade'+ FloatToStr(v_qtde) );
end;

procedure TFpedido.btnzeroClick(Sender: TObject);
begin
  or_botao:= 'Zero';
  if local = 'Mesa'       then local1;
  //if local = 'Garcom'     then local2;
  if local = 'Produto'    then local3;
  if local = 'Quantidade' then local4;
end;

procedure TFpedido.btnHumClick(Sender: TObject);
begin
  or_botao:= 'Hum';
  if local = 'Mesa'       then local1;
  //if local = 'Garcom'     then local2;
  if local = 'Produto'    then local3;
  if local = 'Quantidade' then local4;
end;

procedure TFpedido.btndoisClick(Sender: TObject);
begin
  or_botao:= 'Dois';
  if local = 'Mesa'       then local1;
  //if local = 'Garcom'     then local2;
  if local = 'Produto'    then local3;
  if local = 'Quantidade' then local4;
end;

procedure TFpedido.btntresClick(Sender: TObject);
begin
  or_botao:= 'Tres';
  if local = 'Mesa'       then local1;
  //if local = 'Garcom'     then local2;
  if local = 'Produto'    then local3;
  if local = 'Quantidade' then local4;
end;

procedure TFpedido.btnquatroClick(Sender: TObject);
begin
  or_botao:= 'Quatro';
  if local = 'Mesa'       then local1;
  //if local = 'Garcom'     then local2;
  if local = 'Produto'    then local3;
  if local = 'Quantidade' then local4;
end;

procedure TFpedido.btncincoClick(Sender: TObject);
begin
  or_botao:= 'Cinco';
  if local = 'Mesa'       then local1;
  //if local = 'Garcom'     then local2;
  if local = 'Produto'    then local3;
  if local = 'Quantidade' then local4;
end;

procedure TFpedido.btnseisClick(Sender: TObject);
begin
  or_botao:= 'Seis';
  if local = 'Mesa'       then local1;
  //if local = 'Garcom'     then local2;
  if local = 'Produto'    then local3;
  if local = 'Quantidade' then local4;
end;

procedure TFpedido.btnseteClick(Sender: TObject);
begin
  or_botao:= 'Sete';
  if local = 'Mesa'       then local1;
  //if local = 'Garcom'     then local2;
  if local = 'Produto'    then local3;
  if local = 'Quantidade' then local4;
end;

procedure TFpedido.btnoitoClick(Sender: TObject);
begin
  or_botao:= 'Oito';
  if local = 'Mesa'       then local1;
  //if local = 'Garcom'     then local2;
  if local = 'Produto'    then local3;
  if local = 'Quantidade' then local4;
end;

procedure TFpedido.btnnoveClick(Sender: TObject);
begin
  or_botao:= 'Nove';
  if local = 'Mesa'       then local1;
  //if local = 'Garcom'     then local2;
  if local = 'Produto'    then local3;
  if local = 'Quantidade' then local4;
end;

procedure TFpedido.btnvirgulaClick(Sender: TObject);
begin
or_botao:= 'Virgula';
if local = 'Quantidade'    then local4;
end;

procedure TFpedido.btnlimpaClick(Sender: TObject);
begin
  or_botao:= 'Limpa';
  if local = 'Mesa'       then local1;
  //if local = 'Garcom'     then local2;
  if local = 'Produto'    then local3;
  if local = 'Quantidade' then local4;
end;
{------------------------------------------------------------------------------}
procedure TFpedido.local1;
begin
  if or_botao = 'Limpa' Then
  begin
     E1mesa.Text:='';
     e1mesa.SetFocus;
  end;
  if or_botao = 'Zero' then
  begin
    e1mesa.Text:= e1mesa.text + '0';
  end;
  if or_botao = 'Hum' then
  begin
    e1mesa.Text:= e1mesa.text + '1';
  end;
  if or_botao = 'Dois' then
  begin
    e1mesa.Text:= e1mesa.text + '2';
  end;
  if or_botao = 'Tres' then
  begin
    e1mesa.Text:= e1mesa.text + '3';
  end;
  if or_botao = 'Quatro' then
  begin
    e1mesa.Text:= e1mesa.text + '4';
  end;
  if or_botao = 'Cinco' then
  begin
    e1mesa.Text:= e1mesa.text + '5';
  end;
  if or_botao = 'Seis' then
  begin
    e1mesa.Text:= e1mesa.text + '6';
  end;
  if or_botao = 'Sete' then
  begin
    e1mesa.Text:= e1mesa.text + '7';
  end;
  if or_botao = 'Oito' then
  begin
    e1mesa.Text:= e1mesa.text + '8';
  end;
  if or_botao = 'Nove' then
  begin
    e1mesa.Text:= e1mesa.text + '9';
  end;
end;
{------------------------------------------------------------------------------}

procedure TFpedido.local3;
begin
  if or_botao = 'Limpa' Then
  begin
     e2produto.Text:='';
     e2produto.SetFocus;
  end;
  if or_botao = 'Zero' then
  begin
    e2produto.Text:= e2produto.text + '0';
  end;
  if or_botao = 'Hum' then
  begin
    e2produto.Text:= e2produto.text + '1';
  end;
  if or_botao = 'Dois' then
  begin
    e2produto.Text:= e2produto.text + '2';
  end;
  if or_botao = 'Tres' then
  begin
    e2produto.Text:= e2produto.text + '3';
  end;
  if or_botao = 'Quatro' then
  begin
    e2produto.Text:= e2produto.text + '4';
  end;
  if or_botao = 'Cinco' then
  begin
    e2produto.Text:= e2produto.text + '5';
  end;
  if or_botao = 'Seis' then
  begin
    e2produto.Text:= e2produto.text + '6';
  end;
  if or_botao = 'Sete' then
  begin
    e2produto.Text:= e2produto.text + '7';
  end;
  if or_botao = 'Oito' then
  begin
    e2produto.Text:= e2produto.text + '8';
  end;
  if or_botao = 'Nove' then
  begin
    e2produto.Text:= e2produto.text + '9';
  end;

end;


{------------------------------------------------------------------------------}
procedure TFpedido.local4;
begin
  if or_botao = 'Limpa' Then
  begin
     e1qtde.Text:='';
     e1qtde.SetFocus;
  end;
  if or_botao = 'Zero' then
  begin
    e1qtde.Text:= e1qtde.text + '0';
  end;
  if or_botao = 'Hum' then
  begin
    e1qtde.Text:= e1qtde.text + '1';
  end;
  if or_botao = 'Dois' then
  begin
    e1qtde.Text:= e1qtde.text + '2';
  end;
  if or_botao = 'Tres' then
  begin
    e1qtde.Text:= e1qtde.text + '3';
  end;
  if or_botao = 'Quatro' then
  begin
    e1qtde.Text:= e1qtde.text + '4';
  end;
  if or_botao = 'Cinco' then
  begin
    e1qtde.Text:= e1qtde.text + '5';
  end;
  if or_botao = 'Seis' then
  begin
    e1qtde.Text:= e1qtde.text + '6';
  end;
  if or_botao = 'Sete' then
  begin
    e1qtde.Text:= e1qtde.text + '7';
  end;
  if or_botao = 'Oito' then
  begin
    e1qtde.Text:= e1qtde.text + '8';
  end;
  if or_botao = 'Nove' then
  begin
    e1qtde.Text:= e1qtde.text + '9';
  end;
  if or_botao = 'Virgula' then
  begin
    e1qtde.Text:= e1qtde.text + ',';
  end;

end;
{------------------------------------------------------------------------------}
procedure Tfpedido.procura_produto;
begin
if e2produto.Text <> '' then
  begin
    SqlRun('SELECT CODIGOPRODUTO FROM PRODUTOASSOCIADO WHERE CODIGOPRODUTOASSOCIADO = ' +
      e2produto.Text,dtm2.produtos);
    if not dtm2.produtos.IsEmpty then
      begin
       e2produto.Text := dtm2.produtos.fields[0].AsString;
       S_codigoassociado:= dtm2.produtos.fields[0].asstring;
       SqlRun('Select codigoproduto, nomeproduto from produto where codigoproduto = ' + S_codigoassociado + '', dtm2.produtos);
       label1.caption:='Produto: ' + dtm2.produtos.fieldbyname('nomeproduto').asstring;
      end
     else
       begin
         SqlRun('Select codigoproduto, nomeproduto from produto where codigoproduto = ' + e2produto.text + '',dtm2.produtos);
         if dtm2.produtos.isempty then
           begin
             label1.caption:='C?digo Inv?lido';
             e2produto.setfocus;
             e2produto.clear;
             Exit;
           end
         else
          begin
           label1.caption:='Produto: ' + dtm2.produtos.fieldbyname('nomeproduto').asstring;
          end;
       end;
  end
else
  label1.caption:='';
v_produto := StrToFloat(e2produto.Text)  ;
SqlRun('SELECT PRECO FROM PRODUTOTABELAPRECO WHERE CODIGOPRODUTO = ' +
            e2produto.text +
            ' AND CODIGOTABELAPRECO = ' + IntToStr(I_CodigoTabelaPreco) + ';'
            , Dtm2.produtos);

if (dtm2.produtos.fields[0].asfloat <> 0) and (not dtm2.produtos.fields[0].IsNull) then
  begin
    v_produtopreco:= dtm2.produtos.Fields[0].AsFloat;
    edit1.text:= FormatFloat('0.00',dtm2.produtos.Fields[0].AsFloat);
    Edit2.Text := CurrencyString;
    e1qtde.setfocus;
  end
else
  begin
    MessageBox(Handle, 'Esse produto n?o pode ser vendido, pois n?o h? pre?o cadastrado', 'Erro', MB_ICONWARNING);
    label1.Caption := '';
    e2produto.setfocus;
    e2produto.Clear;
  end;

end;



procedure Tfpedido.procura_mesa;
var
 mesa: ShortString;
 aux: string;

begin
     mesa:=e1mesa.text;
     if (StrToFloat(Mesa) >= I_LimitePedidoMinimo)and (StrToFloat(Mesa) <= I_LimitePedidoMaximo) then
        begin
           SqlRun('SELECT SITUACAO, ORIGEMPEDIDO FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' +
           Mesa, dtm2.produtos);
      {Se o campo Situacao estiver com x na tabela PEDIDOVENDA, acesso negado!}
          if (Dtm2.produtos.FieldByName('SITUACAO').AsString <> 'X') then
             begin
                if (Dtm2.produtos.FieldByName('ORIGEMPEDIDO').AsString <> IntToStr(I_Delivery))
                  and (Dtm2.produtos.FieldByName('ORIGEMPEDIDO').AsString <> '0')
                  and (Dtm2.produtos.FieldByName('ORIGEMPEDIDO').AsString <> '') then
                  begin
                     application.MessageBox('Acesso Negado!!','Autocom - Samba',mb_ok);
                     e1mesa.SetFocus;
                     e1mesa.Clear;
                  end
                else
                  begin
                     e2produto.setfocus;
                  end;
             end
          else
             begin
                messagedlg('Esta '+ S_NomePedido +' j? foi fechada' ,mtinformation,[mbok],0);
                e1mesa.setfocus;
                e1mesa.Clear;
             end;
        end
     else
        begin
           aux:= 'Erro - A '+ S_NomePedido +' deve estar entre '+ IntToStr(I_LimitePedidoMinimo) +' e '+ IntToStr(I_LimitePedidoMaximo);
           messagedlg(aux,mtinformation,[mbok],0);
           e1mesa.setfocus;
           e1mesa.Clear;
           abort;
        end;

     v_mesa:= StrtoInt(e1mesa.Text);

end;



procedure TFpedido.E1mesaExit(Sender: TObject);
begin
  local:= 'Mesa'
end;

procedure TFpedido.e2produtoExit(Sender: TObject);
begin
  local:= 'Produto';
end;

procedure TFpedido.e1qtdeExit(Sender: TObject);
begin
  local:= 'Quantidade';
end;

procedure tfpedido.Inclui_produto;
begin
 if CodigoProdutos < 1 then
   begin
     CodigoProdutos := 1;
   end;
 produtos[codigoprodutos].Codigo:= FloatToStr(v_produto);
 Produtos[CodigoProdutos].Quantidade:= FloatToStr(v_qtde);

 produtos[codigoprodutos].Preco:= v_produtopreco;

 if B_obs = true then
   produtos[codigoprodutos].Obs:= v_obs
 else
   produtos[codigoprodutos].Obs:='';

//provavelmente inserir aqui a politica de preco
  politica_preco;
  proximo_produto;
  e2produto.Text:='';
  e1qtde.Text:='';
end;
procedure tfpedido.politica_preco;
var
  Preco: Real;
begin
  if (Produtos[CodigoProdutos-1].Quantidade = '0.5') and
    (Produtos[CodigoProdutos].Quantidade = '0.5') then
  begin
    case I_PoliticaPreco of
      0: //Normal
        Exit;
      1: //Menor Preco
      begin
        Preco := Min(Produtos[CodigoProdutos-1].Preco,
          Produtos[CodigoProdutos].Preco);
        Produtos[CodigoProdutos-1].Preco := Preco;
        Produtos[CodigoProdutos].Preco := Preco;
      end;
      2: //Maior Preco
      begin
        Preco := Max(Produtos[CodigoProdutos-1].Preco,
          Produtos[CodigoProdutos].Preco);
        Produtos[CodigoProdutos-1].Preco := Preco;
        Produtos[CodigoProdutos].Preco := Preco;
      end;
      3:  //M?dia de Pre?os
      begin
        Preco := Mean([Produtos[CodigoProdutos-1].Preco,
          Produtos[CodigoProdutos].Preco]);
        Produtos[CodigoProdutos-1].Preco := Preco;
        Produtos[CodigoProdutos].Preco := Preco;
      end;
    end;
    {Altera Valor do Array}

  end;
end;

procedure TFpedido.grava_pedido;
var
  S_CodigoNaturezaOperacao, S_CodigoCondicaoPagamento, S_CliCodCliente: ShortString;
  I_CodRecord: Integer;
  TotalProdutos: Real;
begin

  {Pega Dados necessarios para insert e guarda nas variaveis}
  SqlRun('SELECT CODIGONATUREZAOPERACAO FROM NATUREZAOPERACAO',dtm2.produtos);
  S_CodigoNaturezaOperacao := dtm2.produtos.Fields[0].AsString;
  SqlRun('SELECT CODIGOCONDICAOPAGAMENTO FROM CONDICAOPAGAMENTO',dtm2.produtos);
  S_CodigoCondicaoPagamento := dtm2.produtos.Fields[0].AsString;
  S_CliCodCliente := '1'; {Codigo Padr?o de Cliente Passante}

  {Verifica se o pedido j? existe e se j? est? fechado}
  SqlRun('SELECT SITUACAO, TOTALPRODUTOS FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' + IntToStr(v_Mesa), dtm2.produtos);
   {Total do Preco dos Produtos}
   I_CodRecord := CodigoProdutos - 1;
   while I_CodRecord <> 0 do
   begin
     TotalProdutos := TotalProdutos + (Produtos[I_CodRecord].Preco * StrToFloat(Produtos[I_CodRecord].quantidade));
     TotalProdutos := TotalProdutos + dtm2.Produtos.Fields[1].AsFloat;
     I_CodRecord := I_CodRecord - 1
   end;

    if (dtm2.produtos.IsEmpty) then
    {Insert na Tabela de PedidoVenda}
    begin

      SqlRun('INSERT INTO PEDIDOVENDA '+
             '( '+
             '  NUMEROPEDIDO, '+
             '  DATA, '+
             '  CODIGONATUREZAOPERACAO, '+
             '  CODIGOCONDICAOPAGAMENTO, '+
             '  VEN_CODVENDEDOR, '+
             '  CODIGOTABELAPRECO,  '+
             '  CLI_CODCLIENTE,  '+
             '  TOTALPRODUTOS,  '+
             '  CFG_CODCONFIG,  '+
             '  ORIGEMPEDIDO) '+
             ' VALUES ( '+
             QuotedStr(IntToStr(v_mesa)) + ',' +
             QuotedStr(FormatDateTime('MM/DD/YYYY',Date))+ ',' +
             QuotedStr(S_CodigoNaturezaOperacao)+ ',' +
             QuotedStr(S_CodigoCondicaoPagamento)+ ',' +
             QuotedStr(IntToStr(v_garcom))+ ',' +
             QuotedStr(IntToStr(I_CodigoTabelaPreco))+ ',' +
             QuotedStr(S_CliCodCliente)+ ',' +
             QuotedStr(StringReplace(FloatToStr(TotalProdutos),',','.',[])) + ',' +
             QuotedStr('1')+ ',' +
             QuotedStr(IntToStr(I_Delivery)) + ')', dtm2.produtos);
      Dtm2.IBTransaction1.CommitRetaining;
    end
    else
    begin
     SqlRun( 'UPDATE PEDIDOVENDA SET ' +
             ' TOTALPRODUTOS           = ' + QuotedStr(StringReplace(FloatToStr(TotalProdutos),',','.',[]))  +
             ' WHERE NUMEROPEDIDO = ' + QuotedStr(IntToStr(v_Mesa)), dtm2.produtos);
     Dtm2.IBTransaction1.CommitRetaining;
    end;
  grava_produto_pedido;
end;
procedure tfpedido.grava_produto_pedido;
var    controle_venda: THandle;
begin
 CodigoProdutos := CodigoProdutos - 1;
  SqlRun('SELECT CODIGOPEDIDOVENDA FROM  PEDIDOVENDA WHERE NUMEROPEDIDO = ' +
         IntToStr(v_mesa), dtm2.produtos);
  while CodigoProdutos <> 0 do
  begin
    SqlRun(' INSERT INTO PRODUTOPEDIDOVENDA '+
           ' (CODIGOPRODUTO, QUANTIDADE, PRECO, CODIGOPEDIDOVENDA, OBSERVACAO, CANCELADO) '+
           ' VALUES (' +
           QuotedStr(Produtos[CodigoProdutos].Codigo) + ',' +
           QuotedStr(StringReplace(Produtos[CodigoProdutos].Quantidade,',','.',[]))+ ', ' +
           QuotedStr(StringReplace(FloatToStr(Produtos[CodigoProdutos].Preco),',','.',[])) + ', ' +
           dtm2.produtos.Fields[0].AsString +', '+
           QuotedStr(Produtos[CodigoProdutos].Obs) +', '+
           QuotedStr('0')+' )', dtm2.conprod );

    CodigoProdutos := CodigoProdutos - 1
  end;
  Dtm2.IBTransaction1.CommitRetaining;

   {Verifica Valor da variavel chama funcao ou nao}
  if I_PrintGrill = 1 then PrintGrill(v_Mesa,S_NomePedido, S_NomeVendedor);

  {Reinicia}
  SqlRun('Commit;',Dtm2.Rede,False);
  Dtm2.IBTransaction1.Active := True;

  CodigoProdutos := 1;
  e1mesa.setfocus;
end;

Procedure tfpedido.proximo_produto;
begin
 CodigoProdutos:= CodigoProdutos + 1;
end;
procedure TFpedido.SpeedButton3Click(Sender: TObject);
begin
if (application.messagebox('Deseja Gravar Pedido?', 'Autocom - Samba',mb_yesnocancel) = IdYes) then
 begin
   grava_pedido;
   SpeedButton2.Enabled := False;
   SpeedButton3.Enabled := False;
   label1.caption:='';
   e1mesa.Text:='';
   e1mesa.setfocus;
 end;
end;

procedure TFpedido.SpeedButton4Click(Sender: TObject);
begin
if (local = 'Mesa') and (not IsNull(e1mesa.Text)) then
  begin
    SqlRun('Commit;',Dtm2.Rede,False);
    Dtm2.IBTransaction1.Active := True;
    CodigoProdutos := 1;
    ZeroMemory(@produtos,SizeOf(produtos));
    procura_mesa;
    Speedbutton2.enabled:=true;
  end;


if (local = 'Produto') and (not IsNull(e2produto.Text)) then
  begin
    procura_produto;
  end;

if (local = 'Quantidade') and (not IsNull(e1qtde.Text)) Then
   begin
     if e1qtde.Text ='' then
       e1qtde.Text:= '1';

     v_qtde:= StrToFloat(e1qtde.Text);
     if B_obs = true then
       begin
         if (application.MessageBox('Deseja Incluir Oberva??o?','Autocom - Samba',MB_YESNO) = IDYes) then
            begin
               fobs.showmodal;
            end
         else
               v_obs:='';
       end;
     Inclui_produto;
     Edit1.Clear;
     Edit2.Clear;
     SpeedButton3.Enabled:= true;
     e2produto.setfocus;
     label1.Caption := '';
   end;
end;

procedure TFpedido.printgrill(pedido:integer;nome_pedido,nome_vendedor:string);
var
   a:integer;
   v_codigo, v_quantidade, v_desc, v_obs:string;
   grill:TextFile;
   cupom:Tstrings;
begin
{Objetivo: Realizar a impress?o dos produtos em impressoras remotas para produ??o
Esta fun??o deve ser usadas nos m?dulos de venda que realizam pedidos de venda  ,
tais como: Venda Pedido, Micro Terminais e Comandas eletr?nicas                 }

     SqlRun('Commit;',dtm2.Rede,False);

     SqlRun('select codigoimpressora,caminhoimpressora,NOMEIMPRESSORA from impressora order by codigoimpressora;', Dtm2.Tbl_Impressoras);

     try
        if Dtm2.Tbl_Impressoras.IsEmpty=false then
           begin
              Dtm2.Tbl_Impressoras.first;
              while not Dtm2.Tbl_Impressoras.eof do
                 begin
                    SqlRun('select ppv.codigoproduto, ppv.quantidade, ppv.observacao, prod.nomeproduto, ppv.codigopedidovenda '+
                             'from produtopedidovenda ppv, produto prod ,pedidovenda pv, subgrupoproduto sg, grupoproduto g '+
                             'where ppv.codigoproduto=prod.codigoproduto '+
                             ' and (ppv.impresso<>'+chr(39)+'X'+chr(39)+' or ppv.impresso is null)'+
                             ' and (ppv.cancelado<>'+'1'+' or ppv.cancelado is null)'+
                             ' and ppv.codigopedidovenda=pv.codigopedidovenda'+
                             ' and pv.numeropedido='+inttostr(pedido)+
                             ' and prod.codigosubgrupoproduto=sg.codigosubgrupoproduto'+
                             ' and sg.codigogrupoproduto=g.codigogrupoproduto'+
                             ' and g.codigoimpressora='+Dtm2.Tbl_Impressoras.fieldbyname('codigoimpressora').asstring +
                             ' ORDER BY ppv.codigoprodutopedido ', Dtm2.pt);
                    if Dtm2.pt.IsEmpty=false then
                       begin
//                          Dll_Display(Codigo, CenterText('Realizando Print Grill: '+trim(Dm.Tbl_Impressoras.fieldbyname('NOMEIMPRESSORA').asstring),40));

                          SQLRun('select p.pes_nome_a '+
                             'from pessoa p, vendedor v,pedidovenda pv '+
                             'where pv.ven_codvendedor=v.ven_codvendedor '+
                             ' and v.pes_codpessoa=p.pes_codpessoa '+
                             ' and pv.numeropedido='+inttostr(pedido),dtm2.Rede);

                          cupom := TStringList.Create;
                          cupom.add('******************************');
                          cupom.add('  '+nome_pedido+' : '+inttostr(pedido));
                          cupom.add('******************************');
                          cupom.add('  '+nome_vendedor+' : '+DtM2.Rede.fieldbyname('pes_nome_a').asstring);
                          cupom.add('******************************');
                          cupom.add('Data: '+datetostr(date));
                          cupom.add('Hora: '+timetostr(time));

                          Dtm2.pt.first;
                          While not Dtm2.pt.eof do
                             Begin
                                v_codigo:=Dtm2.pt.fieldbyname('codigoproduto').asstring;
                                v_quantidade:=Dtm2.pt.fieldbyname('quantidade').asstring;
                                v_desc:=Dtm2.pt.fieldbyname('nomeproduto').asstring;
                                v_obs:=trim(Dtm2.pt.fieldbyname('observacao').asstring);

                                cupom.add(copy(v_quantidade,1,4)+'.'+copy(v_quantidade,5,3)+' ['+v_desc+']');
                                if length(v_obs)>0 then
                                   begin
                                      cupom.add(v_obs);
                                   end;
                                sqlrun('update produtopedidovenda set impresso='+chr(39)+'X'+chr(39)+
                                ' where codigoproduto='+v_codigo+
                                ' and codigopedidovenda='+Dtm2.pt.fieldbyname('codigopedidovenda').asstring,dtm2.rede,false);

                                dtm2.pt.next;
                             End;
                          cupom.add('Area de impressao: '+trim(Dtm2.Tbl_Impressoras.fieldbyname('NOMEIMPRESSORA').asstring));
                          cupom.add('Pedido efetuado por: '+fpedido.e2garcom.Text);
                          cupom.add('-- Sistema Autocom --');
                          cupom.add(chr(10)+chr(13));
                          cupom.add(chr(10)+chr(13));
                          cupom.add(chr(10)+chr(13));
                          cupom.add(chr(10)+chr(13));

                          AssignFile(grill, trim(Dtm2.Tbl_Impressoras.fieldbyname('caminhoimpressora').asstring));
                          rewrite(grill);
                          for a:=0 to cupom.count-1 do
                             begin
                                writeln(grill,cupom.Strings[a]);
                             end;
                          closefile(grill);
                          FreeAndNil(cupom);
                       end;
                    Dtm2.Tbl_Impressoras.next;
                 end;
           end;

        SqlRun('Commit;',dtm2.rede,False);

     except
        on e:exception do
           begin
              SqlRun('commit',dtm2.rede,False);
              Showmessage('Erro de impressao na Print Grill: '+chr(13)+
                           trim(Dtm2.Tbl_Impressoras.fieldbyname('NOMEIMPRESSORA').asstring));
           end;
     end;
end;


initialization
begin
  if IniRead(ExtractFilePath(Application.exename) + 'DADOS\AUTOCOM.INI', 'SAMBA','PRINTGRILL') = '1' then
end;

finalization
begin
end;
end.
