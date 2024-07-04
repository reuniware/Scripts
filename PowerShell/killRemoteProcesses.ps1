# Prompt user for credentials
$credential = Get-Credential

# Define the remote computer name
$remoteComputer = "MACHINENAME"

# Define the script block to be executed remotely
$scriptBlock = {
    # Get the process ID (PID) of SetProcessNameHere
    $process = Get-CimInstance -ClassName Win32_Process -Filter "Name='ApplicationNameToKill.exe'"
    
    if ($process) {
        # Kill the SetProcessNameHere process
        $process | ForEach-Object {
            Stop-Process -Id $_.ProcessId -Force
            Write-Host "SetProcessNameHere process (PID: $($_.ProcessId)) killed."
        }
    } else {
        Write-Host "SetProcessNameHere process not found."
    }
}

# Execute the script block remotely on the specified computer with credentials
Invoke-Command -ComputerName $remoteComputer -Credential $credential -ScriptBlock $scriptBlock
