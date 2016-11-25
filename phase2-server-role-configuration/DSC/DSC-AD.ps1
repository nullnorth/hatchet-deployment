configuration DSC-AD             
{             
   param             
    (             
        [Parameter(Mandatory)]             
        [pscredential]$safemodeAdministratorCred,             
        [Parameter(Mandatory)]            
        [pscredential]$domainCred            
    )             
            
    Import-DscResource -ModuleName xActiveDirectory             
    import-dscresource -ModuleName xDhcpServer
            
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
            DatabasePath = 'N:\NTDS'            
            LogPath = 'N:\NTDS'            
            DependsOn = "[WindowsFeature]ADDSInstall","[File]ADFiles"            
        }            
            
    }             
}                     
# Configuration Data for AD              
$ConfigData = @{             
    AllNodes = @(             
        @{             
            #DC
            Nodename = "localhost"             
            Role = "Primary DC"             
            DomainName = "alpineskihouse.com"             
            RetryCount = 20              
            RetryIntervalSec = 30            
            PsDscAllowPlainTextPassword = $true            
            #DHCP
            DHCPScopeEnd = "192.168.22.200"
            DHCPScopeStart = "192.168.22.100"
            networkaddress = "192.168.22.0"
            DNSserver1 = "192.168.22.2"
            DNSserver2 = "192.168.22.3"     
        }            
    )             
}   

DSC-AD -ConfigurationData $ConfigData `
    -safemodeAdministratorCred (Get-Credential -UserName '(Password Only)' `
        -Message "New Domain Safe Mode Administrator Password") `
    -domainCred (Get-Credential -UserName alpineskihouse\administrator `
        -Message "New Domain Admin Credential")            
            
# Make sure that LCM is set to continue configuration after reboot            
#Set-DSCLocalConfigurationManager -Path .\DSC-AD –Verbose            
            
# Build the domain            
#Start-DscConfiguration -Wait -Force -Path .\DSC-AD    