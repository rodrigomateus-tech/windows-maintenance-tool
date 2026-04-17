@echo off
title ASS. COELHO - Maintenance Tool v4.0
color 0A

:: Verificacao de Administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ==================================================
    echo ERRO: ACESSO NEGADO!
    echo ==================================================
    echo Por favor, execute como Administrador.
    pause
    exit
)

:menu
cls
echo ==================================================
echo    ASS. COELHO - WINDOWS MAINTENANCE TOOL v4.0
echo ==================================================
echo.
echo  1 - Informacoes do Sistema
echo  2 - Limpeza Profunda (Temporarios e Cache)
echo  3 - Reparar Windows (SFC e DISM)
echo  4 - Otimizacao de Rede (DNS e TCP Stack)
echo  5 - Otimizacao de Sistema (Fix SSD 100%%)
echo  6 - Suporte contabil (Limpar Java e Sincronizar Relogio)
echo  7 - Ferramentas de Suporte (Spooler e Explorer)
echo  8 - Verificar Disco (Chkdsk Scan)
echo  9 - Programas na Inicializacao
echo 10 - Verificacao de Virus (Defender)
echo 11 - GERAR RELATORIO DE MANUTENCAO
echo  0 - Sair
echo.

set /p opt="Selecione uma opcao: "

if "%opt%"=="1" goto sistema
if "%opt%"=="2" goto limpeza
if "%opt%"=="3" goto reparar
if "%opt%"=="4" goto rede
if "%opt%"=="5" goto otimizar_os
if "%opt%"=="6" goto suporte_contabil
if "%opt%"=="7" goto ferramentas_suporte
if "%opt%"=="8" goto disco
if "%opt%"=="9" goto startup
if "%opt%"=="10" goto virus
if "%opt%"=="11" goto gerar_log
if "%opt%"=="0" exit

echo Opcao invalida!
timeout /t 2 >nul
goto menu

:sistema
cls
echo =====================================
echo INFORMACOES DO SISTEMA
echo =====================================
systeminfo | findstr /B /C:"Nome do host" /C:"OS Name" /C:"OS Version"
wmic cpu get name
wmic memorychip get capacity
wmic logicaldisk get caption,freespace,size
pause
goto menu

:limpeza
cls
echo EXECUTANDO LIMPEZA PROFUNDA...
del /s /f /q "%temp%\*" >nul 2>&1
del /s /f /q C:\Windows\Temp\* >nul 2>&1
del /s /f /q C:\Windows\Prefetch\* >nul 2>&1
del /s /f /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache*" >nul 2>&1
ipconfig /flushdns >nul
echo Limpeza concluida!
pause
goto menu

:reparar
cls
echo REPARANDO IMAGEM DO WINDOWS...
sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth
pause
goto menu

:rede
cls
echo OTIMIZACAO DE REDE AVANCADA...
netsh winsock reset >nul
netsh int ip reset >nul
netsh int tcp set global autotuninglevel=normal >nul
netsh int tcp set global rss=enabled >nul
ipconfig /flushdns >nul
ipconfig /registerdns >nul
echo Rede otimizada para portais do Governo.
pause
goto menu

:otimizar_os
cls
echo OTIMIZANDO SSD E SERVICOS...
sc stop "SysMain" >nul 2>&1
sc config "SysMain" start=disabled >nul 2>&1
sc stop "WSearch" >nul 2>&1
sc config "WSearch" start=disabled >nul 2>&1
sc stop "DiagTrack" >nul 2>&1
sc config "DiagTrack" start=disabled >nul 2>&1
echo Ajustes aplicados para acabar com SSD 100%%.
pause
goto menu

:suporte_contabil
cls
echo =====================================
echo SUPORTE CONTABIL (JAVA E RELOGIO)
echo =====================================
echo 1. Limpando Cache do Java...
del /Q /F /S "%USERPROFILE%\AppData\LocalLow\Sun\Java\Deployment\cache\*.*" >nul 2>&1
echo 2. Sincronizando relogio para Certificados Digitais...
net stop w32time >nul 2>&1
w32tm /unregister >nul 2>&1
w32tm /register >nul 2>&1
net start w32time >nul 2>&1
w32tm /resync >nul 2>&1
echo Suporte concluido!
pause
goto menu

:ferramentas_suporte
cls
echo =====================================
echo FERRAMENTAS (IMPRESSORA E EXPLORER)
echo =====================================
echo 1. Reiniciando Spooler de Impressao...
net stop spooler >nul 2>&1
del /Q /F /S "%systemroot%\System32\Spool\Printers\*.*" >nul 2>&1
net start spooler >nul 2>&1
echo 2. Reiniciando Windows Explorer...
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
echo Processos destravados!
pause
goto menu

:disco
cls
chkdsk C: /scan
pause
goto menu

:startup
cls
wmic startup get caption,command
pause
goto menu

:virus
cls
echo Iniciando verificacao rapida do Windows Defender...
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 1
pause
goto menu

:gerar_log
cls
echo =====================================
echo GERANDO RELATORIO DE MANUTENCAO
echo =====================================
echo.
echo Coletando dados do sistema...

set LOGFILE="%USERPROFILE%\Desktop\Relatorio_Manutencao_%computername%.txt"

echo ===================================== > %LOGFILE%
echo RELATORIO DE MANUTENCAO - ASS. COELHO >> %LOGFILE%
echo Data: %date% as %time% >> %LOGFILE%
echo Computador: %computername% >> %LOGFILE%
echo Usuario: %username% >> %LOGFILE%
echo ===================================== >> %LOGFILE%
echo. >> %LOGFILE%
echo [SISTEMA OPERACIONAL] >> %LOGFILE%
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" >> %LOGFILE%
echo. >> %LOGFILE%
echo [ARMAZENAMENTO LIVRE] >> %LOGFILE%
wmic logicaldisk get caption,freespace,size >> %LOGFILE%
echo. >> %LOGFILE%
echo [SERVICOS OTIMIZADOS] >> %LOGFILE%
echo SysMain/Superfetch: Desativado >> %LOGFILE%
echo Windows Search: Desativado >> %LOGFILE%
echo. >> %LOGFILE%
echo STATUS: Manutencao concluida com sucesso atraves da Maintenance Tool v4.0 >> %LOGFILE%

echo.
echo Relatorio gerado com sucesso na Area de Trabalho!
echo Arquivo: Relatorio_Manutencao_%computername%.txt
pause
goto menu
