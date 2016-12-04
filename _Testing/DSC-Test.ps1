configuration DSC-TEST            
{             
   param             
    (             
        [Parameter(Mandatory)]             
        [pscredential]$safemodeAdministratorCred,             
        [Parameter(Mandatory)]            
        [pscredential]$domainCred
    )             
            
    Import-DscResource -ModuleName xActiveDirectory
    Import-DscResource -ModuleName xDhcpServer
            
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
            
        # Optional GUI tools            
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
            DatabasePath = 'C:\NTDS'            
            LogPath = 'C:\NTDS'            
            DependsOn = "[WindowsFeature]ADDSInstall","[File]ADFiles"            
        }            
                windowsfeature dhcpinstall
        {
            ensure = "Present"
            Name = "DHCP"
        }
        windowsfeature dhcptools
        {
            ensure = "Present"
            Name = "RSAT-DHCP"
        }
        xDhcpServerScope Scope 
        { 
            Ensure = 'Present' 
            IPEndRange = "$DHCPScopeEnd" 
            IPStartRange = "$DHCPScopeStart" 
            Name = "$domainname"
            SubnetMask = '255.255.255.0' 
            LeaseDuration = '00:08:00' 
            State = 'Inactive' 
            AddressFamily = 'IPv4'
            Dependson = "[WindowsFeature]dhcptools"
        } 
        xDhcpServerOption ScopeOpt 
        { 
            Ensure = 'Present'
            #I need to hardcode in the SCOPEID ????
            #Seems to be a issue with variable resolution
            ScopeID = '192.168.22.0'
            #ScopeID = "$ScopeID"
            DnsDomain = "$domainname" 
            DnsServerIPAddress = "$DNSserver1","$DNSserver2" 
            AddressFamily = 'IPv4'
            #Dependson = "[xDhcpServer]Scope,[WindowsFeature]dhcptools" 
         } 
    }             
}                     
# Configuration Data for AD              

DSC-TEST -ConfigurationData .\DSC-AD.psd1 `
    -safemodeAdministratorCred (Get-Credential -UserName '(Password Only)' `
        -Message "New Domain Safe Mode Administrator Password") `
    -domainCred (Get-Credential -UserName alpineskihouse\administrator `
        -Message "New Domain Admin Credential")          
            
# Make sure that LCM is set to continue configuration after reboot            
#Set-DSCLocalConfigurationManager -Path .\DSC-AD –Verbose            
            
# Build the domain            
#Start-DscConfiguration -Wait -Force -Path .\DSC-AD    