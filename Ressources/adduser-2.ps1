$OutputEncoding = [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

$csvPath = "C:\Users\Administrator\Downloads\S06_Ekoloclast_old.csv"
$logPath = "C:\Users\Administrator\Downloads\log_utilisateurs.txt"
$ou = "OU=Utilisateurs,DC=ekoloclast,DC=local"

# Vérifie si l'OU existe
if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$ou'")) {
    Write-Host "Erreur : L'OU $ou est introuvable dans l'AD." -ForegroundColor Red
    exit
}

try {
    $users = Import-Csv -Path $csvPath -Delimiter "," -Encoding Default  # UTF8 avec BOM depuis Excel = Default
} catch {
    Write-Host "Erreur : échec de l'import du CSV." -ForegroundColor Red
    exit
}

# Pour éviter doublons de SamAccountName
$samAccountNameSet = @{}

foreach ($user in $users) {
    if ([string]::IsNullOrWhiteSpace($user.Prenom) -or [string]::IsNullOrWhiteSpace($user.Nom)) {
        Write-Host "Ligne ignorée : prénom ou nom manquant." -ForegroundColor Red
        Add-Content $logPath "Ligne ignorée : prénom ou nom manquant."
        continue
    }

    try {
        $baseSam = (($user.Prenom.Substring(0,1) + $user.Nom).ToLower() -replace '[^a-z0-9]', '')
        $samAccountName = $baseSam
        $suffix = 1
        while ($samAccountNameSet.ContainsKey($samAccountName) -or (Get-ADUser -Filter "SamAccountName -eq '$samAccountName'" -ErrorAction SilentlyContinue)) {
            $samAccountName = "$baseSam$suffix"
            $suffix++
        }
        # Tronque à 20 caractères max
        $samAccountName = $samAccountName.Substring(0, [Math]::Min(20, $samAccountName.Length))
        $samAccountNameSet[$samAccountName] = $true
    } catch {
        Write-Host "Erreur lors de la génération du login pour $($user.Prenom) $($user.Nom)" -ForegroundColor Red
        Add-Content $logPath "Erreur SAM : $($user.Prenom) $($user.Nom)"
        continue
    }

    $nomComplet = "$($user.Prenom) $($user.Nom)"
    $password = ConvertTo-SecureString "Azerty123!" -AsPlainText -Force  # Mot de passe plus complexe

   # Nettoyage des champs optionnels
$company     = ($user.Societe     -replace '[^\u0020-\u007E]', '')
$department  = ($user.Departement -replace '[^\u0020-\u007E]', '')
$title       = ($user.fonction    -replace '[^\u0020-\u007E]', '')
$office      = ($user.Site        -replace '[^\u0020-\u007E]', '')
$description = ($user.Service     -replace '[^\u0020-\u007E]', '')

if (-not $company)     { $company = "" }
if (-not $department)  { $department = "" }
if (-not $title)       { $title = "" }
if (-not $office)      { $office = "" }
if (-not $description) { $description = "" }

    try {
        Write-Host "Création de : $nomComplet (login : $samAccountName)..."

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
            -CannotChangePassword $false `
            -PasswordNeverExpires $false `
            -Path $ou `
            -Company $company `
            -Department $department `
            -Title $title `
            -Office $office `
            -Description $description `
            -PassThru | Out-Null

        Write-Host "✅ Utilisateur $nomComplet créé (login : $samAccountName)" -ForegroundColor Green
        Add-Content $logPath "Créé : $nomComplet ($samAccountName)"
    } catch {
        Write-Host "❌ Erreur création $nomComplet : $_" -ForegroundColor Red
        Add-Content $logPath "Erreur création $nomComplet : $_"
    }
}
