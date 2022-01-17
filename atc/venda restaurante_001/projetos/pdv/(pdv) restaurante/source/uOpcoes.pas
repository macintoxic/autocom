unit uOpcoes;

interface

uses
    Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
    Dialogs, uPadrao, Buttons, ExtCtrls, StdCtrls;

type
    TfrmOpcoes = class(TfrmPadrao)
        Panel1: TPanel;
        SpeedButton1: TSpeedButton;
        SpeedButton2: TSpeedButton;
        SpeedButton3: TSpeedButton;
        procedure SpeedButton1Click(Sender: TObject);
        procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
        procedure FormKeyDown(Sender: TObject; var Key: Word;
            Shift: TShiftState);
        procedure FormCreate(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    frmOpcoes: TfrmOpcoes;

implementation
uses uRotinas;
{$R *.dfm}

procedure TfrmOpcoes.SpeedButton1Click(Sender: TObject);
begin
    Self.Tag := (Sender as TSpeedButton).Tag;
    Close;
end;

procedure TfrmOpcoes.FormCloseQuery(Sender: TObject;
    var CanClose: Boolean);
begin
    case Self.Tag of
        1: ModalResult := mrCancel;
        2: ModalResult := mrOk;
        3: ModalResult := mrNo;
    end;
    CanClose := True;
end;

procedure TfrmOpcoes.FormKeyDown(Sender: TObject; var Key: Word;
    Shift: TShiftState);
begin
    case key of
        VK_F1: SpeedButton1.Click;
        VK_F2:
            begin
                if SpeedButton2.Enabled then
                    SpeedButton2.Click;
            end;
        VK_F3, VK_ESCAPE: SpeedButton3.Click;
    end;
end;

procedure TfrmOpcoes.FormCreate(Sender: TObject);
begin
    inherited;
    SpeedButton2.Caption := format(SpeedButton2.Caption,
        [AnsiLowerCase(leini(TIPO_TERMINAL, 'legenda'))]);
end;

end.
