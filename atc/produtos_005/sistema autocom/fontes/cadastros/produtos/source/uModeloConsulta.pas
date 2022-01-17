unit uModeloConsulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, ActnList, XPStyleActnCtrls, ActnMan,
  Buttons, DB, uGlobal, uSqlGlobal, StdCtrls;

type
  TfModeloConsulta = class(TForm)
    GrdConsulta: TDBGrid;
    PanFields: TPanel;
    PanBtns: TPanel;
    BtnNovo: TSpeedButton;
    BtnEditar: TSpeedButton;
    BtnSalvar: TSpeedButton;
    DsConsulta: TDataSource;
    BtnExcluir: TSpeedButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BtnExcluirClick(Sender: TObject);
    procedure BtnNovoClick(Sender: TObject);
    procedure BtnEditarClick(Sender: TObject);
  private
  public
    DataSetConsulta: TDataSet;
    State: TSqlAction;
    procedure Refresh; virtual; abstract;
    procedure Editando(Status: Boolean);
    procedure Seleciona; virtual; abstract;
  end;

var
  fModeloConsulta: TfModeloConsulta;

implementation

uses uMain, uDm, Math;

{$R *.dfm}

procedure TfModeloConsulta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE: Close;
    VK_RETURN:
      begin
         if ActiveControl.Name = 'EdNome' then BtnSalvar.Click;
      end;
  end;
end;


procedure TfModeloConsulta.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  FreeAndNil(DataSetConsulta);
end;

procedure TfModeloConsulta.FormShow(Sender: TObject);
begin
  DataBaseAutocom := Dm.DBAutocom;
  ZeroMemory(@ResultConsultaCodigo,SizeOf(ResultConsultaCodigo));
  ZeroMemory(@ResultConsultaNome,SizeOf(ResultConsultaNome));
end;

procedure TfModeloConsulta.BtnExcluirClick(Sender: TObject);
begin
  if MessageBox(Handle,'Deseja realmente excluir este registro?',Autocom,MB_ICONQUESTION + MB_YESNO) = ID_NO then Abort;
end;

procedure TfModeloConsulta.Editando(Status: Boolean);
begin
  if Status then
    begin
      BtnNovo.Enabled := False;
      BtnEditar.Enabled := False;
      BtnExcluir.Enabled := False;
      BtnSalvar.Enabled := True;
    end
  else
    begin
      BtnNovo.Enabled := True;
      BtnEditar.Enabled := True;
      BtnExcluir.Enabled := True;
      BtnSalvar.Enabled := False;
    end;
end;

procedure TfModeloConsulta.BtnNovoClick(Sender: TObject);
begin
  GrdConsulta.Enabled := False;
end;

procedure TfModeloConsulta.BtnEditarClick(Sender: TObject);
begin
  if DataSetConsulta.IsEmpty then Exit;
  GrdConsulta.Enabled := False;
end;

end.
