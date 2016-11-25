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