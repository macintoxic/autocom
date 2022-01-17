unit msg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons;

type
  TFmsg = class(TForm)
    Memo1: TMemo;
    Timer1: TTimer;
    BitBtn1: TBitBtn;
    procedure Timer1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Fmsg: TFmsg;
  conta:integer;

implementation

uses tefdisc;

{$R *.dfm}

procedure TFmsg.Timer1Timer(Sender: TObject);
begin
     application.processmessages;
     setforegroundwindow(application.handle);
     application.processmessages;
     timer1.enabled:=false;
     if conta>7 then
        begin
           Fmsg.close;
        end
     else
        begin
           application.processmessages;
           setforegroundwindow(application.handle);
           conta:=conta+1;
           application.processmessages;
           setforegroundwindow(application.handle);
        end;
     application.processmessages;
     timer1.enabled:=true;
     setforegroundwindow(application.handle);
end;

procedure TFmsg.FormActivate(Sender: TObject);
begin
     memo1.clear;
     memo1.lines.add(FTEFDISC.Msg_oper);
     conta:=0;
//     if fileexists(extractfilepath(application.exename)+'dados\comprovante.tef') then timer1.enabled:=true else bitbtn1.visible:=true;
     bitbtn1.visible:=true;
end;

procedure TFmsg.BitBtn1Click(Sender: TObject);
begin
     Fmsg.close;
end;

end.
