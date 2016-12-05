#from https://adsecurity.org/?p=440
#This is to automatically convert the domain name supplied into a usable DN
Clear-Variable -Name ADObjectDNArrayItemDomainName
Clear-Variable -Name DomainFullyQualifiedDomainName
$DomainFullyQualifiedDomainName = (read-host -prompt "Enter FQDN")
$DomainFullyQualifiedDomainNameArray = $DomainFullyQualifiedDomainName -Split(“\.”)
[int]$DomainNameFECount = 0
ForEach ($DomainFullyQualifiedDomainNameArrayItem in $DomainFullyQualifiedDomainNameArray)
{ 
    IF ($DomainNameFECount -eq 0)
        { [string]$ADObjectDNArrayItemDomainName += “DC=” +$DomainFullyQualifiedDomainNameArrayItem }
    ELSE 
        { [string]$ADObjectDNArrayItemDomainName += “,DC=” +$DomainFullyQualifiedDomainNameArrayItem }
    $DomainNameFECount++
}

$DSCVAR = @{             
    AllNodes = @(             
        @{             
            #DC
            Nodename = "$env:computername"             
            Role = "Primary DC"             
            #DN = "$ADObjectDNArrayItemDomainName"             
            $RootOUName = ""
            $CompOUName
            $ServerOUName
            $WorkstationOUName
            UsersOUName
        }            
    )             
}
$DSCVAR
configuration DSC-OU            
{             
   param             
    (             
        [Parameter(Mandatory)]             
        [string]$DNpath             
    )             
            
    Import-DscResource -ModuleName xActiveDirectory
    Import-DscResource -ModuleName xDhcpServer
            
    Node $AllNodes.Where{$_.Role -eq "Primary DC"}.Nodename             
    {   
        xadorganizationalunit RootOU
        {
            Name = "rooty"
            Path = "$DNpath"
            Description = "Root OU"
            ProtectedFromAccidentalDeletion = $false
            Ensure = "Present"
            #Domain admin credentials
            #Credential = ""
        }
        xadorganizationalunit Computers
        {
            Name = "Computers"
            Path = "OU=$abbr,$DN"
            Description = "Contains all Active Workstations & Servers"
            ProtectedFromAccidentalDeletion = $false
            Ensure = "Present"
            #Domain admin credentials
            #Credential = ""
        }
        xadorganizationalunit Servers
        {
            Name = "Computers"
            Path = "OU=OU=$abbr,$DN"
            Description = "Contains all Active Workstations & Servers"
            ProtectedFromAccidentalDeletion = $false
            Ensure = "Present"
            #Domain admin credentials
            #Credential = ""
        }
        xadorganizationalunit Workstations
        {
            Name = "Computers"
            Path = "OU=$abbr,$DN"
            Description = "Contains all Active Workstations & Servers"
            ProtectedFromAccidentalDeletion = $false
            Ensure = "Present"
            #Domain admin credentials
            #Credential = ""
        }#>
    }
}
DSC-OU -ConfigurationData $DSCVAR `
    -DNpath $ADObjectDNArrayItemDomainName