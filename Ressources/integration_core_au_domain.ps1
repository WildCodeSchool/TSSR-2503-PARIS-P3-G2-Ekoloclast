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

        $Domain = "ekoloclast.local"
        $OU = "OU=SERVEURS,DC=ekoloclast,DC=local"
        $User = "ekoloclast\Administrator"
        $Password = ConvertTo-SecureString "Azerty1*" -AsPlainText -Force
        $Credential = New-Object System.Management.Automation.PSCredential ($User, $Password)
        
        # Joindre au domaine
        Add-Computer -DomainName $Domain -Credential $Credential -OUPath $OU -Restart
        
        
        
        
            Write-EventLog -LogName $EventLogName -Source $EventSource -EntryType Information -EventId 110 -Message "succès"
}
catch {
    Write-Log "Erreur : $_" -Level "ERROR"
    Write-EventLog -LogName $EventLogName -Source $EventSource -EntryType Error -EventId 500 -Message "Erreur : $_"
}


