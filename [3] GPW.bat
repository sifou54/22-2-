@echo off
color 09

REM Take ownership of the GameBarPresenceWriter.exe file and grant the current user full control
takeown /s %computername% /u %username% /f "%WINDIR%\System32\GameBarPresenceWriter.exe"
icacls "%WINDIR%\System32\GameBarPresenceWriter.exe" /grant:r %username%:F

REM Kill the GameBarPresenceWriter.exe process and rename the file
taskkill /im GameBarPresenceWriter.exe /f
ren "%WINDIR%\System32\GameBarPresenceWriter.exe" GameBarPresenceWriter.old.exe

REM Wait for 4 seconds and clear the screen
timeout 4 >nul
cls
exit
