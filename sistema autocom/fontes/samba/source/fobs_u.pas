unit fobs_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  Tfobs = class(TForm)
    Panel1: TPanel;
    btnobssete: TBitBtn;
    btnobsoito: TBitBtn;
    btnobsnove: TBitBtn;
    btnobsseis: TBitBtn;
    btnobscinco: TBitBtn;
    btnobsquatro: TBitBtn;
    btnobstres: TBitBtn;
    btnobsdois: TBitBtn;
    btnobsHum: TBitBtn;
    btnobszero: TBitBtn;
    btnobslimpa: TBitBtn;
    GroupBox1: TGroupBox;
    Eobs: TEdit;
    btnobsQ: TBitBtn;
    btnobsW: TBitBtn;
    btnobsE: TBitBtn;
    btnobsR: TBitBtn;
    btnobsT: TBitBtn;
    btnobsY: TBitBtn;
    btnobsU: TBitBtn;
    btnobsI: TBitBtn;
    btnobsO: TBitBtn;
    btnobsP: TBitBtn;
    btnobsA: TBitBtn;
    btnobsS: TBitBtn;
    btnobsD: TBitBtn;
    btnobsF: TBitBtn;
    btnobsG: TBitBtn;
    btnobsH: TBitBtn;
    btnobsJ: TBitBtn;
    btnobsK: TBitBtn;
    btnobsL: TBitBtn;
    btnobsCEDILHA: TBitBtn;
    btnobsZ: TBitBtn;
    btnobsX: TBitBtn;
    btnobsC: TBitBtn;
    btnobsV: TBitBtn;
    btnobsB: TBitBtn;
    btnobsN: TBitBtn;
    btnobsM: TBitBtn;
    btnobsSPACE: TBitBtn;
    SpeedButton1: TSpeedButton;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnobsHumClick(Sender: TObject);
    procedure btnobsdoisClick(Sender: TObject);
    procedure btnobstresClick(Sender: TObject);
    procedure btnobsquatroClick(Sender: TObject);
    procedure btnobscincoClick(Sender: TObject);
    procedure btnobsseisClick(Sender: TObject);
    procedure btnobsseteClick(Sender: TObject);
    procedure btnobsoitoClick(Sender: TObject);
    procedure btnobsnoveClick(Sender: TObject);
    procedure btnobszeroClick(Sender: TObject);
    procedure btnobsQClick(Sender: TObject);
    procedure btnobsWClick(Sender: TObject);
    procedure btnobsEClick(Sender: TObject);
    procedure btnobsRClick(Sender: TObject);
    procedure btnobsTClick(Sender: TObject);
    procedure btnobsYClick(Sender: TObject);
    procedure btnobsUClick(Sender: TObject);
    procedure btnobsIClick(Sender: TObject);
    procedure btnobsOClick(Sender: TObject);
    procedure btnobsPClick(Sender: TObject);
    procedure btnobsAClick(Sender: TObject);
    procedure btnobsSClick(Sender: TObject);
    procedure btnobsDClick(Sender: TObject);
    procedure btnobsFClick(Sender: TObject);
    procedure btnobsGClick(Sender: TObject);
    procedure btnobsHClick(Sender: TObject);
    procedure btnobsJClick(Sender: TObject);
    procedure btnobsKClick(Sender: TObject);
    procedure btnobsLClick(Sender: TObject);
    procedure btnobsCEDILHAClick(Sender: TObject);
    procedure btnobsZClick(Sender: TObject);
    procedure btnobsXClick(Sender: TObject);
    procedure btnobsCClick(Sender: TObject);
    procedure btnobsVClick(Sender: TObject);
    procedure btnobsBClick(Sender: TObject);
    procedure btnobsNClick(Sender: TObject);
    procedure btnobsMClick(Sender: TObject);
    procedure btnobslimpaClick(Sender: TObject);
    procedure btnobsSPACEClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure btnobsbackspaceClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fobs: Tfobs;

implementation

uses pedido;

{$R *.dfm}

procedure Tfobs.BitBtn1Click(Sender: TObject);
begin
fobs.Close;
end;

