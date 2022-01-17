{===============================================================================
| File:             uGlobal.pas                                                |
| Environment:      Dlphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5    |
| Compiled state:   Dlphi Compiled Unit: uRotinas.dcu                          |
| Resources:        Win32 API                                                  |
| Version of File:  1.4                                                        |
===============================================================================}

unit uGlobal;

interface

uses Controls, Windows, classes, Forms, DB, Dialogs, IBQuery,
  IBDatabase, IniFiles, SysUtils, Math, StdCtrls;

type
  TFormatEditKind = set of (CurrencyIn, CurrencyOut, Float);
  procedure LogSend(FileName, S: String);
  procedure GravaINI(strSessao, strChave, strValor: string;
    strArquivo: string = 'dados\autocom.ini');
  function LeINI(strSessao, strChave: string;
    strArquivo: string = 'dados\autocom.ini'): Variant;
  procedure SqlRun(SQL: string; Table: TIBQuery; OpenTable: Boolean = True; CreateLog: Boolean = False); overload;
  procedure SqlRun(IBDatabase: TIBDatabase); overload;
  function CenterText(Text: string; Size: Integer; Char: Char = ' '): string;
  procedure RunSQL(strQuery: string; IBDatabase: TIBDatabase); overload;
  procedure RunSQL(strQuery: string; IBDatabase: TIBDatabase; var aux:TDataSet; CreateLog: Boolean = False); overload;
  function IsFloat(S: string): Boolean;
  function IsInteger(S: string): Boolean;
  function IsNull(S: string): Boolean;
  function TrimAll(t: string): string;
  procedure FormatEdit(Sender: TObject; FormatKind: TFormatEditKind = [Float]; Cases: Integer = 2);
  procedure FiltroNumerico(Sender: TObject; var Key: Char);
const
  Autocom = 'Sistema Autocom Plus';

implementation

procedure GravaINI(strSessao, strChave, strValor,
  strArquivo: string);
{-------------------------------------------------------------------------------
|  Procedure:   CenterText                                                     |
|  Autor:       Charles                                                        |
|  Data:        04-abr-2003                                                    |
|  Grava informações em qquer arquivo ini.                                     |
-------------------------------------------------------------------------------}
begin
  if strArquivo = 'dados\autocom.ini' then strArquivo := extractfilepath(application.exename)+'dados\autocom.ini';
  with TIniFile.Create(strarquivo) do
    begin
      WriteString(strSessao, strChave, strValor);
      Free;
    end;
end;

function LeINI(strSessao, strChave, strArquivo: string): variant;
{-------------------------------------------------------------------------------
|  Procedure:   CenterText                                                     |
|  Autor:       Charles                                                        |
|  Data:        04-abr-2003                                                    |
|  Le as informações gravadas em qquer arquivo ini;                            |
-------------------------------------------------------------------------------}
begin
  if strArquivo = 'dados\autocom.ini' then strArquivo := extractfilepath(application.exename)+'dados\autocom.ini';
  with TIniFile.Create(strArquivo) do
    begin
      Result := ReadString(strSessao, strChave, '');
      Free;
    end;
end;

procedure RunSQL(strQuery: string; IBDatabase: TIBDatabase);
{-------------------------------------------------------------------------------
|  Procedure: RunSQL                                                           |
|  Autor:     Charles                                                          |
|  Data:      26-mar-2003                                                      |
|  Procedure que executa comandos sql que não retornam cursores                |
-------------------------------------------------------------------------------}
var aux: TDataSet;
begin
     aux := TIBQuery.Create(nil);
     with (aux as TIBQuery) do
     begin
          Database := IBDatabase;
          SQL.Text := strQuery;
          ExecSQL;
          SQL.Clear;
          SQL.Text := 'commit;';
          ExecSQL;
          FreeAndNil(aux);
     end;
end;

procedure RunSQL(strQuery: string; IBDatabase: TIBDatabase; var aux:TDataSet; CreateLog: Boolean = False);
{-------------------------------------------------------------------------------
|  Procedure: RunSQL                                                           |
|  Autor:     Charles                                                          |
|  Data:      26-mar-2003                                                      |
|  Procedure que executa comandos sql que não retornam cursores                |
-------------------------------------------------------------------------------}
begin
     if not Assigned(aux) then
        FreeAndNil(aux);
     aux := TIBQuery.Create(nil);
     with (aux as TIBQuery) do
     begin
          Database := IBDatabase;
          SQL.Text := strQuery;
          Open;
     end;
     if CreateLog then
      begin
        ForceDirectories(ExtractFilePath(Application.ExeName) + '\logs');
        LogSend('logs\RVECF' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + strQuery);
      end;
end;

procedure SqlRun(SQL: string; Table: TIBQuery; OpenTable: Boolean = True; CreateLog: Boolean = False);
{-------------------------------------------------------------------------------
|  Procedure: SqlRun                                                           |
|  Autor:     André                                                            |
|  Data:      18-mar-2003                                                      |
|  Procedure que executa comandos sql em query passada como parametro          |
-------------------------------------------------------------------------------}
begin
  Table.Close;
  Table.SQL.Clear;
  Table.SQL.Add(SQL);
  Table.Prepare;
  if OpenTable then Table.Open else Table.ExecSQL;
     if CreateLog then
      begin
        ForceDirectories(ExtractFilePath(Application.ExeName) + '\logs');
        LogSend('logs\RVECF' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + SQL);
      end;
end;

