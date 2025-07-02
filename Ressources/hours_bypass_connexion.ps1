# =============================================
# 🔥 Bloc de journalisation universel PowerShell
# =============================================

# 📁 Répertoire des logs fichier
$LogFolder = "C:\Logs\PowerShell"
if (-not (Test-Path $LogFolder)) {
    New-Item -Path $LogFolder -ItemType Directory | Out-Null
}

# 🔧 Variables dynamiques
$ScriptName = ($MyInvocation.MyCommand.Name).Split('.')[0]
$Date = Get-Date -Format "yyyyMMdd"
$LogFile = "$LogFolder\$ScriptName-$Date.log"

# 📑 Nom du journal EventLog et de la source (par script)
$EventLogName = "PSLogs-$ScriptName"
$EventSource = "$ScriptName"

# 📜 Fonction d’écriture dans le fichier log
Function Write-Log {
    param(
        [string]$Message,
        [string]$Level = "INFO"
    )
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Entry = "$Timestamp [$Level] - $Message"
    Add-Content -Path $LogFile -Value $Entry
    Write-Output $Entry
}

# 🏛️ Création du journal EventLog si inexistant
if (-not [System.Diagnostics.EventLog]::SourceExists($EventSource)) {
    New-EventLog -LogName $EventLogName -Source $EventSource
    Write-Log "Création du journal EventLog $EventLogName avec la source $EventSource"
}

# 🚩 Début du script
Write-Log "Début du script"
Write-EventLog -LogName $EventLogName -Source $EventSource -EntryType Information -EventId 100 -Message "Script démarré"

# ===========================
# 🔧 Zone des actions du script
# ===========================

Write-Log "Exemple : création d’un utilisateur AD JohnDoe"

try {
    # Exemple de commande
    # New-ADUser -Name "JohnDoe" -GivenName "John" -Surname "Doe" -SamAccountName "JohnDoe" -AccountPassword (ConvertTo-SecureString "Password123!" -AsPlainText -Force) -Enabled $true

    Write-Log "Création de l'utilisateur JohnDoe effectuée avec succès"
    Write-EventLog -LogName $EventLogName -Source $EventSource -EntryType Information -EventId 110 -Message "Utilisateur JohnDoe créé avec succès"
}
catch {
    Write-Log "Erreur lors de la création de l'utilisateur : $_" -Level "ERROR"
    Write-EventLog -LogName $EventLogName -Source $EventSource -EntryType Error -EventId 500 -Message "Erreur : $_"
}





Autoriser 7h à 18h (heure locale), du lundi au vendredi, bypass cette règle pour les administrateurs
$users = Get-ADUser -Filter * -SearchBase "OU=LabUtilisateurs,DC=ekoloclast,DC=local"
foreach ($user in $users) {
    if (-not (Get-ADGroupMember "Groupe_Bypass_Connexion" | Where-Object {$_.distinguishedName -eq $user.DistinguishedName})) {
        Set-ADUser $user -LogonHours (New-LogonHours "Monday-Friday" 7 18)
    }
}
