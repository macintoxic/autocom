unit snt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OnGuard, OgUtil, ExtCtrls, SUIForm, SUIImagePanel,
  SUIMemo, SUIButton, SUIMgr, inifiles, SUIThemes, SUIDlg;

type
  TFpliber = class(TForm)
    suiForm1: TsuiForm;
    suiImagePanel1: TsuiImagePanel;
    suiMemo1: TsuiMemo;
    Panel1: TPanel;
    suiButton1: TsuiButton;
    suiButton2: TsuiButton;
    suiButton3: TsuiButton;
    skin: TsuiThemeManager;
    msg: TsuiMessageDialog;
    procedure suiButton1Click(Sender: TObject);
    procedure suiButton2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    cnpj_empresa:string;
    chave_usada:string;

    function selecionachave:Tkey;
    function LeINI(strSessao, strChave, strArquivo: string): variant;
    procedure GravaINI(strSessao, strChave, strValor, strArquivo: string);
    procedure Muda_skin(componente_skin:TsuiThemeManager);
    function Mensagem(componente_msg:TsuiMessageDialog; tipo:integer; texto:string):TModalResult;
    function ValidaCnpj(xCNPJ: String):Boolean;
    function IsEditNull(Field: string; Sender: TObject): Boolean;
    function TrimAll(t: string): string;

  end;

var
  Fpliber: TFpliber;


implementation

uses BD, lib;

{$R *.dfm}

function TFpliber.selecionachave:Tkey;
const
  Key00 : TKey = ($E8,$B5,$DF,$7F,$F7,$01,$C6,$4A,$24,$08,$02,$DC,$B0,$78,$CC,$43);
  Key01 : TKey = ($13,$F3,$1C,$32,$9F,$40,$C9,$A1,$AA,$6E,$66,$30,$F4,$E4,$33,$BD);
  Key02 : TKey = ($B3,$9E,$C6,$3F,$7E,$7E,$A6,$DA,$43,$1C,$C6,$AD,$95,$F9,$AB,$23);
  Key03 : TKey = ($B3,$9E,$C6,$3F,$7E,$7E,$A6,$DA,$43,$1C,$C6,$AD,$95,$F9,$AB,$23);
  Key04 : TKey = ($D5,$61,$4D,$7B,$D9,$59,$E1,$D0,$81,$67,$24,$A4,$24,$A1,$2A,$5E);
  Key05 : TKey = ($90,$07,$B2,$D6,$10,$E0,$A7,$1B,$81,$74,$15,$12,$FE,$42,$EF,$99);
  Key06 : TKey = ($4A,$18,$4F,$AF,$F4,$25,$CE,$89,$1D,$64,$16,$12,$DF,$1A,$E5,$CD);
  Key07 : TKey = ($99,$5D,$1A,$60,$DD,$4D,$A6,$49,$B8,$2A,$19,$51,$88,$22,$FB,$0D);
  Key08 : TKey = ($1B,$8D,$5E,$42,$21,$ED,$FE,$96,$F8,$19,$4C,$17,$99,$76,$96,$EF);
  Key09 : TKey = ($B3,$F8,$F2,$45,$AD,$B8,$DA,$B9,$16,$60,$A9,$0D,$49,$08,$3C,$3C);
  Key10 : TKey = ($BD,$B4,$2A,$40,$61,$67,$1A,$40,$14,$49,$AE,$5F,$9D,$A5,$3B,$3F);
  Key11 : TKey = ($C6,$C5,$F3,$8A,$BE,$3E,$1E,$DC,$D6,$76,$9B,$6C,$2D,$44,$7D,$D7);
  Key12 : TKey = ($75,$2D,$1D,$6F,$E1,$E1,$0B,$2A,$27,$7D,$FF,$20,$60,$EA,$79,$66);
  Key13 : TKey = ($BC,$78,$DB,$E1,$F2,$0C,$A6,$BC,$00,$AE,$21,$3E,$77,$87,$7B,$CF);
  Key14 : TKey = ($8F,$B7,$6C,$B2,$57,$52,$C9,$44,$40,$83,$2E,$5E,$7F,$CC,$2E,$05);
  Key15 : TKey = ($40,$E0,$9C,$4B,$1C,$30,$FD,$F5,$C1,$38,$05,$8B,$31,$DA,$08,$16);
  Key16 : TKey = ($2D,$5B,$AE,$EF,$3A,$71,$77,$9C,$3E,$02,$25,$8F,$39,$80,$07,$78);
  Key17 : TKey = ($F5,$B7,$AA,$34,$6B,$9D,$3A,$DF,$3B,$1A,$55,$67,$79,$03,$25,$89);
  Key18 : TKey = ($DD,$ED,$1B,$4E,$67,$18,$E6,$D3,$D2,$76,$15,$45,$80,$18,$87,$4C);
  Key19 : TKey = ($6E,$94,$DE,$3D,$D0,$03,$94,$FC,$D3,$27,$24,$68,$D1,$7C,$74,$49);
  Key20 : TKey = ($EF,$BD,$F4,$64,$66,$8E,$AB,$F0,$10,$EB,$A0,$0F,$88,$AD,$FA,$DB);
  Key21 : TKey = ($90,$06,$EF,$09,$68,$49,$65,$98,$F1,$DB,$91,$AA,$29,$5D,$E3,$89);
  Key22 : TKey = ($7C,$8B,$37,$85,$5C,$24,$A3,$37,$F0,$A4,$32,$99,$32,$44,$98,$D5);
  Key23 : TKey = ($A8,$99,$DF,$1E,$44,$51,$CD,$81,$F8,$06,$27,$74,$6D,$BC,$4B,$2E);
