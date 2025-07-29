## Guide d'installation – G2-WinCoreRedondance-SRV-CORE

**Nom Proxmox** : `G2-WinCoreRedondance-SRV-CORE`
**Nom machine** : `WinCoreRedondance`
**Rôle** : Contrôleur de domaine secondaire (ADDS) sur Windows Server Core

> ⚠️ État : Machine non-utilisable – erreur DNS/ADDS non résolue à l'étape de promotion

---

### 1. Création de la VM dans Proxmox

* **ID Proxmox** : `194`
* **Type** : VM Windows Server Core 2019 ou 2022
* **Nom** : `G2-WinCoreRedondance-SRV-CORE`
* **CPU** : 2 vCPU
* **RAM** : 2048 Mo (ou 4096 Mo)
* **Disque** : 40 Go (VirtIO)
* **Réseaux** :

  * `vmbr0` ou réseau interne AD (même VLAN que le contrôleur principal)

---

### 2. ISO d'installation

* Utiliser l'ISO Windows Server Core 2019/2022
* Choisir l’édition sans interface graphique (Core uniquement)

---

### 3. Post-installation initiale

#### a) Configuration réseau via `sconfig`

* Donner un nom à la machine : `WinCoreRedondance`
* Définir une IP statique sur le VLAN AD (ex : 192.168.100.12)
* DNS principal : IP du serveur principal ADDS (ex : 192.168.100.10)

#### b) Activer le RDP si besoin (option 7 dans `sconfig`)

---

### 4. Installation du rôle ADDS

```powershell
Install-WindowsFeature AD-Domain-Services
```

Puis promotion en tant que contrôleur secondaire :

```powershell
Import-Module ADDSDeployment
Install-ADDSDomainController `
    -DomainName "ekoloclast.local" `
    -InstallDns `
    -Credential (Get-Credential) `
    -SiteName "Default-First-Site-Name" `
    -ReplicationSourceDC "SERV-ADDS.ekoloclast.local" `
    -DatabasePath "C:\Windows\NTDS" `
    -LogPath "C:\Windows\NTDS" `
    -SYSVOLPath "C:\Windows\SYSVOL" `
    -Force:$true
```

> ⚠️ Une erreur bloquante survient ici liée à la réplication DNS/AD.

---

### 5. Résolution de l’erreur DNS/AD

* **Symptôme** : La réplication échoue, le serveur ne rejoint pas le domaine.
* **Tentatives** :

  * Vérification des règles de pare-feu entrantes/sortantes
  * Test de résolution DNS depuis la machine (`nslookup`, `ping`)
  * Vérification connectivité RPC, Netlogon, et W32Time

**Statut actuel** : échec non résolu, documentation suspendue en attente de correctif.

---

### 6. Snapshot Proxmox

* Aucun snapshot valide car la machine ne passe pas la phase de promotion ADDS
* Pas de point de restauration exploitable

---

### 7. À prévoir pour corrections

* Diagnostic complet sur Netlogon, SRV DNS, réplication d'annuaire
* Réseau isolé pour debug ou logs Wireshark

---
