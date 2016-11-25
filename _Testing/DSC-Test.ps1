﻿configuration DSC-AD             
{             
   param             
    (             
        [Parameter(Mandatory)]             
        [pscredential]$safemodeAdministratorCred,             
        [Parameter(Mandatory)]            
        [pscredential]$domainCred            
    )             
            
    Import-DscResource -ModuleName xActiveDirectory             
    import-dscresource -module xDHCPServer
    
            
    Node $AllNodes.Where{$_.Role -eq "Primary DC"}.Nodename             
    {             
            
        LocalConfigurationManager            
        {            
            ActionAfterReboot = 'ContinueConfiguration'            
            ConfigurationMode = 'ApplyOnly'            
            RebootNodeIfNeeded = $true            
        }            
           
        File ADFiles            
        {            
            DestinationPath = 'C:\NTDS'            
            Type = 'Directory'            
            Ensure = 'Present'            
        }            
                    
        WindowsFeature ADDSInstall             
        {             
            Ensure = "Present"             
            Name = "AD-Domain-Services"             
        }            
            
# Optional ADDS GUI tools            
        WindowsFeature ADDSTools            
        {             
            Ensure = "Present"             
            Name = "RSAT-ADDS"             
        }            
            
# No slash at end of folder paths            
        xADDomain FirstDS             
        {             
            DomainName = $Node.DomainName             
            DomainAdministratorCredential = $domainCred             
            SafemodeAdministratorPassword = $safemodeAdministratorCred            
            DatabasePath = 'N:\NTDS'            
            LogPath = 'N:\NTDS'            
            DependsOn = "[WindowsFeature]ADDSInstall","[File]ADFiles"            
        }
        
#To install the DHCP Server Role
        windowsfeature dhcpinstall
        {
            ensure = "Present"
            Name = "DHCP"
        }
#To install the DHCP GUI tools
        windowsfeature dhcptools
        {
            ensure = "Present"
            Name = "RSAT-DHCP"
        }
#DHCP Scope 
        xDhcpServerScope DomainScope 
             { 
                 Ensure = 'Present' 
                 IPEndRange = "$DHCPScopeEnd" 
                 IPStartRange = "$DHCPScopeStart" 
                 Name = '$domainname' 
                 SubnetMask = '255.255.255.0' 
                 LeaseDuration = '00:08:00' 
                 State = 'Inactive' 
                 AddressFamily = 'IPv4' 
             }
#Scope Options
        xDhcpServerOption Option 
             { 
                 Ensure = 'Present' 
                 ScopeID = "$networkaddress"
                 DnsDomain = "$domainname" 
                 DnsServerIPAddress = "$DNSserver1","$DNSserver2" 
                 AddressFamily = 'IPv4' 
             } 
        #TODO Add section for DHCP server authorization 
            
            
    }             
}                     

DSC-AD -ConfigurationData $ConfigData `
    -safemodeAdministratorCred (Get-Credential -UserName '(Password Only)' `
        -Message "New Domain Safe Mode Administrator Password") `
    -domainCred (Get-Credential -UserName alpineskihouse\administrator `
        -Message "New Domain Admin Credential")            
            
# Make sure that LCM is set to continue configuration after reboot            
Set-DSCLocalConfigurationManager -Path .\DSC-AD –Verbose            
            
# Build the domain            
Start-DscConfiguration -Wait -Force -Path .\DSC-AD -Verbose            