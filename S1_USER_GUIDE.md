# Guide de l'Utilisateur - Projet Ekoloclast

## Utilisation de Base

### Accès au Réseau
Les utilisateurs peuvent se connecter au réseau via le VLAN qui leur est assigné (par exemple, le VLAN RH pour les utilisateurs RH).

### Services Disponibles
- **Active Directory** : Utilisez votre identifiant pour vous connecter aux machines et accéder aux ressources partagées.
- **Serveur de fichiers** : Accédez aux documents partagés via le réseau local.

## Utilisation Avancée

### Gestion des VLANs
Les administrateurs réseau peuvent gérer les VLANs via le switch administrable.


### Configuration de GLPI

Nom	ADEko
Serveur	srv-adds.ekoloclast.local
Port	389
DN du compte (Bind)	CN=Administrator,CN=Users,DC=ekoloclast,DC=local
Mot de passe	X
BaseDN	DC=ekoloclast,DC=local
Filtre de connexion	(sAMAccountName=%u)
Champ de l'identifiant	sAMAccountName
Champ de synchro	displayName
Utiliser le bind	✅ Oui

## FAQ

### Problèmes connus liés à l'utilisation

- **Problèmes de connexion à GitLab** : Vérifiez les permissions d'accès et l'état des services GitLab.
- **Accès limité aux fichiers partagés** : Assurez-vous que vous êtes connecté au bon VLAN et que les permissions de fichiers sont correctement configurées.

