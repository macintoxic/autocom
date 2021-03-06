unit uRelatorio;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, ExtCtrls, Buttons, uGlobal, StrUtils, DB;

type
  TfRelatorio = class(TForm)
    PanCep: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    MskCep1: TMaskEdit;
    MskCep2: TMaskEdit;
    ChkCep: TCheckBox;
    PanEndereco: TPanel;
    CmbTipoEndereco: TComboBox;
    ChkEndereco: TCheckBox;
    BtnImprimir: TSpeedButton;
    BtnCancelar: TSpeedButton;
    RadGrp: TRadioGroup;
    procedure BtnCancelarClick(Sender: TObject);
    procedure ChkEnderecoClick(Sender: TObject);
    procedure ChkCepClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BtnImprimirClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
    DsRel: TDataSet;
  end;

var
  fRelatorio: TfRelatorio;

implementation

uses uDm;

{$R *.dfm}

procedure TfRelatorio.BtnCancelarClick(Sender: TObject);
begin
  Close;
end;

procedure TfRelatorio.ChkEnderecoClick(Sender: TObject);
begin
  if ChkEndereco.Checked then
    begin
      EnableFields(True,PanEndereco);
      RadGrp.Items.Text := 'C?digo' + #13 + 'Nome' + #13 + 'Cidade' + #13 + 'Estado';
      CmbTipoEndereco.ItemIndex := 0;
      ChkCep.Enabled := True;
    end
  else
    begin
      EnableFields(False,PanEndereco);
      RadGrp.Items.Text := 'C?digo' + #13 + 'Nome';
      ChkCep.Enabled := False;
    end;
end;

procedure TfRelatorio.ChkCepClick(Sender: TObject);
begin
  if ChkCep.Checked then EnableFields(True,PanCep) else EnableFields(False,PanCep);
end;

procedure TfRelatorio.FormShow(Sender: TObject);
var
  DsAux: TDataSet;
begin
  RunSql('SELECT TEN_DESCRICAO_A FROM TIPOENDERECO ORDER BY TEN_DESCRICAO_A',dm.dbautocom,DsAux);
  while not DsAux.Eof do
    begin
      CmbTipoEndereco.Items.Add(DsAux.Fields[0].AsString);
      DsAux.Next;
    end;
end;

procedure TfRelatorio.BtnImprimirClick(Sender: TObject);
begin
  FreeAndNil(DsRel);
  if (ChkCep.Checked) and ((not IsInteger(MskCep1.Text)) or (not IsInteger(MskCep2.Text))) then
    begin
      Application.MessageBox('Cep inv?lido, Verifique!',Autocom,MB_ICONERROR);
      MskCep1.SetFocus;
      Abort;
    end;
  RunSql(' SELECT T.*, P.* ' + IfThen(ChkEndereco.Checked,' ,E.* ') +
         ' FROM CLIENTE T, PESSOA P ' +
         IfThen(ChkEndereco.Checked,' INNER JOIN ENDERECOPESSOA E ON (E.PES_CODPESSOA = P.PES_CODPESSOA) ') +
         ' WHERE T.PES_CODPESSOA = P.PES_CODPESSOA ' +
         IfThen(ChkEndereco.Checked,'AND TEN_CODTIPOENDERECO = ' + KeyLookUp('TEN_DESCRICAO_A','TEN_CODTIPOENDERECO','TIPOENDERECO',QuotedStr(CmbTipoEndereco.Text),Dm.dbautocom)) +
         IfThen(ChkCep.Checked,' AND E.ENP_CEP_I BETWEEN ' + MskCep1.Text + ' AND ' + MskCep2.Text) +
         ' ORDER BY ' +
         IfThen(RadGrp.ItemIndex = 0,'T.CODIGOCLIENTE') +
         IfThen(RadGrp.ItemIndex = 1,'P.PES_NOME_A') +
         IfThen(RadGrp.ItemIndex = 2,'E.ENP_CIDADE_A') +
         IfThen(RadGrp.ItemIndex = 3,'E.ENP_ESTADO_A')
         ,dm.dbautocom,DsRel);

  if DsRel.IsEmpty then
    begin
      Application.MessageBox('Nenhum registro encontrado!',Autocom,MB_ICONWARNING);
      Abort;
    end;

  Dm.RvConn.SetParam('Tipo',CmbTipoEndereco.Text);
  TFloatField(DsRel.FieldByName('LIMITECREDITO')).currency := True;
//  TDateField(DsRel.FieldByName('CLIENTEDESDE')).DisplayFormat := 'dd/mm/yyyy';
//  TDateField(DsRel.FieldByName('PREVISAOCONTATO')).DisplayFormat := 'dd/mm/yyyy';
//  TDateField(DsRel.FieldByName('ULTIMOCONTATO')).DisplayFormat := 'dd/mm/yyyy';
//  TDateField(DsRel.FieldByName('ULTIMAALTERACAO')).DisplayFormat := 'dd/mm/yyyy';

  DsRel.Last; //Este First e Last foi inserido por causa de um bug no RecordCount.
  DsRel.First;
  Dm.RvConn.SetParam('Total',IntToStr(DsRel.RecordCount));

  Dm.RvDs.DataSet := DsRel;
  DM.RvConn.ProjectFile:=ExtractFilePath(application.exename)+'CClientes.rav';
  if ChkEndereco.Checked then Dm.RvConn.ExecuteReport('RFull') else Dm.RvConn.ExecuteReport('RBasic');
end;

procedure TfRelatorio.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  FreeAndNil(DsRel);
end;

end.

