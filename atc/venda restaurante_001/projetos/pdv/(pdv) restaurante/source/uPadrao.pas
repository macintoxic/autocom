unit uPadrao;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, StdCtrls;

type
    TfrmPadrao = class(TForm)
        procedure FormKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
    private
        { Private declarations }
    public
        { Public declarations }
    protected
        procedure Numerosdecimais(Sender: TObject; var Key: Char);
        procedure SoNumeros(Sender: TObject; var Key: Char);
    end;

var
    frmPadrao: TfrmPadrao;

implementation

{$R *.dfm}

procedure TfrmPadrao.FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    case key of
        VK_RETURN, VK_DOWN: Perform(WM_NEXTDLGCTL, 0, 0);
        VK_UP: Perform(WM_NEXTDLGCTL, 1, 0);
        VK_ESCAPE: Self.Close;
    end;
end;

procedure TfrmPadrao.Numerosdecimais(Sender: TObject; var Key: Char);
begin
    //prefiro fazer o controle dessa forma. Charles.
    if key = '.' then
        key := ',';
    if not (key in ['0'..'9', #8, DecimalSeparator]) then
        key := #0;
    if (key = DecimalSeparator) and (Pos(DecimalSeparator, (Sender as
        TCustomEdit).Text) > 0) and
        (Length((Sender as TCustomEdit).Text) <> Length((Sender as
        TCustomEdit).SelText)) then
        key := #0;
end;

procedure TfrmPadrao.SoNumeros(Sender: TObject; var Key: Char);
begin
    //prefiro fazer o controle dessa forma. Charles.
    if not (key in ['0'..'9', #8]) then
        key := #0;
    if key = '.' then
        key := ',';
end;

end.
