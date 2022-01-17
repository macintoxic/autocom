unit uCadCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Mask, StdCtrls, ExtCtrls, Buttons, db, StrUtils, uPadrao;

type
  TfrmCadastroCliente = class(TfrmPadrao)
    GBCliente: TPanel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    mskBairro: TEdit;
    mskMunicipio: TEdit;
    mskUF: TComboBox;
    mskNome: TMaskEdit;
    mskFone: TMaskEdit;
    mskEndereco: TEdit;
    Panel1: TPanel;
    spdGravar: TSpeedButton;
    spdCancela: TSpeedButton;
    mskCodigo: TMaskEdit;
    Label1: TLabel;
    procedure spdGravarClick(Sender: TObject);
    procedure spdCancelaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mskUFEnter(Sender: TObject);
    procedure mskUFExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCadastroCliente: TfrmCadastroCliente;

implementation
uses uRotinas, Math, udmPDV;
{$R *.dfm}

procedure TfrmCadastroCliente.spdGravarClick(Sender: TObject);
var
   i,j :Integer;
   auxdataset:TDataSet;

begin
     for i := 0 to GBCliente.ControlCount -1 do
     begin
          if (not (GBCliente.Controls[i] is TLabel))
             and (not (GBCliente.Controls[i] is TComboBox)) then
               if trim((GBCliente.Controls[i] as TCustomEdit).Text) = '' then
               begin
                    (GBCliente.Controls[i] as TCustomEdit).setfocus;
                    Application.MessageBox(pchar('O campo ' + Copy((GBCliente.Controls[i] as TCustomEdit).Name, 4, 20) + ' não pode ser vazio'),
                                                    TITULO_MENSAGEM, MB_OK + MB_ICONERROR );
                    Exit;
               end;
     end;

    auxdataset := dmORc.ConsultaCliente(mskCodigo.text);
    if auxdataset.IsEmpty then
    begin
         dmORC.RunSQL( 'INSERT INTO PESSOA '+
                       '(TPE_CODTIPOPESSOA, PES_NOME_A, TELEFONE1) ' +
                       'VALUES (' +
                       QuotedStr('1') + ',' +
                       QuotedStr(mskNome.Text) + ',' +
                       QuotedStr(mskFone.Text) + ')'
                     );
         FreeAndNil(auxdataset);

         Log('INSERINDO DADOS DA PESSOA.');
         DMORC.Commit;
         dmORC.RunSQL('SELECT * FROM PESSOA WHERE PES_NOME_A = '  + QuotedStr(mskNome.TEXT) + 'AND TELEFONE1 = ' + QuotedStr(mskFone.Text), auxdataset);
         DMORC.Commit;
         j := auxdataset.FieldByName('PES_CODPESSOA').AsInteger;
         Log('INSERINDO ENDERECO DO CLIENTE.');
         DMORC.RunSQL( 'INSERT INTO ENDERECOPESSOA ' +
                       '(PES_CODPESSOA, TEN_CODTIPOENDERECO, ENP_ENDERECO_A, '+
                       'ENP_BAIRRO_A, ENP_CIDADE_A, ENP_ESTADO_A, ENP_TELEFONE_A, ENP_CODENDERECOPESSOA) ' +
                       'VALUES' +
                       '( ' + IntToStr(j) +', '+
                             LEINI(TIPO_TERMINAL,'TIPOENDERECOENTREGA') +', '+
                             QuotedStr(mskEndereco.Text) + ', ' +
                             QuotedStr(mskBairro.Text) +', '+
                             QuotedStr(mskMunicipio.Text) + ', '+
                             QuotedStr(mskUF.Text) + ', '+
                             QuotedStr(mskfone.Text) + ', gen_id(SEQ_EnderecoPessoa,1) )');
         DMORC.Commit;

         FreeAndNil(auxdataset);

         Log('INSERINDO DADOS DO CLIENTE.');
         DMORC.RunSQL( ' INSERT INTO CLIENTE '+
                         '( CODIGOCLIENTE, PES_CODPESSOA, CFG_CODCONFIG)' +
                         'VALUES (' +
                         mskCodigo.text + ', '+
                         IntToStr(j) +', '+
                         '1)');
    end
       else
           begin
                //atualiza os dados do cliente.
                LOG('ATUALIZANDO OS DADOS DO CLIENTE. ');
                dmorc.RunSQL( 'UPDATE ENDERECOPESSOA SET ' +
                              'ENP_ENDERECO_A = ' + QuotedStr(mskEndereco.Text) + ', ' +
                              'ENP_BAIRRO_A   = ' + QuotedStr(mskBairro.Text) +', '+
                              'ENP_CIDADE_A   = ' + QuotedStr(mskMunicipio.Text) + ', '+
                              'ENP_ESTADO_A   = ' + QuotedStr(mskUF.Text) + ', '+
                              'ENP_TELEFONE_A = ' + QuotedStr(mskfone.Text) +
                              ' WHERE PES_CODPESSOA = ' + auxdataset.FieldByName('pes_codpessoa').AsString
                              );
                Log('ATUALIZANDO PESSOA.');
                dmorc.RunSQL( 'UPDATE PESSOA SET ' +
                              'PES_NOME_A = ' + QuotedStr(mskNome.Text) + ', ' +
                              'PES_APELIDO_A = ' + QuotedStr(mskNome.Text) +
                              'WHERE PES_CODPESSOA = ' + auxdataset.FieldByName('pes_codpessoa').AsString);
           end;
    DMORC.Commit;
    FreeAndNil(auxdataset);
    Tag := 0;

    Close;
end;

procedure TfrmCadastroCliente.spdCancelaClick(Sender: TObject);
begin
     Tag := 1;
     Close;
end;

procedure TfrmCadastroCliente.FormCreate(Sender: TObject);
var
   auxdataset:TDataSet;
begin
     mskCodigo.Enabled  := Boolean(IfThen(LeINI(TIPO_TERMINAL,'contadorcliente') = 0, 0,1));
     if not mskCodigo.Enabled then
     begin
          dmorc.RunSQL('select (max(codigoliente) + 1) valor from cliente',auxdataset);
          mskcodigo.Text := auxdataset.FieldByName('valor').AsString;
          freeandnil(auxdataset);
     end;
end;

procedure TfrmCadastroCliente.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
     if key = Vk_f3 then
        spdGravar.Click
        else
     if key = Vk_f6 then
        spdGravar.Click
        else
        inherited;
end;

procedure TfrmCadastroCliente.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
     ModalResult := IfThen(Tag = 0, mrOk,mrcancel); 
end;

procedure TfrmCadastroCliente.mskUFEnter(Sender: TObject);
begin
     KeyPreview :=  False;
end;

procedure TfrmCadastroCliente.mskUFExit(Sender: TObject);
begin
     KeyPreview :=  true;
end;

end.
