unit uDm;

interface

uses
  Messages, SysUtils, Variants, Classes, DB, IBCustomDataSet, IBQuery, IBDatabase,
  IBUpdateSQL, uGlobal;

type
  TDm = class(TDataModule)
    DBAutocom: TIBDatabase;
    Transaction: TIBTransaction;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure InsertImpressora(CFG_CODCONFIG, NOMEIMPRESSORA, CAMINHOIMPRESSORA: String);
    procedure UpdateImpressora(CODIGOIMPRESSORA, NOMEIMPRESSORA, CAMINHOIMPRESSORA: String);
    procedure DeleteImpressora(CODIGOIMPRESSORA: String);
  end;

var
  Dm: TDm;

implementation

{$R *.dfm}

{ TDm }

procedure TDm.DeleteImpressora(CODIGOIMPRESSORA: String);
begin
  RunSql('DELETE FROM IMPRESSORA WHERE CODIGOIMPRESSORA = ' + CODIGOIMPRESSORA,dm.dbautocom);
end;    

procedure TDm.InsertImpressora(CFG_CODCONFIG, NOMEIMPRESSORA,
  CAMINHOIMPRESSORA: String);
begin
  RunSql('INSERT INTO IMPRESSORA (CFG_CODCONFIG, ' +
         ' NOMEIMPRESSORA, CAMINHOIMPRESSORA) Values (' +
         CFG_CODCONFIG + ', ' +
         QuotedStr(NOMEIMPRESSORA) + ', ' +
         QuotedStr(CAMINHOIMPRESSORA) + ');',dm.dbautocom);

end;

procedure TDm.UpdateImpressora(CODIGOIMPRESSORA, NOMEIMPRESSORA,
  CAMINHOIMPRESSORA: String);
begin
  RunSql('UPDATE IMPRESSORA SET ' +
        ' NOMEIMPRESSORA         = ' + QuotedStr(NOMEIMPRESSORA) +
        ' ,CAMINHOIMPRESSORA      = ' + QuotedStr(CAMINHOIMPRESSORA) +
        ' WHERE CODIGOIMPRESSORA = ' + CODIGOIMPRESSORA,dm.dbautocom);

end;

procedure TDm.DataModuleCreate(Sender: TObject);
begin
//  DataBaseAutocom := @DBAutocom;
end;

end.
