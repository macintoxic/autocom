unit uWait;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfWait = class(TForm)
    PanWait: TPanel;
    LblWait: TLabel;
  private
  public
  end;

var
  fWait: TfWait;

implementation

{$R *.dfm}

end.
