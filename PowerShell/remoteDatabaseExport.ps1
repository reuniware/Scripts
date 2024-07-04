# Définir les variables
$serverInstance = "serverName"
$databaseName = "databaseName"
$backupFilePath = "\\MachineName\c$\Users\UserName\source\repos\MyApp\Server\Web\WebHost\dbbackup.bak"
$username = "UserName"
$password = ConvertTo-SecureString "PassWord" -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential($username, $password)

Install-Module -Name SQLPS -AllowClobber

# Exécuter la commande sur l'ordinateur distant
Invoke-Command -ComputerName "MachineName" -Credential $credential -ScriptBlock {
    param($serverInstance, $databaseName, $backupFilePath)

    # Importer le module SQL Server
    Import-Module SQLPS -DisableNameChecking

    # Exécuter la commande d'exportation
    Backup-SqlDatabase -ServerInstance $serverInstance -Database $databaseName -BackupFile $backupFilePath
} -ArgumentList $serverInstance, $databaseName, $backupFilePath
