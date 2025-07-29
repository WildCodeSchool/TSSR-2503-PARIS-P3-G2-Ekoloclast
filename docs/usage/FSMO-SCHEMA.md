# Guide d'usage de la VM G2-WinServ-FSMO-SCHEMA

## Description
- **Nom GUI Proxmox :** G2-WinServ-FSMO-SCHEMA  
- **Nom machine :** FSMO-PDC  
- **Type :** VM Windows Server – Contrôleur FSMO pour le rôle Schema Master  
- **Fonction :** Gérer le rôle FSMO Schema Master dans l'infrastructure Active Directory.

---

## Accès à la machine
- Connexion via console Proxmox ou RDP avec un compte administrateur AD disposant des droits FSMO.  
- Privilégier une session avec droits élevés (exécuter en tant qu'administrateur).

---

## Utilisation courante

### 1. Gestion du rôle FSMO Schema Master
- Ce serveur détient le rôle Schema Master qui contrôle les modifications du schéma AD.  
- Avant de modifier le schéma, s’assurer que toutes les sauvegardes sont à jour.  
- Les modifications du schéma AD sont rares et doivent être planifiées (ex : extensions pour applications tierces).  

### 2. Consultation et transfert des rôles FSMO
- Vérifier les rôles FSMO sur ce serveur via la commande PowerShell ou la console :  
  ```powershell
  netdom query fsmo
