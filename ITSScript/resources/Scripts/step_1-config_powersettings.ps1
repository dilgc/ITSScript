Write-Output "Setting up ITS power plan..."

# Get Current Active Plan
$OriginalPlan = $(powercfg -getactivescheme).split()[3]
if (-not $OriginalPlan) {
    Write-Output "Failed to retrieve the current active power plan."
}

# Duplicate Current Active Plan
$Duplicate = powercfg -duplicatescheme $OriginalPlan
if (-not $Duplicate) {
    Write-Output "Failed to duplicate the current active power plan."
}

# Change Name of Duplicated Plan
$CurrentPlan = powercfg -changename ($Duplicate).split()[3] "ITS Power Plan"
if (-not $CurrentPlan) {
    Write-Output "Failed to change the name of the duplicated power plan."
}

# Set New Plan as Active Plan
$SetActiveNewPlan = powercfg -setactive ($Duplicate).split()[3]
if (-not $SetActiveNewPlan) {
    Write-Output "Failed to set the duplicated power plan as active."
}

# Get the New Plan
$NewPlan = $(powercfg -getactivescheme).split()[3]
if (-not $NewPlan) {
    Write-Output "Failed to retrieve the newly activated power plan."
}

# PLAN SETTINGS
try {
    # Turn off Display - On Battery - 30 = 30 Minutes
    powercfg -change -monitor-timeout-dc 30
    # Turn off Display - While plugged in - 0 = Never
    powercfg -change -monitor-timeout-ac 0
    # Sleep Mode - On Battery - 30 = Never
    powercfg -change -standby-timeout-ac 30
    # Sleep Mode - While plugged in - 0 = Never
    powercfg -change -standby-timeout-dc 0
    # Turn off Hard Disk - On Battery - 30 = 30 Minutes
    powercfg -change -disk-timeout-dc 10
    # Turn off Hard Disk - While Plugged In - 0 = Never
    powercfg -change -disk-timeout-ac 0
    # Hibernate - On Battery - 180 minutes
    powercfg -change -hibernate-timeout-dc 180
    # Hibernate - While plugged in - 0 = Never
    powercfg -change -hibernate-timeout-ac 0
} catch {
    Write-Output "Failed to apply power plan settings: $_"
}

# APPLY CHANGES
try {
    cmd /c "powercfg /s $NewPlan"
} catch {
    Write-Output "Failed to apply the new power plan: $_"
}

# Disable fast startup
Write-Output "Disabling fast startup..."
try {
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f
} catch {
    Write-Output "Failed to disable fast startup: $_"
}

Write-Output "Power plan setup completed successfully."
