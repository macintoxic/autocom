unit teste_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, IBCustomDataSet, IBQuery, IBDatabase, StrUtils, Inifiles,
  ComCtrls, Buttons;

type
  TForm1 = class(TForm)
    DBAutocom: TIBDatabase;
    Trans: TIBTransaction;
    IBQuery1: TIBQuery;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    datainicio: TDateTimePicker;
    datafim: TDateTimePicker;
    SBdetalhecupom: TSpeedButton;
    SBfechacupom: TSpeedButton;
    SBcabecupom: TSpeedButton;
    SBFechar: TSpeedButton;
    procedure FormActivate(Sender: TObject);
    procedure SBdetalhecupomClick(Sender: TObject);
    procedure SBfechacupomClick(Sender: TObject);
    procedure SBcabecupomClick(Sender: TObject);
    procedure SBFecharClick(Sender: TObject);
  private
    { Private declarations }
  public
    procedure Exporta(S_Log:string);
    procedure Conecta_db;
    function FormataXCasas(texto:string; X:Integer):string;
    Function Formata_Valores(texto:string;QtdAntes,QtdDepois:Integer):string;
    { Public declarations }
  end;

var
  Form1: TForm1;
  conta: integer;
  Teste: String;
  NomeFile:String;
  path: String;
implementation

uses uglobal;

{$R *.dfm}

Function TForm1.FormataXCasas(texto:string; X:Integer):string; //Formata um campo que tem x casas
Begin
     Texto := TrimAll(texto);
     While length(texto) < X do
        Texto := '0' + Texto;
     Result := texto;
End;

Function TForm1.Formata_Valores(texto:string;QtdAntes,QtdDepois:Integer):string; //QtdAntes = Qtde de caracteres antes da v?rgula e QtdDepois ? a qtde depois da v?rgula
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
procedure TForm1.conecta_DB;
var ini:Tinifile;
    t1,t2:string;
begin
     Trans.active:=false;
     DBAutocom.connected:=false;

     ini:=TIniFile.Create(path+'Dados\Autocom.ini');
     t1:=ini.readstring('ATCPLUS','IP_SERVER','');
     t2:=ini.readstring('ATCPLUS','PATH_DB','');
     path:= ini.ReadString('ATCPLUS','EXP_DADOS','');
     ini.free;

     dbautocom.databasename:=t1+':'+t2;

     dbautocom.connected:=true;
     Trans.active:=true;
end;

procedure TForm1.Exporta(S_Log: string);
var
  LogFile: TextFile;
begin
  { A fun??o LOG cria um log (em TXT) no mesmo diret?rio do programa
   com os modulos acessados. Isso facilita a depura??o de algum eventual BUG no sistema.}

  AssignFile(LogFile, path + NomeFile);
  if not FileExists(path + NomeFile) then
    Rewrite(LogFile)
  else
    Reset(LogFile);
  Append(LogFile);
  Writeln(LogFile, S_Log);
  Flush(LogFile);
  CloseFile(LogFile);
end;

procedure TForm1.FormActivate(Sender:TObject);
begin

   conecta_db;
end;

procedure TForm1.SBdetalhecupomClick(Sender: TObject);
begin
  NomeFile:= 'DetCupom.TXT';
  sqlrun('Select * from PDV_DETALHECUPOM where (DATAHORA >= '
        + QuotedStr(FormatDateTime('mm/dd/yyyy', datainicio.date)) + ') and '
        + '(DATAHORA <= ' + QuotedStr(FormatDateTime('mm/dd/yyyy', datafim.Date))+ ')', ibquery1);
  exporta('Tabela PDV_DETALHECUPOM  - Dia Inicio: '+ FormatDateTime('dd/mm/yyyy', datainicio.date)
          + ' - Dia Fim: '+ FormatDateTime('dd/mm/yyyy', datafim.Date));
  exporta('Campos');
  exporta('CFG_CODCONFIG, CLI_CODCLIENTE, VEN_CODVENDEDOR, IDUSUARIO, DATAHORA, '
        + ' CODIGOPRODUTO, TERMINAL, NCP, SEQ, VALORUN, QTDE, DESCONTO, ACRESCIMO, SITUACAO');
  while not ibquery1.Eof do
     begin
        exporta(trim(formataxcasas(ibquery1.fields[1].asstring,4))
           + trim(formataxcasas(IBQuery1.Fields[2].asstring,10))
           + trim(formataxcasas(ibquery1.fields[3].asstring,10))
           + trim(formataxcasas(IBQuery1.Fields[4].asstring,10))
           + trim(ibquery1.fields[5].asstring)
           + trim(formataxcasas(IBQuery1.Fields[6].asstring,13))
           + trim(formataxcasas(ibquery1.fields[7].asstring,4))
           + trim(formataxcasas(IBQuery1.Fields[8].asstring,6))
           + trim(formataxcasas(ibquery1.fields[9].asstring,6))
           + trim(formataxcasas(formata_valores(ibquery1.Fields[10].asstring,9,2),12))
           + trim(formataxcasas(formata_valores(ibquery1.Fields[11].asstring,4,3),7))
           + trim(formataxcasas(formata_valores(ibquery1.Fields[12].asstring,9,2),12))
           + trim(formataxcasas(formata_valores(ibquery1.Fields[13].asstring,9,2),12))
           + trim(ifthen(isnull(ibquery1.fields[14].asstring),'0',ibquery1.Fields[14].asstring)) );
        IBQuery1.next;
     end;
     Application.MessageBox('Arquivo exportado com sucesso','Autocom Plus',MB_OK);
  end;

