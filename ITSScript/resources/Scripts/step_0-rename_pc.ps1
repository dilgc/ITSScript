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

# Get the current time zone
$currentTimeZone = Get-TimeZone

# Check if the current time zone is Eastern Standard Time
if ($currentTimeZone.Id -ne 'Eastern Standard Time') {
    # Set the time zone to Eastern Standard Time
    Set-TimeZone -Id 'Eastern Standard Time'
    Write-Host "Time zone changed to Eastern Standard Time."
} else {
    Write-Host "Time zone is already Eastern Standard Time."
}