procedure SqlRun(IBDatabase: TIBDatabase);
{-------------------------------------------------------------------------------
|  Procedure: SqlRun                                                           |
|  Autor:     André                                                            |
|  Data:      18-mar-2003                                                      |
|  Executa Commit                                                              |
-------------------------------------------------------------------------------}
var
  TblCommit: TIBQuery;
begin
  TblCommit := TIBQuery.Create(nil);
  TblCommit.Database := IBDatabase;
  TblCommit.Close;
  TblCommit.SQL.Clear;
  TblCommit.SQL.Add('Commit;');
  TblCommit.Prepare;
  TblCommit.ExecSQL;
  FreeAndNil(TblCommit);
end;


function CenterText(Text: string; Size: Integer; Char: Char = ' '): string;
{-------------------------------------------------------------------------------
|  Procedure:   CenterText                                                     |
|  Autor:       Charles                                                        |
|  Data:        04-abr-2003                                                    |
|  Centraliza uma string;                                                      |
-------------------------------------------------------------------------------}
var
  i: Integer;
begin
  for i := 0 to (Size - Length(Text)) div 2 do
    Text := Char + Text + Char;
  Result := Copy(Text,0,Size);
end;

function IsFloat(S: string): Boolean;
{-------------------------------------------------------------------------------
|  Procedure:   IsFloat                                                        |
|  Autor:       André Faria                                                    |
|  Data:        04-abr-2003                                                    |
|  Verifica se a string é um float valido;                                     |
-------------------------------------------------------------------------------}
var
  f: extended;
begin
  Result := TextToFloat(PChar(S), f, fvExtended);
end;

function IsInteger(S: string): Boolean;
{-------------------------------------------------------------------------------
|  Procedure:   IsInteger                                                      |
|  Autor:       André Faria                                                    |
|  Data:        04-abr-2003                                                    |
|  Verifica se a string é um integer valido;                                     |
-------------------------------------------------------------------------------}
var 
  I: Integer; 
  E: Integer; 
begin 
  Val(S, I, E); 
  Result := E = 0; 
  E := Trunc(I); 
end;


function IsNull(S: string): Boolean;
{-------------------------------------------------------------------------------
|  Procedure:   IsNull                                                         |
|  Autor:       André Faria                                                    |
|  Data:        04-abr-2003                                                    |
|  Verifica se a string é nula;                                                |
-------------------------------------------------------------------------------}
begin
  if Trim(S) = '' then Result := True else Result := False;
end;

function TrimAll(t: string): string;
{-------------------------------------------------------------------------------
|  Procedure:   IsNull                                                         |
|  Autor:       André Faria                                                    |
|  Data:        04-abr-2003                                                    |
|  Apaga ' ' do inicio e do fim da String;                                     |
-------------------------------------------------------------------------------}
begin
  while pos(' ',t)>0 do delete(t,pos(' ',t),1);
  while pos('',t)>0 do delete(t,pos('',t),1);
  result:=t;
end;

procedure LogSend(FileName, S: String);
{-------------------------------------------------------------------------------
|  Procedure:   LogSend                                                        |
|  Autor:       Helder                                                         |
|  Data:        04-abr-2003                                                    |
|  Escreve Arquivo de Log                                                      |
-------------------------------------------------------------------------------}
var
  LogFile: TextFile;
begin
  AssignFile(LogFile, ExtractFilePath(Application.Exename) + FileName);
  if not FileExists(ExtractFilePath(Application.Exename) + FileName)
    then Rewrite(LogFile) else Reset(LogFile);
  Append(LogFile);
  Writeln(LogFile, DateTimeToStr(Now) + ' - ' + S);
  Flush(LogFile);
  CloseFile(LogFile);
end;

procedure FormatEdit(Sender: TObject; FormatKind: TFormatEditKind;
  Cases: Integer);
{-------------------------------------------------------------------------------
|  Procedure:   FormatEdit                                                     |
|  Autor:       André Faria                                                    |
|  Data:        04-abr-2003                                                    |
|  Formata Campos Edit                                                         |
-------------------------------------------------------------------------------}
var
  DCases: string;
begin
  if not (Sender is TEdit) then Exit;
  while Length(DCases) < Cases do
    begin
      DCases := DCases + '0';
    end;
  if FormatKind = [Float] then
    begin
      if not IsFloat((Sender as TEdit).Text) then (Sender as TEdit).Text := '0';
      (Sender as TEdit).Text := FormatFloat('0.' + DCases,
        StrToFloat((Sender as TEdit).Text));
    end;
  if FormatKind = [CurrencyIn] then
    begin
      (Sender as TEdit).Text := StringReplace((Sender as TEdit).Text,
        CurrencyString,'',[]);
      (Sender as TEdit).SelectAll;
    end;
  if FormatKind = [CurrencyOut] then
    begin
      if not IsFloat((Sender as TEdit).Text) then (Sender as TEdit).Text := '0';
      (Sender as TEdit).Text := FormatFloat(CurrencyString + '0.' +
        DCases,StrToFloat((Sender as TEdit).Text));
    end;
end;

procedure FiltroNumerico(Sender: TObject; var Key: Char);
{-------------------------------------------------------------------------------
|  Procedure:   FormatEdit                                                     |
|  Autor:       André Faria                                                    |
|  Data:        04-abr-2003                                                    |
|  Filtro de caracteres para campos numericos                                  |
-------------------------------------------------------------------------------}
begin
  if Key = '.' then Key := ',';
  if not (Key in ['0'..'9', ',', #8, #13, #37, #38, #39, #40]) then Key := #0;
  if Key = ',' then
      if Pos(',',(Sender as TEdit).Text) <> 0 then  Key := #0;
end;


end.



