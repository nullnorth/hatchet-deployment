#set-computer-name.ps1
#$domainname
#$provisionname
#$domainadmincred

#set-net-adapter-address.ps1
#$blacklist = @('10.*', '192.168.*')

#local-account-gen.ps1
#$computername = $env:computername   # place computername here for remote access
#$username = '' #Need to populate desired username
#$password = '' #Need to populate desired password
#$desc = 'Automatically created local admin account'

# Configuration Data for Phase-1             
@{             
    AllNodes = @(             
        @{             
            #DC
            Nodename = "$env:computername"             
            ComputerName = "$env:computername"
			ProvisionName = "TEST-DC"
        }
    )             
}   