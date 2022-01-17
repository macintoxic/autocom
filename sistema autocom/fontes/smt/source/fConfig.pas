unit fConfig;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Mask, XPStyleActnCtrls, StrUtils,
  ActnList, ActnMan, ToolWin, ActnCtrls, IniFiles, uGlobal;

type
  TFrmConfig = class(TForm)
    Label1: TLabel;
    Label4: TLabel;
    TxtPedido: TEdit;
    Label5: TLabel;
    TxtVendedor: TEdit;
    Label6: TLabel;
    CmbOrigem: TComboBox;
    ChkObs: TCheckBox;
    PanServico: TPanel;
    ChkServico: TCheckBox;
    Label7: TLabel;
    MskTerminais: TMaskEdit;
    MskTabelaPreco: TMaskEdit;
    AmConfig: TActionManager;
    ActionToolBar1: TActionToolBar;
    ActGravar: TAction;
    ActCancelar: TAction;
    PanLimite: TPanel;
    Label2: TLabel;
    MskLimiteDe: TMaskEdit;
    Label3: TLabel;
    MskLimiteeAte: TMaskEdit;
    Label9: TLabel;
    PanDataBase: TPanel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    MskIp: TMaskEdit;
    MskEndereco: TMaskEdit;
    Cmd: TSpeedButton;
    ActPastas: TAction;
    DlgOpen: TOpenDialog;
    Label12: TLabel;
    CmbPoliticaPreco: TComboBox;
    ChkPrintGrill: TCheckBox;
    SpeedButton1: TSpeedButton;
    MemoMensagem: TMemo;
    Label13: TLabel;
    CmbAcrescimo: TComboBox;
    CmbDesconto: TComboBox;
    Label14: TLabel;
    Label15: TLabel;
    EdAcrescimo: TEdit;
    EdDesconto: TEdit;
    BtnLocal: TSpeedButton;
    procedure ChkServicoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure MskServValorKeyPress(Sender: TObject; var Key: Char);    
    procedure DlgOpenClose(Sender: TObject);
    procedure ActPastasExecute(Sender: TObject);
    procedure MskIpKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ActGravarExecute(Sender: TObject);
    procedure ActCancelarExecute(Sender: TObject);
    procedure CmeTabelaPrecoClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure MemoMensagemKeyPress(Sender: TObject; var Key: Char);
    procedure EdAcrescimoEnter(Sender: TObject);
    procedure EdDescontoEnter(Sender: TObject);
    procedure EdDescontoExit(Sender: TObject);
    procedure EdAcrescimoExit(Sender: TObject);
    procedure CmbAcrescimoChange(Sender: TObject);
    procedure CmbDescontoChange(Sender: TObject);
    procedure BtnLocalClick(Sender: TObject);
  private
    procedure GetIniData;
    procedure PostIniData;
    function Validacao: Boolean;
  public
    { Public declarations }
  end;

var
  FrmConfig: TFrmConfig;
    B_UsaServico: Boolean;

implementation

uses fMain, Math, fConsulta, Module;

{$R *.dfm}


procedure TFrmConfig.GetIniData;
{______________________________________________________________________________|
|  Autor:     André Faria Gomes                                               |
|  Data:      02/04/2003                                                       |
|  Argumentos: none                                                            |
|  Retorno:    none                                                            |
|                                                                              |
|  Pega dados do arquivo dados de configuracao do arquivo smt.ini              |
|______________________________________________________________________________}
var
  Ini: TIniFile;
