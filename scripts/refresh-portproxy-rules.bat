@echo off
title Reparar red K3S

echo ==========================================
echo REPARANDO PORTPROXY K3S
echo ==========================================
echo.

echo Detectando IP actual de WSL2...

for /f %%i in ('wsl hostname -I') do (
    set WSLIP=%%i
    goto :ipok
)

:ipok

echo IP detectada: %WSLIP%
echo.

echo Eliminando reglas antiguas...

for /L %%p in (32101,1,32120) do (
    netsh interface portproxy delete v4tov4 listenaddress=0.0.0.0 listenport=%%p >nul 2>&1
)

echo Creando nuevas reglas...

for /L %%p in (32101,1,32120) do (
    netsh interface portproxy add v4tov4 ^
    listenaddress=0.0.0.0 ^
    listenport=%%p ^
    connectaddress=%WSLIP% ^
    connectport=%%p >nul
)

echo.

echo Abriendo firewall...

powershell -Command "New-NetFirewallRule -DisplayName 'K3S_NodePorts_32101_32120' -Direction Inbound -Action Allow -Protocol TCP -LocalPort 32101-32120 -ErrorAction SilentlyContinue" >nul 2>&1

echo.
echo ==========================================
echo RED ACTUALIZADA
echo ==========================================
echo.

echo WSL2 actual: %WSLIP%
echo.

pause