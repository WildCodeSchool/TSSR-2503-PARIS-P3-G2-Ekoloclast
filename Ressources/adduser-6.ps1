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





$OutputEncoding = [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

$csvPath = "C:\Users\Administrator\Downloads\S06_Ekoloclast.csv"
$logPath = "C:\Users\Administrator\Downloads\log_utilisateurs.txt"
$ou = "OU=Utilisateurs,DC=ekoloclast,DC=local"

function Test-ADAttributeExists {
    param([string]$AttributeName)
    try {
        $userSample = Get-ADUser -Filter * -Properties $AttributeName -ResultSetSize 1 -ErrorAction Stop
        return $userSample.PSObject.Properties.Name -contains $AttributeName
    }
    catch {
        return $false
    }
}

function Escape-ADFilterString {
    param([string]$str)
    if (-not $str) { return $str }
    return $str -replace "'", "''"
}

function Clean-Value {
    param([string]$val)
    if ([string]::IsNullOrWhiteSpace($val)) { return $null }
    return $val.Trim()
}

# Vérifie l'OU
if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$ou'")) {
    Write-Host "Erreur : OU introuvable." -ForegroundColor Red
    exit
}

try {
    $users = Import-Csv -Path $csvPath -Delimiter "," -Encoding UTF8
} catch {
    Write-Host "Erreur import CSV" -ForegroundColor Red
    exit
}

# Désactivation manuelle de Lana Wong si elle existe
$lana = Get-ADUser -Filter "GivenName -eq 'Lana' -and Surname -eq 'Wong'" -ErrorAction SilentlyContinue
if ($lana) {
    if ($lana.Enabled) {
        Disable-ADAccount -Identity $lana.DistinguishedName
        Write-Host "⛔ Lana Wong désactivée (départ manuel)" -ForegroundColor Yellow
        Add-Content $logPath "Désactivé (manuel) : Lana Wong"
    } else {
        Write-Host "ℹ️ Lana Wong est déjà désactivée." -ForegroundColor Gray
    }
} else {
    Write-Host "⚠️ Lana Wong introuvable dans l'AD." -ForegroundColor DarkYellow
}

