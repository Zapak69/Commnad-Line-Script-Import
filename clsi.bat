@echo off
set "ver=1.0.3.2.8.2"
echo Commnad Line Script Import %ver%
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

:: APP INSTALL COMMANDS
if /i "%command%" == "$app install chrome" (
	PowerShell.exe -ExecutionPolicy Bypass -Command "irm 'https://dl.google.com/tag/s/appguid%3D%7B8A69D345-D564-463C-AFF1-A69D9E530F96%7D%26iid%3D%7B40D2092E-9681-5275-E300-7AF18C93F373%7D%26lang%3Dcs%26browser%3D4%26usagestats%3D1%26appname%3DGoogle%2520Chrome%26needsadmin%3Dprefers%26ap%3Dx64-statsdef_1%26installdataindex%3Dempty/update2/installers/ChromeSetup.exe' -UseBasicParsing -OutFile '%temp%\chrome_setup.exe'"
	start %temp%\chrome_setup.exe
)

::OTHER COMMANDS
if /i "%command%" == "$clear" cls
if /i "%command%" == "$exit" (
	echo Thanks for using CLSI! Goodbye.
	echo.
	timeout /t 0 /nobreak >nul
	exit
)
if /i "%command%" == "$" call :help
if /i "%command%" == "$help" call :help


::SETTING COMMANDS
if /i "%command%" == "$check" (
	powershell -Command "if (Test-Connection -ComputerName github.com -Count 1 -Quiet) { exit 0 } else { exit 1 }"
	if "%errorlevel%" == "0" (
		echo Github connection is working!
	) else (
		echo Failed to connect to github!
	)
)

::HARDER COMMANDS
echo %command% | find "$start" >nul
if "%errorlevel%" == "0" (
    call :start
    set start=1
)


::COMMAND NOT FOUND HANDLER
echo.
if not "%command%" == "$import" if not "%command%" == "$import base-gui" if not "%command%" == "$clear" if NOT "%command%" == "$install gui-buttons" if NOT "%command%" == "$check" if NOT "%command%" == "$app install chrome" if NOT "%command%" == "$" if NOT "%command%" == "$help" if NOT "%start%" == "1" (
    echo Unrecognized or incompleted command: "%command%"
)
goto :command

:start
for /f "tokens=1,2 delims= " %%a in ("%command%") do (
    set start=%%b
)
start "" "%start%"
exit /b 0

:help
echo [46m[CLSI HELP][0m
echo.
echo [92mCommand list:[0m
echo $import - script importation
echo $install - function installation
echo $app - app operations
echo $clear - clear console
echo $exit - exit
echo $check - conectivity check
echo.
echo [95mCommand addons:[0m
echo $import base-gui - basic gui menu
echo $install gui-buttons - Gui buttons installation
echo $app install chrome - google chrome installation
exit /b 0
