# Prompt user for ITS number. Rename PC to ITS[Number]

try {

    $ITSNumber = Read-Host "Enter ITS Number"
    Rename-Computer -NewName "ITS$ITSNumber"
    
    Write-Host "PC has been renamed to $ITSNumber successfully."
}
catch
{
    $errorMessage = $_.Exception.Message
    Write-Host "Error occurred trying to rename PC"
    Write-Host "Error: $errorMessage"
}


# Prompt user for workstation description

try{
    $WorkstationDescription = Read-Host "Enter Workstation Description"

    # Set workstation description
    $WMIObject = Get-WmiObject Win32_OperatingSystem
    $WMIObject.Description = $WorkstationDescription
    $WMIObject.Put()

    Write-Host "Description has been set to $WorkstationDescription successfully."
}
catch
{
    $errorMessage = $_.Exception.Message
    Write-Host "Error occurred trying to set workstation description"
    Write-Host "Error: $errorMessage"
}
