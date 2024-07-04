# Define the remote computer name and credentials
$remoteComputer = "MACHINENAME"
$username = "username"
$password = "password" | ConvertTo-SecureString -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

# Connect to the remote computer
$session = New-PSSession -ComputerName $remoteComputer -Credential $credential

# Define the script block to be executed on the remote machine
$scriptBlock = {
    # Function to monitor new processes
    function Monitor-Processes {
        # Get the initial list of processes
        $initialProcesses = Get-Process

        while ($true) {
            # Get the current list of processes
            $currentProcesses = Get-Process

            # Compare the current list with the initial list
            Compare-Object -ReferenceObject $initialProcesses -DifferenceObject $currentProcesses |
            Where-Object { $_.SideIndicator -eq "=>" } |
            ForEach-Object {
                # Output the new process
                Write-Host "New process started: $($_.InputObject.Name)"
            }

            # Update the initial list of processes
            $initialProcesses = $currentProcesses

            # Wait for a while before checking again
            Start-Sleep -Seconds 5
        }
    }

    # Start monitoring processes
    Monitor-Processes
}

# Invoke the script block on the remote machine
Invoke-Command -Session $session -ScriptBlock $scriptBlock

# Clean up the session
Remove-PSSession $session
