## Guide d'installation – FSMO-INFRASTRUCTURE (G2-WinServ-FSMO-INFRASTRUCTURE)

**Nom Proxmox** : `G2-WinServ-FSMO-INFRASTRUCTURE`
**Nom machine** : `FSMO-INFRASTRUCTURE`
**Rôle** : Contrôleur de domaine secondaire – FSMO Infrastructure Master

---

### 1. Création de la VM sous Proxmox

**ID Proxmox** : `186`
**Type** : VM Windows Server 2022 Standard

#### a) Paramètres Proxmox :

* Nom : `G2-WinServ-FSMO-INFRASTRUCTURE`
* OS : Windows Server 2022
* RAM : 4096 Mo
* CPU : 2 vCPU
* Disque : 60 Go (VirtIO SCSI, qcow2)
* Réseau : VirtIO, bridge `vmbr0`, VLAN correspondant

#### b) ISO :

* Windows Server 2022 officiel

---

### 2. Installation de Windows Server

1. Interface avec expérience utilisateur complète.
2. Configuration classique de Windows Server.

---

### 3. Configuration initiale

#### a) Renommage de la machine

```powershell
Rename-Computer -NewName "FSMO-INFRASTRUCTURE" -Restart
```

#### b) Réseau statique

```powershell
New-NetIPAddress -InterfaceAlias "Ethernet" -IPAddress 192.168.10.12 -PrefixLength 24 -DefaultGateway 192.168.10.1
Set-DnsClientServerAddress -InterfaceAlias "Ethernet" -ServerAddresses 192.168.10.10
```

#### c) Installer pilotes VirtIO (si nécessaires)

---

### 4. Rejoindre le domaine

```powershell
Add-Computer -DomainName "ekoloclast.local" -Credential ekoloclast\administrateur -Restart
```

---

### 5. Installation du rôle ADDS

```powershell
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools
```

---

### 6. Promotion en contrôleur de domaine secondaire

```powershell
Install-ADDSDomainController `
    -DomainName "ekoloclast.local" `
    -Credential (Get-Credential) `
    -SiteName "Default-First-Site-Name" `
    -InstallDns
```

* Redémarrage automatique post-promotion.

---

### 7. Vérifications

* `netdom query fsmo`
* `repadmin /replsummary`
* `Get-ADDomainController -Filter *`

> **Problème connu** :
> Actuellement, la machine rencontre une **erreur GPO non documentée**, empêchant la réplication correcte des stratégies de groupe. Le problème est en cours d’investigation.

---

### 8. Transfert du rôle FSMO (si prévu)

```powershell
Move-ADDirectoryServerOperationMasterRole -Identity "FSMO-INFRASTRUCTURE" -OperationMasterRole InfrastructureMaster
```

---

### 9. Sauvegarde

```powershell
Add-WindowsFeature Windows-Server-Backup
```

* Effectuer une sauvegarde dès que les erreurs GPO sont résolues.

---
