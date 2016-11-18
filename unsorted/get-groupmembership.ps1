Import-Module activedirectory

get-content ~\documents\group.txt | ForEach-Object {
Get-ADGroupMember -recursive -Identity $_ | select name  >> ~\Documents\groups-out.txt
}