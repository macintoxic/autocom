unit uRelatorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, StrUtils, DB, uGlobal,DBClient;

type
  TfRelatorio = class(TForm)
    BtnCancelar: TSpeedButton;
    BtnImprimir: TSpeedButton;
    GroupBox2: TGroupBox;
    RadCodigo: TRadioButton;
    RadDescricao: TRadioButton;
    procedure BtnCancelarClick(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
  public
    DsRel: TDataSet;
    function BooleanToSN(str: string): string;
  end;

var
  fRelatorio: TfRelatorio;

implementation

uses uDm;

{$R *.dfm}

function TfRelatorio.BooleanToSN(str: string): string;
begin
  if UpperCase(str) = 'S' then result := 'Sim' else result := 'Não';
end;

procedure TfRelatorio.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfRelatorio.BtnImprimirClick(Sender: TObject);
begin
  Dm.CdsCFOP.EmptyDataSet;
  RunSql('SELECT CODIGONATUREZAOPERACAO, NATUREZAOPERACAO, DESCRICAO, TRIBUTAICMS, ' +
        ' TRIBUTAIPI, TRIBUTAISS, MOVIMENTACONTAS, MOVIMENTAESTOQUE FROM NATUREZAOPERACAO ' +
        ' ORDER BY ' + Ifthen(RadCodigo.Checked,'CODIGONATUREZAOPERACAO','NATUREZAOPERACAO'),
        Dm.DBAutocom, DsRel);
  DsRel.First;
  while not DsRel.Eof do
    begin
      Dm.CdsCFOP.Insert;
      Dm.CdsCFOPCODIGONATUREZAOPERACAO.AsInteger := DsRel.FieldByName('CODIGONATUREZAOPERACAO').AsInteger;
      Dm.CdsCFOPNATUREZAOPERACAO.AsString := DsRel.FieldByName('NATUREZAOPERACAO').AsString;
      Dm.CdsCFOPDESCRICAO.AsString := DsRel.FieldByName('DESCRICAO').AsString;
      Dm.CdsCFOPTRIBUTAICMS.Value := BooleanToSN(DsRel.FieldByName('TRIBUTAICMS').AsString);
      Dm.CdsCFOPTRIBUTAIPI.Value := BooleanToSN(DsRel.FieldByName('TRIBUTAIPI').AsString);
      Dm.CdsCFOPTRIBUTAISS.Value := BooleanToSN(DsRel.FieldByName('TRIBUTAISS').AsString);
      Dm.CdsCFOPMOVIMENTACONTAS.Value := BooleanToSN(DsRel.FieldByName('MOVIMENTACONTAS').AsString);
      Dm.CdsCFOPMOVIMENTAESTOQUE.Value := BooleanToSN(DsRel.FieldByName('MOVIMENTAESTOQUE').AsString);
      Dm.CdsCFOP.Post;
      DsRel.Next
    end;
  FreeAndNil(DsRel);
  DM.Rave.ProjectFile:=ExtractFilePath(application.exename)+'CCFOP.rav';
  if RadCodigo.Checked then Dm.CdsCFOP.IndexFieldNames := 'CODIGONATUREZAOPERACAO' else Dm.CdsCFOP.IndexFieldNames := 'NATUREZAOPERACAO';
  Dm.Rave.Execute;
end;

procedure TfRelatorio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN: BtnImprimir.Click;
    VK_ESCAPE: BtnCancelar.Click;
  end;
end;

end.
