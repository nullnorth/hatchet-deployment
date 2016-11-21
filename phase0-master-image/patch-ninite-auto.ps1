$outlocation = "C:\temp-ninite.exe"
#$niniteURL
invoke-webrequest -uri "https://ninite.com/eclipse/ninite.exe" -OutFile $outlocation
&$outlocation /silent
Start-Sleep -Seconds 600
Remove-Item -Path $outlocation