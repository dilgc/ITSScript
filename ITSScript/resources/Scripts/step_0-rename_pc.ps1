# Prompt user for ITS number
$ITSNumber = Read-Host "Enter ITS Number"
# Rename PC to "ITS[ITSNumber]"
Rename-Computer -NewName "ITS$ITSNumber"

Write-Output "PC has been renamed. Will update after a restart."
Write-Output "Initiating Windows updates..."

# Trigger Windows Update via PowerShell
Invoke-Command -ScriptBlock {
    $updateSession = New-Object -ComObject Microsoft.Update.Session
    $updateSearcher = $updateSession.CreateUpdateSearcher()
    $updates = $updateSearcher.Search("IsInstalled=0")
    $updates | ForEach-Object {
        $_.Install()
    }
}