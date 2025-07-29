# Guide d'usage de la VM G2-WinServ-FSMO-INFRASTRUCTURE

## Description
- **Nom GUI Proxmox :** G2-WinServ-FSMO-INFRASTRUCTURE  
- **Nom machine :** FSMO-INFRASTRUCTURE  
- **Type :** VM Windows Server – Contrôleur FSMO pour le rôle Infrastructure Master  
- **Fonction :** Gestion du rôle FSMO Infrastructure Master dans l’Active Directory.

---

## Accès à la machine
- Connexion via console Proxmox ou RDP avec un compte administrateur AD disposant des droits FSMO.  
- Ouvrir une session avec droits administrateur.

---

## Utilisation courante

### 1. Rôle Infrastructure Master
- Ce serveur détient le rôle Infrastructure Master, responsable de la mise à jour des références d’objets inter-domaines dans AD.  
- Important dans les environnements multi-domaines pour maintenir la cohérence des objets liés.  

### 2. Vérification du rôle FSMO
- Pour vérifier la localisation des rôles FSMO, utiliser :  
  ```powershell
  netdom query fsmo
