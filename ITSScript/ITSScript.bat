@echo off
:: BatchGotAdmin
:-------------------------------------
REM  --> Check for permissions
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"

REM --> If error flag set, we do not have admin.
if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params = %*:"=""
    echo UAC.ShellExecute "%~s0", "%params%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
:--------------------------------------

echo Running PowerShell scripts...

PowerShell -NoProfile -ExecutionPolicy Bypass -File "resources\Scripts\step_0-rename_pc.ps1"
PowerShell -NoProfile -ExecutionPolicy Bypass -File "resources\Scripts\step_1-config_powersettings.ps1"
PowerShell -NoProfile -ExecutionPolicy Bypass -File "resources\Scripts\step_2-uninstalls.ps1"
PowerShell -NoProfile -ExecutionPolicy Bypass -File "resources\Scripts\step_3-installs.ps1"
PowerShell -NoProfile -ExecutionPolicy Bypass -File "resources\Scripts\step_4-update.ps1"

pause