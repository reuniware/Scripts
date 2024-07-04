# Définir la cible du système distant
$computerName = "MachineName"

# Créer un objet PSCredential avec les informations d'identification
$username = "username"
$password = "password" | ConvertTo-SecureString -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

# Utiliser la commande Invoke-Command pour exécuter la commande sur le système distant
$users = Invoke-Command -ComputerName $computerName -Credential $credential -ScriptBlock { Get-WmiObject -Class Win32_ComputerSystem | Select-Object -Property UserName }

# Afficher les utilisateurs connectés
$users