begin
  Ini := TIniFile.Create(Patch + 'AUTOCOM.INI');
  MskTerminais.Text          := Ini.ReadString('SMT','NUMEROTERMINAIS','');
  TxtPedido.Text             := Ini.ReadString('SMT','NOMEPEDIDO','');
  TxtVendedor.Text           := Ini.ReadString('SMT','NOMEVENDEDOR','');
  MskLimiteDe.Text           := Ini.ReadString('SMT','LIMITEPEDIDOMINIMO','');
  MskLimiteeAte.Text         := Ini.ReadString('SMT','LIMITEPEDIDOMAXIMO','');
  MskIp.Text                 := Ini.ReadString('ATCPLUS','IP_SERVER','');
  MskEndereco.Text           := Ini.ReadString('ATCPLUS','PATH_DB','');

  SqlRun('SELECT CODIGOTABELA FROM TABELAPRECO WHERE CODIGOTABELAPRECO = ' + Ini.ReadString('SMT','CODIGOTABELAPRECO',''), Dm.Rede);
  MskTabelaPreco.Text        := Dm.Rede.Fields[0].AsString;

  if IsFloat(Ini.ReadString('SMT','POLITICAPRECO','')) then
    CmbPoliticaPreco.ItemIndex := StrtoInt(Ini.ReadString('SMT','POLITICAPRECO',''));

  if Ini.ReadString('SMT','USA_SERVICO','') = '1' then
    ChkServico.Checked := True else ChkServico.Checked := False;

  if Ini.ReadString('SMT','PRINTGRILL','') = '1' then
    ChkPrintGrill.Checked := True else ChkPrintGrill.Checked := False;

  if Copy(Ini.ReadString('SMT','ACRESCIMO',''),1,1) = '$' then
    CmbAcrescimo.ItemIndex := 0 else CmbAcrescimo.ItemIndex := 1;

  if Copy(Ini.ReadString('SMT','DESCONTO',''),1,1) = '$' then
    CmbDesconto.ItemIndex := 0 else CmbDesconto.ItemIndex := 1;

  EdDesconto.Text := PChar(string(Ini.ReadString('SMT','DESCONTO','')))+1;
  EdAcrescimo.Text := PChar(string(Ini.ReadString('SMT','ACRESCIMO','')))+1;  

  if Ini.ReadString('SMT','OBSERVACAO','') = '1' then
    ChkObs.Checked := True else ChkObs.Checked := False;

  CmbOrigem.ItemIndex := StrToInt(Ini.ReadString('SMT','DELIVERY',''));

  MemoMensagem.Lines.Add(Ini.ReadString('CORTESIA','Linha0',''));
  MemoMensagem.Lines.Add(Ini.ReadString('CORTESIA','Linha1',''));
  MemoMensagem.Lines.Add(Ini.ReadString('CORTESIA','Linha2',''));
  MemoMensagem.Lines.Add(Ini.ReadString('CORTESIA','Linha3',''));
  MemoMensagem.Lines.Add(Ini.ReadString('CORTESIA','Linha4',''));
  MemoMensagem.Lines.Add(Ini.ReadString('CORTESIA','Linha5',''));
  Ini.Free;
  ChkServicoClick(ChkServico);
  EdAcrescimoExit(EdAcrescimo);
  EdDescontoExit(EdDesconto);
end;

procedure TFrmConfig.PostIniData;
{______________________________________________________________________________|
|  Autor:     André Faria Gomes                                               |
|  Data:      02/04/2003                                                       |
|  Argumentos: none                                                            |
|  Retorno:    none                                                            |
|                                                                              |
|  Grava dados no arquivo smt.ini                                              |
|______________________________________________________________________________}
var
  Ini: TIniFile;
//  TabelaPreco: string;
begin
  SqlRun('SELECT CODIGOTABELAPRECO FROM TABELAPRECO WHERE CODIGOTABELA = ' + MskTabelaPreco.Text, Dm.Rede);
  MemoMensagem.SetFocus;
  Ini := TIniFile.Create(Patch + 'AUTOCOM.INI');
  Ini.WriteString('SMT','NUMEROTERMINAIS',MskTerminais.Text);
  Ini.WriteString('SMT','NOMEPEDIDO',TxtPedido.Text);
  Ini.WriteString('SMT','NOMEVENDEDOR',TxtVendedor.Text);
  Ini.WriteString('SMT','LIMITEPEDIDOMINIMO',MskLimiteDe.Text);
  Ini.WriteString('SMT','LIMITEPEDIDOMAXIMO',MskLimiteeAte.Text);
  Ini.WriteString('SMT','CODIGOTABELAPRECO',Dm.Rede.Fields[0].AsString);
  Ini.WriteString('ATCPLUS','IP_SERVER',MskIp.Text);
  Ini.WriteString('ATCPLUS','PATH_DB',MskEndereco.Text);
  Ini.WriteString('SMT','DELIVERY',IntToStr(CmbOrigem.ItemIndex));
  Ini.WriteString('SMT','POLITICAPRECO',IntToStr(CmbPoliticaPreco.ItemIndex));

  EdDescontoEnter(EdDesconto);
  EdAcrescimoEnter(EdAcrescimo);
  if ChkServico.Checked then
    begin
      Ini.WriteString('SMT','USA_SERVICO','1');
      Ini.WriteString('SMT','ACRESCIMO',IfThen(CmbAcrescimo.ItemIndex=0,'$','%') + EdAcrescimo.Text);
      Ini.WriteString('SMT','DESCONTO',IfThen(CmbDesconto.ItemIndex=0,'$','%') + EdDesconto.Text);
    end
  else
    begin
      Ini.WriteString('SMT','USA_SERVICO','0');
      Ini.WriteString('SMT','ACRESCIMO','$0,00');
      Ini.WriteString('SMT','DESCONTO','$0,00');
    end;                          

  if ChkObs.Checked then
    Ini.WriteString('SMT','OBSERVACAO','1')
  else Ini.WriteString('SMT','OBSERVACAO','0');

  if ChkPrintGrill.Checked then
    Ini.WriteString('SMT','PRINTGRILL','1')
  else Ini.WriteString('SMT','PRINTGRILL','0');

  Ini.WriteString('CORTESIA','Linha0',MemoMensagem.Lines[0]);
  Ini.WriteString('CORTESIA','Linha1',MemoMensagem.Lines[1]);
  Ini.WriteString('CORTESIA','Linha2',MemoMensagem.Lines[2]);
  Ini.WriteString('CORTESIA','Linha3',MemoMensagem.Lines[3]);
  Ini.WriteString('CORTESIA','Linha4',MemoMensagem.Lines[4]);
  Ini.WriteString('CORTESIA','Linha5',MemoMensagem.Lines[5]);

  Dm.Rede.Close;
  Ini.Free;
