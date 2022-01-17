//******************************************************************************
//
//                 PROGRAM PDV_ORC (-)
//
//******************************************************************************
// Project:        Módulo PDV - ORCAMENTO
// File:           PDV_ORC.dpr
// Directory:      D:\projetos\pdv - novo\source\
// Function:       Main Program and Project File for PDV_ORC Executable
// Description:    ..
// Author:         Charles Alves
// Environment:    Delphi 7 Enterprise, Celeron , 128MB, Windows NT 4.0 SP5
// Compiled state: Win32 Executable: PDV_ORC.EXE
// Resources:      Win32 API
// Notes:          ..
// Revisions:
//
// 1.0.0 01/01/2001 First Version
//
//******************************************************************************

program pdv_caixa;


uses
  Forms,
  dialogs,
  windows,
  sysutils,
  uOrcamento in 'uOrcamento.pas' {frmPDV},
  udmPDV in 'udmPDV.pas' {dmORC: TDataModule},
  uRotinas in 'uRotinas.pas',
  uFechaNormal in 'uFechaNormal.pas' {frmFechaECF},
  uBuscaProduto in 'uBuscaProduto.pas' {frmConsultaProduto},
  uBuscaVendedor in 'uBuscaVendedor.pas' {frmBuscaVendedor},
  uConsultaPedido in 'uConsultaPedido.pas' {frmConsultaPedido},
  uSangria in 'uSangria.pas' {frmSangria},
  uFundoCaixa in 'uFundoCaixa.pas' {frmFundoCaixa},
  uConsultaClientes in 'uConsultaClientes.pas' {frmConsultaCliente},
  uFuncoes in 'uFuncoes.pas' {frmFuncoes},
  uQrFechamento in 'uQrFechamento.pas' {qrFechamento: TQuickRep},
  uDadosRestaurante in 'uDadosRestaurante.pas' {frmDadosRestaurante},
  uConsultaPadrao in 'uConsultaPadrao.pas' {frmConsultaPadrao},
  uPadrao in 'uPadrao.pas' {frmPadrao},
  uTransferencia in 'uTransferencia.pas' {frmTransferencia},
  uDadosCheque in 'uDadosCheque.pas' {frmDadosCheque},
  uOpcoes in 'uOpcoes.pas' {frmOpcoes},
  uDadosChequeLeitor in 'uDadosChequeLeitor.pas' {frmChequeLeitor},
  uCadCliente in 'uCadCliente.pas' {frmCadastroCliente};

{$R *.res}
begin
  log('Application.Initialize');
  Application.Initialize;
  log('Application.Initialize ok.');
  if {$ifopt d+} False {$endif}  {$ifopt d-}(UpperCase(ParamStr(1)) <> 'HANDLE') and (ParamCount <> 2) {$endif} then
  begin
       Log('>>>>Tentativa de executar o programa sem iniciar o menu.');
       Application.MessageBox('Inicie o aplicativo a partir do menu do sistema Autocom Plus',
                               TITULO_MENSAGEM,mb_ok + mb_iconerror);
       Application.Terminate;
  end
     else
     begin
          if {$ifopt d+} False {$endif}  {$ifopt d-} OpenMutex(MUTANT_ALL_ACCESS,False, TIPO_TERMINAL)  <> 0 {$endif} then
          begin
               Application.MessageBox('Este aplicativo já está em execução. Finalizando.',
                                       TITULO_MENSAGEM,mb_ok + mb_iconerror);
               Halt;
          end
          else
          begin
                // fecha em caso de operador inválido
                if strtointdef(LeINI('oper', 'codigo', 'dados\oper.ini'), 0) = 0 then
                begin
                    Application.MessageBox('Operador Inválido. Favor reiniciar o sistema', TITULO_MENSAGEM, MB_OK + MB_ICONERROR);
                    Log('Operador inválido. Finalizando a aplicação.');
                    Application.Terminate;
                end
                else
                    begin
                          log('Criando datamodule.');
                          Application.CreateForm(TdmORC, dmORC);
  log('Criando datamodule ok.');
                          log('Criando janela pdv.');
                          Application.CreateForm(TfrmPDV, frmPDV);
                          HandMutex  := CreateMutex(nil,True,TIPO_TERMINAL);
                          Log('Criando Objeto Mutex handle: ' + IntToStr(HandMutex));
                          log('Criando janela pdv ok.');
                    end
          end;
     end;
  Application.Run;
end.
//******************************************************************************
//*                          End of File PDV_ORC.dpr
//******************************************************************************
