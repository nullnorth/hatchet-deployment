$evilFiles = Get-ChildItem C:\DEXIS -Recurse | Select-Object FullName
 
foreach($evilFile in $evilFiles) {
    if($evilFile.FullName -like "*CRYPTED*") {
        Remove-Item -Path $evilFile.FullName -WhatIf
        }
    else {
        Write-Host "No evil found."
        }
}