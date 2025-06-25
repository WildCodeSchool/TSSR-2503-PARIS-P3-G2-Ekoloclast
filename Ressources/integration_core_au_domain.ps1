$Domain = "ekoloclast.local"
$OU = "OU=SERVEURS,DC=ekoloclast,DC=local"
$User = "ekoloclast\Administrator"
$Password = ConvertTo-SecureString "Azerty1*" -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($User, $Password)

# Joindre au domaine
Add-Computer -DomainName $Domain -Credential $Credential -OUPath $OU -Restart
