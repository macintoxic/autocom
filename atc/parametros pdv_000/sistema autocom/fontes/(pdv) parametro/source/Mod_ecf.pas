unit Mod_ecf;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons;

type
  TModECF = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ListBox1: TListBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ListBox2: TListBox;
    procedure ListBox1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ListBox2DblClick(Sender: TObject);
    procedure ListBox2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Monta_Lista(inicio,fim:integer);
    function Exportanome:boolean;
  end;

var
  ModECF: TModECF;

implementation

uses Par;

{$R *.DFM}

procedure TModECF.ListBox1Click(Sender: TObject);
begin
     if listbox1.items[listbox1.itemindex]='DEMO'             then Monta_lista(99,99);
     if listbox1.items[listbox1.itemindex]='NCR'              then Monta_lista(20,29);
     if listbox1.items[listbox1.itemindex]='BEMATECH'         then Monta_lista(30,39);
     if listbox1.items[listbox1.itemindex]='CONTROLE INTERNO' then Monta_lista(01,02);
     if listbox1.items[listbox1.itemindex]='AFRAC'            then Monta_lista(40,49);
end;

procedure TModECF.Monta_Lista(inicio,fim:integer);
var a:integer;
begin
     Listbox2.clear;
     for a:=inicio to fim do
        begin
           if PARAMETRO.modeloecf(a)<>'' then
              begin
                 Listbox2.items.add(PARAMETRO.modeloecf(a));
              end;
        end;
end;

function TMODECF.Exportanome:boolean;
begin
     if listbox2.itemindex<0 then
        begin
           result:=false;
           exit;
        end;
     if listbox2.items[listbox2.itemindex]<>'' then
        begin
           try
              PARAMETRO.edmodecf.text:=listbox2.items[listbox2.itemindex];
              result:=true;
           except
              result:=false;
           end;
        end
     else
        begin
           result:=false;
        end;
end;

procedure TModECF.BitBtn2Click(Sender: TObject);
begin
     close;
end;

procedure TModECF.BitBtn1Click(Sender: TObject);
begin
     if Exportanome=true then close;
end;

procedure TModECF.ListBox2DblClick(Sender: TObject);
begin
     if Exportanome=true then close;
end;

procedure TModECF.ListBox2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key=vk_return then
        begin
           if Exportanome=true then close;
        end;
end;

procedure TModECF.FormActivate(Sender: TObject);
begin
     Monta_lista(30,39);
     ListBox1.ItemIndex:=0;
end;

end.
