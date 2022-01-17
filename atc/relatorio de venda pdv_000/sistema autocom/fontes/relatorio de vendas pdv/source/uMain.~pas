unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ActnList, XPStyleActnCtrls, ActnMan, StdCtrls, Buttons, uGlobal,
  SUIMgr, ExtCtrls, SUIForm, SuiThemes;

type
  TOptionsReturn = record
    IntCodeReturn: Integer;
    ExtCodeReturn: Integer;
    StringReturn: String;
  end;

type
  TKindOfConsulta = (Produto, Operador,  Indicador, Cliente, Grupo);
  TfMain = class(TForm)
    BtnProdutos: TSpeedButton;
    BtnSaldoClientes: TSpeedButton;
    BtnVendedores: TSpeedButton;
    LblTitle: TLabel;
    BtnExtratoCheques: TSpeedButton;
    BtnExtratoConvenio: TSpeedButton;
    BtnFaixaHoraria: TSpeedButton;
    BtnGrupo: TSpeedButton;
    BtnOperadores: TSpeedButton;
    BtnSangrias: TSpeedButton;
    BtnFechar: TSpeedButton;
    suiForm1: TsuiForm;
    skin: TsuiThemeManager;
    procedure BtnFecharClick(Sender: TObject);
    procedure BtnProdutosClick(Sender: TObject);
    procedure BtnGrupoClick(Sender: TObject);
    procedure BtnOperadoresClick(Sender: TObject);
    procedure BtnExtratoChequesClick(Sender: TObject);
    procedure BtnExtratoConvenioClick(Sender: TObject);
    procedure BtnFaixaHorariaClick(Sender: TObject);
    procedure BtnSaldoClientesClick(Sender: TObject);
    procedure BtnSangriasClick(Sender: TObject);
    procedure BtnVendedoresClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
  end;

var
  fMain: TfMain;
    ActiveConsulta : TKindOfConsulta;
    OptionsReturn  : TOptionsReturn;
    CodigoLoja     : Integer;
    Vendedor       : string;
implementation

uses DateUtils, uProdutos, uGrupos, uOperadores, uCheques, uConvenios,
  uHoras, uSaldoClientes, uSangrias, uIndicadores, uDm;

{$R *.dfm}

procedure TfMain.BtnFecharClick(Sender: TObject);
begin
  PostMessage(Handle, WM_SYSCOMMAND,SC_CLOSE,0);  
end;

procedure TfMain.BtnProdutosClick(Sender: TObject);
begin
  with TfProdutos.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
end;

procedure TfMain.BtnGrupoClick(Sender: TObject);
begin
  with TfGrupos.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
end;

procedure TfMain.BtnOperadoresClick(Sender: TObject);
begin
  with TfOperadores.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
end;

procedure TfMain.BtnExtratoChequesClick(Sender: TObject);
begin
  with TfCheques.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
end;

procedure TfMain.BtnExtratoConvenioClick(Sender: TObject);
begin
  with TfConvenios.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
end;

procedure TfMain.BtnFaixaHorariaClick(Sender: TObject);
begin
  with TfHoras.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
end;

procedure TfMain.BtnSaldoClientesClick(Sender: TObject);
begin
  with TfSaldoClientes.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
end;

procedure TfMain.BtnSangriasClick(Sender: TObject);
begin
  with TfSangrias.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
end;

procedure TfMain.BtnVendedoresClick(Sender: TObject);
begin
  with TfIndicadores.Create(Self) do
    begin
      ShowModal;
      Free;
    end;
end;

procedure TfMain.FormActivate(Sender: TObject);
var Tipo_skin:string;
begin
     tipo_skin:=LeINI('ATCPLUS', 'skin');
     if (tipo_skin='0') or (tipo_skin='') then skin.uistyle:=WinXP;
     if (tipo_skin='1') then skin.uistyle:=BlueGlass;
     if (tipo_skin='2') then skin.uistyle:=DeepBlue;
     if (tipo_skin='3') then skin.uistyle:=MacOS;
     if (tipo_skin='4') then skin.uistyle:=Protein;
     application.processmessages;


  Dm.dbautocom.DatabaseName :=
    LeINI('ATCPLUS','IP_SERVER') + ':' + LeINI('ATCPLUS','PATH_DB');
  CodigoLoja := StrToIntDef(LeINI('Loja','LojaNum'),1);
  Vendedor := Copy(UpperCase(LeINI('TERMINAL','NOMEINDP')),1,1) + Copy(LowerCase(LeINI('TERMINAL','NOMEINDP')),2,40);
  BtnVendedores.Caption := '&' + Vendedor;
  Dm.dbautocom.Connected := True;
  Dm.Transaction.Active := True;
  RunSQL('Commit;');
  dm.RvAutocom.ProjectFile:=extractfilepath(application.exename)+'RPDV.rav';
  setforegroundwindow(application.handle);
end;

procedure TfMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Dm.CdsHoras.Close;
  Dm.CdsOperadoresF.Close;
  Dm.Transaction.Active := False;
  Dm.DBAutocom.Close;
end;

end.

