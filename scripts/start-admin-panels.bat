@echo off
setlocal

title PANEL DE CONTROL - ENTORNO DOCENTE
mode con: cols=90 lines=30
color 0B

echo =============================================================================
echo           SISTEMA DE GESTION DE CLUSTER KUBERNETES - V3.0
echo =============================================================================
echo.

echo [0/6] Iniciando entorno WSL2...
wsl echo WSL iniciado correctamente >nul

timeout /t 8 /nobreak >nul

echo.
echo [1/6] Cerrando tuneles antiguos...
wsl pkill -f "kubectl proxy" >nul 2>&1
wsl pkill -f "port-forward" >nul 2>&1

echo [OK] Procesos antiguos eliminados.
echo.

echo [2/6] Verificando estado de K3s...
wsl sudo systemctl is-active k3s >nul

if errorlevel 1 (
    echo [WARN] K3s detenido. Reiniciando servicio...
    wsl sudo systemctl restart k3s
    timeout /t 12 /nobreak >nul
)

echo [OK] Cluster Kubernetes operativo.
echo.

echo [3/6] Esperando estabilizacion de red y pods...
timeout /t 10 /nobreak >nul

echo.
echo [4/6] Iniciando Kubernetes Dashboard Proxy...

start "K8S_PROXY" /min cmd /k "wsl sudo kubectl proxy --address=0.0.0.0 --accept-hosts='.*'"

timeout /t 5 /nobreak >nul

echo [OK] Proxy Kubernetes iniciado.
echo.

echo [5/6] Iniciando Portainer...

start "PORTAINER" /min cmd /k "wsl sudo kubectl port-forward -n portainer svc/portainer 9443:9443"

timeout /t 8 /nobreak >nul

echo [OK] Tunel Portainer iniciado.
echo.

echo [6/6] Abriendo paneles de administracion...
timeout /t 3 /nobreak >nul

start https://localhost:9443

start http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/login

echo.
echo =============================================================================
echo  SISTEMA OPERATIVO
echo =============================================================================
echo.
echo  PORTAINER:
echo  https://localhost:9443
echo.
echo  KUBERNETES DASHBOARD:
echo  http://localhost:8001
echo.
echo =============================================================================
echo.
echo IMPORTANTE:
echo - Mantenga esta ventana abierta durante toda la sesion.
echo - No cierre las ventanas minimizadas K8S_PROXY o PORTAINER.
echo - No ejecute multiples veces el script simultaneamente.
echo =============================================================================
echo.

pause