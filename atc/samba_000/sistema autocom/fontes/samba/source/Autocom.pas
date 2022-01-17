unit Autocom;

interface

uses Controls, Windows, Messages, SysUtils, Variants, Classes, IBQuery, Forms, IniFiles;

{Procedimentos e Funções Globais usadas em módulos do Autocom Plus}
  procedure SqlRun(SQL: string; Table: TIBQuery; OpenTable: Boolean = True);
  function IsFloat(S: string): Boolean;
  function CenterText(Text:string;Size:Integer = 40):string;
  function IsNull(S: string): Boolean;
  function FormatCases(Valor: string): String;
  function FormataValores(S_Numero: String; I_ChrAntes, I_ChrDepois: Integer): string;
  procedure FormOpen(FormClass: TControlClass; Form: TForm);
  function TrimAll(t: string): string;
  function IniRead(IniFile: ShortString; Key: ShortString; SubKey: ShortString): string;
const
     TITULO_MENSAGEM = 'Sistema Autocom Plus';
  

implementation

uses Math;

procedure SqlRun(SQL: string; Table: TIBQuery; OpenTable: Boolean);
begin
  Table.Close;
  Table.SQL.Clear;
  Table.SQL.Add(SQL);
  Table.Prepare;
  if OpenTable then Table.Open else Table.ExecSQL;
end;

function IsFloat(S: string): Boolean;
var
  f: extended;
begin
  Result := TextToFloat(PChar(S), f, fvExtended);
end;

function IsNull(S: string): Boolean;
begin
  if Trim(S) = '' then Result := True else Result := False;
end;

function CenterText(Text:string;Size:Integer = 40):string;
var
   i:Integer;
begin
     for i := 0 to (Size - Length(Text)) div 2 do
         Text := ' ' + Text;
     Result := Text;
end;

function FormatCases(Valor: String): string;
var
  TotalCaracteres: Integer;
  Inteiro: ShortString;
  Decimal: ShortString;
begin
  TotalCaracteres := Length(Valor);
  Decimal := Copy(Valor, TotalCaracteres - 1, TotalCaracteres);
  Inteiro := Copy(Valor, 0, TotalCaracteres - 2);
  Result := Inteiro + ',' + Decimal;
end;

procedure FormOpen(FormClass: TControlClass; Form: TForm);
begin
  Application.CreateForm(FormClass, Form);
  Form.ShowModal;
  Form.Destroy;
end;

function FormataValores(S_Numero: String; I_ChrAntes, I_ChrDepois: Integer): string;
  //I_ChrAntes = Quantidade de caracteres antes da vírgula
  //I_ChrDepois= Qunatidade de caracteres depois da vírgula
Var
  I_Virgula: Integer;
  S_Antes, S_Depois, s_Temp: String;
Begin
  I_Virgula := Pos(',', S_Numero);
  If I_Virgula > 0 then begin
    S_Antes := trimAll(copy(S_Numero,1,I_Virgula-1));
    S_Depois := trimall(copy(S_Numero,I_Virgula+1,I_ChrDepois));
  End Else Begin
    S_Antes := TrimAll(S_Numero);
    S_Depois := '';
  End;
  While length(S_Depois) < I_ChrDepois do
    S_Depois := S_Depois + '0';
   s_Temp := '0';
   While (length(S_Antes) > 1) and (s_Temp = '0') do begin
     s_Temp := copy(S_Antes,1,1);
     If s_Temp = '0' then delete(S_Antes,1,1);
   End;
   If length(S_Antes) = 0 then S_Antes := '0';
   S_Numero := S_Antes + S_Depois;
   While length(S_Numero) < (I_ChrAntes + I_ChrDepois) do S_Numero := ' ' + S_Numero;
   Result := S_Numero;
end;

function TrimAll(t: string): string;
begin
  while pos(' ',t)>0 do delete(t,pos(' ',t),1);
  while pos('',t)>0 do delete(t,pos('',t),1);
  result:=t;
end;

function IniRead(IniFile: ShortString; Key: ShortString; SubKey: ShortString): string;
var
  Ini: TiniFile;
begin
  Ini := TIniFile.Create(IniFile);
  Result := Ini.ReadString(Key, SubKey, '');
  Ini.Free;
end;

end.
