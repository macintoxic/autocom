unit fConsulta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, ActnList, XPStyleActnCtrls, ActnMan, Buttons;

type
  TFrmConsulta = class(TForm)
    GrdConsulta: TDBGrid;
    DsConsulta: TDataSource;
    AmConsulta: TActionManager;
    ActSelecionar: TAction;
    SpeedButton1: TSpeedButton;
    procedure ActSelecionarExecute(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrdConsultaDblClick(Sender: TObject);
  private
  public
  end;

var
  FrmConsulta: TFrmConsulta;
    CodigoCosultaInterno: Real;

implementation

uses Module, fMain;

{$R *.dfm}

procedure TFrmConsulta.ActSelecionarExecute(Sender: TObject);
begin
  CodigoCosultaInterno := Dm.Tbl_TabelaPrecoCODIGOTABELA.AsFloat;
  Close;
end;

procedure TFrmConsulta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then ActSelecionar.Execute;
  if Key = VK_ESCAPE then Close;
end;

procedure TFrmConsulta.GrdConsultaDblClick(Sender: TObject);
begin
  ActSelecionar.Execute;
end;

end.
