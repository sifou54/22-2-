@echo off
color 0B
PowerShell "Write-Host 'ChkDsk' -ForegroundColor Blue; ChkDsk /scan; 
REM Check if the C:\Windows\Temp folder exists and create it if it doesn't
IF NOT EXIST C:\Windows\Temp (
  echo C:\Windows\Temp folder not found, creating...
  mkdir C:\Windows\Temp
)

REM Grant full access permissions to the Everyone group for the C:\Windows\Temp folder
echo Granting permissions to C:\Windows\Temp folder...
icacls "C:\Windows\Temp" /grant Everyone:(OI)(CI)F /T > NUL

REM Grant full access permissions to the Everyone group for the %TEMP% and %USERPROFILE%\AppData\Local\Temp folders
echo Granting permissions to %TEMP% folder...
icacls "%TEMP%" /grant Everyone:(OI)(CI)F /T > NUL
echo Granting permissions to %USERPROFILE%\AppData\Local\Temp folder...
icacls "%USERPROFILE%\AppData\Local\Temp" /grant Everyone:(OI)(CI)F /T > NUL

PowerShell "Write-Host 'SFC - Scan 1' -ForegroundColor Blue; sfc /scannow;
PowerShell "Write-Host 'DISM' -ForegroundColor Blue; DISM /Online /Cleanup-Image /Restorehealth; 
PowerShell "Write-Host 'SFC - Scan 2' -ForegroundColor Blue; sfc /scannow; 
timeout 2 >nul
cls
@echo Done
timeout 2 >nul
exit