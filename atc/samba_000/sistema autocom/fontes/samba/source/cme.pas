unit cme;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ExtCtrls, Inifiles, Mask;

type
  Tfcomand = class(TForm)
    SpeedButton1: TSpeedButton;
    BitBtn12: TBitBtn;
    BitBtn13: TBitBtn;
    Image1: TImage;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    SpeedButton3: TSpeedButton;
    e2garcom: TEdit;
    Panel1: TPanel;
    btnhsete: TBitBtn;
    btnhoito: TBitBtn;
    btnhnove: TBitBtn;
    btnhseis: TBitBtn;
    btnhcinco: TBitBtn;
    btnhquatro: TBitBtn;
    btnhtres: TBitBtn;
    btnhdois: TBitBtn;
    btnhHum: TBitBtn;
    btnhzero: TBitBtn;
    btnhvirgula: TBitBtn;
    btnhlimpa: TBitBtn;
    MEsenha: TMaskEdit;
    SpeedButton2: TSpeedButton;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure conecta_db;
    procedure SpeedButton3Click(Sender: TObject);
    procedure Edit2Enter(Sender: TObject);
    procedure MEsenhaEnter(Sender: TObject);
    procedure preenche_senha;
    procedure btnhzeroClick(Sender: TObject);
    procedure btnhHumClick(Sender: TObject);
    procedure btnhdoisClick(Sender: TObject);
    procedure btnhtresClick(Sender: TObject);
    procedure btnhquatroClick(Sender: TObject);
    procedure btnhcincoClick(Sender: TObject);
    procedure btnhseisClick(Sender: TObject);
    procedure btnhseteClick(Sender: TObject);
    procedure btnhoitoClick(Sender: TObject);
    procedure btnhnoveClick(Sender: TObject);
    procedure btnhlimpaClick(Sender: TObject);
    procedure MEsenhaChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);


  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fcomand: Tfcomand;
  path, orbotao, local: string;
  S_NomeVendedor, S_NomePedido, garcom, R_ServicoDes, patch: string;
  I_LimitePedidoMinimo, I_PrintGrill, I_Delivery, I_LimitePedidoMaximo, I_CodigoTabelaPreco: integer;
  I_PoliticaPreco: integer;
  R_ServicoVal, R_LServicoVal, R_ServicoPer, R_LServicoPer, TaxaServico : real;
  B_Obs, B_Servico: Boolean;
  loggarcom: integer;
  v_passwd: shortstring;
implementation

uses conta, pedido, dtm2_u, autocom, Unit1;

function Encripit(a,b,c,d,e,f:integer):shortstring;
 external 'ECRPT.dll' index 1;

{$R *.dfm}

procedure Tfcomand.SpeedButton1Click(Sender: TObject);
begin
     dtm2.DbAutocom.Connected:= false;
     close;
end;

procedure Tfcomand.conecta_db;
var ini:Tinifile;
    t1,t2:string;
