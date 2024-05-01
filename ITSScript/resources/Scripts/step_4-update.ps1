#Update Windows on the machine
try{
# Install PSWindowsUpdate module if not already installed
if (-not (Get-Module -Name PSWindowsUpdate -ListAvailable)) {
    Install-Module -Name PSWindowsUpdate -Force -Scope CurrentUser -AllowClobber
}

# Import the PSWindowsUpdate module
Import-Module PSWindowsUpdate -Force

# Perform Windows Update
Install-WindowsUpdate -AcceptAll -Verbose
}
catch{
Write-Host "Did not update Windows successfully."
}
