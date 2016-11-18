import-module ActiveDirectory

Get-ADUser -SearchBase "OU=SBSUsers,OU=Users,OU=MyBusiness,DC=kmcoilfield,DC=local" -filter * |select Name,SamAccountName |Export-Csv "C:\SBSUsers-dump.txt"
Get-ADUser -SearchBase "OU=Generic Accounts,OU=Users,OU=MyBusiness,DC=kmcoilfield,DC=local" -filter * |select Name,SamAccountName |Export-Csv "C:\GenericAccounts-dump.txt"
Get-ADUser -SearchBase "OU=Avalon,OU=Users,OU=MyBusiness,DC=kmcoilfield,DC=local" -filter * |select Name,SamAccountName |Export-Csv "C:\Avalon-dump.txt"
Get-ADUser -SearchBase "OU=Terminated/Quit,OU=Users,OU=MyBusiness,DC=kmcoilfield,DC=local" -filter * |select Name,SamAccountName |Export-Csv "C:\terminated&Quit-dump.txt"