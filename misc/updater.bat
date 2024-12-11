@echo off
net session >nul 2>&1
if %errorlevel% neq 0 (
    powershell -Command "Start-Process cmd -ArgumentList '/c \"%~f0\"' -Verb RunAs"
    exit /b
)
del %systemroot%\System32\clsi.bat 
if exist "%systemroot%\System32\clsi.bat" (
    exit
)
PowerShell.exe -ExecutionPolicy Bypass -Command "irm 'https://raw.githubusercontent.com/Zapak69/Commnad-Line-Script-Import/refs/heads/main/clsi.bat' -UseBasicParsing -OutFile '%systemroot%\System32\clsi.bat'"
if NOT exist "%systemroot%\System32\clsi.bat" (
    exit
)
echo X=MsgBox("Update complete!", 0+64, "UPDATER") >> %temp%\msg.vbs
start %temp%\msg.vbs
timeout /t 1 /nobreak >nul
del %temp%\msg.vbs
del %~dp0
exit
