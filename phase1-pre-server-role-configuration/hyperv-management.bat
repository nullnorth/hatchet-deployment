@ECHO OFF
PowerShell.exe -ExecutionPolicy Bypass -Command "& '%~dpn0.ps1'"
netsh advfirewall firewall set rule group="Remote Desktop" new enable=yes
PAUSE