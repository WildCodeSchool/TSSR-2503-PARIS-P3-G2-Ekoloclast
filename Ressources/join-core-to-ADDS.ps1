$DomainName = "ekoloclast.local"
$DomainUser = "ekoloclast\Administrator"    # compte admin du domaine
$DomainPassword = "Azerty1*"            # mot de passe du compte admin (en clair ici, pour test uniquement)
$NewComputerName = "SRV-CORE"

# Convertir le mot de passe en SecureString
$SecurePassword = ConvertTo-SecureString $DomainPassword -AsPlainText -Force

# Créer les credentials
$Cred = New-Object System.Management.Automation.PSCredential($DomainUser, $SecurePassword)

# Changer le nom de l'ordinateur
Rename-Computer -NewName $NewComputerName -Force -Restart:$false

# Joindre le domaine AD
Add-Computer -DomainName $DomainName -Credential $Cred -Restart:$true
