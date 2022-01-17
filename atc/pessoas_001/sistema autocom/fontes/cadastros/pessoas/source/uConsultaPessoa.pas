unit uConsultaPessoa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, uGlobal;

type
  TfConsultaPessoa = class(TForm)
    PanPesquisa: TPanel;
    BtnPesquisar: TSpeedButton;
    EdPesquisar: TEdit;
    GrdPessoa: TDBGrid;
    BtnSelectAll: TSpeedButton;
    DSourcePessoa: TDataSource;
    procedure BtnSelectAllClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure EdPesquisarKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrdPessoaKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnPesquisarClick(Sender: TObject);
    procedure GrdPessoaDblClick(Sender: TObject);
  private
    DsPessoa: TDataSet;
    procedure Seleciona;
  public
    ResultCodigo, ResultNome: String;
  end;

var
  fConsultaPessoa: TfConsultaPessoa;

implementation

uses uDm, uMain, uCadastro;

{$R *.dfm}

procedure TfConsultaPessoa.BtnSelectAllClick(Sender: TObject);
begin
  RunSql('Select PES_CODPESSOA, PES_NOME_A from Pessoa ORDER BY PES_NOME_A',dm.dbautocom,DsPessoa);
  DSourcePessoa.DataSet := DsPessoa;  
end;

procedure TfConsultaPessoa.FormShow(Sender: TObject);
begin
  BtnSelectAll.Click;
  DSourcePessoa.DataSet := DsPessoa;
end;

procedure TfConsultaPessoa.Seleciona;
begin
  ResultCodigo := DsPessoa.FieldByName('PES_CODPESSOA').AsString;
  ResultNome := DsPessoa.FieldByName('PES_NOME_A').AsString;
  Close;
end;

procedure TfConsultaPessoa.EdPesquisarKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Case key of
    VK_F12: BtnPesquisar.Click;
    VK_RETURN:
      begin
        BtnPesquisar.Click;
        EdPesquisar.SelectAll;
      end;
  end;
end;

procedure TfConsultaPessoa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case key of
    VK_F5: BtnSelectAll.Click;
    VK_ESCAPE: Close;
  end;
end;

procedure TfConsultaPessoa.GrdPessoaKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case key of
    VK_RETURN: Seleciona;
  end;
end;

procedure TfConsultaPessoa.BtnPesquisarClick(Sender: TObject);
begin
  if IsFloat(EdPesquisar.Text) then
    RunSql('Select PES_CODPESSOA, PES_NOME_A from Pessoa where PES_CODPESSOA = ' + EdPesquisar.Text + ' ORDER BY PES_CODPESSOA',dm.dbautocom,DsPessoa)
  else
    RunSql('Select PES_CODPESSOA, PES_NOME_A from Pessoa where PES_NOME_A LIKE ' + QuotedStr('%'+EdPesquisar.Text+'%') + ' ORDER BY PES_NOME_A',dm.dbautocom,DsPessoa);
  DSourcePessoa.DataSet := DsPessoa;    
end;

procedure TfConsultaPessoa.GrdPessoaDblClick(Sender: TObject);
begin
  Seleciona;
end;

end.
