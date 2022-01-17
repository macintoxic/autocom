unit uDadosChequeLeitor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uPadrao, StdCtrls, Mask, Buttons, ExtCtrls;

type
  TfrmChequeLeitor = class(TfrmPadrao)
    Panel2: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    lblPre: TLabel;
    BitBtn1: TBitBtn;
    mskDadosCheque: TMaskEdit;
    mskDataCheque: TMaskEdit;
    procedure mskDadosChequeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    banco,
    cheque,
    agencia,
    conta:integer;
    strTotalPedido:String;
  end;

var
  frmChequeLeitor: TfrmChequeLeitor;

implementation

uses Math, uRotinas, uDadosCheque;

{$R *.dfm}

procedure TfrmChequeLeitor.mskDadosChequeKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  if key = VK_RETURN then
  begin
       if Length(mskDadosCheque.Text) < 34 then
       begin
            if Application.MessageBox('Erro de Leitura. '#13'Deseja digitar os dados manualmente?',TITULO_MENSAGEM,MB_YESNO + MB_ICONQUESTION) = IDYES then
            begin
                  frmdadoscheque := tfrmdadoscheque.Create(self);
                  frmDadosCheque.strTotalPedido := strTotalPedido;
                  frmDadosCheque.lblPre.Visible := lblPre.Visible;
                  frmDadosCheque.mskDataCheque.Visible := lblPre.Visible;
                  frmDadosCheque.mskDataCheque.Text := mskDataCheque.Text;
                  frmDadosCheque.ShowModal;
                  freeandnil(frmDadosCheque);
                  Self.Visible := False;
                  Close;
            end
               else
                   mskDadosCheque.Clear;
       end
          else
         begin
              banco := StrToIntDef(Copy(mskDadosCheque.Text,2,3),0);
              cheque := StrToIntDef(Copy(mskDadosCheque.Text,14,6),0);
              agencia := StrToIntDef(Copy(mskDadosCheque.Text,5,4),0);
              conta := StrToIntDef(Copy(mskDadosCheque.Text,24,9),0);
          end;
  end;
end;

procedure TfrmChequeLeitor.BitBtn1Click(Sender: TObject);
var
   Cheque:FCheque;
   hand:THandle;
   strAux:string;
begin
      strAux := ExtractFilePath(Application.ExeName) + LeINI('modulos','dll_ECF');
      hand := LoadLibrary(PChar(straux));
      @Cheque := GetProcAddress(hand,'Cheque');
      straux := Cheque( StrToInt(leini('terminal','ModECF')),
                        StrToInt(leini('terminal','comECF')),
                        formatfloat('000',banco),
                        strTotalPedido,
                        mskDataCheque.Text,
                        LeINI('terminal', 'favorecido'),
                        leini('terminal', 'municipio'),
                        CurrencyString,
                        LeINI('terminal', 'Moedasing'),
                        LeINI('terminal', 'Moedaplur'));

     if straux[1] = '#' then
        Application.MessageBox( Pchar('Ocorreu um erro durante o envio do comando para a impressora'#13 +
                                'Erro: ' + Copy(strAux,2,Length(straux))), TITULO_MENSAGEM, MB_ICONERROR + MB_OK);

      FreeLibrary(hand);
      Close;
end;

end.
