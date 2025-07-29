
# Guide d'usage - G2-WinCoreRedondance-SRV-CORE

## Description
Machine virtuelle Windows Server dédiée à la redondance du contrôleur de domaine (Core AD) dans l’infrastructure. Cette VM assure la haute disponibilité des services AD et DNS.

---

## Accès

- Connexion via Bureau à distance (RDP)
- Utilisateur : administrateur AD
- Adresse IP : à vérifier dans la console Proxmox

---

## Utilisation quotidienne

### 1. Vérification des services AD et DNS

- Ouvrir le gestionnaire de serveur
- Vérifier que les services Active Directory Domain Services et DNS sont démarrés
- En cas de problème, redémarrer les services via les outils Windows ou PowerShell

### 2. Réplication et santé AD

- Utiliser `repadmin /replsummary` en PowerShell pour vérifier la réplication AD
- Vérifier les journaux d'événements dans le Visualisateur d'événements, notamment les logs Directory Service et DNS Server

### 3. Gestion des sauvegardes

- Vérifier les sauvegardes programmées des services AD et SYSVOL
- Restaurer les données si nécessaire via les outils Windows Server Backup ou autre solution utilisée

---

## Commandes utiles PowerShell

| Commande                          | Description                          |
|----------------------------------|------------------------------------|
| `Get-Service -Name NTDS`          | Vérifie le statut du service AD DS |
| `Restart-Service -Name NTDS`      | Redémarre le service AD DS          |
| `repadmin /replsummary`           | Résumé de la réplication AD         |
| `dcdiag`                         | Diagnostic du contrôleur de domaine |

---

## Limitations et remarques

- Cette VM est critique pour l’infrastructure, éviter les redémarrages inutiles.
- Toute modification doit être testée sur un environnement de test.
- En cas d’incident majeur, contacter l’administrateur principal.

---

## Documentation

- [Documentation d'installation](../docs/install/WinCoreRedondance-SRV-CORE.md)  
- [Documentation d'utilisation](../docs/usage/WinCoreRedondance-SRV-CORE.md)
