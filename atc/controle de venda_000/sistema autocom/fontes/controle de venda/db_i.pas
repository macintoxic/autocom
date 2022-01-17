unit db_i;

interface

uses dbiprocs, db, dbtables;


procedure grava_buffer_db(DataSet: TDataSet);


implementation

procedure grava_buffer_db(DataSet: TDataSet);
var tabela:TTable;
begin
     tabela:=dataset as Ttable;
     DBISaveChanges(tabela.handle);
end;


end.
 