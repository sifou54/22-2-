@echo off
color 0B
@echo Cache Cleaner
timeout 2 >nul
    IF "%PROCESSOR_ARCHITECTURE%" EQU "amd64" (
>nul 2>&1 "%SYSTEMROOT%\SysWOW64\cacls.exe" "%SYSTEMROOT%\SysWOW64\config\system"
) ELSE (
>nul 2>&1 "%SYSTEMROOT%\system32\cacls.exe" "%SYSTEMROOT%\system32\config\system"
)

if '%errorlevel%' NEQ '0' (
    echo Requesting administrative privileges...
    goto UACPrompt
) else ( goto gotAdmin )

:UACPrompt
    echo Set UAC = CreateObject^("Shell.Application"^) > "%temp%\getadmin.vbs"
    set params= %*
    echo UAC.ShellExecute "cmd.exe", "/c ""%~s0"" %params:"=""%", "", "runas", 1 >> "%temp%\getadmin.vbs"

    "%temp%\getadmin.vbs"
    del "%temp%\getadmin.vbs"
    exit /B

:gotAdmin
    pushd "%CD%"
    CD /D "%~dp0"
FOR /F "tokens=1,2*" %%V IN ('bcdedit') DO SET adminTest=%%V
IF (%adminTest%)==(Access) goto noAdmin
for /F "tokens=*" %%G in ('wevtutil.exe el') DO (call :do_clear "%%G")
echo.
goto theEnd
:do_clear
echo clearing %1
wevtutil.exe cl %1
goto :eof
:theEnd
cls
@echo Removing Temporary files
timeout 2 >nul
del /s /f /q c:\windows\temp\*.*
rd /s /q c:\windows\temp
md c:\windows\temp
del /s /f /q C:\WINDOWS\Prefetch
del /s /f /q %temp%\*.*
rd /s /q %temp%
cd /d c:\windows\tempor~1 && rd /s /q .\
cd /d c:\windows\temp && rd /s /q .\
cd /d c:\windows\tmp && rd /s /q .\
cd /d c:\windows\ff*.tmp && rd /s /q .\
cd /d c:\windows\history && rd /s /q .\
cd /d c:\windows\cookies && rd /s /q .\
cd /d c:\windows\recent && rd /s /q .\
cd /d c:\windows\spool\printers && rd /s /q .\
REM Log Files
cd/
@echo
del *.log /a /s /q /f
RD /S /Q %temp%
MKDIR %temp%
RD /S /Q C:\Windows\Temp
MKDIR C:\Windows\Temp
timeout 2 >nul
cls
@echo Finished
timeout /t 3 /nobreak >nul
exit