#Variables
$blacklist = @('10.*', '192.168.*')

#Get-NetIPAddress -AddressFamily IPv4 -Verbose
#Filters out all NICs that are NOT static,IPv6,disconnected
$activeadapter = Get-NetIPinterface -ConnectionState Connected -Dhcp Enabled -AddressFamily IPv4
#Retrieve the interface IP and check that it is NOT Link-local,public IP or in specific private address ranges
foreach ($blackIP in $blacklist) {
    if ($(Get-NetIPAddress -AddressFamily IPv4 -InterfaceIndex $activeadapter.ifIndex).IPv4Address -like $blackIP )
        {echo "Invalid IP"; break}
    }

