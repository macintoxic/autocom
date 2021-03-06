{===============================================================================
| File:             uSQLGlobal.pas                                             |
| Environment:      Dlphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5    |
| Compiled state:   Dlphi Compiled Unit: uRotinas.dcu                          |
| Resources:        Win32 API                                                  |
| Version of File:  1.0                                                        |
===============================================================================}

unit uSqlGlobal;

interface

uses Controls, Windows, classes, Forms, DB, Dialogs, IBQuery, StrUtils,
  IBDatabase, IniFiles, SysUtils, Math, StdCtrls, uGlobal;

  procedure SqlGrupo(Action: TSqlAction; CodigoGrupoProduto, GrupoProduto, Impressora: string);
  function SqlGrupoDelete(CodigoGrupoProduto: String): Boolean;
  procedure SqlSubGrupo(Action: TSqlAction; CodigoSubGrupoProduto, CodigosSubGrupo, CodigoGrupo, Nome: string);
  function SqlSubGrupoDelete(CodigoSubGrupoProduto: string): Boolean;
  procedure SqlTipo(Action: TSqlAction; CodTipoProduto, CodigoTipoProduto,  Descricao: string);
  function SqlTipoDelete(CodTipoProduto: string): Boolean;
  procedure SqlSecao(Action: TSqlAction; CodSecao, CodigoSecao, Descricao, CfgCodConfig: string);
  function SqlSecaoDelete(CodSecao: string): Boolean;
  procedure SqlSituacaoTributaria(Action: TSqlAction; CodigoSituacaoTributaria,  SituacaoTributaria: string);
  function SqlSituacaoTributariaDelete(CodigoSitucaoTributaria: string): Boolean;
  procedure SqlPrateleira(Action: TSqlAction; CodSecao, CodPrateleira, CodigoPrateleira: String);
  function SqlPrateleiraDelete(CodPrateleira: string): Boolean;
  procedure SqlClassificaoFiscal(Action: TSqlAction; CodigoClassificacaoFiscal, ClassificacaoFiscal: string);
  function SqlClassificaoFiscaDelete(CodigoClassificacaoFiscal: string): Boolean;
  procedure SqlTabelaPreco(Action: TSqlAction; CodigoTabelaPreco, CodigoTabela, TabelaPreco: string);
  function SqlTabelaPrecoDelete(CodigoTabelaPreco: string): Boolean;
  procedure SqlProdutoTabelaPreco(Action: TSqlAction; CodigoProdutoTabelaPreco, CodigoProduto, Preco, CodigoTabelaPreco: String);
  function SqlProdutoTabelaPrecoDelete(CodigoProdutoTabelaPreco: string): Boolean;
  procedure SqlProdutoAssociado(CodigoProdutoAssociado, CodigoProduto: String);
  function SqlProdutoAssociadoDelete(CodigoProdutoAssociado: string): Boolean;

var
  DataBaseAutocom: TIBDatabase;
const
  ErroRelacional = 'Este registro n?o pode ser excluido porque est? relacionado com outros registros!';

implementation

uses Variants;

procedure SqlGrupo(Action: TSqlAction; CodigoGrupoProduto, GrupoProduto, Impressora: string);
begin
  case Action of
    UpdateSql:
      begin
        RunSQL('UPDATE GRUPOPRODUTO SET GRUPOPRODUTO = ' + QuotedStr(GrupoProduto) + ', CODIGOIMPRESSORA = ' + Impressora + ' WHERE CODIGOGRUPOPRODUTO = ' + CodigoGrupoProduto,DataBaseAutocom);
      end;
    InsertSql:
      begin
        RunSQL('INSERT INTO GRUPOPRODUTO (CODIGOGRUPOPRODUTO, GRUPOPRODUTO, CODIGOIMPRESSORA) VALUES (' + CodigoGrupoProduto + ', ' + QuotedStr(GrupoProduto) + ', ' + Impressora + ')',DataBaseAutocom);
      end;
  end;
end;

function SqlSubGrupoDelete(CodigoSubGrupoProduto: String): Boolean;
begin
  try
    RunSQL('DELETE FROM SUBGRUPOPRODUTO WHERE CODIGOSUBGRUPOPRODUTO = ' + CodigoSubGrupoProduto,DataBaseAutocom);
    Result := True;
  except
    Application.MessageBox(ErroRelacional, Autocom, MB_ICONWARNING);
    Result := False;
  end;
end;

procedure SqlSubGrupo(Action: TSqlAction; CodigoSubGrupoProduto, CodigosSubGrupo, CodigoGrupo, Nome: String);
begin
  case Action of
    UpdateSql:
      begin
        RunSQL('UPDATE SUBGRUPOPRODUTO SET SUBGRUPO = ' + QuotedStr(Nome) + ' WHERE CODIGOSUBGRUPOPRODUTO = ' + CodigoSubGrupoProduto,DataBaseAutocom);
      end;
    InsertSql:
      begin
        RunSQL('INSERT INTO SUBGRUPOPRODUTO (CODIGOSUBGRUPO, CODIGOGRUPOPRODUTO, SUBGRUPO) VALUES (' + CodigosSubGrupo + ', ' + CodigoGrupo + ', ' + QuotedStr(Nome) + ')',DataBaseAutocom);
      end;
  end;
