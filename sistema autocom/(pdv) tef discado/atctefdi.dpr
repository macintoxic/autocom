library atctefdi;

uses
  Forms,
  tefdisc in 'tefdisc.pas' {FTEFDISC},
  msg in 'msg.pas' {Fmsg};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TFTEFDISC, FTEFDISC);
  Application.CreateForm(TFmsg, Fmsg);
  end.
