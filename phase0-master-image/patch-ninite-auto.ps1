$outlocation = "C:\temp-ninite.exe"
#$niniteURL
invoke-webrequest -uri "https://ninite.com/eclipse/ninite.exe" -OutFile $outlocation
start-process $outlocation -NoNewWindow -Wait
Remove-Item -Path $outlocation