end;

function SqlGrupoDelete(CodigoGrupoProduto: String): Boolean;
begin
  try
    RunSQL('DELETE FROM GRUPOPRODUTO WHERE CODIGOGRUPOPRODUTO = ' + CodigoGrupoProduto,DataBaseAutocom);
    Result := True;
  except
    Application.MessageBox(ErroRelacional, Autocom, MB_ICONWARNING);
    Result := False;
  end;
end;

procedure SqlTipo(Action: TSqlAction; CodTipoProduto, CodigoTipoProduto,  Descricao: String);
begin
  case Action of
    UpdateSql:
      begin
        RunSQL('UPDATE TIPOPRODUTO SET DESCRICAO = ' + QuotedStr(Descricao) + ' WHERE CODTIPOPRODUTO = ' + CodTipoProduto,DataBaseAutocom);
      end;
    InsertSql:
      begin
        RunSQL('INSERT INTO TIPOPRODUTO (CODIGOTIPOPRODUTO, DESCRICAO) VALUES (' + CodigoTipoProduto + ', ' + QuotedStr(Descricao) + ')',DataBaseAutocom);
      end;
  end;
end;

function SqlTipoDelete(CodTipoProduto: String): Boolean;
begin
  try
    RunSQL('DELETE FROM TIPOPRODUTO WHERE CODTIPOPRODUTO = ' + CodTipoProduto,DataBaseAutocom);
    Result := True;
  except
    Application.MessageBox(ErroRelacional, Autocom, MB_ICONWARNING);
    Result := False;
  end;
end;

  procedure SqlSecao(Action: TSqlAction; CodSecao, CodigoSecao,  Descricao, CfgCodConfig: string);
begin
  case Action of
    UpdateSql:
      begin
        RunSQL('UPDATE SECAO SET DESCRICAO = ' + QuotedStr(Descricao) + ' WHERE CODSECAO  = ' + CodSecao,DataBaseAutocom);
      end;
    InsertSql:
      begin
        RunSQL('INSERT INTO SECAO (CODIGOSECAO, DESCRICAO, CFG_CODCONFIG) VALUES (' + CodigoSecao + ', ' + QuotedStr(Descricao) + ', ' + CfgCodConfig +')',DataBaseAutocom);
      end;
  end;
end;

function SqlSecaoDelete(CodSecao: string): Boolean;
begin
  try
    RunSQL('DELETE FROM SECAO WHERE CODSECAO = ' + CodSecao,DataBaseAutocom);
    Result := True;
  except
    Application.MessageBox(ErroRelacional, Autocom, MB_ICONWARNING);
    Result := False;
  end;
end;

procedure SqlSituacaoTributaria(Action: TSqlAction; CodigoSituacaoTributaria,  SituacaoTributaria: String);
begin
  case Action of
    UpdateSql:
      begin
        RunSQL('UPDATE SITUACAOTRIBUTARIA SET SITUACAOTRIBUTARIA = ' + QuotedStr(SituacaoTributaria) + ' WHERE CODIGOSITUACAOTRIBUTARIA  = ' + CodigoSituacaoTributaria,DataBaseAutocom);
      end;
    InsertSql:
      begin
        RunSQL('INSERT INTO SITUACAOTRIBUTARIA (CODIGOSITUACAOTRIBUTARIA, SITUACAOTRIBUTARIA) VALUES (' + CodigoSituacaoTributaria + ', ' + QuotedStr(SituacaoTributaria) + ')',DataBaseAutocom);
      end;
  end;           
end;

function SqlSituacaoTributariaDelete(CodigoSitucaoTributaria: String): Boolean;
begin
  try
    RunSQL('DELETE FROM SITUACAOTRIBUTARIA WHERE CODIGOSITUACAOTRIBUTARIA  = ' + CodigoSitucaoTributaria,DataBaseAutocom);
    Result := True;
  except
    Application.MessageBox(ErroRelacional, Autocom, MB_ICONWARNING);
    Result := False;
  end;
end;

procedure SqlPrateleira(Action: TSqlAction; CodSecao, CodPrateleira, CodigoPrateleira: String);
begin
  case Action of
    InsertSql:
      begin
        RunSQL('INSERT INTO PRATELEIRA (CODIGOPRATELEIRA, CODSECAO) VALUES (' + CodigoPrateleira + ', ' + CodSecao + ')',DataBaseAutocom);
      end;
    UpdateSql:
      begin
        RunSQL('UPDATE PRATELEIRA SET CODIGOPRATELEIRA = ' + CodigoPrateleira + ' WHERE CODPRATELEIRA = ' + CodPrateleira,DataBaseAutocom);
      end;
  end;
end;

function SqlPrateleiraDelete(CodPrateleira: String): Boolean;
begin
  try
    RunSQL('DELETE FROM PRATELEIRA WHERE CODPRATELEIRA  = ' + CodPrateleira,DataBaseAutocom);
    Result := True;
  except
    Application.MessageBox(ErroRelacional, Autocom, MB_ICONWARNING);
    Result := False;
  end;
