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



# Script PowerShell : Création des OU et des groupes dans Active Directory

# Liste des OU principales
$OUList = @(
    "OU=Ordinateurs,DC=mondomaine,DC=local",
    "OU=Clients,OU=Ordinateurs,DC=mondomaine,DC=local",
    "OU=Serveurs,OU=Ordinateurs,DC=mondomaine,DC=local",
    "OU=Utilisateurs,DC=mondomaine,DC=local",
    "OU=GRP-DEP-DG,OU=Utilisateurs,DC=mondomaine,DC=local",
    "OU=GRP-DEP-RH,OU=Utilisateurs,DC=mondomaine,DC=local",
    "OU=GRP-DEP-FIN,OU=Utilisateurs,DC=mondomaine,DC=local",
    "OU=GRP-DEP-COM,OU=Utilisateurs,DC=mondomaine,DC=local",
    "OU=GRP-DEP-VENTE,OU=Utilisateurs,DC=mondomaine,DC=local",
    "OU=GRP-DEP-MARKETING,OU=Utilisateurs,DC=mondomaine,DC=local",
    "OU=GRP-DEP-JUR,OU=Utilisateurs,DC=mondomaine,DC=local",
    "OU=GRP-DEP-SG,OU=Utilisateurs,DC=mondomaine,DC=local",
    "OU=GRP-DEP-DSI,OU=Utilisateurs,DC=mondomaine,DC=local",
    "OU=GRP-DEP-R&D,OU=Utilisateurs,DC=mondomaine,DC=local"
)

# Création des OU
foreach ($OU in $OUList) {
    if (-not (Get-ADOrganizationalUnit -LDAPFilter "(distinguishedName=$OU)" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name ($OU -split ",")[0].Replace("OU=", "") -Path ($OU -replace "^OU=[^,]+,", "") -ProtectedFromAccidentalDeletion $false
        Write-Host "OU créée : $OU" -ForegroundColor Green
    } else {
        Write-Host "OU déjà existante : $OU" -ForegroundColor Yellow
    }
}

# Liste des groupes
$Groupes = @(
    "GRP-DEP-DG",
    "GRP-DEP-RH",
    "GRP-DEP-FIN",
    "GRP-DEP-COM",
    "GRP-DEP-VENTE",
    "GRP-DEP-MARKETING",
    "GRP-DEP-JUR",
    "GRP-DEP-SG",
    "GRP-DEP-DSI",
    "GRP-DEP-R&D"
)

foreach ($grp in $Groupes) {
    $groupName = $grp
    $ouPath = "OU=$grp,OU=Utilisateurs,DC=mondomaine,DC=local"
    if (-not (Get-ADGroup -Filter { Name -eq $groupName } -SearchBase $ouPath -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $groupName -GroupScope Global -GroupCategory Security -Path $ouPath
        Write-Host "Groupe créé : $groupName" -ForegroundColor Cyan
    } else {
        Write-Host "Groupe déjà existant : $groupName" -ForegroundColor Yellow
    }
}
