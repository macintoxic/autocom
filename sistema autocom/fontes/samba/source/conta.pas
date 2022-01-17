unit conta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ComCtrls, ExtCtrls, IniFiles;

type
  TFconta = class(TForm)
    RichEdit1: TRichEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    GroupBox1: TGroupBox;
    e1pessoas: TEdit;
    GroupBox2: TGroupBox;
    e2servico: TEdit;
    lblservico: TLabel;
    Panel1: TPanel;
    btnhcsete: TBitBtn;
    btnhcoito: TBitBtn;
    btnhcnove: TBitBtn;
    btnhcseis: TBitBtn;
    btnhccinco: TBitBtn;
    btnhcquatro: TBitBtn;
    btnhctres: TBitBtn;
    btnhcdois: TBitBtn;
    btnhcHum: TBitBtn;
    btnhczero: TBitBtn;
    btnhcvirgula: TBitBtn;
    btnhclimpa: TBitBtn;
    SpeedButton4: TSpeedButton;
    GroupBox3: TGroupBox;
    edmesa: TEdit;
    SpeedButton3: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure fecha_pedido;
    procedure Entra_pessoas;
    procedure Entra_servico;
    procedure Entra_Mesa;
    procedure pega_produtos;
    procedure Imprimir(QtdeProdutos: Integer);
    procedure verifica_status;
    procedure e1pessoasExit(Sender: TObject);
    procedure e1pessoasEnter(Sender: TObject);
    procedure e2servicoEnter(Sender: TObject);
    procedure e2servicoExit(Sender: TObject);
    procedure btnhczeroClick(Sender: TObject);
    procedure btnhcvirgulaClick(Sender: TObject);
    procedure btnhclimpaClick(Sender: TObject);
    procedure btnhcHumClick(Sender: TObject);
    procedure btnhcdoisClick(Sender: TObject);
    procedure btnhctresClick(Sender: TObject);
    procedure btnhcquatroClick(Sender: TObject);
    procedure btnhccincoClick(Sender: TObject);
    procedure btnhcseisClick(Sender: TObject);
    procedure btnhcseteClick(Sender: TObject);
    procedure btnhcoitoClick(Sender: TObject);
    procedure btnhcnoveClick(Sender: TObject);
    procedure edmesaEnter(Sender: TObject);
    procedure edmesaExit(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fconta: TFconta;
  ValorServico: ShortString;
  NPessoas: integer;
  orhbotao:string;
  consorigem, Vendedor: String;
  Codigo: boolean;

implementation

Uses cme, pedido, autocom, dtm2_u;

{$R *.dfm}

procedure TFconta.FormActivate(Sender: TObject);
begin
     fconta.top:=0;
     fconta.left:=0;
     fconta.width:=247;
     fconta.height:=297;
     verifica_status;
end;

procedure TFconta.verifica_status;
begin
  if consorigem = 'Consulta' then
       begin
         groupbox1.Visible:=false;
         groupbox2.Visible:=false;
         groupbox3.Visible:=false;
         SpeedButton3.Visible:=false;
         SpeedButton4.Visible:=false;
         RichEdit1.Visible:=true;
         panel1.Visible:=false;
         pega_produtos;
         Imprimir(CodigoProdutos);
         SpeedButton2.Visible := False;
       end;

     if consorigem = 'Normal' then
        begin
          groupbox1.Visible:=true;
          speedbutton4.Visible:= True;
          speedbutton3.Visible:= True;
          groupbox3.Visible:=true;
          speedbutton3.Enabled:=false;
          groupbox3.caption:= S_NomePedido;
          edmesa.text:='';
          e1pessoas.text:='';
          if B_Servico = true then
            Begin
             groupbox2.Visible:= true;
             lblservico.Caption:= R_ServicoDes;
             e2servico.text:= FloatToStr(taxaservico);
             ValorServico:=FloatToStr(taxaservico);
             edmesa.setfocus;
            end
          else
            begin
             ValorServico:='0';
             edmesa.SetFocus;
            end;
    end;
end;

procedure TFconta.SpeedButton1Click(Sender: TObject);
begin
     consorigem:='Normal';
     richedit1.Lines.Clear;
     RichEdit1.Visible:=false;
     fconta.close;
     RichEdit1.Clear;
end;

procedure TFconta.SpeedButton4Click(Sender: TObject);
var libera:boolean;
begin
  if (local = 'Pessoas') or (e1pessoas.text <>'') then
     begin
     NPessoas:= StrToInt(e1pessoas.Text);
     if B_Servico then
          begin
           libera:= true;
           e2servico.setfocus;
          end
        else
          begin
           libera:=true;
          end;
     panel1.Visible:= false;
     end;
  if (local = 'Servico') then
     begin
      ValorServico:= e2servico.text;
      panel1.visible:=false;

      e1pessoas.SetFocus;
     end;
  ValorServico:=e2servico.text;
  if (local = 'Mesa')  then
     begin
        v_mesa:= StrToInt(edmesa.text);
        panel1.Visible:=false;
        e1pessoas.setfocus;
     end;
  if (edmesa.Text <>'') and (e1pessoas.text <>'') and (libera) then
     begin
       speedbutton3.enabled:=true;
     end;

end;

procedure TFconta.Entra_pessoas;
begin
   if orhbotao = 'Limpa' Then
   begin
     e1pessoas.Text:='';
     e1pessoas.SetFocus;
   end;
   if orhbotao = 'Zero' then
   begin
    e1pessoas.Text:= e1pessoas.text + '0';
   end;
   if orhbotao = 'Hum' then
   begin
    e1pessoas.Text:= e1pessoas.text + '1';
   end;
   if orhbotao = 'Dois' then
   begin
    e1pessoas.Text:= e1pessoas.text + '2';
   end;
   if orhbotao = 'Tres' then
   begin
    e1pessoas.Text:= e1pessoas.text + '3';
   end;
   if orhbotao = 'Quatro' then
   begin
    e1pessoas.Text:= e1pessoas.text + '4';
   end;
   if orhbotao = 'Cinco' then
   begin
    e1pessoas.Text:= e1pessoas.text + '5';
   end;
   if orhbotao = 'Seis' then
   begin
    e1pessoas.Text:= e1pessoas.text + '6';
   end;
   if orhbotao = 'Sete' then
   begin
    e1pessoas.Text:= e1pessoas.text + '7';
   end;
   if orhbotao = 'Oito' then
   begin
    e1pessoas.Text:= e1pessoas.text + '8';
   end;
   if orhbotao = 'Nove' then
   begin
    e1pessoas.Text:= e1pessoas.text + '9';
   end;
    if orhbotao = 'Virgula' then
   begin
    e1pessoas.Text:= e1pessoas.text + '';
   end;
end;
procedure tfconta.fecha_pedido;
var
  R_TotalProdutos: Real;
  R_TotalPedido: Real;
begin
    {Pega Valores na Tabela}
    SqlRun('SELECT TOTALPRODUTOS FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' + INtToStr(v_mesa)
           , dtm2.consubgrpo);
    R_TotalProdutos :=  dtm2.consubgrpo.Fields[0].AsFloat;

    {Soma Valor Total}
    if ValorServico = '' then ValorServico := '1';
    If (R_ServicoPer <> 0) then
      {Acrescimo em Porcentagem}
      R_TotalPedido := (R_TotalProdutos * (StrToFloat(ValorServico) / 100)) + R_TotalProdutos
    else
      {Acrescimo em Dinheiro}
      R_TotalPedido := R_TotalProdutos + StrToFloat(ValorServico);
    {Update na Tabela}
    SqlRun( ' update PEDIDOVENDA ' +
            ' set  '+
            ' SITUACAO = ' + QuotedStr('Z') + ' , ' +
            ' NUMPESSOAS = ' + QuotedStr(IntToStr(npessoas)) + ' , ' +
            ' DESPESASACESSORIAS = ' + QuotedStr(StringReplace(ValorServico,',','.', [])) + ' , ' +
            ' TOTALPEDIDO = ' + QuotedStr(StringReplace(FloatToStr(R_TotalPedido),',','.', [])) +
            ' where ' +
            ' NumeroPedido = ' + IntToStr(v_mesa)
            , dtm2.consubgrpo);
  SqlRun('Commit;',Dtm2.Rede,False);
  Dtm2.IBTransaction1.Active := True;

    if CodigoProdutos < 1 then
    begin
      {Reinicia}
      CodigoProdutos := 1;
    end;
  {Reinicia}
  application.MessageBox('Pedido Fechado','Autocom - Samba',MB_ICONINFORMATION);
  CodigoProdutos := 1;
end;
procedure TFconta.e1pessoasExit(Sender: TObject);
begin
local:= 'Pessoas';
end;

procedure TFconta.e1pessoasEnter(Sender: TObject);
begin
panel1.Visible:= true;
end;

procedure TFconta.e2servicoEnter(Sender: TObject);
begin
panel1.visible:=true;

end;

procedure TFconta.e2servicoExit(Sender: TObject);
begin
  local:='Servico';
end;

procedure TFconta.btnhczeroClick(Sender: TObject);
begin
  orhbotao:= 'Zero';
  if local = 'Pessoas'    then Entra_pessoas;
  if local = 'Servico'    then Entra_servico;
  if local = 'Mesa'    then Entra_mesa;
end;


procedure tfconta.Entra_servico;
begin
if orhbotao = 'Limpa' Then
   begin
     e2servico.Text:='';
     e2servico.SetFocus;
   end;
   if orhbotao = 'Zero' then
   begin
    e2servico.Text:= e2servico.text + '0';
   end;
   if orhbotao = 'Hum' then
   begin
    e2servico.Text:= e2servico.text + '1';
   end;
   if orhbotao = 'Dois' then
   begin
    e2servico.Text:= e2servico.text + '2';
   end;
   if orhbotao = 'Tres' then
   begin
    e2servico.Text:= e2servico.text + '3';
   end;
   if orhbotao = 'Quatro' then
   begin
    e2servico.Text:= e2servico.text + '4';
   end;
   if orhbotao = 'Cinco' then
   begin
    e2servico.Text:= e2servico.text + '5';
   end;
   if orhbotao = 'Seis' then
   begin
    e2servico.Text:= e2servico.text + '6';
   end;
   if orhbotao = 'Sete' then
   begin
    e2servico.Text:= e2servico.text + '7';
   end;
   if orhbotao = 'Oito' then
   begin
    e2servico.Text:= e2servico.text + '8';
   end;
   if orhbotao = 'Nove' then
   begin
    e2servico.Text:= e2servico.text + '9';
   end;
    if orhbotao = 'Virgula' then
   begin
    e2servico.Text:= e2servico.text + ',';
    end;
end;

procedure tfconta.Entra_Mesa;
begin
   if orhbotao = 'Limpa' Then
   begin
     edmesa.Text:='';
     edmesa.SetFocus;
   end;
   if orhbotao = 'Zero' then
   begin
    edmesa.Text:= edmesa.text + '0';
   end;
   if orhbotao = 'Hum' then
   begin
    edmesa.Text:= edmesa.text + '1';
   end;
   if orhbotao = 'Dois' then
   begin
    edmesa.Text:= edmesa.text + '2';
   end;
   if orhbotao = 'Tres' then
   begin
    edmesa.Text:= edmesa.text + '3';
   end;
   if orhbotao = 'Quatro' then
   begin
    edmesa.Text:= edmesa.text + '4';
   end;
   if orhbotao = 'Cinco' then
   begin
    edmesa.Text:= edmesa.text + '5';
   end;
   if orhbotao = 'Seis' then
   begin
    edmesa.Text:= edmesa.text + '6';
   end;
   if orhbotao = 'Sete' then
   begin
    edmesa.Text:= edmesa.text + '7';
   end;
   if orhbotao = 'Oito' then
   begin
    edmesa.Text:= edmesa.text + '8';
   end;
   if orhbotao = 'Nove' then
   begin
    edmesa.Text:= edmesa.text + '9';
   end;
    if orhbotao = 'Virgula' then
   begin
    edmesa.Text:= edmesa.text + '';
   end;
end;

procedure TFconta.btnhcvirgulaClick(Sender: TObject);
begin
  orhbotao:= 'Virgula';
  if local = 'Servico'    then Entra_servico;
end;

procedure TFconta.btnhclimpaClick(Sender: TObject);
begin
  orhbotao:= 'Limpa';
  if local = 'Pessoas'    then Entra_pessoas;
  if local = 'Servico'    then Entra_servico;
  if local = 'Mesa'       then Entra_mesa;
end;

procedure TFconta.btnhcHumClick(Sender: TObject);
begin
  orhbotao:= 'Hum';
  if local = 'Pessoas'    then Entra_pessoas;
  if local = 'Servico'    then Entra_servico;
  if local = 'Mesa'       then Entra_mesa;

end;

procedure TFconta.btnhcdoisClick(Sender: TObject);
begin
  orhbotao:= 'Dois';
  if local = 'Pessoas'    then Entra_pessoas;
  if local = 'Servico'    then Entra_servico;
  if local = 'Mesa'       then Entra_mesa;

end;

procedure TFconta.btnhctresClick(Sender: TObject);
begin
  orhbotao:= 'Tres';
  if local = 'Pessoas'    then Entra_pessoas;
  if local = 'Servico'    then Entra_servico;
  if local = 'Mesa'       then Entra_mesa;

end;

procedure TFconta.btnhcquatroClick(Sender: TObject);
begin
  orhbotao:= 'Quatro';
  if local = 'Pessoas'    then Entra_pessoas;
  if local = 'Servico'    then Entra_servico;
  if local = 'Mesa'       then Entra_mesa;

end;

procedure TFconta.btnhccincoClick(Sender: TObject);
begin
  orhbotao:= 'Cinco';
  if local = 'Pessoas'    then Entra_pessoas;
  if local = 'Servico'    then Entra_servico;
  if local = 'Mesa'       then Entra_mesa;

end;

procedure TFconta.btnhcseisClick(Sender: TObject);
begin
  orhbotao:= 'Seis';
  if local = 'Pessoas'    then Entra_pessoas;
  if local = 'Servico'    then Entra_servico;
  if local = 'Mesa'       then Entra_mesa;

end;

procedure TFconta.btnhcseteClick(Sender: TObject);
begin
  orhbotao:= 'Sete';
  if local = 'Pessoas'    then Entra_pessoas;
  if local = 'Servico'    then Entra_servico;
  if local = 'Mesa'       then Entra_mesa;

end;

procedure TFconta.btnhcoitoClick(Sender: TObject);
begin
  orhbotao:= 'Oito';
  if local = 'Pessoas'    then Entra_pessoas;
  if local = 'Servico'    then Entra_servico;
  if local = 'Mesa'       then Entra_mesa;

end;

procedure TFconta.btnhcnoveClick(Sender: TObject);
begin
  orhbotao:= 'Nove';
  if local = 'Pessoas'    then Entra_pessoas;
  if local = 'Servico'    then Entra_servico;
  if local = 'Mesa'       then Entra_mesa;
end;

procedure tfconta.pega_produtos;
{Pega Produtos Vendidos da Tabela e Joga no Array}
begin
  SqlRun('Commit;',Dtm2.Rede,False);
  SqlRun('SELECT CODIGOPEDIDOVENDA FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' + IntToStr(v_mesa)  ,dtm2.consubgrpo);
  dtm2.consubgrpo.First;
  if dtm2.consubgrpo.IsEmpty then Exit;
  SqlRun('SELECT CODIGOPRODUTO, QUANTIDADE, PRECO, OBSERVACAO ' +
         ' FROM PRODUTOPEDIDOVENDA WHERE CANCELADO='+QUOTEDSTR('0')+' AND CODIGOPEDIDOVENDA = ' + dtm2.consubgrpo.Fields[0].AsString , dtm2.conprod);
  ZeroMemory(@produtos, SizeOf(Produtos));
  CodigoProdutos := 1;
  Dtm2.conprod.First;
  while not dtm2.conprod.Eof do
  begin
    Produtos[CodigoProdutos].Codigo := dtm2.conprod.FieldByName('CODIGOPRODUTO').AsString;
    Produtos[CodigoProdutos].Quantidade := dtm2.conprod.FieldByName('QUANTIDADE').AsString;
    Produtos[CodigoProdutos].Preco := dtm2.conprod.FieldByName('PRECO').AsFloat;
    Produtos[CodigoProdutos].Obs := dtm2.conprod.FieldByName('OBSERVACAO').AsString;
    CodigoProdutos := CodigoProdutos + 1;
    dtm2.conprod.Next;
  end;
  CodigoProdutos := CodigoProdutos - 1;
end;

procedure TFconta.edmesaEnter(Sender: TObject);
begin
panel1.Visible:= true;
end;

procedure TFconta.edmesaExit(Sender: TObject);
begin
local:='Mesa';
end;

procedure TFconta.SpeedButton3Click(Sender: TObject);
begin
 consorigem := 'Consulta';
 verifica_status;
 codigo:= true;
 SpeedButton2.Visible := True;
end;

procedure TFconta.Imprimir(QtdeProdutos:Integer);
var
   cupom: TStrings;
   TotalPedido :Real;
   i :Integer;
   txtFile: TextFile;
   PrinterPatch: ShortString;
   Ordem: Integer;
   straux, aux, nomevendedor: string;
   TotalPessoa: Real;
begin

   {Pega Endereco da Impressoara do Banco de Dados  }

    aux:='SELECT CAMINHOIMPRESSORA FROM IMPRESSORA WHERE CODIGOIMPRESSORA = '
         + IniRead(patch + 'AUTOCOM.INI', Garcom,'CODIGOIMPRESSORA');
   SqlRun(aux, dtm2.Tbl_Impressoras);
   PrinterPatch := dtm2.Tbl_Impressoras.Fields[0].AsString;

   {Faz Consulta no Pedido para Gravar Dados}
   SqlRun('SELECT * FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' +
     IntToStr(V_mesa), dtm2.Tbl_Impressoras);

  if dtm2.Tbl_Impressoras.IsEmpty then
    begin
      MessageBox(Handle,'É necessario gravar o pedido antes de consulta-lo!','Atenção',MB_ICONWARNING);
      Fconta.Close;
      abort;
    end;

   TotalPedido := dtm2.Tbl_Impressoras.FieldByName('TOTALPRODUTOS').AsFloat;

   {Rotina para Impressao em Impressora Windows 40 Colunas}
   cupom := TStringList.Create;
   if consorigem = 'Consulta' then
     begin
        cupom.Add('----------------------------------------');
        cupom.Add(CenterText(S_NomePedido +' ' + IntToSTr(v_mesa)));
        cupom.Add('ITEM         CODIGO            DESCRICAO');
        cupom.Add('QUANTIDADE ');
        cupom.Add('----------------------------------------');
     end
   else
     begin
        cupom.Add('----------------------------------------');
        cupom.Add(CenterText(Format('DATA: %s HORA: %s ', [DateToStr(now),TimeToStr(now)])));//Agora imprime a data
        cupom.Add('Impressao via comanda eletronica ');
        cupom.Add('----------------------------------------');
        cupom.Add(CenterText(S_NomePedido +' ' + IntToSTr(v_mesa)));
        cupom.Add('----------------------------------------');
        cupom.Add('ITEM         CODIGO            DESCRICAO');
        cupom.Add('QUANTIDADE x VALOR UNIT.     VALOR ('+ CurrencyString + ')');
        cupom.Add('----------------------------------------');
     end;
   Ordem := 1; {Varival de ordem dos produtos na Nota}
   while QtdeProdutos <> 0 do
   begin
    SqlRun(' SELECT P.NOMEPRODUTO FROM PRODUTO P WHERE P.CODIGOPRODUTO = ' +
           Produtos[QtdeProdutos].Codigo + ';', dtm2.Rede);

     cupom.Add(Format('%0.3d %s %s ',
     [Ordem, FormatFloat('0000000000000', StrToFloat(Produtos[QtdeProdutos].Codigo)),
     (dtm2.Rede.Fields[0].AsString)]));

     if consorigem = 'Consulta' then
     begin
        cupom.Add(Format('%3.2f',
        [ StrToFloat(Produtos[QtdeProdutos].Quantidade)]));
     end
     else
     begin
        cupom.Add(Format('%3.3fx%11.2f = ' +  CurrencyString + '%15.2f',
        [ StrToFloat(Produtos[QtdeProdutos].Quantidade), Produtos[QtdeProdutos].Preco,
        (Produtos[QtdeProdutos].Preco * StrToFloat(Produtos[QtdeProdutos].Quantidade))]));
     end;
     Ordem := Ordem + 1;
     QtdeProdutos := QtdeProdutos - 1;
   end;


     cupom.Add('----------------------------------------');
     cupom.Add(Format('SUBTOTAL      = ' + CurrencyString + '%12.2f',[TotalPedido]));
     cupom.Add('');

     if not IsNull(ValorServico) then
     begin
       if B_Servico then
       begin
         if R_ServicoPer <> 0 then
            begin
              cupom.Add(Format('SERVICO       = %2.2F%% ', [StrToFloat(ValorServico)]));
              cupom.Add(Format('TOTAL A PAGAR = ' + CurrencyString + '%12.2f',[TotalPedido + TotalPedido * StrToFloat(ValorServico)/100]));
           end;

         if R_ServicoVal <> 0 then
            begin
               cupom.Add(Format('SERVICO       = %f ', [StrToFloat(ValorServico)]));
               cupom.Add(Format('TOTAL A PAGAR = ' + CurrencyString + '%12.2f',[TotalPedido + StrToFloat(ValorServico)]));
            end;
       end;
     end;
      //Pega Código do Vendedor
         SqlRun(' SELECT V.CODIGOVENDEDOR ' +
                ' FROM PEDIDOVENDA PV ' +
                ' INNER JOIN VENDEDOR V ON (V.VEN_CODVENDEDOR = PV.VEN_CODVENDEDOR) ' +
                ' WHERE PV.NUMEROPEDIDO = ' + IntToStr(v_mesa) + ';'
                 , dtm2.Rede);
         Vendedor := dtm2.Rede.Fields[0].AsString;

         SQLRun('select p.pes_nome_a '+
                'from pessoa p, vendedor v,pedidovenda pv '+
                'where pv.ven_codvendedor=v.ven_codvendedor '+
                ' and v.pes_codpessoa=p.pes_codpessoa '+
                ' and pv.numeropedido='+inttostr(v_mesa),dtm2.Rede);
         NomeVendedor := trim(dtm2.Rede.Fields[0].AsString);

       cupom.Add('');
       cupom.Add('----------------------------------------');
              cupom.Add(S_NomeVendedor + ': ' + Vendedor+' - '+NomeVendedor);

      {Divide Total por Pessoa}
       if NPessoas > 1 then
       begin
         if (B_Servico) and (R_ServicoPer <> 0) then
           TotalPessoa := TotalPedido + (TotalPedido * StrToFloat(ValorServico)/100)
         else
           TotalPessoa := TotalPedido + StrToFloat(ValorServico);
         TotalPessoa := TotalPessoa / NPessoas;
         cupom.add(format('TOTAL POR PESSOA (%d) ' + CurrencyString + '%8.2f',[ NPessoas , TotalPessoa ]));
       end;

     cupom.Add('----------'+ TITULO_MENSAGEM + '----------');
     cupom.Add('');
     cupom.Add('');
     cupom.Add('');


     {Alinha Colunas (40 Carateres)}
     for i := 0 to cupom.Count - 1 do
     begin
          straux := cupom.Strings[i];
          if Length(straux) > 40 then
          begin
              Insert(#10#13,straux,40);
              cupom.Strings[i] := straux;
          end;
     end;

     {Escreve}
     if consorigem = 'Consulta' then
        begin
           for i:= 0 to cupom.Count - 1 do richedit1.Lines.Add(cupom.strings[i]);
        end
     else
        begin
           AssignFile(txtFile,PrinterPatch);
           Rewrite(txtFile);
           for i := 0 to cupom.Count - 1 do Writeln(txtfile,cupom.Strings[i]);
           {Adiciona Mensagem de Cortesia Linha configuradas no Ini}
           with TIniFile.Create(patch + 'AUTOCOM.INI') do
              begin
                 ReadSectionValues('CORTESIA', cupom);
                 Free;
              end;
           {Adiciona Quebras de Linha configuradas no Ini }
           for i := 0 to StrToInt(IniRead(patch + 'AUTOCOM.INI', 'IMPRESSORA','QUEBRADELINHA')) do
              begin
                 Cupom.Add(#13);
              end;
           for i := 0 to cupom.Count - 1 do Writeln(txtfile,Copy(cupom.Strings[i],Pos('=',cupom.Strings[i])+1,40));
           closefile(txtFile);
        end;
     FreeAndNil(cupom);
end;

procedure TFconta.SpeedButton2Click(Sender: TObject);
begin
 if codigo then
   begin
       consorigem:='Normal';
       pega_produtos;
       Imprimir(CodigoProdutos);
       fecha_pedido;
       e1pessoas.Text:='';
       if B_Servico then
         e2servico.Text:='';
       edmesa.Text:='';
       Close;
   end
 else
   begin
    consorigem:='Normal';
    pega_produtos;
    Imprimir(CodigoProdutos);
    Close;
   end;
  RichEdit1.Clear;
  RichEdit1.Visible:=False;
end;

end.
