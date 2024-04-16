# Check if Windows Update is currently running
$windowsUpdateStatus = Get-Service wuauserv

if ($windowsUpdateStatus.Status -eq 'Running') {
    Write-Host "Windows Update is currently running. Waiting for updates to finish..."
    
    # Wait until Windows Update service stops
    while ($windowsUpdateStatus.Status -eq 'Running') {
        Start-Sleep -Seconds 60  # Wait for 60 seconds before checking again
        $windowsUpdateStatus = Get-Service wuauserv
    }
    
    Write-Host "Windows Update has finished."
}

# Restart the system
Write-Host "Restarting the system..."
Restart-Computer -Force