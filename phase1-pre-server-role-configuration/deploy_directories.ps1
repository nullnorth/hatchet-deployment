$drive = "D"
$softwaredir = @("Practice Management","Imaging","iTrans Certs","WSUSoffline")
$dentalequipmentdir = @('X-Ray Sensors','Intraoral Camera','PAN Machine')
New-Item -ItemType Directory -Path "${drive}:\Deploy\Drivers"
New-Item -ItemType Directory -Path "${drive}:\Deploy\Drivers\Dental Equipment"
foreach ($dentalequipment in $dentalequipmentdir ) {
 New-Item -ItemType Directory -Path "${drive}:\Deploy\Drivers\Dental Equipment\$dentalequipment"
 }

New-Item -ItemType Directory -Path "${drive}:\Deploy\Drivers\Printers"
New-Item -ItemType Directory -Path "${drive}:\Deploy\Software"

foreach ($software in $softwaredir ) {
 New-Item -ItemType Directory -Path "${drive}:\Deploy\Software\$software" 
 }

New-Item -ItemType Directory -Path "${drive}:\Deploy\GPO"
New-Item -ItemType Directory -Path "${drive}:\Redirected Profiles"