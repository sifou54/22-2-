@echo off
@echo DirectX Installer
timeout 2 >nul
powershell -Command "Invoke-WebRequest 'https://download.microsoft.com/download/1/7/1/1718CCC4-6315-4D8E-9543-8E28A4E18C4C/dxwebsetup.exe' -OutFile 'C:\dxwebsetup.exe'"
start /wait C:\dxwebsetup.exe /Q
del /F /Q C:\dxwebsetup.exe