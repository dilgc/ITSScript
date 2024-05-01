# Prompt user for ITS number
$ITSNumber = Read-Host "Enter ITS Number"
# Rename PC to "ITS[ITSNumber]"
Rename-Computer -NewName "ITS$ITSNumber"

# Prompt user for workstation description
$WorkstationDescription = Read-Host "Enter Workstation Description"

# Set workstation description
$WMIObject = Get-WmiObject Win32_OperatingSystem
$WMIObject.Description = $WorkstationDescription
$WMIObject.Put()
