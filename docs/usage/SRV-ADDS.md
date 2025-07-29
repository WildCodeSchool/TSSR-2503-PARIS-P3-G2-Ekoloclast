# Guide d'usage de la VM G2-WinServ-SRV-ADDS

## Description
- **Nom GUI Proxmox :** G2-WinServ-SRV-ADDS  
- **Nom machine :** SERV-ADDS  
- **Type :** VM Windows Server – Contrôleur de domaine AD et DNS  
- **Fonction :** Fournir les services Active Directory Domain Services (AD DS) et DNS pour l'infrastructure réseau.

---

## Accès à la machine
- Connectez-vous via la console Proxmox ou via RDP (Remote Desktop Protocol) avec un compte administrateur AD.  
- Assurez-vous d'avoir les droits nécessaires pour modifier les configurations AD et DNS.

---

## Utilisation courante

### 1. Gestion des utilisateurs et groupes AD
- Ouvrir la console **Utilisateurs et ordinateurs Active Directory** (`dsa.msc`).  
- Créer, modifier, ou supprimer des comptes utilisateurs et groupes selon les besoins.  
- Organiser les comptes dans les Unités d’Organisation (OU) selon la structure de l’entreprise.  

### 2. Gestion des stratégies de groupe (GPO)
- Ouvrir la console **Gestion des stratégies de groupe** (`gpmc.msc`).  
- Créer ou modifier des GPO pour appliquer des configurations de sécurité, déploiement de logiciels, scripts, etc.  
- Lier les GPO aux OU ou au domaine selon les besoins.  
- Tester l’application des GPO sur les clients via la commande `gpupdate /force`.  

### 3. Gestion du service DNS
- Ouvrir la console **DNS** (`dnsmgmt.msc`).  
- Ajouter, modifier ou supprimer des zones DNS et enregistrements (A, PTR, CNAME, SRV, etc.).  
- Assurer la résolution DNS correcte pour tous les clients du domaine.  
- Surveiller la santé du service DNS via les journaux d’événements Windows.  

### 4. Sauvegarde et restauration
- Planifier des sauvegardes régulières du serveur (notamment de la base AD).  
- Utiliser les outils de sauvegarde Windows Server ou une solution tiers (ex. Bareos).  
- Tester régulièrement la restauration des données AD en environnement test.  

---

## Bonnes pratiques

- Ne jamais supprimer directement un objet AD sans vérifier les dépendances.  
- Documenter toutes les modifications importantes effectuées sur AD et DNS.  
- Surveiller régulièrement les logs des services AD et DNS pour détecter des anomalies.  
- Maintenir le serveur à jour avec les dernières mises à jour Windows.  
- Limiter l'accès administratif au serveur pour éviter les modifications non autorisées.  

---

## Commandes utiles

| Commande               | Description                                          |
| ---------------------- | -------------------------------------------------- |
| `dcdiag`               | Diagnostic de la santé du contrôleur de domaine    |
| `repadmin /replsummary`| Résumé de la réplication entre contrôleurs AD      |
| `gpupdate /force`      | Forcer la mise à jour des stratégies de groupe     |
| `netdom query fsmo`    | Vérifier les rôles FSMO                             |

---

## Documentation et ressources
- [Doc installation G2-WinServ-SRV-ADDS](../docs/install/SRV-ADDS.md)  
- [Doc usage G2-WinServ-SRV-ADDS](../docs/usage/SRV-ADDS.md)  
- [Microsoft Docs - Active Directory](https://docs.microsoft.com/en-us/windows-server/identity/active-directory-domain-services)  
- [Microsoft Docs - DNS Server](https://docs.microsoft.com/en-us/windows-server/networking/dns/dns-top)

---