begin
     chave_usada:=copy(formatdatetime('hh:nn:ss',time),1,2);

     if chave_usada='00' then result:=key00;
     if chave_usada='01' then result:=key01;
     if chave_usada='02' then result:=key02;
     if chave_usada='03' then result:=key03;
     if chave_usada='04' then result:=key04;
     if chave_usada='05' then result:=key05;
     if chave_usada='06' then result:=key06;
     if chave_usada='07' then result:=key07;
     if chave_usada='08' then result:=key08;
     if chave_usada='09' then result:=key09;
     if chave_usada='10' then result:=key10;
     if chave_usada='11' then result:=key11;
     if chave_usada='12' then result:=key12;
     if chave_usada='13' then result:=key13;
     if chave_usada='14' then result:=key14;
     if chave_usada='15' then result:=key15;
     if chave_usada='16' then result:=key16;
     if chave_usada='17' then result:=key17;
     if chave_usada='18' then result:=key18;
     if chave_usada='19' then result:=key19;
     if chave_usada='20' then result:=key20;
     if chave_usada='21' then result:=key21;
     if chave_usada='22' then result:=key22;
     if chave_usada='23' then result:=key23;
end;

procedure TFpliber.suiButton1Click(Sender: TObject);
begin
     IF Fpliber.Mensagem(msg, 2, 'Deseja realmente sair do utilit?rio?')=mryes then application.terminate;

end;

procedure TFpliber.suiButton2Click(Sender: TObject);
begin
     Fbd.showmodal;
end;

function TFpliber.LeINI(strSessao, strChave, strArquivo: string): variant;
begin
    with TIniFile.Create(strArquivo) do
    begin
        Result := ReadString(strSessao, strChave, '');
        Free;
    end;
end;

procedure TFpliber.GravaINI(strSessao, strChave,strValor, strArquivo: string);
begin
    with TIniFile.Create(strArquivo) do
    begin
        WriteString(strSessao, strChave, strvalor);
        Free;
    end;
end;

Procedure TFpliber.Muda_skin(componente_skin:TsuiThemeManager);
var
    tipo_skin:string;
