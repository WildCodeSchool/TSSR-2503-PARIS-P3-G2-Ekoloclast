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
