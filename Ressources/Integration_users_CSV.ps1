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

try {
    
        # Intégration des utilisateurs selon le fichier CSV
        
        $csvPath = "C:\Scripts\utilisateurs.csv"
        $users = Import-Csv -Path $csvPath
        
        foreach ($user in $users) {
            $OU = "OU=GRP-DEP-$($user.Département),OU=Utilisateurs,DC=mondomaine,DC=local"
            $UPN = "$($user.Identifiant)@mondomaine.local"
            $samAccountName = $user.Identifiant
        
            if (-not (Get-ADUser -Filter { SamAccountName -eq $samAccountName } -ErrorAction SilentlyContinue)) {
                New-ADUser `
                    -Name "$($user.Prénom) $($user.Nom)" `
                    -GivenName $user.Prénom `
                    -Surname $user.Nom `
                    -SamAccountName $samAccountName `
                    -UserPrincipalName $UPN `
                    -Path $OU `
                    -AccountPassword (ConvertTo-SecureString $user.MotDePasse -AsPlainText -Force) `
                    -Enabled $true
                Add-ADGroupMember -Identity "GRP-DEP-$($user.Département)" -Members $samAccountName
                Write-Host "Utilisateur $samAccountName créé et ajouté au groupe." -ForegroundColor Green
            } else {
                Write-Host "Utilisateur $samAccountName déjà existant." -ForegroundColor Yellow
            }
        }
        
            Write-EventLog -LogName $EventLogName -Source $EventSource -EntryType Information -EventId 110 -Message "Succès"
        }
catch {
    Write-Log "Erreur lors de la création de l'utilisateur : $_" -Level "ERROR"
    Write-EventLog -LogName $EventLogName -Source $EventSource -EntryType Error -EventId 500 -Message "Erreur : $_"
}





# ===========================
# 🚩 Fin du script
# ===========================

Write-Log "Fin du script"
Write-EventLog -LogName $EventLogName -Source $EventSource -EntryType Information -EventId 200 -Message "Script terminé avec succès"


