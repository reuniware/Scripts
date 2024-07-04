#générer un fichier avec un mot de passe pour utilisation dans powershell
#Read-Host -AsSecureString | ConvertFrom-SecureString | Out-File C:\tmp\pspwd.txt

$scriptBlock = {
	shutdown /r /t 0
}

$securePassword = Get-Content 'C:\tmp\pspwd.txt' | ConvertTo-SecureString
$credential = New-Object System.Management.Automation.PSCredential("username", $securePassword)

#Invoke-Command -ComputerName NomDeLaMachine -ScriptBlock { tracert google.fr } -Credential username

Invoke-Command -ComputerName NomDeLaMachine -ScriptBlock $scriptBlock -Credential $credential
