import-module ActiveDirectory

Get-ADUser -SearchBase "OU=SBSUsers,OU=Users,OU=MyBusiness,DC=kmcoilfield,DC=local" -filter * |select Name,SamAccountName |Export-Csv "C:\_dump\SBSUsers-dump.txt"
Get-ADUser -SearchBase "OU=Generic Accounts,OU=Users,OU=MyBusiness,DC=kmcoilfield,DC=local" -filter * |select Name,SamAccountName |Export-Csv "C:\_dump\GenericAccounts-dump.txt"
Get-ADUser -SearchBase "OU=Avalon,OU=Users,OU=MyBusiness,DC=kmcoilfield,DC=local" -filter * |select Name,SamAccountName |Export-Csv "C:\_dump\Avalon-dump.txt"
Get-ADUser -SearchBase "OU=Terminated/Quit,OU=Users,OU=MyBusiness,DC=kmcoilfield,DC=local" -filter * |select Name,SamAccountName |Export-Csv "C:\_dump\terminated&Quit-dump.txt"

get-adgroup -searchscope subtree -searchbase "OU=Users,OU=MyBusiness,DC=kmcoilfield,DC=local" -filter * |select Name,SamAccountName |Export-Csv "C:\_dump\groups-dump.txt"
import-csv "C:\_dump\groups-dump.txt" | select Name|ForEach-Object {
    Get-ADGroupMember -recursive -Identity $_ | select Name | export-csv -Append "C:\_dump\groups-membership-dump.txt"
}