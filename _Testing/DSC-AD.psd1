# Configuration Data for AD              
@{             
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
            #networkaddress = "192.168.22.0"
            ScopeID = '1024'
            DNSserver1 = "192.168.22.2"
            DNSserver2 = "192.168.22.3"     
        }            
    )             
}   