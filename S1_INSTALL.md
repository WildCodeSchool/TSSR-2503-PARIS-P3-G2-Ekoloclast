# Guide d'Installation - Projet Ekoloclast

## Prérequis Techniques

Avant de commencer l'installation, assurez-vous de disposer des éléments suivants :
- **Matériel réseau** : routeur, switch administrable, box FAI.
- **Serveurs et machines virtuelles** : pour héberger les services comme Active Directory, DNS, etc.
- **Logiciels nécessaires** : hyperviseur, systèmes d'exploitation pour les machines virtuelles.

## Étapes d'Installation et Configuration

### Étape 1 : Configuration du Réseau

1. **Définir les VLANs** : Créez les VLANs sur le switch selon le plan d'adressage.
2. **Attribuer les adresses IP** : Configurez les adresses IP sur les équipements réseau.

### Étape 2 : Création et Configuration des Machines Virtuelles

1. **Créer les VM** pour chaque serveur (AD, DNS, GitLab, etc.).
2. **Installer les systèmes d'exploitation** sur chaque machine virtuelle.
3. **Configurer les rôles et services** sur les serveurs (AD, DNS, DHCP, etc.).

Exemple de procédure à suivre sur chaque serveur:
``` bash
Rename-Computer -NewName "SRV-FICHIERS" -Restart
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.9.13 -PrefixLength 24 -DefaultGateway 192.168.9.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 192.168.9.10
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
Restart-Computer```

### Étape 3 : Déploiement des Services

1. **Active Directory et DNS** : Configurez le contrôleur de domaine, les serveurs DNS et DHCP.
2. **Serveurs Fichiers et GitLab** : Configurez les serveurs de fichiers et GitLab pour le développement.
3. **Serveur RH/Finance** : Déployez les applications sensibles sur ce serveur.

### Étape 4 : Vérification

Vérifiez que les VLANs sont correctement configurés et que les services sont accessibles.

## FAQ

### Problèmes connus lors de l'installation

- **Problème de communication entre VLANs** : Assurez-vous que les VLANs sont correctement configurés sur le switch et que le routage inter-VLAN est activé sur le routeur.
- **Problème de DHCP** : Vérifiez que les plages DHCP ne se chevauchent pas avec les adresses statiques réservées.

