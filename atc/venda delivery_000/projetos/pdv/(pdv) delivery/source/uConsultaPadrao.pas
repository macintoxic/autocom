//******************************************************************************
// 
//                 UNIT UCONSULTAPADRAO (-)
// 
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           uConsultaPadrao.pas
// Directory:      D:\projetos\pdv - novo\source\
// Function:       ..
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Delphi Compiled Unit: uConsultaPadrao.dcu
// Resources:      Win32 API
// Notes:          ..
// Revisions:      
// 
// 1.0.0 01/01/2001 First Version
// 
//******************************************************************************

unit uConsultaPadrao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, DB;

type
  TfrmConsultaPadrao = class(TForm)
    pnlDicas: TPanel;
    dsClientes: TDataSource;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaPadrao: TfrmConsultaPadrao;

implementation
uses udmPDV;
{$R *.dfm}

procedure TfrmConsultaPadrao.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     case key of
          VK_RETURN:
          begin
              if ActiveControl is TDBGrid then
                 Close;
              Perform(WM_NEXTDLGCTL,0,0);
          end;
          VK_DOWN:
                  begin
                       if not (ActiveControl is TDBGrid) then
                          Perform(WM_NEXTDLGCTL,0,0);
                  end;
          VK_UP:
                begin
                     if not (ActiveControl is TDBGrid) then
                     Perform(WM_NEXTDLGCTL,1,0);
                end;
          VK_ESCAPE:
          begin
               Self.Tag := 1;
               Close;
          end;
     end;

end;

procedure TfrmConsultaPadrao.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
     if Self.Tag = 1 then
        ModalResult :=  mrCancel
        else
            ModalResult :=  mrOk;
     CanClose := True;
end;

end.
 
//******************************************************************************
//*                          End of File uConsultaPadrao.pas
//******************************************************************************
