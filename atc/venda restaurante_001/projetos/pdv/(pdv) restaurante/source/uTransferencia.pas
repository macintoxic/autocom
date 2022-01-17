unit uTransferencia;

interface

uses
    Windows, Messages, SysUtils, Classes, Forms,
    uPadrao, StdCtrls, ExtCtrls, Buttons, DB, Controls;

type
    TfrmTransferencia = class(TfrmPadrao)
        Panel1: TPanel;
        Label1: TLabel;
        edOrigem: TEdit;
        Label2: TLabel;
        edDestino: TEdit;
        BitBtn1: TBitBtn;
        BitBtn2: TBitBtn;
        procedure FormCreate(Sender: TObject);
        procedure BitBtn1Click(Sender: TObject);
        procedure BitBtn2Click(Sender: TObject);
    private
        { Private declarations }
    public
        { Public declarations }
    end;

var
    frmTransferencia: TfrmTransferencia;

implementation
uses udmPDV, uRotinas;
{$R *.dfm}

procedure TfrmTransferencia.FormCreate(Sender: TObject);
begin
    inherited;
    edOrigem.OnKeyPress := numerosdecimais;
    edDestino.OnKeyPress := numerosdecimais;
end;

procedure TfrmTransferencia.BitBtn1Click(Sender: TObject);
var
    auxDataset: TDataSet;
    strAux: string;
    // armazena o código do pedido para atualiza os itens transferidos.
begin
    if
        Application.MessageBox(PChar(Format('Confirma a transferência da mesa %3s para a mesa %3s ?', [edOrigem.Text, edDestino.Text])),
        TITULO_MENSAGEM, MB_YESNO + MB_ICONQUESTION) = IDYes then
    begin
        dmORC.RunSQL('SELECT CODIGOPEDIDOVENDA FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' +
            QuotedStr(edOrigem.Text), auxDataset);
        strAux := auxDataset.Fields[0].AsString;

        if auxDataset.IsEmpty then
        begin
            FreeAndNil(auxDataset);
            Application.MessageBox('Mesa de origem inexistente.',
                TITULO_MENSAGEM,
                MB_OK + MB_ICONERROR);
        end
        else
        begin
            FreeAndNil(auxDataset);
            dmORC.RunSQL('SELECT CODIGOPEDIDOVENDA FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' +
                QuotedStr(edDestino.Text), auxDataset);

            if auxDataset.IsEmpty then
                //caso a mesa de destino não exista...
                dmORC.RunSQL('UPDATE PEDIDOVENDA SET ' +
                    'NUMEROPEDIDO = ' + QuotedStr(edDestino.Text) +
                    ' WHERE NUMEROPEDIDO = ' + QuotedStr(edOrigem.Text))
            else
            begin
                //se existir será necessário passar os itens de um pedido para o outro.
                dmORC.RunSQL('UPDATE PRODUTOPEDIDOVENDA SET ' +
                    'CODIGOPEDIDOVENDA = ' + auxDataset.Fields[0].AsString +
                    ' WHERE CODIGOPEDIDOVENDA =' + QuotedStr(strAux));
                dmORC.RunSQL('DELETE FROM PEDIDOVENDA WHERE NUMEROPEDIDO = ' +
                    QuotedStr(edOrigem.Text));

            end;

            FreeAndNil(auxDataset);
            Close;
        end;
    end;
end;

procedure TfrmTransferencia.BitBtn2Click(Sender: TObject);
begin
    Close;
end;

end.