end;

function TFrmConfig.Validacao: Boolean;
{______________________________________________________________________________|
|  Autor:     André Faria Gomes                                                |
|  Data:      02/04/2003                                                       |
|  Argumentos: none                                                            |
|  Retorno:    Verdeiro para Sucesso - False para Erro                         |
|                                                                              |
|  Grava dados no arquivo smt.ini                                              |
|______________________________________________________________________________}
begin
  Result := False;

  try
    Dm.DBAutocom.Close;
    Dm.DBAutocom.DatabaseName := MskIp.Text + ':' + MskEndereco.Text;
    Dm.DBAutocom.Open;
  except
    Application.MessageBox('Banco de dados não encontrado, Verifique!'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    MskIp.SetFocus;
    Exit;
  end;

  if IsNull(MskTerminais.Text) then
  begin
    Application.MessageBox('O Campo número de terminais não pode ficar vazio, Verifique'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    MskTerminais.SetFocus;
    Exit;
  end;

  if StrToFloat(MskTerminais.Text) > 30 then
  begin
    Application.MessageBox('O número máximo de terminais é 30, Verifique'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    MskTerminais.SetFocus;
    Exit;
  end;

  if StrToFloat(MskTerminais.Text) > 30 then
  begin
    Application.MessageBox('O número máximo de terminais é 30, Verifique'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    MskTerminais.SetFocus;
    Exit;
  end;

  if IsNull(TxtPedido.Text) then
  begin
    Application.MessageBox('O campo nome do pedido não pode ficar vazio, Verifique'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    TxtPedido.SetFocus;
    Exit;
  end;

  if IsNull(MskLimiteDe.Text) then
  begin
    Application.MessageBox('Os campos de limite não podem ficar vazios, Verifique'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    MskLimiteDe.SetFocus;
    Exit;
  end;

  if IsNull(MskLimiteeAte.Text) then
  begin
    Application.MessageBox('Os campos de limite não podem ficar vazios, Verifique'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    MskLimiteeAte.SetFocus;
    Exit;
  end;

  if IsNull(TxtVendedor.Text) then
  begin
    Application.MessageBox('O campo nome do Vendedor não pode ficar vazio, Verifique'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    TxtVendedor.SetFocus;
    Exit;
  end;

  if CmbPoliticaPreco.ItemIndex = -1 then
  begin
    Application.MessageBox('Algum valor deve ser selecionado no campo Política de Preço, Verifique'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    MskTabelaPreco.SetFocus;
    Exit;
  end;


  if IsNull(MskTabelaPreco.Text) then
  begin
    Application.MessageBox('O campo tabela de preço não pode ficar vazio, Verifique'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    MskTabelaPreco.SetFocus;
    Exit;
  end;

  if CmbOrigem.ItemIndex = -1 then
  begin
    Application.MessageBox('Algum valor deve ser selecionado no campo origem, Verifique'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    MskTabelaPreco.SetFocus;
    Exit;
  end;

  if IsNull(MskIp.Text) then
  begin
    Application.MessageBox('O campo IP do Servidor não pode ficar vazio, Verifique'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    MskIp.SetFocus;
    Exit;
  end;

  if IsNull(MskEndereco.Text) then
  begin
    Application.MessageBox('O campo endereço não pode ficar vazio, Verifique'
                           ,'Autocom PLUS',MB_ICONEXCLAMATION);
    MskEndereco.SetFocus;
    Exit;
  end;


  Result := True;
end;


{******************************************************************************|
|                                  EVENTOS                                     |
|******************************************************************************}

procedure TFrmConfig.ActGravarExecute(Sender: TObject);
begin
  if Validacao then
  begin
    PostIniData;
    Application.MessageBox('Reinicie o SMT para efetivar as alterações!'
                           ,Autocom,MB_ICONEXCLAMATION);
    Close;
  end;
end;

procedure TFrmConfig.ChkServicoClick(Sender: TObject);
begin
  if ChkServico.Checked then
    EnableFields(True,PanServico,Self)
  else
    EnableFields(False,PanServico,Self);
end;

procedure TFrmConfig.FormShow(Sender: TObject);
begin
  GetIniData;
  ChkServicoClick(Self);
end;

procedure TFrmConfig.DlgOpenClose(Sender: TObject);
begin
  MskEndereco.Text := DlgOpen.FileName;
end;

procedure TFrmConfig.ActPastasExecute(Sender: TObject);
begin
  DlgOpen.Execute;
  MskEndereco.Text := DlgOpen.FileName;
end;

procedure TFrmConfig.MskIpKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key <> '1') and (Key <> '2') and (Key <> '3') and (Key <> '4') and
    (Key <> '4') and (Key <> '6') and (Key <> '7') and (Key <> '8') and
    (Key <> '9') and (Key <> '0') and (Key <> '5') and (Key <> '.') and
    (Key <> #13) and (Key <> #8) then  Key := #0;
end;

procedure TFrmConfig.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_Return then Perform(WM_NEXTDLGCTL,0,0);
end;

procedure TFrmConfig.ActCancelarExecute(Sender: TObject);
begin
  Close;
end;

procedure TFrmConfig.MskServValorKeyPress(Sender: TObject; var Key: Char);
begin
  {Se Pressionar ponto retorna virgula}
  if key = #46 then key := #44;
end;



procedure TFrmConfig.CmeTabelaPrecoClick(Sender: TObject);
begin
  Dm.Tbl_TabelaPreco.Open;
  with TFrmConsulta.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  Dm.Tbl_TabelaPreco.Close;
  MskTabelaPreco.Text := FloatToStr(CodigoCosultaInterno);
end;


procedure TFrmConfig.SpeedButton1Click(Sender: TObject);
begin
  Dm.Tbl_TabelaPreco.Open;
  with TFrmConsulta.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
  MskTabelaPreco.Text := FloatToStr(CodigoCosultaInterno);
  Dm.Tbl_TabelaPreco.Close;
end;

procedure TFrmConfig.MemoMensagemKeyPress(Sender: TObject; var Key: Char);
begin
  if MemoMensagem.Lines.Count > 5 then Key := #0;
end;

procedure TFrmConfig.EdAcrescimoEnter(Sender: TObject);
begin
  if CmbAcrescimo.ItemIndex = 0 then
    FormatEdit(Sender,CurrencyIn)
  else
    FormatEdit(Sender,PorcentIn);
end;

procedure TFrmConfig.EdDescontoEnter(Sender: TObject);
begin
  if CmbDesconto.ItemIndex = 0 then
    FormatEdit(Sender,CurrencyIn)
  else
    FormatEdit(Sender,PorcentIn);
end;

procedure TFrmConfig.EdDescontoExit(Sender: TObject);
begin
  if CmbDesconto.ItemIndex = 0 then
    FormatEdit(Sender,CurrencyOut)
  else
    FormatEdit(Sender,PorcentOut);

end;

procedure TFrmConfig.EdAcrescimoExit(Sender: TObject);
begin
  if CmbAcrescimo.ItemIndex = 0 then
    FormatEdit(Sender,CurrencyOut)
  else
    FormatEdit(Sender,PorcentOut);
end;

procedure TFrmConfig.CmbAcrescimoChange(Sender: TObject);
begin
  EdAcrescimo.Clear;
end;

procedure TFrmConfig.CmbDescontoChange(Sender: TObject);
begin
  EdDesconto.Clear;
end;

procedure TFrmConfig.BtnLocalClick(Sender: TObject);
begin
  MskIp.Text := 'localhost';
end;

end.
