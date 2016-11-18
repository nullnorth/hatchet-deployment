param(
    [parameter(Mandatory=$true)]
    [string] $zone,
    [parameter(Mandatory=$true)]
    [string] $record
)

#external DNS resolution using opendns servers
$PubRR = Resolve-DnsName -name "$record.$zone" -Type A -DnsOnly -Server 208.67.222.222
#get internal DNS entries for the same record
$OldIntRR = Get-DnsServerResourceRecord -ZoneName $zone -RRType A -Name $record
#Same variable just will be modded with a IP injection
$NewIntRR = Get-DnsServerResourceRecord -ZoneName $zone -RRType A -Name $record    
#Inject the external IP into the NewIntRR variable
$NewIntRR.recorddata.ipv4address=[System.Net.IPAddress]::Parse($PubRR.IPAddress)
if ( $PubRR.IPAddress -eq $OldIntRR.RecordData.IPv4Address.IPAddressToString ) {
    Write-Host "Error: The DNS record either does not exist or is already correct."
    exit 1001
        }
#Write-Output $PubRR.IPAddress
#Write-Output $OldIntRR.RecordData.IPv4Address.IPAddressToString

if ( $PubRR.IPAddress -ne $OldIntRR.RecordData.IPv4Address.IPAddressToString) {
    #If not matching, update the record from old -> new with the new IP address
    Set-DnsServerResourceRecord -OldInputObject $OldIntRR -NewInputObject $NewIntRR  -ZoneName $zone -PassThru
    Write-Host "Successfully updated to new IP"
    exit 0
        }
