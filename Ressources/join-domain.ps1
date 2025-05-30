# Chargement du fichier de configuration
$config = Get-Content -Raw -Path "C:\join-domain.json" | ConvertFrom-Json

# Renommer le serveur
Rename-Computer -NewName $config.ComputerName -Force -Restart:$false

# Configurer l'adresse IP statique (suppose une seule carte réseau active)
$ifIndex = (Get-NetAdapter | Where-Object { $_.Status -eq "Up" }).ifIndex

New-NetIPAddress -InterfaceIndex $ifIndex `
    -IPAddress $config.IPAddress `
    -PrefixLength $config.PrefixLength `
    -DefaultGateway $config.Gateway

Set-DnsClientServerAddress -InterfaceIndex $ifIndex `
    -ServerAddresses $config.DNSServer

# Installation du rôle AD-DS
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Stockage du mot de passe du domaine
$SecurePassword = ConvertTo-SecureString $config.DomainPassword -AsPlainText -Force
$DomainCred = New-Object System.Management.Automation.PSCredential ("$($config.DomainName)\$($config.DomainUser)", $SecurePassword)

# Rejoindre le domaine
Add-Computer -DomainName $config.DomainName -Credential $DomainCred -Restart

