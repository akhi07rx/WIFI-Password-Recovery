@echo off
setlocal enabledelayedexpansion

for /f "tokens=2 delims=:" %%a in ('netsh wlan show profile ^| findstr ":"') do (
    set "ssid=%%~a"
    call :getpwd "%%ssid:~1%%"
)

echo.
echo Press any key to exit...
pause > nul
exit

:getpwd
set "ssid=%*"

for /f "tokens=2 delims=:" %%i in ('netsh wlan show profile name^="%ssid:"=%" key^=clear ^| findstr /C:"Key Content"') do (
    echo SSID: %ssid% PASS: %%i
)
