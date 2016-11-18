Import-Module ActiveDirectory
new-adgroup -Name "DispatchUsers"
import-csv C:\users\administrator\desktop\users.csv | % {Add-ADGroupMember -Identity "DispatchUsers" -whatif -member $_.SamAccountName}
