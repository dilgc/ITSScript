Write-Output "Setting up ITS power plan..."

# Get Current Active Plan
$OriginalPlan = $(powercfg -getactivescheme).split()[3]
# Duplicate Current Active Plan
$Duplicate = powercfg -duplicatescheme $OriginalPlan
# Change Name of Duplicated Plan
$CurrentPlan = powercfg -changename ($Duplicate).split()[3] "ITS Power Plan"
# Set New Plan as Active Plan
$SetActiveNewPlan = powercfg -setactive ($Duplicate).split()[3]
# Get the New Plan
$NewPlan = $(powercfg -getactivescheme).split()[3]

# PLAN SETTINGS

#Turn off Display - On Battery - 15 = 15 Minutes
powercfg -change -monitor-timeout-dc 15
#Turn off Display - While plugged in - 0 = Never
powercfg -change -monitor-timeout-ac 0
#Sleep Mode - On Battery - 0 = Never
powercfg -change -standby-timeout-ac 0
#Sleep Mode - While plugged in - 0 = Never
powercfg -change -standby-timeout-dc 0
#Turn off Hard Disk - On Battery - 30 = 30 Minutes
powercfg -change -disk-timeout-dc 30
#Turn off Hard Disk - While Plugged In - 0 = Never
powercfg -change -disk-timeout-ac 0


#APPLY CHANGES
cmd /c "powercfg /s $NewPlan"

#Disable fast startup
Write-Output "Disabling fast startup..."
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Power" /v HiberbootEnabled /t REG_DWORD /d 0 /f
	