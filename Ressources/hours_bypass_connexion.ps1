Autoriser 7h à 18h (heure locale), du lundi au vendredi
$users = Get-ADUser -Filter * -SearchBase "OU=LabUtilisateurs,DC=ekoloclast,DC=local"
foreach ($user in $users) {
    if (-not (Get-ADGroupMember "Groupe_Bypass_Connexion" | Where-Object {$_.distinguishedName -eq $user.DistinguishedName})) {
        Set-ADUser $user -LogonHours (New-LogonHours "Monday-Friday" 7 18)
    }
}
