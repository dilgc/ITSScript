# Get the directory of the script file
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path

# Navigate to the parent folder of the script (resources folder)
$resourcesFolder = Split-Path -Parent $scriptDirectory

# Construct the path to the Setups folder
$setupsFolder = Join-Path $resourcesFolder "Setups"

Write-Output "Starting installations..."

# Check if the Setups folder exists
if (Test-Path $setupsFolder) {
    # Construct the path to the Java setup executable
    $javaSetupPath = Join-Path $setupsFolder "JavaSetup.exe"
    $firefoxSetupPath = Join-Path $setupsFolder "FirefoxSetup.exe"
    $readerSetupPath = Join-Path $setupsFolder "ReaderSetup.exe"
    $chromeSetupPath = Join-Path $setupsFolder "ChromeSetup.exe"
    
    # Check if the Java setup executable exists
    if (Test-Path $javaSetupPath) {
        # Run Java setup silently
        Start-Process -FilePath $javaSetupPath -ArgumentList "/s" -Wait
        Write-Host "Java has been installed."
    } else {
        Write-Host "Java setup executable not found in $setupsFolder"
    }
    # Check if the Firefox setup executable exists
    if (Test-Path $firefoxSetupPath) {
        # Run Firefox setup silently
        Start-Process -FilePath $firefoxSetupPath -ArgumentList "/s" -Wait
        Write-Host "Mozilla Firefox has been installed."
    } else {
        Write-Host "Firefox setup executable not found in $setupsFolder"
    }
    # Check if the Chrome setup executable exists
    if (Test-Path $chromeSetupPath) {
        # Run Chrome setup silently
        Start-Process -FilePath $chromeSetupPath -ArgumentList "/silent /install" -Wait
        Write-Host "Google Chrome has been installed."
    } else {
        Write-Host "Chrome setup executable not found in $setupsFolder"
    }
    # Check if the Reader setup executable exists
    if (Test-Path $readerSetupPath) {
        # Run Reader setup silently
        Start-Process -FilePath $readerSetupPath -ArgumentList "/sAll /rs /rps /msi /norestart /quiet EULA_ACCEPT=YES" -Wait
        Write-Host "Adobe Reader has been installed."
    } else {
        Write-Host "Reader setup executable not found in $setupsFolder"
    }


} else {
    Write-Host "Setups folder not found in $resourcesFolder"
}
