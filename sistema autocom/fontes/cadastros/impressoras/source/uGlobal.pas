{===============================================================================
| File:             uGlobal.pas                                                |
| Environment:      Dlphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5    |
| Compiled state:   Dlphi Compiled Unit: uRotinas.dcu                          |
| Resources:        Win32 API                                                  |
| Version of File:  2.0                                                        |
===============================================================================}

unit uGlobal;

interface

uses Controls, Windows, classes, Forms, DB, Dialogs, IBQuery,
  IBDatabase, IniFiles, SysUtils, Math, StdCtrls;

type
  TSqlAction = (InsertSql, UpdateSql, DeleteSql);
  TFormatEditKind = (CurrencyIn, CurrencyOut, Float, PorcentIn, PorcentOut);
  procedure LogSend(FileName, S: String);
  procedure GravaINI(strSessao, strChave, strValor: string;
    strArquivo: string = 'dados\autocom.ini');
  function LeINI(strSessao, strChave: string;
    strArquivo: string = 'dados\autocom.ini'): Variant;
  procedure SqlRun(SQL: string; Table: TIBQuery; OpenTable: Boolean = True; CreateLog: Boolean = False); overload;
  function CenterText(Text: string; Size: Integer): string;
  procedure RunSQL(strQuery: string; IBDatabase: TIBDatabase; CreateLog: Boolean = False); overload;
  procedure RunSQL(strQuery: string; IBDatabase: TIBDatabase; var aux:TDataSet; CreateLog: Boolean = False); overload;
  function IsFloat(S: string): Boolean;
  function IsInteger(S: string): Boolean;
  function IsNull(S: string): Boolean;
  function TrimAll(t: string): string;
  procedure FormatEdit(Sender: TObject; FormatKind: TFormatEditKind = Float; IntegerCases: Integer = 1; DecimalCases: Integer = 2);
  procedure FiltroNumerico(Sender: TObject; var Key: Char);
  procedure ValidaInteger(Field: string; Sender: TObject);
  function IsEditNull(Field: string; Sender: TObject): Boolean;
  function KeyLookUp(FieldSource, FieldResult, Table, ValueOfField: string; AutocomDataBase: TIBDatabase): string;
  procedure ClearEdits(Form: TForm);
  procedure EnableFields(Status: Boolean; ParentComponent: TWinControl);
  function SqlStringTest(Str: String): STring;

const
  Autocom = 'Sistema Autocom Plus';

implementation

uses IBCustomDataSet, Variants;

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

