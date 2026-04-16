@echo off
title ASS. COELHO - Maintenance Tool v2.0
color 0A

:: Verificacao de Administrador (Trava de Seguranca)
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ==================================================
    echo ERRO: ACESSO NEGADO!
    echo ==================================================
    echo Por favor, clique com o botao direito no arquivo 
    echo e selecione "Executar como Administrador".
    echo.
    pause
    exit
)

:matrix
cls
echo.
echo 01001010 01010011 01010100 01001001 01001110
echo Inicializando modulo de manutencao...
timeout /t 1 >nul
cls
echo Carregando componentes...
timeout /t 1 >nul
cls
goto menu

:menu
cls
echo ==================================================
echo    ASS. COELHO - WINDOWS MAINTENANCE TOOL
echo ==================================================
echo.
echo 1 - Informacoes do Sistema
echo 2 - Limpeza Profunda
echo 3 - Reparar Windows
echo 4 - Otimizacao de Rede
echo 5 - Verificar Disco
echo 6 - Programas na Inicializacao
echo 7 - Verificacao Basica de Virus
echo 8 - Sair
echo.

choice /c 12345678 /n /m "Selecione uma opcao: "

if errorlevel 8 exit
if errorlevel 7 goto virus
if errorlevel 6 goto startup
if errorlevel 5 goto disco
if errorlevel 4 goto rede
if errorlevel 3 goto reparar
if errorlevel 2 goto limpeza
if errorlevel 1 goto sistema
goto menu

:sistema
cls
echo =====================================
echo INFORMACOES DO SISTEMA
echo =====================================
echo.

systeminfo | findstr /B /C:"Nome do host" /C:"OS Name" /C:"OS Version"
echo.
wmic cpu get name
echo.
wmic memorychip get capacity
echo.
wmic logicaldisk get caption,freespace,size

echo.
pause
goto menu

:barra
echo.
echo [##########..............................]
timeout /t 1 >nul
cls
echo [####################....................]
timeout /t 1 >nul
cls
echo [##############################..........]
timeout /t 1 >nul
cls
echo [########################################]
echo.
exit /b

:limpeza
cls
echo LIMPEZA PROFUNDA
call :barra

del /s /f /q "%temp%\*" >nul 2>&1
del /s /f /q C:\Windows\Temp\* >nul 2>&1
del /s /f /q "%LocalAppData%\Microsoft\Windows\Explorer\thumbcache*" >nul 2>&1

forfiles /p "C:\Windows\Logs" /s /m *.log /d -7 /c "cmd /c del @path" >nul 2>&1

net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
del /s /f /q C:\Windows\SoftwareDistribution\Download\* >nul 2>&1
net start wuauserv >nul 2>&1
net start bits >nul 2>&1

ipconfig /flushdns >nul

rd /s /q C:\$Recycle.Bin >nul 2>&1

echo Limpeza concluida
pause
goto menu

:reparar
cls
echo REPARANDO WINDOWS
echo.
echo ATENCAO: Este processo pode demorar ate 30 minutos.
echo O Windows exibira a porcentagem real do processo abaixo.
echo Nao feche esta janela, o computador pode parecer travado.
echo.

sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth

echo.
pause
goto menu

:rede
cls
echo OTIMIZACAO DE REDE
echo.
echo Testando comunicacao com o servidor do Governo...
ping certificado.sso.acesso.gov.br -n 4
echo.
echo Se houver "Esgotado o tempo limite", o site pode estar fora do ar.
echo Pressione qualquer tecla para continuar com o reset da placa de rede...
pause >nul

call :barra

ipconfig /flushdns
netsh winsock reset
netsh int ip reset

echo.
echo Otimizacao concluida. Reinicie o computador.
pause
goto menu

:disco
cls
echo VERIFICANDO DISCO
echo.
echo O Windows exibira o progresso da verificacao abaixo.
echo.

chkdsk C: /scan

echo.
pause
goto menu

:startup
cls
echo =====================================
echo PROGRAMAS NA INICIALIZACAO
echo =====================================
echo.

wmic startup get caption,command

echo.
echo Programas acima iniciam com o Windows.
pause
goto menu

:virus
cls
echo =====================================
echo VERIFICACAO BASICA DE VIRUS
echo =====================================
echo.

echo Iniciando verificacao rapida...

"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 1

echo.
echo Verificacao finalizada.
pause
goto menu
