@echo off
set "ver=1.0.5.0.0.0"
echo Commnad Line Script Import %ver%
if /i "%1" == "-version" exit /b 0
timeout /t 0 /nobreak >nul
echo [92m[IMPORTING...][0m
timeout /t 0 /nobreak >nul
where powershell >nul
if "%errorlevel%" == "0" (
	echo [94m[POWERSHELL FOUND...][0m
	timeout /t 0 /nobreak >nul
) else (
	echo [91m[POWERSHELL NOT FOUND...][0m
	pause >nul
	exit
)
powershell -Command "if (Test-Connection -ComputerName github.com -Count 1 -Quiet) { exit 0 } else { exit 1 }"
if "%errorlevel%" == "0" (
	echo [90m[GITHUB RESPONDING...][0m
	timeout /t 0 /nobreak >nul
) else (
	echo [41m[GITHUB FAILED CONECTION...][0m
	pause >nul
	exit
)
echo [96m[CHECKING FOR UPDATES...][0m
PowerShell.exe -ExecutionPolicy Bypass -Command "irm 'https://raw.githubusercontent.com/Zapak69/Commnad-Line-Script-Import/refs/heads/main/ver' -UseBasicParsing -OutFile '%temp%\ver.txt'"
type %temp%\ver.txt | find "%ver%"
if NOT "%errorlevel%" == 0 (
	goto updater
)
echo.
timeout /t 0 /nobreak >nul
echo [42m[97m[CLSI LOADED][0m
timeout /t 0 /nobreak >nul
echo.
echo [100mType the prefix "$" to enter the command[0m
set "prompt=[0m --> "
:command
echo.
set /p "command=%prompt%"
echo.

::IMPORT COMMANDS
if /i "%command%" == "$import base-gui" (
	PowerShell.exe -ExecutionPolicy Bypass -Command "irm 'https://raw.githubusercontent.com/Zapak69/Commnad-Line-Script-Import/refs/heads/main/Commands/import/base-gui.bat' -UseBasicParsing -OutFile '%USERPROFILE%\Desktop\base-gui.bat'"
	if "%errorlevel%" == "0" echo [100m[97mBase gui imported to: "[92m%USERPROFILE%\Desktop\base-gui.bat[97m"[0m
)

:: FUNCTIONS COMMANDS
if /i "%command%" == "$install gui-buttons" (
	PowerShell.exe -ExecutionPolicy Bypass -Command "irm 'https://github.com/Zapak69/BATCH_GUI_BUTTONS_INSTALL/raw/refs/heads/main/NOGUI_BUTTON.exe' -UseBasicParsing -OutFile '%temp%\bdownload.exe'"
	start %temp%\bdownload.exe
	powershell.exe -Command "Write-Host '[100m[97mFunction installed to: [92m%systemroot%\System32[97m' -NoNewline"
)

::OTHER COMMANDS
if /i "%command%" == "$clear" cls
if /i "%command%" == "$exit" (
	echo Thanks for using CLSI! Goodbye.
	echo.
	exit
)
if /i "%command%" == "$version" echo CLSI VERSION: %ver%


::COMMAND NOT FOUND HANDLER
echo.
if not "%command%" == "$import" if not "%command%" == "$import base-gui" if not "%command%" == "$clear" if NOT "%command%" == "$install gui-buttons" (
    echo Unrecognized or incompleted command: "%command%"
)

goto :command

:updater
echo [[96mNEW UPDATE FOUND!...][0m
net session >nul 2>&1
if %errorlevel% neq 0 (
	cls
	echo.
	echo [91m[ERROR :/][0m
	echo.
	echo Start script as admin to complete update!
	pause >nul
	exit
)
echo.
echo [[96mUPDATING!...][0m
PowerShell.exe -ExecutionPolicy Bypass -Command "irm 'https://raw.githubusercontent.com/Zapak69/Commnad-Line-Script-Import/refs/heads/main/misc/updater.bat' -UseBasicParsing -OutFile '%temp%\clsiupdate.bat'"
start %temp%\clsiupdate.bat & exit
