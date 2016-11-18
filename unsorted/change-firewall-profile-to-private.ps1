#Method to remove Publicly flagged Networks on Servers
#As per http://windowsitpro.com/powershell/how-force-network-type-windows-using-powershell
#Get-NetConnectionProfile -NetworkCategory Public
$netget = Get-NetConnectionProfile
Set-NetConnectionProfile -InputObject $netget -NetworkCategory Public
