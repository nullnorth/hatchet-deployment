@ECHO ON
SET scriptdrive=%~dp0
powershell.exe -ExecutionPolicy Bypass -Command "& '%~dpn0.ps1'"
pause