begin

     ini:=TIniFile.Create(path+'Autocom.ini');
     t1:=ini.readstring('ATCPLUS','IP_SERVER','');
     t2:=ini.readstring('ATCPLUS','PATH_DB','');
     Patch := Extractfilepath(Application.ExeName) + 'dados\';
     S_NomeVendedor := Ini.ReadString('SAMBA','NOMEVENDEDOR','');
     S_NomePedido := Ini.ReadString('SAMBA','NOMEPEDIDO','');
     I_LimitePedidoMinimo := StrToInt(Ini.ReadString('SAMBA','LIMITEPEDIDOMINIMO',''));
     I_LimitePedidoMaximo := StrToInt(Ini.ReadString('SAMBA','LIMITEPEDIDOMAXIMO',''));
     I_Delivery := StrToInt(Ini.ReadString('SAMBA','DELIVERY',''));
     I_PoliticaPreco := StrToInt(Ini.ReadString('SAMBA','POLITICAPRECO',''));
     I_PrintGrill := StrToInt(Ini.ReadString('SAMBA','PRINTGRILL',''));
     if (Ini.ReadString('SAMBA','USA_SERVICO ','')) = '1' then
        B_Servico := True
     else
        B_Servico := False;
     if IsFloat(Ini.ReadString('SAMBA','SERVICO_PER',''))
          and (Ini.ReadString('SAMBA','SERVICO_PER','') <> '0') then
        begin
          R_ServicoPer := StrToFloat(FormatCases(Ini.ReadString('SAMBA','SERVICO_PER','')));
          R_ServicoDes:='%';
          R_ServicoVal := 0;
          TaxaServico:= R_ServicoPer;
        end
     else
        begin
          R_ServicoVal := StrToFloat(FormatCases(Ini.ReadString('SAMBA','SERVICO_VAL','')));
          R_ServicoDes:='R$';
          R_ServicoPer := 0;
          TaxaServico:= R_ServicoVal;
        end;
     I_CodigoTabelaPreco := StrToInt(Ini.ReadString('SAMBA','CODIGOTABELAPRECO',''));
     if (Ini.ReadString('SAMBA','OBSERVACAO','')) = '1' then
        B_Obs := True
     else
        B_Obs := False;
     ini.free;
     try
      // showmessage(t1 + ':' + t2);
       dtm2.dbautocom.databasename:= t1 + ':' + t2;
       dtm2.DBautocom.connected:=true;
       dtm2.ibtransaction1.active:=true;
       groupbox3.Caption:=S_NomeVendedor;
     except
       Application.messagebox('Erro ao abrir banco de dados, utilize o'+ #13 + 'programa de configuração para corrigir'+ #13+ 'o problema','Autocom - Samba',mb_iconerror);
       close;
            end;
end;

procedure Tfcomand.FormActivate(Sender: TObject);
begin
     BitBtn12.Visible:=false;
     BitBtn13.Visible:=false;
     fcomand.top:=0;
     fcomand.left:=0;
     fcomand.width:=247;
     fcomand.height:=297;
     panel1.Visible:=false;
     mesenha.MaxLength :=6;

     path:=extractfilepath(application.exename)+'dados\';

     conecta_db;

     dtm2.vendedores.Close;
     dtm2.vendedores.SQL.clear;
     dtm2.vendedores.SQL.add('Select * from tipopessoa');
     dtm2.vendedores.prepare;
     dtm2.vendedores.Open;
     e2garcom.setfocus;
     SetForegroundWindow(application.Handle) ;
end;

procedure Tfcomand.BitBtn13Click(Sender: TObject);
begin
     consorigem:='Normal';

     fconta.showmodal;
end;

procedure Tfcomand.BitBtn12Click(Sender: TObject);
begin
     fpedido.ShowModal;
     consorigem := 'Normal';
end;
procedure Tfcomand.SpeedButton3Click(Sender: TObject);

begin
dtm2.vendedores.close;
dtm2.vendedores.sql.clear;      //vendedor.pes_codpessoa,
dtm2.vendedores.sql.Add('select vendedor.ven_codvendedor, pessoa.pes_nome_a from  vendedor  ' +
                        'inner join pessoa on (vendedor.pes_codpessoa = pessoa.pes_codpessoa)');
dtm2.vendedores.prepare;
dtm2.vendedores.open;

origem:= 2;

fconsprod.showmodal;
MEsenha.Clear;
end;

procedure Tfcomand.Edit2Enter(Sender: TObject);
begin
  panel1.Visible := true;
end;

procedure Tfcomand.MEsenhaEnter(Sender: TObject);
begin
  panel1.Visible:= true;
end;

procedure Tfcomand.btnhzeroClick(Sender: TObject);
begin
  orbotao:='Zero';
  preenche_senha;
end;

procedure Tfcomand.btnhHumClick(Sender: TObject);
begin
  orbotao:='Hum';
  preenche_senha;
end;

procedure Tfcomand.btnhdoisClick(Sender: TObject);
begin
  orbotao:='Dois';
  preenche_senha;
end;

procedure Tfcomand.btnhtresClick(Sender: TObject);
begin
  orbotao:='Tres';
  preenche_senha;
end;

procedure Tfcomand.btnhquatroClick(Sender: TObject);
begin
  orbotao:='Quatro';
  preenche_senha;
end;

procedure Tfcomand.btnhcincoClick(Sender: TObject);
begin
  orbotao:='Cinco';
  preenche_senha;
end;

procedure Tfcomand.btnhseisClick(Sender: TObject);
begin
  orbotao:='Seis';
  preenche_senha;
end;

procedure Tfcomand.btnhseteClick(Sender: TObject);
begin
  orbotao:='Sete';
  preenche_senha;
end;

procedure Tfcomand.btnhoitoClick(Sender: TObject);
begin
  orbotao:='Oito';
  preenche_senha;
end;

procedure Tfcomand.btnhnoveClick(Sender: TObject);
begin
  orbotao:='Nove';
  preenche_senha;
end;
procedure Tfcomand.btnhlimpaClick(Sender: TObject);
begin
  orbotao:= 'Limpa';
  preenche_senha;
end;


procedure Tfcomand.preenche_senha;
begin
   if orbotao = 'Limpa' Then
   begin
     MEsenha.Text:='';
     MEsenha.SetFocus;
   end;
   if orbotao = 'Zero' then
   begin
    MEsenha.Text:= MEsenha.text + '0';
   end;
   if orbotao = 'Hum' then
   begin
    MEsenha.Text:= MEsenha.text + '1';
   end;
   if orbotao = 'Dois' then
   begin
    MEsenha.Text:= MEsenha.text + '2';
   end;
   if orbotao = 'Tres' then
   begin
    MEsenha.Text:= MEsenha.text + '3';
   end;
   if orbotao = 'Quatro' then
   begin
    MEsenha.Text:= MEsenha.text + '4';
   end;
   if orbotao = 'Cinco' then
   begin
    MEsenha.Text:= MEsenha.text + '5';
   end;
   if orbotao = 'Seis' then
   begin
    MEsenha.Text:= MEsenha.text + '6';
   end;
   if orbotao = 'Sete' then
   begin
    MEsenha.Text:= MEsenha.text + '7';
   end;
   if orbotao = 'Oito' then
   begin
    MEsenha.Text:= MEsenha.text + '8';
   end;
   if orbotao = 'Nove' then
   begin
    MEsenha.Text:= MEsenha.text + '9';
   end;
end;

procedure Tfcomand.MEsenhaChange(Sender: TObject);
begin
  if length(mesenha.text) >= 6 then
    panel1.Visible:=false;
end;

procedure Tfcomand.Button1Click(Sender: TObject);
begin
showmessage(fpedido.e1mesa.text);
end;

procedure Tfcomand.SpeedButton2Click(Sender: TObject);
begin
if length(mesenha.text) < 6 then
  begin
    while  length(mesenha.text) < 6 do
      mesenha.text:='0' + mesenha.text;
  end;
 if speedbutton2.Caption = 'Login' then
   begin
      panel1.Visible:= false;
      speedbutton2.caption:='Logout';
      speedbutton1.visible:=false;
      v_passwd:= Encripit(StrToInt(copy(MEsenha.text,1,1)),StrToInt(copy(MEsenha.text,2,1)),StrToInt(copy(MEsenha.text,3,1)),StrToInt(copy(MEsenha.text,4,1)),StrToInt(copy(MEsenha.text,5,1)),StrToInt(copy(MEsenha.text,6,1)));
      SQLRUN('Select senha from vendedor where ven_codvendedor = '+ IntToStr(v_garcom) + ';',dtm2.vendedores );
      if (v_passwd = dtm2.vendedores.FieldByName('Senha').AsString) then
        begin
          panel1.visible:=false;
          bitbtn12.Visible:= true;
          bitbtn13.Visible:= true ;
          groupbox2.Visible:=false;
          groupbox3.visible:=false;
          fpedido.e2garcom.Text  := IntToStr(v_garcom)+ ' - ' + garcom ;
        end
      else
        Begin
          application.MessageBox('Senha Incorreta, Digite novamente','Autocom - Samba ',MB_ok);
          speedbutton2.Caption:='Login';
          speedbutton1.Visible:=true;
          mesenha.SetFocus;
        end;
   end
 else
   Begin
     {Chamar procedimento de logout}
     speedbutton2.Caption:='Login';
     bitbtn12.Visible:= false;
     bitbtn13.Visible:= false;
     groupbox2.Visible:=true;
     groupbox3.visible:=true;
     speedbutton1.Visible:= true;
     e2garcom.Text:='';
     Mesenha.text:='';
     e2garcom.setfocus;
   end;
end;


end.