procedure Tfobs.btnobsHumClick(Sender: TObject);
begin
eobs.text:= eobs.text + '1';
end;

procedure Tfobs.btnobsdoisClick(Sender: TObject);
begin
eobs.text:= eobs.text + '2';
end;

procedure Tfobs.btnobstresClick(Sender: TObject);
begin
eobs.text:= eobs.text + '3';
end;

procedure Tfobs.btnobsquatroClick(Sender: TObject);
begin
eobs.text:= eobs.text + '4';
end;

procedure Tfobs.btnobscincoClick(Sender: TObject);
begin
eobs.text:= eobs.text + '5';
end;

procedure Tfobs.btnobsseisClick(Sender: TObject);
begin
eobs.text:= eobs.text + '6';
end;

procedure Tfobs.btnobsseteClick(Sender: TObject);
begin
eobs.text:= eobs.text + '7';
end;

procedure Tfobs.btnobsoitoClick(Sender: TObject);
begin
eobs.text:= eobs.text + '8';
end;

procedure Tfobs.btnobsnoveClick(Sender: TObject);
begin
eobs.text:= eobs.text + '9';
end;

procedure Tfobs.btnobszeroClick(Sender: TObject);
begin
eobs.text:= eobs.text + '0';
end;

procedure Tfobs.btnobsQClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'Q';
end;

procedure Tfobs.btnobsWClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'W';
end;

procedure Tfobs.btnobsEClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'E';
end;

procedure Tfobs.btnobsRClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'R';
end;

procedure Tfobs.btnobsTClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'T';
end;

procedure Tfobs.btnobsYClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'Y';
end;

procedure Tfobs.btnobsUClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'U';
end;

procedure Tfobs.btnobsIClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'I';
end;

procedure Tfobs.btnobsOClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'O';
end;

procedure Tfobs.btnobsPClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'P';
end;

procedure Tfobs.btnobsAClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'A';
end;

procedure Tfobs.btnobsSClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'S';
end;

procedure Tfobs.btnobsDClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'D';
end;

procedure Tfobs.btnobsFClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'F';
end;

procedure Tfobs.btnobsGClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'G';
end;

procedure Tfobs.btnobsHClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'H';
end;

procedure Tfobs.btnobsJClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'J';
end;

procedure Tfobs.btnobsKClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'K';
end;

procedure Tfobs.btnobsLClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'L';
end;

procedure Tfobs.btnobsCEDILHAClick(Sender: TObject);
begin
eobs.text:= eobs.text + '?';
end;

procedure Tfobs.btnobsZClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'Z';
end;

procedure Tfobs.btnobsXClick(Sender: TObject);
begin
 eobs.text:= eobs.text + 'X';
end;

procedure Tfobs.btnobsCClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'C';
end;

procedure Tfobs.btnobsVClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'V';
end;

procedure Tfobs.btnobsBClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'B';
end;

procedure Tfobs.btnobsNClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'N';
end;

procedure Tfobs.btnobsMClick(Sender: TObject);
begin
eobs.text:= eobs.text + 'M';
end;

procedure Tfobs.btnobslimpaClick(Sender: TObject);
begin
eobs.text:= '';
end;

procedure Tfobs.btnobsSPACEClick(Sender: TObject);
begin
eobs.text:= eobs.text + ' ';
end;

procedure Tfobs.FormActivate(Sender: TObject);
begin
     fobs.top:=0;
     fobs.left:=0;
     fobs.width:=247;
     fobs.height:=297;
     eobs.text:='';
     eobs.setfocus;
end;

procedure Tfobs.SpeedButton1Click(Sender: TObject);
begin
  case Messagebox(Handle,'Confirma Inclus?o de Observa??o?','Autocom - Samba',mb_yesnocancel) of
    idyes:
      begin
        v_obs := eobs.text;
        fobs.Close;
      end;
    idno:
      begin
        v_obs := '';
        fobs.Close;
      end;
  end;
end;

procedure Tfobs.btnobsbackspaceClick(Sender: TObject);
begin
  eobs.text:= eobs.text + #8;
end;

end.
