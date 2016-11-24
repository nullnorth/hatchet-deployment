Configuration Sample_xVHD_NewVHD
{
    param
    (
        [Parameter(Mandatory)]
        [string]$Name,

        [Parameter(Mandatory)]
        [string]$Path,

        [Parameter(Mandatory)]
        [Uint64]$MaximumSizeBytes,

        [ValidateSet("Vhd","Vhdx")]
        [string]$Generation = "Vhd",

        [ValidateSet("Present","Absent")]
        [string]$Ensure = "Present"        
    )

    Import-DscResource -module xHyper-V

    Node localhost
    {
        xVHD NewVHD
        {
            Ensure           = $Ensure
            Name             = $Name
            Path             = $Path
            Generation       = $Generation
            MaximumSizeBytes = $MaximumSizeBytes
        }
    }
}