unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, ImgList, ComCtrls, ExtCtrls, StdCtrls, Grids, DBGrids;

type
  TfrmPrincipal = class(TfrmPadrao)
    Panel1: TPanel;
    Panel2: TPanel;
    ListView1: TListView;
    ImageList1: TImageList;
    Panel3: TPanel;
    Panel4: TPanel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Edit4: TEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    DBGrid1: TDBGrid;
    Panel5: TPanel;
    Panel6: TPanel;
    Label10: TLabel;
    lblMesa: TLabel;
    Panel7: TPanel;
    procedure ListView1DragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ListView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses Contnrs;

{$R *.dfm}

procedure TfrmPrincipal.ListView1DragDrop(Sender, Source: TObject; X,
  Y: Integer);
var 
   li : TListItem;
begin
   li := (Source As TListView).Selected;
   li.SetPosition(Point(X, Y));
end;

procedure TfrmPrincipal.ListView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
     if ListView1.GetItemAt(x,y) <> nil then
        lblMesa.Caption := ListView1.GetItemAt(x,y).Caption;
end;

end.
