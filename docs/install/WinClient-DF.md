# Guide d'installation de la VM G2-WinClient-DF

## Description
- **Nom GUI Proxmox :** G2-WinClient-DF  
- **Nom machine :** WinClient-DF  
- **Type :** VM poste client Windows 10 pour la direction financière  
- **Fonction :** Poste utilisateur standard, accès aux ressources internes et services réseau.

---

## Prérequis
- Serveur Proxmox opérationnel avec ressources disponibles (CPU, RAM, stockage)
- ISO Windows 10 disponible sur le stockage Proxmox
- Réseau configuré (VLAN ou bridge selon architecture)
- Licence Windows valide

---

## Étapes d'installation

### 1. Création de la VM dans Proxmox
- Connectez-vous à l’interface web Proxmox.
- Cliquez sur **Créer VM**.
- Paramétrez la VM :
  - **Node :** sélectionner le serveur Proxmox approprié.
  - **VM ID :** 197 (ou ID libre disponible)
  - **Nom :** G2-WinClient-DF
- Choisissez l’ISO Windows 10 dans le stockage.
- Configurez le disque dur (minimum 60 Go recommandé).
- Allouez la RAM (8 Go recommandé).
- Configurez les CPUs (2 vCPUs recommandé).
- Configurez la carte réseau dans le VLAN dédié à la direction financière ou sur le bridge réseau correspondant.

### 2. Installation de Windows 10
- Démarrez la VM et connectez-vous à la console via Proxmox.
- Suivez la procédure standard d’installation Windows 10.
- Entrez la clé de licence lors de l’installation.
- Configurez le nom de la machine : `WinClient-DF`.
- Connectez la machine au domaine Active Directory (ex : ekoloclast.local).
- Appliquez les stratégies de groupe spécifiques à la direction financière.

### 3. Configuration post-installation
- Installez les mises à jour Windows.
- Installez les logiciels métiers nécessaires (ERP, suite bureautique, antivirus).
- Configurez les accès aux partages réseau et imprimantes.
- Vérifiez l’accès Internet et VPN si nécessaire.
- Effectuez un test utilisateur pour validation.

---

## Documentation liée
- [Documentation d'installation complète](../docs/install/WinClient-DF.md)  
- [Documentation d'utilisation](../docs/usage/WinClient-DF.md)

---

## Support & dépannage
- En cas de problème, consulter la documentation technique du serveur Proxmox.
- Vérifier les logs Windows dans l’Observateur d’événements.
- Contacter l’équipe support réseau pour les problèmes de connectivité.

---

*Fin du guide d’installation pour G2-WinClient-DF*
