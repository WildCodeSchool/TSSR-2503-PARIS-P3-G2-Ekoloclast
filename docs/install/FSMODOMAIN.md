# Guide d'installation de la VM G2-WinServ-FSMODOMAIN

## Description
- **Nom GUI Proxmox :** G2-WinServ-FSMODOMAIN  
- **Nom machine :** FSMO-PDC  
- **Type :** VM Windows Server – FSMO Domain Naming Master  
- **Fonction :** Contrôleur de domaine avec rôle FSMO Domain Naming Master  

---

## Prérequis
- Serveur Proxmox opérationnel  
- ISO Windows Server (version compatible avec l’ADDS) disponible  
- Licence Windows Server valide  
- Réseau configuré et accessible  
- Accès console Proxmox  

---

## Étapes d'installation

### 1. Création de la VM dans Proxmox
- Connectez-vous à l’interface Proxmox.  
- Créez une nouvelle VM avec les paramètres suivants :  
  - **Nom :** G2-WinServ-FSMODOMAIN  
  - **VM ID :** libre (ex. 210)  
  - **ISO :** Windows Server (2016/2019/2022 selon l’environnement)  
  - **Disque :** au moins 60 Go recommandé  
  - **RAM :** 8 Go minimum  
  - **CPU :** 2 vCPU minimum  
  - **Réseau :** connectée au VLAN du domaine Active Directory  

### 2. Installation de Windows Server
- Démarrez la VM et lancez l’installation via la console Proxmox.  
- Suivez les étapes classiques d’installation de Windows Server.  
- Créez un compte administrateur local.  

### 3. Configuration Active Directory Domain Services (ADDS)
- Ouvrez le **Gestionnaire de serveur** → **Ajouter des rôles et fonctionnalités**.  
- Sélectionnez **Services de domaine Active Directory (AD DS)**, puis installez.  
- Une fois installé, lancez la promotion du serveur en **contrôleur de domaine**.  
- Configurez ce contrôleur comme contrôleur principal (PDC) pour le domaine existant ou nouveau domaine.  

### 4. Attribution du rôle FSMO Domain Naming Master
- Si le domaine est déjà existant, déplacez le rôle FSMO Domain Naming Master vers cette VM :  
  - Ouvrez une console PowerShell avec droits administrateur.  
  - Lancez `netdom query fsmo` pour vérifier l’emplacement actuel des rôles FSMO.  
  - Pour transférer le rôle Domain Naming Master :  
    ```
    ntdsutil
    roles
    connections
    connect to server FSMO-PDC
    quit
    transfer domain naming master
    quit
    quit
    ```
- Confirmez la réussite du transfert.  

### 5. Vérifications et tests
- Vérifiez la réplication AD entre les contrôleurs.  
- Confirmez que le rôle FSMO Domain Naming Master est bien attribué à cette VM.  
- Testez l’ajout de nouveaux domaines ou objets dans l’AD.  

---

## Documentation liée
- [Doc install FSMO Domain Naming Master](../docs/install/FSMODOMAIN.md)  
- [Doc usage FSMO Domain Naming Master](../docs/usage/FSMODOMAIN.md) (en cours de rédaction)  

---

## Support & dépannage
- En cas de problème avec le rôle FSMO, vérifier la connectivité réseau entre DCs.  
- Consulter les logs AD et événements Windows.  
- Vérifier la santé de la réplication avec `repadmin /replsummary`.  

---
