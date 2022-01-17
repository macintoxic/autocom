unit financeiro_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Grids, DBGrids, DB, ExtCtrls, StrUtils,
  ActnMan, ActnColorMaps, ActnList, XPStyleActnCtrls, ToolWin, ActnCtrls, inifiles,
  ImgList ;

type
  TFrmFinanceiro = class(TForm)
    Label1: TLabel;
    SpeedButton2: TSpeedButton;
    GroupBox1: TGroupBox;
    RBcontapagar: TRadioButton;
    RBcontareceber: TRadioButton;
    GroupBox2: TGroupBox;
    chkemissao: TCheckBox;
    Label3: TLabel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label4: TLabel;
    GroupBox3: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    DateTimePicker3: TDateTimePicker;
    DateTimePicker4: TDateTimePicker;
    GrdConta: TDBGrid;
    dsprincipal: TDataSource;
    Panel1: TPanel;
    Label7: TLabel;
    EdDiasatraso: TEdit;
    Label8: TLabel;
    DateTimePicker5: TDateTimePicker;
    Label9: TLabel;
    cmbportadores: TComboBox;
    Label10: TLabel;
    EdMovimentacao: TEdit;
    SpeedButton3: TSpeedButton;
    lblmovimentacao: TLabel;
    Label12: TLabel;
    EDfornec: TEdit;
    SpeedButton4: TSpeedButton;
    Label13: TLabel;
    EDHistorico: TEdit;
    lblfornec: TLabel;
    Panel2: TPanel;
    SpeedButton5: TSpeedButton;
    Panel3: TPanel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    EDcodmoeda: TEdit;
    SpeedButton6: TSpeedButton;
    lblnomemoeda: TLabel;
    Label19: TLabel;
    EDindimoeda: TEdit;
    Label20: TLabel;
    Edit9: TEdit;
    Label21: TLabel;
    EDValorTotal: TEdit;
    ActionToolBar1: TActionToolBar;
    ActionManager1: TActionManager;
    Action1: TAction;
    Action2: TAction;
    Label14: TLabel;
    EdDoctoOrigem: TEdit;
    Label18: TLabel;
    cmbinformacao: TComboBox;
    ImageList1: TImageList;
    Action3: TAction;
    Label2: TLabel;
    EDTotal: TEdit;
    Label11: TLabel;
    DTdatavencimento: TDateTimePicker;
    Label22: TLabel;
    EDnrodcto: TEdit;
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure cmbportadoresDropDown(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure GrdContaDblClick(Sender: TObject);
    procedure cmbinformacaoDropDown(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Conecta_db;
    procedure Grava_registros;
    procedure Pega_Dados;
    Function Formata_Valores(texto:string;QtdAntes,QtdDepois:Integer):string;

  end;

var
  FrmFinanceiro: TFrmFinanceiro;
  Path, Origem, Origem1, FileName,Teste, TipoOrigem, codpessoa: String;
  achou: boolean;
  codlancpr: String;
  codconjunto, situacao: Integer;
  codconta, codtransacao, nivelconta, codlancto: string;
  debito, credito, codcontapagreceb, tipoinf :string;
implementation

Uses uglobal, dm_u, pessoa, grupo;

{$R *.dfm}
//********************** Funções **************************************************

Function TFrmFinanceiro.Formata_Valores(texto:string;QtdAntes,QtdDepois:Integer):string; //QtdAntes = Qtde de caracteres antes da vírgula e QtdDepois é a qtde depois da vírgula
Var                                                                                           //Aceita " , " e " % "
   virgula: integer;
   antes, depois: string;
Begin
     virgula := pos(',', texto);
     If virgula > 0 then
        Begin
             antes := trimAll(copy(texto,1,virgula-1));
             depois := trimall(copy(texto,virgula+1,QtdDepois));
        End
     Else
         Begin
              antes := trimAll(texto);
              depois := '';
         End;

     While length(depois) < QtdDepois do
           depois := depois + '0';

     Teste := '0';
     While (length(antes) > 1) and (teste = '0') do
           Begin
                teste := copy(antes,1,1);
                If teste = '0' then
                   delete(antes,1,1);
           End;

     If length(antes) = 0 then
        antes := '0';

     Texto := antes + depois;
     While length(Texto) < (QtdAntes + QtdDepois) do
           Texto := ' ' + texto;

     Result := texto;
End;

//**********************************************************************************



procedure TFrmFinanceiro.Conecta_db;
var ini:Tinifile;
    t1,t2:string;
begin
   dm.DBAutocom.Connected:=false;
   dm.Trans.active:=false;
   ini:=TIniFile.Create(path+'Dados\Autocom.ini');
   t1:=ini.readstring('ATCPLUS','IP_SERVER','');
   t2:=ini.readstring('ATCPLUS','PATH_DB','');
   ini.free;
   dm.DBAutocom.databasename:=t1+':'+t2;
   try
      dm.DBAutocom.connected:=true;
      dm.Trans.active:=true;
   except
      application.MessageBox('Ocorreu algum erro ao tentar abrir Banco de Dados','Autocom PLUS',MB_ICONERROR);
   end;
end;

procedure TFrmFinanceiro.Action1Execute(Sender: TObject);

begin
   Grava_registros;
   showmessage ('Gravou');
end;

procedure TFrmFinanceiro.Action2Execute(Sender: TObject);
begin
   if (panel1.Visible = true) then
     begin
       panel1.visible:=false;
       GrdConta.Height:= 418;
        
     end
   else
     Begin
       panel1.Visible:= true;
       GrdConta.Height:= 129;
     end;
end;

procedure TFrmFinanceiro.FormActivate(Sender: TObject);
begin
   RBcontapagar.Checked:= true;
   path:= ExtractFilePath(Application.ExeName);
   Conecta_db;
   filename:= 'Financ' + FormatDateTime('yyyymmdd',now) + '.log';
   logsend(filename,'Abertura do Módulo Financeiro');
   DateTimePicker1.date:= now;
   DateTimePicker2.date:= now;
   DateTimePicker3.date:= now;
   DateTimePicker4.date:= now;
   DateTimePicker5.date:= now;
   DTdatavencimento.Date:=now;
   panel1.Visible:=false;
   GrdConta.Height:= 418;  
end;

procedure TFrmFinanceiro.cmbportadoresDropDown(Sender: TObject);
begin
   cmbportadores.items.Clear;
   sqlrun('Select * from portadores', dm.portadores);
   while not dm.portadores.Eof do
     begin
       cmbportadores.items.Add(dm.portadores.fieldbyname('portador').asstring);
       dm.portadores.Next;
     end;
end;

procedure TFrmFinanceiro.SpeedButton3Click(Sender: TObject);
begin
   sqlrun('Select codigoconjunto as codigo, nome, tor_codtipoorigem as Tipo from conjuntos', dm.Consulta);
   Origem:='Movimentacao';
   application.CreateForm(TFrmgrupo, Frmgrupo);
   Frmgrupo.Showmodal;
   Frmgrupo.Destroy;
end;

procedure TFrmFinanceiro.SpeedButton4Click(Sender: TObject);
begin
   if (Origem1 = 'Fornecedores') then
      begin
         sqlrun('select f.frn_codfornecedor as codigo, f.codigofornecedor as codigoF, p.pes_nome_a as Nome, '
            + ' p.pes_codpessoa as codp  from'
            + ' fornecedor f, pessoa p where (f.pes_codpessoa=p.pes_codpessoa)',dm.Consulta);
         achou:=true;
      end;
   if (Origem1 = 'Cliente') then
      begin
         sqlrun('select c.codigocliente as codigo, c.pes_codpessoa, c.con_codconta, p.pes_codpessoa, p.pes_nome_a as nome,'
            + 'p.tpe_codtipopessoa from cliente c, pessoa p where'
            + ' (c.pes_codpessoa = p.pes_codpessoa) and (p.tpe_codtipopessoa = 1)' ,dm.consulta);
         Dm.Consulta.Fields[1].Visible := False;
         Dm.Consulta.Fields[2].Visible := False;
         Dm.Consulta.Fields[3].Visible := False;
         Dm.Consulta.Fields[5].Visible := False;
         achou:=true;
      end;
   application.CreateForm(TFrmPessoa, FrmPessoa);
   FrmPessoa.Showmodal;
   FrmPessoa.Destroy;
end;

procedure TFrmFinanceiro.SpeedButton2Click(Sender: TObject);
begin
   if RBcontapagar.Checked = true then
     begin
        label1.caption:= 'Lançamento de Contas a Pagar';
        label12.caption:= 'FORNECEDORES';
        tipoorigem:= '1';
        Origem1:='Fornecedores';
        logsend(filename,'Executando Contas a Pagar');
        if (chkemissao.Checked  = True) then
           begin
             logsend(filename,'Executando Query com retorno');
             sqlrun('Select * from contaspagarreceber c where c.codigocontapagarreceber'
                + ' not in (select codigocontapagarreceber from lancamentoscpr) and (tipocontapagarreceber= 1) And '
                + '(datavencimento between '
                + chr(39) + formatDateTime('mm/dd/yyyy',DateTimePicker3.Date)+ chr(39) + ' And '
                + chr(39) + formatDateTime('mm/dd/yyyy',DateTimePicker4.Date)+ chr(39) + ')',dm.principal);
           end
        else
           begin
             logsend(filename,'Executando Query com retorno');
             sqlrun('Select * from contaspagarreceber c where c.codigocontapagarreceber'
                + ' not in (select codigocontapagarreceber from lancamentoscpr) and (tipocontapagarreceber= 1)',dm.principal);
           end;
       if (dm.principal.eof = true) then
          begin
            logsend(filename,'cliente não conseguiu encontrar documentos pendentes no período solicitado');
            application.MessageBox('Não existe documentos pendentes no período', 'Autocom PLUS',MB_ICONINFORMATION);
            DateTimePicker3.SetFocus;
          end;
     end;
   if RBcontareceber.Checked = true then
      begin
         label1.caption:= 'Lançamento de Contas a Receber';
         label12.caption:= 'CLIENTE';
         Origem1:='Cliente';
         tipoorigem:='2';
         logsend(filename,'Executando Contas a Receber');
         if (chkemissao.Checked  = True) then
           begin
             logsend(filename,'Executando Query com retorno');
             sqlrun('Select * from contaspagarreceber c where c.codigocontapagarreceber'
                + ' not in (select codigocontapagarreceber from lancamentoscpr) and (tipocontapagarreceber= 2) And '
                + '(datavencimento between '
                + chr(39) + formatDateTime('mm/dd/yyyy',DateTimePicker3.Date)+ chr(39) + ' And '
                + chr(39) + formatDateTime('mm/dd/yyyy',DateTimePicker4.Date)+ chr(39) + ')',dm.principal);
           end
         else
           begin
             logsend(filename,'Executando Query com retorno');
             sqlrun('Select * from contaspagarreceber c where c.codigocontapagarreceber'
                + ' not in (select codigocontapagarreceber from lancamentoscpr) and (tipocontapagarreceber= 2)',dm.principal);
           end;
         if (dm.principal.eof = true) then
            begin
              logsend(filename,'cliente não conseguiu encontrar documentos pendentes no período solicitado');
              application.MessageBox('Não existe documentos pendentes no período', 'Autocom PLUS',MB_ICONINFORMATION);
              DateTimePicker3.SetFocus;
            end;
      end;
end;

procedure TFrmFinanceiro.SpeedButton6Click(Sender: TObject);
begin
   sqlrun('Select moe_codmoeda as Codigo, moe_prefixo_a as Prefixo, moe_nome_a as Nome'
       + ', mensal from Moeda', dm.Consulta);
   Origem:='Moeda';
   application.CreateForm(TFrmPessoa, FrmPessoa);
   FrmPessoa.Showmodal;
   FrmPessoa.Destroy;
end;

procedure TFrmFinanceiro.GrdContaDblClick(Sender: TObject);
begin
  Pega_Dados;
end;

procedure TFrmFinanceiro.cmbinformacaoDropDown(Sender: TObject);
begin
   cmbinformacao.Items.Clear;
   sqlrun ('Select * from tipoinformacao', dm.Consulta);
   while not dm.consulta.Eof do
      begin
         cmbinformacao.Items.Add(dm.consulta.fieldbyname('Tin_tipoinformacao_a'). asstring);
         dm.Consulta.next;
      end;
end;

procedure TFrmFinanceiro.Action3Execute(Sender: TObject);
begin
  dm.Trans.Active:=false;
  dm.DBAutocom.Connected:=false;
  logsend(filename, 'Fechamento do módulo Financeiro');
  close;
end;

procedure TFrmFinanceiro.Grava_registros;

begin

// ******************** Tabela de transações *************************************
   logsend(filename,'Inserindo dados na tabela transações');
   sqlrun('commit',dm.portadores);
   sqlrun('Select max(codigotransacao) from transacoes', dm.portadores);
   Sqlrun('Insert into TRANSACOES (CODIGOTRANSACAO, CODIGOCONJUNTO, CODIGOTRANSACAOMODELO, '
      + 'DATA, HISTORICO, CODIGOREFERENCIA, TIPOMOVIMENTO) values ('
      + IntToStr(dm.portadores.Fields[0].Asinteger + 1) + ', '
      + EdMovimentacao.text + ', '
      + 'Null, '
      + quotedStr(FormatDateTime('mm/dd/yyyy',now)) + ', '
      + QuotedStr(EDHistorico.Text) + ', '
      + EdDoctoOrigem.text + ', '
      + tipoorigem + ')'  ,dm.Inclusao);
   sqlrun('Commit',dm.aux);


//*********************** Tabela de Lançamentos **********************************
   logsend(filename,'Entranto na rotina Grava_pedido');
   logsend(filename,'Inserindo dados na tabela lançamentos');
   sqlrun('Select max(codigotransacao) from transacoes', dm.portadores);
   codtransacao:= dm.portadores.Fields[0].asstring;
   sqlrun('Select con_codconta from cliente where codigocliente = '+ EDfornec.text, dm.portadores);
   codconta:= dm.portadores.fields[0].AsString;
   sqlrun('Select nivelconta from contas where con_codconta = ' + codconta , dm.portadores);
   nivelconta:= dm.portadores.Fields[0].asstring;
   sqlrun('Select max(codigolancamento) from lancamentos', dm.portadores);
   codlancto:= IntToStr(dm.portadores.fields[0].Asinteger + 1);
   if RBcontapagar.Checked = true then
      begin
         debito:= edtotal.Text;
         credito:= '0,00';
      end;
   if RBcontareceber.Checked = true then
      begin
         credito:= edtotal.text;
         debito:= '0,00';
      end;

   sqlrun('Insert into Lancamentos (CODIGOLANCAMENTO, CODIGOTRANSACAO, CODIGOLANCTOTRANSACAOMODELO,'
      + 'CODIGOCONTA, NIVELCONTA, CCO_CODCENTROCONTABIL, DEBITO, CREDITO) values ('
      + codlancto + ', '
      + codtransacao + ', '
      + 'Null, '
      + codconta + ', '
      + quotedStr(nivelconta) + ', '
      + 'Null, '
      + StringReplace(debito,',','.',[])+ ', '
      + StringReplace(credito,',','.',[])
      + ')' , dm.inclusao);
   sqlrun('commit', dm.Aux);

//******************* Tabela Contaspagarreceber *********************************
   logsend(filename,'Inserindo dados na tabela Contaspagarreceber');
   sqlrun('Select max(codigocontapagarreceber) from contaspagarreceber', dm.portadores);
   codcontapagreceb:= IntToStr(dm.portadores.Fields[0].asinteger + 1);
   sqlrun('Select tin_codtipoinformacao from tipoinformacao where tin_tipoinformacao_a = ' + QuotedStr(cmbinformacao.Text) ,dm.portadores);
   tipoinf:= dm.portadores.fields[0].AsString;
   sqlrun('Insert into contaspagarreceber (CODIGOCONTAPAGARRECEBER, TIPOCONTAPAGARRECEBER, CODIGOLANCAMENTO, CODIGOCONTA, '
      + 'TIN_CODTIPOINFORMACAO, NUMEROCOMPROMISSO, DATAVENCIMENTO, PES_CODPESSOA, PRORROGADO, HISTORICO, '
      + 'CODIGOBORDERO, CFG_CODCONFIG) Values ('
      + codcontapagreceb + ', '
      + tipoorigem + ', '
      + codlancto + ', '
      + codconta + ', '
      + tipoinf + ', '
      + EDnrodcto.text + ', '
      + QuotedStr(FormatDateTime('mm/dd/yyyy',DTdatavencimento.date)) + ', '
      + codpessoa + ', '
      + 'null, '
      + QuotedStr(EDHistorico.text) + ', '
      + 'null, '
      + '1)'
      , dm.Inclusao);
   sqlrun('commit',dm.inclusao);
   logsend(filename,'Dados incluídos');
   logsend(filename,'Fim da rotina Grava_pedidos');

end;
procedure TFrmFinanceiro.Pega_Dados;
begin
  EdDiasatraso.text:= ifthen(isnull(IntToStr(now - dm.principal.Fields[6].AsVariant)),'0',IntToStr(now - dm.principal.Fields[6].AsVariant));
  EDnrodcto.text:= dm.principal.Fields[5].AsString;
  EDHistorico.text:= dm.principal.Fields[10].AsString;
  DTdatavencimento.Date:= dm.principal.Fields[6].AsDateTime;
  codlancto:= dm.principal.fields[2].AsString; 
  codcontapagreceb:= dm.principal.Fields[0].AsString;
end;
procedure TFrmFinanceiro.SpeedButton5Click(Sender: TObject);
begin
  logsend(filename,'Dando baixa na conta');
  sqlrun('Select max(lpr_codlancamentocpr) from lancamentoscpr', dm.portadores);
  codlancpr:= IntToStr(dm.portadores.Fields[0].AsInteger + 1);
  Sqlrun('Insert Into LANCAMENTOSCPR (LPR_CODLANCAMENTOCPR, CODIGOCONTAPAGARRECEBER,'
     + ' CODIGOLANCAMENTO) values ('
     + codlancpr + ', '
     + codcontapagreceb + ', '
     + codlancto + ')' , dm.Inclusao);
  sqlrun('Commit', dm.inclusao);
  application.MessageBox('Baixa Efetuada!','Autocom PLUS',MB_ICONINFORMATION); 
end;

end.


