#Write-Host "Num Args:" $args.Length;
foreach ($arg in $args)
{
  #Write-Host "Arg: $arg";
  Invoke-Command -ComputerName $arg {
                                       start-service -name 'Advanced Monitoring Agent'
                                       start-service -name 'gfi_lanss11_attservice'
                                    }
}