begin
     tipo_skin:=LeINI('ATCPLUS', 'skin', extractfilepath(application.exename)+'dados\autocom.ini');
     if (tipo_skin='0') or (tipo_skin='') then skin.uistyle:=WinXP;
     if (tipo_skin='1') then componente_skin.uistyle:=BlueGlass;
     if (tipo_skin='2') then componente_skin.uistyle:=DeepBlue;
     if (tipo_skin='3') then componente_skin.uistyle:=MacOS;
     if (tipo_skin='4') then componente_skin.uistyle:=Protein;
end;

function TFpliber.Mensagem(componente_msg:TsuiMessageDialog; tipo:integer; texto:string):TModalResult;
begin
     if tipo=1 then // informacao
        begin
           componente_msg.Button1caption:='OK';
           componente_msg.Button1ModalResult:=mrOK;
           componente_msg.ButtonCount:=1;
           componente_msg.Icontype:=suiInformation;
        end;
     if tipo=2 then // pergunta
        begin
           componente_msg.Button1caption:='SIM';
           componente_msg.Button1ModalResult:=mrYES;
           componente_msg.Button2caption:='N?O';
           componente_msg.Button2ModalResult:=mrNO;
           componente_msg.ButtonCount:=2;
           componente_msg.Icontype:=suiHelp;
        end;
     componente_msg.text:=texto;
     componente_msg.uistyle:=skin.uistyle;
     result:=componente_msg.ShowModal;
end;

procedure TFpliber.FormActivate(Sender: TObject);
begin
     Fpliber.Muda_skin(skin);
     application.processmessages;
     suiButton2.setfocus;
     if (ParamCount = 2) and (ParamStr(1) = 'handle') then
        begin
           Flibera.showmodal;
        end;
end;


function TFpliber.ValidaCnpj(xCNPJ: String):Boolean;
var
  d1,d4,xx,nCount,fator,resto,digito1,digito2 : Integer;
  Check : String;
begin
  d1 := 0;
  d4 := 0;
  xx := 1;
  for nCount := 1 to Length( xCNPJ )-2 do
    begin
      if Pos( Copy( xCNPJ, nCount, 1 ), '/-.' ) = 0 then
      begin
        if xx < 5 then
        begin
          fator := 6 - xx;
        end
      else
        begin
          fator := 14 - xx;
        end;
   d1 := d1 + StrToInt( Copy( xCNPJ, nCount, 1 ) ) * fator;
   if xx < 6 then
    begin
    fator := 7 - xx;
   end
   else
   begin
   fator := 15 - xx;    end;
   d4 := d4 + StrToInt( Copy( xCNPJ, nCount, 1 ) ) * fator;
   xx := xx+1;
   end;
   end;
   resto := (d1 mod 11);
   if resto < 2 then
   begin
   digito1 := 0;
   end
   else
   begin
   digito1 := 11 - resto;
   end;
   d4 := d4 + 2 * digito1;
   resto := (d4 mod 11);
   if resto < 2 then
    begin
    digito2 := 0;
   end
   else
    begin
    digito2 := 11 - resto;
   end;
    Check := IntToStr(Digito1) + IntToStr(Digito2);
   if Check <> copy(xCNPJ,succ(length(xCNPJ)-2),2) then
    begin
    Result := False;
   end
   else
    begin
    Result := True;
   end;
 end;

function TFpliber.IsEditNull(Field: string; Sender: TObject): Boolean;
begin
  if trimall((Sender as TCustomEdit).Text)='' then
    begin
      Fpliber.Mensagem(msg, 1, 'O campo ' + Field + '  n?o pode ficar vazio, Verifique!');
      (Sender as TCustomEdit).SetFocus;
      Result := True;
    end
  else
    Result := False;
  if Result = True then Abort;
end;

function TFpliber.TrimAll(t: string): string;
{-------------------------------------------------------------------------------
|  Procedure:   IsNull                                                         |
|  Autor:       Andr? Faria                                                    |
|  Data:        04-abr-2003                                                    |
|  Apaga ' ' do inicio e do fim da String;                                     |
-------------------------------------------------------------------------------}
begin
  while pos(' ',t)>0 do delete(t,pos(' ',t),1);
  while pos('',t)>0 do delete(t,pos('',t),1);
  result:=t;
end;


end.
