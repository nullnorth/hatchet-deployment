Import-Module activedirectory
#need to create Params for this properly
$DC1="kmc"
$DC2="old"
$abbr="KMC"
New-ADOrganizationalUnit -Name "$abbr" -path "DC=$DC1,DC=$DC2"
New-ADOrganizationalUnit -Name "Computers" -path "OU=$abbr,DC=$DC1,DC=$DC2"
New-ADOrganizationalUnit -Name "Workstations" -path "OU=Computers,OU=$abbr,DC=$DC1,DC=$DC2"
New-ADOrganizationalUnit -Name "Servers" -path "OU=Computers,OU=$abbr,DC=$DC1,DC=$DC2"
New-ADOrganizationalUnit -Name "Users" -path "OU=$abbr,DC=$DC1,DC=$DC2"
New-ADOrganizationalUnit -Name "Staff" -path "OU=Users,OU=$abbr,DC=$DC1,DC=$DC2"
New-ADOrganizationalUnit -Name "Management" -path "OU=Users,OU=$abbr,DC=$DC1,DC=$DC2"
redircmp "OU=Workstations,OU=Computers,OU=$abbr,DC=$DC1,DC=$DC2"
redirusr "OU=Staff,OU=Users,OU=$abbr,DC=$DC1,DC=$DC2"