foreach ($user in $users) {
    if ([string]::IsNullOrWhiteSpace($user.Prenom) -or [string]::IsNullOrWhiteSpace($user.Nom)) {
        Write-Host "❌ Ignoré : Prénom ou nom vide" -ForegroundColor Red
        Add-Content $logPath "Ignoré : $($user.Prenom) $($user.Nom)"
        continue
    }

    $prenomEscaped = Escape-ADFilterString $user.Prenom
    $nomEscaped = Escape-ADFilterString $user.Nom
    $nomComplet = "$($user.Prenom) $($user.Nom)"

    $utilisateurAD = Get-ADUser -Filter "GivenName -eq '$prenomEscaped' -and Surname -eq '$nomEscaped'" -Properties *

    $managerDN = $null
    if ($user.'Manager-Prenom' -and $user.'Manager-Nom') {
        $mgrPrenomEscaped = Escape-ADFilterString $user.'Manager-Prenom'
        $mgrNomEscaped = Escape-ADFilterString $user.'Manager-Nom'
        $manager = Get-ADUser -Filter "GivenName -eq '$mgrPrenomEscaped' -and Surname -eq '$mgrNomEscaped'" -Properties DistinguishedName -ErrorAction SilentlyContinue
        if ($manager) { $managerDN = $manager.DistinguishedName }
    }

    # Nettoyage des variables
    $company     = Clean-Value ($user.Societe     -replace '[^\u0020-\u007E]', '')
    $department  = Clean-Value ($user.Departement -replace '[^\u0020-\u007E]', '')
    $title       = Clean-Value ($user.fonction    -replace '[^\u0020-\u007E]', '')
    $office      = Clean-Value ($user.Site        -replace '[^\u0020-\u007E]', '')
    $description = Clean-Value ($user.Service     -replace '[^\u0020-\u007E]', '')
    $civilite    = Clean-Value ($user.Civilité    -replace '[^\u0020-\u007E]', '')
    $fixe        = Clean-Value $user.'Telephone fixe'
    $mobile      = Clean-Value $user.'Telephone portable'
    $dob         = Clean-Value $user.'Date de naissance'
    $pcName      = Clean-Value $user.'Nom de PC'
    $pcBrand     = Clean-Value $user.'Marque PC'

    if ($user.Etat -eq "Départ") {
        if ($utilisateurAD) {
            try {
                Disable-ADAccount -Identity $utilisateurAD.DistinguishedName
                Write-Host "⛔ $nomComplet désactivé (Départ)" -ForegroundColor Yellow
                Add-Content $logPath "Désactivé : $nomComplet"
            }
            catch {
                Write-Warning "⚠️ Impossible de désactiver $nomComplet : $_"
            }
        }
        continue
    }

    if ($utilisateurAD) {
        Write-Host "🔄 Mise à jour de : $nomComplet"

        try {
            Set-ADUser -Identity $utilisateurAD.DistinguishedName `
                -Company $company `
                -Department $department `
                -Title $title `
                -Office $office `
                -Description $description `
                -OfficePhone $fixe `
                -MobilePhone $mobile
        }
        catch {
            Write-Warning "⚠️ Erreur Set-ADUser basique pour $nomComplet : $_"
        }

        # Préparation des attributs étendus uniquement s'ils existent et ont une valeur
        $replaceHash = @{}
        if (Test-ADAttributeExists 'extensionAttribute1' -and $dob) { $replaceHash['extensionAttribute1'] = $dob }
        if (Test-ADAttributeExists 'extensionAttribute2' -and $civilite) { $replaceHash['extensionAttribute2'] = $civilite }
        if (Test-ADAttributeExists 'extensionAttribute3' -and $pcName) { $replaceHash['extensionAttribute3'] = $pcName }
        if (Test-ADAttributeExists 'extensionAttribute4' -and $pcBrand) { $replaceHash['extensionAttribute4'] = $pcBrand }
        if ($replaceHash.Count -gt 0) {
            try {
                Set-ADUser -Identity $utilisateurAD.DistinguishedName -Replace $replaceHash
            }
            catch {
                Write-Warning "⚠️ Impossible de mettre à jour les attributs étendus de $nomComplet : $_"
            }
        }

        if ($managerDN) {
            try {
                Set-ADUser -Identity $utilisateurAD.DistinguishedName -Manager $managerDN
            }
            catch {
                Write-Warning "⚠️ Impossible de mettre à jour le manager de $nomComplet : $_"
            }
        }

        $newDisplay = "$($user.Prenom) $($user.Nom)"
        if ($utilisateurAD.DisplayName -ne $newDisplay) {
            try {
                Set-ADUser -Identity $utilisateurAD.DistinguishedName `
                    -GivenName $user.Prenom `
                    -Surname $user.Nom `
                    -DisplayName $newDisplay

                Rename-ADObject -Identity $utilisateurAD.DistinguishedName -NewName $newDisplay
            }
            catch {
                Write-Warning "⚠️ Impossible de renommer ou mettre à jour le displayname de $nomComplet : $_"
            }
        }

        Add-Content $logPath "Mis à jour : $nomComplet"
        continue
    }

    # Création nouvel utilisateur
    $baseSam = (($user.Prenom.Substring(0,1) + $user.Nom).ToLower() -replace '[^a-z0-9]', '')
    $samAccountName = $baseSam
    $suffix = 1
    while (Get-ADUser -Filter "SamAccountName -eq '$samAccountName'" -ErrorAction SilentlyContinue) {
        $samAccountName = "$baseSam$suffix"
        $suffix++
    }
    $samAccountName = $samAccountName.Substring(0, [Math]::Min(20, $samAccountName.Length))
    $password = ConvertTo-SecureString "Azerty123!" -AsPlainText -Force

    Write-Host "➕ Création : $nomComplet ($samAccountName)" -ForegroundColor Cyan

    try {
        New-ADUser `
            -SamAccountName $samAccountName `
            -Name $nomComplet `
            -GivenName $user.Prenom `
            -Surname $user.Nom `
            -DisplayName $nomComplet `
            -UserPrincipalName "$samAccountName@ekoloclast.local" `
            -EmailAddress "$samAccountName@ekoloclast.local" `
            -AccountPassword $password `
            -Enabled $true `
            -ChangePasswordAtLogon $true `
            -Path $ou `
            -Company $company `
            -Department $department `
            -Title $title `
            -Office $office `
            -Description $description `
            -OfficePhone $fixe `
            -MobilePhone $mobile | Out-Null
    }
    catch {
        Write-Warning "⚠️ Erreur création utilisateur $nomComplet : $_"
        continue
    }

    # Mise à jour des attributs étendus après création si existants et non nuls
    $replaceHash = @{}
    if (Test-ADAttributeExists 'extensionAttribute1' -and $dob) { $replaceHash['extensionAttribute1'] = $dob }
    if (Test-ADAttributeExists 'extensionAttribute2' -and $civilite) { $replaceHash['extensionAttribute2'] = $civilite }
    if (Test-ADAttributeExists 'extensionAttribute3' -and $pcName) { $replaceHash['extensionAttribute3'] = $pcName }
    if (Test-ADAttributeExists 'extensionAttribute4' -and $pcBrand) { $replaceHash['extensionAttribute4'] = $pcBrand }
    if ($replaceHash.Count -gt 0) {
        try {
            Set-ADUser -Identity $samAccountName -Replace $replaceHash
        }
        catch {
            Write-Warning "⚠️ Impossible de mettre à jour les attributs étendus de $nomComplet (création) : $_"
        }
    }

    if ($managerDN) {
        try {
            Set-ADUser -Identity $samAccountName -Manager $managerDN
        }
        catch {
            Write-Warning "⚠️ Impossible de définir le manager de $nomComplet (création) : $_"
        }
    }

    Add-Content $logPath "Créé : $nomComplet"
}

Write-Host "Traitement terminé."
