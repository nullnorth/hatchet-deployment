import-dscresource -module xDHCPServer
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
         Name = '$domainname' 
         SubnetMask = '255.255.255.0' 
         LeaseDuration = '00:08:00' 
         State = 'Active' 
         AddressFamily = 'IPv4' 
     } 
xDhcpServerOption Option 
     { 
         Ensure = 'Present' 
         ScopeID = "$networkaddress"
         DnsDomain = "$domainname" 
         DnsServerIPAddress = "$DNSserver1","$DNSserver2" 
         AddressFamily = 'IPv4' 
     } 
#TODO Add section for DHCP server authorization 
