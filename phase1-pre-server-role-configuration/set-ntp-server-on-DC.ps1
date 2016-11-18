#Based on information in http://www.sysadminlab.net/windows/configuring-ntp-on-windows-server-2012
w32tm /config /manualpeerlist:”0.pool.ntp.org 1.pool.ntp.org” /syncfromflags:MANUAL
Stop-Service w32time
Start-Service w32time
w32tm /query /status