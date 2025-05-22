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
