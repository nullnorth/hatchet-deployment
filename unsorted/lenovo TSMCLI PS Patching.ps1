#Variables
$SERVERIP = ""
$CREDPATH = ""
$UPDATEID = ""
$FWFILE = ""
$REBOOTMODE = ""
#create credentials first for the lenovo server
invoke-tsmcli -commandname create-credential -commandargs @{username="lenovo"; password="len0vO";savetofile=$CREDPATH}
#get into firmware update mode
invoke-tsmcli -commandname enter-fwupdatemode -computername $SERVERIP -credential $CREDPATH 
#upload/transfer
#based on command descriptions appears that transfer uses other protocols (NFS/CIFS/TFTP) for the transmission process....assume that http is used for upload command
invoke-tsmcli -commandname upload-fwimage -computername $SERVERIP -credential $CREDPATH -commandargs @{updateid=$UPDATEID;fwfile=$FWFILE}
#check and verify patches Patch Level
invoke-tsmcli -commandname get-fwversions -computername $SERVERIP -credential $CREDPATH
#start patching process, Note that you can set reboot mode...perfer to keep it at auto and just suceed frequently and move on to the next patch
invoke-tsmcli -commandname upload-fwimage -computername $SERVERIP -credential $CREDPATH -commandargs @{updateid=$UPDATEID;rebootafterupdate=$REBOOTMODE}
#Check-in on firmware patching process
invoke-tsmcli -commandname upload-fwimage -computername $SERVERIP -credential $CREDPATH
#leaving firmware update mode
invoke-tsmcli -commandname exit-fwupdatemode -computername $SERVERIP -credential $CREDPATH -commandargs @{updateId=$UPDATEID}

