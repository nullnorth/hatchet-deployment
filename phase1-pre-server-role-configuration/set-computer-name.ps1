#variables
#$domainname
#$provisionname
#$domainadmincred

Add-Computer -ComputerName $env:COMPUTERNAME -Domain $domainname -NewName $provisionname -Credential $domainadmincred -force -Restart