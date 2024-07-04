

$startIP = "192.168.1.1"
$endIP = "192.168.1.254"

$scriptBlock = {
    param($startIP, $endIP)

    for ($i = [int]$startIP.Split(".")[3]; $i -le [int]$endIP.Split(".")[3]; $i++) {
        $ip = "$($startIP.Split(".")[0]).$($startIP.Split(".")[1]).$($startIP.Split(".")[2]).$i"
        if (Test-Connection -ComputerName $ip -Count 1 -Quiet) {
            Write-Output "$ip is reachable"
        } else {
            Write-Output "$ip is not reachable"
        }
    }
}

#Invoke-Command -ComputerName MachineName -ScriptBlock { tracert google.fr } -Credential UserName

Invoke-Command -ComputerName MachineName -ScriptBlock $scriptBlock -ArgumentList $startIP, $endIP -Credential UserName