end;

procedure SqlClassificaoFiscal(Action: TSqlAction; CodigoClassificacaoFiscal, ClassificacaoFiscal: string);
begin
  case Action of
    UpdateSql:
      begin
        RunSQL('UPDATE CLASSIFICACAOFISCAL SET CLASSIFICACAOFISCAL = ' + QuotedStr(ClassificacaoFiscal) + ' WHERE CODIGOCLASSIFICACAOFISCAL  = ' + CodigoClassificacaoFiscal,DataBaseAutocom);
      end;
    InsertSql:
      begin
        RunSQL('INSERT INTO CLASSIFICACAOFISCAL (CODIGOCLASSIFICACAOFISCAL, CLASSIFICACAOFISCAL) VALUES (' + CodigoClassificacaoFiscal + ', ' + QuotedStr(ClassificacaoFiscal) + ')',DataBaseAutocom);
      end;
  end;           
end;

function SqlClassificaoFiscaDelete(CodigoClassificacaoFiscal: string): Boolean;
begin
  try
    RunSQL('DELETE FROM CLASSIFICACAOFISCAL WHERE CODIGOCLASSIFICACAOFISCAL  = ' + CodigoClassificacaoFiscal,DataBaseAutocom);
    Result := True;
  except
    Application.MessageBox(ErroRelacional, Autocom, MB_ICONWARNING);
    Result := False;
  end;
end;

procedure SqlTabelaPreco(Action: TSqlAction; CodigoTabelaPreco, CodigoTabela, TabelaPreco: string);
begin
  case Action of
    UpdateSql:
      begin
        RunSQL('UPDATE TABELAPRECO SET TABELAPRECO = ' + QuotedStr(TabelaPreco) + ' WHERE CODIGOTABELAPRECO = ' + CodigoTabelaPreco,DataBaseAutocom);
      end;
    InsertSql:
      begin
        RunSQL('INSERT INTO TABELAPRECO (CODIGOTABELA, TABELAPRECO, DATA, CFG_CODCONFIG) VALUES (' + CodigoTabela + ', ' + QuotedStr(TabelaPreco) + ', ' + QuotedStr(FormatDateTime('MM/DD/YYYY',Date)) + ', ' + IfThen(LeINI('Loja','LojaNum') <> NullAsStringValue, LeINI('Loja','LojaNum'),'1') + ')',DataBaseAutocom);
      end;
  end;
end;

function SqlTabelaPrecoDelete(CodigoTabelaPreco: string): Boolean;
begin
  try
    RunSQL('DELETE FROM TABELAPRECO WHERE CODIGOTABELAPRECO = ' + CodigoTabelaPreco,DataBaseAutocom);
    Result := True;
  except
    Application.MessageBox(ErroRelacional, Autocom, MB_ICONWARNING);
    Result := False;
  end;
end;

procedure SqlProdutoTabelaPreco(Action: TSqlAction; CodigoProdutoTabelaPreco, CodigoProduto, Preco, CodigoTabelaPreco: String);
begin
  case Action of
    UpdateSql:
      begin
        RunSQL('UPDATE PRODUTOTABELAPRECO SET CODIGOTABELAPRECO =' + CodigoTabelaPreco + ', ' + ' PRECO = ' + Preco + ' WHERE CODIGOPRODUTOTABELAPRECO = ' + CodigoProdutoTabelaPreco,DataBaseAutocom);
      end;
    InsertSql:
      begin
        RunSQL('INSERT INTO PRODUTOTABELAPRECO (CODIGOPRODUTO, CODIGOTABELAPRECO, PRECO) VALUES (' + CodigoProduto + ', ' + CodigoTabelaPreco + ', ' + Preco +  ')',DataBaseAutocom);
      end;
  end;
end;

function SqlProdutoTabelaPrecoDelete(CodigoProdutoTabelaPreco: string): Boolean;
begin
  try
    RunSQL('DELETE FROM PRODUTOTABELAPRECO WHERE CODIGOPRODUTOTABELAPRECO = ' + CodigoProdutoTabelaPreco,DataBaseAutocom);
    Result := True;
  except
    Application.MessageBox(ErroRelacional, Autocom, MB_ICONWARNING);
    Result := False;
  end;
end;

procedure SqlProdutoAssociado(CodigoProdutoAssociado, CodigoProduto: String);
begin
  RunSQL('INSERT INTO PRODUTOASSOCIADO (CODIGOPRODUTOASSOCIADO, CODIGOPRODUTO) VALUES (' + CodigoProdutoAssociado + ', ' + CodigoProduto +  ')',DataBaseAutocom);
end;

function SqlProdutoAssociadoDelete(CodigoProdutoAssociado: string): Boolean;
begin
  try
    RunSQL('DELETE FROM PRODUTOASSOCIADO WHERE CODIGOPRODUTOASSOCIADO = ' + CodigoProdutoAssociado,DataBaseAutocom);
    Result := True;
  except
    Application.MessageBox(ErroRelacional, Autocom, MB_ICONWARNING);
    Result := False;
  end;
end;


end.
