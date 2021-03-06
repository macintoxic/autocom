unit uRelatorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ExtCtrls, Buttons, DB, IBCustomDataSet, IBQuery,
  uGlobal, StrUtils, DBClient;

type
  TfRelatorio = class(TForm)
    RadCod: TRadioButton;
    RadNome: TRadioButton;
    RadFF: TRadioButton;
    BtnImprimir: TSpeedButton;
    BtnCancelar: TSpeedButton;
    procedure CmbImprimirClick(Sender: TObject);
    procedure CmbCancelarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DsCacula(DataSet: TDataSet);
  private
  public
    DsRel: TDataSet;
  end;

var
  fRelatorio: TfRelatorio;

implementation

uses uDm, uMain;

{$R *.dfm}

procedure TfRelatorio.CmbImprimirClick(Sender: TObject);
begin
  FreeAndNil(DsRel);
  //Cria Campos Calculados

  RunSQL(' SELECT C.*, F.FORMAFATURAMENTO FROM CONDICAOPAGAMENTO C, FORMAFATURAMENTO F ' +
         ' WHERE C.CODIGOFORMAFATURAMENTO = F.CODIGOFORMAFATURAMENTO ' +
         ' ORDER BY ' +
         IfThen(RadCod.Checked,' C.CODIGOCONDICAOPAGAMENTO ') +
         IfThen(RadNome.Checked,' C.CONDICAOPAGAMENTO ') +
         IfThen(RadFF.Checked,' F.FORMAFATURAMENTO '),dm.dbautocom, DsRel);

  DsREl.First;
  Dm.CdsCP.EmptyDataSet;
  while not DsRel.Eof do
    begin
      Dm.CdsCP.Insert;
      Dm.CdsCPCODIGOCONDICAOPAGAMENTO.Value := DsRel.FieldByName('CODIGOCONDICAOPAGAMENTO').Value;
      Dm.CdsCPCONDICAOPAGAMENTO.Value := DsRel.FieldByName('CONDICAOPAGAMENTO').Value;
      Dm.CdsCPCODIGOFORMAFATURAMENTO.Value := DsRel.FieldByName('CODIGOFORMAFATURAMENTO').Value;
      Dm.CdsCPNUMEROPARCELAS.Value := DsRel.FieldByName('NUMEROPARCELAS').Value;
      Dm.CdsCPPRIMEIRAPARCELA.Value := DsRel.FieldByName('PRIMEIRAPARCELA').Value;
      Dm.CdsCPINTERVALOPARCELAS.Value := DsRel.FieldByName('INTERVALOPARCELAS').Value;
      if DsRel.FieldByName('AUTENTICA').AsString = 'T' then Dm.CdsCPAUTENTICA.Value := 'Sim' else Dm.CdsCPAUTENTICA.Value := 'N?o';
      if DsRel.FieldByName('IMPRESSAOCHEQUE').AsString = 'T' then Dm.CdsCPIMPRESSAOCHEQUE.Value := 'Sim' else Dm.CdsCPIMPRESSAOCHEQUE.Value := 'N?o';

      case DsRel.FieldByName('TIPOTROCO').AsInteger of
        0: Dm.CdsCPTIPOTROCO.AsString := 'N?O PERMITE';
        1: Dm.CdsCPTIPOTROCO.AsString := 'PERMITE';
        2: Dm.CdsCPTIPOTROCO.AsString := 'CONTRA-VALE';
        3: Dm.CdsCPTIPOTROCO.AsString := 'PERGUNTA POR REPIQUE';
      end;

      case DsRel.FieldByName('FUNCAOESPECIAL').AsInteger of
        0: Dm.CdsCPTIPOTROCO.AsString := 'SEM FUN??O';
        1: Dm.CdsCPTIPOTROCO.AsString := 'CONSULTA LISTA NEGRA';
        2: Dm.CdsCPTIPOTROCO.AsString := 'CONV?NIO';
        3: Dm.CdsCPTIPOTROCO.AsString := 'CONSULTA CHEQUE TEF';
        4: Dm.CdsCPTIPOTROCO.AsString := 'TEF REDECARD/VISANET/AMEX';
        5: Dm.CdsCPTIPOTROCO.AsString := 'TEF TECBAN';
      end;

      if DsRel.FieldByName('ATIVOVENDA').AsString = 'T' then Dm.CdsCPATIVOVENDA.Value := 'Sim' else Dm.CdsCPATIVOVENDA.Value := 'N?o';
      if DsRel.FieldByName('ATIVOFINANCEIRO').AsString = 'T' then Dm.CdsCPATIVOFINANCEIRO.Value := 'Sim' else Dm.CdsCPATIVOFINANCEIRO.Value := 'N?o';
      if DsRel.FieldByName('SOMASALDO').AsString = 'T' then Dm.CdsCPSOMASALDO.Value := 'Sim' else Dm.CdsCPSOMASALDO.Value := 'N?o';
      Dm.CdsCPFORMAFATURAMENTO.Value := DsRel.FieldByName('FORMAFATURAMENTO').Value;
      Dm.CdsCP.Post;
      DsRel.Next;
    end;
  DM.Rave.ProjectFile:=ExtractFilePath(application.exename)+'CPagamento.rav';
  Dm.Rave.Execute;
end;

procedure TfRelatorio.CmbCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfRelatorio.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then BtnImprimir.Click;
  if Key = VK_ESCAPE then BtnCancelar.Click;
end;

procedure TfRelatorio.DsCacula(DataSet: TDataSet);
begin
  if DsRel.FieldByName('ATIVOVENDA').AsString = 'T' then DsRel.FieldByName('BAtivoVenda').Value := 'Sim' else DsRel.FieldByName('BAtivoVenda').Value := 'N?o';
  if DsRel.FieldByName('ATIVOFINACEIRO').AsString = 'T' then DsRel.FieldByName('BAtivoFinanceiro').Value := 'Sim' else DsRel.FieldByName('BAtivoFinanceiro').Value := 'N?o';
  if DsRel.FieldByName('IMPRESSAOCHEQUE').AsString = 'T' then DsRel.FieldByName('BCheque').Value := 'Sim' else DsRel.FieldByName('BCheque').Value := 'N?o';
  if DsRel.FieldByName('ATENTICA').AsString = 'T' then DsRel.FieldByName('BAtentificar').Value := 'Sim' else DsRel.FieldByName('BAtentificar').Value := 'N?o';
  if DsRel.FieldByName('SOMASALDO').AsString = 'T' then DsRel.FieldByName('BSomaSaldo').Value := 'Sim' else DsRel.FieldByName('BSomaSaldo').Value := 'N?o';
end;


end.
