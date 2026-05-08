@echo off
setlocal enabledelayedexpansion
title ASS. COELHO - WINDOWS MAINTENANCE TOOL v4.5
mode con cols=95 lines=35

 --- AUTO-ELEVAÇÃO PARA ADMINISTRADOR ---
admin_check
net session nul 2&1
if %errorLevel% neq 0 (
    echo.
    echo  [!] ERRO PRIVILEGIOS INSUFICIENTES
    echo  [!] Solicitando permissao de administrador...
    echo Set UAC = CreateObject^(Shell.Application^)  %temp%getadmin.vbs
    echo UAC.ShellExecute %~s0, , , runas, 1  %temp%getadmin.vbs
    %temp%getadmin.vbs
    del %temp%getadmin.vbs
    exit b
)

vars
set log_file=%USERPROFILE%DesktopRelatorio_Manutencao_%computername%.txt

menu
color 0B
cls
echo.
echo  +=======================================================================================+
echo  I                     ASS. COELHO - WINDOWS MAINTENANCE TOOL v4.5                       I
echo  +=======================================================================================+
echo  I                                                                                       I
echo  I   [ DIAGNOSTICO E REPARO ]                [ LIMPEZA E PERFORMANCE ]                   I
echo  I   ------------------------                -------------------------                   I
echo  I   [1] Info do Sistema (PS)                [2] Limpeza Profunda (TempUpdate)          I
echo  I   [3] Reparar Windows (SFCDISM)          [4] Otimizacao de Rede (DNSTCP)            I
echo  I   [8] Verificar Disco (Chkdsk)            [5] Fix SSD 100%% (SysMainSearch)           I
echo  I                                                                                       I
echo  I   [ SUPORTE E UTILITARIOS ]               [ SEGURANCA E RELATORIOS ]                  I
echo  I   -------------------------               --------------------------                  I
echo  I   [6] Suporte Contabil (JavaHora)        [10] Verificacao de Virus                   I
echo  I   [7] Reset Spooler  Explorer            [11] GERAR RELATORIO FINAL                  I
echo  I   [9] Programas Inicializacao             [0]  Sair do Sistema                        I
echo  I                                                                                       I
echo  +=======================================================================================+
echo  I  Status Pronto para execucao                   I           Dev Rodrigo Mateus       I
echo  +=======================================================================================+
echo.
set p opt=  Selecione uma tarefa e tecle ENTER 

if %opt%==1 goto sistema
if %opt%==2 goto limpeza
if %opt%==3 goto reparar
if %opt%==4 goto rede
if %opt%==5 goto otimizar_os
if %opt%==6 goto suporte_contabil
if %opt%==7 goto ferramentas_suporte
if %opt%==8 goto disco
if %opt%==9 goto startup
if %opt%==10 goto virus
if %opt%==11 goto gerar_log
if %opt%==0 exit
goto menu

sistema
cls
echo.
echo  [#] COLETANDO DADOS DE HARDWARE E REDE...
echo  -----------------------------------------------------------------------------------------
powershell -Command Get-ComputerInfo  Select-Object OsName, OsVersion, CsCaption  Out-String
powershell -Command Get-CimInstance Win32_Processor  Select-Object Name  Out-String
powershell -Command Get-CimInstance Win32_PhysicalMemory  Measure-Object -Property Capacity -Sum  ForEach-Object { 'RAM Total ' + [Math]Round($_.Sum  1GB, 2) + ' GB' }
powershell -Command Get-CimInstance Win32_LogicalDisk -Filter 'DriveType=3'  Select-Object DeviceID, @{Name='Livre(GB)';Expression={[Math]Round($_.FreeSpace  1GB,2)}}, @{Name='Total(GB)';Expression={[Math]Round($_.Size  1GB,2)}}  Out-String
echo  -----------------------------------------------------------------------------------------
pause
goto menu

limpeza
cls
echo.
echo  [#] INICIANDO LIMPEZA PROFUNDA DO SISTEMA...
echo.
echo  [!] Excluindo arquivos temporarios...
del s f q %temp% nul 2&1
del s f q CWindowsTemp nul 2&1
del s f q CWindowsPrefetch nul 2&1
echo  [!] Limpando cache do Windows Update...
net stop wuauserv nul 2&1
del s f q CWindowsSoftwareDistributionDownload nul 2&1
net start wuauserv nul 2&1
ipconfig flushdns nul
echo.
echo  [+] LIMPEZA CONCLUIDA COM SUCESSO!
pause
goto menu

reparar
cls
echo.
echo  [#] INICIANDO REPARO DE IMAGEM E ARQUIVOS...
echo  -----------------------------------------------------------------------------------------
sfc scannow
DISM Online Cleanup-Image RestoreHealth
echo  -----------------------------------------------------------------------------------------
pause
goto menu

rede
cls
echo.
echo  [#] OTIMIZANDO PILHA TCPIP E DNS...
netsh winsock reset nul
netsh int ip reset nul
netsh int tcp set global autotuninglevel=normal nul
netsh int tcp set global rss=enabled nul
ipconfig flushdns nul
ipconfig registerdns nul
echo.
echo  [+] REDE OTIMIZADA PARA SISTEMAS CONTABEIS E PORTAIS GOV.
pause
goto menu

otimizar_os
cls
echo.
echo  [#] APLICANDO CORRECOES PARA USO DE DISCO 100%%...
sc stop SysMain nul 2&1
sc config SysMain start=disabled nul 2&1
sc stop WSearch nul 2&1
sc config WSearch start=disabled nul 2&1
echo.
echo  [+] SERVICOS DE TELEMETRIA E INDEXACAO PESADA DESATIVADOS.
pause