procedure RunSQL(strQuery: string; IBDatabase: TIBDatabase; CreateLog: Boolean = False);
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
     if CreateLog then
      begin
        ForceDirectories(ExtractFilePath(Application.ExeName) + '\logs');
        LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + strQuery);
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
          try
            Open;
          except
            LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log','Erro - ' + strQuery);
          end;
     end;
     if CreateLog then
      begin
        ForceDirectories(ExtractFilePath(Application.ExeName) + '\logs');
        LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + strQuery);
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
        LogSend('logs\' + FormatDateTime('yyyymmdd',Now)+'.log', ExtractFileName(Application.ExeName) + ' - ' + SQL);
      end;
end;

function CenterText(Text: string; Size: Integer): string;
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
    Text := ' ' + Text;
  Result := Text;
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
  if TrimAll(S) = '' then Result := True else Result := False;
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

procedure FormatEdit(Sender: TObject; FormatKind: TFormatEditKind = Float; IntegerCases: Integer = 1; DecimalCases: Integer = 2);
{-------------------------------------------------------------------------------
|  Procedure:   FormatEdit                                                     |
|  Autor:       André Faria                                                    |
|  Data:        04-abr-2003                                                    |
|  Formata Campos Edit                                                         |
-------------------------------------------------------------------------------}
var
  ICases, DCases: string;
begin
  if not (Sender is TCustomEdit) then Exit;
  while Length(ICases) < IntegerCases do
    begin
      ICases := ICases + '0';
    end;
  while Length(DCases) < DecimalCases do
    begin
      DCases := DCases + '0';
    end;

  if FormatKind = Float then
    begin
      if not IsFloat((Sender as TCustomEdit).Text) then (Sender as TCustomEdit).Text := '0';
      (Sender as TCustomEdit).Text := FormatFloat(ICases + '.' + DCases,
        StrToFloat((Sender as TCustomEdit).Text));
      if (Sender as TCustomEdit).Text = ',' + DCases then (Sender as TCustomEdit).Text := '0,' + DCases;
    end;
  if FormatKind = CurrencyIn then
    begin
      (Sender as TCustomEdit).Text := StringReplace((Sender as TCustomEdit).Text,
        CurrencyString,'',[]);
      (Sender as TCustomEdit).SelectAll;
    end;
  if FormatKind = CurrencyOut then
    begin
      if not IsFloat((Sender as TCustomEdit).Text) then (Sender as TCustomEdit).Text := '0';
      (Sender as TCustomEdit).Text := FormatFloat(CurrencyString + ICases + '.' + DCases,StrToFloat((Sender as TCustomEdit).Text));
    end;
  if FormatKind = PorcentIn then
    begin
      (Sender as TCustomEdit).Text := StringReplace((Sender as TCustomEdit).Text,
        '%','',[]);
      (Sender as TCustomEdit).SelectAll;
    end;
  if FormatKind = PorcentOut then
    begin
      if not IsFloat((Sender as TCustomEdit).Text) then (Sender as TCustomEdit).Text := '0';
      (Sender as TCustomEdit).Text := FormatFloat(ICases + '.' + DCases + '%',StrToFloat((Sender as TCustomEdit).Text));
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

procedure ValidaInteger(Field: string; Sender: TObject);
begin
  if not IsInteger((Sender as TCustomEdit).Text) then
  begin
    Application.MessageBox(PChar('O valor digitado no campo ' + Field + '  é inválido, Verifique!'),Autocom,MB_ICONEXCLAMATION);
    Abort;
  end;
end;

function KeyLookUp(FieldSource, FieldResult, Table, ValueOfField: string; AutocomDataBase: TIBDatabase): string;
var
  DsAux: TDataSet;
  SqlStr: string;
begin
     DsAux := TIBQuery.Create(nil);
     if (IsNull(ValueOfField)) or (IsNull(FieldSource)) or (IsNull(Table)) or (IsNull(FieldResult)) then
      begin
        Result := NullAsStringValue;
        Exit;
      end;
     SqlStr := ' SELECT ' + FieldResult + ' FROM ' + Table + ' WHERE ' + FieldSource + ' = ' + ValueOfField;
     try
       with (DsAux as TIBQuery) do
       begin
            Database := AutocomDataBase;
            SQL.Text := SqlStr;
            Open;
       end;
       Result := DsAux.Fields[0].AsString;
     except
      Result := NullAsStringValue;
     end;
end;

procedure ClearEdits(Form: TForm);
var
  i: Integer;
begin
  for i := 0 to Form.ComponentCount-1 do
    begin
      if (Form.Components[i] is TCustomEdit) then
        (Form.Components[i] as TCustomEdit).Clear;
  end;
end;

function IsEditNull(Field: string; Sender: TObject): Boolean;
begin
  if IsNull((Sender as TCustomEdit).Text) then
    begin
      Application.MessageBox(PChar('O campo ' + Field + '  não pode ficar vazio, Verifique!'),Autocom,MB_ICONEXCLAMATION);
      (Sender as TCustomEdit).SetFocus;
      Result := True;
    end
  else
    Result := False;
  if Result = True then Abort;
end;

procedure EnableFields(Status: Boolean; ParentComponent: TWinControl);
var
  i: Integer;
begin
  for i := 0 to ParentComponent.ControlCount-1 do
    begin
      if Status then
        begin
          (ParentComponent.Controls[i] as TControl).Enabled := True;
        end
      else
        begin
          (ParentComponent.Controls[i] as TControl).Enabled := False;
          if (ParentComponent.Controls[i] is TCustomEdit) then (ParentComponent.Controls[i] as TCustomEdit).Clear;
          if (ParentComponent.Controls[i] is TCustomComboBox) then (ParentComponent.Controls[i] as TCustomComboBox).ItemIndex := -1;
        end;
    end;
end;

function SqlStringTest(Str: String): STring;
begin
  if IsNull(Str) then
    Result := 'NULL'
  else
    Result := Str;
end;


end.