procedure TForm1.SBfechacupomClick(Sender: TObject);
begin
   NomeFile:= 'FecCupom.TXT';
   sqlrun('Select * from PDV_FECHAMENTOCUPOM where (DATAHORA >= '
        + QuotedStr(FormatDateTime('mm/dd/yyyy', datainicio.date)) + ') and '
        + '(DATAHORA <= ' + QuotedStr(FormatDateTime('mm/dd/yyyy', datafim.Date))+ ')', ibquery1);
   exporta('Tabela PDV_FECHAMENTOCUPOM  - Dia Inicio: '+ FormatDateTime('dd/mm/yyyy', datainicio.date)
          + ' - Dia Fim: '+ FormatDateTime('dd/mm/yyyy', datafim.Date));
   exporta('Campos');
   exporta('DATAHORA, CFG_CODCONFIG, CLI_CODCLIENTE, VEN_CODVENDEDOR, IDUSUARIO,'
        + ' CODIGOCONDICAOPAGAMENTO, TERMINAL, NCP, REPIQUE, CONTRAVALE, TROCO,'
        + ' VALORRECEBIDO, BANCO, NUMEROCHEQUE, AGENCIA, DATAPRE');
   while not ibquery1.eof do
      begin
        exporta(trim(ibquery1.Fields[1].asstring) + trim(formataxcasas(ibquery1.Fields[2].asstring,4))
           + trim(formataxcasas(ibquery1.fields[3].asstring,10))
           + trim(formataxcasas(ibquery1.fields[4].asstring,10))
           + trim(formataxcasas(ibquery1.fields[5].asstring,10))
           + trim(formataxcasas(ibquery1.fields[6].asstring,10))
           + trim(formataxcasas(ibquery1.fields[7].asstring,4))
           + trim(formataxcasas(ibquery1.fields[8].asstring,6))
           + trim(formataxcasas(formata_valores(ibquery1.Fields[9].asstring,9,2),12))
           + trim(formataxcasas(formata_valores(ibquery1.Fields[10].asstring,9,2),12))
           + trim(formataxcasas(formata_valores(ibquery1.Fields[11].asstring,9,2),12))
           + trim(formataxcasas(formata_valores(ibquery1.Fields[12].asstring,9,2),12))
           + trim(formataxcasas(ibquery1.fields[13].asstring,3))
           + trim(formataxcasas(ibquery1.fields[14].asstring,10))
           + trim(formataxcasas(ibquery1.fields[15].asstring,6))
           + trim(formataxcasas(ibquery1.fields[16].asstring,10))
           + trim(formataxcasas(ibquery1.fields[17].asstring,10)));
        ibquery1.next;
      end;
   Application.MessageBox('Arquivo exportado com sucesso','Autocom Plus',MB_OK);
end;

procedure TForm1.SBcabecupomClick(Sender: TObject);
begin
   NomeFile:= 'CabCupom.TXT';
   sqlrun('Select * from PDV_CABECALHOCUPOM where (DATAHORA >= '
        + QuotedStr(FormatDateTime('mm/dd/yyyy', datainicio.date)) + ') and '
        + '(DATAHORA <= ' + QuotedStr(FormatDateTime('mm/dd/yyyy', datafim.Date))+ ')', ibquery1);
   exporta('Tabela PDV_CABECALHOCUPOM  - Dia Inicio: '+ FormatDateTime('dd/mm/yyyy', datainicio.date)
          + ' - Dia Fim: '+ FormatDateTime('dd/mm/yyyy', datafim.Date));
   exporta('Campos');
   exporta('CFG_CODCONFIG, CLI_CODCLIENTE, VEN_CODVENDEDOR, IDUSUARIO, DATAHORA'
       + ' TERMINAL, NCP, ECF, VALORCUPOM, DESCONTO, ACRESCIMO, SITUACAO, NUMEROCLIENTE');
   while not ibquery1.Eof do
      begin
          exporta(trim(formataxcasas(ibquery1.Fields[1].asstring,4))
             + trim(formataxcasas(ibquery1.fields[2].asstring,10))
             + trim(formataxcasas(ibquery1.fields[3].asstring,10))
             + trim(formataxcasas(ibquery1.fields[4].asstring,10))
             + trim(ibquery1.Fields[1].asstring)
             + trim(formataxcasas(ibquery1.fields[6].asstring,4))
             + trim(formataxcasas(ibquery1.fields[7].asstring,6))
             + trim(formataxcasas(ibquery1.fields[8].asstring,4))
             + trim(formataxcasas(formata_valores(ibquery1.Fields[9].asstring,9,2),12))
             + trim(formataxcasas(formata_valores(ibquery1.Fields[10].asstring,9,2),12))
             + trim(formataxcasas(formata_valores(ibquery1.Fields[11].asstring,9,2),12))
             + trim(ifthen(isnull(ibquery1.fields[12].asstring),'0',ibquery1.Fields[12].asstring))
             + trim(formataxcasas(ibquery1.fields[13].asstring,10)) );
          ibquery1.Next;
      end;
   Application.MessageBox('Arquivo exportado com sucesso','Autocom Plus',MB_OK);
end;


procedure TForm1.SBFecharClick(Sender: TObject);
begin
Trans.active:=false;
DBAutocom.Connected:=false;
close;
end;

end.
